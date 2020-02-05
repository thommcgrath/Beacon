#tag Class
Protected Class Shelf
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
		  Var Point As New BeaconUI.Point(X,Y)
		  
		  For I As Integer = 0 To Self.mHitRects.LastRowIndex
		    If Self.mHitRects(I) = Nil Then
		      Continue
		    End If
		    If Self.mHitRects(I).Contains(Point) And (Self.RequiresSelection = False Or I <> Self.mSelectedIndex) Then
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
		  
		  Var Point As New BeaconUI.Point(X,Y)
		  Var TargetRect As BeaconUI.Rect = Self.mHitRects(Self.mMouseDownItem)
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
		  CallLater.Cancel(Self.mHoverCallbackKey)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Var Point As New BeaconUI.Point(X,Y)
		  For I As Integer = 0 To Self.mHitRects.LastRowIndex
		    If Self.mHitRects(I) = Nil Then
		      Continue
		    End If
		    If Self.mHitRects(I).Contains(Point) Then
		      CallLater.Cancel(Self.mHoverCallbackKey)
		      Self.mHoverCallbackKey = CallLater.Schedule(1000, WeakAddressOf ShowHoverToolTip)
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
		  
		  Var Point As New BeaconUI.Point(X,Y)
		  Var TargetRect As BeaconUI.Rect = Self.mHitRects(Self.mMouseDownItem)
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
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  Const CellCornerRadius = 6
		  
		  #Pragma Unused areas
		  
		  G.FontSize = 10
		  G.FontUnit = FontUnits.Point
		  
		  Var PrecisionX As Double = 1 / G.ScaleX
		  Var PrecisionY As Double = 1 / G.ScaleY
		  
		  Var CellPadding, CellSpacing As Double
		  If Self.IsVertical Then
		    CellSpacing = Min((G.Width - Self.IconSize) / 4, 6)
		  Else
		    CellSpacing = Min((G.Height - Self.IconSize) / 4, 6)
		  End If
		  CellPadding = CellSpacing
		  
		  Var FlexibleSpaceCount, StaticSpaceCount As Integer
		  For I As Integer = 0 To Self.mItems.LastRowIndex
		    Select Case Self.mItems(I).Type
		    Case ShelfItem.TypeNormal, ShelfItem.TypeSpacer
		      StaticSpaceCount = StaticSpaceCount + 1
		    Case ShelfItem.TypeFlexibleSpacer
		      FlexibleSpaceCount = FlexibleSpaceCount + 1
		    End Select
		  Next
		  
		  Var AvailableSpace,MaximumCellWidth As Double
		  If Self.IsVertical Then
		    AvailableSpace = G.Height - ((StaticSpaceCount + 1) * CellSpacing)
		    MaximumCellWidth = G.Width - (CellSpacing * 2)
		  Else
		    AvailableSpace = G.Width - ((StaticSpaceCount + 1) * CellSpacing)
		    MaximumCellWidth = AvailableSpace / StaticSpaceCount
		  End If
		  MaximumCellWidth = Max(MaximumCellWidth, Self.IconSize + (CellPadding * 2))
		  
		  Var CellWidth As Double = Self.IconSize + (CellPadding * 2)
		  Var CellHeight As Double = CellWidth
		  
		  Var MaxCaptionWidth As Double
		  For I As Integer = 0 To Self.mItems.LastRowIndex
		    If Self.mItems(I).Type <> ShelfItem.TypeNormal Then
		      Continue
		    End If
		    
		    MaxCaptionWidth = Max(MaxCaptionWidth, G.TextWidth(Self.mItems(I).Caption))
		  Next
		  If Self.DrawCaptions Then
		    CellWidth = Min(Max(Self.IconSize, MaxCaptionWidth) + (CellPadding * 2), MaximumCellWidth)
		    CellHeight = Self.IconSize + (CellPadding * 3) + Self.TextHeight
		  End If
		  
		  Var RequiredSpace As Double = (StaticSpaceCount * If(Self.IsVertical, CellHeight, CellWidth)) + ((StaticSpaceCount + 1) * CellSpacing)
		  Var FlexibleSpaceSize As Double = Max(Floor(AvailableSpace - RequiredSpace) / FlexibleSpaceCount, 0)
		  
		  Var CellDeltaX, CellDeltay As Double
		  If Self.IsVertical Then
		    CellDeltaX = (G.Width - CellWidth) / 2
		  Else
		    CellDeltaY = (G.Height - CellHeight) / 2
		  End If
		  
		  Var NextPos As Double = CellSpacing
		  Self.mHitRects.ResizeTo(Self.mItems.LastRowIndex)
		  For I As Integer = 0 To Self.mItems.LastRowIndex
		    If Self.mItems(I).Type = ShelfItem.TypeSpacer Then
		      Self.mHitRects(I) = Nil
		      NextPos = NextPos + If(Self.IsVertical, CellHeight, CellWidth) + CellSpacing
		      Continue For I
		    ElseIf Self.mItems(I).Type = ShelfItem.TypeFlexibleSpacer Then
		      Self.mHitRects(I) = Nil
		      NextPos = NextPos + FlexibleSpaceSize + CellSpacing
		      Continue For I
		    End If
		    
		    Var IconColor As Color = SystemColors.SecondaryLabelColor
		    Var CellRect As New BeaconUI.Rect(If(Self.IsVertical, 0, NextPos) + CellDeltaX, If(Self.IsVertical, NextPos, 0) + CellDeltaY, CellWidth, CellHeight)
		    Self.mHitRects(I) = CellRect
		    
		    If Self.mSelectedIndex = I Then
		      G.DrawingColor = SystemColors.SelectedContentBackgroundColor
		      G.FillRoundRectangle(NearestMultiple(CellRect.Left, PrecisionX), NearestMultiple(CellRect.Top, PrecisionY), NearestMultiple(CellRect.Width, PrecisionX), NearestMultiple(CellRect.Height, PrecisionY), CellCornerRadius, CellCornerRadius)
		      IconColor = SystemColors.AlternateSelectedControlTextColor
		    End If
		    
		    Var IconRect As New BeaconUI.Rect(NearestMultiple(CellRect.Left + ((CellRect.Width - Self.IconSize) / 2), PrecisionX), NearestMultiple(CellRect.Top + CellSpacing, PrecisionY), Self.IconSize, Self.IconSize)
		    Var Icon As Picture = BeaconUI.IconWithColor(Self.mItems(I).Icon, IconColor)
		    G.DrawPicture(Icon, NearestMultiple(IconRect.Left, PrecisionX), NearestMultiple(IconRect.Top, PrecisionY), NearestMultiple(IconRect.Width, PrecisionX), NearestMultiple(IconRect.Height, PrecisionY), 0, 0, Icon.Width, Icon.Height)
		    
		    If Self.mItems(I).NotificationColor <> ShelfItem.NotificationColors.None Then
		      Var PulseColor As Color
		      If Self.mSelectedIndex = I Then
		        PulseColor = SystemColors.AlternateSelectedControlTextColor
		      Else
		        Select Case Self.mItems(I).NotificationColor
		        Case ShelfItem.NotificationColors.Blue
		          PulseColor = SystemColors.SystemBlueColor
		        Case ShelfItem.NotificationColors.Brown
		          PulseColor = SystemColors.SystemBrownColor
		        Case ShelfItem.NotificationColors.Gray
		          PulseColor = SystemColors.SystemGrayColor
		        Case ShelfItem.NotificationColors.Green
		          PulseColor = SystemColors.SystemGreenColor
		        Case ShelfItem.NotificationColors.Orange
		          PulseColor = SystemColors.SystemOrangeColor
		        Case ShelfItem.NotificationColors.Pink
		          PulseColor = SystemColors.SystemPinkColor
		        Case ShelfItem.NotificationColors.Purple
		          PulseColor = SystemColors.SystemPurpleColor
		        Case ShelfItem.NotificationColors.Red
		          PulseColor = SystemColors.SystemRedColor
		        Case ShelfItem.NotificationColors.Yellow
		          PulseColor = SystemColors.SystemYellowColor
		        End Select
		      End If
		      
		      Var PulseAmount As Double = Self.mItems(I).PulseAmount
		      Var DotRect As New BeaconUI.Rect(IconRect.Right - Self.NotificationDotSize, IconRect.Top, Self.NotificationDotSize, Self.NotificationDotSize)
		      
		      G.DrawingColor = PulseColor
		      G.FillOval(DotRect.Left, DotRect.Top, DotRect.Width, DotRect.Height)
		      If PulseAmount > 0 Then
		        Var PrecisePulseSize As Double = Self.NotificationDotSize + ((Self.NotificationDotSize * 2) * PulseAmount)
		        Var PulseSize As Double = NearestMultiple(PrecisePulseSize, PrecisionX * 2)
		        G.DrawingColor = PulseColor.AtOpacity(1.0 - PulseAmount)
		        G.DrawOval(DotRect.Left - ((PulseSize - Self.NotificationDotSize) / 2), DotRect.Top - ((PulseSize - Self.NotificationDotSize) / 2), PulseSize, PulseSize)
		      End If
		    End If
		    
		    If Self.DrawCaptions Then
		      Var Caption As String = Self.mItems(I).Caption
		      Var CaptionY As Double = IconRect.Bottom + CellSpacing + Self.TextHeight
		      Var CaptionWidth As Double = G.TextWidth(Caption)
		      CaptionWidth = Min(CaptionWidth, CellRect.Width - (CellPadding * 2))
		      Var CaptionX As Double = CellRect.Left + ((CellRect.Width - CaptionWidth) / 2)
		      
		      G.DrawingColor = IconColor
		      G.DrawText(Caption, NearestMultiple(CaptionX, PrecisionX), NearestMultiple(CaptionY, PrecisionY), NearestMultiple(CellRect.Width, PrecisionX), True)
		    End If
		    
		    If Self.mPressed And Self.mMouseDownItem = I Then
		      G.DrawingColor = &c000000CC
		      G.FillRoundRectangle(NearestMultiple(CellRect.Left, PrecisionX), NearestMultiple(CellRect.Top, PrecisionY), NearestMultiple(CellRect.Width, PrecisionX), NearestMultiple(CellRect.Height, PrecisionY), CellCornerRadius, CellCornerRadius)
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
		  Self.mItems.AddRow(Item)
		  Item.AddObserver(Self, "PulseAmount")
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mItems.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mHoverCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Value
		  
		  Select Case Key
		  Case "PulseAmount"
		    Self.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems(Index).RemoveObserver(Self, "PulseAmount")
		  Self.mItems.RemoveRowAt(Index)
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
		  Value = Max(Min(Self.mItems.LastRowIndex, Value), If(Self.RequiresSelection, 0, -1))
		  If Self.mSelectedIndex <> Value Then
		    Self.mSelectedIndex = Value
		    RaiseEvent Action
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
		  
		  For I As Integer = 0 To Self.mItems.LastRowIndex
		    If Self.mItems(I).Tag = Value.Tag Then
		      Self.SelectedIndex = I
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowHoverToolTip()
		  Var Point As New BeaconUI.Point(Self.MouseX, Self.MouseY)
		  For I As Integer = 0 To Self.mHitRects.LastRowIndex
		    If Self.mHitRects(I) = Nil Then
		      Continue
		    End If
		    If Self.mHitRects(I).Contains(Point) Then
		      App.ShowTooltip(Self.mItems(I).Caption, System.MouseX, System.MouseY + 16)
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Activate()
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
		Private mHitRects() As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverCallbackKey As String
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

	#tag Property, Flags = &h0
		RequiresSelection As Boolean
	#tag EndProperty


	#tag Constant, Name = IconSize, Type = Double, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NotificationDotSize, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TextHeight, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=false
			Group="Behavior"
			InitialValue="False"
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
			InitialValue="72"
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
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
			Name="LockRight"
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
			InitialValue="376"
			Type="Integer"
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
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsVertical"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawCaptions"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
