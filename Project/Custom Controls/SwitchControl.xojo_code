#tag Class
Protected Class SwitchControl
Inherits ControlCanvas
	#tag Event
		Sub Activate()
		  RaiseEvent Activate
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivate()
		  RaiseEvent Deactivate
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If RaiseEvent KeyDown(Key) Then
		    Return True
		  End If
		  
		  If (Key = Encodings.UTF8.Chr(10) Or Key = Encodings.UTF8.Chr(13)) Then
		    Self.Value = Not Self.Value
		    Return True
		  ElseIf Key = Encodings.UTF8.Chr(28) Then // Left
		    Self.Value = False
		    Return True
		  ElseIf Key = Encodings.UTF8.Chr(29) Then // Right
		    Self.Value = True
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var ThumbRect As Rect = Self.ThumbRect
		  
		  Self.mPressedOpacity = 1.0
		  Self.mMouseDownPoint = New Point(X, Y)
		  Self.mDragEligible = ThumbRect.Contains(Self.mMouseDownPoint)
		  Self.mDragStarted = False
		  Self.Invalidate
		  
		  If (Self.mValueChangeAnimation Is Nil) = False Then
		    Self.mValueChangeAnimation.Cancel
		    Self.mValueChangeAnimation = Nil
		  End If
		  
		  If (Self.mPressedAnimation Is Nil) = False Then
		    Self.mPressedAnimation.Cancel
		    Self.mPressedAnimation = Nil
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  #Pragma Unused Y
		  
		  If Not Self.mDragEligible Then
		    Return
		  End If
		  
		  Var DeltaX As Integer = X - Self.mMouseDownPoint.X
		  
		  If Self.mDragStarted = False And Abs(DeltaX) > 5 Then
		    Self.mDragStarted = True
		  End If
		  
		  If Self.mDragStarted = True Then
		    Var ThumbRect As Rect = Self.ThumbRect
		    Var LeftBefore As Integer = ThumbRect.Left
		    ThumbRect.Offset(DeltaX, 0)
		    Self.ThumbRect = ThumbRect
		    ThumbRect = Self.ThumbRect // To recompute
		    Var LeftAfter As Integer = ThumbRect.Left
		    Self.mMouseDownPoint.Translate(LeftAfter - LeftBefore, 0)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Self.mPressedAnimation = New AnimationKit.ValueTask(Self, "PressedOpacity", Self.mPressedOpacity, 0.0)
		  Self.mPressedAnimation.DurationInSeconds = 0.3
		  Self.mPressedAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.mPressedAnimation.Run
		  
		  If Self.mDragStarted Then
		    Self.Value = Self.mAnimationState > 0.5
		  Else
		    Self.Value = Not Self.Value
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused SafeArea
		  
		  Var ThumbRect As Rect = Self.ThumbRect
		  Var OnColor As Color = If(Highlighted, SystemColors.SelectedContentBackgroundColor, SystemColors.UnemphasizedSelectedContentBackgroundColor)
		  Var OffColor As Color = SystemColors.QuaternaryLabelColor
		  
		  Var Full As New Picture(G.Width * G.ScaleX, G.Height * G.ScaleY)
		  Full.Graphics.ScaleX = G.ScaleX
		  Full.Graphics.ScaleY = G.ScaleY
		  Full.HorizontalResolution = 72 * G.ScaleX
		  Full.VerticalResolution = 72 * G.ScaleY
		  
		  If Self.mAnimationState < 1.0 Then
		    Full.Graphics.DrawingColor = OffColor
		    Full.Graphics.FillRectangle(0, 0, Full.Graphics.Width, Full.Graphics.Height)
		  End If
		  If Self.mAnimationState > 0.0 Then
		    Full.Graphics.DrawingColor = OnColor.AtOpacity(Self.mAnimationState)
		    Full.Graphics.FillRectangle(0, 0, Full.Graphics.Width, Full.Graphics.Height)
		  End If
		  
		  Var BorderMask As New Picture(G.Width * G.ScaleX, G.Height * G.ScaleY)
		  BorderMask.Graphics.ScaleX = G.ScaleX
		  BorderMask.Graphics.ScaleY = G.ScaleY
		  BorderMask.HorizontalResolution = 72 * G.ScaleX
		  BorderMask.VerticalResolution = 72 * G.ScaleY
		  BorderMask.Graphics.DrawingColor = &cD4D4D4
		  BorderMask.Graphics.FillRectangle(0, 0, BorderMask.Graphics.Width, BorderMask.Graphics.Height)
		  BorderMask.Graphics.DrawingColor = &cFFFFFF
		  BorderMask.Graphics.FillRoundRectangle(1, 1, BorderMask.Graphics.Width - 2, BorderMask.Graphics.Height - 2, BorderMask.Graphics.Height - 2, BorderMask.Graphics.Height - 2)
		  
		  Var Border As New Picture(G.Width * G.ScaleX, G.Height * G.ScaleY)
		  Border.Graphics.ScaleX = G.ScaleX
		  Border.Graphics.ScaleY = G.ScaleY
		  Border.HorizontalResolution = 72 * G.ScaleX
		  Border.VerticalResolution = 72 * G.ScaleY
		  Border.Graphics.DrawingColor = SystemColors.LabelColor
		  Border.Graphics.FillRectangle(0, 0, Border.Graphics.Width, Border.Graphics.Height)
		  Border.ApplyMask(BorderMask)
		  
		  Var Shadow As New ShadowBrush
		  Shadow.BlurAmount = 3
		  Shadow.Offset = New Point(0, 1)
		  Shadow.ShadowColor = &c00000080
		  
		  Full.Graphics.ShadowBrush = Shadow
		  Full.Graphics.DrawPicture(Border, 0, 0)
		  Full.Graphics.DrawingColor = &cFFFFFF
		  Full.Graphics.FillOval(ThumbRect.Left, ThumbRect.Top, ThumbRect.Width, ThumbRect.Height)
		  Full.Graphics.ShadowBrush = Nil
		  
		  If Self.mPressedOpacity > 0.0 Then
		    Var PressedColor As Color = &c000000D4
		    Full.Graphics.DrawingColor = PressedColor.AtOpacity(Self.mPressedOpacity)
		    Full.Graphics.FillRectangle(0, 0, Full.Graphics.Width, Full.Graphics.Height)
		  End If
		  
		  Var White As New Picture(G.Width * G.ScaleX, G.Height * G.ScaleY)
		  White.Graphics.ScaleX = G.ScaleX
		  White.Graphics.ScaleY = G.ScaleY
		  White.HorizontalResolution = 72 * G.ScaleX
		  White.VerticalResolution = 72 * G.ScaleY
		  White.Graphics.DrawingColor = &cFFFFFF
		  White.Graphics.FillRectangle(0, 0, White.Graphics.Width, White.Graphics.Height)
		  
		  Var Mask As New Picture(G.Width * G.ScaleX, G.Height * G.ScaleY)
		  Mask.Graphics.ScaleX = G.ScaleX
		  Mask.Graphics.ScaleY = G.ScaleY
		  Mask.HorizontalResolution = 72 * G.ScaleX
		  Mask.VerticalResolution = 72 * G.ScaleY
		  Mask.Graphics.DrawingColor = &c000000
		  Mask.Graphics.FillRectangle(0, 0, Mask.Graphics.Width, Mask.Graphics.Height)
		  Mask.Graphics.DrawingColor = &cFFFFFF
		  Mask.Graphics.FillRoundRectangle(0, 0, Mask.Graphics.Width, Mask.Graphics.Height, Mask.Graphics.Height, Mask.Graphics.Height)
		  White.ApplyMask(Mask)
		  
		  Var FullMask As Picture = Full.CopyMask
		  FullMask.Graphics.ScaleX = G.ScaleX
		  FullMask.Graphics.ScaleY = G.ScaleY
		  FullMask.Graphics.DrawPicture(White, 0, 0)
		  Full.ApplyMask(FullMask)
		  
		  G.DrawPicture(Full, 0, 0)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As String, Value As Double)
		  Super.AnimationStep(Identifier, Value)
		  
		  Select Case Identifier
		  Case "AnimationState"
		    Self.mAnimationState = Value
		    Self.Invalidate
		  Case "PressedOpacity"
		    Self.mPressedOpacity = Value
		    Self.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ThumbRect() As Rect
		  Var ThumbWidth As Integer = Min(Self.Width, Self.Height) - (Self.ThumbPadding * 2)
		  Var ThumbHeight As Integer = ThumbWidth
		  Var ThumbMinX As Integer = Self.ThumbPadding
		  Var ThumbMaxX As Integer = Self.Width - (Self.ThumbPadding + ThumbWidth)
		  Var ThumbRange As Integer = ThumbMaxX - ThumbMinX
		  
		  Return New Rect(ThumbMinX + Round(ThumbRange * Self.mAnimationState), Self.ThumbPadding, ThumbWidth, ThumbHeight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ThumbRect(Assigns NewRect As Rect)
		  // We're really only going to take the left position
		  
		  Var ThumbWidth As Integer = Min(Self.Width, Self.Height) - (Self.ThumbPadding * 2)
		  Var ThumbHeight As Integer = ThumbWidth
		  Var ThumbMinX As Integer = Self.ThumbPadding
		  Var ThumbMaxX As Integer = Self.Width - ((Self.ThumbPadding * 2) + ThumbWidth)
		  Var ThumbRange As Integer = ThumbMaxX - ThumbMinX
		  
		  Self.mAnimationState = Max(Min((NewRect.Left - ThumbMinX) / ThumbRange, 1.0), 0.0)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Boolean
		  Return Self.VisualState = Checkbox.VisualStates.Checked
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Animated As Boolean = True, Assigns Value As Boolean)
		  If Value Then
		    Self.VisualState(Animated) = Checkbox.VisualStates.Checked
		  Else
		    Self.VisualState(Animated) = Checkbox.VisualStates.Unchecked
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisualState() As Checkbox.VisualStates
		  Return Self.mVisualState
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VisualState(Animated As Boolean = True, Assigns Value As Checkbox.VisualStates)
		  If Self.mVisualState <> Value Then
		    Self.mVisualState = Value
		    RaiseEvent Action
		  End If
		  
		  If (Self.mValueChangeAnimation Is Nil) = False Then
		    Self.mValueChangeAnimation.Cancel
		    Self.mValueChangeAnimation = Nil
		  End If
		  
		  Var TargetState As Double
		  Select Case Self.mVisualState
		  Case Checkbox.VisualStates.Checked
		    TargetState = 1.0
		  Case Checkbox.VisualStates.Indeterminate
		    TargetState = 0.5
		  Case Checkbox.VisualStates.Unchecked
		    TargetState = 0.0
		  End Select
		  
		  If Self.mAnimationState = TargetState Then
		    Return
		  End If
		  
		  If Animated Then
		    Self.mValueChangeAnimation = New AnimationKit.ValueTask(Self, "AnimationState", Self.mAnimationState, TargetState)
		    Self.mValueChangeAnimation.DurationInSeconds = 0.15
		    Self.mValueChangeAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		    Self.mValueChangeAnimation.Run
		  Else
		    Self.mAnimationState = TargetState
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Activate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Deactivate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAnimationState As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDragEligible As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDragStarted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedOpacity As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValueChangeAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisualState As Checkbox.VisualStates
	#tag EndProperty


	#tag Constant, Name = ThumbPadding, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="20"
			Type="Integer"
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
			Name="TabIndex"
			Visible=true
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="40"
			Type="Integer"
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
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
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
			Name="Visible"
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
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
		#tag ViewProperty
			Name="ScrollActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollingEnabled"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
