#tag Module
Protected Module PopupMenuExtensions
	#tag Method, Flags = &h0
		Sub AddRow(Extends Menu As DesktopPopupMenu, Text As String, Tag As Variant)
		  Menu.AddRow(Text)
		  Menu.RowTagAt(Menu.RowCount - 1) = Tag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRowAt(Extends Menu As DesktopPopupMenu, Row As Integer, Text As String, Tag As Variant)
		  Menu.AddRowAt(Row, Text)
		  Menu.RowTagAt(Row) = Tag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectByCaption(Extends Menu As DesktopPopupMenu, Caption As String)
		  For I As Integer = 0 To Menu.RowCount - 1
		    If Menu.RowValueAt(I) = Caption Then
		      Menu.SelectedRowIndex = I
		      Return
		    End If
		  Next
		  Menu.SelectedRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectByTag(Extends Menu As DesktopPopupMenu, Tag As Variant)
		  For I As Integer = 0 To Menu.RowCount - 1
		    If Menu.RowTagAt(I) = Tag Then
		      Menu.SelectedRowIndex = I
		      Return
		    End If
		  Next
		  Menu.SelectedRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tag(Extends Menu As DesktopPopupMenu) As Variant
		  If Menu.SelectedRowIndex > -1 Then
		    Return Menu.RowTagAt(Menu.SelectedRowIndex)
		  End If
		End Function
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
End Module
#tag EndModule
