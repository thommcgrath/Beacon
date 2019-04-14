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
		  Self.mExpiration = NewDateFromSecondsFrom1970(Dict.Value("Expiration"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Authenticate(Force As Boolean = False)
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
		Private Function Authorization_Handler(URL As String) As Boolean
		  If Not URL.BeginsWith("oauth") Then
		    Return False
		  End If
		  
		  Dim FragmentPos As Integer = URL.IndexOf("#")
		  If FragmentPos > -1 Then
		    // WTF...
		    URL = URL.Left(FragmentPos)
		  End If
		  
		  If Self.mBrowser <> Nil Then
		    Self.mBrowser.Close
		    Self.mBrowser = Nil
		  End If
		  
		  Dim AccessToken, RefreshToken As String
		  Dim Expires As UInteger
		  
		  Dim QueryPos As Integer = URL.IndexOf("?")
		  If QueryPos = -1 Then
		    RaiseEvent AuthenticationError
		    Return True
		  End If
		  
		  Dim Path As String = URL.Left(QueryPos)
		  If Path <> "oauth/" + Self.mProvider Then
		    Break
		    RaiseEvent AuthenticationError
		    Return True
		  End If
		  
		  Dim QueryString As String = URL.SubString(QueryPos + 1)
		  Dim Parts() As String = QueryString.Split("&")
		  For Each Part As String In Parts
		    Dim Idx As Integer = Part.IndexOf("=")
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Dim Key As String = Beacon.URLDecode(Part.Left(Idx))
		    Dim Value As String = Beacon.URLDecode(Part.SubString(Idx + 1))
		    
		    Select Case Key
		    Case "access_token"
		      AccessToken = Value
		    Case "refresh_token"
		      RefreshToken = Value
		    Case "expires_in"
		      Expires = Val(Value)
		    Else
		      Break
		    End Select
		  Next
		  
		  If AccessToken = "" Or RefreshToken = "" Or Expires = 0 Then
		    RaiseEvent AuthenticationError
		    Return True
		  End If
		  
		  Dim Now As New Date
		  Now.TotalSeconds = Now.TotalSeconds + Expires
		  
		  Self.mAccessToken = AccessToken
		  Self.mRefreshToken = RefreshToken
		  Self.mExpiration = Now
		  
		  RaiseEvent Authenticated
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AuthURL() As String
		  Return Beacon.WebURL("/oauth/").Replace("https://", "https://api.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.References <> Nil And Self.mRequestID <> "" And Self.References.HasKey(Self.mRequestID) Then
		    Self.References.Remove(Self.mRequestID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HandleURL(URL As String) As Boolean
		  If Not URL.BeginsWith("oauth/") Then
		    Return False
		  End If
		  
		  If References = Nil Then
		    // Because it is an oauth url, return true because we are the correct recipient
		    Return True
		  End If
		  
		  Dim StartPos As Integer = URL.IndexOf("&requestid=")
		  If StartPos = -1 Then
		    Return True
		  End If
		  StartPos = StartPos + 11
		  
		  Dim EndPos As Integer = URL.IndexOf(StartPos, "&")
		  If EndPos = -1 Then
		    EndPos = URL.Length
		  End If
		  
		  Dim RequestID As String = Beacon.URLDecode(URL.SubString(StartPos, EndPos - StartPos))
		  If References.HasKey(RequestID) Then
		    Dim Ref As WeakRef = References.Value(RequestID)
		    Call OAuth2Client(Ref.Value).Authorization_Handler(URL)
		  End If
		  
		  Return True
		End Function
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
		  
		  Dim Now As New Date
		  If Self.mExpiration.TotalSeconds <= Now.TotalSeconds Then
		    #If DebugBuild
		      System.DebugLog("Not authenticated because expiration has passed")
		    #EndIf
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NewAuthorization()
		  Dim URL As String = Self.AuthURL + "?provider=" + Beacon.URLEncode(Self.mProvider)
		  Dim Browser As Beacon.WebView = RaiseEvent ShowURL(URL)
		  If Browser = Nil Then
		    If Self.References = Nil Then
		      Self.References = New Dictionary
		    End If
		    
		    Self.mRequestID = Beacon.CreateUUID
		    Dim Ref As WeakRef = New WeakRef(Self)
		    Self.References.Value(Self.mRequestID) = Ref
		    
		    ShowURL(URL + "&requestid=" + Beacon.URLEncode(Self.mRequestID))
		    Return
		  End If
		  Browser.URLHandler = AddressOf Authorization_Handler
		  Self.mBrowser = Browser
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RedirectURI() As String
		  Return Self.AuthURL() + "callback.php"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Refresh_Callback(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <> 200 Then
		    Self.NewAuthorization()
		    Return
		  End If
		  
		  Try
		    Dim Reply As Dictionary = Beacon.ParseJSON(Content)
		    Dim Expiration As New Date
		    Expiration.TotalSeconds = Expiration.TotalSeconds + Reply.Value("expires_in").IntegerValue
		    
		    Self.mAccessToken = Reply.Value("access_token").StringValue
		    Self.mRefreshToken = Reply.Value("refresh_token").StringValue
		    Self.mExpiration = Expiration
		    
		    RaiseEvent Authenticated()
		  Catch Err As RuntimeException
		    RaiseEvent AuthenticationError()
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
		Event ShowURL(URL As String) As Beacon.WebView
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthState As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBrowser As Beacon.WebView
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClientID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndpoint As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As Date
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

	#tag Property, Flags = &h21
		Private Shared References As Dictionary
	#tag EndProperty


	#tag Constant, Name = ProviderNitrado, Type = String, Dynamic = False, Default = \"Nitrado", Scope = Public
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
		#tag ViewProperty
			Name="Provider"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
