#tag Class
Protected Class ViewSwitcher
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Self.mMouseDownPosition = New REALbasic.Point(X, Y)
		  Self.mMouseDownIndex = Self.IndexAtPoint(Self.mMouseDownPosition)
		  Self.mMouseDown = True
		  Self.Invalidate
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Dim OverIndex As Integer = Self.IndexAtPoint(New REALbasic.Point(X, Y))
		  If OverIndex = Self.mMouseDownIndex And Self.mMouseDown = False Then
		    Self.mMouseDown = True
		    Self.Invalidate
		  ElseIf OverIndex <> Self.mMouseDownIndex And Self.mMouseDown = True Then
		    Self.mMouseDown = False
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Dim OverIndex As Integer = Self.IndexAtPoint(New REALbasic.Point(X, Y))
		  If OverIndex > -1 And OverIndex = Self.mMouseDownIndex Then
		    Self.Value = OverIndex
		  End If
		  Self.mMouseDown = False
		  Self.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim TargetRect As New REALbasic.Rect(0, 0, G.Width, G.Height)
		  If (Self.mBorders And Self.BorderTop) = Self.BorderTop Then
		    TargetRect.Offset(0, 1)
		    TargetRect.Height = TargetRect.Height - 1
		  End If
		  If (Self.mBorders And Self.BorderLeft) = Self.BorderLeft Then
		    TargetRect.Offset(1, 0)
		    TargetRect.Width = TargetRect.Width - 1
		  End If
		  If (Self.mBorders And Self.BorderBottom) = Self.BorderBottom Then
		    TargetRect.Height = TargetRect.Height - 1
		  End If
		  If (Self.mBorders And Self.BorderRight) = Self.BorderRight Then
		    TargetRect.Width = TargetRect.Width - 1
		  End If
		  
		  Redim Self.mSegmentRects(Self.mSegments.Ubound)
		  Dim AvailableWidth As Integer = TargetRect.Width - (Self.Count - 1)
		  Dim SegmentWidth As Integer = Floor(AvailableWidth / Self.Count)
		  Dim Remainder As Integer = AvailableWidth - (SegmentWidth * Self.Count)
		  Dim NextPos As Integer = TargetRect.Left
		  For I As Integer = 0 To Self.mSegments.Ubound
		    Dim ThisWidth As Integer = SegmentWidth
		    If I < Remainder Then
		      ThisWidth = ThisWidth + 1
		    End If
		    
		    Self.mSegmentRects(I) = New REALbasic.Rect(NextPos, TargetRect.Top, ThisWidth, TargetRect.Height)
		    NextPos = NextPos + ThisWidth + 1
		  Next
		  
		  G.ForeColor = Self.ColorProfile.BorderColor
		  G.FillRect(0, 0, G.Width, G.Height)
		  
		  For I As Integer = 0 To Self.mSegmentRects.Ubound
		    Dim Rect As REALbasic.Rect = Self.mSegmentRects(I)
		    Dim Clip As Graphics = G.Clip(Rect.Left, Rect.Top, Rect.Width, Rect.Height)
		    Self.DrawSegment(Clip, I)
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(ParamArray Segments() As String)
		  For Each Segment As String In Segments
		    Self.mSegments.Append(Segment.Trim)
		  Next
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSegments.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSegment(G As Graphics, Index As Integer)
		  Const Padding = 5
		  
		  Dim Pressed As Boolean = Self.mMouseDown And Self.mMouseDownIndex = Index
		  Dim Selected As Boolean = Self.mSelectedIndex = Index
		  
		  Dim TextColor, ShadowColor, BackgroundColor As Color
		  If Selected Then
		    TextColor = Self.ColorProfile.SelectedForegroundColor
		    BackgroundColor = Self.ColorProfile.SelectedBackgroundColor
		    ShadowColor = Self.ColorProfile.SelectedShadowColor
		  Else
		    TextColor = Self.ColorProfile.ForegroundColor
		    BackgroundColor = Self.ColorProfile.BackgroundColor
		    ShadowColor = Self.ColorProfile.ShadowColor
		  End If
		  
		  If Pressed Then
		    TextColor = HSV(TextColor.Hue, TextColor.Saturation, TextColor.Value / 2, TextColor.Alpha)
		    ShadowColor = HSV(ShadowColor.Hue, ShadowColor.Saturation, ShadowColor.Value / 2, ShadowColor.Alpha)
		    BackgroundColor = HSV(BackgroundColor.Hue, BackgroundColor.Saturation, BackgroundColor.Value / 2, BackgroundColor.Alpha)
		  End If
		  
		  Dim PaddedWidth As Integer = G.Width - (Padding * 2)
		  Dim Caption As String = Self.mSegments(Index)
		  Dim CaptionWidth As Integer = Min(Ceil(G.StringWidth(Caption)), PaddedWidth)
		  Dim CaptionLeft As Integer = Padding + ((PaddedWidth - CaptionWidth) / 2)
		  Dim CaptionBottom As Integer = (G.Height / 2) + (G.CapHeight / 2)
		  
		  G.ForeColor = BackgroundColor
		  G.FillRect(0, 0, G.Width, G.Height)
		  
		  G.ForeColor = ShadowColor
		  G.DrawString(Caption, CaptionLeft, CaptionBottom + 1, PaddedWidth, True)
		  G.ForeColor = TextColor
		  G.DrawString(Caption, CaptionLeft, CaptionBottom, PaddedWidth, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexAtPoint(Point As REALbasic.Point) As Integer
		  For I As Integer = 0 To Self.mSegmentRects.Ubound
		    If Self.mSegmentRects(I) <> Nil And Self.mSegmentRects(I).Contains(Point) Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Segment As String) As Integer
		  Return Self.mSegments.IndexOf(Segment)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Segment As String)
		  Self.mSegments.Insert(Index, Segment.Trim)
		  If Index <= Self.mSelectedIndex Then
		    Self.mSelectedIndex = Self.mSelectedIndex + 1
		  End If
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mSegments.Remove(Index)
		  If Index < Self.mSelectedIndex Then
		    Self.mSelectedIndex = Self.mSelectedIndex - 1
		  ElseIf Index = Self.mSelectedIndex Then
		    Self.mSelectedIndex = -1
		  End If
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Segment As String)
		  Dim Index As Integer = Self.IndexOf(Segment)
		  If Index > -1 Then
		    Self.Remove(Index)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Segment(Index As Integer) As String
		  Return Self.mSegments(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Segment(Index As Integer, Assigns Value As String)
		  Value = Value.Trim
		  If StrComp(Self.mSegments(Index), Value, 0) <> 0 Then
		    Self.mSegments(Index) = Value
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Self.mSegments.Ubound
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action(NewIndex As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBorders
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Mask As Integer = BorderBottom Or BorderLeft Or BorderRight Or BorderTop
			  Value = Value And Mask
			  If Self.mBorders <> Value Then
			    Self.mBorders = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Borders As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBorders As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownPosition As REALbasic.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSegmentRects() As REALbasic.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSegments() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedIndex As Integer = -1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Min(Value, Self.mSegments.Ubound), -1)
			  If Self.mSelectedIndex <> Value Then
			    Self.mSelectedIndex = Value
			    RaiseEvent Action(Value)
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Value As Integer
	#tag EndComputedProperty


	#tag Constant, Name = BorderBottom, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderLeft, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderRight, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BorderTop, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ScrollSpeed"
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
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
			Name="Borders"
			Visible=true
			Group="Behavior"
			Type="Integer"
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
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="20"
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
			Name="Value"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
