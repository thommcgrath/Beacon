#tag Class
Protected Class StepperControl
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.mMouseDownButton = Self.ButtonAtPoint(X, Y)
		  Self.mPressedButton = Self.mMouseDownButton
		  Self.Refresh
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var CurrentButton As Integer = Self.ButtonAtPoint(X, Y)
		  If CurrentButton = Self.mMouseDownButton Then
		    If Self.mPressedButton <> CurrentButton Then
		      Self.mPressedButton = CurrentButton
		      Self.Refresh
		    End If
		  Else
		    If Self.mPressedButton <> 0 Then
		      Self.mPressedButton = 0
		      Self.Refresh
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var CurrentButton As Integer = Self.ButtonAtPoint(X, Y)
		  If CurrentButton = Self.mMouseDownButton Then
		    Select Case CurrentButton
		    Case Self.UpButton
		      RaiseEvent UpPressed()
		    Case Self.DownButton
		      RaiseEvent DownPressed()
		    End Select
		  End If
		  Self.mMouseDownButton = 0
		  Self.mPressedButton = 0
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  Var LineSize As Double = Max(Self.Width / 12, 1)
		  Var ButtonWidth As Double = Self.Width - (LineSize * 2)
		  Var UpHeight As Double = (Self.Height - (LineSize * 3)) / 2
		  Var DownHeight As Double = Self.Height - ((LineSize * 3) + UpHeight)
		  
		  Self.mUpRect = New Xojo.Rect(LineSize, LineSize, ButtonWidth, UpHeight)
		  Self.mDownRect = New Xojo.Rect(LineSize, Self.mUpRect.Bottom + LineSize, ButtonWidth, DownHeight)
		  
		  Var CornerRadius As Integer = Min(Self.Width, Self.Height)
		  Var Base As Picture = G.CreateScaledPic(Self.Width, Self.Height)
		  Base.Graphics.DrawingColor = SystemColors.ControlBackgroundColor
		  Base.Graphics.FillRectangle(0, 0, Self.Width, Self.Height)
		  
		  Select Case Self.mPressedButton
		  Case Self.UpButton
		    Base.Graphics.DrawingColor = SystemColors.SelectedContentBackgroundColor
		    Base.Graphics.FillRectangle(Self.mUpRect.Left - LineSize, Self.mUpRect.Top - LineSize, Self.mUpRect.Width + (LineSize * 2), Self.mUpRect.Height + (LineSize * 2))
		  Case Self.DownButton
		    Base.Graphics.DrawingColor = SystemColors.SelectedContentBackgroundColor
		    Base.Graphics.FillRectangle(Self.mDownRect.Left - LineSize, Self.mDownRect.Top - LineSize, Self.mDownRect.Width + (LineSize * 2), Self.mDownRect.Height + (LineSize * 2))
		  End Select
		  
		  Var SmallestEdge As Integer = Min(Self.mUpRect.Width, Self.mUpRect.Height, Self.mDownRect.Width, Self.mDownRect.Height)
		  Var IconSize As Double = (SmallestEdge - (LineSize * 2)) * 0.8
		  Var LineHalf As Double = LineSize / 2
		  Var Nudge As Double = 0//Self.Width / 48
		  
		  Var UpIconRect As New Xojo.Rect(Self.mUpRect.Left + ((Self.mUpRect.Width - IconSize) / 2), Self.mUpRect.Top + ((Self.mUpRect.Height - IconSize) / 2), IconSize, IconSize)
		  UpIconRect.Offset(0, Nudge)
		  Var UpIconPoints() As Xojo.Point
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.Left, UpIconRect.VerticalCenter - LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter - LineHalf, UpIconRect.VerticalCenter - LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter - LineHalf, UpIconRect.Top))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter + LineHalf, UpIconRect.Top))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter + LineHalf, UpIconRect.VerticalCenter - LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.Right, UpIconRect.VerticalCenter - LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.Right, UpIconRect.VerticalCenter + LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter + LineHalf, UpIconRect.VerticalCenter + LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter + LineHalf, UpIconRect.Bottom))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter - LineHalf, UpIconRect.Bottom))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.HorizontalCenter - LineHalf, UpIconRect.VerticalCenter + LineHalf))
		  UpIconPoints.Add(New Xojo.Point(UpIconRect.Left, UpIconRect.VerticalCenter + LineHalf))
		  Var UpIcon As FigureShape = BeaconUI.IconFromPoints(UpIconPoints)
		  If Self.mPressedButton = Self.UpButton Then
		    UpIcon.FillColor = SystemColors.AlternateSelectedControlTextColor
		  Else
		    UpIcon.FillColor = SystemColors.SecondaryLabelColor
		  End If
		  Base.Graphics.DrawObject(UpIcon)
		  
		  Var DownIconRect As New Xojo.Rect(Self.mDownRect.Left + ((Self.mDownRect.Width - IconSize) / 2), Self.mDownRect.Top + ((Self.mDownRect.Height - IconSize) / 2), IconSize, IconSize)
		  DownIconRect.Offset(0, Nudge * -1)
		  Var DownIconPoints() As Xojo.Point
		  DownIconPoints.Add(New Xojo.Point(DownIconRect.Left, DownIconRect.VerticalCenter - LineHalf))
		  DownIconPoints.Add(New Xojo.Point(DownIconRect.Right, DownIconRect.VerticalCenter - LineHalf))
		  DownIconPoints.Add(New Xojo.Point(DownIconRect.Right, DownIconRect.VerticalCenter + LineHalf))
		  DownIconPoints.Add(New Xojo.Point(DownIconRect.Left, DownIconRect.VerticalCenter + LineHalf))
		  Var DownIcon As FigureShape = BeaconUI.IconFromPoints(DownIconPoints)
		  If Self.mPressedButton = Self.DownButton Then
		    DownIcon.FillColor = SystemColors.AlternateSelectedControlTextColor
		  Else
		    DownIcon.FillColor = SystemColors.SecondaryLabelColor
		  End If
		  Base.Graphics.DrawObject(DownIcon)
		  
		  Var BorderColor As Color = New ColorGroup(&c000000CF, &cFFFFFFDF)
		  Var BorderBaseColor As Color = Color.RGB(BorderColor.Red, BorderColor.Green, BorderColor.Blue)
		  Var BorderMaskColor As Color = Color.RGB(BorderColor.Alpha, BorderColor.Alpha, BorderColor.Alpha)
		  
		  Var BorderMask As Picture = G.CreateScaledPic(Self.Width, Self.Height)
		  BorderMask.Graphics.ScaleX = G.ScaleX
		  BorderMask.Graphics.ScaleY = G.ScaleY
		  BorderMask.Graphics.DrawingColor = BorderMaskColor
		  BorderMask.Graphics.FillRectangle(0, 0, Self.Width, Self.Height)
		  BorderMask.Graphics.DrawingColor = &cFFFFFF
		  BorderMask.Graphics.FillRoundRectangle(LineSize, LineSize, Self.Width - (LineSize * 2), Self.Height - (LineSize * 2), ButtonWidth, ButtonWidth)
		  BorderMask.Graphics.DrawingColor = BorderMaskColor
		  BorderMask.Graphics.FillRectangle(0, (Self.Height / 2) - LineHalf, Self.Width, LineSize)
		  
		  Var Border As Picture = G.CreateScaledPic(Self.Width, Self.Height)
		  Border.Graphics.ScaleX = G.ScaleX
		  Border.Graphics.ScaleY = G.ScaleY
		  Border.Graphics.DrawingColor = BorderBaseColor
		  Border.Graphics.FillRectangle(0, 0, Self.Width, Self.Height)
		  Border.ApplyMask(BorderMask)
		  
		  Base.Graphics.DrawPicture(Border, 0, 0, Self.Width, Self.Height, 0, 0, Border.Width, Border.Height)
		  
		  Var BaseMask As Picture = G.CreateScaledPic(Self.Width, Self.Height)
		  BaseMask.Graphics.DrawingColor = &cFFFFFF
		  BaseMask.Graphics.FillRectangle(0, 0, Self.Width, Self.Height)
		  BaseMask.Graphics.DrawingColor = &c000000
		  BaseMask.Graphics.FillRoundRectangle(0, 0, Self.Width, Self.Height, Self.Width, Self.Width)
		  Base.ApplyMask(BaseMask)
		  
		  G.DrawPicture(Base, 0, 0, Self.Width, Self.Height, 0, 0, Base.Width, Base.Height)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ButtonAtPoint(X As Integer, Y As Integer) As Integer
		  If Self.mUpRect.Contains(X, Y) Then
		    Return Self.UpButton
		  End If
		  
		  If Self.mDownRect.Contains(X, Y) Then
		    Return Self.DownButton
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DownPressed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpPressed()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDownRect As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownButton As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedButton As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpRect As Xojo.Rect
	#tag EndProperty


	#tag Constant, Name = DownButton, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UpButton, Type = Double, Dynamic = False, Default = \"1", Scope = Private
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
			InitialValue="22"
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
			InitialValue="12"
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
			Visible=false
			Group="Behavior"
			InitialValue=""
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
