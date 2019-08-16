#tag Class
Protected Class ControlCanvas
Inherits Canvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not Self.mPainted Then
		    Return False
		  End If
		  
		  Return MouseDown(X, Y)
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Not Self.mPainted Then
		    Return
		  End If
		  
		  RaiseEvent MouseEnter()
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Not Self.mPainted Then
		    Return
		  End If
		  
		  RaiseEvent MouseExit
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Not Self.mPainted Then
		    Return
		  End If
		  
		  RaiseEvent MouseMove(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  If Not Self.mPainted Then
		    Return False
		  End If
		  
		  Dim WheelData As New BeaconUI.ScrollEvent(Self.ScrollSpeed, DeltaX, DeltaY)
		  Return MouseWheel(X, Y, WheelData.ScrollX, WheelData.ScrollY, WheelData)
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Opening
		  
		  #if XojoVersion >= 2018.01
		    Self.Transparent = True
		  #else
		    Self.DoubleBuffer = TargetWin32
		    Self.Transparent = Not Self.DoubleBuffer
		    Self.EraseBackground = Not Self.DoubleBuffer
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  If Not Self.Transparent Then
		    Dim TempColor As Color = G.DrawingColor
		    If Self.Window.HasBackgroundColor Then
		      G.DrawingColor = Self.Window.BackgroundColor
		    Else
		      G.DrawingColor = SystemColors.WindowBackgroundColor
		    End If
		    G.FillRect(0, 0, G.Width, G.Height)
		    G.DrawingColor = TempColor
		  End If
		  
		  RaiseEvent Paint(g, areas)
		  Self.mPainted = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Invalidate(eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.Invalidate(EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.Invalidate(Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(x As Integer, y As Integer, width As Integer, height As Integer, eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.Invalidate(X, Y, Width, Height, EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.Invalidate(X, Y, Width, Height, Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh(eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.Refresh(EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.Refresh(Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshRect(x As Integer, y As Integer, width As Integer, height As Integer, eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.RefreshRect(X, Y, Width, Height, EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.RefreshRect(X, Y, Width, Height, Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseEnter()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseExit()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseMove(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Integer, PixelsY As Integer, WheelData As BeaconUI.ScrollEvent) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Paint(g As Graphics, areas() As REALbasic.Rect)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mPainted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ScrollSpeed As Integer = 20
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=false
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=false
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=false
			Group="Behavior"
			InitialValue="False"
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
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType="Picture"
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
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
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
