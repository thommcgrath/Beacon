#tag Module
Protected Module DedicatedServer
	#tag Method, Flags = &h1
		Protected Function Configure(Project As Ark.Project, Profile As Ark.ServerProfile, ArkRoot As FolderItem, HostDir As FolderItem) As Boolean
		  Var Organizer As Ark.ConfigOrganizer = Project.CreateConfigOrganizer(App.IdentityManager.CurrentIdentity, Profile)
		  If Organizer Is Nil Then
		    App.Log("Project did not create a config organizer")
		    Return False
		  End If
		  
		  If HostDir.CheckIsFolder(True) = False Then
		    App.Log("Server root " + HostDir.NativePath + " could not be created.")
		    Return False
		  End If
		  
		  Var ShooterGameFolder As FolderItem = ArkRoot.Child("ShooterGame")
		  Var ServerFolder As FolderItem = HostDir.Child(Profile.ProfileID)
		  If ServerFolder.CheckIsFolder(True) = False Then
		    App.Log("Server directory " + ServerFolder.NativePath + " could not be created.")
		    Return False
		  End If
		  
		  Var ServerShooterGameFolder As FolderItem = ServerFolder.Child("ShooterGame")
		  If ServerShooterGameFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create server ShooterGame directory " + ServerShooterGameFolder.NativePath + ".")
		    Return False
		  End If
		  
		  Var SavedFolder As FolderItem = ServerShooterGameFolder.Child("Saved")
		  If SavedFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create server Saved directory " + SavedFolder.NativePath + ".")
		    Return False
		  End If
		  
		  Var ConfigFolder As FolderItem = SavedFolder.Child("Config")
		  If ConfigFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create server Config directory " + ConfigFolder.NativePath + ".")
		    Return False
		  End If
		  
		  #if TargetWindows
		    ConfigFolder = ConfigFolder.Child("WindowsServer")
		  #elseif TargetLinux
		    ConfigFolder = ConfigFolder.Child("LinuxServer")
		  #elseif TargetMacOS
		    ConfigFolder = ConfigFolder.Child("MacServer")
		  #endif
		  If ConfigFolder.CheckIsFolder(True) = False Then
		    App.Log("Could not create platform config directory " + ConfigFolder.NativePath + ".")
		    Return False
		  End If
		  
		  Var GameUserSettingsIniOriginal, GameIniOriginal As String
		  If ConfigFolder.Child(Ark.ConfigFileGameUserSettings).Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(ConfigFolder.Child(Ark.ConfigFileGameUserSettings))
		    GameUserSettingsIniOriginal = Stream.ReadAll(Nil).GuessEncoding
		    Stream.Close
		  End If
		  If ConfigFolder.Child(Ark.ConfigFileGame).Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(ConfigFolder.Child(Ark.ConfigFileGame))
		    GameIniOriginal = Stream.ReadAll(Nil).GuessEncoding
		    Stream.Close
		  End If
		  
		  Var Format As Ark.Rewriter.EncodingFormat
		  If Project.AllowUCS2 Then
		    Format = Ark.Rewriter.EncodingFormat.UCS2AndASCII
		  Else
		    Format = Ark.Rewriter.EncodingFormat.ASCII
		  End If
		  
		  Var RewriteError As RuntimeException
		  
		  Var GameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, GameIniOriginal, Ark.HeaderShooterGame, Ark.ConfigFileGame, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Ark.Project.UWPCompatibilityModes.Never, False, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    App.Log(RewriteError, CurrentMethodName, "Building Game.ini")
		    Return False
		  End If
		  
		  Var GameUserSettingsIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, GameUserSettingsIniOriginal, Ark.HeaderServerSettings, Ark.ConfigFileGameUserSettings, Organizer, Project.UUID, Project.LegacyTrustKey, Format, Ark.Project.UWPCompatibilityModes.Never, False, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    App.Log(RewriteError, CurrentMethodName, "Building GameUserSettings.ini")
		    Return False
		  End If
		  
		  If ConfigFolder.Child(Ark.ConfigFileGameUserSettings).Write(GameUserSettingsIniRewritten) = False Then
		    App.Log("Could not write GameUserSettings.ini to platform config directory")
		    Return False
		  End If
		  If ConfigFolder.Child(Ark.ConfigFileGame).Write(GameIniRewritten) = False Then
		    App.Log("Could not write Game.ini to platform config directory")
		    Return False
		  End If
		  
		  Try
		    HardLinkContents(ArkRoot, ServerFolder)
		    HardLinkContents(ShooterGameFolder, ServerFolder.Child("ShooterGame"))
		  Catch Err As RuntimeException
		    App.Log(Err, "Creating hard links", CurrentMethodName)
		    Return False
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateHardLink(Sh As Shell, SourceFile As FolderItem, DestinationFile As FolderItem)
		  If SourceFile.Exists = False Or DestinationFile.Exists = True Then
		    Return
		  End If
		  
		  #if TargetWindows
		    If SourceFile.IsFolder Then
		      Sh.Execute("mklink /J """ + DestinationFile.NativePath + """ """ + SourceFile.NativePath + """")
		    Else
		      Sh.Execute("mklink /H """ + DestinationFile.NativePath + """ """ + SourceFile.NativePath + """")
		    End If
		    
		    Var ExitCode As Integer = Sh.ExitCode
		    If ExitCode <> 0 Then
		      Var Err As New UnsupportedOperationException
		      Err.ErrorNumber = ExitCode
		      Err.Message = Sh.Result.Trim
		      Raise Err
		    End If
		  #elseif TargetLinux Or TargetMacOS
		    If SourceFile.IsFolder Then
		      Sh.Execute("ln -s " + SourceFile.ShellPath + " " + DestinationFile.ShellPath)
		    Else
		      Sh.Execute("ln " + SourceFile.ShellPath + " " + DestinationFile.ShellPath)
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HardLinkContents(Folder As FolderItem, Destination As FolderItem, ParamArray Exclude() As String)
		  Var Sh As Shell
		  For Each SourceFile As FolderItem In Folder.Children
		    If Exclude.IndexOf(SourceFile.Name) > -1 Then
		      Continue
		    End If
		    
		    Var TargetFile As FolderItem = Destination.Child(SourceFile.Name)
		    If TargetFile.Exists Then
		      Continue
		    End If
		    
		    If Sh Is Nil Then
		      Sh = New Shell
		    End If
		    
		    CreateHardLink(Sh, SourceFile, TargetFile)
		  Next SourceFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShooterGameServer(ArkRoot As FolderItem) As FolderItem
		  If ArkRoot Is Nil Or ArkRoot.Exists = False Then
		    Return Nil
		  End If
		  
		  Var PathComponents() As String
		  
		  #if TargetWindows
		    PathComponents.Add("ShooterGame")
		    PathComponents.Add("Binaries")
		    PathComponents.Add("Win64")
		    PathComponents.Add("ShooterGameServer.exe")
		  #elseif TargetLinux
		    
		  #elseif TargetMacOS
		    #if DebugBuild
		      PathComponents.Add("ShooterGame.app")
		      PathComponents.Add("Contents")
		      PathComponents.Add("MacOS")
		      PathComponents.Add("ShooterGame")
		    #else
		      Return Nil
		    #endif
		  #endif
		  
		  Var Dir As FolderItem = ArkRoot
		  For Each Component As String In PathComponents
		    Dir = Dir.Child(Component)
		    If Dir Is Nil Or Dir.Exists = False Then
		      Return Nil
		    End If
		  Next
		  Return Dir
		End Function
	#tag EndMethod


	#tag Constant, Name = PathSeparator, Type = String, Dynamic = False, Default = \"/", Scope = Protected
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"\\"
	#tag EndConstant


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
End Module
#tag EndModule
