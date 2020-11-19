#tag Class
Protected Class Metadata
Inherits Beacon.ConfigGroup
Implements ObservationKit.Observable
	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  
		  If (Profile Is Nil Or Profile IsA Beacon.GenericServerProfile Or Profile.Name.IsEmpty) = False Then
		    Values.AddRow(New Beacon.ConfigValue("SessionSettings", "SessionName", Profile.Name))
		  End If
		  
		  If App.IdentityManager.CurrentIdentity.IsBanned Then
		    Var Messages() As String
		    Messages.AddRow("My dog has no nose.\nHow does he smell?\nBad.")
		    Messages.AddRow("Pet the damn Thylacoleo!")
		    Messages.AddRow("You are not in the sudoers file.\nThis incident will be reported.")
		    Messages.AddRow("All our horses are 100% horse-fed for that double-horse juiced-in goodness.")
		    Messages.AddRow("The intent is to provide players with a sense of pride and accomplishment.")
		    Messages.AddRow("Dog lips. That is all.")
		    Messages.AddRow("Maybe question how the server owner pays for this server.")
		    Messages.AddRow("You're stuck with this message for 5 minutes.")
		    Messages.AddRow("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!")
		    Messages.AddRow("Bonus round! Until further notice, there are no rules! Admin password is 'peanuts' so have fun!")
		    Messages.AddRow("It's ""Boy in the Bubble"" day! Even a sneeze could kill you! Good luck!")
		    Messages.AddRow("Children of Men! Dinos won't respawn! Good luck!")
		    Messages.AddRow("What happens when an Ark spins out of control?")
		    
		    Var Rand As Random = System.Random
		    Rand.RandomizeSeed
		    Var Index As Integer = Rand.InRange(0, Messages.LastRowIndex)
		    
		    Values.AddRow(New Beacon.ConfigValue("MessageOfTheDay", "Message", Messages(Index)))
		    
		    If Index = 9 Then
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ServerAdminPassword", "peanuts"))
		    ElseIf Index = 10 Then
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "PlayerResistanceMultiplier", "9999"))
		    ElseIf Index = 11 Then
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "DinoCountMultiplier", "0"))
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "DinoResistanceMultiplier", "9999"))
		    ElseIf Index = 12 Then
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "DayCycleSpeedScale", "300"))
		    End If
		    
		    If Index = 7 Then
		      Values.AddRow(New Beacon.ConfigValue("MessageOfTheDay", "Duration", "360"))
		    Else
		      Values.AddRow(New Beacon.ConfigValue("MessageOfTheDay", "Duration", "30"))
		    End If
		    
		    Return
		  End If
		  
		  #if Beacon.MOTDEditingEnabled Then
		    If Profile.MessageOfTheDay.IsEmpty = False Then
		      Values.AddRow(New Beacon.ConfigValue("MessageOfTheDay", "Message", Self.RTFToArkML(Profile.MessageOfTheDay)))
		      Values.AddRow(New Beacon.ConfigValue("MessageOfTheDay", "Duration", Profile.MessageDuration.ToString))
		    End If
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Title") Then
		    Self.Title = Dict.Value("Title")
		  End If
		  If Dict.HasKey("Description") Then
		    Self.Description = Dict.Value("Description")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Title") = Self.Title
		  Dict.Value("Description") = Self.Description
		  Dict.Value("Public") = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.AddRow(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ArkMLToRTF(ArkData As String) As String
		  If ArkData.BeginsWith("""") And ArkData.EndsWith("""") Then
		    ArkData = ArkData.Middle(1, ArkData.Length - 2)
		  End If
		  
		  ArkData = ArkData.ReplaceAll("\""", """")
		  ArkData = ArkData.ReplaceAll("\n", EndOfLine.UNIX)
		  ArkData = HTMLDecode(ArkData)
		  
		  Var NewLine As Boolean = True
		  Var Offset As Integer = 0
		  Var Styles As New StyledText
		  While True
		    Var Pos As Integer = ArkData.IndexOf(Offset, "<RichColor")
		    If Pos = -1 Then
		      Var Run As New StyleRun(ArkData.Middle(Offset))
		      Run.TextColor = &cFFFFFF00
		      Styles.AddStyleRun(Run)
		      Exit
		    End If
		    
		    If Pos > Offset Then
		      Var Unstyled As String = ArkData.Middle(Offset, Pos - Offset)
		      Var Run As New StyleRun(Unstyled)
		      Run.TextColor = &cFFFFFF00
		      Styles.AddStyleRun(Run)
		      If Unstyled.IndexOf(EndOfLine.UNIX) > -1 Then
		        NewLine = True
		      End If
		    End If
		    
		    Var EndPos As Integer = ArkData.IndexOf(Offset, "</>")
		    If EndPos = -1 Then
		      // Tag was never closed
		      ArkData = ArkData + "</>"
		      EndPos = ArkData.Length
		    Else
		      EndPos = EndPos + 3
		    End If
		    Var Chunk As String = ArkData.Middle(Offset, EndPos - Offset)
		    
		    Var ColorStartPos As Integer = Chunk.IndexOf("=") + 1
		    Var ColorEndPos As Integer = Chunk.IndexOf(ColorStartPos, ">")
		    Var ColorAttribute As String = Chunk.Middle(ColorStartPos, ColorEndPos - ColorStartPos)
		    If (ColorAttribute.BeginsWith("""") And ColorAttribute.EndsWith("""")) Or (ColorAttribute.BeginsWith("'") And ColorAttribute.EndsWith("'")) Then
		      ColorAttribute = ColorAttribute.Middle(1, ColorAttribute.Length - 2)
		    End If
		    Chunk = Chunk.Middle(ColorEndPos + 1)
		    Chunk = Chunk.Left(Chunk.Length - 3)
		    
		    Var ColorParts() As String = ColorAttribute.Split(",")
		    If ColorParts.LastRowIndex = 3 Then
		      Var RedAmount As Integer = Round(255 * ColorParts(0).Trim.ToDouble)
		      Var GreenAmount As Integer = Round(255 * ColorParts(1).Trim.ToDouble)
		      Var BlueAmount As Integer = Round(255 * ColorParts(2).Trim.ToDouble)
		      Var AlphaAmount As Integer = 255 - Round(255 * ColorParts(3).Trim.ToDouble)
		      
		      If NewLine Then
		        Var Space As New StyleRun(" ")
		        Space.TextColor = &CFFFFFF
		        Styles.AddStyleRun(Space)
		        NewLine = False
		      End If
		      
		      Var Run As New StyleRun(Chunk)
		      Run.TextColor = Color.RGB(RedAmount, GreenAmount, BlueAmount, AlphaAmount)
		      Styles.AddStyleRun(Run)
		      
		      If Chunk.IndexOf(EndOfLine.UNIX) > -1 Then
		        NewLine = True
		      End If
		    End If
		    
		    Offset = EndPos
		  Wend
		  
		  If Styles.StyleRunCount > 0 Then
		    // This errors sometimes for who knows why
		    Try
		      Return Styles.RTFData
		    Catch Err As RuntimeException
		      Return ""
		    End Try
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "Metadata"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.Metadata
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If ParsedData.HasKey("SessionName") Then
		    Var SessionNames() As Variant = ParsedData.AutoArrayValue("SessionName")
		    For Each SessionName As Variant In SessionNames
		      Try
		        Var Config As New BeaconConfigs.Metadata
		        Config.Title = SessionName.StringValue.GuessEncoding
		        Return Config
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
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
		Sub NotifyObservers(Key As String, Value As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function RTFToArkML(RTFData As String) As String
		  Const UTF16HighSurrogateStart = &hD800
		  Const UTF16LowSurrogateStart = &hDC00
		  Const UTF16SurrogateEnd = &hDFFF
		  
		  Var Styles As New StyledText
		  Styles.RTFData = RTFData
		  
		  Var Parts() As String
		  Var WhitespaceMatcher As New Regex
		  WhitespaceMatcher.SearchPattern = "^\s+$"
		  Var ColoredTextTrimmer As New Regex
		  ColoredTextTrimmer.SearchPattern = "^(\s*)(.+)(\s*)$"
		  ColoredTextTrimmer.Options.Greedy = True
		  
		  Var Bound As Integer = Styles.StyleRunCount - 1
		  For Idx As Integer = 0 To Bound
		    Var Run As StyleRun = Styles.StyleRun(Idx)
		    Var Body As String = Run.Text.ReplaceLineEndings(EndOfLine)
		    
		    Var RunLen As Integer = Body.Length - 2
		    For Offset As Integer = 0 To RunLen
		      Var Char As Int32 = Asc(Body.Middle(Offset, 1))
		      If Char < UTF16HighSurrogateStart Or Char > UTF16SurrogateEnd Then
		        Continue
		      End If
		      
		      Var HighSurrogate As Int32 = Char - UTF16HighSurrogateStart
		      Var LowSurrogate As Int32 = (Asc(Body.Middle(Offset + 1, 1)) And &hFFFF) - UTF16LowSurrogateStart
		      
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
		    
		    If Run.TextColor.IsWhite = False And WhitespaceMatcher.Search(Body) Is Nil Then
		      Var RedAmount As Double = Run.TextColor.Red / 255
		      Var GreenAmount As Double = Run.TextColor.Green / 255
		      Var BlueAmount As Double = Run.TextColor.Blue / 255
		      Var AlphaAmount As Double = 1.0 - (Run.TextColor.Alpha / 255)
		      
		      Var OpenTag As String = "<RichColor Color=""" + RedAmount.PrettyText(2) + "," + GreenAmount.PrettyText(2) + "," + BlueAmount.PrettyText(2) + "," + AlphaAmount.PrettyText(2) + """>"
		      Var CloseTag As String = "</>"
		      
		      Var Pieces() As String = Body.Split(EndOfLine)
		      For Piece As Integer = 0 To Pieces.LastRowIndex
		        Var Match As RegexMatch = ColoredTextTrimmer.Search(Pieces(Piece))
		        If (Match Is Nil) = False Then
		          Pieces(Piece) = Match.SubExpressionString(1) + OpenTag + Match.SubExpressionString(2) + CloseTag + Match.SubExpressionString(3)
		        Else
		          Pieces(Piece) = ""
		        End If
		      Next
		      
		      Body = Pieces.Join(EndOfLine)
		    End If
		    
		    Parts.AddRow(Body)
		  Next
		  
		  // The first <RichColor> on each line gets replaced with a space. Whatever Ark...
		  // So we need one more split on EndOfLine
		  Parts = Parts.Join("").Split(EndOfLine)
		  For Idx As Integer = 0 To Parts.LastRowIndex
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
		  //Return """" + Message + """"
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDescription
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDescription.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mDescription = Value
			    Self.Modified = True
			    Self.NotifyObservers("Description", Self.mDescription)
			  End If
			End Set
		#tag EndSetter
		Description As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTitle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mTitle.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mTitle = Value
			    Self.Modified = True
			    Self.NotifyObservers("Title", Self.mTitle)
			  End If
			End Set
		#tag EndSetter
		Title As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
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
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
