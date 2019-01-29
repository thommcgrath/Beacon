#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Function Clone() As Beacon.Identity
		  Dim Exported As Xojo.Core.Dictionary = Self.Export()
		  Return Self.Import(Exported)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Compare(Left As Xojo.Core.MemoryBlock, Right As Xojo.Core.MemoryBlock) As Integer
		  // I guess if both are non-nil, we'll sort by hex?
		  
		  If Left <> Nil And Right = Nil Then
		    Return 1
		  ElseIf Left = Nil And Right <> Nil Then
		    Return -1
		  ElseIf Left = Nil And Right = Nil Then
		    Return 0
		  End If
		  
		  Dim LeftString As String = Beacon.EncodeHex(Left)
		  Dim RightString As String = Beacon.EncodeHex(Right)
		  Return StrComp(LeftString, RightString, REALbasic.StrCompLexical)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim PrivateKey, PublicKey As Xojo.Core.MemoryBlock
		  If Xojo.Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) = False Or Xojo.Crypto.RSAVerifyKey(PrivateKey) = False Or Xojo.Crypto.RSAVerifyKey(PublicKey) = False Then
		    Raise New Xojo.Crypto.CryptoException
		  End If
		  
		  // Keys are already hex encoded, despite being MemoryBlock objects. Brilliant.
		  
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mPrivateKey = PrivateKey
		  Self.mPublicKey = PublicKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Identifier As Text, PublicKey As Xojo.Core.MemoryBlock, PrivateKey As Xojo.Core.MemoryBlock)
		  Self.mIdentifier = Identifier
		  Self.mPublicKey = PublicKey
		  Self.mPrivateKey = PrivateKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsumeUserDictionary(Dict As Xojo.Core.Dictionary) As Boolean
		  Dim UserID As Text = Dict.Value("user_id")
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
		      Dim SignaturesDict As Xojo.Core.Dictionary = Dict.Value("signatures")
		      Self.mSignature = Beacon.DecodeHex(SignaturesDict.Lookup(Self.SignatureVersion.ToText, ""))
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
		Function Decrypt(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Try
		    Dim Decrypted As Xojo.Core.MemoryBlock = Xojo.Crypto.RSADecrypt(Data, Self.mPrivateKey)
		    Return Decrypted
		  Catch Err As Xojo.Crypto.CryptoException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSAEncrypt(Data, Self.mPublicKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Identifier") = Self.mIdentifier
		  Dict.Value("Public") = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPublicKey)
		  Dict.Value("Private") = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPrivateKey)
		  Dict.Value("Version") = 2
		  Dict.Value("Omni Version") = Self.mPurchasedOmniVersion
		  Dict.Value("LoginKey") = Self.mLoginKey
		  If Self.mSignature <> Nil And Self.mSignature.Size > 0 Then
		    Dict.Value("Signature") = Beacon.EncodeHex(Self.mSignature)
		  End If
		  If Self.mExpirationText <> "" Then
		    Dict.Value("Expiration") = Self.mExpirationText
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromUserDictionary(Dict As Xojo.Core.Dictionary, Password As Text) As Beacon.Identity
		  Try
		    Dim PrivateKey As Xojo.Core.MemoryBlock
		    
		    If Password = "" Then
		      Return Nil
		    End If
		    
		    Try
		      Dim Salt As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Dict.Value("private_key_salt"))
		      Dim Iterations As Integer = Dict.Value("private_key_iterations")
		      Dim Key As Xojo.Core.MemoryBlock = Xojo.Crypto.PBKDF2(Salt, Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Password), Iterations, 56, Xojo.Crypto.HashAlgorithms.SHA512)
		      Dim Decrypted As Xojo.Core.MemoryBlock = BeaconEncryption.BlowfishDecrypt(Key, Beacon.DecodeHex(Dict.Value("private_key")))
		      PrivateKey = BeaconEncryption.PEMDecodePrivateKey(Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Decrypted, False))
		    Catch Err As Xojo.Crypto.CryptoException
		      Return Nil
		    End Try
		    
		    Dim PublicKey As Xojo.Core.MemoryBlock = BeaconEncryption.PEMDecodePublicKey(Dict.Value("public_key"))
		    Dim UserID As Text = Dict.Value("user_id")
		    
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
		Function Identifier() As Text
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Source As Xojo.Core.Dictionary) As Beacon.Identity
		  If Source.HasKey("Identifier") = False Or Source.HasKey("Public") = False Or Source.HasKey("Private") = False Then
		    Return Nil
		  End If
		  
		  Dim PublicKey, PrivateKey As Xojo.Core.MemoryBlock
		  If Source.HasKey("Version") Then
		    Select Case Source.Value("Version")
		    Case 2
		      PublicKey = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source.Value("Public"))
		      PrivateKey = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Source.Value("Private"))
		    Else
		      Return Nil
		    End Select
		  Else
		    PublicKey = Beacon.DecodeHex(Source.Value("Public"))
		    PrivateKey = Beacon.DecodeHex(Source.Value("Private"))
		  End If
		  
		  If Not VerifyKeyPair(PublicKey, PrivateKey) Then
		    Return Nil
		  End If
		  
		  Dim Identity As New Beacon.Identity(Source.Value("Identifier"), PublicKey, PrivateKey)
		  
		  If Source.HasKey("Omni Version") Then
		    Identity.mPurchasedOmniVersion = Source.Value("Omni Version")
		  End If
		  
		  If Source.HasKey("Signature") Then
		    Identity.mSignature = Beacon.DecodeHex(Source.Value("Signature"))
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
		Shared Function IsUserDictionary(Dict As Xojo.Core.Dictionary) As Boolean
		  If Dict = Nil Then
		    Return False
		  End If
		  
		  Return Dict.HasAllKeys("private_key_salt", "private_key_iterations", "private_key", "public_key", "user_id")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoginKey() As Text
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
		  Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		  Dim Zone As New Xojo.Core.TimeZone(0)
		  Dim Period As New Xojo.Core.DateInterval(30)
		  Dim SelfExpiration As Xojo.Core.Date
		  If Self.mExpirationText <> "" Then
		    SelfExpiration = Self.mExpirationText.ToDate(Zone)
		  Else
		    SelfExpiration = Now + Period
		  End If
		  Dim OtherExpiration As Xojo.Core.Date
		  If Other.mExpirationText <> "" Then
		    OtherExpiration = Other.mExpirationText.ToDate(Zone)
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
		  
		  // They are fully equal
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey() As Xojo.Core.MemoryBlock
		  Return Self.mPrivateKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As Xojo.Core.MemoryBlock
		  Return Self.mPublicKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sign(Data As Xojo.Core.MemoryBlock) As Xojo.Core.MemoryBlock
		  Return Xojo.Crypto.RSASign(Data, Self.mPrivateKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate()
		  If Self.mSignature <> Nil Then
		    Dim Fields(2) As Text
		    Fields(0) = Beacon.HardwareID
		    Fields(1) = Self.mIdentifier.Lowercase
		    Fields(2) = Self.mPurchasedOmniVersion.ToText(Xojo.Core.Locale.Raw)
		    
		    If Self.mExpirationText <> "" Then
		      Dim Expires As Xojo.Core.Date = Self.mExpirationText.ToDate(New Xojo.Core.TimeZone(0))
		      Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		      If Now.SecondsFrom1970 < Expires.SecondsFrom1970 Then
		        // Not Expired
		        Fields.Append(Self.mExpirationText)
		      End If
		    End If
		    
		    Dim PublicKey As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(BeaconAPI.PublicKey)
		    Dim CheckData As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Fields.Join(" "))
		    If Xojo.Crypto.RSAVerifySignature(CheckData, Self.mSignature, PublicKey) Then
		      // It is valid, now return so the reset code below does not fire
		      Return
		    End If
		  End If
		  
		  Self.mLoginKey = ""
		  Self.mPurchasedOmniVersion = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function VerifyKeyPair(PublicKey As Xojo.Core.MemoryBlock, PrivateKey As Xojo.Core.MemoryBlock) As Boolean
		  If Xojo.Crypto.RSAVerifyKey(PublicKey) = False Or Xojo.Crypto.RSAVerifyKey(PrivateKey) = False Then
		    Return False
		  End If
		  
		  Try
		    Dim Original As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(12)
		    Dim Encrypted As Xojo.Core.MemoryBlock = Xojo.Crypto.RSAEncrypt(Original, PublicKey)
		    Dim Decrypted As Xojo.Core.MemoryBlock = Xojo.Crypto.RSADecrypt(Encrypted, PrivateKey)
		    If Decrypted <> Original Then
		      Return False
		    End If
		    
		    Dim Signature As Xojo.Core.MemoryBlock = Xojo.Crypto.RSASign(Original, PrivateKey)
		    Return Xojo.Crypto.RSAVerifySignature(Original, Signature, PublicKey)
		  Catch Err As Xojo.Crypto.CryptoException
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExpirationText As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginKey As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPurchasedOmniVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As Xojo.Core.MemoryBlock
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
