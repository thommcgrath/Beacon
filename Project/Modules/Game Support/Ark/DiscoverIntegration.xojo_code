#tag Class
Protected Class DiscoverIntegration
Inherits Beacon.DiscoverIntegration
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function Run() As Beacon.Project
		  Var Project As Beacon.Project = Self.Project
		  Var Provider As Beacon.HostingProvider = Self.Provider
		  Var DownloadIniFiles, GatherGameSettings As Boolean = True
		  Var GetMapFromLogs As Boolean = True
		  
		  Var Profile As Ark.ServerProfile = Self.Profile
		  Var Data As New Ark.DiscoveredData
		  Data.Profile = Profile
		  Select Case Provider
		  Case IsA Nitrado.HostingProvider
		    Self.Log("Checking server status…")
		    Try
		      Profile.BasePath = Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, "/game_specific.path")
		    Catch Err As RuntimeException
		      Self.SetError("Could not find server base path: " + Err.Message)
		      Return Nil
		    End Try
		    
		    Try
		      Var MapIdentifier As String = Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, "config.map")
		      Profile.Mask = Ark.Maps.MaskForIdentifier(MapIdentifier.LastField(","))
		      GetMapFromLogs = False
		    Catch Err As RuntimeException
		      Self.SetError("Could not find server map: " + Err.Message)
		      Return Nil
		    End Try
		    
		    Var ExpertMode As Boolean
		    Try
		      ExpertMode = Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, "general.expertMode")
		    Catch Err As RuntimeException
		      Self.SetError("Could not determine if the server is in expert mode: " + Err.Message)
		      Return Nil
		    End Try
		    
		    GatherGameSettings = False
		    DownloadIniFiles = ExpertMode
		    Data.CommandLineOptions = Beacon.ParseJSON(JSONItem(Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, "start-param")).ToString(False)) // Weird way to convert JSONItem to Dictionary
		    
		    If ExpertMode = False Then
		      Var GuidedOrganizer As New Ark.ConfigOrganizer
		      Var Settings() As Ark.ConfigOption = Ark.DataSource.Pool.Get(False).GetConfigOptions("", "", "", False)
		      For Each Setting As Ark.ConfigOption In Settings
		        If Setting.HasNitradoEquivalent = False Then
		          Continue
		        End If
		        
		        Var Value As Variant
		        Try
		          Var Paths() As String = Setting.NitradoPaths
		          Value = Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, Paths(0))
		        Catch Err As RuntimeException
		          Self.SetError("Failed to get value for setting '" + Setting.Key + "': " + Err.Message)
		          Return Nil
		        End Try
		        
		        Select Case Setting.NitradoFormat
		        Case Ark.ConfigOption.NitradoFormats.Value
		          GuidedOrganizer.Add(New Ark.ConfigValue(Setting, Setting.Key + "=" + Value))
		        Case Ark.ConfigOption.NitradoFormats.Line
		          Var Lines() As String = Value.StringValue.Split(EndOfLine.UNIX)
		          For LineIdx As Integer = 0 To Lines.LastIndex
		            GuidedOrganizer.Add(New Ark.ConfigValue(Setting, Lines(LineIdx), LineIdx))
		          Next
		        End Select
		      Next
		      
		      Var DownloadSuccess As Boolean
		      Var ExtraGameIniContent As String = Self.GetFile(Profile.BasePath + "/user-settings.ini", "user-settings.ini", Beacon.Integration.DownloadFailureMode.MissingAllowed, Profile, False, DownloadSuccess)
		      If Not DownloadSuccess Then
		        Return Nil
		      End If
		      GuidedOrganizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, ExtraGameIniContent)
		      
		      Data.GameIniContent = GuidedOrganizer.Build(Ark.ConfigFileGame)
		      Data.GameUserSettingsIniContent = GuidedOrganizer.Build(Ark.ConfigFileGameUserSettings)
		    End If
		  End Select
		  
		  If DownloadIniFiles Then
		    Var LogsPath As String = Profile.LogsPath
		    If LogsPath.IsEmpty = False Then
		      Var PathSeparator As String = If(LogsPath.Contains("/"), "/", "\")
		      Var LogFilePath As String = LogsPath + PathSeparator + "ShooterGame.log"
		      Var DownloadSuccess As Boolean
		      Var LogContents As String = Self.GetFile(LogFilePath, "ShooterGame.log", Beacon.Integration.DownloadFailureMode.ErrorsAllowed, Profile, False, DownloadSuccess)
		      If DownloadSuccess Then
		        Var Lines() As String = LogContents.GuessEncoding("Primal Game Data Took").Split(EndOfLine)
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
		            Var Options As Dictionary = Ark.ParseCommandLine(CommandLine)
		            If GetMapFromLogs Then
		              Profile.Mask = Ark.Maps.MaskForIdentifier(Options.Value("Map"))
		            End If
		            Data.CommandLineOptions = Options
		            FoundCommandLine = True
		          End If
		          
		          If FoundName And FoundCommandLine Then
		            Exit For Line
		          End If
		        Next
		      End If
		    End If
		    
		    Var GameIniPath As String = Profile.GameIniPath
		    If GameIniPath.IsEmpty = False Then
		      Var DownloadSuccess As Boolean
		      Var IniContent As String = Self.GetFile(GameIniPath, Ark.ConfigFileGame, Beacon.Integration.DownloadFailureMode.Required, Profile, False, DownloadSuccess)
		      If DownloadSuccess Then
		        Data.GameIniContent = IniContent.GuessEncoding("/script/")
		      Else
		        Return Nil
		      End If
		    End If
		    
		    Var GameUserSettingsIniPath As String = Profile.GameUserSettingsIniPath
		    If GameUserSettingsIniPath.IsEmpty = False Then
		      Var DownloadSuccess As Boolean
		      Var IniContent As String = Self.GetFile(GameUserSettingsIniPath, Ark.ConfigFileGameUserSettings, Beacon.Integration.DownloadFailureMode.Required, Profile, False, DownloadSuccess)
		      If DownloadSuccess Then
		        Data.GameUserSettingsIniContent = IniContent.GuessEncoding("/script/")
		      Else
		        Return Nil
		      End If
		    End If
		  End If
		  
		  Select Case Provider
		  Case IsA Nitrado.HostingProvider
		    Var ExpertMode As Boolean
		    Try
		      ExpertMode = Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, "general.expertMode")
		    Catch Err As RuntimeException
		      Self.SetError("Could not determine if the server is in expert mode: " + Err.Message)
		      Return Nil
		    End Try
		    
		    Var CommandLineOptions As New Dictionary
		    Var Settings() As Ark.ConfigOption = Ark.DataSource.Pool.Get(False).GetConfigOptions("", "", "", False)
		    For Each Setting As Ark.ConfigOption In Settings
		      If Setting.NitradoMatchesDeployStyle(ExpertMode) = False Then
		        Continue
		      End If
		      
		      Var Value As Variant
		      Try
		        Var Paths() As String = Setting.NitradoPaths
		        Value = Nitrado.HostingProvider(Provider).GameSetting(Project, Profile, Paths(0))
		        If Value.IsNull = False Then
		          CommandLineOptions.Value(Setting.Key) = Value
		        End If
		      Catch Err As RuntimeException
		        Self.SetError("Failed to get value for setting '" + Setting.Key + "': " + Err.Message)
		        Return Nil
		      End Try
		    Next
		    Data.CommandLineOptions = CommandLineOptions
		  Case IsA GameServerApp.HostingProvider
		    Var ChainDownloaded As Boolean
		    Var Chain As String = Self.GetFile("chain", "Launch Options: Chain", Beacon.Integration.DownloadFailureMode.MissingAllowed, False, ChainDownloaded)
		    
		    Var TailDownloaded As Boolean
		    Var Tail As String = Self.GetFile("end", "Launch Options: End", Beacon.Integration.DownloadFailureMode.MissingAllowed, False, TailDownloaded)
		    
		    Var Launch As String = "TheIsland?listen" + Chain + " " + Tail
		    Var CommandLine As Dictionary = Ark.ParseCommandLine(Launch, False)
		    If CommandLine.HasKey("?Map") Then
		      CommandLine.Remove("?Map")
		    ElseIf CommandLine.HasKey("Map") Then
		      CommandLine.Remove("Map")
		    End If
		    Data.CommandLineOptions = CommandLine
		  End Select
		  
		  Self.mImportProgress = New Beacon.DummyProgressDisplayer
		  Var NewProject As Ark.Project = Ark.ImportThread.RunSynchronous(Data, Self.mDestinationProject, Self.mImportProgress)
		  Self.mImportProgress = Nil
		  Return NewProject
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin(DestinationProject As Ark.Project)
		  Self.mDestinationProject = DestinationProject
		  Super.Begin()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusMessage() As String
		  If (Self.mImportProgress Is Nil) = False Then
		    Return Self.mImportProgress.Detail
		  Else
		    Return Super.StatusMessage
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDestinationProject As Ark.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportProgress As Beacon.DummyProgressDisplayer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ThreadPriority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
