#tag Class
Protected Class OAuth2Client
	#tag Method, Flags = &h0
		Function AccessToken() As Text
		  If Not Self.IsAuthenticated Then
		    Return ""
		  End If
		  
		  Return Self.mAccessToken
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthData() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
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
		Sub AuthData(Assigns Dict As Xojo.Core.Dictionary)
		  If Dict = Nil Or Not Dict.HasAllKeys("Access Token", "Refresh Token", "Expiration") Then
		    Return
		  End If
		  
		  Self.mAccessToken = Dict.Value("Access Token")
		  Self.mRefreshToken = Dict.Value("Refresh Token")
		  Self.mExpiration = New Xojo.Core.Date(Dict.Value("Expiration"), New Xojo.Core.TimeZone(0))
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
		  
		  Dim QueryParams As New Xojo.Core.Dictionary
		  QueryParams.Value("grant_type") = "refresh_token"
		  QueryParams.Value("client_id") = Self.mClientID
		  QueryParams.Value("refresh_token") = Self.mRefreshToken
		  QueryParams.Value("redirect_uri") = Self.RedirectURI
		  
		  Dim TextArray() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In QueryParams
		    TextArray.Append(Beacon.EncodeURLComponent(Entry.Key) + "=" + Beacon.EncodeURLComponent(Entry.Value))
		  Next
		  Dim TextContent As Text = Text.Join(TextArray, "&")
		  Dim Content As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(TextContent, False)
		  Dim ContentType As Text = "application/x-www-form-urlencoded"
		  
		  SimpleHTTP.Post(Self.mEndpoint + "/auth", ContentType, Content, AddressOf Refresh_Callback, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Authorization_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <> 200 Then
		    RaiseEvent AuthenticationError
		    Return
		  End If
		  
		  If Self.ReceivedToken(Content) Then
		    RaiseEvent Authenticated
		  Else
		    RaiseEvent AuthenticationError
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Authorization_Handler(URL As Text) As Boolean
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
		  
		  Dim Code, State As Text
		  
		  Dim QueryString As Text = URL.Mid(6)
		  Dim Parts() As Text = QueryString.Split("&")
		  For Each Part As Text In Parts
		    Dim Idx As Integer = Part.IndexOf("=")
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Dim Key As Text = Beacon.DecodeURLComponent(Part.Left(Idx))
		    Dim Value As Text = Beacon.DecodeURLComponent(Part.Mid(Idx + 1))
		    
		    Select Case Key
		    Case "code"
		      Code = Value
		    Case "state"
		      State = Value
		    Else
		      Break
		    End Select
		  Next
		  
		  If State <> Self.mAuthState Then
		    // Problem
		    Self.mAuthState = ""
		    Return True
		  End If
		  
		  Self.mAuthState = ""
		  
		  Dim QueryParams As New Xojo.Core.Dictionary
		  QueryParams.Value("grant_type") = "authorization_code"
		  QueryParams.Value("client_id") = Self.mClientID
		  QueryParams.Value("client_secret") = Self.mClientSecret
		  QueryParams.Value("code") = Code
		  QueryParams.Value("redirect_uri") = Self.RedirectURI
		  
		  Dim TextArray() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In QueryParams
		    TextArray.Append(Beacon.EncodeURLComponent(Entry.Key) + "=" + Beacon.EncodeURLComponent(Entry.Value))
		  Next
		  Dim TextContent As Text = Text.Join(TextArray, "&")
		  Dim Content As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(TextContent, False)
		  Dim ContentType As Text = "application/x-www-form-urlencoded"
		  
		  SimpleHTTP.Post(Self.mEndPoint + "/token", ContentType, Content, AddressOf Authorization_Callback, Nil)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAuthenticated() As Boolean
		  If Self.mAccessToken = "" Then
		    System.DebugLog("Not authenticated because token is empty")
		    Return False
		  End If
		  
		  If Self.mExpiration = Nil Then
		    System.DebugLog("Not authenticated because expiration is missing")
		    Return False
		  End If
		  
		  Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		  If Self.mExpiration.SecondsFrom1970 <= Now.SecondsFrom1970 Then
		    System.DebugLog("Not authenticated because expiration has passed")
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NewAuthorization()
		  Self.mAuthState = Beacon.CreateUUID
		  Dim URL As Text = Self.mEndpoint + "/auth?redirect_uri=" + Beacon.EncodeURLComponent(Self.RedirectURI) + "&client_id=" + Beacon.EncodeURLComponent(Self.mClientID) + "&response_type=code&scope=service&state=" + Beacon.EncodeURLComponent(Self.mAuthState)
		  Dim Browser As Beacon.WebView = RaiseEvent ShowURL(URL)
		  If Browser = Nil Then
		    Return
		  End If
		  Browser.URLHandler = AddressOf Authorization_Handler
		  Self.mBrowser = Browser
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReceivedToken(Content As Xojo.Core.MemoryBlock) As Boolean
		  Dim Dict As Xojo.Core.Dictionary
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dict = Xojo.Data.ParseJSON(TextContent)
		    
		    Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		    
		    Self.mAccessToken = Dict.Value("access_token")
		    Self.mRefreshToken = Dict.Value("refresh_token")
		    Self.mExpiration = New Xojo.Core.Date(Now.SecondsFrom1970 + Dict.Value("expires_in"), New Xojo.Core.TimeZone(0))
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Refresh_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Status <> 200 Then
		    Self.NewAuthorization()
		    Return
		  End If
		  
		  If Self.ReceivedToken(Content) Then
		    RaiseEvent Authenticated
		  Else
		    RaiseEvent AuthenticationError
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Setup(Endpoint As Text, ClientID As Text, ClientSecret As Text)
		  Self.mEndpoint = Endpoint
		  Self.mClientID = ClientID
		  Self.mClientSecret = ClientSecret
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Authenticated()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AuthenticationError()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowURL(URL As Text) As Beacon.WebView
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccessToken As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthState As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBrowser As Beacon.WebView
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClientID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClientSecret As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEndpoint As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRefreshToken As Text
	#tag EndProperty


	#tag Constant, Name = RedirectURI, Type = Text, Dynamic = False, Default = \"https://app.beaconapp.cc/oauth", Scope = Private
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
	#tag EndViewBehavior
End Class
#tag EndClass
