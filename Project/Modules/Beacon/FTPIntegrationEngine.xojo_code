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
		  
		  Var BaseURL As String
		  Var Files() As CURLSFileInfoMBS
		  Var PotentialPaths() As String
		  For Each Protocol As String In Protocols
		    If FTPProfile.Mode = Beacon.FTPServerProfile.ModeAuto Then
		      Self.Log("Attempting " + Protocol + " mode…")
		    End If
		    
		    Files = Self.ListFiles(Protocol + "://" + FTPProfile.Host + ":" + FTPProfile.Port.ToString)
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
		    
		    For Each Info As CURLSFileInfoMBS In Files
		      If Not Info.IsDirectory Then
		        Continue
		      End If
		      
		      If Info.Filename = "arkse" Or Info.Filename = "arkserer" Then
		        PotentialPaths.AddRow("/" + Info.FileName + "/ShooterGame/Saved")
		        PotentialPaths.AddRow("/" + Info.Filename + "/ShooterGame/SavedArks")
		      ElseIf Info.Filename = "ShooterGame" Then
		        PotentialPaths.AddRow("/ShooterGame/Saved")
		        PotentialPaths.AddRow("/ShooterGame/SavedArks")
		      ElseIf Info.Filename = "Saved" Then
		        PotentialPaths.AddRow("/Saved")
		      ElseIf Info.Filename = "SavedArks" Then
		        PotentialPaths.AddRow("/SavedArks")
		      ElseIf IPMatch.Search(Info.Filename) <> Nil Then
		        PotentialPaths.AddRow("/" + Info.Filename + "/ShooterGame/Saved")
		        PotentialPaths.AddRow("/" + Info.Filename + "/ShooterGame/SavedArks")
		      End If
		    Next
		    
		    BaseURL = Self.BaseURL
		    Exit
		  Next
		  
		  // None of them worked
		  If Files = Nil Then
		    Self.SetError("Unable to connect and list files.")
		    Return
		  End If
		  
		  Self.Log("Discovering paths…")
		  Var DiscoveredProfiles() As Beacon.FTPServerProfile
		  For Each Path As String In PotentialPaths
		    Var SavedFiles() As CURLSFileInfoMBS = Self.ListFiles(BaseURL + Path + "/*")
		    If SavedFiles = Nil Then
		      Continue
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
		      Continue
		    End If
		    
		    Var Profile As New Beacon.FTPServerProfile
		    Profile.Host = FTPProfile.Host
		    Profile.Port = FTPProfile.Port
		    Profile.Mode = FTPProfile.Mode
		    Profile.Username = FTPProfile.Username
		    Profile.Password = FTPProfile.Password
		    
		    Var ConfigFolders() As CURLSFileInfoMBS = Self.ListFiles(BaseURL + ConfigPath + "/*")
		    If ConfigFolders = Nil Then
		      Continue
		    End If
		    
		    For Each Info As CURLSFileInfoMBS In ConfigFolders
		      If Not Info.IsDirectory Then
		        Continue
		      End If
		      
		      Select Case Info.FileName
		      Case "WindowsServer", "LinuxServer", "WindowsNoEditor"
		        Profile.GameIniPath = ConfigPath + "/" + Info.Filename + "/Game.ini"
		        Profile.GameUserSettingsIniPath = ConfigPath + "/" + Info.Filename + "/GameUserSettings.ini"
		        Exit
		      End Select
		    Next
		    
		    If Profile.GameIniPath.Length = 0 Or Profile.GameUserSettingsIniPath.Length = 0 Then
		      Continue
		    End If
		    
		    If LogsPath.Length > 0 Then
		      Self.Log("Analyzing log files…")
		      Var Logs() As CURLSFileInfoMBS = Self.ListFiles(BaseURL + LogsPath)
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
		          Var Contents As String = Self.DownloadFile(BaseURL + LogsPath + "/" + Filenames(Idx))
		          If Self.ParseLogFile(Profile, Contents) Then
		            Exit
		          End If
		        Next
		      End If
		    End If
		    
		    DiscoveredProfiles.AddRow(Profile)
		  Next
		  
		  Break
		  
		  #if false
		    // If the files were not discovered, ask the user to find them
		    If FTPProfile.GameIniPath.Length = 0 Then
		      Var Controller As New Beacon.TaskWaitController("Locate Game.ini")
		      Self.Wait(Controller)
		      If Controller.Cancelled Then
		        Self.Cancel
		        Return
		      End If
		    End If
		  #endif
		  
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
		  Self.mSocket = New CURLSMBS
		  Call Self.mSocket.UseSystemCertificates
		  Self.mSocket.OptionUsername = Beacon.FTPServerProfile(Self.Profile).Username
		  Self.mSocket.OptionPassword = Beacon.FTPServerProfile(Self.Profile).Password
		  Self.mSocket.OptionTimeOut = 10
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DownloadFile(Path As String) As String
		  Self.mSocket.OptionURL = Path
		  Call Self.mSocket.Perform
		  If Self.mSocket.Lasterror = CURLSMBS.kError_OK Then
		    Return Self.mSocket.OutputData
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ListFiles(Path As String) As CURLSFileInfoMBS()
		  If Path.Right(2) = "/*" Then
		    // Good
		  ElseIf Path.Right(1) = "/" Then
		    Path = Path + "*"
		  Else
		    Path = Path + "/*"
		  End If
		  
		  Var Wildcard As Boolean = Self.mSocket.OptionWildcardMatch
		  Self.mSocket.OptionWildcardMatch = True
		  Self.mSocket.OptionURL = Path
		  Call Self.mSocket.Perform
		  Self.mSocket.OptionWildcardMatch = Wildcard
		  Return Self.mSocket.FileInfos
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseLogFile(Profile As Beacon.FTPServerProfile, Contents As String) As Boolean
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
		      Profile.Name = ServerName
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
		      
		      Profile.Mask = Beacon.Maps.MaskForIdentifier(Map)
		      // Something needs to happen with the parameters
		      
		      FoundCommandLine = True
		    End If
		  Next
		  Return FoundName And FoundCommandLine
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSocket As CURLSMBS
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
