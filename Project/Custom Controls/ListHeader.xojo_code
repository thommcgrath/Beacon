#tag Class
Protected Class ListHeader
Inherits ControlCanvas
	#tag Event
		Sub Activate()
		  RaiseEvent Activate()
		  
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
		  If MouseDown(X, Y) Then
		    Self.mSubclassHandlesMouse = True
		    Return True
		  End If
		  
		  Dim Point As New Xojo.Core.Point(X, Y)
		  
		  Self.mSubclassHandlesMouse = False
		  Self.mMouseDown = False
		  
		  Self.mActiveClickRegion = ""
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mClickRects
		    Dim Key As Text = Entry.Key
		    Dim Rect As Xojo.Core.Rect = Entry.Value
		    If Rect.Contains(Point) Then
		      Self.mActiveClickRegion = Key
		      Self.mMouseDown = True
		      Self.mMouseDownInRect = True
		    End If
		  Next
		  
		  If Self.mMouseDown Then
		    Self.Invalidate
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Self.mSubclassHandlesMouse Then
		    RaiseEvent MouseDrag(X, Y)
		    Return
		  End If
		  
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Dim Point As New Xojo.Core.Point(X, Y)
		  Dim Region As Xojo.Core.Rect = Self.mClickRects.Value(Self.mActiveClickRegion)
		  If Region.Contains(Point) Then
		    If Not Self.mMouseDownInRect Then
		      Self.mMouseDownInRect = True
		      Self.Invalidate
		    End If
		  Else
		    If Self.mMouseDownInRect Then
		      Self.mMouseDownInRect = False
		      Self.Invalidate
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If Self.mSubclassHandlesMouse Then
		    RaiseEvent MouseUp(X, Y)
		    Return
		  End If
		  
		  If Not Self.mMouseDown Then
		    Return
		  End If
		  
		  Self.mMouseDown = False
		  
		  Dim Point As New Xojo.Core.Point(X, Y)
		  Dim Region As Xojo.Core.Rect = Self.mClickRects.Value(Self.mActiveClickRegion)
		  If Region.Contains(Point) Then
		    Self.RegionClicked(Self.mActiveClickRegion)
		  End If
		  
		  If Self.mMouseDownInRect Then
		    Self.mMouseDownInRect = True
		    Self.Invalidate
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused Areas
		  
		  Dim Scheme As ColorScheme = If(Self.Highlighted, Self.mActiveColors, Self.mInactiveColors)
		  
		  G.ForeColor = Scheme.BackgroundColor
		  G.FillRect(0, 0, G.Width, G.Height)
		  
		  Dim HasSegments As Boolean = UBound(Self.mSegments) > -1
		  
		  Dim IdealHeight As Integer = (Self.Padding * 2) + Self.TitleHeight + 1
		  If HasSegments Then
		    IdealHeight = IdealHeight + Self.SegmentCellHeight + Self.Padding
		  End If
		  If Self.Height <> IdealHeight Then
		    Dim OriginalHeight As Integer = Self.Height
		    RaiseEvent Resize(IdealHeight)
		    If Self.Height <> OriginalHeight Then
		      Xojo.Core.Timer.CallLater(1, AddressOf Self.CallbackInvalidate)
		    End If
		  End If
		  
		  If HasSegments Then
		    Self.DrawSegments(G, New Xojo.Core.Rect(Self.Padding, (Self.Padding * 2) + Self.TitleHeight, G.Width - (Self.Padding * 2), Self.SegmentCellHeight), Scheme)
		  End If
		  Dim TitleWidth As Integer = Min(G.StringWidth(Self.Title), G.Width - (Self.Padding * 2))
		  Dim TitleLeft As Integer = (G.Width - TitleWidth) / 2
		  Dim TitleBottom As Integer = Self.Padding + Self.TitleHeight
		  G.Bold = True
		  G.ForeColor = Scheme.TitleShadowColor
		  G.DrawString(Self.Title, TitleLeft, TitleBottom + 1, G.Width - (Self.Padding * 2), True)
		  G.ForeColor = Scheme.TitleTextColor
		  G.DrawString(Self.Title, TitleLeft, TitleBottom, G.Width - (Self.Padding * 2), True)
		  
		  G.ForeColor = Scheme.BorderColor
		  G.DrawLine(0, G.Height - 1, G.Width, G.Height - 1)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddSegment(Caption As Text)
		  If Self.mSegments.IndexOf(Caption) = -1 Then
		    Self.mSegments.Append(Caption)
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AdjustColor(SourceColor As Color, BrightnessAdjust As Double) As Color
		  If BrightnessAdjust = 0 Then
		    Return SourceColor
		  End If
		  
		  Dim Adjust As Integer = 255 * BrightnessAdjust
		  Return RGB(SourceColor.Red + Adjust, SourceColor.Green + Adjust, SourceColor.Blue + Adjust, SourceColor.Alpha)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildColorScheme(SourceColor As Color) As ColorScheme
		  Const BrightnessLimit = 170
		  
		  Dim Brightness As Integer = Exp(Log((SourceColor.Red * SourceColor.Red * 0.241) + (SourceColor.Green * SourceColor.Green * 0.691) + (SourceColor.Blue * SourceColor.Blue * 0.068)) * 0.5)
		  Dim IsDark As Boolean = Brightness < BrightnessLimit
		  
		  Dim Scheme As ColorScheme
		  Scheme.BackgroundColor = SourceColor
		  Scheme.TitleTextColor = if(IsDark, &cFFFFFF, Self.AdjustColor(SourceColor, -0.60))
		  Scheme.TitleShadowColor = if(IsDark, Self.AdjustColor(SourceColor, -0.75), &cFFFFFF)
		  Scheme.SegmentFrameColor = if(IsDark, &cFFFFFF, Self.AdjustColor(SourceColor, -0.50))
		  Scheme.SegmentShadowColor = if(IsDark, Self.AdjustColor(SourceColor, -0.75), &cFFFFFF)
		  Scheme.SegmentTextColor = if(IsDark, &cFFFFFF, Self.AdjustColor(SourceColor, -0.70))
		  Scheme.SegmentPressedColor = if(IsDark, Self.AdjustColor(SourceColor, 0.75), Self.AdjustColor(SourceColor, -0.75))
		  Scheme.SegmentSelectedTextColor = if(IsDark, &c000000, &cFFFFFF)
		  Scheme.BorderColor = if(IsDark, Self.AdjustColor(SourceColor, -0.1), Self.AdjustColor(SourceColor, -0.2))
		  Return Scheme
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CallbackInvalidate()
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  Self.mClickRects = New Xojo.Core.Dictionary
		  
		  Self.TintColor = Self.DefaultColor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSegments(G As Graphics, Rect As Xojo.Core.Rect, Scheme As ColorScheme)
		  Dim SegmentCount As Integer = UBound(Self.mSegments) + 1
		  Dim BorderCount As Integer = SegmentCount + 1
		  Dim CellWidth As Integer = Min(Self.SegmentCellWidth, Floor((Rect.Width - (Self.SegmentBorderSize * BorderCount)) / SegmentCount))
		  Dim ControlWidth As Integer = (CellWidth * SegmentCount) + (Self.SegmentBorderSize * BorderCount)
		  Dim ControlLeft As Integer = Rect.Left + ((Rect.Width - ControlWidth) / 2)
		  Dim ControlTop As Integer = Rect.Top
		  Dim ControlHeight As Integer = Rect.Height
		  
		  // Because Xojo on Windows draws like old people fuck...
		  G.ForeColor = Scheme.SegmentShadowColor
		  #if TargetWin32
		    G.FillRect(ControlLeft, ControlTop + 1, ControlWidth, ControlHeight)
		  #else
		    G.FillRoundRect(ControlLeft, ControlTop + 1, ControlWidth, ControlHeight, Self.CornerRadius, Self.CornerRadius)
		  #endif
		  G.ForeColor = Scheme.SegmentFrameColor
		  #if TargetWin32
		    G.FillRect(ControlLeft, ControlTop, ControlWidth, ControlHeight)
		  #else
		    G.FillRoundRect(ControlLeft, ControlTop, ControlWidth, ControlHeight, Self.CornerRadius, Self.CornerRadius)
		  #endif
		  G.ForeColor = Scheme.BackgroundColor
		  #if TargetWin32
		    G.FillRect(ControlLeft + Self.SegmentBorderSize, ControlTop + Self.SegmentBorderSize, ControlWidth - (Self.SegmentBorderSize * 2), ControlHeight - (Self.SegmentBorderSize * 2))
		  #else
		    G.FillRoundRect(ControlLeft + Self.SegmentBorderSize, ControlTop + Self.SegmentBorderSize, ControlWidth - (Self.SegmentBorderSize * 2), ControlHeight - (Self.SegmentBorderSize * 2), Self.CornerRadius - Self.SegmentBorderSize, Self.CornerRadius - Self.SegmentBorderSize)
		  #endif
		  Dim NextLeft As Integer = ControlLeft + Self.SegmentBorderSize
		  For I As Integer = 0 To UBound(Self.mSegments)
		    Dim Selected As Boolean = I = Self.mSelectedSegmentIndex
		    Dim Pressed As Boolean
		    Dim SegmentTag As Text = "Segment" + I.ToText()
		    If Self.mMouseDown And Self.mMouseDownInRect And Self.mActiveClickRegion = SegmentTag Then
		      // Pressed
		      Pressed = True
		    End If
		    
		    Dim Segment As Graphics = G.Clip(NextLeft, ControlTop + Self.SegmentBorderSize, CellWidth, ControlHeight - (Self.SegmentBorderSize * 2))
		    Dim TextColor, ShadowColor As Color
		    If Pressed Then
		      Segment.ForeColor = Scheme.SegmentPressedColor
		      Segment.FillRect(0, 0, Segment.Width, Segment.Height)
		      TextColor = Scheme.SegmentSelectedTextColor
		      ShadowColor = Scheme.SegmentPressedColor
		    ElseIf Selected Then
		      Segment.ForeColor = Scheme.SegmentFrameColor
		      Segment.FillRect(0, 0, Segment.Width, Segment.Height)
		      TextColor = Scheme.SegmentSelectedTextColor
		      ShadowColor = Scheme.SegmentFrameColor
		    Else
		      TextColor = Scheme.SegmentTextColor
		      ShadowColor = Scheme.SegmentShadowColor
		    End If
		    
		    Dim SegmentText As String = Self.mSegments(I)
		    Dim TextWidth As Integer = Min(Ceil(Segment.StringWidth(SegmentText)), CellWidth - 10)
		    Dim TextLeft As Integer = (Segment.Width - TextWidth) / 2
		    Dim TextBottom As Integer = (Segment.Height / 2) + ((Segment.TextAscent * 0.9) / 2)
		    #if TargetWin32
		      TextBottom = TextBottom - 1
		    #endif
		    Segment.ForeColor = ShadowColor
		    Segment.DrawString(SegmentText, TextLeft, TextBottom + 1, CellWidth - 10, True)
		    Segment.ForeColor = TextColor
		    Segment.DrawString(SegmentText, TextLeft, TextBottom, CellWidth - 10, True)
		    
		    Self.RegisterClickRegion(SegmentTag, New Xojo.Core.Rect(NextLeft, ControlTop + Self.SegmentBorderSize, CellWidth, ControlHeight - (Self.SegmentBorderSize * 2)))
		    
		    NextLeft = NextLeft + CellWidth
		    If I < UBound(Self.mSegments) Then
		      G.ForeColor = Scheme.SegmentFrameColor
		      G.FillRect(NextLeft, ControlTop, Self.SegmentBorderSize, ControlHeight)
		    End If
		    NextLeft = NextLeft + Self.SegmentBorderSize
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Highlighted() As Boolean
		  If Self.Enabled Then
		    #if TargetCocoa
		      Declare Function IsMainWindow Lib "Cocoa.framework" Selector "isMainWindow" (Target As Integer) As Boolean
		      Declare Function IsKeyWindow Lib "Cocoa.framework" Selector "isKeyWindow" (Target As Integer) As Boolean
		      Return IsKeyWindow(Self.TrueWindow.Handle) Or IsMainWindow(Self.TrueWindow.Handle)
		    #else
		      Return True
		    #endif
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RegionClicked(Tag As Text)
		  If Tag.BeginsWith("Segment") Then
		    Self.SegmentIndex = Integer.FromText(Tag.Mid(7))
		    Return
		  ElseIf Tag = "Add" Then
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RegisterClickRegion(Tag As Text, Rect As Xojo.Core.Rect)
		  Self.mClickRects.Value(Tag) = Rect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveSegment(Caption As Text)
		  Dim Index As Integer = Self.mSegments.IndexOf(Caption)
		  If Index > -1 Then
		    Self.mSegments.Remove(Index)
		    Self.UnregisterClickRegion("Segment" + Index.ToText)
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Segment(Index As Integer) As Text
		  Return Self.mSegments(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Segment(Index As Integer, Assigns Value As Text)
		  Self.mSegments(Index) = Value
		  Self.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UnregisterClickRegion(Tag As Text)
		  If Self.mClickRects.HasKey(Tag) Then
		    Self.mClickRects.Remove(Tag)
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Activate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Deactivate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDrag(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseUp(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize(NewSize As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SegmentChange()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mActiveClickRegion As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mActiveColors As ColorScheme
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClickRects As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInactiveColors As ColorScheme
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInactiveTintColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMouseDownInRect As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSegments() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectedSegmentIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubclassHandlesMouse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTintColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelectedSegmentIndex
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Min(Value, UBound(Self.mSegments)), -1)
			  
			  If Self.mSelectedSegmentIndex <> Value Then
			    Self.mSelectedSegmentIndex = Value
			    RaiseEvent SegmentChange()
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		SegmentIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTintColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTintColor = Value Then
			    Return
			  End If
			  
			  Dim Grey As Integer = (Value.Red * 0.71) + (Value.Green * 0.72) + (Value.Blue * 0.07)
			  Self.mActiveColors = Self.BuildColorScheme(Value)
			  Self.mInactiveColors = Self.BuildColorScheme(RGB(Grey, Grey, Grey, Value.Alpha))
			  
			  Self.Invalidate
			End Set
		#tag EndSetter
		TintColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mTitle, Value, 0) <> 0 Then
			    Self.mTitle = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		Title As String
	#tag EndComputedProperty


	#tag Constant, Name = CornerRadius, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DefaultColor, Type = Color, Dynamic = False, Default = \"&cEAEEF1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Padding, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RowHeight, Type = Double, Dynamic = False, Default = \"36", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SegmentBorderSize, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SegmentCellHeight, Type = Double, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SegmentCellWidth, Type = Double, Dynamic = False, Default = \"68", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TitleHeight, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant


	#tag Structure, Name = ColorScheme, Flags = &h21
		BackgroundColor As Color
		  BorderColor As Color
		  SegmentFrameColor As Color
		  SegmentPressedColor As Color
		  SegmentSelectedTextColor As Color
		  SegmentShadowColor As Color
		  SegmentTextColor As Color
		  TitleTextColor As Color
		TitleShadowColor As Color
	#tag EndStructure


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
			Name="SegmentIndex"
			Group="Behavior"
			Type="Integer"
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
			Name="TintColor"
			Visible=true
			Group="Behavior"
			InitialValue="&cEAEEF1"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
