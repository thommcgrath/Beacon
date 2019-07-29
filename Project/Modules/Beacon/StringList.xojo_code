#tag Class
Protected Class StringList
Implements  Iterable
	#tag Method, Flags = &h0
		Sub Append(Item As String)
		  If Self.mItems.IndexOf(Item) = -1 Then
		    Self.mItems.Append(Item)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.StringList)
		  Redim Self.mItems(Source.mItems.Ubound)
		  For I As Integer = 0 To Source.mItems.Ubound
		    Self.mItems(I) = Source.mItems(I)
		  Next
		  Self.Modified = Source.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Bound As Integer = -1)
		  Redim Self.mItems(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mItems.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromVariant(Source As Variant) As Beacon.StringList
		  Dim SourceArray() As Variant
		  Try
		    SourceArray = Source
		  Catch Err As TypeMismatchException
		    Return Nil
		  End Try
		  
		  Dim List As New Beacon.StringList
		  For Each Item As Variant In SourceArray
		    Try
		      List.Append(Item)
		    Catch Err As TypeMismatchException
		      Continue
		    End Try
		  Next
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As String) As Integer
		  Return Self.mItems.IndexOf(Item)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As String)
		  If Self.mItems.IndexOf(Item) = -1 Then
		    Self.mItems.Insert(Index, Item)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Index As Integer) As String
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Item(Index As Integer, Assigns Value As String)
		  If Self.mItems.IndexOf(Value) = -1 Then
		    Self.mItems(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Return New Beacon.StringArrayIterator(Self.mItems)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(Delimiter As String) As String
		  Return Join(Self.mItems, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.StringList) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.Operator_Compare(Other.mItems)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Others() As String) As Integer
		  Dim CompareLeft As String = Join(Self.mItems, "|")
		  Dim CompareRight As String = Join(Others, "|")
		  Return CompareLeft.Compare(CompareRight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String()
		  Dim Items() As String
		  Redim Items(Self.mItems.Ubound)
		  For I As Integer = 0 To Self.mItems.Ubound
		    Items(I) = Self.mItems(I)
		  Next
		  Return Items
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source() As String)
		  Redim Self.mItems(Source.Ubound)
		  For I As Integer = 0 To Source.Ubound
		    Self.mItems(I) = Source(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(NewBound As Integer)
		  Redim Self.mItems(NewBound)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As String
		  Return Self.Item(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As String)
		  Self.Item(Index) = Item
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Item As String)
		  Dim Idx As Integer = Self.mItems.IndexOf(Item)
		  If Idx > -1 Then
		    Self.mItems.Remove(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort()
		  Self.mItems.Sort
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ubound() As Integer
		  Return Self.mItems.Ubound
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mItems() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Modified As Boolean
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
		#tag ViewProperty
			Name="Modified"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
