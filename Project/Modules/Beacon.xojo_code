#tag Module
Protected Module Beacon
	#tag Method, Flags = &h1
		Protected Function Clone(Source As Xojo.Core.Dictionary) As Xojo.Core.Dictionary
		  // This method only exists because the built-in clone method causes crashes.
		  // However, this only handles basic cases.
		  
		  If Source = Nil Then
		    // That was easy
		    Return Nil
		  End If
		  
		  Dim Clone As New Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Source
		    Clone.Value(Entry.Key) = Entry.Value
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ComputeDifficultySettings(BaseDifficulty As Double, DesiredDinoLevel As Integer, ByRef DifficultyValue As Double, ByRef DifficultyOffset As Double, ByRef OverrideOfficialDifficulty As Double)
		  OverrideOfficialDifficulty = Max(Ceil(DesiredDinoLevel / 30), BaseDifficulty)
		  DifficultyOffset = Xojo.Math.Max((DesiredDinoLevel - 15) / ((OverrideOfficialDifficulty * 30) - 15), 0.001)
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

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ConvertMemoryBlock(Source As Global.MemoryBlock) As Xojo.Core.MemoryBlock
		  Dim Temp As New Xojo.Core.MemoryBlock(Source)
		  Return Temp.Left(Source.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function ConvertMemoryBlock(Source As Xojo.Core.MemoryBlock) As Global.MemoryBlock
		  Return CType(Source.Data, Global.MemoryBlock).StringValue(0, Source.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CRC32(Data As Xojo.Core.MemoryBlock) As UInt32
		  dim crcg, c, t, x,b as uint32
		  dim ch as uint8
		  crcg = &hffffffff
		  c = Data.Size - 1
		  
		  for x=0 to c
		    ch = data.uint8value(x)
		    
		    t = (crcg and &hFF) xor ch
		    
		    for b=0 to 7
		      if( (t and &h1) = &h1) then
		        t = Beacon.ShiftRight( t, 1) xor &hEDB88320
		      else
		        t = Beacon.ShiftRight(t, 1)
		      end if
		    next
		    crcg = Beacon.ShiftRight(crcg, 8) xor t
		  next
		  
		  crcg = crcg Xor &hFFFFFFFF
		  return crcg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateUUID() As Text
		  Dim Bytes As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		  Dim Id As New Xojo.Core.MutableMemoryBlock(Bytes)
		  Dim Value As UInt8
		  
		  Value = Id.UInt8Value(6)
		  Value = Value And CType(&b00001111, UInt8)
		  Value = Value Or CType(&b01000000, UInt8)
		  Id.UInt8Value(6) = Value
		  
		  Value = Id.UInt8Value(8)
		  Value = Value And CType(&b00111111, UInt8)
		  Value = Value Or CType(&b10000000, UInt8)
		  Id.UInt8Value(8) = Value
		  
		  Dim Chars() As Text
		  For I As Integer = 0 To Id.Size - 1
		    Chars.Append(Id.UInt8Value(I).ToHex(2))
		  Next
		  
		  Chars.Insert(10, "-")
		  Chars.Insert( 8, "-")
		  Chars.Insert( 6, "-")
		  Chars.Insert( 4, "-")
		  
		  Return Chars.Join("").Lowercase
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
		Protected Function DecodeBase64(Source As Text) As Xojo.Core.MemoryBlock
		  #if TargetiOS
		    
		  #else
		    Dim StringValue As String = Source
		    Dim Block As Global.MemoryBlock = DecodeBase64(StringValue)
		    Dim Temp As New Xojo.Core.MemoryBlock(Block)
		    Return Temp.Left(Block.Size)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecodeHex(Source As Text) As Xojo.Core.MemoryBlock
		  #if TargetiOS
		    Dim Mem As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source)
		    Dim Size As UInt64 = Mem.Size\2-1
		    Static Lookup() As Integer = Array(0,1,2,3,4,5,6,7,8,9,_
		    0,0,0,0,0,0,0,10,11,12,13,14,15,0,0,0,0,0,0,0,0,0,0,_
		    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,11,12,13,14,15)
		    Dim Bytes() As UInt8
		    Redim Bytes(Size)
		    For I As UInt64 = 0 To Size
		      Dim Index As UInt64 = I + I
		      Bytes(I) = (Lookup(Mem.UInt8Value(Index) - 48) * 16) + Lookup(Mem.UInt8Value(Index + 1) - 48)
		    Next
		    
		    Return New Xojo.Core.MemoryBlock(Bytes)
		  #else
		    Return Beacon.ConvertMemoryBlock(REALbasic.DecodeHex(Source))
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecodeURLComponent(Value As Text) As Text
		  #if TargetiOS
		    Dim Chars(), HexChars() As Text
		    Dim HexMode, UnicodeMode As Boolean
		    For Each Character As Text In Value.Characters
		      If HexMode Then
		        HexChars.Append(Character)
		        If HexChars.Ubound = 0 And Character = "u" Then
		          UnicodeMode = True
		          HexChars.Remove(0)
		        ElseIf (UnicodeMode = False And HexChars.Ubound = 1) Or (UnicodeMode = True And HexChars.Ubound = 3) Then
		          Dim Encoded As Text = HexChars.Join("")
		          Redim HexChars(-1)
		          HexMode = False
		          UnicodeMode = False
		          
		          Chars.Append(Text.FromUnicodeCodepoint(UInt32.FromHex(Encoded)))
		        End If
		        
		        Continue
		      End If
		      
		      If Character = "%" Then
		        HexMode = True
		        Continue
		      ElseIf Character = "+" Then
		        Character = " "
		      End If
		      
		      Chars.Append(Character)
		    Next
		    Return Chars.Join("")
		  #else
		    Dim StringValue As String = Value
		    StringValue = StringValue.ReplaceAll("+", " ")
		    Return DefineEncoding(DecodeURLComponent(StringValue), Encodings.UTF8).ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DifficultyOffset(Value As Double, Scale As Double) As Double
		  Return Xojo.Math.Min((Value - 0.5) / (Scale - 0.5), 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DifficultyScale(Extends Maps() As Beacon.Map) As Double
		  Dim Scale As Double
		  For Each Map As Beacon.Map In Maps
		    Scale = Xojo.Math.Max(Scale, Map.DifficultyScale)
		  Next
		  Return Scale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DifficultyValue(Offset As Double, Scale As Double) As Double
		  Offset = Xojo.Math.Max(Offset, 0.0001)
		  Return (Offset * (Scale - 0.5)) + 0.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeBase64(Source As Text, Encoding As Xojo.Core.TextEncoding) As Text
		  Dim Bytes As Xojo.Core.MemoryBlock = Encoding.ConvertTextToData(Source)
		  Return Beacon.EncodeBase64(Bytes)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeBase64(Source As Xojo.Core.MemoryBlock) As Text
		  #if TargetiOS
		    Dim Chars As Text = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		    
		    Dim Remainder As Integer = (Source.Size Mod 3)
		    Dim Padding As Integer
		    If Remainder > 0 Then
		      Padding = 3 - Remainder
		      If Padding > 0 Then
		        Dim Clone As New Xojo.Core.MutableMemoryBlock(Source)
		        Clone.Append(New Xojo.Core.MemoryBlock(Padding))
		        Source = New Xojo.Core.MemoryBlock(Clone)
		      End If
		    End If
		    
		    Dim Output() As Text
		    
		    For I As Integer = 0 To Source.Size - 3 Step 3
		      Dim N As Integer = Beacon.ShiftLeft(Source.UInt8Value(I), 16) + Beacon.ShiftLeft(Source.UInt8Value(I + 1), 8) + Source.UInt8Value(I + 2)
		      
		      Dim Offsets(3) As UInt8
		      Offsets(0) = Beacon.ShiftRight(N, 18) And 63
		      Offsets(1) = Beacon.ShiftRight(N, 12) And 63
		      Offsets(2) = Beacon.ShiftRight(N, 6) And 63
		      Offsets(3) = N And 63
		      
		      Output.Append(Chars.Mid(Offsets(0), 1))
		      Output.Append(Chars.Mid(Offsets(1), 1))
		      Output.Append(Chars.Mid(Offsets(2), 1))
		      Output.Append(Chars.Mid(Offsets(3), 1))
		    Next
		    
		    For I As Integer = 0 To Padding - 1
		      Output(UBound(Output) - I) = "="
		    Next
		    
		    Return Output.Join("")
		  #else
		    Return EncodeBase64(Beacon.ConvertMemoryBlock(Source), 0).ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function EncodeHex(Block As Global.MemoryBlock) As Text
		  Return REALbasic.EncodeHex(Block).ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeHex(Value As Text, Encoding As Xojo.Core.TextEncoding = Nil) As Text
		  If Encoding = Nil Then
		    Encoding = Xojo.Core.TextEncoding.UTF8
		  End If
		  
		  Dim Bytes As Xojo.Core.MemoryBlock = Encoding.ConvertTextToData(Value)
		  Return Beacon.EncodeHex(Bytes)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeHex(Block As Xojo.Core.MemoryBlock) As Text
		  #if TargetiOS
		    Dim Chars() As Text
		    For I As Integer = 0 To Block.Size - 1
		      Dim Value As UInt8 = Block.UInt8Value(I)
		      Chars.Append(Value.ToHex(2))
		    Next
		    Return Chars.Join("")
		  #else
		    Return REALbasic.EncodeHex(Beacon.ConvertMemoryBlock(Block)).ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeURLComponent(Value As Text) As Text
		  #if TargetiOS
		    Dim Encoded() As Text
		    For Each CodePoint As UInt32 In Value.Codepoints
		      Select Case CodePoint
		      Case &h21, &h23, &h24, &h26, &h27, &h28, &h29, &h2A, &h2B, &h2C, &h2F, &h3A, &h3B, &h3D, &h3F, &h40, &h5B, &h5D
		        Encoded.Append("%" + CodePoint.ToHex(2))
		      Else
		        Encoded.Append(Text.FromUnicodeCodepoint(CodePoint))
		      End Select
		    Next
		    Return Encoded.Join("")
		  #else
		    Dim StringValue As String = Value
		    Return EncodeURLComponent(StringValue).ReplaceAll(" ", "%20").ToText
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetDesktop and (Target32Bit or Target64Bit))
		Function GlobalPosition(Extends Target As Window) As Xojo.Core.Point
		  Dim Left As Integer = Target.Left
		  Dim Top As Integer = Target.Top
		  
		  While Target IsA ContainerControl
		    Target = ContainerControl(Target).Window
		    Left = Left + Target.Left
		    Top = Top + Target.Top
		  Wend
		  
		  Return New Xojo.Core.Point(Left, Top)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasAllKeys(Extends Dict As Xojo.Core.Dictionary, ParamArray Keys() As Auto) As Boolean
		  For Each Key As Auto In Keys
		    If Not Dict.HasKey(Key) Then
		      Return False
		    End If
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Function Hash(Block As Global.MemoryBlock) As Text
		  Dim Temp As New Xojo.Core.MemoryBlock(Block)
		  Return Beacon.Hash(Temp.Left(Block.Size))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Hash(Value As Text, Encoding As Xojo.Core.TextEncoding = Nil) As Text
		  If Encoding = Nil Then
		    Encoding = Xojo.Core.TextEncoding.UTF8
		  End If
		  
		  Return Beacon.Hash(Encoding.ConvertTextToData(Value))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Hash(Block As Xojo.Core.MemoryBlock) As Text
		  Return Beacon.EncodeHex(Xojo.Crypto.SHA512(Block))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function IsBeaconURL(ByRef Value As String) As Boolean
		  Dim TextValue As Text = Value.ToText
		  If Beacon.IsBeaconURL(TextValue) Then
		    Value = TextValue
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBeaconURL(ByRef Value As Text) As Boolean
		  Dim PossiblePrefixes() As Text
		  PossiblePrefixes.Append(Beacon.URLScheme + "://")
		  PossiblePrefixes.Append("https://app.beaconapp.cc/")
		  
		  Dim URLLength As Integer = Value.Length
		  For Each PossiblePrefix As Text In PossiblePrefixes
		    Dim PrefixLength As Integer = PossiblePrefix.Length
		    If URLLength > PrefixLength And Value.Left(PrefixLength) = PossiblePrefix Then
		      Value = Value.Mid(PrefixLength)
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Extends Maps() As Beacon.Map) As Text
		  Dim Names() As Text
		  For Each Map As Beacon.Map In Maps
		    Names.Append(Map.Name)
		  Next
		  
		  
		  If UBound(Names) = 0 Then
		    Return Names(0)
		  ElseIf UBound(Names) = 1 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Dim Tail As Text = Names(UBound(Names))
		    Names.Remove(UBound(Names))
		    Return Names.Join(", ") + ", & " + Tail
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
		Protected Function MD5(Value As Text) As Text
		  Dim Bytes As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Value)
		  Dim Hash As Xojo.Core.MemoryBlock = Xojo.Crypto.MD5(Bytes)
		  Return Beacon.EncodeHex(Hash)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseSQLDate(Value As Text) As Xojo.Core.Date
		  Value = Value.Trim
		  
		  Dim Year, Month, Day, Hour, Minute, Second, Offset As Integer
		  
		  If Value.Length >= 10 Then
		    Year = Integer.FromText(Value.Mid(0, 4))
		    Month = Integer.FromText(Value.Mid(5, 2))
		    Day = Integer.FromText(Value.Mid(8, 2))
		    Value = Value.Mid(10)
		  End If
		  
		  If Value.Length >= 1 And Value.Left(1) = " " Then
		    Value = Value.Mid(1)
		  End If
		  
		  If Value.Length >= 8 Then
		    Hour = Integer.FromText(Value.Mid(0, 2))
		    Minute = Integer.FromText(Value.Mid(3, 2))
		    Second = Integer.FromText(Value.Mid(6, 2))
		    Value = Value.Mid(8)
		  End If
		  
		  If Value.Length >= 3 Then
		    Dim Multiplier As Integer = if(Value.Left(1) = "-", -1, 1)
		    Dim OffsetHours As Integer = Integer.FromText(Value.Mid(1, 2))
		    Dim OffsetMinutes As Integer
		    If Value.Length >= 5 Then
		      OffsetMinutes = Integer.FromText(Value.Mid(3, 2))
		    End If
		    
		    Offset = ((OffsetHours * 3600) + (OffsetMinutes + 60)) * Multiplier
		  End If
		  
		  Return New Xojo.Core.Date(Year, Month, Day, Hour, Minute, Second, 0, New Xojo.Core.TimeZone(Offset))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PrettyText(Value As Double, DecimalPlaces As Integer = 6) As Text
		  Dim Multiplier As UInteger = 1
		  Dim Places As Integer = 0
		  Dim Format As Text = "0"
		  
		  While Places < DecimalPlaces
		    Dim TestValue As Double = Value * Multiplier
		    If Xojo.Math.Floor(TestValue) = TestValue Then
		      Exit
		    End If
		    Multiplier = Multiplier * 10
		    Format = Format + "0"
		    Places = Places + 1
		  Wend
		  
		  If Format.Length > 1 Then
		    Format = Format.Left(1) + "." + Format.Mid(1)
		  End If
		  
		  Dim RoundedValue As Double = Round(Value * Multiplier) / Multiplier
		  Return RoundedValue.ToText(Xojo.Core.Locale.Raw, Format)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrettyText(Extends Value As Double, DecimalPlaces As Integer = 6) As Text
		  Return PrettyText(Value, DecimalPlaces)
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
		Function ReplaceLineEndings(Extends Source As Text, ReplaceWith As Text) As Text
		  Return Beacon.ReplaceLineEndings(Source, ReplaceWith)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplaceLineEndings(Source As Text, ReplaceWith As Text) As Text
		  #if Not TargetiOS
		    Return REALbasic.ReplaceLineEndings(Source, ReplaceWith).ToText
		  #else
		    Dim CR As Text = Text.FromUnicodeCodepoint(13)
		    Dim LR As Text = Text.FromUnicodeCodepoint(10)
		    
		    Source = Source.ReplaceAll(CR + LF, CR)
		    Source = Source.ReplaceAll(LF, CR)
		    Return Source.ReplaceAll(CR, ReplaceWith)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RewriteIniContent(InitialContent As Text, NewConfigs As Xojo.Core.Dictionary) As Text
		  // First, normalize line endings
		  Dim CR As Text = Text.FromUnicodeCodepoint(13)
		  Dim LF As Text = Text.FromUnicodeCodepoint(10)
		  Dim EOL As Text = CR + LF
		  InitialContent = InitialContent.ReplaceAll(CR + LF, CR)
		  InitialContent = InitialContent.ReplaceAll(LF, CR)
		  InitialContent = InitialContent.ReplaceAll(CR, EOL)
		  
		  Const BeginBeaconTag = "BeginBeaconContent"
		  Const EndBeaconTag = "EndBeaconContent"
		  
		  // Organize all existing content
		  Dim Lines() As Text = InitialContent.Split(EOL)
		  Dim UntouchedConfigs As New Xojo.Core.Dictionary
		  Dim LastGroupHeader As Text
		  Dim InBeaconContentGroup As Boolean
		  For I As Integer = 0 To Lines.Ubound
		    Dim Line As Text = Lines(I).Trim
		    If Line.Length = 0 Then
		      Continue
		    End If
		    
		    If Line = "; " + BeginBeaconTag Then
		      InBeaconContentGroup = True
		      Continue
		    ElseIf Line = "; " + EndBeaconTag Then
		      InBeaconContentGroup = False
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      // This is a group header
		      LastGroupHeader = Line.Mid(1, Line.Length - 2)
		      InBeaconContentGroup = False
		      Continue
		    End If
		    
		    If InBeaconContentGroup Then
		      // We want to ignore all previously generated content
		      Continue
		    End If
		    
		    Dim SectionDict As Xojo.Core.Dictionary
		    If UntouchedConfigs.HasKey(LastGroupHeader) Then
		      SectionDict = UntouchedConfigs.Value(LastGroupHeader)
		    Else
		      SectionDict = New Xojo.Core.Dictionary
		    End If
		    
		    Dim KeyPos As Integer = Line.IndexOf("=")
		    If KeyPos = -1 Then
		      Continue
		    End If
		    
		    Dim Key As Text = Line.Left(KeyPos)
		    Dim ModifierPos As Integer = Key.IndexOf("[")
		    If ModifierPos > -1 Then
		      Key = Key.Left(ModifierPos)
		    End If
		    
		    If NewConfigs.HasKey(LastGroupHeader) Then
		      Dim NewSectionDict As Xojo.Core.Dictionary = NewConfigs.Value(LastGroupHeader)
		      If NewSectionDict.HasKey(Key) Then
		        // This key is being overridden
		        Continue
		      End If
		    End If
		    
		    Dim ConfigLines() As Text
		    If SectionDict.HasKey(Key) Then
		      ConfigLines = SectionDict.Value(Key)
		    End If
		    ConfigLines.Append(Line)
		    SectionDict.Value(Key) = ConfigLines
		    UntouchedConfigs.Value(LastGroupHeader) = SectionDict
		  Next
		  
		  Dim AllSectionHeaders() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In UntouchedConfigs
		    AllSectionHeaders.Append(Entry.Key)
		  Next
		  For Each Entry As Xojo.Core.DictionaryEntry In NewConfigs
		    If AllSectionHeaders.IndexOf(Entry.Key) = -1 Then
		      AllSectionHeaders.Append(Entry.Key)
		    End If
		  Next
		  
		  // Build an ini file
		  Dim NewLines() As Text
		  NewLines.Append("; This file was generated by Beacon " + App.NonReleaseVersion.ToText)
		  NewLines.Append("; Sections of this file are marked with comments that helps ensure Beacon")
		  NewLines.Append("; updates it correctly in the future. Do not edit content between the")
		  NewLines.Append("; " + BeginBeaconTag + " and " + EndBeaconTag + " lines.")
		  For Each Header As Text In AllSectionHeaders
		    NewLines.Append("")
		    NewLines.Append("[" + Header + "]")
		    
		    If UntouchedConfigs.HasKey(Header) Then
		      Dim Section As Xojo.Core.Dictionary = UntouchedConfigs.Value(Header)
		      For Each Entry As Xojo.Core.DictionaryEntry In Section
		        Dim Values() As Text = Entry.Value
		        For Each Line As Text In Values
		          NewLines.Append(Line)
		        Next
		      Next
		    End If
		    
		    If NewConfigs.HasKey(Header) Then
		      Dim Section As Xojo.Core.Dictionary = NewConfigs.Value(Header)
		      NewLines.Append("; " + BeginBeaconTag)
		      For Each Entry As Xojo.Core.DictionaryEntry In Section
		        Dim Values() As Text = Entry.Value
		        For Each Line As Text In Values
		          NewLines.Append(Line)
		        Next
		      Next
		      NewLines.Append("; " + EndBeaconTag)
		    End If
		  Next
		  
		  Return NewLines.Join(EOL)
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

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Function URLHandler(URL As Text) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Function WebURL(Path As Text = "/") As Text
		  #if DebugBuild
		    Dim Domain As Text = "https://workbench.beaconapp.cc"
		  #else
		    Dim Domain As Text = "https://beaconapp.cc"
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
