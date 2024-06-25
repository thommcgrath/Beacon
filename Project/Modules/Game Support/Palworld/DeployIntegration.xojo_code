#tag Class
Protected Class DeployIntegration
Inherits Beacon.DeployIntegration
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Var InitialStatus As Beacon.ServerStatus = Self.Status
		  Var Project As Palworld.Project = Self.Project
		  Var Profile As Palworld.ServerProfile = Self.Profile
		  
		  Var SettingsIniPath As String
		  
		  Select Case Self.Provider
		  Case IsA Nitrado.HostingProvider
		    Var GameServer As JSONItem = InitialStatus.UserData
		    Var GamePath As String = GameServer.Child("game_specific").Value("path").StringValue
		    If GamePath.EndsWith("/") Then
		      GamePath = GamePath.Left(GamePath.Length - 1)
		    End If
		    
		    Profile.SecondaryName = GameServer.Value("ip").StringValue + ":" + GameServer.Value("port").IntegerValue.ToString(Locale.Raw, "0") + " (" + GameServer.Value("service_id").IntegerValue.ToString(Locale.Raw, "0") + ")"
		    Profile.BasePath = GamePath
		    Profile.SettingsIniPath = GamePath + "/Pal/Saved/Config/WindowsServer/PalWorldSettings.ini"
		    Profile.LogsPath = GamePath + "/Pal/Saved/Logs"
		  End Select
		  
		  SettingsIniPath = Profile.SettingsIniPath
		  
		  Self.EnterResourceIntenseMode()
		  Var Organizer As Palworld.ConfigOrganizer = Project.CreateConfigOrganizer(Self.Identity, Profile)
		  Self.ExitResourceIntenseMode()
		  If Organizer Is Nil Then
		    Self.SetError("Could not generate new config data. Log files may have more info.")
		    Return
		  End If
		  
		  Var SettingsIniOriginal As String
		  // Download the ini files
		  Var DownloadSuccess As Boolean
		  SettingsIniOriginal = Self.GetFile(SettingsIniPath, Palworld.ConfigFileSettings, Beacon.Integration.DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finish()
		    Return
		  End If
		  
		  // Build the new ini files
		  Self.Log("Generating new ini files…")
		  
		  Var Format As Palworld.Rewriter.EncodingFormat = Palworld.Rewriter.EncodingFormat.ASCII
		  Var RewriteError As RuntimeException
		  
		  Self.EnterResourceIntenseMode()
		  Var SettingsIniRewritten As String = Palworld.Rewriter.Rewrite(Palworld.Rewriter.Sources.Deploy, SettingsIniOriginal, Palworld.HeaderPalworldSettings, Palworld.ConfigFileSettings, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, Self.NukeEnabled, RewriteError)
		  Self.ExitResourceIntenseMode()
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  // Verify content looks acceptable
		  If Not Self.ValidateContent(SettingsIniRewritten, Palworld.ConfigFileSettings) Then
		    Return
		  End If
		  
		  // Allow the user to review the new files if requested
		  If Self.ReviewEnabled And Self.Identity.IsBanned = False Then
		    If Self.AnalyzeEnabled Then
		      // Analyzer would go here
		    End If
		    
		    Var Dict As New Dictionary
		    Dict.Value(Palworld.ConfigFileSettings) = SettingsIniRewritten
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
		    OldFiles.Value(Palworld.ConfigFileSettings) = SettingsIniOriginal
		    
		    Var NewFiles As New Dictionary
		    NewFiles.Value(Palworld.ConfigFileSettings) = SettingsIniRewritten
		    
		    Select Case Self.Provider
		    Case IsA Nitrado.HostingProvider
		      Var GameServer As JSONItem = InitialStatus.UserData
		      Var Settings As JSONItem = GameServer.Child("settings")
		      Settings.Compact = False
		      OldFiles.Value("Config.json") = Settings.ToString
		      NewFiles.Value("Config.json") = Settings.ToString
		    End Select
		    
		    Self.RunBackup(OldFiles, NewFiles)
		    
		    If Self.Finished Then
		      Return
		    End If
		  End If
		  
		  // Stop the server
		  If Self.Plan = Beacon.DeployPlan.StopUploadStart Then
		    Self.StopServer()
		  End If
		  
		  // Wait if necessary
		  If InitialStatus.State <> Beacon.ServerStatus.States.Stopped And Self.Provider IsA Nitrado.HostingProvider Then
		    Self.NitradoCooldownWait()
		  End If
		  
		  // Put the new files on the server
		  If Self.PutFile(SettingsIniRewritten, SettingsIniPath, Palworld.ConfigFileSettings) = False Or Self.Finished Then
		    Self.Finish()
		    Return
		  End If
		End Sub
	#tag EndEvent


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
		  
		  Var ServerStopTime As DateTime = Now
		  
		  // Now we can compute how long to wait.
		  Var WaitSeconds As Integer = Palworld.DataSource.Pool.Get(False).GetVariable("Nitrado Wait Seconds")
		  Var WaitUntil As DateTime = ServerStopTime + New DateInterval(0, 0, 0, 0, 0, WaitSeconds)
		  WaitUntil = New DateTime(WaitUntil.SecondsFrom1970, TimeZone.Current)
		  Var Diff As Double = WaitUntil.SecondsFrom1970 - Now.SecondsFrom1970
		  
		  If Diff > 0 Then
		    Self.Log("Waiting until " + WaitUntil.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Medium) + " per Nitrado recommendation…")
		    Self.Wait(Diff * 1000)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Palworld.ServerProfile
		  Return Palworld.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Palworld.Project
		  Return Palworld.Project(Super.Project)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValidateContent(Content As String, Filename As String) As Boolean
		  Var MissingHeaders() As String = Palworld.ValidateIniContent(Content, Filename)
		  
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
