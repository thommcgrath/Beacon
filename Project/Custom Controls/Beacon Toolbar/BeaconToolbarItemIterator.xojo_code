#tag Class
Protected Class BeaconToolbarItemIterator
Implements Iterator
	#tag Method, Flags = &h0
		Sub Constructor(Source() As BeaconToolbarItem)
		  Redim Self.mItems(Source.LastRowIndex)
		  For I As Integer = 0 To Self.mItems.LastRowIndex
		    Self.mItems(I) = Source(I)
		  Next
		  Self.mIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the Iterator interface.
		  
		  Self.mIndex = Self.mIndex + 1
		  Return Self.mIndex <= Self.mItems.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Part of the Iterator interface.
		  
		  Return Self.mItems(Self.mIndex)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As BeaconToolbarItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
