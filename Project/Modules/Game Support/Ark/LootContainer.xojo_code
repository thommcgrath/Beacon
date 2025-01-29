#tag Class
Protected Class LootContainer
Implements Ark.Blueprint,Beacon.Countable,Iterable,Beacon.Validateable,Beacon.DisambiguationCandidate
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AppendMode() As Boolean
		  Return Self.mAppendMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintId() As String
		  Return Self.mLootDropId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Ark.CategoryLootContainers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.LootContainer
		  Return New Ark.LootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mMinItemSets = 1
		  Self.mMaxItemSets = 1
		  Self.mPreventDuplicates = True
		  Self.mMultipliers = New Beacon.Range(1.0, 1.0)
		  Self.mRequirements = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.LootContainer)
		  Self.Constructor()
		  
		  Self.mAlternateLabel = Source.mAlternateLabel
		  Self.mAppendMode = Source.mAppendMode
		  Self.mAvailability = Source.mAvailability
		  Self.mClassString = Source.mClassString
		  Self.mExperimental = Source.mExperimental
		  Self.mLabel = Source.mLabel
		  Self.mMaxItemSets = Source.MaxItemSets
		  Self.mMinItemSets = Source.mMinItemSets
		  Self.mContentPackId = Source.mContentPackId
		  Self.mModified = Source.mModified
		  Self.mContentPackName = Source.mContentPackName
		  Self.mMultipliers = Source.mMultipliers
		  Self.mNotes = Source.mNotes
		  Self.mLootDropId = Source.mLootDropId
		  Self.mPath = Source.mPath
		  Self.mPreventDuplicates = Source.mPreventDuplicates
		  Self.mRequirements = If(Source.mRequirements Is Nil, Nil, Source.mRequirements.Clone)
		  Self.mSortValue = Source.mSortValue
		  Self.mIconID = Source.mIconID
		  Self.mUIColor = Source.mUIColor
		  Self.mLastUpdate = Source.mLastUpdate
		  Self.mPendingContentsString = Source.mPendingContentsString
		  
		  Self.mItemSets.ResizeTo(Source.mItemSets.LastIndex)
		  For I As Integer = Source.mItemSets.FirstRowIndex To Source.mItemSets.LastIndex
		    Self.mItemSets(I) = Source.mItemSets(I).ImmutableVersion
		  Next
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Add(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentsString(Pretty As Boolean = False) As String
		  If Self.mPendingContentsString.IsEmpty = False Then
		    Return Self.mPendingContentsString
		  End If
		  
		  Var Objects() As Variant
		  For Each Set As Ark.LootItemSet In Self.mItemSets
		    If (Set Is Nil) = False Then
		      Objects.Add(Set.SaveData)
		    End If
		  Next
		  Try
		    Return Beacon.GenerateJSON(Objects, Pretty)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Self.LoadPendingContents()
		  Return Self.mItemSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(BlueprintId As String, Path As String, ClassString As String) As Ark.LootContainer
		  Var LootContainer As New Ark.LootContainer
		  LootContainer.mContentPackId = Ark.UserContentPackId
		  LootContainer.mContentPackName = Ark.UserContentPackName
		  
		  If BlueprintId.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "BeaconLoot_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "BeaconLoot_" + BlueprintId + "_C"
		    End If
		    Path = Ark.UnknownBlueprintPath("LootContainers", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = Ark.ClassStringFromPath(Path)
		  End If
		  If BlueprintId.IsEmpty Then
		    BlueprintId = Beacon.UUID.v5(LootContainer.mContentPackId.Lowercase + ":" + Path.Lowercase)
		  End If
		  
		  LootContainer.mClassString = ClassString
		  LootContainer.mPath = Path
		  LootContainer.mLootDropId = BlueprintId
		  LootContainer.mLabel = Ark.LabelFromClassString(ClassString)
		  Return LootContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultItemSetWeight() As Double
		  Self.LoadPendingContents()
		  
		  If Self.mItemSets.Count = 0 Then
		    If Self.mAppendMode Then
		      Return 0.5
		    Else
		      Return 500
		    End If
		  End If
		  
		  Var Sum As Double
		  For Idx As Integer = Self.mItemSets.FirstIndex To Self.mItemSets.LastIndex
		    Sum = Sum + Self.mItemSets(Idx).RawWeight
		  Next Idx
		  Return Sum / Self.mItemSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationId() As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mLootDropId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationSuffix(Mask As UInt64) As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Ark.Maps.LabelForMask(Self.Availability And Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Experimental() As Boolean
		  Return Self.mExperimental
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Ark.LootContainer
		  If SaveData Is Nil Then
		    Return Nil
		  End If
		  
		  Var PreventDuplicatesKey As String = "PreventDuplicates"
		  Var AppendModeKey As String = "AppendMode"
		  Var MinItemSetsKey As String = "MinItemSets"
		  Var MaxItemSetsKey As String = "MaxItemSets"
		  Var SourceContainer As Ark.LootContainer
		  If SaveData.HasKey("lootDropId") Then
		    PreventDuplicatesKey = "preventDuplicates"
		    AppendModeKey = "appendMode"
		    MinItemSetsKey = "minItemSets"
		    MaxItemSetsKey = "maxItemSets"
		    SourceContainer = Ark.ResolveLootContainer(SaveData.Value("lootDropId").StringValue, "", "", Nil)
		  ElseIf SaveData.HasKey("Reference") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(SaveData.Value("Reference"))
		    If Reference Is Nil Then
		      Return Nil
		    End If
		    SourceContainer = Ark.LootContainer(Reference.Resolve)
		  Else
		    SourceContainer = Ark.ResolveLootContainer(SaveData, "", "", "SupplyCrateClassString", Nil)
		    PreventDuplicatesKey = "bSetsRandomWithoutReplacement"
		    AppendModeKey = "bAppendMode"
		  End If
		  
		  If SourceContainer Is Nil Then
		    Return Nil
		  End If
		  
		  Var Container As New Ark.MutableLootContainer(SourceContainer)
		  
		  Try
		    Container.MinItemSets = SaveData.Lookup(MinItemSetsKey, 1).IntegerValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinItemSets value")
		  End Try
		  
		  Try
		    Container.MaxItemSets = SaveData.Lookup(MaxItemSetsKey, 1).IntegerValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxItemSets value")
		  End Try
		  
		  Try
		    Container.PreventDuplicates = SaveData.Lookup(PreventDuplicatesKey, True).BooleanValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading " + PreventDuplicatesKey + " value")
		  End Try
		  
		  Try
		    Container.AppendMode = SaveData.Lookup(AppendModeKey, False).BooleanValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading " + AppendModeKey + " value")
		  End Try
		  
		  Var SetDicts() As Variant
		  If SaveData.HasKey("itemSets") Then
		    Try
		      SetDicts = SaveData.Value("itemSets")
		    Catch Err As RuntimeException
		    End Try
		  ElseIf SaveData.HasKey("ItemSets") Then
		    Try
		      SetDicts = SaveData.Value("ItemSets")
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  For Idx As Integer = 0 To SetDicts.LastIndex
		    Try
		      Var SetDict As Variant = SetDicts(Idx)
		      If IsNull(SetDict) Or SetDict.IsArray = True Or SetDict.Type <> Variant.TypeObject Or (SetDict.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var Set As Ark.LootItemSet = Ark.LootItemSet.FromSaveData(Dictionary(SetDict))
		      If (Set Is Nil) = False Then
		        Container.Add(Set)
		      End If
		    Catch IdxErr As RuntimeException
		      App.Log(IdxErr, CurrentMethodName, "Reading item set member")
		    End Try
		  Next
		  
		  Container.Modified = False
		  Return Container
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IconID() As String
		  Return Self.mIconID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootContainer
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(ItemSet As Ark.LootItemSet) As Integer
		  Self.LoadPendingContents()
		  For Idx As Integer = 0 To Self.mItemSets.LastIndex
		    If Self.mItemSets(Idx) = ItemSet Then
		      Return Idx
		    End If
		  Next Idx
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Self.LoadPendingContents()
		  Var Sets() As Variant
		  Sets.ResizeTo(Self.mItemSets.LastIndex)
		  For I As Integer = 0 To Self.mItemSets.LastIndex
		    Sets(I) = Self.mItemSets(I)
		  Next
		  Return New Beacon.GenericIterator(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  If Self.mLabel.IsEmpty Then
		    Self.mLabel = Ark.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadPendingContents()
		  If Self.mPendingContentsString.IsEmpty Then
		    Return
		  End If
		  
		  Try
		    // Sometimes the defaults have duplicated sets, which confuses Beacon's multi-editor.
		    Var Names() As String
		    Var Children() As Variant = Beacon.ParseJSON(Self.mPendingContentsString)
		    Self.mItemSets.ResizeTo(-1)
		    For Each SaveData As Dictionary In Children
		      Var Set As Ark.LootItemSet = Ark.LootItemSet.FromSaveData(SaveData)
		      If Set Is Nil Then
		        Continue
		      End If
		      
		      Var Label As String = Set.Label
		      Var AdjustedLabel As String = Beacon.FindUniqueLabel(Label, Names)
		      If AdjustedLabel <> Label Then
		        Var Mutable As New Ark.MutableLootItemSet(Set)
		        Mutable.Label = AdjustedLabel
		        Set = New Ark.LootItemSet(Mutable)
		      End If
		      Names.Add(AdjustedLabel)
		      Self.mItemSets.Add(Set)
		    Next
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.mPendingContentsString = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootDropId() As String
		  Return Self.mLootDropId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxItemSets() As Integer
		  Return Self.mMaxItemSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItemSets() As Integer
		  Return Self.mMinItemSets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Multipliers() As Beacon.Range
		  Return Self.mMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableLootContainer
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.MutableLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootContainer
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.MutableLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Notes() As String
		  Return Self.mNotes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mLootDropId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Idx As Integer) As Ark.LootItemSet
		  Self.LoadPendingContents()
		  Return Self.mItemSets(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary, ForAPI As Boolean)
		  // Part of the Ark.Blueprint interface.
		  
		  Self.LoadPendingContents()
		  
		  Var Sets() As Dictionary
		  Sets.ResizeTo(Self.mItemSets.LastIndex)
		  For Idx As Integer = Self.mItemSets.FirstIndex To Self.mItemSets.LastIndex
		    Sets(Idx) = Self.mItemSets(Idx).Pack(ForAPI)
		  Next Idx
		  
		  Dict.Value("multipliers") = New Dictionary("min": Self.mMultipliers.Min, "max": Self.mMultipliers.Max)
		  Dict.Value("uiColor") = Self.mUIColor.ToHex
		  Dict.Value("iconId") = Self.mIconID
		  Dict.Value("sort") = Self.mSortValue
		  Dict.Value("experimental") = Self.mExperimental
		  Dict.Value("notes") = Self.mNotes
		  Dict.Value("requirements") = Beacon.GenerateJSON(Self.mRequirements, False)
		  Dict.Value("minItemSets") = Self.mMinItemSets
		  Dict.Value("maxItemSets") = Self.mMaxItemSets
		  Dict.Value("preventDuplicates") = Self.mPreventDuplicates
		  Dict.Value("itemSets") = Sets
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PreventDuplicates() As Boolean
		  Return Self.mPreventDuplicates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiredItemSetCount() As Integer
		  If Self.mRequirements.HasKey("minItemSets") Then
		    Return Max(Self.mRequirements.Value("minItemSets").IntegerValue, 1)
		  ElseIf Self.mRequirements.HasKey("min_item_sets") Then
		    Return Max(Self.mRequirements.Value("min_item_sets").IntegerValue, 1)
		  Else
		    Return 1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Requirements() As Dictionary
		  Return Self.mRequirements.Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Self.LoadPendingContents()
		  
		  Var Children() As Variant
		  For Each Set As Ark.LootItemSet In Self.mItemSets
		    Children.Add(Set.SaveData)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("lootDropId") = Self.mLootDropId
		  Keys.Value("minItemSets") = Self.mMinItemSets
		  Keys.Value("maxItemSets") = Self.mMaxItemSets
		  Keys.Value("preventDuplicates") = Self.mPreventDuplicates
		  Keys.Value("appendMode") = Self.mAppendMode
		  If Children.LastIndex > -1 Then
		    Keys.Value("itemSets") = Children
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As Ark.LootSimulatorSelection()
		  Var Selections() As Ark.LootSimulatorSelection
		  Var NumSets As Integer = Self.mItemSets.Count
		  If NumSets = 0 Then
		    Return Selections
		  End If
		  
		  Var MinSets As Integer = Min(Self.MinItemSets, Self.MaxItemSets)
		  Var MaxSets As Integer = Max(Self.MaxItemSets, Self.MinItemSets)
		  
		  // Assemble a pool first. Members of SelectedSets may be duplicates so that removing an entry for SelectedSets(0) will affect
		  // SelectedSets(1) if they point to the same object.
		  Var Pool() As Ark.MutableLootItemSet
		  Pool.ResizeTo(Self.mItemSets.LastIndex)
		  For Idx As Integer = 0 To Pool.LastIndex
		    Pool(Idx) = New Ark.MutableLootItemSet(Self.mItemSets(Idx))
		  Next
		  
		  Var SelectedSets() As Ark.MutableLootItemSet
		  If NumSets = MinSets And MinSets = MaxSets And Self.PreventDuplicates Then
		    // All
		    SelectedSets = Pool
		  Else
		    Const WeightScale = 100000
		    
		    Var RecomputeFigures As Boolean = True
		    Var ChooseSets As Integer = System.Random.InRange(MinSets, MaxSets)
		    Var WeightSum, Weights() As Double
		    Var WeightLookup As Dictionary
		    For I As Integer = 1 To ChooseSets
		      If Pool.Count = 0 Then
		        Exit For I
		      End If
		      
		      If RecomputeFigures Then
		        Ark.LootSimulatorSelection.ComputeSimulatorFigures(Pool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Var Decision As Double = System.Random.InRange(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Var SelectedSet As Ark.MutableLootItemSet
		        
		        For X As Integer = 0 To Weights.LastIndex
		          If Weights(X) >= Decision Then
		            Var SelectedWeight As Double = Weights(X)
		            SelectedSet = WeightLookup.Value(SelectedWeight)
		            Exit For X
		          End If
		        Next
		        
		        If SelectedSet Is Nil Then
		          Continue
		        End If
		        
		        SelectedSets.Add(SelectedSet)
		        If Self.PreventDuplicates Then
		          For X As Integer = 0 To Pool.LastIndex
		            If Pool(X) = SelectedSet Then
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
		  
		  Var LootSelections() As Ark.LootSimulatorSelection
		  For Each Set As Ark.MutableLootItemSet In SelectedSets
		    If Set.Count = 0 Then
		      Continue
		    End
		    
		    Var Entries() As Ark.LootItemSetEntry = Set.Simulate
		    For Each Entry As Ark.LootItemSetEntry In Entries
		      If Set.ItemsRandomWithoutReplacement Then
		        Set.Remove(Entry)
		      End If
		      
		      Var EntryLootSelections() As Ark.LootSimulatorSelection = Entry.Simulate()
		      For Each EntryLootSelection As Ark.LootSimulatorSelection In EntryLootSelections
		        LootSelections.Add(EntryLootSelection)
		      Next
		    Next
		  Next
		  Return LootSelections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SortValue() As Integer
		  Return Self.mSortValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  // Part of the Ark.Blueprint interface.
		  
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastIndex)
		  For I As Integer = 0 To Self.mTags.LastIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIColor() As Color
		  Return Self.mUIColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  Self.LoadPendingContents()
		  
		  For Each Set As Ark.LootItemSet In Self.mItemSets
		    Set.Validate(Location + Beacon.Issue.Separator + Self.ClassString, Issues, Project)
		  Next Set
		  
		  If Self.Count < Self.RequiredItemSetCount Then
		    Issues.Add(New Beacon.Issue(Location + Beacon.Issue.Separator + Self.ClassString, "Loot drop '" + Self.Label + "' requires at least " + Self.RequiredItemSetCount.ToString(Locale.Current, "0") + " item sets."))
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAlternateLabel As NullableString
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAppendMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mExperimental As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIconID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mItemSets() As Ark.LootItemSet
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLootDropId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMultipliers As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mNotes As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPendingContentsString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPreventDuplicates As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequirements As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSortValue As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUIColor As Color
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
