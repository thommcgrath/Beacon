#tag Class
Protected Class LootContainer
Implements Ark.Blueprint,Beacon.Countable, Iterable
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
		Function Clone() As Ark.Blueprint
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.LootContainer(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  
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
		  Self.mModID = Source.mModID
		  Self.mModified = Source.mModified
		  Self.mModName = Source.mModName
		  Self.mMultipliers = Source.mMultipliers
		  Self.mNotes = Source.mNotes
		  Self.mObjectID = Source.mObjectID
		  Self.mPath = Source.mPath
		  Self.mPreventDuplicates = Source.mPreventDuplicates
		  Self.mRequiredItemSetCount = Source.mRequiredItemSetCount
		  Self.mSortValue = Source.mSortValue
		  Self.mUIColor = Source.mUIColor
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Add(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(ObjectID As String, Path As String, ClassString As String) As Ark.LootContainer
		  Var LootContainer As New Ark.LootContainer
		  LootContainer.mModID = Beacon.UserModID
		  LootContainer.mModName = Beacon.UserModName
		  
		  If ObjectID.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "BeaconLoot_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "BeaconLoot_" + ObjectID + "_C"
		    End If
		    Path = Beacon.UnknownBlueprintPath("LootContainers", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = Beacon.ClassStringFromPath(Path)
		  End If
		  If ObjectID.IsEmpty Then
		    ObjectID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, LootContainer.mModID + ":" + Path.Lowercase)
		  End If
		  
		  LootContainer.mClassString = ClassString
		  LootContainer.mPath = Path
		  LootContainer.mObjectID = ObjectID
		  LootContainer.mLabel = Beacon.LabelFromClassString(ClassString)
		  Return LootContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Experimental() As Boolean
		  Return Self.mExperimental
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
		Function ModID() As String
		  // Part of the Ark.Blueprint interface.
		  
		  If Self.mModID Is Nil Then
		    Return ""
		  End If
		  
		  Return Self.mModID
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
		Function ModName() As String
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mModName
		End Function
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
		  Return Self.mRequiredItemSetCount
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
		Protected mExperimental As Boolean
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

	#tag Property, Flags = &h1
		Protected mModID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMultipliers As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mNotes As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPreventDuplicates As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequiredItemSetCount As Integer
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
