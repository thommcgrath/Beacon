#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag Method, Flags = &h21
		Private Shared Function CleanupPath(Path As String) As String
		  Var Query As String
		  Var QueryPos As Integer = Path.IndexOf("?")
		  If QueryPos > -1 Then
		    Query = Path.Middle(QueryPos + 1)
		    Path = Path.Left(QueryPos)
		  End If
		  
		  If Path.Contains("../") Then
		    Var Err As UnsupportedOperationException
		    Err.Message = "Paths containing '../' are not allowed"
		    Raise Err
		  End If
		  Path = Path.ReplaceAll("./", "")
		  While Path.BeginsWith("/")
		    Path = Path.Middle(1)
		  Wend
		  While Path.EndsWith("/")
		    Path = Path.Left(Path.Length - 1)
		  Wend
		  
		  Var Components() As String = Path.Split("/")
		  For Idx As Integer = Components.LastIndex DownTo Components.FirstIndex
		    If Components(Idx).IsEmpty Then
		      Components.RemoveAt(Idx)
		      Continue
		    End If
		    
		    Components(Idx) = EncodeURLComponent(Components(Idx))
		  Next
		  Path = String.FromArray(Components, "/")
		  
		  If Query.IsEmpty = False Then
		    Path = Path + "?" + Query
		  End If
		  
		  Return Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Logger As Beacon.LogProducer = Nil)
		  // Part of the Beacon.HostingProvider interface.
		  
		  If Logger Is Nil Then
		    Self.mLogger = New Beacon.DummyLogProducer
		  Else
		    Self.mLogger = Logger
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateCheckpoint(Project As Beacon.Project, Profile As Beacon.ServerProfile, Name As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("backupName") = Name
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("POST", BaseUrl + "/servers/" + ServerId + "/backup", Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function DiscoverHost(Config As BeaconHostingAPI.HostConfig) As Boolean
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Config.TokenId, Nil, True)
		  If Token Is Nil Then
		    Return False
		  End If
		  Config.TokenKey = Token.EncryptionKey
		  
		  Return DiscoverHost(Config, Token)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function DiscoverHost(Config As BeaconHostingAPI.HostConfig, Token As BeaconAPI.ProviderToken) As Boolean
		  Var DiscoveryUrl As String = Token.ProviderSpecific("endpoint", "")
		  If DiscoveryUrl.IsEmpty Then
		    Return False
		  End If
		  
		  Var Connection As New URLConnection
		  Connection.RequestHeader("User-Agent") = App.UserAgent
		  Connection.RequestHeader("Authorization") = "KEY " + Token.AccessToken
		  
		  Var Response As String
		  Try
		    Response = Connection.SendSync("GET", DiscoveryUrl, 30)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  If Connection.HTTPStatusCode < 200 Or Connection.HTTPStatusCode >= 300 Then
		    Return False
		  End If
		  
		  Var Discovery As JSONItem
		  Try
		    Discovery = New JSONItem(Response)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Try
		    Var BaseUrl As String = Discovery.Value("baseUrl")
		    Config.Endpoint = BaseUrl
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  Var Path As String = Self.CleanupPath(Transfer.Path)
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", BaseUrl + "/servers/" + ServerId + "/files/" + Path, Token))
		  If Not Response.Success Then
		    Select Case FailureMode
		    Case Beacon.Integration.DownloadFailureMode.MissingAllowed
		      Var Status As Integer = Response.HTTPStatus
		      If Status = 404 Then
		        Transfer.Success = True
		        Transfer.Content = ""
		      Else
		        Transfer.SetError(Response.Message)
		      End If
		    Case Beacon.Integration.DownloadFailureMode.ErrorsAllowed
		      Transfer.Success = True
		      Transfer.Content = ""
		    Case Beacon.Integration.DownloadFailureMode.Required
		      Raise Response.Error
		    End Select
		    Return
		  End If
		  
		  Transfer.Success = True
		  Transfer.Content = Response.Content
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GetCredentials(Project As Beacon.Project, Profile As Beacon.ServerProfile, ByRef BaseUrl As String, ByRef ServerId As String, ByRef Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA BeaconHostingAPI.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile must have a Beacon Open Hosting API config object"
		    Raise Err
		  End If
		  
		  Var APIConfig As BeaconHostingAPI.HostConfig = BeaconHostingAPI.HostConfig(Config)
		  ServerId = APIConfig.ServerId
		  BaseUrl = APIConfig.Endpoint
		  Token = BeaconAPI.GetProviderToken(APIConfig.TokenId, Project, True)
		  If (Token Is Nil) = False Then
		    If Token.IsEncrypted Then
		      Var Err as New UnsupportedOperationException
		      Err.Message = "Provider token is still encrypted. Ask " + Token.UserName + " to resave."
		      Raise Err
		    End If
		    APIConfig.TokenKey = Token.EncryptionKey
		  Else
		    // No such token
		    Var Err as New UnsupportedOperationException
		    Err.Message = "Authorization data for the account was not found."
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse
		  Var RetriesRemaining As Integer = 3
		  Do
		    Response = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", BaseUrl + "/servers/" + ServerId + "/status", Token))
		    If Response.Success = False Then
		      If RetriesRemaining > 0 Then
		        RetriesRemaining = RetriesRemaining - 1
		        Thread.Current.Sleep(3000)
		        Continue
		      Else
		        Raise Response.Error
		      End If
		    End If
		  Loop Until (Response Is Nil) = False And Response.Success = True
		  
		  Var JSON As JSONItem = New JSONItem(Response.Content)
		  Var StatusCode As String = JSON.Value("status")
		  
		  Var Status As Beacon.ServerStatus
		  Select Case StatusCode
		  Case "running", "started"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Running, StatusCode)
		  Case "starting"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Starting, StatusCode)
		  Case "stopped"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopped, StatusCode)
		  Case "stopping"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopping, StatusCode)
		  Case "suspended"
		    Status = New Beacon.ServerStatus("The server has been suspended. Contact your hosting provider for more information.", StatusCode)
		  Case "updating"
		    Status = New Beacon.ServerStatus("The server is installing an update.", StatusCode)
		  Else
		    Status = New Beacon.ServerStatus("Unknown server status: " + StatusCode, StatusCode)
		  End Select
		  
		  Return Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  StartingPath = Self.CleanupPath(StartingPath)
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", BaseUrl + "/servers/" + ServerId + "/files/" + StartingPath, Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var JSON As JSONItem = New JSONItem(Response.Content)
		  Var Files As JSONItem = JSON.Value("files")
		  Var Paths() As String
		  For Idx As Integer = 0 To Files.LastRowIndex
		    Paths.Add(Files.ValueAt(Idx))
		  Next
		  
		  Return Paths
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  If (Config IsA BeaconHostingAPI.HostConfig) = False Then
		    Var Err As UnsupportedOperationException
		    Err.Message = "Config is not a Beacon Open Hosting API config."
		    Raise Err
		  End If
		  Var APIConfig As BeaconHostingAPI.HostConfig = BeaconHostingAPI.HostConfig(Config)
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(APIConfig.TokenId, Nil, True)
		  APIConfig.TokenKey = Token.EncryptionKey
		  
		  If APIConfig.Endpoint.IsEmpty And Self.DiscoverHost(APIConfig, Token) = False Then
		    Raise New BeaconHostingAPI.APIException("Could not find the hosts's API")
		  End
		  
		  Var ListUrl As String = APIConfig.Endpoint + "/servers"
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", ListUrl, Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Profiles() As Beacon.ServerProfile
		  Var JSON As New JSONItem(Response.Content)
		  Var Servers As JSONItem = JSON.Value("servers")
		  For Idx As Integer = 0 To Servers.LastRowIndex
		    Var ServerJSON As JSONItem = Servers.ValueAt(Idx)
		    If ServerJSON Is Nil Or ServerJSON.Value("gameId") <> GameId Then
		      Continue
		    End If
		    
		    Var ServerId As String = ServerJSON.Value("serverId")
		    Var ServerName As String = ServerJSON.Value("name")
		    Var Nickname As String = ServerJSON.Lookup("nickname", "")
		    Var Platform As Integer = ServerJSON.Lookup("platform", Beacon.PlatformUnknown)
		    
		    Var SecondaryName As String
		    If ServerJSON.HasKey("ip_address") And ServerJSON.HasKey("port") Then
		      SecondaryName = ServerJSON.Value("ip_address").StringValue + ":" + ServerJSON.Value("port").IntegerValue.ToString(Locale.Raw, "0")
		    End If
		    
		    Var ProfileId As String = Beacon.UUID.v5(Self.Identifier + ":" + ServerId)
		    
		    Var Profile As Beacon.ServerProfile
		    Select Case GameId
		    Case Ark.Identifier
		      Profile = New Ark.ServerProfile(Self.Identifier, ProfileId, ServerName, Nickname, SecondaryName)
		    Case SDTD.Identifier
		      Profile = New SDTD.ServerProfile(Self.Identifier, ProfileId, ServerName, Nickname, SecondaryName)
		    Case ArkSA.Identifier
		      Profile = New ArkSA.ServerProfile(Self.Identifier, ProfileId, ServerName, Nickname, SecondaryName)
		    Case Palworld.Identifier
		      Profile = New Palworld.ServerProfile(Self.Identifier, ProfileId, ServerName, Nickname, SecondaryName)
		    End Select
		    
		    Var ProfileConfig As New BeaconHostingAPI.HostConfig
		    ProfileConfig.ServerId = ServerId
		    ProfileConfig.TokenId = Token.TokenId
		    ProfileConfig.TokenKey = Token.EncryptionKey
		    Profile.HostConfig = ProfileConfig
		    Profile.Platform = Platform
		    Profile.Modified = False
		    
		    Profiles.Add(Profile)
		  Next
		  
		  Return Profiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logger() As Beacon.LogProducer
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return Self.mLogger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchesToken(Token As BeaconAPI.ProviderToken) As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return (Token Is Nil) = False And Token.Provider = BeaconAPI.ProviderToken.ProviderBeaconHostingAPI
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunRequest(Request As BeaconHostingAPI.APIRequest) As BeaconHostingAPI.APIResponse
		  Var Headers As Dictionary = Request.Headers
		  Var Content As MemoryBlock = Request.Content
		  Var RequestMethod As String = Request.RequestMethod
		  Var Url As String = Request.Url
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  For Each Entry As DictionaryEntry In Headers
		    Socket.RequestHeader(Entry.Key) = Entry.Value
		  Next
		  
		  If (Content Is Nil) = False And Content.Size > 0 And Headers.HasKey("Content-Type") Then
		    Socket.SetRequestContent(Content, Headers.Value("Content-Type"))
		  End If
		  
		  Self.mThrottled = True
		  Var Locked As Boolean = Preferences.SignalConnection()
		  Self.mThrottled = False
		  Self.mActiveSocket = Socket
		  #if DebugBuild
		    System.DebugLog("BeaconHostingAPI.HostingProvider: " + RequestMethod + " " + Url)
		    Var RequestStartTime As Double = System.Microseconds
		  #endif
		  Socket.Send(RequestMethod, Url, 120)
		  #if DebugBuild
		    Var RequestDuration As Double = (System.Microseconds - RequestStartTime) * 0.001
		    System.DebugLog("HTTP " + Socket.LastHTTPStatus.ToString(Locale.Raw, "0") + " took " + RequestDuration.ToString(Locale.Raw, ",##0.00") + "ms")
		  #endif
		  Self.mActiveSocket = Nil
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		  Return New BeaconHostingAPI.APIResponse(Socket)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  If Self.mActiveSocket Is Nil Then
		    Return ""
		  End If
		  
		  Select Case Self.mActiveSocket.Phase
		  Case SimpleHTTP.SynchronousHTTPSocket.Phases.Sending
		    Var Sent As Int64 = Self.mActiveSocket.SentBytes
		    Var Total As Int64 = Self.mActiveSocket.SendingBytes
		    If Total > 0 Then
		      Var Percent As Double = Sent / Total
		      Return "Uploaded " + Beacon.BytesToString(Sent) + " of " + Beacon.BytesToString(Total) + " (" + Percent.ToString(Locale.Current, "0%") + ")"
		    Else
		      Return "Uploaded " + Beacon.BytesToString(Sent)
		    End If
		  Case SimpleHTTP.SynchronousHTTPSocket.Phases.Receiving
		    Var Received As Int64 = Self.mActiveSocket.ReceivedBytes
		    Var Total As Int64 = Self.mActiveSocket.ReceivingBytes
		    If Total > 0 Then
		      Var Percent As Double = Received / Total
		      Return "Downloaded " + Beacon.BytesToString(Received) + " of " + Beacon.BytesToString(Total) + " (" + Percent.ToString(Locale.Current, "0%") + ")"
		    Else
		      Return "Downloaded " + Beacon.BytesToString(Received)
		    End If
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("logMessage") = "Started by Beacon"
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("POST", BaseUrl + "/servers/" + ServerId + "/start", Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("logMessage") = "Stopped by Beacon"
		  Body.Value("announceMessage") = StopMessage
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("POST", BaseUrl + "/servers/" + ServerId + "/stop", Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return Self.mThrottled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId, BaseUrl As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, BaseUrl, ServerId, Token)
		  
		  Var Path As String = Self.CleanupPath(Transfer.Path)
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("PUT", BaseUrl + "/servers/" + ServerId + "/files/" + Path, Token, "application/octet-stream", Transfer.Content))
		  If Not Response.Success Then
		    Select Case Response.HTTPStatus
		    Case 406
		      Response.Error.Message = "The host could not verify the provided checksum. This usually indicates the connection was dropped during upload. If this problem persists, contact your hosting provider."
		    Else
		      Response.Error.Message = "Unexpected " + Response.HTTPStatus.ToString(Locale.Raw, "0") + " status from host: " + Response.Error.Message
		    End Select
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mActiveSocket As SimpleHTTP.SynchronousHTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogger As Beacon.LogProducer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThrottled As Boolean
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
