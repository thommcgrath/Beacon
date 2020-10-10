#tag Class
Protected Class TabBar
Inherits ControlCanvas
Implements ObservationKit.Observer
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var Point As New Xojo.Point(X, Y)
		  For I As Integer = 0 To Self.mTabRects.LastRowIndex
		    If Self.mTabRects(I) = Nil Then
		      Continue
		    End If
		    
		    If Self.mTabRects(I).Contains(Point) Then
		      If Self.mCloseBoxes(I) <> Nil And Self.mCloseBoxes(I).Contains(Point) Then
		        // Pressed close box
		        Self.mMouseDownIndex = I    
		        Self.Invalidate
		      Else
		        // Pressed the tab
		        RaiseEvent SwitchToView(I)
		      End If
		      Return True
		    End If
		  Next
		  
		  Self.mMouseDownIndex = -1
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mMouseDownIndex = -1 Then
		    Return
		  End If
		  
		  Self.MouseMove(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Self.mMouseDownIndex > -1 Then
		    Return
		  End If
		  
		  If Self.mHoverRect <> Nil Then
		    Self.mHoverRect = Nil
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Self.MouseMove(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mMouseDownIndex = -1 Then
		    Return
		  End If
		  
		  Var Point As New Xojo.Point(X, Y)
		  If Self.mCloseBoxes(Self.mMouseDownIndex) <> Nil And Self.mCloseBoxes(Self.mMouseDownIndex).Contains(Point) Then
		    RaiseEvent ShouldDismissView(Self.mMouseDownIndex)
		  End If
		  
		  Self.mMouseDownIndex = -1
		  Self.MouseMove(X, Y)
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect, Highlighted As Boolean)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  
		  Var Count As Integer = Self.Count
		  Var MaxTotalTabWidth As Integer = (Count * Self.MaxTabWidth) + (Count - 1)
		  Var TabInsideWidth As Integer = Self.MaxTabWidth
		  Var Remainder As Integer
		  If MaxTotalTabWidth > G.Width Then
		    TabInsideWidth = Floor((G.Width - (Count - 1)) / Count)
		    Remainder = G.Width - ((Count * TabInsideWidth) + (Count - 1))
		  End If
		  
		  Var IndeterminatePattern As Picture
		  Var TopOffset As Integer = If(WithTopBorder, 1, 0)
		  
		  Var LeftPos As Integer = 0
		  For I As Integer = 0 To Count - 1
		    Var TabWidth As Integer = TabInsideWidth
		    If I < Remainder Then
		      TabWidth = TabWidth + 1
		    End If
		    
		    Var Clip As Graphics = G.Clip(LeftPos, TopOffset, TabWidth, G.Height - TopOffset)
		    If Self.mSelectedIndex <> I Then
		      G.DrawingColor = SystemColors.ControlBackgroundColor
		      G.FillRectangle(LeftPos, 0, Clip.Width, G.Height - 1)
		      G.DrawingColor = SystemColors.SeparatorColor
		      G.FillRectangle(LeftPos, G.Height - 1, Clip.Width, 1)
		    ElseIf TopOffset > 0 Then
		      G.DrawingColor = SystemColors.SeparatorColor
		      G.FillRectangle(LeftPos, 0, Clip.Width, TopOffset)
		    End If
		    
		    Var View As BeaconSubview = RaiseEvent ViewAtIndex(I)
		    Var CloseRect As Xojo.Rect = Self.mCloseBoxes(I)
		    Var BoxState As CloseBoxState = CloseBoxState.Normal
		    If CloseRect <> Nil Then
		      If Self.mHoverRect = CloseRect Then
		        If Self.mMouseDownIndex = I Then
		          BoxState = CloseBoxState.Pressed
		        Else
		          BoxState = CloseBoxState.Hover
		        End If
		      End If
		    End If
		    
		    If View <> Nil Then
		      Self.DrawTabCell(Clip, View, BoxState, CloseRect)
		    End If
		    
		    If CloseRect <> Nil Then
		      CloseRect.Offset(LeftPos, 0)
		    End If
		    Self.mCloseBoxes(I) = CloseRect
		    Self.mTabRects(I) = New Xojo.Rect(LeftPos, 0, TabWidth, G.Height)
		    
		    If View <> Nil And View.Progress <> BeaconSubview.ProgressNone Then
		      Var Progress As Graphics = G.Clip(Self.mTabRects(I).Left, Self.mTabRects(I).Top, Self.mTabRects(I).Width, Self.ProgressHeight)
		      
		      Var ProgressBackColor As Color = SystemColors.QuaternaryLabelColor
		      Progress.DrawingColor = ProgressBackColor
		      Progress.FillRectangle(0, 0, Progress.Width, Progress.Height)
		      
		      If View.Progress = BeaconSubview.ProgressIndeterminate Then
		        // This is the tricky animated one
		        If IndeterminatePattern = Nil Then
		          IndeterminatePattern = BeaconUI.IconWithColor(IconTabIndeterminatePattern, SystemColors.SelectedContentBackgroundColor)
		        End If
		        
		        If System.Microseconds - Self.mLastCycleTime > Self.IndeterminateCyclePeriod Then
		          Self.mLastCycleTime = System.Microseconds
		        End If
		        Var CycleProgress As Double = (System.Microseconds - Self.mLastCycleTime) / Self.IndeterminateCyclePeriod
		        Var CycleOffset As Integer = IndeterminatePattern.Width * CycleProgress
		        
		        For X As Integer = IndeterminatePattern.Width * -1 To Progress.Width Step IndeterminatePattern.Width
		          Progress.DrawPicture(IndeterminatePattern, X + CycleOffset, 0)
		        Next
		        
		        CallLater.Cancel(Self.mUpdateIndeterminateKey)
		        Self.mUpdateIndeterminateKey = CallLater.Schedule(10, WeakAddressOf UpdateIndeterminate)
		      Else
		        Var FillWidth As Integer = Self.mTabRects(I).Width * View.Progress
		        Progress.DrawingColor = SystemColors.SelectedContentBackgroundColor
		        Progress.FillRectangle(0, 0, FillWidth, Progress.Height)
		      End If
		    End If
		    
		    LeftPos = LeftPos + TabWidth
		    G.ClearRectangle(LeftPos, 0, 1, G.Height - 1)
		    G.DrawingColor = SystemColors.SeparatorColor
		    G.FillRectangle(LeftPos, 0, 1, G.Height)
		    LeftPos = LeftPos + 1
		  Next
		  
		  G.DrawingColor = SystemColors.ControlBackgroundColor
		  G.FillRectangle(LeftPos, 0, G.Width - LeftPos, G.Height - 1)
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.FillRectangle(LeftPos, G.Height - 1, G.Width - LeftPos, 1)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mUpdateIndeterminateKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTabCell(G As Graphics, View As BeaconSubview, BoxState As CloseBoxState, ByRef CloseRect As Xojo.Rect)
		  Const CellPadding = 4
		  Const ButtonSize = 16
		  
		  G.DrawingColor = SystemColors.ControlTextColor
		  
		  Var PrecisionX As Double = 1 / G.ScaleX
		  Var PrecisionY As Double = 1 / G.ScaleY
		  
		  Var MaxCaptionWidth As Integer = G.Width - ((ButtonSize * 2) + (CellPadding * 4))
		  
		  Var Icon As Picture = View.ViewIcon
		  If (Icon Is Nil) = False Then
		    MaxCaptionWidth = MaxCaptionWidth - (CellPadding + ButtonSize)
		  End If
		  
		  Var Caption As String = View.ViewTitle
		  Var CaptionWidth As Double = Min(G.TextWidth(Caption), MaxCaptionWidth).NearestMultiple(PrecisionX)
		  Var CaptionLeft As Double = NearestMultiple((G.Width - CaptionWidth) / 2, PrecisionX)
		  Var CaptionBottom As Double = NearestMultiple((G.Height / 2) + (G.CapHeight / 2), PrecisionY)
		  
		  If (Icon Is Nil) = False Then
		    Var IconColored As Picture = BeaconUI.IconWithColor(Icon, G.DrawingColor)
		    Var IconLeft As Double = CaptionLeft - (ButtonSize + CellPadding)
		    If IconLeft < CellPadding + ButtonSize + CellPadding Then
		      IconLeft = CellPadding + ButtonSize + CellPadding
		      CaptionLeft = IconLeft + ButtonSize + CellPadding
		    End If
		    G.DrawPicture(IconColored, IconLeft, NearestMultiple((G.Height - ButtonSize) / 2, PrecisionY), ButtonSize, ButtonSize, 0, 0, IconColored.Width, IconColored.Height)
		  End If
		  
		  G.DrawText(Caption, CaptionLeft, CaptionBottom, MaxCaptionWidth, True)
		  
		  Var ButtonTop As Double = NearestMultiple((G.Height - ButtonSize) / 2, PrecisionY)
		  
		  If View.Changed Then
		    Var ModifiedIcon As Picture = BeaconUI.IconWithColor(IconModified, G.DrawingColor.AtOpacity(0.5))
		    G.DrawPicture(ModifiedIcon, CellPadding, ButtonTop, ButtonSize, ButtonSize, 0, 0, ModifiedIcon.Width, ModifiedIcon.Height)
		  End If
		  
		  If View.CanBeClosed Then
		    Var IconColor As Color = G.DrawingColor.AtOpacity(0.5)
		    If BoxState <> CloseBoxState.Normal Then
		      IconColor = G.DrawingColor
		    End If
		    
		    CloseRect = New Xojo.Rect(NearestMultiple(G.Width - (ButtonSize + CellPadding), PrecisionX), ButtonTop, ButtonSize, ButtonSize)
		    
		    Var CloseIcon As Picture = BeaconUI.IconWithColor(IconClose, IconColor)
		    G.DrawPicture(CloseIcon, CloseRect.Left, CloseRect.Top, CloseRect.Width, CloseRect.Height, 0, 0, CloseIcon.Width, CloseIcon.Height)
		    
		    If BoxState = CloseBoxState.Pressed Then
		      G.DrawingColor = &c00000080
		      G.FillRoundRectangle(CloseRect.Left, CloseRect.Top, CloseRect.Width, CloseRect.Height, 4, 4)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MouseMove(X As Integer, Y As Integer)
		  Var HoverRect As Xojo.Rect
		  Var Point As New Xojo.Point(X, Y)
		  For I As Integer = 0 To Self.mCloseBoxes.LastRowIndex
		    If Self.mCloseBoxes(I) = Nil Then
		      Continue
		    End If
		    
		    If Self.mCloseBoxes(I).Contains(Point) Then
		      HoverRect = Self.mCloseBoxes(I)
		      Exit For I
		    End If
		  Next
		  
		  If Self.mHoverRect <> HoverRect Then
		    Self.mHoverRect = HoverRect
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  #Pragma Unused Value
		  
		  Select Case Key
		  Case "BeaconSubview.Progress"
		    Self.Invalidate
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateIndeterminate()
		  Self.Invalidate
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ShouldDismissView(ViewIndex As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SwitchToView(ViewIndex As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ViewAtIndex(TabIndex As Integer) As BeaconSubview
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCount
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCount <> Value Then
			    Self.mCount = Value
			    
			    Var OldBound As Integer = Self.mTabRects.LastRowIndex
			    Var NewBound As Integer = Value - 1
			    For I As Integer = OldBound + 1 To NewBound
			      Var View As BeaconSubview = RaiseEvent ViewAtIndex(I)
			      If View <> Nil Then
			        View.AddObserver(Self, "BeaconSubview.Progress")
			      End If
			    Next
			    
			    Self.mTabRects.ResizeTo(Value - 1)
			    Self.mCloseBoxes.ResizeTo(Value - 1)
			    Self.SelectedIndex = Self.SelectedIndex
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCloseBoxes(-1) As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverRect As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCycleTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTabRects(-1) As Xojo.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateIndeterminateKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWithTopBorder As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Min(Max(Value, 0), Self.Count - 1)
			  If Self.mSelectedIndex <> Value Then
			    Self.mSelectedIndex = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		SelectedIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mWithTopBorder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mWithTopBorder <> Value Then
			    Self.mWithTopBorder = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		WithTopBorder As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = IndeterminateCyclePeriod, Type = Double, Dynamic = False, Default = \"1000000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MaxTabWidth, Type = Double, Dynamic = False, Default = \"200", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ProgressHeight, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


	#tag Enum, Name = CloseBoxState, Type = Integer, Flags = &h21
		Normal
		  Hover
		Pressed
	#tag EndEnum


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
			InitialValue="25"
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
			InitialValue="100"
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
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectedIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WithTopBorder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
