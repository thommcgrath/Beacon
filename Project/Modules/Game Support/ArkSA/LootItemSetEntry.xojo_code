#tag Class
Protected Class LootItemSetEntry
Implements Beacon.Countable,Iterable,ArkSA.Weighted,Beacon.Validateable
	#tag Method, Flags = &h0
		Function CanBeBlueprint() As Boolean
		  // This could be a new entry
		  If Self.mOptions.Count = 0 Then
		    Return True
		  End If
		  
		  For Each Option As ArkSA.LootItemSetEntryOption In Self.mOptions
		    If Option.Engram.IsTagged("blueprintable") Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChanceToBeBlueprint() As Double
		  Return Self.mChanceToBeBlueprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassesLabel() As String
		  If Self.mOptions.LastIndex = -1 Then
		    Return "No Items"
		  ElseIf Self.mOptions.LastIndex = 0 Then
		    Return Self.mOptions(0).Engram.ClassString
		  ElseIf Self.mOptions.LastIndex = 1 Then
		    Return Self.mOptions(0).Engram.ClassString + " or " + Self.mOptions(1).Engram.ClassString
		  Else
		    Var Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastIndex - 1
		      Labels.Add(Self.mOptions(I).Engram.ClassString)
		    Next
		    Labels.Add("or " + Self.mOptions(Self.mOptions.LastIndex).Engram.ClassString)
		    
		    Return Labels.Join("")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mMinQuantity = 1
		  Self.mMaxQuantity = 1
		  Self.mMinQuality = ArkSA.Qualities.Tier1
		  Self.mMaxQuality = ArkSA.Qualities.Tier3
		  Self.mChanceToBeBlueprint = 0.25
		  Self.mWeight = 250
		  Self.mEntryId = Beacon.UUID.v4
		  Self.mSingleItemQuantity = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.LootItemSetEntry)
		  Self.Constructor()
		  
		  Self.mOptions.ResizeTo(Source.mOptions.LastIndex)
		  
		  Self.mChanceToBeBlueprint = Source.mChanceToBeBlueprint
		  Self.mMaxQuality = Source.mMaxQuality
		  Self.mMaxQuantity = Source.mMaxQuantity
		  Self.mMinQuality = Source.mMinQuality
		  Self.mMinQuantity = Source.mMinQuantity
		  Self.mWeight = Source.mWeight
		  Self.mPreventGrinding = Source.mPreventGrinding
		  Self.mStatClampMultiplier = Source.mStatClampMultiplier
		  Self.mSingleItemQuantity = Source.mSingleItemQuantity
		  Self.mEntryId = Source.mEntryId
		  Self.mHash = Source.mHash
		  Self.mLastHashTime = Source.mLastHashTime
		  Self.mLastModifiedTime = Source.mLastModifiedTime
		  Self.mLastSaveTime = Source.mLastSaveTime
		  Self.mSingleItemQuantity = Source.mSingleItemQuantity
		  
		  For I As Integer = 0 To Source.mOptions.LastIndex
		    Self.mOptions(I) = New ArkSA.LootItemSetEntryOption(Source.mOptions(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mOptions.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryId() As String
		  Return Self.mEntryId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary, Options As Integer = 0) As ArkSA.LootItemSetEntry
		  Var Entry As New ArkSA.MutableLootItemSetEntry
		  Var NewEntryId As Boolean = (Options And OptionNewId) = OptionNewId
		  Var LoadEmpty As Boolean = (Options And OptionLoadEmpty) = OptionLoadEmpty
		  
		  If NewEntryId Then
		    Entry.EntryId = Beacon.UUID.v4
		  Else
		    Try
		      If Dict.HasKey("lootItemSetEntryId") Then
		        Entry.EntryId = Dict.Value("lootItemSetEntryId")
		      ElseIf Dict.HasKey("loot_item_set_entry_id") Then
		        Entry.EntryId = Dict.Value("loot_item_set_entry_id")
		      ElseIf Dict.HasKey("UUID") Then
		        Entry.EntryId = Dict.Value("UUID")
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading UUID value")
		    End Try
		  End If
		  
		  Try
		    If Dict.HasKey("weight") Then
		      Entry.RawWeight = Dict.Value("weight")
		    ElseIf Dict.HasKey("Weight") Then
		      Entry.RawWeight = Dict.Value("Weight")
		    ElseIf Dict.HasKey("EntryWeight") Then
		      Entry.RawWeight = Dict.Value("EntryWeight") * 1000.0
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Try
		    If Dict.HasKey("minQuality") Then
		      Entry.MinQuality = ArkSA.Qualities.ForKey(Dict.Value("minQuality"))
		    ElseIf Dict.HasKey("min_quality") Then
		      Entry.MinQuality = ArkSA.Qualities.ForKey(Dict.Value("min_quality"))
		    ElseIf Dict.HasKey("MinQuality") Then
		      Entry.MinQuality = ArkSA.Qualities.ForKey(Dict.Value("MinQuality"))
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinQuality value")
		  End Try
		  
		  Try
		    If Dict.HasKey("maxQuality") Then
		      Entry.MaxQuality = ArkSA.Qualities.ForKey(Dict.Value("maxQuality"))
		    ElseIf Dict.HasKey("max_quality") Then
		      Entry.MaxQuality = ArkSA.Qualities.ForKey(Dict.Value("max_quality"))
		    ElseIf Dict.HasKey("MaxQuality") Then
		      Entry.MaxQuality = ArkSA.Qualities.ForKey(Dict.Value("MaxQuality"))
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxQuality value")
		  End Try
		  
		  Try
		    If Dict.HasKey("minQuantity") Then
		      Entry.MinQuantity = Dict.Value("minQuantity")
		    ElseIf Dict.HasKey("min_quantity") Then
		      Entry.MinQuantity = Dict.Value("min_quantity")
		    ElseIf Dict.HasKey("MinQuantity") Then
		      Entry.MinQuantity = Dict.Value("MinQuantity")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinQuantity value")
		  End Try
		  
		  Try
		    If Dict.HasKey("maxQuantity") Then
		      Entry.MaxQuantity = Dict.Value("maxQuantity")
		    ElseIf Dict.HasKey("max_quantity") Then
		      Entry.MaxQuantity = Dict.Value("max_quantity")
		    ElseIf Dict.HasKey("MaxQuantity") Then
		      Entry.MaxQuantity = Dict.Value("MaxQuantity")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxQuantity value")
		  End Try
		  
		  Try
		    If Dict.HasKey("blueprintChance") Then
		      Entry.ChanceToBeBlueprint = Dict.Value("blueprintChance")
		    ElseIf Dict.HasKey("blueprint_chance") Then
		      Entry.ChanceToBeBlueprint = Dict.Value("blueprint_chance")
		    ElseIf Dict.HasKey("ChanceToBeBlueprintOverride") Then
		      Entry.ChanceToBeBlueprint = Dict.Value("ChanceToBeBlueprintOverride")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading ChangeToBeBlueprintOverride value")
		  End Try
		  
		  Var Children() As Dictionary
		  Try
		    If Dict.HasKey("options") And Dict.Value("options").IsNull = False Then
		      Children = Dict.Value("options").DictionaryArrayValue
		    ElseIf Dict.HasKey("Items") Then
		      Children = Dict.Value("Items").DictionaryArrayValue
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Casting Items to array")
		  End Try
		  For Idx As Integer = 0 To Children.LastIndex
		    Try
		      Var Option As ArkSA.LootItemSetEntryOption = ArkSA.LootItemSetEntryOption.FromSaveData(Dictionary(Children(Idx)), NewEntryId)
		      If (Option Is Nil) = False Then
		        Entry.Add(Option)
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading option dictionary #" + Idx.ToString(Locale.Raw, "0"))
		    End Try
		  Next
		  If Entry.Count = 0 And LoadEmpty = False Then
		    Return Nil
		  End If
		  
		  Try
		    If Dict.HasKey("preventGrinding") Then
		      Entry.PreventGrinding = Dict.Value("preventGrinding")
		    ElseIf Dict.HasKey("prevent_grinding") Then
		      Entry.PreventGrinding = Dict.Value("prevent_grinding")
		    ElseIf Dict.HasKey("PreventGrinding") Then
		      Entry.PreventGrinding = Dict.Value("PreventGrinding")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading PreventGrinding value")
		  End Try
		  
		  Try
		    If Dict.HasKey("statClampMultiplier") Then
		      Entry.StatClampMultiplier = Dict.Value("statClampMultiplier")
		    ElseIf Dict.HasKey("stat_clamp_multiplier") Then
		      Entry.StatClampMultiplier = Dict.Value("stat_clamp_multiplier")
		    ElseIf Dict.HasKey("StatClampMultiplier") Then
		      Entry.StatClampMultiplier = Dict.Value("StatClampMultiplier")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading StatClampMultiplier value")
		  End Try
		  
		  Try
		    If Dict.HasKey("singleItemQuantity") Then
		      Entry.SingleItemQuantity = Dict.Value("singleItemQuantity")
		    ElseIf Dict.HasKey("single_item_quantity") Then
		      Entry.SingleItemQuantity = Dict.Value("single_item_quantity")
		    ElseIf Dict.HasKey("SingleItemQuantity") Then
		      Entry.SingleItemQuantity = Dict.Value("SingleItemQuantity")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading SingleItemQuantity value")
		  End Try
		  
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.HashIsStale Then
		    Var Items() As String
		    Items.ResizeTo(Self.mOptions.LastIndex)
		    For I As Integer = 0 To Items.LastIndex
		      Items(I) = Self.mOptions(I).Hash
		    Next
		    Items.Sort
		    
		    Var Locale As Locale = Locale.Raw
		    Var Format As String = "0.000"
		    
		    Var Parts(9) As String
		    Parts(0) = Beacon.MD5(Items.Join(",")).Lowercase
		    Parts(1) = Self.ChanceToBeBlueprint.ToString(Locale, Format)
		    Parts(2) = Self.MaxQuality.Key.Lowercase
		    Parts(3) = Self.MaxQuantity.ToString(Locale, Format)
		    Parts(4) = Self.MinQuality.Key.Lowercase
		    Parts(5) = Self.MinQuantity.ToString(Locale, Format)
		    Parts(6) = Self.RawWeight.ToString(Locale, Format)
		    Parts(7) = If(Self.PreventGrinding, "True", "False")
		    Parts(8) = Self.StatClampMultiplier.ToString(Locale, Format)
		    Parts(9) = If(Self.SingleItemQuantity, "True", "False")
		    
		    Self.mHash = Beacon.MD5(Parts.Join(":")).Lowercase
		    Self.mLastHashTime = System.Microseconds
		  End If
		  Return Self.mHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HashIsStale() As Boolean
		  If Self.mHash.IsEmpty Or Self.mLastHashTime = 0 Or Self.mLastHashTime < Self.mLastModifiedTime Then
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As ArkSA.LootItemSetEntry
		  Return New ArkSA.LootItemSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.LootItemSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Multipliers As Beacon.Range, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.LootItemSetEntry
		  Var Entry As New ArkSA.MutableLootItemSetEntry
		  Entry.RawWeight = Dict.Lookup("EntryWeight", 1.0)
		  
		  Var BaseArbitraryQuality As Double = ArkSA.Configs.Difficulty.BaseArbitraryQuality(Difficulty)
		  
		  If Dict.HasKey("MinQuality") Then
		    Entry.MinQuality = ArkSA.Qualities.ForValue(Dict.Value("MinQuality"), Multipliers.Min, BaseArbitraryQuality)
		  End If
		  If Dict.HasKey("MaxQuality") Then
		    Entry.MaxQuality = ArkSA.Qualities.ForValue(Dict.Value("MaxQuality"), Multipliers.Max, BaseArbitraryQuality)
		  End If
		  If Dict.HasKey("MinQuantity") Then
		    Entry.MinQuantity = Dict.Value("MinQuantity")
		  End If
		  If Dict.HasKey("MaxQuantity") Then
		    Entry.MaxQuantity = Dict.Value("MaxQuantity")
		  End If
		  If Dict.HasKey("bForcePreventGrinding") Then
		    Entry.PreventGrinding = Dict.Value("bForcePreventGrinding")
		  End If
		  If Dict.HasKey("ItemStatClampsMultiplier") Then
		    Entry.StatClampMultiplier = Dict.Value("ItemStatClampsMultiplier")
		  End If
		  If Dict.HasKey("bApplyQuantityToSingleItem") Then
		    Entry.SingleItemQuantity = Dict.Value("bApplyQuantityToSingleItem")
		  End If
		  
		  // If bForceBlueprint is not included or explicitly true, then force is true. This
		  // mirrors how Ark works. If bForceBlueprint is false, then look to one of the
		  // chance keys. If neither key is specified, chance default to 1.0.
		  Var ForceBlueprint As Boolean = if(Dict.HasKey("bForceBlueprint"), Dict.Value("bForceBlueprint"), True)
		  Var Chance As Double
		  If ForceBlueprint Then
		    Chance = 1.0
		  Else
		    If Dict.HasKey("ChanceToActuallyGiveItem") Then
		      Chance = 1.0 - Dict.Value("ChanceToActuallyGiveItem")
		    ElseIf Dict.HasKey("ChanceToBeBlueprintOverride") Then
		      Chance = Dict.Value("ChanceToBeBlueprintOverride")
		    Else
		      Chance = 0.0
		    End If
		  End If
		  Entry.ChanceToBeBlueprint = Chance
		  
		  Var ClassWeights() As Variant
		  If Dict.HasKey("ItemsWeights") Then
		    ClassWeights = Dict.Value("ItemsWeights")
		  End If
		  
		  Var Engrams() As ArkSA.Engram
		  If Dict.HasKey("ItemClassStrings") Then
		    Var ClassStrings() As Variant = Dict.Value("ItemClassStrings")
		    For Each ClassString As String In ClassStrings
		      Engrams.Add(ArkSA.ResolveEngram("", "", ClassString, ContentPacks, True))
		    Next
		  ElseIf Dict.HasKey("Items") Then
		    Var Paths() As Variant = Dict.Value("Items")
		    For Each Path As String In Paths
		      If Path.Length > 23 And Path.Left(23) = "BlueprintGeneratedClass" Then
		        Path = Path.Middle(24, Path.Length - 27)
		      ElseIf Path.Length > 9 And Path.Left(9) = "Blueprint" Then
		        // This technically does not work, but we'll support it
		        Path = Path.Middle(10, Path.Length - 11)
		      Else
		        // No idea what this says
		        Continue
		      End If
		      
		      Engrams.Add(ArkSA.ResolveEngram("", Path, "", ContentPacks, True))
		    Next
		  End If
		  
		  If ClassWeights.LastIndex < Engrams.LastIndex Then
		    // Add more values
		    While ClassWeights.LastIndex < Engrams.LastIndex
		      ClassWeights.Add(1)
		    Wend
		  ElseIf ClassWeights.LastIndex > Engrams.LastIndex Then
		    // Just truncate
		    ClassWeights.ResizeTo(Engrams.LastIndex)
		  End If
		  
		  For I As Integer = 0 To Engrams.LastIndex
		    Try
		      Var Engram As ArkSA.Engram = Engrams(I)
		      Var ClassWeight As Double = ClassWeights(I)
		      Entry.Add(New ArkSA.LootItemSetEntryOption(Engram, If(ClassWeight > 1.0, ClassWeight / 100, ClassWeight)))
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		  
		  Entry.Modified = False
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As ArkSA.LootItemSetEntryOption) As Integer
		  For I As Integer = 0 To Self.mOptions.LastIndex
		    If Self.mOptions(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Options() As Variant
		  Options.ResizeTo(Self.mOptions.LastIndex)
		  For I As Integer = 0 To Self.mOptions.LastIndex
		    Options(I) = Self.mOptions(I)
		  Next
		  Return New Beacon.GenericIterator(Options)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Entries() As ArkSA.LootItemSetEntry, Separator As String, Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As Double) As String
		  Var Values() As String
		  For Each Entry As ArkSA.LootItemSetEntry In Entries
		    Var EntryConfig As String = Entry.StringValue(Multipliers, UseBlueprints, Difficulty)
		    If EntryConfig.IsEmpty = False Then
		      Values.Add(EntryConfig)
		    End If
		  Next
		  Return Values.Join(Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mOptions.LastIndex = -1 Then
		    Return "No Items"
		  ElseIf Self.mOptions.LastIndex = 0 Then
		    Return Self.mOptions(0).Engram.Label
		  ElseIf Self.mOptions.LastIndex = 1 Then
		    Return Self.mOptions(0).Engram.Label + " or " + Self.mOptions(1).Engram.Label
		  Else
		    Var Labels() As String
		    For I As Integer = 0 To Self.mOptions.LastIndex - 1
		      Labels.Add(Self.mOptions(I).Engram.Label)
		    Next
		    Labels.Add("or " + Self.mOptions(Self.mOptions.LastIndex).Engram.Label)
		    
		    Return Labels.Join(", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQuality() As ArkSA.Quality
		  Return Self.mMaxQuality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQuantity() As Integer
		  Return Self.mMaxQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Merge(Entries() As ArkSA.LootItemSetEntry) As ArkSA.LootItemSetEntry
		  If Entries.Count = 0 Then
		    Return Nil
		  ElseIf Entries.Count = 1 Then
		    Return Entries(0).ImmutableClone
		  End If
		  
		  Var EntryCount As Integer
		  Var EntryWeightSum, EntryChanceSum As Double
		  Var MinQualitySum, MaxQualitySum As Double
		  Var MinQuantity, MaxQuantity As Integer = -1
		  Var Options As New Dictionary
		  For Each Entry As ArkSA.LootItemSetEntry In Entries
		    Var EntryAdded As Boolean
		    For Each Option As ArkSA.LootItemSetEntryOption In Entry
		      If Option.Engram = Nil Then
		        Continue
		      End If
		      
		      Var Key As String = Option.Engram.EngramId
		      If Key = "" Then
		        Continue
		      End If
		      
		      If EntryAdded = False Then
		        EntryWeightSum = EntryWeightSum + Entry.RawWeight
		        EntryChanceSum = EntryChanceSum + Entry.ChanceToBeBlueprint
		        EntryCount = EntryCount + 1
		        MinQualitySum = MinQualitySum + Entry.MinQuality.BaseValue
		        MaxQualitySum = MaxQualitySum + Entry.MaxQuality.BaseValue
		        EntryAdded = True
		      End If
		      
		      If MinQuantity = -1 Then
		        MinQuantity = Entry.MinQuantity
		      Else
		        MinQuantity = Min(MinQuantity, Entry.MinQuantity)
		      End If
		      MaxQuantity = Max(MaxQuantity, Entry.MaxQuantity)
		      
		      Var Arr() As ArkSA.LootItemSetEntryOption
		      If Options.HasKey(Key) Then
		        Arr = Options.Value(Key)
		      End If
		      Arr.Add(Option)
		      Options.Value(Key) = Arr
		    Next
		  Next
		  
		  If Options.KeyCount = 0 Then
		    Return Nil
		  End If
		  
		  Var Replacement As New ArkSA.MutableLootItemSetEntry
		  Replacement.RawWeight = EntryWeightSum / EntryCount
		  Replacement.ChanceToBeBlueprint = EntryChanceSum / EntryCount
		  Replacement.MinQuantity = MinQuantity
		  Replacement.MaxQuantity = MaxQuantity
		  Replacement.MinQuality = ArkSA.Qualities.ForBaseValue(MinQualitySum / EntryCount)
		  Replacement.MaxQuality = ArkSA.Qualities.ForBaseValue(MaxQualitySum / EntryCount)
		  
		  For Each Entry As DictionaryEntry In Options
		    Var Arr() As ArkSA.LootItemSetEntryOption = Entry.Value
		    For Each Option As ArkSA.LootItemSetEntryOption In Arr
		      Replacement.Add(New ArkSA.LootItemSetEntryOption(Option))
		    Next
		  Next
		  
		  Return Replacement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQuality() As ArkSA.Quality
		  Return Self.mMinQuality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQuantity() As Integer
		  Return Self.mMinQuantity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mLastModifiedTime > Self.mLastSaveTime Then
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = False Then
		    Self.mLastSaveTime = System.Microseconds
		  Else
		    Self.mLastModifiedTime = System.Microseconds
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As ArkSA.MutableLootItemSetEntry
		  Return New ArkSA.MutableLootItemSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableLootItemSetEntry
		  Return New ArkSA.MutableLootItemSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.LootItemSetEntry) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mEntryId.IsEmpty = False And Self.mEntryId = Other.mEntryId Then
		    Return 0
		  End If
		  
		  Var SelfHash As String = Self.mEntryId + ":" + Self.Hash
		  Var OtherHash As String = Other.mEntryId + ":" + Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As ArkSA.LootItemSetEntryOption
		  Return Self.mOptions(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pack() As Dictionary
		  Var Options() As Dictionary
		  Options.ResizeTo(Self.mOptions.LastIndex)
		  For Idx As Integer = Self.mOptions.FirstIndex To Self.mOptions.LastIndex
		    Options(Idx) = Self.mOptions(Idx).Pack
		  Next Idx
		  
		  Var Dict As New Dictionary
		  Dict.Value("lootItemSetEntryId") = Self.mEntryId
		  Dict.Value("minQuantity") = Self.mMinQuantity
		  Dict.Value("maxQuantity") = Self.mMaxQuantity
		  Dict.Value("minQuality") = Self.mMinQuality.Key
		  Dict.Value("maxQuality") = Self.mMaxQuality.Key
		  Dict.Value("blueprintChance") = Self.mChanceToBeBlueprint
		  Dict.Value("weight") = Self.mWeight
		  Dict.Value("singleItemQuantity") = Self.mSingleItemQuantity
		  Dict.Value("preventGrinding") = Self.mPreventGrinding
		  Dict.Value("statClampMultiplier") = Self.mStatClampMultiplier
		  Dict.Value("options") = Options
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PreventGrinding() As Boolean
		  Return Self.mPreventGrinding
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RawWeight() As Double
		  Return Max(Self.mWeight, 0.00001)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function RunSimulation(MinQuality As Double, MaxQuality As Double, Weights() As Double, WeightSum As Double, WeightLookup As Dictionary, RequiredBlueprintChance As Double) As ArkSA.LootSimulatorSelection
		  Var QualityValue As Double = (System.Random.InRange(MinQuality * 100000, MaxQuality * 100000) / 100000)
		  Var BlueprintDecision As Integer = System.Random.InRange(1, 100)
		  Var ClassDecision As Double = System.Random.InRange(100000, 100000 + (WeightSum * 100000)) - 100000
		  
		  For Idx As Integer = 0 To Weights.LastIndex
		    If Weights(Idx) < ClassDecision Then
		      Continue For Idx
		    End If
		    
		    Var SelectedWeight As Double = Weights(Idx)
		    Var SelectedEntry As ArkSA.LootItemSetEntryOption = WeightLookup.Value(SelectedWeight)
		    If SelectedEntry Is Nil Then
		      Continue For Idx
		    End If
		    
		    Var Selection As New ArkSA.LootSimulatorSelection
		    Selection.Engram = SelectedEntry.Engram
		    Selection.IsBlueprint = BlueprintDecision > RequiredBlueprintChance
		    Selection.Quality = ArkSA.Qualities.ForBaseValue(QualityValue)
		    Return Selection
		  Next Idx
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SafeForContentPacks(ContentPacks As Beacon.StringList) As Boolean
		  // This method kind of sucks, but yes it is needed for preset generation.
		  
		  If ContentPacks.Count = 0 Then
		    Return True
		  End If
		  
		  For Each Option As ArkSA.LootItemSetEntryOption In Self.mOptions
		    If ContentPacks.IndexOf(Option.Engram.ContentPackId) = -1 Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(ForPreferences As Boolean = False) As Dictionary
		  Var Options() As Dictionary
		  If ForPreferences = False Then
		    For Each Item As ArkSA.LootItemSetEntryOption In Self.mOptions
		      Options.Add(Item.SaveData)
		    Next
		  End If
		  
		  Var Keys As New Dictionary
		  If ForPreferences = False Then
		    Keys.Value("lootItemSetEntryId") = Self.mEntryId
		  End If
		  Keys.Value("minQuantity") = Self.MinQuantity
		  Keys.Value("maxQuantity") = Self.MaxQuantity
		  Keys.Value("minQuality") = Self.MinQuality.Key
		  Keys.Value("maxQuality") = Self.MaxQuality.Key
		  Keys.Value("blueprintChance") = Self.ChanceToBeBlueprint
		  If ForPreferences = False Then
		    Keys.Value("weight") = Self.RawWeight
		  End If
		  Keys.Value("singleItemQuantity") = Self.SingleItemQuantity
		  Keys.Value("preventGrinding") = Self.PreventGrinding
		  Keys.Value("statClampMultiplier") = Self.StatClampMultiplier
		  If ForPreferences = False Then
		    Keys.Value("options") = Options
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As ArkSA.LootSimulatorSelection()
		  Var Quantity As Integer
		  If Self.mMaxQuantity < Self.mMinQuantity Then
		    Quantity = System.Random.InRange(Self.mMaxQuantity, Self.mMinQuantity)
		  Else
		    Quantity = System.Random.InRange(Self.mMinQuantity, Self.mMaxQuantity)
		  End If
		  Var MinQuality As Double = Self.mMinQuality.BaseValue
		  Var MaxQuality As Double = Self.mMaxQuality.BaseValue
		  Var Selections() As ArkSA.LootSimulatorSelection
		  Var RequiredChance As Integer = (1 - Self.mChanceToBeBlueprint) * 100
		  
		  If MaxQuality < MinQuality Then
		    Var Temp As Double = MinQuality
		    MinQuality = MaxQuality
		    MaxQuality = Temp
		  End If
		  
		  Var WeightLookup As New Dictionary
		  Var Sum, Weights() As Double
		  For Each Entry As ArkSA.LootItemSetEntryOption In Self.mOptions
		    If Entry.RawWeight = 0 Then
		      Return Selections
		    End If
		    Sum = Sum + Entry.RawWeight
		    Weights.Add(Sum * 100000)
		    WeightLookup.Value(Sum * 100000) = Entry
		  Next
		  Weights.Sort
		  
		  If Self.SingleItemQuantity Then
		    Var Selection As ArkSA.LootSimulatorSelection = Self.RunSimulation(MinQuality, MaxQuality, Weights, Sum, WeightLookup, RequiredChance)
		    If (Selection Is Nil) = False Then
		      For I As Integer = 1 To Quantity
		        Selections.Add(Selection)
		      Next I
		    End If
		  Else
		    For I As Integer = 1 To Quantity
		      Var Selection As ArkSA.LootSimulatorSelection = Self.RunSimulation(MinQuality, MaxQuality, Weights, Sum, WeightLookup, RequiredChance)
		      If (Selection Is Nil) = False Then
		        Selections.Add(Selection)
		      End If
		    Next I
		  End If
		  
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SingleItemQuantity(Actual As Boolean = False) As Boolean
		  // If Actual is true, the caller is looking for the true state of the setting and not the effective state
		  
		  If Actual Then
		    Return Self.mSingleItemQuantity
		  Else
		    Return Self.mSingleItemQuantity Or Self.mOptions.Count = 1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Split(Entries() As ArkSA.LootItemSetEntry) As ArkSA.LootItemSetEntry()
		  Var Replacements() As ArkSA.LootItemSetEntry
		  For Each Entry As ArkSA.LootItemSetEntry In Entries
		    If Entry.Count = 1 Then
		      Replacements.Add(New ArkSA.LootItemSetEntry(Entry))
		      Continue
		    End If
		    
		    For Each Option As ArkSA.LootItemSetEntryOption In Entry
		      Var Replacement As New ArkSA.MutableLootItemSetEntry(Entry)
		      Replacement.EntryId = Beacon.UUID.v4
		      Replacement.ResizeTo(0)
		      Replacement(0) = New ArkSA.LootItemSetEntryOption(Option)
		      Replacements.Add(Replacement)
		    Next
		  Next
		  Return Replacements
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatClampMultiplier() As Double
		  Return Self.mStatClampMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As Double) As String
		  If Self.mOptions.Count = 0 Then
		    Return ""
		  End If
		  
		  Var Paths(), Weights(), Classes() As String
		  Paths.ResizeTo(Self.mOptions.LastIndex)
		  Weights.ResizeTo(Self.mOptions.LastIndex)
		  Classes.ResizeTo(Self.mOptions.LastIndex)
		  For I As Integer = 0 To Self.mOptions.LastIndex
		    Paths(I) = Self.mOptions(I).Engram.GeneratedClassBlueprintPath()
		    Classes(I) = """" + Self.mOptions(I).Engram.ClassString + """"
		    Weights(I) = Beacon.PrettyText(Self.mOptions(I).RawWeight * 100)
		  Next
		  
		  Var BaseArbitraryQuality As Double = ArkSA.Configs.Difficulty.BaseArbitraryQuality(Difficulty)
		  Var MinQuality As Double = Self.mMinQuality.Value(Multipliers.Min, BaseArbitraryQuality)
		  Var MaxQuality As Double = Self.mMaxQuality.Value(Multipliers.Max, BaseArbitraryQuality)
		  If MinQuality > MaxQuality Then
		    // This probably isn't a good thing. Use the min for both values.
		    MaxQuality = MinQuality
		  End If
		  
		  Var Chance As Double = if(Self.CanBeBlueprint, Self.mChanceToBeBlueprint, 0)
		  Var EntryWeight As Integer = Self.mWeight
		  
		  Var Values() As String
		  Values.Add("EntryWeight=" + EntryWeight.ToString)
		  If UseBlueprints Then
		    Values.Add("Items=(" + Paths.Join(",") + ")")
		  Else
		    Values.Add("ItemClassStrings=(" + Classes.Join(",") + ")")
		  End If
		  Values.Add("ItemsWeights=(" + Weights.Join(",") + ")")
		  Values.Add("MinQuantity=" + Self.MinQuantity.ToString)
		  Values.Add("MaxQuantity=" + Self.MaxQuantity.ToString)
		  Values.Add("MinQuality=" + MinQuality.PrettyText)
		  Values.Add("MaxQuality=" + MaxQuality.PrettyText)
		  If Self.SingleItemQuantity Then
		    Values.Add("bApplyQuantityToSingleItem=True")
		  End If
		  
		  // ChanceToActuallyGiveItem and ChanceToBeBlueprintOverride appear to be inverse of each
		  // other. I'm not sure why both exist, but I've got a theory. Some of the loot drop
		  // definitions are based on PrimalSupplyCrateItemSets and others on PrimalSupplyCrateItemSet.
		  // There's no common parent between them. Seems like Wildcard messed this up. I think
		  // PrimalSupplyCrateItemSets uses ChanceToActuallyGiveItem, and PrimalSupplyCrateItemSet
		  // uses ChanceToBeBlueprintOverride. Safest option right now is to include both.
		  
		  // 2017-07-07: As of 261.0, it appears ChanceToActuallyGiveItem does something else. It will
		  // now be left off.
		  If Chance < 1 Then
		    Values.Add("bForceBlueprint=False")
		  Else
		    Values.Add("bForceBlueprint=True")
		  End If
		  //Values.Add("ChanceToActuallyGiveItem=" + InverseChance.PrettyText)
		  Values.Add("ChanceToBeBlueprintOverride=" + Chance.PrettyText)
		  
		  If Self.PreventGrinding Then
		    Values.Add("bForcePreventGrinding=True")
		  End If
		  
		  If Self.StatClampMultiplier <> 1.0 Then
		    Values.Add("ItemStatClampsMultiplier=" + Self.StatClampMultiplier.PrettyText)
		  End If
		  
		  Return "(" + Values.Join(",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  Location = Location + Beacon.Issue.Separator + Self.EntryId
		  
		  For Each Option As ArkSA.LootItemSetEntryOption In Self.mOptions
		    Option.Validate(Location, Issues, Project)
		  Next Option
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mChanceToBeBlueprint As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEntryId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHashTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastModifiedTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSaveTime As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxQuality As ArkSA.Quality
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinQuality As ArkSA.Quality
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mOptions() As ArkSA.LootItemSetEntryOption
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPreventGrinding As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSingleItemQuantity As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStatClampMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWeight As Double
	#tag EndProperty


	#tag Constant, Name = OptionLoadEmpty, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionNewId, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
