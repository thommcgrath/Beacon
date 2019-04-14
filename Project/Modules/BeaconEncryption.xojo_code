#tag Module
Protected Module BeaconEncryption
	#tag Method, Flags = &h1
		Protected Function BlowfishDecrypt(Key As MemoryBlock, Data As MemoryBlock) As MemoryBlock
		  If Data.Size < BeaconEncryption.BlowfishHeader.Size Then
		    Dim Err As New CryptoException
		    Err.Message = "Data is too short"
		    Raise Err
		  End If
		  
		  Dim Header As New BeaconEncryption.BlowfishHeader(Data.Left(BeaconEncryption.BlowfishHeader.Size))
		  If Header.MagicByte <> BeaconEncryption.BlowfishMagicByte Then
		    Dim Err As New CryptoException
		    Err.Message = "Data is not properly encrypted"
		    Raise Err
		  End If
		  If Header.Version > BeaconEncryption.BlowfishVersion Then
		    Dim Err As New CryptoException
		    Err.Message = "Encryption is too new"
		    Raise Err
		  End If
		  
		  Data = Data.Mid(Header.Size)
		  
		  Dim Crypt As New M_Crypto.Blowfish_MTC(Key)
		  Crypt.SetInitialVector(Header.Vector)
		  Data = Crypt.DecryptCBC(Data)
		  If Data.Size > Header.Length Then
		    Data = Data.Left(Header.Length)
		  End If
		  
		  Dim ComputedChecksum As UInt32 = Beacon.CRC32(Data)
		  If ComputedChecksum <> Header.Checksum Then
		    Dim Err As New CryptoException
		    Err.Message = "CRC32 checksum failed on decrypted data."
		    Raise Err
		  End If
		  
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BlowfishEncrypt(Key As MemoryBlock, Data As MemoryBlock) As MemoryBlock
		  Dim Header As New BeaconEncryption.BlowfishHeader
		  Header.MagicByte = BlowfishMagicByte
		  Header.Version = BlowfishVersion
		  Header.Vector = Crypto.GenerateRandomBytes(8)
		  Header.Length = Data.Size
		  Header.Checksum = Beacon.CRC32(Data)
		  
		  Dim Output As New MemoryBlock(0)
		  Output.Append(Header)
		  
		  Dim Crypt As New M_Crypto.Blowfish_MTC(Key)
		  Crypt.SetInitialVector(Header.Vector)
		  Output.Append(Crypt.EncryptCBC(Data))
		  
		  Return Output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PEMDecodePrivateKey(Key As String) As MemoryBlock
		  Key = Trim(Key)
		  Key = ReplaceLineEndings(Key, EndOfLineChar)
		  
		  Dim Lines() As String = Split(Key, EndOfLineChar)
		  If (Lines(0).IndexOf("BEGIN PRIVATE KEY") = -1 Or Lines(Lines.Ubound).IndexOf("END PRIVATE KEY") = -1) And (Lines(0).IndexOf("BEGIN RSA PRIVATE KEY") = -1 Or Lines(Lines.Ubound).IndexOf("END RSA PRIVATE KEY") = -1) Then
		    Dim Err As New CryptoException
		    Err.Message = "Text does not appear to be a PEM-encoded private key"
		    Raise Err
		  End If
		  
		  Lines.Remove(0)
		  Lines.Remove(Lines.Ubound)
		  
		  Key = Join(Lines, EndOfLineChar)
		  
		  Dim Decoded As MemoryBlock = DecodeBase64(Key)
		  #Pragma BreakOnExceptions Off
		  Try
		    Return Crypto.BERDecodePrivateKey(Decoded)
		  Catch Err As CryptoException
		    Return EncodeHex(Decoded)
		  End Try
		  #Pragma BreakOnExceptions Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PEMDecodePublicKey(Key As String) As MemoryBlock
		  Key = Trim(Key)
		  Key = ReplaceLineEndings(Key, EndOfLineChar)
		  
		  Dim Lines() As String = Split(Key, EndOfLineChar)
		  If Lines(0).IndexOf("BEGIN PUBLIC KEY") = -1 Or Lines(Lines.Ubound).IndexOf("END PUBLIC KEY") = -1 Then
		    Dim Err As New CryptoException
		    Err.Message = "Text does not appear to be a PEM-encoded public key"
		    Raise Err
		  End If
		  
		  Lines.Remove(0)
		  Lines.Remove(Lines.Ubound)
		  
		  Key = Join(Lines, EndOfLineChar)
		  
		  Dim Decoded As MemoryBlock = DecodeBase64(Key)
		  #Pragma BreakOnExceptions Off
		  Try
		    Return Crypto.BERDecodePublicKey(Decoded)
		  Catch Err As CryptoException
		    Return EncodeHex(Decoded)
		  End Try
		  #Pragma BreakOnExceptions Default
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PEMEncodePrivateKey(Key As MemoryBlock) As String
		  Dim Base64 As String = EncodeBase64(Crypto.DEREncodePrivateKey(Key))
		  Dim Lines() As String = Array("-----BEGIN PRIVATE KEY-----")
		  While Base64.Length > 64
		    Lines.Append(Base64.Left(64))
		    Base64 = Base64.SubString(64)
		  Wend
		  If Base64.Length > 0 Then
		    Lines.Append(Base64)
		  End If
		  Lines.Append("-----END PRIVATE KEY-----")
		  Return Join(Lines, EndOfLineChar)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PEMEncodePublicKey(Key As MemoryBlock) As String
		  Dim Base64 As String = EncodeBase64(DecodeHex(Key))
		  Dim Lines() As String = Array("-----BEGIN PUBLIC KEY-----")
		  While Base64.Length > 64
		    Lines.Append(Base64.Left(64))
		    Base64 = Base64.SubString(64)
		  Wend
		  If Base64.Length > 0 Then
		    Lines.Append(Base64)
		  End If
		  Lines.Append("-----END PUBLIC KEY-----")
		  Return Join(Lines, EndOfLineChar)
		End Function
	#tag EndMethod


	#tag Constant, Name = BlowfishLittleEndian, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BlowfishMagicByte, Type = Double, Dynamic = False, Default = \"&h8A", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BlowfishVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EndOfLineChar, Type = String, Dynamic = False, Default = \"&u10", Scope = Private
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
