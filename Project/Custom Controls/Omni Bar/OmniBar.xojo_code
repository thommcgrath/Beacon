#tag Class
Protected Class OmniBar
Inherits ControlCanvas
Implements ObservationKit.Observer
	#tag Event
		Sub Activate()
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivate()
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.mMouseDown = True
		  Self.mMousePoint = New Point(X, Y)
		  Self.mMouseDownPoint = New Point(X, Y)
		  Self.mMouseDownIndex = Self.IndexAtPoint(Self.mMouseDownPoint)
		  Self.mMouseOverIndex = Self.mMouseDownIndex
		  Self.Invalidate(Self.mMouseDownIndex)
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Point(X, Y)
		  
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  If OldIndex > -1 And Self.mMouseOverIndex <> OldIndex Then
		    Var OldRect As Rect = Self.mItemRects(OldIndex)
		    Self.Invalidate(OldRect.Left, OldRect.Top, OldRect.Width, OldRect.Height)
		  End If
		  
		  If Self.mMouseOverIndex > -1 Then
		    Var OverRect As Rect = Self.mItemRects(Self.mMouseOverIndex)
		    Self.Invalidate(OverRect.Left, OverRect.Top, OverRect.Width, OverRect.Height)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Self.mMouseDown Then
		    Return
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = Nil
		  
		  If Self.mMouseOverIndex <> -1 Then
		    Self.Invalidate(Self.mMouseOverIndex)
		    Self.mMouseOverIndex = -1
		  End If
		  
		  #if TargetMacOS
		    Self.TrueWindow.NSWindowMBS.Movable = True
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Point(X, Y)
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  If OldIndex > -1 And Self.mMouseOverIndex <> OldIndex Then
		    Self.Invalidate(OldIndex)
		  End If
		  
		  If Self.mMouseOverIndex > -1 Then
		    Self.Invalidate(Self.mMouseOverIndex)
		  End If
		  
		  #if TargetMacOS
		    Self.TrueWindow.NSWindowMBS.Movable = Self.mMouseOverIndex = -1
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Point(X, Y)
		  
		  If Self.mMouseDownIndex > -1 And Self.IndexAtPoint(Self.mMousePoint) = Self.mMouseDownIndex And Self.mItems(Self.mMouseDownIndex).Enabled = True Then
		    Var Item As OmniBarItem = Self.mItems(Self.mMouseDownIndex)
		    Var ItemRect As Rect = Self.mItemRects(Self.mMouseDownIndex)
		    Var FirePressed As Boolean = True
		    If Item.CanBeClosed Then
		      Var AccessoryRect As New Rect(ItemRect.Right - Self.IconSize, (Self.Height - Self.IconSize) / 2, Self.IconSize, Self.IconSize)
		      If AccessoryRect.Contains(Self.mMousePoint) Then
		        FirePressed = False
		        RaiseEvent ShouldCloseItem(Item)
		      End If
		    End If
		    
		    If FirePressed Then
		      RaiseEvent ItemPressed(Item)
		    End If
		  End If
		  
		  Self.mMouseDown = False
		  Self.mMouseDownIndex = -1
		  
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  // First, compute the rectangles for each item. It's ok to assume left alignment here,
		  // as we'll apply an offset later.
		  
		  Var Highlighted As Boolean = Self.Highlighted
		  
		  Var NextPos As Double = If(Self.LeftPadding = -1, Self.ItemSpacing, Self.LeftPadding)
		  Var Rects() As Rect
		  Rects.ResizeTo(Self.mItems.LastRowIndex)
		  G.Bold = True // Assume all are toggled for the sake of spacing
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    If Item Is Nil Then
		      Continue
		    End If
		    
		    Var Segments() As Double
		    If Item.Caption.IsEmpty = False Then
		      Segments.AddRow(Min(G.TextWidth(Item.Caption), Self.MaxCaptionWidth))
		    End If
		    If (Item.Icon Is Nil) = False Then
		      If Item.Caption.IsEmpty Then
		        Segments.AddRow(Self.IconSize + (Self.ButtonPadding * 2))
		      Else
		        Segments.AddRow(Self.IconSize)
		      End If
		    End If
		    If Item.CanBeClosed Or Item.HasUnsavedChanges Then
		      Segments.AddRow(Self.CloseIconSize)
		    End If
		    
		    Var ItemWidth As Double = NearestMultiple(Segments.Sum(Self.ElementSpacing), 1.0) // Yes, round to nearest whole
		    Rects(Idx) = New Rect(NextPos, 0, ItemWidth, G.Height)
		    If ItemWidth > 0 Then
		      NextPos = NextPos + ItemWidth + Self.ItemSpacing
		    End If
		  Next
		  
		  If Self.mAlignment = Self.AlignCenter Or Self.mAlignment = Self.AlignRight Then
		    Var MinX, MaxX As Integer
		    For Idx As Integer = 0 To Rects.LastRowIndex
		      If Idx = 0 Then
		        MinX = Rects(Idx).Left
		        MaxX = Rects(Idx).Right
		      Else
		        MinX = Min(MinX, Rects(Idx).Left)
		        MaxX = Max(MaxX, Rects(Idx).Right)
		      End If
		    Next
		    
		    Var ItemsWidth As Integer = MaxX - MinX
		    Var TargetX As Integer
		    
		    If Self.mAlignment = Self.AlignCenter Then
		      TargetX = (Self.Width - ItemsWidth) / 2
		    Else
		      TargetX = Self.Width - (If(Self.RightPadding = -1, Self.ItemSpacing, Self.RightPadding) + ItemsWidth)
		    End If
		    
		    Var OffsetX As Integer = TargetX - MinX
		    If OffsetX <> 0 Then
		      For Idx As Integer = 0 To Rects.LastRowIndex
		        Rects(Idx).Offset(OffsetX, 0)
		      Next
		    End If
		  End If
		  
		  Self.mItemRects = Rects
		  G.Bold = False
		  
		  Var BackgroundColor As Color = SystemColors.ControlBackgroundColor
		  G.ClearRectangle(0, 0, G.Width, G.Height)
		  //G.DrawingColor = BackgroundColor
		  //G.FillRectangle(0, 0, G.Width, G.Height)
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(0, G.Height - 1, G.Width, 1)
		  
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    Var ItemRect As Rect = Rects(Idx)
		    If Item Is Nil Or ItemRect Is Nil Then
		      Continue
		    End If
		    
		    Var ShouldDraw As Boolean
		    If Areas.LastRowIndex = -1 Then
		      ShouldDraw = True
		    Else
		      For Each Area As Rect In Areas
		        If Area.Intersects(ItemRect) Then
		          ShouldDraw = True
		        End If
		      Next
		    End If
		    If Not ShouldDraw Then
		      Continue
		    End If
		    
		    Var State As Integer
		    If Self.mMouseDown And Self.mMouseOverIndex = Idx Then
		      // Pressed
		      State = Self.StatePressed
		    ElseIf Self.mMouseOverIndex = Idx Then
		      // Hover
		      State = Self.StateHover
		    Else
		      // Normal
		      State = Self.StateNormal
		    End If
		    
		    Var LocalPoint As Point
		    If (Self.mMousePoint Is Nil) = False Then
		      LocalPoint = ItemRect.LocalPoint(Self.mMousePoint)
		    End If
		    
		    Var Clip As Graphics = G.Clip(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height)
		    Self.DrawItem(Clip, BackgroundColor, Item, Highlighted, State, LocalPoint)
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function ActiveColorToColor(Value As OmniBarItem.ActiveColors) As Color
		  Select Case Value
		  Case OmniBarItem.ActiveColors.Blue
		    Return SystemColors.SystemBlueColor
		  Case OmniBarItem.ActiveColors.Brown
		    Return SystemColors.SystemBrownColor
		  Case OmniBarItem.ActiveColors.Gray
		    Return SystemColors.SystemGrayColor
		  Case OmniBarItem.ActiveColors.Green
		    Return SystemColors.SystemGreenColor
		  Case OmniBarItem.ActiveColors.Orange
		    Return SystemColors.SystemOrangeColor
		  Case OmniBarItem.ActiveColors.Pink
		    Return SystemColors.SystemPinkColor
		  Case OmniBarItem.ActiveColors.Purple
		    Return SystemColors.SystemPurpleColor
		  Case OmniBarItem.ActiveColors.Red
		    Return SystemColors.SystemRedColor
		  Case OmniBarItem.ActiveColors.Yellow
		    Return SystemColors.SystemYellowColor
		  Else
		    Return SystemColors.ControlAccentColor
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Append(ParamArray Items() As OmniBarItem)
		  For Each Item As OmniBarItem In Items
		    If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		      Item.AddObserver(Self, "MinorChange", "MajorChange")
		      Self.mItems.AddRow(Item)
		      Self.Invalidate
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawItem(G As Graphics, BackgroundColor As Color, Item As OmniBarItem, Highlighted As Boolean, State As Integer, LocalMousePoint As Point)
		  Var HasIcon As Boolean = (Item.Icon Is Nil) = False
		  Var HasCaption As Boolean = Item.Caption.IsEmpty = False
		  If HasIcon = False And HasCaption = False Then
		    // There's nothing here to draw
		    Return
		  End If
		  
		  If Item.HasProgressIndicator Then
		    If Item.Progress = OmniBarItem.ProgressIndeterminate Then
		      Const BarMaxPercent = 0.75
		      
		      Var Phase As Double = Item.IndeterminatePhase
		      Var RangeMin As Double = (G.Width * BarMaxPercent) * -1
		      Var RangeMax As Double = G.Width
		      Var BarLeft As Double = NearestMultiple(RangeMin + ((RangeMax - RangeMin) * Phase), G.ScaleX)
		      Var BarWidth As Double = NearestMultiple(G.Width * BarMaxpercent, G.ScaleX)
		      
		      G.DrawingColor = Self.ActiveColorToColor(Item.ActiveColor)
		      G.FillRectangle(BarLeft, G.Height - 2, BarWidth, 2)
		    Else
		      Var BarWidth As Double = NearestMultiple(G.Width * Item.Progress, G.ScaleX)
		      G.DrawingColor = Self.ActiveColorToColor(Item.ActiveColor)
		      G.FillRectangle(0, G.Height - 2, BarWidth, 2)
		    End If
		  ElseIf Item.Toggled Then
		    G.ClearRectangle(0, G.Height - 2, G.Width, 2)
		    If Highlighted Then
		      G.DrawingColor = Self.ActiveColorToColor(Item.ActiveColor)
		    Else
		      G.DrawingColor = SystemColors.SeparatorColor
		    End If
		    G.DrawRectangle(0, G.Height - 2, G.Width, 2)
		  End If
		  
		  If HasIcon = True And HasCaption = False Then
		    // Draw as button
		    Self.DrawItemAsButton(G, Item, Highlighted, State)
		    Return
		  End If
		  
		  // Find the color we'll be using
		  Var ForeColor, ShadowColor As Color
		  If Item.Enabled = False Then
		    ForeColor = SystemColors.DisabledControlTextColor
		  ElseIf Highlighted = True Then
		    If Item.Toggled Or Item.AlwaysUseActiveColor Or State = Self.StateHover Or State = Self.StatePressed Then
		      ForeColor = BeaconUI.FindContrastingColor(BackgroundColor, Self.ActiveColorToColor(Item.ActiveColor))
		    Else
		      ForeColor = SystemColors.ControlTextColor
		    End If
		  Else
		    ForeColor = SystemColors.ControlTextColor
		  End If
		  ShadowColor = SystemColors.TextBackgroundColor
		  
		  Var OriginalForeColor As Color = ForeColor
		  If State = Self.StatePressed And Item.Enabled Then
		    ForeColor = ForeColor.Darker(0.5)
		  End If
		  
		  // Draw as text, with an icon to the left if available.
		  // Accessory comes first, as it may change the hover and pressed appearances
		  
		  Var AccessoryImage As Picture
		  Var AccessoryRect As New Rect(G.Width - Self.IconSize, NearestMultiple((G.Height - Self.IconSize) / 2, G.ScaleY), Self.IconSize, Self.IconSize)
		  Var AccessoryColor As Color
		  Var WithAccessory As Boolean = True
		  If Item.CanBeClosed And (State = Self.StateHover Or State = Self.StatePressed) Then
		    Var AccessoryState As Integer = State
		    If (LocalMousePoint Is Nil) = False And AccessoryRect.Contains(LocalMousePoint) Then
		      G.DrawingColor = SystemColors.QuaternaryLabelColor
		      G.FillRoundRectangle(AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 6, 6)
		      State = Self.StateNormal
		      ForeColor = OriginalForeColor
		    End If
		    
		    G.DrawPicture(BeaconUI.IconWithColor(IconClose, SystemColors.TertiaryLabelColor), AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, IconClose.Width, IconClose.Height)
		    
		    If AccessoryState = Self.StatePressed Then
		      If (LocalMousePoint Is Nil) = False And AccessoryRect.Contains(LocalMousePoint) Then
		        G.DrawingColor = &C00000090
		        G.FillRoundRectangle(AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 6, 6)
		      ElseIf Item.Enabled Then
		        G.DrawPicture(BeaconUI.IconWithColor(IconClose, &C00000090), AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, IconClose.Width, IconClose.Height)
		      End If
		    End If
		  ElseIf Item.HasUnsavedChanges Then
		    AccessoryColor = ForeColor
		    AccessoryImage = IconModified
		  ElseIf Item.CanBeClosed Then
		    AccessoryColor = SystemColors.TertiaryLabelColor
		    AccessoryImage = IconClose
		  Else
		    WithAccessory = False
		  End If
		  If (AccessoryImage Is Nil) = False Then
		    AccessoryImage = BeaconUI.IconWithColor(AccessoryImage, AccessoryColor)
		    G.DrawPicture(AccessoryImage, AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, AccessoryImage.Width, AccessoryImage.Height)
		  End If
		  
		  Var CaptionOffset As Double = 0
		  If HasIcon = True Then
		    CaptionOffset = Self.IconSize + Self.ElementSpacing
		    
		    Var IconTop As Double = NearestMultiple((G.Height - Self.IconSize) / 2, G.ScaleY)
		    Var Icon As Picture = BeaconUI.IconWithColor(Item.Icon, Forecolor)
		    G.DrawPicture(Icon, 0, IconTop, Self.IconSize, Self.IconSize, 0, 0, Icon.Width, Icon.Height)
		  End If
		  
		  If Item.Toggled Then
		    G.Bold = True
		  End If
		  
		  Var CaptionSpace As Double = If(WithAccessory, AccessoryRect.Left, G.Width) - CaptionOffset
		  Var CaptionLeft As Double = NearestMultiple((CaptionSpace - Min(G.TextWidth(Item.Caption), Self.MaxCaptionWidth)) / 2, G.ScaleX)
		  Var CaptionBaseline As Double = NearestMultiple((G.Height / 2) + (G.CapHeight / 2), G.ScaleY)
		  
		  G.DrawingColor = ShadowColor
		  G.DrawText(Item.Caption, CaptionLeft, CaptionBaseline + 1, Self.MaxCaptionWidth, True)
		  G.DrawingColor = ForeColor
		  G.DrawText(Item.Caption, CaptionLeft, CaptionBaseline, Self.MaxCaptionWidth, True)
		  G.Bold = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawItemAsButton(G As Graphics, Item As OmniBarItem, Highlighted As Boolean, State As Integer)
		  Const CornerRadius = 6
		  
		  Var ForeColor, BackColor As Color = &c000000FF
		  If Item.Toggled Then
		    ForeColor = SystemColors.ControlBackgroundColor
		    If Highlighted Then
		      BackColor = Self.ActiveColorToColor(Item.ActiveColor)
		    Else
		      BackColor = SystemColors.SecondaryLabelColor
		    End If
		  ElseIf Highlighted And Item.AlwaysUseActiveColor Then
		    ForeColor = Self.ActiveColorToColor(Item.ActiveColor)
		  Else
		    ForeColor = SystemColors.SecondaryLabelColor
		  End If
		  
		  Var IconRect As New Rect(NearestMultiple((G.Width - Self.IconSize) / 2, G.ScaleX), NearestMultiple((G.Height - Self.IconSize) / 2, G.ScaleY), Self.IconSize, Self.IconSize)
		  Var Factor As Double = Max(G.ScaleX, G.ScaleY)
		  Var Icon As Picture = BeaconUI.IconWithColor(Item.Icon, ForeColor, Factor, Factor)
		  
		  If BackColor.Alpha < 255 Then
		    G.DrawingColor = BackColor
		    G.FillRoundRectangle(IconRect.Left - Self.ButtonPadding, IconRect.Top - Self.ButtonPadding, IconRect.Width + (Self.ButtonPadding * 2), IconRect.Height + (Self.ButtonPadding * 2), CornerRadius, CornerRadius)
		  End If
		  
		  G.DrawPicture(Icon, IconRect.Left, IconRect.Top, IconRect.Width, IconRect.Height, 0, 0, IconRect.Width, IconRect.Height)
		  
		  If State = Self.StatePressed And Item.Enabled Then
		    G.DrawingColor = &c00000080
		    G.FillRoundRectangle(IconRect.Left, IconRect.Top, IconRect.Width, IconRect.Height, CornerRadius, CornerRadius)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexAtPoint(X As Integer, Y As Integer) As Integer
		  Return Self.IndexAtPoint(New Point(X, Y))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexAtPoint(Point As Point) As Integer
		  For Idx As Integer = 0 To Self.mItemRects.LastRowIndex
		    If (Self.mItemRects(Idx) Is Nil) = False And Self.mItemRects(Idx).Contains(Point) Then
		      Return Idx
		    End If
		  Next
		  Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As OmniBarItem) As Integer
		  If Item Is Nil Then
		    Return -1
		  End If
		  
		  Return Self.IndexOf(Item.Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Name As String) As Integer
		  For Idx As Integer = 0 To Self.mItems.LastRowIndex
		    If (Self.mItems(Idx) Is Nil) = False And Self.mItems(Idx).Name = Name Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As OmniBarItem)
		  If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		    Item.AddObserver(Self, "MinorChange", "MajorChange")
		    Self.mItems.AddRowAt(Index, Item)
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(Idx As Integer)
		  If Idx < Self.mItemRects.FirstRowIndex Or Idx > Self.mItemRects.LastRowIndex Then
		    Super.Invalidate(False)
		    Return
		  End If
		  
		  Var ItemRect As Rect = Self.mItemRects(Idx)
		  If ItemRect Is Nil Then
		    Super.Invalidate(False)
		    Return
		  End If
		  
		  Super.Invalidate(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Idx As Integer) As OmniBarItem
		  If Idx >= 0 And Idx <= Self.mItems.LastRowIndex Then
		    Return Self.mItems(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Item(Idx As Integer, Assigns NewItem As OmniBarItem)
		  If (NewItem Is Nil) = False And Self.IndexOf(NewItem) = -1 Then
		    NewItem.AddObserver(Self, "MinorChange", "MajorChange")
		    Self.mItems(Idx) = NewItem
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Name As String) As OmniBarItem
		  Var Idx As Integer = Self.IndexOf(Name)
		  Return Self.Item(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mItems.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Value
		  
		  If Key = "MajorChange" Then
		    Self.Invalidate(False)
		  ElseIf Key = "MinorChange" And Source IsA OmniBarItem Then
		    Var Item As OmniBarItem = OmniBarItem(Source)
		    Var Idx As Integer = Self.IndexOf(Item)
		    Self.Invalidate(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  If Idx >= 0 And Idx <= Self.mItems.LastRowIndex Then
		    Self.mItems(Idx).RemoveObserver(Self, "MinorChange", "MajorChange")
		    Self.mItems.RemoveRowAt(Idx)
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Item As OmniBarItem)
		  Var Idx As Integer = Self.IndexOf(Item)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Name As String)
		  Var Idx As Integer = Self.IndexOf(Name)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAllItems()
		  If Self.mItems.Count > 0 Then
		    For Idx As Integer = Self.mItems.LastRowIndex DownTo 0
		      Self.mItems(Idx).RemoveObserver(Self, "MinorChange", "MajorChange")
		      Self.mItems.RemoveRowAt(Idx)
		    Next
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ItemPressed(Item As OmniBarItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldCloseItem(Item As OmniBarItem)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAlignment
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAlignment <> Value Then
			    Self.mAlignment = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Alignment As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLeftPadding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mLeftPadding <> Value Then
			    Self.mLeftPadding = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		LeftPadding As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAlignment As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItemRects() As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As OmniBarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLeftPadding As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseOverIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMousePoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightPadding As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mRightPadding
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mRightPadding <> Value Then
			    Self.mRightPadding = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		RightPadding As Integer
	#tag EndComputedProperty


	#tag Constant, Name = AlignCenter, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AlignLeft, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AlignRight, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonPadding, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CloseIconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ElementSpacing, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FirstRowIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ItemSpacing, Type = Double, Dynamic = False, Default = \"20", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MaxCaptionWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateHover, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateNormal, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatePressed, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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
			InitialValue="38"
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
			InitialValue="100"
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
			Name="Alignment"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Center"
				"2 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftPadding"
			Visible=true
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightPadding"
			Visible=true
			Group="Behavior"
			InitialValue="-1"
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
