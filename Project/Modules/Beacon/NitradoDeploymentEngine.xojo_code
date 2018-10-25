#tag Class
Protected Class NitradoDeploymentEngine
Implements Beacon.DeploymentEngine
	#tag Method, Flags = &h0
		Function BackupGameIni() As Text
		  Return Self.mGameIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupGameUserSettingsIni() As Text
		  Return Self.mGameUserSettingsIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Begin(CommandLineOptions() As Beacon.ConfigValue, GameIniDict As Xojo.Core.Dictionary, GameUserSettingsIniDict As Xojo.Core.Dictionary)
		  Self.mCommandLineOptions = CommandLineOptions
		  Self.mGameIniDict = GameIniDict
		  Self.mGameUserSettingsIniDict = GameUserSettingsIniDict
		  
		  Dim SessionSettingsValues() As Text = Array("SessionName=" + Self.mServerName)
		  Dim SessionSettings As New Xojo.Core.Dictionary
		  SessionSettings.Value("SessionName") = SessionSettingsValues
		  Self.mGameUserSettingsIniDict.Value("SessionSettings") = SessionSettings
		  
		  // First, look up the server details to determine what needs to be done next
		  Self.mStatus = "Getting server status…"
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers", AddressOf Callback_ServerStatus, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not download Game.ini."
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Response.Value("data")
		    Dim TokenDict As Xojo.Core.Dictionary = Data.Value("token")
		    
		    Dim Headers As New Xojo.Core.Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadGameIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni_Content(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, True) // Yes, allow lossy here
		    Self.mGameIniOriginal = TextContent
		    Self.DownloadGameUserSettingsIni
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not download GameUserSettings.ini."
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Response.Value("data")
		    Dim TokenDict As Xojo.Core.Dictionary = Data.Value("token")
		    
		    Dim Headers As New Xojo.Core.Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadGameUserSettingsIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni_Content(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, True) // Yes, allow lossy here
		    Self.mGameUserSettingsIniOriginal = TextContent
		    Self.WaitForServerStop()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_EnableExpertMode(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not enable expert mode."
		      Return
		    End If
		    
		    Self.SetNextCommandLineParam()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStart(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Nitrado refused to start the server."
		      Return
		    End If
		    
		    Self.mFinished = True
		    Self.mErrored = False
		    Self.mStatus = "Finished"
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStatus(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    Dim Data As Xojo.Core.Dictionary = Response.Value("data")
		    Dim GameServer As Xojo.Core.Dictionary = Data.Value("gameserver")
		    
		    Dim ServerStatus As Text = GameServer.Value("status")
		    Self.mStartOnFinish = ServerStatus = "started"
		    
		    Dim Settings As Xojo.Core.Dictionary = GameServer.Value("settings")
		    Dim GeneralSettings As Xojo.Core.Dictionary = Settings.Value("general")
		    Self.mExpertMode = GeneralSettings.Value("expertMode") = "true"
		    
		    Dim StartParams As Xojo.Core.Dictionary = Settings.Value("start-param")
		    For Each ConfigValue As Beacon.ConfigValue In Self.mCommandLineOptions
		      Dim Key As Text = ConfigValue.Key
		      Dim Value As Text = ConfigValue.Value
		      
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
		    
		    Dim GameSpecific As Xojo.Core.Dictionary = GameServer.Value("game_specific")
		    Self.mConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		    
		    Self.StopServer()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ServerStop(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Nitrado refused to stop the server."
		      Return
		    End If
		    
		    Self.mServerStopTime = Microseconds
		    Self.EnableExpertMode()
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_SetNextCommandLineParam(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
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
		Private Sub Callback_UploadGameIni(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not get permission to upload Game.ini."
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Response.Value("data")
		    Dim TokenDict As Xojo.Core.Dictionary = Data.Value("token")
		    Dim Token As Text = TokenDict.Value("token")
		    
		    Dim Headers As New Xojo.Core.Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    Headers.Value("token") = Token
		    
		    Dim NewTextContent As Text = Beacon.RewriteIniContent(Self.mGameIniOriginal, Self.mGameIniDict)
		    Dim NewContent As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(NewTextContent)
		    
		    SimpleHTTP.Post(TokenDict.Value("url"), "text/plain", NewContent, AddressOf Callback_UploadGameIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameIni_Content(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Content
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  If Status < 400 Then
		    Self.UploadGameUserSettingsIni()
		  Else
		    Self.mErrored = True
		    Self.mStatus = "Error: Could not upload Game.ini, server said " + Status.ToText
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Response As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    
		    If Response.Value("status") <> "success" Then
		      Self.mErrored = True
		      Self.mStatus = "Error: Could not get permission to upload GameUserSettings.ini."
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Response.Value("data")
		    Dim TokenDict As Xojo.Core.Dictionary = Data.Value("token")
		    Dim Token As Text = TokenDict.Value("token")
		    
		    Dim Headers As New Xojo.Core.Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    Headers.Value("token") = Token
		    
		    Dim NewTextContent As Text = Beacon.RewriteIniContent(Self.mGameUserSettingsIniOriginal, Self.mGameUserSettingsIniDict)
		    Dim NewContent As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(NewTextContent)
		    
		    SimpleHTTP.Post(TokenDict.Value("url"), "text/plain", NewContent, AddressOf Callback_UploadGameUserSettingsIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_UploadGameUserSettingsIni_Content(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  #Pragma Unused Content
		  #Pragma Unused Tag
		  
		  If Self.mCancelled Or Self.CheckError(Status) Then
		    Return
		  End If
		  
		  If Status < 400 Then
		    Self.StartServer()
		  Else
		    Self.mErrored = True
		    Self.mStatus = "Error: Could not upload GameUserSettings.ini, server said " + Status.ToText
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Xojo.Core.Timer.CancelCall(WeakAddressOf UploadGameIni)
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
		Sub Constructor(ServerName As Text, ServiceID As Integer, OAuthData As Xojo.Core.Dictionary)
		  Self.mServerName = ServerName
		  Self.mServiceID = ServiceID
		  Self.mAccessToken = OAuthData.Value("Access Token")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  If Self.mGameIniDict.Count = 0 Then
		    // Skip
		    Self.DownloadGameUserSettingsIni()
		    Return
		  End If
		  
		  Self.mStatus = "Downloading Game.ini…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As Text = Self.mConfigPath + "/Game.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/file_server/download?file=" + Beacon.EncodeURLComponent(FilePath), AddressOf Callback_DownloadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  If Self.mGameUserSettingsIniDict.Count = 0 Then
		    // Skip
		    Self.WaitForServerStop()
		    Return
		  End If
		  
		  Self.mStatus = "Downloading GameUserSettings.ini…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As Text = Self.mConfigPath + "/GameUserSettings.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/file_server/download?file=" + Beacon.EncodeURLComponent(FilePath), AddressOf Callback_DownloadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EnableExpertMode()
		  If Self.mExpertMode Then
		    // Nothing to disable
		    Self.SetNextCommandLineParam()
		    Return
		  End If
		  
		  Self.mStatus = "Enabling expert mode…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Xojo.Core.Dictionary
		  FormData.Value("category") = "general"
		  FormData.Value("key") = "expertMode"
		  FormData.Value("value") = "true"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/settings", FormData, AddressOf Callback_EnableExpertMode, Nil, Headers)
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

	#tag Method, Flags = &h0
		Function Name() As Text
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
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Err)
		  Dim Reason As Text
		  If Err.Reason <> "" Then
		    Reason = Err.Reason
		  ElseIf Err.Message <> "" Then
		    Reason = Err.Message.ToText
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
		    Self.DownloadGameIni()
		    Return
		  End If
		  
		  Self.mStatus = "Setting command line parameters…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Xojo.Core.Dictionary
		  FormData.Value("category") = "start-param"
		  FormData.Value("key") = Self.mCommandLineChanges(0).Key
		  FormData.Value("value") = Self.mCommandLineChanges(0).Value
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/settings", FormData, AddressOf Callback_SetNextCommandLineParam, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartServer()
		  If Not Self.mStartOnFinish Then
		    Self.mFinished = True
		    Self.mErrored = False
		    Self.mStatus = "Finished"
		    Return
		  End If
		  
		  Self.mStatus = "Starting server…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Xojo.Core.Dictionary
		  FormData.Value("message") = "Server started by Beacon (https://beaconapp.cc)"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/restart", FormData, AddressOf Callback_ServerStart, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Text
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StopServer()
		  If Not Self.mStartOnFinish Then
		    Self.EnableExpertMode()
		    Return
		  End If
		  
		  Self.mStatus = "Stopping server…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FormData As New Xojo.Core.Dictionary
		  FormData.Value("message") = "Server is being updated by Beacon (https://beaconapp.cc)"
		  FormData.Value("stop_message") = "Server is now stopping for a few minutes for changes."
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/stop", FormData, AddressOf Callback_ServerStop, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameIni()
		  If Self.mGameIniDict.Count = 0 Then
		    // Skip
		    Self.UploadGameUserSettingsIni()
		    Return
		  End If
		  
		  Self.mStatus = "Uploading Game.ini…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim Fields As New Xojo.Core.Dictionary
		  Fields.Value("path") = Self.mConfigPath
		  Fields.Value("file") = "Game.ini"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/file_server/upload", Fields, AddressOf Callback_UploadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadGameUserSettingsIni()
		  If Self.mGameUserSettingsIniDict.Count = 0 Then
		    // Skip
		    Self.StartServer()
		    Return
		  End If
		  
		  Self.mStatus = "Uploading GameUserSettings.ini…"
		  
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim Fields As New Xojo.Core.Dictionary
		  Fields.Value("path") = Self.mConfigPath
		  Fields.Value("file") = "GameUserSettings.ini"
		  
		  SimpleHTTP.Post("https://api.nitrado.net/services/" + Self.mServiceID.ToText + "/gameservers/file_server/upload", Fields, AddressOf Callback_UploadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WaitForServerStop()
		  If Self.mServerStopTime = 0 Then
		    // Put files on the server
		    Self.UploadGameIni()
		    Return
		  End If
		  
		  Const MillisecondsToWait = 180000
		  
		  Dim MillisecondsWaited As Double = (Microseconds - Self.mServerStopTime) * 0.001
		  Dim MillisecondsRemaining As Double = Max(MillisecondsToWait - MillisecondsWaited, 0)
		  
		  Self.mStatus = "Waiting 3 minutes per Nitrado recommendations…"
		  Xojo.Core.Timer.CallLater(MillisecondsRemaining, WeakAddressOf UploadGameIni)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccessToken As Text
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
		Private mConfigPath As Text
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
		Private mGameIniDict As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniOriginal As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniDict As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniOriginal As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerName As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerStopTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceID As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStartOnFinish As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As Text
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
