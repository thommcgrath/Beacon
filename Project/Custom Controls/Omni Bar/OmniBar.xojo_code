#tag Class
Protected Class OmniBar
Inherits ControlCanvas
Implements ObservationKit.Observer,NotificationKit.Receiver
	#tag Event
		Sub Activated()
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivated()
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub DoublePressed(x As Integer, y As Integer)
		  Self.MouseUp(X, Y, True)
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.mMouseDown = True
		  Self.mMousePoint = New Point(X, Y)
		  Self.mMouseDownPoint = New Point(X, Y)
		  Self.mMouseDownIndex = Self.IndexAtPoint(Self.mMouseDownPoint)
		  Self.mMouseOverIndex = Self.mMouseDownIndex
		  Self.mMouseHeld = False
		  Self.mUsedLongAction = False
		  Self.Refresh(Self.mMouseDownIndex)
		  
		  App.HideTooltip
		  CallLater.Cancel(Self.mHoverCallbackKey)
		  
		  If Self.mMouseDownIndex > -1 Then
		    Self.mHoldTimer.Reset
		    Self.mHoldTimer.RunMode = Timer.RunModes.Single
		    
		    If Self.mItems(Self.mMouseDownIndex).IsResizer Then
		      RaiseEvent ResizeStarted(Self.mItems(Self.mMouseDownIndex))
		    End If
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDown = False Or ((Self.mMousePoint Is Nil) = False And Self.mMousePoint.X = X And Self.mMousePoint.Y = Y) Then
		    // Don't act if we're not tracking mouse events OR if the cursor has not moved
		    Return
		  End If
		  
		  Var OldMousePoint As Point = Self.mMousePoint
		  Self.mMousePoint = New Point(X, Y)
		  
		  If Self.mMouseDownIndex > -1 And Self.mItems(Self.mMouseDownIndex).IsResizer Then
		    Var DeltaX As Integer = Self.mMousePoint.X - Self.mMouseDownPoint.X
		    Var DeltaY As Integer = Self.mMousePoint.Y - Self.mMouseDownPoint.Y
		    If DeltaX <> 0 Or DeltaY <> 0 Then
		      Var OriginalRect As New Rect(Self.Left, Self.Top, Self.Width, Self.Height)
		      RaiseEvent Resize(Self.mItems(Self.mMouseDownIndex), DeltaX, DeltaY)
		      Var ChangedRect As New Rect(Self.Left, Self.Top, Self.Width, Self.Height)
		      If OriginalRect.Left <> ChangedRect.Left Or OriginalRect.Top <> ChangedRect.Top Or OriginalRect.Width <> ChangedRect.Width Or OriginalRect.Height <> ChangedRect.Height Then
		        // Determine how the button has moved
		        Var OriginalButtonRect As Rect = Self.mItemRects(Self.mMouseDownIndex)
		        Self.Refresh(True)
		        Var NewButtonRect As Rect = Self.mItemRects(Self.mMouseDownIndex)
		        
		        Var ButtonDeltaX As Double = NewButtonRect.Left - OriginalButtonRect.Left
		        Var ButtonDeltaY As Double = NewButtonRect.Top - OriginalButtonRect.Top
		        Self.mMouseDownPoint = New Point(Self.mMouseDownPoint.X + ButtonDeltaX, Self.mMouseDownPoint.Y + ButtonDeltaY)
		      End If
		    End If
		    Return
		  End If
		  
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  If Self.mMouseOverIndex <> OldIndex Then
		    If OldIndex > -1 Then
		      Self.Refresh(OldIndex)
		    End If
		    
		    If Self.mMouseOverIndex > -1 Then
		      Self.Refresh(Self.mMouseOverIndex)
		    End If
		  ElseIf Self.mMouseOverIndex > -1 Then
		    // Mouse is dragging inside an item
		    Var WasInsideAccessoryRect As Boolean = Self.mItems(Self.mMouseOverIndex).InsideAccessoryRegion(Self.mItemRects(Self.mMouseOverIndex), OldMousePoint)
		    Var IsInsideAccessoryRect As Boolean = Self.mItems(Self.mMouseOverIndex).InsideAccessoryRegion(Self.mItemRects(Self.mMouseOverIndex), Self.mMousePoint)
		    If IsInsideAccessoryRect <> WasInsideAccessoryRect Then
		      Self.Refresh(Self.mMouseOverIndex)
		    End If
		  End If
		  
		  If Self.mMouseDownIndex > -1 Then
		    Var DownRect As Rect = Self.mItemRects(Self.mMouseDownIndex)
		    If (DownRect Is Nil) = False Then
		      If DownRect.Contains(Self.mMousePoint) Then
		        If Not Self.mMouseHeld Then
		          Self.mHoldTimer.Reset
		          Self.mHoldTimer.RunMode = Timer.RunModes.Single
		        End If
		      Else
		        Self.mHoldTimer.Reset
		        Self.mHoldTimer.RunMode = Timer.RunModes.Off
		      End If
		    End If
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
		    Self.Refresh(Self.mMouseOverIndex)
		    Self.mMouseOverIndex = -1
		  End If
		  
		  #if TargetMacOS
		    Try
		      Self.Window.NSWindowMBS.Movable = True
		    Catch Err As RuntimeException
		    End Try
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Self.mMouseDown Then
		    Return
		  End If
		  
		  Var OldMousePoint As Point = Self.mMousePoint
		  Self.mMousePoint = New Point(X, Y)
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  If Self.mMouseOverIndex <> OldIndex Then
		    If OldIndex > -1 Then
		      Self.Refresh(OldIndex)
		    End If
		    If Self.mMouseOverIndex > -1 Then
		      Self.Refresh(Self.mMouseOverIndex)
		    End If
		    
		    App.HideTooltip
		    CallLater.Cancel(Self.mHoverCallbackKey)
		    
		    If Self.mMouseOverIndex > -1 And Self.mItems(Self.mMouseOverIndex).HelpTag.IsEmpty = False Then
		      Self.mHoverCallbackKey = CallLater.Schedule(1000, WeakAddressOf ShowHoverTooltip)
		    End If
		  ElseIf Self.mMouseOverIndex > -1 Then
		    // Cursor is moving inside an item
		    Var WasInsideAccessoryRect As Boolean = Self.mItems(Self.mMouseOverIndex).InsideAccessoryRegion(Self.mItemRects(Self.mMouseOverIndex), OldMousePoint)
		    Var IsInsideAccessoryRect As Boolean = Self.mItems(Self.mMouseOverIndex).InsideAccessoryRegion(Self.mItemRects(Self.mMouseOverIndex), Self.mMousePoint)
		    If IsInsideAccessoryRect <> WasInsideAccessoryRect Then
		      Self.Refresh(Self.mMouseOverIndex)
		    End If
		  End If
		  
		  Var TargetCursor As MouseCursor
		  If Self.mMouseOverIndex > -1 And Self.mItems(Self.mMouseOverIndex).Type = OmniBarItem.Types.HorizontalResizer And Self.mItems(Self.mMouseOverIndex).Enabled = True Then
		    TargetCursor = System.Cursors.SplitterEastWest
		  ElseIf Self.mMouseOverIndex > -1 And Self.mItems(Self.mMouseOverIndex).Type = OmniBarItem.Types.VerticalResizer And Self.mItems(Self.mMouseOverIndex).Enabled = True Then
		    TargetCursor = System.Cursors.SplitterNorthSouth
		  Else
		    TargetCursor = System.Cursors.StandardPointer
		  End If
		  If Self.MouseCursor <> TargetCursor Then
		    Self.MouseCursor = TargetCursor
		  End If
		  
		  #if TargetMacOS
		    Self.Window.NSWindowMBS.Movable = Self.mMouseOverIndex = -1
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Self.MouseUp(X, Y, False)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused SafeArea
		  
		  Var ColorProfile As OmniBarColorProfile
		  If Self.mColorProfiles.HasKey(Self.mBackgroundColor) = False Then
		    Self.mColorProfiles.Value(Self.mBackgroundColor) = New OmniBarColorProfile(Self.mBackgroundColor)
		  End If
		  ColorProfile = Self.mColorProfiles.Value(Self.mBackgroundColor)
		  
		  Var RequiresOverflow As Boolean
		  Self.mItemRects = Self.ComputeRects(G, RequiresOverflow)
		  
		  G.ClearRectangle(0, 0, G.Width, G.Height)
		  G.DrawingColor = ColorProfile.FillColor
		  G.FillRectangle(0, 0, G.Width, G.Height)
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(0, G.Height - 1, G.Width, 1)
		  
		  Self.mOverflowStopIndex = -1
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    Var ItemRect As Rect = Self.mItemRects(Idx)
		    If Item Is Nil Or ItemRect Is Nil Or Item.Visible = False Then
		      Continue
		    End If
		    
		    If RequiresOverflow And ItemRect.Right > G.Width - (Self.OverflowWidth + Self.RightEdgePadding) Then
		      // Don't draw any more
		      Self.mOverflowStopIndex = Idx - 1
		      Exit For Idx
		    End If
		    
		    Var ShouldDraw As Boolean
		    If Areas.LastIndex = -1 Then
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
		    
		    Var MouseHover, MouseDown As Boolean
		    If Self.mMouseDown And Self.mMouseOverIndex = Idx And Self.mMouseDownIndex = Idx And Item.Enabled Then
		      // Pressed
		      MouseDown = True
		      MouseHover = True
		    ElseIf Self.mMouseOverIndex = Idx And Item.Enabled Then
		      // Hover
		      MouseHover = True
		    End If
		    
		    Var LocalPoint As Point
		    If (Self.mMousePoint Is Nil) = False Then
		      LocalPoint = ItemRect.LocalPoint(Self.mMousePoint)
		    End If
		    
		    Var Clip As Graphics = G.Clip(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height)
		    Item.DrawInto(Clip, ColorProfile, MouseDown, MouseHover, LocalPoint, Highlighted)
		  Next
		  
		  If Not RequiresOverflow Then
		    Self.mOverflowRect = Nil
		    Return
		  End If
		  
		  Var OverflowToggled As Boolean
		  If Self.mMouseOverIndex = Self.OverflowItemIndex Then
		    OverflowToggled = True
		  Else
		    For Idx As Integer = Self.mOverflowStopIndex + 1 To Self.mItems.LastIndex
		      If Self.mItems(Idx).Toggled Then
		        OverflowToggled = True
		      End If
		    Next
		  End If
		  
		  Var OverflowPressed As Boolean = OverflowToggled And Self.mMouseDownIndex = Self.OverflowItemIndex
		  
		  Self.mOverflowRect = New Rect(G.Width - (Self.OverflowWidth + Self.RightEdgePadding), NearestMultiple((G.Height - Self.OverflowWidth) / 2, G.ScaleY), Self.OverflowWidth, Self.OverflowWidth)
		  
		  Var LocalOverflowPoint As Point
		  If (Self.mMousePoint Is Nil) = False Then
		    LocalOverflowPoint = Self.mOverflowRect.LocalPoint(Self.mMousePoint)
		  End If
		  Var Clip As Graphics = G.Clip(Self.mOverflowRect.Left, Self.mOverflowRect.Top, Self.mOverflowRect.Width, Self.mOverflowRect.Height)
		  OmniBarItem.DrawOverflow(Clip, ColorProfile, OverflowPressed, OverflowToggled, LocalOverflowPoint, Highlighted)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(ParamArray Items() As OmniBarItem)
		  For Each Item As OmniBarItem In Items
		    If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		      Item.AddObserver(Self, "MinorChange", "MajorChange")
		      Self.mItems.Add(Item)
		      Self.Refresh
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ComputeRects(G As Graphics, ByRef RequiresOverflow As Boolean) As Rect()
		  Var UniquePriorities As New Dictionary
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    UniquePriorities.Value(Self.mItems(Idx).Priority) = True
		  Next
		  Var Priorities() As Integer
		  For Each Entry As DictionaryEntry In UniquePriorities
		    Priorities.Add(Entry.Key)
		  Next
		  Var Fits As Boolean
		  If Priorities.Count = 1 Then
		    Return Self.ComputeRects(G, Priorities(0), True, Fits, RequiresOverflow)
		  End If
		  Priorities.Sort
		  
		  For Idx As Integer = 0 To Priorities.LastIndex
		    Var Priority As Integer = Priorities(Idx)
		    Var AllowOverflow As Boolean = Idx = Priorities.LastIndex
		    Var Rects() As Rect = Self.ComputeRects(G, Priority, AllowOverflow, Fits, RequiresOverflow)
		    If Fits Or AllowOverflow Then
		      Return Rects
		    End If
		  Next
		  
		  Var Rects() As Rect
		  Return Rects
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ComputeRects(G As Graphics, MinPriority As Integer, AllowOverflow As Boolean, ByRef Fits As Boolean, ByRef RequiresOverflow As Boolean) As Rect()
		  // First, compute the rectangles for each item. It's ok to assume left alignment here,
		  // as we'll apply an offset later.
		  
		  RequiresOverflow = False
		  Var AvailableWidth As Integer = G.Width - (Self.LeftEdgePadding + Self.RightEdgePadding)
		  
		  G.Bold = True // Assume all are toggled for the sake of spacing
		  Var Widths(), Margins() As Integer
		  Widths.ResizeTo(Self.mItems.LastIndex)
		  Margins.ResizeTo(Self.mItems.LastIndex)
		  Var FlexSpaceIndexes(), FlexItemIndexes() As Integer
		  Var FirstMarginIndex As Integer = -1
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    If Item Is Nil Or Item.Visible = False Then
		      Continue
		    End If
		    
		    If Item.Type = OmniBarItem.Types.FlexSpace Then
		      FlexSpaceIndexes.Add(Idx)
		    ElseIf Item.Priority >= MinPriority Then
		      If Item.IsFlexible Then
		        FlexItemIndexes.Add(Idx)
		      End If
		      
		      Var Previousitem As OmniBarItem
		      For PreviousIdx As Integer = Idx - 1 DownTo 0
		        If Widths(PreviousIdx) > 0 Then
		          PreviousItem = Self.mItems(PreviousIdx)
		          Exit For PreviousIdx
		        End If
		      Next
		      
		      Var LeftMargin As Integer
		      If PreviousItem Is Nil Then
		        LeftMargin = If(Self.LeftPadding = -1, Self.DefaultEdgePadding, Self.LeftPadding)
		      Else
		        LeftMargin = Max(PreviousItem.Margin(Item), Item.Margin(PreviousItem))
		      End If
		      
		      Var ItemWidth As Integer = Item.Width(G)
		      Widths(Idx) = ItemWidth
		      If ItemWidth > 0 Then
		        Margins(Idx) = LeftMargin
		        If FirstMarginIndex = -1 Then
		          FirstMarginIndex = Idx
		        End If
		      End If
		    End If
		  Next
		  Var ItemsWidth As Integer = Widths.Sum + (Margins.Sum - Margins(FirstMarginIndex))
		  If ItemsWidth > AvailableWidth Then
		    Var Overflow As Integer = ItemsWidth - AvailableWidth
		    Var ReducibleSpace As Integer
		    For Each Idx As Integer In FlexItemIndexes
		      Var Range As Beacon.Range = Self.mItems(Idx).FlexRange
		      ReducibleSpace = ReducibleSpace + Max(0, Widths(Idx) - Range.Min)
		    Next
		    If ReducibleSpace > Overflow Then
		      // Enough space to reduce items and show all content
		      Var RemainingOverflow As Integer = Overflow
		      For FlexIdx As Integer = 0 To FlexItemIndexes.LastIndex
		        Var Idx As Integer = FlexItemIndexes(FlexIdx)
		        Var RemainingItems As Integer = FlexItemIndexes.Count - FlexIdx
		        Var RemoveFromThis As Integer = Ceiling(RemainingOverflow / RemainingItems)
		        Var AdditionalPixels As Integer = RemainingOverflow - (RemoveFromThis * RemainingItems)
		        If FlexIdx < AdditionalPixels Then
		          RemoveFromThis = RemoveFromThis - 1
		        End If
		        
		        Var Range As Beacon.Range = Self.mItems(Idx).FlexRange
		        Var NewWidth As Integer = Max(Widths(Idx) - RemoveFromThis, Range.Min)
		        Var PixelsRemoved As Integer = Widths(Idx) - NewWidth
		        RemainingOverflow = RemainingOverflow - PixelsRemoved
		        Widths(Idx) = NewWidth
		      Next
		    Else
		      // Even at min size, this isn't fitting
		      If AllowOverflow = False Then
		        // Since WithOverflow is false, this will be tried again at a lower priority, so there's really no reason to continue.
		        Var Rects() As Rect
		        Return Rects
		      End If
		      
		      RequiresOverflow = True
		      AvailableWidth = AvailableWidth - (Self.OverflowWidth + Self.RightEdgePadding)
		      
		      For Each Idx As Integer In FlexItemIndexes
		        Var Range As Beacon.Range = Self.mItems(Idx).FlexRange
		        Widths(Idx) = Range.Min
		      Next
		    End If
		    ItemsWidth = Widths.Sum + (Margins.Sum - Margins(FirstMarginIndex))
		  End If
		  Fits = (ItemsWidth <= AvailableWidth)
		  
		  If ItemsWidth <= AvailableWidth And FlexSpaceIndexes.Count > 0 Then
		    Var FlexWidth As Integer = AvailableWidth - ItemsWidth
		    Var FlexItemWidth As Integer = Max(Floor(FlexWidth / FlexSpaceIndexes.Count), 0)
		    Var FlexRemainder As Integer = AvailableWidth - (FlexItemWidth * FlexSpaceIndexes.Count)
		    
		    For FlexNum As Integer = 0 To FlexSpaceIndexes.LastIndex
		      Var Idx As Integer = FlexSpaceIndexes(FlexNum)
		      Var ItemWidth As Integer = FlexItemWidth + If(FlexNum < FlexRemainder, 1, 0)
		      Widths(Idx) = ItemWidth
		    Next
		  End If
		  
		  Var NextPos As Double = 0
		  Var Rects() As Rect
		  Rects.ResizeTo(Self.mItems.LastIndex)
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    If Item Is Nil Then
		      Continue
		    End If
		    
		    Var ItemWidth As Integer = Widths(Idx)
		    Var LeftMargin As Integer = Margins(Idx)
		    
		    Rects(Idx) = New Rect(NextPos + LeftMargin, 0, ItemWidth, G.Height)
		    If ItemWidth > 0 And Idx < Self.mItems.LastIndex Then
		      NextPos = Rects(Idx).Right
		    End If
		  Next
		  
		  G.Bold = False
		  Return Rects
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  If Self.mColorProfiles Is Nil Then
		    Self.mColorProfiles = New Dictionary
		  End If
		  
		  Super.Constructor
		  
		  Self.mHoldTimer = New Timer
		  Self.mHoldTimer.RunMode = Timer.RunModes.Off
		  Self.mHoldTimer.Period = 250
		  AddHandler Self.mHoldTimer.Action, WeakAddressOf Self.mHoldTimer_Action
		  
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  NotificationKit.Ignore(Self, App.Notification_AppearanceChanged)
		  CallLater.Cancel(Self.mHoverCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexAtPoint(X As Integer, Y As Integer) As Integer
		  Return Self.IndexAtPoint(New Point(X, Y))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexAtPoint(Point As Point) As Integer
		  If Point Is Nil Then
		    Return -1
		  End If
		  
		  If (Self.mOverflowRect Is Nil) = False And Self.mOverflowRect.Contains(Point) Then
		    Return Self.OverflowItemIndex
		  End If
		  
		  Var Bound As Integer = Min(Self.mItemRects.LastIndex, Self.mItems.LastIndex)
		  If Self.mOverflowStopIndex > -1 Then
		    Bound = Min(Bound, Self.mOverflowStopIndex)
		  End If
		  
		  For Idx As Integer = 0 To Bound
		    If (Self.mItemRects(Idx) Is Nil) = False And (Self.mItems(Idx) Is Nil) = False And Self.mItemRects(Idx).Contains(Point) Then
		      If Not Self.mItems(Idx).Clickable Then
		        Return -1
		      End If
		      
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
		  For Idx As Integer = 0 To Self.mItems.LastIndex
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
		    Self.mItems.AddAt(Index, Item)
		    Self.Refresh
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Idx As Integer) As OmniBarItem
		  If Idx >= 0 And Idx <= Self.mItems.LastIndex Then
		    Return Self.mItems(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Item(Idx As Integer, Assigns NewItem As OmniBarItem)
		  If (NewItem Is Nil) = False And Self.IndexOf(NewItem) = -1 Then
		    NewItem.AddObserver(Self, "MinorChange", "MajorChange")
		    Self.mItems(Idx) = NewItem
		    Self.Refresh
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
		Function LastIndex() As Integer
		  Return Self.mItems.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LeftEdgePadding() As Integer
		  If Self.LeftPadding < 0 Then
		    Return Self.DefaultEdgePadding
		  Else
		    Return Self.LeftPadding
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHoldTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Self.mMouseHeld Or Self.mMouseDownIndex = -1 Then
		    Return
		  End If
		  
		  Var Item As OmniBarItem = Self.mItems(Self.mMouseDownIndex)
		  Var ItemRect As Rect = Self.mItemRects(Self.mMouseDownIndex)
		  Self.mMouseHeld = True
		  
		  Var InsetRect As Rect = ItemRect
		  If (Item.InsetRect Is Nil) = False Then
		    InsetRect = New Rect(ItemRect.Left + Item.InsetRect.Left, ItemRect.Top + Item.InsetRect.Top, Min(ItemRect.Width, Item.InsetRect.Width), Min(ItemRect.Height, Item.InsetRect.Height))
		  End If
		  
		  Self.mUsedLongAction = RaiseEvent ItemHeld(Item, InsetRect)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MouseUp(X As Integer, Y As Integer, Double As Boolean)
		  #Pragma Unused Double
		  
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMousePoint = New Point(X, Y)
		  Self.mHoldTimer.RunMode = Timer.RunModes.Off
		  
		  If Self.mMouseDownIndex >= Self.mItems.FirstIndex And Self.mMouseDownIndex <= Self.mItems.LastIndex And Self.mItems(Self.mMouseDownIndex).IsResizer Then
		    RaiseEvent ResizeFinished(Self.mItems(Self.mMouseDownIndex))
		  End If
		  
		  Var ReleasedOnPressedItem As Boolean = Self.IndexAtPoint(Self.mMousePoint) = Self.mMouseDownIndex
		  If ReleasedOnPressedItem Then
		    If Self.mMouseDownIndex >= Self.mItems.FirstIndex And Self.mMouseDownIndex <= Self.mItems.LastIndex And Self.mUsedLongAction = False And Self.mItems(Self.mMouseDownIndex).Enabled = True And Self.mItems(Self.mMouseDownIndex).IsResizer = False Then
		      Var Item As OmniBarItem = Self.mItems(Self.mMouseDownIndex)
		      Var ItemRect As Rect = Self.mItemRects(Self.mMouseDownIndex)
		      Var FirePressed As Boolean = True
		      If Item.CanBeClosed Then
		        Var AccessoryRect As New Rect(ItemRect.Right - OmniBarItem.AccessoryIconSize, (Self.Height - OmniBarItem.AccessoryIconSize) / 2, OmniBarItem.AccessoryIconSize, OmniBarItem.AccessoryIconSize)
		        If AccessoryRect.Contains(Self.mMousePoint) Then
		          FirePressed = False
		          RaiseEvent ShouldCloseItem(Item)
		        End If
		      End If
		      
		      If FirePressed Then
		        Var InsetRect As Rect = ItemRect
		        If (Item.InsetRect Is Nil) = False Then
		          InsetRect = New Rect(ItemRect.Left + Item.InsetRect.Left, ItemRect.Top + Item.InsetRect.Top, Min(ItemRect.Width, Item.InsetRect.Width), Min(ItemRect.Height, Item.InsetRect.Height))
		        End If
		        RaiseEvent ItemPressed(Item, InsetRect)
		      End If
		    ElseIf Self.mMouseDownIndex = Self.OverflowItemIndex Then
		      Var Base As New DesktopMenuItem
		      For Idx As Integer = Self.mOverflowStopIndex + 1 To Self.mItems.LastIndex
		        Var Item As OmniBarItem = Self.mItems(Idx)
		        Select Case Item.Type
		        Case OmniBarItem.Types.Button, OmniBarItem.Types.Tab
		          Var Menu As New DesktopMenuItem(Item.Caption, Idx)
		          Menu.HasCheckMark = Item.Toggled
		          Base.AddMenu(Menu)
		        Case OmniBarItem.Types.Separator
		          Var Menu As New DesktopMenuItem(DesktopMenuItem.TextSeparator)
		          Base.AddMenu(Menu)
		        Case OmniBarItem.Types.Title
		          Var Menu As New DesktopMenuItem(Item.Caption)
		          Menu.Enabled = False
		          Base.AddMenu(Menu)
		        End Select
		      Next
		      
		      Var Position As Point = Self.GlobalPosition
		      Var Choice As DesktopMenuItem = Base.PopUp(Position.X + Self.mOverflowRect.Left, Position.Y + Self.mOverflowRect.Bottom)
		      If (Choice Is Nil) = False And Choice.Tag.IsNull = False Then
		        Var Item As OmniBarItem = Self.Item(Choice.Tag.IntegerValue)
		        RaiseEvent ItemPressed(Item, Self.mOverflowRect)
		      End If
		    End If
		  End If
		  
		  Self.mMouseDown = False
		  Self.mMouseDownIndex = -1
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  Self.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_AppearanceChanged
		    Self.Refresh()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused OldValue
		  #Pragma Unused NewValue
		  
		  If Key = "MajorChange" Then
		    Self.Refresh(False)
		  ElseIf Key = "MinorChange" And Source IsA OmniBarItem Then
		    Var Item As OmniBarItem = OmniBarItem(Source)
		    Var Idx As Integer = Self.IndexOf(Item)
		    Self.Refresh(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub RebuildColors()
		  mColorProfiles = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RectForItem(Idx As Integer) As Rect
		  Return Self.mItemRects(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RectForItem(Item As OmniBarItem) As Rect
		  Var Idx As Integer = Self.IndexOf(Item)
		  If Idx > -1 Then
		    Return Self.RectForItem(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RectForItem(Name As String) As Rect
		  Var Idx As Integer = Self.IndexOf(Name)
		  If Idx > -1 Then
		    Return Self.RectForItem(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh(Idx As Integer, Immediately As Boolean = False)
		  If Idx = Self.OverflowItemIndex And (Self.mOverflowRect Is Nil) = False Then
		    Super.Refresh(Self.mOverflowRect.Left, Self.mOverflowRect.Top, Self.mOverflowRect.Width, Self.mOverflowRect.Height, Immediately)
		    Return
		  End If
		  
		  If Idx < Self.mItemRects.FirstRowIndex Or Idx > Self.mItemRects.LastIndex Then
		    Super.Refresh(Immediately)
		    Return
		  End If
		  
		  Var ItemRect As Rect = Self.mItemRects(Idx)
		  If ItemRect Is Nil Then
		    Super.Refresh(Immediately)
		    Return
		  End If
		  
		  Super.Refresh(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height, Immediately)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  If Idx >= 0 And Idx <= Self.mItems.LastIndex Then
		    Self.mItems(Idx).RemoveObserver(Self, "MinorChange", "MajorChange")
		    Self.mItems.RemoveAt(Idx)
		    Self.Refresh
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
		    For Idx As Integer = Self.mItems.LastIndex DownTo 0
		      Self.mItems(Idx).RemoveObserver(Self, "MinorChange", "MajorChange")
		      Self.mItems.RemoveAt(Idx)
		    Next
		    Self.Refresh
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RightEdgePadding() As Integer
		  If Self.RightPadding < 0 Then
		    Return Self.DefaultEdgePadding
		  Else
		    Return Self.RightPadding
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHoverTooltip()
		  If Self.mMouseOverIndex = -1 Then
		    Return
		  End If
		  
		  Const MaxWidth = 510
		  
		  Var HelpTag As String = Self.mItems(Self.mMouseOverIndex).HelpTag
		  If HelpTag.IsEmpty Then
		    Return
		  End If
		  
		  Var Measure As New Picture(10, 10)
		  #if TargetMacOS
		    Measure.Graphics.FontSize = 12
		  #elseif TargetWindows
		    Measure.Graphics.FontSize = 13
		  #endif
		  
		  Var X As Integer = System.MouseX
		  Var Y As Integer = System.MouseY
		  Var DisplayBound As Integer = DesktopDisplay.DisplayCount - 1
		  Var CursorDisplay As DesktopDisplay
		  If DisplayBound = 0 Then
		    CursorDisplay = DesktopDisplay.DisplayAt(0)
		  ElseIf DisplayBound > 0 Then
		    For Idx As Integer = 0 To DisplayBound
		      Var Display As DesktopDisplay = DesktopDisplay.DisplayAt(Idx)
		      If X >= Display.Left And X <= Display.Left + Display.Width And Y >= Display.Top And Y <= Display.Top + Display.Height Then
		        CursorDisplay = Display
		        Exit For Idx
		      End If
		    Next
		    If CursorDisplay Is Nil Then
		      Return
		    End If
		  End If
		  
		  Var TooltipWidth As Integer = Min(Measure.Graphics.TextWidth(HelpTag), MaxWidth)
		  Var MaxX As Integer = (CursorDisplay.AvailableLeft + CursorDisplay.AvailableWidth) - TooltipWidth
		  
		  App.ShowTooltip(Self.mItems(Self.mMouseOverIndex).HelpTag, Min(X, MaxX), Y + 16)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ItemPressed(Item As OmniBarItem, ItemRect As Rect)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize(DraggedResizer As OmniBarItem, DeltaX As Integer, DeltaY As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResizeFinished(DraggedResizer As OmniBarItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResizeStarted(DraggedResizer As OmniBarItem)
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
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		Alignment As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBackgroundColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBackgroundColor <> Value Then
			    Self.mBackgroundColor = Value
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		BackgroundColor As OmniBar.BackgroundColors
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
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		LeftPadding As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAlignment As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackgroundColor As OmniBar.BackgroundColors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mColorProfiles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoldTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverCallbackKey As String
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
		Private mMouseDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseHeld As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseOverIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMousePoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverflowRect As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverflowStopIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightPadding As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsedLongAction As Boolean
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
			    Self.Refresh
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

	#tag Constant, Name = DefaultEdgePadding, Type = Double, Dynamic = False, Default = \"20", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FirstRowIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OverflowItemIndex, Type = Double, Dynamic = False, Default = \"-2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = OverflowWidth, Type = Double, Dynamic = False, Default = \"20", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateHover, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateNormal, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatePressed, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


	#tag Enum, Name = BackgroundColors, Type = Integer, Flags = &h0
		Natural
		  Blue
		  Gray
		  Green
		  Orange
		  Pink
		  Purple
		  Red
		Yellow
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBar.BackgroundColors"
			EditorType="Enum"
			#tag EnumValues
				"0 - Natural"
				"1 - Blue"
				"2 - Gray"
				"3 - Green"
				"4 - Orange"
				"5 - Pink"
				"6 - Purple"
				"7 - Red"
				"8 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
