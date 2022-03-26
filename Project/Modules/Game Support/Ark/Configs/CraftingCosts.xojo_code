#tag Class
Protected Class CraftingCosts
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.CraftingCosts = Ark.Configs.CraftingCosts(Other)
		  
		  For Each Entry As DictionaryEntry In Source.mCosts
		    Self.mCosts.Value(Entry.Key) = Entry.Value
		  Next Entry
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Var Cost As Ark.CraftingCost = Entry.Value
		    If Cost.Engram Is Nil Or Cost.Engram.ValidForProject(Project) = False Then
		      Continue
		    End If
		    
		    Var ConfigValue As Ark.ConfigValue = Self.ConfigValueForCraftingCost(Cost)
		    If ConfigValue Is Nil Then
		      Continue
		    End If
		    
		    Values.Add(ConfigValue)
		  Next
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ConfigOverrideItemCraftingCosts"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return (Self.mCosts Is Nil) = False And Self.mCosts.KeyCount > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("Costs") Then
		    Var Costs() As Dictionary = SaveData.Value("Costs").DictionaryArrayValue
		    For Each CostData As Dictionary In Costs
		      Var Cost As Ark.CraftingCost = Ark.CraftingCost.ImportFromBeacon(CostData)
		      If (Cost Is Nil) = False Then
		        Self.mCosts.Value(Cost.Engram.ObjectID) = Cost
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Var Costs() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Costs.Add(Ark.CraftingCost(Entry.Value).Export)
		  Next
		  SaveData.Value("Costs") = Costs
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Cost As Ark.CraftingCost)
		  If Cost Is Nil Then
		    Return
		  End If
		  
		  Self.Cost(Cost.Engram) = Cost.ImmutableVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigValueForCraftingCost(Cost As Ark.CraftingCost) As Ark.ConfigValue
		  If Cost.Engram Is Nil Then
		    Return Nil
		  End If
		  
		  Return New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ConfigOverrideItemCraftingCosts=" + Cost.StringValue, "ConfigOverrideItemCraftingCosts:" + Cost.Engram.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCosts = New Dictionary
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cost(Engram As Ark.Engram) As Ark.CraftingCost
		  If Engram Is Nil Then
		    Return Nil
		  End If
		  
		  If Self.mCosts.HasKey(Engram.ObjectID) Then
		    Return Self.mCosts.Value(Engram.ObjectID)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cost(Engram As Ark.Engram, Assigns Cost As Ark.CraftingCost)
		  If Engram Is Nil Then
		    Return
		  End If
		  
		  If Cost Is Nil Then
		    If Self.mCosts.HasKey(Engram.ObjectID) Then
		      Self.mCosts.Remove(Engram.ObjectID)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  Var Key As String = Cost.Engram.ObjectID
		  If Self.mCosts.HasKey(Key) And Ark.CraftingCost(Self.mCosts.Value(Key)) = Cost Then
		    Return
		  End If
		  
		  Self.mCosts.Value(Key) = Cost.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mCosts.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Ark.Engram()
		  Var Results() As Ark.Engram
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Results.Add(Ark.CraftingCost(Entry.Value).Engram)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.CraftingCosts
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
		  
		  Var Config As New Ark.Configs.CraftingCosts
		  For Each Dict As Dictionary In Overrides
		    Var Cost As Ark.CraftingCost = Ark.CraftingCost.ImportFromConfig(Dict, ContentPacks)
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
		Function InternalName() As String
		  Return Ark.Configs.NameCraftingCosts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Cost As Ark.CraftingCost)
		  If Cost Is Nil Then
		    Return
		  End If
		  
		  Self.Cost(Cost.Engram) = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As Ark.Engram)
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
	#tag EndViewBehavior
End Class
#tag EndClass
