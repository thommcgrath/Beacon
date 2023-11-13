#tag Class
Protected Class LootDrops
Inherits ArkSA.ConfigGroup
Implements Iterable
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.LootDrops = ArkSA.Configs.LootDrops(Other)
		  For Each Override As ArkSA.LootDropOverride In Source.mOverrides
		    Self.Add(Override)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  Var Difficulty As ArkSA.Configs.Difficulty = Project.Difficulty
		  If Difficulty Is Nil Then
		    Difficulty = New ArkSA.Configs.Difficulty
		  End If
		  Var DifficultyValue As Double = Difficulty.DifficultyValue
		  
		  Var ContentPackIds As Beacon.StringList = Project.ContentPacks
		  Var Values() As ArkSA.ConfigValue
		  For Each Override As ArkSA.LootDropOverride In Self.mOverrides
		    Var LootDrop As ArkSA.Blueprint = Override.LootDropReference.Resolve(ContentPackIds)
		    If LootDrop Is Nil Or LootDrop.ValidForMask(Profile.Mask) = False Then
		      Continue
		    End If
		    
		    Var Value As ArkSA.ConfigValue = Self.ConfigValueForOverride(Override, DifficultyValue)
		    If (Value Is Nil) = False Then
		      Values.Add(Value)
		    End If
		  Next
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, ConfigOverrideSupplyCrateItems))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mOverrides.Count > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  For Idx As Integer = Self.mOverrides.LastIndex DownTo 0
		    If Self.mOverrides(Idx).LootDropReference.Resolve(ContentPackIds, 0) Is Nil Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		      Continue
		    End If
		    
		    Var Mutable As New ArkSA.MutableLootDropOverride(Self.mOverrides(Idx))
		    Mutable.PruneUnknownContent(ContentPackIds)
		    If Mutable.Count = 0 Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		    ElseIf Mutable.Hash <> Self.mOverrides(Idx).Hash Then
		      Self.mOverrides(Idx) = New ArkSA.LootDropOverride(Mutable)
		      Self.Modified = True
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("overrides") = False Then
		    If SaveData.HasKey("Contents") Then
		      // Old style
		      Var Drops() As Dictionary
		      Try
		        Drops = SaveData.Value("Contents").DictionaryArrayValue
		      Catch Err As RuntimeException
		      End Try
		      
		      For Each DropData As Dictionary In Drops
		        Var Override As ArkSA.LootDropOverride
		        Try
		          Override = ArkSA.LootDropOverride.FromLegacy(DropData)
		        Catch Err As RuntimeException
		        End Try
		        If Override Is Nil Then
		          Continue
		        End If
		        
		        Self.mOverrides.Add(Override)
		      Next
		    End If
		    Return
		  End If
		  
		  Var OverrideDicts() As Dictionary
		  Try
		    OverrideDicts = SaveData.Value("overrides").DictionaryArrayValue
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  For Each Dict As Dictionary In OverrideDicts
		    Var Override As ArkSA.LootDropOverride
		    Try
		      Override = ArkSA.LootDropOverride.FromSaveData(Dict)
		    Catch Err As RuntimeException
		    End Try
		    If Override Is Nil Then
		      Continue
		    End If
		    
		    Self.mOverrides.Add(Override)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  For Each Override As ArkSA.LootDropOverride In Self.mOverrides
		    Override.Validate(Location, Issues, Project)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Var OverrideDicts() As Dictionary
		  For Each Override As ArkSA.LootDropOverride In Self.mOverrides
		    OverrideDicts.Add(Override.SaveData)
		  Next
		  SaveData.Value("overrides") = OverrideDicts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(LootDropRef As ArkSA.BlueprintReference)
		  If LootDropRef Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDropRef.BlueprintId Then
		      Self.mOverrides(Idx) = New ArkSA.LootDropOverride(LootDropRef)
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  Self.mOverrides.Add(New ArkSA.LootDropOverride(LootDropRef))
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(LootDrop As ArkSA.LootContainer)
		  If LootDrop Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDrop.LootDropId Then
		      Self.mOverrides(Idx) = New ArkSA.LootDropOverride(LootDrop)
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  Self.mOverrides.Add(New ArkSA.LootDropOverride(LootDrop))
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Override As ArkSA.LootDropOverride)
		  If Override Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = Override.LootDropId Then
		      Self.mOverrides(Idx) = New ArkSA.LootDropOverride(Override)
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  Self.mOverrides.Add(New ArkSA.LootDropOverride(Override))
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ConfigValueForOverride(Override As ArkSA.LootDropOverride, DifficultyValue As Double) As ArkSA.ConfigValue
		  Var Keys() As String
		  Keys.Add("SupplyCrateClassString=""" + Override.LootDropReference.ClassString + """")
		  
		  If Override.AddToDefaults Then
		    Keys.Add("bAppendItemSets=True")
		  Else
		    Var MinSets As Integer = Min(Override.MinItemSets, Override.MaxItemSets)
		    Var MaxSets As Integer = Max(Override.MaxItemSets, Override.MinItemSets)
		    
		    Keys.Add("MinItemSets=" + MinSets.ToString(Locale.Raw, "0"))
		    Keys.Add("MaxItemSets=" + MaxSets.ToString(Locale.Raw, "0"))
		    Keys.Add("NumItemSetsPower=1.0")
		    Keys.Add("bSetsRandomWithoutReplacement=" + If(Override.PreventDuplicates, "True", "False"))
		  End If
		  
		  // You don't need the content packs from the project because the caller (GenerateConfigValues) will
		  // have already resolved the blueprint.
		  Var Blueprint As ArkSA.Blueprint = Override.LootDropReference.Resolve()
		  If Blueprint Is Nil Then
		    Return Nil
		  End If
		  Var LootDrop As ArkSA.LootContainer = ArkSA.LootContainer(Blueprint)
		  
		  Var GeneratedSets() As String
		  For Each Set As ArkSA.LootItemSet In Override
		    GeneratedSets.Add(Set.StringValue(LootDrop.Multipliers, False, DifficultyValue))
		  Next
		  Keys.Add("ItemSets=(" + GeneratedSets.Join(",") + ")")
		  
		  Return New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, ConfigOverrideSupplyCrateItems + "=(" + Keys.Join(",") + ")", ConfigOverrideSupplyCrateItems + ":" + LootDrop.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mOverrides.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.LootDrops
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  
		  If Not ParsedData.HasKey(ConfigOverrideSupplyCrateItems) Then
		    Return Nil
		  End If
		  
		  Var Value As Variant = ParsedData.Value(ConfigOverrideSupplyCrateItems)
		  If IsNull(Value) Then
		    Return Nil
		  End If
		  
		  Var Dicts() As Variant
		  If Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		    Dicts.Add(Dictionary(Value.ObjectValue))
		  ElseIf Value.IsArray And Value.ArrayElementType = Value.TypeObject Then
		    Dicts = Value
		  End If
		  
		  // Only keep the most recent of the duplicates
		  Var LootDrops As New ArkSA.Configs.LootDrops
		  For Each Member As Variant In Dicts
		    If IsNull(Member) Or Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Override As ArkSA.LootDropOverride
		    Try
		      Override = ArkSA.LootDropOverride.ImportFromConfig(Dictionary(Member.ObjectValue), Difficulty, ContentPacks)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Importing override from ini")
		      Continue
		    End Try
		    If Override Is Nil Then
		      Continue
		    End If
		    
		    LootDrops.Add(Override)
		  Next
		  If LootDrops.Count > 0 Then
		    Return LootDrops
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOverride(LootDropRef As ArkSA.BlueprintReference) As Boolean
		  If LootDropRef Is Nil Then
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDropRef.BlueprintId Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOverride(LootDrop As ArkSA.LootContainer) As Boolean
		  If LootDrop Is Nil Then
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDrop.LootDropId Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOverride(Override As ArkSA.LootDropOverride) As Boolean
		  If Override Is Nil Then
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = Override.LootDropId Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameLootDrops
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Overrides() As Variant
		  For Each Override As ArkSA.LootDropOverride In Self.mOverrides
		    Overrides.Add(Override.ImmutableVersion)
		  Next
		  Return New Beacon.GenericIterator(Overrides)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverrideForLootDrop(LootDropRef As ArkSA.BlueprintReference) As ArkSA.LootDropOverride
		  If LootDropRef Is Nil Then
		    Return Nil
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDropRef.BlueprintId Then
		      Return Self.mOverrides(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverrideForLootDrop(LootDrop As ArkSA.LootContainer) As ArkSA.LootDropOverride
		  If LootDrop Is Nil Then
		    Return Nil
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDrop.LootDropId Then
		      Return Self.mOverrides(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overrides(Filter As String = "") As ArkSA.LootDropOverride()
		  Filter = Filter.Trim
		  
		  Var Results() As ArkSA.LootDropOverride
		  For Each Override As ArkSA.LootDropOverride In Self.mOverrides
		    If Filter.IsEmpty = False And Override.LootDropReference.Label.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Results.Add(Override.ImmutableVersion)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RebuildItemSets(Mask As UInt64, ContentPacks As Beacon.StringList) As Integer
		  If Mask = CType(0, UInt64) Then
		    Return 0
		  End If
		  
		  Var NumChanged As Integer
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    Var Mutable As ArkSA.MutableLootDropOverride = Self.mOverrides(Idx).MutableCopy
		    Var Num As Integer = Mutable.RebuildItemSets(Mask, ContentPacks)
		    If Num > 0 Then
		      NumChanged = NumChanged + Num
		      Self.mOverrides(Idx) = Mutable.ImmutableCopy
		    End If
		  Next
		  Return NumChanged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(LootDropRef As ArkSA.BlueprintReference)
		  If LootDropRef Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDropRef.BlueprintId Then
		      Self.mOverrides.RemoveAt(Idx)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(LootDrop As ArkSA.LootContainer)
		  If LootDrop Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = LootDrop.LootDropId Then
		      Self.mOverrides.RemoveAt(Idx)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Override As ArkSA.LootDropOverride)
		  If Override Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).LootDropId = Override.LootDropId Then
		      Self.mOverrides.RemoveAt(Idx)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  Self.mOverrides.ResizeTo(-1)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOverrides() As ArkSA.LootDropOverride
	#tag EndProperty


	#tag Constant, Name = ConfigOverrideSupplyCrateItems, Type = String, Dynamic = False, Default = \"ConfigOverrideSupplyCrateItems", Scope = Private
	#tag EndConstant


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
