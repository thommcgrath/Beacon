#tag Class
Protected Class BeaconWindow
Inherits DesktopWindow
	#tag Event
		Sub Closing()
		  RaiseEvent Closing
		  
		  If Self.mWindowMenuItem <> Nil Then
		    Var WindowMenu As DesktopMenuItem = MainMenuBar.Child("WindowMenu")
		    For I As Integer = WindowMenu.Count - 1 DownTo 0
		      If WindowMenu.MenuAt(I) = Self.mWindowMenuItem Then
		        WindowMenu.RemoveMenuAt(I)
		        If WindowMenu.MenuAt(WindowMenu.Count - 1) = MainMenuBar.Child("WindowMenu").Child("UntitledSeparator4") Then
		          MainMenuBar.Child("WindowMenu").Child("UntitledSeparator4").Visible = False
		        End If
		        Exit For I
		      End If
		    Next
		    
		    RemoveHandler Self.mWindowMenuItem.MenuItemSelected, WeakAddressOf Self.mWindowMenuItem_MenuItemSelected
		    Self.mWindowMenuItem = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuBarSelected()
		  If Self.HasCloseButton Then
		    FileClose.Enabled = True
		  End If
		  If Self.HasMinimizeButton Then
		    WindowMinimize.Enabled = True
		  End If
		  If Self.Resizeable Then
		    WindowZoom.Enabled = True
		  End If
		  If Self.mWindowMenuItem <> Nil Then
		    Self.mWindowMenuItem.Enabled = True
		  End If
		  
		  RaiseEvent MenuBarSelected
		End Sub
	#tag EndEvent

	#tag Event
		Sub Moved()
		  If Self.mOpened Then
		    RaiseEvent Moved
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Var InitialWidth As Integer = Self.Width
		  // Dumb workaround because contents are sizing 1 pixels too short.
		  // A resize causes them to find their correct positions.
		  Self.Width = InitialWidth + 1
		  Self.Width = InitialWidth
		  
		  Var MenuItem As New DesktopMenuItem(Self.Title)
		  AddHandler MenuItem.MenuItemSelected, WeakAddressOf Self.mWindowMenuItem_MenuItemSelected
		  
		  If MenuItem <> Nil Then
		    Self.mWindowMenuItem = MenuItem
		    
		    MainMenuBar.Child("WindowMenu").Child("UntitledSeparator3").Visible = True
		    MainMenuBar.Child("WindowMenu").AddMenu(MenuItem)
		  End If
		  
		  RaiseEvent Opening
		  
		  Self.mOpened = True
		  RaiseEvent UpdateControlPositions
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  If Self.mOpened Then
		    RaiseEvent Resized
		    RaiseEvent UpdateControlPositions
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  If Self.mOpened Then
		    RaiseEvent Resizing
		    RaiseEvent UpdateControlPositions
		  End If
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
		  Self.Close
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function WindowMinimize() As Boolean Handles WindowMinimize.Action
		  Self.Minimize
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function WindowZoom() As Boolean Handles WindowZoom.Action
		  Self.Maximize
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub BringToFront()
		  #if TargetMacOS
		    Declare Function NSClassFromString Lib "Cocoa" (ClassName As CFStringRef) As Ptr
		    Declare Function SharedApplication Lib "Cocoa" Selector "sharedApplication" (Target As Ptr) As Ptr
		    Declare Sub ActivateIgnoringOtherApps Lib "Cocoa" Selector "activateIgnoringOtherApps:" (Target As Ptr, Flag As Boolean)
		    
		    Var SharedApp As Ptr = SharedApplication(NSClassFromString("NSApplication"))
		    ActivateIgnoringOtherApps(SharedApp, True)
		  #elseif TargetWin32
		    Declare Function BringWindowToTop Lib "User32" (Target As Ptr) As Boolean
		    Call BringWindowToTop(Self.Handle)
		  #else
		    #Pragma Warning "No code to bring a window to foreground on this platform."
		  #endif
		  
		  Self.Show()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mWindowMenuItem_MenuItemSelected(Sender As DesktopMenuItem) As Boolean
		  #Pragma Unused Sender
		  
		  Self.BringToFront()
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Opened() As Boolean
		  Return Self.mOpened
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateWindowMenu()
		  If Self.mWindowMenuItem <> Nil Then
		    Self.mWindowMenuItem.Text = Self.Title
		    Self.mWindowMenuItem.Enabled = True
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MenuBarSelected()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Moved()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resized()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resizing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateControlPositions()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.Changed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Changed = Value
			End Set
		#tag EndSetter
		Modified As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWindowMenuItem As DesktopMenuItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Interfaces"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="MinimumWidth"
			Visible=true
			Group="Size"
			InitialValue="64"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=true
			Group="Size"
			InitialValue="64"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumWidth"
			Visible=true
			Group="Size"
			InitialValue="32000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumHeight"
			Visible=true
			Group="Size"
			InitialValue="32000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="400"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="600"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Frame"
			InitialValue="0"
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Document"
				"1 - Movable Modal"
				"2 - Modal Dialog"
				"3 - Floating Window"
				"4 - Plain Box"
				"5 - Shadowed Box"
				"6 - Rounded Window"
				"7 - Global Floating Window"
				"8 - Sheet Window"
				"9 - Metal Window"
				"11 - Modeless Dialog"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasCloseButton"
			Visible=true
			Group="Frame"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasMaximizeButton"
			Visible=true
			Group="Frame"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasMinimizeButton"
			Visible=true
			Group="Frame"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasFullScreenButton"
			Visible=true
			Group="Frame"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=true
			Group="Frame"
			InitialValue="Untitled"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="ColorGroup"
			EditorType="ColorGroup"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultLocation"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Locations"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Parent Window"
				"2 - Main Screen"
				"3 - Parent Window Screen"
				"4 - Stagger"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ImplicitInstance"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuBar"
			Visible=true
			Group="Menus"
			InitialValue=""
			Type="DesktopMenuBar"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MenuBarVisible"
			Visible=true
			Group="Deprecated"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Resizeable"
			Visible=false
			Group="Frame"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Composite"
			Visible=false
			Group="OS X (Carbon)"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FullScreen"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacProcID"
			Visible=false
			Group="OS X (Carbon)"
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
