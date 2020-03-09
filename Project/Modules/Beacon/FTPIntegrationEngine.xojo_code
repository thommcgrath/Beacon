#tag Class
Protected Class FTPIntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var FTPProfile As Beacon.FTPServerProfile = Beacon.FTPServerProfile(Self.Profile)
		  
		  Var Protocols() As String
		  Select Case FTPProfile.Mode
		  Case Beacon.FTPServerProfile.ModeFTP
		    Protocols.AddRow("ftp")
		  Case Beacon.FTPServerProfile.ModeFTPTLS
		    Protocols.AddRow("ftps")
		  Case Beacon.FTPServerProfile.ModeSFTP
		    Protocols.AddRow("sftp")
		  Else
		    Protocols.AddRow("sftp")
		    Protocols.AddRow("ftps")
		    Protocols.AddRow("ftp")
		  End Select
		  
		  If FTPProfile.Mode <> Beacon.FTPServerProfile.ModeAuto Then
		    Self.Log("Connecting to server…")
		  End If
		  
		  Var IPMatch As New Regex
		  IPMatch.SearchPattern = "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}_\d{1,5}$"
		  
		  Var Files() As CURLSFileInfoMBS
		  Var PotentialPaths() As String
		  For Each Protocol As String In Protocols
		    If FTPProfile.Mode = Beacon.FTPServerProfile.ModeAuto Then
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
		      FTPProfile.Mode = Beacon.FTPServerProfile.ModeFTP
		    Case "ftps"
		      FTPProfile.Mode = Beacon.FTPServerProfile.ModeFTPTLS
		    Case "sftp"
		      FTPProfile.Mode = Beacon.FTPServerProfile.ModeSFTP
		    End Select
		    
		    Var BaseURL As String = Self.BaseURL
		    For Each Info As CURLSFileInfoMBS In Files
		      If Not Info.IsDirectory Then
		        Continue
		      End If
		      
		      If Info.Filename = "arkse" Or Info.Filename = "arkserer" Then
		        PotentialPaths.AddRow(BaseURL + "/" + Info.FileName + "/ShooterGame/Saved")
		        PotentialPaths.AddRow(BaseURL + "/" + Info.Filename + "/ShooterGame/SavedArks")
		      ElseIf Info.Filename = "ShooterGame" Then
		        PotentialPaths.AddRow(BaseURL + "/" + Info.FileName + "/Saved")
		        PotentialPaths.AddRow(BaseURL + "/" + Info.FileName + "/SavedArks")
		      ElseIf Info.Filename = "Saved" Or Info.Filename = "SavedArks" Then
		        PotentialPaths.AddRow(BaseURL + "/" + Info.Filename)
		      ElseIf IPMatch.Search(Info.Filename) <> Nil Then
		        PotentialPaths.AddRow(BaseURL + "/" + Info.Filename + "/ShooterGame/Saved")
		        PotentialPaths.AddRow(BaseURL + "/" + Info.Filename + "/ShooterGame/SavedArks")
		      End If
		    Next
		    
		    Exit
		  Next
		  
		  // None of them worked
		  If Files = Nil Then
		    Self.SetError("Unable to connect and list files.")
		    Return Nil
		  End If
		  
		  Self.Log("Discovering paths…")
		  Var DiscoveredData() As Beacon.DiscoveredData
		  For Each Path As String In PotentialPaths
		    Var Data As Beacon.DiscoveredData = Self.DiscoverFromPath(Path)
		    If Data <> Nil Then
		      DiscoveredData.AddRow(Data)
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
		      Var Data As Beacon.DiscoveredData = Self.DiscoverFromPath(Self.BaseURL + SavedPath)
		      If Data <> Nil Then
		        DiscoveredData.AddRow(Data)
		      End If
		    End If
		  End If
		  
		  Break
		  
		  Return DiscoveredData
		End Function
	#tag EndEvent

	#tag Event
		Function DownloadFile(Filename As String) As String
		  Select Case Filename
		  Case "Game.ini"
		    Return Self.DownloadFile(Self.BaseURL + Beacon.FTPServerProfile(Self.Profile).GameIniPath)
		  Case "GameUserSettings.ini"
		    Return Self.DownloadFile(Self.BaseURL + Beacon.FTPServerProfile(Self.Profile).GameUserSettingsIniPath)
		  End Select
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function BaseURL() As String
		  Var FTPProfile As Beacon.FTPServerProfile = Beacon.FTPServerProfile(Self.Profile)
		  Var Protocol As String
		  Select Case FTPProfile.Mode
		  Case Beacon.FTPServerProfile.ModeFTP
		    Protocol = "ftp"
		  Case Beacon.FTPServerProfile.ModeFTPTLS
		    Protocol = "ftps"
		  Case Beacon.FTPServerProfile.ModeSFTP
		    Protocol = "sftp"
		  End Select
		  
		  Return Protocol + "://" + FTPProfile.Host + ":" + FTPProfile.Port.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  Super.Constructor(Profile)
		  
		  Var FTPProfile As Beacon.FTPServerProfile = Beacon.FTPServerProfile(Self.Profile)
		  
		  Self.mSocket = New CURLSMBS
		  Call Self.mSocket.UseSystemCertificates
		  Self.mSocket.OptionUseSSL = CURLSMBS.kUseSSLtry
		  Self.mSocket.OptionUsername = FTPProfile.Username
		  Self.mSocket.OptionPassword = FTPProfile.Password
		  Self.mSocket.OptionSSHAuthTypes = CURLSMBS.kSSHAuthPassword
		  Self.mSocket.OptionTimeOut = 10
		  Self.mSocket.YieldTime = True
		  
		  Self.mSocketLock = New CriticalSection
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DiscoverFromPath(Path As String) As Beacon.DiscoveredData
		  Var SavedFiles() As CURLSFileInfoMBS = Self.PrivateListFiles(Path)
		  If SavedFiles = Nil Then
		    Return Nil
		  End If
		  
		  Var LogsPath, ConfigPath As String
		  For Each Info As CURLSFileInfoMBS In SavedFiles
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
		  
		  Var ConfigFolders() As CURLSFileInfoMBS = Self.PrivateListFiles(ConfigPath)
		  If ConfigFolders = Nil Then
		    Return Nil
		  End If
		  
		  Var BaseURL As String = Self.BaseURL
		  Var Profile As New Beacon.FTPServerProfile(Beacon.FTPServerProfile(Self.Profile))
		  Var Data As New Beacon.DiscoveredData
		  Data.Profile = Profile
		  
		  For Each Info As CURLSFileInfoMBS In ConfigFolders
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
		    Var Logs() As CURLSFileInfoMBS = Self.PrivateListFiles(LogsPath)
		    If Logs <> Nil Then
		      Var Filenames() As String
		      For Each Info As CURLSFileInfoMBS In Logs
		        If Info.IsDirectory Or Info.Filename.BeginsWith("ShooterGame") = False Or Info.Filename.EndsWith(".log") = False Then
		          Continue
		        End If
		        
		        Filenames.AddRow(Info.Filename)
		      Next
		      Filenames.Sort
		      For Idx As Integer = Filenames.LastRowIndex DownTo 0
		        Var Contents As String = Self.DownloadFile(LogsPath + "/" + Filenames(Idx))
		        If Self.ParseLogFile(Data, Contents) Then
		          Exit
		        End If
		      Next
		    End If
		  End If
		  
		  Self.Log("Downloading ini files…")
		  Data.GameIniContent = Self.DownloadFile(BaseURL + Profile.GameIniPath).GuessEncoding
		  Data.GameUserSettingsIniContent = Self.DownloadFile(BaseURL + Profile.GameUserSettingsIniPath).GuessEncoding 
		  
		  Return Data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DownloadFile(Path As String) As String
		  Self.mSocketLock.Enter
		  Self.mSocket.OptionURL = Path
		  Call Self.mSocket.Perform
		  Var Response As String
		  If Self.mSocket.Lasterror = CURLSMBS.kError_OK Then
		    Response = Self.mSocket.OutputData
		  End If
		  Self.mSocketLock.Leave
		  Return Response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListFiles(Path As String)
		  If App.CurrentThread <> Nil Then
		    Var Files() As CURLSFileInfoMBS = Self.PrivateListFiles(Self.BaseURL + Path)
		    Var Params(1) As Variant
		    Params(0) = Path
		    Params(1) = Files
		    Call CallLater.Schedule(1, WeakAddressOf TriggerFilesListed, Params)
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
		Private Function ParseLogFile(Data As Beacon.DiscoveredData, Contents As String) As Boolean
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
		      Var InQuotes As Boolean
		      Var Characters() As String = CommandLine.Split("")
		      Var Buffer, Params() As String
		      For Each Char As String In Characters
		        If Char = """" Then
		          If InQuotes Then
		            Params.AddRow(Buffer)
		            Buffer = ""
		            InQuotes = False
		          Else
		            InQuotes = True
		          End If
		        ElseIf Char = " " Then
		          If InQuotes = False And Buffer.Length > 0 Then
		            Params.AddRow(Buffer)
		            Buffer = ""
		          End If
		        ElseIf Char = "-" And Buffer.Length = 0 Then
		          Continue
		        Else
		          Buffer = Buffer + Char
		        End If
		      Next
		      If Buffer.Length > 0 Then
		        Params.AddRow(Buffer)
		        Buffer = ""
		      End If
		      
		      Var StartupParams() As String = Params.Shift.Split("?")
		      Var Map As String = StartupParams.Shift
		      Call StartupParams.Shift // The listen statement
		      StartupParams.Merge(Params)
		      Params = StartupParams
		      
		      Data.Profile.Mask = Beacon.Maps.MaskForIdentifier(Map)
		      Data.CommandLineOptions = Params
		      
		      FoundCommandLine = True
		    End If
		  Next
		  Return FoundName And FoundCommandLine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PrivateListFiles(Path As String) As CURLSFileInfoMBS()
		  If Path.Right(2) = "/*" Then
		    // Good
		  ElseIf Path.Right(1) = "/" Then
		    Path = Path + "*"
		  Else
		    Path = Path + "/*"
		  End If
		  
		  Self.mSocketLock.Enter
		  Var Wildcard As Boolean = Self.mSocket.OptionWildcardMatch
		  Self.mSocket.OptionWildcardMatch = True
		  Self.mSocket.OptionURL = Path
		  Var Err As Integer = Self.mSocket.Perform
		  If Err <> CURLSMBS.kError_OK Then
		    Break
		  End If
		  Self.mSocket.OptionWildcardMatch = Wildcard
		  Var Files() As CURLSFileInfoMBS = Self.mSocket.FileInfos
		  Self.mSocketLock.Leave
		  Return Files
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerFilesListed(Value As Variant)
		  Var Params() As Variant = Value
		  RaiseEvent FilesListed(Params(0).StringValue, Params(1))
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event FilesListed(Path As String, Files() As CURLSFileInfoMBS)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mSocket As CURLSMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocketLock As CriticalSection
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
