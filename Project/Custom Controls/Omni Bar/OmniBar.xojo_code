#tag Class
Protected Class OmniBar
Inherits ControlCanvas
Implements ObservationKit.Observer,NotificationKit.Receiver
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
		  Self.mMouseHeld = False
		  Self.mUsedLongAction = False
		  Self.Invalidate(Self.mMouseDownIndex)
		  
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
		        Self.Refresh(False)
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
		  
		  If OldIndex > -1 And Self.mMouseOverIndex <> OldIndex Then
		    Var OldRect As Rect = Self.mItemRects(OldIndex)
		    Self.Invalidate(OldRect.Left, OldRect.Top, OldRect.Width, OldRect.Height)
		  End If
		  
		  If Self.mMouseOverIndex > -1 And Self.mMouseOverIndex <> OldIndex Then
		    Var OverRect As Rect = Self.mItemRects(Self.mMouseOverIndex)
		    Self.Invalidate(OverRect.Left, OverRect.Top, OverRect.Width, OverRect.Height)
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
		  
		  If OldIndex <> Self.mMouseOverIndex Then
		    App.HideTooltip
		    CallLater.Cancel(Self.mHoverCallbackKey)
		    
		    If Self.mMouseOverIndex > -1 And Self.mItems(Self.mMouseOverIndex).HelpTag.IsEmpty = False Then
		      Self.mHoverCallbackKey = CallLater.Schedule(1000, WeakAddressOf ShowHoverTooltip)
		    End If
		  End If
		  
		  If Self.mMouseOverIndex > -1 And Self.mItems(Self.mMouseOverIndex).Type = OmniBarItem.Types.HorizontalResizer And Self.mItems(Self.mMouseOverIndex).Enabled = True Then
		    Self.MouseCursor = System.Cursors.SplitterEastWest
		  ElseIf Self.mMouseOverIndex > -1 And Self.mItems(Self.mMouseOverIndex).Type = OmniBarItem.Types.VerticalResizer And Self.mItems(Self.mMouseOverIndex).Enabled = True Then
		    Self.MouseCursor = System.Cursors.SplitterNorthSouth
		  Else
		    Self.MouseCursor = System.Cursors.StandardPointer
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
		  Self.mHoldTimer.RunMode = Timer.RunModes.Off
		  
		  If Self.mMouseDownIndex > -1 And Self.mItems(Self.mMouseDownIndex).IsResizer Then
		    RaiseEvent ResizeFinished(Self.mItems(Self.mMouseDownIndex))
		  End If
		  
		  If Self.mMouseDownIndex > -1 And Self.mUsedLongAction = False And Self.IndexAtPoint(Self.mMousePoint) = Self.mMouseDownIndex And Self.mItems(Self.mMouseDownIndex).Enabled = True And Self.mItems(Self.mMouseDownIndex).IsResizer = False Then
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
		  End If
		  
		  Self.mMouseDown = False
		  Self.mMouseDownIndex = -1
		  Self.mMouseOverIndex = Self.IndexAtPoint(Self.mMousePoint)
		  
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused SafeArea
		  
		  If Self.mColorProfile Is Nil Then
		    Self.mColorProfile = New OmniBarColorProfile
		  End If
		  
		  Self.mItemRects = Self.ComputeRects(G)
		  
		  G.ClearRectangle(0, 0, G.Width, G.Height)
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(0, G.Height - 1, G.Width, 1)
		  
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    Var ItemRect As Rect = Self.mItemRects(Idx)
		    If Item Is Nil Or ItemRect Is Nil Then
		      Continue
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
		    If Self.mMouseDown And Self.mMouseOverIndex = Idx And Self.mMouseDownIndex = Idx Then
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
		    Item.DrawInto(Clip, Self.mColorProfile, MouseDown, MouseHover, LocalPoint, Highlighted)
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(ParamArray Items() As OmniBarItem)
		  For Each Item As OmniBarItem In Items
		    If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		      Item.AddObserver(Self, "MinorChange", "MajorChange")
		      Self.mItems.Add(Item)
		      Self.Invalidate
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ComputeRects(G As Graphics) As Rect()
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
		    Return Self.ComputeRects(G, Priorities(0), Fits)
		  End If
		  Priorities.Sort
		  
		  For Idx As Integer = 0 To Priorities.LastIndex
		    Var Priority As Integer = Priorities(Idx)
		    Var Rects() As Rect = Self.ComputeRects(G, Priority, Fits)
		    If Fits Or Idx = Priorities.LastIndex Then
		      Return Rects
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ComputeRects(G As Graphics, MinPriority As Integer, ByRef Fits As Boolean) As Rect()
		  // First, compute the rectangles for each item. It's ok to assume left alignment here,
		  // as we'll apply an offset later.
		  
		  Const DefaultEdgePadding = 20
		  
		  Var NextPos As Double = 0
		  Var Rects() As Rect
		  Var FlexSpaceIndexes() As Integer
		  Rects.ResizeTo(Self.mItems.LastIndex)
		  G.Bold = True // Assume all are toggled for the sake of spacing
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Var Item As OmniBarItem = Self.mItems(Idx)
		    If Item Is Nil Then
		      Continue
		    End If
		    
		    If Item.Type = OmniBarItem.Types.FlexSpace Then
		      FlexSpaceIndexes.Add(Idx)
		      Rects(Idx) = New Rect(NextPos, 0, 0, G.Height)
		    ElseIf Item.Priority < MinPriority Then
		      Rects(Idx) = New Rect(NextPos, 0, 0, G.Height)
		    Else
		      Var ItemWidth As Double = Item.Width(G)
		      Var Previousitem As OmniBarItem
		      For PreviousIdx As Integer = Idx - 1 DownTo 0
		        If Rects(PreviousIdx).Width > 0 Then
		          PreviousItem = Self.mItems(PreviousIdx)
		          Exit For PreviousIdx
		        End If
		      Next
		      
		      Var LeftMargin As Integer
		      If PreviousItem Is Nil Then
		        LeftMargin = If(Self.LeftPadding = -1, DefaultEdgePadding, Self.LeftPadding)
		      Else
		        LeftMargin = Max(PreviousItem.Margin(Item), Item.Margin(PreviousItem))
		      End If
		      
		      Rects(Idx) = New Rect(NextPos + LeftMargin, 0, ItemWidth, G.Height)
		      If ItemWidth > 0 And Idx < Self.mItems.LastIndex Then
		        NextPos = Rects(Idx).Right
		      End If
		    End If
		  Next
		  
		  Var MinX, MaxX As Integer
		  Var First As Boolean = True
		  For Idx As Integer = 0 To Rects.LastIndex
		    If Rects(Idx).Width = 0 Then
		      Continue
		    End If
		    If First Then
		      MinX = Rects(Idx).Left
		      MaxX = Rects(Idx).Right
		      First = False
		    Else
		      MinX = Min(MinX, Rects(Idx).Left)
		      MaxX = Max(MaxX, Rects(Idx).Right)
		    End If
		  Next
		  
		  Var AvailableWidth As Integer = G.Width - (If(Self.LeftPadding = -1, DefaultEdgePadding, Self.LeftPadding) + If(Self.RightPadding = -1, DefaultEdgePadding, Self.RightPadding))
		  Var ItemsWidth As Integer = MaxX - MinX
		  Fits = (ItemsWidth <= AvailableWidth)
		  
		  If FlexSpaceIndexes.Count > 0 Then
		    Var FlexWidth As Integer = AvailableWidth - ItemsWidth
		    Var FlexItemWidth As Integer = Max(Floor(FlexWidth / FlexSpaceIndexes.Count), 0)
		    Var FlexRemainder As Integer = AvailableWidth - (FlexItemWidth * FlexSpaceIndexes.Count)
		    
		    For FlexNum As Integer = 0 To FlexSpaceIndexes.LastIndex
		      Var Idx As Integer = FlexSpaceIndexes(FlexNum)
		      Var ItemWidth As Integer = FlexItemWidth + If(FlexNum < FlexRemainder, 1, 0)
		      Rects(Idx) = New Rect(Rects(Idx).Left, Rects(Idx).Top, ItemWidth, Rects(Idx).Height)
		      For ItemIdx As Integer = Idx + 1 To Rects.LastIndex
		        Rects(ItemIdx).Offset(ItemWidth, 0)
		      Next
		    Next
		  End If
		  
		  G.Bold = False
		  Return Rects
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
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
		  For Idx As Integer = 0 To Min(Self.mItemRects.LastIndex, Self.mItems.LastIndex)
		    If (Self.mItemRects(Idx) Is Nil) = False And Self.mItemRects(Idx).Contains(Point) Then
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
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(Idx As Integer)
		  If Idx < Self.mItemRects.FirstRowIndex Or Idx > Self.mItemRects.LastIndex Then
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
		Function LastIndex() As Integer
		  Return Self.mItems.LastIndex
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

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_AppearanceChanged
		    Self.Invalidate()
		  End Select
		End Sub
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
		Shared Sub RebuildColors()
		  mColorProfile = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  If Idx >= 0 And Idx <= Self.mItems.LastIndex Then
		    Self.mItems(Idx).RemoveObserver(Self, "MinorChange", "MajorChange")
		    Self.mItems.RemoveAt(Idx)
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
		    For Idx As Integer = Self.mItems.LastIndex DownTo 0
		      Self.mItems(Idx).RemoveObserver(Self, "MinorChange", "MajorChange")
		      Self.mItems.RemoveAt(Idx)
		    Next
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHoverTooltip()
		  If Self.mMouseOverIndex = -1 Then
		    Return
		  End If
		  
		  App.ShowTooltip(Self.mItems(Self.mMouseOverIndex).HelpTag, System.MouseX, System.MouseY + 16)
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
		Private Shared mColorProfile As OmniBarColorProfile
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

	#tag Constant, Name = FirstRowIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateHover, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateNormal, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StatePressed, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


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
