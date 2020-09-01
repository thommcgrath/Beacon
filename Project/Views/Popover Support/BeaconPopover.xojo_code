#tag Class
Protected Class BeaconPopover
Inherits NSPopoverMBS
	#tag Event
		Sub popoverWillClose(notification as NSNotificationMBS)
		  RaiseEvent PopoverWillClose(Notification)
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event PopoverWillClose(notification as NSNotificationMBS)
	#tag EndHook


	#tag Note, Name = WTF
		Why does this useless class exist? It seems like the MBS plugin doesn't watch for the notification
		unless the event is implemented. Using AddHandler doesn't trigger it.
		
	#tag EndNote


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
			InitialValue=""
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
