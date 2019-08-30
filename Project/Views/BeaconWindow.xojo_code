#tag Class
Protected Class BeaconWindow
Inherits Window
	#tag Event
		Sub Closing()
		  RaiseEvent Closing
		  
		  If Self.mWindowMenuItem <> Nil Then
		    Dim WindowMenu As MenuItem = MainMenuBar.Child("WindowMenu")
		    For I As Integer = WindowMenu.Count - 1 DownTo 0
		      If WindowMenu.MenuAt(I) = Self.mWindowMenuItem Then
		        WindowMenu.RemoveMenuAt(I)
		        If WindowMenu.MenuAt(WindowMenu.Count - 1) = MainMenuBar.Child("WindowMenu").Child("UntitledSeparator4") Then
		          MainMenuBar.Child("WindowMenu").Child("UntitledSeparator4").Visible = False
		        End If
		        Exit For I
		      End If
		    Next
		    
		    RemoveHandler Self.mWindowMenuItem.MenuItemSelected, WeakAddressOf Self.mWindowMenuItem_Action
		    Self.mWindowMenuItem = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuSelected()
		  If Self.HasCloseButton Then
		    FileClose.Enable
		  End If
		  If Self.HasMinimizeButton Then
		    WindowMinimize.Enable
		  End If
		  If Self.Resizeable Then
		    WindowZoom.Enable
		  End If
		  If Self.mWindowMenuItem <> Nil Then
		    Self.mWindowMenuItem.Enable
		  End If
		  
		  RaiseEvent MenuSelected
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
		  Dim InitialWidth As Integer = Self.Width
		  // Dumb workaround because contents are sizing 1 pixels too short.
		  // A resize causes them to find their correct positions.
		  Self.Width = InitialWidth + 1
		  Self.Width = InitialWidth
		  
		  Dim MenuItem As New MenuItem(Self.Title)
		  AddHandler MenuItem.MenuItemSelected, WeakAddressOf Self.mWindowMenuItem_Action
		  
		  If MenuItem <> Nil Then
		    Self.mWindowMenuItem = MenuItem
		    
		    MainMenuBar.Child("WindowMenu").Child("UntitledSeparator3").Visible = True
		    MainMenuBar.Child("WindowMenu").AddMenu(MenuItem)
		  End If
		  
		  RaiseEvent Opening
		  
		  Self.mOpened = True
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  If Self.mOpened Then
		    RaiseEvent Resized
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
		    
		    Dim SharedApp As Ptr = SharedApplication(NSClassFromString("NSApplication"))
		    ActivateIgnoringOtherApps(SharedApp, True)
		  #elseif TargetWin32
		    Declare Function BringWindowToTop Lib "User32" (Target As Int32) As Boolean
		    Call BringWindowToTop(Self.Handle)
		  #else
		    #Pragma Error "No code to bring a window to foreground on this platform."
		  #endif
		  
		  Self.Show()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mWindowMenuItem_Action(Sender As MenuItem) As Boolean
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
		    Self.mWindowMenuItem.Value = Self.Title
		    Self.mWindowMenuItem.Enable
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MenuSelected()
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


	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWindowMenuItem As MenuItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="MinWidth"
			Visible=false
			Group="Size"
			InitialValue="64"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinHeight"
			Visible=false
			Group="Size"
			InitialValue="64"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxWidth"
			Visible=false
			Group="Size"
			InitialValue="32000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxHeight"
			Visible=false
			Group="Size"
			InitialValue="32000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Frame"
			Visible=false
			Group="Frame"
			InitialValue="0"
			Type="Integer"
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
			Name="CloseButton"
			Visible=false
			Group="Frame"
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
			Name="MaximizeButton"
			Visible=false
			Group="Frame"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimizeButton"
			Visible=false
			Group="Frame"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FullScreenButton"
			Visible=false
			Group="Frame"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Placement"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
			Name="HasBackColor"
			Visible=false
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=false
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
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
			Name="Resizable"
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
			Type="Color"
			EditorType=""
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
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="400"
			Type="Integer"
			EditorType=""
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
			Name="Interfaces"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="MenuBar"
			Visible=true
			Group="Menus"
			InitialValue=""
			Type="MenuBar"
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
			Name="Title"
			Visible=true
			Group="Frame"
			InitialValue="Untitled"
			Type="String"
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
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="600"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
