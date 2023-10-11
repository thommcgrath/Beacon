#tag Class
Protected Class DeployIntegration
Inherits Beacon.DeployIntegration
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub Run()
		  Self.RefreshServerStatus()
		  If Self.Finished Then
		    Return
		  End If
		  
		  Var InitialStatus As Beacon.ServerStatus = Self.Status
		  Var Project As Ark.Project = Self.Project
		  Var Profile As Ark.ServerProfile = Self.Profile
		  
		  Var GameIniPath, GameUserSettingsIniPath As String
		  
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Var GameServer As JSONItem = InitialStatus.UserData
		    Var GamePath As String = GameServer.Child("game_specific").Value("path").StringValue
		    If GamePath.EndsWith("/") Then
		      GamePath = GamePath.Left(GamePath.Length - 1)
		    End If
		    
		    Self.Profile.SecondaryName = GameServer.Value("ip").StringValue + ":" + GameServer.Value("port").IntegerValue.ToString(Locale.Raw, "0") + " (" + GameServer.Value("service_id").IntegerValue.ToString(Locale.Raw, "0") + ")"
		    Self.Profile.BasePath = GamePath
		    Self.Profile.GameIniPath = GamePath + "/ShooterGame/Saved/Config/WindowsServer/Game.ini"
		    Self.Profile.GameUserSettingsIniPath = GamePath + "/ShooterGame/Saved/Config/WindowsServer/GameUserSettings.ini"
		    Self.Profile.LogsPath = GamePath + "/ShooterGame/Saved/Logs"
		    
		    Var Config As JSONItem = GameServer.Child("settings").Child("config")
		    Var Map As String = Config.Value("map").StringValue
		    Self.Profile.Mask = Ark.Maps.MaskForIdentifier(Map.LastField("."))
		  Else
		    Self.SetError("Unknown hosting provider")
		    Return
		  End Select
		  
		  Self.EnterResourceIntenseMode()
		  Var Organizer As Ark.ConfigOrganizer = Project.CreateConfigOrganizer(Self.Identity, Profile)
		  Self.ExitResourceIntenseMode()
		  If Organizer Is Nil Then
		    Self.SetError("Could not generate new config data. Log files may have more info.")
		    Return
		  End If
		  
		  If Self.Provider IsA Nitrado.HostingProvider Then
		    Var GameServer As JSONItem = InitialStatus.UserData
		    Var Settings As JSONItem = GameServer.Child("settings")
		    Var General As JSONItem = Settings.Child("general")
		    Var InExpertMode As Boolean = General.Value("expertMode")
		    
		    If InExpertMode = False Then
		      Var GuidedSuccess As Boolean = Self.NitradoApplySettings(Organizer, True)
		      If Self.Finished Then
		        Return
		      End If
		      
		      If GuidedSuccess Then
		        // Restart the server if it is running
		        If Self.Provider.SupportsRestarting And (InitialStatus = Beacon.ServerStatus.States.Running Or InitialStatus = Beacon.ServerStatus.States.Starting) Then
		          Self.StopServer()
		          // The starting is handled automatically
		        End If
		        
		        Return
		      End If
		    End If
		  End If
		  
		  Var GameIniOriginal, GameUserSettingsIniOriginal As String
		  // Download the ini files
		  Var DownloadSuccess As Boolean
		  GameIniOriginal = Self.GetFile(GameIniPath, Beacon.Integration.DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finish()
		    Return
		  End If
		  GameUserSettingsIniOriginal = Self.GetFile(GameUserSettingsIniPath, Beacon.Integration.DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finish()
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
		  If Self.Provider IsA Nitrado.HostingProvider Then
		    UWPMode = Ark.Project.UWPCompatibilityModes.Never
		  End If
		  
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
		  Self.StopServer()
		  
		  // Let the implementor do any final work
		  If Self.Provider IsA Nitrado.HostingProvider Then
		    Self.NitradoCooldownWait()
		  End If
		  
		  // Put the new files on the server
		  If Self.PutFile(GameIniRewritten, GameIniPath) = False Or Self.Finished Then
		    Self.Finish()
		    Return
		  End If 
		  If Self.PutFile(GameUserSettingsIniRewritten, GameUserSettingsIniPath) = False Or Self.Finished Then
		    Self.Finish()
		    Return
		  End If
		  
		  // Make command line changes
		  If Self.Provider.SupportsGameSettings Then
		    Self.Log("Updating other settings…")
		    Call Self.ApplySettings(Organizer, False)
		    If Self.Finished Then
		      Return
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function Wait(Controller As Beacon.TaskWaitController) As Boolean
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function ApplySettings(Organizer As Ark.ConfigOrganizer, Full As Boolean) As Boolean
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Return Self.NitradoApplySettings(Organizer, Full)
		  Else
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NitradoApplySettings(Organizer As Ark.ConfigOrganizer, Full As Boolean) As Boolean
		  If (Self.Provider IsA Nitrado.HostingProvider) = False Then
		    Return False
		  End If
		  
		  Var Profile As Ark.ServerProfile = Self.Profile
		  Var Keys() As Ark.ConfigOption = Organizer.DistinctKeys
		  Var NewValues As New Dictionary
		  Var ExtraGameIniOrganizer As New Ark.ConfigOrganizer
		  Var Style As Ark.ConfigOption.NitradoDeployStyles = If(Full, Ark.ConfigOption.NitradoDeployStyles.Guided, Ark.ConfigOption.NitradoDeployStyles.Expert)
		  
		  // First we need to determine if guided mode *can* be supported.
		  // Nitrado values are limited to 65,535 characters and not all GameUserSettings.ini
		  // configs are supported in guided mode.
		  
		  For Each ConfigOption As Ark.ConfigOption In Keys
		    If Full And ConfigOption.File = Ark.ConfigFileGameUserSettings And ConfigOption.HasNitradoEquivalent = False Then
		      // Expert mode required because this config cannot be supported.
		      App.Log("Cannot use guided deploy because the key " + ConfigOption.SimplifiedKey + " needs to be in GameUserSettings.ini but Nitrado does not have a config for it.")
		      Self.SwitchToExpertMode(ConfigOption.Key, 0)
		      Return False
		    End If
		    
		    If ConfigOption.HasNitradoEquivalent = False Then
		      If Full And ConfigOption.File = Ark.ConfigFileGame Then
		        ExtraGameIniOrganizer.Add(Organizer.FilteredValues(ConfigOption))
		      End If
		      Continue
		    End If
		    
		    Var SendToNitrado As Boolean = ConfigOption.NitradoDeployStyle = Ark.ConfigOption.NitradoDeployStyles.Both Or ConfigOption.NitradoDeployStyle = Style
		    If SendToNitrado = False Then
		      Continue
		    End If
		    
		    Var Values() As Ark.ConfigValue = Organizer.FilteredValues(ConfigOption)
		    
		    Select Case ConfigOption.NitradoFormat
		    Case Ark.ConfigOption.NitradoFormats.Line
		      Var Lines() As String
		      For Each Value As Ark.ConfigValue In Values
		        Lines.Add(Value.Command)
		      Next
		      NewValues.Value(ConfigOption) = Lines
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
		        
		        NewValues.Value(ConfigOption) = Value
		      Else
		        // This doesn't make sense
		        Break
		      End If
		    End Select
		  Next
		  
		  Var Changes As New Dictionary
		  For Each Entry As DictionaryEntry In NewValues
		    Var ConfigOption As Ark.ConfigOption = Entry.Key
		    Var CurrentValue As Variant = Self.Provider.GameSetting(Self, Profile, ConfigOption)
		    Var FinishedValue As String
		    If Entry.Value.Type = Variant.TypeString Then
		      // Value comparison
		      If ConfigOption.ValuesEqual(Entry.Value, CurrentValue) Then
		        Continue
		      End If
		      FinishedValue = Entry.Value.StringValue
		    ElseIf Entry.Value.IsArray And Entry.Value.ArrayElementType = Variant.TypeString Then
		      // Line comparison, but if there is only one line, go back to value comparison
		      Var NewLines() As String = Entry.Value
		      FinishedValue = NewLines.Join(EndOfLine) // Prepare the finished value before sorting, even if we nay not use it
		      
		      Var CurrentLines() As String = CurrentValue.StringValue.ReplaceLineEndings(EndOfLine.UNIX).Split(EndOfLine.UNIX)
		      
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
		    
		    If Full And FinishedValue.Length > 65535 Then
		      App.Log("Cannot use guided deploy because the key " + ConfigOption.SimplifiedKey + " needs " + FinishedValue.Length.ToString(Locale.Current, "#,##0") + " characters, and Nitrado has a limit of 65,535 characters.")
		      Self.SwitchToExpertMode(ConfigOption.Key, FinishedValue.Length)
		      Return False
		    End If
		    
		    Changes.Value(ConfigOption) = FinishedValue
		  Next
		  
		  If Full Then
		    Var UserSettingsIniPath As String = Self.Profile.BasePath + "/user-settings.ini"
		    
		    // Generate a new user-settings.ini file
		    Var ExtraGameIniSuccess As Boolean
		    Var ExtraGameIni As String = Self.GetFile(UserSettingsIniPath, DownloadFailureMode.MissingAllowed, False, ExtraGameIniSuccess)
		    If ExtraGameIniSuccess = False Or Self.Finished Then
		      Self.Finish()
		      Return False
		    End If
		    If ExtraGameIni.BeginsWith("[" + Ark.HeaderShooterGame + "]") = False Then
		      ExtraGameIni = "[" + Ark.HeaderShooterGame + "]" + EndOfLine.UNIX + ExtraGameIni
		    End If
		    Var RewriteError As RuntimeException
		    Var ExtraGameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, ExtraGameIni, Ark.HeaderShooterGame, Ark.ConfigFileGame, ExtraGameIniOrganizer, Self.Project.ProjectId, Self.Project.LegacyTrustKey, If(Self.Project.AllowUCS2, Ark.Rewriter.EncodingFormat.UCS2AndASCII, Ark.Rewriter.EncodingFormat.ASCII), Ark.Project.UWPCompatibilityModes.Never, Self.NukeEnabled, RewriteError)
		    If (RewriteError Is Nil) = False Then
		      Self.SetError(RewriteError)
		      Return False
		    End If
		    
		    // Need to remove the header that the rewriter adds
		    ExtraGameIniRewritten = ExtraGameIniRewritten.Replace("[" + Ark.HeaderShooterGame + "]", "").Trim
		    
		    // Create a checkpoint before making changes
		    If Self.BackupEnabled Then
		      Var GameServer As JSONItem = Self.Status.UserData
		      Var OldSettings As JSONItem = GameServer.Child("settings")
		      Var OldFiles As New Dictionary
		      OldFiles.Value("Config.json") = Beacon.GenerateJSON(OldSettings, True)
		      OldFiles.Value("user-settings.ini") = ExtraGameIni
		      
		      Var NewSettings As New JSONItem(OldSettings.ToString)
		      For Each Entry As DictionaryEntry In Changes
		        Var ConfigOption As Ark.ConfigOption = Entry.Key
		        Var NewValue As String = Entry.Value
		        Var Paths() As String = ConfigOption.NitradoPaths
		        
		        For Each Path As String In Paths
		          Var CategoryLength As Integer = Path.IndexOf(".")
		          Var Category As String = Path.Left(CategoryLength)
		          Var Key As String = Path.Middle(CategoryLength + 1)
		          
		          Var CategoryDict As JSONItem = NewSettings.Child(Category)
		          CategoryDict.Value(Key) = NewValue
		        Next
		      Next
		      
		      Var NewFiles As New Dictionary
		      NewFiles.Value("Config.json") = Beacon.GenerateJSON(NewSettings, True)
		      NewFiles.Value("user-settings.ini") = ExtraGameIniRewritten
		      
		      Self.RunBackup(OldFiles, NewFiles)
		      
		      If Self.Finished Then
		        Return False
		      End If
		    End If
		    
		    If Not Self.PutFile(ExtraGameIniRewritten, UserSettingsIniPath) Then
		      Self.Finish()
		      Return False
		    End If
		    If Self.Finished Then
		      Return False
		    End If
		  End If
		  
		  // Deploy changes
		  For Each Entry As DictionaryEntry In Changes
		    Var Setting As Ark.ConfigOption = Entry.Key
		    Var NewValue As String = Entry.Value
		    
		    Try
		      Self.Provider.GameSetting(Self, Self.Profile, Setting) = NewValue
		    Catch Err As RuntimeException
		      Self.SetError(Err)
		      Return False
		    End Try
		    
		    // So we don't go nuts
		    Self.Thread.Sleep(100)
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub NitradoCooldownWait()
		  // Since the process is about to upload, we need to find the log file and determine how long to wait
		  // First we need to look up the current time, since we cannot trust the user's clock
		  Var Now As DateTime
		  Var Locked As Boolean
		  Try
		    Locked = Preferences.SignalConnection
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(New BeaconAPI.Request("/now", "GET"))
		    If Locked Then
		      Preferences.ReleaseConnection()
		      Locked = False
		    End If
		    
		    Var Parsed As New JSONItem(Response.Content)
		    Now = New DateTime(Parsed.Value("unixEpoch").DoubleValue)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Getting current time from API")
		    Now = DateTime.Now
		    
		    If Locked Then
		      Preferences.ReleaseConnection()
		      Locked = False
		    End If
		  End Try
		  
		  Var LogPath As String = Self.Profile.BasePath + "/ShooterGame/Saved/Logs/ShooterGame.log"
		  Var LogContentSuccess As Boolean
		  Var LogContent As String = Self.GetFile(LogPath, Beacon.Integration.DownloadFailureMode.ErrorsAllowed, False, LogContentSuccess)
		  Var ServerStopTime As DateTime
		  
		  If LogContentSuccess Then
		    Try
		      Var EOL As String = Encodings.ASCII.Chr(10)
		      Var Lines() As String = LogContent.ReplaceLineEndings(EOL).Split(EOL)
		      Var TimestampFound As Boolean
		      For I As Integer = Lines.LastIndex DownTo 0
		        Var Line As String = Lines(I)
		        If Line.IndexOf("Log file closed") = -1 Then
		          Continue
		        End If
		        
		        Var Year As Integer = Integer.FromString(Line.Middle(1, 4), Locale.Raw)
		        Var Month As Integer = Integer.FromString(Line.Middle(6, 2), Locale.Raw)
		        Var Day As Integer = Integer.FromString(Line.Middle(9, 2), Locale.Raw)
		        Var Hour As Integer = Integer.FromString(Line.Middle(12, 2), Locale.Raw)
		        Var Minute As Integer = Integer.FromString(Line.Middle(15, 2), Locale.Raw)
		        Var Second As Integer = Integer.FromString(Line.Middle(18, 2), Locale.Raw)
		        Var Nanosecond As Integer = (Integer.FromString(Line.Middle(21, 3), Locale.Raw) / 1000) * 1000000000
		        
		        ServerStopTime = New DateTime(Year, Month, Day, Hour, Minute, Second, Nanosecond, New TimeZone(0))
		        TimestampFound = True
		        Exit For I
		      Next
		      
		      If Not TimestampFound Then
		        ServerStopTime = Now
		      End If
		    Catch Err As RuntimeException
		      ServerStopTime = Now
		    End Try
		  Else
		    ServerStopTime = Now
		  End If
		  
		  // Now we can compute how long to wait.
		  Var WaitUntil As DateTime = ServerStopTime + New DateInterval(0, 0, 0, 0, 3, 0)
		  WaitUntil = New DateTime(WaitUntil.SecondsFrom1970, TimeZone.Current)
		  Var Diff As Double = WaitUntil.SecondsFrom1970 - Now.SecondsFrom1970
		  
		  If Diff > 0 Then
		    Self.Log("Waiting until " + WaitUntil.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Medium) + " per Nitrado recommendation…")
		    Self.Wait(Diff * 1000)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Ark.Project
		  Return Ark.Project(Super.Project)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchToExpertMode(OffendingKey As String, ContentLength As Integer)
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
		  Select Case Self.Status.State
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
		  
		  Try
		    Self.Provider.GameSetting(Self, Self.Profile, "general.expertMode") = True
		  Catch Err As RuntimeException
		    Self.SetError("Could not enable expert mode: " + Err.Message)
		    Return
		  End Try
		  
		  Self.Log("Expert mode enabled.")
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


	#tag Property, Flags = &h21
		Private mCheckpointCreated As Boolean
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
