#tag Class
Protected Class PopoverContainer
Inherits DesktopContainer
	#tag Event
		Sub Closing()
		  RaiseEvent Finished()
		  RaiseEvent Closing()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function IsPopover() As Boolean
		  Return Self.mIsPopover
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetContentSize(NewWidth As Integer, NewHeight As Integer)
		  If Self.mIsPopover = False Then
		    Self.Width = NewWidth
		    Self.Height = NewHeight
		    Return
		  End If
		  
		  If Self.Window Is Nil Then
		    Return
		  End If
		  
		  #if Not TargetMacOS
		    Select Case Self.mDisplaySide
		    Case DesktopWindow.DisplaySides.Bottom
		      Self.Window.Left = Self.Window.Left + (Self.Window.Width - NewWidth) / 2
		    Case DesktopWindow.DisplaySides.Top
		      Self.Window.Left = Self.Window.Left + (Self.Window.Width - NewWidth) / 2
		      Self.Window.Top = Self.Window.Height - NewHeight
		    Case DesktopWindow.DisplaySides.Left
		      Self.Window.Left = Self.Window.Width - NewWidth
		      Self.Window.Top = Self.Window.Top + (Self.Window.Height - NewHeight) / 2
		    Case DesktopWindow.DisplaySides.Right
		      Self.Window.Top = Self.Window.Top + (Self.Window.Height - NewHeight) / 2
		    End Select
		  #endif
		  
		  Self.Window.Width = NewWidth
		  Self.Window.Height = NewHeight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowPopover(parentControl As DesktopUIControl, displaySide As DesktopWindow.DisplaySides = DesktopWindow.DisplaySides.Bottom, detachable As Boolean = True, animated As Boolean = true, x As integer = -1, y As Integer = -1)
		  Self.mDisplaySide = DisplaySide
		  Self.mIsPopover = True
		  Super.ShowPopover(parentControl, displaySide, detachable, animated, x, y)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDisplaySide As DesktopWindow.DisplaySides
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsPopover As Boolean
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
			Name="Super"
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
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
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
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
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
			Name="HasBackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Composited"
			Visible=true
			Group="Window Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
