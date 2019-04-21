#tag Module
Protected Module Beacon
	#tag Method, Flags = &h1
		Protected Function Clone(Source As Dictionary) As Dictionary
		  // This method only exists because the built-in clone method causes crashes.
		  // However, this only handles basic cases.
		  
		  If Source = Nil Then
		    // That was easy
		    Return Nil
		  End If
		  
		  Dim Clone As New Dictionary
		  Dim Keys() As Variant = Source.Keys
		  For Each Key As Variant In Keys
		    Dim Value As Variant = Source.Value(Key)
		    If Value <> Nil And Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		      Clone.Value(Key) = Beacon.Clone(Dictionary(Value.ObjectValue))
		    Else
		      Clone.Value(Key) = Source.Value(Key)
		    End If
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ComputeDifficultySettings(BaseDifficulty As Double, DesiredDinoLevel As Integer, ByRef DifficultyValue As Double, ByRef DifficultyOffset As Double, ByRef OverrideOfficialDifficulty As Double)
		  OverrideOfficialDifficulty = Max(Ceil(DesiredDinoLevel / 30), BaseDifficulty)
		  DifficultyOffset = Max((DesiredDinoLevel - 15) / ((OverrideOfficialDifficulty * 30) - 15), 0.001)
		  DifficultyValue = (DifficultyOffset * (OverrideOfficialDifficulty - 0.5)) + 0.5
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ComputeDifficultySettings(MaxDinoLevel As Integer, DinoLevelSteps As Integer, ByRef DifficultyValue As Double, ByRef DifficultyOffset As Double, ByRef OverrideOfficialDifficulty As Double)
		  MaxDinoLevel = Max(MaxDinoLevel, 15)
		  DinoLevelSteps = Max(DinoLevelSteps, 1)
		  DifficultyValue = MaxDinoLevel / 30 
		  OverrideOfficialDifficulty = DinoLevelSteps
		  DifficultyOffset = Max(((MaxDinoLevel / 30) - 0.5) / (DinoLevelSteps - 0.5), 0.01)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ComputeMaxDinoLevel(Offset As Double, Steps As Integer) As Integer
		  Dim DifficultyValue As Double = (Offset * (Steps - 0.5)) + 0.5
		  Return DifficultyValue * 30
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CRC32(Data As MemoryBlock) As UInt32
		  dim crcg, c, t, x,b as uint32
		  dim ch as uint8
		  crcg = &hffffffff
		  c = Data.Size - 1
		  
		  for x=0 to c
		    ch = data.uint8value(x)
		    
		    t = (crcg and &hFF) xor ch
		    
		    for b=0 to 7
		      if( (t and &h1) = &h1) then
		        t = Bitwise.ShiftRight(t, 1) xor &hEDB88320
		      else
		        t = Bitwise.ShiftRight(t, 1)
		      end if
		    next
		    crcg = Bitwise.ShiftRight(crcg, 8) xor t
		  next
		  
		  crcg = crcg Xor &hFFFFFFFF
		  return crcg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateUUID() As String
		  Dim Id As MemoryBlock = Crypto.GenerateRandomBytes(16)
		  Dim Value As UInt8
		  
		  Value = Id.UInt8Value(6)
		  Value = Value And CType(&b00001111, UInt8)
		  Value = Value Or CType(&b01000000, UInt8)
		  Id.UInt8Value(6) = Value
		  
		  Value = Id.UInt8Value(8)
		  Value = Value And CType(&b00111111, UInt8)
		  Value = Value Or CType(&b10000000, UInt8)
		  Id.UInt8Value(8) = Value
		  
		  Dim Chars As String = EncodeHex(Id).Lowercase
		  Return Chars.SubString(0, 8) + "-" + Chars.SubString(8, 4) + "-" + Chars.SubString(12, 4) + "-" + Chars.SubString(16, 4) + "-" + Chars.SubString(20, 12)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Data() As Beacon.DataSource
		  Return mDataSource
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Data(Assigns Value As Beacon.DataSource)
		  If mDataSource <> Value Then
		    mDataSource = Value
		    mDataSource.LoadPresets
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DetectLineEnding(Extends Source As String) As String
		  Const CR = &u0D
		  Const LF = &u0A
		  
		  If Source.InStr(CR + LF) > 0 Then
		    Return CR + LF
		  ElseIf Source.InStr(CR) > 0 Then
		    Return CR
		  Else
		    Return LF
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DictionaryValue(Extends Dict As Dictionary, Key As Variant, Default As Dictionary, AllowArray As Boolean = True) As Dictionary
		  Dim Value As Variant = Dict.Lookup(Key, Default)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  If Value.IsArray Then
		    If Not AllowArray Then
		      Return Default
		    End If
		    
		    Select Case Value.ArrayElementType
		    Case Variant.TypeObject
		      Dim Temp As Auto = Value
		      Dim Objects() As Object = Temp
		      For I As Integer = Objects.Ubound DownTo 0
		        Dim Obj As Variant = Objects(I)
		        If Obj <> Nil And Obj.Type = Variant.TypeObject And Obj IsA Dictionary Then
		          Return Dictionary(Obj.ObjectValue)
		        End If
		      Next
		      Return Default
		    Else
		      Return Default
		    End Select
		  End If
		  
		  If Value.Type = Variant.TypeObject And Value IsA Dictionary Then
		    Return Dictionary(Value.ObjectValue)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DifficultyOffset(Value As Double, Scale As Double) As Double
		  Return Min((Value - 0.5) / (Scale - 0.5), 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyScale(Extends Maps() As Beacon.Map) As Double
		  Dim Scale As Double
		  For Each Map As Beacon.Map In Maps
		    Scale = Max(Scale, Map.DifficultyScale)
		  Next
		  Return Scale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DifficultyValue(Offset As Double, Scale As Double) As Double
		  Offset = Max(Offset, 0.0001)
		  Return (Offset * (Scale - 0.5)) + 0.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleValue(Extends Dict As Dictionary, Key As Variant, Default As Double = 0.0, AllowArray As Boolean = True) As Double
		  Dim Value As Variant = Dict.Lookup(Key, Default)
		  If Value = Nil Then
		    Return Default
		  End If
		  
		  If Value.IsArray Then
		    If Not AllowArray Then
		      Return Default
		    End If
		    
		    Select Case Value.ArrayElementType
		    Case Variant.TypeDouble
		      Dim Doubles() As Double = Value
		      If Doubles.Ubound > -1 Then
		        Return Doubles(Doubles.Ubound)
		      Else
		        Return Default
		      End If
		    Case Variant.TypeObject
		      Dim Temp As Auto = Value
		      Dim Objects() As Object = Temp
		      For I As Integer = Objects.Ubound DownTo 0
		        Dim Obj As Variant = Objects(I)
		        #Pragma BreakOnExceptions False
		        Try
		          Return Obj.DoubleValue
		        Catch Err As TypeMismatchException
		        End Try
		        #Pragma BreakOnExceptions Default
		      Next
		      Return Default
		    Case Variant.TypeInt32
		      Dim Integers() As Int32 = Value
		      If Integers.Ubound > -1 Then
		        Return Integers(Integers.Ubound)
		      Else
		        Return Default
		      End If
		    Case Variant.TypeInt64
		      Dim Integers() As Int64 = Value
		      If Integers.Ubound > -1 Then
		        Return Integers(Integers.Ubound)
		      Else
		        Return Default
		      End If
		    Else
		      Return Default
		    End Select
		  End If
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Return Value.DoubleValue
		  Catch Err As TypeMismatchException
		    Return Default
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateJSON(Source As Variant, Pretty As Boolean = False) As String
		  Dim Options As UInt64
		  If Pretty Then
		    Options = Options Or JSONPretty
		  End If
		  Return GenerateJSON(Source, Options)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateJSON(Source As Variant, Options As UInt64) As String
		  If (Options And JSONCompressed) = JSONCompressed Or (Options And JSONBase64) = JSONBase64 Then
		    Options = Options And Not JSONPretty // If formatted, disable pretty
		  End If
		  
		  Dim Node As JSONMBS = JSONMBS.Convert(Source)
		  Dim JSON As String = Node.ToString((Options And JSONPretty) = JSONPretty)
		  
		  If (Options And JSONCompressed) = JSONCompressed Then
		    Dim Compressor As New _GZipString
		    Compressor.UseHeaders = True
		    
		    JSON = Compressor.Compress(JSON)
		  End If
		  
		  If (Options And JSONBase64) = JSONBase64 Then
		    JSON = EncodeBase64(JSON)
		  End If
		  
		  Return JSON
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function GlobalPosition(Extends Target As Window) As REALbasic.Point
		  Dim Left As Integer = Target.Left
		  Dim Top As Integer = Target.Top
		  
		  While Target IsA ContainerControl
		    Target = ContainerControl(Target).Window
		    Left = Left + Target.Left
		    Top = Top + Target.Top
		  Wend
		  
		  Return New REALbasic.Point(Left, Top)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GuessEncoding(Extends Value As String) As String
		  // This function will check for UTF-8 and UTF-16 Byte Order Marks,
		  // remove them, and convert to UTF-8.
		  
		  If Value.LeftB(3) = Encodings.ASCII.Chr(239) + Encodings.ASCII.Chr(187) + Encodings.ASCII.Chr(191) Then
		    // The rare UTF-8 BOM
		    Return Value.DefineEncoding(Encodings.UTF8).MidB(4)
		  ElseIf Value.LeftB(2) = Encodings.ASCII.Chr(254) + Encodings.ASCII.Chr(255) Then
		    // Confirmed UTF-16 BE
		    Return Value.DefineEncoding(Encodings.UTF16BE).MidB(3).ConvertEncoding(Encodings.UTF8)
		  ElseIf Value.LeftB(2) = Encodings.ASCII.Chr(255) + Encodings.ASCII.Chr(254) Then
		    // Confirmed UTF-16 LE
		    Return Value.DefineEncoding(Encodings.UTF16LE).MidB(3).ConvertEncoding(Encodings.UTF8)
		  Else
		    // Ok, now we need to get fancy. It's a safe bet that all files contain a "/script/" string, right?
		    // Let's interpret the file as each of the 3 and see which one matches.
		    
		    Const TestValue = "/script/"
		    Static EncodingsList() As TextEncoding
		    If EncodingsList.Ubound = -1 Then
		      EncodingsList = Array(Encodings.UTF8, Encodings.UTF16LE, Encodings.UTF16BE)
		      Dim Bound As Integer = Encodings.Count - 1
		      For I As Integer = 0 To Bound
		        Dim Encoding As TextEncoding = Encodings.Item(I)
		        If EncodingsList.IndexOf(Encoding) = -1 Then
		          EncodingsList.Append(Encoding)
		        End If
		      Next
		    End If
		    
		    For Each Encoding As TextEncoding In EncodingsList
		      Dim TestVersion As String = Value.DefineEncoding(Encoding)
		      If TestVersion.InStr(TestValue) > 0 Then
		        Return TestVersion.ConvertEncoding(Encodings.UTF8)
		      End If
		    Next
		    
		    // Who knows what the heck it could be, so it's ASCII now.
		    Return Value.DefineEncoding(Encodings.ASCII).ConvertEncoding(Encodings.UTF8)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HardwareID() As String
		  #if TargetDesktop
		    Dim Root As Global.FolderItem = Volume(0)
		    If Root = Nil Or Root.Exists = False Then
		      // What the hell is this?
		      Return ""
		    End If
		    
		    Dim Created As Date = Root.CreationDate
		    If Created = Nil Then
		      // Seriously?
		      Return ""
		    End If
		    Created.GMTOffset = 0
		    
		    Return EncodeHex(Crypto.SHA256(Str(Created.TotalSeconds, "-0"))).Lowercase
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBeaconURL(ByRef Value As String) As Boolean
		  Dim PossiblePrefixes() As String
		  PossiblePrefixes.Append(Beacon.URLScheme + "://")
		  PossiblePrefixes.Append("https://app.beaconapp.cc/")
		  
		  Dim URLLength As Integer = Value.Length
		  For Each PossiblePrefix As String In PossiblePrefixes
		    Dim PrefixLength As Integer = PossiblePrefix.Length
		    If URLLength > PrefixLength And Value.Left(PrefixLength) = PossiblePrefix Then
		      Value = Value.SubString(PrefixLength)
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Extends Maps() As Beacon.Map) As String
		  Dim Names() As String
		  For Each Map As Beacon.Map In Maps
		    Names.Append(Map.Name)
		  Next
		  
		  
		  If Names.Ubound = 0 Then
		    Return Names(0)
		  ElseIf Names.Ubound = 1 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Dim Tail As String = Names(Names.Ubound)
		    Names.Remove(Names.Ubound)
		    Return Join(Names, ", ") + ", & " + Tail
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask(Extends Maps() As Beacon.Map) As UInt64
		  Dim Bits As UInt64
		  For Each Map As Beacon.Map In Maps
		    Bits = Bits Or Map.Mask
		  Next
		  Return Bits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MD5(Value As String) As String
		  Return EncodeHex(Crypto.MD5(Value)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseJSON(Content As String) As Variant
		  Static GZIPHeader As String
		  If GZIPHeader = "" Then
		    GZIPHeader = Encodings.ASCII.Chr(&h1F) + Encodings.ASCII.Chr(&h8B)
		  End If
		  
		  Static Detector As RegEx
		  If Detector = Nil Then
		    Detector = New RegEx
		    Detector.SearchPattern = "^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$"
		  End If
		  
		  If Len(Content) Mod 4 = 0 And Detector.Search(Content) <> Nil Then
		    Content = DecodeBase64(Content)
		  End If
		  
		  If Content.BeginsWith(GZIPHeader) Then
		    Dim Compressor As New _GZipString
		    Content = Compressor.Decompress(Content)
		  End If
		  
		  Dim Node As New JSONMBS(Content)
		  If Not Node.Valid Then
		    Dim Err As New UnsupportedFormatException
		    Err.Message = "Supplied string is not a valid JSON structure"
		    Raise Err
		  End If
		  Return Node.Convert
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyString(Value As Double, DecimalPlaces As Integer = 6) As String
		  Dim Multiplier As UInteger = 1
		  Dim Places As Integer = 0
		  Dim Format As String = "0"
		  
		  While Places < DecimalPlaces
		    Dim TestValue As Double = Value * Multiplier
		    If Floor(TestValue) = TestValue Then
		      Exit
		    End If
		    Multiplier = Multiplier * 10
		    Format = Format + "0"
		    Places = Places + 1
		  Wend
		  
		  If Format.Length > 1 Then
		    Format = Format.Left(1) + "." + Format.SubString(1)
		  End If
		  
		  Dim RoundedValue As Double = Round(Value * Multiplier) / Multiplier
		  Return Str(RoundedValue, Format)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyString(Extends Value As Double, DecimalPlaces As Integer = 6) As String
		  Return PrettyString(Value, DecimalPlaces)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RewriteIniContent(InitialContent As String, NewConfigs As Dictionary, WithMarkup As Boolean = True) As String
		  Const StandardizeLineEnding = &u10
		  
		  // First, normalize line endings
		  Dim EOL As String = InitialContent.DetectLineEnding
		  InitialContent = ReplaceLineEndings(InitialContent, StandardizeLineEnding)
		  
		  // So that we can make changes without changing the input
		  NewConfigs = Beacon.Clone(NewConfigs)
		  
		  // Organize all existing content
		  Dim Lines() As String = Split(InitialContent, StandardizeLineEnding)
		  Dim UntouchedConfigs As New Dictionary
		  Dim LastGroupHeader As String
		  For I As Integer = 0 To Lines.Ubound
		    Dim Line As String = Trim(Lines(I))
		    If Line.Length = 0 Then
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      // This is a group header
		      LastGroupHeader = Line.Mid(1, Line.Length - 2)
		      Continue
		    End If
		    
		    Dim SectionDict As Dictionary
		    If UntouchedConfigs.HasKey(LastGroupHeader) Then
		      SectionDict = UntouchedConfigs.Value(LastGroupHeader)
		    Else
		      SectionDict = New Dictionary
		    End If
		    
		    Dim KeyPos As Integer = Line.IndexOf("=")
		    If KeyPos = -1 Then
		      Continue
		    End If
		    
		    Dim Key As String = Line.Left(KeyPos)
		    Dim ModifierPos As Integer = Key.IndexOf("[")
		    If ModifierPos > -1 Then
		      Key = Key.Left(ModifierPos)
		    End If
		    
		    If NewConfigs.HasKey(LastGroupHeader) Then
		      Dim NewConfigSection As Dictionary = NewConfigs.Value(LastGroupHeader)
		      If NewConfigSection.HasKey(Key) Then
		        // This key is being overridden by Beacon
		        Continue
		      End If
		    End If
		    
		    Dim ConfigLines() As String
		    If SectionDict.HasKey(Key) Then
		      ConfigLines = SectionDict.Value(Key)
		    End If
		    ConfigLines.Append(Line)
		    SectionDict.Value(Key) = ConfigLines
		    UntouchedConfigs.Value(LastGroupHeader) = SectionDict
		  Next
		  
		  Dim AllSectionHeaders() As String
		  Dim UntouchedConfigKeys() As Variant = UntouchedConfigs.Keys
		  For Each UntouchedConfigKey As Variant In UntouchedConfigKeys
		    AllSectionHeaders.Append(UntouchedConfigKey)
		  Next
		  Dim NewConfigKeys() As Variant = NewConfigs.Keys
		  For Each NewConfigKey As Variant In NewConfigKeys
		    If AllSectionHeaders.IndexOf(NewConfigKey) = -1 Then
		      AllSectionHeaders.Append(NewConfigKey)
		    End If
		  Next
		  
		  // Figure out which keys are managed by Beacon so they can be removed
		  If UntouchedConfigs.HasKey("Beacon") Then
		    // Generated by a version of Beacon that includes its own config section
		    Dim BeaconDict As Dictionary = UntouchedConfigs.Value("Beacon")
		    Dim BeaconGroupVersion As Integer = 10103300
		    If BeaconDict.HasKey("Build") Then
		      Dim BuildLines() As String = BeaconDict.Value("Build")
		      Dim BuildLine As String = BuildLines(0)
		      Dim ValuePos As Integer = BuildLine.IndexOf("=") + 1
		      Dim Value As String = BuildLine.SubString(ValuePos)
		      If Value.BeginsWith("""") And Value.EndsWith("""") Then
		        Value = Value.SubString(1, Value.Length - 2)
		      End If
		      BeaconGroupVersion = Val(Value)
		    End If
		    
		    If BeaconDict.HasKey("ManagedKeys") Then
		      Dim ManagedKeyLines() As String = BeaconDict.Value("ManagedKeys")
		      For Each KeyLine As String In ManagedKeyLines
		        Dim Header, ArrayTextContent As String
		        
		        If BeaconGroupVersion > 10103300 Then
		          Dim HeaderStartPos As Integer = KeyLine.IndexOf(13, "Section=""") + 9
		          Dim HeaderEndPos As Integer = KeyLine.IndexOf(HeaderStartPos, """")
		          Header = KeyLine.Mid(HeaderStartPos, HeaderEndPos - HeaderStartPos)
		          If Not UntouchedConfigs.HasKey(Header) Then
		            Continue
		          End If
		          
		          Dim ArrayStartPos As Integer = KeyLine.IndexOf(13, "Keys=(") + 6
		          Dim ArrayEndPos As Integer = KeyLine.IndexOf(ArrayStartPos, ")")
		          ArrayTextContent = KeyLine.SubString(ArrayStartPos, ArrayEndPos - ArrayStartPos)
		        Else
		          Dim HeaderPos As Integer = KeyLine.IndexOf("['") + 2
		          Dim HeaderEndPos As Integer = KeyLine.IndexOf(HeaderPos, "']")
		          Header = KeyLine.SubString(HeaderPos, HeaderEndPos - HeaderPos)
		          If Not UntouchedConfigs.HasKey(Header) Then
		            Continue
		          End If
		          
		          Dim ArrayPos As Integer = KeyLine.IndexOf(HeaderEndPos, "(") + 1
		          Dim ArrayEndPos As Integer = KeyLine.IndexOf(ArrayPos, ")")
		          ArrayTextContent = KeyLine.SubString(ArrayPos, ArrayEndPos - ArrayPos)
		        End If
		        
		        Dim ManagedKeys() As String = ArrayTextContent.Split(",")
		        Dim SectionContents As Dictionary = UntouchedConfigs.Value(Header)
		        For Each ManagedKey As String In ManagedKeys
		          If SectionContents.HasKey(ManagedKey) Then
		            SectionContents.Remove(ManagedKey)
		          End If
		        Next
		        If SectionContents.Count = 0 Then
		          UntouchedConfigs.Remove(Header)
		        End If
		      Next
		    End If
		    If UntouchedConfigs.HasKey("Beacon") Then
		      UntouchedConfigs.Remove("Beacon")
		    End If
		    AllSectionHeaders.Remove(AllSectionHeaders.IndexOf("Beacon"))
		  Else
		    // We'll need to use the legacy style of removing only what is being replaced
		    NewConfigKeys = NewConfigs.Keys // Probably unchanged from before, but let's be sure
		    For Each Header As Variant In NewConfigKeys
		      If Not UntouchedConfigs.HasKey(Header) Then
		        Continue
		      End If
		      
		      Dim OldContents As Dictionary = UntouchedConfigs.Value(Header)
		      Dim NewContents As Dictionary = NewConfigs.Value(Header)
		      Dim NewContentKeys() As Variant = NewContents.Keys
		      For Each NewContentKey As Variant In NewContentKeys
		        If OldContents.HasKey(NewContentKey) Then
		          OldContents.Remove(NewContentKey)
		        End If
		      Next
		      If OldContents.Count = 0 Then
		        UntouchedConfigs.Remove(Header)
		      End If
		    Next
		  End If
		  
		  // Setup the Beacon section
		  If WithMarkup Then
		    Dim BeaconKeys As New Dictionary
		    NewConfigKeys = NewConfigs.Keys
		    For Each Header As Variant In NewConfigKeys
		      Dim Keys() As String
		      If BeaconKeys.HasKey(Header) Then
		        Keys = BeaconKeys.Value(Header)
		      End If
		      
		      Dim Dict As Dictionary = NewConfigs.Value(Header)
		      Dim DictKeys() As Variant = Dict.Keys
		      For Each DictKey As Variant In DictKeys
		        If Keys.IndexOf(DictKey) = -1 Then
		          Keys.Append(DictKey)
		        End If
		      Next
		      
		      BeaconKeys.Value(Header) = Keys
		    Next
		    If BeaconKeys.Count > 0 Then
		      Dim BeaconDict As New Dictionary
		      Dim BeaconKeysArray() As Variant = BeaconKeys.Keys
		      For Each Header As Variant In BeaconKeysArray
		        Dim Keys() As String = BeaconKeys.Value(Header)
		        Dim SectionLines() As String
		        If BeaconDict.HasKey("ManagedKeys") Then
		          SectionLines = BeaconDict.Value("ManagedKeys")
		        End If
		        SectionLines.Append("ManagedKeys=(Section=""" + Header + """,Keys=(" + Join(Keys, ",") + "))")
		        BeaconDict.Value("ManagedKeys") = SectionLines
		      Next
		      BeaconDict.Value("Build") = Array("Build=" + Str(App.BuildNumber, "-0"))
		      AllSectionHeaders.Append("Beacon")
		      NewConfigs.Value("Beacon") = BeaconDict
		    End If
		  End If
		  
		  // Build an ini file
		  Dim NewLines() As String
		  AllSectionHeaders.Sort
		  For Each Header As String In AllSectionHeaders
		    If NewLines.Ubound > -1 Then
		      NewLines.Append("")
		    End If
		    NewLines.Append("[" + Header + "]")
		    
		    If UntouchedConfigs.HasKey(Header) Then
		      Dim Section As Dictionary = UntouchedConfigs.Value(Header)
		      Dim SectionKeys() As Variant = Section.Keys
		      For Each SectionKey As Variant In SectionKeys
		        Dim Values() As String = Section.Value(SectionKey)
		        For Each Line As String In Values
		          NewLines.Append(Line)
		        Next
		      Next
		    End If
		    
		    If NewConfigs.HasKey(Header) Then
		      Dim Section As Dictionary = NewConfigs.Value(Header)
		      Dim SectionKeys() As Variant = Section.Keys
		      For Each SectionKey As Variant In SectionKeys
		        Dim Values() As String = Section.Value(SectionKey)
		        For Each Line As String In Values
		          NewLines.Append(Line)
		        Next
		      Next
		    End If
		  Next
		  
		  Return Join(NewLines, EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SanitizeFilename(Filename As String) As String
		  Filename = Filename.ReplaceAll("/", "-")
		  Filename = Filename.ReplaceAll("\", "-")
		  Filename = Filename.ReplaceAll(":", "-")
		  Filename = Filename.ReplaceAll("""", "")
		  Filename = Filename.ReplaceAll("<", "")
		  Filename = Filename.ReplaceAll(">", "")
		  Filename = Filename.ReplaceAll("|", "")
		  Return Filename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(Extends Source As Beacon.DataSource, SearchText As String, Mods As Beacon.StringList) As Beacon.Engram()
		  Dim Tags() As String
		  Return Source.SearchForEngrams(SearchText, Mods, Tags)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SHA512(Value As String) As String
		  Return EncodeHex(Crypto.SHA512(Value)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Sources() As Beacon.LootSource)
		  Dim Bound As Integer = Sources.Ubound
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Dim Order() As Integer
		  Redim Order(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Sources(I).SortValue
		  Next
		  
		  Order.SortWith(Sources)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Qualities() As Beacon.Quality)
		  Dim Bound As Integer = Qualities.Ubound
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Dim Order() As Double
		  Redim Order(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Qualities(I).BaseValue
		  Next
		  
		  Order.SortWith(Qualities)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound(Item As Beacon.Countable) As Integer
		  Return Item.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound(Extends Item As Beacon.Countable) As Integer
		  Return Item.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function URLDecode(Value As String) As String
		  Return DefineEncoding(DecodeURLComponent(Value.ReplaceAll("+", " ")), Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLEncode(Value As String) As String
		  Return EncodeURLComponent(Value).ReplaceAll(" ", "%20")
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function URLHandler(URL As String) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function WebURL(Path As String = "/") As String
		  #if DebugBuild
		    Dim Domain As String = "https://workbench.beaconapp.cc"
		  #else
		    Dim Domain As String = "https://beaconapp.cc"
		  #endif
		  If Path.Length = 0 Or Path.BeginsWith("/") = False Then
		    Path = "/" + Path
		  End If
		  Return Domain + Path
		End Function
	#tag EndMethod


	#tag Note, Name = Difficulty
		OverrideOfficialDifficulty determines the steps dino levels will take. For example, when set to 5.0,
		you will see levels 5, 10, 15, 20. When set to 10, levels will be 10, 20, 30, 40.
		
		This means computing the correct difficulty offset requires both the max dino level and the dino level
		step value.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mDataSource As Beacon.DataSource
	#tag EndProperty


	#tag Constant, Name = JSONBase64, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = JSONCompressed, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = JSONPretty, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RewriteModeGameIni, Type = Text, Dynamic = False, Default = \"Game.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RewriteModeGameUserSettingsIni, Type = Text, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ServerSettingsHeader, Type = Text, Dynamic = False, Default = \"ServerSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ShooterGameHeader, Type = Text, Dynamic = False, Default = \"/script/shootergame.shootergamemode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = URLScheme, Type = Text, Dynamic = False, Default = \"beacon", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
