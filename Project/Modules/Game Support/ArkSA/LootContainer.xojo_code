#tag Class
Protected Class LootContainer
Implements ArkSA.Blueprint,Beacon.Countable,Iterable,Beacon.Validateable,Beacon.DisambiguationCandidate
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  // Part of the ArkSA.Blueprint interface.
		  
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
		  // Part of the ArkSA.Blueprint interface.
		  
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
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return ArkSA.CategoryLootContainers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ArkSA.LootContainer
		  Return New ArkSA.LootContainer(Self)
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
		Sub Constructor(Source As ArkSA.LootContainer)
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
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentsString(Pretty As Boolean = False) As String
		  Var Objects() As Variant
		  For Each Set As ArkSA.LootItemSet In Self.mItemSets
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
		  
		  Return Self.mItemSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(BlueprintId As String, Path As String, ClassString As String) As ArkSA.LootContainer
		  Var LootContainer As New ArkSA.LootContainer
		  LootContainer.mContentPackId = ArkSA.UserContentPackId
		  LootContainer.mContentPackName = ArkSA.UserContentPackName
		  
		  If BlueprintId.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "BeaconLoot_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "BeaconLoot_" + BlueprintId + "_C"
		    End If
		    Path = ArkSA.UnknownBlueprintPath("LootContainers", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = ArkSA.ClassStringFromPath(Path)
		  End If
		  If BlueprintId.IsEmpty Then
		    BlueprintId = Beacon.UUID.v5(LootContainer.mContentPackId.Lowercase + ":" + Path.Lowercase)
		  End If
		  
		  LootContainer.mClassString = ClassString
		  LootContainer.mPath = Path
		  LootContainer.mLootDropId = BlueprintId
		  LootContainer.mLabel = ArkSA.LabelFromClassString(ClassString)
		  Return LootContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultItemSetWeight() As Double
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
		  
		  Return ArkSA.Maps.LabelForMask(Self.Availability And Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Experimental() As Boolean
		  Return Self.mExperimental
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As ArkSA.LootContainer
		  If SaveData Is Nil Then
		    Return Nil
		  End If
		  
		  Var PreventDuplicatesKey As String = "PreventDuplicates"
		  Var AppendModeKey As String = "AppendMode"
		  Var MinItemSetsKey As String = "MinItemSets"
		  Var MaxItemSetsKey As String = "MaxItemSets"
		  Var SourceContainer As ArkSA.LootContainer
		  If SaveData.HasKey("lootDropId") Then
		    PreventDuplicatesKey = "preventDuplicates"
		    AppendModeKey = "appendMode"
		    MinItemSetsKey = "minItemSets"
		    MaxItemSetsKey = "maxItemSets"
		    SourceContainer = ArkSA.ResolveLootContainer(SaveData.Value("lootDropId").StringValue, "", "", Nil, True)
		  ElseIf SaveData.HasKey("Reference") Then
		    Var Reference As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(SaveData.Value("Reference"))
		    If Reference Is Nil Then
		      Return Nil
		    End If
		    SourceContainer = ArkSA.LootContainer(Reference.Resolve)
		  Else
		    SourceContainer = ArkSA.ResolveLootContainer(SaveData, "", "", "SupplyCrateClassString", Nil, True)
		    PreventDuplicatesKey = "bSetsRandomWithoutReplacement"
		    AppendModeKey = "bAppendMode"
		  End If
		  
		  If SourceContainer Is Nil Then
		    Return Nil
		  End If
		  
		  Var Container As New ArkSA.MutableLootContainer(SourceContainer)
		  
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
		      
		      Var Set As ArkSA.LootItemSet = ArkSA.LootItemSet.FromSaveData(Dictionary(SetDict))
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
		Function ImmutableVersion() As ArkSA.LootContainer
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.LootContainer
		  Var ClassString As String
		  If Dict.HasKey("SupplyCrateClassString") Then
		    ClassString = Dict.Value("SupplyCrateClassString")
		  End If
		  
		  Var Containers() As ArkSA.LootContainer = ArkSA.DataSource.Pool.Get(False).GetLootContainersByClass(ClassString, ContentPacks)
		  Var Container As ArkSA.MutableLootContainer
		  If Containers.Count > 0 Then
		    Container = New ArkSA.MutableLootContainer(Containers(0))
		  Else
		    Var Path As String = ArkSA.UnknownBlueprintPath("LootContainers", ClassString)
		    Var UUID As String = Beacon.UUID.v5(ArkSA.UserContentPackId.Lowercase + ":" + Path.Lowercase)
		    Var UIColor As String = Dict.Lookup("UIColor", "FFFFFF00")
		    
		    Container = New ArkSA.MutableLootContainer(Path, UUID)
		    Container.Multipliers = New Beacon.Range(Dict.Lookup("Multiplier_Min", 1), Dict.Lookup("Multiplier_Max", 1))
		    Container.Availability = ArkSA.Maps.UniversalMask
		    Container.UIColor = Color.RGB(Integer.FromHex(UIColor.Middle(0, 2)), Integer.FromHex(UIColor.Middle(2, 2)), Integer.FromHex(UIColor.Middle(4, 2)), Integer.FromHex(UIColor.Middle(6, 2)))
		    Container.SortValue = Dict.Lookup("SortValue", 999).IntegerValue
		    Container.Label = Dict.Lookup("Label", ClassString).StringValue
		    Container.RequiredItemSetCount = Dict.Lookup("RequiredItemSets", 1).IntegerValue
		    Container.Experimental = Dict.Lookup("Experimental", False).BooleanValue
		    Container.Notes = Dict.Lookup("Notes", "").StringValue
		    Container.ContentPackId = ArkSA.UserContentPackId
		  End If
		  
		  Var Children() As Dictionary
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets").DictionaryArrayValue
		  End If
		  Var AddedHashes As New Dictionary
		  For Each Child As Dictionary In Children
		    Var Set As ArkSA.LootItemSet = ArkSA.LootItemSet.ImportFromConfig(Child, Container.Multipliers, Difficulty, ContentPacks)
		    Var Hash As String = Set.Hash
		    If (Set Is Nil) = False And AddedHashes.HasKey(Hash) = False Then
		      Call Container.Add(Set)
		      AddedHashes.Value(Hash) = True
		    End If
		  Next
		  
		  If Dict.HasKey("MaxItemSets") Then
		    Container.MaxItemSets = Dict.Value("MaxItemSets")
		  End If
		  If Dict.HasKey("MinItemSets") Then
		    Container.MinItemSets = Dict.Value("MinItemSets")
		  End If
		  If Dict.HasKey("bSetsRandomWithoutReplacement") Then
		    Container.PreventDuplicates = Dict.Value("bSetsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("bAppendItemSets") Then
		    Container.AppendMode = Dict.Value("bAppendItemSets")
		  End If
		  
		  Container.Modified = False
		  Return Container
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(ItemSet As ArkSA.LootItemSet) As Integer
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
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
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
		    Self.mLabel = ArkSA.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
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
		Function MutableClone() As ArkSA.MutableLootContainer
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.MutableLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableLootContainer
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.MutableLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Notes() As String
		  Return Self.mNotes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mLootDropId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Idx As Integer) As ArkSA.LootItemSet
		  Return Self.mItemSets(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  // Part of the ArkSA.Blueprint interface.
		  
		  Var Sets() As Dictionary
		  Sets.ResizeTo(Self.mItemSets.LastIndex)
		  For Idx As Integer = Self.mItemSets.FirstIndex To Self.mItemSets.LastIndex
		    Sets(Idx) = Self.mItemSets(Idx).Pack
		  Next Idx
		  
		  Dict.Value("multipliers") = New Dictionary("min": Self.mMultipliers.Min, "max": Self.mMultipliers.Max)
		  Dict.Value("uiColor") = Self.mUIColor.ToHex
		  Dict.Value("icon") = Self.mIconID
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
		  // Part of the ArkSA.Blueprint interface.
		  
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
		  Var Children() As Variant
		  For Each Set As ArkSA.LootItemSet In Self.mItemSets
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
		Function SortValue() As Integer
		  Return Self.mSortValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  // Part of the ArkSA.Blueprint interface.
		  
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
		  
		  For Each Set As ArkSA.LootItemSet In Self.mItemSets
		    Set.Validate(Location + "." + Self.ClassString, Issues, Project)
		  Next Set
		  
		  If Self.Count < Self.RequiredItemSetCount Then
		    Issues.Add(New Beacon.Issue(Location + "." + Self.ClassString, "Loot drop '" + Self.Label + "' requires at least " + Self.RequiredItemSetCount.ToString(Locale.Current, "0") + " item sets."))
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
		Protected mItemSets() As ArkSA.LootItemSet
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
