#tag Class
Protected Class Collection
Implements Countable
	#tag Method, Flags = &h0
		Sub Append(Item As Variant)
		  Self.mItems.Append(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Bound As Integer = -1)
		  Redim Self.mItems(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Items() As Variant)
		  Self.Constructor(Items.Ubound)
		  For I As Integer = 0 To Items.Ubound
		    Self.mItems(I) = Items(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Xojo.Core.Iterable)
		  Self.Constructor(-1)
		  For Each Item As Variant In Source
		    Self.mItems.Append(Item)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  Return New Beacon.CollectionIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Variant) As Integer
		  For I As Integer = 0 To Self.mItems.Ubound
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Variant)
		  Self.mItems.Insert(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mItems(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Variant
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Value As Variant)
		  Self.mItems(Index) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Self.mItems.Ubound
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mItems() As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
