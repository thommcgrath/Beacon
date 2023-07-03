#tag Module
Protected Module BeaconAPI
	#tag Method, Flags = &h1
		Protected Function GetProviderToken(TokenId As String) As BeaconAPI.ProviderToken
		  Var Request As New BeaconAPI.Request("/tokens/" + EncodeURLComponent(TokenId))
		  Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		  If Response.HTTPStatus <> 200 Then
		    Return Nil
		  End If
		  
		  Var Parsed As Dictionary
		  Try
		    Parsed = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing JSON")
		    Return Nil
		  End Try
		  
		  Try
		    Var Token As BeaconAPI.ProviderToken = BeaconAPI.ProviderToken.Load(Parsed)
		    Return Token
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Building ProviderToken from response")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetProviderTokens(UserId As String) As BeaconAPI.ProviderToken()
		  Var Request As New BeaconAPI.Request("/users/" + EncodeURLComponent(UserId) + "/tokens")
		  Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		  Var Tokens() As BeaconAPI.ProviderToken
		  If Response.HTTPStatus <> 200 Then
		    Return Tokens
		  End If
		  
		  Var Parsed() As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Response.Content)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing JSON")
		  End Try
		  
		  For Each Member As Variant In Parsed
		    Try
		      Var Token As BeaconAPI.ProviderToken = BeaconAPI.ProviderToken.Load(Dictionary(Member.ObjectValue))
		      If (Token Is Nil) = False Then
		        Tokens.Add(Token)
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Building ProviderToken from response")
		    End Try
		  Next
		  
		  Return Tokens
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Send(Request As BeaconAPI.Request)
		  // We really want only one socket here so that things queue and stay in order
		  
		  If mSharedSocket Is Nil Then
		    mSharedSocket = New BeaconAPI.Socket
		  End If
		  mSharedSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SendSync(Request As BeaconAPI.Request) As BeaconAPI.Response
		  If Thread.Current Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Do not use SendSync on the main thread"
		    Raise Err
		  End If
		  
		  Var AuthHeader As String
		  If Request.RequiresAuthentication Then
		    If Request.RequestHeader("Authorization").IsEmpty = False Then
		      AuthHeader = Request.RequestHeader("Authorization")
		    Else
		      Var Token As BeaconAPI.OAuthToken = Preferences.BeaconAuth
		      If (Token Is Nil) = False Then
		        If Token.AccessTokenExpired Then
		          Var Params As New Dictionary
		          Params.Value("grant_type") = "refresh_token"
		          Params.Value("client_id") = BeaconAPI.ClientId
		          Params.Value("refresh_token") = Token.RefreshToken
		          Params.Value("scope") = Token.Scope
		          
		          Var RefreshSocket As New URLConnection
		          RefreshSocket.SetRequestContent(SimpleHTTP.BuildFormData(Params), "application/x-www-form-urlencoded")
		          
		          Var RefreshResponse As String = RefreshSocket.SendSync("POST", BeaconAPI.URL("/login"))
		          If RefreshSocket.HTTPStatusCode = 201 Then
		            Token = BeaconAPI.OAuthToken.Load(RefreshResponse)
		            Preferences.BeaconAuth = Token
		          End If
		        End If
		        
		        AuthHeader = Token.AuthHeaderValue
		      End If
		    End If
		  End If
		  
		  Var Socket As New URLConnection
		  Var URL As String = SetupSocket(Socket, Request, AuthHeader)
		  Var ResponseBody As String = Socket.SendSync(Request.Method, URL)
		  Var ResponseHeaders As New Dictionary
		  For Each Header As Pair In Socket.ResponseHeaders
		    ResponseHeaders.Value(Header.Left) = Header.Right
		  Next
		  Return New BeaconAPI.Response(URL, Socket.HTTPStatusCode, ResponseBody, ResponseHeaders)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SetupSocket(Socket As URLConnection, Request As BeaconAPI.Request, AuthHeader As String) As String
		  Var URL As String = Request.URL
		  Var Headers() As String = Request.RequestHeaders
		  For Each Header As String In Headers
		    Socket.RequestHeader(Header) = Request.RequestHeader(Header)
		  Next
		  Socket.RequestHeader("Cache-Control") = "no-cache"
		  Socket.RequestHeader("User-Agent") = App.UserAgent
		  If AuthHeader.IsEmpty = False Then
		    Socket.RequestHeader("Authorization") = AuthHeader
		  End If
		  
		  If Request.Method = "GET" Then
		    Var Query As String = Request.Query
		    If Query <> "" Then
		      URL = URL + "?" + Query
		    End If
		    #if DebugBuild
		      App.Log("GET " + URL)
		    #endif
		  Else
		    Socket.SetRequestContent(Request.Payload, Request.ContentType)
		    #if DebugBuild
		      App.Log(Request.Method + " " + URL)
		    #endif
		  End If
		  
		  Return URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URL(Path As String = "/", Versioned As Boolean = True, Scheme As String = "https") As String
		  #if DebugBuild And App.ForceLiveData = False
		    Var Domain As String = Scheme + "://local-api.usebeacon.app"
		  #else
		    Var Domain As String = Scheme + "://api.usebeacon.app"
		  #endif
		  If Path.Length = 0 Or Path.Left(1) <> "/" Then
		    Path = "/" + Path
		  End If
		  Return Domain + If(Versioned, "/v" + Version.ToString, "") + Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UserController() As BeaconAPI.UserController
		  If mUserController Is Nil Then
		    mUserController = New BeaconAPI.UserController
		  End If
		  Return mUserController
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSharedSocket As BeaconAPI.Socket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserController As BeaconAPI.UserController
	#tag EndProperty


	#tag Constant, Name = ClientId, Type = String, Dynamic = False, Default = \"9f823fcf-eb7a-41c0-9e4b-db8ed4396f80", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PublicKey, Type = String, Dynamic = False, Default = \"30820122300D06092A864886F70D01010105000382010F003082010A02820101009F0CA4882EC50BD8F18DAFA6BB0A83C82BD7AF43872F2DFDF21C932E028EAB699CE4EF229B087565B9DFE48A99101BF5798E8DAD6995489E080813F9EAC88E01F1BD0E250129D9F4837590732A8E11AD6398980246C7DAE9D0C4574239A563EF9C550EB30CED63F7F8D187F7D6CBED463C11EC1FEE4AF8CE87C8B54AB244EFD81CF9F218D8A7674638D7A4F302ED850FD27DB7B1C3B1B8CDCD51FF15D4F8FBD236806CFA2B5E97A6A1504F8CE891CEB786B0B13761B2892A91C78AF9CBFD3CF272613992C71948E6702C0A0AF6345A1BD334A9C6895A5AD7E529217ED6251C3AF78F520642B02FBCD08D1864BCCA584477697326C2FD40BD8FABD7FDB253DE5F0203010001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
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
End Module
#tag EndModule
