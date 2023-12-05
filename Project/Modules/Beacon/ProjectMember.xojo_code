#tag Class
Protected Class ProjectMember
	#tag Method, Flags = &h0
		Sub Constructor(Identity As Beacon.Identity, Role As String)
		  // For adding via identity file
		  
		  Self.mUserId = Identity.UserId.Lowercase
		  Self.mUsername = Identity.Username(False)
		  Self.mPublicKey = Identity.PublicKey
		  Self.mRole = Role
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(UserId As String, Source As Dictionary)
		  // From the api or modern project files (v7 and newer)
		  
		  Self.mUserId = UserId.Lowercase
		  Self.mUsername = Source.Value("username")
		  Self.mPublicKey = BeaconEncryption.PEMDecodePublicKey(Source.Value("publicKey").StringValue)
		  Self.mRole = Source.Value("role")
		  Self.mEncryptedPassword = Source.Value("encryptedPassword")
		  Self.mFingerprint = Source.Value("fingerprint")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(UserId As String, Role As String, EncryptedPassword As String)
		  // From legacy project files (v6 and lower)
		  
		  Self.mUserId = UserId.Lowercase
		  Self.mEncryptedPassword = EncryptedPassword
		  Self.mRole = Role
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DictionaryValue() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("username") = Self.mUsername
		  Dict.Value("publicKey") = BeaconEncryption.PEMEncodePublicKey(Self.mPublicKey)
		  Dict.Value("role") = Self.mRole
		  Dict.Value("encryptedPassword") = Self.mEncryptedPassword
		  Dict.Value("fingerprint") = Self.mFingerprint
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EncryptedPassword() As String
		  Return Self.mEncryptedPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Fingerprint() As String
		  Return Self.mFingerprint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ProjectMember) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mFingerprint.IsEmpty And Other.mFingerprint.IsEmpty Then
		    Return Self.mUserId.Compare(Other.mUserId, ComparisonOptions.CaseInsensitive)
		  End If
		  
		  // If the fingerprints do not match, sort by username
		  If Self.mFingerprint.Compare(Other.mFingerprint, ComparisonOptions.CaseSensitive) <> 0 Then
		    Var MySortValue As String = Self.mUsername + "z" + Self.mFingerprint
		    Var TheirSortValue As String = Other.mUsername + "z" + Other.mFingerprint
		    Return MySortValue.Compare(TheirSortValue, ComparisonOptions.CaseSensitive)
		  End If
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Role() As String
		  Return Self.mRole
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetPassword(Password As String)
		  If Self.mPublicKey.IsEmpty Then
		    Return
		  End If
		  
		  Var RawPublicKey As String = DecodeHex(Self.mPublicKey)
		  
		  Var FingerprintBytes As MemoryBlock = DecodeBase64MBS("com2R8j7FkwXzwOUoMs6qNUXXATzZrfuqG7xjo9Lp3c=")
		  FingerprintBytes.Append(DecodeHex(Self.mUserId.ReplaceAll("-", "")))
		  FingerprintBytes.Append(Self.mUsername)
		  FingerprintBytes.Append(Password)
		  FingerprintBytes.Append(RawPublicKey)
		  
		  Var FingerprintHash As String = EncodeBase64MBS(Crypto.SHA3_256(FingerprintBytes))
		  If Self.mFingerprint = FingerprintHash Then
		    Return
		  End If
		  
		  Self.mFingerprint = FingerprintHash
		  Self.mEncryptedPassword = EncodeBase64MBS(Crypto.RSAEncrypt(Password, Self.mPublicKey))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserId() As String
		  Return Self.mUserId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Username() As String
		  Return Self.mUsername
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEncryptedPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFingerprint As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRole As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty


	#tag Constant, Name = RoleAdmin, Type = String, Dynamic = False, Default = \"Admin", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoleEditor, Type = String, Dynamic = False, Default = \"Editor", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoleGuest, Type = String, Dynamic = False, Default = \"Guest", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RoleOwner, Type = String, Dynamic = False, Default = \"Owner", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
