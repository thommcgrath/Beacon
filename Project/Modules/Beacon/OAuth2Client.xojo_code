#tag Class
Protected Class OAuth2Client
	#tag Method, Flags = &h0
		Function AccessToken() As String
		  If Not Self.IsAuthenticated Then
		    Return ""
		  End If
		  
		  Return Self.mAccessToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthData() As Dictionary
		  Dim Dict As New Dictionary
		  Dict.Value("Access Token") = Self.mAccessToken
		  Dict.Value("Refresh Token") = Self.mRefreshToken
		  If Self.mExpiration = Nil Then
		    Dict.Value("Expiration") = 0
		  Else
		    Dict.Value("Expiration") = Self.mExpiration.SecondsFrom1970
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AuthData(Assigns Dict As Dictionary)
		  If Dict = Nil Or Not Dict.HasAllKeys("Access Token", "Refresh Token", "Expiration") Then
		    Return
		  End If
		  
		  Self.mAccessToken = Dict.Value("Access Token")
		  Self.mRefreshToken = Dict.Value("Refresh Token")
		  Self.mExpiration = New DateTime(Dict.Value("Expiration"), New TimeZone(0))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Authenticate(Identity As Beacon.Identity, Force As Boolean = False)
		  Self.mIdentity = Identity
		  
		  If Force = False And Self.IsAuthenticated Then
		    RaiseEvent Authenticated()
		    Return
		  End If
		  
		  If Force = True Or Self.mRefreshToken = "" Then
		    // Start a brand new authorization
		    Self.NewAuthorization()
		    Return
		  End If
		  
		  Dim QueryParams As New Dictionary
		  QueryParams.Value("grant_type") = "refresh_token"
		  QueryParams.Value("client_id") = Self.mClientID
		  QueryParams.Value("refresh_token") = Self.mRefreshToken
		  QueryParams.Value("redirect_uri") = Self.RedirectURI
		  
		  SimpleHTTP.Post(Self.mEndpoint, QueryParams, AddressOf Refresh_Callback, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AuthURL() As String
		  Return Beacon.WebURL("/account/oauth/")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  If Self.mCheckStatusKey <> "" Then
		    CallLater.Cancel(Self.mCheckStatusKey)
		    Self.mCheckStatusKey = ""
		  End If
		  
		  If Self.mCheckSocket <> Nil Then
		    Self.mCheckSocket.Disconnect
		    Self.mCheckSocket = Nil
		  End If
		  
		  RaiseEvent DismissWaitingWindow()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckStatus()
		  If Self.mCheckSocket = Nil Then
		    Self.mCheckSocket = New URLConnection
		    AddHandler mCheckSocket.Error, WeakAddressOf mCheckSocket_Error
		    AddHandler mCheckSocket.ContentReceived, WeakAddressOf mCheckSocket_ContentReceived
		  End If
		  
		  Self.mCheckSocket.Send("GET", Self.AuthURL + "lookup.php?requestid=" + EncodeURLComponent(Self.mRequestID))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.Cancel()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAuthenticated() As Boolean
		  If Self.mAccessToken = "" Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because token is empty")
		    #EndIf
		    Return False
		  End If
		  
		  If Self.mExpiration = Nil Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because expiration is missing")
		    #EndIf
		    Return False
		  End If
		  
		  Dim Now As DateTime = DateTime.Now
		  If Self.mExpiration.SecondsFrom1970 <= Now.SecondsFrom1970 Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because expiration has passed")
		    #EndIf
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCheckSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    Self.mCheckStatusKey = CallLater.Schedule(5000, AddressOf CheckStatus)
		    Return
		  End If
		  
		  RaiseEvent DismissWaitingWindow()
		  
		  Try
		    Dim Dict As Dictionary = Beacon.ParseJSON(Content.GuessEncoding)
		    
		    Dim EncryptedSymmetricKeyBase64 As String = Dict.Value("encrypted_symmetric_key")
		    Dim EncryptedPayloadBase64 As String = Dict.Value("encrypted_payload")
		    
		    Dim EncryptedSymmetricKey As MemoryBlock = DecodeBase64(EncryptedSymmetricKeyBase64)
		    Dim EncryptedPayload As MemoryBlock = DecodeBase64(EncryptedPayloadBase64)
		    
		    Dim SymmetricKey As MemoryBlock = Self.mIdentity.Decrypt(EncryptedSymmetricKey)
		    Dim Payload As String = BeaconEncryption.SymmetricDecrypt(SymmetricKey, EncryptedPayload)
		    
		    Dict = Beacon.ParseJSON(Payload.GuessEncoding)
		    
		    Dim Expires As Integer = Dict.Value("expires_in")
		    
		    Self.mRefreshToken = Dict.Value("refresh_token")
		    Self.mAccessToken = Dict.Value("access_token")
		    Self.mExpiration = New DateTime(DateTime.Now.SecondsFrom1970 + Expires, New TimeZone(0))
		    
		    RaiseEvent Authenticated
		  Catch Err As RuntimeException
		    RaiseEvent AuthenticationError
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCheckSocket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  #Pragma Unused Err
		  
		  RaiseEvent DismissWaitingWindow()
		  RaiseEvent AuthenticationError()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NewAuthorization()
		  Self.mRequestID = New v4UUID
		  
		  Dim RequestID As String = New v4UUID
		  Dim PublicKey As String = Self.mIdentity.PublicKey
		  Dim URL As String = Self.AuthURL + "?provider=" + EncodeURLComponent(Self.mProvider) + "&requestid=" + EncodeURLComponent(RequestID) + "&pubkey=" + EncodeURLComponent(PublicKey)
		  
		  If StartAuthentication(URL, Self.mProvider) = False Then
		    Return
		  End If
		  
		  Self.mRequestID = RequestID
		  Self.mCheckStatusKey = CallLater.Schedule(5000, AddressOf CheckStatus)
		  
		  RaiseEvent ShowWaitingWindow()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RedirectURI() As String
		  Return Self.AuthURL() + "complete.php"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Refresh_Callback(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <> 200 Then
		    Self.NewAuthorization()
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  Try
		    Dict = Beacon.ParseJSON(Content)
		    
		    Self.mAccessToken = Dict.Value("access_token")
		    Self.mRefreshToken = Dict.Value("refresh_token")
		    Self.mExpiration = New DateTime(DateTime.Now.SecondsFrom1970 + Dict.Value("expires_in"), New TimeZone(0))
		    
		    RaiseEvent Authenticated
		  Catch Err As RuntimeException
		    RaiseEvent AuthenticationError
		  End Try
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Authenticated()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AuthenticationError()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DismissWaitingWindow()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowWaitingWindow()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StartAuthentication(URL As String, Provider As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthState As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckSocket As URLConnection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckStatusKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClientID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndpoint As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProvider As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestID As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProvider
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProvider = Value Then
			    Return
			  End If
			  
			  Select Case Value
			  Case Self.ProviderNitrado
			    Self.mEndpoint = "https://oauth.nitrado.net/oauth/v2/token"
			    Self.mClientID = "222_mh7VoS9vLQn_jgE6UPZ8MXVlPNMdDhwblQP2kFHffnL7gy2h2rbdj5XWnmUm"
			  Else
			    Return
			  End Select
			  
			  Self.mProvider = Value
			End Set
		#tag EndSetter
		Provider As String
	#tag EndComputedProperty


	#tag Constant, Name = ProviderNitrado, Type = Text, Dynamic = False, Default = \"Nitrado", Scope = Public
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
		#tag ViewProperty
			Name="Provider"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
