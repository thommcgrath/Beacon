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
		  If Self.Project.AllowUCS2 Then
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
		  
		  // Run the backup if requested
		  If Self.BackupEnabled Then
		    Var OldFiles As New Dictionary
		    OldFiles.Value(ArkSA.ConfigFileGame) = GameIniOriginal
		    OldFiles.Value(ArkSA.ConfigFileGameUserSettings) = GameUserSettingsIniOriginal
		    
		    Var NewFiles As New Dictionary
		    NewFiles.Value(ArkSA.ConfigFileGame) = GameIniRewritten
		    NewFiles.Value(ArkSA.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
		    
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
		  If Self.PutFile(GameIniRewritten, GameIniPath, ArkSA.ConfigFileGame) = False Or Self.Finished Then
		    Self.Finish()
		    Return
		  End If 
		  If Self.PutFile(GameUserSettingsIniRewritten, GameUserSettingsIniPath, ArkSA.ConfigFileGameUserSettings) = False Or Self.Finished Then
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


	#tag Method, Flags = &h1
		Protected Function ApplySettings(Organizer As ArkSA.ConfigOrganizer, Full As Boolean) As Boolean
		  #Pragma Unused Full
		  
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Return Self.NitradoApplySettings(Organizer)
		  Else
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NitradoApplySettings(Organizer As ArkSA.ConfigOrganizer) As Boolean
		  #Pragma Unused
		  
		  If (Self.Provider IsA Nitrado.HostingProvider) = False Then
		    Return False
		  End If
		  
		  Var Project As ArkSA.Project = Self.Project
		  Var Profile As ArkSA.ServerProfile = Self.Profile
		  Var Keys() As ArkSA.ConfigOption = Organizer.DistinctKeys
		  Var NewValues As New Dictionary
		  Var Style As ArkSA.ConfigOption.NitradoDeployStyles = ArkSA.ConfigOption.NitradoDeployStyles.Expert
		  
		  For Each ConfigOption As ArkSA.ConfigOption In Keys
		    If ConfigOption.HasNitradoEquivalent = False Then
		      Continue
		    End If
		    
		    Var SendToNitrado As Boolean = ConfigOption.NitradoDeployStyle = ArkSA.ConfigOption.NitradoDeployStyles.Both Or ConfigOption.NitradoDeployStyle = Style
		    If SendToNitrado = False Then
		      Continue
		    End If
		    
		    Var Values() As ArkSA.ConfigValue = Organizer.FilteredValues(ConfigOption)
		    
		    Select Case ConfigOption.NitradoFormat
		    Case ArkSA.ConfigOption.NitradoFormats.Line
		      Var Lines() As String
		      For Each Value As ArkSA.ConfigValue In Values
		        Lines.Add(Value.Command)
		      Next
		      NewValues.Value(ConfigOption) = Lines
		    Case ArkSA.ConfigOption.NitradoFormats.Value
		      If Values.Count >= 1 Then
		        Var Value As String = Values(Values.LastIndex).Value
		        
		        If ConfigOption.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean Then
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
		    Var ConfigOption As ArkSA.ConfigOption = Entry.Key
		    Var CurrentValue As Variant = Self.Provider.GameSetting(Project, Profile, ConfigOption)
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
		      
		      If NewLines.Count = 1 And CurrentLines.Count = 1 And (ConfigOption.ValueType = ArkSA.ConfigOption.ValueTypes.TypeNumeric Or ConfigOption.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean Or ConfigOption.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean) Then
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
		    
		    Changes.Value(ConfigOption) = FinishedValue
		  Next
		  
		  // Deploy changes
		  For Each Entry As DictionaryEntry In Changes
		    Var Setting As ArkSA.ConfigOption = Entry.Key
		    Var NewValue As String = Entry.Value
		    
		    Try
		      Self.Provider.GameSetting(Project, Profile, Setting) = NewValue
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
