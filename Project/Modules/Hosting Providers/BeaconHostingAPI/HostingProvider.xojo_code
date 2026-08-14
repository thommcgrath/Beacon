#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider, Ark.HostingProvider, ArkSA.HostingProvider, Palworld.HostingProvider
	#tag Method, Flags = &h1
		Protected Function BuildUrl(Profile As Beacon.ServerProfile, Token As BeaconAPI.ProviderToken, Path As String) As String
		  Var Holder As New Beacon.LockHolder(mDetailsLock)
		  #Pragma Unused Holder
		  If mEndpointDetails.HasKey(Profile.ProfileId) = False Then
		    mEndpointDetails.Value(Profile.ProfileId) = Self.GetEndpointDetails(Token)
		  End If
		  
		  If Path.BeginsWith("/") = False Then
		    Path = "/" + Path
		  End If
		  Return EndpointDetails(mEndpointDetails.Value(Profile.ProfileId).ObjectValue).BaseUrl + Path
		End Function
	#tag EndMethod

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
		  Path = Path.ReplaceAll("./", "/")
		  While Path.Contains("//")
		    Path = Path.ReplaceAll("//", "/")
		  Wend
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
		Function CommandLineOptions(Project As Ark.Project, Profile As Ark.ServerProfile) As Dictionary
		  // Part of the Ark.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/launchOptions"), Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  // We have the "raw" value, but the docs say we don't read from it, so let's not read from it.
		  
		  Var JSON As New JSONItem(Response.Content)
		  
		  Var Options() As String
		  Var OptionsSource As JSONItem = JSON.Value("chain")
		  For Idx As Integer = 0 To OptionsSource.LastRowIndex
		    Var Option As String = OptionsSource.ValueAt(Idx)
		    If Option.BeginsWith("?") Then
		      Option = Option.Middle(1)
		    End If
		    Options.Add(Option)
		  Next
		  
		  Var Flags() As String
		  Var FlagsSource As JSONItem = JSON.Value("flags")
		  For Idx As Integer = 0 To FlagsSource.LastRowIndex
		    Var Flag As String = FlagsSource.ValueAt(Idx)
		    If Flag.BeginsWith("-") = False Then
		      Flag = "-" + Flag
		    End If
		    Flags.Add(Flag)
		  Next
		  
		  Var Launch As String = """" + String.FromArray(Options, "?") + """ " + String.FromArray(Flags, " ")
		  Return Ark.ParseCommandLine(Launch, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Project As Ark.Project, Profile As Ark.ServerProfile, Assigns Options As Dictionary)
		  // Part of the Ark.HostingProvider interface.
		  
		  Var Body As New JSONItem("{}")
		  Var Chain() As String
		  Var Flags() As String
		  
		  For Each Entry As DictionaryEntry In Options
		    Var Key As String = Entry.Key
		    Var First As String = Key.Left(1)
		    Key = Key.Middle(1)
		    
		    Select Case First
		    Case "?"
		      Chain.Add(Entry.Value)
		    Case "-"
		      Flags.Add(Entry.Value)
		    End Select
		  Next
		  
		  Var Maps() As Ark.Map = Ark.Maps.ForMask(Profile.Mask)
		  Var Map As String
		  If Maps.Count > 0 Then
		    Map = Maps(0).Identifier
		  Else
		    Map = "TheIsland"
		  End If
		  
		  Var Raw As String = """" + Map + "?listen?" + String.FromArray(Chain, "?") + """"
		  If Flags.Count > 0 Then
		    Raw = Raw + " -" + String.FromArray(Flags, " -")
		  End If
		  
		  Body.Value("raw") = Raw
		  Body.Value("chain") = Chain
		  Body.Value("flags") = Flags
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("PUT", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/launchOptions"), Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As Dictionary
		  // Part of the ArkSA.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/launchOptions"), Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  // We have the "raw" value, but the docs say we don't read from it, so let's not read from it.
		  
		  Var JSON As New JSONItem(Response.Content)
		  
		  Var Options() As String
		  Var OptionsSource As JSONItem = JSON.Value("chain")
		  For Idx As Integer = 0 To OptionsSource.LastRowIndex
		    Var Option As String = OptionsSource.ValueAt(Idx)
		    If Option.BeginsWith("?") Then
		      Option = Option.Middle(1)
		    End If
		    Options.Add(Option)
		  Next
		  
		  Var Flags() As String
		  Var FlagsSource As JSONItem = JSON.Value("flags")
		  For Idx As Integer = 0 To FlagsSource.LastRowIndex
		    Var Flag As String = FlagsSource.ValueAt(Idx)
		    If Flag.BeginsWith("-") = False Then
		      Flag = "-" + Flag
		    End If
		    Flags.Add(Flag)
		  Next
		  
		  Var Launch As String = """" + String.FromArray(Options, "?") + """ " + String.FromArray(Flags, " ")
		  Return ArkSA.ParseCommandLine(Launch, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Project As ArkSA.Project, Profile As ArkSA.ServerProfile, Assigns Options As Dictionary)
		  // Part of the ArkSA.HostingProvider interface.
		  
		  Var Body As New JSONItem("{}")
		  Var Chain() As String
		  Var Flags() As String
		  
		  For Each Entry As DictionaryEntry In Options
		    Var Key As String = Entry.Key
		    Var First As String = Key.Left(1)
		    Key = Key.Middle(1)
		    
		    Select Case First
		    Case "?"
		      Chain.Add(Entry.Value)
		    Case "-"
		      Flags.Add(Entry.Value)
		    End Select
		  Next
		  
		  Var Maps() As ArkSA.Map = ArkSA.Maps.ForMask(Profile.Mask)
		  Var Map As String
		  If Maps.Count > 0 Then
		    Map = Maps(0).Identifier
		  Else
		    Map = "TheIsland_WP"
		  End If
		  
		  Var Raw As String = """" + Map + "?listen?" + String.FromArray(Chain, "?") + """"
		  If Flags.Count > 0 Then
		    Raw = Raw + " -" + String.FromArray(Flags, " -")
		  End If
		  
		  Body.Value("raw") = Raw
		  Body.Value("chain") = Chain
		  Body.Value("flags") = Flags
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("PUT", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/launchOptions"), Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
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
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("backupName") = Name
		  Body.Value("level") = "configOnly"
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("POST", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/backup"), Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeployPostflight(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeployPreflight(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Path As String = Self.CleanupPath(Transfer.Path)
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/files/" + Path), Token))
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

	#tag Method, Flags = &h0
		Function FeatureFlags(Project As Beacon.Project, Profile As Beacon.ServerProfile) As UInt64
		  Var Holder As New Beacon.LockHolder(mDetailsLock)
		  #Pragma Unused Holder
		  If mEndpointDetails.HasKey(Profile.ProfileId) = False Then
		    Var ServerId As String
		    Var Token As BeaconAPI.ProviderToken
		    Self.GetCredentials(Project, Profile, ServerId, Token)
		    mEndpointDetails.Value(Profile.ProfileId) = Self.GetEndpointDetails(Token)
		  End If
		  Return EndpointDetails(mEndpointDetails.Value(Profile.ProfileId).ObjectValue).FeatureFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GetCredentials(Project As Beacon.Project, Profile As Beacon.ServerProfile, ByRef ServerId As String, ByRef Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA BeaconHostingAPI.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile must have a Beacon Open Hosting API config object"
		    Raise Err
		  End If
		  
		  Var APIConfig As BeaconHostingAPI.HostConfig = BeaconHostingAPI.HostConfig(Config)
		  
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

	#tag Method, Flags = &h1
		Protected Shared Function GetEndpointDetails(Token As BeaconAPI.ProviderToken) As BeaconHostingAPI.EndpointDetails
		  Var DiscoveryUrl As String = Token.ProviderSpecific("endpoint", "")
		  If DiscoveryUrl.IsEmpty Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Auth token does not contain a discovery endpoint."
		    Raise Err
		  End If
		  
		  Var Connection As New SimpleHTTP.SynchronousHTTPSocket
		  Connection.RequestHeader("User-Agent") = App.UserAgent
		  Connection.RequestHeader("Authorization") = "KEY " + Token.AccessToken
		  Connection.Send("GET", DiscoveryUrl, 30)
		  
		  If Connection.LastHTTPStatus < 200 Or Connection.LastHTTPStatus >= 300 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Could not find API information at the provided endpoint."
		    Raise Err
		  End If
		  
		  Var Response As String = Connection.LastContent
		  Var Discovery As JSONItem = New JSONItem(Response)
		  Var BaseUrl As String = Discovery.Value("baseUrl")
		  If BaseUrl.EndsWith("/") Then
		    BaseUrl = BaseUrl.Left(BaseUrl.Length - 1)
		  End If
		  
		  Var FeatureFlags As UInt64
		  If Discovery.HasKey("capabilities") Then
		    Var Capabilities As JSONItem = Discovery.Value("capabilities")
		    For Idx As Integer = 0 To Capabilities.LastRowIndex
		      Var Key As String = Capabilities.ValueAt(Idx)
		      Select Case Key
		      Case "status"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureStatus
		      Case "restarts"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureRestarts
		      Case "stopMessages"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureStopMessages
		      Case "fullBackups"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureFullBackups
		      Case "configBackups"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureConfigBackups
		      Case "saveBackups"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureSaveBackups
		      Case "launchOptions"
		        FeatureFlags = FeatureFlags Or Beacon.HostFeatureLaunchOptions
		      End Select
		    Next
		  Else
		    FeatureFlags = -1
		  End If
		  
		  Return New EndpointDetails(BaseUrl, FeatureFlags)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse
		  Var RetriesRemaining As Integer = 3
		  Do
		    Response = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId), Token))
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
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Running, JSON)
		  Case "starting"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Starting, JSON)
		  Case "stopped"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopped, JSON)
		  Case "stopping"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopping, JSON)
		  Case "suspended"
		    Status = New Beacon.ServerStatus("The server has been suspended. Contact your hosting provider for more information.", JSON)
		  Case "updating"
		    Status = New Beacon.ServerStatus("The server is installing an update.", JSON)
		  Else
		    Status = New Beacon.ServerStatus("Unknown server status: " + StatusCode, JSON)
		  End Select
		  
		  Return Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return BeaconHostingAPI.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  StartingPath = Self.CleanupPath(StartingPath)
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/files/" + StartingPath), Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var JSON As JSONItem = New JSONItem(Response.Content)
		  Var Files As JSONItem = JSON.Value("files")
		  Var Paths() As String
		  For Idx As Integer = 0 To Files.LastRowIndex
		    Var FileInfo As JSONItem = Files.ValueAt(Idx)
		    Var Filename As String = FileInfo.Value("name")
		    Var IsDirectory As Boolean = FileInfo.Value("directory")
		    If IsDirectory Then
		      Filename = Filename + "/"
		    End If
		    Paths.Add(Filename)
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
		  
		  Var Details As EndpointDetails = Self.GetEndpointDetails(Token)
		  Var BaseUrl As String = Details.BaseUrl
		  Var ListUrl As String = BaseUrl + "/servers"
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", ListUrl, Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Profiles() As Beacon.ServerProfile
		  Var JSON As New JSONItem(Response.Content)
		  Var Servers As JSONItem = JSON.Value("servers")
		  For Idx As Integer = 0 To Servers.LastRowIndex
		    Var ServerJSON As JSONItem = Servers.ValueAt(Idx)
		    If ServerJSON Is Nil Or ServerJSON.HasKey("game") = False Then
		      Continue
		    End If
		    
		    Var GameJSON As JSONItem = ServerJSON.Value("game")
		    If GameJSON Is Nil Or GameJSON.Value("id") <> GameId Then
		      Continue
		    End If
		    
		    Var ServerId As String = ServerJSON.Value("serverId")
		    Var ServerName As String = ServerJSON.Value("name")
		    Var Nickname As String = ServerJSON.Lookup("nickname", "")
		    Var Platform As Integer = ServerJSON.Lookup("platform", Beacon.PlatformUnknown)
		    
		    Var SecondaryName As String
		    If ServerJSON.HasKey("ipAddress") And ServerJSON.HasKey("port") Then
		      SecondaryName = ServerJSON.Value("ipAddress").StringValue + ":" + ServerJSON.Value("port").IntegerValue.ToString(Locale.Raw, "0")
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
		    
		    Var Holder As New Beacon.LockHolder(mDetailsLock)
		    #Pragma Unused Holder
		    mEndpointDetails.Value(Profile.ProfileId) = Details
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

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As Ark.Project, Profile As Ark.ServerProfile)
		  // Part of the Ark.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse
		  Var RetriesRemaining As Integer = 3
		  Do
		    Response = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId), Token))
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
		  
		  Var Game As JSONItem = JSON.Value("game")
		  Var Map As String = Game.Value("map")
		  Profile.Mask = Ark.Maps.MaskForIdentifier(Map)
		  
		  If JSON.HasKey("ipAddress") And JSON.HasKey("port") Then
		    Profile.SecondaryName = JSON.Value("ipAddress").StringValue + ":" + JSON.Value("port").IntegerValue.ToString(Locale.Raw, "0")
		  End If
		  
		  Profile.GameIniPath = Ark.ConfigFileGame
		  Profile.GameUserSettingsIniPath = Ark.ConfigFileGameUserSettings
		  
		  If JSON.HasKey("configPaths") Then
		    Var ConfigPaths As JSONItem = JSON.Value("configPaths")
		    If ConfigPaths.HasKey(Ark.ConfigFileGame) Then
		      Profile.GameIniPath = ConfigPaths.Value(Ark.ConfigFileGame)
		    End If
		    If ConfigPaths.HasKey(Ark.ConfigFileGameUserSettings) Then
		      Profile.GameUserSettingsIniPath = ConfigPaths.Value(Ark.ConfigFileGameUserSettings)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As ArkSA.Project, Profile As ArkSA.ServerProfile)
		  // Part of the ArkSA.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse
		  Var RetriesRemaining As Integer = 3
		  Do
		    Response = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId), Token))
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
		  
		  Var Game As JSONItem = JSON.Value("game")
		  Var Map As String = Game.Value("map")
		  Profile.Mask = ArkSA.Maps.MaskForIdentifier(Map)
		  
		  If JSON.HasKey("ipAddress") And JSON.HasKey("port") Then
		    Profile.SecondaryName = JSON.Value("ipAddress").StringValue + ":" + JSON.Value("port").IntegerValue.ToString(Locale.Raw, "0")
		  End If
		  
		  Profile.GameIniPath = ArkSA.ConfigFileGame
		  Profile.GameUserSettingsIniPath = ArkSA.ConfigFileGameUserSettings
		  
		  If JSON.HasKey("configPaths") Then
		    Var ConfigPaths As JSONItem = JSON.Value("configPaths")
		    If ConfigPaths.HasKey(ArkSA.ConfigFileGame) Then
		      Profile.GameIniPath = ConfigPaths.Value(ArkSA.ConfigFileGame)
		    End If
		    If ConfigPaths.HasKey(ArkSA.ConfigFileGameUserSettings) Then
		      Profile.GameUserSettingsIniPath = ConfigPaths.Value(ArkSA.ConfigFileGameUserSettings)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As Palworld.Project, Profile As Palworld.ServerProfile)
		  // Part of the Palworld.HostingProvider interface.
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Response As BeaconHostingAPI.APIResponse
		  Var RetriesRemaining As Integer = 3
		  Do
		    Response = Self.RunRequest(New BeaconHostingAPI.APIRequest("GET", Self.BuildUrl(Profile, Token, "/servers/" + ServerId), Token))
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
		  
		  If JSON.HasKey("ipAddress") And JSON.HasKey("port") Then
		    Profile.SecondaryName = JSON.Value("ipAddress").StringValue + ":" + JSON.Value("port").IntegerValue.ToString(Locale.Raw, "0")
		  End If
		  
		  Profile.SettingsIniPath = Palworld.ConfigFileSettings
		  
		  If JSON.HasKey("configPaths") Then
		    Var ConfigPaths As JSONItem = JSON.Value("configPaths")
		    If ConfigPaths.HasKey(Palworld.ConfigFileSettings) Then
		      Profile.SettingsIniPath = ConfigPaths.Value(Palworld.ConfigFileSettings)
		    End If
		  End If
		End Sub
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
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("logMessage") = "Started by Beacon"
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("POST", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/start"), Token, "application/json", Body.ToString))
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
		  
		  Var Body As New JSONItem("{}")
		  Body.Value("logMessage") = "Stopped by Beacon"
		  Body.Value("announceMessage") = StopMessage
		  
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("POST", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/stop"), Token, "application/json", Body.ToString))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
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
		  
		  Var ServerId As String
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServerId, Token)
		  
		  Var Path As String = Self.CleanupPath(Transfer.Path)
		  Var Response As BeaconHostingAPI.APIResponse = Self.RunRequest(New BeaconHostingAPI.APIRequest("PUT", Self.BuildUrl(Profile, Token, "/servers/" + ServerId + "/files/" + Path), Token, "application/octet-stream", Transfer.Content))
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
