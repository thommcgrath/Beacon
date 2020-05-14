#tag Class
Protected Class NitradoIntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Sub Begin()
		  // To make sure we don't spam the user with more authentication requests than necessary, 
		  // we obtain a lock here. This event is threaded, so it is safe
		  
		  Self.Log("Waiting for another authorization…")
		  Self.mAuthLock.Enter
		  Self.Log("Authorizing…", True)
		  If Self.Finished Then
		    Self.mAuthLock.Leave
		    Return
		  End If
		  
		  Self.mAccount = Self.Document.Accounts.GetByUUID(Self.Profile.ExternalAccountUUID)
		  If Self.mAccount = Nil Or Self.mAccount.IsExpired Then
		    Self.Authenticate()
		  End If
		  
		  If (Self.mAccount Is Nil) = False Then
		    // Test that authentication works
		    Var Sock As New HTTPClientSocket
		    Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		    
		    // Odd request, but we're just trying to test validity
		    Call Sock.SendSync("GET", "https://api.nitrado.net/countries/states", Self.ConnectionTimeout)
		    Var Status As Integer = Sock.HTTPStatusCode
		    If Status = 401 Then
		      // A new account is needed
		      Self.Document.Accounts.Remove(Self.mAccount)
		      Self.mAccount = Nil
		      
		      Self.Authenticate()
		    End If
		  End If
		  
		  Self.mAuthLock.Leave
		End Sub
	#tag EndEvent

	#tag Event
		Sub CreateCheckpoint()
		  Var FormData As New Dictionary
		  FormData.Value("name") = "Beacon " + Self.Label
		  
		  Var Sock As New HTTPClientSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Sock.SetFormData(FormData)
		  
		  Var Content As String = Sock.SendSync("POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings/sets", Self.ConnectionTimeout)
		  Var Status As Integer = Sock.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Error: Could not backup current settings.")
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var Servers() As Beacon.DiscoveredData
		  
		  // Get a list of all servers
		  Var Socket As New HTTPClientSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  
		  Self.Log("Finding servers…")
		  Var Content As String = Socket.SendSync("GET", "https://api.nitrado.net/services", Self.ConnectionTimeout)
		  Var Status As Integer = Socket.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return Servers
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    App.LogAPIException(Parsed, CurrentMethodName, Status, Content)
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
		      
		      Var Details As Dictionary = Dict.Value("details")
		      Var GameName As String = Details.Value("game")
		      If GameName.BeginsWith("ARK: Survival Evolved") = False Then
		        Continue
		      End If
		      
		      Var Profile As New Beacon.NitradoServerProfile
		      Profile.ExternalAccountUUID = Self.mAccount.UUID
		      Profile.Name = Details.Value("name")
		      Profile.ServiceID = Dict.Value("id")
		      Profile.Address = Details.Value("address")
		      
		      Var Server As New Beacon.DiscoveredData
		      Server.Profile = Profile
		      
		      Self.Log("Retrieving " + Server.Profile.Name + "…")
		      // Lookup server information
		      Var DetailsSocket As New HTTPClientSocket
		      DetailsSocket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		      App.Log(Profile.ServiceID.ToString(Locale.Raw, "#"))
		      Var DetailsContent As String = DetailsSocket.SendSync("GET", "https://api.nitrado.net/services/" + Profile.ServiceID.ToString(Locale.Raw, "#") + "/gameservers", Self.ConnectionTimeout)
		      Var DetailsStatus As Integer = DetailsSocket.HTTPStatusCode
		      If Self.Finished Or Self.CheckError(DetailsStatus, DetailsContent) Then
		        Continue
		      End If
		      
		      Var DetailsResponse As Dictionary = Beacon.ParseJSON(DetailsContent)
		      Var DetailsData As Dictionary = DetailsResponse.Value("data")
		      Var GameServer As Dictionary = DetailsData.Value("gameserver")
		      Var Settings As Dictionary = GameServer.Value("settings")
		      Var General As Dictionary = Settings.Value("general")
		      Var Config As Dictionary = Settings.Value("config")
		      Var MapText As String = Config.Value("map")
		      Var MapParts() As String = MapText.Split(",")
		      Profile.Mask = Beacon.Maps.MaskForIdentifier(MapParts(MapParts.LastRowIndex))
		      Var GameSpecific As Dictionary = GameServer.Value("game_specific")
		      Profile.ConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		      
		      Server.CommandLineOptions = Settings.Value("start-param")
		      
		      If DebugBuild And General.Lookup("expertMode", False).BooleanValue = False Then
		        // Build our own ini files from known keys
		        Var AllConfigs() As Beacon.ConfigKey = Beacon.Data.SearchForConfigKey("", "", "") // To retrieve all
		        Var GameUserSettingsIniValues(), GameIniValues() As Beacon.ConfigValue
		        For Each ConfigKey As Beacon.ConfigKey In AllConfigs
		          If ConfigKey.HasNitradoEquivalent = False Then
		            Continue
		          End If
		          
		          Var TargetArray() As Beacon.ConfigValue
		          Select Case ConfigKey.File
		          Case "Game.ini"
		            TargetArray = GameIniValues
		          Case "GameUserSettings.ini"
		            TargetArray = GameUserSettingsIniValues
		          Else
		            Continue
		          End Select
		          
		          Var Path As String = ConfigKey.NitradoPath
		          Var Value As String = Self.GetViaDotNotation(Settings, Path).StringValue.ReplaceLineEndings(EndOfLine.UNIX)
		          Select Case ConfigKey.NitradoFormat
		          Case Beacon.ConfigKey.NitradoFormats.Value
		            TargetArray.AddRow(New Beacon.ConfigValue(ConfigKey.Header, ConfigKey.Key, Value))
		          Case Beacon.ConfigKey.NitradoFormats.Line
		            Var Lines() As String = Value.Split(EndOfLine.UNIX)
		            For Each Line As String In Lines
		              Var Pos As Integer = Line.IndexOf("=")
		              If Pos = -1 Then
		                TargetArray.AddRow(New Beacon.ConfigValue(ConfigKey.Header, ConfigKey.Key, Line))
		                Continue
		              End If
		              
		              TargetArray.AddRow(New Beacon.ConfigValue(ConfigKey.Header, Line.Left(Pos), Line.Middle(Pos + 1)))
		            Next
		          End Select
		        Next
		        
		        Var GameIniDict As New Dictionary
		        Beacon.ConfigValue.FillConfigDict(GameIniDict, GameIniValues)
		        
		        Var GameUserSettingsIniDict As New Dictionary
		        Beacon.ConfigValue.FillConfigDict(GameUserSettingsIniDict, GameUserSettingsIniValues)
		        
		        Var Errored As Boolean
		        Var ExtraGameIni As String = Self.GetViaDotNotation(Settings, "append.gameini")
		        Server.GameIniContent = Beacon.Rewriter.Rewrite(ExtraGameIni, GameIniDict, "", Beacon.Rewriter.EncodingFormat.Unicode, Errored)
		        Server.GameUserSettingsIniContent = Beacon.Rewriter.Rewrite("", GameUserSettingsIniDict, "", Beacon.Rewriter.EncodingFormat.Unicode, Errored)
		        Break
		      Else
		        // Download ini files
		        Server.GameIniContent = Self.DownloadFile(Profile.ConfigPath + "/Game.ini", Beacon.NitradoIntegrationEngine.DownloadFailureMode.MissingAllowed, Profile.ServiceID)
		        Server.GameUserSettingsIniContent = Self.DownloadFile(Profile.ConfigPath + "/GameUserSettings.ini", Beacon.NitradoIntegrationEngine.DownloadFailureMode.MissingAllowed, Profile.ServiceID)
		      End If
		      
		      Servers.AddRow(Server)
		    Catch Err As RuntimeException
		      App.LogAPIException(Err, CurrentMethodName, Status, Content)
		      Continue
		    End Try
		  Next
		  
		  Return Servers
		End Function
	#tag EndEvent

	#tag Event
		Function DownloadFile(Filename As String) As String
		  Var Path As String = Beacon.NitradoServerProfile(Self.Profile).ConfigPath + "/" + Filename
		  Return Self.DownloadFile(Path, DownloadFailureMode.MissingAllowed)
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadyToUpload()
		  // Since the process is about to upload, we need to find the log file and determine how long to wait
		  // First we need to look up the current time, since we cannot trust the user's clock
		  Var TimeLookupSocket As New HTTPClientSocket
		  Var TimeString As String = TimeLookupSocket.SendSync("GET", BeaconAPI.URL("/now"), Self.ConnectionTimeout)
		  Var Now As DateTime
		  Try
		    Now = NewDateFromSQLDateTime(TimeString)
		  Catch Err As RuntimeException
		    Now = DateTime.Now
		  End Try
		  
		  Var LogContent As String = Self.DownloadFile(Self.mLogFilePath, DownloadFailureMode.ErrorsAllowed)
		  Var ServerStopTime As DateTime
		  
		  Try
		    Var EOL As String = Encodings.ASCII.Chr(10)
		    Var Lines() As String = LogContent.ReplaceLineEndings(EOL).Split(EOL)
		    Var TimestampFound As Boolean
		    For I As Integer = Lines.LastRowIndex DownTo 0
		      Var Line As String = Lines(I)
		      If Line.IndexOf("Log file closed") = -1 Then
		        Continue
		      End If
		      
		      Var Year As Integer = Val(Line.Middle(1, 4))
		      Var Month As Integer = Val(Line.Middle(6, 2))
		      Var Day As Integer = Val(Line.Middle(9, 2))
		      Var Hour As Integer = Val(Line.Middle(12, 2))
		      Var Minute As Integer = Val(Line.Middle(15, 2))
		      Var Second As Integer = Val(Line.Middle(18, 2))
		      Var Nanosecond As Integer = (Val(Line.Middle(21, 3)) / 1000) * 1000000000
		      
		      ServerStopTime = New DateTime(Year, Month, Day, Hour, Minute, Second, Nanosecond, New TimeZone(0))
		      TimestampFound = True
		      Exit For I
		    Next
		    
		    If Not TimestampFound Then
		      ServerStopTime = Now
		    End If
		  Catch Err As RuntimeException
		    ServerStopTime = Now
		  End Try
		  
		  // Now we can compute how long to wait.
		  Var WaitUntil As DateTime = ServerStopTime + New DateInterval(0, 0, 0, 0, 3, 0)
		  WaitUntil = New DateTime(WaitUntil.SecondsFrom1970, TimeZone.Current)
		  Var Diff As Double = WaitUntil.SecondsFrom1970 - Now.SecondsFrom1970
		  
		  If Diff > 0 Then
		    Self.Log("Waiting until " + WaitUntil.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Medium) + " per Nitrado recommendation…")
		    Self.Wait(Diff * 1000)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshServerStatus()
		  Var Sock As New HTTPClientSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  
		  Var Content As String = Sock.SendSync("GET", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers", Self.ConnectionTimeout)
		  Var Status As Integer = Sock.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    Var Data As Dictionary = Response.Value("data")
		    Var GameServer As Dictionary = Data.Value("gameserver")
		    
		    Select Case GameServer.Value("status")
		    Case "started"
		      Self.State = Self.StateRunning
		    Case "starting", "restarting"
		      Self.State = Self.StateStarting
		    Case "stopping"
		      Self.State = Self.StateStopping
		    Case "stopped"
		      Self.State = Self.StateStopped
		    Case "suspended"
		      Self.State = Self.StateOther
		      Self.SetError("The server is suspended. See your Nitrado control panel to reactivate your server.")
		    Case "guardian_locked"
		      Self.State = Self.StateOther
		      Self.SetError("The server is currently guardian locked. Try again during allowed hours.")
		    Case "gs_installation"
		      Self.State = Self.StateOther
		      Self.SetError("The server is switching games.")
		    Case "backup_restore"
		      Self.State = Self.StateOther
		      Self.SetError("The server is restoring a backup.")
		    Case "backup_creation"
		      Self.State = Self.StateOther
		      Self.SetError("The server is creating a backup.")
		    Else
		      Self.State = Self.StateOther
		      Self.SetError("Unknown server status: " + GameServer.Value("status").StringValue)
		    End Select
		    
		    If Self.mInitialStatusQuery And Self.State <> Self.StateOther Then
		      Self.mInitialStatusQuery = False
		      
		      Var Settings As Dictionary = GameServer.Value("settings")
		      Var GeneralSettings As Dictionary = Settings.Value("general")
		      Var ExpertMode As Boolean = GeneralSettings.Value("expertMode") = "true"
		      
		      If ExpertMode = False And Self.Mode = Self.ModeDeploy Then
		        Var Controller As New Beacon.TaskWaitController("Needs Expert Mode")
		        
		        Self.Log("Waiting for user action…")
		        Self.Wait(Controller)
		        Self.RemoveLastLog()
		        If Controller.Cancelled Then
		          Self.Cancel
		          Return
		        End If
		        
		        // Start the server, returning it to its previous state
		        Self.Log("Enabling expert mode…")
		        Select Case Self.State
		        Case Self.StateStopped, Self.StateStopping
		          Self.Log("Enabling expert mode - starting server…", True)
		          Self.StartServer(False)
		          If Self.Finished Then
		            Return
		          End If
		          Self.Log("Enabling expert mode - stopping server…", True)
		          Self.StopServer(False)
		          If Self.Finished Then
		            Return
		          End If
		        Case Self.StateRunning, Self.StateStarting
		          Self.Log("Enabling expert mode - stopping server…", True)
		          Self.StopServer(False)
		          If Self.Finished Then
		            Return
		          End If
		          Self.Log("Enabling expert mode - starting server…", True)
		          Self.StartServer(False)
		          If Self.Finished Then
		            Return
		          End If
		        End Select
		        
		        // Now actually change the server
		        Var FormData As New Dictionary
		        FormData.Value("category") = "general"
		        FormData.Value("key") = "expertMode"
		        FormData.Value("value") = "true"
		        
		        Var ExpertToggleSocket As New HTTPClientSocket
		        ExpertToggleSocket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		        ExpertToggleSocket.SetFormData(FormData)
		        
		        Self.Log("Enabling expert mode…", True)
		        Var ExpertContent As String = ExpertToggleSocket.SendSync("POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings", Self.ConnectionTimeout)
		        Var ExpertStatus As Integer = ExpertToggleSocket.HTTPStatusCode
		        If Self.Finished Or Self.CheckError(ExpertStatus, ExpertContent) Then
		          Return
		        End If
		        
		        Var ExpertResponse As Dictionary = Beacon.ParseJSON(ExpertContent)
		        If ExpertResponse.Value("status") <> "success" Then
		          Self.SetError("Error: Could not enable expert mode.")
		          Return
		        End If
		        
		        Self.Log("Expert mode enabled.")
		      End If
		      
		      // Determine which map the server is running and update the profile if necessary
		      Var Config As Dictionary = Settings.Value("config")
		      Var MapText As String = Config.Value("map")
		      Var MapParts() As String = MapText.Split(",")
		      Self.Profile.Mask = Beacon.Maps.MaskForIdentifier(MapParts(MapParts.LastRowIndex))
		      
		      // Keep track of the current command line parameters for later
		      Self.mCurrentStartParams = Settings.Value("start-param")
		      
		      // Update the profile with less common changes
		      Var GameSpecific As Dictionary = GameServer.Value("game_specific")
		      Self.mLogFilePath = GameSpecific.Value("path") + "ShooterGame/Saved/Logs/ShooterGame.log"
		      Beacon.NitradoServerProfile(Self.Profile).ConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		      Beacon.NitradoServerProfile(Self.Profile).Address = GameServer.Value("ip") + ":" + GameServer.Value("port")
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetCommandLine(Options() As Beacon.ConfigValue)
		  Var PendingChanges() As Beacon.ConfigValue
		  For Each ConfigValue As Beacon.ConfigValue In Options
		    Var Key As String = ConfigValue.Key
		    Var Value As String = ConfigValue.Value
		    
		    If Not self.mCurrentStartParams.HasKey(Key) Then
		      Continue
		    End If
		    
		    If Self.mCurrentStartParams.Value(Key) <> Value Then
		      PendingChanges.AddRow(ConfigValue)
		    End If
		  Next
		  
		  // To remove the automatic "updating other settings" message
		  Self.RemoveLastLog()
		  
		  If PendingChanges.Count = 0 Then
		    Return
		  End If
		  
		  For Each ConfigValue As Beacon.ConfigValue In PendingChanges
		    Var Sock As New HTTPClientSocket
		    Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		    
		    Var FormData As New Dictionary
		    FormData.Value("category") = "start-param"
		    FormData.Value("key") = ConfigValue.Key
		    FormData.Value("value") = ConfigValue.Value
		    Sock.SetFormData(FormData)
		    
		    Self.Log("Setting '" + ConfigValue.Key + "' to '" + ConfigValue.Value + "'…")
		    Var Content As String = Sock.SendSync("POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings", Self.ConnectionTimeout)
		    Var Status As Integer = Sock.HTTPStatusCode
		    
		    If Self.Finished Or Self.CheckError(Status, Content) Then
		      Return
		    End If
		    
		    Try
		      Var Response As Dictionary = Beacon.ParseJSON(Content)
		      If Response.Value("status") <> "success" Then
		        Self.SetError("Error: Unable to change command line parameter.")
		        Return
		      End If
		    Catch Err As RuntimeException
		      App.LogAPIException(Err, CurrentMethodName, Status, Content)
		      Self.SetError(Err)
		      Return
		    End Try
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub StartServer()
		  Var Sock As New HTTPClientSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon (https://beaconapp.cc)"
		  Sock.SetFormData(FormData)
		  
		  Var Content As String = Sock.SendSync("POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/restart", Self.ConnectionTimeout)
		  Var Status As Integer = Sock.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Error: Nitrado refused to start the server.")
		      #if DebugBuild
		        System.DebugLog("Reason: " + Response.Value("status").StringValue)
		        System.DebugLog(Content)
		      #endif
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		  End Try 
		End Sub
	#tag EndEvent

	#tag Event
		Sub StopServer()
		  Var Sock As New HTTPClientSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server is being stopped by Beacon (https://beaconapp.cc)"
		  FormData.Value("stop_message") = Self.StopMessage
		  Sock.SetFormData(FormData)
		  
		  Var Content As String = Sock.SendSync("POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/stop", Self.ConnectionTimeout)
		  Var Status As Integer = Sock.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.Log("Error: Nitrado refused to stop the server.")
		      #if DebugBuild
		        System.DebugLog("Reason: " + Response.Value("status").StringValue)
		        System.DebugLog(Content)
		      #endif
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Function UploadFile(Contents As String, Filename As String) As Boolean
		  Var Path As String = Beacon.NitradoServerProfile(Self.Profile).ConfigPath + "/" + Filename
		  Self.UploadFile(Path, Contents)
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Authenticate()
		  Var Dict As New Dictionary
		  Dict.Value("Provider") = "Nitrado"
		  
		  Var Controller As New Beacon.TaskWaitController("Auth External", Dict)
		  
		  Self.Log("Waiting for authentication…")
		  Self.Wait(Controller)
		  If Controller.Cancelled Or IsNull(Dict.Value("Account")) Then
		    Self.Cancel
		    Return
		  End If
		  
		  Self.mAccount = Dict.Value("Account")
		  Self.Profile.ExternalAccountUUID = Self.mAccount.UUID
		  Self.Document.Accounts.Add(Self.mAccount)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(HTTPStatus As Integer, HTTPResponse As MemoryBlock) As Boolean
		  Var Message As String
		  If Self.CheckResponseForError(HTTPStatus, HTTPResponse, Message) Then
		    Self.SetError(Message)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckResponseForError(HTTPStatus As Integer, HTTPResponse As MemoryBlock, ByRef Message As String) As Boolean
		  Select Case HTTPStatus
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
		    Try
		      Var Parsed As Variant = Beacon.ParseJSON(HTTPResponse)
		      If Parsed.Type = Variant.TypeObject And Parsed.ObjectValue IsA Dictionary And Dictionary(Parsed.ObjectValue).HasKey("message") Then
		        TempMessage = "Nitrado Error: " + Dictionary(Parsed.ObjectValue).Value("message").StringValue
		      End If
		    Catch Err As RuntimeException
		    End Try
		    If TempMessage <> "" Then
		      Message = TempMessage
		    Else
		      Message = "Error: Nitrado responded with an error but no message."
		    End If
		  Case 0
		    If HTTPResponse <> Nil And HTTPResponse.Size > 0 Then
		      Message = "Connection error: " + HTTPResponse.StringValue(0, HTTPResponse.Size).GuessEncoding
		    Else
		      Message = "Connection error"
		    End If
		  Else
		    Message = ""
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  Super.Constructor(Profile)
		  Self.mInitialStatusQuery = True
		  
		  If Profile IsA Beacon.NitradoServerProfile Then
		    Self.mServiceID = Beacon.NitradoServerProfile(Profile).ServiceID
		  End If
		  
		  If Self.mAuthLock = Nil Then
		    Self.mAuthLock = New CriticalSection
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DownloadFile(Path As String, Mode As Beacon.NitradoIntegrationEngine.DownloadFailureMode) As String
		  Return Self.DownloadFile(Path, Mode, Self.mServiceID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DownloadFile(Path As String, Mode As Beacon.NitradoIntegrationEngine.DownloadFailureMode, ServiceID As Integer) As String
		  Var Sock As New HTTPClientSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  
		  Var Content As String = Sock.SendSync("GET", "https://api.nitrado.net/services/" + ServiceID.ToString(Locale.Raw, "#") + "/gameservers/file_server/download?file=" + EncodeURLComponent(Path), Self.ConnectionTimeout)
		  Var Status As Integer = Sock.HTTPStatusCode
		  
		  If Self.Finished Or (Status <> 200 And Mode = DownloadFailureMode.ErrorsAllowed) Or (Status = 404 And Mode = DownloadFailureMode.MissingAllowed) Or Self.CheckError(Status, Content) Then
		    Return ""
		  End If
		  
		  Var FetchURL As String
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Error: Could not download " + Path + ".")
		      Return ""
		    End If
		    
		    Var Data As Dictionary = Response.Value("data")
		    Var TokenDict As Dictionary = Data.Value("token")
		    FetchURL = TokenDict.Value("url")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return ""
		  End Try
		  
		  Var FetchSocket As New HTTPClientSocket
		  FetchSocket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Content = FetchSocket.SendSync("GET", FetchURL, Self.ConnectionTimeout)
		  Status = FetchSocket.HTTPStatusCode
		  
		  If Self.Finished Or (Status <> 200 And Mode = DownloadFailureMode.ErrorsAllowed) Or (Status = 404 And Mode = DownloadFailureMode.MissingAllowed) Or Self.CheckError(Status, Content) Then
		    Return ""
		  End If
		  
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetViaDotNotation(Dict As Dictionary, Path As String) As Variant
		  Var Pos As Integer = Path.IndexOf(".")
		  Var Key As String
		  If Pos = -1 Then
		    Key = Path
		    Path = ""
		  Else
		    Key = Path.Left(Pos)
		    Path = Path.Middle(Pos + 1)
		  End If
		  
		  If Dict.HasKey(Key) = False Then
		    Return Nil
		  End If
		  
		  Var Value As Variant = Dict.Value(Key)
		  If Path.IsEmpty Or (Value IsA Dictionary) = False Then
		    Return Value
		  End If
		  
		  Return GetViaDotNotation(Dictionary(Value), Path)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadFile(Path As String, FileContent As String)
		  Var Sock As New HTTPClientSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  
		  Var PathParts() As String = Path.Split("/")
		  Var Filename As String = PathParts(PathParts.LastRowIndex)
		  PathParts.RemoveRowAt(PathParts.LastRowIndex)
		  Path = PathParts.Join("/")
		  
		  Var FormData As New Dictionary
		  FormData.Value("path") = Path
		  FormData.Value("file") = Filename
		  Sock.SetFormData(FormData)
		  
		  Var Content As String = Sock.SendSync("POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/file_server/upload", Self.ConnectionTimeout)
		  Var Status As Integer = Sock.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Var PutURL, PutToken As String
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Error: Could not upload " + Path + "/" + Filename + ".")
		      Return
		    End If
		    
		    Var Data As Dictionary = Response.Value("data")
		    Var TokenDict As Dictionary = Data.Value("token")
		    PutURL = TokenDict.Value("url")
		    PutToken = TokenDict.Value("token")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		  
		  Var PutSocket As New HTTPClientSocket
		  PutSocket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  PutSocket.RequestHeader("token") = PutToken
		  PutSocket.SetRequestContent(FileContent, "text/plain")
		  Content = PutSocket.SendSync("POST", PutURL, Self.ConnectionTimeout)
		  Status = PutSocket.HTTPStatusCode
		  
		  If Self.Finished Or Self.CheckError(Status, Content) Then
		    Return
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccount As Beacon.ExternalAccount
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mAuthLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentStartParams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialStatusQuery As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogFilePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceID As Integer
	#tag EndProperty


	#tag Constant, Name = ConnectionTimeout, Type = Double, Dynamic = False, Default = \"30", Scope = Private
	#tag EndConstant


	#tag Enum, Name = DownloadFailureMode, Type = Integer, Flags = &h21
		Required
		  MissingAllowed
		ErrorsAllowed
	#tag EndEnum


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
