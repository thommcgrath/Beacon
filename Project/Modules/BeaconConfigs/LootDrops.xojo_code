#tag Class
Protected Class LootDrops
Inherits Beacon.ConfigGroup
Implements Iterable
	#tag Event
		Sub DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
		  Var ConfigName As String = Self.ConfigName()
		  Var Cache As New Dictionary
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    Self.DetectLootSourceIssues(Source, ConfigName, Document, Issues, Cache)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  Var DifficultyConfig As BeaconConfigs.Difficulty = SourceDocument.Difficulty
		  If DifficultyConfig = Nil Then
		    DifficultyConfig = New BeaconConfigs.Difficulty
		    DifficultyConfig.IsImplicit = True
		  End If
		  
		  If App.IdentityManager.CurrentIdentity.IsBanned Then
		    Var Sources() As Beacon.LootSource = LocalData.SharedInstance.SearchForLootSources("", New Beacon.StringList, False)
		    
		    Var Engram As Beacon.Engram = LocalData.SharedInstance.GetEngramByID("1b4d42f4-86ab-4277-a73e-dd688635b324")
		    
		    Var Entry As New Beacon.SetEntry
		    Entry.Append(New Beacon.SetEntryOption(Engram, 1.0))
		    Entry.MinQuantity = 300
		    Entry.MaxQuantity = 300
		    Entry.MinQuality = Beacon.Qualities.Tier1
		    Entry.MaxQuality = Beacon.Qualities.Tier1
		    Entry.ChanceToBeBlueprint = 0
		    
		    Var Set As New Beacon.ItemSet
		    Set.Label = "Turds"
		    Set.MinNumItems = 1
		    Set.MaxNumItems = 1
		    Set.Append(Entry)
		    
		    Var Values() As Beacon.ConfigValue
		    For Each Source As Beacon.LootSource In Sources
		      If Not Source.ValidForMask(Profile.Mask) Then
		        Continue
		      End If
		      
		      Source.MinItemSets = 1
		      Source.MaxItemSets = 1
		      Call Source.ItemSets.Append(Set, False)
		      
		      Self.BuildOverrides(Source, Values, DifficultyConfig)
		    Next
		    Return Values
		  End If
		  
		  Var Values() As Beacon.ConfigValue
		  For Each Source As Beacon.LootSource In Self.mSources
		    If Not Source.ValidForMask(Profile.Mask) Then
		      Continue
		    End If
		    
		    Self.BuildOverrides(Source, Values, DifficultyConfig)
		  Next
		  Return Values()
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, ConfigOverrideSupplyCrateItems))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mSources.Count > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.LootDrops = BeaconConfigs.LootDrops(Other)
		  For Each Drop As Beacon.LootSource In Source
		    Var Idx As Integer = Self.IndexOf(Drop)
		    If Idx > -1 Then
		      Self.Operator_Subscript(Idx) = Drop
		    Else
		      Self.Append(Drop)
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Contents") = False Then
		    App.Log("Unable to load LootDrops because there is no Contents key.")
		    Return
		  End If
		  
		  // Only keep the most recent of the duplicates
		  Var Contents() As Dictionary = Dict.Value("Contents").DictionaryArrayValue
		  Var UniqueClasses As New Dictionary
		  For Each DropDict As Dictionary In Contents
		    Var Source As Beacon.LootSource
		    Try
		      Source = Beacon.LoadLootSourceSaveData(DropDict)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading DropDict with Beacon.LoadLootSourceSaveData")
		    End Try
		    If Source Is Nil Then
		      Continue
		    End If
		    
		    Var Idx As Integer = UniqueClasses.Lookup(Source.ClassString, -1)
		    If Idx = -1 Then
		      Self.mSources.Add(Source)
		      UniqueClasses.Value(Source.ClassString) = Self.mSources.LastIndex
		    Else
		      Self.mSources(Idx) = Source
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var Contents() As Dictionary
		  For Each Source As Beacon.LootSource In Self.mSources
		    Contents.Add(Source.SaveData)
		  Next
		  Dict.Value("Contents") = Contents
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Source As Beacon.LootSource)
		  Self.mSources.Add(Source)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function AssembleLocationDict(Source As Beacon.LootSource, ItemSet As Beacon.ItemSet = Nil, Entry As Beacon.SetEntry = Nil, Option As Beacon.SetEntryOption = Nil) As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("LootSource") = Source
		  If ItemSet <> Nil Then
		    Dict.Value("ItemSet") = ItemSet
		    If Entry <> Nil Then
		      Dict.Value("Entry") = Entry
		      If Option <> Nil Then
		        Dict.Value("Option") = Option
		      End If
		    End If
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub BuildOverrides(Source As Beacon.LootSource, Values() As Beacon.ConfigValue, Difficulty As BeaconConfigs.Difficulty)
		  #if false
		    If Source IsA MetaLootSource Then
		      Var MetaSource As MetaLootSource = MetaLootSource(Source)
		      For Each SubSource As Beacon.LootContainer In MetaSource
		        BuildOverrides(SubSource, Values, Difficulty)
		      Next
		      Return
		    End If
		  #endif
		  
		  Var Keys() As String
		  Keys.Add("SupplyCrateClassString=""" + Source.ClassString + """")
		  
		  If Source.AppendMode Then
		    Keys.Add("bAppendItemSets=true")
		  Else
		    Var MinSets As Integer = Min(Source.MinItemSets, Source.MaxItemSets)
		    Var MaxSets As Integer = Max(Source.MaxItemSets, Source.MinItemSets)
		    
		    Keys.Add("MinItemSets=" + MinSets.ToString)
		    Keys.Add("MaxItemSets=" + MaxSets.ToString)
		    Keys.Add("NumItemSetsPower=1.0")
		    Keys.Add("bSetsRandomWithoutReplacement=" + if(Source.PreventDuplicates, "True", "False"))
		  End If
		  
		  Var GeneratedSets() As String
		  For Each Set As Beacon.ItemSet In Source.ItemSets
		    GeneratedSets.Add(Set.StringValue(Source.Multipliers, False, Difficulty))
		  Next
		  If Source.MandatoryItemSets.Count > 0 And Source.AppendMode = False Then
		    For Each Set As Beacon.ItemSet In Source.MandatoryItemSets
		      GeneratedSets.Add(Set.StringValue(Source.Multipliers, False, Difficulty))
		    Next
		  End If
		  
		  Keys.Add("ItemSets=(" + GeneratedSets.Join(",") + ")")
		  
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, ConfigOverrideSupplyCrateItems + "=(" + Keys.Join(",") + ")", ConfigOverrideSupplyCrateItems + ":" + Source.ClassString))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameLootDrops
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSources.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefinedSources() As Beacon.LootSourceCollection
		  Var Results As New Beacon.LootSourceCollection
		  For Each LootSource As Beacon.LootSource In Self.mSources
		    Results.Append(LootSource)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetectItemSetIssues(Source As Beacon.LootSource, Set As Beacon.ItemSet, ConfigName As String, Document As Beacon.Document, Issues() As Beacon.Issue, Cache As Dictionary)
		  Try
		    If Set.Count = 0 Then
		      Issues.Add(New Beacon.Issue(ConfigName, "Item set " + Set.Label + " of loot source " + Source.Label + " is empty.", Self.AssembleLocationDict(Source, Set)))
		    Else
		      For Each Entry As Beacon.SetEntry In Set
		        Self.DetectSetEntryIssues(Source, Set, Entry, ConfigName, Document, Issues, Cache)
		      Next
		    End If
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetectLootSourceIssues(Source As Beacon.LootSource, ConfigName As String, Document As Beacon.Document, Issues() As Beacon.Issue, Cache As Dictionary)
		  Try
		    If Source.ItemSets.Count < Source.RequiredItemSetCount Then
		      Issues.Add(New Beacon.Issue(ConfigName, "Loot source " + Source.Label + " needs at least " + Source.RequiredItemSetCount.ToString + " " + if(Source.RequiredItemSetCount = 1, "item set", "item sets") + " to work correctly.", Source))
		    Else
		      For Each Set As Beacon.ItemSet In Source.ItemSets
		        Self.DetectItemSetIssues(Source, Set, ConfigName, Document, Issues, Cache)
		      Next
		    End If
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetectSetEntryIssues(Source As Beacon.LootSource, Set As Beacon.ItemSet, Entry As Beacon.SetEntry, ConfigName As String, Document As Beacon.Document, Issues() As Beacon.Issue, Cache As Dictionary)
		  Try
		    If Entry.Count = 0 Then
		      Issues.Add(New Beacon.Issue(ConfigName, "An entry in item set " + Set.Label + " of loot source " + Source.Label + " has no engrams selected.", Self.AssembleLocationDict(Source, Set, Entry)))
		    Else
		      For Each Option As Beacon.SetEntryOption In Entry
		        Self.DetectSetEntryOptionIssues(Source, Set, Entry, Option, ConfigName, Document, Issues, Cache)
		      Next
		    End If
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DetectSetEntryOptionIssues(Source As Beacon.LootSource, Set As Beacon.ItemSet, Entry As Beacon.SetEntry, Option As Beacon.SetEntryOption, ConfigName As String, Document As Beacon.Document, Issues() As Beacon.Issue, Cache As Dictionary)
		  Try
		    Var ObjectID As String = Option.Reference.ObjectID
		    If Cache.HasKey(ObjectID) Then
		      Return
		    End If
		    
		    Var Engram As Beacon.Engram = Option.Engram
		    If Document.ModEnabled(Engram.ModID) = False Then
		      Issues.Add(New Beacon.Issue(ConfigName, "'" + Engram.Label + "' is provided by the '" + Engram.ModName + "' mod, which is turned off.", Self.AssembleLocationDict(Source, Set, Entry, Option)))
		    ElseIf Engram.IsTagged("Generic") Or Engram.IsTagged("Blueprint") Then
		      Issues.Add(New Beacon.Issue(ConfigName, Engram.Label + " is a generic item intended for crafting recipes. It cannot spawn in a drop.", Self.AssembleLocationDict(Source, Set, Entry, Option)))
		    End If
		    Cache.Value(Engram.ObjectID) = True
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.LootDrops
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
		  Var LootDrops As New BeaconConfigs.LootDrops
		  Var UniqueClasses As New Dictionary
		  For Each Member As Variant In Dicts
		    If IsNull(Member) Or Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Source As Beacon.LootSource
		    Try
		      Source = Beacon.LootContainer.ImportFromConfig(Dictionary(Member.ObjectValue), Difficulty, Mods)
		    Catch Err As RuntimeException
		      Continue
		    End Try
		    
		    If Source = Nil Then
		      Continue
		    End If
		    
		    Var Idx As Integer = UniqueClasses.Lookup(Source.ClassString, -1)
		    If Idx = -1 Then
		      LootDrops.Append(Source)
		      UniqueClasses.Value(Source.ClassString) = LootDrops.LastRowIndex
		    Else
		      LootDrops(Idx) = Source
		    End If
		  Next
		  If LootDrops.LastRowIndex > -1 Then
		    Return LootDrops
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasLootSource(Source As Beacon.LootSource) As Boolean
		  Return Self.IndexOf(Source) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Source As Beacon.LootSource) As Integer
		  For I As Integer = 0 To Self.mSources.LastIndex
		    If Self.mSources(I).ClassString = Source.ClassString Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Source As Beacon.LootSource)
		  Self.mSources.AddAt(Index, Source)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Items() As Variant
		  Items.ResizeTo(Self.mSources.LastIndex)
		  For I As Integer = Items.FirstRowIndex To Items.LastIndex
		    Items(I) = Self.mSources(I)
		  Next
		  
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mSources.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Source As Beacon.LootSource In Self.mSources
		    If Source.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Not Value Then
		    For Each Source As Beacon.LootSource In Self.mSources
		      Source.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.LootSource
		  Return Self.mSources(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Source As Beacon.LootSource)
		  Self.mSources(Index) = Source
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReconfigurePresets(Mask As UInt64, Mods As Beacon.StringList) As Integer
		  If Mask = CType(0, UInt64) Then
		    Return 0
		  End If
		  
		  Var NumChanged As Integer
		  For Each Source As Beacon.LootSource In Self.mSources
		    NumChanged = NumChanged + Source.ReconfigurePresets(Mask, Mods)
		  Next
		  Return NumChanged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Source As Beacon.LootSource)
		  Var Idx As Integer = Self.IndexOf(Source)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mSources.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewUBound As Integer)
		  If NewUBound <> Self.mSources.LastIndex Then
		    Self.mSources.ResizeTo(NewUBound)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunWhenBanned() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mResolveIssuesCallback As Beacon.ConfigGroup.ResolveIssuesCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSources() As Beacon.LootSource
	#tag EndProperty


	#tag Constant, Name = ConfigOverrideSupplyCrateItems, Type = String, Dynamic = False, Default = \"ConfigOverrideSupplyCrateItems", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
