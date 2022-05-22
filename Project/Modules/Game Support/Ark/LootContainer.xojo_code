#tag Class
Protected Class LootContainer
Implements Ark.Blueprint,Beacon.Countable,Iterable,Beacon.Validateable
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
		  Self.mContentPackUUID = Source.mContentPackUUID
		  Self.mModified = Source.mModified
		  Self.mContentPackName = Source.mContentPackName
		  Self.mMultipliers = Source.mMultipliers
		  Self.mNotes = Source.mNotes
		  Self.mObjectID = Source.mObjectID
		  Self.mPath = Source.mPath
		  Self.mPreventDuplicates = Source.mPreventDuplicates
		  Self.mRequirements = If(Source.mRequirements Is Nil, Nil, Source.mRequirements.Clone)
		  Self.mSortValue = Source.mSortValue
		  Self.mIconID = Source.mIconID
		  Self.mUIColor = Source.mUIColor
		  
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
		Function ContentPackName() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackUUID() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mContentPackUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentsString(Pretty As Boolean = False) As String
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
		  
		  Return Self.mItemSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(ObjectID As String, Path As String, ClassString As String) As Ark.LootContainer
		  Var LootContainer As New Ark.LootContainer
		  LootContainer.mContentPackUUID = Ark.UserContentPackUUID
		  LootContainer.mContentPackName = Ark.UserContentPackName
		  
		  If ObjectID.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "BeaconLoot_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "BeaconLoot_" + ObjectID + "_C"
		    End If
		    Path = Ark.UnknownBlueprintPath("LootContainers", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = Beacon.ClassStringFromPath(Path)
		  End If
		  If ObjectID.IsEmpty Then
		    ObjectID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, LootContainer.mContentPackUUID + ":" + Path.Lowercase)
		  End If
		  
		  LootContainer.mClassString = ClassString
		  LootContainer.mPath = Path
		  LootContainer.mObjectID = ObjectID
		  LootContainer.mLabel = Beacon.LabelFromClassString(ClassString)
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
		Function Experimental() As Boolean
		  Return Self.mExperimental
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Ark.LootContainer
		  If SaveData Is Nil Then
		    Return Nil
		  End If
		  
		  Var LegacyMode As Boolean
		  Var PreventDuplicatesKey As String = "PreventDuplicates"
		  Var AppendModeKey As String = "AppendMode"
		  Var SourceContainer As Ark.LootContainer
		  If SaveData.HasKey("Reference") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(SaveData.Value("Reference"))
		    If Reference Is Nil Then
		      Return Nil
		    End If
		    SourceContainer = Ark.LootContainer(Reference.Resolve)
		  Else
		    SourceContainer = Ark.ResolveLootContainer(SaveData, "", "", "SupplyCrateClassString", Nil)
		    LegacyMode = True
		    PreventDuplicatesKey = "bSetsRandomWithoutReplacement"
		    AppendModeKey = "bAppendMode"
		  End If
		  
		  If SourceContainer Is Nil Then
		    Return Nil
		  End If
		  
		  Var Container As New Ark.MutableLootContainer(SourceContainer)
		  
		  Try
		    Container.MinItemSets = SaveData.Lookup("MinItemSets", 1).IntegerValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinItemSets value")
		  End Try
		  
		  Try
		    Container.MaxItemSets = SaveData.Lookup("MaxItemSets", 1).IntegerValue
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
		  
		  If SaveData.HasKey("ItemSets") Then
		    Try
		      Var SetDicts() As Variant = SaveData.Value("ItemSets")
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
		      Next Idx
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading ItemSets value")
		    End Try
		  End If
		  
		  If LegacyMode And Container.ContentPackUUID = Ark.UserContentPackUUID Then
		    // Load the extra data
		    Try
		      Container.Availability = SaveData.Lookup("Availability", Ark.Maps.UniversalMask).UInt64Value
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Container.Multipliers = New Beacon.Range(SaveData.Lookup("Multiplier_Min", 1.0).DoubleValue, SaveData.Lookup("Multiplier_Max", 1.0).DoubleValue)
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Container.SortValue = SaveData.Lookup("SortValue", 999).IntegerValue
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Container.Label = SaveData.Lookup("Label", Container.ClassString).StringValue
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Container.RequiredItemSetCount = SaveData.Lookup("RequiredItemSets", 1).IntegerValue
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Container.Experimental = SaveData.Lookup("Experimental", False).BooleanValue
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Container.Notes = SaveData.Lookup("Notes", "").StringValue
		    Catch Err As RuntimeException
		    End Try
		    
		    Try
		      Var UIColor As String = SaveData.Lookup("UIColor", "FFFFFF00")
		      Container.UIColor = Color.RGB(Integer.FromHex(UIColor.Middle(0, 2)), Integer.FromHex(UIColor.Middle(2, 2)), Integer.FromHex(UIColor.Middle(4, 2)), Integer.FromHex(UIColor.Middle(6, 2)))
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Container.Modified = True
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
		Shared Function ImportFromConfig(Dict As Dictionary, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.LootContainer
		  Var ClassString As String
		  If Dict.HasKey("SupplyCrateClassString") Then
		    ClassString = Dict.Value("SupplyCrateClassString")
		  End If
		  
		  Var Containers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainersByClass(ClassString, ContentPacks)
		  Var Container As Ark.MutableLootContainer
		  If Containers.Count > 0 Then
		    Container = New Ark.MutableLootContainer(Containers(0))
		  Else
		    Var UIColor As String = Dict.Lookup("UIColor", "FFFFFF00")
		    Container = New Ark.MutableLootContainer()
		    Container.Path = Ark.UnknownBlueprintPath("LootContainers", ClassString)
		    Container.Multipliers = New Beacon.Range(Dict.Lookup("Multiplier_Min", 1), Dict.Lookup("Multiplier_Max", 1))
		    Container.Availability = Ark.Maps.UniversalMask
		    Container.UIColor = Color.RGB(Integer.FromHex(UIColor.Middle(0, 2)), Integer.FromHex(UIColor.Middle(2, 2)), Integer.FromHex(UIColor.Middle(4, 2)), Integer.FromHex(UIColor.Middle(6, 2)))
		    Container.SortValue = Dict.Lookup("SortValue", 999).IntegerValue
		    Container.Label = Dict.Lookup("Label", ClassString).StringValue
		    Container.RequiredItemSetCount = Dict.Lookup("RequiredItemSets", 1).IntegerValue
		    Container.Experimental = Dict.Lookup("Experimental", False).BooleanValue
		    Container.Notes = Dict.Lookup("Notes", "").StringValue
		    Container.ContentPackUUID = Ark.UserContentPackUUID
		  End If
		  
		  Var Children() As Dictionary
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets").DictionaryArrayValue
		  End If
		  Var AddedHashes As New Dictionary
		  For Each Child As Dictionary In Children
		    Var Set As Ark.LootItemSet = Ark.LootItemSet.ImportFromConfig(Child, Container.Multipliers, Difficulty, ContentPacks)
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
		Function IndexOf(ItemSet As Ark.LootItemSet) As Integer
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
		    Self.mLabel = Beacon.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
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
		  
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Idx As Integer) As Ark.LootItemSet
		  Return Self.mItemSets(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  // Part of the Ark.Blueprint interface.
		  
		  Var Sets() As Dictionary
		  Sets.ResizeTo(Self.mItemSets.LastIndex)
		  For Idx As Integer = Self.mItemSets.FirstIndex To Self.mItemSets.LastIndex
		    Sets(Idx) = Self.mItemSets(Idx).Pack
		  Next Idx
		  
		  Dict.Value("multipliers") = New Dictionary("min": Self.mMultipliers.Min, "max": Self.mMultipliers.Max)
		  Dict.Value("ui_color") = Self.mUIColor.ToHex
		  Dict.Value("icon") = Self.mIconID
		  Dict.Value("sort") = Self.mSortValue
		  Dict.Value("experimental") = Self.mExperimental
		  Dict.Value("notes") = Self.mNotes
		  Dict.Value("requirements") = Beacon.GenerateJSON(Self.mRequirements, False)
		  Dict.Value("min_item_sets") = Self.mMinItemSets
		  Dict.Value("max_item_sets") = Self.mMaxItemSets
		  Dict.Value("prevent_duplicates") = Self.mPreventDuplicates
		  Dict.Value("contents") = Sets
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
		  If Self.mRequirements.HasKey("min_item_sets") Then
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
		  For Each Set As Ark.LootItemSet In Self.mItemSets
		    Children.Add(Set.SaveData)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("Reference") = Ark.BlueprintReference.CreateSaveData(Self)
		  Keys.Value("MinItemSets") = Self.mMinItemSets
		  Keys.Value("MaxItemSets") = Self.mMaxItemSets
		  Keys.Value("PreventDuplicates") = Self.mPreventDuplicates
		  Keys.Value("AppendMode") = Self.mAppendMode
		  If Children.LastIndex > -1 Then
		    Keys.Value("ItemSets") = Children
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
		  
		  Var SelectedSets() As Ark.LootItemSet
		  If NumSets = MinSets And MinSets = MaxSets And Self.PreventDuplicates Then
		    // All
		    For Each Set As Ark.LootItemSet In Self.mItemSets
		      SelectedSets.Add(Set)
		    Next
		  Else
		    Const WeightScale = 100000
		    Var ItemSetPool() As Ark.LootItemSet
		    For Each Set As Ark.LootItemSet In Self.mItemSets
		      ItemSetPool.Add(Set)
		    Next
		    
		    Var RecomputeFigures As Boolean = True
		    Var ChooseSets As Integer = System.Random.InRange(MinSets, MaxSets)
		    Var WeightSum, Weights() As Double
		    Var WeightLookup As Dictionary
		    For I As Integer = 1 To ChooseSets
		      If ItemSetPool.LastIndex = -1 Then
		        Exit For I
		      End If
		      
		      If RecomputeFigures Then
		        Ark.LootSimulatorSelection.ComputeSimulatorFigures(ItemSetPool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Var Decision As Double = System.Random.InRange(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Var SelectedSet As Ark.LootItemSet
		        
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
		          For X As Integer = 0 To ItemSetPool.LastIndex
		            If ItemSetPool(X) = SelectedSet Then
		              ItemSetPool.RemoveAt(X)
		              Exit For X
		            End If
		          Next
		          RecomputeFigures = True
		        End If
		        
		        Exit
		      Loop
		    Next
		  End If
		  
		  For Each Set As Ark.LootItemSet In SelectedSets
		    Var SetSelections() As Ark.LootSimulatorSelection = Set.Simulate
		    For Each Selection As Ark.LootSimulatorSelection In SetSelections
		      Selections.Add(Selection)
		    Next
		  Next
		  Return Selections
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
		  
		  For Each Set As Ark.LootItemSet In Self.mItemSets
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
		Protected mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackUUID As String
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
		Protected mObjectID As String
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
