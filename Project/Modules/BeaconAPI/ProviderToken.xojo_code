#tag Class
Protected Class ProviderToken
	#tag Method, Flags = &h0
		Function AccessToken() As String
		  Return Self.mAccessToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AccessTokenExpiration() As NullableDouble
		  Return Self.mAccessTokenExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AccessTokenExpired() As Boolean
		  If Self.mAccessTokenExpiration Is Nil Then
		    Return False
		  End If
		  
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
		  Self.mType = Dict.Value("type").StringValue
		  Self.mAccessToken = Dict.Value("accessToken").StringValue
		  Self.mAccessTokenExpiration = NullableDouble.FromVariant(Dict.Value("accessTokenExpiration"))
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
		Function Label(Detail As Integer) As String
		  Var Label As String
		  
		  Select Case Self.Provider
		  Case Self.ProviderNitrado
		    Try
		      Var TokenName As String = Self.ProviderSpecific("tokenName", "")
		      Var UserDict As Dictionary = Self.ProviderSpecific("user", Nil)
		      Var Username As String = UserDict.Value("username")
		      Var Id As Integer = UserDict.Value("id")
		      
		      Label = Username
		      
		      If Detail >= Self.DetailNormal Then
		        Label = Label + " (" + Id.ToString(Locale.Current, "0") + ")"
		      End If
		      
		      If Detail >= Self.DetailHigh And TokenName.IsEmpty = False Then
		        Label = TokenName + " - " + Label
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Building Nitrado service name")
		    End Try
		  Case Self.ProviderGameServerApp
		    Try
		      Label = Self.ProviderSpecific("tokenName", "")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Building GameServerApp service name")
		    End Try
		  End Select
		  
		  If Label.IsEmpty Then
		    Label = Self.mTokenId
		  End If
		  If Detail >= Self.DetailHigh Then
		    Label = Self.Provider + ": " + Label
		  End If
		  
		  Return Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(Dict As Dictionary) As BeaconAPI.ProviderToken
		  If Dict.HasAllKeys("tokenId", "userId", "provider", "type", "accessToken", "accessTokenExpiration", "providerSpecific") = False Then
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
		Function Type() As String
		  Return Self.mType
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
		Private mAccessTokenExpiration As NullableDouble
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
		Private mType As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserId As String
	#tag EndProperty


	#tag Constant, Name = DetailHigh, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DetailLow, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DetailNormal, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProviderGameServerApp, Type = String, Dynamic = False, Default = \"GameServerApp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProviderNitrado, Type = String, Dynamic = False, Default = \"Nitrado", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeOAuth, Type = String, Dynamic = False, Default = \"OAuth", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeStatic, Type = String, Dynamic = False, Default = \"Static", Scope = Public
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
