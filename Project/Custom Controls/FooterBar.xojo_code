#tag Class
Protected Class FooterBar
Inherits ControlCanvas
Implements ObservationKit.Observer
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not Self.Enabled Then
		    Return False
		  End If
		  
		  Dim Target As FooterBarButton = Self.Button(X, Y)
		  If Target = Nil Or Target.Enabled = False Then
		    Return False
		  End If
		  
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  Self.mMouseDown = True
		  Self.mHoldTimer.Mode = Timer.ModeSingle
		  Self.mMouseHeld = False
		  Self.mNoActionOnRelease = False
		  Self.mPressTarget = Target
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
		  
		  Dim Point As New Xojo.Core.Point(X, Y)
		  
		  If Self.mPressTarget.Rect.Contains(Point) Then
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
		  
		  Dim Point As New Xojo.Core.Point(X, Y)
		  If Self.mPressTarget.Rect.Contains(Point) And Not Self.mNoActionOnRelease Then
		    RaiseEvent Action(Self.mPressTarget)
		  End If
		  
		  Self.mPressTarget = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  
		  Dim BorderTop As Integer = G.Height - 25
		  Dim ContentTop As Integer = BorderTop + 1
		  
		  G.ForeColor = Self.BorderColor
		  G.FillRect(0, BorderTop, G.Width, G.Height - BorderTop)
		  
		  // Draw only into the bottom 24 pixels
		  Dim Target As Graphics = G.Clip(0, ContentTop, G.Width, G.Height - ContentTop)
		  Self.PaintInto(Target)
		  
		  For Each Button As FooterBarButton In Self.mButtons
		    Button.Top = Button.Top + ContentTop
		  Next
		  
		  Dim MousePoint As New Xojo.Core.Point(Self.mMouseX, Self.mMouseY)
		  If Self.mMouseDown And Self.mPressTarget <> Nil And Self.mPressTarget.Rect.Contains(MousePoint) Then
		    G.ForeColor = &c000000CC
		    G.FillRect(Self.mPressTarget.Left + 1, Self.mPressTarget.Top + 1, Self.mPressTarget.Width - 2, Self.mPressTarget.Height - 2)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(Button As FooterBarButton)
		  Dim Idx As Integer = Self.IndexOf(Button)
		  If Idx = -1 Then
		    Self.mButtons.Append(Button)
		    Button.AddObserver(Self, "Alignment", "Caption", "Enabled", "Icon")
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Button(Index As Integer) As FooterBarButton
		  Return Self.mButtons(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Button(Index As Integer, Assigns Value As FooterBarButton)
		  Self.mButtons(Index) = Value
		  Value.AddObserver(Self, "Alignment", "Caption", "Enabled", "Icon")
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Button(X As Integer, Y As Integer) As FooterBarButton
		  Dim Point As New Xojo.Core.Point(X, Y)
		  For Each Button As FooterBarButton In Self.mButtons
		    If Button.Rect.Contains(Point) Then
		      Return Button
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Button(Named As String) As FooterBarButton
		  For I As Integer = 0 To UBound(Self.mButtons)
		    If Self.mButtons(I).Name = Named Then
		      Return Self.mButtons(I)
		    End If
		  Next
		End Function
	#tag EndMethod

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

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mButtons)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawButton(G As Graphics, Button As FooterBarButton, Enabled As Boolean)
		  Self.Fill(G)
		  
		  Dim ShadowColor As Color = &cFFFFFF
		  Dim ForeColor As Color = if(Enabled And Button.Enabled, &c292929, &cC0C0C0)
		  
		  Dim Mask As New Picture(G.Width * G.ScaleX, G.Height * G.ScaleY)
		  Mask.HorizontalResolution = 72 * G.ScaleX
		  Mask.VerticalResolution = 72 * G.ScaleY
		  Mask.Graphics.ScaleX = G.ScaleX
		  Mask.Graphics.ScaleY = G.ScaleY
		  
		  Mask.Graphics.ForeColor = &cFFFFFF
		  Mask.Graphics.FillRect(0, 0, Mask.Graphics.Width, Mask.Graphics.Height)
		  
		  Dim CaptionLeft As Integer = Self.ButtonPadding
		  Mask.Graphics.ForeColor = &c000000
		  If Button.Icon <> Nil Then
		    Mask.Graphics.DrawPicture(Button.Icon, Self.ButtonPadding + ((16 - Button.Icon.Width) / 2), 4 + ((16 - Button.Icon.Height) / 2))
		    CaptionLeft = CaptionLeft + 16 + Self.ButtonPadding
		  End If
		  
		  If Button.Caption <> "" Then
		    Mask.Graphics.Bold = True
		    Mask.Graphics.DrawString(Button.Caption, CaptionLeft, 16)
		  End If
		  
		  Dim Foreground As New Picture(Mask.Width, Mask.Height)
		  Foreground.HorizontalResolution = 72 * G.ScaleX
		  Foreground.VerticalResolution = 72 * G.ScaleY
		  Foreground.Graphics.ScaleX = G.ScaleX
		  Foreground.Graphics.ScaleY = G.ScaleY
		  Foreground.Graphics.ForeColor = ForeColor
		  Foreground.Graphics.FillRect(0, 0, Foreground.Graphics.Width, Foreground.Graphics.Height)
		  Foreground.ApplyMask(Mask)
		  
		  Dim Shadow As New Picture(Mask.Width, Mask.Height)
		  Shadow.HorizontalResolution = 72 * G.ScaleX
		  Shadow.VerticalResolution = 72 * G.ScaleY
		  Shadow.Graphics.ScaleX = G.ScaleX
		  Shadow.Graphics.ScaleY = G.ScaleY
		  Shadow.Graphics.ForeColor = ShadowColor
		  Shadow.Graphics.FillRect(0, 0, Shadow.Graphics.Width, Shadow.Graphics.Height)
		  Shadow.ApplyMask(Mask)
		  
		  G.DrawPicture(Shadow, 0, 1)
		  G.DrawPicture(Foreground, 0, 0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Fill(G As Graphics)
		  G.ForeColor = &cFFFFFF
		  G.FillRect(-1, -1, G.Width + 2, G.Height + 2)
		  
		  G.ForeColor = &cEBEBEB
		  G.FillRect(1, G.Height / 2, G.Width - 2, (G.Height / 2) - 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Button As FooterBarButton) As Integer
		  For I As Integer = 0 To UBound(Self.mButtons)
		    If Self.mButtons(I) = Button Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Button As FooterBarButton)
		  Dim Idx As Integer = Self.IndexOf(Button)
		  If Idx = -1 Then
		    Self.mButtons.Insert(Index, Button)
		    Button.AddObserver(Self, "Alignment", "Caption", "Enabled", "Icon")
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHoldTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Self.mMouseHeld Then
		    Return
		  End If
		  
		  Self.mNoActionOnRelease = RaiseEvent MouseHold(Self.mPressTarget)
		  Self.mMouseHeld = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As Text, Value As Auto)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Key
		  #Pragma Unused Value
		  
		  Self.Invalidate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintInto(G As Graphics)
		  Dim Owner As RectControl = Self.Parent
		  Dim Enabled As Boolean = Self.Enabled
		  While Enabled And Owner <> Nil
		    Enabled = Enabled And Owner.Enabled
		    Owner = Owner.Parent
		  Wend
		  
		  If UBound(Self.mButtons) = -1 Then
		    Self.Fill(G)
		    Return
		  End If
		  
		  G.Bold = True
		  
		  Dim LeftButtons(), CenterButtons(), RightButtons() As FooterBarButton
		  Dim LeftWidth, CenterWidth, RightWidth As Integer
		  For I As Integer = 0 To UBound(Self.mButtons)
		    Dim Button As FooterBarButton = Self.mButtons(I)
		    Dim Width As Integer = (ButtonPadding * 2)
		    If Button.Icon <> Nil And Button.Caption <> "" Then
		      Width = Width + ButtonPadding
		    End If
		    If Button.Icon <> Nil Then
		      Width = Width + 16
		    End If
		    If Button.Caption <> "" Then
		      Width = Width + Ceil(G.StringWidth(Button.Caption))
		    End If
		    Button.Width = Width
		    
		    Select Case Button.Alignment
		    Case FooterBarButton.AlignCenter
		      CenterButtons.Append(Button)
		      CenterWidth = CenterWidth + Button.Width
		    Case FooterBarButton.AlignRight
		      RightButtons.Append(Button)
		      RightWidth = RightWidth + Button.Width
		    Else
		      LeftButtons.Append(Button)
		      LeftWidth = LeftWidth + Button.Width
		    End Select
		  Next
		  
		  LeftWidth = LeftWidth + UBound(LeftButtons) + 1
		  CenterWidth = CenterWidth + if(UBound(CenterButtons) > -1, UBound(CenterButtons) + 2, 0)
		  RightWidth = RightWidth + UBound(RightButtons) + 1
		  
		  Dim FillLeft, NextLeft As Integer
		  
		  If UBound(LeftButtons) > -1 Then
		    NextLeft = 0
		    For Each Button As FooterBarButton In LeftButtons
		      Dim Rect As New Xojo.Core.Rect(NextLeft, 0, Button.Width, G.Height)
		      Dim Clip As Graphics = G.Clip(Rect.Left, Rect.Top, Rect.Width, Rect.Height)
		      Self.DrawButton(Clip, Button, Enabled)
		      Button.Rect = Rect
		      NextLeft = NextLeft + Button.Width
		      
		      G.ForeColor = BorderColor
		      G.DrawLine(NextLeft, 0, NextLeft, G.Height)
		      NextLeft = NextLeft + 1
		    Next
		    FillLeft = NextLeft
		  End If
		  
		  If UBound(CenterButtons) > -1 Then
		    NextLeft = (G.Width - CenterWidth) / 2
		    Dim Between As Graphics = G.Clip(FillLeft, 0, NextLeft - FillLeft, G.Height)
		    Self.Fill(Between)
		    
		    G.ForeColor = BorderColor
		    G.DrawLine(NextLeft, 0, NextLeft, G.Height)
		    NextLeft = NextLeft + 1
		    
		    For Each Button As FooterBarButton In CenterButtons
		      Dim Rect As New Xojo.Core.Rect(NextLeft, 0, Button.Width, G.Height)
		      Dim Clip As Graphics = G.Clip(Rect.Left, Rect.Top, Rect.Width, Rect.Height)
		      Self.DrawButton(Clip, Button, Enabled)
		      Button.Rect = Rect
		      NextLeft = NextLeft + Button.Width
		      
		      G.ForeColor = BorderColor
		      G.DrawLine(NextLeft, 0, NextLeft, G.Height)
		      NextLeft = NextLeft + 1
		    Next
		    FillLeft = NextLeft
		  End If
		  
		  If UBound(RightButtons) > -1 Then
		    NextLeft = G.Width - RightWidth
		    Dim Between As Graphics = G.Clip(FillLeft, 0, NextLeft - FillLeft, G.Height)
		    Self.Fill(Between)
		    
		    For Each Button As FooterBarButton In RightButtons
		      G.ForeColor = BorderColor
		      G.DrawLine(NextLeft, 0, NextLeft, G.Height)
		      NextLeft = NextLeft + 1
		      
		      Dim Rect As New Xojo.Core.Rect(NextLeft, 0, Button.Width, G.Height)
		      Dim Clip As Graphics = G.Clip(Rect.Left, Rect.Top, Rect.Width, Rect.Height)
		      Self.DrawButton(Clip, Button, Enabled)
		      Button.Rect = Rect
		      NextLeft = NextLeft + Button.Width
		    Next
		  Else
		    Dim Between As Graphics = G.Clip(FillLeft, 0, G.Width - FillLeft, G.Height)
		    Self.Fill(Between)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Button As FooterBarButton)
		  Dim Idx As Integer = Self.IndexOf(Button)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Dim Button As FooterBarButton = Self.mButtons(Index)
		  Button.RemoveObserver(Self, "Alignment", "Caption", "Enabled", "Icon")
		  Self.mButtons.Remove(Index)
		  Self.Invalidate
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action(Button As FooterBarButton)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseHold(Button As FooterBarButton) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mButtons() As FooterBarButton
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoldTimer As Timer
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

	#tag Property, Flags = &h21
		Private mPressTarget As FooterBarButton
	#tag EndProperty


	#tag Constant, Name = BorderColor, Type = Color, Dynamic = False, Default = \"&cCCCCCC", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ButtonPadding, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant


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
			InitialValue="25"
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
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
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
