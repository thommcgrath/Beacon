#tag Class
Protected Class BeaconWindow
Inherits Window
	#tag Event
		Sub EnableMenuItems()
		  If Self.CloseButton Then
		    FileClose.Enable
		  End If
		  If Self.MinimizeButton Then
		    WindowMinimize.Enable
		  End If
		  If Self.Resizeable Then
		    WindowZoom.Enable
		  End If
		  
		  RaiseEvent EnableMenuItems
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			Self.Close
			Return True
		End Function
	#tag EndMenuHandler


	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook


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
