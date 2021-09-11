#tag Class
Protected Class ArkML
	#tag Method, Flags = &h0
		Function ArkMLValue() As String
		  Const UTF16HighSurrogateStart = &hD800
		  Const UTF16LowSurrogateStart = &hDC00
		  Const UTF16SurrogateEnd = &hDFFF
		  
		  Var Parts() As String
		  Var WhitespaceMatcher As New Regex
		  WhitespaceMatcher.SearchPattern = "^\s+$"
		  Var ColoredTextTrimmer As New Regex
		  ColoredTextTrimmer.SearchPattern = "^(\s*)(.+)(\s*)$"
		  ColoredTextTrimmer.Options.Greedy = True
		  
		  Var Bound As Integer = Self.mParts.LastIndex
		  For Idx As Integer = 0 To Bound
		    Var Dict As Dictionary = Self.mParts(Idx)
		    Var Body As String = Dict.Value("Text").StringValue
		    
		    Var RunLen As Integer = Body.Length - 2
		    For Offset As Integer = 0 To RunLen
		      Var Char As Int32 = Body.Middle(Offset, 1).Asc
		      If Char < UTF16HighSurrogateStart Or Char > UTF16SurrogateEnd Then
		        Continue
		      End If
		      
		      Var HighSurrogate As Int32 = Char - UTF16HighSurrogateStart
		      Var LowSurrogate As Int32 = (Body.Middle(Offset + 1, 1).Asc And &hFFFF) - UTF16LowSurrogateStart
		      
		      If HighSurrogate >= 0 And LowSurrogate >= 0 Then
		        Char = (HighSurrogate * &h400) + LowSurrogate + &h10000
		        Body = Body.Left(Offset) + Encodings.UTF8.Chr(Char) + Body.Middle(Offset + 2)
		      Else
		        Body = Body.Left(Offset) + Body.Middle(Offset + 1)
		      End If
		    Next
		    
		    If Body.IsEmpty Then
		      Continue
		    End If
		    
		    Body = HTMLEncode(Body)
		    
		    Var TextColor As Color = Dict.Value("Color").ColorValue
		    If TextColor.IsWhite = False And WhitespaceMatcher.Search(Body) Is Nil Then
		      Var RedAmount As Double = TextColor.Red / 255
		      Var GreenAmount As Double = TextColor.Green / 255
		      Var BlueAmount As Double = TextColor.Blue / 255
		      Var AlphaAmount As Double = 1.0 - (TextColor.Alpha / 255)
		      
		      Var OpenTag As String = "<RichColor Color=""" + RedAmount.PrettyText(2) + "," + GreenAmount.PrettyText(2) + "," + BlueAmount.PrettyText(2) + "," + AlphaAmount.PrettyText(2) + """>"
		      Var CloseTag As String = "</>"
		      
		      Var Pieces() As String = Body.Split(EndOfLine.UNIX)
		      For Piece As Integer = 0 To Pieces.LastIndex
		        Var Match As RegexMatch = ColoredTextTrimmer.Search(Pieces(Piece))
		        If (Match Is Nil) = False Then
		          Pieces(Piece) = Match.SubExpressionString(1) + OpenTag + Match.SubExpressionString(2) + CloseTag + Match.SubExpressionString(3)
		        Else
		          Pieces(Piece) = ""
		        End If
		      Next
		      
		      Body = Pieces.Join(EndOfLine.UNIX)
		    End If
		    
		    Parts.Add(Body)
		  Next
		  
		  // The first <RichColor> on each line gets replaced with a space. Whatever Ark...
		  // So we need one more split on EndOfLine
		  Parts = Parts.Join("").Split(EndOfLine.UNIX)
		  For Idx As Integer = 0 To Parts.LastIndex
		    Var Pos As Integer = Parts(Idx).IndexOf("<RichColor")
		    If Pos > 0 And Parts(Idx).Middle(Pos - 1, 1) = " " Then
		      Parts(Idx) = Parts(Idx).Left(Pos - 1) + Parts(Idx).Middle(Pos)
		    End If
		  Next
		  
		  Var Message As String = Parts.Join("\n")
		  //Message = Message.ReplaceAll("""", "\""")
		  
		  // Move whitespace from the end of a color tag to outside it
		  Var Cleaner As New Regex
		  Cleaner.SearchPattern = "(\s+)</>"
		  Cleaner.ReplacementPattern = "</>\1"
		  Message = Cleaner.Replace(Message)
		  
		  // Remove whitespace at the end of lines
		  Cleaner.SearchPattern = "(\s+)\\n"
		  Cleaner.ReplacementPattern = "\\n"
		  Message = Cleaner.Replace(Message)
		  
		  // And remove newlines at the end of the message
		  Cleaner.SearchPattern = "(\\n+)$"
		  Cleaner.ReplacementPattern = ""
		  Message = Cleaner.Replace(Message)
		  
		  // Links seem to screw up Ark
		  Message = Message.ReplaceAll("https://", "")
		  Message = Message.ReplaceAll("http://", "")
		  
		  Return Message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ArkMLValue(Assigns Source As String)
		  Self.mParts.ResizeTo(-1)
		  
		  If Source.BeginsWith("""") And Source.EndsWith("""") Then
		    Source = Source.Middle(1, Source.Length - 2)
		  End If
		  
		  Source = Source.ReplaceAll("\""", """")
		  Source = Source.ReplaceAll("\n", EndOfLine.UNIX)
		  Source = HTMLDecode(Source)
		  
		  Var NewLine As Boolean = True
		  Var Offset As Integer = 0
		  While True
		    Var Pos As Integer = Source.IndexOf(Offset, "<RichColor")
		    If Pos = -1 Then
		      Self.mParts.Add(Self.CreateDict(Source.Middle(Offset), &cFFFFFF00))
		      Exit
		    End If
		    
		    If Pos > Offset Then
		      Var Unstyled As String = Source.Middle(Offset, Pos - Offset)
		      Self.mParts.Add(Self.CreateDict(Unstyled, &cFFFFFF00))
		      If Unstyled.IndexOf(EndOfLine.UNIX) > -1 Then
		        NewLine = True
		      End If
		    End If
		    
		    Var EndPos As Integer = Source.IndexOf(Offset, "</>")
		    If EndPos = -1 Then
		      // Tag was never closed
		      Source = Source + "</>"
		      EndPos = Source.Length
		    Else
		      EndPos = EndPos + 3
		    End If
		    Var Chunk As String = Source.Middle(Offset, EndPos - Offset)
		    
		    Var ColorStartPos As Integer = Chunk.IndexOf("=") + 1
		    Var ColorEndPos As Integer = Chunk.IndexOf(ColorStartPos, ">")
		    Var ColorAttribute As String = Chunk.Middle(ColorStartPos, ColorEndPos - ColorStartPos)
		    If (ColorAttribute.BeginsWith("""") And ColorAttribute.EndsWith("""")) Or (ColorAttribute.BeginsWith("'") And ColorAttribute.EndsWith("'")) Then
		      ColorAttribute = ColorAttribute.Middle(1, ColorAttribute.Length - 2)
		    End If
		    Chunk = Chunk.Middle(ColorEndPos + 1)
		    Chunk = Chunk.Left(Chunk.Length - 3)
		    
		    Var ColorParts() As String = ColorAttribute.Split(",")
		    If ColorParts.LastIndex = 3 Then
		      Var RedAmount As Integer = Round(255 * ColorParts(0).Trim.ToDouble)
		      Var GreenAmount As Integer = Round(255 * ColorParts(1).Trim.ToDouble)
		      Var BlueAmount As Integer = Round(255 * ColorParts(2).Trim.ToDouble)
		      Var AlphaAmount As Integer = 255 - Round(255 * ColorParts(3).Trim.ToDouble)
		      
		      If NewLine Then
		        Self.mParts.Add(Self.CreateDict(" ", &cFFFFFF00))
		        NewLine = False
		      End If
		      
		      Self.mParts.Add(Self.CreateDict(Chunk, Color.RGB(RedAmount, GreenAmount, BlueAmount, AlphaAmount)))
		      
		      If Chunk.IndexOf(EndOfLine.UNIX) > -1 Then
		        NewLine = True
		      End If
		    End If
		    
		    Offset = EndPos
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ArrayValue() As Dictionary()
		  Var Parts() As Dictionary
		  Parts.ResizeTo(Self.mParts.LastIndex)
		  For Idx As Integer = 0 To Parts.LastIndex
		    Parts(Idx) = Self.mParts(Idx).Clone
		  Next
		  Return Parts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ArrayValue(Assigns Source() As Dictionary)
		  Var Parts() As Dictionary
		  Parts.ResizeTo(Source.LastIndex)
		  For Idx As Integer = 0 To Parts.LastIndex
		    Parts(Idx) = Source(Idx).Clone
		  Next
		  Self.mParts = Parts
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.ArkML
		  Return FromArray(Self.mParts)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateDict(Value As String, TextColor As Color) As Dictionary
		  Var ColorValue As Variant = TextColor
		  
		  Var Dict As New Dictionary
		  Dict.Value("Text") = Value.ReplaceLineEndings(EndOfLine.UNIX) // Always store consistent line endings
		  Dict.Value("Color") = ColorValue.StringValue
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArkML(Source As String) As Ark.ArkML
		  Try
		    Var ML As New Ark.ArkML
		    ML.ArkMLValue = Source
		    Return ML
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromArray(Source() As Dictionary) As Ark.ArkML
		  Try
		    Var ML As New Ark.ArkML
		    ML.ArrayValue = Source
		    Return ML
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromObjects(Source() As Object) As Ark.ArkML
		  Var Dicts() As Dictionary
		  For Each Obj As Object In Source
		    If Obj IsA Dictionary Then
		      Dicts.Add(Dictionary(Obj))
		    End If
		  Next
		  Return FromArray(Dicts)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function FromRTF(Source As String) As Ark.ArkML
		  Try
		    Var ML As New Ark.ArkML
		    ML.RTFValue = Source
		    Return ML
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HTMLDecode(Input As String) As String
		  Var Searcher As New RegEx
		  Searcher.SearchPattern = "&(([A-Za-z0-9]+)|(#x[A-Fa-f0-9]+)|(#\d+));"
		  
		  Do
		    Var Match As RegExMatch = Searcher.Search(Input)
		    If Match Is Nil Then
		      Return Input
		    End If
		    
		    Var Matched As String = Match.SubExpressionString(1)
		    Var Replacement As String
		    If Matched.BeginsWith("#x") Then
		      // Hex encoding
		      Replacement = Encodings.UTF8.Chr(Integer.FromHex(Matched.Middle(2)))
		    ElseIf Matched.BeginsWith("#") Then
		      // Decimal encoding
		      Replacement = Encodings.UTF8.Chr(Integer.FromString(Matched.Middle(1)))
		    Else
		      // Named encoding
		      Select Case Matched
		      Case "quot"
		        Replacement = """"
		      Case "apos"
		        Replacement = "'"
		      Case "amp"
		        Replacement = "&"
		      Case "lt"
		        Replacement = "<"
		      Case "gt"
		        Replacement = ">"
		      Case "nbsp"
		        Replacement = " "
		      Case "iexcl"
		        Replacement = "¡"
		      Case "cent"
		        Replacement = "¢"
		      Case "pound"
		        Replacement = "£"
		      Case "curren"
		        Replacement = "¤"
		      Case "yen"
		        Replacement = "¥"
		      Case "brvbar"
		        Replacement = "¦"
		      Case "sect"
		        Replacement = "§"
		      Case "uml"
		        Replacement = "¨"
		      Case "copy"
		        Replacement = "©"
		      Case "ordf"
		        Replacement = "ª"
		      Case "laquo"
		        Replacement = "«"
		      Case "not"
		        Replacement = "¬"
		      Case "shy"
		        Replacement = ""
		      Case "reg"
		        Replacement = "®"
		      Case "macr"
		        Replacement = "¯"
		      Case "deg"
		        Replacement = "°"
		      Case "plusmn"
		        Replacement = "±"
		      Case "sup2"
		        Replacement = "²"
		      Case "sup3"
		        Replacement = "³"
		      Case "acute"
		        Replacement = "´"
		      Case "micro"
		        Replacement = "µ"
		      Case "para"
		        Replacement = "¶"
		      Case "middot"
		        Replacement = "·"
		      Case "cedil"
		        Replacement = "¸"
		      Case "sup1"
		        Replacement = "¹"
		      Case "ordm"
		        Replacement = "º"
		      Case "raquo"
		        Replacement = "»"
		      Case "frac14"
		        Replacement = "¼"
		      Case "frac12"
		        Replacement = "½"
		      Case "frac34"
		        Replacement = "¾"
		      Case "iquest"
		        Replacement = "¿"
		      Case "times"
		        Replacement = "×"
		      Case "divide"
		        Replacement = "÷"
		      Case "Agrave"
		        Replacement = "À"
		      Case "Aacute"
		        Replacement = "Á"
		      Case "Acirc"
		        Replacement = "Â"
		      Case "Atilde"
		        Replacement = "Ã"
		      Case "Auml"
		        Replacement = "Ä"
		      Case "Aring"
		        Replacement = "Å"
		      Case "AElig"
		        Replacement = "Æ"
		      Case "Ccedil"
		        Replacement = "Ç"
		      Case "Egrave"
		        Replacement = "È"
		      Case "Eacute"
		        Replacement = "É"
		      Case "Ecirc"
		        Replacement = "Ê"
		      Case "Euml"
		        Replacement = "Ë"
		      Case "Igrave"
		        Replacement = "Ì"
		      Case "Iacute"
		        Replacement = "Í"
		      Case "Icirc"
		        Replacement = "Î"
		      Case "Iuml"
		        Replacement = "Ï"
		      Case "ETH"
		        Replacement = "Ð"
		      Case "Ntilde"
		        Replacement = "Ñ"
		      Case "Ograve"
		        Replacement = "Ò"
		      Case "Oacute"
		        Replacement = "Ó"
		      Case "Ocirc"
		        Replacement = "Ô"
		      Case "Otilde"
		        Replacement = "Õ"
		      Case "Ouml"
		        Replacement = "Ö"
		      Case "Oslash"
		        Replacement = "Ø"
		      Case "Ugrave"
		        Replacement = "Ù"
		      Case "Uacute"
		        Replacement = "Ú"
		      Case "Ucirc"
		        Replacement = "Û"
		      Case "Uuml"
		        Replacement = "Ü"
		      Case "Yacute"
		        Replacement = "Ý"
		      Case "THORN"
		        Replacement = "Þ"
		      Case "szlig"
		        Replacement = "ß"
		      Case "agrave"
		        Replacement = "à"
		      Case "aacute"
		        Replacement = "á"
		      Case "acirc"
		        Replacement = "â"
		      Case "atilde"
		        Replacement = "ã"
		      Case "auml"
		        Replacement = "ä"
		      Case "aring"
		        Replacement = "å"
		      Case "aelig"
		        Replacement = "æ"
		      Case "ccedil"
		        Replacement = "ç"
		      Case "egrave"
		        Replacement = "è"
		      Case "eacute"
		        Replacement = "é"
		      Case "ecirc"
		        Replacement = "ê"
		      Case "euml"
		        Replacement = "ë"
		      Case "igrave"
		        Replacement = "ì"
		      Case "iacute"
		        Replacement = "í"
		      Case "icirc"
		        Replacement = "î"
		      Case "iuml"
		        Replacement = "ï"
		      Case "eth"
		        Replacement = "ð"
		      Case "ntilde"
		        Replacement = "ñ"
		      Case "ograve"
		        Replacement = "ò"
		      Case "oacute"
		        Replacement = "ó"
		      Case "ocirc"
		        Replacement = "ô"
		      Case "otilde"
		        Replacement = "õ"
		      Case "ouml"
		        Replacement = "ö"
		      Case "oslash"
		        Replacement = "ø"
		      Case "ugrave"
		        Replacement = "ù"
		      Case "uacute"
		        Replacement = "ú"
		      Case "ucirc"
		        Replacement = "û"
		      Case "uuml"
		        Replacement = "ü"
		      Case "yacute"
		        Replacement = "ý"
		      Case "thorn"
		        Replacement = "þ"
		      Case "yuml"
		        Replacement = "ÿ"
		      End Select
		    End If
		    
		    Input = Input.ReplaceAll(Match.SubExpressionString(0), Replacement)
		  Loop
		  
		  Return Input
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HTMLEncode(Input As String) As String
		  Input = Input.ReplaceAll("&", "&amp;")
		  Input = Input.ReplaceAll("<", "&lt;")
		  Input = Input.ReplaceAll(">", "&gt;")
		  Input = Input.ReplaceAll("""", "&quot;")
		  
		  // Clear control characters
		  Var Searcher As New Regex
		  Searcher.SearchPattern = "[\x{00}-\x{08}\x{0B}\x{0C}\x{0E}-\x{1F}\x{7F}]"
		  Searcher.ReplacementPattern = ""
		  Input = Searcher.Replace(Input)
		  
		  // Clear non-ascii characters
		  Searcher = New Regex
		  Searcher.SearchPattern = "[^\x{00}-\x{7F}]"
		  Do
		    Var Match As RegExMatch = Searcher.Search(Input)
		    If Match Is Nil Then
		      Return Input
		    End If
		    
		    Input = Input.ReplaceAll(Match.SubExpressionString(0), "")
		  Loop
		  
		  Return Input
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty() As Boolean
		  Return Self.mParts.Count = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.ArkML) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var SelfEncoded As String = Beacon.GenerateJSON(Self.mParts, False)
		  Var OtherEncoded As String = Beacon.GenerateJSON(Other.mParts, False)
		  
		  Return SelfEncoded.Compare(OtherEncoded, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function RTFValue() As String
		  #Pragma BreakOnExceptions False
		  Try
		    Var Styles As New StyledText
		    
		    For Idx As Integer = 0 To Self.mParts.LastIndex
		      Var Dict As Dictionary = Self.mParts(Idx)
		      Var Run As New StyleRun(Dict.Value("Text").StringValue) // Use the platform line ending here
		      Run.TextColor = Dict.Value("Color").ColorValue
		      Styles.AddStyleRun(Run)
		    Next
		    
		    Return Styles.RTFData
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Sub RTFValue(Assigns Source As String)
		  Try
		    Var Styles As New StyledText
		    Styles.RTFData = Source
		    
		    Self.mParts.ResizeTo(-1)
		    Var Bound As Integer = Styles.StyleRunCount - 1
		    For Idx As Integer = 0 To Bound
		      Var Run As StyleRun = Styles.StyleRun(Idx)
		      
		      Self.mParts.Add(Self.CreateDict(Run.Text, Run.TextColor))
		    Next
		  Catch Err As RuntimeException
		    Self.mParts.ResizeTo(-1)
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mParts() As Dictionary
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
	#tag EndViewBehavior
End Class
#tag EndClass
