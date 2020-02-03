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
		  
		  Self.mIdentifier = New v4UUID
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Identifier As String, PublicKey As String, PrivateKey As String)
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
		    Self.mExpirationString = Dict.Lookup("expiration", "")
		  Catch Err As RuntimeException
		    Self.mExpirationString = ""
		  End Try
		  
		  Try
		    If Dict.HasKey("signatures") Then
		      Dim SignaturesDict As Dictionary = Dict.Value("signatures")
		      Self.mSignature = DecodeHex(SignaturesDict.Lookup(Self.SignatureVersion.ToString, ""))
		    Else
		      Self.mSignature = Nil
		    End If
		  Catch Err As RuntimeException
		    Self.mSignature = Nil
		  End Try
		  
		  Try
		    If Dict.HasKey("usercloud_key") And Dict.Value("usercloud_key") <> Nil Then
		      Dim EncryptedCloudKey As String = Dict.Value("usercloud_key")
		      Self.mUsercloudKey = Self.Decrypt(DecodeHex(EncryptedCloudKey))
		    End If
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Try
		    Self.mBanned = Dict.Lookup("banned", false)
		  Catch Err As RuntimeException
		    
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
		  Dict.Value("Banned") = Self.mBanned
		  If Self.mSignature <> Nil And Self.mSignature.Size > 0 Then
		    Dict.Value("Signature") = EncodeHex(Self.mSignature)
		  End If
		  If Self.mExpirationString <> "" Then
		    Dict.Value("Expiration") = Self.mExpirationString
		  End If
		  If Self.mUsercloudKey <> Nil Then
		    Dict.Value("Cloud Key") = EncodeHex(Self.mUsercloudKey)
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromUserDictionary(Dict As Dictionary, Password As String) As Beacon.Identity
		  Try
		    Dim PrivateKey As String
		    
		    If Password = "" Then
		      Return Nil
		    End If
		    
		    Try
		      Dim Salt As MemoryBlock = DecodeHex(Dict.Value("private_key_salt"))
		      Dim Iterations As Integer = Dict.Value("private_key_iterations")
		      Dim Key As MemoryBlock = Crypto.PBKDF2(Salt, Password, Iterations, 56, Crypto.Algorithm.SHA512)
		      Dim Decrypted As MemoryBlock = BeaconEncryption.SymmetricDecrypt(Key, DecodeHex(Dict.Value("private_key")))
		      PrivateKey = BeaconEncryption.PEMDecodePrivateKey(Decrypted)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		    
		    Dim PublicKey As String = BeaconEncryption.PEMDecodePublicKey(Dict.Value("public_key"))
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
		    Identity.mExpirationString = Source.Value("Expiration")
		  End If
		  
		  If Source.HasKey("Cloud Key") Then
		    Identity.mUsercloudKey = DecodeHex(Source.Value("Cloud Key"))
		  End If
		  
		  If Source.HasKey("Banned") Then
		    Identity.mBanned = Source.Value("Banned")
		  End If
		  
		  Identity.Validate()
		  
		  Return Identity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnonymous() As Boolean
		  Return Self.mLoginKey.Length = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBanned() As Boolean
		  Return Self.mBanned
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
		  Dim Now As DateTime = DateTime.Now
		  Dim Period As New DateInterval(30) // Yes, this says 30 years
		  Dim SelfExpiration As DateTime
		  If Self.mExpirationString <> "" Then
		    SelfExpiration = NewDateFromSQLDateTime(Self.mExpirationString)
		  Else
		    SelfExpiration = Now + Period
		  End If
		  Dim OtherExpiration As DateTime
		  If Other.mExpirationString <> "" Then
		    OtherExpiration = NewDateFromSQLDateTime(Other.mExpirationString)
		  Else
		    OtherExpiration = Now + Period
		  End If
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
		  
		  Result = Self.Compare(Self.mUsercloudKey, Other.mUsercloudKey)
		  If Result <> 0 Then
		    Return Result
		  End If
		  
		  // They are fully equal
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey() As String
		  Return Self.mPrivateKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As String
		  Return Self.mPublicKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As MemoryBlock) As MemoryBlock
		  Return Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserCloudKey() As MemoryBlock
		  If Self.mUsercloudKey <> Nil Then
		    Return Self.mUsercloudKey.StringValue(0, Self.mUsercloudKey.Size)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate()
		  If Self.mSignature <> Nil Then
		    Dim Fields(3) As String
		    Fields(0) = Beacon.HardwareID
		    Fields(1) = Self.mIdentifier.Lowercase
		    Fields(2) = Self.mPurchasedOmniVersion.ToString(Locale.Raw)
		    Fields(3) = If(Self.mBanned, "Banned", "Clean")
		    
		    If Self.mExpirationString <> "" Then
		      Dim Expires As DateTime = NewDateFromSQLDateTime(Self.mExpirationString)
		      Dim Now As DateTime = DateTime.Now
		      If Now.SecondsFrom1970 < Expires.SecondsFrom1970 Then
		        // Not Expired
		        Fields.AddRow(Self.mExpirationString)
		      End If
		    End If
		    
		    Dim PublicKey As String = BeaconAPI.PublicKey
		    Dim CheckData As String = Fields.Join(" ")
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
		    Dim Encrypted As String = Crypto.RSAEncrypt(Original, PublicKey)
		    Dim Decrypted As String = Crypto.RSADecrypt(Encrypted, PrivateKey)
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
		Private mBanned As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpirationString As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPurchasedOmniVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsercloudKey As MemoryBlock
	#tag EndProperty


	#tag Constant, Name = SignatureVersion, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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
End Class
#tag EndClass
