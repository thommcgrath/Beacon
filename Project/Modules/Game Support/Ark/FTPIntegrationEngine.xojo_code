#tag Class
Protected Class FTPIntegrationEngine
Inherits Ark.IntegrationEngine
	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var FTPProfile As Ark.FTPServerProfile = Self.Profile
		  
		  Var Protocols() As String
		  Select Case FTPProfile.Mode
		  Case Ark.FTPServerProfile.ModeFTP
		    Protocols.Add("ftp")
		  Case Ark.FTPServerProfile.ModeFTPTLS
		    Protocols.Add("ftps")
		  Case Ark.FTPServerProfile.ModeSFTP
		    Protocols.Add("sftp")
		  Else
		    // If the port number ends in 21, try sftp mode last.
		    Var BasePort As Integer = Abs(FTPProfile.Port) Mod 100
		    Break
		    If BasePort = 21 Then
		      Protocols.Add("ftps")
		      Protocols.Add("ftp")
		      Protocols.Add("sftp")
		    Else
		      Protocols.Add("sftp")
		      Protocols.Add("ftps")
		      Protocols.Add("ftp")
		    End If
		  End Select
		  
		  If FTPProfile.Mode <> Ark.FTPServerProfile.ModeAuto Then
		    Self.Log("Connecting to server…")
		  End If
		  
		  Var IPMatch As New Regex
		  IPMatch.SearchPattern = "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}_\d{1,5}$"
		  
		  Var Files() As Beacon.FTPFileListing
		  Var PotentialPaths() As String
		  For Each Protocol As String In Protocols
		    If FTPProfile.Mode = Ark.FTPServerProfile.ModeAuto Then
		      Self.Log("Attempting " + Protocol + " mode…")
		    End If
		    
		    Files = Self.PrivateListFiles(Protocol + "://" + FTPProfile.Host + ":" + FTPProfile.Port.ToString)
		    If Files = Nil Then
		      // That didn't work
		      Continue
		    End If
		    
		    Self.Log("Connected with " + Protocol + ".")
		    Select Case Protocol
		    Case "ftp"
		      FTPProfile.Mode = Ark.FTPServerProfile.ModeFTP
		    Case "ftps"
		      FTPProfile.Mode = Ark.FTPServerProfile.ModeFTPTLS
		    Case "sftp"
		      FTPProfile.Mode = Ark.FTPServerProfile.ModeSFTP
		    End Select
		    
		    Var BaseURL As String = Self.BaseURL
		    For Each Info As Beacon.FTPFileListing In Files
		      If Not Info.IsDirectory Then
		        Continue
		      End If
		      
		      If Info.Filename = "arkse" Or Info.Filename = "arkserer" Then
		        PotentialPaths.Add(BaseURL + "/" + Info.FileName + "/ShooterGame/Saved")
		        PotentialPaths.Add(BaseURL + "/" + Info.Filename + "/ShooterGame/SavedArks")
		      ElseIf Info.Filename = "ShooterGame" Then
		        PotentialPaths.Add(BaseURL + "/" + Info.FileName + "/Saved")
		        PotentialPaths.Add(BaseURL + "/" + Info.FileName + "/SavedArks")
		      ElseIf Info.Filename = "Saved" Or Info.Filename = "SavedArks" Then
		        PotentialPaths.Add(BaseURL + "/" + Info.Filename)
		      ElseIf IPMatch.Search(Info.Filename) <> Nil Then
		        PotentialPaths.Add(BaseURL + "/" + Info.Filename + "/ShooterGame/Saved")
		        PotentialPaths.Add(BaseURL + "/" + Info.Filename + "/ShooterGame/SavedArks")
		      End If
		    Next
		    
		    Exit
		  Next
		  
		  // None of them worked
		  If Files = Nil Then
		    If Protocols.Count > 1 Then
		      Self.SetError("The server either refused all connection attempts or could not list files. Check the connection information and try again. If the problem persists, contact the hosting provider.")
		    Else
		      Self.SetError("The server either refused the connection or could not list files. Check the connection information and try again. If the problem persists, contact the hosting provider.")
		    End If
		    Return Nil
		  End If
		  
		  Self.Log("Discovering paths…")
		  Var DiscoveredData() As Beacon.DiscoveredData
		  For Each Path As String In PotentialPaths
		    Var Data As Ark.DiscoveredData = Self.DiscoverFromPath(Path)
		    If Data <> Nil Then
		      DiscoveredData.Add(Data)
		    End If
		  Next
		  
		  If DiscoveredData.Count = 0 Then
		    // Ok, nothing was found in the normal paths. The user will need to find the Game.ini file
		    Var UserData As New Dictionary
		    UserData.Value("Root") = Self.BaseURL
		    Var Controller As New Beacon.TaskWaitController("Locate Game.ini", UserData)
		    Self.Log("Waiting for user action…")
		    Self.Wait(Controller)
		    If Controller.Cancelled Then
		      Self.Cancel
		      Return Nil
		    End If
		    If UserData.HasKey("Path") Then
		      Var SavedPath As String = UserData.Value("Path")
		      Var Data As Ark.DiscoveredData = Self.DiscoverFromPath(Self.BaseURL + SavedPath)
		      If Data <> Nil Then
		        DiscoveredData.Add(Data)
		      End If
		    End If
		  End If
		  
		  Return DiscoveredData
		End Function
	#tag EndEvent

	#tag Event
		Sub DownloadFile(Transfer As Beacon.IntegrationTransfer, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  
		  Var Path As String
		  If Transfer.Path.IsEmpty Then
		    Path = Self.BaseURL
		    Select Case Transfer.Filename
		    Case Ark.ConfigFileGame
		      Path = Path + Ark.FTPServerProfile(Self.Profile).GameIniPath
		    Case Ark.ConfigFileGameUserSettings
		      Path = Path + Ark.FTPServerProfile(Self.Profile).GameUserSettingsIniPath
		    End Select
		  Else
		    Path = Transfer.Path + "/" + Transfer.Filename
		  End If
		  
		  Var Locked As Boolean = Self.LockEnter
		  Self.SetURL(Path)
		  Call Self.mSocket.PerformMT
		  If Self.mSocket.Lasterror = CURLSMBS.kError_OK Then
		    Transfer.Content = Self.mSocket.OutputData
		    Transfer.Success = True
		  ElseIf (Self.mSocket.LastError = CURLSMBS.kError_REMOTE_FILE_NOT_FOUND And FailureMode = DownloadFailureMode.MissingAllowed) Or FailureMode = DownloadFailureMode.ErrorsAllowed Then
		    Transfer.Content = ""
		    Transfer.Success = True
		  Else
		    Transfer.SetError("Could not download: " + Self.mSocket.LasterrorMessage + ", code " + Self.mSocket.Lasterror.ToString(Locale.Raw, "0"))
		  End If
		  Self.LockLeave(Locked)
		End Sub
	#tag EndEvent

	#tag Event
		Sub UploadFile(Transfer As Beacon.IntegrationTransfer)
		  Var Path As String
		  If Transfer.Path.IsEmpty Then
		    Path = Self.BaseURL
		    Select Case Transfer.Filename
		    Case Ark.ConfigFileGame
		      Path = Path + Ark.FTPServerProfile(Self.Profile).GameIniPath
		    Case Ark.ConfigFileGameUserSettings
		      Path = Path + Ark.FTPServerProfile(Self.Profile).GameUserSettingsIniPath
		    End Select
		  Else
		    Path = Transfer.Path + "/" + Transfer.Filename
		  End If
		  
		  Var Locked As Boolean = Self.LockEnter()
		  Self.mSocket.OptionUpload = True
		  Self.SetURL(Path)
		  Self.mSocket.SetInputData(Transfer.Content)
		  Call Self.mSocket.PerformMT
		  Var ErrorCode As Integer = Self.mSocket.Lasterror
		  Var ErrorMessage As String = Self.mSocket.LasterrorMessage
		  Self.mSocket.OptionUpload = False
		  Self.LockLeave(Locked)
		  If ErrorCode <> CURLSMBS.kError_OK Then
		    Transfer.SetError(ErrorMessage + ", code " + ErrorCode.ToString(Locale.Raw, "0"))
		  Else
		    Transfer.Success = True
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BaseURL() As String
		  Var FTPProfile As Ark.FTPServerProfile = Ark.FTPServerProfile(Self.Profile)
		  Var Protocol As String
		  Select Case FTPProfile.Mode
		  Case Ark.FTPServerProfile.ModeFTP
		    Protocol = "ftp"
		  Case Ark.FTPServerProfile.ModeFTPTLS
		    Protocol = "ftps"
		  Case Ark.FTPServerProfile.ModeSFTP
		    Protocol = "sftp"
		  End Select
		  
		  Return Protocol + "://" + FTPProfile.Host + ":" + FTPProfile.Port.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  Self.mSocket = New CURLSMBS
		  Call Self.mSocket.UseSystemCertificates
		  Self.mSocket.OptionUsername = Ark.FTPServerProfile(Profile).Username
		  Self.mSocket.OptionPassword = Ark.FTPServerProfile(Profile).Password
		  Self.mSocket.OptionSSHAuthTypes = CURLSMBS.kSSHAuthPassword
		  Self.mSocket.OptionSSHCompression = False
		  Self.mSocket.OptionTimeOut = 10
		  Self.mSocket.YieldTime = True
		  
		  Var PrivateKeyFile As FolderItem = Ark.FTPServerProfile(Profile).PrivateKeyFile
		  If (PrivateKeyFile Is Nil) = False Then
		    Self.mSocket.OptionSSHAuthTypes = Self.mSocket.OptionSSHAuthTypes Or CURLSMBS.kSSHAuthPublicKey
		    Self.mSocket.OptionSSHPrivateKeyfile = PrivateKeyFile.NativePath
		    Self.mSocket.OptionKeyPassword = Self.mSocket.OptionPassword
		  End If
		  
		  Self.mSocketLock = New CriticalSection
		  
		  Super.Constructor(Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DiscoverFromPath(Path As String) As Ark.DiscoveredData
		  Var SavedFiles() As Beacon.FTPFileListing = Self.PrivateListFiles(Path)
		  If SavedFiles = Nil Then
		    Return Nil
		  End If
		  
		  Var LogsPath, ConfigPath As String
		  For Each Info As Beacon.FTPFileListing In SavedFiles
		    If Not Info.IsDirectory Then
		      Continue
		    End If
		    
		    Select Case Info.FileName
		    Case "Config"
		      ConfigPath = Path + "/Config"
		    Case "Logs"
		      LogsPath = Path + "/Logs"
		    End Select
		  Next
		  
		  If ConfigPath.Length = 0 Then
		    Return Nil
		  End If
		  
		  Var ConfigFolders() As Beacon.FTPFileListing = Self.PrivateListFiles(ConfigPath)
		  If ConfigFolders = Nil Then
		    Return Nil
		  End If
		  
		  Var BaseURL As String = Self.BaseURL
		  Var Profile As New Ark.FTPServerProfile(Ark.FTPServerProfile(Self.Profile))
		  Var Data As New Ark.DiscoveredData
		  Data.Profile = Profile
		  
		  For Each Info As Beacon.FTPFileListing In ConfigFolders
		    If Not Info.IsDirectory Then
		      Continue
		    End If
		    
		    If Info.Filename.EndsWith("Server") Or Info.Filename.EndsWith("NoEditor") Then
		      Profile.GameIniPath = ConfigPath.Middle(BaseURL.Length) + "/" + Info.Filename + "/Game.ini"
		      Profile.GameUserSettingsIniPath = ConfigPath.Middle(BaseURL.Length) + "/" + Info.Filename + "/GameUserSettings.ini"
		      Exit
		    End If
		  Next
		  
		  If Profile.GameIniPath.Length = 0 Or Profile.GameUserSettingsIniPath.Length = 0 Then
		    Return Nil
		  End If
		  
		  If LogsPath.Length > 0 Then
		    Self.Log("Analyzing log files…")
		    Var Logs() As Beacon.FTPFileListing = Self.PrivateListFiles(LogsPath)
		    If Logs <> Nil Then
		      Var Filenames() As String
		      For Each Info As Beacon.FTPFileListing In Logs
		        If Info.IsDirectory Or Info.Filename.BeginsWith("ShooterGame") = False Or Info.Filename.EndsWith(".log") = False Then
		          Continue
		        End If
		        
		        Filenames.Add(Info.Filename)
		      Next
		      Filenames.Sort
		      For Idx As Integer = Filenames.LastIndex DownTo 0
		        Var LogFileDownloaded As Boolean
		        Var Contents As String = Self.GetFile(LogsPath + "/" + Filenames(Idx), DownloadFailureMode.Required, False, LogFileDownloaded)
		        If LogFileDownloaded And Self.ParseLogFile(Data, Contents) Then
		          Exit
		        End If
		      Next
		    End If
		  End If
		  
		  Var FileDownloaded As Boolean
		  Var FileContent As String = Self.GetFile(BaseURL + Profile.GameIniPath, DownloadFailureMode.MissingAllowed, False, FileDownloaded)
		  If FileDownloaded Then
		    Data.GameIniContent = FileContent.GuessEncoding
		  Else
		    Self.SetError("Could not download Game.ini")
		    Return Nil
		  End If
		  FileContent = Self.GetFile(BaseURL + Profile.GameUserSettingsIniPath, DownloadFailureMode.MissingAllowed, False, FileDownloaded)
		  If FileDownloaded Then
		    Data.GameUserSettingsIniContent = FileContent.GuessEncoding
		  Else
		    Self.SetError("Could not download GameUserSettings.ini")
		    Return Nil
		  End If
		  
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListFiles(Path As String)
		  If Thread.Current <> Nil Then
		    Var Files() As Beacon.FTPFileListing = Self.PrivateListFiles(Self.BaseURL + Path)
		    Var Params(1) As Variant
		    Params(0) = Path
		    Params(1) = Files
		    Self.mPendingCalls.Add(CallLater.Schedule(1, WeakAddressOf TriggerFilesListed, Params))
		    Return
		  End If
		  
		  Var Th As New Beacon.Thread
		  Th.UserData = Path
		  AddHandler Th.Run, WeakAddressOf ListThread_Run
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListThread_Run(Sender As Beacon.Thread)
		  Var Path As String = Sender.UserData
		  Self.ListFiles(Path)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LockEnter() As Boolean
		  Var Locked As Boolean = Preferences.SignalConnection()
		  Self.mSocketLock.Enter
		  Return Locked
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LockLeave(WasLocked As Boolean)
		  Self.mSocketLock.Leave
		  If WasLocked Then
		    Preferences.ReleaseConnection()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseLogFile(Data As Ark.DiscoveredData, Contents As String) As Boolean
		  If Contents.Length = 0 Then
		    Return False
		  End If
		  
		  Contents = Contents.GuessEncoding.ReplaceLineEndings(EndOfLine)
		  
		  Var Lines() As String = Contents.Split(EndOfLine)
		  Var FoundName, FoundCommandLine As Boolean
		  For Each Line As String In Lines
		    Line = Line.Middle(30).Trim
		    
		    If Line.BeginsWith("Server: """) And Line.EndsWith(""" has successfully started!") Then
		      // Found the server name
		      Var ServerName As String = Line.Middle(9, Line.Length - 36)
		      Data.Profile.Name = ServerName
		      FoundName = True
		    ElseIf Line.BeginsWith("Commandline: ") Then
		      // Here's the command line
		      Var CommandLine As String = Line.Middle(13)
		      Var Options As Dictionary = Ark.ParseCommandLine(CommandLine)
		      Data.Profile.Mask = Ark.Maps.MaskForIdentifier(Options.Value("Map"))
		      Data.CommandLineOptions = Options
		      FoundCommandLine = True
		    End If
		  Next
		  Return FoundName And FoundCommandLine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PrivateListFiles(Path As String) As Beacon.FTPFileListing()
		  If Path.BeginsWith("sftp://") Then
		    If Path.EndsWith("/") = False Then
		      Path = Path + "/"
		    End If
		    
		    Var Locked As Boolean = Self.LockEnter
		    Self.SetURL(Path)
		    Var Err As Integer = Self.mSocket.Perform
		    Var Content As String = Self.mSocket.OutputData
		    Self.LockLeave(Locked)
		    If Err <> CURLSMBS.kError_OK Then
		      Self.Log("Curl Error " + Err.ToString)
		      Return Nil
		    End If
		    
		    Var Lines() As String = Content.Trim.ReplaceLineEndings(EndOfLine.UNIX).Split(EndOfLine.UNIX)
		    
		    Var Parser As New RegEx
		    Parser.SearchPattern = "^(.{10})\s+(\d+)\s+(\S+)\s+(\S+)\s+(\d+)\s+(.{11,12})\s(.+)$"
		    
		    Var Files() As Beacon.FTPFileListing
		    Var Names() As String
		    For Each Line As String In Lines
		      Var Matches As RegExMatch = Parser.Search(Line)
		      If Matches Is Nil Then 
		        Continue
		      End If
		      
		      Var Permissions As String = Matches.SubExpressionString(1)
		      Var Filename As String = Matches.SubExpressionString(7)
		      
		      Files.Add(New Beacon.FTPFileListing(Permissions.BeginsWith("d"), Filename))
		      Names.Add(Filename)
		    Next
		    Names.SortWith(Files)
		    
		    Return Files
		  End If
		  
		  If Path.Right(2) = "/*" Then
		    // Good
		  ElseIf Path.Right(1) = "/" Then
		    Path = Path + "*"
		  Else
		    Path = Path + "/*"
		  End If
		  
		  Var Locked As Boolean = Self.LockEnter()
		  Var Wildcard As Boolean = Self.mSocket.OptionWildcardMatch
		  Self.mSocket.OptionWildcardMatch = True
		  Self.SetURL(Path)
		  Var Err As Integer = Self.mSocket.Perform
		  Self.mSocket.OptionWildcardMatch = Wildcard
		  Var Infos() As CURLSFileInfoMBS = Self.mSocket.FileInfos
		  Self.LockLeave(Locked)
		  If Err <> CURLSMBS.kError_OK Then
		    Self.Log("Curl Error " + Err.ToString)
		    Return Nil
		  End If
		  
		  If (Infos Is Nil) = FAlse Then
		    Var Files() As Beacon.FTPFileListing
		    Var Names() As String
		    For Each Info As CURLSFileInfoMBS In Infos
		      Files.Add(New Beacon.FTPFileListing(Info.IsDirectory, Info.FileName))
		      Names.Add(Info.FileName)
		    Next
		    Names.SortWith(Files)
		    
		    Return Files
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.FTPServerProfile
		  Return Ark.FTPServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetURL(URL As String)
		  Self.mSocket.OptionURL = URL
		  If URL.BeginsWith("ftps://") Then
		    Self.mSocket.OptionSSLVerifyHost = 2
		    Self.mSocket.OptionSSLVerifyPeer = 1
		  Else
		    Self.mSocket.OptionSSLVerifyHost = 0
		    Self.mSocket.OptionSSLVerifyPeer = 0
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerFilesListed(Value As Variant)
		  Var Params() As Variant
		  Var Path As String
		  Var Files() As Beacon.FTPFileListing
		  Try
		    Params = Value
		    Path = Params(0).StringValue
		    Files = Params(1)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName)
		    RaiseEvent FileListError(Err)
		    Return
		  End Try
		  
		  RaiseEvent FilesListed(Path, Files)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event FileListError(Err As RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event FilesListed(Path As String, Files() As Beacon.FTPFileListing)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSocket As CURLSMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocketLock As CriticalSection
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSocket.OptionSSLVerifyHost = 2
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.mSocket.OptionSSLVerifyHost = 2
			    Self.mSocket.OptionSSLVerifyPeer = 1
			  Else
			    Self.mSocket.OptionSSLVerifyHost = 0
			    Self.mSocket.OptionSSLVerifyPeer = 0
			  End If
			End Set
		#tag EndSetter
		VerifyHost As Boolean
	#tag EndComputedProperty


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
		#tag ViewProperty
			Name="VerifyHost"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
