#tag Class
Protected Class OAuth2Client
	#tag Method, Flags = &h0
		Function Account() As Beacon.ExternalAccount
		  Return Self.mAccount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Authenticate(Identity As Beacon.Identity, Force As Boolean = False)
		  Self.mIdentity = Identity
		  
		  If Force = False And Self.IsAuthenticated Then
		    RaiseEvent Authenticated()
		    Return
		  End If
		  
		  If Force = True Or Self.mAccount Is Nil Or Self.mAccount.RefreshToken.IsEmpty Then
		    // Start a brand new authorization
		    Self.NewAuthorization()
		    Return
		  End If
		  
		  Var QueryParams As New Dictionary
		  QueryParams.Value("grant_type") = "refresh_token"
		  QueryParams.Value("client_id") = Self.mClientID
		  QueryParams.Value("refresh_token") = Self.mAccount.RefreshToken
		  QueryParams.Value("redirect_uri") = Self.RedirectURI
		  
		  Self.StartTask()
		  SimpleHTTP.Post(Self.mEndpoint, QueryParams, WeakAddressOf Refresh_Callback, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AuthURL() As String
		  Return Beacon.WebURL("/account/oauth/")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return Self.mBusyCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.EndTask()
		  Self.Cleanup()
		  
		  RaiseEvent DismissWaitingWindow()
		  RaiseEvent UserCancelled()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckStatus()
		  If (Self.mCheckSocket Is Nil) = False Then
		    RemoveHandler mCheckSocket.Error, WeakAddressOf mCheckSocket_Error
		    RemoveHandler mCheckSocket.ContentReceived, WeakAddressOf mCheckSocket_ContentReceived
		    Self.mCheckSocket.Disconnect
		    Self.mCheckSocket = Nil
		  End If
		  
		  Self.mCheckSocket = New URLConnection
		  AddHandler mCheckSocket.Error, WeakAddressOf mCheckSocket_Error
		  AddHandler mCheckSocket.ContentReceived, WeakAddressOf mCheckSocket_ContentReceived
		  Self.mCheckSocket.RequestHeader("User-Agent") = App.UserAgent
		  
		  Self.mCheckSocket.Send("GET", Self.AuthURL + "lookup?requestid=" + EncodeURLComponent(Self.mRequestID), 10)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cleanup()
		  If Self.mCheckStatusKey <> "" Then
		    CallLater.Cancel(Self.mCheckStatusKey)
		    Self.mCheckStatusKey = ""
		  End If
		  
		  If (Self.mCheckSocket Is Nil) = False Then
		    RemoveHandler mCheckSocket.Error, WeakAddressOf mCheckSocket_Error
		    RemoveHandler mCheckSocket.ContentReceived, WeakAddressOf mCheckSocket_ContentReceived
		    Self.mCheckSocket.Disconnect
		    Self.mCheckSocket = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.Cleanup()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EndTask()
		  Self.mBusyCount = Self.mBusyCount - 1
		  If Self.mBusyCount = 0 Then
		    RaiseEvent Idle
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAuthenticated() As Boolean
		  If Self.mAccount = Nil Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because account is nil")
		    #EndIf
		    Return False
		  End If
		  
		  If Self.mAccount.AccessToken.Length = 0 Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because access token is empty")
		    #EndIf
		    Return False
		  End If
		  
		  If Self.mAccount.Expiration = Nil Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because expiration empty")
		    #EndIf
		    Return False
		  End If
		  
		  Var Now As DateTime = DateTime.Now
		  If Self.mAccount.Expiration.SecondsFrom1970 <= Now.SecondsFrom1970 Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because expiration has passed")
		    #EndIf
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Lock()
		  If AuthLock Is Nil Then
		    AuthLock = New CriticalSection
		  End If
		  
		  AuthLock.Enter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCheckSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <= 0 Then
		    RaiseEvent DismissWaitingWindow()
		    App.Log("Socket error " + HTTPStatus.ToString("0") + ": " + Content)
		    RaiseEvent AuthenticationError("Socket error " + HTTPStatus.ToString("0"))
		    Return
		  ElseIf HTTPStatus <> 200 Then
		    Self.mCheckStatusKey = CallLater.Schedule(5000, WeakAddressOf CheckStatus)
		    Return
		  End If
		  
		  RaiseEvent DismissWaitingWindow()
		  
		  Try
		    Var Dict As Dictionary = Beacon.ParseJSON(Content.GuessEncoding)
		    
		    Var EncryptedSymmetricKeyBase64 As String = Dict.Value("encrypted_symmetric_key")
		    Var EncryptedPayloadBase64 As String = Dict.Value("encrypted_payload")
		    
		    Var EncryptedSymmetricKey As MemoryBlock = DecodeBase64(EncryptedSymmetricKeyBase64)
		    Var EncryptedPayload As MemoryBlock = DecodeBase64(EncryptedPayloadBase64)
		    
		    Var SymmetricKey As MemoryBlock = Self.mIdentity.Decrypt(EncryptedSymmetricKey)
		    Var Payload As String = BeaconEncryption.SymmetricDecrypt(SymmetricKey, EncryptedPayload)
		    
		    Dict = Beacon.ParseJSON(Payload.GuessEncoding)
		    
		    Var Expires As Integer = Dict.Value("expires_in")
		    
		    Var AccessToken As String = Dict.Value("access_token").StringValue
		    Var RefreshToken As String = Dict.Value("refresh_token").StringValue
		    Var Expiration As New DateTime(DateTime.Now.SecondsFrom1970 + Expires, New TimeZone(0))
		    
		    Var AccountUUID As v4UUID
		    Var UserID, Username As String
		    If Dict.HasKey("user_id") Then
		      UserID = Dict.Value("user_id").StringValue
		      AccountUUID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, Self.mAccount.Provider + "." + UserID)
		    ElseIf (Self.mAccount.UUID Is Nil) = False Then
		      AccountUUID = Self.mAccount.UUID
		    Else
		      AccountUUID = New v4UUID
		    End If
		    If Dict.HasKey("username") Then
		      Username = Dict.Value("username").StringValue
		    End If
		    
		    Var OriginalUUID As v4UUID = Self.mAccount.UUID
		    Self.mAccount = New Beacon.ExternalAccount(AccountUUID, Username, Self.mAccount.Provider, AccessToken, RefreshToken, Expiration)
		    
		    If Self.mAccount.UUID <> OriginalUUID Then
		      RaiseEvent AccountUUIDChanged(OriginalUUID)
		    End If
		    
		    RaiseEvent Authenticated
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, URL, HTTPStatus, Content)
		    RaiseEvent AuthenticationError(Err.Message)
		  End Try
		  Self.EndTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCheckSocket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  #Pragma Unused Err
		  
		  RaiseEvent DismissWaitingWindow()
		  App.Log(Err, CurrentMethodName)
		  RaiseEvent AuthenticationError(Err.Message)
		  Self.EndTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NewAuthorization()
		  Self.mRequestID = New v4UUID
		  
		  Var RequestID As String = New v4UUID
		  Var PublicKey As String = Self.mIdentity.PublicKey
		  Var URL As String = Self.AuthURL + "?provider=" + EncodeURLComponent(Self.mAccount.Provider) + "&requestid=" + EncodeURLComponent(RequestID) + "&pubkey=" + EncodeURLComponent(PublicKey)
		  
		  If StartAuthentication(Self.mAccount, URL) = False Then
		    Self.Cancel()
		    Return
		  End If
		  
		  Self.StartTask()
		  Self.mRequestID = RequestID
		  Self.mCheckStatusKey = CallLater.Schedule(5000, WeakAddressOf CheckStatus)
		  
		  RaiseEvent ShowWaitingWindow()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RedirectURI() As String
		  Return Self.AuthURL() + "complete"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Refresh_Callback(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <= 0 Then
		    If (Content Is Nil) Or Content.Size < 1 Then
		      App.Log("Socket error " + Status.ToString("0") + ": Nil content")
		    Else
		      App.Log("Socket error " + Status.ToString("0") + ": " + Content.StringValue(0, Content.Size))
		    End If
		    RaiseEvent AuthenticationError("Socket error " + Status.ToString("0"))
		  ElseIf Status <> 200 Then
		    Self.NewAuthorization()
		  Else
		    Var Dict As Dictionary
		    Try
		      Dict = Beacon.ParseJSON(Content)
		      
		      Var AccessToken As String = Dict.Value("access_token").StringValue
		      Var RefreshToken As String = Dict.Value("refresh_token").StringValue
		      Var Expiration As DateTime = New DateTime(DateTime.Now.SecondsFrom1970 + Dict.Value("expires_in"), New TimeZone(0))
		      Self.mAccount = New Beacon.ExternalAccount(Self.mAccount.UUID, Self.mAccount.Label, Self.mAccount.Provider, AccessToken, RefreshToken, Expiration)
		      
		      RaiseEvent Authenticated
		    Catch Err As RuntimeException
		      App.LogAPIException(Err, CurrentMethodName, URL, Status, Content)
		      RaiseEvent AuthenticationError(Err.Message)
		    End Try
		  End If
		  
		  Self.EndTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAccount(Account As Beacon.ExternalAccount) As Boolean
		  If Account Is Nil Then
		    Return False
		  End If
		  
		  If Self.mAccount = Account Then
		    // Do nothing
		    Return True
		  End If
		  
		  Select Case Account.Provider
		  Case Beacon.ExternalAccount.ProviderNitrado
		    Self.mEndpoint = "https://oauth.nitrado.net/oauth/v2/token"
		    Self.mClientID = "222_mh7VoS9vLQn_jgE6UPZ8MXVlPNMdDhwblQP2kFHffnL7gy2h2rbdj5XWnmUm"
		  Else
		    Return False
		  End Select
		  
		  Self.mAccount = Account
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAccount(Provider As String) As Boolean
		  Var Account As New Beacon.ExternalAccount(Provider)
		  Return Self.SetAccount(Account)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartTask()
		  Self.mBusyCount = Self.mBusyCount + 1
		  If Self.mBusyCount = 1 Then
		    RaiseEvent Busy
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Unlock()
		  If (AuthLock Is Nil) = False Then
		    AuthLock.Leave
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AccountUUIDChanged(OldUUID As v4UUID)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Authenticated()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AuthenticationError(Reason As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Busy()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DismissWaitingWindow()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Idle()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowWaitingWindow()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StartAuthentication(Account As Beacon.ExternalAccount, URL As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UserCancelled()
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared AuthLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAccount As Beacon.ExternalAccount
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthState As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBusyCount As Integer
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
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestID As String
	#tag EndProperty


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
