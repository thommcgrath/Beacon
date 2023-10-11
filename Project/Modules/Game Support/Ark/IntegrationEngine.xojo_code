#tag Class
Protected Class IntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag CompatibilityFlags = (TargetDesktop and (Target32Bit))
	#tag Event
		Sub Deploy(InitialServerState As Beacon.ServerStatus.States)
		  Var Project As Ark.Project = Self.Project
		  Self.EnterResourceIntenseMode()
		  Var Organizer As Ark.ConfigOrganizer = Project.CreateConfigOrganizer(Self.Identity, Self.Profile)
		  Self.ExitResourceIntenseMode()
		  If Organizer Is Nil Then
		    Self.SetError("Could not generate new config data. Log files may have more info.")
		    Return
		  End If
		  
		  If Self.mDoGuidedDeploy And Self.SupportsWideSettings Then
		    Var GuidedSuccess As Boolean = RaiseEvent ApplySettings(Organizer)
		    If Self.Finished Then
		      Return
		    End If
		    
		    If GuidedSuccess Then
		      // Restart the server if it is running
		      If Self.SupportsRestarting And (InitialServerState = Beacon.ServerStatus.States.Running Or InitialServerState = Beacon.ServerStatus.States.Starting) Then
		        Self.StopServer()
		        // The starting is handled automatically
		      End If
		      
		      Return
		    Else
		      Self.mDoGuidedDeploy = False
		    End If
		  End If
		  
		  Var GameIniOriginal, GameUserSettingsIniOriginal As String
		  // Download the ini files
		  Var DownloadSuccess As Boolean
		  GameIniOriginal = Self.GetFile(Ark.ConfigFileGame, DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finished = True
		    Return
		  End If
		  GameUserSettingsIniOriginal = Self.GetFile(Ark.ConfigFileGameUserSettings, DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finished = True
		    Return
		  End If
		  
		  // Build the new ini files
		  Self.Log("Generating new ini files…")
		  
		  Var Format As Ark.Rewriter.EncodingFormat
		  If Self.Project.AllowUCS2 Then
		    Format = Ark.Rewriter.EncodingFormat.UCS2AndASCII
		  Else
		    Format = Ark.Rewriter.EncodingFormat.ASCII
		  End If
		  
		  Var UWPMode As Ark.Project.UWPCompatibilityModes = Project.UWPMode
		  RaiseEvent OverrideUWPMode(UWPMode)
		  
		  Var RewriteError As RuntimeException
		  
		  Self.EnterResourceIntenseMode()
		  Var GameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, GameIniOriginal, Ark.HeaderShooterGame, Ark.ConfigFileGame, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, UWPMode, Self.NukeEnabled, RewriteError)
		  Self.ExitResourceIntenseMode()
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  Self.EnterResourceIntenseMode()
		  Var GameUserSettingsIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, GameUserSettingsIniOriginal, Ark.HeaderServerSettings, Ark.ConfigFileGameUserSettings, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, UWPMode, Self.NukeEnabled, RewriteError)
		  Self.ExitResourceIntenseMode()
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  // Verify content looks acceptable
		  If Not Self.ValidateContent(GameUserSettingsIniRewritten, Ark.ConfigFileGameUserSettings) Then
		    Return
		  End If
		  If Not Self.ValidateContent(GameIniRewritten, Ark.ConfigFileGame) Then
		    Return
		  End If
		  
		  // Allow the user to review the new files if requested
		  If Self.ReviewEnabled And Self.Identity.IsBanned = False Then
		    If Self.AnalyzeEnabled Then
		      // Analyzer would go here
		    End If
		    
		    Var Dict As New Dictionary
		    Dict.Value(Ark.ConfigFileGame) = GameIniRewritten
		    Dict.Value(Ark.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
		    Dict.Value("Advice") = Nil // The results would go here
		    
		    Var Controller As New Beacon.TaskWaitController("Review Files", Dict)
		    
		    Self.Log("Waiting for user review")
		    Self.Wait(Controller)
		    If Controller.Cancelled Then
		      Return
		    End If
		  End If
		  
		  // Run the backup if requested
		  If Self.BackupEnabled Then
		    Var OldFiles As New Dictionary
		    OldFiles.Value(Ark.ConfigFileGame) = GameIniOriginal
		    OldFiles.Value(Ark.ConfigFileGameUserSettings) = GameUserSettingsIniOriginal
		    
		    Var NewFiles As New Dictionary
		    NewFiles.Value(Ark.ConfigFileGame) = GameIniRewritten
		    NewFiles.Value(Ark.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
		    
		    Self.RunBackup(OldFiles, NewFiles)
		    
		    If Self.Finished Then
		      Return
		    End If
		  End If
		  
		  // Stop the server
		  If Self.SupportsRestarting Then
		    Self.StopServer()
		  End If
		  
		  // Let the implementor do any final work
		  RaiseEvent ReadyToUpload()
		  
		  // Put the new files on the server
		  If Self.PutFile(GameIniRewritten, Ark.ConfigFileGame) = False Or Self.Finished Then
		    Self.Finished = True
		    Return
		  End If 
		  If Self.PutFile(GameUserSettingsIniRewritten, Ark.ConfigFileGameUserSettings) = False Or Self.Finished Then
		    Self.Finished = True
		    Return
		  End If
		  
		  // Make command line changes
		  If Self.SupportsWideSettings Then
		    Self.Log("Updating other settings…")
		    Call RaiseEvent ApplySettings(Organizer)
		    If Self.Finished Then
		      Return
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  // HostingProvider.ListServers takes a token instead of a profile because that's how it
		  // *should* work. However the discovery process uses one engine per dummy profile so
		  // we'll just adapt accordingly. Maybe some day discovery will be reworked.
		  
		  Var ExpertModeSetting As New Beacon.GenericGameSetting("general.expertMode")
		  Var PrimitivePlusSetting As New Beacon.GenericGameSetting("general.PrimitivePlus")
		  Var StartParamsSetting As New Beacon.GenericGameSetting("start-param")
		  Var ConfigPathSetting As New Beacon.GenericGameSetting("/game_specific.path")
		  
		  Var AllConfigs() As Ark.ConfigOption
		  Var DiscoveredData() As Beacon.DiscoveredData
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Self.Profile.ProviderTokenId, True)
		  Var Profiles() As Beacon.ServerProfile = Self.Provider.ListServers(Self, Token, Ark.Identifier)
		  For Each Profile As Beacon.ServerProfile In Profiles
		    Self.Log("Retrieving " + Profile.Name + "…")
		    
		    Var InExpertMode As Boolean = Self.Provider.GameSetting(Self, Profile, ExpertModeSetting)
		    Var IsPrimitivePlus As Boolean = Self.Provider.GameSetting(Self, Profile, PrimitivePlusSetting)
		    Var ConfigPath As String = Self.Provider.GameSetting(Self, Profile, ConfigPathSetting)
		    
		    Var Server As New Ark.NitradoDiscoveredData(Profile.ProviderServiceId, Token.AccessToken, ConfigPath, IsPrimitivePlus)
		    Server.Profile = Profile
		    Server.CommandLineOptions = Self.Provider.GameSetting(Self, Profile, StartParamsSetting)
		    
		    If InExpertMode = False Then
		      If AllConfigs.Count = 0 Then
		        AllConfigs = Ark.DataSource.Pool.Get(False).GetConfigOptions("", "", "", False) // To retrieve all
		      End If
		      Var GuidedOrganizer As New Ark.ConfigOrganizer
		      For Each ConfigOption As Ark.ConfigOption In AllConfigs
		        If ConfigOption.HasNitradoEquivalent = False Then
		          Continue
		        End If
		        
		        Var Value As String = Self.Provider.GameSetting(Self, Profile, ConfigOption).StringValue.ReplaceLineEndings(EndOfLine.UNIX)
		        If ConfigOption.ValueType = Ark.ConfigOption.ValueTypes.TypeBoolean Then
		          Var IsTrue As Boolean = (Value = "True") Or (Value = "1")
		          Var Reversed As NullableBoolean = NullableBoolean.FromVariant(ConfigOption.Constraint("nitrado.boolean.reversed"))
		          If (Reversed Is Nil) = False And Reversed.BooleanValue Then
		            IsTrue = Not IsTrue
		          End If
		          Value = If(IsTrue, "True", "False")
		        End If
		        
		        Select Case ConfigOption.NitradoFormat
		        Case Ark.ConfigOption.NitradoFormats.Value
		          GuidedOrganizer.Add(New Ark.ConfigValue(ConfigOption, ConfigOption.Key + "=" + Value))
		        Case Ark.ConfigOption.NitradoFormats.Line
		          Var Lines() As String = Value.Split(EndOfLine.UNIX)
		          For LineIdx As Integer = 0 To Lines.LastIndex
		            GuidedOrganizer.Add(New Ark.ConfigValue(ConfigOption, Lines(LineIdx), LineIdx))
		          Next
		        End Select
		      Next
		      
		      Var ExtraGameIniSuccess As Boolean
		      Var ExtraGameIni As String = Self.GetFile(GameSpecific.Value("path") + "user-settings.ini", DownloadFailureMode.MissingAllowed, Profile, False, ExtraGameIniSuccess)
		      If ExtraGameIniSuccess = False Or Self.Finished Then
		        Continue
		      End If
		      GuidedOrganizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, ExtraGameIni)
		      
		      Server.GameIniContent = GuidedOrganizer.Build(Ark.ConfigFileGame)
		      Server.GameUserSettingsIniContent = GuidedOrganizer.Build(Ark.ConfigFileGameUserSettings)
		    Else
		      // This is normally where the ini files would be downloaded, but the NitradoDiscoveredData class will handle that on demand.
		    End If
		    
		    DiscoveredData.Add(Server)
		  Next
		  
		  Return DiscoveredData
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ApplySettings(Organizer As Ark.ConfigOrganizer)
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Var Keys() As Ark.ConfigOption = Organizer.DistinctKeys
		    Var NewValues As New Dictionary
		    Var KeysForPath As New Dictionary
		    Var ExtraGameIniOrganizer As New Ark.ConfigOrganizer
		    
		    // First we need to determine if guided mode *can* be supported.
		    // Nitrado values are limited to 65,535 characters and not all GameUserSettings.ini
		    // configs are supported in guided mode.
		    
		    For Each ConfigOption As Ark.ConfigOption In Keys
		      If Self.mDoGuidedDeploy And ConfigOption.File = Ark.ConfigFileGameUserSettings And ConfigOption.HasNitradoEquivalent = False Then
		        // Expert mode required because this config cannot be supported.
		        App.Log("Cannot use guided deploy because the key " + ConfigOption.SimplifiedKey + " needs to be in GameUserSettings.ini but Nitrado does not have a config for it.")
		        Self.SwitchToExpertMode(ConfigOption.Key, 0)
		        Return
		      End If
		      
		      If ConfigOption.HasNitradoEquivalent = False Then
		        If Self.mDoGuidedDeploy And ConfigOption.File = Ark.ConfigFileGame Then
		          ExtraGameIniOrganizer.Add(Organizer.FilteredValues(ConfigOption))
		        End If
		        Continue
		      End If
		      
		      Var SendToNitrado As Boolean = ConfigOption.NitradoDeployStyle = Ark.ConfigOption.NitradoDeployStyles.Both Or ConfigOption.NitradoDeployStyle = If(Self.mDoGuidedDeploy, Ark.ConfigOption.NitradoDeployStyles.Guided, Ark.ConfigOption.NitradoDeployStyles.Expert)
		      If SendToNitrado = False Then
		        Continue
		      End If
		      
		      Var NitradoPaths() As String = ConfigOption.NitradoPaths
		      Var Values() As Ark.ConfigValue = Organizer.FilteredValues(ConfigOption)
		      For Each NitradoPath As String In NitradoPaths
		        KeysForPath.Value(NitradoPath) = ConfigOption
		        
		        Select Case ConfigOption.NitradoFormat
		        Case Ark.ConfigOption.NitradoFormats.Line
		          Var Lines() As String
		          If NewValues.HasKey(NitradoPath) Then
		            Lines = NewValues.Value(NitradoPath)
		          End If
		          For Each Value As Ark.ConfigValue In Values
		            Lines.Add(Value.Command)
		          Next
		          NewValues.Value(NitradoPath) = Lines
		        Case Ark.ConfigOption.NitradoFormats.Value
		          If Values.Count >= 1 Then
		            Var Value As String = Values(Values.LastIndex).Value
		            
		            If ConfigOption.ValueType = Ark.ConfigOption.ValueTypes.TypeBoolean Then
		              Value = Value.Lowercase
		              
		              Var Reversed As NullableBoolean = NullableBoolean.FromVariant(ConfigOption.Constraint("nitrado.boolean.reversed"))
		              If (Reversed Is Nil) = False And Reversed.BooleanValue Then
		                Value = If(Value = "true", "false", "true")
		              End If
		            End If
		            
		            NewValues.Value(NitradoPath) = Value
		          Else
		            // This doesn't make sense
		            Break
		          End If
		        End Select
		      Next
		    Next
		    
		    Var Changes As New Dictionary
		    For Each Entry As DictionaryEntry In NewValues
		      Var NitradoPath As String = Entry.Key
		      Var ConfigOption As Ark.ConfigOption = KeysForPath.Value(NitradoPath)
		      Var CurrentValue As String = Self.GetViaDotNotation(Self.mCurrentSettings, NitradoPath)
		      Var FinishedValue As String
		      If Entry.Value.Type = Variant.TypeString Then
		        // Value comparison
		        If ConfigOption.ValuesEqual(Entry.Value.StringValue, CurrentValue) Then
		          Continue
		        End If
		        FinishedValue = Entry.Value.StringValue
		      ElseIf Entry.Value.IsArray And Entry.Value.ArrayElementType = Variant.TypeString Then
		        // Line comparison, but if there is only one line, go back to value comparison
		        Var NewLines() As String = Entry.Value
		        FinishedValue = NewLines.Join(EndOfLine) // Prepare the finished value before sorting, even if we nay not use it
		        
		        Var CurrentLines() As String = CurrentValue.ReplaceLineEndings(EndOfLine.UNIX).Split(EndOfLine.UNIX)
		        
		        If NewLines.Count = 1 And CurrentLines.Count = 1 And (ConfigOption.ValueType = Ark.ConfigOption.ValueTypes.TypeNumeric Or ConfigOption.ValueType = Ark.ConfigOption.ValueTypes.TypeBoolean Or ConfigOption.ValueType = Ark.ConfigOption.ValueTypes.TypeBoolean) Then
		          Var NewValue As String = NewLines(0).Middle(NewLines(0).IndexOf("=") + 1)
		          CurrentValue = CurrentLines(0).Middle(CurrentLines(0).IndexOf("=") + 1)
		          If ConfigOption.ValuesEqual(NewValue, CurrentValue) Then
		            Continue
		          End If
		          FinishedValue = NewLines(0)
		        Else
		          NewLines.Sort
		          CurrentLines.Sort
		          Var NewHash As String = EncodeHex(Crypto.SHA1(NewLines.Join(EndOfLine.UNIX).Lowercase))
		          Var CurrentHash As String = EncodeHex(Crypto.SHA1(CurrentLines.Join(EndOfLine.UNIX).Lowercase))
		          If NewHash = CurrentHash Then
		            // No change
		            Continue
		          End If
		        End If
		      Else
		        Continue
		      End If
		      
		      If Self.mDoGuidedDeploy And FinishedValue.Length > 65535 Then
		        App.Log("Cannot use guided deploy because the key " + ConfigOption.SimplifiedKey + " needs " + FinishedValue.Length.ToString(Locale.Current, "#,##0") + " characters, and Nitrado has a limit of 65,535 characters.")
		        Self.SwitchToExpertMode(ConfigOption.Key, FinishedValue.Length)
		        Return
		      End If
		      
		      Changes.Value(NitradoPath) = FinishedValue
		    Next
		    
		    If Self.mDoGuidedDeploy Then
		      // Generate a new user-settings.ini file
		      Var ExtraGameIniSuccess As Boolean
		      Var ExtraGameIni As String = Self.GetFile(Self.mGamePath + "user-settings.ini", DownloadFailureMode.MissingAllowed, False, ExtraGameIniSuccess)
		      If ExtraGameIniSuccess = False Or Self.Finished Then
		        Self.Finished = True
		        Return
		      End If
		      If ExtraGameIni.BeginsWith("[" + Ark.HeaderShooterGame + "]") = False Then
		        ExtraGameIni = "[" + Ark.HeaderShooterGame + "]" + EndOfLine.UNIX + ExtraGameIni
		      End If
		      Var RewriteError As RuntimeException
		      Var ExtraGameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, ExtraGameIni, Ark.HeaderShooterGame, Ark.ConfigFileGame, ExtraGameIniOrganizer, Self.Project.ProjectId, Self.Project.LegacyTrustKey, If(Self.Project.AllowUCS2, Ark.Rewriter.EncodingFormat.UCS2AndASCII, Ark.Rewriter.EncodingFormat.ASCII), Ark.Project.UWPCompatibilityModes.Never, Self.NukeEnabled, RewriteError)
		      If (RewriteError Is Nil) = False Then
		        Self.SetError(RewriteError)
		        Return
		      End If
		      
		      // Need to remove the header that the rewriter adds
		      ExtraGameIniRewritten = ExtraGameIniRewritten.Replace("[" + Ark.HeaderShooterGame + "]", "").Trim
		      
		      // Create a checkpoint before making changes
		      If Self.BackupEnabled Then
		        Var OldFiles As New Dictionary
		        OldFiles.Value("Config.json") = Beacon.GenerateJSON(Self.mCurrentSettings, True)
		        OldFiles.Value("user-settings.ini") = ExtraGameIni
		        
		        Var NewSettings As Dictionary = Self.mCurrentSettings.Clone
		        For Each Entry As DictionaryEntry In Changes
		          Var NitradoPath As String = Entry.Key
		          Var NewValue As String = Entry.Value
		          
		          Var CategoryLength As Integer = NitradoPath.IndexOf(".")
		          Var Category As String = NitradoPath.Left(CategoryLength)
		          Var Key As String = NitradoPath.Middle(CategoryLength + 1)
		          
		          Var CategoryDict As Dictionary = NewSettings.Value(Category)
		          CategoryDict.Value(Key) = NewValue
		        Next
		        
		        Var NewFiles As New Dictionary
		        NewFiles.Value("Config.json") = Beacon.GenerateJSON(NewSettings, True)
		        NewFiles.Value("user-settings.ini") = ExtraGameIniRewritten
		        
		        Self.RunBackup(OldFiles, NewFiles)
		        
		        If Self.Finished Then
		          Return
		        End If
		      End If
		      
		      If Not Self.PutFile(ExtraGameIniRewritten, Self.mGamePath + "user-settings.ini") Then
		        Self.Finished = True
		        Return
		      End If
		      If Self.Finished Then
		        Return
		      End If
		    End If
		    
		    // Deploy changes
		    For Each Entry As DictionaryEntry In Changes
		      Var NitradoPath As String = Entry.Key
		      Var NewValue As String = Entry.Value
		      
		      Var CategoryLength As Integer = NitradoPath.IndexOf(".")
		      Var Category As String = NitradoPath.Left(CategoryLength)
		      Var Key As String = NitradoPath.Middle(CategoryLength + 1)
		      Var FormData As New Dictionary
		      FormData.Value("category") = Category
		      FormData.Value("key") = Key
		      FormData.Value("value") = NewValue
		      
		      Self.Log("Updating " + Key + "…")
		      
		      Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		      Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		      Sock.SetFormData(FormData)
		      Self.SendRequest(Sock, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings")
		      If Self.Finished Or Self.CheckError(Sock) Then
		        Return
		      End If
		      Var Content As String = Sock.LastString
		      Var Status As Integer = Sock.LastHTTPStatus
		      
		      Try
		        Var Response As Dictionary = Beacon.ParseJSON(Content)
		        If Response.Value("status") <> "success" Then
		          Self.SetError("Error: Unable to change setting: " + FormData.Value("category").StringValue + "." + FormData.Value("value").StringValue)
		          Return
		        End If
		      Catch Err As RuntimeException
		        App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		        Self.SetError(Err)
		        Return
		      End Try
		      
		      // So we don't go nuts
		      Thread.SleepCurrent(100)
		    Next
		    
		    Return
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As Beacon.HostingProvider, Profile As Beacon.ServerProfile)
		  If (Profile Is Nil) = False And Profile.GameId <> Ark.Identifier Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Incorrect server profile for integration engine. Expected " + Ark.Identifier + ", got " + Profile.GameId + "."
		    Raise Err
		  End If
		  
		  Super.Constructor(Provider, Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Project() As Ark.Project
		  Return Ark.Project(Super.Project())
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchToExpertMode(OffendingKey As String, ContentLength As Integer)
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Var UserData As New Dictionary
		    UserData.Value("OffendingKey") = OffendingKey
		    UserData.Value("ContentLength") = ContentLength
		    Var Controller As New Beacon.TaskWaitController("Needs Expert Mode", UserData)
		    
		    Self.Log("Waiting for user action…")
		    Self.Wait(Controller)
		    Self.RemoveLastLog()
		    If Controller.Cancelled Then
		      Self.Cancel
		      Return
		    End If
		    
		    // Create a checkpoint now
		    If Self.BackupEnabled Then
		      Self.CreateCheckpoint()
		      If Self.Finished Then
		        Return
		      End If
		    End If
		    
		    // Start the server, returning it to its previous state
		    Self.Log("Enabling expert mode…")
		    Select Case Self.State.State
		    Case Beacon.ServerStatus.States.Stopped, Beacon.ServerStatus.States.Stopping
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
		    Case Beacon.ServerStatus.States.Running, Beacon.ServerStatus.States.Starting
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
		    
		    Var Setting As New Beacon.GenericGameSetting("general.expertMode")
		    Try
		      Self.Provider.GameSetting(Self, Setting) = True
		    Catch Err As RuntimeException
		      Self.SetError("Could not enable expert mode: " + Err.Message)
		      Return
		    End Try
		    
		    Self.Log("Expert mode enabled.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValidateContent(Content As String, Filename As String) As Boolean
		  Var MissingHeaders() As String = Ark.ValidateIniContent(Content, Filename)
		  
		  If MissingHeaders.Count = 0 Then
		    Return True
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("File") = Filename
		  Dict.Value("Groups") = MissingHeaders
		  If MissingHeaders.Count > 1 Then
		    Dict.Value("Message") = Filename + " is not valid because it is missing the following groups: " + MissingHeaders.EnglishOxfordList + "."
		  Else
		    Dict.Value("Message") = Filename + " is not valid because it is missing its " + MissingHeaders(0) + " group."
		  End If
		  
		  Var Controller As New Beacon.TaskWaitController("ValidationFailed", Dict)
		  
		  Self.Log("Content validation failed!")
		  Self.Wait(Controller)
		  If Controller.Cancelled Then
		    Self.SetError(Dict.Value("Message").StringValue)
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ApplySettings(Organizer As Ark.ConfigOrganizer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Discover() As Beacon.DiscoveredData()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OverrideUWPMode(ByRef UWPMode As Ark.Project.UWPCompatibilityModes)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadyToUpload()
	#tag EndHook


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
