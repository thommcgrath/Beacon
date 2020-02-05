#tag Class
Protected Class StringList
Implements Iterable
	#tag Method, Flags = &h0
		Sub Append(Item As String)
		  If Self.mItems.IndexOf(Item) = -1 Then
		    Self.mItems.AddRow(Item)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.StringList)
		  Self.mItems.ResizeTo(Source.mItems.LastRowIndex)
		  For I As Integer = 0 To Source.mItems.LastRowIndex
		    Self.mItems(I) = Source.mItems(I)
		  Next
		  Self.Modified = Source.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Bound As Integer = -1)
		  Self.mItems.ResizeTo(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mItems.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromVariant(Source As Variant) As Beacon.StringList
		  Var SourceArray() As Variant
		  Try
		    SourceArray = Source
		  Catch Err As TypeMismatchException
		    Return Nil
		  End Try
		  
		  Var List As New Beacon.StringList
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
		    Self.mItems.AddRowAt(Index, Item)
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
		  Return Self.mItems.Join(Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mItems.LastRowIndex
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
		  Var CompareLeft As String = Self.mItems.Join("|")
		  Var CompareRight As String = Others.Join("|")
		  Return CompareLeft.Compare(CompareRight, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String()
		  Var Items() As String
		  Items.ResizeTo(Self.mItems.LastRowIndex)
		  For I As Integer = 0 To Self.mItems.LastRowIndex
		    Items(I) = Self.mItems(I)
		  Next
		  Return Items
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source() As String)
		  Self.mItems.ResizeTo(Source.LastRowIndex)
		  For I As Integer = 0 To Source.LastRowIndex
		    Self.mItems(I) = Source(I)
		  Next
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
		  Self.mItems.RemoveRowAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Item As String)
		  Var Idx As Integer = Self.mItems.IndexOf(Item)
		  If Idx > -1 Then
		    Self.mItems.RemoveRowAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewBound As Integer)
		  Self.mItems.ResizeTo(NewBound)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort()
		  Self.mItems.Sort
		  Self.Modified = True
		End Sub
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
