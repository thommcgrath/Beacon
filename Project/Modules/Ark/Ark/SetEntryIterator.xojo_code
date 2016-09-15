#tag Class
Protected Class SetEntryIterator
Implements xojo.Core.Iterator
	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.SetEntry)
		  Redim Self.mItems(UBound(Source))
		  For I As Integer = 0 To UBound(Self.mItems)
		    Self.mItems(I) = Source(I)
		  Next
		  Self.mIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  // Part of the xojo.Core.Iterator interface.
		  
		  Self.mIndex = Self.mIndex + 1
		  Return Self.mIndex <= UBound(Self.mItems)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Auto
		  // Part of the xojo.Core.Iterator interface.
		  
		  Return Self.mItems(Self.mIndex)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As Ark.ItemClass
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
