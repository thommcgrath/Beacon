#tag Class
Protected Class MasterToolbarItem
	#tag Method, Flags = &h0
		Function Caption() As String
		  Return Self.View.ToolbarCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloseRect() As REALbasic.Rect
		  If Self.Rect = Nil Then
		    Return Nil
		  End If
		  
		  Return New REALbasic.Rect(Self.Rect.Right - (IconClose.Width + (MasterToolbar.CellVerticalPadding * 2)), Self.Rect.Top, IconClose.Width + (MasterToolbar.CellVerticalPadding * 2), IconClose.Height + (MasterToolbar.CellVerticalPadding * 2))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(View As BeaconSubview)
		  Self.mView = New WeakRef(View)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Icon() As Picture
		  Return Self.View.ToolbarIcon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mView.Value <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function View() As BeaconSubview
		  If Self.IsValid Then
		    Return BeaconSubview(Self.mView.Value)
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mView As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		Rect As REALbasic.Rect
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
