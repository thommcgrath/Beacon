#tag Class
Protected Class BezierCurveDesigner
Inherits ControlCanvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Var Point As New Point(X, Y)
		  
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
		    Var DeltaX As Double = (X - Self.mHandle1DownPoint.X) / Self.Viewport.Width
		    Var DeltaY As Double = (Y - Self.mHandle1DownPoint.Y) / Self.Viewport.Height
		    If DeltaX = 0 And DeltaY = 0 Then
		      Return
		    End If
		    Self.mHandle1DownPoint = New Point(X, Y)
		    
		    Var Point1 As Point = Self.Curve.Point(1)
		    Var Point2 As Point = Self.Curve.Point(2)
		    Point1 = New Point(Point1.X + DeltaX, Point1.Y - DeltaY)
		    
		    Self.Curve = New Beacon.Curve(Point1, Point2)
		  ElseIf Self.mHandle2DownPoint <> Nil Then
		    Var DeltaX As Double = (X - Self.mHandle2DownPoint.X) / Self.Viewport.Width
		    Var DeltaY As Double = (Y - Self.mHandle2DownPoint.Y) / Self.Viewport.Height
		    If DeltaX = 0 And DeltaY = 0 Then
		      Return
		    End If
		    Self.mHandle2DownPoint = New Point(X, Y)
		    
		    Var Point1 As Point = Self.Curve.Point(1)
		    Var Point2 As Point = Self.Curve.Point(2)
		    Point2 = New Point(Point2.X + DeltaX, Point2.Y - DeltaY)
		    
		    Self.Curve = New Beacon.Curve(Point1, Point2)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Var Point As New Point(X, Y)
		  If (Self.mHandle1Rect <> Nil And Self.mHandle1Rect.Contains(Point)) Or (Self.mHandle2Rect <> Nil And Self.mHandle2Rect.Contains(Point)) Then
		    #if BeaconUI.CursorsEnabled
		      Self.MouseCursor = System.Cursors.ArrowAllDirections
		    #endif
		    #if Self.ShowCrosshair
		      Self.mHoverPoint = Nil
		    #endif
		  Else
		    #if BeaconUI.CursorsEnabled
		      Self.MouseCursor = Nil
		    #endif
		    #if Self.ShowCrosshair
		      Self.mHoverPoint = Point
		    #endif
		  End If
		  #if Self.ShowCrosshair
		    Self.Refresh
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  // Nothing to do
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused Highlighted
		  #Pragma Unused SafeArea
		  
		  G.DrawingColor = SystemColors.ControlBackgroundColor
		  G.FillRectangle(1, 1, G.Width - 2, G.Height - 2)
		  
		  G.DrawingColor = SystemColors.SeparatorColor
		  G.DrawRectangle(0, 0, G.Width, G.Height)
		  
		  G.FontName = "SmallSystem"
		  G.FontSize = 0
		  
		  Var Viewport As Rect = Self.Viewport
		  
		  Var YLegend As New TextShape
		  YLegend.Value = "Experience"
		  YLegend.Rotation = -1.5708
		  YLegend.X = Viewport.Left - 6
		  YLegend.Y = Viewport.Top + (Viewport.Height / 2)
		  YLegend.FontName = G.FontName
		  YLegend.FontSize = G.FontSize
		  YLegend.FillColor = SystemColors.LabelColor
		  G.DrawObject(YLegend)
		  
		  Var XLegend As New TextShape
		  XLegend.Value = "Level"
		  XLegend.X = Viewport.Left + (Viewport.Width / 2)
		  XLegend.Y = Viewport.Bottom + 6 + G.CapHeight
		  XLegend.FontName = G.FontName
		  XLegend.FontSize = G.FontSize
		  XLegend.FillColor = SystemColors.LabelColor
		  G.DrawObject(XLegend)
		  
		  G.DrawingColor = SystemColors.SecondaryLabelColor
		  G.DrawLine(Viewport.Left - 1, Viewport.Top - 1, Viewport.Left - 1, Viewport.Bottom)
		  G.DrawLine(Viewport.Left, Viewport.Bottom, Viewport.Right, Viewport.Bottom)
		  G.DrawingColor = SystemColors.QuaternaryLabelColor
		  G.DrawLine(Viewport.Left, Viewport.Top - 1, Viewport.Right, Viewport.Top - 1)
		  G.DrawLine(Viewport.Right, Viewport.Top, Viewport.Right, Viewport.Bottom - 1)
		  
		  Var Clip As Graphics = G.Clip(Viewport.Left, Viewport.Top, Viewport.Width, Viewport.Height)
		  If Self.Curve <> Nil Then
		    #if Self.ShowCrosshair
		      If Self.mHoverPoint <> Nil And Viewport.Contains(Self.mHoverPoint) Then
		        Var Localized As Point = Viewport.Localize(Self.mHoverPoint)
		        
		        #if false
		          Var Time As Double = Localized.X / Viewport.Width
		          Var Intersect As Point = Self.Curve.Evaluate(Time, Viewport.Localize(Viewport))
		        #endif
		        Var X As Integer = Localized.X
		        Var Y As Integer = Self.Curve.Evaluate(X / Viewport.Width, 0, Viewport.Width)
		        
		        Var YLine As New CurveShape
		        YLine.X = 0
		        YLine.Y = Clip.Height - Y
		        YLine.X2 = Viewport.Right
		        YLine.Y2 = Clip.Height - Y
		        YLine.BorderColor = SystemColors.TertiaryLabelColor
		        Clip.DrawObject(YLine)
		        
		        Var XLine As New CurveShape
		        XLine.X = X
		        XLine.Y = 0
		        XLine.X2 = X
		        XLine.Y2 = Viewport.Bottom
		        XLine.BorderColor = YLine.BorderColor
		        Clip.DrawObject(XLine)
		      End If
		    #endif
		    
		    
		    Var Path1 As New CurveShape
		    Path1.X = 0
		    Path1.Y = Clip.Height
		    Path1.X2 = Self.Curve.Point(1).X * Clip.Width
		    Path1.Y2 = Clip.Height - (Self.Curve.Point(1).Y * Clip.Height)
		    Path1.BorderColor = SystemColors.QuaternaryLabelColor
		    Clip.DrawObject(Path1)
		    
		    Var Path2 As New CurveShape
		    Path2.X = Clip.Width
		    Path2.Y = 0
		    Path2.X2 = Self.Curve.Point(2).X * Clip.Width
		    Path2.Y2 = Clip.Height - (Self.Curve.Point(2).Y * Clip.Height)
		    Path2.BorderColor = Path1.BorderColor
		    Clip.DrawObject(Path2)
		    
		    Var Shape As New CurveShape
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
		    
		    Var Handle1 As New OvalShape
		    Handle1.X = Path1.X2
		    Handle1.Y = Path1.Y2
		    Handle1.Width = 10
		    Handle1.Height = 10
		    Handle1.FillColor = SystemColors.SelectedContentBackgroundColor
		    Handle1.BorderColor = Path1.BorderColor
		    Handle1.BorderOpacity = 100
		    G.DrawObject(Handle1, Viewport.Left, Viewport.Top)
		    Self.mHandle1Rect = New Rect((Handle1.X - Floor(Handle1.Width / 2)) + Viewport.Left, (Handle1.Y - Floor(Handle1.Height / 2)) + Viewport.Top, Handle1.Width, Handle1.Height)
		    
		    Var Handle2 As New OvalShape
		    Handle2.X = Path2.X2
		    Handle2.Y = Path2.Y2
		    Handle2.Width = Handle1.Width
		    Handle2.Height = Handle1.Height
		    Handle2.FillColor = Handle1.FillColor
		    Handle2.BorderColor = Handle1.BorderColor
		    Handle2.BorderOpacity = Handle1.BorderOpacity
		    G.DrawObject(Handle2, Viewport.Left, Viewport.Top)
		    
		    Self.mHandle2Rect = New Rect((Handle2.X - Floor(Handle2.Width / 2)) + Viewport.Left, (Handle2.Y - Floor(Handle2.Height / 2)) + Viewport.Top, Handle2.Width, Handle2.Height)
		  Else
		    Self.mHandle1Rect = Nil
		    Self.mHandle2Rect = Nil
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function Viewport() As Rect
		  Const LeftGutter = 21
		  Const TopGutter = 11
		  Const BottomGutter = 21
		  Const RightGutter = 11
		  
		  Return New Rect(LeftGutter, TopGutter, Self.Width - (LeftGutter + RightGutter), Self.Height - (TopGutter + BottomGutter))
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
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		Curve As Beacon.Curve
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle1DownPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle1Rect As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle2DownPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandle2Rect As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverPoint As Point
	#tag EndProperty


	#tag Constant, Name = ShowCrosshair, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="Transparent"
			Visible=true
			Group="Behavior"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
