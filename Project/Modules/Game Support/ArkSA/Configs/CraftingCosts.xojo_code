#tag Class
Protected Class CraftingCosts
Inherits ArkSA.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.CraftingCosts = ArkSA.Configs.CraftingCosts(Other)
		  
		  For Each Entry As DictionaryEntry In Source.mCosts
		    Self.mCosts.Value(Entry.Key) = Entry.Value
		  Next Entry
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As ArkSA.ConfigValue
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Var Cost As ArkSA.CraftingCost = Entry.Value
		    If Cost.Engram Is Nil Or Cost.Engram.ValidForProject(Project) = False Then
		      Continue
		    End If
		    
		    Var ConfigValue As ArkSA.ConfigValue = Self.ConfigValueForCraftingCost(Cost)
		    If ConfigValue Is Nil Then
		      Continue
		    End If
		    
		    Values.Add(ConfigValue)
		  Next
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ConfigOverrideItemCraftingCosts"))
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
		      Var Cost As ArkSA.CraftingCost = ArkSA.CraftingCost.ImportFromBeacon(CostData)
		      If (Cost Is Nil) = False Then
		        Self.mCosts.Value(Cost.Engram.EngramId) = Cost
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
		    Costs.Add(ArkSA.CraftingCost(Entry.Value).Export)
		  Next
		  SaveData.Value("Costs") = Costs
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Cost As ArkSA.CraftingCost)
		  If Cost Is Nil Then
		    Return
		  End If
		  
		  Self.Cost(Cost.Engram) = Cost.ImmutableVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigValueForCraftingCost(Cost As ArkSA.CraftingCost) As ArkSA.ConfigValue
		  If Cost.Engram Is Nil Then
		    Return Nil
		  End If
		  
		  Return New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ConfigOverrideItemCraftingCosts=" + Cost.StringValue, "ConfigOverrideItemCraftingCosts:" + Cost.Engram.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCosts = New Dictionary
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cost(Engram As ArkSA.Engram) As ArkSA.CraftingCost
		  If Engram Is Nil Then
		    Return Nil
		  End If
		  
		  If Self.mCosts.HasKey(Engram.EngramId) Then
		    Return Self.mCosts.Value(Engram.EngramId)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cost(Engram As ArkSA.Engram, Assigns Cost As ArkSA.CraftingCost)
		  If Engram Is Nil Then
		    Return
		  End If
		  
		  If Cost Is Nil Then
		    If Self.mCosts.HasKey(Engram.EngramId) Then
		      Self.mCosts.Remove(Engram.EngramId)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  Var Key As String = Cost.Engram.EngramId
		  If Self.mCosts.HasKey(Key) And ArkSA.CraftingCost(Self.mCosts.Value(Key)) = Cost Then
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
		Function Engrams() As ArkSA.Engram()
		  Var Results() As ArkSA.Engram
		  For Each Entry As DictionaryEntry In Self.mCosts
		    Results.Add(ArkSA.CraftingCost(Entry.Value).Engram)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.CraftingCosts
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
		  
		  Var Config As New ArkSA.Configs.CraftingCosts
		  For Each Dict As Dictionary In Overrides
		    Var Cost As ArkSA.CraftingCost = ArkSA.CraftingCost.ImportFromConfig(Dict, ContentPacks)
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
		  Return ArkSA.Configs.NameCraftingCosts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Cost As ArkSA.CraftingCost)
		  If Cost Is Nil Then
		    Return
		  End If
		  
		  Self.Cost(Cost.Engram) = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As ArkSA.Engram)
		  Self.Cost(Engram) = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return True
		End Function
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
