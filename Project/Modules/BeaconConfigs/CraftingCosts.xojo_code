#tag Class
Protected Class CraftingCosts
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Beacon.ConfigValue
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Var Cost As Beacon.CraftingCost = Entry.Value
		    If Cost.Engram Is Nil Or Cost.Engram.ValidForDocument(SourceDocument) = False Then
		      Continue
		    End If
		    
		    Var ConfigValue As Beacon.ConfigValue = Self.ConfigValueForCraftingCost(Cost)
		    If ConfigValue Is Nil Then
		      Continue
		    End If
		    
		    Values.Add(ConfigValue)
		  Next
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ConfigOverrideItemCraftingCosts"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.CraftingCosts = BeaconConfigs.CraftingCosts(Other)
		  For Each Entry As DictionaryEntry In Source.mCosts
		    If Self.mCosts.HasKey(Entry.Key) Then
		      Continue
		    End If
		    
		    Self.mCosts.Value(Entry.Key) = Entry.Value
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Costs") Then
		    Var Costs() As Dictionary = Dict.Value("Costs").DictionaryArrayValue
		    For Each CostData As Dictionary In Costs
		      Var Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromBeacon(CostData)
		      If Cost <> Nil Then
		        Self.mCosts.Value(Cost.Engram.ObjectID) = Cost
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var Costs() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Costs.Add(Beacon.CraftingCost(Entry.Value).Export)
		  Next
		  Dict.Value("Costs") = Costs
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Cost As Beacon.CraftingCost)
		  If Cost = Nil Then
		    Return
		  End If
		  
		  Self.Cost(Cost.Engram) = Cost
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameCraftingCosts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigValueForCraftingCost(Cost As Beacon.CraftingCost) As Beacon.ConfigValue
		  If Cost.Engram Is Nil Then
		    Return Nil
		  End If
		  
		  Return New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ConfigOverrideItemCraftingCosts=" + Cost.StringValue, "ConfigOverrideItemCraftingCosts:" + Cost.Engram.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCosts = New Dictionary
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cost(Engram As Beacon.Engram) As Beacon.CraftingCost
		  If Engram = Nil Then
		    Return Nil
		  End If
		  
		  If Self.mCosts.HasKey(Engram.ObjectID) Then
		    Return Self.mCosts.Value(Engram.ObjectID)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cost(Engram As Beacon.Engram, Assigns Cost As Beacon.CraftingCost)
		  If Engram = Nil Then
		    Return
		  End If
		  
		  If Cost = Nil Then
		    If Self.mCosts.HasKey(Engram.ObjectID) Then
		      Self.mCosts.Remove(Engram.ObjectID)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  Var Key As String = Cost.Engram.ObjectID
		  If Self.mCosts.HasKey(Key) And Beacon.CraftingCost(Self.mCosts.Value(Key)) = Cost Then
		    Return
		  End If
		  
		  Self.mCosts.Value(Key) = Cost
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mCosts.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Beacon.Engram()
		  Var Results() As Beacon.Engram
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Results.Add(Beacon.CraftingCost(Entry.Value).Engram)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.CraftingCosts
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If Not ParsedData.HasKey("ConfigOverrideItemCraftingCosts") Then
		    Return Nil
		  End If
		  
		  Var Values As Variant = ParsedData.Value("ConfigOverrideItemCraftingCosts")
		  Var ValuesInfo As Introspection.TypeInfo = Introspection.GetType(Values)
		  Var Overrides() As Variant
		  If ValuesInfo.FullName = "Object()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Dictionary" Then
		    Overrides.Add(Values)
		  Else
		    Return Nil
		  End If
		  
		  Var Config As New BeaconConfigs.CraftingCosts
		  For Each Dict As Dictionary In Overrides
		    Var Cost As Beacon.CraftingCost = Beacon.CraftingCost.ImportFromConfig(Dict, Mods)
		    If Cost <> Nil Then
		      Config.Add(Cost)
		    End If
		  Next
		  If Config.Count > 0 Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mCosts
		    If Beacon.CraftingCost(Entry.Value).Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Not Value Then
		    For Each Entry As DictionaryEntry In Self.mCosts
		      Beacon.CraftingCost(Entry.Value).Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Cost As Beacon.CraftingCost)
		  If Cost = Nil Then
		    Return
		  End If
		  
		  Self.Cost(Cost.Engram) = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As Beacon.Engram)
		  Self.Cost(Engram) = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCosts As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
