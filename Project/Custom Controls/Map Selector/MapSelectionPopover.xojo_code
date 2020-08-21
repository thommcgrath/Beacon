#tag Class
Protected Class MapSelectionPopover
Inherits NSPopoverMBS
	#tag Event
		Sub popoverWillClose(notification as NSNotificationMBS)
		  #Pragma Unused Notification
		  
		  Self.mCallback.Invoke(Self.mGrid.Mask)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Grid As MapSelectionGrid, Callback As MapSelectionSheet.SelectionCallback)
		  Self.mGrid = Grid
		  Self.mCallback = Callback
		  
		  Var Controller As New NSViewControllerMBS
		  Controller.View = Grid.NSViewMBS
		  Controller.View.SetBoundsOrigin(New NSPointMBS(-14, 14)) // No idea why the X should be negative here
		  
		  Super.Constructor
		  Self.ContentSize = New NSSizeMBS(Grid.DesiredWidth + 28, Grid.DesiredHeight + 28)
		  Self.ContentViewController = Controller
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCallback As MapSelectionSheet.SelectionCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGrid As MapSelectionGrid
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
