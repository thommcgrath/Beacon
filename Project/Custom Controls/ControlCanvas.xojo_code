#tag Class
Protected Class ControlCanvas
Inherits Canvas
Implements AnimationKit.Scrollable,AnimationKit.ValueAnimator
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not Self.mPainted Then
		    Return False
		  End If
		  
		  Self.AdjustMouseCoordinates(X, Y)
		  
		  If Self.ScrollingEnabled And X >= Self.Width - Self.ScrollTrackWidth Then
		    Var ThumbRect As Rect = Self.ScrollThumbRect
		    If (ThumbRect Is Nil) = False And ThumbRect.Contains(X, Y) Then
		      Self.mMouseDownThumbPoint = New Point(X, Y)
		    Else
		      Self.mMouseDownThumbPoint = Nil
		    End If
		    
		    Self.mMouseDownInTrack = True
		    Return True
		  End If
		  
		  Self.mMouseDownInTrack = False
		  
		  Return MouseDown(X, Y)
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Self.AdjustMouseCoordinates(X, Y)
		  
		  If Self.mMouseDownInTrack = False Then
		    RaiseEvent MouseDrag(X, Y)
		    Return
		  End If
		  
		  If Self.mMouseDownThumbPoint Is Nil Then
		    // Jump to a point in the scroll track
		    Var TrackRect As Rect = Self.ScrollTrackRect
		    Var ScrollPercent As Double = (Y - TrackRect.Top) / (TrackRect.Height - TrackRect.Top)
		    Self.ScrollPosition = Round(Self.ScrollMaximum * ScrollPercent)
		    Return
		  End If
		  
		  Var Delta As Integer = Y - Self.mMouseDownThumbPoint.Y
		  If Delta <> 0 Then
		    Var ThumbRect As Rect = Self.ScrollThumbRect
		    Var ThumbMousePoint As Point = ThumbRect.LocalPoint(Self.mMouseDownThumbPoint)
		    Var TrackRect As Rect = Self.ScrollTrackRect
		    Var Limit As Integer = TrackRect.Height - ThumbRect.Height
		    Var ScrollPercent As Double = (ThumbRect.Top + Delta) / Limit
		    Self.ScrollPosition = Round(Self.ScrollMaximum * ScrollPercent)
		    
		    ThumbRect = Self.ScrollThumbRect
		    Self.mMouseDownThumbPoint = New Point(ThumbRect.Left + ThumbMousePoint.X, ThumbRect.Top + ThumbMousePoint.Y)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  If Self.mPainted = False Or Self.mMouseDownInTrack Then
		    Return
		  End If
		  
		  RaiseEvent MouseEnter()
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Self.mPainted = False Or Self.mMouseDownInTrack Then
		    Return
		  End If
		  
		  Self.ScrollActive = False
		  
		  RaiseEvent MouseExit
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If Self.mPainted = False Or Self.mMouseDownInTrack Then
		    Return
		  End If
		  
		  Self.AdjustMouseCoordinates(X, Y)
		  
		  Var TrackRect As Rect = Self.ScrollTrackRect
		  Self.ScrollActive = TrackRect.Contains(X, Y)
		  
		  RaiseEvent MouseMove(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Self.AdjustMouseCoordinates(X, Y)
		  
		  If Self.mMouseDownInTrack = False Then
		    Var DeltaX As Integer = System.MouseX - X
		    Var DeltaY As Integer = System.MouseY - Y
		    RaiseEvent MouseUp(X, Y)
		    Var NewX As Integer = System.MouseX - DeltaX
		    Var NewY As Integer = System.MouseY - DeltaY
		    If NewX <> X Or NewY <> Y Then
		      If NewX >= 0 And NewY >= 0 And NewX <= Self.Width And NewY <= Self.Height Then
		        RaiseEvent MouseMove(NewX, NewY)
		      Else
		        RaiseEvent MouseExit()
		      End If
		    End If
		    Return
		  End If
		  
		  Self.mMouseDownInTrack = False
		  Self.mMouseDownThumbPoint = Nil
		  
		  Var TrackRect As Rect = Self.ScrollTrackRect
		  Self.ScrollActive = TrackRect.Contains(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  If Not Self.mPainted Then
		    Return False
		  End If
		  
		  Self.AdjustMouseCoordinates(X, Y)
		  Var WheelData As New BeaconUI.ScrollEvent(Self.ScrollSpeed, DeltaX, DeltaY)
		  
		  If IsEventImplemented("MouseWheel") Then
		    Return RaiseEvent MouseWheel(X, Y, WheelData.ScrollX, WheelData.ScrollY, WheelData)
		  ElseIf Self.ScrollingEnabled Then
		    Self.ScrollPosition = Self.mScrollOffset + WheelData.ScrollY
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  #if XojoVersion >= 2022.01
		    Self.AllowFocusRing = False
		  #endif
		  
		  RaiseEvent Open
		  
		  #if XojoVersion >= 2018.01
		    Self.Transparent = True
		  #else
		    Self.DoubleBuffer = TargetWin32
		    Self.Transparent = Not Self.DoubleBuffer
		    Self.EraseBackground = Not Self.DoubleBuffer
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  Var WithScroller As Boolean = Self.ScrollingEnabled And Self.ScrollMaximum > 0
		  Var NeedsRedraw As Boolean = True
		  While NeedsRedraw
		    Var SafeArea As Rect
		    If WithScroller Then
		      SafeArea = New Rect(0, 0, G.Width - Self.ScrollTrackWidth, G.Height)
		    Else
		      SafeArea = New Rect(0, 0, G.Width, G.Height)
		    End If
		    
		    If Self.Transparent Then
		      G.ClearRectangle(0, 0, G.Width, G.Height)
		    Else
		      Var TempColor As Color = G.DrawingColor
		      If Self.Window.HasBackgroundColor Then
		        G.DrawingColor = Self.Window.BackgroundColor
		      Else
		        G.DrawingColor = SystemColors.WindowBackgroundColor
		      End If
		      G.FillRectangle(0, 0, G.Width, G.Height)
		      G.DrawingColor = TempColor
		    End If
		    
		    RaiseEvent Paint(g, areas, Self.Highlighted, SafeArea)
		    
		    // If the paint changed the content height, we need to redraw
		    Var NewWithScroller As Boolean = Self.ScrollingEnabled And Self.ScrollMaximum > 0
		    NeedsRedraw = WithScroller <> NewWithScroller
		    WithScroller = NewWithScroller
		  Wend
		  
		  If WithScroller Then
		    Var ThumbRect As Rect = Self.ScrollThumbRect()
		    G.DrawingColor = SystemColors.SecondaryLabelColor.AtOpacity(Self.mScrollOpacity)
		    G.FillRoundRectangle(NearestMultiple(ThumbRect.Left + Self.ScrollThumbPadding, G.ScaleX), NearestMultiple(ThumbRect.Top + Self.ScrollThumbPadding, G.ScaleY), NearestMultiple(ThumbRect.Width - (Self.ScrollThumbPadding * 2), G.ScaleX), NearestMultiple(ThumbRect.Height - (Self.ScrollThumbPadding * 2), G.ScaleY), Self.ScrollThumbWidth, Self.ScrollThumbWidth)
		  End If
		  
		  Self.mPainted = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AdjustMouseCoordinates(ByRef X As Integer, ByRef Y As Integer)
		  #if TargetMacOS
		    Var Location As NSPointMBS = NSApplicationMBS.SharedApplication.CurrentEvent.LocationInWindow
		    Var View As NSViewMBS = Self.NSViewMBS
		    Var Localized As NSPointMBS = View.ConvertPointFromView(Location, Nil)
		    
		    X = Floor(Localized.X)
		    Y = Floor(View.Bounds.Height - Localized.Y)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As String, Value As Double)
		  // Part of the AnimationKit.ValueAnimator interface.
		  
		  Select Case Identifier
		  Case "Scroll Opacity"
		    Self.mScrollOpacity = Value
		    Self.Invalidate(Self.Width - ((Self.ScrollThumbPadding * 2) + Self.ScrollThumbWidth), 0, ((Self.ScrollThumbPadding * 2) + Self.ScrollThumbWidth), Self.Height)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Highlighted() As Boolean
		  Var Highlighted As Boolean = True
		  #if TargetCocoa And BeaconUI.ToolbarHasBackground = False
		    Var Win As NSWindowMBS = Self.NSViewMBS.Window
		    Highlighted = Win.isKeyWindow Or Win.isMainWindow
		  #endif
		  Return Highlighted
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.Invalidate(EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.Invalidate(Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(x As Integer, y As Integer, width As Integer, height As Integer, eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.Invalidate(X, Y, Width, Height, EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.Invalidate(X, Y, Width, Height, Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LimitScrollOffset(Offset As Double, ContentHeight As Integer, ViewportHeight As Integer) As Double
		  Return Min(Max(Offset, 0), Max(ContentHeight - ViewportHeight, 0))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh(eraseBackground As Boolean = True)
		  #if XojoVersion >= 2018.01
		    Super.Refresh(EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.Refresh(Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh(x As Integer, y As Integer, width As Integer, height As Integer, eraseBackground As Boolean = True)
		  // Calling the overridden superclass method.
		  #if XojoVersion >= 2020.01
		    Super.Refresh(X, Y, Width, Height, EraseBackground)
		  #elseif XojoVersion >= 2018.01
		    Super.RefreshRect(X, Y, Width, Height, EraseBackground)
		  #else
		    #Pragma Unused eraseBackground
		    Super.RefreshRect(X, Y, Width, Height, Self.EraseBackground)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMaximum() As Double
		  // Part of the AnimationKit.Scrollable interface.
		  
		  Return Max(Self.mContentHeight - Self.Height, 0)
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
		  
		  Return 0
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
		  
		  Return Self.LimitScrollOffset(Self.mScrollOffset, Self.mContentHeight, Self.Height)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollPosition(Assigns Value As Double)
		  // Part of the AnimationKit.Scrollable interface.
		  
		  Value = Self.LimitScrollOffset(Value, Self.mContentHeight, Self.Height)
		  If Self.mScrollOffset <> Value Then
		    Self.mScrollOffset = Value
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScrollThumbRect() As Rect
		  If Self.ScrollingEnabled = False Or Self.ScrollMaximum = 0 Then
		    Return Nil
		  End If
		  
		  Var ScrollPercent As Double
		  If Self.ScrollMaximum > 0 Then
		    ScrollPercent = Min(Max(Self.ScrollPosition / Self.ScrollMaximum, 0.0), 1.0)
		  End If
		  
		  Var TrackRect As Rect = Self.ScrollTrackRect()
		  Var Ratio As Double = Min(TrackRect.Height / Self.mContentHeight, 1.0)
		  Var ScrollThumbHeight As Double = TrackRect.Height * Ratio
		  Var ScrollThumbTop As Double = TrackRect.Top + ((TrackRect.Height - ScrollThumbHeight) * ScrollPercent)
		  
		  Return New Rect(TrackRect.Left, ScrollThumbTop, TrackRect.Width, ScrollThumbHeight)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScrollTrackRect() As Rect
		  Var TrackWidth As Double = Self.ScrollTrackWidth
		  Return New Rect(Self.Width - TrackWidth, 0, TrackWidth, Self.Height)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScrollTrackWidth() As Double
		  Return Self.ScrollThumbWidth + (Self.ScrollThumbPadding * 2)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDrag(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseEnter()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseExit()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseMove(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseUp(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseWheel(MouseX As Integer, MouseY As Integer, PixelsX As Double, PixelsY As Double, WheelData As BeaconUI.ScrollEvent) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Paint(G As Graphics, Areas() As REALbasic.Rect, Highlighted As Boolean, SafeArea As Rect)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mScrollingEnabled Then
			    Return Max(Self.mContentHeight, Self.Height)
			  Else
			    Return Self.Height
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mContentHeight = Value Then
			    Return
			  End If
			  
			  Self.mContentHeight = Value
			  Self.Invalidate()
			End Set
		#tag EndSetter
		ContentHeight As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mContentHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownInTrack As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownThumbPoint As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPainted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollFadeAnimation As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollingEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollOffset As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollOpacity As Double = 0.25
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollOpacityKey As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mScrollActive
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mScrollActive = Value Then
			    Return
			  End If
			  
			  Self.mScrollActive = Value
			  
			  If (Self.mScrollFadeAnimation Is Nil) = False Then
			    Self.mScrollFadeAnimation.Cancel
			    Self.mScrollFadeAnimation = Nil
			  End If
			  
			  Var Amount As Double = If(Value, 1.0, 0.25)
			  
			  If Self.mScrollOpacity = Amount Then
			    Return
			  End If
			  
			  Self.mScrollFadeAnimation = New AnimationKit.ValueTask(Self, "Scroll Opacity", Self.mScrollOpacity, Amount)
			  If Value Then
			    Self.mScrollFadeAnimation.DurationInSeconds = 0.15
			  Else
			    If Self.mScrollOpacity = 1.0 Then
			      Self.mScrollFadeAnimation.DelayInSeconds = 1.0
			    End If
			    Self.mScrollFadeAnimation.DurationInSeconds = 0.5
			  End If
			  Self.mScrollFadeAnimation.Curve = AnimationKit.Curve.CreateEaseOut
			  Self.mScrollFadeAnimation.Run
			End Set
		#tag EndSetter
		ScrollActive As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mScrollingEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mScrollingEnabled <> Value Then
			    Self.mScrollingEnabled = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		ScrollingEnabled As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ScrollSpeed As Integer = 20
	#tag EndProperty


	#tag Constant, Name = ScrollThumbPadding, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ScrollThumbWidth, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
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
			InitialValue="100"
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
		#tag ViewProperty
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
