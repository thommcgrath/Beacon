#tag Class
Protected Class GraphicButton
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not Self.Enabled Then
		    Return False
		  End If
		  
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  Self.mMouseDown = True
		  Self.mHoldTimer.Mode = Timer.ModeSingle
		  Self.mMouseHeld = False
		  Self.mNoActionOnRelease = False
		  Self.Invalidate()
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If X = Self.mMouseX And Y = Self.mMouseY Then
		    Return
		  End If
		  
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  
		  If X >= 0 And X <= Self.Width And Y >= 0 And Y <= Self.Height Then
		    If Not Self.mMouseDown Then
		      Self.mMouseDown = True
		      Self.Invalidate()
		    End If
		    If Not Self.mMouseHeld Then
		      Self.mHoldTimer.Reset
		      Self.mHoldTimer.Mode = Timer.ModeSingle
		    End If
		  Else
		    If Self.mMouseDown Then
		      Self.mMouseDown = False
		      Self.Invalidate
		    End If
		    Self.mHoldTimer.Reset
		    Self.mHoldTimer.Mode = Timer.ModeOff
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  
		  Self.mHoldTimer.Reset
		  Self.mHoldTimer.Mode = Timer.ModeOff
		  
		  If Self.mMouseDown Then
		    Self.mMouseDown = False
		    Self.Invalidate
		  End If
		  
		  If X >= 0 And X <= Self.Width And Y >= 0 And Y <= Self.Height And Not Self.mNoActionOnRelease Then
		    RaiseEvent Action()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim Owner As RectControl = Self.Parent
		  Dim Enabled As Boolean = Self.Enabled
		  While Enabled And Owner <> Nil
		    Enabled = Enabled And Owner.Enabled
		    Owner = Owner.Parent
		  Wend
		  
		  Dim Icon As Picture
		  If Not Enabled Then
		    Icon = if(Self.mIconDisabled <> Nil, Self.mIconDisabled, Self.mIconNormal)
		  ElseIf Self.mMouseDown Then
		    Icon = if(Self.mIconPressed <> Nil, Self.mIconPressed, Self.mIconNormal)
		  Else
		    Icon = Self.mIconNormal
		  End If
		  
		  G.DrawPicture(Icon, 0, 0)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  Self.mHoldTimer = New Timer
		  Self.mHoldTimer.Mode = Timer.ModeOff
		  Self.mHoldTimer.Period = 250
		  AddHandler Self.mHoldTimer.Action, WeakAddressOf Self.mHoldTimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHoldTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Self.mMouseHeld Then
		    Return
		  End If
		  
		  Self.mNoActionOnRelease = RaiseEvent MouseHold(Self.mMouseX, Self.mMouseY)
		  Self.mMouseHeld = True
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseHold(X As Integer, Y As Integer) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIconDisabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mIconDisabled = Value
			  Self.Invalidate
			End Set
		#tag EndSetter
		IconDisabled As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIconNormal
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mIconNormal = Value
			  Self.Invalidate()
			End Set
		#tag EndSetter
		IconNormal As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIconPressed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mIconPressed = Value
			  Self.Invalidate
			End Set
		#tag EndSetter
		IconPressed As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHoldTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIconDisabled As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIconNormal As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIconPressed As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseHeld As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNoActionOnRelease As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconDisabled"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconNormal"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconPressed"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
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
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
