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
		    Self.mStartingWidth = Self.Width
		    Self.mResizeOffset = X
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
		    Dim NewSize As Integer = Self.mStartingWidth + (X - Self.mResizeOffset)
		    RaiseEvent ShouldResize(NewSize)
		    Self.mResizeOffset = Self.mResizeOffset + (Self.Width - Self.mStartingWidth)
		    Self.mStartingWidth = Self.Width
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
		    Self.MouseCursor = System.Cursors.SplitterEastWest
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
		  
		  Const CellPadding = 8
		  Const ButtonSize = 24
		  
		  Dim Highlighted As Boolean = True
		  #if TargetCocoa
		    Declare Function IsMainWindow Lib "Cocoa.framework" Selector "isMainWindow" (Target As Integer) As Boolean
		    Declare Function IsKeyWindow Lib "Cocoa.framework" Selector "isKeyWindow" (Target As Integer) As Boolean
		    Highlighted = IsKeyWindow(Self.TrueWindow.Handle) Or IsMainWindow(Self.TrueWindow.Handle)
		  #endif
		  
		  Dim ContentRect As New REALbasic.Rect(CellPadding, CellPadding, Self.Width - (CellPadding * 2), Self.Height - (CellPadding * 2))
		  
		  If Self.HasResizer Then
		    ContentRect.Right = ContentRect.Right - (CellPadding + ImgToolbarResizer.Width)
		    
		    Dim ResizerLeft As Integer = ContentRect.Right + CellPadding
		    Dim ResizerTop As Integer = (Self.Height - ImgToolbarResizer.Height) / 2
		    
		    Self.mResizerRect = New REALbasic.Rect(ResizerLeft, 0, Self.Width - ResizerLeft, Self.Height)
		    G.DrawPicture(ImgToolbarResizer, ResizerLeft, ResizerTop)
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
		      
		      Dim ColorValue As Integer = 255
		      Dim AlphaValue As Integer = 0
		      Dim Mode As ButtonModes = ButtonModes.Normal
		      If Self.mPressedName = Self.CaptionButtonName Then
		        Mode = ButtonModes.Pressed
		        ColorValue = 128
		      End If
		      If Not Self.mCaptionEnabled Then
		        Mode = ButtonModes.Disabled
		        AlphaValue = 128
		      End If
		      If Not Highlighted Then
		        ColorValue = 51
		      End If
		      
		      Self.DrawButtonFrame(G, ButtonRect, Mode, BeaconToolbarItem.DefaultColor, Highlighted, False)
		      
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
		      
		      G.ForeColor = RGB(ColorValue, ColorValue, ColorValue, AlphaValue)
		      G.TextSize = CaptionSize
		      G.DrawString(Caption, CaptionLeft, CaptionBottom, ButtonRect.Width - (CaptionPadding * 2), True)
		      If Subcaption <> "" Then
		        G.TextSize = SubcaptionSize
		        G.DrawString(Subcaption, SubcaptionLeft, SubcaptionBottom, ButtonRect.Width - (CaptionPadding * 2), True)
		      End If
		      
		      Self.mCaptionRect = ButtonRect
		    Else
		      CaptionWidth = Min(CaptionWidth, ContentRect.Width)
		      Dim CaptionLeft As Integer = ContentRect.Left + ((ContentRect.Width - CaptionWidth) / 2)
		      Dim CaptionBottom As Integer = ContentRect.Top + (ContentRect.Height / 2) + ((G.TextAscent * 0.8) / 2)
		      
		      G.ForeColor = &cFFFFFF
		      G.DrawString(Self.Caption, CaptionLeft, CaptionBottom + 1, CaptionWidth, True)
		      G.ForeColor = &c333333
		      G.DrawString(Self.Caption, CaptionLeft, CaptionBottom, CaptionWidth, True)
		      
		      Self.mCaptionRect = Nil
		    End If
		  Else
		    Self.mCaptionRect = Nil
		  End If
		  
		  G.ForeColor = Self.BorderColor
		  G.DrawLine(-1, G.Height - 1, G.Width + 1, G.Height - 1)
		End Sub
	#tag EndEvent


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
		  Self.DrawButtonFrame(G, Rect, Mode, Button.ButtonColor, Highlighted, Button.HasMenu)
		  If Button.Icon = Nil Then
		    Return
		  End If
		  
		  Dim IconColor As Color = &cFFFFFF
		  Select Case Mode
		  Case ButtonModes.Pressed
		    IconColor = &c808080
		  Case ButtonModes.Disabled
		    IconColor = &cFFFFFF80
		  End Select
		  If Not Highlighted Then
		    IconColor = RGB(51, 51, 51, IconColor.Alpha)
		  End If
		  
		  Dim Pic As Picture = BeaconUI.IconWithColor(Button.Icon, IconColor)
		  G.DrawPicture(Pic, Rect.Left + ((Rect.Width - Pic.Width) / 2), Rect.Top + ((Rect.Height - Pic.Height) / 2))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawButtonFrame(G As Graphics, Rect As REALbasic.Rect, Mode As ButtonModes, BackgroundColor As Color, Highlighted As Boolean, WithMenu As Boolean)
		  Dim Source As Picture
		  Select Case Mode
		  Case ButtonModes.Normal
		    Source = If(WithMenu, ImgToolbarMenuNormal, ImgToolbarButtonNormal)
		  Case ButtonModes.Disabled
		    Source = If(WithMenu, ImgToolbarMenuDisabled, ImgToolbarButtonDisabled)
		  Case ButtonModes.Pressed
		    Source = If(WithMenu, ImgToolbarMenuPressed, ImgToolbarButtonPressed)
		  End Select
		  If Not Highlighted Then
		    BackgroundColor = &cFFFFFF
		  End If
		  If Mode = ButtonModes.Disabled Then
		    BackgroundColor = RGB(BackgroundColor.Red, BackgroundColor.Green, BackgroundColor.Blue, 128)
		  End If
		  
		  Dim LeftRect As New REALbasic.Rect(0, 0, 12, Source.Height)
		  Dim FillRect As New REALbasic.Rect(12, 0, 1, Source.Height)
		  Dim RightRect As New REALbasic.Rect(Source.Width - 12, 0, 12, Source.Height)
		  Dim CenterRect As New REALbasic.Rect(16, 0, 8, Source.Height)
		  Dim Top As Integer = Rect.Top + ((Rect.Height - Source.Height) / 2)
		  
		  Rect = New REALbasic.Rect(Rect.Left - 8, Rect.Top - 8, Rect.Width + 16, Rect.Height + 16)
		  
		  Dim Mask As Picture = BeaconUI.IconWithColor(If(WithMenu, ImgToolbarMenuMask, ImgToolbarButtonMask), BackgroundColor)
		  G.DrawPicture(Mask, Rect.Left, Top, LeftRect.Width, LeftRect.Height, LeftRect.Left, LeftRect.Top, LeftRect.Width, LeftRect.Height)
		  G.DrawPicture(Mask, Rect.Right - RightRect.Width, Top, RightRect.Width, RightRect.Height, RightRect.Left, RightRect.Top, RightRect.Width, RightRect.Height)
		  G.DrawPicture(Mask, Rect.Left + LeftRect.Width, Top, Rect.Width - (LeftRect.Width + RightRect.Width), FillRect.Height, FillRect.Left, FillRect.Top, FillRect.Width, FillRect.Height)
		  If WithMenu Then
		    G.DrawPicture(Mask, Rect.HorizontalCenter - (CenterRect.Width / 2), Top, CenterRect.Width, CenterRect.Height, CenterRect.Left, CenterRect.Top, CenterRect.Width, CenterRect.Height)
		  End If
		  
		  G.DrawPicture(Source, Rect.Left, Top, LeftRect.Width, LeftRect.Height, LeftRect.Left, LeftRect.Top, LeftRect.Width, LeftRect.Height)
		  G.DrawPicture(Source, Rect.Right - RightRect.Width, Top, RightRect.Width, RightRect.Height, RightRect.Left, RightRect.Top, RightRect.Width, RightRect.Height)
		  If WithMenu Then
		    Dim TailLeft As Integer = Rect.HorizontalCenter - (CenterRect.Width / 2)
		    Dim TailRight As Integer = TailLeft + CenterRect.Width
		    
		    Dim LeftSectionLeft As Integer = Rect.Left + LeftRect.Width
		    Dim LeftSectionRight As Integer = TailLeft
		    
		    Dim RightSectionLeft As Integer = TailRight
		    Dim RightSectionRight As Integer = Rect.Right - RightRect.Width
		    
		    G.DrawPicture(Source, TailLeft, Top, CenterRect.Width, CenterRect.Height, CenterRect.Left, CenterRect.Top, CenterRect.Width, CenterRect.Height)
		    G.DrawPicture(Source, LeftSectionLeft, Top, LeftSectionRight - LeftSectionLeft, FillRect.Height, FillRect.Left, FillRect.Top, FillRect.Width, FillRect.Height)
		    G.DrawPicture(Source, RightSectionLeft, Top, RightSectionRight - RightSectionLeft, FillRect.Height, FillRect.Left, FillRect.Top, FillRect.Width, FillRect.Height)
		  Else
		    G.DrawPicture(Source, Rect.Left + LeftRect.Width, Top, Rect.Width - (LeftRect.Width + RightRect.Width), FillRect.Height, FillRect.Left, FillRect.Top, FillRect.Width, FillRect.Height)
		  End If
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
			  Return Self.mHasResizer
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasResizer <> Value Then
			    Self.mHasResizer = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		HasResizer As Boolean
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
		Private mHasResizer As Boolean
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
		Private mResizing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightItems As BeaconToolbarItemArray
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartingWidth As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mRightItems
			End Get
		#tag EndGetter
		RightItems As BeaconToolbarItemArray
	#tag EndComputedProperty


	#tag Constant, Name = BorderColor, Type = Color, Dynamic = False, Default = \"&ca6a6a6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CaptionButtonName, Type = String, Dynamic = False, Default = \"CaptionButton", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ButtonModes, Type = Integer, Flags = &h21
		Normal
		  Disabled
		Pressed
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
			Name="HasResizer"
			Visible=true
			Group="Behavior"
			InitialValue="True"
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
