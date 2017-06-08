#tag Module
Protected Module Beacon
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
		  
		  Return Text.Join(Chars, "")
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
		Protected Function DecodeHex(Source As Text) As Xojo.Core.MemoryBlock
		  Dim Bytes() As UInt8
		  For I As Integer = 0 To Source.Length - 2 Step 2
		    Dim Value As UInt8 = UInt8.FromHex(Source.Mid(I, 2))
		    Bytes.Append(Value)
		  Next
		  Return New Xojo.Core.MemoryBlock(Bytes)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecodeHex(Source As Text, Encoding As Xojo.Core.TextEncoding) As Text
		  Dim Bytes As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Source)
		  Return Encoding.ConvertDataToText(Bytes)
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
		  
		  Return Text.Join(Output, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeHex(Value As Text, Encoding As Xojo.Core.TextEncoding) As Text
		  Dim Bytes As Xojo.Core.MemoryBlock = Encoding.ConvertTextToData(Value)
		  Return Beacon.EncodeHex(Bytes)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeHex(Block As Xojo.Core.MemoryBlock) As Text
		  Dim Chars() As Text
		  For I As Integer = 0 To Block.Size - 1
		    Dim Value As UInt8 = Block.UInt8Value(I)
		    Chars.Append(Value.ToHex(2))
		  Next
		  Return Text.Join(Chars, "")
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

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function IsType(Extends File As FolderItem, Type As FileType) As Boolean
		  Dim Extension As String = Type.PrimaryExtension
		  Return Right(File.Name, Len(Extension)) = Extension
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

	#tag Method, Flags = &h1
		Protected Function QualityForValue(Quality As Double, Multiplier As Double) As Beacon.Qualities
		  Quality = Quality * Multiplier
		  
		  // Thanks to math, we can get the quality as 15.99999 instead of 16. So rounding it is.
		  Quality = Xojo.Math.Round(Quality * 10000) / 10000
		  
		  If Quality < Beacon.QualityRamshackle Then
		    Return Beacon.Qualities.Primitive
		  ElseIf Quality < Beacon.QualityApprentice Then
		    Return Beacon.Qualities.Ramshackle
		  ElseIf Quality < Beacon.QualityJourneyman Then
		    Return Beacon.Qualities.Apprentice
		  ElseIf Quality < Beacon.QualityMastercraft Then
		    Return Beacon.Qualities.Journeyman
		  ElseIf Quality < Beacon.QualityAscendant Then
		    Return Beacon.Qualities.Mastercraft
		  ElseIf Quality < Beacon.QualityAscendantPlus Then
		    Return Beacon.Qualities.Ascendant
		  ElseIf Quality < Beacon.QualityAscendantPlusPlus Then
		    Return Beacon.Qualities.AscendantPlus
		  ElseIf Quality < Beacon.QualityAscendantPlusPlusPlus Then
		    Return Beacon.Qualities.AscendantPlusPlus
		  Else
		    Return Beacon.Qualities.AscendantPlusPlusPlus
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function QualityToText(Quality As Beacon.Qualities) As Text
		  Select Case Quality
		  Case Beacon.Qualities.Primitive
		    Return "Tier1"
		  Case Beacon.Qualities.Ramshackle
		    Return "Tier2"
		  Case Beacon.Qualities.Apprentice
		    Return "Tier3"
		  Case Beacon.Qualities.Journeyman
		    Return "Tier4"
		  Case Beacon.Qualities.Mastercraft
		    Return "Tier5"
		  Case Beacon.Qualities.Ascendant
		    Return "Tier6"
		  Case Beacon.Qualities.AscendantPlus
		    Return "Tier7"
		  Case Beacon.Qualities.AscendantPlusPlus
		    Return "Tier8"
		  Case Beacon.Qualities.AscendantPlusPlusPlus
		    Return "Tier9"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ReportAProblem()
		  Dim URL As Text = Beacon.WebURL + "/reportaproblem.php"
		  
		  #if TargetiOS
		    Declare Function NSClassFromString Lib "Foundation" (Name As CFStringRef) As Ptr
		    Declare Function sharedApplication Lib "UIKit" Selector "sharedApplication" (Obj As Ptr) As Ptr
		    Declare Function URLWithString Lib "Foundation" Selector "URLWithString:" (ID As Ptr, URLString As CFStringRef ) As Ptr
		    Declare Function openURL Lib "UIKit" Selector "openURL:" (ID As Ptr, NSURL As Ptr) As Boolean
		    
		    Dim SharedApp As Ptr = sharedApplication(NSClassFromString("UIApplication"))
		    Dim NSURL As Ptr = URLWithString(NSClassFromString("NSURL"), URL)
		    Call openURL(SharedApp, NSURL)
		  #else
		    ShowURL(URL)
		  #endif
		End Sub
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

	#tag Method, Flags = &h0
		Sub Sort(Extends Sources() As Beacon.LootSource)
		  Dim Order() As Integer
		  Redim Order(UBound(Sources))
		  For I As Integer = 0 To UBound(Order)
		    Order(I) = Sources(I).SortValue
		  Next
		  
		  Order.SortWith(Sources)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextToQuality(Quality As Text) As Beacon.Qualities
		  Select Case Quality
		  Case "Tier1"
		    Return Beacon.Qualities.Primitive
		  Case "Tier2"
		    Return Beacon.Qualities.Ramshackle
		  Case "Tier3"
		    Return Beacon.Qualities.Apprentice
		  Case "Tier4"
		    Return Beacon.Qualities.Journeyman
		  Case "Tier5"
		    Return Beacon.Qualities.Mastercraft
		  Case "Tier6"
		    Return Beacon.Qualities.Ascendant
		  Case "Tier7"
		    Return Beacon.Qualities.AscendantPlus
		  Case "Tier8"
		    Return Beacon.Qualities.AscendantPlusPlus
		  Case "Tier9"
		    Return Beacon.Qualities.AscendantPlusPlusPlus
		  End Select
		End Function
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

	#tag Method, Flags = &h1
		Protected Function ValueForQuality(Quality As Beacon.Qualities, Multiplier As Double) As Double
		  Select Case Quality
		  Case Beacon.Qualities.Primitive
		    Return Beacon.QualityPrimitive / Multiplier
		  Case Beacon.Qualities.Ramshackle
		    Return Beacon.QualityRamshackle / Multiplier
		  Case Beacon.Qualities.Apprentice
		    Return Beacon.QualityApprentice / Multiplier
		  Case Beacon.Qualities.Journeyman
		    Return Beacon.QualityJourneyman / Multiplier
		  Case Beacon.Qualities.Mastercraft
		    Return Beacon.QualityMastercraft / Multiplier
		  Case Beacon.Qualities.Ascendant
		    Return Beacon.QualityAscendant / Multiplier
		  Case Beacon.Qualities.AscendantPlus
		    Return Beacon.QualityAscendantPlus / Multiplier
		  Case Beacon.Qualities.AscendantPlusPlus
		    Return Beacon.QualityAscendantPlusPlus / Multiplier
		  Case Beacon.Qualities.AscendantPlusPlusPlus
		    Return Beacon.QualityAscendantPlusPlusPlus / Multiplier
		  Else
		    Return Beacon.QualityPrimitive / Multiplier
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WebURL() As Text
		  #if DebugBuild
		    Return "https://workbench.thezaz.com/beacon"
		  #else
		    Return "https://thezaz.com/beacon"
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDataSource As Beacon.DataSource
	#tag EndProperty


	#tag Constant, Name = QualityApprentice, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendant, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlus, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlusPlus, Type = Double, Dynamic = False, Default = \"12", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlusPlusPlus, Type = Double, Dynamic = False, Default = \"16", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityJourneyman, Type = Double, Dynamic = False, Default = \"3.75", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityMastercraft, Type = Double, Dynamic = False, Default = \"5.5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityPrimitive, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityRamshackle, Type = Double, Dynamic = False, Default = \"1.25", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = URLScheme, Type = Text, Dynamic = False, Default = \"beacon", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Qualities, Type = Integer, Flags = &h1
		Primitive
		  Ramshackle
		  Apprentice
		  Journeyman
		  Mastercraft
		  Ascendant
		  AscendantPlus
		  AscendantPlusPlus
		AscendantPlusPlusPlus
	#tag EndEnum


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
