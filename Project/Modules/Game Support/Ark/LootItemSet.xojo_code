#tag Class
Protected Class LootItemSet
Implements Beacon.Countable,Iterable,Ark.Weighted,Beacon.Validateable
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mMinNumItems = 1
		  Self.mMaxNumItems = 1
		  Self.mNumItemsPower = 1
		  Self.mSetWeight = 500
		  Self.mItemsRandomWithoutReplacement = True
		  Self.mLabel = "Untitled Item Set"
		  Self.mUUID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.LootItemSet)
		  Self.Constructor()
		  Self.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CopyFrom(Source As Ark.LootItemSet)
		  Self.mHash = Source.mHash
		  Self.mItemsRandomWithoutReplacement = Source.mItemsRandomWithoutReplacement
		  Self.mLabel = Source.mLabel
		  Self.mLastHashTime = Source.mLastHashTime
		  Self.mLastModifiedTime = Source.mLastModifiedTime
		  Self.mLastSaveTime = Source.mLastSaveTime
		  Self.mMaxNumItems = Source.mMaxNumItems
		  Self.mMinNumItems = Source.mMinNumItems
		  Self.mNumItemsPower = Source.mNumItemsPower
		  Self.mSetWeight = Source.mSetWeight
		  Self.mTemplateUUID = Source.mTemplateUUID
		  Self.mUUID = Source.mUUID
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastIndex)
		  For I As Integer = 0 To Source.mEntries.LastIndex
		    Self.mEntries(I) = Source.mEntries(I).ImmutableVersion
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mEntries.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary, NewUUID As Boolean = False) As Ark.LootItemSet
		  Var Set As New Ark.MutableLootItemSet
		  If NewUUID Then
		    Set.UUID = v4UUID.Create.StringValue
		  Else
		    Try
		      If Dict.HasKey("loot_item_set_id") Then
		        Set.UUID = Dict.Value("loot_item_set_id")
		      ElseIf Dict.HasKey("UUID") Then
		        Set.UUID = Dict.Value("UUID")
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading UUID value")
		    End Try
		  End If
		  
		  Try
		    If Dict.HasKey("NumItemsPower") Then
		      Set.NumItemsPower = Dict.Value("NumItemsPower")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading NumItemsPower value")
		  End Try
		  
		  Try
		    If Dict.HasKey("weight") Then
		      Set.RawWeight = Dict.Value("weight")
		    ElseIf Dict.HasKey("Weight") Then
		      Set.RawWeight = Dict.Value("Weight")
		    ElseIf Dict.HasKey("SetWeight") Then
		      Set.RawWeight = Dict.Value("SetWeight") * 1000.0
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Weight value")
		  End Try
		  
		  Try
		    If Dict.HasKey("prevent_duplicates") Then
		      Set.ItemsRandomWithoutReplacement = Dict.Value("prevent_duplicates")
		    ElseIf Dict.HasKey("bItemsRandomWithoutReplacement") Then
		      Set.ItemsRandomWithoutReplacement = Dict.Value("bItemsRandomWithoutReplacement")
		    ElseIf Dict.HasKey("ItemsRandomWithoutReplacement") Then
		      Set.ItemsRandomWithoutReplacement = Dict.Value("ItemsRandomWithoutReplacement")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading bItemsRandomWithoutReplacement value")
		  End Try
		  
		  Try
		    If Dict.HasKey("label") Then
		      Set.Label = Dict.Value("label")
		    ElseIf Dict.HasKey("Label") Then
		      Set.Label = Dict.Value("Label")
		    ElseIf Dict.HasKey("SetName") Then
		      Set.Label = Dict.Value("SetName")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading Label value")
		  End Try
		  
		  Var Children() As Dictionary
		  Try
		    If Dict.HasKey("entries") And IsNull(Dict.Value("entries")) = False Then
		      Children = Dict.Value("entries").DictionaryArrayValue
		    ElseIf Dict.HasKey("ItemEntries") And IsNull(Dict.Value("ItemEntries")) = False Then
		      Children = Dict.Value("ItemEntries").DictionaryArrayValue
		    ElseIf Dict.HasKey("Items") And IsNull(Dict.Value("Items")) = False Then
		      Children = Dict.Value("Items").DictionaryArrayValue
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Casting ItemEntries to array")
		  End Try
		  
		  For Idx As Integer = 0 To Children.LastIndex
		    Try
		      Var Entry As Ark.LootItemSetEntry = Ark.LootItemSetEntry.FromSaveData(Dictionary(Children(Idx)), NewUUID)
		      If (Entry Is Nil) = False Then
		        Set.Add(Entry)
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading set entry dictionary #" + Idx.ToString(Locale.Raw, "0"))
		    End Try
		  Next
		  
		  Try
		    If Dict.HasKey("min_entries") Then
		      Set.MinNumItems = Dict.Value("min_entries")
		    ElseIf Dict.HasKey("MinNumItems") Then
		      Set.MinNumItems = Dict.Value("MinNumItems")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinNumItems value")
		  End Try
		  
		  Try
		    If Dict.HasKey("max_entries") Then
		      Set.MaxNumItems = Dict.Value("max_entries")
		    ElseIf Dict.HasKey("MaxNumItems") Then
		      Set.MaxNumItems = Dict.Value("MaxNumItems")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxNumItems value")
		  End Try
		  
		  Try
		    If Dict.HasKey("SourcePresetID") Then
		      Set.TemplateUUID = Dict.Value("SourcePresetID")
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading SourcePresetID value")
		  End Try
		  
		  Set.Modified = False
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromTemplate(Template As Ark.LootTemplate, ForLootContainer As Ark.LootContainer, Mask As UInt64, ContentPacks As Beacon.StringList) As Ark.LootItemSet
		  Var Set As New Ark.MutableLootItemSet
		  Set.Label = Template.Label
		  Set.RawWeight = ForLootContainer.DefaultItemSetWeight
		  Set.TemplateUUID = Template.UUID
		  
		  Var ActiveModifiers() As String = Template.ActiveSelectorIDs
		  Var QuantityMultipliers() As Double
		  Var MinQualityModifiers() As Integer
		  Var MaxQualityModifiers() As Integer
		  Var BlueprintMultipliers() As Double
		  Var WeightMultipliers() As Double
		  Var CommonData As Beacon.CommonData
		  If ActiveModifiers.Count > 0 Then
		    CommonData = Beacon.CommonData.Pool.Get(False)
		  End If
		  For Each LootSelectorUUID As String In ActiveModifiers
		    Var TemplateSelector As Beacon.TemplateSelector = CommonData.GetTemplateSelectorByUUID(LootSelectorUUID)
		    If TemplateSelector Is Nil Then
		      Continue
		    End If
		    
		    Var LootSelector As New Ark.LootContainerSelector(TemplateSelector)
		    If LootSelector.Matches(ForLootContainer) Then
		      QuantityMultipliers.Add(Template.QuantityMultiplier(LootSelectorUUID))
		      MinQualityModifiers.Add(Template.MinQualityOffset(LootSelectorUUID))
		      MaxQualityModifiers.Add(Template.MaxQualityOffset(LootSelectorUUID))
		      BlueprintMultipliers.Add(Template.BlueprintChanceMultiplier(LootSelectorUUID))
		      WeightMultipliers.Add(Template.WeightMultiplier(LootSelectorUUID))
		    End If
		  Next LootSelectorUUID
		  
		  Var Qualities() As Ark.Quality = Ark.Qualities.All
		  
		  For Each TemplateEntry As Ark.LootTemplateEntry In Template
		    If TemplateEntry.ValidForMask(Mask) = False Or TemplateEntry.SafeForContentPacks(ContentPacks) = False Then
		      Continue
		    End If
		    
		    Var Entry As New Ark.MutableLootItemSetEntry
		    Entry.SingleItemQuantity = TemplateEntry.SingleItemQuantity
		    Entry.PreventGrinding = TemplateEntry.PreventGrinding
		    Entry.StatClampMultiplier = TemplateEntry.StatClampMultiplier
		    
		    For Idx As Integer = 0 To TemplateEntry.LastIndex
		      Entry.Add(TemplateEntry(Idx))
		    Next Idx
		    
		    If TemplateEntry.RespectQualityOffsets Then
		      Var MinQualityIndex, MaxQualityIndex As Integer
		      For I As Integer = 0 To Qualities.LastIndex
		        If Qualities(I) = TemplateEntry.MinQuality Then
		          MinQualityIndex = I
		        End If
		        If Qualities(I) = TemplateEntry.MaxQuality Then
		          MaxQualityIndex = I
		        End If
		      Next
		      
		      For Each Modifier As Integer In MinQualityModifiers
		        MinQualityIndex = MinQualityIndex + Modifier
		      Next
		      For Each Modifier As Integer In MaxQualityModifiers
		        MaxQualityIndex = MaxQualityIndex + Modifier
		      Next
		      MinQualityIndex = Max(Min(MinQualityIndex, Qualities.LastIndex), 0)
		      MaxQualityIndex = Max(Min(MaxQualityIndex, Qualities.LastIndex), 0)
		      Entry.MinQuality = Qualities(MinQualityIndex)
		      Entry.MaxQuality = Qualities(MaxQualityIndex)
		    Else
		      Entry.MinQuality = TemplateEntry.MinQuality
		      Entry.MaxQuality = TemplateEntry.MaxQuality
		    End If
		    
		    If TemplateEntry.RespectQuantityMultipliers Then
		      Var MinQuantityRaw As Double = TemplateEntry.MinQuantity
		      Var MaxQuantityRaw As Double = TemplateEntry.MaxQuantity
		      For Each Multiplier As Double In QuantityMultipliers
		        MinQuantityRaw = MinQuantityRaw * Multiplier
		        MaxQuantityRaw = MaxQuantityRaw * Multiplier
		      Next
		      Entry.MinQuantity = Round(MinQuantityRaw)
		      Entry.MaxQuantity = Round(MaxQuantityRaw)
		    Else
		      Entry.MinQuantity = TemplateEntry.MinQuantity
		      Entry.MaxQuantity = TemplateEntry.MaxQuantity
		    End If
		    
		    If TemplateEntry.CanBeBlueprint And TemplateEntry.RespectBlueprintChanceMultipliers Then
		      Var BlueprintChanceRaw As Double = TemplateEntry.ChanceToBeBlueprint
		      For Each Multiplier As Double In BlueprintMultipliers
		        BlueprintChanceRaw = BlueprintChanceRaw * Multiplier
		      Next
		      Entry.ChanceToBeBlueprint = Max(Min(BlueprintChanceRaw, 1.0), 0.0)
		    Else
		      Entry.ChanceToBeBlueprint = TemplateEntry.ChanceToBeBlueprint
		    End If
		    
		    Var RawWeight As Double = TemplateEntry.RawWeight
		    If TemplateEntry.RespectWeightMultipliers Then
		      For Each Multiplier As Double In WeightMultipliers
		        RawWeight = RawWeight * Multiplier
		      Next
		    End If
		    Entry.RawWeight = RawWeight
		    
		    Set.Add(Entry)
		  Next
		  
		  Set.MinNumItems = Template.MinEntriesSelected
		  Set.MaxNumItems = Template.MaxEntriesSelected
		  
		  Set.Modified = False
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(ForPreset As Boolean = False) As String
		  If Self.HashIsStale Or ForPreset Then
		    Var Entries() As String
		    Entries.ResizeTo(Self.mEntries.LastIndex)
		    For I As Integer = 0 To Entries.LastIndex
		      Entries(I) = Self.mEntries(I).Hash
		    Next
		    Entries.Sort
		    
		    Var Locale As Locale = Locale.Raw
		    Var Format As String = "0.000"
		    
		    Var Parts(6) As String
		    Parts(0) = Beacon.MD5(Entries.Join(",")).Lowercase
		    Parts(1) = Self.MaxNumItems.ToString(Locale, Format)
		    Parts(2) = Self.MinNumItems.ToString(Locale, Format)
		    If ForPreset Then
		      Return Beacon.MD5(Parts.Join(":")).Lowercase
		    End If
		    Parts(3) = Self.NumItemsPower.ToString(Locale, Format)
		    Parts(4) = Self.RawWeight.ToString(Locale, Format)
		    Parts(5) = Self.Label.Lowercase  
		    Parts(6) = If(Self.ItemsRandomWithoutReplacement, "True", "False")
		    
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
		  
		  For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		    If Entry.HashIsStale Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As Ark.LootItemSet
		  Return New Ark.LootItemSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootItemSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Multipliers As Beacon.Range, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.LootItemSet
		  Var Set As New Ark.MutableLootItemSet
		  If Dict.HasKey("NumItemsPower") Then
		    Set.NumItemsPower = Dict.Value("NumItemsPower")
		  End If
		  If Dict.HasKey("SetWeight") Then
		    Set.RawWeight = Dict.Value("SetWeight")
		  End If
		  If Dict.HasKey("bItemsRandomWithoutReplacement") Then
		    Set.ItemsRandomWithoutReplacement = Dict.Value("bItemsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("SetName") Then
		    Set.Label = Dict.Value("SetName")
		  End If
		  
		  Var Children() As Variant
		  If Dict.HasKey("ItemEntries") Then
		    Children = Dict.Value("ItemEntries")
		  End If
		  For Each Child As Variant In Children
		    Try
		      If IsNull(Child) Or (Child IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var Entry As Ark.LootItemSetEntry = Ark.LootItemSetEntry.ImportFromConfig(Dictionary(Child), Multipliers, Difficulty, ContentPacks)
		      If Entry <> Nil Then
		        Set.Add(Entry)
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Loading item set from Beacon project")
		    End Try
		  Next
		  
		  If Dict.HasKey("MinNumItems") Then
		    Set.MinNumItems = Dict.Value("MinNumItems")
		  End If
		  If Dict.HasKey("MaxNumItems") Then
		    Set.MaxNumItems = Dict.Value("MaxNumItems")
		  End If
		  
		  If Dict.HasKey("SourcePresetID") Then
		    Set.TemplateUUID = Dict.Value("SourcePresetID")
		  End If
		  
		  Set.Modified = False
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Ark.LootItemSetEntry) As Integer
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    If Self.mEntries(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemsRandomWithoutReplacement() As Boolean
		  Return Self.mItemsRandomWithoutReplacement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Entries() As Variant
		  Entries.ResizeTo(Self.mEntries.LastIndex)
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    Entries(I) = Self.mEntries(I)
		  Next
		  Return New Beacon.GenericIterator(Entries)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Sets() As Ark.LootItemSet, Separator As String, Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As Double) As String
		  Var Values() As String
		  For Each Set As Ark.LootItemSet In Sets
		    Values.Add(Set.StringValue(Multipliers, UseBlueprints, Difficulty))
		  Next
		  
		  Return Values.Join(Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxNumItems() As Integer
		  Return Max(Self.mMaxNumItems, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinNumItems() As Integer
		  Return Max(Self.mMinNumItems, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mLastModifiedTime > Self.mLastSaveTime Then
		    Return True
		  End If
		  
		  For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		    If Entry.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = False Then
		    Self.mLastSaveTime = System.Microseconds
		  Else
		    Self.mLastModifiedTime = System.Microseconds
		  End If
		  
		  If Not Value Then
		    For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		      Entry.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableLootItemSet
		  Return New Ark.MutableLootItemSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootItemSet
		  Return New Ark.MutableLootItemSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumItemsPower() As Double
		  Return Self.mNumItemsPower
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.LootItemSet) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  // If they have the same ID, they are the same. End of story.
		  If Self.mUUID = Other.mUUID Then
		    Return 0
		  End If
		  
		  // If the do not have the same ID, we must sort them alphabetically but without equating two sets with the same label
		  Var SelfComparison As String = Self.mLabel + " " + Self.mUUID
		  Var OtherComparison As String = Other.mLabel + " " + Other.mUUID
		  Return SelfComparison.Compare(OtherComparison, ComparisonOptions.CaseInsensitive, Locale.Current)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Ark.LootItemSetEntry
		  Return Self.mEntries(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pack() As Dictionary
		  Var Entries() As Dictionary
		  Entries.ResizeTo(Self.mEntries.LastIndex)
		  For Idx As Integer = Self.mEntries.FirstIndex To Self.mEntries.LastIndex
		    Entries(Idx) = Self.mEntries(Idx).Pack
		  Next Idx
		  
		  Var Dict As New Dictionary
		  Dict.Value("loot_item_set_id") = Self.mUUID
		  Dict.Value("label") = Self.mLabel
		  Dict.Value("min_entries") = Self.mMinNumItems
		  Dict.Value("max_entries") = Self.mMaxNumItems
		  Dict.Value("weight") = Self.mSetWeight
		  Dict.Value("prevent_duplicates") = Self.mItemsRandomWithoutReplacement
		  Dict.Value("entries") = Entries
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RawWeight() As Double
		  Return Max(Self.mSetWeight, 0.00001)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Rebuild(ForContainer As Ark.LootContainer, Mask As UInt64, ContentPacks As Beacon.StringList) As Ark.LootItemSet
		  If Self.mTemplateUUID.IsEmpty Then
		    Return Nil
		  End If
		  
		  Var Template As Ark.LootTemplate = Ark.DataSource.Pool.Get(False).GetLootTemplateByUUID(Self.TemplateUUID)
		  If Template Is Nil Then
		    Return Nil
		  End If
		  
		  Var Clone As Ark.LootItemSet = Self.FromTemplate(Template, ForContainer, Mask, ContentPacks)
		  If Self.Hash(True) = Clone.Hash(True) Then
		    // No change
		    Return Nil
		  End If
		  
		  Var Mutable As New Ark.MutableLootItemSet(Clone)
		  Mutable.RawWeight = Self.RawWeight
		  Mutable.ItemsRandomWithoutReplacement = Self.ItemsRandomWithoutReplacement
		  Mutable.NumItemsPower = Self.NumItemsPower
		  Return New Ark.LootItemSet(Mutable)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RelativeWeight(Index As Integer) As Double
		  Return Self.mEntries(Index).RawWeight / Self.TotalWeight()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Children() As Dictionary
		  For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		    Children.Add(Entry.SaveData)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("UUID") = Self.mUUID
		  Keys.Value("ItemEntries") = Children
		  Keys.Value("bItemsRandomWithoutReplacement") = Self.ItemsRandomWithoutReplacement
		  Keys.Value("Label") = Self.Label // Write "Label" so older versions of Beacon can read it
		  Keys.Value("MaxNumItems") = Self.MaxNumItems
		  Keys.Value("MinNumItems") = Self.MinNumItems
		  Keys.Value("NumItemsPower") = Self.NumItemsPower
		  Keys.Value("Weight") = Self.RawWeight
		  Keys.Value("SetWeight") = Self.RawWeight / 1000
		  If Self.TemplateUUID.IsEmpty = False Then
		    Keys.Value("SourcePresetID") = Self.TemplateUUID
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As Ark.LootSimulatorSelection()
		  Var Selections() As Ark.LootSimulatorSelection
		  If Self.mEntries.LastIndex = -1 Then
		    Return Selections
		  End If
		  
		  Var NumEntries As Integer = Self.Count
		  Var MinEntries As Integer = Min(Self.MinNumItems, Self.MaxNumItems)
		  Var MaxEntries As Integer = Max(Self.MaxNumItems, Self.MinNumItems)
		  
		  Var SelectedEntries() As Ark.LootItemSetEntry
		  If NumEntries = MinEntries And MinEntries = MaxEntries And Self.ItemsRandomWithoutReplacement Then
		    // All
		    For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		      SelectedEntries.Add(Entry)
		    Next
		  Else
		    Const WeightScale = 100000
		    Var Pool() As Ark.LootItemSetEntry
		    Pool.ResizeTo(Self.mEntries.LastIndex)
		    For I As Integer = 0 To Self.mEntries.LastIndex
		      Pool(I) = New Ark.LootItemSetEntry(Self.mEntries(I))
		    Next
		    
		    Var RecomputeFigures As Boolean = True
		    Var ChooseEntries As Integer = System.Random.InRange(MinEntries, MaxEntries)
		    Var WeightSum, Weights() As Double
		    Var WeightLookup As Dictionary
		    For I As Integer = 1 To ChooseEntries
		      If Pool.LastIndex = -1 Then
		        Exit For I
		      End If
		      
		      If RecomputeFigures Then
		        Ark.LootSimulatorSelection.ComputeSimulatorFigures(Pool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Var Decision As Double = System.Random.InRange(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Var SelectedEntry As Ark.LootItemSetEntry
		        
		        For X As Integer = 0 To Weights.LastIndex
		          If Weights(X) >= Decision Then
		            Var SelectedWeight As Double = Weights(X)
		            SelectedEntry = WeightLookup.Value(SelectedWeight)
		            Exit For X
		          End If
		        Next
		        
		        If SelectedEntry = Nil Then
		          Continue
		        End If
		        
		        SelectedEntries.Add(SelectedEntry)
		        If Self.ItemsRandomWithoutReplacement Then
		          For X As Integer = 0 To Pool.LastIndex
		            If Pool(X) = SelectedEntry Then
		              Pool.RemoveAt(X)
		              Exit For X
		            End If
		          Next
		          RecomputeFigures = True
		        End If
		        
		        Exit
		      Loop
		    Next
		  End If
		  
		  For Each Entry As Ark.LootItemSetEntry In SelectedEntries
		    Var EntrySelections() As Ark.LootSimulatorSelection = Entry.Simulate()
		    For Each Selection As Ark.LootSimulatorSelection In EntrySelections
		      Selections.Add(Selection)
		    Next
		  Next
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Multipliers As Beacon.Range, UseBlueprints As Boolean, Difficulty As Double) As String
		  Var Values() As String
		  Values.Add("SetName=""" + Self.Label + """")
		  Values.Add("MinNumItems=" + Self.MinNumItems.ToString)
		  Values.Add("MaxNumItems=" + Self.MaxNumItems.ToString)
		  Values.Add("NumItemsPower=" + Self.mNumItemsPower.PrettyText)
		  Values.Add("SetWeight=" + Self.mSetWeight.PrettyText)
		  Values.Add("bItemsRandomWithoutReplacement=" + if(Self.mItemsRandomWithoutReplacement, "True", "False"))
		  Values.Add("ItemEntries=(" + Ark.LootItemSetEntry.Join(Self.mEntries, ",", Multipliers, UseBlueprints, Difficulty) + ")")
		  Return "(" + Values.Join(",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TemplateUUID() As String
		  Return Self.mTemplateUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeight() As Double
		  Var Value As Double
		  For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		    Value = Value + Entry.RawWeight
		  Next
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  For Each Entry As Ark.LootItemSetEntry In Self.mEntries
		    Entry.Validate(Location + "." + Self.UUID, Issues, Project)
		  Next Entry
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEntries() As Ark.LootItemSetEntry
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mItemsRandomWithoutReplacement As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
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
		Protected mMaxNumItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinNumItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mNumItemsPower As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSetWeight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTemplateUUID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUUID As String
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
