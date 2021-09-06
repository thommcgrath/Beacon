#tag Class
Protected Class LootContainer
Implements Ark.Blueprint, Beacon.Countable
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
		  Self.mMinimumItemSetCount = Source.mMinimumItemSetCount
		  Self.mMinItemSets = Source.mMinItemSets
		  Self.mModID = Source.mModID
		  Self.mModified = Source.mModified
		  Self.mModName = Source.mModName
		  Self.mMultipliers = Source.mMultipliers
		  Self.mNotes = Source.mNotes
		  Self.mObjectID = Source.mObjectID
		  Self.mPath = Source.mPath
		  Self.mPreventDuplicates = Source.mPreventDuplicates
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
		Function IsTagged(Tag As String) As Boolean
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  
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
		Function MinimumItemSetCount() As Integer
		  Return Self.MinimumItemSetCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinItemSets() As Integer
		  Return Self.mMinimumItemSetCount
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
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinimumItemSetCount As Integer
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
