#tag Module
Protected Module Beacon
	#tag Method, Flags = &h0
		Sub AddClipboardData(Extends Board As Clipboard, Type As String, Dicts() As Dictionary)
		  Var Wrapper As New Dictionary
		  Wrapper.Value("type") = Type
		  Wrapper.Value("data") = Dicts
		  
		  Board.Text = Beacon.GenerateJson(Wrapper, True)
		  Board.RawData(Type) = Beacon.GenerateJson(Dicts, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddClipboardData(Extends Board As Clipboard, Type As String, Dict As Dictionary)
		  Var Wrapper As New Dictionary
		  Wrapper.Value("type") = Type
		  Wrapper.Value("data") = Dict
		  
		  Board.Text = Beacon.GenerateJson(Wrapper, True)
		  Board.RawData(Type) = Beacon.GenerateJson(Dict, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddClipboardData(Extends Board As Clipboard, Type As String, Data As JSONItem)
		  Var Wrapper As New JSONItem
		  Wrapper.Value("type") = Type
		  Wrapper.Value("data") = Data
		  Wrapper.Compact = False
		  
		  Var Compact As Boolean = Data.Compact
		  Data.Compact = True
		  
		  Board.Text = Wrapper.ToString
		  Board.RawData(Type) = Data.ToString
		  
		  Data.Compact = Compact
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

	#tag Method, Flags = &h21
		Private Function BuildExport(ContentPacks() As Beacon.ContentPack, Archive As Beacon.Archive, IsUserData As Boolean) As Boolean
		  Var Filenames() As String
		  Var ArkDataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var ArkSADataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  For Each ContentPack As Beacon.ContentPack In ContentPacks
		    Select Case ContentPack.GameId
		    Case Ark.Identifier
		      Var Blueprints() As Ark.Blueprint = ArkDataSource.GetBlueprints("", New Beacon.StringList(ContentPack.ContentPackId), Nil)
		      Var Filename As String = Ark.AddToArchive(Archive, ContentPack, Blueprints)
		      If Filename.IsEmpty = False Then
		        Filenames.Add(Filename)
		      End If
		    Case ArkSA.Identifier
		      Var Blueprints() As ArkSA.Blueprint = ArkSADataSource.GetBlueprints("", New Beacon.StringList(ContentPack.ContentPackId), Nil)
		      Var Filename As String = ArkSA.AddToArchive(Archive, ContentPack, Blueprints)
		      If Filename.IsEmpty = False Then
		        Filenames.Add(Filename)
		      End If
		    End Select
		  Next
		  If Filenames.Count = 0 Then
		    Return False
		  End If
		  Filenames.Sort
		  
		  Var Manifest As New Dictionary
		  Manifest.Value("version") = 7
		  Manifest.Value("minVersion") = 7
		  Manifest.Value("generatedWith") = App.BuildNumber
		  Manifest.Value("isFull") = False
		  Manifest.Value("files") = Filenames
		  Manifest.Value("isUserData") = IsUserData
		  Archive.AddFile("Manifest.json", Beacon.GenerateJson(Manifest, False))
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(ContentPacks() As Beacon.ContentPack, IsUserData As Boolean) As MemoryBlock
		  If ContentPacks Is Nil Or ContentPacks.Count = 0 Then
		    App.Log("Could not export blueprints because there are no mods to export.")
		    Return Nil
		  End If
		  
		  Var Archive As Beacon.Archive = Beacon.Archive.Create()
		  Var Success As Boolean = BuildExport(ContentPacks, Archive, IsUserData)
		  Var Mem As MemoryBlock = Archive.Finalize
		  If Success Then
		    Return Mem
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(ContentPacks() As Beacon.ContentPack, Destination As FolderItem, IsUserData As Boolean) As Boolean
		  If ContentPacks Is Nil Or ContentPacks.Count = 0 Or Destination Is Nil Then
		    App.Log("Could not export blueprints because the destination is invalid or there are no mods to export.")
		    Return False
		  End If
		  
		  Var Temp As FolderItem = FolderItem.TemporaryFile
		  Var Archive As Beacon.Archive = Beacon.Archive.Create(Temp)
		  Var Success As Boolean = BuildExport(ContentPacks, Archive, IsUserData)
		  Call Archive.Finalize
		  
		  If Success Then
		    Try
		      If Destination.Exists Then
		        Destination.Remove
		      End If
		      Temp.MoveTo(Destination)
		      Return True
		    Catch Err As RuntimeException
		      Return False
		    End Try
		  End If
		  
		  Try
		    Temp.Remove
		  Catch Err As RuntimeException
		  End Try
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(IsUserData As Boolean, ParamArray ContentPacks() As Beacon.ContentPack) As MemoryBlock
		  Return BuildExport(ContentPacks, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(Destination As FolderItem, IsUserData As Boolean, ParamArray ContentPacks() As Beacon.ContentPack) As Boolean
		  Return BuildExport(ContentPacks, Destination, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildPath(Components() As String) As String
		  Return String.FromArray(Components, Beacon.PathSeparator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildPath(ParamArray Components() As String) As String
		  Return Beacon.BuildPath(Components)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BytesToString(Bytes As Double, Locale As Locale = Nil) As String
		  If Bytes < 1024 Then
		    Return Bytes.ToString(Locale, "#,##0") + " Bytes"
		  End If
		  
		  Var Kibibytes As Double = Bytes / 1024
		  If Kibibytes < 1024 Then
		    Return Kibibytes.ToString(Locale, "#,##0.00") + " KiB"
		  End If
		  
		  Var Mebibytes As Double = Kibibytes / 1024
		  If Mebibytes < 1024 Then
		    Return Mebibytes.ToString(Locale, "#,##0.00") + " MiB"
		  End If
		  
		  // Let's be real, Beacon isn't going to be dealing with values greater than
		  // Mebibytes, but here's the logic just in case.
		  
		  Var Gibibytes As Double = Mebibytes / 1024
		  If Gibibytes < 1024 Then
		    Return Gibibytes.ToString(Locale, "#,##0.00") + " GiB"
		  End If
		  
		  Var Tebibytes As Double = Gibibytes / 1024
		  Return Tebibytes.ToString(Locale, "#,##0.00") + " TiB"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CaseSensitiveSort(LeftValue As String, RightValue As String) As Integer
		  Return LeftValue.Compare(RightValue, ComparisonOptions.CaseSensitive)
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
		Protected Function ConfigHelpPath(ConfigGroup As Beacon.ConfigGroup) As String
		  Return ConfigHelpPath(ConfigGroup.InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigHelpPath(ConfigName As String) As String
		  Var GameId, Slug As String
		  
		  // Weird at the moment because we don't need to special-case anything
		  Select Case ConfigName
		  Else
		    Var Parts() As String = ConfigName.Split(".")
		    If Parts.Count < 2 Then
		      Return "/"
		    End If
		    
		    GameId = Parts(0)
		    
		    Var Replacer As New Regex
		    Replacer.SearchPattern = "[A-Z0-9]+"
		    Replacer.ReplacementPattern = " $0"
		    Replacer.Options.ReplaceAllMatches = True
		    Replacer.Options.CaseSensitive = True
		    
		    Slug = Replacer.Replace(Parts(1))
		    
		    Replacer.SearchPattern = "\s+"
		    Replacer.ReplacementPattern = "_"
		    Slug = Replacer.Replace(Slug.Trim)
		  End Select
		  
		  Return "/configs/" + EncodeURLComponent(GameId.Lowercase) + "/" + EncodeURLComponent(Slug.Lowercase) + "/"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackIds(Extends ContentPacks() As Beacon.ContentPack) As String()
		  Var Ids() As String
		  Ids.ResizeTo(ContentPacks.LastIndex)
		  For Idx As Integer = 0 To ContentPacks.LastIndex
		    If ContentPacks(Idx) Is Nil Then
		      Continue
		    End If
		    Ids(Idx) = ContentPacks(Idx).ContentPackId
		  Next
		  Return Ids
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CurseForgeApiKey() As String
		  Static ApiKey As String
		  If ApiKey.IsEmpty Then
		    #if DebugBuild
		      Var Chars As String = App.ResourcesFolder.Child("CurseForge.txt").Read
		    #else
		      Var Chars As String = CurseForgeApiKeyEncoded
		    #endif
		    ApiKey = DefineEncoding(DecodeBase64(Chars.Middle(0, 1) + Chars.Middle(3, 1) + Chars.Middle(0, 1) + Chars.Middle(38, 1) + Chars.Middle(0, 1) + Chars.Middle(3, 1) + Chars.Middle(5, 1) + Chars.Middle(34, 1) + Chars.Middle(0, 1) + Chars.Middle(3, 1) + Chars.Middle(38, 1) + Chars.Middle(6, 1) + Chars.Middle(33, 1) + Chars.Middle(18, 1) + Chars.Middle(35, 1) + Chars.Middle(40, 1) + Chars.Middle(35, 1) + Chars.Middle(5, 1) + Chars.Middle(0, 1) + Chars.Middle(28, 1) + Chars.Middle(19, 1) + Chars.Middle(5, 1) + Chars.Middle(25, 1) + Chars.Middle(12, 1) + Chars.Middle(35, 1) + Chars.Middle(8, 1) + Chars.Middle(29, 1) + Chars.Middle(41, 1) + Chars.Middle(17, 1) + Chars.Middle(27, 1) + Chars.Middle(22, 1) + Chars.Middle(11, 1) + Chars.Middle(19, 1) + Chars.Middle(7, 1) + Chars.Middle(35, 1) + Chars.Middle(22, 1) + Chars.Middle(22, 1) + Chars.Middle(32, 1) + Chars.Middle(14, 1) + Chars.Middle(2, 1) + Chars.Middle(27, 1) + Chars.Middle(31, 1) + Chars.Middle(14, 1) + Chars.Middle(4, 1) + Chars.Middle(22, 1) + Chars.Middle(24, 1) + Chars.Middle(38, 1) + Chars.Middle(20, 1) + Chars.Middle(1, 1) + Chars.Middle(13, 1) + Chars.Middle(25, 1) + Chars.Middle(22, 1) + Chars.Middle(17, 1) + Chars.Middle(36, 1) + Chars.Middle(0, 1) + Chars.Middle(32, 1) + Chars.Middle(33, 1) + Chars.Middle(16, 1) + Chars.Middle(16, 1) + Chars.Middle(24, 1) + Chars.Middle(1, 1) + Chars.Middle(26, 1) + Chars.Middle(9, 1) + Chars.Middle(37, 1) + Chars.Middle(36, 1) + Chars.Middle(36, 1) + Chars.Middle(15, 1) + Chars.Middle(3, 1) + Chars.Middle(21, 1) + Chars.Middle(25, 1) + Chars.Middle(30, 1) + Chars.Middle(11, 1) + Chars.Middle(21, 1) + Chars.Middle(10, 1) + Chars.Middle(16, 1) + Chars.Middle(19, 1) + Chars.Middle(2, 1) + Chars.Middle(30, 1) + Chars.Middle(39, 1) + Chars.Middle(23, 1)),Encodings.UTF8)
		  End If
		  Return ApiKey
		End Function
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

	#tag Method, Flags = &h1
		Protected Function DetectGame(File As FolderItem) As String
		  Try
		    Var Content As String = File.Read
		    Return DetectGame(Content)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DetectGame(Content As String) As String
		  // At the moment there is only one game supported, so the logic is really simple
		  
		  If Content.BeginsWith("<?xml") Then
		    Return SDTD.Identifier
		  Else
		    Return Ark.Identifier
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
		    Var Err As New NilObjectException
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

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Candidates() As Beacon.DisambiguationCandidate, Mask As UInt64, GuaranteedMembers() As Beacon.DisambiguationCandidate = Nil) As Dictionary
		  Var Mapper As New SQLiteDatabase
		  Mapper.Connect
		  Mapper.ExecuteSQL("CREATE TABLE labels (id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, suffix TEXT COLLATE NOCASE NOT NULL);")
		  Mapper.ExecuteSQL("CREATE INDEX labels_label_idx ON labels(label);")
		  
		  Var Results As New Dictionary
		  For Idx As Integer = 0 To Candidates.LastIndex
		    If (Candidates(Idx).DisambiguationMask And Mask) = CType(0, UInt64) Then
		      Continue For Idx
		    End If
		    
		    Results.Value(Candidates(Idx).DisambiguationId) = Candidates(Idx).Label
		    Mapper.ExecuteSQL("INSERT OR IGNORE INTO labels (id, label, suffix) VALUES (?1, ?2, ?3);", Candidates(Idx).DisambiguationId, Candidates(Idx).Label, Candidates(Idx).DisambiguationSuffix(Mask))
		  Next
		  
		  If (GuaranteedMembers Is Nil) = False Then
		    For Each Candidate As Beacon.DisambiguationCandidate In GuaranteedMembers
		      Results.Value(Candidate.DisambiguationId) = Candidate.Label
		      Mapper.ExecuteSQL("INSERT OR IGNORE INTO labels (id, label, suffix) VALUES (?1, ?2, ?3);", Candidate.DisambiguationId, Candidate.Label, Candidate.DisambiguationSuffix(Mask))
		    Next
		  End If
		  
		  Var Labels As New Dictionary
		  For Each Candidate As Beacon.DisambiguationCandidate In Candidates
		    If Labels.HasKey(Candidate.DisambiguationId) Then
		      // No need to check this one again
		      Continue
		    End If
		    
		    Var CommonLabel As String = Candidate.Label
		    Var SiblingRows As RowSet = Mapper.SelectSQL("SELECT id, suffix FROM labels WHERE label = ?1;", CommonLabel)
		    If SiblingRows.RowCount = 1 Then
		      // Unique already
		      Labels.Value(SiblingRows.Column("id").StringValue) = CommonLabel
		      Continue
		    End If
		    
		    For Each SiblingRow As DatabaseRow In SiblingRows
		      Var Id As String = SiblingRow.Column("id").StringValue
		      Var Suffix As String = SiblingRow.Column("suffix").StringValue
		      Labels.Value(Id) = CommonLabel + " (" + Suffix + ")"
		    Next
		  Next
		  
		  Return Labels
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
		Function ExceptionsFolder(Extends Target As Beacon.Application, Create As Boolean = True) As FolderItem
		  Var ErrorsFolder As FolderItem = Target.ApplicationSupport.Child("Errors")
		  Call ErrorsFolder.CheckIsFolder(Create)
		  Return ErrorsFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueLabel(DesiredLabel As String, Siblings() As String) As String
		  If Siblings.IndexOf(DesiredLabel) = -1 Then
		    // Not in the array
		    Return DesiredLabel
		  End If
		  
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
		Protected Function FlagsForGameId(GameId As String) As Integer
		  Var Games() As Beacon.Game = Beacon.Games
		  For Each Game As Beacon.Game In Games
		    If Game.Identifier = GameId Then
		      Return Game.Flags
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Games() As Beacon.Game()
		  Static GameList() As Beacon.Game
		  If GameList.Count = 0 Then
		    GameList.Add(New Beacon.Game(Ark.Identifier, Ark.FullName, Ark.OmniFlag, Beacon.Game.FeatureTemplates Or Beacon.Game.FeatureMods Or Beacon.Game.FeatureModDiscovery))
		    #if SDTD.Enabled
		      GameList.Add(New Beacon.Game(SDTD.Identifier, SDTD.FullName, SDTD.OmniFlag, 0))
		    #endif
		    #if ArkSA.Enabled
		      GameList.Add(New Beacon.Game(ArkSA.Identifier, ArkSA.FullName, ArkSA.OmniFlag, Beacon.Game.FeatureTemplates Or Beacon.Game.FeatureMods))
		    #endif
		    #if Palworld.Enabled
		      GameList.Add(New Beacon.Game(Palworld.Identifier, Palworld.FullName, Palworld.OmniFlag, 0))
		    #endif
		    
		    Var Names() As String
		    Names.ResizeTo(GameList.LastIndex)
		    For Idx As Integer = Names.FirstIndex To Names.LastIndex
		      Names(Idx) = GameList(Idx).Name
		    Next
		    Names.SortWith(GameList)
		  End If
		  Return GameList
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateJSON(Source As Variant, Pretty As Boolean) As String
		  Const UseMBS = False
		  
		  #if UseMBS 
		    Var Temp As JSONMBS = JSONMBS.Convert(Source)
		    Return Temp.ToString(Pretty)
		  #else
		    If Source.Type = Variant.TypeObject And Source.ObjectValue IsA JSONItem Then
		      Var Item As JSONItem = Source
		      Var OriginalCompact As Boolean = Item.Compact
		      Item.Compact = Not Pretty
		      Var Json As String = Item.ToString()
		      Item.Compact = OriginalCompact
		      Return Json
		    End If
		    
		    Var Result As String = Xojo.GenerateJSON(Source, Pretty)
		    #if TargetARM And XojoVersion < 2022.01
		      If Pretty Then
		        // feedback://showreport?report_id=66705
		        Var Temp As New JSONMBS(Result)
		        Result = Temp.ToString(True)
		      End If
		    #endif
		    Return Result
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateRandomKey(CharacterCount As Integer = 12, Pool As String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") As String
		  Var Rand As Random = System.Random
		  Var PoolMax As Integer = Pool.Length - 1
		  Var Chars() As String
		  For Idx As Integer = 1 To CharacterCount
		    Var Offset As Integer = Rand.InRange(0, PoolMax)
		    Chars.Add(Pool.Middle(Offset, 1))
		  Next
		  Return String.FromArray(Chars, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetClipboardData(Extends Board As Clipboard, Type As String) As Variant
		  If Board.RawDataAvailable(Type) Then
		    Try
		      Return Beacon.ParseJson(Board.RawData(Type))
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  
		  If Board.TextAvailable = False Then
		    Return Nil
		  End If
		  
		  Try
		    Var Parsed As Variant = Beacon.ParseJson(Board.Text)
		    If Parsed.Type <> Variant.TypeObject Or (Parsed.ObjectValue IsA Dictionary) = False Then
		      Return Nil
		    End If
		    
		    Var Dict As Dictionary = Dictionary(Parsed.ObjectValue)
		    If Dict.Lookup("type", "").StringValue <> Type Or Dict.HasKey("data") = False Then
		      Return Nil
		    End If
		    
		    Return Dict.Value("data")
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetClipboardDataAsJSON(Extends Board As Clipboard, Type As String) As JSONItem
		  If Board.RawDataAvailable(Type) Then
		    Try
		      Return New JSONItem(Board.RawData(Type))
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  
		  If Board.TextAvailable = False Then
		    Return Nil
		  End If
		  
		  Try
		    Var Parsed As New JSONItem(Board.Text)
		    If Parsed.IsArray Then
		      Return Nil
		    End If
		    
		    If Parsed.Lookup("type", "").StringValue <> Type Or Parsed.HasKey("data") = False Then
		      Return Nil
		    End If
		    
		    Return Parsed.Child("data")
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
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

	#tag Method, Flags = &h0
		Function GuessEncoding(Extends Value As String, TestValue As String) As String
		  // This function will check for UTF-8 and UTF-16 Byte Order Marks,
		  // remove them, and convert to UTF-8.
		  
		  If Value.IsEmpty Then
		    Return ""
		  End If
		  
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
		      Try
		        #Pragma BreakOnExceptions False
		        If TestVersion.IndexOf(TestValue) > -1 Then
		          Return TestVersion.ConvertEncoding(Encodings.UTF8)
		        End If
		      Catch Err As RuntimeException
		        // IndexOf firing exceptions is stupid
		      End Try
		    Next
		    
		    // Who knows what the heck it could be, so it's ASCII now.
		    Return Value.DefineEncoding(Encodings.ASCII).ConvertEncoding(Encodings.UTF8)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HardwareId() As String
		  Return HardwareId(Preferences.HardwareIdVersion)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HardwareId(Version As Integer) As String
		  #if TargetMacOS
		    #Pragma Unused Version
		    Return SystemInformationMBS.MacUUID.Lowercase
		  #elseif TargetWindows Or TargetLinux
		    Var Pieces(3) As String = Array(SystemInformationMBS.HardDiscSerial, SystemInformationMBS.CPUBrandString, "", SystemInformationMBS.WinProductKey)
		    If Version >= 6 Then
		      Pieces(2) = Preferences.DeviceSalt
		    Else
		      Pieces(2) = SystemInformationMBS.MACAddress
		    End If
		    Var Source As String = String.FromArray(Pieces, ":")
		    If Version >= 5 Then
		      Return Beacon.UUID.v5(Source)
		    Else
		      Return Beacon.UUID.v4(Crypto.HashAlgorithms.MD5, Source)
		    End If
		  #elseif TargetiOS
		    #Pragma Unused Version
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
		    #Pragma Unused Version
		    #Pragma Error "HardwareID not implemented for this platform"
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasClipboardData(Extends Board As Clipboard, Type As String) As Boolean
		  If Board.RawDataAvailable(Type) Then
		    Return True
		  End If
		  
		  If Board.TextAvailable = False Then
		    Return False
		  End If
		  
		  Var Contents As String = Board.Text
		  Return Contents.Contains("""type"": """ + Type + """")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Hash(Block As MemoryBlock) As String
		  Return EncodeHex(Crypto.SHA2_512(Block)).DefineEncoding(Encodings.UTF8).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HelpURL(Path As String = "/") As String
		  Const NewHelpSystem = True
		  
		  If Path.IsEmpty Or Path.BeginsWith("/") = False Then
		    Path = "/" + Path
		  End If
		  
		  #if Not NewHelpSystem
		    Return Beacon.WebURL("/help/" + App.BuildVersion + Path)
		  #endif
		  
		  If Path = "/config_sets" Then
		    Path = "/core/configsets/"
		  End If
		  
		  #if DebugBuild And App.ForceLiveData = False
		    Var Domain As String = "http://127.0.0.1:4000"
		  #else
		    Var Domain As String = "https://help.usebeacon.app"
		  #endif
		  
		  Return Domain + Path
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
		Function IsTruthy(Extends Value As Variant) As Boolean
		  Try
		    If IsNumeric(Value) Then
		      Return Value.DoubleValue = 1.0
		    End If
		    
		    Select Case Value.Type
		    Case Variant.TypeBoolean
		      Return Value.BooleanValue
		    Case Variant.TypeString, Variant.TypeText
		      Var StringValue As String = Value.StringValue
		      Return StringValue = "True" Or StringValue = "t"
		    Else
		      Return False
		    End Select
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex(Extends Target As Beacon.Countable) As Integer
		  Return Target.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MakeHumanReadable(Source As String) As String
		  Var Chars() As String
		  Var SourceChars() As String = Source.Split("")
		  Var LastCapital As Boolean
		  Var NewWord As Boolean = True
		  For Each Char As String In SourceChars
		    Var Codepoint As Integer = Char.Asc
		    If (Codepoint >= 48 And Codepoint <= 57) Or (Codepoint >= 97 And Codepoint <= 122) Then
		      If LastCapital Then
		        Chars.AddAt(Chars.LastIndex, " ")
		      End If
		      If NewWord Then
		        Char = Char.Uppercase
		      End If
		      Chars.Add(Char)
		      LastCapital = False
		      NewWord = False
		    ElseIf CodePoint >= 65 And Codepoint <= 90 Then
		      If LastCapital = False Then
		        Chars.Add(" ")
		      End If
		      Chars.Add(Char)
		      LastCapital = True
		      NewWord = False
		    ElseIf CodePoint = 95 Or Codepoint = 32 Then // Underscore and space
		      Chars.Add(" ")
		      LastCapital = False
		      NewWord = True
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
		Function MapIds(Extends Maps() As Beacon.Map) As String()
		  Var Ids() As String
		  For Each Map As Beacon.Map In Maps
		    Ids.Add(Map.MapId)
		  Next
		  Return Ids
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MD5(Value As MemoryBlock) As String
		  Return EncodeHex(Crypto.MD5(Value))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Merge(Array1() As Ark.Engram, Array2() As Ark.Engram) As Ark.Engram()
		  Var Unique As New Dictionary
		  For Each Engram As Ark.Engram In Array1
		    Unique.Value(Engram.EngramId) = Engram
		  Next
		  For Each Engram As Ark.Engram In Array2
		    Unique.Value(Engram.EngramId) = Engram
		  Next
		  Var Merged() As Ark.Engram
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Merge(LeftArray() As Beacon.Map, RightArray() As Beacon.Map) As Beacon.Map()
		  Var Merged() As Beacon.Map
		  For Each Map As Beacon.Map In LeftArray
		    Merged.Add(Map)
		  Next
		  For Each Map As Beacon.Map In RightArray
		    Merged.Add(Map)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Extends LeftArray() As Beacon.Map, RightArray() As Beacon.Map) As Beacon.Map()
		  Return Merge(LeftArray, RightArray)
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
		Protected Function OSName() As String
		  #if TargetMacOS
		    Return "macOS"
		  #elseif TargetWindows
		    Return "Windows"
		  #elseif TargetLinux
		    Return "Linux"
		  #else
		    #Pragma Error "Not implemented"
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OSVersionString() As String
		  #if TargetMacOS Or TargetWindows
		    Return SystemInformationMBS.OSVersionString
		  #elseif TargetLinux
		    Var Sh As New Shell
		    Sh.Execute("cat /etc/os-release")
		    Var Reg As New Regex
		    Reg.SearchPattern = "PRETTY_NAME=""([^\n""]+)"""
		    
		    Var Matches As RegexMatch = Reg.Search(Sh.Result.Trim)
		    If (Matches Is Nil) = False Then
		      Return Matches.SubExpressionString(1)
		    Else
		      // The information returned by this method is kind of useless, but something
		      Return SystemInformationMBS.OSVersionString
		    End If
		  #else
		    #Pragma Error "Not implemented"
		  #endif
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
		    Source = Source.DefineEncoding(Encodings.UTF8)
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
		Protected Function ParseQueryString(QueryString As String) As Dictionary
		  // Does not handle multiple parameters of the same name
		  
		  QueryString = QueryString.Trim
		  
		  If QueryString.BeginsWith("?") Then
		    QueryString = QueryString.Middle(1)
		  End If
		  
		  Var Params As New Dictionary
		  Var Parts() As String = QueryString.Split("&")
		  For Each Part As String In Parts
		    Var Pos As Integer = Part.IndexOf("=")
		    If Pos = -1 Then
		      Params.Value(DecodeURLComponent(Part)) = True
		      Continue
		    End If
		    
		    Var Key As String = DecodeURLComponent(Part.Left(Pos)).DefineEncoding(Encodings.UTF8)
		    Var Value As String = DecodeURLComponent(Part.Middle(Pos + 1)).DefineEncoding(Encodings.UTF8)
		    Params.Value(Key) = Value
		  Next
		  
		  Return Params
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
		Function Read(Extends File As FolderItem, Identity As Beacon.Identity) As MemoryBlock
		  // Do not catch exceptions here so that they bubble up
		  
		  Var Content As MemoryBlock = File.Read
		  If (Identity Is Nil) = False And BeaconEncryption.IsEncrypted(Content) Then
		    Content = BeaconEncryption.SymmetricDecrypt(Identity.UserCloudKey, Content)
		  End If
		  If Beacon.IsCompressed(Content) Then
		    Content = Beacon.Decompress(Content)
		  End If
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SafeToInvoke(Callback As Variant) As Boolean
		  // Module methods will have a Nil target, but can never be weak. Non-weak methods are always safe to invoke.
		  Return Callback.IsNull = False And (GetDelegateWeakMBS(Callback) = False Or GetDelegateTargetMBS(Callback).IsNull = False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SanitizeFilename(Filename As String, MaxLength As Integer = 0) As String
		  Var Searcher As New Regex
		  Searcher.Options.ReplaceAllMatches = True
		  
		  // Remove path separators
		  Searcher.SearchPattern = "[/\\:]"
		  Searcher.ReplacementPattern = "-"
		  Filename = Searcher.Replace(Filename)
		  
		  // Remove control characters
		  Searcher.SearchPattern = "[<>""|?*\x00-\x1F]+"
		  Searcher.ReplacementPattern = ""
		  Filename = Searcher.Replace(Filename)
		  
		  // Remove lone hyphens
		  Searcher.SearchPattern = "(\s+-+)|(-+\s+)"
		  Searcher.ReplacementPattern = " "
		  Filename = Searcher.Replace(Filename)
		  
		  // Remove double whitespace
		  Searcher.SearchPattern = "\s{2,}"
		  Searcher.ReplacementPattern = " "
		  Filename = Searcher.Replace(Filename)
		  
		  // Windows doesn't seem to agree with trailing whitespace
		  Filename = Filename.Trim(EndOfLine.CRLF, EndOfLine.CR, EndOfLine.LF, ".", " ", Encodings.ASCII.Chr(9))
		  
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

	#tag Method, Flags = &h1
		Protected Function SanitizeText(Source As String, ASCIIOnly As Boolean = True) As String
		  Var Sanitizer As New RegEx
		  If ASCIIOnly Then
		    Sanitizer.SearchPattern = "[^\x0A\x0D\x20-\x7E]+"
		  Else
		    Sanitizer.SearchPattern = "[\x00-\x08\x0B-\x0C\x0E-\x1F\x7F]+"
		  End If
		  Sanitizer.ReplacementPattern = ""
		  If ASCIIOnly Then
		    Return Sanitizer.Replace(Source.SanitizeIni).ConvertEncoding(Encodings.ASCII)
		  Else
		    Return Sanitizer.Replace(Source.SanitizeIni)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondsToString(Human As Boolean, Intervals() As Double) As String
		  Var WithDays, WithHours, WithMinutes As Boolean = True
		  For Each Interval As Double In Intervals
		    WithDays = WithDays And Interval >= SecondsPerDay
		    WithHours = WithHours And Interval >= SecondsPerHour
		    WithMinutes = WithMinutes And Interval >= SecondsPerMinute
		  Next
		  
		  Var Values() As String
		  For Each Interval As Double In Intervals
		    Values.Add(SecondsToString(Interval, WithDays, WithHours, WithMinutes, Human))
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

	#tag Method, Flags = &h1
		Protected Function SecondsToString(Human As Boolean, ParamArray Intervals() As Double) As String
		  Return SecondsToString(Human, Intervals)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SecondsToString(ParamArray Intervals() As Double) As String
		  Return SecondsToString(False, Intervals)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SecondsToString(Seconds As Double, WithDays As Boolean, WithHours As Boolean, WithMinutes As Boolean, Human As Boolean) As String
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
		    Parts.Add(If(Human, Language.NounWithQuantity(Days, "day", "days"), Days.ToString(Locale.Raw, "0") + "d"))
		  End If
		  If Hours > 0 Then
		    Parts.Add(If(Human, Language.NounWithQuantity(Hours, "hour", "hours"), Hours.ToString(Locale.Raw, "0") + "h"))
		  End If
		  If Minutes > 0 Then
		    Parts.Add(If(Human, Language.NounWithQuantity(Minutes, "minute", "minutes"), Minutes.ToString(Locale.Raw, "0") + "m"))
		  End If
		  If Seconds > 0 Or (Parts.Count = 0 And Human) Then
		    Parts.Add(If(Human, Language.NounWithQuantity(Round(Seconds), "second", "seconds"), Seconds.PrettyText(False) + "s"))
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
		Function StringValue(Extends Dict As Dictionary, Key As Variant, Default As String, AllowArray As Boolean = False) As String
		  Return GetValueAsType(Dict, Key, "String", Default, AllowArray, AddressOf CoerceToString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SystemAccountName() As String
		  Return SystemInformationMBS.ShortUsername
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

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function ValueAdapter(ByRef Value As Variant, DesiredTypeName As String) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function VariantToString(Value As Variant) As String
		  #Pragma BreakOnExceptions False
		  
		  If Value.IsNull Then
		    Return "Null"
		  End If
		  
		  Select Case Value.Type
		  Case Variant.TypeDouble, Variant.TypeSingle
		    Return Value.DoubleValue.PrettyText(False)
		  Case Variant.TypeInt32, Variant.TypeInt64
		    Return Value.Int64Value.ToString(Locale.Raw, "0")
		  Case Variant.TypeString, Variant.TypeText
		    Return Value.StringValue
		  Case Variant.TypeBoolean
		    Return If(Value.BooleanValue, "True", "False")
		  Else
		    Return ""
		  End Select
		  
		  Exception
		    Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WebURL(Path As String = "/", Authenticate As Boolean = False) As String
		  #if DebugBuild And App.ForceLiveData = False
		    Var Domain As String = "https://local.usebeacon.app"
		  #else
		    Var Domain As String = "https://usebeacon.app"
		  #endif
		  
		  If Path.Length = 0 Or Path.Left(1) <> "/" Then
		    Path = "/" + Path
		  End If
		  
		  If Authenticate Then
		    Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		    If (Identity Is Nil) = False And Identity.IsAnonymous Then
		      Var Expiration As String = Ceiling(DateTime.Now.SecondsFrom1970 + 90).ToString(Locale.Raw, "0")
		      Var StringToSign As String = Identity.UserId + ";" + Expiration
		      Var Signature As String = Identity.Sign(StringToSign)
		      
		      Path = "/account/auth/app?path=" + EncodeURLComponent(Path) + "&userId=" + EncodeURLComponent(Identity.UserId) + "&expiration=" + EncodeURLComponent(Expiration) + "&signature=" + EncodeBase64URLMBS(Signature)
		    End If
		  End If
		  
		  Return Domain + Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function XmlMessage(Extends Err As XmlException) As String
		  Var ErrNum As Integer = Err.ErrorNumber
		  
		  If ErrNum = 2 Then
		    Return "Syntax error"
		  Else
		    Return Err.Message
		  End If
		End Function
	#tag EndMethod


	#tag Note, Name = Difficulty
		OverrideOfficialDifficulty determines the steps dino levels will take. For example, when set to 5.0,
		you will see levels 5, 10, 15, 20. When set to 10, levels will be 10, 20, 30, 40.
		
		This means computing the correct difficulty offset requires both the max dino level and the dino level
		step value.
		
	#tag EndNote


	#tag Constant, Name = CurseForgeApiKeyEncoded, Type = String, Dynamic = False, Default = \"Biggle bongos!", Scope = Private
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

	#tag Constant, Name = FileExtensionTemplate, Type = String, Dynamic = False, Default = \".beacontemplate", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FileExtensionXml, Type = String, Dynamic = False, Default = \".xml", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPModeExplicitTLS, Type = String, Dynamic = False, Default = \"ftp+tls", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPModeImplicitTLS, Type = String, Dynamic = False, Default = \"ftps", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPModeInsecure, Type = String, Dynamic = False, Default = \"ftp-tls", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPModeOptionalTLS, Type = String, Dynamic = False, Default = \"ftp", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPModeSSH, Type = String, Dynamic = False, Default = \"sftp", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MapTypeCanon, Type = String, Dynamic = False, Default = \"Official Canon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MapTypeNonCanon, Type = String, Dynamic = False, Default = \"Official Non-Canon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MapTypeThirdParty, Type = String, Dynamic = False, Default = \"Third Party", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MarketplaceCurseForge, Type = String, Dynamic = False, Default = \"CurseForge", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MarketplaceSteam, Type = String, Dynamic = False, Default = \"Steam", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MarketplaceSteamWorkshop, Type = String, Dynamic = False, Default = \"Steam Workshop", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PathSeparator, Type = String, Dynamic = False, Default = \"/", Scope = Protected
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"\\"
	#tag EndConstant

	#tag Constant, Name = Pi, Type = Double, Dynamic = False, Default = \"3.141592653589793", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformPC, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformPlayStation, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformSwitch, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformUniversal, Type = Double, Dynamic = False, Default = \"999", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformUnknown, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformUnsupported, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PlatformXbox, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PrettyPrintXsl, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<xsl:transform version\x3D\"1.0\" xmlns:xsl\x3D\"http://www.w3.org/1999/XSL/Transform\">\n      <xsl:output method\x3D\"xml\" indent\x3D\"yes\" />\n      <xsl:template match\x3D\"/\">\n              <xsl:copy-of select\x3D\"/\" />\n      </xsl:template>\n</xsl:transform>", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SecondsPerDay, Type = Double, Dynamic = False, Default = \"86400", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SecondsPerHour, Type = Double, Dynamic = False, Default = \"3600", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SecondsPerMinute, Type = Double, Dynamic = False, Default = \"60", Scope = Private
	#tag EndConstant

	#tag Constant, Name = URLScheme, Type = String, Dynamic = False, Default = \"beacon", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = DeployPlan, Type = Integer, Flags = &h1
		StopUploadStart
		  UploadRestart
		UploadOnly
	#tag EndEnum


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
