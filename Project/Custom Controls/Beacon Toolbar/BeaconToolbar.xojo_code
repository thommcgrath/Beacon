#tag Class
Protected Class BeaconToolbar
Inherits ControlCanvas
Implements ObservationKit.Observer
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
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim Point As New REALbasic.Point(X, Y)
		  Self.mMouseDownName = ""
		  Self.mMouseHeld = False
		  Self.mMouseDownX = X
		  Self.mMouseDownY = Y
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  
		  Tooltip.Hide
		  Xojo.Core.Timer.CancelCall(AddressOf ShowHoverTooltip)
		  
		  If Self.mResizerRect <> Nil And Self.mResizerRect.Contains(Point) Then
		    Self.mResizing = True
		    RaiseEvent ResizeStarted()
		    If Self.mResizerStyle = ResizerTypes.Horizontal Then
		      Self.mStartingSize = Self.Width
		      Self.mResizeOffset = X
		    ElseIf Self.mResizerStyle = ResizerTypes.Vertical Then
		      Self.mStartingSize = Self.Top
		      Self.mResizeOffset = Y
		    End If
		    Return True
		  End If
		  
		  If Self.mCaptionRect <> Nil And Self.mCaptionRect.Contains(Point) And Self.mCaptionEnabled Then
		    Self.mMouseDownName = Self.CaptionButtonName
		    Self.mPressedName = Self.CaptionButtonName
		    Self.Refresh
		    Return True
		  End If
		  
		  Dim HitItem As BeaconToolbarItem = Self.ItemAtPoint(Point)
		  If HitItem <> Nil And HitItem.Enabled Then
		    Self.mMouseDownName = HitItem.Name
		    Self.mPressedName = Self.mMouseDownName
		    Self.Refresh
		    If HitItem.HasMenu Then
		      Self.mHoldTimer.Mode = Timer.ModeSingle
		    End If
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If X = Self.mMouseX And Y = Self.mMouseY Then
		    Return
		  End If
		  
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  
		  If Self.mResizing Then
		    Dim DeltaX As Integer = 0
		    Dim DeltaY As Integer = 0
		    
		    If Self.mResizerStyle = ResizerTypes.Horizontal Then
		      DeltaX = X - Self.mResizeOffset
		      
		      Dim NewWidth As Integer = Self.Width + DeltaX
		      RaiseEvent ShouldResize(NewWidth)
		      Self.mResizeOffset = Self.mResizeOffset + (Self.Width - Self.mStartingSize)
		      Self.mStartingSize = Self.Width
		    ElseIf Self.mResizerStyle = ResizerTypes.Vertical Then
		      DeltaY = Y - Self.mResizeOffset
		      
		      Dim NewTop As Integer = Self.Top + DeltaY
		      RaiseEvent ShouldResize(NewTop)
		    End If
		    
		    RaiseEvent ResizerDragged(DeltaX, DeltaY)
		    
		    Return
		  End If
		  
		  If Self.mMouseDownName = Self.CaptionButtonName Then
		    Dim Rect As REALbasic.Rect = Self.mCaptionRect
		    If Rect.Contains(New REALbasic.Point(X, Y)) Then
		      If Self.mPressedName <> Self.CaptionButtonName Then
		        Self.mPressedName = Self.CaptionButtonName
		        Self.Invalidate
		      End If
		    Else
		      If Self.mPressedName <> "" Then
		        Self.mPressedName = ""
		        Self.Invalidate
		      End If
		    End If
		    Return
		  End If
		  
		  If Self.mMouseDownName <> "" Then
		    Dim Item As BeaconToolbarItem = Self.ItemWithName(Self.mMouseDownName)
		    If Item <> Nil Then
		      Dim Rect As REALbasic.Rect = Item.Rect
		      If Rect.Contains(New REALbasic.Point(X, Y)) Then
		        If Self.mPressedName <> Item.Name Then
		          Self.mPressedName = Item.Name
		          Self.Invalidate
		        End If
		        If Not Self.mMouseHeld Then
		          Self.mHoldTimer.Reset
		          Self.mHoldTimer.Mode = Timer.ModeSingle
		        End If
		      Else
		        If Self.mPressedName <> "" Then
		          Self.mPressedName = ""
		          Self.Invalidate
		        End If
		        Self.mHoldTimer.Reset
		        Self.mHoldTimer.Mode = Timer.ModeOff
		      End If
		      Return
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  Self.MouseCursor = Nil
		  Self.HoverItem = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Self.mResizerRect = Nil Then
		    Return
		  End If
		  
		  Dim Point As New REALbasic.Point(X, Y)
		  If Self.mResizerRect.Contains(Point) Then
		    If Self.mResizerStyle = ResizerTypes.Horizontal Then
		      Self.MouseCursor = System.Cursors.SplitterEastWest
		    ElseIf Self.mResizerStyle = ResizerTypes.Vertical Then
		      Self.MouseCursor = System.Cursors.SplitterNorthSouth
		    End If
		  Else
		    Self.MouseCursor = Nil
		  End If
		  
		  Self.HoverItem = Self.ItemAtPoint(Point)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Self.mMouseX = X
		  Self.mMouseY = Y
		  
		  Self.mHoldTimer.Reset
		  Self.mHoldTimer.Mode = Timer.ModeOff
		  
		  If Self.mResizing Then
		    Self.mResizing = False
		    RaiseEvent ResizeFinished()
		    Return
		  End If
		  
		  If Self.mMouseDownName = Self.CaptionButtonName Then
		    Dim Rect As REALbasic.Rect = Self.mCaptionRect
		    If Rect.Contains(New REALbasic.Point(X, Y)) Then
		      RaiseEvent CaptionClicked()
		    End If
		    Self.mPressedName = ""
		    Self.mMouseDownName = ""
		    Self.Invalidate
		    Return
		  End If
		  
		  If Self.mMouseDownName <> "" Then
		    Dim Item As BeaconToolbarItem = Self.ItemWithName(Self.mMouseDownName)
		    If Item <> Nil And Item.Rect.Contains(New REALbasic.Point(X, Y)) And Not Self.mMouseHeld Then
		      // Action
		      RaiseEvent Action(Item)
		    End If
		    Self.mPressedName = ""
		    Self.mMouseDownName = ""
		    Self.Invalidate
		    Return
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim ContentTop As Integer = 0
		  Dim ContentHeight As Integer = G.Height
		  If Self.mHasTopBorder Then
		    ContentTop = ContentTop + 1
		    ContentHeight = ContentHeight - 1
		  End If
		  If Self.mHasBottomBorder Then
		    ContentHeight = ContentHeight - 1
		  End If
		  
		  Dim Clip As Graphics = G.Clip(0, ContentTop, G.Width, ContentHeight)
		  Self.PaintContent(Clip)
		  
		  G.ForeColor = Self.ColorProfile.BorderColor
		  If Self.mHasTopBorder Then
		    G.DrawLine(-1, 0, G.Width + 1, 0)
		  End If
		  If Self.mHasBottomBorder Then
		    G.DrawLine(-1, G.Height - 1, G.Width + 1, G.Height - 1)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ComputeColors()
		  Self.mColorSet = Self.ComputeColorSet(Self.ColorProfile.SelectedForegroundColor)
		  Self.mColorSetClear = Self.ComputeColorSet(&cFFFFFF)
		  
		  #if false
		    Self.mFillColor = Self.ColorProfile.SelectedForegroundColor
		    #if BeaconUI.ToolbarHasBackground
		      Self.mFillColorDisabled = Self.mFillColor.BlendWith(Self.ColorProfile.BackgroundColor, 0.4)
		      Self.mBorderShadowColor = Self.ColorProfile.BackgroundColor.BlendWith(&cFFFFFF, 0.35)
		    #else
		      Self.mFillColorDisabled = Self.mFillColor.Lighter(0.5)
		      Self.mBorderShadowColor = &cFFFFFF40
		    #endif
		    
		    If BeaconUI.ToolbarHasBackground = False Or Self.ColorProfile.BackgroundColor.Luminance >= 0.65 Then
		      Self.mBorderColor = Self.mFillColor.Darker(0.5)
		      Self.mBorderColorDisabled = Self.mFillColorDisabled.Darker(0.3)
		    Else
		      Self.mBorderColor = Self.ColorProfile.BorderColor 
		      Self.mBorderColorDisabled = Self.mBorderColor 
		    End If
		    
		    Self.mBorderColorPressed = Self.mBorderColor.Darker(0.5)
		    Self.mFillColorPressed = Self.mFillColor.Darker(0.5)
		    
		    If Self.mFillColor.IsBright Then
		      Self.mIconColor = Self.mFillColor.Darker(0.7)
		      Self.mShadowColor = Self.mFillColor.Lighter(0.7)
		    Else
		      Self.mIconColor = &cFFFFFF
		      Self.mShadowColor = Self.mFillColor.Darker(0.4)
		    End If
		    
		    Self.mIconColorPressed = Self.mIconColor.Darker(0.5)
		    Self.mIconColorDisabled = Self.mIconColor.BlendWith(Self.mFillColorDisabled, 0.7)
		    
		    Self.mShadowColorPressed = Self.mShadowColor.Darker(0.5)
		    Self.mShadowColorDisabled = Self.mShadowColor.BlendWith(Self.mFillColorDisabled, 0.7)
		    
		    // Clear, when the window is not in the foreground on macOS
		    
		    Self.mFillColorClear = &cFFFFFF
		    #if BeaconUI.ToolbarHasBackground
		      Self.mFillColorClearDisabled = Self.mFillColorClear.BlendWith(Self.ColorProfile.BackgroundColor, 0.4)
		    #else
		      Self.mFillColorClearDisabled = Self.mFillColorClear.Lighter(0.5)
		    #endif
		    
		    Self.mBorderColorClear = Self.mFillColorClear.Darker(0.5)
		    Self.mBorderColorClearDisabled = Self.mFillColorClearDisabled.Darker(0.3)
		    
		    Self.mIconColorClear = Self.mFillColorClear.Darker(0.7)
		    Self.mIconColorClearDisabled = Self.mIconColorClear.BlendWith(Self.mFillColorClearDisabled, 0.7)
		    
		    Self.mShadowColorClear = Self.mFillColorClear.Lighter(0.7)
		    Self.mShadowColorClearDisabled = Self.mShadowColorClear.BlendWith(Self.mFillColorClearDisabled, 0.7)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ComputeColorSet(FillColor As Color) As ColorSet
		  #if BeaconUI.ToolbarHasBackground
		    Dim HasDarkBackground As Boolean = Self.ColorProfile.BackgroundColor.Luminance < 0.65
		  #else
		    Dim HasDarkBackground As Boolean = False
		  #endif
		  
		  Dim Set As ColorSet
		  Set.FillColor = FillColor
		  
		  If HasDarkBackground Then
		    Set.BorderColor = Self.ColorProfile.BorderColor
		    Set.BorderShadowColor = Self.ColorProfile.BackgroundColor.BlendWith(&cFFFFFF, 0.35)
		  Else
		    Set.BorderColor = FillColor.Darker(0.5)
		    Set.BorderShadowColor = &cFFFFFF40
		  End If
		  
		  If FillColor.IsBright Then
		    Set.IconColor = FillColor.Darker(0.7)
		    Set.ShadowColor = FillColor.Lighter(0.35)
		  Else
		    Set.IconColor = &cFFFFFF
		    Set.ShadowColor = FillColor.Darker(0.4)
		  End If
		  
		  Set.FillColorPressed = FillColor.Darker(0.5)
		  Set.BorderColorPressed = Set.BorderColor.Darker(0.5)
		  Set.IconColorPressed = Set.IconColor.Darker(0.5)
		  Set.ShadowColorPressed = Set.ShadowColor.Darker(0.5)
		  
		  Set.IconColorDisabled = Set.IconColor.BlendWith(FillColor, 0.7)
		  Set.ShadowColorDisabled = Set.ShadowColor.BlendWith(FillColor, 0.7)
		  
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  Self.mLeftItems = New BeaconToolbarItemArray
		  Self.mLeftItems.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  Self.mRightItems = New BeaconToolbarItemArray
		  Self.mRightItems.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  Self.mHoldTimer = New Timer
		  Self.mHoldTimer.Mode = Timer.ModeOff
		  Self.mHoldTimer.Period = 250
		  AddHandler Self.mHoldTimer.Action, WeakAddressOf Self.mHoldTimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawButton(G As Graphics, Button As BeaconToolbarItem, Rect As REALbasic.Rect, Mode As ButtonModes, Highlighted As Boolean)
		  Self.DrawButtonFrame(G, Rect, Mode, Highlighted, Button.HasMenu)
		  If Button.Icon = Nil Then
		    Return
		  End If
		  
		  Dim Set As ColorSet = If(Highlighted, Self.mColorSet, Self.mColorSetClear)
		  Dim IconColor, ShadowColor As Color
		  Select Case Mode
		  Case ButtonModes.Pressed
		    IconColor = Set.IconColorPressed
		    ShadowColor = Set.ShadowColorPressed
		  Case ButtonModes.Disabled
		    IconColor = Set.IconColorDisabled
		    ShadowColor = Set.ShadowColorDisabled
		  Else
		    IconColor = Set.IconColor
		    ShadowColor = Set.ShadowColor
		  End Select
		  
		  Dim Shadow As Picture = BeaconUI.IconWithColor(Button.Icon, ShadowColor)
		  G.DrawPicture(Shadow, Rect.Left + ((Rect.Width - Shadow.Width) / 2), Rect.Top + 1 + ((Rect.Height - Shadow.Height) / 2))
		  Dim Icon As Picture = BeaconUI.IconWithColor(Button.Icon, IconColor)
		  G.DrawPicture(Icon, Rect.Left + ((Rect.Width - Icon.Width) / 2), Rect.Top + ((Rect.Height - Icon.Height) / 2))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawButtonFrame(G As Graphics, Rect As REALbasic.Rect, Mode As ButtonModes, Highlighted As Boolean, WithMenu As Boolean)
		  Dim Set As ColorSet = If(Highlighted, Self.mColorSet, Self.mColorSetClear)
		  Dim FillColor, BorderColor, ShadowColor As Color
		  Select Case Mode
		  Case ButtonModes.Pressed
		    FillColor = Set.FillColorPressed
		    BorderColor = Set.BorderColorPressed
		  Else
		    FillColor = Set.FillColor
		    BorderColor = Set.BorderColor
		  End Select
		  ShadowColor = Set.BorderShadowColor
		  
		  Const SourceWidth = 40
		  Const SourceHeight = 42
		  
		  Dim LeftRect As New REALbasic.Rect(0, 0, 12, 42)
		  Dim FillRect As New REALbasic.Rect(12, 0, 1, 42)
		  Dim RightRect As New REALbasic.Rect(40 - 12, 0, 12, 42)
		  Dim CenterRect As New REALbasic.Rect(16, 0, 8, 42)
		  Dim Top As Integer = Rect.Top + ((Rect.Height - 42) / 2)
		  
		  Rect = New REALbasic.Rect(Rect.Left - 8, Rect.Top - 8, Rect.Width + 16, Rect.Height + 16)
		  
		  Dim BorderMask As Picture = BeaconUI.IconWithColor(If(WithMenu, ImgToolbarMenuBorderMask, ImgToolbarButtonBorderMask), BorderColor)
		  Dim FillMask As Picture = BeaconUI.IconWithColor(If(WithMenu, ImgToolbarMenuFillMask, ImgToolbarButtonFillMask), FillColor)
		  Dim ShadowMask As Picture = BeaconUI.IconWithColor(If(WithMenu, ImgToolbarMenuBorderMask, ImgToolbarButtonBorderMask), ShadowColor)
		  
		  Dim Temp As New Picture(SourceWidth * G.ScaleX, SourceHeight * G.ScaleY)
		  Temp.HorizontalResolution = 72 * G.ScaleX
		  Temp.VerticalResolution = 72 * G.ScaleY
		  Temp.Graphics.ScaleX = G.ScaleX
		  Temp.Graphics.ScaleY = G.ScaleY
		  Temp.Graphics.DrawPicture(ShadowMask, 0, 1)
		  Temp.Graphics.DrawPicture(BorderMask, 0, 0)
		  Temp.Graphics.DrawPicture(FillMask, 0, 0)
		  Dim Source As New Picture(SourceWidth, SourceHeight, Array(Temp))
		  
		  G.DrawPicture(Source, Rect.Left, Top, LeftRect.Width, LeftRect.Height, LeftRect.Left, LeftRect.Top, LeftRect.Width, LeftRect.Height)
		  G.DrawPicture(Source, Rect.Right - RightRect.Width, Top, RightRect.Width, RightRect.Height, RightRect.Left, RightRect.Top, RightRect.Width, RightRect.Height)
		  
		  Dim TailLeft As Integer = Rect.HorizontalCenter - (CenterRect.Width / 2)
		  Dim TailRight As Integer = TailLeft + CenterRect.Width
		  
		  Dim LeftSectionLeft As Integer = Rect.Left + LeftRect.Width
		  Dim LeftSectionRight As Integer = TailLeft
		  
		  Dim RightSectionLeft As Integer = TailRight
		  Dim RightSectionRight As Integer = Rect.Right - RightRect.Width
		  
		  G.DrawPicture(Source, TailLeft, Top, CenterRect.Width, CenterRect.Height, CenterRect.Left, CenterRect.Top, CenterRect.Width, CenterRect.Height)
		  G.DrawPicture(Source, LeftSectionLeft, Top, LeftSectionRight - LeftSectionLeft, FillRect.Height, FillRect.Left, FillRect.Top, FillRect.Width, FillRect.Height)
		  G.DrawPicture(Source, RightSectionLeft, Top, RightSectionRight - RightSectionLeft, FillRect.Height, FillRect.Left, FillRect.Top, FillRect.Width, FillRect.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HoverItem() As BeaconToolbarItem
		  Return Self.mHoverItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HoverItem(Assigns Item As BeaconToolbarItem)
		  If Self.mHoverItem = Item Then
		    Return
		  End If
		  
		  Self.mHoverItem = Item
		  
		  Tooltip.Hide
		  Xojo.Core.Timer.CancelCall(AddressOf ShowHoverTooltip)
		  
		  If Item <> Nil And Item.HelpTag <> "" Then
		    Xojo.Core.Timer.CallLater(2000, AddressOf ShowHoverTooltip)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemAtPoint(X As Integer, Y As Integer) As BeaconToolbarItem
		  Return Self.ItemAtPoint(New REALbasic.Point(X, Y))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemAtPoint(Point As REALbasic.Point) As BeaconToolbarItem
		  For I As Integer = 0 To Self.mLeftItems.UBound
		    If Self.mLeftItems(I).Rect.Contains(Point) Then
		      Return Self.mLeftItems(I)
		    End If
		  Next
		  
		  For I As Integer = 0 To Self.mRightItems.UBound
		    If Self.mRightItems(I).Rect.Contains(Point) Then
		      Return Self.mRightItems(I)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ItemWithName(Name As String) As BeaconToolbarItem
		  For I As Integer = 0 To Self.mLeftItems.UBound
		    If Self.mLeftItems(I).Name = Name Then
		      Return Self.mLeftItems(I)
		    End If
		  Next
		  For I As Integer = 0 To Self.mRightItems.UBound
		    If Self.mRightItems(I).Name = Name Then
		      Return Self.mRightItems(I)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHoldTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Self.mMouseHeld Or Self.mPressedName = "" Then
		    Return
		  End If
		  
		  Dim Item As BeaconToolbarItem = Self.ItemWithName(Self.mPressedName)
		  Dim Menu As New MenuItem
		  RaiseEvent BuildMenu(Item, Menu)
		  Self.mMouseHeld = True
		  
		  If Menu.Count = 0 Then
		    Return
		  End If
		  
		  Dim Position As Xojo.Core.Point = Self.Window.GlobalPosition
		  Dim Choice As MenuItem = Menu.PopUp(Position.X + Self.Left + Item.Rect.Left, Position.Y + Self.Top + Item.Rect.Bottom)
		  If Choice <> Nil Then
		    RaiseEvent HandleMenuAction(Item, Choice)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As Text, Value As Auto)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Key
		  #Pragma Unused Value
		  
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Lookup(Name As String) As BeaconToolbarItem
		  Return Self.ItemWithName(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PaintContent(G As Graphics)
		  Const CellPadding = 8
		  Const ButtonSize = 24
		  
		  Self.ComputeColors()
		  
		  #if BeaconUI.ToolbarHasBackground
		    G.ForeColor = Self.ColorProfile.BackgroundColor
		    G.FillRect(0, 0, G.Width, G.Height)
		  #endif
		  
		  Dim Highlighted As Boolean = True
		  #if TargetCocoa And BeaconUI.ToolbarHasBackground = False
		    Declare Function IsMainWindow Lib "Cocoa.framework" Selector "isMainWindow" (Target As Integer) As Boolean
		    Declare Function IsKeyWindow Lib "Cocoa.framework" Selector "isKeyWindow" (Target As Integer) As Boolean
		    Highlighted = IsKeyWindow(Self.TrueWindow.Handle) Or IsMainWindow(Self.TrueWindow.Handle)
		  #endif
		  
		  Dim ContentRect As New REALbasic.Rect(CellPadding, CellPadding, G.Width - (CellPadding * 2), G.Height - (CellPadding * 2))
		  
		  If Self.mResizerStyle <> ResizerTypes.None Then
		    Const ResizerStripes = 3
		    Dim ResizerHeight As Integer = 12
		    
		    Dim ResizerWidth As Integer = (ResizerStripes * 2) + (ResizerStripes - 1)
		    If Self.mResizerStyle = ResizerTypes.Vertical Then
		      Dim Temp as Integer = ResizerHeight
		      ResizerHeight = ResizerWidth
		      ResizerWidth = Temp
		    End If
		    
		    ContentRect.Right = ContentRect.Right - (CellPadding + ResizerWidth)
		    
		    Dim ResizerLeft As Integer = ContentRect.Right + CellPadding
		    Dim ResizerTop As Integer = (G.Height - ResizerHeight) / 2
		    
		    Self.mResizerRect = New REALbasic.Rect(ResizerLeft, 0, G.Width - ResizerLeft, G.Height)
		    
		    Dim LeftColor, RightColor As Color
		    #if BeaconUI.ToolbarHasBackground
		      LeftColor = Self.ColorProfile.ForegroundColor
		      RightColor = Self.ColorProfile.ShadowColor
		      LeftColor = RGB(LeftColor.Red, LeftColor.Green, LeftColor.Blue, 155)
		      RightColor = RGB(RightColor.Red, RightColor.Green, RightColor.Blue, 155)
		    #else
		      LeftColor = &c0000009B
		      RightColor = &cFFFFFF00
		    #endif
		    
		    For I As Integer = 1 To ResizerStripes
		      If Self.mResizerStyle = ResizerTypes.Vertical Then
		        Dim Y As Integer = ResizerTop + ((I - 1) * 3)
		        G.ForeColor = LeftColor
		        G.DrawLine(ResizerLeft, Y, ResizerLeft + ResizerWidth, Y)
		        G.ForeColor = RightColor
		        G.DrawLine(ResizerLeft + 1, Y + 1, ResizerLeft + ResizerWidth + 1, Y + 1)
		      Else
		        Dim X As Integer = ResizerLeft + ((I - 1) * 3)
		        G.ForeColor = LeftColor
		        G.DrawLine(X, ResizerTop, X, ResizerTop + ResizerHeight)
		        G.ForeColor = RightColor
		        G.DrawLine(X + 1, ResizerTop + 1, X + 1, ResizerTop + 1 + ResizerHeight)
		      End If
		    Next
		  Else
		    Self.mResizerRect = Nil
		  End If
		  
		  Dim NextLeft As Integer = ContentRect.Left
		  Dim NextRight As Integer = ContentRect.Right
		  Dim ItemsPerSide As Integer = Max(Self.LeftItems.Count, Self.RightItems.Count)
		  ContentRect.Left = ContentRect.Left + (ItemsPerSide * (ButtonSize + CellPadding))
		  ContentRect.Width = ContentRect.Width - ((ItemsPerSide * 2) * (ButtonSize + CellPadding))
		  
		  For I As Integer = 0 To Self.mLeftItems.UBound
		    Dim Item As BeaconToolbarItem = Self.mLeftItems(I)
		    Dim Mode As ButtonModes = ButtonModes.Normal
		    If Self.mPressedName = Item.Name Then
		      Mode = ButtonModes.Pressed
		    End If
		    If Not Item.Enabled Then
		      Mode = ButtonModes.Disabled
		    End If
		    
		    Item.Rect = New REALbasic.Rect(NextLeft, CellPadding, ButtonSize, ButtonSize)
		    Self.DrawButton(G, Item, Item.Rect, Mode, Highlighted)
		    NextLeft = Item.Rect.Right + CellPadding
		  Next
		  
		  For I As Integer = 0 To Self.mRightItems.UBound
		    Dim Item As BeaconToolbarItem = Self.mRightItems(I)
		    Dim Mode As ButtonModes = ButtonModes.Normal
		    If Self.mPressedName = Item.Name Then
		      Mode = ButtonModes.Pressed
		    End If
		    If Not Item.Enabled Then
		      Mode = ButtonModes.Disabled
		    End If
		    
		    Item.Rect = New REALbasic.Rect(NextRight - ButtonSize, CellPadding, ButtonSize, ButtonSize)
		    Self.DrawButton(G, Item, Item.Rect, Mode, Highlighted)
		    NextRight = Item.Rect.Left - CellPadding
		  Next
		  
		  If Self.Caption <> "" Then
		    Dim Caption As String = Self.Caption.NthField(EndOfLine, 1)
		    Dim Subcaption As String = Self.Caption.NthField(EndOfLine, 2)
		    
		    Dim CaptionSize, SubcaptionSize As Double = 0
		    If Subcaption <> "" Then
		      CaptionSize = 11
		      SubcaptionSize = 8
		    End If
		    
		    G.TextSize = CaptionSize
		    Dim CaptionWidth As Integer = Ceil(G.StringWidth(Caption))
		    G.TextSize = SubcaptionSize
		    Dim SubcaptionWidth As Integer = Ceil(G.StringWidth(Subcaption))
		    
		    If Self.CaptionIsButton Then
		      Const CaptionPadding = 8
		      
		      Dim ButtonWidth As Integer = Min(Max(CaptionWidth, SubcaptionWidth) + (CaptionPadding * 2), ContentRect.Width)
		      Dim ButtonRect As New REALbasic.Rect(ContentRect.Left + ((ContentRect.Width - ButtonWidth) / 2), CellPadding, ButtonWidth, ButtonSize)
		      
		      Dim Mode As ButtonModes = ButtonModes.Normal
		      If Self.mPressedName = Self.CaptionButtonName Then
		        Mode = ButtonModes.Pressed
		      End If
		      If Not Self.mCaptionEnabled Then
		        Mode = ButtonModes.Disabled
		      End If
		      
		      Dim Set As ColorSet = If(Highlighted, Self.mColorSet, Self.mColorSetClear)
		      Dim CaptionColor, ShadowColor As Color
		      Select Case Mode
		      Case ButtonModes.Pressed
		        CaptionColor = Set.IconColorPressed
		        ShadowColor = Set.ShadowColorPressed
		      Case ButtonModes.Disabled
		        CaptionColor = Set.IconColorDisabled
		        ShadowColor = Set.ShadowColorDisabled
		      Else
		        CaptionColor = Set.IconColor
		        ShadowColor = Set.ShadowColor
		      End Select
		      
		      Self.DrawButtonFrame(G, ButtonRect, Mode, Highlighted, False)
		      
		      Dim CaptionLeft As Integer = Max(ButtonRect.HorizontalCenter - (CaptionWidth / 2), ButtonRect.Left + CaptionPadding)   
		      Dim SubcaptionLeft As Integer = Max(ButtonRect.HorizontalCenter - (SubcaptionWidth / 2), ButtonRect.Left + CaptionPadding)
		      
		      G.TextSize = CaptionSize
		      Dim CaptionHeight As Integer = G.CapHeight
		      G.TextSize = SubcaptionSize
		      Dim SubcaptionHeight As Integer = G.CapHeight
		      
		      Dim TextHeight As Integer = CaptionHeight
		      If Subcaption <> "" Then
		        TextHeight = TextHeight + 3 + SubcaptionHeight
		      End If
		      
		      Dim TextTop As Integer = Ceil(ButtonRect.VerticalCenter - (TextHeight / 2))
		      Dim CaptionBottom As Integer = TextTop + CaptionHeight
		      Dim SubcaptionBottom As Integer = TextTop + TextHeight
		      
		      G.TextSize = CaptionSize
		      G.ForeColor = ShadowColor
		      G.DrawString(Caption, CaptionLeft, CaptionBottom + 1, ButtonRect.Width - (CaptionPadding * 2), True)
		      G.ForeColor = CaptionColor
		      G.DrawString(Caption, CaptionLeft, CaptionBottom, ButtonRect.Width - (CaptionPadding * 2), True)
		      If Subcaption <> "" Then
		        G.TextSize = SubcaptionSize
		        G.ForeColor = ShadowColor
		        G.DrawString(Subcaption, SubcaptionLeft, SubcaptionBottom + 1, ButtonRect.Width - (CaptionPadding * 2), True)
		        G.ForeColor = CaptionColor
		        G.DrawString(Subcaption, SubcaptionLeft, SubcaptionBottom, ButtonRect.Width - (CaptionPadding * 2), True)
		      End If
		      
		      Self.mCaptionRect = ButtonRect
		    Else
		      CaptionWidth = Min(CaptionWidth, ContentRect.Width)
		      Dim CaptionLeft As Integer = ContentRect.Left + ((ContentRect.Width - CaptionWidth) / 2)
		      Dim CaptionBottom As Integer = ContentRect.Top + (ContentRect.Height / 2) + ((G.TextAscent * 0.8) / 2)
		      
		      G.ForeColor = If(BeaconUI.ToolbarHasBackground, Self.ColorProfile.ShadowColor, &cFFFFFF)
		      G.DrawString(Self.Caption, CaptionLeft, CaptionBottom + 1, CaptionWidth, True)
		      G.ForeColor = If(BeaconUI.ToolbarHasBackground, Self.ColorProfile.ForegroundColor, &c333333)
		      G.DrawString(Self.Caption, CaptionLeft, CaptionBottom, CaptionWidth, True)
		      
		      Self.mCaptionRect = Nil
		    End If
		  Else
		    Self.mCaptionRect = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHoverTooltip()
		  If Self.mHoverItem = Nil Then
		    Return
		  End If
		  
		  Tooltip.Show(Self.mHoverItem.HelpTag, System.MouseX, System.MouseY + 16)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action(Item As BeaconToolbarItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Activate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BuildMenu(Item As BeaconToolbarItem, Menu As MenuItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CaptionClicked()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Deactivate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HandleMenuAction(Item As BeaconToolbarItem, ChosenItem As MenuItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResizeFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResizerDragged(DeltaX As Integer, DeltaY As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResizeStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(ByRef NewSize As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mCaption, Value, 0) <> 0 Then
			    Self.mCaption = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaptionEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCaptionEnabled <> Value Then
			    Self.mCaptionEnabled = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		CaptionEnabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaptionIsButton
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCaptionIsButton <> Value Then
			    Self.mCaptionIsButton = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		CaptionIsButton As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasBottomBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasBottomBorder <> Value Then
			    Self.mHasBottomBorder = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		HasBottomBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasTopBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasTopBorder <> Value Then
			    Self.mHasTopBorder = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		HasTopBorder As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLeftItems
			End Get
		#tag EndGetter
		LeftItems As BeaconToolbarItemArray
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaptionEnabled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaptionIsButton As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaptionRect As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mColorSet As ColorSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mColorSetClear As ColorSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasBottomBorder As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasTopBorder As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoldTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverItem As BeaconToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLeftItems As BeaconToolbarItemArray
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownX As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownY As Integer
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
		Private mPressedName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResizeOffset As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResizerRect As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResizerStyle As BeaconToolbar.ResizerTypes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResizing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightItems As BeaconToolbarItemArray
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartingSize As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mResizerStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mResizerStyle <> Value Then
			    Self.mResizerStyle = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Resizer As BeaconToolbar.ResizerTypes
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mRightItems
			End Get
		#tag EndGetter
		RightItems As BeaconToolbarItemArray
	#tag EndComputedProperty


	#tag Constant, Name = CaptionButtonName, Type = String, Dynamic = False, Default = \"CaptionButton", Scope = Private
	#tag EndConstant


	#tag Structure, Name = ColorSet, Flags = &h21
		FillColor As Color
		  FillColorPressed As Color
		  BorderColor As Color
		  BorderColorPressed As Color
		  BorderShadowColor As Color
		  IconColor As Color
		  IconColorPressed As Color
		  IconColorDisabled As Color
		  ShadowColor As Color
		  ShadowColorPressed As Color
		ShadowColorDisabled As Color
	#tag EndStructure


	#tag Enum, Name = ButtonModes, Type = Integer, Flags = &h21
		Normal
		  Disabled
		Pressed
	#tag EndEnum

	#tag Enum, Name = ResizerTypes, Type = Integer, Flags = &h0
		None
		  Horizontal
		Vertical
	#tag EndEnum


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
			Group="Appearance"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=true
			Group="Behavior"
			InitialValue="Untitled"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaptionEnabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaptionIsButton"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Group="Behavior"
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
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBottomBorder"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasTopBorder"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="41"
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
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
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
			Name="Resizer"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="BeaconToolbar.ResizerTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollSpeed"
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
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
			Group="Behavior"
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
			InitialValue="200"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
