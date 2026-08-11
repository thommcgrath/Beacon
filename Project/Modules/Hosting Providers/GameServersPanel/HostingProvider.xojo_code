#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
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
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("GET", "https://gameserverspanel.com/api/v1/servers/" + ServerId + "/config-files/" + Transfer.Path, Token))
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
		  
		  Var JSON As New JSONItem(Response.Content)
		  Transfer.Success = True
		  Transfer.Content = JSON.Value("content")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GetCredentials(Project As Beacon.Project, Profile As Beacon.ServerProfile, ByRef ServerId As String, ByRef Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA GameServersPanel.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile must have a GameServersPanel config object"
		    Raise Err
		  End If
		  
		  Var APIConfig As GameServersPanel.HostConfig = GameServersPanel.HostConfig(Config)
		  ServerId = APIConfig.ServerId
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
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("GET", "https://gameserverspanel.com/api/v1/servers/" + ServerId + "/status", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var JSON As New JSONItem(Response.Content)
		  Var StatusCode As String = JSON.Value("status")
		  
		  Var Status As Beacon.ServerStatus
		  Select Case StatusCode
		  Case "installing"
		    Status = New Beacon.ServerStatus("The server is performing its initial install.", StatusCode)
		  Case "updating"
		    Status = New Beacon.ServerStatus("The server is installing an update.", StatusCode)
		  Case "running"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Running, StatusCode)
		  Case "starting"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Starting, StatusCode)
		  Case "stopped", "offline"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopped, StatusCode)
		  Case "stopping"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopping, StatusCode)
		  Case "crashed"
		    Status = New Beacon.ServerStatus("The server has crashed.", StatusCode)
		  Else
		    Status = New Beacon.ServerStatus("Unknown server status: " + StatusCode, StatusCode)
		  End Select
		  
		  Return Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return GameServersPanel.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  #Pragma Unused StartingPath
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("GET", "https://gameserverspanel.com/api/v1/servers/" + ServerId + "/config-files", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var JSON As JSONItem = New JSONItem(Response.Content)
		  Var Files As JSONItem = JSON.Value("data")
		  Var Paths() As String
		  For Idx As Integer = 0 To Files.LastRowIndex
		    Var FileJSON As JSONItem = Files.ValueAt(Idx)
		    Paths.Add(FileJSON.Value("key"))
		  Next
		  
		  Return Paths
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  If (Config IsA GameServersPanel.HostConfig) = False Then
		    Var Err As UnsupportedOperationException
		    Err.Message = "Config is not a GameServersPanel config."
		    Raise Err
		  End If
		  Var APIConfig As GameServersPanel.HostConfig = GameServersPanel.HostConfig(Config)
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(APIConfig.TokenId, Nil, True)
		  APIConfig.TokenKey = Token.EncryptionKey
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("GET", "https://gameserverspanel.com/api/v1/servers", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var JSON As New JSONItem(Response.Content)
		  Var Servers As JSONItem = JSON.Value("data")
		  Var Profiles() As Beacon.ServerProfile
		  For Idx As Integer = 0 To Servers.LastRowIndex
		    Var ServerJSON As JSONItem = Servers.ValueAt(Idx)
		    
		    Var ServerGame As String = ServerJSON.Value("game")
		    Select Case ServerGame
		    Case "arkse"
		      ServerGame = Ark.Identifier
		    End Select
		    If ServerGame <> GameId Then
		      Continue
		    End If
		    
		    Var ServerId As String = ServerJSON.Value("id")
		    Var ServerName As String = ServerJSON.Value("name")
		    
		    Var ProfileId As String = Beacon.UUID.v5(Self.Identifier + ":" + ServerId)
		    
		    Var Profile As Beacon.ServerProfile
		    Select Case GameId
		    Case Ark.Identifier
		      Profile = New Ark.ServerProfile(Self.Identifier, ProfileId, ServerName, "", "")
		      Ark.ServerProfile(Profile).GameIniPath = "game_ini"
		      Ark.ServerProfile(Profile).GameUserSettingsIniPath = "game_user_settings_ini"
		    Case SDTD.Identifier
		      Profile = New SDTD.ServerProfile(Self.Identifier, ProfileId, ServerName, "", "")
		    Case ArkSA.Identifier
		      Profile = New ArkSA.ServerProfile(Self.Identifier, ProfileId, ServerName, "", "")
		      ArkSA.ServerProfile(Profile).GameIniPath = "game_ini"
		      ArkSA.ServerProfile(Profile).GameUserSettingsIniPath = "game_user_settings_ini"
		    Case Palworld.Identifier
		      Profile = New Palworld.ServerProfile(Self.Identifier, ProfileId, ServerName, "", "")
		      Palworld.ServerProfile(Profile).SettingsIniPath = "game_ini"
		    End Select
		    
		    Var ProfileConfig As New GameServersPanel.HostConfig
		    ProfileConfig.ServerId = ServerId
		    ProfileConfig.TokenId = Token.TokenId
		    ProfileConfig.TokenKey = Token.EncryptionKey
		    Profile.HostConfig = ProfileConfig
		    Profile.Platform = Beacon.PlatformUnknown
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
		  
		  Return (Token Is Nil) = False And Token.Provider = BeaconAPI.ProviderToken.ProviderGameServersPanel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunRequest(Request As GameServersPanel.APIRequest) As GameServersPanel.APIResponse
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
		    System.DebugLog("GameServersPanel.HostingProvider: " + RequestMethod + " " + Url)
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
		  Return New GameServersPanel.APIResponse(Socket)
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
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("POST", "https://gameserverspanel.com/api/v1/servers/" + ServerId + "/power/start", Token, "application/json", ""))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("POST", "https://gameserverspanel.com/api/v1/servers/" + ServerId + "/power/stop", Token, "application/json", ""))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
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
		  
		  Return False
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
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("content") = Transfer.Content
		  Body.Value("restartPolicy") = "manual"
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As GameServersPanel.APIResponse = Self.RunRequest(New GameServersPanel.APIRequest("PUT", "https://gameserverspanel.com/api/v1/servers/" + ServerId + "/config-files/" + Transfer.Path, Token, "application/octet-stream", Body.ToString))
		  If Not Response.Success Then
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


End Class
#tag EndClass
