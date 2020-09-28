#tag Class
Protected Class BeaconCodeEditor
Inherits ScrollCanvas
	#tag Event
		Function CharacterAtPoint(x as integer, y as integer) As integer
		  Return Floor(Self.CharacterAtPoint(X, Y))
		End Function
	#tag EndEvent

	#tag Event
		Function FontNameAtLocation(location as integer) As string
		  #Pragma Unused Location
		  Return "Source Code Pro"
		End Function
	#tag EndEvent

	#tag Event
		Function FontSizeAtLocation(location as integer) As integer
		  #Pragma Unused Location
		  Return 12
		End Function
	#tag EndEvent

	#tag Event
		Sub InsertText(text as string, range as TextRange)
		  Self.InsertText(Text, Range.Location, Range.Length)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Var Index As Double = Self.CharacterAtPoint(X, Y)
		  If Index = -1 Then
		    Return
		  End If
		  
		  //Var Char As String = Self.mContent.Middle(Floor(Index), 1)
		  //System.DebugLog(Str(Index, "-0.00") + ": " + Char)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Object)
		  #Pragma Unused Areas
		  
		  Var CurrentTheme As BeaconCodeTheme
		  If SystemColors.IsDarkMode Then
		    CurrentTheme = New BeaconCodeTheme(&c17171700, &cFFFFFF00, &cFC5FA200, &c6C798500, &c98E7D400, &c98E7D400, &c9586F400, &c9586F400, &c6C798500, &cFC8E3E00)
		  Else
		    CurrentTheme = New BeaconCodeTheme(&cFFFFFF00, &c00000000, &c9A239200, &c3F4F6100, &c3900A000, &c3900A000, &c1C00CE00, &c1C00CE00, &c52657900, &c63381F00)
		  End If
		  If Self.mLastTheme = Nil Or G.ScaleX <> Self.mLastScaleX Or G.ScaleY <> Self.mLastScaleY Or Self.mLastTheme.Matches(CurrentTheme) = False Then
		    For I As Integer = 0 To Self.mContentLines.LastRowIndex
		      Self.mContentLines(I).Invalidate()
		    Next
		  End If
		  
		  Self.mLastTheme = CurrentTheme
		  Self.mLastScaleX = G.ScaleX
		  Self.mLastScaleY = G.ScaleY
		  
		  G.DrawingColor = CurrentTheme.BackgroundColor
		  G.FillRectangle(0, 0, G.Width, G.Height)
		  G.DrawingColor = CurrentTheme.PlainTextColor.AtOpacity(0.05)
		  G.FillRectangle(0, 0, Self.GutterWidth, G.Height)
		  G.DrawingColor = CurrentTheme.PlainTextColor.AtOpacity(0.15)
		  G.FillRectangle(Self.GutterWidth, 0, 1, G.Height)
		  
		  G.FontName = "Source Code Pro"
		  G.FontSize = 12
		  G.FontUnit = FontUnits.Point
		  
		  Self.mCharacterWidth = G.TextWidth("m")
		  Self.mLineHeight = Ceil(G.TextHeight * 1.2)
		  Self.mBaselineHeight = Ceil((((G.TextHeight * 1.2) - G.CapHeight) / 2) + G.CapHeight)
		  
		  Var LineTop As Integer = Self.ScrollY * -1
		  Var Area As Graphics = G.Clip(Self.GutterWidth + 1, 0, G.Width - 41, G.Height)
		  Var Gutter As Graphics = G.Clip(0, 0, Self.GutterWidth, G.Height)
		  
		  Area.DrawingColor = CurrentTheme.PlainTextColor
		  Gutter.DrawingColor = Area.DrawingColor.AtOpacity(0.5)
		  Gutter.FontSize = 10
		  Var ContentWidth As Integer
		  For I As Integer = 0 To Self.mContentLines.LastRowIndex
		    Var Line As BeaconCodeLine = Self.mContentLines(I)
		    ContentWidth = Max(ContentWidth, Area.TextWidth(Line.Content))
		    
		    Var LineBottom As Integer = LineTop + Self.mLineHeight
		    If LineBottom < 0 Or LineTop > G.Height Then
		      Line.Visible = False
		      LineTop = LineTop + Self.mLineHeight
		      Continue
		    End If
		    
		    Line.Render(Area, New Xojo.Rect(0, LineTop, Area.Width, Self.mLineHeight), CurrentTheme, Self.LeftPadding + (Self.ScrollX * -1), LineTop + Self.mBaselineHeight)
		    Line.Visible = True
		    
		    Var LineNum As String = Str(I + 1, "0")
		    Gutter.DrawText(LineNum, Gutter.Width - (Gutter.TextWidth(LineNum) + 3), LineTop + Self.mBaselineHeight)
		    
		    LineTop = LineTop + Self.mLineHeight
		  Next
		  Self.ScrollSpeed = Self.mLineHeight
		  Self.ContentHeight = Self.mLineHeight * (Self.mContentLines.Count)
		  Self.ContentWidth = ContentWidth
		  //Self.ScrollX(False) = Self.ScrollX
		  //Self.ScrollY(False) = Self.ScrollY
		End Sub
	#tag EndEvent

	#tag Event
		Sub PaintScrollbar(G As Graphics, Vertical As Boolean, TrackRect As Xojo.Rect, ThumbRect As Xojo.Rect, Opacity As Double)
		  #Pragma Unused Vertical
		  #Pragma Unused TrackRect
		  
		  Var ArcWidth As Double = Min(ThumbRect.Width - 4, ThumbRect.Height - 4)
		  G.DrawingColor = SystemColors.LabelColor.AtOpacity(0.6).AtOpacity(Opacity)
		  G.FillRoundRectangle(ThumbRect.Left + 2, ThumbRect.Top + 2, ThumbRect.Width - 4, ThumbRect.Height - 4, ArcWidth, ArcWidth)
		End Sub
	#tag EndEvent

	#tag Event
		Function SelectedRange() As TextRange
		  Return New TextRange(Self.mSelStart, Self.mSelLength)
		End Function
	#tag EndEvent

	#tag Event
		Sub SetupGutters(ByRef LeftGutter As Integer, ByRef TopGutter As Integer, ByRef RightGutter As Integer, ByRef BottomGutter As Integer)
		  #Pragma Unused TopGutter
		  #Pragma Unused RightGutter
		  #Pragma Unused BottomGutter
		  
		  LeftGutter = Self.GutterWidth
		End Sub
	#tag EndEvent

	#tag Event
		Function TextForRange(range as TextRange) As string
		  Return Self.mContent.Middle(Range.Location, Range.Length)
		End Function
	#tag EndEvent

	#tag Event
		Function TextLength() As integer
		  Return Self.mContent.Length
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CharacterAtPoint(X As Integer, Y As Integer) As Double
		  Var Point As New Xojo.Point(X, Y)
		  Var TotalCharacterIndex As Integer
		  For Each Line As BeaconCodeLine In Self.mContentLines
		    If Line.Visible = False Then
		      TotalCharacterIndex = TotalCharacterIndex + Line.Content.Length + 1
		      Continue
		    End If
		    
		    Var Rect As Xojo.Rect = Line.Rect
		    If Rect = Nil Or Rect.Contains(Point) = False Then
		      TotalCharacterIndex = TotalCharacterIndex + Line.Content.Length + 1
		      Continue
		    End If
		    
		    X = X - (Self.GutterWidth + Self.LeftPadding + Self.ScrollX)
		    If X < 0 Then
		      Return -1
		    End If
		    
		    Var CharacterIndex As Double = X / Self.mCharacterWidth
		    If CharacterIndex >= Line.Content.Length Then
		      Return -1
		    End If
		    Return TotalCharacterIndex + CharacterIndex
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InsertText(NewText As String, StartPosition As UInteger, Length As UInteger)
		  Var LeftChunk As String = Self.mContent.Left(StartPosition)
		  Var RightChunk As String = Self.mContent.Middle(StartPosition + Length)
		  Self.mContent = LeftChunk + NewText + RightChunk
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OffsetAtPoint(X As Integer, Y As Integer) As Integer
		  Return Round(Self.CharacterAtPoint(X, Y))
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaselineHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCharacterWidth As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentLines() As BeaconCodeLine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastScaleX As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastScaleY As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastTheme As BeaconCodeTheme
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLineHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelLength As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelStart As UInteger
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mSelLength = 0 Then
			    Return ""
			  End If
			  
			  Return Self.mContent.Middle(Self.mSelStart, Self.mSelLength)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.InsertText(Value, Self.mSelStart, Self.mSelLength)
			  Self.mSelLength = Value.Length
			End Set
		#tag EndSetter
		SelContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelStart + Self.mSelLength
			End Get
		#tag EndGetter
		SelEnd As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelLength
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelLength <> Value Then
			    Self.mSelLength = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		SelLength As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSelStart
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mSelStart <> Value Then
			    Self.mSelStart = Value
			    Self.Invalidate
			  End If
			End Set
		#tag EndSetter
		SelStart As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var EOL As String = Encodings.ASCII.Chr(10)
			  Value = Value.ReplaceLineEndings(EOL)
			  
			  If StrComp(Self.mContent, Value, 0) <> 0 Then
			    Self.mContent = Value
			    
			    Var NewLines() As String = Value.Split(EOL)
			    Var Dict As New Dictionary
			    For I As Integer = 0 To Self.mContentLines.LastRowIndex
			      Dict.Value(Self.mContentLines(I).Content) = I
			    Next
			    
			    Var NewContentLines() As BeaconCodeLine
			    For I As Integer = 0 To NewLines.LastRowIndex
			      Var OldIdx As Integer = Dict.Lookup(NewLines(I), -1)
			      If OldIdx = -1 Then
			        NewContentLines.AddRow(New BeaconCodeLine(NewLines(I)))
			      Else
			        NewContentLines.AddRow(Self.mContentLines(OldIdx))
			      End If
			    Next
			    Self.mContentLines = NewContentLines
			    
			    Self.Invalidate()
			  End If
			End Set
		#tag EndSetter
		Value As String
	#tag EndComputedProperty


	#tag Constant, Name = GutterWidth, Type = Double, Dynamic = False, Default = \"40", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LeftPadding, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
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
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
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
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
		#tag ViewProperty
			Name="ViewportWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewportHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewportTop"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewportLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewportRight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewportBottom"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OverflowWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OverflowHeight"
			Visible=false
			Group="Behavior"
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
			EditorType="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelLength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelEnd"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
