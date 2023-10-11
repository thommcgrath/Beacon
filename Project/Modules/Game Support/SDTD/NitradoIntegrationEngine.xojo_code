#tag Class
Protected Class NitradoIntegrationEngine
Inherits SDTD.IntegrationEngine
	#tag CompatibilityFlags = (TargetDesktop and (Target32Bit))
	#tag Event
		Sub Begin()
		  Var Token As Variant = Beacon.Cache.Fetch(Profile.ProviderTokenId)
		  If Token.IsNull = False And Token.Type = Variant.TypeObject And Token.ObjectValue IsA BeaconAPI.ProviderToken Then
		    Self.mProviderToken = Token
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var Servers() As Beacon.DiscoveredData
		  
		  // Get a list of all servers
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  
		  Self.Log("Finding servers…")
		  Self.SendRequest(Socket, "GET", "https://api.nitrado.net/services")
		  If Self.Finished Or Self.CheckError(Socket) Then
		    Return Servers
		  End If
		  Var Content As String = Socket.LastString
		  Var Status As Integer = Socket.LastHTTPStatus
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    App.LogAPIException(Parsed, CurrentMethodName, Socket.LastURL, Status, Content)
		    Self.SetError("There was an exception while retrieving your server list.")
		    Return Servers
		  End Try
		  
		  // If it's not a dictionary, what else can we do
		  If (Parsed IsA Dictionary) = False Then
		    Return Servers
		  End If
		  
		  Var Response As Dictionary = Parsed
		  If Response.Lookup("status", "") <> "success" Or Response.HasKey("data") = False Or IsNull(Response.Value("data")) Or Response.Value("data").Type <> Variant.TypeObject Or (Response.Value("data").ObjectValue IsA Dictionary) = False Then
		    Self.SetError("Nitrado API returned unexpected data.")
		    Return Servers
		  End If
		  
		  Var Data As Dictionary = Dictionary(Response.Value("data").ObjectValue)
		  If Data.HasKey("services") = False Or IsNull(Data.Value("services")) Or Data.Value("services").IsArray = False Then
		    Return Servers
		  End If
		  
		  // Get a list of the servers that match
		  Var Portlists() As String = Nitrado.PortlistsForProducts(Self.mProviderToken, "7dtd")
		  
		  Var Services() As Variant = Data.Value("services")
		  For Each Service As Variant In Services
		    If IsNull(Service) Or Service.Type <> Variant.TypeObject Or (Service.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Try
		      Var Dict As Dictionary = Service
		      
		      If Dict.Lookup("type", "").StringValue <> "gameserver" Or Dict.Lookup("status", "").StringValue <> "active" Then
		        Continue
		      End If
		      
		      Var Profile As SDTD.NitradoServerProfile
		      Try
		        Var Details As Dictionary = Dict.Value("details")
		        Var GamePortlist As String = Details.Value("portlist_short")
		        If Portlists.IndexOf(GamePortlist) = -1 Then
		          Continue
		        End If
		        
		        Profile = New SDTD.NitradoServerProfile
		        Profile.ProviderTokenId = Self.mProviderToken.TokenId
		        Profile.Name = Details.Value("name")
		        Profile.ServiceId = Dict.Value("id")
		        Profile.Address = Details.Value("address")
		        Profile.Platform = Beacon.PlatformPC
		        
		        If Profile.Name.BeginsWith("Gameserver - ") And Dict.HasKey("comment") And IsNull(Dict.Value("comment")) = False Then
		          Profile.Name = Dict.Value("comment")
		        End If
		      Catch Err As RuntimeException
		        Continue
		      End Try
		      
		      Self.Log("Retrieving " + Profile.Name + "…")
		      // Lookup server information
		      Var DetailsSocket As New SimpleHTTP.SynchronousHTTPSocket
		      DetailsSocket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		      Self.SendRequest(DetailsSocket, "GET", "https://api.nitrado.net/services/" + Profile.ServiceID.ToString(Locale.Raw, "#") + "/gameservers")
		      If Self.Finished Or Self.CheckError(DetailsSocket) Then
		        Continue
		      End If
		      Var DetailsContent As String = DetailsSocket.LastString
		      
		      Var DetailsResponse As Dictionary = Beacon.ParseJSON(DetailsContent)
		      Var DetailsData As Dictionary = DetailsResponse.Value("data")
		      Var GameServer As Dictionary = DetailsData.Value("gameserver")
		      Var GameSpecific As Dictionary = GameServer.Value("game_specific")
		      Profile.ConfigPath = GameSpecific.Value("path")
		      
		      Var Settings As Dictionary = GameServer.Value("settings")
		      Var Config As Dictionary = Settings.Value("config")
		      Var AdminFilename As String = Config.Value("AdminFileName")
		      
		      Var Server As New SDTD.NitradoDiscoveredData(Profile.ServiceId, Self.mProviderToken.AccessToken, Profile.ConfigPath, AdminFilename)
		      Server.Profile = Profile
		      
		      Servers.Add(Server)
		    Catch Err As RuntimeException
		      App.LogAPIException(Err, CurrentMethodName, Socket.LastURL, Status, Content)
		      Continue
		    End Try
		  Next
		  
		  Return Servers
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CheckError(Socket As SimpleHTTP.SynchronousHTTPSocket) As Boolean
		  Return Self.CheckError(Socket.LastURL, Socket.LastHTTPStatus, Socket.LastContent, Socket.LastException)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(URL As String, HTTPStatus As Integer, HTTPResponse As MemoryBlock, HTTPException As RuntimeException) As Boolean
		  Var Message As String
		  If Self.CheckResponseForError(URL, HTTPStatus, HTTPResponse, HTTPException, Message) Then
		    Self.SetError(Message)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckResponseForError(URL As String, HTTPStatus As Integer, HTTPResponse As MemoryBlock, HTTPException As RuntimeException, ByRef Message As String) As Boolean
		  Select Case HTTPStatus
		  Case 200, 201
		    Message = ""
		    Return False
		  Case 401
		    Message = "Error: Authorization failed."
		  Case 429
		    Message = "Error: Rate limit has been exceeded."
		  Case 503
		    Message = "Error: Nitrado is offline for maintenance."
		  Case 504
		    Message = "Error: Nitrado appears to be having an unplanned outage."
		  Case 500
		    Var TempMessage As String
		    If (HTTPResponse Is Nil) = False Then
		      Try
		        Var Parsed As Variant = Beacon.ParseJSON(HTTPResponse)
		        If Parsed.Type = Variant.TypeObject And Parsed.ObjectValue IsA Dictionary And Dictionary(Parsed.ObjectValue).HasKey("message") Then
		          TempMessage = "Nitrado Error: " + Dictionary(Parsed.ObjectValue).Value("message").StringValue
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If TempMessage = "Nitrado Error: The service is currently in state 4 but it expecting state 2,3." Then
		      Message = TempMessage + " The service may be expired."
		    ElseIf TempMessage.IsEmpty = False Then
		      Message = TempMessage
		    Else
		      Message = "Error: Nitrado responded with an error but no message."
		    End If
		  Case 0
		    Message = "Connection error #" + HTTPException.ErrorNumber.ToString(Locale.Raw, "0")
		    
		    If (HTTPException Is Nil) = False And HTTPException.Message.IsEmpty = False Then
		      Message = Message + ": " + HTTPException.Message
		    ElseIf (HTTPResponse Is Nil) = False And HTTPResponse.Size > 0 Then
		      Message = Message + ": " + HTTPResponse.StringValue(0, HTTPResponse.Size).GuessEncoding
		    End If
		    
		    If Message.EndsWith(".") = False Then
		      Message = Message + "."
		    End If
		    App.Log(Message)
		    App.Log("Target: " + URL)
		    
		    Message = Message + " Check the Nitrado API status at https://status.usebeacon.app/ for more information."
		  Else
		    Message = "Unexpected HTTP status " + HTTPStatus.ToString(Locale.Raw, "0")
		  End Select
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckSocketForError(Socket As SimpleHTTP.SynchronousHTTPSocket, Transfer As Beacon.IntegrationTransfer) As Boolean
		  Var Message As String
		  If CheckResponseForError(Socket.LastURL, Socket.LastHTTPStatus, Socket.LastContent, Socket.LastException, Message) Then
		    Transfer.ErrorMessage = Message
		    Transfer.Success = False
		  Else
		    Transfer.Success = True
		  End If
		  If (Socket.LastContent Is Nil) = False Then
		    Transfer.Content = Socket.LastContent
		  End If
		  Return Not Transfer.Success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckSocketForError(Socket As SimpleHTTP.SynchronousHTTPSocket, ByRef Message As String) As Boolean
		  Return CheckResponseForError(Socket.LastURL, Socket.LastHTTPStatus, Socket.LastContent, Socket.LastException, Message)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  Self.mInitialStatusQuery = True
		  
		  If Profile IsA SDTD.NitradoServerProfile Then
		    Self.mServiceId = SDTD.NitradoServerProfile(Profile).ServiceId
		  End If
		  
		  Super.Constructor(Nil, Profile)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mInitialStatusQuery As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderToken As BeaconAPI.ProviderToken
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceId As Integer
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
