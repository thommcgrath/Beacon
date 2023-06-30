#tag Class
Protected Class Identity
	#tag Method, Flags = &h0
		Attributes( Deprecated )  Sub Constructor(Source As Beacon.Identity)
		  Self.mBanned = Source.mBanned
		  Self.mCloudKey = Source.mCloudKey
		  Self.mExpiration = Source.mExpiration
		  Self.mUserId = Source.mUserId
		  Self.mIsValid = Source.mIsValid
		  Self.mPrivateKey = Source.mPrivateKey
		  Self.mPublicKey = Source.mPublicKey
		  Self.mUsername = Source.mUserName
		  
		  For Each License As Beacon.OmniLicense In Source.mLicenses
		    Self.mLicenses.Add(New Beacon.OmniLicense(License))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(UserId As String, PublicKey As String, PrivateKey As String)
		  Self.mUserId = UserId.Lowercase
		  Self.mPublicKey = PublicKey
		  Self.mPrivateKey = PrivateKey
		  Self.mIsValid = True
		End Sub
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
		Function IsExpired() As Boolean
		  If Self.mExpiration Is Nil Then
		    Return False
		  End If
		  
		  Var Now As DateTime = DateTime.Now
		  Return Now.SecondsFrom1970 < Self.mExpiration.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOmniFlagged(Value As Integer) As Boolean
		  Return (Self.OmniFlags And Value) = Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mIsValid And Self.IsExpired = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(Row As RowSet) As Beacon.Identity
		  Var Identity As New Beacon.Identity(Row.Column("user_id").StringValue, Row.Column("public_key").StringValue, Row.Column("private_key").StringValue)
		  
		  Try
		    Var CloudKey As String = DecodeBase64(Row.Column("cloud_key").StringValue)
		    Var Banned As Boolean = Row.Column("banned").BooleanValue
		    Var Signature As String = DecodeBase64(Row.Column("signature").StringValue)
		    Var SignatureVersion As Integer = Row.Column("signature_version").IntegerValue
		    Var Username As String = Row.Column("username").StringValue
		    Var ExpirationString As String = Row.Column("expiration").StringValue
		    Var Expiration As DateTime
		    
		    Var Licenses() As Beacon.OmniLicense
		    Var Arr() As Variant
		    If Row.Column("licenses").Value.IsNull = False Then
		      Arr = Beacon.ParseJSON(Row.Column("licenses").StringValue)
		    End If
		    Var OmniFlags As Integer
		    Var LicenseSigningData() As String
		    For Each Member As Variant In Arr
		      If Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var License As New Beacon.OmniLicense(Dictionary(Member))
		      OmniFlags = OmniFlags Or License.Flags
		      LicenseSigningData.Add(License.ValidationString)
		      Licenses.Add(License)
		    Next
		    
		    Var SignatureParts(3) As String
		    SignatureParts(0) = Beacon.HardwareID
		    SignatureParts(1) = Identity.mUserId
		    Select Case SignatureVersion
		    Case 2
		      SignatureParts(2) = OmniFlags.ToString(Locale.Raw, "0")
		    Case 3
		      SignatureParts(2) = String.FromArray(LicenseSigningData, ";")
		    End Select
		    SignatureParts(3) = If(Banned, "Banned", "Clean")
		    
		    If ExpirationString.IsEmpty = False Then
		      Expiration = NewDateFromSQLDateTime(ExpirationString)
		      SignatureParts.Add(ExpirationString)
		    End If
		    
		    Var StringToSign As String = String.FromArray(SignatureParts, " ")
		    Var SignatureValid As Boolean = Crypto.RSAVerifySignature(StringToSign, Signature, BeaconAPI.PublicKey)
		    
		    Identity.mBanned = Banned
		    Identity.mCloudKey = CloudKey
		    Identity.mExpiration = Expiration
		    Identity.mIsValid = SignatureValid
		    Identity.mUsername = Username
		    Identity.mLicenses = Licenses
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Return Identity
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
		  
		  Return Self.mUserId.Compare(Other.mUserId, ComparisonOptions.CaseInsensitive)
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
		Function UserCloudKey() As String
		  Return Self.mCloudKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserId() As String
		  Return Self.mUserId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Username(WithSuffix As Boolean = False) As String
		  If WithSuffix Then
		    Return Self.mUsername + "#" + Self.mUserId.Left(8)
		  Else
		    Return Self.mUsername
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBanned As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCloudKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLicenses() As Beacon.OmniLicense
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserId As String
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
