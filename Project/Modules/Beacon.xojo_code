#tag Module
Protected Module Beacon
	#tag Method, Flags = &h0
		Sub AddArray(Extends Destination() As Beacon.ConfigValue, Source() As Beacon.ConfigValue)
		  If Source Is Nil Or Source.Count = 0 Then
		    Return
		  End If
		  
		  Var StartingIndex As Integer = Destination.LastIndex + 1
		  Destination.ResizeTo((Destination.Count + Source.Count) - 1)
		  
		  For Idx As Integer = StartingIndex To Destination.LastIndex
		    Destination(Idx) = Source(Idx - StartingIndex)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTag(Extends Blueprint As Beacon.MutableBlueprint, ParamArray TagsToAdd() As String)
		  Blueprint.AddTags(TagsToAdd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTags(Extends Blueprint As Beacon.MutableBlueprint, TagsToAdd() As String)
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToAdd.LastIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToAdd(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    If Tags.IndexOf(Tag) <> -1 Then
		      Continue
		    End If
		    
		    Tags.Add(Tag)
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
		  If Items = Nil Or Items.LastIndex <= 0 Then
		    Return True
		  End If
		  
		  Var CommonValue As Variant = Items(0)
		  For Idx As Integer = 1 To Items.LastIndex
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
		      Entries.Add(Value)
		    End If
		  End If
		  Return Entries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AutosaveFolder(Extends Target As Beacon.Application, Create As Boolean = False) As FolderItem
		  Var Folder As FolderItem = Target.ApplicationSupport.Child("Autosave")
		  If Folder = Nil Then
		    Return Nil
		  End If
		  If Not Folder.Exists Then
		    If Create Then
		      Folder.CreateFolder
		    Else
		      Return Nil
		    End If
		  End If
		  Return Folder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupsFolder(Extends Target As Beacon.Application) As FolderItem
		  Return Target.ApplicationSupport.Child("Backups")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BooleanValue(Extends Dict As Dictionary, Key As Variant, Default As Boolean, AllowArray As Boolean = False) As Boolean
		  Return GetValueAsType(Dict, Key, "Boolean", Default, AllowArray, AddressOf CoerceToBoolean)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BytesToString(Bytes As Double, Locale As Locale = Nil) As String
		  If Bytes < 1024 Then
		    Return Bytes.ToString(Locale, ",##0") + " Bytes"
		  End If
		  
		  Var Kibibytes As Double = Bytes / 1024
		  If Kibibytes < 1024 Then
		    Return Kibibytes.ToString(Locale, ",##0.00") + " KiB"
		  End If
		  
		  Var Mebibytes As Double = Kibibytes / 1024
		  If Mebibytes < 1024 Then
		    Return Mebibytes.ToString(Locale, ",##0.00") + " MiB"
		  End If
		  
		  // Let's be real, Beacon isn't going to be dealing with values greater than
		  // Mebibytes, but here's the logic just in case.
		  
		  Var Gibibytes As Double = Mebibytes / 1024
		  If Gibibytes < 1024 Then
		    Return Gibibytes.ToString(Locale, ",##0.00") + " GiB"
		  End If
		  
		  Var Tebibytes As Double = Gibibytes / 1024
		  Return Tebibytes.ToString(Locale, ",##0.00") + " TiB"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Categories() As String()
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
		  Var Tail As String = Components(Components.LastIndex)
		  Components = Tail.Split(".")
		  Return Components(Components.LastIndex) + "_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CleanupConfigBackups()
		  Var BackupsRoot As FolderItem = App.BackupsFolder
		  If BackupsRoot = Nil Or BackupsRoot.Exists = False Then
		    Return
		  End If
		  
		  Var Matcher As New Regex
		  Matcher.SearchPattern = "^(\d{4})-(\d{2})-(\d{2}) (\d{2}).(\d{2}).(\d{2}) GMT"
		  
		  Var Zone As New TimeZone(0)
		  For Each ServerFolder As FolderItem In BackupsRoot.Children
		    If ServerFolder.IsFolder = False Then
		      Continue
		    End If
		    
		    Var Timestamps() As Integer
		    Var Folders() As FolderItem
		    For Each BackupFolder As FolderItem In ServerFolder.Children
		      Try
		        If BackupFolder.IsFolder = False Then
		          Continue
		        End If
		        
		        Var Matches As RegexMatch = Matcher.Search(BackupFolder.Name)
		        If Matches = Nil Then
		          Continue
		        End If
		        
		        Var Year As Integer = Matches.SubExpressionString(1).ToInteger
		        Var Month As Integer = Matches.SubExpressionString(2).ToInteger
		        Var Day As Integer = Matches.SubExpressionString(3).ToInteger
		        Var Hour As Integer = Matches.SubExpressionString(4).ToInteger
		        Var Minute As Integer = Matches.SubExpressionString(5).ToInteger
		        Var Second As Integer = Matches.SubExpressionString(6).ToInteger
		        
		        Var BackupTime As New DateTime(Year, Month, Day, Hour, Minute, Second, 0, Zone)
		        Timestamps.Add(BackupTime.SecondsFrom1970)
		        Folders.Add(BackupFolder)
		      Catch Err As RuntimeException
		      End Try
		    Next
		    
		    // Keep the very first and the most recent three
		    If Timestamps.Count < 5 Then
		      Continue
		    End If
		    
		    Timestamps.SortWith(Folders)
		    
		    For I As Integer = 1 To Timestamps.LastIndex - 3
		      If Folders(I).DeepDelete Then
		        App.Log("Removed backup " + Folders(I).NativePath)
		      Else
		        App.Log("Unable to clean up backup " + Folders(I).NativePath)
		      End If
		    Next
		  Next
		End Sub
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

	#tag Method, Flags = &h21
		Private Function CoerceToString(ByRef Value As Variant, DesiredTypeName As String) As Boolean
		  #Pragma Unused DesiredTypeName
		  
		  #Pragma BreakOnExceptions False
		  Try
		    If Value.IsNull Then
		      Value = ""
		      Return True
		    End If
		    
		    Var StringValue As String
		    Select Case Value.Type
		    Case Variant.TypeInt32
		      Var IntValue As Int32 = Value
		      StringValue = IntValue.ToString(Locale.Raw, "0")
		    Case Variant.TypeInt64
		      Var IntValue As Int64 = Value
		      StringValue = IntValue.ToString(Locale.Raw, "0")
		    Case Variant.TypeDouble
		      Var DoubleValue As Double = Value
		      StringValue = DoubleValue.PrettyText(False)
		    Else
		      StringValue = Value
		    End Select
		    Value = StringValue
		    
		    Return True
		  Catch Err As TypeMismatchException
		    Return False
		  End Try
		  #Pragma BreakOnExceptions Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Compress(Data As String) As String
		  If IsCompressed(Data) Then
		    Return Data
		  End If
		  
		  Var Compressor As New GZipFileMBS
		  If Compressor.CreateForString Then
		    Compressor.Write(Data)
		    Return Compressor.CloseForString
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ComputeDifficultySettings(BaseDifficulty As Double, DesiredDinoLevel As Integer, ByRef DifficultyValue As Double, ByRef DifficultyOffset As Double, ByRef OverrideOfficialDifficulty As Double)
		  OverrideOfficialDifficulty = Max(Ceiling(DesiredDinoLevel / 30), BaseDifficulty)
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

	#tag Method, Flags = &h21
		Private Sub ComputeSimulationFigures(ItemSetPool() As Beacon.ItemSet, WeightScale As Integer, ByRef WeightSum As Double, ByRef Weights() As Double, ByRef WeightLookup As Dictionary)
		  Weights.ResizeTo(-1)
		  WeightLookup = New Dictionary
		  WeightSum = 0
		  
		  For Each Set As Beacon.ItemSet In ItemSetPool
		    If Set.RawWeight = 0 Then
		      Continue
		    End If
		    WeightSum = WeightSum + Set.RawWeight
		    Weights.Add(WeightSum * WeightScale)
		    WeightLookup.Value(WeightSum * WeightScale) = Set
		  Next
		  Weights.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ComputeWeightStatistics(Extends Source As Beacon.LootSource, ByRef TotalWeight As Double, ByRef AverageWeight As Double, ByRef MinWeight As Double, ByRef MaxWeight As Double)
		  Var Sets As Beacon.ItemSetCollection = Source.ItemSets
		  
		  Var NumSets As Integer = Sets.Count
		  If NumSets = 0 Then
		    Return
		  End If
		  
		  TotalWeight = Sets.AtIndex(0).RawWeight
		  MinWeight = Sets.AtIndex(0).RawWeight
		  MaxWeight = Sets.AtIndex(0).RawWeight
		  
		  For I As Integer = 1 To Sets.LastRowIndex
		    TotalWeight = TotalWeight + Sets.AtIndex(I).RawWeight
		    MinWeight = Min(MinWeight, Sets.AtIndex(I).RawWeight)
		    MaxWeight = Max(MaxWeight, Sets.AtIndex(I).RawWeight)
		  Next
		  
		  AverageWeight = TotalWeight / NumSets
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creatures(Extends Blueprints() As Beacon.Blueprint) As Beacon.Creature()
		  Var Creatures() As Beacon.Creature
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Creature Then
		      Creatures.Add(Beacon.Creature(Blueprint))
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

	#tag Method, Flags = &h1
		Protected Function Decompress(Data As String) As String
		  If Not IsCompressed(Data) Then
		    Return Data
		  End If
		  
		  Const ChunkSize = 1000000
		  
		  Var Decompressor As New GZipFileMBS
		  If Decompressor.OpenString(Data) Then
		    Var Parts() As String
		    While Not Decompressor.EOF
		      Parts.Add(Decompressor.Read(ChunkSize))
		    Wend
		    Return String.FromArray(Parts, "")
		  End If
		End Function
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
		Function DictionaryArrayValue(Extends Value As Variant) As Dictionary()
		  If Value.IsNull Then
		    Var Err As NilObjectException
		    Err.Message = "Value is nil"
		    Raise Err
		  End If
		  
		  If Value.IsArray = False Then
		    Var Err As New TypeMismatchException
		    Err.Message = "Value is not an array"
		    Raise Err
		  End If
		  
		  If Value.ArrayElementType <> Variant.TypeObject Then
		    Var Err As New TypeMismatchException
		    Err.Message = "Value is not an array of objects"
		    Raise Err
		  End If
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Value)
		  Select Case Info.FullName
		  Case "Dictionary()"
		    Return Value
		  Case "Object()"
		    Var Results() As Dictionary
		    Var Members() As Variant = Value
		    For Idx As Integer = 0 To Members.LastIndex
		      If Members(Idx) IsA Dictionary Then
		        Results.Add(Members(Idx))
		      Else
		        Var Err As New TypeMismatchException
		        Err.Message = "Value at index " + Idx.ToString + "is not a Dictionary"
		        Raise Err
		      End If
		    Next
		    Return Results
		  Else
		    Var Err As New TypeMismatchException
		    Err.Message = "Value is a " + Info.FullName + " which cannot be converted to Dictionary()"
		    Raise Err
		  End Select
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
		Function Disambiguate(Extends Label As String, Specifier As String) As String
		  Return Beacon.Disambiguate(Label, Specifier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Disambiguate(Label As String, Specifier As String) As String
		  // Yes it's a word, shut up.
		  
		  If Label.EndsWith(")") Then
		    Return Label.Left(Label.Length - 1) + ", " + Specifier + ")"
		  Else
		    Return Label + " (" + Specifier + ")"
		  End If
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
		      Engrams.Add(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExceptionsFolder(Extends Target As Beacon.Application, Create As Boolean = True) As FolderItem
		  Var ErrorsFolder As FolderItem = Target.ApplicationSupport.Child("Errors")
		  Call ErrorsFolder.CheckIsFolder(Create)
		  Return ErrorsFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueLabel(DesiredLabel As String, Siblings() As String) As String
		  Var Counter As Integer = 1
		  
		  Var Words() As String = DesiredLabel.Split(" ")
		  If Words.LastIndex > 0 And IsNumeric(Words(Words.LastIndex)) Then
		    Counter = Integer.FromString(Words(Words.LastIndex), Locale.Raw)
		    Words.RemoveAt(Words.LastIndex)
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

	#tag Method, Flags = &h0
		Function GetConfigKey(Extends Source As Beacon.DataSource, File As String, Header As String, Key As String) As Beacon.ConfigKey
		  Var Results() As Beacon.ConfigKey = Source.SearchForConfigKey(File, Header, Key, False)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetLastValueAsType(Values() As Object, FullName As String, Default As Variant) As Variant
		  For I As Integer = Values.LastIndex DownTo 0
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
		  ElseIf Beacon.SafeToInvoke(Adapter) Then
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
		    If EncodingsList.LastIndex = -1 Then
		      EncodingsList = Array(Encodings.UTF8, Encodings.UTF16LE, Encodings.UTF16BE)
		      Var Bound As Integer = Encodings.Count - 1
		      For I As Integer = 0 To Bound
		        Var Encoding As TextEncoding = Encodings.Item(I)
		        If EncodingsList.IndexOf(Encoding) = -1 Then
		          EncodingsList.Add(Encoding)
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
		    
		    Var Seconds As Double = Created.SecondsFrom1970 + 2082844800
		    Return EncodeHex(Crypto.SHA256(Seconds.ToString(Locale.Raw, "0"))).Lowercase
		  #elseif TargetiOS
		    // https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor
		    
		    Const UIKitFramework = "UIKit.framework"
		    Const FoundationFramework = "Foundation.framework"
		    
		    Declare Function NSClassFromString Lib FoundationFramework (ClassName As CFStringRef) As Ptr
		    Declare Function GetCurrentDevice Lib UIKitFramework Selector "currentDevice" (Target As Ptr) As Ptr
		    Declare Function GetIdentifierForVendor Lib UIKitFramework Selector "identifierForVendor" (Target As Ptr) As Ptr
		    Declare Function GetUUIDString Lib UIKitFramework Selector "UUIDString" (Target As Ptr) As Ptr
		    Declare Function GetUTF8String Lib FoundationFramework Selector "UTF8String" (Target As Ptr) As CString
		    
		    Var UIDevice As Ptr = NSClassFromString("UIDevice")
		    Var CurrentDevice As Ptr = GetCurrentDevice(UIDevice)
		    Var UUIDValue As Ptr = GetIdentifierForVendor(CurrentDevice)
		    Var NSStringValue As Ptr = GetUUIDString(UUIDValue)
		    Var Identifier As String = GetUTF8String(NSStringValue)
		    
		    Return Identifier.DefineEncoding(Encodings.UTF8).Lowercase
		  #else
		    #Pragma Error "HardwareID not implemented for this platform"
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(Extends Blueprint As Beacon.Blueprint) As String
		  #if DebugBuild
		    Return Beacon.GenerateJSON(Beacon.PackBlueprint(Blueprint), True)
		  #else
		    Return EncodeHex(Crypto.SHA1(Beacon.GenerateJSON(Beacon.PackBlueprint(Blueprint), False))).Lowercase
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Hash(Block As MemoryBlock) As String
		  Return EncodeHex(Crypto.SHA512(Block)).DefineEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedPresetCount(Extends Source As Beacon.LootSource) As UInteger
		  Var Sets As Beacon.ItemSetCollection = Source.ItemSets
		  Var Total As UInteger
		  For Each Set As Beacon.ItemSet In Sets
		    If Set.SourcePresetID <> "" Then
		      Total = Total + CType(1, UInteger)
		    End If
		  Next
		  Return Total
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBeaconURL(ByRef Value As String) As Boolean
		  Var PossiblePrefixes() As String
		  PossiblePrefixes.Add(Beacon.URLScheme + "://")
		  PossiblePrefixes.Add("https://app.usebeacon.app/")
		  
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

	#tag Method, Flags = &h1
		Protected Function IsCompressed(Value As Variant) As Boolean
		  If Value.IsNull Then
		    Return False
		  End If
		  
		  // Try to get a string value
		  #Pragma BreakOnExceptions Off
		  Var StringValue As String
		  Try
		    StringValue = Value
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  If StringValue.Bytes < 2 Then
		    Return False
		  End If
		  
		  // See if the value starts with 1F8B
		  Var MagicBytes As String = EncodeHex(StringValue.LeftBytes(2))
		  Return MagicBytes = "1F8B"
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
		    Names.Add(Map.Name)
		  Next
		  
		  If Names.LastIndex = -1 Then
		    Return "No Maps"
		  ElseIf Names.LastIndex = 0 Then
		    Return Names(0)
		  ElseIf Names.LastIndex = 1 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Var Tail As String = Names(Names.LastIndex)
		    Names.RemoveAt(Names.LastIndex)
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
		      Parts.RemoveAt(0)
		    End If
		    
		    For I As Integer = Parts.LastIndex DownTo 0
		      Select Case Parts(I)
		      Case "AB"
		        MapName = "Aberration"
		        Parts.RemoveAt(I)
		        Continue
		      Case "Val"
		        MapName = "Valguero"
		        Parts.RemoveAt(I)
		        Continue
		      Case "SE"
		        MapName = "Scorched"
		        Parts.RemoveAt(I)
		        Continue
		      Case "Ext", "EX"
		        MapName = "Extinction"
		        Parts.RemoveAt(I)
		        Continue
		      Case "JacksonL", "Ragnarok"
		        MapName = "Ragnarok"
		        Parts.RemoveAt(I)
		        Continue
		      Case "TheCenter"
		        MapName = "The Center"
		        Parts.RemoveAt(I)
		        Continue
		      End Select
		      
		      For Each Prefix As String In Prefixes
		        If Parts(I).BeginsWith(Prefix) Then
		          Parts(I) = Parts(I).Middle(Prefix.Length)
		        End If
		      Next
		      
		      For Each Member As String In Blacklist
		        If Parts(I) = Member Then
		          Parts.RemoveAt(I)
		          Continue For I
		        End If
		      Next
		    Next
		    
		    If MapName <> "" Then
		      Parts.AddAt(0, MapName)
		    End If
		    
		    If Parts.Count > 0 Then
		      Return Beacon.MakeHumanReadable(Parts.Join(" "))
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Return Beacon.MakeHumanReadable(ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex(Extends Target As Beacon.Countable) As Integer
		  Return Target.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LoadLootSourceSaveData(SaveData As Dictionary) As Beacon.LootSource
		  If SaveData Is Nil Then
		    Return Nil
		  End If
		  
		  Var ClassString As String = SaveData.Lookup("SupplyCrateClassString", "")
		  If ClassString.IsEmpty Then
		    Return Nil
		  End If
		  
		  Var Type As String = SaveData.Lookup("Type", "LootContainer")
		  Var Source As Beacon.LootSource
		  Select Case Type
		  Case "LootContainer"
		    Var OfficialSource As Beacon.LootSource = Beacon.Data.GetLootSource(ClassString)
		    Source = OfficialSource
		  End Select
		  
		  If Source Is Nil Then
		    Source = New CustomLootContainer(ClassString)
		  End If
		  
		  Try
		    Source.MinItemSets = SaveData.Lookup("MinItemSets", 1).IntegerValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MinItemSets value")
		  End Try
		  
		  Try
		    Source.MaxItemSets = SaveData.Lookup("MaxItemSets", 1).IntegerValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading MaxItemSets value")
		  End Try
		  
		  Try
		    Source.PreventDuplicates = SaveData.Lookup("bSetsRandomWithoutReplacement", True).BooleanValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading bSetsRandomWithoutReplacement value")
		  End Try
		  
		  Try
		    Source.AppendMode = SaveData.Lookup("bAppendMode", False).BooleanValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading bAppendMode value")
		  End Try
		  
		  If SaveData.HasKey("ItemSets") Then
		    Try
		      Source.ItemSets = Beacon.ItemSetCollection.FromSaveData(SaveData.Value("ItemSets"))
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading ItemSets value")
		    End Try
		  End If
		  
		  If Not Source.LoadSaveData(SaveData) Then
		    Return Nil
		  End If
		  
		  Source.Modified = True
		  Return Source
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeHumanReadable(Source As String) As String
		  Var Chars() As String
		  Var SourceChars() As String = Source.Split("")
		  For Each Char As String In SourceChars
		    Var Codepoint As Integer = Char.Asc
		    If Codepoint = 32 Or (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 97 And Codepoint <= 122) Then
		      Chars.Add(Char)
		    ElseIf CodePoint >= 65 And Codepoint <= 90 Then
		      Chars.Add(" ")
		      Chars.Add(Char)
		    ElseIf CodePoint = 95 Then
		      Chars.Add(" ")
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
		    Unique.Value(Engram.ObjectID) = Engram
		  Next
		  For Each Engram As Beacon.Engram In Array2
		    Unique.Value(Engram.ObjectID) = Engram
		  Next
		  Var Merged() As Beacon.Engram
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Merge(Extends FirstArray() As String, SecondArray() As String)
		  For Idx As Integer = SecondArray.FirstRowIndex To SecondArray.LastIndex
		    FirstArray.Add(SecondArray(Idx))
		  Next
		End Sub
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

	#tag Method, Flags = &h0
		Function NewMembers(Extends LeftMembers() As String, RightMembers() As String) As String()
		  Var Dict As New Dictionary
		  For Each Member As String In LeftMembers
		    Dict.Value(Member) = 1
		  Next Member
		  Var Unique() As String
		  For Each Member As String In RightMembers
		    If Dict.HasKey(Member) = False Then
		      Unique.Add(Member)
		    End If
		  Next Member
		  Return Unique
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

	#tag Method, Flags = &h0
		Function Pack(Extends Blueprint As Beacon.Blueprint) As Dictionary
		  Return PackBlueprint(Blueprint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PackBlueprint(Blueprint As Beacon.Blueprint) As Dictionary
		  Var Dict As New Dictionary
		  
		  Select Case Blueprint
		  Case IsA Beacon.Engram
		    Dict.Value("group") = "engrams"
		  Case IsA Beacon.Creature
		    Dict.Value("group") = "creatures"
		  Case IsA Beacon.SpawnPoint
		    Dict.Value("group") = "spawn_points"
		  Else
		    Return Nil
		  End Select
		  
		  Var ModInfo As New Dictionary
		  ModInfo.Value("id") = Blueprint.ModID
		  ModInfo.Value("name") = Blueprint.ModName
		  
		  Dict.Value("id") = Blueprint.ObjectID
		  Dict.Value("label") = Blueprint.Label
		  Dict.Value("alternate_label") = Blueprint.AlternateLabel
		  Dict.Value("mod") = ModInfo
		  Dict.Value("tags") = Blueprint.Tags
		  Dict.Value("availability") = Blueprint.Availability
		  Dict.Value("path") = Blueprint.Path
		  
		  // Let the blueprint add whatever additional data it needs
		  Blueprint.Pack(Dict)
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseCommandLine(CommandLine As String, PreserveSyntax As Boolean = False) As Dictionary
		  // This shouldn't take long, but still, probably best to only use this on a thread
		  
		  Var InQuotes As Boolean
		  Var Characters() As String = CommandLine.Split("")
		  Var Buffer, Params() As String
		  For Each Char As String In Characters
		    If Char = """" Then
		      If InQuotes Then
		        Params.Add(Buffer)
		        Buffer = ""
		        InQuotes = False
		      Else
		        InQuotes = True
		      End If
		    ElseIf Char = " " Then
		      If InQuotes = False And Buffer.Length > 0 Then
		        Params.Add(Buffer)
		        Buffer = ""
		      End If
		    ElseIf Char = "-" And Buffer.Length = 0 Then
		      Continue
		    Else
		      Buffer = Buffer + Char
		    End If
		  Next
		  If Buffer.Length > 0 Then
		    Params.Add(Buffer)
		    Buffer = ""
		  End If
		  
		  Var StartupParams() As String = Params.Shift.Split("?")
		  Var Map As String = StartupParams.Shift
		  Call StartupParams.Shift // The listen statement
		  If PreserveSyntax Then
		    For Idx As Integer = 0 To Params.LastIndex
		      Params(Idx) = "-" + Params(Idx)
		    Next
		    For Idx As Integer = 0 To StartupParams.LastIndex
		      StartupParams(Idx) = "?" + StartupParams(Idx)
		    Next
		  End If
		  StartupParams.Merge(Params)
		  
		  Var CommandLineOptions As New Dictionary
		  For Each Parameter As String In StartupParams
		    Var KeyPos As Integer = Parameter.IndexOf("=")
		    Var Key As String
		    Var Value As Variant
		    If KeyPos = -1 Then
		      Key = Parameter
		      Value = True
		    Else
		      Key = Parameter.Left(KeyPos)
		      Value = Parameter.Middle(KeyPos + 1)
		    End If
		    If PreserveSyntax Then
		      Value = Parameter
		    End If
		    CommandLineOptions.Value(Key) = Value
		  Next
		  
		  If PreserveSyntax Then
		    CommandLineOptions.Value("?Map") = Map
		  Else
		    CommandLineOptions.Value("Map") = Map
		  End If
		  Return CommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseInterval(Input As String) As DateInterval
		  Input = Input.Trim
		  If Input.IsEmpty Then
		    Return Nil
		  End If
		  
		  Var Parser As New Regex
		  Parser.SearchPattern = "^((\d+)\s*(d|day|days))?\s*((\d+)\s*(h|hour|hours))?\s*((\d+)\s*(m|minute|minutes))?\s*((\d+)(\.(\d+))?\s*(s|second|seconds))?$"
		  
		  Var Matches As RegExMatch = Parser.Search(Input)
		  If Matches = Nil Then
		    Return Nil
		  End If
		  
		  Var MatchCount As Integer = Matches.SubExpressionCount
		  Var Days As String = If(MatchCount >= 2, Matches.SubExpressionString(2), "0")
		  Var Hours As String = If(MatchCount >= 5, Matches.SubExpressionString(5), "0")
		  Var Minutes As String = If(MatchCount >= 8, Matches.SubExpressionString(8), "0")
		  Var Seconds As String = If(MatchCount >= 11, Matches.SubExpressionString(11), "0")
		  Var PartialSeconds As String = If(MatchCount >= 12, "0" + Matches.SubExpressionString(12), "0.0")
		  If Days.IsEmpty Then
		    Days = "0"
		  End If
		  If Hours.IsEmpty Then
		    Hours = "0"
		  End If
		  If Minutes.IsEmpty Then
		    Minutes = "0"
		  End If
		  If Seconds.IsEmpty Then
		    Seconds = "0"
		  End If
		  If PartialSeconds.IsEmpty Then
		    PartialSeconds = "0.0"
		  End If
		  
		  Return New DateInterval(0, 0, Integer.FromString(Days), Integer.FromString(Hours), Integer.FromString(Minutes), Integer.FromString(Seconds), 1000000000 * Double.FromString(PartialSeconds))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseJSON(Source As String) As Variant
		  If Source.IsEmpty Then
		    Return Nil
		  End If
		  
		  Const UseMBS = False
		  
		  If Source.Encoding Is Nil Then
		    Source = Source.GuessEncoding
		  ElseIf Source.Encoding <> Encodings.UTF8 Then
		    Source = Source.ConvertEncoding(Encodings.UTF8)
		  End If
		  
		  #if UseMBS
		    Var Temp As New JSONMBS(Source)
		    Return Temp.Convert
		  #else
		    Return Xojo.ParseJSON(Source)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double) As String
		  Return PrettyText(Value, DefaultPrettyDecimals, DefaultPrettyLocalized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double, Localized As Boolean) As String
		  Return PrettyText(Value, DefaultPrettyDecimals, Localized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double, DecimalPlaces As Integer) As String
		  Return PrettyText(Value, DecimalPlaces, DefaultPrettyLocalized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double, DecimalPlaces As Integer, Localized As Boolean) As String
		  Var Multiplier As UInteger = 1
		  Var Places As Integer = 0
		  Var Format As String = "0"
		  
		  While Places < DecimalPlaces
		    Var TestValue As Double = Value * Multiplier
		    If Abs(TestValue - Floor(TestValue)) < 0.0000000001 Then
		      Exit
		    End If
		    Multiplier = Multiplier * CType(10, UInteger)
		    Format = Format + "0"
		    Places = Places + 1
		  Wend
		  
		  If Format.Length > 1 Then
		    Format = Format.Left(1) + "." + Format.Middle(1)
		  End If
		  
		  Var RoundedValue As Double = Round(Value * Multiplier) / Multiplier
		  If Localized Then
		    Return RoundedValue.ToString(Locale.Current, Format)
		  Else
		    Return RoundedValue.ToString(Locale.Raw, Format)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyText(Extends Value As Double) As String
		  Return PrettyText(Value, DefaultPrettyDecimals, DefaultPrettyLocalized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyText(Extends Value As Double, Localized As Boolean) As String
		  Return PrettyText(Value, DefaultPrettyDecimals, Localized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyText(Extends Value As Double, DecimalPlaces As Integer) As String
		  Return PrettyText(Value, DecimalPlaces, DefaultPrettyLocalized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyText(Extends Value As Double, DecimalPlaces As Integer, Localized As Boolean) As String
		  Return PrettyText(Value, DecimalPlaces, Localized)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReconfigurePresets(Extends Source As Beacon.LootSource, Mask As UInt64, Mods As Beacon.StringList) As Integer
		  Var Sets As Beacon.ItemSetCollection = Source.ItemSets
		  Var NumChanged As Integer
		  For Each Set As Beacon.ItemSet In Sets
		    If Set.SourcePresetID = "" Then
		      Continue
		    End If
		    
		    If Set.ReconfigureWithPreset(Source, Mask, Mods) Then
		      NumChanged = NumChanged + 1
		    End If
		  Next
		  Return NumChanged
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
		  For I As Integer = 0 To TagsToRemove.LastIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToRemove(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    Var Idx As Integer = Tags.IndexOf(Tag)
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Tags.RemoveAt(Idx)
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
		Protected Function ResolveCreature(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Beacon.Creature
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Beacon.ResolveCreature(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Beacon.Creature
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByID(ObjectID)
		      If (Creature Is Nil) = False Then
		        Return Creature
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Creatures() As Beacon.Creature = Beacon.Data.GetCreaturesByPath(Path, Mods)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Creatures() As Beacon.Creature = Beacon.Data.GetCreaturesByClass(ClassString, Mods)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Beacon.Creature.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Beacon.Engram
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Beacon.ResolveEngram(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Beacon.Engram
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var Engram As Beacon.Engram = Beacon.Data.GetEngramByID(ObjectID)
		      If (Engram Is Nil) = False Then
		        Return Engram
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Engrams() As Beacon.Engram = Beacon.Data.GetEngramsByPath(Path, Mods)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Engrams() As Beacon.Engram = Beacon.Data.GetEngramsByClass(ClassString, Mods)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Beacon.Engram.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(Dict As Dictionary, ObjectIDKey As String, PathKey As String, ClassKey As String, Mods As Beacon.StringList) As Beacon.SpawnPoint
		  Var ObjectID, Path, ClassString As String
		  
		  If ObjectIDKey.IsEmpty = False And Dict.HasKey(ObjectIDKey) Then
		    ObjectID = Dict.Value(ObjectIDKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return Beacon.ResolveSpawnPoint(ObjectID, Path, ClassString, Mods)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(ObjectID As String, Path As String, ClassString As String, Mods As Beacon.StringList) As Beacon.SpawnPoint
		  If ObjectID.IsEmpty = False Then
		    Try
		      Var SpawnPoint As Beacon.SpawnPoint = Beacon.Data.GetSpawnPointByID(ObjectID)
		      If (SpawnPoint Is Nil) = False Then
		        Return SpawnPoint
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As Beacon.SpawnPoint = Beacon.Data.GetSpawnPointsByPath(Path, Mods)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As Beacon.SpawnPoint = Beacon.Data.GetSpawnPointsByClass(ClassString, Mods)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Beacon.SpawnPoint.CreateCustom(ObjectID, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SafeToInvoke(Callback As Variant) As Boolean
		  Return Callback.IsNull = False And (GetDelegateWeakMBS(Callback) = False Or (GetDelegateTargetMBS(Callback) Is Nil) = False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SanitizeFilename(Filename As String, MaxLength As Integer = 0) As String
		  // Windows doesn't seem to agree with trailing whitespace
		  Filename = Filename.Trim
		  
		  Var Searcher As New Regex
		  Searcher.Options.ReplaceAllMatches = True
		  
		  Searcher.SearchPattern = "[/\\:]"
		  Searcher.ReplacementPattern = "-"
		  Filename = Searcher.Replace(Filename)
		  
		  Searcher.SearchPattern = "[<>""|?*\x00-\x1F]+"
		  Searcher.ReplacementPattern = ""
		  Filename = Searcher.Replace(Filename)
		  
		  Searcher.SearchPattern = "(\s+-+)|(-+\s+)|(\s{2,})"
		  Searcher.ReplacementPattern = " "
		  Filename = Searcher.Replace(Filename)
		  
		  If MaxLength > 0 And Filename.Length > MaxLength Then
		    // Remove hyphens first
		    Filename = Filename.ReplaceAll("-", "")
		    
		    // Extension cannot be truncated
		    Var Parts() As String = Filename.Split(".")
		    Var Basename, Extension As String
		    If Parts.Count >= 2 And (Parts(Parts.LastIndex).Length + 1) < MaxLength And Parts(Parts.LastIndex).IndexOf(" ") = -1 Then // No spaces in extensions
		      Extension = "." + Parts(Parts.LastIndex)
		      Parts.RemoveAt(Parts.LastIndex)
		      Basename = Parts.Join(".")
		      MaxLength = MaxLength - Extension.Length
		    Else
		      Basename = Filename
		    End If
		    
		    If MaxLength > 1 Then
		      MaxLength = MaxLength - 1 // To leave space for the elipsis
		    End If
		    Var PrefixLength As Integer = Ceiling(MaxLength / 2)
		    Var SuffixLength As Integer = MaxLength - PrefixLength
		    Var Prefix As String = Basename.Left(PrefixLength).Trim
		    Var Suffix As String = Basename.Right(SuffixLength).Trim
		    Filename = Prefix + If(PrefixLength + SuffixLength > 1, "…", "") + Suffix + Extension
		  End If
		  
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
		Function SaveData(Extends Source As Beacon.LootSource) As Dictionary
		  // Mandatory item sets should not be part of this.
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Source)
		  
		  Var Keys As New Dictionary
		  Keys.Value("Type") = Info.Name
		  Keys.Value("ItemSets") = Source.ItemSets.SaveData
		  Keys.Value("MaxItemSets") = Source.MaxItemSets
		  Keys.Value("MinItemSets") = Source.MinItemSets
		  Keys.Value("bSetsRandomWithoutReplacement") = Source.PreventDuplicates
		  Keys.Value("SupplyCrateClassString") = Source.ClassString
		  Keys.Value("bAppendMode") = Source.AppendMode
		  Source.EditSaveData(Keys)
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForBlueprints(Extends Source As Beacon.DataSource, SearchText As String = "", Mods As Beacon.StringList = Nil, Tags As String = "") As Beacon.Blueprint()
		  Var Categories() As String = Beacon.Categories
		  Var Blueprints() As Beacon.Blueprint
		  For Each Category As String In Categories
		    Var Results() As Beacon.Blueprint = Source.SearchForBlueprints(Category, SearchText, Mods, Tags)
		    For Each Result As Beacon.Blueprint In Results
		      Blueprints.Add(Result)
		    Next
		  Next
		  Return Blueprints
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
		      Creatures.Add(Beacon.Creature(Blueprint))
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
		      Engrams.Add(Beacon.Engram(Blueprint))
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
		      SpawnPoints.Add(Beacon.SpawnPoint(Blueprint))
		    End If
		  Next
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondsToString(ParamArray Intervals() As Double) As String
		  Var WithDays, WithHours, WithMinutes As Boolean = True
		  For Each Interval As Double In Intervals
		    WithDays = WithDays And Interval >= SecondsPerDay
		    WithHours = WithHours And Interval >= SecondsPerHour
		    WithMinutes = WithMinutes And Interval >= SecondsPerMinute
		  Next
		  
		  Var Values() As String
		  For Each Interval As Double In Intervals
		    Values.Add(SecondsToString(Interval, WithDays, WithHours, WithMinutes))
		  Next
		  
		  If Intervals.Count = 1 Then
		    Return Values(0)
		  ElseIf Intervals.Count = 2 Then
		    Return Values(0) + " to " + Values(1)
		  Else
		    Return Values.Join(", ")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SecondsToString(Seconds As Double, WithDays As Boolean, WithHours As Boolean, WithMinutes As Boolean) As String
		  Var Days, Hours, Minutes As Integer
		  
		  If WithDays Then
		    Days = Floor(Seconds / SecondsPerDay)
		    Seconds = Seconds - (Days * SecondsPerDay)
		  End If
		  
		  If WithHours Then
		    Hours = Floor(Seconds / SecondsPerHour)
		    Seconds = Seconds - (Hours * SecondsPerHour)
		  End If
		  
		  If WithMinutes Then
		    Minutes = Floor(Seconds / SecondsPerMinute)
		    Seconds = Seconds - (Minutes * SecondsPerMinute)
		  End If
		  
		  Var Parts() As String
		  If Days > 0 Then
		    Parts.Add(Days.ToString(Locale.Raw, "0") + "d")
		  End If
		  If Hours > 0 Then
		    Parts.Add(Hours.ToString(Locale.Raw, "0") + "h")
		  End If
		  If Minutes > 0 Then
		    Parts.Add(Minutes.ToString(Locale.Raw, "0") + "m")
		  End If
		  If Seconds > 0 Then
		    Parts.Add(Seconds.PrettyText(False) + "s")
		  End If
		  Return Parts.Join(" ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Shift(Extends Arr() As String) As String
		  // Removes the first element of the array and returns it
		  If Arr.Count = 0 Then
		    Return ""
		  End If
		  
		  Var Value As String = Arr(Arr.FirstRowIndex)
		  Arr.RemoveAt(Arr.FirstRowIndex)
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Simulate(Extends Source As Beacon.LootSource) As Beacon.SimulatedSelection()
		  Var Sets As Beacon.ItemSetCollection = Source.ItemSets
		  Var MandatorySets() As Beacon.ItemSet = Source.MandatoryItemSets
		  Var Selections() As Beacon.SimulatedSelection
		  Var NumSets As Integer = Sets.Count + MandatorySets.Count
		  If NumSets = 0 Then
		    Return Selections
		  End If
		  
		  Var MinSets As Integer = Min(Source.MinItemSets, Source.MaxItemSets)
		  Var MaxSets As Integer = Max(Source.MaxItemSets, Source.MinItemSets)
		  
		  Var SelectedSets() As Beacon.ItemSet
		  If NumSets = MinSets And MinSets = MaxSets And Source.PreventDuplicates Then
		    // All
		    For Each Set As Beacon.ItemSet In Sets
		      SelectedSets.Add(Set)
		    Next
		    For Each Set As Beacon.ItemSet In MandatorySets
		      SelectedSets.Add(Set)
		    Next
		  Else
		    Const WeightScale = 100000
		    Var ItemSetPool() As Beacon.ItemSet
		    For I As Integer = 0 To Sets.LastRowIndex
		      ItemSetPool.Add(Sets.AtIndex(I))
		    Next
		    For I As Integer = 0 To MandatorySets.LastIndex
		      ItemSetPool.Add(MandatorySets(I))
		    Next
		    
		    Var RecomputeFigures As Boolean = True
		    Var ChooseSets As Integer = System.Random.InRange(MinSets, MaxSets)
		    Var WeightSum, Weights() As Double
		    Var WeightLookup As Dictionary
		    For I As Integer = 1 To ChooseSets
		      If ItemSetPool.LastIndex = -1 Then
		        Exit For I
		      End If
		      
		      If RecomputeFigures Then
		        Beacon.ComputeSimulationFigures(ItemSetPool, WeightScale, WeightSum, Weights, WeightLookup)
		        RecomputeFigures = False
		      End If
		      
		      Do
		        Var Decision As Double = System.Random.InRange(WeightScale, WeightScale + (WeightSum * WeightScale)) - WeightScale
		        Var SelectedSet As Beacon.ItemSet
		        
		        For X As Integer = 0 To Weights.LastIndex
		          If Weights(X) >= Decision Then
		            Var SelectedWeight As Double = Weights(X)
		            SelectedSet = WeightLookup.Value(SelectedWeight)
		            Exit For X
		          End If
		        Next
		        
		        If SelectedSet = Nil Then
		          Continue
		        End If
		        
		        SelectedSets.Add(SelectedSet)
		        If Source.PreventDuplicates Then
		          For X As Integer = 0 To ItemSetPool.LastIndex
		            If ItemSetPool(X) = SelectedSet Then
		              ItemSetPool.RemoveAt(X)
		              Exit For X
		            End If
		          Next
		          RecomputeFigures = True
		        End If
		        
		        Exit
		      Loop
		    Next
		  End If
		  
		  For Each Set As Beacon.ItemSet In SelectedSets
		    Var SetSelections() As Beacon.SimulatedSelection = Set.Simulate
		    For Each Selection As Beacon.SimulatedSelection In SetSelections
		      Selections.Add(Selection)
		    Next
		  Next
		  Return Selections
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Sources() As Beacon.LootSource)
		  Var Bound As Integer = Sources.LastIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As String
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Sources(I).SortValue.ToString(Locale.Raw, "0000") + Sources(I).Label + Sources(I).ClassString
		  Next
		  
		  Order.SortWith(Sources)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sort(Qualities() As Beacon.Quality)
		  Var Bound As Integer = Qualities.LastIndex
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
		Sub Sort(Extends Values() As Beacon.ConfigValue)
		  If Values.Count <= 1 Then
		    Return
		  End If
		  
		  Var Sorts() As String
		  Sorts.ResizeTo(Values.LastIndex)
		  For Idx As Integer = 0 To Sorts.LastIndex
		    Sorts(Idx) = Values(Idx).SortKey
		  Next
		  Sorts.SortWith(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Extends Dict As Dictionary, Key As Variant, Default As String, AllowArray As Boolean = False) As String
		  Return GetValueAsType(Dict, Key, "String", Default, AllowArray, AddressOf CoerceToString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagString(Extends Blueprint As Beacon.Blueprint) As String
		  Var Tags() As String = Blueprint.Tags
		  If Tags.IndexOf("object") = -1 Then
		    Tags.AddAt(0, "object")
		  End If
		  Return Tags.Join(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagString(Extends Source As Beacon.LootSource) As String
		  Var Tags() As String = Source.Tags
		  Return Tags.Join(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Extends Blueprint As Beacon.MutableBlueprint, Assigns Value As String)
		  Var Tags() As String = Value.Split(",")
		  Var Idx As Integer = Tags.IndexOf("object")
		  If Idx > -1 Then
		    Tags.RemoveAt(Idx)
		  End If
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Extends Source As Beacon.MutableLootSource, Assigns Value As String)
		  Var Tags() As String = Value.Split(",")
		  Source.Tags = Tags
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

	#tag Method, Flags = &h1
		Protected Function UnpackBlueprint(Dict As Dictionary) As Beacon.MutableBlueprint
		  If Not Dict.HasAllKeys("id", "label", "alternate_label", "path", "group", "tags", "availability", "mod") Then
		    Return Nil
		  End If
		  
		  Var Group As String = Dict.Value("group")
		  Var Path As String = Dict.Value("path")
		  Var ObjectID As String = Dict.Value("id")
		  
		  If Path.IsEmpty Or ObjectID.IsEmpty Or Group.IsEmpty Then
		    Return Nil
		  End If
		  
		  Var Blueprint As Beacon.MutableBlueprint
		  Select Case Group
		  Case "engrams"
		    Blueprint = New Beacon.MutableEngram(Path, ObjectID)
		  Case "creatures"
		    Blueprint = New Beacon.MutableCreature(Path, ObjectID)
		  Case "spawn_points"
		    Blueprint = New Beacon.MutableSpawnPoint(Path, ObjectID)
		  Else
		    Return Nil
		  End Select
		  
		  Var ModInfo As Dictionary = Dict.Value("mod")
		  
		  Var Tags() As String
		  If Dict.Value("tags").IsArray Then
		    If Dict.Value("tags").ArrayElementType = Variant.TypeString Then
		      Tags = Dict.Value("tags")
		    ElseIf Dict.Value("tags").ArrayElementType = Variant.TypeObject Then
		      Var Temp() As Variant = Dict.Value("tags")
		      For Each Tag As Variant In Temp
		        If Tag.Type = Variant.TypeString Then
		          Tags.Add(Tag.StringValue)
		        End If
		      Next
		    End If
		  End If
		  
		  If IsNull(Dict.Value("alternate_label")) = False And Dict.Value("alternate_label").StringValue.IsEmpty = False Then
		    Blueprint.AlternateLabel = Dict.Value("alternate_label").StringValue
		  Else
		    Blueprint.AlternateLabel = Nil
		  End If
		  Blueprint.Availability = Dict.Value("availability").UInt64Value
		  Blueprint.Label = Dict.Value("label").StringValue
		  Blueprint.ModID = ModInfo.Value("id").StringValue
		  Blueprint.ModName = ModInfo.Value("name").StringValue
		  Blueprint.Tags = Tags
		  
		  // Let the blueprint grab whatever additional data it needs
		  Blueprint.Unpack(Dict)
		  
		  Return Blueprint
		  
		  Exception Err As RuntimeException
		    Return Nil
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

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, RequiredHeaders() As String) As String()
		  Var MissingHeaders() As String
		  For Each RequiredHeader As String In RequiredHeaders
		    If Content.IndexOf(RequiredHeader) = -1 Then
		      MissingHeaders.Add(RequiredHeader)
		    End If
		  Next
		  MissingHeaders.Sort
		  Return MissingHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, Filename As String) As String()
		  Var RequiredHeaders() As String
		  If Filename = Beacon.ConfigFileGame Then
		    RequiredHeaders = Array("[/script/shootergame.shootergamemode]")
		  ElseIf Filename = Beacon.ConfigFileGameUserSettings Then
		    RequiredHeaders = Array("[SessionSettings]", "[ServerSettings]", "[/Script/ShooterGame.ShooterGameUserSettings]")
		  End If
		  Return Beacon.ValidateIniContent(Content, RequiredHeaders)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForDocument(Extends Blueprint As Beacon.Blueprint, Document As Beacon.Document) As Boolean
		  Return (Document Is Nil) = False And Document.ModEnabled(Blueprint.ModID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Extends Blueprint As Beacon.Blueprint, Map As Beacon.Map) As Boolean
		  Return Map = Nil Or Blueprint.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Extends Source As Beacon.LootSource, Map As Beacon.Map) As Boolean
		  Return Source.ValidForMask(Map.Mask)
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
		  Return Mask = CType(0, UInt64) Or (Blueprint.Availability And Mask) > CType(0, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Extends Source As Beacon.LootSource, Mask As UInt64) As Boolean
		  Return (Source.Availability And Mask) > CType(0, UInt64)
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
		    Var Domain As String = "https://lab.usebeacon.app"
		  #else
		    Var Domain As String = "https://usebeacon.app"
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

	#tag Constant, Name = ConfigFileGame, Type = String, Dynamic = False, Default = \"Game.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileGameUserSettings, Type = String, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DefaultPrettyDecimals, Type = Double, Dynamic = False, Default = \"9", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DefaultPrettyLocalized, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FileExtensionAuth, Type = String, Dynamic = False, Default = \".beaconauth", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionCSV, Type = String, Dynamic = False, Default = \".csv", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionDelta, Type = String, Dynamic = False, Default = \".beacondata", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionIdentity, Type = String, Dynamic = False, Default = \".beaconidentity", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionINI, Type = String, Dynamic = False, Default = \".ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionJSON, Type = String, Dynamic = False, Default = \".json", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionPlainText, Type = String, Dynamic = False, Default = \".txt", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionPreset, Type = String, Dynamic = False, Default = \".beaconpreset", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionProject, Type = String, Dynamic = False, Default = \".beacon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RewriteModeGameIni, Type = String, Dynamic = False, Default = \"Game.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RewriteModeGameUserSettingsIni, Type = String, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SecondsPerDay, Type = Double, Dynamic = False, Default = \"86400", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SecondsPerHour, Type = Double, Dynamic = False, Default = \"3600", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SecondsPerMinute, Type = Double, Dynamic = False, Default = \"60", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ServerSettingsHeader, Type = String, Dynamic = False, Default = \"ServerSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ShooterGameHeader, Type = String, Dynamic = False, Default = \"/script/shootergame.shootergamemode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UnknownBlueprintPrefix, Type = String, Dynamic = False, Default = \"/Game/BeaconUserBlueprints/", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = URLScheme, Type = String, Dynamic = False, Default = \"beacon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserModID, Type = String, Dynamic = False, Default = \"23ecf24c-377f-454b-ab2f-d9d8f31a5863", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserModName, Type = String, Dynamic = False, Default = \"User Blueprints", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserModWorkshopID, Type = Double, Dynamic = False, Default = \"3971430332", Scope = Protected
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
