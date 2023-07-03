#tag Class
Protected Class ProviderToken
	#tag Method, Flags = &h0
		Function AccessToken() As String
		  Return Self.mAccessToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AccessTokenExpiration() As Double
		  Return Self.mAccessTokenExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AccessTokenExpired() As Boolean
		  Var Now As DateTime = DateTime.Now
		  Return Self.mAccessTokenExpiration < Now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthHeaderValue() As String
		  Return "Bearer " + Self.mAccessToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Dict As Dictionary)
		  Self.mTokenId = Dict.Value("tokenId").StringValue
		  Self.mUserId = Dict.Value("userId").StringValue
		  Self.mProvider = Dict.Value("provider").StringValue
		  Self.mAccessToken = Dict.Value("accessToken").StringValue
		  Self.mAccessTokenExpiration = Dict.Value("accessTokenExpiration").DoubleValue
		  Try
		    Self.mProviderSpecific = Dict.Value("providerSpecific")
		  Catch Err As RuntimeException
		    Self.mProviderSpecific = New Dictionary
		  End Try
		  If Dict.HasKey("encryptionKey") Then
		    Self.mEncryptionKey = Dict.Value("encryptionKey").StringValue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(EncryptionKey As String) As Boolean
		  If Self.mEncryptionKey.IsEmpty = False Then
		    Return True
		  ElseIf EncryptionKey.IsEmpty = True Then
		    Return False
		  End If
		  
		  Try
		    Var RawKey As String = DecodeBase64(EncryptionKey)
		    Var AccessToken As String = BeaconEncryption.SymmetricDecrypt(RawKey, DecodeBase64(Self.mAccessToken))
		    Self.mEncryptionKey = EncryptionKey
		    Self.mAccessToken = AccessToken
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EncryptionKey() As String
		  Return Self.mEncryptionKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEncrypted() As Boolean
		  Return Self.mEncryptionKey.IsEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(Dict As Dictionary) As BeaconAPI.ProviderToken
		  If Dict.HasAllKeys("tokenId", "userId", "provider", "accessToken", "accessTokenExpiration", "providerSpecific") = False Then
		    Return Nil
		  End If
		  
		  Return New BeaconAPI.ProviderToken(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(Source As String) As BeaconAPI.ProviderToken
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Source)
		    Return BeaconAPI.ProviderToken.Load(Parsed)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.AuthHeaderValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Provider() As String
		  Return Self.mProvider
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderSpecific(Key As String, DefaultValue As Variant) As Variant
		  If Self.mProviderSpecific Is Nil Or Self.mProviderSpecific.HasKey(Key) = False Then
		    Return DefaultValue
		  End If
		  
		  Return Self.mProviderSpecific.Value(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TokenId() As String
		  Return Self.mTokenId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserId() As String
		  Return Self.mUserId
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAccessTokenExpiration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProvider As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderSpecific As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserId As String
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
