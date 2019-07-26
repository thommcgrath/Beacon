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
		Function AddSuffix(Extends Title As Text, Suffix As Text) As Text
		  Dim Words() As Text = Title.Split(" ")
		  If Words.Ubound >= 0 And Words(Words.Ubound) = Suffix Then
		    Words.Append("2")
		  ElseIf Words.Ubound >= 1 And Words(Words.Ubound - 1) = Suffix Then
		    Dim CopyNum As Integer
		    #Pragma BreakOnExceptions Off
		    Try
		      CopyNum = Integer.FromText(Words(Words.Ubound), Xojo.Core.Locale.Raw) + 1
		      Words(Words.Ubound) = CopyNum.ToText(Xojo.Core.Locale.Raw, "0")
		    Catch Err As RuntimeException
		      Words.Append(Suffix)
		    End Try
		    #Pragma BreakOnExceptions Default
		  Else
		    Words.Append(Suffix)
		  End If
		  Return Words.Join(" ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AutoToDouble(Value As Auto, ResolveWithFirst As Boolean = False) As Double
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		  Select Case Info.FullName
		  Case "Text"
		    Dim TextValue As Text = Value
		    If TextValue = "" Then
		      Return 0
		    Else
		      Return Double.FromText(TextValue)
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
		Function Characters(Extends Source As String) As String()
		  Return Split(Source, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CheckIsFolder(Extends Folder As FolderItem, Create As Boolean = True) As Boolean
		  If Folder.Exists Then
		    If Folder.Folder Then
		      Return True
		    Else
		      If Create = True Then
		        Folder.Delete
		        Folder.CreateAsFolder
		        Return True
		      Else
		        Return False
		      End If
		    End If
		  Else
		    If Create = True Then
		      Folder.CreateAsFolder
		      Return True
		    Else
		      Return False
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function Clone(Extends Source() As String) As String()
		  Dim Result() As String
		  Redim Result(Source.Ubound)
		  For I As Integer = 0 To Source.Ubound
		    Result(I) = Source(I)
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Extends Source() As Text) As Text()
		  Dim Result() As Text
		  Redim Result(Source.Ubound)
		  For I As Integer = 0 To Source.Ubound
		    Result(I) = Source(I)
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Convert(Extends Source As Date) As Xojo.Core.Date
		  Return New Xojo.Core.Date(Source.SecondsFrom1970, New Xojo.Core.TimeZone(Source.Timezone.SecondsFromGMT))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Convert(Extends Source As MemoryBlock) As Xojo.Core.MemoryBlock
		  Dim Temp As New Xojo.Core.MemoryBlock(Source)
		  Return Temp.Left(Source.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Convert(Extends Source As Xojo.Core.Date) As Date
		  Return New Date(Source.SecondsFrom1970, New TimeZone(Source.TimeZone.SecondsFromGMT))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Convert(Extends Source As Xojo.Core.MemoryBlock) As MemoryBlock
		  Return CType(Source.Data, MemoryBlock).StringValue(0, Source.Size)
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
		Function DeepDelete(Extends File As FolderItem) As Boolean
		  If Not File.Exists Then
		    Return True
		  End If
		  
		  If File.Folder Then
		    For I As Integer = File.Count DownTo 1
		      If Not File.Item(I).DeepDelete Then
		        Return False
		      End If
		    Next
		  End If
		  
		  Try
		    File.Delete
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleValue(Extends Dict As Xojo.Core.Dictionary, Key As Auto, ResolveWithFirst As Boolean = False) As Double
		  Dim Value As Auto = Dict.Value(Key)
		  Return AutoToDouble(Value, ResolveWithFirst)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explanation(Extends Err As RuntimeException) As Text
		  If Err.Reason <> "" Then
		    Return Err.Reason
		  ElseIf Err.Message <> "" Then
		    Return Err.Message.ToText
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Extension(Extends File As FolderItem) As String
		  Dim Name As String = File.Name
		  If Name.IndexOf(".") = -1 Then
		    Return ""
		  End If
		  
		  Dim Parts() As String = Name.Split(".")
		  Return Parts(Parts.Ubound)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegerValue(Extends Value As Auto) As Integer
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
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
		    Dim TextValue As Text = Value
		    Return Integer.FromText(TextValue)
		  Else
		    Return 0
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsType(Extends File As FolderItem, Type As FileType) As Boolean
		  Return File.Name.EndsWith(Type.PrimaryExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(Extends Source() As String, Delimiter As String) As String
		  Return Join(Source, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(Extends Source() As Text, Delimiter As Text) As Text
		  #if TargetWin32
		    // Thanks to bug <feedback://showreport?report_id=54183>
		    Dim Arr() As String
		    Redim Arr(Source.Ubound)
		    For I As Integer = 0 To Source.Ubound
		      Arr(I) = Source(I)
		    Next
		    Return Arr.Join(Delimiter).ToText
		  #endif
		  
		  Return Text.Join(Source, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Extends Rect As Xojo.Core.Rect, Point As Xojo.Core.Point) As Xojo.Core.Point
		  Return New Xojo.Core.Point(Point.X - Rect.Origin.X, Point.Y - Rect.Origin.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Extends Rect As Xojo.Core.Rect, OtherRect As Xojo.Core.Rect) As Xojo.Core.Rect
		  Return New Xojo.Core.Rect(Rect.Localize(OtherRect.Origin), OtherRect.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LocalTime(Extends Source As Date) As Date
		  Dim Now As New Date
		  Return New Date(Source.SecondsFrom1970, Now.Timezone)
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
		Function NewDateFromSQLDateTime(SQLDateTime As String) As Date
		  Dim Now As New Date
		  Now.SQLDateTimeWithOffset = SQLDateTime
		  Return Now
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Extends File As FolderItem) As MemoryBlock
		  Try
		    Dim Stream As BinaryStream = BinaryStream.Open(File, False)
		    Dim Contents As MemoryBlock = Stream.Read(Stream.Length)
		    Stream.Close
		    Return Contents
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Extends File As FolderItem, Encoding As TextEncoding) As String
		  Dim Mem As MemoryBlock = File.Read
		  If Mem = Nil Then
		    Return ""
		  End If
		  Return Mem.StringValue(0, Mem.Size).DefineEncoding(Encoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SQLDateTimeWithOffset(Extends Source As Date) As String
		  Dim Zone As TimeZone = Source.Timezone
		  Dim Offset As Double = Abs(Zone.SecondsFromGMT / 3600)
		  Dim Hours As Integer = Floor(Offset)
		  Dim Minutes As Integer = (Offset - Floor(Offset)) * 60
		  
		  Return Str(Source.Year, "0000") + "-" + Str(Source.Month, "00") + "-" + Str(Source.Day, "00") + " " + Str(Source.Hour, "00") + ":" + Str(Source.Minute, "00") + ":" + Str(Source.Second, "00") + If(Zone.SecondsFromGMT < 0, "-", "+") + Str(Hours, "00") + ":" + Str(Minutes, "00")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SQLDateTimeWithOffset(Extends Source As Date, Assigns Value As String)
		  Dim Validator As New Regex
		  Validator.SearchPattern = "^(\d{4})-(\d{2})-(\d{2})( (\d{2}):(\d{2}):(\d{2})(\.\d+)?\s*((\+|-)(\d{1,2})(:?(\d{2}))?)?)?$"
		  
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
		  
		  Source.Constructor(Year, Month, Day, Hour, Minute, Second, 0, New TimeZone(Offset))
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
		Function ToHex(Extends Source As Color) As Text
		  Return Source.Red.ToHex(2).Lowercase + Source.Green.ToHex(2).Lowercase + Source.Blue.ToHex(2).Lowercase + Source.Alpha.ToHex(2).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ToString(Extends Source() As Text) As String()
		  Dim Result() As String
		  Redim Result(Source.Ubound)
		  For I As Integer = 0 To Source.Ubound
		    Result(I) = Source(I)
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ToText(Extends Source() As String) As Text()
		  Dim Result() As Text
		  Redim Result(Source.Ubound)
		  For I As Integer = 0 To Source.Ubound
		    Result(I) = Source(I).ToText
		  Next
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToText(Extends Source As Xojo.Core.MemoryBlock) As Text
		  Dim Content As String = CType(Source.Data, Global.MemoryBlock).StringValue(0, Source.Size)
		  Content = Content.GuessEncoding
		  Return Content.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Write(Extends File As FolderItem, Contents As MemoryBlock) As Boolean
		  Try
		    Dim Stream As BinaryStream
		    If File.Exists Then
		      Stream = BinaryStream.Open(File, True)
		      Stream.BytePosition = 0
		      Stream.Length = 0
		    Else
		      Stream = BinaryStream.Create(File, True)
		    End If
		    Stream.Write(Contents)
		    Stream.Close
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Write(Extends File As FolderItem, Source As Text, Encoding As Xojo.Core.TextEncoding) As Boolean
		  Dim Mem As Xojo.Core.MemoryBlock
		  Try
		    Mem = Encoding.ConvertTextToData(Source, False)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  Return File.Write(Mem.Convert)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Write(Extends File As FolderItem, Contents As Xojo.Core.MemoryBlock) As Boolean
		  Return File.Write(Contents.Convert)
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
