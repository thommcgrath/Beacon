#tag Module
Protected Module PopupMenuExtensions
	#tag Method, Flags = &h0
		Sub AddRow(Extends Menu As PopupMenu, Text As String, Tag As Variant)
		  Menu.AddRow(Text)
		  Menu.RowTag(Menu.RowCount - 1) = Tag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectByCaption(Extends Menu As PopupMenu, Caption As String)
		  For I As Integer = 0 To Menu.RowCount - 1
		    If Menu.List(I) = Caption Then
		      Menu.SelectedRowIndex = I
		      Return
		    End If
		  Next
		  Menu.SelectedRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectByTag(Extends Menu As PopupMenu, Tag As Variant)
		  For I As Integer = 0 To Menu.RowCount - 1
		    If Menu.RowTag(I) = Tag Then
		      Menu.SelectedRowIndex = I
		      Return
		    End If
		  Next
		  Menu.SelectedRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tag(Extends Menu As PopupMenu) As Variant
		  If Menu.SelectedRowIndex > -1 Then
		    Return Menu.RowTag(Menu.SelectedRowIndex)
		  End If
		End Function
	#tag EndMethod


End Module
#tag EndModule
