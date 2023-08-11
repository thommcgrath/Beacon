#tag Class
Protected Class ProjectGuest
	#tag Method, Flags = &h0
		Sub Constructor(Identity As Beacon.Identity)
		  Self.Constructor(Identity.UserId, Identity.Username(False), Identity.PublicKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  Self.mEncryptedPassword = Source.Value("Password")
		  Self.mFingerprint = Source.Value("Fingerprint")
		  Self.mPublicKey = Source.Value("Public Key")
		  Self.mUserId = Source.Value("User Id")
		  Self.mUsername = Source.Value("Username")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(UserId As String, Username As String, PublicKey As String, EncryptedPassword As String = "")
		  Self.mUserId = UserId
		  Self.mUsername = Username
		  Self.mEncryptedPassword = EncryptedPassword
		  
		  If PublicKey.IsEmpty = False Then
		    If PublicKey.IndexOf("-----BEGIN PUBLIC KEY-----") > -1 Then
		      PublicKey = BeaconEncryption.PEMDecodePublicKey(PublicKey)
		    End If
		    
		    If Crypto.RSAVerifyKey(PublicKey) Then
		      Self.mPublicKey = EncodeBase64MBS(DecodeHex(PublicKey))
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DictionaryValue() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("User Id") = Self.mUserId
		  Dict.Value("Username") = Self.mUsername
		  Dict.Value("Public Key") = Self.mPublicKey
		  Dict.Value("Fingerprint") = Self.mFingerprint
		  Dict.Value("Password") = Self.mEncryptedPassword
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
		Function Operator_Compare(Other As Beacon.ProjectGuest) As Integer
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
		Sub SetPassword(Password As String)
		  Var RawPublicKey As String = DecodeBase64MBS(Self.mPublicKey)
		  
		  Var FingerprintBytes As MemoryBlock = DecodeBase64MBS("com2R8j7FkwXzwOUoMs6qNUXXATzZrfuqG7xjo9Lp3c=")
		  FingerprintBytes.Append(DecodeHex(Self.mUserId.ReplaceAll("-", "")))
		  FingerprintBytes.Append(Self.mUsername)
		  FingerprintBytes.Append(Password)
		  FingerprintBytes.Append(RawPublicKey)
		  
		  Self.mFingerprint = EncodeBase64MBS(Crypto.SHA3_256(FingerprintBytes))
		  
		  Var PublicKey As String = EncodeHex(RawPublicKey)
		  Var Raw As MemoryBlock = Crypto.RSAEncrypt(Password, PublicKey)
		  Self.mEncryptedPassword = EncodeBase64MBS(Raw)
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
		Private mUserId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty


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
