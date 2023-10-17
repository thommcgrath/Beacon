#tag Class
Protected Class DiscoverIntegration
Inherits Beacon.DiscoverIntegration
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Function Run() As Beacon.Project
		  Var Provider As Beacon.HostingProvider = Self.Profile.CreateHostingProvider
		  If Provider Is Nil Then
		    Self.SetError("Failed to create hosting provider object")
		    Return Nil
		  End If
		  
		  Var DownloadIniFiles, GatherGameSettings As Boolean = True
		  
		  Var Data As New Ark.DiscoveredData
		  Var Profile As Ark.ServerProfile = Self.Profile
		  Select Case Provider
		  Case IsA Nitrado.HostingProvider
		    Self.Log("Checking server status…")
		    Try
		      Profile.BasePath = Provider.GameSetting(Self, Profile, "/game_specific.path")
		    Catch Err As RuntimeException
		      Self.SetError("Could not find server base path: " + Err.Message)
		      Return Nil
		    End Try
		    
		    Var ExpertMode As Boolean
		    Try
		      ExpertMode = Provider.GameSetting(Self, Profile, "general.expertMode")
		    Catch Err As RuntimeException
		      Self.SetError("Could not determine if the server is in expert mode: " + Err.Message)
		      Return Nil
		    End Try
		    
		    GatherGameSettings = False
		    DownloadIniFiles = ExpertMode
		    Data.CommandLineOptions = Beacon.ParseJSON(JSONItem(Provider.GameSetting(Self, Profile, "start-param")).ToString) // Weird way to convert JSONItem to Dictionary
		    
		    If ExpertMode = False Then
		      Var GuidedOrganizer As New Ark.ConfigOrganizer
		      Var Settings() As Ark.ConfigOption = Ark.DataSource.Pool.Get(False).GetConfigOptions("", "", "", False)
		      For Each Setting As Ark.ConfigOption In Settings
		        If Setting.HasNitradoEquivalent = False Then
		          Continue
		        End If
		        
		        Var Value As Variant
		        Try
		          Value = Provider.GameSetting(Self, Profile, Setting)
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
		      
		      Self.Log("Downloading extra " + Ark.ConfigFileGame + " content…")
		      Var ExtraGameIniPath As String = Profile.BasePath + "/user-settings.ini"
		      Var ExtraGameIniTransfer As New Beacon.IntegrationTransfer(ExtraGameIniPath)
		      Provider.DownloadFile(Self, Profile, ExtraGameIniTransfer, Beacon.Integration.DownloadFailureMode.MissingAllowed)
		      If Not ExtraGameIniTransfer.Success Then
		        Self.SetError("Failed to load extra " + Ark.ConfigFileGame + " content: " + ExtraGameIniTransfer.ErrorMessage)
		        Return Nil
		      End If
		      GuidedOrganizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, ExtraGameIniTransfer.Content)
		      
		      Data.GameIniContent = GuidedOrganizer.Build(Ark.ConfigFileGame)
		      Data.GameUserSettingsIniContent = GuidedOrganizer.Build(Ark.ConfigFileGameUserSettings)
		    End If
		  End Select
		  
		  If DownloadIniFiles Then
		    Var GameIniPath As String = Profile.GameIniPath
		    If GameIniPath.IsEmpty = False Then
		      Self.Log("Downloading " + Ark.ConfigFileGame + "…")
		      Var Transfer As New Beacon.IntegrationTransfer(GameIniPath)
		      Provider.DownloadFile(Self, Profile, Transfer, Beacon.Integration.DownloadFailureMode.Required)
		      If Not Transfer.Success Then
		        Self.SetError("Failed to load " + Ark.ConfigFileGame + ": " + Transfer.ErrorMessage)
		        Return Nil
		      End If
		      Data.GameIniContent = Transfer.Content
		    End If
		    Var GameUserSettingsIniPath As String = Profile.GameUserSettingsIniPath
		    If GameUserSettingsIniPath.IsEmpty = False Then
		      Self.Log("Downloading " + Ark.ConfigFileGameUserSettings + "…")
		      Var Transfer As New Beacon.IntegrationTransfer(GameUserSettingsIniPath)
		      Provider.DownloadFile(Self, Profile, Transfer, Beacon.Integration.DownloadFailureMode.Required)
		      If Not Transfer.Success Then
		        Self.SetError("Failed to load " + Ark.ConfigFileGameUserSettings + ": " + Transfer.ErrorMessage)
		        Return Nil
		      End If
		      Data.GameUserSettingsIniContent = Transfer.Content
		    End If
		  End If
		  
		  If GatherGameSettings And Provider.SupportsGameSettings Then
		    Var CommandLineOptions As New Dictionary
		    Var Settings() As Ark.ConfigOption = Ark.DataSource.Pool.Get(False).GetConfigOptions("", "", "", False)
		    For Each Setting As Ark.ConfigOption In Settings
		      Var Value As Variant
		      Try
		        Value = Provider.GameSetting(Self, Profile, Setting)
		        CommandLineOptions.Value(Setting.Key) = Value
		      Catch Err As RuntimeException
		        Self.SetError("Failed to get value for setting '" + Setting.Key + "': " + Err.Message)
		        Return Nil
		      End Try
		    Next
		    Data.CommandLineOptions = CommandLineOptions
		  End If
		  
		  Self.mImportProgress = New Beacon.DummyProgressDisplayer
		  Var Project As Ark.Project = Ark.ImportThread.RunSynchronous(Data, Self.mDestinationProject, Self.mImportProgress)
		  Self.mImportProgress = Nil
		  Return Project
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
