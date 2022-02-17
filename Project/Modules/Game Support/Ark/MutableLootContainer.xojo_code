#tag Class
Protected Class MutableLootContainer
Inherits Ark.LootContainer
Implements Ark.MutableBlueprint
	#tag Method, Flags = &h0
		Sub Add(ItemSet As Ark.LootItemSet)
		  Var Idx As Integer = Self.IndexOf(ItemSet)
		  If Idx = -1 Then
		    Self.mItemSets.Add(ItemSet.ImmutableVersion)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mAlternateLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendMode(Assigns Value As Boolean)
		  Self.mAppendMode = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.MutableLootContainer
		  Return New Ark.MutableLootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mRequirements = New Dictionary
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, ObjectID As String)
		  Self.mObjectID = ObjectID
		  Self.mPath = Path
		  Self.mClassString = Beacon.ClassStringFromPath(Path)
		  Self.mRequirements = New Dictionary
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackName(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackUUID(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mContentPackUUID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentsString(Assigns JSON As String)
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(JSON)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Children() As Variant = Parsed
		  Self.mItemSets.ResizeTo(-1)
		  For Each SaveData As Dictionary In Children
		    Var Set As Ark.LootItemSet = Ark.LootItemSet.FromSaveData(SaveData)
		    If (Set Is Nil) = False Then
		      Self.mItemSets.Add(Set)
		    End If
		  Next
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Experimental(Assigns Value As Boolean)
		  Self.mExperimental = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IconID(Assigns Value As String)
		  Self.mIconID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootContainer
		  Return New Ark.LootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItemSets(Assigns Value As Integer)
		  Self.mMaxItemSets = Max(Value, 0)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItemSets(Assigns Value As Integer)
		  Self.mMinItemSets = Max(Value, 0)
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
		Function MutableVersion() As Ark.MutableLootContainer
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Notes(Assigns Value As String)
		  Self.mNotes = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Idx As Integer, Assigns ItemSet As Ark.LootItemSet)
		  Self.mItemSets(Idx) = ItemSet.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mPath = Value
		  Self.mClassString = Beacon.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventDuplicates(Assigns Value As Boolean)
		  Self.mPreventDuplicates = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RebuildItemSets(Mask As UInt64, ContentPacks As Beacon.StringList) As Integer
		  Var NumChanged As Integer
		  For Idx As Integer = 0 To Self.mItemSets.LastIndex
		    If Self.mItemSets(Idx).TemplateUUID.IsEmpty Then
		      Continue
		    End If
		    
		    Var Template As Ark.LootTemplate = Ark.DataSource.SharedInstance.GetLootTemplateByUUID(Self.mItemSets(Idx).TemplateUUID)
		    If Template Is Nil Then
		      Continue
		    End If
		    
		    Var Mutable As Ark.MutableLootItemSet = Self.mItemSets(Idx).MutableVersion
		    If Template.RebuildLootItemSet(Mutable, Self, ContentPacks) = False Then
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
		Sub Remove(ItemSet As Ark.LootItemSet)
		  Var Idx As Integer = Self.IndexOf(ItemSet)
		  If Idx > -1 Then
		    Self.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
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
		  Self.mSortValue = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		  // Part of the Ark.MutableBlueprint interface.
		  
		  If Dict.HasKey("multipliers") Then
		    Var Multipliers As Dictionary = Dict.Value("multipliers")
		    Var MultiplierMin As Double = Multipliers.Value("min")
		    Var MultiplierMax As Double = Multipliers.Value("max")
		    Self.mMultipliers = New Beacon.Range(MultiplierMin, MultiplierMax)
		  End If
		  
		  If Dict.HasKey("ui_color") Then
		    Self.mUIColor = Dict.Value("ui_color").StringValue.ToColor
		  End If
		  
		  If Dict.HasKey("icon") Then
		    Self.mIconID = Dict.Value("icon").StringValue
		  End If
		  
		  If Dict.HasKey("sort") Then
		    Self.mSortValue = If(Dict.Value("sort").IsNull, 9999, Dict.Value("sort").IntegerValue)
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
		  
		  If Dict.HasKey("min_item_sets") Then
		    Self.mMinItemSets = Dict.Value("min_item_sets").IntegerValue
		  End If
		  
		  If Dict.HasKey("max_item_sets") Then
		    Self.mMaxItemSets = Dict.Value("max_item_sets").IntegerValue
		  End If
		  
		  If Dict.HasKey("prevent_duplicates") Then
		    Self.mPreventDuplicates = Dict.Value("prevent_duplicates").BooleanValue
		  End If
		  
		  If Dict.HasKey("contents") And Dict.Value("contents").IsNull = False Then
		    Var Sets() As Dictionary
		    Try
		      Sets = Dict.Value("contents").DictionaryArrayValue
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Unpacking item sets")
		    End Try
		    For Each PackedSet As Dictionary In Sets
		      Var Set As Ark.LootItemSet = Ark.LootItemSet.FromSaveData(PackedSet)
		      If (Set Is Nil) = False Then
		        Self.mItemSets.Add(Set)
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
