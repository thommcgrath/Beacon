#tag Class
Protected Class LootDropOverride
Implements Beacon.Validateable,Iterable,Beacon.Countable,Beacon.NamedItem,Beacon.DisambiguationCandidate
	#tag Method, Flags = &h0
		Function AddToDefaults() As Boolean
		  Return Self.mAddToDefaults
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  If Self.mDropRef.IsResolved = False Then
		    Return Self.mAvailability
		  End If
		  
		  Return ArkSA.LootContainer(Self.mDropRef.Resolve()).Availability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageWeight() As Double
		  Var Sum As Double
		  For Each Set As ArkSA.LootItemSet In Self.mSets
		    Sum = Sum + Set.RawWeight
		  Next
		  Return Sum / Self.mSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DropRef As ArkSA.BlueprintReference)
		  Self.mDropRef = DropRef
		  Self.mMinItemSets = 1
		  Self.mMaxItemSets = 1
		  Self.mAddToDefaults = False
		  Self.mPreventDuplicates = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Drop As ArkSA.LootContainer, IncludeItemSets As Boolean)
		  Self.Constructor(New ArkSA.BlueprintReference(Drop))
		  Self.mAvailability = Drop.Availability
		  Self.mExperimental = Drop.Experimental
		  Self.mSortValue = Drop.SortValue
		  
		  If IncludeItemSets = False Then
		    Return
		  End If
		  
		  For Each ItemSet As ArkSA.LootItemSet In Drop
		    Self.mSets.Add(ItemSet.ImmutableClone)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.LootDropOverride)
		  Self.mDropRef = New ArkSA.BlueprintReference(Source.mDropRef)
		  Self.mMinItemSets = Source.mMinItemSets
		  Self.mMaxItemSets = Source.mMaxItemSets
		  Self.mAddToDefaults = Source.mAddToDefaults
		  Self.mPreventDuplicates = Source.mPreventDuplicates
		  Self.mAvailability = Source.mAvailability
		  Self.mExperimental = Source.mExperimental
		  Self.mSortValue = Source.mSortValue
		  
		  Self.mSets.ResizeTo(Source.mSets.LastIndex)
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    Self.mSets(Idx) = New ArkSA.LootItemSet(Source.mSets(Idx))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultWeight() As Double
		  If Self.mSets.Count = 0 Then
		    If Self.mAddToDefaults Then
		      Return 0.5
		    Else
		      Return 500
		    End If
		  Else
		    Return Self.AverageWeight
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationId() As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mDropRef.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.Availability
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
		  If Self.mDropRef.IsResolved = False Then
		    Return Self.mExperimental
		  End If
		  
		  Return ArkSA.LootContainer(Self.mDropRef.Resolve()).Experimental
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromLegacy(SaveData As Dictionary) As ArkSA.LootDropOverride
		  Try
		    Var LootDropRef As ArkSA.BlueprintReference
		    If SaveData.HasKey("Reference") Then
		      LootDropRef = ArkSA.BlueprintReference.FromSaveData(SaveData.Value("Reference"))
		    ElseIf SaveData.HasKey("lootDropId") Then
		      LootDropRef = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindLootContainer, SaveData.Value("lootDropId").StringValue, "", "", "", "", "")
		    ElseIf SaveData.HasKey("SupplyCrateClassString") Then
		      LootDropRef = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindLootContainer, "", "", SaveData.Lookup("SupplyCrateClassString", "").StringValue, "", "", "")
		    End If
		    If LootDropRef Is Nil Then
		      Return Nil
		    End If
		    
		    Var Override As New ArkSA.LootDropOverride(LootDropRef)
		    Override.mPreventDuplicates = SaveData.FirstValue("preventDuplicates", "PreventDuplicates", "bSetsRandomWithoutReplacement", Override.PreventDuplicates)
		    Override.mAddToDefaults = SaveData.FirstValue("appendMode", "AppendMode", "bAppendMode", Override.AddToDefaults)
		    Override.mMinItemSets = SaveData.FirstValue("minItemSets", "MinItemSets", Override.MinItemSets)
		    Override.mMaxItemSets = SaveData.FirstValue("maxItemSets", "MaxItemSets", Override.MaxItemSets)
		    
		    Var SetSaveData() As Variant = SaveData.FirstValue("itemSets", "ItemSets", Nil)
		    If (SetSaveData Is Nil) = False Then
		      For Each SetDict As Dictionary In SetSaveData
		        Var Set As ArkSA.LootItemSet = ArkSA.LootItemSet.FromSaveData(SetDict)
		        If Set <> Nil Then
		          Override.mSets.Add(Set)
		        End If
		      Next
		    End If
		    If Override.Count = 0 Then
		      Return Nil
		    End If
		    
		    Override.Modified = False
		    Return Override
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As ArkSA.LootDropOverride
		  If SaveData.HasAllKeys("definition", "minItemSets", "maxItemSets", "addToDefaults", "preventDuplicates", "sets") = False Then
		    Return Nil
		  End If
		  
		  Var Definition As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(SaveData.Value("definition"))
		  Var Override As New ArkSA.LootDropOverride(Definition)
		  Override.mMinItemSets = SaveData.Value("minItemSets").IntegerValue
		  Override.mMaxItemSets = SaveData.Value("maxItemSets").IntegerValue
		  Override.mAddToDefaults = SaveData.Value("addToDefaults").BooleanValue
		  Override.mPreventDuplicates = SaveData.Value("preventDuplicates").BooleanValue
		  Override.mAvailability = SaveData.Value("availability").UInt64Value
		  Override.mExperimental = SaveData.Value("experimental").BooleanValue
		  Override.mSortValue = SaveData.Value("sortOrder").IntegerValue
		  
		  Var SetDicts() As Variant = SaveData.Value("sets")
		  For Each SetDict As Dictionary In SetDicts
		    Var ItemSet As ArkSA.LootItemSet = ArkSA.LootItemSet.FromSaveData(SetDict)
		    If (ItemSet Is Nil) = False Then
		      Override.mSets.Add(ItemSet)
		    End If
		  Next
		  If Override.Count = 0 Then
		    Return Nil
		  End If
		  
		  Return Override
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Return EncodeBase64MBS(Beacon.GenerateJSON(Self.SaveData, False))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As ArkSA.LootDropOverride
		  Return New ArkSA.LootDropOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.LootDropOverride
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Dictionary, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.LootDropOverride
		  Var ClassString As String
		  If Dict.HasKey("SupplyCrateClassString") Then
		    ClassString = Dict.Value("SupplyCrateClassString")
		  End If
		  
		  Var Containers() As ArkSA.LootContainer = ArkSA.DataSource.Pool.Get(False).GetLootContainersByClass(ClassString, ContentPacks)
		  Var Container As ArkSA.LootContainer
		  If Containers.Count > 0 Then
		    Container = Containers(0)
		  Else
		    Var Path As String = ArkSA.UnknownBlueprintPath("LootContainers", ClassString)
		    Var UUID As String = Beacon.UUID.v5(ArkSA.UserContentPackId.Lowercase + ":" + Path.Lowercase)
		    Var UIColor As String = Dict.Lookup("UIColor", "FFFFFF00")
		    
		    Var Mutable As New ArkSA.MutableLootContainer(Path, UUID)
		    Mutable.Multipliers = New Beacon.Range(Dict.Lookup("Multiplier_Min", 1), Dict.Lookup("Multiplier_Max", 1))
		    Mutable.Availability = ArkSA.Maps.UniversalMask
		    Mutable.UIColor = Color.RGB(Integer.FromHex(UIColor.Middle(0, 2)), Integer.FromHex(UIColor.Middle(2, 2)), Integer.FromHex(UIColor.Middle(4, 2)), Integer.FromHex(UIColor.Middle(6, 2)))
		    Mutable.SortValue = Dict.Lookup("SortValue", 999).IntegerValue
		    Mutable.Label = Dict.Lookup("Label", ClassString).StringValue
		    Mutable.RequiredItemSetCount = Dict.Lookup("RequiredItemSets", 1).IntegerValue
		    Mutable.Experimental = Dict.Lookup("Experimental", False).BooleanValue
		    Mutable.Notes = Dict.Lookup("Notes", "").StringValue
		    Mutable.ContentPackId = ArkSA.UserContentPackId
		    Container = Mutable
		  End If
		  
		  Var Override As New ArkSA.MutableLootDropOverride(Container, False)
		  
		  Var Children() As Dictionary
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets").DictionaryArrayValue
		  End If
		  Var AddedHashes As New Dictionary
		  For Each Child As Dictionary In Children
		    Var Set As ArkSA.LootItemSet = ArkSA.LootItemSet.ImportFromConfig(Child, Container.Multipliers, Difficulty, ContentPacks)
		    Var Hash As String = Set.Hash
		    If (Set Is Nil) = False And AddedHashes.HasKey(Hash) = False Then
		      Override.Add(Set)
		      AddedHashes.Value(Hash) = True
		    End If
		  Next
		  
		  If Dict.HasKey("MaxItemSets") Then
		    Override.MaxItemSets = Dict.Value("MaxItemSets")
		  End If
		  If Dict.HasKey("MinItemSets") Then
		    Override.MinItemSets = Dict.Value("MinItemSets")
		  End If
		  If Dict.HasKey("bSetsRandomWithoutReplacement") Then
		    Override.PreventDuplicates = Dict.Value("bSetsRandomWithoutReplacement")
		  End If
		  If Dict.HasKey("bAppendItemSets") Then
		    Override.AddToDefaults = Dict.Value("bAppendItemSets")
		  End If
		  
		  Override.Modified = False
		  Return Override.ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As ArkSA.LootItemSet) As Integer
		  If Set Is Nil Then
		    Return -1
		  End If
		  
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    If Self.mSets(Idx).UUID = Set.UUID Then
		      Return Idx
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Sets() As Variant
		  Sets.ResizeTo(Self.mSets.LastIndex)
		  For Idx As Integer = 0 To Sets.LastIndex
		    Sets(Idx) = Self.mSets(Idx)
		  Next
		  Return New Beacon.GenericIterator(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Var Label As String = Self.mDropRef.Label
		  If Label.IsEmpty Then
		    Var Drop As ArkSA.Blueprint = Self.mDropRef.Resolve()
		    If (Drop Is Nil) = False Then
		      Label = Drop.Label
		    End If
		  End If
		  Return Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootDrop(Pack As Beacon.StringList = Nil, Options As Integer = 3) As ArkSA.LootContainer
		  Var Blueprint As ArkSA.Blueprint = Self.mDropRef.Resolve(Pack, Options)
		  If Blueprint Is Nil Or (Blueprint IsA ArkSA.LootContainer) = False Then
		    Return Nil
		  End If
		  
		  Return ArkSA.LootContainer(Blueprint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootDropId() As String
		  Return Self.mDropRef.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootDropReference() As ArkSA.BlueprintReference
		  Return Self.mDropRef
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
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Set As ArkSA.LootItemSet In Self.mSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Value = False Then
		    For Each Set As ArkSA.LootItemSet In Self.mSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As ArkSA.MutableLootDropOverride
		  Return New ArkSA.MutableLootDropOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableLootDropOverride
		  Return New ArkSA.MutableLootDropOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PreventDuplicates() As Boolean
		  Return Self.mPreventDuplicates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Sets() As Dictionary
		  For Each Set As ArkSA.LootItemSet In Self.mSets
		    Sets.Add(Set.SaveData)
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("definition") = Self.mDropRef.SaveData
		  Dict.Value("minItemSets") = Self.mMinItemSets
		  Dict.Value("maxItemSets") = Self.mMaxItemSets
		  Dict.Value("addToDefaults") = Self.mAddToDefaults
		  Dict.Value("preventDuplicates") = Self.mPreventDuplicates
		  Dict.Value("sets") = Sets
		  If Self.mDropRef.IsResolved Then
		    Var Blueprint As ArkSA.Blueprint = Self.mDropRef.Resolve() // Parameters don't matter because it's already been resolved
		    Var Container As ArkSA.LootContainer = ArkSA.LootContainer(Blueprint)
		    Dict.Value("availability") = Container.Availability
		    Dict.Value("experimental") = Container.Experimental
		    Dict.Value("sortOrder") = Container.SortValue
		  Else
		    Dict.Value("availability") = Self.mAvailability
		    Dict.Value("experimental") = Self.mExperimental
		    Dict.Value("sortOrder") = Self.mSortValue
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAt(Idx As Integer) As ArkSA.LootItemSet
		  If Idx = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mSets(Idx).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate() As ArkSA.LootSimulatorSelection()
		  Var Selections() As ArkSA.LootSimulatorSelection
		  Var NumSets As Integer = Self.mSets.Count
		  If NumSets = 0 Then
		    Return Selections
		  End If
		  
		  Var MinSets As Integer = Min(Self.mMinItemSets, Self.mMaxItemSets)
		  Var MaxSets As Integer = Max(Self.mMaxItemSets, Self.mMinItemSets)
		  
		  // Assemble a pool first. Members of SelectedSets may be duplicates so that removing an entry for SelectedSets(0) will affect
		  // SelectedSets(1) if they point to the same object.
		  Var Pool() As ArkSA.MutableLootItemSet
		  Pool.ResizeTo(Self.mSets.LastIndex)
		  For Idx As Integer = 0 To Pool.LastIndex
		    Pool(Idx) = New ArkSA.MutableLootItemSet(Self.mSets(Idx))
		  Next
		  
		  Var SelectedSets() As ArkSA.MutableLootItemSet
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
		        ArkSA.LootSimulatorSelection.ComputeSimulatorFigures(Pool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Var Decision As Double = System.Random.InRange(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Var SelectedSet As ArkSA.MutableLootItemSet
		        
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
		  
		  Var LootSelections() As ArkSA.LootSimulatorSelection
		  For Each Set As ArkSA.MutableLootItemSet In SelectedSets
		    If Set.Count = 0 Then
		      Continue
		    End
		    
		    Var Entries() As ArkSA.LootItemSetEntry = Set.Simulate
		    For Each Entry As ArkSA.LootItemSetEntry In Entries
		      If Set.ItemsRandomWithoutReplacement Then
		        Set.Remove(Entry)
		      End If
		      
		      Var EntryLootSelections() As ArkSA.LootSimulatorSelection = Entry.Simulate()
		      For Each EntryLootSelection As ArkSA.LootSimulatorSelection In EntryLootSelections
		        LootSelections.Add(EntryLootSelection)
		      Next
		    Next
		  Next
		  Return LootSelections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SortValue() As Integer
		  If Self.mDropRef.IsResolved = False Then
		    Return Self.mSortValue
		  End If
		  
		  Return ArkSA.LootContainer(Self.mDropRef.Resolve()).SortValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeight() As Double
		  Var Sum As Double
		  For Each Set As ArkSA.LootItemSet In Self.mSets
		    Sum = Sum + Set.RawWeight
		  Next
		  Return Sum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  For Each Set As ArkSA.LootItemSet In Self.mSets
		    Set.Validate(Location + Beacon.Issue.Separator + Self.mDropRef.ClassString, Issues, Project)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAddToDefaults As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDropRef As ArkSA.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExperimental As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPreventDuplicates As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSets() As ArkSA.LootItemSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSortValue As Integer
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
