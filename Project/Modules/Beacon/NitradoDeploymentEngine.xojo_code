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
		Sub Begin(Label As String, Document As Beacon.Document, Identity As Beacon.Identity)
		  Self.mLabel = Label
		  Self.mDocument = Document
		  Self.mIdentity = Identity
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As String = Content
		    Self.mGameIniOriginal = TextContent
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Self.mGameUserSettingsIniOriginal = Content
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadLogFile(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  // If the log file cannot be downloaded for any reason, assume a stop time of now
		  
		  If Self.CheckError(Status) Then
		    Self.mServerStopTime = DateTime.Now
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mServerStopTime = DateTime.Now
		      Self.RunNextTask()
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadLogFile_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.mServerStopTime = DateTime.Now
		    Self.RunNextTask()
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadLogFile_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  If Self.CheckError(Status) Then
		    Self.mServerStopTime = DateTime.Now
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Try
		    Dim EOL As String = Encodings.ASCII.Chr(10)
		    Dim Lines() As String = ReplaceLineEndings(Content, EOL).Split(EOL)
		    Dim TimestampFound As Boolean
		    For I As Integer = Lines.LastRowIndex DownTo 0
		      Dim Line As String = Lines(I)
		      If Line.IndexOf("Log file closed") = -1 Then
		        Continue
		      End If
		      
		      Dim Year As Integer = Val(Line.Middle(1, 4))
		      Dim Month As Integer = Val(Line.Middle(6, 2))
		      Dim Day As Integer = Val(Line.Middle(9, 2))
		      Dim Hour As Integer = Val(Line.Middle(12, 2))
		      Dim Minute As Integer = Val(Line.Middle(15, 2))
		      Dim Second As Integer = Val(Line.Middle(18, 2))
		      Dim Nanosecond As Integer = (Val(Line.Middle(21, 3)) / 1000) * 1000000000
		      
		      Self.mServerStopTime = New DateTime(Year, Month, Day, Hour, Minute, Second, Nanosecond, New TimeZone(0))
		      TimestampFound = True
		      Exit For I
		    Next
		    
		    If Not TimestampFound Then
		      Self.mServerStopTime = DateTime.Now
		    End If
		  Catch Err As RuntimeException
		    Self.mServerStopTime = DateTime.Now
		  End Try
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_EnableExpertMode(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    
		    Self.mExpertMode = True
		    Self.RunNextTask()
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_MakeConfigBackup(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStart(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    
		    If Not Self.mExpertMode Then
		      Self.mWatchForStatusStopCallbackKey = CallLater.Schedule(10000, AddressOf WatchStatusForStop)
		    Else
		      Self.RunNextTask()
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStatus(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    Dim Data As Dictionary = Response.Value("data")
		    Dim GameServer As Dictionary = Data.Value("gameserver")
		    
		    If Self.mMask = 0 Then
		      Dim Settings As Dictionary = GameServer.Value("settings")
		      Dim Config As Dictionary = Settings.Value("config")
		      Dim MapText As String = Config.Value("map")
		      Dim MapParts() As String = MapText.Split(",")
		      Self.mMask = Beacon.Maps.MaskForIdentifier(MapParts(MapParts.LastRowIndex))
		    End If
		    
		    Self.mServerStatus = GameServer.Value("status")
		    If Self.mInitialServerStatus = "" Then
		      Self.mInitialServerStatus = Self.mServerStatus
		    End If
		    Select Case Self.mServerStatus
		    Case "started"
		      // Stop
		      Self.mWatchForStatusStopCallbackKey = CallLater.Schedule(5000, AddressOf StopServer)
		    Case "starting", "restarting", "stopping"
		      // Wait
		      Self.mWatchForStatusStopCallbackKey = CallLater.Schedule(5000, AddressOf WatchStatusForStop)
		    Case "stopped"
		      // Ok to continue... maybe
		      Dim Settings As Dictionary = GameServer.Value("settings")
		      Dim GeneralSettings As Dictionary = Settings.Value("general")
		      Self.mExpertMode = GeneralSettings.Value("expertMode") = "true"
		      
		      If Self.mDidRebuildStart = False And Self.mExpertMode = False Then
		        // Since the server is not in expert mode, issue a start to rebuild the ini, just in case
		        Self.mDidRebuildStart = True
		        Self.StartServer(True)
		        Return
		      End If
		      
		      Dim Groups() As Beacon.ConfigGroup = Self.mDocument.ImplementedConfigs
		      Dim CommandLineOptions() As Beacon.ConfigValue
		      For Each Group As Beacon.ConfigGroup In Groups
		        If Group.ConfigName = BeaconConfigs.CustomContent.ConfigName Then
		          Continue
		        End If
		        
		        Dim Options() As Beacon.ConfigValue = Group.CommandLineOptions(Self.mDocument, Self.mIdentity, Self.mProfile)
		        For Each Option As Beacon.ConfigValue In Options
		          CommandLineOptions.Append(Option)
		        Next
		      Next
		      
		      Dim StartParams As Dictionary = Settings.Value("start-param")
		      For Each ConfigValue As Beacon.ConfigValue In CommandLineOptions
		        Dim Key As String = ConfigValue.Key
		        Dim Value As String = ConfigValue.Value
		        
		        If Not StartParams.HasKey(Key) Then
		          Continue
		        End If
		        
		        If StartParams.Value(Key) <> Value Then
		          Self.mCommandLineChanges.Append(ConfigValue)
		        End If
		      Next
		      
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
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStop(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_SetNextCommandLineParam(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameIni(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    
		    SimpleHTTP.Post(TokenDict.Value("url"), "text/plain", Self.mGameIniRewritten, AddressOf Callback_UploadGameIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameIni_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    Self.mStatus = "Error: Could not upload Game.ini, server said " + Status.ToString
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    
		    SimpleHTTP.Post(TokenDict.Value("url"), "text/plain", Self.mGameUserSettingsIniRewritten, AddressOf Callback_UploadGameUserSettingsIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
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
		    Self.mStatus = "Error: Could not upload GameUserSettings.ini, server said " + Status.ToString
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
		Sub Constructor(Profile As Beacon.NitradoServerProfile, OAuthData As Dictionary)
		  Self.mProfile = Profile
		  Self.mAccessToken = OAuthData.Value("Access Token")
		  
		  Self.mGameIniRewriter = New Beacon.Rewriter
		  AddHandler mGameIniRewriter.Finished, WeakAddressOf mGameIniRewriter_Finished
		  
		  Self.mGameUserSettingsIniRewriter = New Beacon.Rewriter
		  AddHandler mGameUserSettingsIniRewriter.Finished, WeakAddressOf mGameUserSettingsIniRewriter_Finished
		  
		  Self.AppendTask(AddressOf WatchStatusForStop, AddressOf DownloadLogFile, AddressOf WaitNitradoIdle, AddressOf MakeConfigBackup, AddressOf EnableExpertMode, AddressOf SetNextCommandLineParam, AddressOf DownloadGameIni, AddressOf DownloadGameUserSettingsIni, AddressOf GenerateGameIni, AddressOf GenerateGameUserSettingsIni, AddressOf UploadGameIni, AddressOf UploadGameUserSettingsIni, AddressOf StartServerIfNeeded)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  Self.mStatus = "Downloading Game.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As String = Self.mConfigPath + "/Game.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString() + "/gameservers/file_server/download?file=" + EncodeURLComponent(FilePath), AddressOf Callback_DownloadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  Self.mStatus = "Downloading GameUserSettings.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As String = Self.mConfigPath + "/GameUserSettings.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString() + "/gameservers/file_server/download?file=" + EncodeURLComponent(FilePath), AddressOf Callback_DownloadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadLogFile()
		  Self.mStatus = "Downloading Log File…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/file_server/download?file=" + EncodeURLComponent(Self.mLogFilePath), AddressOf Callback_DownloadLogFile, Nil, Headers)
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
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/settings", FormData, AddressOf Callback_EnableExpertMode, Nil, Headers)
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
		Private Sub GenerateGameIni()
		  Self.mStatus = "Generating Game.ini…"
		  Self.mGameIniRewriter.Rewrite(Self.mGameIniOriginal, Beacon.RewriteModeGameIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GenerateGameUserSettingsIni()
		  Self.mStatus = "Generating GameUserSettings.ini…"
		  Self.mGameUserSettingsIniRewriter.Rewrite(Self.mGameUserSettingsIniOriginal, Beacon.RewriteModeGameUserSettingsIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeConfigBackup()
		  Self.mStatus = "Making config backup…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("name") = "Beacon " + Self.mLabel
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/settings/sets", FormData, AddressOf Callback_MakeConfigBackup, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mGameIniRewriter_Finished(Sender As Beacon.Rewriter)
		  If Sender.Errored Then
		    Self.mErrored = True
		    Self.mStatus = "Error generating Game.ini"
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.mGameIniRewritten = Sender.UpdatedContent
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mGameUserSettingsIniRewriter_Finished(Sender As Beacon.Rewriter)
		  If Sender.Errored Then
		    Self.mErrored = True
		    Self.mStatus = "Error generating GameUserSettings.ini"
		    Self.mFinished = True
		    Return
		  End If
		  
		  Self.mGameUserSettingsIniRewritten = Sender.UpdatedContent
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerIsStarting() As Boolean
		  Return Self.mInitialServerStatus = "started" Or Self.mInitialServerStatus = "starting"
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
		  If Self.mCommandLineChanges.LastRowIndex = -1 Then
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
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/settings", FormData, AddressOf Callback_SetNextCommandLineParam, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartServer(Force As Boolean)
		  If Force = False And Not Self.ServerIsStarting Then
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Starting server…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon (https://beaconapp.cc)"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/restart", FormData, AddressOf Callback_ServerStart, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartServerIfNeeded()
		  Self.StartServer(False)
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
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/stop", FormData, AddressOf Callback_ServerStop, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameIni()
		  Self.mStatus = "Uploading Game.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim Fields As New Dictionary
		  Fields.Value("path") = Self.mConfigPath
		  Fields.Value("file") = "Game.ini"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/file_server/upload", Fields, AddressOf Callback_UploadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameUserSettingsIni()
		  Self.mStatus = "Uploading GameUserSettings.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim Fields As New Dictionary
		  Fields.Value("path") = Self.mConfigPath
		  Fields.Value("file") = "GameUserSettings.ini"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/file_server/upload", Fields, AddressOf Callback_UploadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WaitNitradoIdle()
		  Dim Now As DateTime = DateTime.Now
		  Dim SecondsToWait As Double = Double.FromString(Beacon.Data.GetStringVariable("Nitrado Wait Seconds"))
		  SecondsToWait = SecondsToWait - (Now.SecondsFrom1970 - Self.mServerStopTime.SecondsFrom1970)
		  If SecondsToWait < 10 Then // Don't need to be THAT precise
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Dim ResumeTime As DateTime = Now + New DateInterval(0, 0, 0, 0, 0, Floor(SecondsToWait), (SecondsToWait - Floor(SecondsToWait)) * 1000000000)
		  
		  Self.mStatus = "Waiting per Nitrado recommendations. Will resume at " + ResumeTime.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Medium) + "…"
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
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers", AddressOf Callback_ServerStatus, Nil, Headers)
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
		Private mConfigPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDidRebuildStart As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
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
		Private mGameIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewritten As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniRewritten As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasBeenStartedRecently As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialServerStatus As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogFilePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.NitradoServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerStatus As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerStopTime As DateTime
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
