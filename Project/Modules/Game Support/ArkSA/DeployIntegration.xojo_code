#tag Class
Protected Class DeployIntegration
Inherits Beacon.DeployIntegration
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Var InitialStatus As Beacon.ServerStatus = Self.Status
		  Var Project As ArkSA.Project = Self.Project
		  Var Profile As ArkSA.ServerProfile = Self.Profile
		  
		  Var GameIniPath, GameUserSettingsIniPath As String
		  
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Var GameServer As JSONItem = InitialStatus.UserData
		    Var GamePath As String = GameServer.Child("game_specific").Value("path").StringValue
		    If GamePath.EndsWith("/") Then
		      GamePath = GamePath.Left(GamePath.Length - 1)
		    End If
		    
		    Profile.SecondaryName = GameServer.Value("ip").StringValue + ":" + GameServer.Value("port").IntegerValue.ToString(Locale.Raw, "0") + " (" + GameServer.Value("service_id").IntegerValue.ToString(Locale.Raw, "0") + ")"
		    Profile.BasePath = GamePath
		    Profile.GameIniPath = GamePath + "/ShooterGame/Saved/Config/WindowsServer/Game.ini"
		    Profile.GameUserSettingsIniPath = GamePath + "/ShooterGame/Saved/Config/WindowsServer/GameUserSettings.ini"
		    Profile.LogsPath = GamePath + "/ShooterGame/Saved/Logs"
		    
		    Var Config As JSONItem = GameServer.Child("settings").Child("config")
		    Var Map As String = Config.Value("map").StringValue
		    Profile.Mask = ArkSA.Maps.MaskForIdentifier(Map.LastField("."))
		  End Select
		  
		  GameIniPath = Profile.GameIniPath
		  GameUserSettingsIniPath = Profile.GameUserSettingsIniPath
		  
		  Self.EnterResourceIntenseMode()
		  Var Organizer As ArkSA.ConfigOrganizer = Project.CreateConfigOrganizer(Self.Identity, Profile)
		  Self.ExitResourceIntenseMode()
		  If Organizer Is Nil Then
		    Self.SetError("Could not generate new config data. Log files may have more info.")
		    Return
		  End If
		  
		  Var GameIniOriginal, GameUserSettingsIniOriginal As String
		  // Download the ini files
		  Var DownloadSuccess As Boolean
		  GameIniOriginal = Self.GetFile(GameIniPath, ArkSA.ConfigFileGame, Beacon.Integration.DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finish()
		    Return
		  End If
		  GameUserSettingsIniOriginal = Self.GetFile(GameUserSettingsIniPath, ArkSA.ConfigFileGameUserSettings, Beacon.Integration.DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finish()
		    Return
		  End If
		  
		  // Build the new ini files
		  Self.Log("Generating new ini files…")
		  
		  Var Format As ArkSA.Rewriter.EncodingFormat
		  If Self.Project.IsFlagged(ArkSA.Project.FlagAllowUCS2) Then
		    Format = ArkSA.Rewriter.EncodingFormat.UCS2AndASCII
		  Else
		    Format = ArkSA.Rewriter.EncodingFormat.ASCII
		  End If
		  
		  Var UWPMode As ArkSA.Project.UWPCompatibilityModes = Project.UWPMode
		  If Self.Provider IsA Nitrado.HostingProvider Then
		    UWPMode = ArkSA.Project.UWPCompatibilityModes.Never
		  End If
		  
		  Var RewriteError As RuntimeException
		  
		  Self.EnterResourceIntenseMode()
		  Var GameIniRewritten As String = ArkSA.Rewriter.Rewrite(ArkSA.Rewriter.Sources.Deploy, GameIniOriginal, ArkSA.HeaderShooterGame, ArkSA.ConfigFileGame, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, UWPMode, Self.NukeEnabled, RewriteError)
		  Self.ExitResourceIntenseMode()
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  Self.EnterResourceIntenseMode()
		  Var GameUserSettingsIniRewritten As String = ArkSA.Rewriter.Rewrite(ArkSA.Rewriter.Sources.Deploy, GameUserSettingsIniOriginal, ArkSA.HeaderServerSettings, ArkSA.ConfigFileGameUserSettings, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, UWPMode, Self.NukeEnabled, RewriteError)
		  Self.ExitResourceIntenseMode()
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  // Verify content looks acceptable
		  If Not Self.ValidateContent(GameUserSettingsIniRewritten, ArkSA.ConfigFileGameUserSettings) Then
		    Return
		  End If
		  If Not Self.ValidateContent(GameIniRewritten, ArkSA.ConfigFileGame) Then
		    Return
		  End If
		  
		  // Allow the user to review the new files if requested
		  If Self.ReviewEnabled And Self.Identity.IsBanned = False Then
		    If Self.AnalyzeEnabled Then
		      // Analyzer would go here
		    End If
		    
		    Var Dict As New Dictionary
		    Dict.Value(ArkSA.ConfigFileGame) = GameIniRewritten
		    Dict.Value(ArkSA.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
		    Dict.Value("Advice") = Nil // The results would go here
		    
		    Var Controller As New Beacon.TaskWaitController("Review Files", Dict)
		    
		    Self.Log("Waiting for user review")
		    Self.Wait(Controller)
		    If Controller.Cancelled Then
		      Return
		    End If
		  End If
		  
		  Var NitradoChanges As Dictionary
		  Var NitradoSettings As JSONItem
		  If Self.Provider IsA Nitrado.HostingProvider Then
		    Var GameServer As JSONItem = InitialStatus.UserData
		    NitradoSettings = GameServer.Child("settings")
		    NitradoChanges = Self.NitradoPrepareChanges(NitradoSettings, Organizer)
		  End If
		  
		  // Run the backup if requested
		  If Self.BackupEnabled Then
		    Var OldFiles As New Dictionary
		    OldFiles.Value(ArkSA.ConfigFileGame) = GameIniOriginal
		    OldFiles.Value(ArkSA.ConfigFileGameUserSettings) = GameUserSettingsIniOriginal
		    
		    Var NewFiles As New Dictionary
		    NewFiles.Value(ArkSA.ConfigFileGame) = GameIniRewritten
		    NewFiles.Value(ArkSA.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
		    
		    Select Case Self.Provider
		    Case IsA Nitrado.HostingProvider
		      OldFiles.Value("Config.json") = NitradoSettings.ToString(False)
		      
		      Var NewSettings As New JSONItem(OldFiles.Value("Config.json").StringValue)
		      For Each Entry As DictionaryEntry In NitradoChanges
		        Var Path As String = Entry.Key
		        Var Category As String = Path.NthField(".", 1)
		        If NewSettings.HasKey(Category) = False Then
		          Continue
		        End If
		        Var Parent As JSONItem = NewSettings.Child(Category)
		        Var Key As String = Path.NthField(".", 2)
		        If Parent.HasKey(Key) = False Then
		          Continue
		        End If
		        Parent.Value(Key) = Entry.Value.StringValue
		      Next
		      NewFiles.Value("Config.json") = NewSettings.ToString(False)
		    End Select
		    
		    Self.RunBackup(OldFiles, NewFiles)
		    
		    If Self.Finished Then
		      Return
		    End If
		  End If
		  
		  // Stop the server
		  If Self.Plan = Beacon.DeployPlan.StopUploadStart Then
		    Self.StopServer()
		    
		    // Let the implementor do any final work
		    If Self.Provider IsA Nitrado.HostingProvider Then
		      Self.NitradoCooldownWait()
		    End If
		  End If
		  
		  // Put the new files on the server
		  If Self.PutFile(GameIniRewritten, GameIniPath, ArkSA.ConfigFileGame) = False Or Self.Finished Then
		    Self.Finish()
		    Return
		  End If 
		  If Self.PutFile(GameUserSettingsIniRewritten, GameUserSettingsIniPath, ArkSA.ConfigFileGameUserSettings) = False Or Self.Finished Then
		    Self.Finish()
		    Return
		  End If
		  
		  // Make command line changes
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Call Self.NitradoApplySettings(NitradoChanges)
		    If Self.Finished Then
		      Return
		    End If
		  Case IsA GameServerApp.HostingProvider
		    Call Self.GameServerAppApplySettings(Organizer)
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function GameServerAppApplySettings(Organizer As ArkSA.ConfigOrganizer) As Boolean
		  If (Self.Provider IsA GameServerApp.HostingProvider) = False Then
		    Return False
		  End If
		  
		  Var ChainDownloaded As Boolean
		  Var Chain As String = Self.GetFile("chain", "Launch Options: Chain", Beacon.Integration.DownloadFailureMode.MissingAllowed, False, ChainDownloaded)
		  
		  Var TailDownloaded As Boolean
		  Var Tail As String = Self.GetFile("end", "Launch Options: End", Beacon.Integration.DownloadFailureMode.MissingAllowed, False, TailDownloaded)
		  
		  Var Launch As String = "TheIsland?listen" + Chain + " " + Tail
		  Var CommandLine As Dictionary = ArkSA.ParseCommandLine(Launch, True)
		  If CommandLine.HasKey("?Map") Then
		    CommandLine.Remove("?Map")
		  ElseIf CommandLine.HasKey("Map") Then
		    CommandLine.Remove("Map")
		  End If
		  
		  // Options are key value pairs, flags are just keys
		  Var Options() As ArkSA.ConfigValue = Organizer.FilteredValues("CommandLineOption")
		  Var Flags() As ArkSA.ConfigValue = Organizer.FilteredValues("CommandLineFlag")
		  
		  For Each Option As ArkSA.ConfigValue In Options
		    Var Key As String = Option.Header + Option.AttributedKey
		    CommandLine.Value(Key) = Option.Command
		  Next
		  For Each Flag As ArkSA.ConfigValue In Flags
		    Var Key As String = Flag.Header + Flag.AttributedKey
		    If Flag.Details.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean Then
		      If Flag.Value = "True" Then
		        CommandLine.Value(Key) = Flag.AttributedKey
		      ElseIf CommandLine.HasKey(Key) Then
		        CommandLine.Remove(Key)
		      End If
		    End If
		  Next
		  
		  Var ChainElements(), TailElements() As String
		  For Each Entry As DictionaryEntry In CommandLine
		    Var Key As String = Entry.Key
		    Var Command As String = Entry.Value
		    If Key.BeginsWith("-") Then
		      If Command.BeginsWith("-") = False Then
		        Command = "-" + Command
		      End If
		      TailElements.Add(Command)
		    ElseIf Key.BeginsWith("?") Then
		      If Command.BeginsWith("?") = False Then
		        Command = "?" + Command
		      End If
		      ChainElements.Add(Command)
		    End If
		  Next
		  
		  Var NewChain As String = ChainElements.Join("")
		  Var NewTail As String = TailElements.Join(" ")
		  
		  If Not Self.PutFile(NewChain, "chain", "Launch Options: Chain") Then
		    Return False
		  End If
		  
		  If Not Self.PutFile(NewTail, "end", "Launch Options: End") Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NitradoApplySettings(Changes As Dictionary) As Boolean
		  // Keys are paths.
		  // Values are strings. Nitrado always uses strings, even for numbers and booleans.
		  
		  If (Self.Provider IsA Nitrado.HostingProvider) = False Or Changes Is Nil Or Changes.KeyCount = 0 Then
		    Return False
		  End If
		  
		  Var Project As ArkSA.Project = Self.Project
		  Var Profile As ArkSA.ServerProfile = Self.Profile
		  
		  Self.Log("Updating Nitrado control panel…")
		  
		  For Each Entry As DictionaryEntry In Changes
		    Var Path As String = Entry.Key
		    Var NewValue As String = Entry.Value
		    
		    Try
		      Self.Log("Setting " + Path + "…")
		      Nitrado.HostingProvider(Self.Provider).GameSetting(Project, Profile, Path) = NewValue
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
		  Var LogContent As String = Self.GetFile(LogPath, "ShooterGame.log", Beacon.Integration.DownloadFailureMode.ErrorsAllowed, False, LogContentSuccess)
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
		  Var WaitSeconds As Integer = ArkSA.DataSource.Pool.Get(False).GetVariable("Nitrado Wait Seconds")
		  Var WaitUntil As DateTime = ServerStopTime + New DateInterval(0, 0, 0, 0, 0, WaitSeconds)
		  WaitUntil = New DateTime(WaitUntil.SecondsFrom1970, TimeZone.Current)
		  Var Diff As Double = WaitUntil.SecondsFrom1970 - Now.SecondsFrom1970
		  
		  If Diff > 0 Then
		    Self.Log("Waiting until " + WaitUntil.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Medium) + " per Nitrado recommendation…")
		    Self.Wait(Diff * 1000)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NitradoPrepareChanges(Settings As JSONItem, Organizer As ArkSA.ConfigOrganizer) As Dictionary
		  // Returns a dictionary with paths for keys and strings for values.
		  // Paths which are not changed should be skipped.
		  
		  Var Keys() As ArkSA.ConfigOption = Organizer.DistinctKeys
		  Var NewValues As New Dictionary
		  Var SettingsForPaths As New Dictionary
		  
		  For Each ConfigOption As ArkSA.ConfigOption In Keys
		    If ConfigOption.HasNitradoEquivalent = False Then
		      Continue
		    End If
		    
		    Var Values() As ArkSA.ConfigValue = Organizer.FilteredValues(ConfigOption)
		    Var NewValue As String
		    
		    Select Case ConfigOption.NitradoFormat
		    Case ArkSA.ConfigOption.NitradoFormats.Line
		      Var Lines() As String
		      For Each Value As ArkSA.ConfigValue In Values
		        If ConfigOption.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean Then
		          Lines.Add(Value.AttributedKey + "=" + If(Value.Value = "True", "true", "false"))
		        Else
		          Lines.Add(Value.Command)
		        End If
		      Next
		      NewValue = String.FromArray(Lines, EndOfLine.UNIX)
		    Case ArkSA.ConfigOption.NitradoFormats.Value
		      If Values.Count >= 1 Then
		        Var Value As String = Values(Values.LastIndex).Value
		        
		        If ConfigOption.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean Then
		          Value = Value.Lowercase
		          
		          Var Reversed As NullableBoolean = NullableBoolean.FromVariant(ConfigOption.Constraint("nitrado.boolean.reversed"))
		          If (Reversed Is Nil) = False And Reversed.BooleanValue Then
		            Value = If(Value = "true", "false", "true")
		          End If
		          
		          Var Map As Dictionary = ConfigOption.Constraint("nitrado.boolean.map")
		          If (Map Is Nil) = False Then
		            Var ExportMap As Dictionary = Map.Value("export")
		            Value = ExportMap.Value(Value)
		          End If
		        End If
		        
		        NewValue = Value
		      Else
		        // This doesn't make sense
		        Break
		      End If
		    End Select
		    
		    Var Paths() As String = ConfigOption.NitradoPaths
		    For Each Path As String In Paths
		      If NewValues.HasKey(Path) Then
		        NewValue = NewValues.Value(Path) + EndOfLine.UNIX + NewValue
		      End If
		      NewValues.Value(Path) = NewValue
		      
		      If SettingsForPaths.HasKey(Path) = False Then
		        SettingsForPaths.Value(Path) = ConfigOption
		      End If
		    Next
		  Next
		  
		  Var Changes As New Dictionary
		  For Each Entry As DictionaryEntry In NewValues
		    Var Path As String = Entry.Key
		    Var NewValue As String = Entry.Value
		    Var ConfigOption As ArkSA.ConfigOption = SettingsForPaths.Value(Path)
		    
		    Var Category As String = Path.NthField(".", 1)
		    Var Key As String = Path.NthField(".", 2)
		    If Settings.HasKey(Category) = False Then
		      Continue
		    End If
		    
		    Var Parent As JSONItem = Settings.Child(Category)
		    If Parent.HasKey(Key) = False Then
		      Continue
		    End If
		    
		    Var CurValue As String = Parent.Value(Key)
		    
		    If ConfigOption.NitradoValuesEqual(NewValue, CurValue) Then
		      Continue
		    End If
		    
		    Changes.Value(Path) = NewValue
		    
		    #if DebugBuild
		      System.DebugLog("Updating " + Path + " from `" + CurValue + "` to `" + NewValue + "`")
		    #endif
		  Next
		  
		  Return Changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As ArkSA.ServerProfile
		  Return ArkSA.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As ArkSA.Project
		  Return ArkSA.Project(Super.Project)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValidateContent(Content As String, Filename As String) As Boolean
		  Var MissingHeaders() As String = ArkSA.ValidateIniContent(Content, Filename)
		  
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
