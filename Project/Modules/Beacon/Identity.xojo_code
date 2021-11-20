#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Function Clone() As Beacon.Identity
		  Var JSON As String = Beacon.GenerateJSON(Self.Export, False)
		  Var Parsed As Variant = Beacon.ParseJSON(JSON)
		  Return Self.Import(Dictionary(Parsed))
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
		  
		  Var LeftString As String = EncodeHex(Left)
		  Var RightString As String = EncodeHex(Right)
		  Return LeftString.Compare(RightString, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Var PrivateKey, PublicKey As String
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
		  Self.mIdentifier = Identifier.Lowercase
		  Self.mPublicKey = PublicKey
		  Self.mPrivateKey = PrivateKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsumeUserDictionary(Dict As Dictionary) As Boolean
		  Var UserID As String = Dict.Value("user_id")
		  If Self.mIdentifier <> UserID Then
		    Return False
		  End If
		  
		  Try
		    Self.mUsername = Dict.Lookup("username", "")
		  Catch Err As RuntimeException
		    Self.mUsername = ""
		  End Try
		  
		  Self.mLicenses.ResizeTo(-1)
		  If Dict.HasKey("licenses") Then
		    Var LicenseDicts() As Variant = Dict.Value("licenses")
		    For Each LicenseDictMember As Variant In LicenseDicts
		      Try
		        Self.mLicenses.Add(New Beacon.OmniLicense(Dictionary(LicenseDictMember)))
		      Catch Err As RuntimeException
		      End Try
		    Next LicenseDictMember
		  End If
		  
		  Try
		    Self.mExpirationString = Dict.Lookup("expiration", "")
		  Catch Err As RuntimeException
		    Self.mExpirationString = ""
		  End Try
		  
		  Try
		    If Dict.HasKey("signatures") Then
		      Var SignaturesDict As Dictionary = Dict.Value("signatures")
		      Self.mSignature = DecodeHex(SignaturesDict.Value(Self.SignatureVersion.ToString))
		      Self.mSignatureVersion = Self.SignatureVersion
		    Else
		      Self.mSignature = Nil
		    End If
		  Catch Err As RuntimeException
		    Self.mSignature = Nil
		  End Try
		  
		  Try
		    If Dict.HasKey("usercloud_key") And Dict.Value("usercloud_key") <> Nil Then
		      Var EncryptedCloudKey As String = Dict.Value("usercloud_key")
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
		    Var Decrypted As MemoryBlock = Crypto.RSADecrypt(Data, Self.mPrivateKey)
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
		  Var Licenses() As Dictionary
		  For Idx As Integer = 0 To Self.mLicenses.LastIndex
		    Var License As New Dictionary
		    License.Value("Flags") = Self.mLicenses(Idx).Flags
		    License.Value("Product ID") = Self.mLicenses(Idx).ProductID
		    If Self.mLicenses(Idx).IsLifetime = False Then
		      License.Value("Expiration") = Self.mLicenses(Idx).ExpirationString
		    End If
		    Licenses.Add(License)
		  Next Idx
		  
		  Var Dict As New Dictionary
		  Dict.Value("Identifier") = Self.mIdentifier
		  Dict.Value("Public") = Self.mPublicKey
		  Dict.Value("Private") = Self.mPrivateKey
		  Dict.Value("Version") = Self.SignatureVersion
		  Dict.Value("Licenses") = Licenses
		  Dict.Value("Username") = Self.mUsername
		  Dict.Value("Banned") = Self.mBanned
		  If (Self.mSignature Is Nil) = False And Self.mSignature.Size > 0 Then
		    Dict.Value("Signature") = EncodeHex(Self.mSignature)
		    Dict.Value("Signature Version") = Self.mSignatureVersion
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
		    Var PrivateKey As String
		    
		    If Password = "" Then
		      Return Nil
		    End If
		    
		    Try
		      Var Salt As MemoryBlock = DecodeHex(Dict.Value("private_key_salt"))
		      Var Iterations As Integer = Dict.Value("private_key_iterations")
		      Var Key As MemoryBlock = Crypto.PBKDF2(Salt, Password, Iterations, 56, Crypto.HashAlgorithms.SHA512)
		      Var Decrypted As MemoryBlock = BeaconEncryption.SymmetricDecrypt(Key, DecodeHex(Dict.Value("private_key")))
		      PrivateKey = BeaconEncryption.PEMDecodePrivateKey(Decrypted)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		    
		    Var PublicKey As String = BeaconEncryption.PEMDecodePublicKey(Dict.Value("public_key"))
		    Var UserID As String = Dict.Value("user_id")
		    
		    If Not VerifyKeyPair(PublicKey, PrivateKey) Then
		      Return Nil
		    End If
		    
		    Var Identity As New Beacon.Identity(UserID, PublicKey, PrivateKey)
		    If Not Identity.ConsumeUserDictionary(Dict) Then
		      Return Nil
		    End If
		    Call Identity.Validate()
		    Return Identity
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Source As Dictionary) As Beacon.Identity
		  If Source.HasKey("Identifier") = False Or Source.HasKey("Public") = False Or Source.HasKey("Private") = False Then
		    Return Nil
		  End If
		  
		  Var PublicKey, PrivateKey As String
		  If Source.HasKey("Version") Then
		    Select Case Source.Value("Version")
		    Case 2, 3
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
		  
		  Var Identity As New Beacon.Identity(Source.Value("Identifier"), PublicKey, PrivateKey)
		  
		  If Source.HasKey("Licenses") Then
		    Var Licenses() As Variant = Source.Value("Licenses")
		    For Each License As Dictionary In Licenses
		      Var Flags As Integer = License.Value("Flags").IntegerValue
		      Var ProductID As String = License.Value("Product ID").StringValue
		      Var ExpirationString As String = License.Lookup("Expiration", "").StringValue
		      
		      Identity.mLicenses.Add(New Beacon.OmniLicense(ProductID, Flags, ExpirationString))
		    Next License
		  ElseIf Source.HasKey("Omni Version") Then
		    Var Flags As Integer = Source.Value("Omni Version").IntegerValue
		    Identity.mLicenses.Add(New Beacon.OmniLicense("972f9fc5-ad64-4f9c-940d-47062e705cc5", Flags, ""))
		  End If
		  
		  If Source.HasKey("Signature") Then
		    Identity.mSignature = DecodeHex(Source.Value("Signature"))
		  End If
		  If Source.HasKey("Signature Version") Then
		    Identity.mSignatureVersion = Source.Value("Signature Version")
		  Else
		    Identity.mSignatureVersion = 2
		  End If
		  
		  If Source.HasKey("Username") Then
		    Identity.mUsername = Source.Value("Username")
		  ElseIf Source.HasKey("LoginKey") Then
		    Identity.mUsername = Source.Value("LoginKey")
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
		  
		  Call Identity.Validate()
		  
		  Return Identity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAnonymous() As Boolean
		  Return Self.mUsername.Length = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBanned() As Boolean
		  Return Self.mBanned
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Function IsChildAccount() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOmniFlagged(Value As Integer) As Boolean
		  Return (Self.OmniFlags And Value) = Value
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
		Function OmniFlags() As Integer
		  Var Flags As Integer
		  For Each License As Beacon.OmniLicense In Self.mLicenses
		    If License.IsExpired = False Then
		      Flags = Flags Or License.Flags
		    End If
		  Next License
		  Return Flags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Identity) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var SelfHash As String = Beacon.Hash(Beacon.GenerateJSON(Self.Export, False))
		  Var OtherHash As String = Beacon.Hash(Beacon.GenerateJSON(Other.Export, False))
		  Return SelfHash.Compare(OtherHash, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Function ParentAccountID() As v4UUID
		  Return Nil
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
		Function UserID() As String
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "UserID" )  Function UserIDForEncryption() As String
		  // For use when decrypting a document. Returns the parent id for child accounts,
		  // or the user's actual id for regular accounts. Return as string since this is
		  // most useful as a dictionary key.
		  
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Username(WithSuffix As Boolean = False) As String
		  If WithSuffix Then
		    Return Self.mUsername + "#" + Self.mIdentifier.Left(8)
		  Else
		    Return Self.mUsername
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Validate() As Boolean
		  If (Self.mSignature Is Nil) = False Then
		    Var Fields(3) As String
		    Fields(0) = Beacon.HardwareID
		    Fields(1) = Self.mIdentifier.Lowercase
		    Select Case Self.mSignatureVersion
		    Case 2
		      Fields(2) = Self.OmniFlags.ToString(Locale.Raw, "0")
		    Case 3
		      Var LicenseSigningData() As String
		      For Each License As Beacon.OmniLicense In Self.mLicenses
		        LicenseSigningData.Add(License.ValidationString)
		      Next License
		      
		      Fields(2) = String.FromArray(LicenseSigningData, ";")
		    End Select
		    Fields(3) = If(Self.mBanned, "Banned", "Clean")
		    
		    If Self.mExpirationString.IsEmpty = False Then
		      Var Expires As DateTime = NewDateFromSQLDateTime(Self.mExpirationString)
		      Var Now As DateTime = DateTime.Now
		      If Now.SecondsFrom1970 < Expires.SecondsFrom1970 Then
		        // Not Expired
		        Fields.Add(Self.mExpirationString)
		      End If
		    End If
		    
		    Var PublicKey As String = BeaconAPI.PublicKey
		    Var CheckData As String = Fields.Join(" ")
		    If Crypto.RSAVerifySignature(CheckData, Self.mSignature, PublicKey) Then
		      // It is valid, now return so the reset code below does not fire
		      Return True
		    End If
		  End If
		  
		  #if DebugBuild
		    System.DebugLog("Failed to validate identity file")
		  #endif
		  
		  Self.mUsername = ""
		  Self.mLicenses.ResizeTo(-1)
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function VerifyKeyPair(PublicKey As MemoryBlock, PrivateKey As MemoryBlock) As Boolean
		  If Crypto.RSAVerifyKey(PublicKey) = False Or Crypto.RSAVerifyKey(PrivateKey) = False Then
		    Return False
		  End If
		  
		  Try
		    Var Original As MemoryBlock = Crypto.GenerateRandomBytes(12)
		    Var Encrypted As String = Crypto.RSAEncrypt(Original, PublicKey)
		    Var Decrypted As String = Crypto.RSADecrypt(Encrypted, PrivateKey)
		    If Decrypted <> Original Then
		      Return False
		    End If
		    
		    Var Signature As MemoryBlock = Crypto.RSASign(Original, PrivateKey)
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
		Private mLicenses() As OmniLicense
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignatureVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsercloudKey As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty


	#tag Constant, Name = SignatureVersion, Type = Double, Dynamic = False, Default = \"3", Scope = Private
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
