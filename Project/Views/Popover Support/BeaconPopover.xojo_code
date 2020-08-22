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


End Class
#tag EndClass
