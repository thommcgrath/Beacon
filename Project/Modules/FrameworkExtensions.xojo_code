#tag Module
Protected Module FrameworkExtensions
	#tag Method, Flags = &h0
		Function ActualStringHeight(Extends G As Graphics, Source As String, WrapWidth As Double) As Double
		  // G.StringHeight is not always correct. It should be G.TextHeight * LineCount,
		  // but it seems to be missing a pixel per line in most cases. This code will work
		  // around the issue, and will remain correct even if the bug is fixed.
		  
		  Dim ExpectedLineHeight As Double = G.TextHeight
		  Dim ActualLineHeight As Double = G.StringHeight("A", 100)
		  Dim LineHeightDelta As Double = ExpectedLineHeight - ActualLineHeight
		  
		  Dim Height As Double = G.StringHeight(Source, WrapWidth)
		  Dim LineCount As Double = Height / ActualLineHeight
		  Return Height + (LineCount * LineHeightDelta)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddSuffix(Extends Title As String, Suffix As String) As String
		  Dim Words() As String = Split(Title, " ")
		  If Words.Ubound >= 0 And Words(Words.Ubound) = Suffix Then
		    Words.Append("2")
		  ElseIf Words.Ubound >= 1 And Words(Words.Ubound - 1) = Suffix Then
		    Dim CopyNum As Integer
		    #Pragma BreakOnExceptions Off
		    Try
		      CopyNum = Val(Words(Words.Ubound)) + 1
		      Words(Words.Ubound) = Str(CopyNum, "0")
		    Catch Err As RuntimeException
		      Words.Append(Suffix)
		    End Try
		    #Pragma BreakOnExceptions Default
		  Else
		    Words.Append(Suffix)
		  End If
		  Return Join(Words, " ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Append(Extends Destination As MemoryBlock, Source As MemoryBlock)
		  If Source = Nil Then
		    Return
		  End If
		  
		  Destination.Size = Destination.Size + Source.Size
		  Destination.StringValue(Destination.Size - Source.Size, Source.Size) = Source.StringValue(0, Source.Size)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AutoToDouble(Value As Auto, ResolveWithFirst As Boolean = False) As Double
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Value)
		  Select Case Info.FullName
		  Case "Text"
		    Dim TextValue As String = Value
		    If TextValue = "" Then
		      Return 0
		    Else
		      Return Val(TextValue)
		    End If
		  Case "Double"
		    Dim DoubleValue As Double = Value
		    Return DoubleValue
		  Case "Single"
		    Dim SingleValue As Single = Value
		    Return SingleValue
		  Case "Int8", "Int16", "Int32", "Int64"
		    Dim IntegerValue As Int64 = Value
		    Return IntegerValue
		  Case "UInt8", "UInt16", "UInt32", "UInt64"
		    Dim UIntegerValue As UInt64 = Value
		    Return UIntegerValue
		  Case "Auto()"
		    Dim Arr() As Auto = Value
		    Dim Possibles() As Double
		    For Each Possible As Auto In Arr
		      Dim Decoded As Double = AutoToDouble(Possible, ResolveWithFirst)
		      Possibles.Append(Decoded)
		    Next
		    If Possibles.Ubound = -1 Then
		      Return 0
		    End If
		    If ResolveWithFirst Then
		      Return Possibles(0)
		    Else
		      Return Possibles(Possibles.Ubound)
		    End If
		  Else
		    Break
		  End Select
		  
		  Exception Err As TypeMismatchException
		    Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeginsWith(Extends Source As String, Other As String) As Boolean
		  Return Left(Source, Len(Other)) = Other
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Characters(Extends Source As String) As String()
		  Return Split(Source, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CorrectWindowPlacement(Extends Win As Window, Parent As Window)
		  #if TargetWin32
		    If Win = Nil Or Parent = Nil Then
		      Return
		    End If
		    
		    If Win.Placement = Window.PlacementParent Then
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
		Function DoubleValue(Extends Dict As Dictionary, Key As Auto, ResolveWithFirst As Boolean = False) As Double
		  Dim Value As Auto = Dict.Value(Key)
		  Return AutoToDouble(Value, ResolveWithFirst)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndsWith(Extends Source As String, Other As String) As Boolean
		  Return Right(Source, Len(Other)) = Other
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explanation(Extends Err As RuntimeException) As String
		  If Err.Reason <> "" Then
		    Return Err.Reason
		  ElseIf Err.Message <> "" Then
		    Return Err.Message
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FutureDate(AdditionalSeconds As Double) As Date
		  Dim Now As New Date
		  Now.TotalSeconds = Now.TotalSeconds + AdditionalSeconds
		  Return Now
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFolderItemFromSaveInfo(SaveInfo As String) As FolderItem
		  Return SecurityScopedFolderItem.FromSaveInfo(SaveInfo)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAllKeys(Extends Source As Dictionary, ParamArray Keys() As Variant) As Boolean
		  For Each Key As Variant In Keys
		    If Not Source.HasKey(Key) Then
		      Return False
		    End If
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Extends Source As String, StartAt As Integer = 0, Other As String) As Integer
		  Return InStr(StartAt, Source, Other) - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(Extends Value As Auto) As Integer
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Value)
		  Select Case Info.Name
		  Case "Int8", "Int16", "Int32", "Int64", "UInt8", "UInt16", "UInt32", "UInt64"
		    Return Value
		  Case "Double", "Single"
		    Dim DoubleValue As Double = Value
		    Return Round(DoubleValue)
		  Case "String"
		    Dim StringValue As String = Value
		    Return Val(StringValue)
		  Case "Text"
		    Dim TextValue As String = Value
		    Return Val(TextValue)
		  Else
		    Return 0
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function IsType(Extends File As FolderItem, Type As FileType) As Boolean
		  Return File.Name.EndsWith(Type.PrimaryExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Attributes( Deprecated = "Join(Array, Delimiter)" )  Function Join(Extends Source() As String, Delimiter As String) As String
		  Return Join(Source, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(Extends Source As MemoryBlock, Length As UInteger) As MemoryBlock
		  Length = Min(Length, Source.Size)
		  Return Source.StringValue(0, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length(Extends Source As String) As Integer
		  Return Len(Source)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Extends Rect As REALbasic.Rect, Point As REALbasic.Point) As REALbasic.Point
		  Return New REALbasic.Point(Point.X - Rect.Origin.X, Point.Y - Rect.Origin.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Extends Rect As REALbasic.Rect, OtherRect As REALbasic.Rect) As REALbasic.Rect
		  Dim Origin As REALbasic.Point = Rect.Localize(OtherRect.Origin)
		  Dim Size As REALbasic.Size = OtherRect.Size
		  Return New REALbasic.Rect(Origin.X, Origin.Y, Size.Width, Size.Height)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Members(Extends Source As Dictionary) As FrameworkExtensions.DictionaryMemberSet
		  Return New FrameworkExtensions.DictionaryMemberSet(Source)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mid(Extends Source As MemoryBlock, Offset As UInteger, Length As UInteger = 0) As MemoryBlock
		  Offset = Min(Offset, Source.Size)
		  Length = Min(Length, Source.Size, Source.Size - Offset)
		  
		  If Length = 0 Then
		    Return ""
		  ElseIf Length > 0 Then
		    Return Source.StringValue(Offset, Min(Length, Source.Size - Offset))
		  Else
		    Return Source.StringValue(Offset, Source.Size - Offset)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NearestMultiple(Original As Double, Factor As Double) As Double
		  Dim Whole As Integer = Floor(Original)
		  If Whole = Original Then
		    Return Original
		  End If
		  
		  Dim Multiplier As Double = 1 / Factor
		  Return Round(Original * Multiplier) / Multiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NearestMultiple(Extends Original As Double, Factor As Double) As Double
		  Return NearestMultiple(Original, Factor)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewDateFromSecondsFrom1970(SecondsFrom1970 As Double) As Date
		  Dim Now As New Date
		  Now.SecondsFrom1970 = SecondsFrom1970
		  Return Now
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewDateFromSQLDateTime(SQLDateTime As String) As Date
		  Dim Now As New Date
		  Now.SQLDateTimeWithOffset = SQLDateTime
		  Return Now
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function PrimaryExtension(Extends Type As FileType) As String
		  Dim Extensions() As String = Split(Type.Extensions, ";")
		  If UBound(Extensions) = -1 Then
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
		Function RandomInt(LowerBound As Integer, UpperBound As Integer) As Integer
		  Static Picker As Random
		  If Picker = Nil Then
		    Picker = New Random
		    Picker.RandomizeSeed
		  End If
		  Return Picker.InRange(LowerBound, UpperBound)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Extends File As FolderItem, Encoding As TextEncoding) As String
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Contents As String = Stream.ReadAll(Encoding)
		  Stream.Close
		  Return Contents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Extends File As FolderItem, Length As UInteger = 0) As MemoryBlock
		  Dim Stream As BinaryStream = BinaryStream.Open(File, False)
		  If Length = 0 Then
		    Length = Stream.Length
		  Else
		    Length = Min(Stream.Length, Length)
		  End If
		  Dim Content As MemoryBlock = Stream.Read(Length, Nil)
		  Stream.Close
		  
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll(Extends Dict As Dictionary)
		  For I As Integer = Dict.Count - 1 DownTo 0
		    Dict.Remove(Dict.Key(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(Extends Source As MemoryBlock, Length As UInteger) As MemoryBlock
		  Length = Min(Length, Source.Size)
		  Return Source.StringValue(Source.Size - Length, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveInfo(Extends File As FolderItem) As String
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function URLWithString Lib "Cocoa" Selector "URLWithString:" (Target As Ptr, URLString As CFStringRef) As Ptr
		    Declare Function BookmarkDataWithOptions Lib "Cocoa" Selector "bookmarkDataWithOptions:includingResourceValuesForKeys:relativeToURL:error:" (Target As Ptr, Options as UInt32, ResourceValuesKeys As Ptr, RelativeURL As Ptr, ByRef Error As Ptr) As Ptr
		    Declare Function DataLength Lib "Cocoa" Selector "length" (Target As Ptr) As UInteger
		    Declare Sub DataBytes Lib "Cocoa" Selector "getBytes:length:" (Target As Ptr, Buffer As Ptr, Length As UInteger)
		    
		    Dim ErrorRef as Ptr
		    Dim NSURL As Ptr = objc_getClass("NSURL")
		    Dim FileURL As Ptr = URLWithString(NSURL, File.URLPath)
		    If FileURL <> Nil Then
		      Dim DataRef As Ptr = BookmarkDataWithOptions(FileURL, 2048, Nil, Nil, ErrorRef)
		      If DataRef <> Nil Then
		        Dim Mem As New Global.MemoryBlock(DataLength(DataRef))
		        DataBytes(DataRef, Mem, Mem.Size)
		        Return EncodeBase64(Mem)
		      End If
		    End If
		  #else
		    Return EncodeBase64(File.GetSaveInfo(Nil))
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondsFrom1970(Extends Source As Date) As Double
		  Return (Source.TotalSeconds - 2082844800) - (Source.GMTOffset * 3600)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SecondsFrom1970(Extends Source As Date, Assigns Value As Double)
		  Source.TotalSeconds = Value + 2082844800 + (Source.GMTOffset * 3600)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SQLDateTimeWithOffset(Extends Source As Date) As String
		  Dim Offset As Double = Abs(Source.GMTOffset)
		  Dim Hours As Integer = Floor(Offset)
		  Dim Minutes As Integer = (Offset - Floor(Offset)) * 60
		  
		  Return Str(Source.Year, "0000") + "-" + Str(Source.Month, "00") + "-" + Str(Source.Day, "00") + " " + Str(Source.Hour, "00") + ":" + Str(Source.Minute, "00") + ":" + Str(Source.Second, "00") + If(Source.GMTOffset < 0, "-", "+") + Str(Hours, "00") + ":" + Str(Minutes, "00")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SQLDateTimeWithOffset(Extends Source As Date, Assigns Value As String)
		  Dim Validator As New Regex
		  Validator.SearchPattern = "^(\d{4})-(\d{2})-(\d{2})( (\d{2}):(\d{2}):(\d{2})(\.\d+)?\s*((\+|-)(\d{1,2})(:(\d{2}))?)?)?$"
		  
		  Dim Matches As RegexMatch = Validator.Search(Value)
		  If Matches = Nil Then
		    Dim Err As New UnsupportedFormatException
		    Err.Message = "Invalid SQL timestamp"
		    Raise Err
		    Return
		  End If
		  
		  Dim Year As Integer = Val(Matches.SubExpressionString(1))
		  Dim Month As Integer = Val(Matches.SubExpressionString(2))
		  Dim Day As Integer = Val(Matches.SubExpressionString(3))
		  Dim Hour As Integer
		  Dim Minute As Integer
		  Dim Second As Integer
		  Dim Offset As Double
		  Dim ExpressionCount As Integer = Matches.SubExpressionCount
		  
		  If ExpressionCount >= 8 And Matches.SubExpressionString(4) <> "" Then
		    Hour = Val(Matches.SubExpressionString(5))
		    Minute = Val(Matches.SubExpressionString(6))
		    Second = Val(Matches.SubExpressionString(7))
		    
		    If ExpressionCount >= 12 And Matches.SubExpressionString(9) <> "" Then
		      Dim OffsetHour As Integer = Val(Matches.SubExpressionString(11))
		      Dim OffsetMinute As Integer
		      If ExpressionCount >= 14 And Matches.SubExpressionString(13) <> "" Then
		        OffsetMinute = Val(Matches.SubExpressionString(13))
		      End If
		      Offset = OffsetHour + (OffsetMinute / 60)
		      If Matches.SubExpressionString(10) = "-" Then
		        Offset = Offset * -1
		      End If
		    End If
		  End If
		  
		  Source.Constructor(Year, Month, Day, Hour, Minute, Second, Offset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubString(Extends Source As String, Start As Integer, Length As Integer = -1) As String
		  If Length = -1 Then
		    Return Mid(Source, Start + 1)
		  Else
		    Return Mid(Source, Start + 1, Length)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToColor(Extends Source As String) As Color
		  Dim Mem As New MemoryBlock(4)
		  Mem.StringValue(0, 4) = DecodeHex(Source.Left(8))
		  Return RGB(Mem.UInt8Value(0), Mem.UInt8Value(1), Mem.UInt8Value(2), Mem.UInt8Value(3))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToHex(Extends Source As Color) As String
		  Return Source.Red.ToHex(2).Lowercase + Source.Green.ToHex(2).Lowercase + Source.Blue.ToHex(2).Lowercase + Source.Alpha.ToHex(2).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(Extends Source As Color) As String
		  Dim Mem As New MemoryBlock(4)
		  Mem.UInt8Value(0) = Source.Red
		  Mem.UInt8Value(1) = Source.Green
		  Mem.UInt8Value(2) = Source.Blue
		  Mem.UInt8Value(3) = Source.Alpha
		  Return EncodeHex(Mem).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Extends File As FolderItem, Content As MemoryBlock)
		  Dim Stream As BinaryStream = BinaryStream.Create(File, True)
		  Stream.Write(Content)
		  Stream.Close
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
