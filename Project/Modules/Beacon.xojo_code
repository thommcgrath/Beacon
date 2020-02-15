#tag Module
Protected Module Beacon
	#tag Method, Flags = &h0
		Sub AddTag(Extends Blueprint As Beacon.MutableBlueprint, ParamArray TagsToAdd() As String)
		  Blueprint.AddTags(TagsToAdd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTags(Extends Blueprint As Beacon.MutableBlueprint, TagsToAdd() As String)
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToAdd.LastRowIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToAdd(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    If Tags.IndexOf(Tag) <> -1 Then
		      Continue
		    End If
		    
		    Tags.AddRow(Tag)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  Tags.Sort
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AreElementsEqual(Items() As Variant) As Boolean
		  If Items = Nil Or Items.LastRowIndex <= 0 Then
		    Return True
		  End If
		  
		  Var CommonValue As Variant = Items(0)
		  For Idx As Integer = 1 To Items.LastRowIndex
		    If CommonValue <> Items(Idx) Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AutoArrayValue(Extends Dict As Dictionary, Key As String) As Variant()
		  Var Entries() As Variant
		  If Dict.HasKey(Key) Then
		    Var Value As Variant = Dict.Value(Key)
		    If IsNull(Value) = False And Value.IsArray And Value.ArrayElementType = Variant.TypeObject Then
		      Entries = Value
		    Else
		      Entries.AddRow(Value)
		    End If
		  End If
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintFromDictionary(Dict As Dictionary) As Beacon.Blueprint
		  Try
		    Var Blueprint As Beacon.Blueprint = Beacon.Engram.FromDictionary(Dict)
		    If Blueprint <> Nil Then
		      Return Blueprint
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Var Blueprint As Beacon.Blueprint = Beacon.Creature.FromDictionary(Dict)
		    If Blueprint <> Nil Then
		      Return Blueprint
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Var Blueprint As Beacon.Blueprint = Beacon.SpawnPoint.FromDictionary(Dict)
		    If Blueprint <> Nil Then
		      Return Blueprint
		    End If
		  Catch Err As RuntimeException
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BooleanValue(Extends Dict As Dictionary, Key As Variant, Default As Boolean, AllowArray As Boolean = False) As Boolean
		  Return GetValueAsType(Dict, Key, "Boolean", Default, AllowArray, AddressOf CoerceToBoolean)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Categories() As String()
		  Return Array(CategoryEngrams, CategoryCreatures, CategorySpawnPoints)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ClassStringFromPath(Path As String) As String
		  If Path.Length > 6 And Path.Left(6) = "/Game/" Then
		    If Path.Right(2) = "_C" Then
		      // Appears to be a BlueprintGeneratedClass Path
		      Path = Path.Left(Path.Length - 2)
		    End If
		  Else
		    Return EncodeHex(Crypto.MD5(Path)).Lowercase
		  End If
		  
		  Var Components() As String = Path.Split("/")
		  Var Tail As String = Components(Components.LastRowIndex)
		  Components = Tail.Split(".")
		  Return Components(Components.LastRowIndex) + "_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends Source As DateInterval) As DateInterval
		  Return New DateInterval(Source.Years, Source.Months, Source.Days, Source.Hours, Source.Minutes, Source.Seconds, Source.NanoSeconds)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CoerceToBoolean(ByRef Value As Variant, DesiredTypeName As String) As Boolean
		  Select Case DesiredTypeName
		  Case "Boolean"
		    Return True
		  Case "String"
		    Var StringValue As String = Value
		    Value = If(StringValue = "true", True, False)
		    Return True
		  Case "Integer"
		    Var IntegerValue As Integer = Value
		    Value = If(IntegerValue >= 1, True, False)
		    Return True
		  Case "Double"
		    Var DoubleValue As Double = Value
		    Value = If(DoubleValue >= 1, True, False)
		    Return True
		  Else
		    #Pragma BreakOnExceptions False
		    Try
		      Var VariantValue As Variant = Value
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
		Private Function CoerceToDouble(ByRef Value As Variant, DesiredTypeName As String) As Boolean
		  #Pragma Unused DesiredTypeName
		  
		  #Pragma BreakOnExceptions False
		  Try
		    Var DoubleValue As Double = Value
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
		  Var DifficultyValue As Double = (Offset * (Steps - 0.5)) + 0.5
		  Return DifficultyValue * 30
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateCSV(Blueprints() As Beacon.Blueprint) As String
		  Var Columns(4) As String
		  Columns(0) = """Path"""
		  Columns(1) = """Label"""
		  Columns(2) = """Availability Mask"""
		  Columns(3) = """Tags"""
		  Columns(4) = """Group"""
		  
		  Var Lines(0) As String
		  Lines(0) = Columns.Join(",")
		  
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    Columns(0) = """" + Blueprint.Path + """"
		    Columns(1) = """" + Blueprint.Label + """"
		    Columns(2) = Blueprint.Availability.ToString(Locale.Raw)
		    Columns(3) = """" + Blueprint.Tags.Join(",") + """"
		    Columns(4) = """" + Blueprint.Category + """"
		    Lines.AddRow(Columns.Join(","))
		  Next
		  
		  Return Lines.Join(Encodings.ASCII.Chr(13) + Encodings.ASCII.Chr(10))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creatures(Extends Blueprints() As Beacon.Blueprint) As Beacon.Creature()
		  Var Creatures() As Beacon.Creature
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Creature Then
		      Creatures.AddRow(Beacon.Creature(Blueprint))
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
		  
		  If Source.IndexOf(CR + LF) > -1 Then
		    Return CR + LF
		  ElseIf Source.IndexOf(CR) > -1 Then
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
		  Var Scale As Double
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
		  Var Engrams() As Beacon.Engram
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Engram Then
		      Engrams.AddRow(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueLabel(DesiredLabel As String, Siblings() As String) As String
		  Var Counter As Integer = 1
		  
		  Var Words() As String = DesiredLabel.Split(" ")
		  If Words.LastRowIndex > 0 And IsNumeric(Words(Words.LastRowIndex)) Then
		    Counter = Val(Words(Words.LastRowIndex))
		    Words.RemoveRowAt(Words.LastRowIndex)
		    DesiredLabel = Words.Join(" ")
		  End If
		  
		  Var TestLabel As String = DesiredLabel
		  
		  Do
		    If Siblings.IndexOf(TestLabel) = -1 Then
		      Return TestLabel
		    End If
		    
		    Counter = Counter + 1
		    TestLabel = DesiredLabel + " " + Counter.ToString
		  Loop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateJSON(Source As Variant, Pretty As Boolean) As String
		  Const UseMBS = False
		  
		  #if UseMBS
		    Var Temp As JSONMBS = JSONMBS.Convert(Source)
		    Return Temp.ToString(Pretty)
		  #else
		    Return Xojo.GenerateJSON(Source, Pretty)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetLastValueAsType(Values() As Object, FullName As String, Default As Variant) As Variant
		  For I As Integer = Values.LastRowIndex DownTo 0
		    Var ValueName As String = NameOfValue(Values(I))
		    If ValueName = FullName Then
		      Return Values(I)
		    End If
		  Next
		  Return Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetValueAsType(Dict As Dictionary, Key As Variant, FullName As String, Default As Variant, AllowArray As Boolean = False, Adapter As ValueAdapter = Nil) As Variant
		  If Dict = Nil Or Dict.HasKey(Key) = False Then
		    Return Default
		  End If
		  
		  Var Value As Variant = Dict.Value(Key)
		  If IsNull(Value) Then
		    Return Default
		  End If
		  
		  Var ValueName As String = NameOfValue(Value)
		  If ValueName.BeginsWith("Unknown") Then
		    Return Default
		  End If
		  If ValueName = "Object()" And AllowArray Then
		    Var Arr() As Object = Value
		    Return GetLastValueAsType(Arr, FullName, Default)
		  ElseIf ValueName = FullName Then
		    Return Value
		  ElseIf Adapter <> Nil Then
		    If Adapter.Invoke(Value, ValueName) Then
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
		  Var Left As Integer = Target.Left
		  Var Top As Integer = Target.Top
		  
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
		  
		  Var Mem As MemoryBlock = Value
		  If Mem.Size >= 3 And Mem.StringValue(0, 3) = Encodings.ASCII.Chr(239) + Encodings.ASCII.Chr(187) + Encodings.ASCII.Chr(191) Then
		    // The rare UTF-8 BOM
		    Return Mem.StringValue(3, Mem.Size - 3).DefineEncoding(Encodings.UTF8)
		  ElseIf Mem.Size >= 2 And Mem.StringValue(0, 2) = Encodings.ASCII.Chr(254) + Encodings.ASCII.Chr(255) Then
		    // Confirmed UTF-16 BE
		    Return Mem.StringValue(2, Mem.Size - 2).DefineEncoding(Encodings.UTF16BE).ConvertEncoding(Encodings.UTF8)
		  ElseIf Mem.Size >= 2 And Mem.StringValue(0, 2) = Encodings.ASCII.Chr(255) + Encodings.ASCII.Chr(254) Then
		    // Confirmed UTF-16 LE
		    Return Mem.StringValue(2, Mem.Size - 2).DefineEncoding(Encodings.UTF16LE).ConvertEncoding(Encodings.UTF8)
		  Else
		    // Ok, now we need to get fancy. It's a safe bet that all files contain a "/script/" string, right?
		    // Let's interpret the file as each of the 3 and see which one matches.
		    
		    Const TestValue = "/script/"
		    Static EncodingsList() As TextEncoding
		    If EncodingsList.LastRowIndex = -1 Then
		      EncodingsList = Array(Encodings.UTF8, Encodings.UTF16LE, Encodings.UTF16BE)
		      Var Bound As Integer = Encodings.Count - 1
		      For I As Integer = 0 To Bound
		        Var Encoding As TextEncoding = Encodings.Item(I)
		        If EncodingsList.IndexOf(Encoding) = -1 Then
		          EncodingsList.AddRow(Encoding)
		        End If
		      Next
		    End If
		    
		    For Each Encoding As TextEncoding In EncodingsList
		      Var TestVersion As String = Value.DefineEncoding(Encoding)
		      If TestVersion.IndexOf(TestValue) > -1 Then
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
		    Var Root As Global.FolderItem = FolderItem.DriveAt(0)
		    If Root = Nil Or Root.Exists = False Then
		      // What the hell is this?
		      Return ""
		    End If
		    
		    Var Created As DateTime = Root.CreationDateTime
		    If Created = Nil Then
		      // Seriously?
		      Return ""
		    End If
		    Created = New DateTime(Created.SecondsFrom1970, New TimeZone(0))
		    
		    Return REALbasic.EncodeHex(Crypto.SHA256(Str(Created.SecondsFrom1970 + 2082844800, "-0"))).Lowercase
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(Extends Blueprint As Beacon.Blueprint) As String
		  Return EncodeHex(Crypto.SHA1(Beacon.GenerateJSON(Blueprint.ToDictionary, False)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function Hash(Block As MemoryBlock) As String
		  Return REALbasic.EncodeHex(Crypto.SHA512(Block)).DefineEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBeaconURL(ByRef Value As String) As Boolean
		  Var PossiblePrefixes() As String
		  PossiblePrefixes.AddRow(Beacon.URLScheme + "://")
		  PossiblePrefixes.AddRow("https://app.beaconapp.cc/")
		  
		  Var URLLength As Integer = Value.Length
		  For Each PossiblePrefix As String In PossiblePrefixes
		    Var PrefixLength As Integer = PossiblePrefix.Length
		    If URLLength > PrefixLength And Value.Left(PrefixLength) = PossiblePrefix Then
		      Value = Value.Middle(PrefixLength)
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsUnknown(Extends Blueprint As Beacon.Blueprint) As Boolean
		  Return Blueprint.Path.BeginsWith(UnknownBlueprintPrefix)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Extends Maps() As Beacon.Map) As String
		  Var Names() As String
		  For Each Map As Beacon.Map In Maps
		    Names.AddRow(Map.Name)
		  Next
		  
		  If Names.LastRowIndex = -1 Then
		    Return "No Maps"
		  ElseIf Names.LastRowIndex = 0 Then
		    Return Names(0)
		  ElseIf Names.LastRowIndex = 1 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Var Tail As String = Names(Names.LastRowIndex)
		    Names.RemoveRowAt(Names.LastRowIndex)
		    Return Names.Join(", ") + ", & " + Tail
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelFromClassString(ClassString As String) As String
		  If ClassString.EndsWith("_C") Then
		    ClassString = ClassString.Left(ClassString.Length - 2)
		  End If
		  
		  Var Prefixes() As String = Array("DinoDropInventoryComponent", "DinoSpawnEntries")
		  Var Blacklist() As String = Array("Character", "BP", "DinoSpawnEntries", "SupplyCrate", "SupplyCreate", "DinoDropInventoryComponent")
		  
		  Try
		    ClassString = ClassString.Replace("T_Ext", "Ext")
		    
		    Var MapName As String
		    
		    Var Parts() As String = ClassString.Split("_")
		    If Parts(0).BeginsWith("PrimalItem") Then
		      Parts.RemoveRowAt(0)
		    End If
		    
		    For I As Integer = Parts.LastRowIndex DownTo 0
		      Select Case Parts(I)
		      Case "AB"
		        MapName = "Aberration"
		        Parts.RemoveRowAt(I)
		        Continue
		      Case "Val"
		        MapName = "Valguero"
		        Parts.RemoveRowAt(I)
		        Continue
		      Case "SE"
		        MapName = "Scorched"
		        Parts.RemoveRowAt(I)
		        Continue
		      Case "Ext", "EX"
		        MapName = "Extinction"
		        Parts.RemoveRowAt(I)
		        Continue
		      Case "JacksonL", "Ragnarok"
		        MapName = "Ragnarok"
		        Parts.RemoveRowAt(I)
		        Continue
		      Case "TheCenter"
		        MapName = "The Center"
		        Parts.RemoveRowAt(I)
		        Continue
		      End Select
		      
		      For Each Prefix As String In Prefixes
		        If Parts(I).BeginsWith(Prefix) Then
		          Parts(I) = Parts(I).Middle(Prefix.Length)
		        End If
		      Next
		      
		      For Each Member As String In Blacklist
		        If Parts(I) = Member Then
		          Parts.RemoveRowAt(I)
		          Continue For I
		        End If
		      Next
		    Next
		    
		    If MapName <> "" Then
		      Parts.AddRowAt(0, MapName)
		    End If
		    
		    Return Beacon.MakeHumanReadable(Parts.Join(" "))
		  Catch Err As RuntimeException
		    Return Beacon.MakeHumanReadable(ClassString)
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex(Extends Target As Beacon.Countable) As Integer
		  Return Target.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeHumanReadable(Source As String) As String
		  Var Chars() As String
		  Var SourceChars() As String = Source.Split("")
		  For Each Char As String In SourceChars
		    Var Codepoint As Integer = Asc(Char)
		    If Codepoint = 32 Or (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 97 And Codepoint <= 122) Then
		      Chars.AddRow(Char)
		    ElseIf CodePoint >= 65 And Codepoint <= 90 Then
		      Chars.AddRow(" ")
		      Chars.AddRow(Char)
		    ElseIf CodePoint = 95 Then
		      Chars.AddRow(" ")
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
		  Var Bits As UInt64
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
		Protected Function Merge(Array1() As Beacon.Engram, Array2() As Beacon.Engram) As Beacon.Engram()
		  Var Unique As New Dictionary
		  For Each Engram As Beacon.Engram In Array1
		    Unique.Value(Engram.Path) = Engram
		  Next
		  For Each Engram As Beacon.Engram In Array2
		    Unique.Value(Engram.Path) = Engram
		  Next
		  Var Merged() As Beacon.Engram
		  For Each Entry As DictionaryEntry In Unique
		    Merged.AddRow(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NameOfValue(Value As Variant) As String
		  Var ValueName As String
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Value)
		  If Info <> Nil Then
		    ValueName = Info.FullName
		  Else
		    Var Type As Integer
		    If Value.IsArray Then
		      Type = Value.ArrayElementType
		    Else
		      Type = Value.Type
		    End If
		    Select Case Type
		    Case Variant.TypeDouble
		      ValueName = "Double"
		    Case Variant.TypeBoolean
		      ValueName = "Boolean"
		    Case Variant.TypeInt32
		      ValueName = "Int32"
		    Case Variant.TypeInt64
		      ValueName = "Int64"
		    Case Variant.TypeSingle
		      ValueName = "Single"
		    Case Variant.TypeString
		      ValueName = "String"
		    Case Variant.TypeText
		      ValueName = "Text"
		    Else
		      ValueName = "Unknown"
		    End Select
		    If Value.IsArray Then
		      ValueName = ValueName + "()"
		    End If
		  End If
		  Return ValueName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NormalizeBlueprintPath(Path As String, FolderName As String) As String
		  Path = Path.Trim
		  
		  If Path.BeginsWith("BlueprintGeneratedClass") Then
		    Path = Path.Middle(23)
		  ElseIf Path.BeginsWith("Blueprint") Then
		    Path = Path.Middle(9)
		  End If
		  
		  If (Path.BeginsWith("'") And Path.EndsWith("'")) Or (Path.BeginsWith("""") And Path.EndsWith("""")) Then
		    Path = Path.Middle(1, Path.Length - 2)
		  End If
		  
		  If Path.BeginsWith("/Game/") Then
		    // Looks like a real path
		    
		    If Path.EndsWith("_C") Then
		      Path = Path.Left(Path.Length - 2)
		    End If
		    
		    Return Path
		  Else
		    // Assume this is a class string
		    Var PossiblePath As String = Beacon.Data.ResolvePathFromClassString(Path)
		    If PossiblePath <> "" Then
		      Return PossiblePath
		    Else
		      Return Beacon.UnknownBlueprintPath(FolderName, Path)
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NormalizeTag(Tag As String) As String
		  Var TagString As String = Tag.Lowercase.Trim
		  
		  Var Sanitizer As New RegEx
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
		  Const UseMBS = False
		  
		  #if UseMBS
		    Var Temp As New JSONMBS(Source)
		    Return Temp.Convert
		  #else
		    Return Xojo.ParseJSON(Source)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double, DecimalPlaces As Integer = 6) As String
		  Var Multiplier As UInteger = 1
		  Var Places As Integer = 0
		  Var Format As String = "0"
		  
		  While Places < DecimalPlaces
		    Var TestValue As Double = Value * Multiplier
		    If Abs(TestValue - Floor(TestValue)) < 0.0000001 Then
		      Exit
		    End If
		    Multiplier = Multiplier * 10
		    Format = Format + "0"
		    Places = Places + 1
		  Wend
		  
		  If Format.Length > 1 Then
		    Format = Format.Left(1) + "." + Format.Middle(1)
		  End If
		  
		  Var RoundedValue As Double = Round(Value * Multiplier) / Multiplier
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
		  Var Extensions() As String = Type.Extensions.Split(";")
		  If Extensions.LastRowIndex = -1 Then
		    Return ""
		  End If
		  
		  Var Extension As String = Extensions(0)
		  If Extension.Left(1) <> "." Then
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
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToRemove.LastRowIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToRemove(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    Var Idx As Integer = Tags.IndexOf(Tag)
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Tags.RemoveRowAt(Idx)
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
		Function SanitizeIni(Extends Content As String) As String
		  Content = Content.ReplaceAll("‘", "'")
		  Content = Content.ReplaceAll("’", "'")
		  Content = Content.ReplaceAll("“", """")
		  Content = Content.ReplaceAll("”", """")
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SanitizeIni(Content As String) As String
		  Return Content.SanitizeIni
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForCreatures(Extends Source As Beacon.DataSource, SearchText As String = "", Mods As Beacon.StringList = Nil, Tags As String = "") As Beacon.Creature()
		  If Mods = Nil Then
		    Mods = New Beacon.StringList
		  End If
		  Var Blueprints() As Beacon.Blueprint = Source.SearchForBlueprints(CategoryCreatures, SearchText, Mods, Tags)
		  Var Creatures() As Beacon.Creature
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Creature Then
		      Creatures.AddRow(Beacon.Creature(Blueprint))
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
		  Var Blueprints() As Beacon.Blueprint = Source.SearchForBlueprints(CategoryEngrams, SearchText, Mods, Tags)
		  Var Engrams() As Beacon.Engram
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Engram Then
		      Engrams.AddRow(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForSpawnPoints(Extends Source As Beacon.DataSource, SearchText As String = "", Mods As Beacon.StringList = Nil, Tags As String = "") As Beacon.SpawnPoint()
		  If Mods = Nil Then
		    Mods = New Beacon.StringList
		  End If
		  Var Blueprints() As Beacon.Blueprint = Source.SearchForBlueprints(CategorySpawnPoints, SearchText, Mods, Tags)
		  Var SpawnPoints() As Beacon.SpawnPoint
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.SpawnPoint Then
		      SpawnPoints.AddRow(Beacon.SpawnPoint(Blueprint))
		    End If
		  Next
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondsToString(Seconds As UInt64) As String
		  // Too obvious?
		  Const SecondsPerDay = 86400
		  Const SecondsPerHour = 3600
		  Const SecondsPerMinute = 60
		  
		  Var Days As Integer = Floor(Seconds / SecondsPerDay)
		  Seconds = Seconds - (Days * SecondsPerDay)
		  
		  Var Hours As Integer = Floor(Seconds / SecondsPerHour)
		  Seconds = Seconds - (Hours * SecondsPerHour)
		  
		  Var Minutes As Integer = Floor(Seconds / SecondsPerMinute)
		  Seconds = Seconds - (Minutes * SecondsPerMinute)
		  
		  Var Parts() As String
		  If Days > 0 Then
		    Parts.AddRow(Str(Days, "-0") + "d")
		  End If
		  If Hours > 0 Then
		    Parts.AddRow(Str(Hours, "-0") + "h")
		  End If
		  If Minutes > 0 Then
		    Parts.AddRow(Str(Minutes, "-0") + "m")
		  End If
		  If Seconds > 0 Then
		    Parts.AddRow(Str(Seconds, "-0") + "s")
		  End If
		  Return Parts.Join(" ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Sources() As Beacon.LootSource)
		  Var Bound As Integer = Sources.LastRowIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As Integer
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Sources(I).SortValue
		  Next
		  
		  Order.SortWith(Sources)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Qualities() As Beacon.Quality)
		  Var Bound As Integer = Qualities.LastRowIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As Double
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Qualities(I).BaseValue
		  Next
		  
		  Order.SortWith(Qualities)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagString(Extends Blueprint As Beacon.Blueprint) As String
		  Var Tags() As String = Blueprint.Tags
		  If Tags.IndexOf("object") = -1 Then
		    Tags.AddRowAt(0, "object")
		  End If
		  Return Tags.Join(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Extends Blueprint As Beacon.MutableBlueprint, Assigns Value As String)
		  Var Tags() As String = Value.Split(",")
		  Var Idx As Integer = Tags.IndexOf("object")
		  If Idx > -1 Then
		    Tags.RemoveRowAt(Idx)
		  End If
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnknownBlueprintPath(FolderName As String, ClassString As String) As String
		  Var ClassName As String
		  If ClassString.EndsWith("_C") Then
		    ClassName = ClassString.Left(ClassString.Length - 2)
		  Else
		    ClassName = ClassString
		  End If
		  
		  Return UnknownBlueprintPrefix + FolderName + "/" + ClassName + "." + ClassName
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function URLHandler(URL As String) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function ValidateEmail(Address As String) As Boolean
		  Var Validator As New RegEx
		  Validator.SearchPattern = "^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|""(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*"")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$"
		  Return Validator.Search(Address) <> Nil
		End Function
	#tag EndMethod

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
		  Return Mask = 0 Or (Blueprint.Availability And Mask) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMask(Extends Blueprint As Beacon.MutableBlueprint, Mask As UInt64, Assigns Value As Boolean)
		  Var Availability As UInt64 = Blueprint.Availability
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
		Private Delegate Function ValueAdapter(ByRef Value As Variant, DesiredTypeName As String) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function WebURL(Path As String = "/") As String
		  #if DebugBuild
		    Var Domain As String = "https://lab.beaconapp.cc"
		  #else
		    Var Domain As String = "https://beaconapp.cc"
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

	#tag Constant, Name = CategorySpawnPoints, Type = String, Dynamic = False, Default = \"spawn_points", Scope = Protected
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

	#tag Constant, Name = UnknownBlueprintPrefix, Type = String, Dynamic = False, Default = \"/Game/BeaconUserBlueprints/", Scope = Protected
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
