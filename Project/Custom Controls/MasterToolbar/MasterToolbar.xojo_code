#tag Class
Protected Class MasterToolbar
Inherits ControlCanvas
Implements ObservationKit.Observer,  AnimationKit.ValueAnimator
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.mMouseDownItem = Self.ItemAtPixel(X, Y)
		  Self.mPressedItem = Self.mMouseDownItem
		  Self.Invalidate
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownItem = Nil Then
		    Return
		  End If
		  
		  If Self.mMouseDownItem.Rect.Contains(New REALbasic.Point(X, Y)) Then
		    If Self.mPressedItem = Nil Then
		      Self.mPressedItem = Self.mMouseDownItem
		      Self.Invalidate
		    End If
		  Else
		    If Self.mPressedItem <> Nil Then
		      Self.mPressedItem = Nil
		      Self.Invalidate
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownItem = Nil Then
		    Return
		  End If
		  
		  Dim Item As MasterToolbarItem = Self.mMouseDownItem
		  Self.mMouseDownItem = Nil
		  Self.mPressedItem = Nil
		  Self.Invalidate
		  
		  If Item.Rect.Contains(New REALbasic.Point(X, Y)) Then
		    RaiseEvent ViewClicked(Item.View)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #if BeaconUI.ToolbarHasBackground
		    G.ForeColor = Self.ColorProfile.BackgroundColor
		    G.FillRect(0, 0, G.Width, G.Height)
		  #endif
		  
		  Self.mSidebarRect = Self.DrawSwitchSet(G, Self.CellHorizontalSpacing, Self.mSidebarItems, Self.mSidebarHighlightRect)
		  Self.mMainRect = Self.DrawSwitchSet(G, Self.mSidebarRect.Right + Self.CellHorizontalSpacing, Self.mMainItems, Self.mMainHighlightRect)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddView(View As BeaconSubview, ToSidebar As Boolean)
		  If ToSidebar Then
		    Self.mSidebarItems.Append(New MasterToolbarItem(View))
		  Else
		    Self.mMainItems.Append(New MasterToolbarItem(View))
		  End If
		  View.AddObserver(Self, "ToolbarCaption", "ToolbarIcon")
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As Text, Value As Double)
		  // Part of the AnimationKit.ValueAnimator interface.
		  
		  Select Case Identifier
		  Case "SidebarHighlightLeft"
		    Self.mSidebarHighlightRect.Left = Value
		    Self.Invalidate
		  Case "SidebarHighlightWidth"
		    Self.mSidebarHighlightRect.Width = Value
		    Self.Invalidate
		  Case "MainHighlightLeft"
		    Self.mMainHighlightRect.Left = Value
		    Self.Invalidate
		  Case "MainHighlightWidth"
		    Self.mMainHighlightRect.Width = Value
		    Self.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawItem(G As Graphics, Item As MasterToolbarItem, Highlighted As Boolean)
		  G = G.Clip(Item.Rect.Left, Item.Rect.Top, Item.Rect.Width, Item.Rect.Height)
		  
		  Dim BackgroundColor As Color = If(Highlighted, Self.ColorProfile.PrimaryColor, Self.ColorProfile.SelectedBackgroundColor)
		  Dim ForegroundColor, ShadowColor As Color
		  If BackgroundColor.IsBright Then
		    ForegroundColor = BackgroundColor.Darker(0.7)
		    ShadowColor = BackgroundColor.Lighter(0.35)
		  Else
		    ForegroundColor = &cFFFFFF
		    ShadowColor = BackgroundColor.Darker(0.4)
		  End If
		  
		  Dim Icon As Picture = BeaconUI.IconWithColor(Item.Icon, ForegroundColor)
		  Dim IconShadow As Picture = BeaconUI.IconWithColor(Item.Icon, ShadowColor)
		  
		  G.DrawPicture(IconShadow, (G.Width - IconShadow.Width) / 2, Self.CellVerticalPadding + 1)
		  G.DrawPicture(Icon, (G.Width - Icon.Width) / 2, Self.CellVerticalPadding)
		  
		  Dim CaptionWidth As Integer = Ceil(G.StringWidth(Item.Caption))
		  Dim CaptionLeft As Integer = (G.Width - CaptionWidth) / 2
		  Dim CaptionTop As Integer = (Self.CellVerticalPadding * 2) + Self.CellSize + G.CapHeight
		  
		  G.ForeColor = ShadowColor
		  G.DrawString(Item.Caption, CaptionLeft, CaptionTop + 1)
		  G.ForeColor = ForegroundColor
		  G.DrawString(Item.Caption, CaptionLeft, CaptionTop)
		  
		  If Self.mPressedItem = Item Then
		    G.ForeColor = &c000000a4
		    G.FillRoundRect(0, 0, G.Width, G.Height, Self.CellCornerSize, Self.CellCornerSize)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DrawSwitchSet(G As Graphics, SwitchLeft As Integer, Items() As MasterToolbarItem, HighlightRect As REALbasic.Rect) As REALbasic.Rect
		  For I As Integer = Items.Ubound DownTo 0
		    If Not Items(I).IsValid Then
		      Items.Remove(I)
		    End If
		  Next
		  
		  Dim SwitchHeight As Integer = (Self.CellVerticalPadding * 3) + Self.CellSize + G.CapHeight + (Self.CellVerticalSpacing * 2)
		  Dim SwitchTop As Integer = Self.CellVerticalSpacing
		  
		  // yes, vertical is correct
		  Dim SwitchWidth As Integer = Self.CellVerticalSpacing * 2
		  Dim NextSwitchLeft As Integer = SwitchLeft + Self.CellVerticalSpacing
		  For I As Integer = 0 To Items.Ubound
		    Dim InsideWidth As Integer = Max(Items(I).Icon.Width, Ceil(G.StringWidth(Items(I).Caption)))
		    Items(I).Rect = New REALbasic.Rect(NextSwitchLeft, SwitchTop + Self.CellVerticalSpacing, InsideWidth + (Self.CellHorizontalPadding * 2), SwitchHeight - (Self.CellVerticalSpacing * 2))
		    SwitchWidth = SwitchWidth + Items(I).Rect.Width
		    NextSwitchLeft = Items(I).Rect.Right
		  Next
		  
		  G.ForeColor = Self.ColorProfile.ShadowColor
		  G.FillRoundRect(SwitchLeft, SwitchTop + 1, SwitchWidth, SwitchHeight, Self.CellCornerSize, Self.CellCornerSize)
		  G.ForeColor = Self.ColorProfile.SelectedBackgroundColor
		  G.FillRoundRect(SwitchLeft, SwitchTop, SwitchWidth, SwitchHeight, Self.CellCornerSize, Self.CellCornerSize)
		  G.ForeColor = Self.ColorProfile.BorderColor
		  G.DrawRoundRect(SwitchLeft, SwitchTop, SwitchWidth, SwitchHeight, Self.CellCornerSize, Self.CellCornerSize)
		  
		  For I As Integer = 0 To Items.Ubound
		    Self.DrawItem(G, Items(I), False)
		  Next
		  
		  If HighlightRect <> Nil Then
		    Dim HighlightClip As Graphics = G.Clip(HighlightRect.Left, HighlightRect.Top, HighlightRect.Width, HighlightRect.Height)
		    HighlightClip.ForeColor = Self.ColorProfile.PrimaryColor
		    HighlightClip.FillRoundRect(0, 0, HighlightClip.Width, HighlightClip.Height, Self.CellCornerSize, Self.CellCornerSize)
		    
		    For I As Integer = 0 To Items.Ubound
		      If Not Items(I).Rect.Intersects(HighlightRect) Then
		        Continue
		      End If
		      Dim OriginalRect As REALbasic.Rect = Items(I).Rect
		      Items(I).Rect = New REALbasic.Rect(OriginalRect.Left - HighlightRect.Left, OriginalRect.Top - HighlightRect.Top, OriginalRect.Width, OriginalRect.Height)
		      Self.DrawItem(HighlightClip, Items(I), True)
		      Items(I).Rect = OriginalRect
		    Next
		  End If
		  
		  Return New REALbasic.Rect(SwitchLeft, SwitchTop, SwitchWidth, SwitchHeight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ItemAtPixel(X As Integer, Y As Integer) As MasterToolbarItem
		  Dim Point As New REALbasic.Point(X, Y)
		  For I As Integer = 0 To Self.mSidebarItems.Ubound
		    If Self.mSidebarItems(I).Rect <> Nil And Self.mSidebarItems(I).Rect.Contains(Point) Then
		      Return Self.mSidebarItems(I)
		    End If
		  Next
		  For I As Integer = 0 To Self.mMainItems.Ubound
		    If Self.mMainItems(I).Rect <> Nil And Self.mMainItems(I).Rect.Contains(Point) Then
		      Return Self.mMainItems(I)
		    End If
		  Next
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As Text, Value As Auto)
		  // Part of the ObservationKit.Observer interface.
		  
		  Self.Invalidate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectView(View As BeaconSubview, Animated As Boolean = True)
		  Dim InSidebar As Boolean
		  Dim Item As MasterToolbarItem
		  For I As Integer = 0 To Self.mSidebarItems.Ubound
		    If Self.mSidebarItems(I).View = View Then
		      InSidebar = True
		      Item = Self.mSidebarItems(I)
		      Exit
		    End If
		  Next
		  If Item = Nil Then
		    For I As Integer = 0 To Self.mMainItems.Ubound
		      If Self.mMainItems(I).View = View Then
		        Item = Self.mMainItems(I)
		        Exit
		      End If
		    Next
		  End If
		  If Item = Nil Then
		    Return
		  End If
		  
		  If Item.Rect = Nil Then
		    // Brand new, force a paint to get a rect
		    Self.Refresh()
		  End If
		  
		  Dim TargetRect As REALbasic.Rect
		  Dim Prefix As Text
		  If InSidebar Then
		    If Self.mSidebarLeftAnimation <> Nil Then
		      Self.mSidebarLeftAnimation.Cancel
		      Self.mSidebarLeftAnimation = Nil
		    End If
		    If Self.mSidebarWidthAnimation <> Nil Then
		      Self.mSidebarWidthAnimation.Cancel
		      Self.mSidebarWidthAnimation = NIl
		    End If
		    TargetRect = Self.mSidebarHighlightRect
		    Prefix = "Sidebar"
		  Else
		    If Self.mMainLeftAnimation <> Nil Then
		      Self.mMainLeftAnimation.Cancel
		      Self.mMainLeftAnimation = Nil
		    End If
		    If Self.mMainWidthAnimation <> Nil Then
		      Self.mMainWidthAnimation.Cancel
		      Self.mMainWidthAnimation = NIl
		    End If
		    TargetRect = Self.mMainHighlightRect
		    Prefix = "Main"
		  End If
		  
		  If Not Animated Or TargetRect = Nil Then
		    // Set it now
		    TargetRect = New REALbasic.Rect(Item.Rect.Left, Item.Rect.Top, Item.Rect.Width, Item.Rect.Height)
		    If InSidebar Then
		      Self.mSidebarHighlightRect = TargetRect
		    Else
		      Self.mMainHighlightRect = TargetRect
		    End If
		    Self.Invalidate
		    Return
		  End If
		  
		  Dim LeftAnimation As New AnimationKit.ValueTask(Self, Prefix + "HighlightLeft", TargetRect.Left, Item.Rect.Left)
		  LeftAnimation.DurationInSeconds = 0.15
		  LeftAnimation.Curve = AnimationKit.Curve.CreateEaseOut
		  LeftAnimation.Run
		  
		  Dim WidthAnimation As New AnimationKit.ValueTask(Self, Prefix + "HighlightWidth", TargetRect.Width, Item.Rect.Width)
		  WidthAnimation.DurationInSeconds = LeftAnimation.DurationInSeconds
		  WidthAnimation.Curve = LeftAnimation.Curve
		  WidthAnimation.Run
		  
		  If InSidebar Then
		    Self.mSidebarLeftAnimation = LeftAnimation
		    Self.mSidebarWidthAnimation = WidthAnimation
		  Else
		    Self.mMainLeftAnimation = LeftAnimation
		    Self.mMainWidthAnimation = WidthAnimation
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ViewClicked(View As BeaconSubview)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mMainHighlightRect As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainItems() As MasterToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainLeftAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainRect As REALBasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainWidthAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownItem As MasterToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressedItem As MasterToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSidebarHighlightRect As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSidebarItems() As MasterToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSidebarLeftAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSidebarRect As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSidebarWidthAnimation As AnimationKit.ValueTask
	#tag EndProperty


	#tag Constant, Name = CellCornerSize, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellHorizontalPadding, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellHorizontalSpacing, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellSize, Type = Double, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellVerticalPadding, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CellVerticalSpacing, Type = Double, Dynamic = False, Default = \"4", Scope = Private
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
