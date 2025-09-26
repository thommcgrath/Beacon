#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag Method, Flags = &h0
		Sub Constructor(Logger As Beacon.LogProducer = Nil)
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
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ContainerId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ContainerId, Token)
		  
		  Var FileType As String
		  Select Case Transfer.Path
		  Case ArkSA.ConfigFileGameUserSettings
		    FileType = "gus_meta"
		  Case ArkSA.ConfigFileGame
		    FileType = "game_meta"
		  Else
		    Transfer.Success = False
		    Transfer.Content = ""
		    Transfer.ErrorMessage = "Unknown file type " + Transfer.Path
		    Return
		  End Select
		  
		  Var Response As ASAManager.APIResponse = Self.RunRequest(New ASAManager.APIRequest("GET", ASAManager.APIRoot + "/containers/" + ContainerId.ToString(Locale.Raw, "0") + "/config/" + FileType, Token))
		  If Not Response.Success Then
		    Transfer.Success = (FailureMode = Beacon.Integration.DownloadFailureMode.Required)
		    Transfer.Content = ""
		    Transfer.ErrorMessage = Response.Error.Message
		    Return
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  If Not Parsed.Value("success").BooleanValue Then
		    Transfer.Success = (FailureMode = Beacon.Integration.DownloadFailureMode.Required)
		    Transfer.Content = ""
		    Transfer.ErrorMessage = Parsed.Value("message").StringValue
		    Return
		  End If
		  
		  Var Data As JSONItem = Parsed.Child("data")
		  Var FileContent As String = Data.Value("content")
		  Var ExpectedHash As String = Data.Value("md5_hash")
		  Var ComputedHash As String = EncodeHex(Crypto.MD5(FileContent))
		  If ExpectedHash <> ComputedHash Then
		    Transfer.Success = False
		    Transfer.Content = ""
		    Transfer.ErrorMessage = "File downloaded, but content verification failed."
		    Return
		  End If
		  
		  Transfer.Content = FileContent
		  Transfer.Success = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GetCredentials(Project As Beacon.Project, Profile As Beacon.ServerProfile, ByRef ContainerId As Integer, ByRef Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA ASAManager.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile must have a ASAManager host config object"
		    Raise Err
		  End If
		  
		  ContainerId = ASAManager.HostConfig(Config).ContainerId
		  Token = BeaconAPI.GetProviderToken(ASAManager.HostConfig(Config).TokenId, Project, True)
		  If (Token Is Nil) = False Then
		    If Token.IsEncrypted Then
		      Var Err as New UnsupportedOperationException
		      Err.Message = "Provider token is still encrypted. Ask " + Token.UserName + " to resave."
		      Raise Err
		    End If
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
		  
		  Var ContainerId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ContainerId, Token)
		  
		  Var Response As ASAManager.APIResponse = Self.RunRequest(New ASAManager.APIRequest("GET", ASAManager.APIRoot + "/containers/" + ContainerId.ToString(Locale.Raw, "0") + "/status", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  If Not Parsed.Value("success").BooleanValue Then
		    Raise New ASAManager.APIException("Could not fetch container status")
		  End If
		  
		  Var StatusData As JSONItem = Parsed.Child("data")
		  Var StatusMessage As String = StatusData.Value("status")
		  Var Status As Beacon.ServerStatus
		  Select Case StatusMessage
		  Case "running"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Running, StatusData)
		  Case "stopped"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopped, StatusData)
		  Else
		    Status = New Beacon.ServerStatus("Unknown server status: " + StatusMessage, StatusData)
		  End Select
		  
		  Return Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return ASAManager.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused StartingPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(ASAManager.HostConfig(Config).TokenId, Nil, True)
		  Var Profiles() As Beacon.ServerProfile
		  
		  Var Response As ASAManager.APIResponse = Self.RunRequest(New ASAManager.APIRequest("GET", ASAManager.APIRoot + "/containers", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  If Not Parsed.Value("success").BooleanValue Then
		    Raise New ASAManager.APIException("Could not list servers")
		  End If
		  
		  Var TargetGameNumber As Integer
		  Select Case GameId
		  Case ArkSA.Identifier
		    TargetGameNumber = 1
		  End Select
		  
		  Var Containers As JSONItem = Parsed.Child("data")
		  Var Bound As Integer = Containers.LastRowIndex
		  For Idx As Integer = 0 To Bound
		    Var Container As JSONItem = Containers.ChildAt(Idx)
		    If Container.Child("permissions").Value("can_view").BooleanValue = False Or Container.Child("game").Value("id") <> TargetGameNumber Then
		      Continue
		    End If
		    Var ContainerId As Integer = Container.Value("id").IntegerValue
		    Var ContainerName As String = Container.Value("container_name").StringValue
		    
		    Var ProfileId As String = Beacon.UUID.v5(Self.Identifier + ":" + ContainerId.ToString(Locale.Raw, "0"))
		    Var ProfileConfig As New ASAManager.HostConfig
		    ProfileConfig.TokenId = Token.TokenId
		    ProfileConfig.TokenKey = Token.EncryptionKey
		    ProfileConfig.ContainerId = ContainerId
		    
		    Var Profile As Beacon.ServerProfile
		    Select Case GameId
		    Case ArkSA.Identifier
		      Var MapMask As UInt64 = ArkSA.Maps.MaskForIdentifier(Container.Value("map_name").StringValue)
		      Var MapLabel As String
		      If MapMask = ArkSA.Maps.All.Mask Then
		        MapLabel = "All Maps"
		      Else
		        MapLabel = ArkSA.Maps.LabelForMask(MapMask)
		      End If
		      
		      Var Address As String = Container.Child("machine").Value("ip_address").StringValue + ":" + Container.Value("server_port").IntegerValue.ToString(Locale.Raw, "0")
		      
		      Profile = New ArkSA.ServerProfile(Self.Identifier, ProfileId, ContainerName + " (" + MapLabel + ")", "", Address)
		      ArkSA.ServerProfile(Profile).Mask = ArkSA.Maps.MaskForIdentifier(Container.Value("map_name"))
		      ArkSA.ServerProfile(Profile).GameIniPath = ArkSA.ConfigFileGame
		      ArkSA.ServerProfile(Profile).GameUserSettingsIniPath = ArkSA.ConfigFileGameUserSettings
		    End Select
		    Profile.Platform = Beacon.PlatformPC
		    Profile.HostConfig = ProfileConfig
		    Profiles.Add(Profile)
		  Next
		  
		  Return Profiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logger() As Beacon.LogProducer
		  Return Self.mLogger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchesToken(Token As BeaconAPI.ProviderToken) As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return (Token Is Nil) = False And Token.Provider = BeaconAPI.ProviderToken.ProviderASAManager
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunRequest(Request As ASAManager.APIRequest) As ASAManager.APIResponse
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
		  Socket.Send(RequestMethod, Url)
		  Self.mActiveSocket = Nil
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		  
		  Return ASAManager.APIResponse.FromSocket(Socket)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ContainerId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ContainerId, Token)
		  
		  Var Response As ASAManager.APIResponse = Self.RunRequest(New ASAManager.APIRequest("POST", ASAManager.APIRoot + "/containers/" + ContainerId.ToString(Locale.Raw, "0") + "/start", Token, "application/json", ""))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  If Not Parsed.Value("success").BooleanValue Then
		    Raise New ASAManager.APIException(Parsed.Value("message").StringValue)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused StopMessage
		  
		  Var ContainerId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ContainerId, Token)
		  
		  Var Response As ASAManager.APIResponse = Self.RunRequest(New ASAManager.APIRequest("POST", ASAManager.APIRoot + "/containers/" + ContainerId.ToString(Locale.Raw, "0") + "/stop", Token, "application/json", ""))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  If Not Parsed.Value("success").BooleanValue Then
		    Raise New ASAManager.APIException(Parsed.Value("message").StringValue)
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
		  
		  Var ContainerId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ContainerId, Token)
		  
		  Var FileType As String
		  Select Case Transfer.Path
		  Case ArkSA.ConfigFileGameUserSettings
		    FileType = "gus_meta"
		  Case ArkSA.ConfigFileGame
		    FileType = "game_meta"
		  Else
		    Transfer.Success = False
		    Transfer.ErrorMessage = "Unknown file type " + Transfer.Path
		    Return
		  End Select
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("content") = Transfer.Content
		  Body.Value("md5_hash") = EncodeHex(Crypto.MD5(Transfer.Content)).Lowercase
		  
		  Var Response As ASAManager.APIResponse = Self.RunRequest(New ASAManager.APIRequest("PUT", ASAManager.APIRoot + "/containers/" + ContainerId.ToString(Locale.Raw, "0") + "/config/" + FileType, Token, "application/json", Body.ToString(True)))
		  If Not Response.Success Then
		    Transfer.Success = False
		    Transfer.ErrorMessage = Response.Error.Message
		    Return
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  If Not Parsed.Value("success").BooleanValue Then
		    Transfer.Success = False
		    Transfer.ErrorMessage = Parsed.Value("message").StringValue
		    Return
		  End If
		  
		  Transfer.Success = True
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
