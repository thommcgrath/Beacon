#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Constructor(Logger As Beacon.LogProducer = Nil)
		  If Logger Is Nil Then
		    Self.mLogger = New Beacon.DummyLogProducer
		  Else
		    Self.mLogger = Logger
		  End If
		  
		  Self.mServerDetailCache = New Dictionary
		  
		  #if Self.UseSingleConnection
		    Self.mDedicatedSocket = New SimpleHTTP.SynchronousHTTPSocket
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateCheckpoint(Project As Beacon.Project, Profile As Beacon.ServerProfile, Name As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var FormData As New Dictionary
		  FormData.Value("name") = "Beacon " + Name
		  
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("POST", "https://api.nitrado.net/services/" + ServiceID.ToString(Locale.Raw, "0") + "/gameservers/settings/sets", Token, "application/x-www-form-urlencoded", SimpleHTTP.BuildFormData(FormData)))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("GET", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/download?file=" + EncodeURLComponent(Transfer.Path), Token))
		  If Not Response.Success Then
		    Select Case FailureMode
		    Case Beacon.Integration.DownloadFailureMode.MissingAllowed
		      Var Status As Integer = Response.HTTPStatus
		      If Status = 500 And Response.Message.Contains("File doesn't exist") Then
		        // Nitrado reports a 404 as a 500
		        Status = 404
		      End If
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
		  
		  Var SizeResponse As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("GET", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/size?path=" + EncodeURLComponent(Transfer.Path), Token))
		  If Not SizeResponse.Success Then
		    If FailureMode <> Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		      Raise SizeResponse.Error
		    End If
		    Return
		  End If
		  
		  Var RequiredFileSize As Integer
		  Try
		    Var Parsed As New JSONItem(SizeResponse.Content)
		    RequiredFileSize = Parsed.Child("data").Value("size")
		  Catch Err As RuntimeException
		    Transfer.Content = ""
		    If FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      App.LogAPIException(Err, CurrentMethodName, SizeResponse.Url, SizeResponse.HTTPStatus, SizeResponse.Content)
		      Transfer.SetError(Err.Message)
		    End If
		    Return
		  End Try
		  If RequiredFileSize <= 0 Then
		    // Nothing to download
		    Transfer.Content = ""
		    Transfer.Success = True
		    Return
		  End If
		  
		  Var FetchUrl As String
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    If Parsed.Value("status").StringValue <> "success" Then
		      Transfer.Content = ""
		      If FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		        Transfer.Success = True
		      Else
		        Transfer.SetError(Parsed.Value("message").StringValue)
		      End If
		      Return
		    End If
		    
		    FetchUrl = Parsed.Child("data").Child("token").Value("url")
		  Catch Err As RuntimeException
		    Transfer.Content = ""
		    If FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      App.LogAPIException(Err, CurrentMethodName, SizeResponse.Url, SizeResponse.HTTPStatus, SizeResponse.Content)
		      Transfer.SetError(Err.Message)
		    End If
		    Return
		  End Try
		  
		  Var FetchResponse As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("GET", FetchUrl, Token))
		  If Not FetchResponse.Success Then
		    Transfer.Content = ""
		    If FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      Transfer.SetError(FetchResponse.Error.Message)
		    End If
		    Return
		  End If
		  
		  Var Content As String = FetchResponse.Content
		  Var ContentSize As Integer = Content.Bytes
		  If ContentSize = RequiredFileSize Or FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		    Transfer.Success = True
		    Transfer.Content = Content
		  Else
		    Transfer.SetError("Nitrado returned " + Beacon.BytesToString(ContentSize) + " but told Beacon to expect " + Beacon.BytesToString(RequiredFileSize) + ".")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameSetting(Project As Beacon.Project, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting) As Variant
		  If Setting Is Nil Or Setting.HasNitradoEquivalent = False Then
		    Return Nil
		  End If
		  
		  Var Paths() As String = Setting.NitradoPaths
		  If Paths.Count = 0 Then
		    Return Nil
		  End If
		  
		  If Self.mServerDetailCache.HasKey(Profile.ProfileId) = False Then
		    Call Self.GetServerStatus(Project, Profile)
		  End If
		  
		  // Look through each path in order until we find a match
		  Var GameServer As JSONItem = Self.mServerDetailCache.Value(Profile.ProfileId)
		  For Each Path As String In Paths
		    Var Found As Boolean
		    Var Value As Variant = Self.ValueByDotNotation(GameServer, Path, Found)
		    If Found Then
		      Return Value
		    End If
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameSetting(Project As Beacon.Project, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting, Assigns Value As Variant)
		  If Setting Is Nil Or Setting.HasNitradoEquivalent = False Then
		    Return
		  End If
		  
		  Var Paths() As String = Setting.NitradoPaths
		  If Paths.Count = 0 Then
		    Return
		  End If
		  
		  If Self.mServerDetailCache.HasKey(Profile.ProfileId) = False Then
		    Call Self.GetServerStatus(Project, Profile)
		  End If
		  Var GameServer As JSONItem = Self.mServerDetailCache.Value(Profile.ProfileId)
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  For Each Path As String In Paths
		    Var Found As Boolean
		    Var OldValue As Variant = Self.ValueByDotNotation(GameServer, Path, Found)
		    If Found = False Or Setting.ValuesEqual(OldValue, Value) Then
		      Continue
		    End If
		    
		    Var Parts() As String = Path.Split(".")
		    Var Key As String = Parts(Parts.LastIndex)
		    Parts.RemoveAt(Parts.LastIndex)
		    Var Category As String = String.FromArray(Parts, ".")
		    
		    Var FormData As New Dictionary
		    FormData.Value("category") = Category
		    FormData.Value("key") = Key
		    If Setting.IsBoolean Then
		      FormData.Value("value") = If(Value.IsTruthy, "true", "false") // Nitrado **must** have these in lowercase
		    Else
		      FormData.Value("value") = Value
		    End If
		    Self.mLogger.Log("Updating " + Key + "…")
		    
		    Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("POST", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/settings", Token, "application/x-www-form-urlencoded", SimpleHTTP.BuildFormData(FormData)))
		    If Not Response.Success Then
		      Raise Response.Error
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GetCredentials(Project As Beacon.Project, Profile As Beacon.ServerProfile, ByRef ServiceId As Integer, ByRef Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA Nitrado.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile must have a Nitrado host config object"
		    Raise Err
		  End If
		  
		  ServiceId = Nitrado.HostConfig(Config).ServiceId
		  Token = BeaconAPI.GetProviderToken(Nitrado.HostConfig(Config).TokenId, Project, True)
		  If (Token Is Nil) = False Then
		    If Token.IsEncrypted And (Project Is Nil Or Token.Decrypt(Project.ProviderTokenKey(Token.TokenId)) = False) Then
		      Var Err as New UnsupportedOperationException
		      Err.Message = "Provider token is still encrypted. Ask a project editor to resave."
		      Raise Err
		    End If
		  Else
		    // No such token
		    Var Err as New UnsupportedOperationException
		    Err.Message = "Authorization data for the account was not found. Ask a project editor to resave."
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var Response As Nitrado.APIResponse
		  Var RetriesRemaining As Integer = 5
		  Do
		    Response = Self.RunRequest(New Nitrado.APIRequest("GET", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers", Token))
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
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Var Data As JSONItem = Parsed.Child("data")
		  Var GameServer As JSONItem = Data.Child("gameserver")
		  Var StatusMessage As String = GameServer.Value("status")
		  
		  // Cache the settings dict for use with game settings later
		  Self.mServerDetailCache.Value(Profile.ProfileId) = GameServer
		  
		  Var Status As Beacon.ServerStatus
		  Select Case StatusMessage
		  Case "started"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Running, GameServer)
		  Case "starting", "restarting"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Starting, GameServer)
		  Case "stopping"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopping, GameServer)
		  Case "stopped"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Stopped, GameServer)
		  Case "suspended"
		    Status = New Beacon.ServerStatus("The server is suspended. See your Nitrado control panel to reactivate your server.", GameServer)
		  Case "guardian_locked"
		    Status = New Beacon.ServerStatus("The server is currently guardian locked. Try again during allowed hours.", GameServer)
		  Case "gs_installation"
		    Status = New Beacon.ServerStatus("The server is switching games.", GameServer)
		  Case "backup_restore"
		    Status = New Beacon.ServerStatus("The server is restoring a backup.", GameServer)
		  Case "backup_creation"
		    Status = New Beacon.ServerStatus("The server is creating a backup.", GameServer)
		  Case "updating"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.States.Starting, "The server is currently installing an update.", GameServer)
		  Else
		    Status = New Beacon.ServerStatus("Unknown server status: " + StatusMessage, GameServer)
		  End Select
		  
		  Return Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return Nitrado.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var FormData As New Dictionary
		  If StartingPath.IsEmpty = False Then
		    FormData.Value("dir") = StartingPath
		  End If
		  Var Url As String = "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/list"
		  If FormData.KeyCount > 0 Then
		    Url = Url + "?" + SimpleHTTP.BuildFormData(FormData)
		  End If
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("GET", Url, Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Var Entries As JSONItem = Parsed.Child("data").Child("entries")
		  Var Bound As Integer = Entries.LastRowIndex
		  Var Paths() As String
		  
		  For Idx As Integer = 0 To Bound
		    Var Child As JSONItem = Entries.ChildAt(Idx)
		    Paths.Add(Child.Value("path"))
		  Next
		  
		  Return Paths
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  If (Config IsA Nitrado.HostConfig) = False Then
		    Var Err As UnsupportedOperationException
		    Err.Message = "Config is not a Nitrado host config."
		    Raise Err
		  End If
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Nitrado.HostConfig(Config).TokenId, Nil, True)
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("GET", "https://api.nitrado.net/services", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Profiles() As Beacon.ServerProfile
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Var Data As JSONItem = Parsed.Child("data")
		  Var Services As JSONItem = Data.Child("services")
		  If Services.Count = 0 Then
		    Return Profiles
		  End If
		  
		  Var Bound As Integer = Services.LastRowIndex
		  For Idx As Integer = 0 To Bound
		    Var Service As JSONItem = Services.ChildAt(Idx)
		    If Service.Lookup("type", "").StringValue <> "gameserver" Then
		      Continue
		    End If
		    
		    Var Details As JSONItem = Service.Child("details")
		    Var Portlist As String = Details.Lookup("portlist_short", "")
		    Var ServerGameId As String = Nitrado.HostingProvider.ShortcodeToGameId(Portlist)
		    If ServerGameId <> GameId Then
		      Continue
		    End If
		    Var Platform As Integer = Nitrado.HostingProvider.ShortcodeToPlatform(Portlist)
		    If Platform = Beacon.PlatformUnsupported Then
		      Continue
		    End If
		    
		    Var ServiceId As Integer = Service.Lookup("id", 0)
		    If ServiceId = 0 Then
		      Continue
		    End If
		    Var Address As String = Details.Lookup("address", "")
		    Var Name As String = Details.Lookup("name", "")
		    Var Nickname As String = Service.Lookup("comment", "")
		    If (Name.IsEmpty Or Name.BeginsWith("Gameserver - ")) And Nickname.IsEmpty = False Then
		      Name = Nickname
		    End If
		    Var SecondaryName As String = Address + " (" + ServiceId.ToString(Locale.Raw, "0") + ")"
		    
		    Var ProfileId As String = Beacon.UUID.v5(Self.Identifier + ":" + ServiceId.ToString(Locale.Raw, "0"))
		    
		    Var Profile As Beacon.ServerProfile
		    Select Case GameId
		    Case Ark.Identifier
		      Profile = New Ark.ServerProfile(Self.Identifier, ProfileId, Name, Nickname, SecondaryName)
		    Case SDTD.Identifier
		      Profile = New SDTD.ServerProfile(Self.Identifier, ProfileId, Name, Nickname, SecondaryName)
		    End Select
		    
		    Var ProfileConfig As New Nitrado.HostConfig
		    ProfileConfig.ServiceId = ServiceId
		    ProfileConfig.TokenId = Token.TokenId
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
		  Return Self.mLogger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchesToken(Token As BeaconAPI.ProviderToken) As Boolean
		  Return (Token Is Nil) = False And Token.Provider = BeaconAPI.ProviderToken.ProviderNitrado
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunRequest(Request As Nitrado.APIRequest) As Nitrado.APIResponse
		  Var Headers As Dictionary = Request.Headers
		  Var Content As MemoryBlock = Request.Content
		  Var RequestMethod As String = Request.RequestMethod
		  Var Url As String = Request.Url
		  
		  Var Socket As SimpleHTTP.SynchronousHTTPSocket
		  If Self.UseSingleConnection Then
		    Socket = Self.mDedicatedSocket
		    Socket.ClearRequestHeaders
		  Else
		    Socket = New SimpleHTTP.SynchronousHTTPSocket
		  End If
		  
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
		    System.DebugLog("Nitrado.HostingProvider: " + RequestMethod + " " + Url)
		    Var RequestStartTime As Double = System.Microseconds
		  #endif
		  Socket.Send(RequestMethod, Url, 120)
		  #if DebugBuild
		    Var RequestDuration As Double = (System.Microseconds - RequestStartTime) * 0.001
		    System.DebugLog("HTTP " + Socket.LastHTTPStatus.ToString(Locale.Raw, "0") + " took " + RequestDuration.ToString(Locale.Raw, ",##0.00") + "ms")
		  #endif
		  If Self.UseSingleConnection = False Then
		    Socket.Disconnect
		  End If
		  Self.mActiveSocket = Nil
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		  Return Nitrado.APIResponse.FromSocket(Socket)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShortcodeToGameId(Shortcode As String) As String
		  Select Case Shortcode
		  Case "arkse", "arksotf", "arkps", "arkxb", "arkswitch", "arkswitchjp", "arkseosg", "arkxbosg", "arkpsosg"
		    Return Ark.Identifier
		  Case "7daystodie", "sevendaysexperimental", "sevendtd"
		    Return SDTD.Identifier
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShortcodeToPlatform(Shortcode As String) As Integer
		  Select Case Shortcode
		  Case "arkxb", "arkxbosg"
		    Return Beacon.PlatformXbox
		  Case "arkps", "arkpsosg"
		    Return Beacon.PlatformPlayStation
		  Case "arkswitch", "arkswitchjp"
		    Return Beacon.PlatformSwitch
		  Case "arkse", "arksotf", "arkseosg", "7daystodie", "sevendaysexperimental", "sevendtd"
		    Return Beacon.PlatformPC
		  Case "arkmobile"
		    Return Beacon.PlatformUnsupported
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
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
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon"
		  FormData.Value("restart_message") = Nil
		  
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("POST", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/restart", Token, "application/json", Beacon.GenerateJson(FormData, True)))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon"
		  FormData.Value("stop_message") = StopMessage
		  
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("POST", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/stop", Token, "application/json", Beacon.GenerateJson(FormData, False)))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsGameSettings() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  Return Self.mThrottled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, ServiceId, Token)
		  
		  Var PathComponents() As String = Transfer.Path.Split("/")
		  Var Filename As String = PathComponents(PathComponents.LastIndex)
		  PathComponents.RemoveAt(PathComponents.LastIndex)
		  
		  Var FormData As New Dictionary
		  FormData.Value("path") = String.FromArray(PathComponents, "/")
		  FormData.Value("file") = Filename
		  
		  Var Response As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("POST", "https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/upload", Token, "application/x-www-form-urlencoded", SimpleHTTP.BuildFormData(FormData)))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var PutUrl, PutToken As String
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    Var TokenItem As JSONItem = Parsed.Child("data").Child("token")
		    PutUrl = TokenItem.Value("url")
		    PutToken = TokenItem.Value("token")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Response.Url, Response.HTTPStatus, Response.Content)
		    Transfer.Success = False
		    Transfer.ErrorMessage = Err.Message
		    Return
		  End Try
		  
		  Var Headers As New Dictionary
		  Headers.Value("token") = PutToken
		  Headers.Value("Content-MD5") = EncodeBase64(Crypto.MD5(Transfer.Content))
		  
		  Var PutResponse As Nitrado.APIResponse = Self.RunRequest(New Nitrado.APIRequest("POST", PutUrl, Token, Headers, "application/octet-stream", Transfer.Content))
		  If Not PutResponse.Success Then
		    Response.Error.Message = Response.Error.Message + EndOfLine + "Check your " + Filename + " file on Nitrado. Nitrado may have accepted partial file content. If you have backups enabled, the originals will be saved to " + App.BackupsFolder.Child(Profile.BackupFolderName).NativePath + "."
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ValueByDotNotation(Root As JSONItem, Path As String, ByRef Found As Boolean) As Variant
		  // Paths in the database assume the settings key is root, but there are
		  // values above settings that we need. We can't practically change the paths
		  // in the database, so we'll use / to indicate that we want to start with
		  // the true root
		  If Path.BeginsWith("/") Then
		    Path = Path.Middle(1)
		  Else
		    Path = "settings." + Path
		  End If
		  
		  Var Parts() As String = Path.Split(".")
		  Var Key As String = Parts(Parts.LastIndex)
		  Parts.RemoveAt(Parts.LastIndex)
		  
		  Var Parent As JSONItem = Root
		  For Each Part As String In Parts
		    If Parent.HasKey(Part) = False Then
		      Found = False
		      Return Nil
		    End If
		    
		    Parent = Parent.Child(Part)
		  Next
		  
		  If Parent.HasKey(Key) Then
		    Found = True
		    Return Parent.Value(Key)
		  End If
		  
		  Found = False
		  Return Nil
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mActiveSocket As SimpleHTTP.SynchronousHTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDedicatedSocket As SimpleHTTP.SynchronousHTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogger As Beacon.LogProducer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerDetailCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThrottled As Boolean
	#tag EndProperty


	#tag Constant, Name = UseSingleConnection, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"False"
	#tag EndConstant


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
