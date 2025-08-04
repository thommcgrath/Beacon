#tag Class
Protected Class PopoverController
	#tag Method, Flags = &h0
		Sub Constructor(Title As String, Container As DesktopContainer)
		  Self.mContainer = Container
		  
		  Self.mDialog = New PopoverDialog(Self)
		  Self.mDialog.Visible = False
		  Self.mDialog.Title = Title
		  Self.mDialog.Embed(Container)
		  
		  If Container IsA BeaconSubview Then
		    Try
		      AddHandler BeaconSubview(Container).Resize, WeakAddressOf Subview_Resize
		    Catch Err As RuntimeException
		    End Try
		  Else
		    Try
		      AddHandler Container.Resizing, WeakAddressOf Container_Resize
		      AddHandler Container.Resized, WeakAddressOf Container_Resize
		    Catch AnotherErr As RuntimeException
		    End Try
		  End If
		  
		  #if TargetMacOS
		    If NSPopoverMBS.Available Then
		      Var ViewController As New NSViewControllerMBS
		      ViewController.View = Container.NSViewMBS
		      ViewController.View.SetBoundsOrigin(New NSPointMBS(0, 0)) // No idea why the X should be negative here
		      
		      Self.mPopover = New BeaconPopover
		      Self.mPopover.ContentViewController = ViewController
		      Self.mPopover.ContentSize = New NSSizeMBS(Container.Width, Container.Height)
		      Self.mPopover.Animates = True
		      Self.mPopover.Behavior = NSPopoverMBS.NSPopoverBehaviorSemitransient
		      
		      AddHandler mPopover.popoverWillClose, WeakAddressOf mPopover_WillDismiss
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Container() As DesktopContainer
		  Return Self.mContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Container_Resize(Sender As DesktopContainer)
		  If (Self.mPopover Is Nil) = False Then
		    Self.mPopover.Animates = False
		    Self.mPopover.ContentViewController.View.SetBoundsOrigin(New NSPointMBS(0, 0))
		    Self.mPopover.ContentSize = New NSSizeMBS(Sender.Width, Sender.Height)
		    Self.mPopover.Animates = True
		  Else
		    Self.mDialog.UpdateSize(Sender.Width, Sender.Height, True)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Var UseDelayedClosing As Boolean
		  If (Self.mPopover Is Nil) = False Then
		    If Self.mPopover.IsShown Then
		      UseDelayedClosing = True
		      Self.mPopover.PerformClose
		    End If
		    Self.mPopover = Nil
		  End If
		  
		  // Needs to close the dialog after the popover animation
		  If (Self.mDialog Is Nil) = False Then
		    If UseDelayedClosing Then
		      Call CallLater.Schedule(2000, AddressOf mDialog.Close)
		    Else
		      Self.mDialog.Close
		      Self.mDialog = Nil
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Dismiss(Cancelled As Boolean)
		  If Not Self.Visible Then
		    Return
		  End If
		  
		  If Self.mPopover Is Nil Then
		    RaiseEvent Finished(Cancelled)
		    Self.mVisible = False
		    Self.mDialog.Hide
		  Else
		    Self.mPopover.PerformClose
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mPopover_WillDismiss(Sender As BeaconPopover, Notification As NSNotificationMBS)
		  #Pragma Unused Sender
		  #Pragma Unused Notification
		  
		  RaiseEvent Finished(False)
		  Self.mVisible = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(Parent As DesktopUIControl)
		  Self.Show(Parent, New Rect(0, 0, Parent.Width, Parent.Height))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(Parent As DesktopUIControl, InsetRect As Rect)
		  If Self.Visible Or Parent Is Nil Or Parent.Window Is Nil Then
		    Return
		  End If
		  
		  Self.mVisible = True
		  
		  If Self.mPopover Is Nil Then
		    Self.mDialog.Show(Parent.Window)
		  Else
		    Var ParentView As NSViewMBS = Parent.NSViewMBS
		    Var PositionRect As NSRectMBS
		    If InsetRect Is Nil Then
		      PositionRect = ParentView.Bounds
		    Else
		      PositionRect = New NSRectMBS(InsetRect.Left, InsetRect.Top, InsetRect.Width, InsetRect.Height)
		    End If
		    Self.mPopover.ShowRelativeToRect(PositionRect, ParentView, NSPopoverMBS.MinYEdge)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Subview_Resize(Sender As BeaconSubview, Initial As Boolean)
		  #Pragma Unused Sender
		  #Pragma Unused Initial
		  
		  Self.Container_Resize(Sender)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Visible() As Boolean
		  If Self.mPopover Is Nil Then
		    Return Self.mVisible
		  Else
		    Return Self.mPopover.isShown
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Cancelled As Boolean)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mContainer As DesktopContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDialog As PopoverDialog
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPopover As BeaconPopover
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisible As Boolean
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
	#tag EndViewBehavior
End Class
#tag EndClass
