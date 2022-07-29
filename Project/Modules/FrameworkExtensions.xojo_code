#tag Module
Protected Module FrameworkExtensions
	#tag Method, Flags = &h0
		Function ActualStringHeight(Extends G As Graphics, Source As String, WrapWidth As Double) As Double
		  // G.StringHeight is not always correct. It should be G.TextHeight * LineCount,
		  // but it seems to be missing a pixel per line in most cases. This code will work
		  // around the issue, and will remain correct even if the bug is fixed.
		  
		  Var ExpectedLineHeight As Double = G.TextHeight
		  Var ActualLineHeight As Double = G.TextHeight("A", 100)
		  Var LineHeightDelta As Double = ExpectedLineHeight - ActualLineHeight
		  
		  Var Height As Double = G.TextHeight(Source, WrapWidth)
		  Var LineCount As Double = Height / ActualLineHeight
		  Return Height + (LineCount * LineHeightDelta)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddSuffix(Extends Title As String, Suffix As String) As String
		  Var Words() As String = Title.Split(" ")
		  If Words.LastIndex >= 0 And Words(Words.LastIndex) = Suffix Then
		    Words.Add("2")
		  ElseIf Words.LastIndex >= 1 And Words(Words.LastIndex - 1) = Suffix Then
		    Var CopyNum As Integer
		    #Pragma BreakOnExceptions Off
		    Try
		      CopyNum = Integer.FromString(Words(Words.LastIndex), Locale.Raw) + 1
		      Words(Words.LastIndex) = CopyNum.ToString(Locale.Raw, "0")
		    Catch Err As RuntimeException
		      Words.Add(Suffix)
		    End Try
		    #Pragma BreakOnExceptions Default
		  Else
		    Words.Add(Suffix)
		  End If
		  Return Words.Join(" ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Append(Extends Target As MemoryBlock, NewData As MemoryBlock)
		  If NewData = Nil Then
		    Return
		  End If
		  
		  Target.Size = Target.Size + NewData.Size
		  Target.StringValue(Target.Size - NewData.Size, NewData.Size) = NewData.StringValue(0, NewData.Size)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function Bottom(Extends Ctl As RectControl) As Integer
		  Return Ctl.Top + Ctl.Height
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Characters(Extends Source As String) As String()
		  Return Source.Split("")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CheckIsFolder(Extends Folder As FolderItem, Create As Boolean = True) As Boolean
		  If Folder.Exists Then
		    If Folder.IsFolder Then
		      Return True
		    Else
		      If Create = True Then
		        Folder.Remove
		        Folder.CreateFolder
		        Return True
		      Else
		        Return False
		      End If
		    End If
		  Else
		    If Create = True Then
		      Folder.CreateFolder
		      Return True
		    Else
		      Return False
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassName(Extends Err As RuntimeException) As String
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  If Info Is Nil Then
		    Return ""
		  End If
		  Return Info.FullName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Source As Dictionary) As Dictionary
		  // This method only exists because the built-in clone method causes crashes.
		  // However, this only handles basic cases.
		  
		  If Source = Nil Then
		    // That was easy
		    Return Nil
		  End If
		  
		  Var Clone As New Dictionary
		  For Each Entry As DictionaryEntry In Source
		    If Entry.Value <> Nil And Entry.Value IsA Dictionary Then
		      Clone.Value(Entry.Key) = Dictionary(Entry.Value).Clone()
		    Else
		      Clone.Value(Entry.Key) = Entry.Value
		    End If
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends Source As MemoryBlock) As MemoryBlock
		  Var Replica As New MemoryBlock(Source.Size)
		  Replica.LittleEndian = Source.LittleEndian
		  Replica.StringValue(0, Replica.Size) = Source.StringValue(0, Source.Size)
		  Return Replica
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends Source() As String) As String()
		  Var Result() As String
		  Result.ResizeTo(Source.LastIndex)
		  For I As Integer = 0 To Source.LastIndex
		    Result(I) = Source(I)
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Coalesce(ParamArray Values() As Variant) As Variant
		  For Idx As Integer = 0 To Values.LastIndex
		    If Values(Idx).IsNull = False Then
		      Return Values(Idx)
		    End If
		  Next Idx
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CompareValues(Value1 As Double, Value2 As Double) As Integer
		  If Value1 > Value2 Then
		    Return 1
		  ElseIf Value1 < Value2 Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub CorrectWindowPlacement(Extends Win As Window, Parent As Window)
		  #if TargetWindows
		    If Win = Nil Or Parent = Nil Then
		      Return
		    End If
		    
		    If Win.DefaultLocation = Window.Locations.ParentWindow Then
		      Win.Top = Parent.Top
		      Win.Left = Parent.Left + ((Parent.Width - Win.Width) / 2)
		    End If
		  #else
		    #Pragma Unused Win
		    #Pragma Unused Parent
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeepDelete(Extends File As FolderItem, FollowAlias As Boolean = True) As Boolean
		  If Not File.Exists Then
		    Return True
		  End If
		  
		  If FollowAlias = False And TargetWindows And WindowsJunctionMBS.IsDirectoryJunction(File) Then
		    If Not WindowsJunctionMBS.DeleteJunction(File) Then
		      Return False
		    End If
		  ElseIf File.IsFolder And (FollowAlias Or File.IsAlias = False) Then
		    For I As Integer = File.Count - 1 DownTo 0
		      If Not File.ChildAt(I, FollowAlias).DeepDelete(FollowAlias) Then
		        Return False
		      End If
		    Next
		  End If
		  
		  Try
		    File.Remove
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleValue(Extends Dict As Dictionary, Key As Variant, ResolveWithFirst As Boolean = False) As Double
		  Var Value As Variant = Dict.Value(Key)
		  Return VariantToDouble(Value, ResolveWithFirst)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explanation(Extends Err As RuntimeException) As String
		  If Err.Message <> "" Then
		    Return Err.Message
		  ElseIf Err.Message <> "" Then
		    Return Err.Message
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Extension(Extends File As FolderItem) As String
		  Var Name As String = File.Name
		  If Name.IndexOf(".") = -1 Then
		    Return ""
		  End If
		  
		  Var Parts() As String = Name.Split(".")
		  Return "." + Parts(Parts.LastIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtensionMatches(Extends File As FolderItem, ParamArray PossibleExtensions() As String) As Boolean
		  Return File.ExtensionMatches(PossibleExtensions)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtensionMatches(Extends File As FolderItem, PossibleExtensions() As String) As Boolean
		  For Each Extension As String In PossibleExtensions
		    If Extension.BeginsWith(".") = False Then
		      Extension = "." + Extension
		    End If
		    
		    If File.Extension = Extension Then
		      Return True
		    End If
		  Next Extension
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FieldAtPosition(Extends Source As String, Separator As String, OneBasedIndex As Integer) As String
		  Return FieldAtPosition(Source, Separator, OneBasedIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FieldAtPosition(Source As String, Separator As String, OneBasedIndex As Integer) As String
		  // Replaces NthField
		  Var Fields() As String = Source.Split(Separator)
		  Var Index As Integer = OneBasedIndex - 1
		  If Index < 0 Or Index > Fields.LastIndex Then
		    Return ""
		  Else
		    Return Fields(Index)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAllKeys(Extends Dict As Dictionary, ParamArray Keys() As Variant) As Boolean
		  For Each Key As Variant In Keys
		    If Dict.HasKey(Key) = False Then
		      Return False
		    End If
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAnyKey(Extends Dict As Dictionary, ParamArray Keys() As Variant) As Boolean
		  For Each Key As Variant In Keys
		    If Dict.HasKey(Key) = True Then
		      Return True
		    End If
		  Next
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(Extends Value As Variant) As Integer
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Value)
		  Select Case Info.Name
		  Case "Int8", "Int16", "Int32", "Int64", "UInt8", "UInt16", "UInt32", "UInt64"
		    Return Value
		  Case "Double", "Single"
		    Var DoubleValue As Double = Value
		    Return Round(DoubleValue)
		  Case "String"
		    Var StringValue As String = Value
		    Return Integer.FromString(StringValue, Locale.Raw)
		  Else
		    Return 0
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsWhite(Extends Source As Color) As Boolean
		  Return Source.Red >= 253 And Source.Green >= 253 And Source.Blue >= 253 And Source.Alpha = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(Extends Source() As String, Delimiter As String) As String
		  Return String.FromArray(Source, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(Extends Source As MemoryBlock, Length As Integer) As MemoryBlock
		  Return Source.Middle(0, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Left(Extends Target As MemoryBlock, Length As Integer, Assigns NewData As MemoryBlock)
		  Target.Middle(0, Length) = NewData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LocalTime(Extends Source As DateTime) As DateTime
		  Var Now As DateTime = DateTime.Now
		  Return New DateTime(Source.SecondsFrom1970, Now.Timezone)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MakeUTF8(Extends Source As String) As String
		  If Source.Encoding = Encodings.UTF8 Then
		    Return Source
		  End If
		  
		  If Source.Encoding Is Nil Then
		    If Encodings.UTF8.IsValidData(Source) Then
		      Return Source.DefineEncoding(Encodings.UTF8)
		    Else
		      Source = Source.DefineEncoding(Encodings.ASCII)
		    End If
		  End If
		  
		  Return Source.ConvertEncoding(Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Middle(Extends Source As MemoryBlock, Offset As Integer, Length As Integer) As MemoryBlock
		  Offset = Min(Offset, Source.Size)
		  Var Bound As Integer = Min(Offset + Length, Source.Size)
		  Length = Bound - Offset
		  
		  Var Mem As New MemoryBlock(Length)
		  Mem.LittleEndian = Source.LittleEndian
		  Mem.StringValue(0, Length) = Source.StringValue(Offset, Length)
		  Return Mem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Middle(Extends Source As MemoryBlock, Offset As Integer, Length As Integer, Assigns NewData As MemoryBlock)
		  If NewData = Nil Then
		    Return
		  End If
		  
		  Offset = Min(Offset, Source.Size)
		  Var Bound As Integer = Min(Offset + Length, Source.Size)
		  Var TailLength As Integer = Source.Size - Bound
		  Length = Bound - Offset
		  Var Delta As Integer = NewData.Size - Length
		  
		  If TailLength > 0 Then
		    If Delta > 0 Then
		      Source.Size = Source.Size + Delta
		    End If
		    Source.StringValue(Bound + Delta, TailLength) = Source.StringValue(Bound, TailLength)
		    If Delta < 0 Then
		      Source.Size = Source.Size + Delta
		    End If
		  ElseIf Delta <> 0 Then
		    Source.Size = Source.Size + Delta
		  End If
		  
		  Source.StringValue(Offset, NewData.Size) = NewData.StringValue(0, NewData.Size)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NearestMultiple(Value As Double, Factor As Double) As Double
		  // If this is already a whole number, there's no reason for more math.
		  Var Whole As Integer = Floor(Value)
		  If Whole = Value Then
		    Return Value
		  End If
		  
		  Return Round(Value * Factor) / Factor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NearestMultiple(Extends Original As Double, Factor As Double) As Double
		  Return NearestMultiple(Original, Factor)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewDateFromSQLDateTime(SQLDateTime As String) As DateTime
		  Var Now As DateTime = DateTime.Now
		  Now.SQLDateTimeWithOffset = SQLDateTime
		  Return Now
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Extends File As FolderItem) As MemoryBlock
		  #Pragma BreakOnExceptions False
		  Try
		    Const ChunkSize = 256000
		    
		    Var Stream As BinaryStream = BinaryStream.Open(File, False)
		    Var Contents As New MemoryBlock(Stream.Length)
		    Var Offset As Integer = 0
		    While Stream.EndOfFile = False
		      Var ReadBytes As Integer = Min(ChunkSize, Stream.Length - Offset)
		      Contents.StringValue(Offset, ReadBytes) = Stream.Read(ReadBytes, Nil)
		      Offset = Offset + ReadBytes
		    Wend
		    Stream.Close
		    
		    Return Contents
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Extends File As FolderItem, Encoding As TextEncoding) As String
		  Try
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As String = Stream.ReadAll(Encoding)
		    Stream.Close
		    Return Contents
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(Extends Source As MemoryBlock, Length As Integer) As MemoryBlock
		  Return Source.Middle(Source.Size - Length, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Right(Extends Target As MemoryBlock, Length As Integer, Assigns NewData As MemoryBlock)
		  Target.Middle(Target.Size - Length, Length) = NewData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function Right(Extends Ctl As RectControl) As Integer
		  Return Ctl.Left + Ctl.Width
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function SelectedRowTag(Extends Menu As PopupMenu) As Variant
		  If Menu.SelectedRowIndex > -1 Then
		    Return Menu.RowTagAt(Menu.SelectedRowIndex)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SQLDateTimeWithOffset(Extends Source As DateTime) As String
		  Var Zone As TimeZone = Source.Timezone
		  Var Offset As Double = Abs(Zone.SecondsFromGMT / 3600)
		  Var Hours As Integer = Floor(Offset)
		  Var Minutes As Integer = (Offset - Floor(Offset)) * 60
		  
		  Return Source.Year.ToString(Locale.Raw, "0000") + "-" + Source.Month.ToString(Locale.Raw, "00") + "-" + Source.Day.ToString(Locale.Raw, "00") + " " + Source.Hour.ToString(Locale.Raw, "00") + ":" + Source.Minute.ToString(Locale.Raw, "00") + ":" + Source.Second.ToString(Locale.Raw, "00") + If(Zone.SecondsFromGMT < 0, "-", "+") + Hours.ToString(Locale.Raw, "00") + ":" + Minutes.ToString(Locale.Raw, "00")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SQLDateTimeWithOffset(Extends Source As DateTime, Assigns Value As String)
		  Var Validator As New Regex
		  Validator.SearchPattern = "^(\d{4})-(\d{2})-(\d{2})( (\d{2}):(\d{2}):(\d{2})(\.\d+)?\s*((\+|-)(\d{1,2})(:?(\d{2}))?)?)?$"
		  
		  Var Matches As RegexMatch = Validator.Search(Value)
		  If Matches = Nil Then
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Invalid SQL timestamp"
		    Raise Err
		    Return
		  End If
		  
		  Var Year As Integer = Integer.FromString(Matches.SubExpressionString(1), Locale.Raw)
		  Var Month As Integer = Integer.FromString(Matches.SubExpressionString(2), Locale.Raw)
		  Var Day As Integer = Integer.FromString(Matches.SubExpressionString(3), Locale.Raw)
		  Var Hour As Integer
		  Var Minute As Integer
		  Var Second As Integer
		  Var Nanosecond As Integer
		  Var Offset As Double
		  Var ExpressionCount As Integer = Matches.SubExpressionCount
		  
		  If ExpressionCount >= 8 And Matches.SubExpressionString(4).IsEmpty = False Then
		    Hour = Integer.FromString(Matches.SubExpressionString(5), Locale.Raw)
		    Minute = Integer.FromString(Matches.SubExpressionString(6), Locale.Raw)
		    Second = Integer.FromString(Matches.SubExpressionString(7), Locale.Raw)
		    If ExpressionCount >= 9 Then
		      Nanosecond = Double.FromString("0" + Matches.SubExpressionString(8), Locale.Raw) * 1000000000
		    End If
		    
		    If ExpressionCount >= 12 And Matches.SubExpressionString(9).IsEmpty = False Then
		      Var OffsetHour As Integer = Integer.FromString(Matches.SubExpressionString(11), Locale.Raw)
		      Var OffsetMinute As Integer
		      If ExpressionCount >= 14 And Matches.SubExpressionString(13).IsEmpty = False Then
		        OffsetMinute = Integer.FromString(Matches.SubExpressionString(13), Locale.Raw)
		      End If
		      Offset = OffsetHour + (OffsetMinute / 60)
		      If Matches.SubExpressionString(10) = "-" Then
		        Offset = Offset * -1
		      End If
		    End If
		  End If
		  
		  Source.Constructor(Year, Month, Day, Hour, Minute, Second, Nanosecond, New TimeZone(Offset * 3600))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sum(Extends Values() As Double, ValueBetween As Double = 0) As Double
		  Var Total As Double
		  For Each Value As Double In Values
		    Total = Total + Value
		  Next
		  Return Total + (ValueBetween * (Values.Count - 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sum(Extends Values() As Integer, ValueBetween As Integer = 0) As Integer
		  Var Total As Integer
		  For Each Value As Integer In Values
		    Total = Total + Value
		  Next
		  Return Total + (ValueBetween * (Values.Count - 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToColor(Extends Source As String) As Color
		  Var RedHex, GreenHex, BlueHex, AlphaHex As String = "00"
		  If Source.Length = 3 Then
		    RedHex = Source.Middle(0, 1) + Source.Middle(0, 1)
		    GreenHex = Source.Middle(1, 1) + Source.Middle(1, 1)
		    BlueHex = Source.Middle(2, 1) + Source.Middle(2, 1)
		  ElseIf Source.Length = 4 Then
		    RedHex = Source.Middle(0, 1) + Source.Middle(0, 1)
		    GreenHex = Source.Middle(1, 1) + Source.Middle(1, 1)
		    BlueHex = Source.Middle(2, 1) + Source.Middle(2, 1)
		    AlphaHex = Source.Middle(3, 1) + Source.Middle(3, 1)
		  ElseIf Source.Length = 6 Then
		    RedHex = Source.Middle(0, 2)
		    GreenHex = Source.Middle(2, 2)
		    BlueHex = Source.Middle(4, 2)
		  ElseIf Source.Length = 8 Then
		    RedHex = Source.Middle(0, 2)
		    GreenHex = Source.Middle(2, 2)
		    BlueHex = Source.Middle(4, 2)
		    AlphaHex = Source.Middle(6, 2)
		  End If
		  Return Color.RGB(Integer.FromHex(RedHex), Integer.FromHex(GreenHex), Integer.FromHex(BlueHex), Integer.FromHex(AlphaHex))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToHex(Extends Source As Color) As String
		  Return Source.Red.ToHex(2).Lowercase + Source.Green.ToHex(2).Lowercase + Source.Blue.ToHex(2).Lowercase + Source.Alpha.ToHex(2).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(Extends Source As MemoryBlock) As String
		  If Source.Size = 0 Then
		    Return ""
		  Else
		    Return Source.StringValue(0, Source.Size)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ToString(Extends Source() As String) As String()
		  Var Result() As String
		  Result.ResizeTo(Source.LastIndex)
		  For I As Integer = 0 To Source.LastIndex
		    Result(I) = Source(I)
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalSeconds(Extends Interval As DateInterval) As Double
		  Var Now As DateTime = DateTime.Now(New TimeZone(0))
		  Var Future As DateTime = Now + Interval
		  Return Future.SecondsFrom1970 - Now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserVersion(Extends Source As SQLiteDatabase) As Integer
		  Var Results As RowSet = Source.SelectSQL("PRAGMA user_version;")
		  Return Results.ColumnAt(0).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserVersion(Extends Source As SQLiteDatabase, Assigns Value As Integer)
		  Source.ExecuteSQL("PRAGMA user_version = " + Value.ToString(Locale.Raw, "0") + ";")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function VariantToDouble(Value As Variant, ResolveWithFirst As Boolean = False) As Double
		  If Value = Nil Then
		    Return 0
		  End If
		  
		  If Value.IsArray Then
		    Var Elements() As Variant
		    Try
		      Elements = Value
		    Catch Err As RuntimeException
		    End Try
		    
		    Var Possibles() As Double
		    For Each Possible As Variant In Elements
		      Var Decoded As Double = VariantToDouble(Possible, ResolveWithFirst)
		      Possibles.Add(Decoded)
		    Next
		    If Possibles.LastIndex = -1 Then
		      Return 0
		    End If
		    If ResolveWithFirst Then
		      Return Possibles(0)
		    Else
		      Return Possibles(Possibles.LastIndex)
		    End If
		    
		    Return 0
		  End If
		  
		  // Try the simple thing
		  Try
		    Return Value.DoubleValue
		  Catch Err As RuntimeException
		  End Try
		  
		  Select Case Value.Type
		  Case Variant.TypeText
		    Return Double.FromText(Value.TextValue)
		  Case Variant.TypeString
		    Return Double.FromString(Value.TextValue)
		  Case Variant.TypeInt32
		    Return Value.Int32Value
		  Case Variant.TypeInt64
		    Return Value.Int64Value
		  Case Variant.TypeSingle
		    Return Value.SingleValue
		  End Select
		  
		  Exception Err As TypeMismatchException
		    Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Write(Extends File As FolderItem, Contents As MemoryBlock) As Boolean
		  Static Locks As Dictionary
		  If Locks = Nil Then
		    Locks = New Dictionary
		  End If
		  Var Lock As CriticalSection
		  If Locks.HasKey(File.NativePath) Then
		    Lock = Locks.Value(File.NativePath)
		  Else
		    Lock = New CriticalSection
		    Locks.Value(File.NativePath) = Lock
		  End If
		  
		  Try
		    Lock.Enter
		    
		    Var Stream As BinaryStream
		    If File.Exists Then
		      Stream = BinaryStream.Open(File, True)
		      Stream.BytePosition = 0
		      Stream.Length = 0
		    Else
		      Stream = BinaryStream.Create(File, True)
		    End If
		    
		    Var CurrentThread As Thread = Thread.Current
		    If CurrentThread = Nil Then
		      Stream.Write(Contents)
		    Else
		      Const ChunkSize = 1024000
		      For I As Integer = 0 To Contents.Size - 1 Step ChunkSize
		        Var Chunk As String = Contents.StringValue(I, Min(ChunkSize, Contents.Size - I))
		        Stream.Write(Chunk)
		        CurrentThread.Sleep(10)
		      Next
		    End If
		    Stream.Close
		    
		    File.ModificationDateTime = DateTime.Now
		    
		    Lock.Leave
		    Return True
		  Catch Err As RuntimeException
		    App.Log("Unable to write " + File.NativePath + ": " + Err.Message + " (" + Err.ErrorNumber.ToString(Locale.Raw, "0") + ")")
		    Lock.Leave
		    Return False
		  End Try
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
