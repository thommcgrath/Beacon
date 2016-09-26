#tag Module
Protected Module PopupMenuExtensions
	#tag Method, Flags = &h0
		Sub AddRow(Extends Menu As PopupMenu, Text As String, Tag As Variant)
		  Menu.AddRow(Text)
		  Menu.RowTag(Menu.ListCount - 1) = Tag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectByTag(Extends Menu As PopupMenu, Tag As Variant)
		  For I As Integer = 0 To Menu.ListCount - 1
		    If Menu.RowTag(I) = Tag Then
		      Menu.ListIndex = I
		      Return
		    End If
		  Next
		  Menu.ListIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tag(Extends Menu As PopupMenu) As Variant
		  If Menu.ListIndex > -1 Then
		    Return Menu.RowTag(Menu.ListIndex)
		  End If
		End Function
	#tag EndMethod


End Module
#tag EndModule
