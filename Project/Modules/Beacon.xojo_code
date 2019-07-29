#tag Module
Protected Module Beacon
	#tag Method, Flags = &h0
		Sub AddTag(Extends Blueprint As Beacon.MutableBlueprint, ParamArray TagsToAdd() As String)
		  Blueprint.AddTags(TagsToAdd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTags(Extends Blueprint As Beacon.MutableBlueprint, TagsToAdd() As String)
		  Dim Tags() As String = Blueprint.Tags
		  Dim Changed As Boolean
		  For I As Integer = 0 To TagsToAdd.LastRowIndex
		    Dim Tag As String  = Beacon.NormalizeTag(TagsToAdd(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    If Tags.IndexOf(Tag) <> -1 Then
		      Continue
		    End If
		    
		    Tags.Append(Tag)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  Tags.Sort
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AutoArrayValue(Extends Dict As Dictionary, Key As String) As Variant()
		  Dim Entries() As Variant
		  If Dict.HasKey(Key) Then
		    Dim Value As Variant = Dict.Value(Key)
		    Dim Info As Introspection.TypeInfo = Introspection.GetType(Value)
		    If Info.FullName = "Auto()" Then
		      Entries = Value
		    Else
		      Entries.Append(Value)
		    End If
		  End If
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BooleanValue(Extends Dict As Dictionary, Key As Variant, Default As Boolean, AllowArray As Boolean = False) As Boolean
		  Return GetValueAsType(Dict, Key, "Boolean", Default, AllowArray, AddressOf CoerceToBoolean)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends Source As DateInterval) As DateInterval
		  Return New DateInterval(Source.Years, Source.Months, Source.Days, Source.Hours, Source.Minutes, Source.Seconds, Source.NanoSeconds)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CoerceToBoolean(ByRef Value As Variant, Info As Introspection.TypeInfo) As Boolean
		  Select Case Info.FullName
		  Case "Boolean"
		    Return True
		  Case "Text"
		    Dim TextValue As String = Value
		    Value = If(TextValue = "true", True, False)
		    Return True
		  Case "String"
		    Dim StringValue As String = Value
		    Value = If(StringValue = "true", True, False)
		    Return True
		  Case "Integer"
		    Dim IntegerValue As Integer = Value
		    Value = If(IntegerValue >= 1, True, False)
		    Return True
		  Case "Double"
		    Dim DoubleValue As Double = Value
		    Value = If(DoubleValue >= 1, True, False)
		    Return True
		  Else
		    #Pragma BreakOnExceptions False
		    Try
		      Dim VariantValue As Variant = Value
		      Value = VariantValue.BooleanValue
		      Return True
		    Catch Err As TypeMismatchException
		      Return False
		    End Try
		    #Pragma BreakOnExceptions Default
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CoerceToDouble(ByRef Value As Variant, Info As Introspection.TypeInfo) As Boolean
		  #Pragma Unused Info
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Dim DoubleValue As Double = Value
		    Value = DoubleValue
		    Return True
		  Catch Err As TypeMismatchException
		    Return False
		  End Try
		  #Pragma BreakOnExceptions Default
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
		  Try
		    Dim crcg, c, t, x,b As UInt32
		    Dim ch As UInt8
		    crcg = &hffffffff
		    c = Data.Size - 1
		    
		    For x=0 To c
		      ch = Data.UInt8Value(x)
		      
		      t = (crcg And &hFF) Xor ch
		      
		      For b=0 To 7
		        If( (t And &h1) = &h1) Then
		          t = Beacon.ShiftRight(t, 1) Xor &hEDB88320
		        Else
		          t = Beacon.ShiftRight(t, 1)
		        End If
		      Next
		      crcg = Beacon.ShiftRight(crcg, 8) Xor t
		    Next
		    
		    crcg = crcg Xor &hFFFFFFFF
		    Return crcg
		  Catch Err As RuntimeException
		    Return 0
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateCSV(Blueprints() As Beacon.Blueprint) As String
		  Dim Columns(4) As String
		  Columns(0) = """Path"""
		  Columns(1) = """Label"""
		  Columns(2) = """Availability Mask"""
		  Columns(3) = """Tags"""
		  Columns(4) = """Group"""
		  
		  Dim Lines(0) As String
		  Lines(0) = Join(Columns, ",")
		  
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    Columns(0) = """" + Blueprint.Path + """"
		    Columns(1) = """" + Blueprint.Label + """"
		    Columns(2) = Blueprint.Availability.ToString(Locale.Raw)
		    Columns(3) = """" + Blueprint.Tags.Join(",") + """"
		    Columns(4) = """" + Blueprint.Category + """"
		    Lines.Append(Join(Columns, ","))
		  Next
		  
		  Return Join(Lines, Encodings.ASCII.Chr(13) + Encodings.ASCII.Chr(10))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateUUID(Bytes As MemoryBlock = Nil) As String
		  If Bytes = Nil Or Bytes.Size <> 16 Then
		    Bytes = Crypto.GenerateRandomBytes(16)
		  End If
		  Dim Id As MemoryBlock = Bytes.StringValue(0, Bytes.Size)
		  Dim Value As UInt8
		  
		  Value = Id.UInt8Value(6)
		  Value = Value And CType(&b00001111, UInt8)
		  Value = Value Or CType(&b01000000, UInt8)
		  Id.UInt8Value(6) = Value
		  
		  Value = Id.UInt8Value(8)
		  Value = Value And CType(&b00111111, UInt8)
		  Value = Value Or CType(&b10000000, UInt8)
		  Id.UInt8Value(8) = Value
		  
		  Dim Chars() As String
		  For I As Integer = 0 To Id.Size - 1
		    Chars.Append(Id.UInt8Value(I).ToHex(2))
		  Next
		  
		  Chars.Insert(10, "-")
		  Chars.Insert( 8, "-")
		  Chars.Insert( 6, "-")
		  Chars.Insert( 4, "-")
		  
		  Return Join(Chars, "").Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creatures(Extends Blueprints() As Beacon.Blueprint) As Beacon.Creature()
		  Dim Creatures() As Beacon.Creature
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Creature Then
		      Creatures.Append(Beacon.Creature(Blueprint))
		    End If
		  Next
		  Return Creatures
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
		Function DictionaryValue(Extends Dict As Dictionary, Key As Variant, Default As Dictionary, AllowArray As Boolean = False) As Dictionary
		  Return GetValueAsType(Dict, Key, "Dictionary", Default, AllowArray)
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
		Function DoubleValue(Extends Dict As Dictionary, Key As Variant, Default As Double, AllowArray As Boolean = False) As Double
		  Return GetValueAsType(Dict, Key, "Double", Default, AllowArray, AddressOf CoerceToDouble)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams(Extends Blueprints() As Beacon.Blueprint) As Beacon.Engram()
		  Dim Engrams() As Beacon.Engram
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Engram Then
		      Engrams.Append(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateJSON(Source As Variant, Pretty As Boolean) As String
		  Const UseMBS = True
		  
		  #if Not DebugBuild
		    #Pragma Error "This method needs to be finished"
		  #endif
		  
		  #if UseMBS
		    Dim Temp As JSONMBS = JSONMBS.Convert(Source)
		    Return Temp.ToString(Pretty)
		  #else
		    Return Xojo.GenerateJSON(Source)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetLastValueAsType(Values() As Variant, FullName As String, Default As Variant) As Variant
		  For I As Integer = Values.LastRowIndex DownTo 0
		    Dim Info As Introspection.TypeInfo = Introspection.GetType(Values(I))
		    If Info.FullName = FullName Then
		      Return Values(I)
		    End If
		  Next
		  Return Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetValueAsType(Dict As Dictionary, Key As Variant, FullName As String, Default As Variant, AllowArray As Boolean = False, Adapter As ValueAdapter = Nil) As Variant
		  If Not Dict.HasKey(Key) Then
		    Return Default
		  End If
		  
		  Dim Value As Variant = Dict.Value(Key)
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Value)
		  If Info = Nil Then
		    Return Default
		  End If
		  If Info.FullName = "Auto()" And AllowArray Then
		    Dim Arr() As Variant = Value
		    Return GetLastValueAsType(Arr, FullName, Default)
		  ElseIf Info.FullName = FullName Then
		    Return Value
		  ElseIf Adapter <> Nil Then
		    If Adapter.Invoke(Value, Info) Then
		      Return Value
		    Else
		      Return Default
		    End If
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function GlobalPosition(Extends Target As Window) As Point
		  Dim Left As Integer = Target.Left
		  Dim Top As Integer = Target.Top
		  
		  While Target IsA ContainerControl
		    Target = ContainerControl(Target).Window
		    Left = Left + Target.Left
		    Top = Top + Target.Top
		  Wend
		  
		  Return New Point(Left, Top)
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
		    If EncodingsList.LastRowIndex = -1 Then
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
		    Created = New Date(Created.SecondsFrom1970, New TimeZone(0))
		    
		    Return REALbasic.EncodeHex(Crypto.SHA256(Str(Created.SecondsFrom1970 + 2082844800, "-0"))).Lowercase
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function Hash(Block As MemoryBlock) As String
		  Return REALbasic.EncodeHex(Crypto.SHA512(Block)).DefineEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IntervalToString(Interval As DateInterval) As String
		  Dim Parts() As String
		  If Interval.Years > 0 Then
		    Parts.Append(Str(Interval.Years, "-0") + "y")
		  End If
		  If Interval.Months > 0 Then
		    Parts.Append(Str(Interval.Months, "-0") + "m")
		  End If
		  If Interval.Days > 0 Then
		    Parts.Append(Str(Interval.Days, "-0") + "d")
		  End If
		  If Interval.Hours > 0 Then
		    Parts.Append(Str(Interval.Hours, "-0") + "h")
		  End If
		  If Interval.Minutes > 0 Then
		    Parts.Append(Str(Interval.Minutes, "-0") + "m")
		  End If
		  If Interval.Seconds > 0 Then
		    Parts.Append(Str(Interval.Seconds, "-0") + "s")
		  End If
		  Return Join(Parts, " ")
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
		      Value = Value.Middle(PrefixLength)
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
		  
		  If Names.LastRowIndex = -1 Then
		    Return "No Maps"
		  ElseIf Names.LastRowIndex = 0 Then
		    Return Names(0)
		  ElseIf Names.LastRowIndex = 1 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Dim Tail As String = Names(Names.LastRowIndex)
		    Names.Remove(Names.LastRowIndex)
		    Return Join(Names, ", ") + ", & " + Tail
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelFromClassString(ClassString As String) As String
		  Dim Parts() As String = Split(ClassString, "_")
		  If Parts.LastRowIndex <= 1 Then
		    Return ClassString
		  End If
		  If ClassString.IndexOf("PrimalItem") > -1 Then
		    Parts.Remove(0)
		    Parts.Remove(Parts.LastRowIndex)
		  ElseIf ClassString.IndexOf("Character") > -1 Then
		    For I As Integer = Parts.LastRowIndex DownTo 0
		      If Parts(I) = "C" Or Parts(I) = "BP" Or Parts(I) = "Character" Then
		        Parts.Remove(I)
		      End If
		    Next
		  End If
		  Return Beacon.MakeHumanReadable(Join(Parts, " "))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex(Extends Target As Beacon.Countable) As Integer
		  Return Target.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeHumanReadable(Source As String) As String
		  Dim Chars() As String
		  Dim SourceChars() As String = Source.Split("")
		  For Each Char As String In SourceChars
		    Dim Codepoint As Integer = Asc(Char)
		    If Codepoint = 32 Or (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 97 And Codepoint <= 122) Then
		      Chars.Append(Char)
		    ElseIf CodePoint >= 65 And Codepoint <= 90 Then
		      Chars.Append(" ")
		      Chars.Append(Char)
		    ElseIf CodePoint = 95 Then
		      Chars.Append(" ")
		    End If
		  Next
		  Source = Chars.Join("")
		  
		  While Source.IndexOf("  ") > -1
		    Source = Source.ReplaceAll("  ", " ")
		  Wend
		  
		  Return Source.Trim
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
		Protected Function MD5(Value As MemoryBlock) As String
		  Return EncodeHex(Crypto.MD5(Value))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NormalizeTag(Tag As String) As String
		  Dim TagString As String = Tag.Lowercase.Trim
		  
		  Dim Sanitizer As New RegEx
		  Sanitizer.Options.ReplaceAllMatches = True
		  Sanitizer.SearchPattern = "\s+"
		  Sanitizer.ReplacementPattern = "_"
		  TagString = Sanitizer.Replace(TagString)
		  
		  Sanitizer.SearchPattern = "[^\w]"
		  Sanitizer.ReplacementPattern = ""
		  TagString = Sanitizer.Replace(TagString)
		  
		  Return TagString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseJSON(Source As String) As Variant
		  Return Xojo.ParseJSON(Source)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double, DecimalPlaces As Integer = 6) As String
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
		    Format = Format.Left(1) + "." + Format.Middle(1)
		  End If
		  
		  Dim RoundedValue As Double = Round(Value * Multiplier) / Multiplier
		  Return RoundedValue.ToString(Locale.Raw, Format)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyText(Extends Value As Double, DecimalPlaces As Integer = 6) As String
		  Return PrettyText(Value, DecimalPlaces)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function PrimaryExtension(Extends Type As FileType) As String
		  Dim Extensions() As String = Split(Type.Extensions, ";")
		  If Extensions.LastRowIndex = -1 Then
		    Return ""
		  End If
		  
		  Dim Extension As String = Extensions(0)
		  If Left(Extension, 1) <> "." Then
		    Extension = "." + Extension
		  End If
		  
		  Return Extension
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTag(Extends Blueprint As Beacon.MutableBlueprint, ParamArray TagsToRemove() As String)
		  Blueprint.RemoveTags(TagsToRemove)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTags(Extends Blueprint As Beacon.MutableBlueprint, TagsToRemove() As String)
		  Dim Tags() As String = Blueprint.Tags
		  Dim Changed As Boolean
		  For I As Integer = 0 To TagsToRemove.LastRowIndex
		    Dim Tag As String  = Beacon.NormalizeTag(TagsToRemove(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    Dim Idx As Integer = Tags.IndexOf(Tag)
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Tags.Remove(Idx)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  // No, you don't need to sort here
		  Blueprint.Tags = Tags
		End Sub
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
		  Filename = Filename.ReplaceAll("*", "")
		  Filename = Filename.ReplaceAll("?", "")
		  Return Filename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForCreatures(Extends Source As Beacon.DataSource, SearchText As String = "", Mods As Beacon.StringList = Nil, Tags As String = "") As Beacon.Creature()
		  If Mods = Nil Then
		    Mods = New Beacon.StringList
		  End If
		  Dim Blueprints() As Beacon.Blueprint = Source.SearchForBlueprints(CategoryCreatures, SearchText, Mods, Tags)
		  Dim Creatures() As Beacon.Creature
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Creature Then
		      Creatures.Append(Beacon.Creature(Blueprint))
		    End If
		  Next
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(Extends Source As Beacon.DataSource, SearchText As String = "", Mods As Beacon.StringList = Nil, Tags As String = "") As Beacon.Engram()
		  If Mods = Nil Then
		    Mods = New Beacon.StringList
		  End If
		  Dim Blueprints() As Beacon.Blueprint = Source.SearchForBlueprints(CategoryEngrams, SearchText, Mods, Tags)
		  Dim Engrams() As Beacon.Engram
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Engram Then
		      Engrams.Append(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondsToInterval(Seconds As UInt64) As DateInterval
		  Return New DateInterval(0, 0, 0, 0, 0, Seconds, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShiftLeft(Value As UInt64, NumBits As UInt64) As UInt64
		  // It is insane that I need to implement this method manually.
		  
		  Return Value * (2 ^ NumBits)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShiftRight(Value As UInt64, NumBits As UInt64) As UInt64
		  // It is insane that I need to implement this method manually.
		  
		  Return Value / (2 ^ NumBits)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Sources() As Beacon.LootSource)
		  Dim Bound As Integer = Sources.LastRowIndex
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
		  Dim Bound As Integer = Qualities.LastRowIndex
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
		Function TagString(Extends Blueprint As Beacon.Blueprint) As String
		  Dim Tags() As String = Blueprint.Tags
		  If Tags.IndexOf("object") = -1 Then
		    Tags.Insert(0, "object")
		  End If
		  Return Join(Tags, ",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Extends Blueprint As Beacon.MutableBlueprint, Assigns Value As String)
		  Dim Tags() As String = Value.Split(",")
		  Dim Idx As Integer = Tags.IndexOf("object")
		  If Idx > -1 Then
		    Tags.Remove(Idx)
		  End If
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function URLHandler(URL As String) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ValidForMap(Extends Blueprint As Beacon.Blueprint, Map As Beacon.Map) As Boolean
		  Return Map = Nil Or Blueprint.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Extends Blueprint As Beacon.MutableBlueprint, Map As Beacon.Map, Assigns Value As Boolean)
		  If Map <> Nil Then
		    Blueprint.ValidForMask(Map.Mask) = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Extends Blueprint As Beacon.Blueprint, Mask As UInt64) As Boolean
		  Return Mask = 0 Or (Blueprint.Availability And Mask) = Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMask(Extends Blueprint As Beacon.MutableBlueprint, Mask As UInt64, Assigns Value As Boolean)
		  Dim Availability As UInt64 = Blueprint.Availability
		  If Value Then
		    Availability = Availability Or Mask
		  Else
		    Availability = Availability And Not Mask
		  End If
		  If Availability <> Blueprint.Availability Then
		    Blueprint.Availability = Availability
		  End If
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function ValueAdapter(ByRef Value As Variant, Info As Introspection . TypeInfo) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function WebURL(Path As String = "/") As String
		  #if DebugBuild
		    Dim Domain As String = "https://lab.beaconapp.cc"
		  #else
		    Dim Domain As String = "https://beaconapp.cc"
		  #endif
		  If Path.Length = 0 Or Path.Left(1) <> "/" Then
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


	#tag Constant, Name = CategoryCreatures, Type = String, Dynamic = False, Default = \"creatures", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryEngrams, Type = String, Dynamic = False, Default = \"engrams", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RewriteModeGameIni, Type = String, Dynamic = False, Default = \"Game.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RewriteModeGameUserSettingsIni, Type = String, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ServerSettingsHeader, Type = String, Dynamic = False, Default = \"ServerSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ShooterGameHeader, Type = String, Dynamic = False, Default = \"/script/shootergame.shootergamemode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = URLScheme, Type = String, Dynamic = False, Default = \"beacon", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
