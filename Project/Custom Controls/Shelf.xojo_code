#tag Class
Protected Class Shelf
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
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim Point As New REALbasic.Point(X,Y)
		  
		  For I As Integer = 0 To Self.mHitRects.Ubound
		    If Self.mHitRects(I) = Nil Then
		      Continue
		    End If
		    If Self.mHitRects(I).Contains(Point) Then
		      Self.mMouseDownItem = I
		      Self.mPressed = True
		      Self.Invalidate
		      Return True
		    End If
		  Next
		  
		  Self.mMouseDownItem = -1
		  Self.mPressed = False
		  Self.Invalidate
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownItem = -1 Then
		    Return
		  End If
		  
		  Dim Point As New REALbasic.Point(X,Y)
		  Dim TargetRect As REALbasic.Rect = Self.mHitRects(Self.mMouseDownItem)
		  If TargetRect.Contains(Point) = True And Self.mPressed = False Then
		    Self.mPressed = True
		    Self.Invalidate
		  ElseIf TargetRect.Contains(Point) = False And Self.mPressed = True Then
		    Self.mPressed = False
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  Xojo.Core.Timer.CancelCall(WeakAddressOf ShowHoverToolTip)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Dim Point As New REALbasic.Point(X,Y)
		  For I As Integer = 0 To Self.mHitRects.Ubound
		    If Self.mHitRects(I) = Nil Then
		      Continue
		    End If
		    If Self.mHitRects(I).Contains(Point) Then
		      Xojo.Core.Timer.CancelCall(WeakAddressOf ShowHoverToolTip)
		      Xojo.Core.Timer.CallLater(2000, WeakAddressOf ShowHoverToolTip)
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownItem = -1 Then
		    Return
		  End If
		  
		  Dim Point As New REALbasic.Point(X,Y)
		  Dim TargetRect As REALbasic.Rect = Self.mHitRects(Self.mMouseDownItem)
		  If TargetRect.Contains(Point) = True Then
		    Self.mPressed = False
		    If Self.SelectedIndex = Self.mMouseDownItem Then
		      Self.SelectedIndex = -1
		    Else
		      Self.SelectedIndex = Self.mMouseDownItem
		    End If
		    Self.mMouseDownItem = -1
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  Self.Transparent = True
		  Self.DoubleBuffer = False
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  Const CellCornerRadius = 6
		  
		  #Pragma Unused areas
		  
		  G.TextSize = 10
		  G.TextUnit = FontUnits.Point
		  
		  Dim CellPadding, CellSpacing As Double
		  If Self.IsVertical Then
		    CellSpacing = (G.Width - Self.IconSize) / 4
		  Else
		    CellSpacing = (G.Height - Self.IconSize) / 4
		  End If
		  CellPadding = CellSpacing
		  
		  Dim CellWidth As Double = Self.IconSize + (CellPadding * 2)
		  Dim CellHeight As Double = CellWidth
		  
		  Dim MaxCaptionWidth As Double
		  For I As Integer = 0 To Self.mItems.Ubound
		    If Self.mItems(I).Type <> ShelfItem.TypeNormal Then
		      Continue
		    End If
		    
		    MaxCaptionWidth = Max(MaxCaptionWidth, G.StringWidth(Self.mItems(I).Caption))
		  Next
		  If Self.DrawCaptions Then
		    CellWidth = Max(Self.IconSize, MaxCaptionWidth) + (CellPadding * 2)
		    CellHeight = Self.IconSize + (CellPadding * 3) + Self.TextHeight
		  End If
		  
		  Dim MinRequiredSpace, SpaceConsumedByItems As Double
		  Dim Amount As Double = If(Self.IsVertical, CellHeight, CellWidth)
		  Dim FlexibleSpaceCount As Integer
		  For I As Integer = 0 To Self.mItems.Ubound
		    MinRequiredSpace = MinRequiredSpace + Amount
		    Select Case Self.mItems(I).Type
		    Case ShelfItem.TypeNormal, ShelfItem.TypeSpacer
		      SpaceConsumedByItems = SpaceConsumedByItems + Amount
		    Case ShelfItem.TypeFlexibleSpacer
		      FlexibleSpaceCount = FlexibleSpaceCount + 1
		    End Select
		  Next
		  SpaceConsumedByItems = SpaceConsumedByItems + ((Self.Count + 1) * CellSpacing)
		  MinRequiredSpace = MinRequiredSpace + ((Self.Count + 1) * CellSpacing)
		  
		  Dim AdditionalSpaceAvailableToFlexers As Double = Max(MinRequiredSpace - SpaceConsumedByItems, 0)
		  Dim AdditionalFlexibleSpaceSize As Double = AdditionalSpaceAvailableToFlexers / FlexibleSpaceCount
		  
		  Dim NextPos As Double = CellSpacing
		  Redim Self.mHitRects(Self.mItems.Ubound)
		  For I As Integer = 0 To Self.mItems.Ubound
		    If Self.mItems(I).Type = ShelfItem.TypeSpacer Then
		      Self.mHitRects(I) = Nil
		      NextPos = NextPos + If(Self.IsVertical, CellHeight, CellWidth) + CellSpacing
		      Continue For I
		    ElseIf Self.mItems(I).Type = ShelfItem.TypeFlexibleSpacer Then
		      Self.mHitRects(I) = Nil
		      NextPos = NextPos + If(Self.IsVertical, CellHeight, CellWidth) + AdditionalFlexibleSpaceSize + CellSpacing
		      Continue For I
		    End If
		    
		    Dim IconColor As Color = SystemColors.SecondaryLabelColor
		    Dim CellRect As New REALbasic.Rect(If(Self.IsVertical, CellSpacing, NextPos), If(Self.IsVertical, NextPos, CellSpacing), CellWidth, CellHeight)
		    Self.mHitRects(I) = CellRect
		    
		    If Self.mSelectedIndex = I Then
		      G.ForeColor = SystemColors.SelectedContentBackgroundColor
		      G.FillRoundRect(CellRect.Left, CellRect.Top, CellRect.Width, CellRect.Height, CellCornerRadius, CellCornerRadius)
		      IconColor = SystemColors.AlternateSelectedControlTextColor
		    End If
		    
		    Dim IconRect As New REALbasic.Rect(CellRect.Left + ((CellRect.Width - Self.IconSize) / 2), CellRect.Top + CellSpacing, Self.IconSize, Self.IconSize)
		    Dim Icon As Picture = BeaconUI.IconWithColor(Self.mItems(I).Icon, IconColor)
		    G.DrawPicture(Icon, IconRect.Left, IconRect.Top, IconRect.Width, IconRect.Height, 0, 0, Icon.Width, Icon.Height)
		    
		    If Self.DrawCaptions Then
		      Dim Caption As String = Self.mItems(I).Caption
		      Dim CaptionY As Double = IconRect.Bottom + CellSpacing + Self.TextHeight
		      Dim CaptionWidth As Double = G.StringWidth(Caption)
		      CaptionWidth = Min(CaptionWidth, CellRect.Width - (CellPadding * 2))
		      Dim CaptionX As Double = (CellRect.Width - CaptionWidth) / 2
		      
		      G.ForeColor = IconColor
		      G.DrawString(Caption, CaptionX, CaptionY, CaptionWidth, True)
		    End If
		    
		    If Self.mPressed And Self.mMouseDownItem = I Then
		      G.ForeColor = &c000000CC
		      G.FillRoundRect(CellRect.Left, CellRect.Top, CellRect.Width, CellRect.Height, CellCornerRadius, CellCornerRadius)
		    End If
		    
		    NextPos = NextPos + If(Self.IsVertical, CellHeight, CellWidth) + CellSpacing
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Icon As Picture, Caption As String, Tag As String)
		  Self.Add(New ShelfItem(Icon, Caption, Tag))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Item As ShelfItem)
		  Self.mItems.Append(Item)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mItems.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedIndex() As Integer
		  Return Self.mSelectedIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedIndex(Assigns Value As Integer)
		  Value = Max(Min(Self.mItems.Ubound, Value), -1)
		  If Self.mSelectedIndex <> Value Then
		    Self.mSelectedIndex = Value
		    RaiseEvent Change
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedItem() As ShelfItem
		  If Self.mSelectedIndex = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mItems(Self.mSelectedIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedItem(Assigns Value As ShelfItem)
		  If Value = Nil Then
		    Self.SelectedIndex = -1
		    Return
		  End If
		  
		  For I As Integer = 0 To Self.mItems.Ubound
		    If Self.mItems(I).Tag = Value.Tag Then
		      Self.SelectedIndex = I
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHoverToolTip()
		  Dim Point As New REALbasic.Point(Self.MouseX, Self.MouseY)
		  For I As Integer = 0 To Self.mHitRects.Ubound
		    If Self.mHitRects(I) = Nil Then
		      Continue
		    End If
		    If Self.mHitRects(I).Contains(Point) Then
		      Tooltip.Show(Self.mItems(I).Caption, System.MouseX, System.MouseY + 16)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Activate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Change()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Deactivate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDrawCaptions
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDrawCaptions <> Value Then
			    Self.mDrawCaptions = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		DrawCaptions As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.Height > Self.Width
			End Get
		#tag EndGetter
		IsVertical As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDrawCaptions As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHitRects() As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItems() As ShelfItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownItem As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedIndex As Integer = -1
	#tag EndProperty


	#tag Constant, Name = IconSize, Type = Double, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TextHeight, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ScrollSpeed"
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="72"
			Type="Integer"
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
			InitialValue="True"
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
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="376"
			Type="Integer"
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="DoubleBuffer"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Group="Behavior"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Group="Behavior"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsVertical"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawCaptions"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
