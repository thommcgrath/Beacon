#tag Class
Protected Class MutableLootContainer
Inherits ArkSA.LootContainer
Implements ArkSA.MutableBlueprint,ArkSA.Prunable
	#tag Method, Flags = &h0
		Sub Add(ItemSet As ArkSA.LootItemSet)
		  Self.LoadPendingContents()
		  
		  Var Idx As Integer = Self.IndexOf(ItemSet)
		  If Idx = -1 Then
		    Var CurrentNames() As String
		    For Each Set As ArkSA.LootItemSet In Self.mItemSets
		      CurrentNames.Add(Set.Label)
		    Next Set
		    
		    Var Label As String = Beacon.FindUniqueLabel(ItemSet.Label, CurrentNames)
		    If Label <> ItemSet.Label Then
		      Var Mutable As New ArkSA.MutableLootItemSet(ItemSet)
		      Mutable.Label = Label
		      ItemSet = Mutable
		    End If
		    
		    Self.mItemSets.Add(ItemSet.ImmutableVersion)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mAlternateLabel = Value Then
		    Return
		  End If
		  
		  Self.mAlternateLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendMode(Assigns Value As Boolean)
		  If Self.mAppendMode = Value Then
		    Return
		  End If
		  
		  Self.mAppendMode = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mAvailability = Value Then
		    Return
		  End If
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintId(Assigns Value As String)
		  If Self.mLootDropId = Value Then
		    Return
		  End If
		  
		  Self.mLootDropId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ArkSA.MutableLootContainer
		  Return New ArkSA.MutableLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Making it public
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, LootDropId As String)
		  Self.mLootDropId = LootDropId
		  Self.mPath = Path
		  Self.mClassString = ArkSA.ClassStringFromPath(Path)
		  Self.mAvailability = ArkSA.Maps.UniversalMask
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackId(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mContentPackId = Value Then
		    Return
		  End If
		  
		  Self.mContentPackId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackName(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mContentPackName = Value Then
		    Return
		  End If
		  
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentsString(Assigns JSON As String)
		  Self.mPendingContentsString = JSON
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Override As ArkSA.LootDropOverride)
		  Self.mMinItemSets = Override.MinItemSets
		  Self.mMaxItemSets = Override.MaxItemSets
		  Self.mAppendMode = Override.AddToDefaults
		  Self.mPreventDuplicates = Override.PreventDuplicates
		  Self.mItemSets.ResizeTo(-1)
		  
		  Var SetBound As Integer = Override.Count - 1
		  For Idx As Integer = 0 To SetBound
		    Var Set As ArkSA.LootItemSet = Override.SetAt(Idx)
		    If (Set Is Nil) = False Then
		      Self.mItemSets.Add(Set.ImmutableVersion)
		    End If
		  Next
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Experimental(Assigns Value As Boolean)
		  If Self.mExperimental = Value Then
		    Return
		  End If
		  
		  Self.mExperimental = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IconID(Assigns Value As String)
		  If Self.mIconId = Value Then
		    Return
		  End If
		  
		  Self.mIconID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.LootContainer
		  Return New ArkSA.LootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Tag = Beacon.NormalizeTag(Tag)
		  Var Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.RemoveAt(Idx)
		    Self.Modified = True
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.Add(Tag)
		    Self.mTags.Sort()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mLabel = Value Then
		    Return
		  End If
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastUpdate(Assigns Value As Double)
		  If Self.mLastUpdate = Value Then
		    Return
		  End If
		  
		  Self.mLastUpdate = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LootDropId(Assigns Value As String)
		  If Self.mLootDropId = Value Then
		    Return
		  End If
		  
		  Self.mLootDropId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItemSets(Assigns Value As Integer)
		  Value = Max(Value, 0)
		  
		  If Self.mMaxItemSets = Value Then
		    Return
		  End If
		  
		  Self.mMaxItemSets = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItemSets(Assigns Value As Integer)
		  Value = Max(Value, 0)
		  
		  If Self.mMinItemSets = Value Then
		    Return
		  End If
		  
		  Self.mMinItemSets = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Multipliers(Assigns Value As Beacon.Range)
		  Self.mMultipliers = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableLootContainer
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Notes(Assigns Value As String)
		  If Self.mNotes = Value Then
		    Return
		  End If
		  
		  Self.mNotes = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Idx As Integer, Assigns ItemSet As ArkSA.LootItemSet)
		  Self.LoadPendingContents()
		  Self.mItemSets(Idx) = ItemSet.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Self.mPath = Value Then
		    Return
		  End If
		  
		  Self.mPath = Value
		  Self.mClassString = ArkSA.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventDuplicates(Assigns Value As Boolean)
		  If Self.mPreventDuplicates = Value Then
		    Return
		  End If
		  
		  Self.mPreventDuplicates = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  // Part of the ArkSA.Prunable interface.
		  
		  Self.LoadPendingContents()
		  For Idx As Integer = Self.mItemSets.LastIndex DownTo 0
		    Var Mutable As ArkSA.MutableLootItemSet = Self.mItemSets(Idx).MutableVersion
		    Mutable.PruneUnknownContent(ContentPackIds)
		    If Mutable.Count = 0 Then
		      Self.mItemSets.RemoveAt(Idx)
		      Self.Modified = True
		    ElseIf Mutable.Hash <> Self.mItemSets(Idx).Hash Then
		      Self.mItemSets(Idx) = Mutable.ImmutableVersion
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RebuildItemSets(Mask As UInt64, ContentPacks As Beacon.StringList) As Integer
		  Self.LoadPendingContents()
		  Var NumChanged As Integer
		  For Idx As Integer = 0 To Self.mItemSets.LastIndex
		    If Self.mItemSets(Idx).TemplateUUID.IsEmpty Then
		      Continue
		    End If
		    
		    Var Template As ArkSA.LootTemplate = ArkSA.DataSource.Pool.Get(False).GetLootTemplateByUUID(Self.mItemSets(Idx).TemplateUUID)
		    If Template Is Nil Then
		      Continue
		    End If
		    
		    Var Mutable As ArkSA.MutableLootItemSet = Self.mItemSets(Idx).MutableVersion
		    If Template.RebuildLootItemSet(Mutable, Mask, Self, ContentPacks) = False Then
		      Continue
		    End If
		    
		    NumChanged = NumChanged + 1
		    Self.mItemSets(Idx) = Mutable.ImmutableVersion
		    Self.Modified = True
		  Next
		  Return NumChanged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ItemSet As ArkSA.LootItemSet)
		  Var Idx As Integer = Self.IndexOf(ItemSet)
		  If Idx > -1 Then
		    Self.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  Self.LoadPendingContents()
		  Self.mItemSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredItemSetCount(Assigns Value As Integer)
		  If Value <= 1 Then
		    If Self.mRequirements.HasKey("min_item_sets") Then
		      Self.mRequirements.Remove("min_item_sets")
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  Self.mRequirements.Value("min_item_sets") = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Requirements(Assigns Dict As Dictionary)
		  If Dict Is Nil Then
		    If Self.mRequirements.KeyCount >= 0 Then
		      Self.mRequirements = New Dictionary
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If Beacon.Hash(Beacon.GenerateJSON(Dict, False)) <> Beacon.Hash(Beacon.GenerateJSON(Self.mRequirements, False)) Then
		    Self.mRequirements = Dict.Clone
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortValue(Assigns Value As Integer)
		  If Self.mSortValue = Value Then
		    Return
		  End If
		  
		  Self.mSortValue = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.Add(Tag)
		  Next
		  Self.mTags.Sort
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UIColor(Assigns Value As Color)
		  Self.mUIColor = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unpack(Dict As Dictionary)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  If Dict.HasKey("multipliers") Then
		    Var Multipliers As Dictionary = Dict.Value("multipliers")
		    Var MultiplierMin As Double = Multipliers.Value("min")
		    Var MultiplierMax As Double = Multipliers.Value("max")
		    Self.mMultipliers = New Beacon.Range(MultiplierMin, MultiplierMax)
		  End If
		  
		  Var UIColorKey As Variant = Dict.FirstKey("uiColor", "ui_color")
		  If UIColorKey.IsNull = False Then
		    Self.mUIColor = Dict.Value(UIColorKey).StringValue.ToColor
		  End If
		  
		  Var IconIdKey As Variant = Dict.FirstKey("iconId", "icon")
		  If IconIdKey.IsNull = False Then
		    Self.mIconID = Dict.Value(IconIdKey).StringValue
		  End If
		  
		  Var SortKey As Variant = Dict.FirstKey("sortOrder", "sort")
		  If SortKey.IsNull = False Then
		    Self.mSortValue = If(Dict.Value(SortKey).IsNull, 9999, Dict.Value(SortKey).IntegerValue)
		  End If
		  
		  If Dict.HasKey("experimental") Then
		    Self.mExperimental = Dict.Value("experimental").BooleanValue
		  End If
		  
		  If Dict.HasKey("notes") Then
		    Self.mNotes = Dict.Value("notes").StringValue
		  End If
		  
		  If Dict.HasKey("requirements") Then
		    Try
		      Var Requirements As Dictionary = Beacon.ParseJSON(Dict.Value("requirements").StringValue)
		      Self.mRequirements = Requirements
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Var MinItemSetsKey As Variant = Dict.FirstKey("minItemSets", "min_item_sets")
		  If MinItemSetsKey.IsNull = False Then
		    Self.mMinItemSets = Dict.Value(MinItemSetsKey).IntegerValue
		  End If
		  
		  Var MaxItemSetsKey As Variant = Dict.FirstKey("maxItemSets", "max_item_sets")
		  If MaxItemSetsKey.IsNull = False Then
		    Self.mMaxItemSets = Dict.Value(MaxItemSetsKey).IntegerValue
		  End If
		  
		  Var PreventDuplicatesKey As Variant = Dict.FirstKey("preventDuplicates", "prevent_duplicates")
		  If PreventDuplicatesKey.IsNull = False Then
		    Self.mPreventDuplicates = Dict.Value(PreventDuplicatesKey)
		  End If
		  
		  Var Sets() As Dictionary
		  If Dict.HasKey("itemSets") And Dict.Value("itemSets").IsNull = False Then
		    Try
		      Sets = Dict.Value("itemSets").DictionaryArrayValue
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Unpacking item sets")
		    End Try
		  ElseIf Dict.HasKey("contents") And Dict.Value("contents").IsNull = False Then
		    Try
		      Sets = Dict.Value("contents").DictionaryArrayValue
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Unpacking item sets")
		    End Try
		  End If
		  
		  Self.mItemSets.ResizeTo(-1)
		  For Each PackedSet As Dictionary In Sets
		    Var Set As ArkSA.LootItemSet = ArkSA.LootItemSet.FromSaveData(PackedSet)
		    If (Set Is Nil) = False Then
		      Self.mItemSets.Add(Set)
		    End If
		  Next
		  Self.mPendingContentsString = ""
		End Sub
	#tag EndMethod


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
