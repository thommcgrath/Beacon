#tag Class
Protected Class IntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Sub Deploy(InitialServerState As Integer)
		  Var Project As Ark.Project = Self.Project
		  Var Organizer As Ark.ConfigOrganizer = Project.CreateConfigOrganizer(Self.Identity, Self.Profile)
		  
		  If Self.mDoGuidedDeploy And Self.SupportsWideSettings Then
		    Var GuidedSuccess As Boolean = RaiseEvent ApplySettings(Organizer)
		    If Self.Finished Then
		      Return
		    End If
		    
		    If GuidedSuccess Then
		      // Restart the server if it is running
		      If Self.SupportsRestarting And (InitialServerState = Self.StateRunning Or InitialServerState = Self.StateStarting) Then
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
		  
		  Var RewriteError As RuntimeException
		  
		  Var GameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, If(Self.NukeEnabled = False, GameIniOriginal, ""), Ark.HeaderShooterGame, Ark.ConfigFileGame, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Project.UWPMode, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  Var GameUserSettingsIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, If(Self.NukeEnabled = False, GameUserSettingsIniOriginal, ""), Ark.HeaderServerSettings, Ark.ConfigFileGameUserSettings, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Project.UWPMode, RewriteError)
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
