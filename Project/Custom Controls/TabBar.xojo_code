#tag Class
Protected Class TabBar
Inherits ControlCanvas
Implements ObservationKit.Observer
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim Point As New REALbasic.Point(X, Y)
		  For I As Integer = 0 To Self.mTabRects.Ubound
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
		  
		  Dim Point As New REALbasic.Point(X, Y)
		  If Self.mCloseBoxes(Self.mMouseDownIndex) <> Nil And Self.mCloseBoxes(Self.mMouseDownIndex).Contains(Point) Then
		    RaiseEvent ShouldDismissView(Self.mMouseDownIndex)
		  End If
		  
		  Self.mMouseDownIndex = -1
		  Self.MouseMove(X, Y)
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim Count As Integer = Self.Count
		  Dim MaxTotalTabWidth As Integer = (Count * Self.MaxTabWidth) + (Count - 1)
		  Dim TabInsideWidth As Integer = Self.MaxTabWidth
		  Dim Remainder As Integer
		  If MaxTotalTabWidth > G.Width Then
		    TabInsideWidth = Floor((G.Width - (Count - 1)) / Count)
		    Remainder = G.Width - ((Count * TabInsideWidth) + (Count - 1))
		  End If
		  
		  Dim IndeterminatePattern As Picture
		  
		  Dim LeftPos As Integer = 0
		  For I As Integer = 0 To Count - 1
		    Dim TabWidth As Integer = TabInsideWidth
		    If I < Remainder Then
		      TabWidth = TabWidth + 1
		    End If
		    
		    Dim Clip As Graphics = G.Clip(LeftPos, 0, TabWidth, G.Height)
		    If Self.mSelectedIndex <> I Then
		      Clip.ForeColor = SystemColors.ControlBackgroundColor
		      Clip.FillRect(0, 0, Clip.Width, Clip.Height - 1)
		      Clip.ForeColor = SystemColors.SeparatorColor
		      Clip.FillRect(0, Clip.Height - 1, Clip.Width, 1)
		    End If
		    
		    Dim View As BeaconSubview = RaiseEvent ViewAtIndex(I)
		    Dim CloseRect As REALbasic.Rect = Self.mCloseBoxes(I)
		    Dim BoxState As CloseBoxState = CloseBoxState.Normal
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
		    Self.mTabRects(I) = New REALbasic.Rect(LeftPos, 0, TabWidth, G.Height)
		    
		    If View <> Nil And View.Progress <> BeaconSubview.ProgressNone Then
		      Dim Progress As Graphics = G.Clip(Self.mTabRects(I).Left, Self.mTabRects(I).Top, Self.mTabRects(I).Width, Self.ProgressHeight)
		      
		      Dim ProgressBackColor As Color = SystemColors.QuaternaryLabelColor
		      Progress.ForeColor = ProgressBackColor
		      Progress.FillRect(0, 0, Progress.Width, Progress.Height)
		      
		      If View.Progress = BeaconSubview.ProgressIndeterminate Then
		        // This is the tricky animated one
		        If IndeterminatePattern = Nil Then
		          IndeterminatePattern = BeaconUI.IconWithColor(IconTabIndeterminatePattern, SystemColors.SelectedContentBackgroundColor)
		        End If
		        
		        If Microseconds - Self.mLastCycleTime > Self.IndeterminateCyclePeriod Then
		          Self.mLastCycleTime = Microseconds
		        End If
		        Dim CycleProgress As Double = (Microseconds - Self.mLastCycleTime) / Self.IndeterminateCyclePeriod
		        Dim CycleOffset As Integer = IndeterminatePattern.Width * CycleProgress
		        
		        For X As Integer = IndeterminatePattern.Width * -1 To Progress.Width Step IndeterminatePattern.Width
		          Progress.DrawPicture(IndeterminatePattern, X + CycleOffset, 0)
		        Next
		        
		        CallLater.Cancel(Self.mUpdateIndeterminateKey)
		        Self.mUpdateIndeterminateKey = CallLater.Schedule(10, WeakAddressOf UpdateIndeterminate)
		      Else
		        Dim FillWidth As Integer = Self.mTabRects(I).Width * View.Progress
		        Progress.ForeColor = SystemColors.SelectedContentBackgroundColor
		        Progress.FillRect(0, 0, FillWidth, Progress.Height)
		      End If
		    End If
		    
		    LeftPos = LeftPos + TabWidth
		    G.ClearRect(LeftPos, 0, 1, G.Height - 1)
		    G.ForeColor = SystemColors.SeparatorColor
		    G.FillRect(LeftPos, 0, 1, G.Height)
		    LeftPos = LeftPos + 1
		  Next
		  
		  G.ForeColor = SystemColors.ControlBackgroundColor
		  G.FillRect(LeftPos, 0, G.Width - LeftPos, G.Height - 1)
		  G.ForeColor = SystemColors.SeparatorColor
		  G.FillRect(LeftPos, G.Height - 1, G.Width - LeftPos, 1)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mUpdateIndeterminateKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTabCell(G As Graphics, View As BeaconSubview, BoxState As CloseBoxState, ByRef CloseRect As REALbasic.Rect)
		  Const CellPadding = 4
		  Const ButtonSize = 16
		  
		  Dim MaxCaptionWidth As Integer = G.Width - ((ButtonSize * 2) + (CellPadding * 4))
		  
		  Dim Caption As String = View.ToolbarCaption
		  Dim CaptionWidth As Double = Min(G.StringWidth(Caption), MaxCaptionWidth)
		  Dim CaptionLeft As Double = (G.Width - CaptionWidth) / 2
		  Dim CaptionBottom As Double = (G.Height / 2) + (G.CapHeight / 2)
		  
		  G.ForeColor = SystemColors.ControlTextColor
		  G.DrawString(Caption, CaptionLeft, CaptionBottom, MaxCaptionWidth, True)
		  
		  Dim ButtonTop As Double = (G.Height - ButtonSize) / 2
		  
		  If View.Changed Then
		    Dim ModifiedIcon As Picture = BeaconUI.IconWithColor(IconModified, G.ForeColor.AtOpacity(0.5))
		    G.DrawPicture(ModifiedIcon, CellPadding, ButtonTop, ButtonSize, ButtonSize, 0, 0, ModifiedIcon.Width, ModifiedIcon.Height)
		  End If
		  
		  If View.CanBeClosed Then
		    Dim IconColor As Color = G.ForeColor.AtOpacity(0.5)
		    If BoxState <> CloseBoxState.Normal Then
		      IconColor = G.ForeColor
		    End If
		    
		    CloseRect = New REALbasic.Rect(G.Width - (ButtonSize + CellPadding), ButtonTop, ButtonSize, ButtonSize)
		    
		    Dim CloseIcon As Picture = BeaconUI.IconWithColor(IconClose, IconColor)
		    G.DrawPicture(CloseIcon, CloseRect.Left, CloseRect.Top, CloseRect.Width, CloseRect.Height, 0, 0, CloseIcon.Width, CloseIcon.Height)
		    
		    If BoxState = CloseBoxState.Pressed Then
		      G.ForeColor = &c00000080
		      G.FillRoundRect(CloseRect.Left, CloseRect.Top, CloseRect.Width, CloseRect.Height, 4, 4)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MouseMove(X As Integer, Y As Integer)
		  Dim HoverRect As REALbasic.Rect
		  Dim Point As New REALbasic.Point(X, Y)
		  For I As Integer = 0 To Self.mCloseBoxes.Ubound
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
			    
			    Dim OldBound As Integer = Self.mTabRects.Ubound
			    Dim NewBound As Integer = Value - 1
			    For I As Integer = OldBound + 1 To NewBound
			      Dim View As BeaconSubview = RaiseEvent ViewAtIndex(I)
			      If View <> Nil Then
			        View.AddObserver(Self, "BeaconSubview.Progress")
			      End If
			    Next
			    
			    Redim Self.mTabRects(Value - 1)
			    Redim Self.mCloseBoxes(Value - 1)
			    Self.SelectedIndex = Self.SelectedIndex
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCloseBoxes(-1) As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverRect As REALbasic.Rect
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
		Private mTabRects(-1) As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateIndeterminateKey As String
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
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
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
			EditorType="Picture"
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
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			EditorType="Boolean"
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
	#tag EndViewBehavior
End Class
#tag EndClass
