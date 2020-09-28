#tag Class
Protected Class BeaconCodeLine
	#tag Method, Flags = &h21
		Private Sub AddText(BasedOn As Graphics, FontColor As Color, Content As String, ByRef X As Double)
		  Const CharsPerChunk = 200
		  
		  Var Bound As Integer = Content.Length
		  For Offset As Integer = 0 To Bound Step CharsPerChunk
		    Var Chunk As String = Content.Middle(Offset, CharsPerChunk)
		    Var Shape As New BeaconTextShape
		    Shape.FontName = BasedOn.FontName
		    Shape.FontSize = BasedOn.FontSize
		    Shape.FontUnit = BasedOn.FontUnit
		    Shape.FillColor = FontColor
		    Shape.Value = Chunk
		    Shape.HorizontalAlignment = TextShape.Alignment.Left
		    Shape.VerticalAlignment = TextShape.Alignment.BaseLine
		    Shape.X = X
		    Shape.Y = 0
		    Shape.Width = BasedOn.TextWidth(Chunk)
		    X = X + Shape.Width
		    Self.mCachedObjects.AddRow(Shape)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Content As String)
		  Self.Constructor()
		  Self.mContent = Content
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate()
		  Self.mCachedPic = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IsValueNumeric(Value As String) As Boolean
		  Static NumberMatcher As Regex
		  If NumberMatcher = Nil Then
		    NumberMatcher = New Regex
		    NumberMatcher.SearchPattern = "^\d+(\.\d+)?$"
		  End If
		  
		  Return NumberMatcher.Search(Value) <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Source As String)
		  Self.Constructor(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Render(G As Graphics, Rect As Xojo.Rect, Theme As BeaconCodeTheme, OffsetX As Double, OffsetY As Double)
		  Static KeywordMatcher As Regex
		  If KeywordMatcher = Nil Then
		    KeywordMatcher = New Regex
		    KeywordMatcher.SearchPattern = "^([a-zA-Z0-9_\.]+)(\[(\d+)\])?=(.*)$"
		  End If
		  
		  Var KeywordMatches As RegexMatch = KeywordMatcher.Search(Self.mContent)
		  Self.mRect = Rect.Clone
		  
		  If Self.mCachedObjects.LastRowIndex = -1 And Self.mContent <> "" Then
		    Var Offset As Double
		    
		    If Self.mContent.BeginsWith("[") And Self.mContent.EndsWith("]") Then
		      Self.AddText(G, Theme.MarkupColor, Self.mContent, Offset)
		    ElseIf Self.mContent.BeginsWith("//") Then
		      Self.AddText(G, Theme.CommentColor, Self.mContent, Offset)
		    ElseIf Self.mContent.BeginsWith("#") Then
		      Self.AddText(G, Theme.PragmaColor, Self.mContent, Offset)
		    ElseIf KeywordMatches <> Nil Then
		      Var Keyword As String = KeywordMatches.SubExpressionString(1)
		      Var KeywordParameter As String = If(KeywordMatches.SubExpressionCount > 2, KeywordMatches.SubExpressionString(3), "")
		      Var ValuePart As String = Keywordmatches.SubExpressionString(4)
		      
		      Self.AddText(G, Theme.KeywordColor, Keyword, Offset)
		      If KeywordParameter <> "" Then
		        Self.AddText(G, Theme.MarkupColor, "[", Offset)
		        Self.AddText(G, Theme.PlainTextColor, KeywordParameter, Offset)
		        Self.AddText(G, Theme.MarkupColor, "]", Offset)
		      End If
		      Self.AddText(G, Theme.MarkupColor, "=", Offset)
		      If ValuePart.Length > 1 And ValuePart.BeginsWith("(") Then
		        Var Pos As Integer = 0
		        Self.RenderArray(ValuePart, Pos, G, Offset, Theme)
		      Else
		        Var ValueColor As Color
		        If ValuePart = "True" Then
		          ValueColor = Theme.TrueColor
		          ValuePart = "True" // To capitalize
		        ElseIf ValuePart = "False" Then
		          ValueColor = Theme.FalseColor
		          ValuePart = "False" // To capitalize
		        ElseIf ValuePart.Length > 1 And ValuePart.BeginsWith("""") Then
		          ValueColor = Theme.StringColor
		        ElseIf Self.IsValueNumeric(ValuePart) Then
		          ValueColor = Theme.NumberColor
		        Else
		          ValueColor = Theme.StringColor
		        End If
		        Self.AddText(G, ValueColor, ValuePart, Offset)
		      End If
		    Else
		      Self.AddText(G, Theme.PlainTextColor, Self.mContent, Offset)
		    End If
		    
		    Self.mLineWidth = Offset
		  End If
		  
		  For Idx As Integer = 0 To Self.mCachedObjects.LastRowIndex
		    Var Obj As BeaconTextShape = Self.mCachedObjects(Idx)
		    Var EffectiveLeft As Double = Obj.X + OffsetX
		    Var EffectiveRight As Double = EffectiveLeft + Obj.Width
		    If EffectiveRight <= 0 Then
		      Continue
		    ElseIf EffectiveLeft >= G.Width Then
		      Exit // Don't even continue inspecting objects, there's no more that can be drawn
		    End If
		    G.DrawObject(Obj, OffsetX, OffsetY)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RenderArray(ValuePart As String, ByRef StartPos As Integer, G As Graphics, ByRef OffsetX As Double, Theme As BeaconCodeTheme)
		  If ValuePart.Middle(StartPos, 1) <> "(" Then
		    Return
		  End If
		  
		  Self.AddText(G, Theme.MarkupColor, "(", OffsetX)
		  StartPos = StartPos + 1
		  
		  Var ValueMatcher As New Regex
		  ValueMatcher.SearchPattern = "^(([a-zA-Z0-9_]+)(\[(\d+)\])?=)?((""[^""]+"")|([^\,\)]+))"
		  
		  Var NextChar As String
		  Do
		    NextChar = ValuePart.Middle(StartPos, 1)
		    If NextChar = "(" Then
		      Self.RenderArray(ValuePart, StartPos, G, OffsetX, Theme)
		      Continue
		    ElseIf NextChar = "," Or NextChar = ")" Or NextChar = "" Then
		      Self.AddText(G, Theme.MarkupColor, NextChar, OffsetX)
		      StartPos = StartPos + 1
		      Continue
		    End If
		    
		    Var ValueMatch As RegexMatch = ValueMatcher.Search(ValuePart.Middle(StartPos))
		    If ValueMatch = Nil Then
		      Break
		      Return
		    End If
		    
		    Var KeywordPart As String = ValueMatch.SubExpressionString(2)
		    Var ParameterPart As String = ValueMatch.SubExpressionString(4)
		    Var Value As String = ValueMatch.SubExpressionString(5)
		    
		    If KeywordPart <> "" Then
		      Self.AddText(G, Theme.KeywordColor, KeywordPart, OffsetX)
		      If ParameterPart <> "" Then
		        Self.AddText(G, Theme.MarkupColor, "[", OffsetX)
		        Self.AddText(G, Theme.PlainTextColor, ParameterPart, OffsetX)
		        Self.AddText(G, Theme.MarkupColor, "]", OffsetX)
		      End If
		      Self.AddText(G, Theme.MarkupColor, "=", OffsetX)
		      StartPos = StartPos + ValueMatch.SubExpressionString(1).Length
		    End If
		    
		    If Value.BeginsWith("(") Then
		      Self.RenderArray(Value, StartPos, G, OffsetX, Theme)
		    Else
		      Var ValueColor As Color
		      If Value = "True" Then
		        ValueColor = Theme.TrueColor
		        Value = "True" // To capitalize
		      ElseIf Value = "False" Then
		        ValueColor = Theme.FalseColor
		        Value = "False" // To capitalize
		      ElseIf Self.IsValueNumeric(Value) Then
		        ValueColor = Theme.NumberColor
		      Else
		        ValueColor = Theme.StringColor
		      End If
		      Self.AddText(G, ValueColor, Value, OffsetX)
		      StartPos = StartPos + Value.Length
		    End If
		  Loop Until NextChar = ")" Or NextChar = ""
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mContent
			End Get
		#tag EndGetter
		Content As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mContent.Length
			End Get
		#tag EndGetter
		Length As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCachedObjects() As BeaconTextShape
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCachedOffset As Xojo.Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCachedPic As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLineWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRect As Xojo.Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return New Xojo.Rect(Self.mRect.Left, Self.mRect.Top, Self.mRect.Width, Self.mRect.Height)
			End Get
		#tag EndGetter
		Rect As Xojo.Rect
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Visible As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Content"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
