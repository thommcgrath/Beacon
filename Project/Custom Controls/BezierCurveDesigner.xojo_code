#tag Class
Protected Class BezierCurveDesigner
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim Point As New BeaconUI.Point(X, Y)
		  
		  If Self.mHandle1Rect <> Nil And Self.mHandle1Rect.Contains(Point) Then
		    Self.mHandle1DownPoint = Point
		    Self.mHandle2DownPoint = Nil
		  ElseIf Self.mHandle2Rect <> Nil And Self.mHandle2Rect.Contains(Point) Then
		    Self.mHandle1DownPoint = Nil
		    Self.mHandle2DownPoint = Point
		  Else
		    Self.mHandle1DownPoint = Nil
		    Self.mHandle2DownPoint = Nil
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mHandle1DownPoint = Nil And Self.mHandle2DownPoint = Nil Then
		    Return
		  End If
		  
		  If Self.mHandle1DownPoint <> Nil Then
		    Dim DeltaX As Double = (X - Self.mHandle1DownPoint.X) / Self.Viewport.Width
		    Dim DeltaY As Double = (Y - Self.mHandle1DownPoint.Y) / Self.Viewport.Height
		    If DeltaX = 0 And DeltaY = 0 Then
		      Return
		    End If
		    Self.mHandle1DownPoint = New BeaconUI.Point(X, Y)
		    
		    Dim Point1 As Xojo.Core.Point = Self.Curve.Point(1)
		    Dim Point2 As Xojo.Core.Point = Self.Curve.Point(2)
		    Point1 = New Xojo.Core.Point(Point1.X + DeltaX, Point1.Y - DeltaY)
		    
		    Self.Curve = New Beacon.Curve(Point1, Point2)
		  ElseIf Self.mHandle2DownPoint <> Nil Then
		    Dim DeltaX As Double = (X - Self.mHandle2DownPoint.X) / Self.Viewport.Width
		    Dim DeltaY As Double = (Y - Self.mHandle2DownPoint.Y) / Self.Viewport.Height
		    If DeltaX = 0 And DeltaY = 0 Then
		      Return
		    End If
		    Self.mHandle2DownPoint = New BeaconUI.Point(X, Y)
		    
		    Dim Point1 As Xojo.Core.Point = Self.Curve.Point(1)
		    Dim Point2 As Xojo.Core.Point = Self.Curve.Point(2)
		    Point2 = New Xojo.Core.Point(Point2.X + DeltaX, Point2.Y - DeltaY)
		    
		    Self.Curve = New Beacon.Curve(Point1, Point2)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  #if BeaconUI.CursorsEnabled
		    Dim Point As New BeaconUI.Point(X, Y)
		    If (Self.mHandle1Rect <> Nil And Self.mHandle1Rect.Contains(Point)) Or (Self.mHandle2Rect <> Nil And Self.mHandle2Rect.Contains(Point)) Then
		      Self.MouseCursor = System.Cursors.ArrowAllDirections
		    Else
		      Self.MouseCursor = Nil
		    End If
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  // Nothing to do
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  G.ForeColor = SystemColors.ControlBackgroundColor
		  G.FillRect(1, 1, G.Width - 2, G.Height - 2)
		  
		  G.ForeColor = SystemColors.SeparatorColor
		  G.DrawRect(0, 0, G.Width, G.Height)
		  
		  G.TextFont = "SmallSystem"
		  G.TextSize = 0
		  
		  Dim Viewport As BeaconUI.Rect = Self.Viewport
		  
		  Dim YLegend As New StringShape
		  YLegend.Text = "Level"
		  YLegend.Rotation = -1.5708
		  YLegend.X = Viewport.Left - 6
		  YLegend.Y = Viewport.Top + (Viewport.Height / 2)
		  YLegend.TextFont = G.TextFont
		  YLegend.TextSize = G.TextSize
		  YLegend.FillColor = SystemColors.LabelColor
		  G.DrawObject(YLegend)
		  
		  Dim XLegend As New StringShape
		  XLegend.Text = "Experience"
		  XLegend.X = Viewport.Left + (Viewport.Width / 2)
		  XLegend.Y = Viewport.Bottom + 6 + G.CapHeight
		  XLegend.TextFont = G.TextFont
		  XLegend.TextSize = G.TextSize
		  XLegend.FillColor = SystemColors.LabelColor
		  G.DrawObject(XLegend)
		  
		  G.ForeColor = SystemColors.SecondaryLabelColor
		  G.DrawLine(Viewport.Left - 1, Viewport.Top - 1, Viewport.Left - 1, Viewport.Bottom)
		  G.DrawLine(Viewport.Left, Viewport.Bottom, Viewport.Right, Viewport.Bottom)
		  G.ForeColor = SystemColors.QuaternaryLabelColor
		  G.DrawLine(Viewport.Left, Viewport.Top - 1, Viewport.Right, Viewport.Top - 1)
		  G.DrawLine(Viewport.Right, Viewport.Top, Viewport.Right, Viewport.Bottom - 1)
		  
		  Dim Clip As Graphics = G.Clip(Viewport.Left, Viewport.Top, Viewport.Width, Viewport.Height)
		  If Self.Curve <> Nil Then
		    #if false
		      Clip.ForeColor = SystemColors.TertiaryLabelColor
		      For X As Integer = 0 To Clip.Width
		        Dim Y As Integer = Round(Self.Curve.Evaluate(X / Clip.Width, 0, Clip.Height, 100))
		        Clip.DrawLine(X, Clip.Height, X, Clip.Height - Y)
		      Next
		    #endif
		    
		    Dim Path1 As New CurveShape
		    Path1.X = 0
		    Path1.Y = Clip.Height
		    Path1.X2 = Self.Curve.Point(1).X * Clip.Width
		    Path1.Y2 = Clip.Height - (Self.Curve.Point(1).Y * Clip.Height)
		    Path1.BorderColor = SystemColors.QuaternaryLabelColor
		    Clip.DrawObject(Path1)
		    
		    Dim Path2 As New CurveShape
		    Path2.X = Clip.Width
		    Path2.Y = 0
		    Path2.X2 = Self.Curve.Point(2).X * Clip.Width
		    Path2.Y2 = Clip.Height - (Self.Curve.Point(2).Y * Clip.Height)
		    Path2.BorderColor = Path1.BorderColor
		    Clip.DrawObject(Path2)
		    
		    Dim Shape As New CurveShape
		    Shape.X = 0
		    Shape.X2 = Clip.Width
		    Shape.Y = Clip.Height
		    Shape.Y2 = 0
		    Shape.ControlX(0) = Self.Curve.Point(1).X * Clip.Width
		    Shape.ControlY(0) = Clip.Height - (Self.Curve.Point(1).Y * Clip.Height)
		    Shape.ControlX(1) = Self.Curve.Point(2).X * Clip.Width
		    Shape.ControlY(1) = Clip.Height - (Self.Curve.Point(2).Y * Clip.Height)
		    Shape.Order = 2
		    Shape.BorderColor = SystemColors.SystemBlueColor
		    Clip.DrawObject(Shape)
		    
		    Dim Handle1 As New OvalShape
		    Handle1.X = Path1.X2
		    Handle1.Y = Path1.Y2
		    Handle1.Width = 10
		    Handle1.Height = 10
		    Handle1.FillColor = SystemColors.SelectedContentBackgroundColor
		    Handle1.BorderColor = Path1.BorderColor
		    Handle1.Border = 100
		    G.DrawObject(Handle1, Viewport.Left, Viewport.Top)
		    Self.mHandle1Rect = New BeaconUI.Rect(Handle1.X - Floor(Handle1.Width / 2), Handle1.Y - Floor(Handle1.Height / 2), Handle1.Width, Handle1.Height)
		    Self.mHandle1Rect.Offset(Viewport.Left, Viewport.Top)
		    
		    Dim Handle2 As New OvalShape
		    Handle2.X = Path2.X2
		    Handle2.Y = Path2.Y2
		    Handle2.Width = Handle1.Width
		    Handle2.Height = Handle1.Height
		    Handle2.FillColor = Handle1.FillColor
		    Handle2.BorderColor = Handle1.BorderColor
		    Handle2.Border = Handle1.Border
		    G.DrawObject(Handle2, Viewport.Left, Viewport.Top)
		    
		    Self.mHandle2Rect = New BeaconUI.Rect(Handle2.X - Floor(Handle2.Width / 2), Handle2.Y - Floor(Handle2.Height / 2), Handle2.Width, Handle2.Height)
		    Self.mHandle2Rect.Offset(Viewport.Left, Viewport.Top)
		  Else
		    Self.mHandle1Rect = Nil
		    Self.mHandle2Rect = Nil
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Viewport() As BeaconUI.Rect
		  Const LeftGutter = 21
		  Const TopGutter = 11
		  Const BottomGutter = 21
		  Const RightGutter = 11
		  
		  Return New BeaconUI.Rect(LeftGutter, TopGutter, Self.Width - (LeftGutter + RightGutter), Self.Height - (TopGutter + BottomGutter))
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Changed()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurve
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCurve <> Value Then
			    Self.mCurve = Value
			    RaiseEvent Changed
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Curve As Beacon.Curve
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle1DownPoint As BeaconUI.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle1Rect As BeaconUI.Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle2DownPoint As BeaconUI.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle2Rect As BeaconUI.Rect
	#tag EndProperty


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
			EditorType="Boolean"
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
		#tag ViewProperty
			Name="ScrollSpeed"
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
