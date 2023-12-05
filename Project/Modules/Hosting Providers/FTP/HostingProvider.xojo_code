#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h21
		Private Function BaseUrl(Config As FTP.HostConfig) As String
		  Var Protocol As String
		  Select Case Config.Mode
		  Case Beacon.FTPModeOptionalTLS, Beacon.FTPModeExplicitTLS, Beacon.FTPModeInsecure
		    Protocol = "ftp"
		  Case Beacon.FTPModeSSH
		    Protocol = "sftp"
		  Case Beacon.FTPModeImplicitTLS
		    Protocol = "ftps"
		  End Select
		  Return Protocol + "://" + Config.Host + ":" + Config.Port.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod

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

	#tag Method, Flags = &h21
		Private Function CreateSocket(Config As FTP.HostConfig, Url As String) As CURLSMBS
		  Var Socket As New CURLSMBS
		  Socket.OptionUsername = Config.Username
		  Socket.OptionPassword = Config.Password
		  Socket.OptionTimeOut = 20
		  Socket.YieldTime = True
		  
		  Select Case Config.Mode
		  Case Beacon.FTPModeInsecure
		    Socket.OptionUseSSL = CURLSMBS.kFTPSSL_NONE
		  Case Beacon.FTPModeOptionalTLS, Beacon.FTPModeExplicitTLS, Beacon.FTPModeImplicitTLS
		    If Config.VerifyHost Then
		      #if TargetLinux
		        #if DebugBuild
		          #Pragma Warning "Linux cannot load system certificates"
		        #else
		          #Pragma Error "Linux cannot load system certificates"
		        #endif
		      #endif
		      Call Socket.UseSystemCertificates
		      
		      Socket.OptionSSLVerifyHost = 2
		      Socket.OptionSSLVerifyPeer = 1
		    Else
		      Socket.OptionSSLVerifyHost = 0
		      Socket.OptionSSLVerifyPeer = 0
		    End If
		    
		    If Config.Mode = Beacon.FTPModeOptionalTLS Then
		      Socket.OptionUseSSL = CURLSMBS.kFTPSSL_TRY
		    Else
		      Socket.OptionUseSSL = CURLSMBS.kFTPSSL_ALL
		    End If
		    Socket.OptionFTPSSLAuth = CURLSMBS.kFTPAUTH_TLS
		    Socket.OptionSSLVersion = CURLSMBS.kSSLVersionTLSv12
		  Case Beacon.FTPModeSSH
		    Socket.OptionSSHAuthTypes = CURLSMBS.kSSHAuthPassword
		    Socket.OptionSSHCompression = False
		    
		    Var PrivateKeyFile As FolderItem = Config.PrivateKeyFile
		    If (PrivateKeyFile Is Nil) = False Then
		      Socket.OptionSSHAuthTypes = Socket.OptionSSHAuthTypes Or CURLSMBS.kSSHAuthPublicKey
		      Socket.OptionSSHPrivateKeyfile = PrivateKeyFile.NativePath
		      Socket.OptionKeyPassword = Socket.OptionPassword
		    End If
		  End Select
		  
		  Socket.OptionURL = Url
		  Return Socket
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  
		  Var Config As FTP.HostConfig = Self.GetConfig(Profile)
		  Var Path As String = Transfer.Path
		  If Path.BeginsWith("/") = False Then
		    Path = "/" + Path
		  End If
		  Var Url As String = Self.BaseUrl(Config) + Path
		  Var Socket As CURLSMBS = Self.CreateSocket(Config, Url)
		  
		  Try
		    Transfer.Content = Self.RunRequest(Socket, True)
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    If FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Or (Err IsA NetworkException And Err.ErrorNumber = CURLSMBS.kError_REMOTE_FILE_NOT_FOUND And FailureMode = Beacon.Integration.DownloadFailureMode.MissingAllowed) Then
		      Transfer.Content = ""
		      Transfer.Success = True
		    Else
		      Transfer.SetError("Could not download: " + Err.Message + ", code: " + Err.ErrorNumber.ToString(Locale.Raw, "0"))
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameSetting(Project As Beacon.Project, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting) As Variant
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Setting
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameSetting(Project As Beacon.Project, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting, Assigns Value As Variant)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Setting
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetConfig(Profile As Beacon.ServerProfile) As FTP.HostConfig
		  If Profile Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "No profile provided"
		    Raise Err
		  End If
		  
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA FTP.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile does have an FTP host config."
		    Raise Err
		  End If
		  
		  Return FTP.HostConfig(Config)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return FTP.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  
		  If StartingPath.BeginsWith("/") = False Then
		    StartingPath = "/" + StartingPath
		  End If
		  
		  Var Config As FTP.HostConfig = Self.GetConfig(Profile)
		  Var Url As String = Self.BaseUrl(Config) + StartingPath
		  Var Filenames() As String
		  If Config.Mode = Beacon.FTPModeSSH Then
		    If Url.EndsWith("/") = False Then
		      Url = Url + "/"
		    End If
		    Var Socket As CURLSMBS = Self.CreateSocket(Config, Url)
		    Var Content As String = Self.RunRequest(Socket, False) // Listing files doesn't work multithreaded
		    Var Lines() As String = Content.Trim.ReplaceLineEndings(EndOfLine.UNIX).Split(EndOfLine.UNIX)
		    
		    Var Parser As New RegEx
		    Parser.SearchPattern = "^(.{10})\s+(\d+)\s+(\S+)\s+(\S+)\s+(\d+)\s+(.{11,12})\s(.+)$"
		    
		    For Each Line As String In Lines
		      Var Matches As RegExMatch = Parser.Search(Line)
		      If Matches Is Nil Then 
		        Continue
		      End If
		      
		      Var Permissions As String = Matches.SubExpressionString(1)
		      Var IsDirectory As Boolean = Permissions.BeginsWith("d")
		      Var Filename As String = Matches.SubExpressionString(7)
		      If IsDirectory And Filename.EndsWith("/") = False Then
		        Filename = Filename + "/"
		      End If
		      
		      If Filename = "./" Or Filename = "../" Then
		        Continue
		      End If
		      
		      Filenames.Add(Filename)
		    Next
		  Else
		    If Url.Right(2) = "/*" Then
		      // Good
		    ElseIf Url.Right(1) = "/" Then
		      Url = Url + "*"
		    Else
		      Url = Url + "/*"
		    End If
		    
		    Var Socket As CURLSMBS = Self.CreateSocket(Config, Url)
		    Socket.OptionWildcardMatch = True
		    Call Self.RunRequest(Socket, False) // Listing files doesn't work multithreaded
		    Var Infos() As CURLSFileInfoMBS = Socket.FileInfos
		    
		    If (Infos Is Nil) = False Then
		      For Each Info As CURLSFileInfoMBS In Infos
		        Var Filename As String = Info.Filename
		        If Info.IsDirectory And Filename.EndsWith("/") = False Then
		          Filename = Filename + "/"
		        End If
		        Filenames.Add(Filename)
		      Next
		    End If
		  End If
		  
		  Filenames.Sort
		  Return Filenames
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  If (Config IsA FTP.HostConfig) = False Then
		    Var Err As UnsupportedOperationException
		    Err.Message = "Config is not an FTP host config."
		    Raise Err
		  End If
		  
		  Var Name As String = Self.BaseUrl(FTP.HostConfig(Config))
		  Var ProfileId As String = Beacon.UUID.v5("FTP:" + Name)
		  
		  Var Profile As Beacon.ServerProfile
		  Select Case GameId
		  Case Ark.Identifier
		    Profile = New Ark.ServerProfile(Self.Identifier, ProfileId, Name, "", Name)
		  Case SDTD.Identifier
		    Profile = New SDTD.ServerProfile(Self.Identifier, ProfileId, Name, "", Name)
		  Case ArkSA.Identifier
		    Profile = New ArkSA.ServerProfile(Self.Identifier, ProfileId, Name, "", Name)
		  End Select
		  
		  Var Profiles(0) As Beacon.ServerProfile
		  Profiles(0) = Profile
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
		  #Pragma Unused Token
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunRequest(Socket As CURLSMBS, Multithreaded As Boolean) As String
		  Self.mThrottled = True
		  Var Locked As Boolean = Preferences.SignalConnection
		  Self.mThrottled = False
		  Var Code As Integer
		  If Multithreaded Then
		    Code = Socket.PerformMT
		  Else
		    Code = Socket.Perform
		  End If
		  Var Content As String = Socket.OutputData
		  If Locked Then
		    Preferences.ReleaseConnection
		  End If
		  If Code <> CURLSMBS.kError_OK Then
		    Var Err As New NetworkException
		    Err.ErrorNumber = Code
		    Err.Message = Socket.LastErrorMessage
		    
		    Self.mLogger.Log("Curl Error " + Code.ToString(Locale.Raw, "0"))
		    Self.mLogger.Log(Socket.OptionURL)
		    Self.mLogger.Log(Socket.DebugMessages)
		    
		    Raise Err
		  End If
		  Return Content
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
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused StopMessage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsGameSettings() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
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
		  
		  #Pragma Unused Project
		  
		  Var Config As FTP.HostConfig = Self.GetConfig(Profile)
		  Var Path As String = Transfer.Path
		  If Path.BeginsWith("/") = False Then
		    Path = "/" + Path
		  End If
		  Var Url As String = Self.BaseUrl(Config) + Path
		  Var Socket As CURLSMBS = Self.CreateSocket(Config, Url)
		  
		  Socket.OptionUpload = True
		  Socket.SetInputData(Transfer.Content)
		  
		  Try
		    Call Self.RunRequest(Socket, True)
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    Transfer.SetError(Err.Message + ", code " + Err.ErrorNumber.ToString(Locale.Raw, "0"))
		  End Try
		End Sub
	#tag EndMethod


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
