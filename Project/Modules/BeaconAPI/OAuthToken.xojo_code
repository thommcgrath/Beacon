#tag Class
Protected Class OAuthToken
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
		  Self.mAccessToken = Dict.Value("access_token").StringValue
		  Self.mRefreshToken = Dict.Value("refresh_token").StringValue
		  Self.mAccessTokenExpiration = Dict.Value("access_token_expiration").DoubleValue
		  Self.mRefreshTokenExpiration = Dict.Value("refresh_token_expiration").DoubleValue
		  Self.mScopes = Dict.Value("scope").StringValue.Split(" ")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DictionaryValue() As Dictionary
		  Var Now As DateTime = DateTime.Now
		  Var AccessTokenExpiresIn As Double = Max(0, Self.mAccessTokenExpiration - Now.SecondsFrom1970)
		  Var RefreshTokenExpiresIn As Double = Max(0, Self.mRefreshTokenExpiration - Now.SecondsFrom1970)
		  
		  Var Dict As New Dictionary
		  Dict.Value("token_type") = "Bearer"
		  Dict.Value("access_token") = Self.mAccessToken
		  Dict.Value("refresh_token") = Self.mRefreshToken
		  Dict.Value("access_token_expiration") = Self.mAccessTokenExpiration
		  Dict.Value("refresh_token_expiration") = Self.mRefreshTokenExpiration
		  Dict.Value("access_token_expires_in") = AccessTokenExpiresIn
		  Dict.Value("refresh_token_expires_in") = RefreshTokenExpiresIn
		  Dict.Value("scope") = String.FromArray(Self.mScopes, " ")
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasScope(Scope As String) As Boolean
		  Return Self.mScopes.IndexOf(Scope) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(Dict As Dictionary) As BeaconAPI.OAuthToken
		  If Dict.HasAllKeys("token_type", "access_token", "refresh_token", "access_token_expiration", "refresh_token_expiration", "access_token_expires_in", "refresh_token_expires_in", "scope") = False Then
		    Return Nil
		  End If
		  
		  Return New BeaconAPI.OAuthToken(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Load(Source As String) As BeaconAPI.OAuthToken
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Source)
		    Return BeaconAPI.OAuthToken.Load(Parsed)
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
		Function RefreshToken() As String
		  Return Self.mRefreshToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RefreshTokenExpiration() As Double
		  Return Self.mRefreshTokenExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RefreshTokenExpired() As Boolean
		  Var Now As DateTime = DateTime.Now
		  Return Self.mRefreshTokenExpiration < Now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Scope() As String
		  Return String.FromArray(Self.mScopes, " ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Scopes() As String()
		  Return String.FromArray(Self.mScopes, " ").Split(" ") // Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  Return Beacon.GenerateJSON(Self.DictionaryValue, False)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAccessTokenExpiration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshTokenExpiration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScopes() As String
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
