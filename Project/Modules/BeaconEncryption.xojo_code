#tag Module
Protected Module BeaconEncryption
	#tag Method, Flags = &h21
		Private Function CRC32(Data As MemoryBlock) As UInt32
		  If Data = Nil Or Data.Size = 0 Then
		    Return 0
		  End If
		  
		  Return CRC_32OfStrMBS(Data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FixSymmetricKey(Key As MemoryBlock, DesiredLength As Integer) As MemoryBlock
		  If Key Is Nil Then
		    Return Nil
		  ElseIf Key.Size = DesiredLength Then
		    Return Key
		  End If
		  
		  Var Temp As New MemoryBlock(DesiredLength)
		  Temp.LittleEndian = Key.LittleEndian
		  Temp.StringValue(0, Min(Key.Size, DesiredLength)) = Key.StringValue(0, Min(Key.Size, DesiredLength))
		  Return Temp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateSymmetricKey(Bits As Integer = 256) As MemoryBlock
		  Return Crypto.GenerateRandomBytes(Bits / 8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetLength(Data As MemoryBlock) As Int32
		  Var Header As BeaconEncryption.SymmetricHeader = BeaconEncryption.SymmetricHeader.FromMemoryBlock(Data)
		  If Header <> Nil Then
		    Return Header.Size + Header.EncryptedLength
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsEncrypted(Data As MemoryBlock) As Boolean
		  Var Header As BeaconEncryption.SymmetricHeader = BeaconEncryption.SymmetricHeader.FromMemoryBlock(Data)
		  Return Header <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PEMDecodePrivateKey(Key As String) As String
		  Key = Key.Trim
		  Key = Key.ReplaceAll(Encodings.UTF8.Chr(13) + Encodings.UTF8.Chr(10), Encodings.UTF8.Chr(10))
		  Key = Key.ReplaceAll(Encodings.UTF8.Chr(13), Encodings.UTF8.Chr(10))
		  
		  Var Lines() As String = Key.Split(Encodings.UTF8.Chr(10))
		  If (Lines(0).IndexOf("BEGIN PRIVATE KEY") = -1 Or Lines(Lines.LastIndex).IndexOf("END PRIVATE KEY") = -1) And (Lines(0).IndexOf("BEGIN RSA PRIVATE KEY") = -1 Or Lines(Lines.LastIndex).IndexOf("END RSA PRIVATE KEY") = -1) Then
		    Var Err As New CryptoException
		    Err.Message = "Text does not appear to be a PEM-encoded private key"
		    Raise Err
		  End If
		  
		  Lines.RemoveAt(0)
		  Lines.RemoveAt(Lines.LastIndex)
		  
		  Key = Lines.Join(Encodings.UTF8.Chr(10))
		  
		  Var Decoded As String = DecodeBase64(Key)
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
		Protected Function PEMDecodePublicKey(Key As String) As String
		  Key = Key.Trim
		  Key = Key.ReplaceAll(Encodings.UTF8.Chr(13) + Encodings.UTF8.Chr(10), Encodings.UTF8.Chr(10))
		  Key = Key.ReplaceAll(Encodings.UTF8.Chr(13), Encodings.UTF8.Chr(10))
		  
		  Var Lines() As String = Key.Split(Encodings.UTF8.Chr(10))
		  If Lines(0).IndexOf("BEGIN PUBLIC KEY") = -1 Or Lines(Lines.LastIndex).IndexOf("END PUBLIC KEY") = -1 Then
		    Var Err As New CryptoException
		    Err.Message = "Text does not appear to be a PEM-encoded public key"
		    Raise Err
		  End If
		  
		  Lines.RemoveAt(0)
		  Lines.RemoveAt(Lines.LastIndex)
		  
		  Key = Lines.Join(Encodings.UTF8.Chr(10))
		  
		  Var Decoded As String = DecodeBase64(Key)
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
		Protected Function PEMEncodePrivateKey(Key As String) As String
		  Var Base64 As String = EncodeBase64(Crypto.DEREncodePrivateKey(Key), 0)
		  Var Lines() As String = Array("-----BEGIN PRIVATE KEY-----")
		  While Base64.Length > 64
		    Lines.Add(Base64.Left(64))
		    Base64 = Base64.Middle(64)
		  Wend
		  If Base64.Length > 0 Then
		    Lines.Add(Base64)
		  End If
		  Lines.Add("-----END PRIVATE KEY-----")
		  Return Lines.Join(Encodings.UTF8.Chr(10))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PEMEncodePublicKey(Key As String) As String
		  Var Base64 As String = EncodeBase64(DecodeHex(Key), 0)
		  Var Lines() As String = Array("-----BEGIN PUBLIC KEY-----")
		  While Base64.Length > 64
		    Lines.Add(Base64.Left(64))
		    Base64 = Base64.Middle(64)
		  Wend
		  If Base64.Length > 0 Then
		    Lines.Add(Base64)
		  End If
		  Lines.Add("-----END PUBLIC KEY-----")
		  Return Lines.Join(Encodings.UTF8.Chr(10))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Process(Extends Cipher As CipherMBS, Data As MemoryBlock) As MemoryBlock
		  #Pragma BreakOnExceptions Off
		  Var Initial As MemoryBlock = Cipher.ProcessMemory(Data)
		  If Initial Is Nil Then
		    Return Cipher.FinalizeAsMemory
		  Else
		    Return Initial + Cipher.FinalizeAsMemory
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShiftLeft(Value As UInt64, NumBits As UInt64) As UInt64
		  // It is insane that I need to implement this method manually.
		  
		  Return Value * (2 ^ NumBits)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShiftRight(Value As UInt64, NumBits As UInt64) As UInt64
		  // It is insane that I need to implement this method manually.
		  
		  Return Value / (2 ^ NumBits)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SlowDecrypt(Key As String, Source As String) As MemoryBlock
		  Var Parts() As String = Source.Split(":")
		  If Parts.Count <> 4 Then
		    Var Err As New CryptoException
		    Err.Message = "Incorrect number of parts"
		    Raise Err
		  End If
		  
		  Var Encrypted As MemoryBlock = DecodeBase64(Parts(0))
		  Var Salt As MemoryBlock = DecodeBase64(Parts(1))
		  Var Algorithm As Crypto.HashAlgorithms
		  Select Case Parts(2)
		  Case "sha2-512"
		    Algorithm = Crypto.HashAlgorithms.SHA2_512
		  Else
		    Var Err As New CryptoException
		    Err.Message = "Unknown algorithm " + Parts(2)
		    Raise Err
		  End Select
		  Var Iterations As Integer = Parts(3).ToInteger()
		  
		  Var DerivedKey As MemoryBlock = Crypto.PBKDF2(Salt, Key, Iterations, 32, Algorithm)
		  Return SymmetricDecrypt(DerivedKey, Encrypted)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SlowEncrypt(Key As String, Data As MemoryBlock) As String
		  Const TargetTime = 250000 // Microseconds
		  Var Algorithm As Crypto.HashAlgorithms = Crypto.HashAlgorithms.SHA2_512
		  
		  If mOptimalIterations = 0 Then
		    // Encrypt something to first get a baseline
		    Var Count As Integer = 50000
		    Var Salt As MemoryBlock = Crypto.GenerateRandomBytes(32)
		    Var TestData As MemoryBlock = v4UUID.Create.StringValue
		    
		    Var Start As Double = System.Microseconds
		    Call Crypto.PBKDF2(Salt, TestData, Count, 32, Algorithm)
		    Var Duration As Double = System.Microseconds - Start
		    
		    Var Ratio As Double = Duration / TargetTime
		    
		    mOptimalIterations = Count / Ratio
		  End If
		  
		  Var Salt As MemoryBlock = Crypto.GenerateRandomBytes(32)
		  Var DerivedKey As MemoryBlock = Crypto.PBKDF2(Salt, Key, mOptimalIterations, 32, Algorithm)
		  Var Encrypted As MemoryBlock = SymmetricEncrypt(DerivedKey, Data)
		  
		  Return EncodeBase64(Encrypted, 0) + ":" + EncodeBase64(Salt, 0) + ":sha2-512:" + mOptimalIterations.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SymmetricDecrypt(Key As MemoryBlock, Data As MemoryBlock) As MemoryBlock
		  If Data Is Nil Or Data.Size = 0 Then
		    Return ""
		  End If
		  
		  Var Header As BeaconEncryption.SymmetricHeader = BeaconEncryption.SymmetricHeader.FromMemoryBlock(Data)
		  If Header = Nil Then
		    Var Err As New CryptoException
		    Err.Message = "Data is not properly encrypted"
		    Raise Err
		  End If
		  
		  Data = Data.Middle(Header.Size, Data.Size - Header.Size)
		  
		  Var Crypt As CipherMBS
		  Select Case Header.Version
		  Case 2
		    Crypt = CipherMBS.aes_256_cbc
		    Key = FixSymmetricKey(Key, Crypt.KeyLength)
		  Case 1
		    Crypt = CipherMBS.bf_cbc
		  End Select
		  
		  If Not Crypt.DecryptInit(Key, Header.Vector) Then
		    Var Err As New CryptoException
		    Err.Message = "Incorrect key or vector length"
		    Raise Err
		  End If
		  
		  Data = Crypt.Process(Data)
		  
		  If Data.Size > Header.Length Then
		    Data = Data.Left(Header.Length)
		  End If
		  
		  Var ComputedChecksum As UInt32 = BeaconEncryption.CRC32(Data)
		  If ComputedChecksum <> Header.Checksum Then
		    Var Err As New CryptoException
		    Err.Message = "CRC32 checksum failed on decrypted data."
		    Raise Err
		  End If
		  
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SymmetricEncrypt(Key As MemoryBlock, Data As MemoryBlock, Version As Integer = 2) As MemoryBlock
		  If Data = "" Then
		    Return ""
		  End If
		  
		  Var Header As New BeaconEncryption.SymmetricHeader(Data, Version)
		  
		  Var Crypt As CipherMBS
		  Select Case Version
		  Case 2
		    Crypt = CipherMBS.aes_256_cbc
		    Key = FixSymmetricKey(Key, Crypt.KeyLength)
		  Case 1
		    Crypt = CipherMBS.bf_cbc
		  Else
		    Var Err As New CryptoException
		    Err.Message = "Unknown symmetric version " + Version.ToString
		    Raise Err
		  End Select
		  
		  If Not Crypt.EncryptInit(Key, Header.Vector) Then
		    Var Err As New CryptoException
		    Err.Message = "Incorrect key or vector length"
		    Raise Err
		    Return ""
		  End If
		  
		  Return Header.Encoded + Crypt.Process(Data)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOptimalIterations As Integer
	#tag EndProperty


	#tag Constant, Name = SymmetricLittleEndian, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SymmetricMagicByte, Type = Double, Dynamic = False, Default = \"&h8A", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SymmetricVersion, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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
