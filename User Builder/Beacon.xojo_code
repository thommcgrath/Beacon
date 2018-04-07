#tag Module
Protected Module Beacon
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
		  
		  Return Text.Join(Chars, "").Lowercase
		End Function
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
		    
		    Return Text.Join(Output, "")
		  #else
		    Return EncodeBase64(Beacon.ConvertMemoryBlock(Source), 0).ToText
		  #endif
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
		    Return Text.Join(Chars, "")
		  #else
		    Return REALbasic.EncodeHex(Beacon.ConvertMemoryBlock(Block)).ToText
		  #endif
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
