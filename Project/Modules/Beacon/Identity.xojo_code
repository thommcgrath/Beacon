#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Function Clone() As Beacon.Identity
		  Dim Exported As Dictionary = Self.Export()
		  Return Self.Import(Exported)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Compare(Left As MemoryBlock, Right As MemoryBlock) As Integer
		  // I guess if both are non-nil, we'll sort by hex?
		  
		  If Left <> Nil And Right = Nil Then
		    Return 1
		  ElseIf Left = Nil And Right <> Nil Then
		    Return -1
		  ElseIf Left = Nil And Right = Nil Then
		    Return 0
		  End If
		  
		  Dim LeftString As String = EncodeHex(Left)
		  Dim RightString As String = EncodeHex(Right)
		  Return StrComp(LeftString, RightString, REALbasic.StrCompLexical)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim PrivateKey, PublicKey As String
		  If Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) = False Or Crypto.RSAVerifyKey(PrivateKey) = False Or Crypto.RSAVerifyKey(PublicKey) = False Then
		    Raise New CryptoException
		  End If
		  
		  // Keys are already hex encoded, despite being MemoryBlock objects. Brilliant.
		  
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Identifier As String, PublicKey As MemoryBlock, PrivateKey As MemoryBlock)
		  Self.mIdentifier = Identifier
		  Self.mPublicKey = PublicKey
		  Self.mPrivateKey = PrivateKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsumeUserDictionary(Dict As Dictionary) As Boolean
		  Dim UserID As String = Dict.Value("user_id")
		  If Self.mIdentifier <> UserID Then
		    Return False
		  End If
		  
		  Try
		    Self.mLoginKey = Dict.Lookup("login_key", "")
		  Catch Err As RuntimeException
		    Self.mLoginKey = ""
		  End Try
		  
		  Try
		    Self.mPurchasedOmniVersion = Dict.Lookup("omni_version", 0)
		  Catch Err As RuntimeException
		    Self.mPurchasedOmniVersion = 0
		  End Try
		  
		  Try
		    Self.mExpirationText = Dict.Lookup("expiration", "")
		  Catch Err As RuntimeException
		    Self.mExpirationText = ""
		  End Try
		  
		  Try
		    If Dict.HasKey("signatures") Then
		      Dim SignaturesDict As Dictionary = Dict.Value("signatures")
		      Self.mSignature = DecodeHex(SignaturesDict.Lookup(Str(Self.SignatureVersion, "-0"), ""))
		    Else
		      Self.mSignature = Nil
		    End If
		  Catch Err As RuntimeException
		    Self.mSignature = Nil
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(Data As MemoryBlock) As MemoryBlock
		  Try
		    Dim Decrypted As MemoryBlock = Crypto.RSADecrypt(Data, Self.mPrivateKey)
		    Return Decrypted
		  Catch Err As CryptoException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function Encrypt(Data As MemoryBlock) As MemoryBlock
		  Return Crypto.RSAEncrypt(Data, Self.mPublicKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Dictionary
		  Dim Dict As New Dictionary
		  Dict.Value("Identifier") = Self.mIdentifier
		  Dict.Value("Public") = Self.mPublicKey
		  Dict.Value("Private") = Self.mPrivateKey
		  Dict.Value("Version") = 2
		  Dict.Value("Omni Version") = Self.mPurchasedOmniVersion
		  Dict.Value("LoginKey") = Self.mLoginKey
		  If Self.mSignature <> Nil And Self.mSignature.Size > 0 Then
		    Dict.Value("Signature") = EncodeHex(Self.mSignature)
		  End If
		  If Self.mExpirationText <> "" Then
		    Dict.Value("Expiration") = Self.mExpirationText
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromUserDictionary(Dict As Dictionary, Password As String) As Beacon.Identity
		  Try
		    Dim PrivateKey As MemoryBlock
		    
		    If Password = "" Then
		      Return Nil
		    End If
		    
		    Try
		      Dim Salt As MemoryBlock = DecodeHex(Dict.Value("private_key_salt"))
		      Dim Iterations As Integer = Dict.Value("private_key_iterations")
		      Dim Key As MemoryBlock = Crypto.PBKDF2(Salt, Password, Iterations, 56, Crypto.Algorithm.SHA512)
		      Dim Decrypted As MemoryBlock = BeaconEncryption.BlowfishDecrypt(Key, DecodeHex(Dict.Value("private_key")))
		      PrivateKey = BeaconEncryption.PEMDecodePrivateKey(Decrypted)
		    Catch Err As CryptoException
		      Return Nil
		    End Try
		    
		    Dim PublicKey As MemoryBlock = BeaconEncryption.PEMDecodePublicKey(Dict.Value("public_key"))
		    Dim UserID As String = Dict.Value("user_id")
		    
		    If Not VerifyKeyPair(PublicKey, PrivateKey) Then
		      Return Nil
		    End If
		    
		    Dim Identity As New Beacon.Identity(UserID, PublicKey, PrivateKey)
		    If Not Identity.ConsumeUserDictionary(Dict) Then
		      Return Nil
		    End If
		    Identity.Validate()
		    Return Identity
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Source As Dictionary) As Beacon.Identity
		  If Source.HasKey("Identifier") = False Or Source.HasKey("Public") = False Or Source.HasKey("Private") = False Then
		    Return Nil
		  End If
		  
		  Dim PublicKey, PrivateKey As String
		  If Source.HasKey("Version") Then
		    Select Case Source.Value("Version")
		    Case 2
		      PublicKey = Source.Value("Public")
		      PrivateKey = Source.Value("Private")
		    Else
		      Return Nil
		    End Select
		  Else
		    PublicKey = DecodeHex(Source.Value("Public"))
		    PrivateKey = DecodeHex(Source.Value("Private"))
		  End If
		  
		  If Not VerifyKeyPair(PublicKey, PrivateKey) Then
		    Return Nil
		  End If
		  
		  Dim Identity As New Beacon.Identity(Source.Value("Identifier"), PublicKey, PrivateKey)
		  
		  If Source.HasKey("Omni Version") Then
		    Identity.mPurchasedOmniVersion = Source.Value("Omni Version")
		  End If
		  
		  If Source.HasKey("Signature") Then
		    Identity.mSignature = DecodeHex(Source.Value("Signature"))
		  End If
		  
		  If Source.HasKey("LoginKey") Then
		    Identity.mLoginKey = Source.Value("LoginKey")
		  End If
		  
		  If Source.HasKey("Expiration") Then
		    Identity.mExpirationText = Source.Value("Expiration")
		  End If
		  
		  Identity.Validate()
		  
		  Return Identity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsUserDictionary(Dict As Dictionary) As Boolean
		  If Dict = Nil Then
		    Return False
		  End If
		  
		  Return Dict.HasAllKeys("private_key_salt", "private_key_iterations", "private_key", "public_key", "user_id")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoginKey() As String
		  Return Self.mLoginKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OmniVersion() As Integer
		  Return Self.mPurchasedOmniVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Identity) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  // Case changes do matter
		  Dim Result As Integer = StrComp(Self.mLoginKey, Other.mLoginKey, REALbasic.StrCompLexical)
		  If Result <> 0 Then
		    Return Result
		  End If
		  
		  // Case changes do not matter
		  If Self.mIdentifier <> Other.mIdentifier Then
		    Return StrComp(Self.mIdentifier, Other.mIdentifier, REALbasic.StrCompLexical)
		  End If
		  
		  // Newer sorts after older
		  If Self.mPurchasedOmniVersion > Other.mPurchasedOmniVersion Then
		    Return 1
		  ElseIf Self.mPurchasedOmniVersion < Other.mPurchasedOmniVersion Then
		    Return -1
		  End If
		  
		  // Compare expirations
		  Dim SelfExpiration, OtherExpiration As Date
		  #Pragma BreakOnExceptions False
		  Try
		    SelfExpiration = NewDateFromSQLDateTime(Self.mExpirationText)
		  Catch Err As UnsupportedFormatException
		    SelfExpiration = FutureDate(30)
		  End Try
		  Try
		    OtherExpiration = NewDateFromSQLDateTime(Other.mExpirationText)
		  Catch Err As UnsupportedFormatException
		    OtherExpiration = FutureDate(30)
		  End Try
		  #Pragma BreakOnExceptions Default
		  If SelfExpiration.SecondsFrom1970 = OtherExpiration.SecondsFrom1970 Then
		  ElseIf SelfExpiration.SecondsFrom1970 > OtherExpiration.SecondsFrom1970 Then
		    Return 1
		  Else
		    Return -1
		  End If
		  
		  // Use custom comparison for binary data
		  Result = Self.Compare(Self.mPublicKey, Other.mPublicKey)
		  If Result <> 0 Then
		    Return Result
		  End If
		  
		  Result = Self.Compare(Self.mPrivateKey, Other.mPrivateKey)
		  If Result <> 0 Then
		    Return Result
		  End If
		  
		  Result = Self.Compare(Self.mSignature, Other.mSignature)
		  If Result <> 0 Then
		    Return Result
		  End If
		  
		  // They are fully equal
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey() As MemoryBlock
		  Return Self.mPrivateKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As MemoryBlock
		  Return Self.mPublicKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As MemoryBlock) As MemoryBlock
		  Return Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate()
		  If Self.mSignature <> Nil Then
		    Dim Fields(2) As String
		    Fields(0) = Beacon.HardwareID
		    Fields(1) = Self.mIdentifier.Lowercase
		    Fields(2) = Str(Self.mPurchasedOmniVersion, "-0")
		    
		    If Self.mExpirationText <> "" Then
		      Dim Expires As Date = NewDateFromSQLDateTime(Self.mExpirationText)
		      Dim Now As New Date
		      If Now.SecondsFrom1970 < Expires.SecondsFrom1970 Then
		        // Not Expired
		        Fields.Append(Self.mExpirationText)
		      End If
		    End If
		    
		    Dim PublicKey As MemoryBlock = BeaconAPI.PublicKey
		    Dim CheckData As MemoryBlock = Join(Fields, " ")
		    If Crypto.RSAVerifySignature(CheckData, Self.mSignature, PublicKey) Then
		      // It is valid, now return so the reset code below does not fire
		      Return
		    End If
		  End If
		  
		  Self.mLoginKey = ""
		  Self.mPurchasedOmniVersion = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function VerifyKeyPair(PublicKey As MemoryBlock, PrivateKey As MemoryBlock) As Boolean
		  If Crypto.RSAVerifyKey(PublicKey) = False Or Crypto.RSAVerifyKey(PrivateKey) = False Then
		    Return False
		  End If
		  
		  Try
		    Dim Original As MemoryBlock = Crypto.GenerateRandomBytes(12)
		    Dim Encrypted As MemoryBlock = Crypto.RSAEncrypt(Original, PublicKey)
		    Dim Decrypted As MemoryBlock = Crypto.RSADecrypt(Encrypted, PrivateKey)
		    If Decrypted <> Original Then
		      Return False
		    End If
		    
		    Dim Signature As MemoryBlock = Crypto.RSASign(Original, PrivateKey)
		    Return Crypto.RSAVerifySignature(Original, Signature, PublicKey)
		  Catch Err As CryptoException
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExpirationText As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPurchasedOmniVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As MemoryBlock
	#tag EndProperty


	#tag Constant, Name = SignatureVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Private
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
End Class
#tag EndClass
