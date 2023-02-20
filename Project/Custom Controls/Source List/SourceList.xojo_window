#tag DesktopWindow
Begin DesktopContainer SourceList Implements AnimationKit.Scrollable
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   598
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   410
   Begin ControlCanvas Content
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   598
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   True
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   410
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  #Pragma Unused Base
		  #Pragma Unused X
		  #Pragma Unused Y
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuItemSelected(selectedItem As DesktopMenuItem) As Boolean
		  #Pragma Unused SelectedItem
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.mSelectedRowIndex = -1
		  
		  #if UseVibrancyView
		    Const NSVisualEffectMaterialSidebar = 7
		    
		    Var VibrancyView As New NSVisualEffectViewMBS(0, 0, Self.Content.Width, Self.Content.Height)
		    VibrancyView.BlendingMode = NSVisualEffectViewMBS.NSVisualEffectBlendingModeBehindWindow
		    VibrancyView.Material = NSVisualEffectMaterialSidebar
		    VibrancyView.State = NSVisualEffectViewMBS.NSVisualEffectStateFollowsWindowActiveState
		    VibrancyView.AutoresizesSubviews = True
		    VibrancyView.AutoresizingMask = NSViewMBS.NSViewWidthSizable Or NSViewMBS.NSViewHeightSizable
		    
		    Var CanvasView As NSViewMBS = Self.Content.NSViewMBS
		    Var RootView As NSViewMBS = Self.NSViewMBS
		    CanvasView.RemoveFromSuperviewWithoutNeedingDisplay
		    RootView.AddSubview(VibrancyView)
		    RootView.AddSubview(CanvasView)
		  #endif
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  Self.Resize()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  Self.Resize()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(ParamArray Items() As SourceListItem)
		  For Each Item As SourceListItem In Items
		    If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		      Self.mItems.Add(Item)
		      Self.Content.Refresh
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexAtPoint(X As Integer, Y As Integer) As Integer
		  Return Self.IndexAtPoint(New Xojo.Point(X, Y))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexAtPoint(Point As Xojo.Point) As Integer
		  If Point Is Nil Then
		    Return -1
		  End If
		  
		  For Idx As Integer = 0 To Self.mItemRects.LastIndex
		    If (Self.mItemRects(Idx) Is Nil) = False And Self.mItemRects(Idx).Contains(Point) Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As SourceListItem) As Integer
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    If Self.mItems(Idx) = Item Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InDismissRect(Point As Point, Idx As Integer) As Boolean
		  If Idx < Self.mDismissRects.FirstIndex Or Idx > Self.mDismissRects.LastIndex Then
		    Return False
		  End If
		  
		  Return (Self.mDismissRects(Idx) Is Nil) = False And Self.mDismissRects(Idx).Contains(Point)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Idx As Integer, Item As SourceListItem)
		  If (Item Is Nil) = False And Self.IndexOf(Item) = -1 Then
		    If Idx < Self.mSelectedRowIndex Then
		      Self.mSelectedRowIndex = Self.mSelectedRowIndex + 1
		    End If
		    
		    Self.mItems.AddAt(Idx, Item)
		    Self.Content.Refresh
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Idx As Integer) As SourceListItem
		  If Idx >= 0 And Idx <= Self.mItems.LastIndex Then
		    Return Self.mItems(Idx)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Item(Idx As Integer, Assigns Item As SourceListItem)
		  If Idx >= 0 And Idx <= Self.mItems.LastIndex Then
		    Self.mItems(Idx) = Item
		    Self.Refresh(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastItemIndex() As Integer
		  Return Self.mItems.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Refresh(Idx As Integer)
		  If Idx < Self.mItemRects.FirstRowIndex Or Idx > Self.mItemRects.LastIndex Then
		    Self.Content.Refresh(False)
		    Return
		  End If
		  
		  Var ItemRect As Rect = Self.mItemRects(Idx)
		  If ItemRect Is Nil Then
		    Self.Content.Refresh(False)
		    Return
		  End If
		  
		  Self.Content.Refresh(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  If Idx >= 0 And Idx <= Self.mItems.LastIndex Then
		    Self.mItems.RemoveAt(Idx)
		    
		    If Idx < Self.mSelectedRowIndex Then
		      // So that Change is not fired
		      Self.mSelectedRowIndex = Self.mSelectedRowIndex - 1
		    ElseIf Idx = Self.mSelectedRowIndex Then
		      // So that Change *is* fired
		      Self.SelectedRowIndex = Self.SelectedRowIndex - 1
		    End If
		    
		    Self.Content.Refresh
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAllItems()
		  Self.mItems.ResizeTo(-1)
		  Self.SelectedRowIndex = -1
		  Self.Content.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceContents(Items() As SourceListItem)
		  // Replaces contents without firing change events if possible
		  
		  Var TargetTag As Variant = Self.SelectedTag
		  Var NewRowIndex As Integer = -1
		  For Idx As Integer = 0 To Items.LastIndex
		    If Items(Idx).Tag = TargetTag Then
		      NewRowIndex = Idx
		      Exit
		    End If
		  Next
		  
		  If NewRowIndex > -1 Then
		    // Can be done without a change event
		    Self.mItems = Items
		    Self.mSelectedRowIndex = NewRowIndex
		    Self.Content.Refresh
		    Return
		  End If
		  
		  // Since the the original can't be found, that means we need to fire a ShouldChange, which could cancel this operation.
		  If IsEventImplemented("ShouldChange") Then
		    If Not RaiseEvent ShouldChange(NewRowIndex) Then
		      Return
		    End If
		  End If
		  
		  Self.mItems = Items
		  Self.mSelectedRowIndex = -1
		  Self.Content.Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Resize()
		  If Self.mLastWidth = Self.Width And Self.mLastHeight = Self.Height Then
		    Return
		  End If
		  
		  Self.mLastWidth = Self.Width
		  Self.mLastHeight = Self.Height
		  
		  RaiseEvent Resize()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMaximum() As Double
		  // Part of the AnimationKit.Scrollable interface.
		  
		  Return Self.Content.ScrollMaximum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ScrollMaximum(Assigns Value As Double)
		  // Part of the AnimationKit.Scrollable interface.
		  
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMinimum() As Double
		  // Part of the AnimationKit.Scrollable interface.
		  
		  Return Self.Content.ScrollMinimum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ScrollMinimum(Assigns Value As Double)
		  // Part of the AnimationKit.Scrollable interface.
		  
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollPosition() As Double
		  // Part of the AnimationKit.Scrollable interface.
		  
		  Return Self.Content.ScrollPosition
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollPosition(Assigns Value As Double)
		  // Part of the AnimationKit.Scrollable interface.
		  
		  Self.Content.ScrollPosition = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedItem() As SourceListItem
		  If Self.SelectedRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.Item(Self.SelectedRowIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedItem(Assigns Item As SourceListItem)
		  Self.SelectedRowIndex = Self.IndexOf(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedTag() As Variant
		  If Self.mSelectedRowIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mItems(Self.mSelectedRowIndex).Tag
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedTag(Assigns Tag As Variant)
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    If Self.mItems(Idx).Tag = Tag Then
		      Self.SelectedRowIndex = Idx
		      Return
		    End If
		  Next
		  Self.SelectedRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetMousePoint(Point As Point)
		  Self.mMousePoint = Point
		  
		  Var OldIndex As Integer = Self.mMouseOverIndex
		  Self.mMouseOverIndex = Self.IndexAtPoint(Point)
		  
		  If Self.mMouseOverIndex <> OldIndex Then
		    If OldIndex > -1 Then
		      Self.Refresh(OldIndex)
		    End If
		    If Self.mMouseOverIndex > -1 Then
		      Self.Refresh(Self.mMouseOverIndex)
		    End If
		  End If
		  
		  If Self.mMouseOverIndex > -1 Then
		    Var InsideDismissRect As Boolean = Self.InDismissRect(Point, Self.mMouseOverIndex)
		    If InsideDismissRect <> Self.mInsideDismissRect Then
		      Self.Refresh(Self.mMouseOverIndex)
		    End If
		    Self.mInsideDismissRect = InsideDismissRect
		  Else
		    Self.mInsideDismissRect = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort()
		  Var Names() As String
		  Var SelectedItem As SourceListItem = Self.Item(Self.SelectedRowIndex)
		  
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Names.Add(Self.mItems(Idx).Caption)
		  Next
		  
		  If Self.mItemRects.LastIndex = Self.mItems.LastIndex Then
		    Names.SortWith(Self.mItems, Self.mItemRects)
		  Else
		    Names.SortWith(Self.mItems)
		    Self.mItemRects.ResizeTo(-1)
		  End If
		  
		  If (SelectedItem Is Nil) = False Then
		    Self.mSelectedRowIndex = Self.IndexOf(SelectedItem)
		  End If
		  
		  Self.Content.Refresh
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContextualClick(MouseX As Integer, MouseY As Integer, ItemIndex As Integer, ItemRect As Rect)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DismissPressed(Item As SourceListItem, ItemIndex As Integer, ItemRect As Rect)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldChange(DesiredIndex As Integer) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDismissRects() As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInsideDismissRect As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItemRects() As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As SourceListItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownInDismiss As Boolean
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
		Private mSelectedRowIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWasContextualClick As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedRowIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelectedRowIndex <> Value Then
			    If IsEventImplemented("ShouldChange") Then
			      If Not RaiseEvent ShouldChange(Value) Then
			        Return
			      End If
			    End If
			    
			    If Self.mSelectedRowIndex > -1 Then
			      Self.Refresh(Self.mSelectedRowIndex)
			    End If
			    Self.mSelectedRowIndex = Value
			    RaiseEvent Change
			    Self.Refresh(Value)
			  End If
			End Set
		#tag EndSetter
		SelectedRowIndex As Integer
	#tag EndComputedProperty


	#tag Constant, Name = UseVibrancyView, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events Content
	#tag Event
		Sub Activated()
		  Me.Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub Deactivated()
		  Me.Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.SetMousePoint(New Point(X, Y))
		  If Self.mMousePoint Is Nil Then
		    Self.mMouseDown = False
		    Return True
		  End If
		  
		  Self.mMouseDown = True
		  Self.mMouseDownPoint = Self.mMousePoint
		  Self.mMouseDownIndex = Self.mMouseOverIndex
		  Self.mMouseDownInDismiss = Self.mInsideDismissRect
		  Self.mWasContextualClick = IsContextualClick = True And Self.mMouseDownInDismiss = False
		  Self.Refresh(Self.mMouseDownIndex)
		  
		  If Self.mWasContextualClick Then
		    // Force the refresh now
		    Self.Refresh(Self.mMouseDownIndex)
		    
		    Var ItemRect As Rect
		    If Self.mMouseOverIndex >= Self.mItemRects.FirstIndex And Self.mMouseOverIndex <= Self.mItemRects.LastIndex Then
		      ItemRect = Self.mItemRects(Self.mMouseOverIndex)
		    End If
		    
		    RaiseEvent ContextualClick(X, Y, Self.mMouseOverIndex, ItemRect)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.SetMousePoint(New Xojo.Point(X, Y))
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
		  
		  Self.SetMousePoint(Nil)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.SetMousePoint(New Point(X, Y))
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.SetMousePoint(New Point(X, Y))
		  
		  If Self.mWasContextualClick = False And Self.mMouseDownIndex > -1 And Self.mMouseOverIndex = Self.mMouseDownIndex Then
		    If Self.mMouseDownInDismiss And Self.mInsideDismissRect Then
		      RaiseEvent DismissPressed(Self.mItems(Self.mMouseDownIndex), Self.mMouseDownIndex, Self.mItemRects(Self.mMouseDownIndex))
		    Else
		      Self.SelectedRowIndex = Self.mMouseDownIndex
		    End If
		  End If
		  
		  Self.mMouseDown = False
		  Self.mMouseDownIndex = -1
		  
		  Me.Refresh
		End Sub
	#tag EndEvent
	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  Var Rects() As Rect
		  Rects.ResizeTo(Self.mItems.LastIndex)
		  
		  Var DismissRects() As Rect
		  DismissRects.ResizeTo(Self.mItems.LastIndex)
		  
		  Const RowHeight = 30
		  Const Inset = 10
		  Const CornerRadius = 8
		  Const Padding = 8
		  Const DismissSize = 16
		  
		  Me.ContentHeight = (Self.mItems.Count * RowHeight) + (Inset * 2)
		  
		  Var LeftMargin As Integer = Max(SafeArea.Left + (Padding / 4), Inset)
		  Var RightMargin As Integer = Max((G.Width - SafeArea.Right) + (Padding / 4), Inset)
		  Var LeftPadding As Integer = Padding
		  Var RightPadding As Integer = Padding
		  Var ItemWidth As Integer = G.Width - (LeftMargin + RightMargin)
		  Var HasDismissButtons As Boolean
		  Var RowTop As Integer = Inset - Me.ScrollPosition
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Rects(Idx) = New Rect(LeftMargin, RowTop, ItemWidth, RowHeight)
		    If Self.mItems(Idx).CanDismiss Then
		      HasDismissButtons = True
		      DismissRects(Idx) = New Rect(Rects(Idx).Right - ((Padding / 4) + DismissSize), Rects(Idx).VerticalCenter - (DismissSize - 8), DismissSize, DismissSize)
		    End If
		    HasDismissButtons = HasDismissButtons Or Self.mItems(Idx).CanDismiss
		    RowTop = RowTop + RowHeight
		  Next
		  
		  Var CaptionMaxWidth As Integer = ItemWidth - (LeftPadding + RightPadding)
		  Var IconDismissRegular As Picture
		  If HasDismissButtons Then
		    CaptionMaxWidth = ItemWidth - (LeftPadding + (RightPadding * 1.25) + DismissSize)
		    
		    IconDismissRegular = BeaconUI.IconWithColor(IconDismissEditor, SystemColors.TertiaryLabelColor, G.ScaleX, G.ScaleX)
		  End If
		  
		  Self.mItemRects = Rects
		  Self.mDismissRects = DismissRects
		  
		  Var Viewport As New Rect(0, 0, G.Width, G.Height)
		  For Idx As Integer = 0 To Self.mItems.LastIndex
		    Var ItemRect As Rect = Self.mItemRects(Idx)
		    Var Draw As Boolean
		    If Viewport.Intersects(ItemRect) Then
		      If Areas.LastIndex = -1 Then
		        Draw = True
		      Else
		        For Each Area As Rect In Areas
		          If Area.Intersects(ItemRect) Then
		            Draw = True
		          End If
		        Next
		      End If
		    End If
		    If Not Draw Then
		      Continue
		    End If
		    
		    Var Clip As Graphics = G.Clip(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height)
		    Var CaptionBaseline As Double = (Clip.Height / 2) + (Clip.CapHeight / 2)
		    Var CaptionLeft As Double = LeftPadding
		    
		    If Self.SelectedRowIndex = Idx Then
		      Clip.DrawingColor = If(Highlighted, SystemColors.SelectedContentBackgroundColor, SystemColors.UnemphasizedSelectedContentBackgroundColor)
		      Clip.FillRoundRectangle(0, 0, Clip.Width, Clip.Height, CornerRadius, CornerRadius)
		      Clip.DrawingColor = If(Highlighted, SystemColors.AlternateSelectedControlTextColor, SystemColors.UnemphasizedSelectedTextColor)
		    Else
		      Clip.DrawingColor = SystemColors.LabelColor
		    End If
		    Clip.DrawText(Self.mItems(Idx).Caption, CaptionLeft, CaptionBaseline, CaptionMaxWidth, True)
		    
		    If Self.mItems(Idx).CanDismiss Then
		      Var DismissRect As Rect = Self.mDismissRects(Idx).LocalRect(ItemRect)
		      Var DismissIcon As Picture
		      If Self.mInsideDismissRect And Self.mMouseOverIndex = Idx Then
		        // Hover, both selected and not.
		        DismissIcon = BeaconUI.IconWithColor(IconDismissEditor, Clip.DrawingColor, G.ScaleX, G.ScaleY)
		        Clip.DrawingColor = Clip.DrawingColor.AtOpacity(0.2)
		        Clip.FillRoundRectangle(DismissRect.Left, DismissRect.Top, DismissRect.Width, DismissRect.Height, 6, 6)
		      ElseIf SelectedRowIndex = Idx Then
		        // Selected, no hover.
		        DismissIcon = BeaconUI.IconWithColor(IconDismissEditor, Clip.DrawingColor.AtOpacity(0.5), G.ScaleX, G.ScaleY)
		      Else
		        DismissIcon = IconDismissRegular
		      End If
		      Clip.DrawPicture(DismissIcon, DismissRect.Left, DismissRect.Top)
		      If Self.mMouseDown And Self.mMouseOverIndex = Idx And Self.mMouseDownIndex = Idx And Self.mInsideDismissRect = True Then
		        Clip.DrawingColor = &c000000AA
		        Clip.FillRoundRectangle(DismissRect.Left, DismissRect.Top, DismissRect.Width, DismissRect.Height, 6, 6)
		      End If
		    End If
		    
		    If Self.mMouseDown And Self.mMouseOverIndex = Idx And Self.mMouseDownIndex = Idx And Self.mInsideDismissRect = False And Self.mMouseDownInDismiss = False Then
		      Clip.DrawingColor = &c000000AA
		      Clip.FillRoundRectangle(0, 0, Clip.Width, Clip.Height, CornerRadius, CornerRadius)
		    End If
		  Next
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
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
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
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
		Name="SelectedRowIndex"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
