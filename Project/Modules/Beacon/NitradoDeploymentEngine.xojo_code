#tag Class
Protected Class NitradoDeploymentEngine
Inherits Beacon.TaskQueue
Implements Beacon.DeploymentEngine
	#tag Event
		Sub Finished()
		  Self.ClearTasks()
		  Self.mFinished = True
		  Self.mErrored = False
		  Self.mStatus = "Finished"
		  RaiseEvent Finished()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function BackupGameIni() As String
		  Return Self.mGameIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupGameUserSettingsIni() As String
		  Return Self.mGameUserSettingsIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Begin(Label As String, CommandLineOptions() As Beacon.ConfigValue, GameIniDict As Dictionary, GameUserSettingsIniDict As Dictionary)
		  Self.mLabel = Label
		  Self.mCommandLineOptions = CommandLineOptions
		  Self.mGameIniDict = GameIniDict
		  Self.mGameUserSettingsIniDict = GameUserSettingsIniDict
		  
		  Dim SessionSettingsValues() As String = Array("SessionName=" + Self.mServerName)
		  Dim SessionSettings As New Dictionary
		  SessionSettings.Value("SessionName") = SessionSettingsValues
		  Self.mGameUserSettingsIniDict.Value("SessionSettings") = SessionSettings
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not download Game.ini."
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadGameIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni_Content(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Self.mGameIniOriginal = Content
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not download GameUserSettings.ini."
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadGameUserSettingsIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni_Content(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Self.mGameUserSettingsIniOriginal = Content
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadLogFile(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  // If the log file cannot be downloaded for any reason, assume a stop time of now
		  
		  If Self.CheckError(Status) Then
		    Self.mServerStopTime = New Date
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mServerStopTime = New Date
		      Self.RunNextTask()
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadLogFile_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.mServerStopTime = New Date
		    Self.RunNextTask()
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadLogFile_Content(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  If Self.CheckError(Status) Then
		    Self.mServerStopTime = New Date
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Try
		    Dim Lines() As String = ReplaceLineEndings(Content, &u0A).Split(&u0A)
		    Dim TimestampFound As Boolean
		    For I As Integer = Lines.Ubound DownTo 0
		      Dim Line As String = Lines(I)
		      If Line.IndexOf("Log file closed") = -1 Then
		        Continue
		      End If
		      
		      Dim Year As Integer = Val(Line.Mid(1, 4))
		      Dim Month As Integer = Val(Line.Mid(6, 2))
		      Dim Day As Integer = Val(Line.Mid(9, 2))
		      Dim Hour As Integer = Val(Line.Mid(12, 2))
		      Dim Minute As Integer = Val(Line.Mid(15, 2))
		      Dim Second As Integer = Val(Line.Mid(18, 2))
		      Dim Nanosecond As Integer = (Val(Line.Mid(21, 3)) / 1000) * 1000000000
		      
		      Self.mServerStopTime = New Date(Year, Month, Day, Hour, Minute, Second, 0)
		      TimestampFound = True
		      Exit For I
		    Next
		    
		    If Not TimestampFound Then
		      Self.mServerStopTime = New Date
		    End If
		  Catch Err As RuntimeException
		    Self.mServerStopTime = New Date
		  End Try
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_EnableExpertMode(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not enable expert mode."
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_MakeConfigBackup(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not backup current settings."
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStart(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Nitrado refused to start the server."
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStatus(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    Dim Data As Dictionary = Response.Value("data")
		    Dim GameServer As Dictionary = Data.Value("gameserver")
		    
		    Self.mServerStatus = GameServer.Value("status")
		    Select Case Self.mServerStatus
		    Case "started"
		      // Stop
		      Self.mStartOnFinish = True
		      Self.StopServer()
		    Case "starting"
		      // Wait
		      Self.mStartOnFinish = True
		      Self.mWatchForStatusStopCallbackKey = CallLater.Schedule(5000, AddressOf WatchStatusForStop)
		    Case "stopping"
		      // Wait
		      Self.mWatchForStatusStopCallbackKey = CallLater.Schedule(5000, AddressOf WatchStatusForStop)
		    Case "stopped"
		      // Ok to continue
		      Dim Settings As Dictionary = GameServer.Value("settings")
		      Dim GeneralSettings As Dictionary = Settings.Value("general")
		      Self.mExpertMode = GeneralSettings.Value("expertMode") = "true"
		      
		      Dim StartParams As Dictionary = Settings.Value("start-param")
		      For Each ConfigValue As Beacon.ConfigValue In Self.mCommandLineOptions
		        Dim Key As String = ConfigValue.Key
		        Dim Value As String = ConfigValue.Value
		        
		        If Not StartParams.HasKey(Key) Then
		          Continue
		        End If
		        
		        If StartParams.Value(Key) <> Value Then
		          Self.mCommandLineChanges.Append(ConfigValue)
		        End If
		      Next
		      
		      If Self.mCommandLineChanges.Ubound = -1 And Self.mGameIniDict.Count = 0 And Self.mGameUserSettingsIniDict.Count = 0 Then
		        // Nothing to do
		        Self.mStatus = "Finished, no changes were necessary."
		        Self.mFinished = True
		        Return
		      End If
		      
		      Dim GameSpecific As Dictionary = GameServer.Value("game_specific")
		      Self.mLogFilePath = GameSpecific.Value("path") + "ShooterGame/Saved/Logs/ShooterGame.log"
		      Self.mConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		      
		      Self.RunNextTask()
		    Else
		      Self.mErrored = True
		      Self.mStatus = "Unexpected server status: " + Self.mServerStatus
		      Self.mFinished = True
		      Return
		    End Select
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStop(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Nitrado refused to stop the server."
		      Return
		    End If
		    
		    Self.WatchStatusForStop()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_SetNextCommandLineParam(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Unable to change command line parameter."
		      Return
		    End If
		    
		    Self.mCommandLineChanges.Remove(0)
		    Self.SetNextCommandLineParam()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameIni(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not get permission to upload Game.ini."
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    Dim Token As String = TokenDict.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    Headers.Value("token") = Token
		    
		    Dim NewContent As String = Beacon.RewriteIniContent(Self.mGameIniOriginal, Self.mGameIniDict)
		    
		    SimpleHTTP.Post(TokenDict.Value("url"), "text/plain", NewContent, AddressOf Callback_UploadGameIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameIni_Content(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Content
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  If Status < 400 Then
		    Self.RunNextTask()
		  Else
		    Self.mErrored = True
		    Self.mStatus = "Error: Could not upload Game.ini, server said " + Status.ToText
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not get permission to upload GameUserSettings.ini."
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    Dim Token As String = TokenDict.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    Headers.Value("token") = Token
		    
		    Dim NewContent As String = Beacon.RewriteIniContent(Self.mGameUserSettingsIniOriginal, Self.mGameUserSettingsIniDict)
		    
		    SimpleHTTP.Post(TokenDict.Value("url"), "text/plain", NewContent, AddressOf Callback_UploadGameUserSettingsIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni_Content(URL As String, Status As Integer, Content As String, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Content
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  If Status < 400 Then
		    Self.RunNextTask()
		  Else
		    Self.mErrored = True
		    Self.mStatus = "Error: Could not upload GameUserSettings.ini, server said " + Status.ToText
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  CallLater.Cancel(Self.mWaitNitradoCallbackKey)
		  CallLater.Cancel(Self.mWatchForStatusStopCallbackKey)
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(HTTPStatus As Integer) As Boolean
		  Select Case HTTPStatus
		  Case 401
		    Self.mStatus = "Error: Authorization failed."
		  Case 429
		    Self.mStatus = "Error: Rate limit has been exceeded."
		  Case 503
		    Self.mStatus = "Error: Nitrado is offline for maintenance."
		  Else
		    Self.mErrored = False
		    Return False
		  End Select
		  
		  Self.mErrored = True
		  Self.mFinished = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ServerName As String, ServiceID As Integer, OAuthData As Dictionary)
		  Self.mServerName = ServerName
		  Self.mServiceID = ServiceID
		  Self.mAccessToken = OAuthData.Value("Access Token")
		  
		  Self.AppendTask(AddressOf WatchStatusForStop, AddressOf DownloadLogFile, AddressOf WaitNitradoIdle, AddressOf MakeConfigBackup, AddressOf EnableExpertMode, AddressOf SetNextCommandLineParam, AddressOf DownloadGameIni, AddressOf DownloadGameUserSettingsIni, AddressOf UploadGameIni, AddressOf UploadGameUserSettingsIni, AddressOf StartServer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  If Self.mGameIniDict.Count = 0 Then
		    // Skip
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Downloading Game.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As String = Self.mConfigPath + "/Game.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/file_server/download?file=" + Beacon.URLEncode(FilePath), AddressOf Callback_DownloadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  If Self.mGameUserSettingsIniDict.Count = 0 Then
		    // Skip
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Downloading GameUserSettings.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As String = Self.mConfigPath + "/GameUserSettings.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/file_server/download?file=" + Beacon.URLEncode(FilePath), AddressOf Callback_DownloadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadLogFile()
		  Self.mStatus = "Downloading Log File…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/file_server/download?file=" + Beacon.URLEncode(Self.mLogFilePath), AddressOf Callback_DownloadLogFile, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EnableExpertMode()
		  If Self.mExpertMode Then
		    // Nothing to disable
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Enabling expert mode…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("category") = "general"
		  FormData.Value("key") = "expertMode"
		  FormData.Value("value") = "true"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/settings", FormData, AddressOf Callback_EnableExpertMode, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeConfigBackup()
		  Self.mStatus = "Making config backup…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("name") = "Beacon " + Self.mLabel
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/settings/sets", FormData, AddressOf Callback_MakeConfigBackup, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mServerName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerIsStarting() As Boolean
		  Return Self.mStartOnFinish
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Err As RuntimeException)
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Dim Reason As String
		  If Err.Reason <> "" Then
		    Reason = Err.Reason
		  ElseIf Err.Message <> "" Then
		    Reason = Err.Message
		  Else
		    Reason = "No details available"
		  End If
		  
		  Self.mStatus = "Error: Unhandled " + Info.FullName + ": '" + Reason + "'"
		  Self.mErrored = True
		  Self.mFinished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetNextCommandLineParam()
		  If Self.mCommandLineChanges.Ubound = -1 Then
		    // Move on
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Setting command line parameters…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("category") = "start-param"
		  FormData.Value("key") = Self.mCommandLineChanges(0).Key
		  FormData.Value("value") = Self.mCommandLineChanges(0).Value
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/settings", FormData, AddressOf Callback_SetNextCommandLineParam, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartServer()
		  If Not Self.mStartOnFinish Then
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Starting server…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon (https://beaconapp.cc)"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/restart", FormData, AddressOf Callback_ServerStart, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StopServer()
		  Self.mStatus = "Stopping server…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("message") = "Server is being updated by Beacon (https://beaconapp.cc)"
		  FormData.Value("stop_message") = "Server is now stopping for a few minutes for changes."
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/stop", FormData, AddressOf Callback_ServerStop, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameIni()
		  If Self.mGameIniDict.Count = 0 Then
		    // Skip
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Uploading Game.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim Fields As New Dictionary
		  Fields.Value("path") = Self.mConfigPath
		  Fields.Value("file") = "Game.ini"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/file_server/upload", Fields, AddressOf Callback_UploadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameUserSettingsIni()
		  If Self.mGameUserSettingsIniDict.Count = 0 Then
		    // Skip
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Uploading GameUserSettings.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim Fields As New Dictionary
		  Fields.Value("path") = Self.mConfigPath
		  Fields.Value("file") = "GameUserSettings.ini"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers/file_server/upload", Fields, AddressOf Callback_UploadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WaitNitradoIdle()
		  Dim Now As New Date
		  Dim SecondsToWait As Double = Val(Beacon.Data.GetTextVariable("Nitrado Wait Seconds"))
		  SecondsToWait = SecondsToWait - (Now.SecondsFrom1970 - Self.mServerStopTime.SecondsFrom1970)
		  If SecondsToWait < 10 Then // Don't need to be THAT precise
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Dim ResumeTime As New Date(Now)
		  ResumeTime.SecondsFrom1970 = ResumeTime.SecondsFrom1970 + SecondsToWait
		  
		  Self.mStatus = "Waiting per Nitrado recommendations. Will resume at " + ResumeTime.LongTime + "…"
		  Self.mWaitNitradoCallbackKey = CallLater.Schedule(SecondsToWait * 1000, AddressOf WaitNitradoIdle)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WatchStatusForStop()
		  If Self.mServerStatus = "" Then
		    Self.mStatus = "Getting server status…"
		  Else
		    Self.mStatus = "Stopping server…"
		  End If
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Str(Self.mServiceID, "-0") + "/gameservers", AddressOf Callback_ServerStatus, Nil, Headers)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommandLineChanges() As Beacon.ConfigValue
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommandLineOptions() As Beacon.ConfigValue
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpertMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogFilePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerStatus As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerStopTime As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceID As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartOnFinish As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWaitNitradoCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWatchForStatusStopCallbackKey As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
