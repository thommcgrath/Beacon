#tag Class
Protected Class App
Inherits DesktopApplication
Implements NotificationKit.Receiver,Beacon.Application
	#tag Event
		Sub AppearanceChanged()
		  Self.AppearanceChanged()
		End Sub
	#tag EndEvent

	#tag Event
		Function AppleEventReceived(theEvent As AppleEvent, eventClass As String, eventID As String) As Boolean
		  If eventClass = "GURL" And eventID = "GURL" Then
		    Var URL As String = theEvent.StringParam("----")
		    Return Self.HandleURL(URL)
		  Else
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Closing()
		  Try
		    Self.UninstallTemporaryFont(Self.ResourcesFolder.Child("Fonts").Child("SourceCodePro").Child("SourceCodePro-Regular.otf"))
		  Catch Err As RuntimeException
		    // Whatever
		  End Try
		  
		  If (Self.mPusher Is Nil) = False Then
		    Self.mPusher.Stop
		    Self.mPusher = Nil
		  End If
		  
		  Ark.DataSource.Pool.CloseAll
		  SDTD.DataSource.Pool.CloseAll
		  Beacon.CommonData.Pool.CloseAll
		  ArkSA.DataSource.Pool.CloseAll
		  Palworld.DataSource.Pool.CloseAll
		  
		  UpdatesKit.Cleanup
		  
		  #if UpdatesKit.UseSparkle = False
		    If Self.mLaunchOnQuit Then
		      Self.Log("Launching " + Self.mUpdateFile.NativePath)
		      
		      If TargetWindows And Self.mUpdateFile.Name.EndsWith(".exe") Then
		        Var Params As String = "/SP- /NOICONS /CLOSEAPPLICATIONS"
		        If Self.mRelaunchAfterUpdate Then
		          Params = "/SILENT " + Params + " /RESTARTAPPLICATIONS"
		        Else
		          Params = "/VERYSILENT " + Params + " /NOLAUNCH"
		        End If
		        Self.mUpdateFile.Open(Params)
		      Else
		        Self.mUpdateFile.Open
		        
		        If Self.IsPortableMode Then
		          // If the app is in portable mode, open the containing folder too
		          Self.ParentFolder.Open
		        End If
		      End If
		    End If
		  #endif
		  
		  Self.Log("Beacon finished gracefully")
		  Self.mLogManager.Flush()
		End Sub
	#tag EndEvent

	#tag Event
		Sub DocumentOpened(item As FolderItem)
		  Self.OpenFile(Item, False)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuBarSelected()
		  If (Self.mMainWindow Is Nil) = False Then
		    FileNew.Enabled = True
		    FileNewPreset.Enabled = True
		    FileOpen.Enabled = True
		    FileImport.Enabled = True
		    HelpEmptyCaches.Enabled = True
		    
		    Var DefaultGameId As String = Preferences.NewProjectGameId
		    If DefaultGameId.IsEmpty Then
		      FileNew.Text = "New Project"
		    Else
		      FileNew.Text = "New " + Language.GameName(DefaultGameId) + " Project"
		    End If
		    
		    Var GameMenu As DesktopMenuItem = FileNewProjectForGame
		    Var Bound As Integer = GameMenu.Count - 1
		    For Idx As Integer = 0 To Bound
		      GameMenu.MenuAt(Idx).Enabled = True
		    Next
		  End If
		  
		  If Preferences.OnlineEnabled Then
		    HelpSyncCloudFiles.Visible = True
		    HelpUpdateEngrams.Visible = True
		    HelpRefreshBlueprints.Visible = True
		    HelpUpdateEngramsSeparator.Visible = True
		    
		    Var Identity As Beacon.Identity = Self.IdentityManager.CurrentIdentity
		    If Identity Is Nil Or Identity.IsAnonymous Then
		      HelpMigrateAccounts.Visible = False
		      HelpMigrateAccountsSeparator.Visible = False
		    Else
		      HelpMigrateAccounts.Visible = True
		      HelpMigrateAccounts.Enabled = True
		      HelpMigrateAccountsSeparator.Visible = True
		    End If
		    
		    If UserCloud.IsBusy = False Then
		      HelpSyncCloudFiles.Enabled = True
		    End If
		    
		    HelpUpdateEngrams.Enabled = True
		    HelpRefreshBlueprints.Enabled = True
		  Else
		    HelpSyncCloudFiles.Visible = False
		    HelpUpdateEngrams.Visible = False
		    HelpRefreshBlueprints.Visible = False
		    HelpUpdateEngramsSeparator.Visible = False
		    HelpMigrateAccounts.Visible = False
		    HelpMigrateAccountsSeparator.Visible = False
		  End If
		  
		  Var Counter As Integer = 1
		  For I As Integer = 0 To WindowCount - 1
		    Var Win As DesktopWindow = Self.WindowAt(I)
		    If Win IsA BeaconWindow Then
		      BeaconWindow(Win).UpdateWindowMenu()
		      Counter = Counter + 1
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.mLogManager = New LogManager
		  
		  #if Not DebugBuild
		    Var MBSRegistered As Boolean
		    Try
		      Var MBSData As Dictionary = Xojo.ParseJSON(Self.MBSLicense)
		      MBSRegistered = RegisterMBSPlugin(MBSData.Value("username").StringValue, MBSData.Value("package").StringValue, MBSData.Value("expires").IntegerValue, MBSData.Value("serial").StringValue)
		    Catch Err As RuntimeException
		    End Try
		    If Not MBSRegistered Then
		      Self.Log("Unable to register MBS plugins")
		      BeaconUI.ShowAlert("This version of Beacon is not suitable for use.", "This build encountered problems during the build process and cannot be used. Please contact the developer.")
		      Quit
		    End If
		  #endif
		  
		  Self.Log(Self.UserAgent)
		  
		  #if TargetWindows
		    Var CommandLine As String = System.CommandLine
		    Var SkipSetupCheck As Boolean = CommandLine.EndsWith("/NOSETUPCHECK") Or CommandLine.IndexOf(" /NOSETUPCHECK ") > -1
		    
		    If SkipSetupCheck = False Then
		      Var SetupMutex As New WindowsMutexMBS
		      SetupMutex.Create("com.thezaz.beacon.setup")
		      If SetupMutex.Lasterror <> 0 Or SetupMutex.TryLock = False Then
		        BeaconUI.ShowAlert("Beacon's installer is currently running", "The installer may be running in the background. Please wait for it to finish before launching Beacon.")
		        Quit
		        Return
		      End If
		    End If
		  #endif
		  
		  If Self.GetMutex() = False Then
		    #if Not TargetMacOS
		      Var StartTime As Double = System.Microseconds
		      Var PushSocket As New IPCSocket
		      PushSocket.Path = Self.GetIPCPath()
		      PushSocket.Connect
		      Do Until PushSocket.IsConnected Or System.Microseconds - StartTime > 5000000
		        PushSocket.Poll
		      Loop
		      If PushSocket.IsConnected Then
		        PushSocket.Write(System.CommandLine + Encodings.UTF8.Chr(0))
		        Do Until PushSocket.BytesLeftToSend = 0 Or System.Microseconds - StartTime > 5000000
		          PushSocket.Poll
		        Loop
		        PushSocket.Close
		      End If
		    #endif
		    
		    Quit
		    Return
		  Else
		    #if Not TargetMacOS
		      Self.mHandoffSocket = New IPCSocket
		      Self.mHandoffSocket.Path = Self.GetIPCPath()
		      AddHandler Self.mHandoffSocket.DataAvailable, WeakAddressOf Self.mHandoffSocket_DataReceived
		      AddHandler Self.mHandoffSocket.Error, WeakAddressOf Self.mHandoffSocket_Error
		      Self.mHandoffSocket.Listen
		    #endif
		  End If
		  
		  Var UpdatesFolder As FolderItem = Self.ApplicationSupport.Child("Updates")
		  If UpdatesFolder <> Nil And UpdatesFolder.Exists Then
		    Call UpdatesFolder.DeepDelete
		  End If
		  
		  #if TargetMacOS
		    //Help.Visible = False
		  #endif
		  Self.RebuildRecentMenu
		  
		  If BeaconUI.DarkModeSupported Then
		    Var DarkMode As Preferences.DarkModeOptions = Preferences.DarkMode
		    #if TargetWindows
		      If DarkMode = Preferences.DarkModeOptions.ForceLight Then
		        System.EnvironmentVariable("XOJO_WIN32_DARKMODE_DISABLED") = "True"
		      End If
		    #elseif TargetMacOS
		      Select Case DarkMode
		      Case Preferences.DarkModeOptions.ForceLight
		        NSAppearanceMBS.SetAppearance(Self, NSAppearanceMBS.AppearanceNamed(NSAppearanceMBS.NSAppearanceNameAqua))
		      Case Preferences.DarkModeOptions.ForceDark
		        NSAppearanceMBS.SetAppearance(Self, NSAppearanceMBS.AppearanceNamed(NSAppearanceMBS.NSAppearanceNameDarkAqua))
		      End Select
		    #endif
		  End If
		  
		  SystemColors.Init
		  
		  NotificationKit.Watch(Self, Preferences.Notification_RecentsChanged, UserCloud.Notification_SyncStarted, UserCloud.Notification_SyncFinished, Preferences.Notification_OnlineStateChanged, DataUpdater.Notification_ImportStopped, IdentityManager.Notification_IdentityChanged)
		  
		  Self.mIdentityManager = New IdentityManager()
		  
		  Try
		    Self.TemporarilyInstallFont(Self.ResourcesFolder.Child("Fonts").Child("SourceCodePro").Child("SourceCodePro-Regular.otf"))
		  Catch Err As RuntimeException
		    // Not critically important
		  End Try
		  
		  #if TargetMacOS
		    EditPrefsSeparator.Visible = False
		    If SystemInformationMBS.IsVentura(True) Then
		      EditPreferences.Text = "Settings"
		    End If
		  #endif
		  
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CheckBetaExpiration)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SetupLogs)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_PrivacyCheck)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SetupDatabases)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CleanupConfigBackups)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SetupNewProjectMenuItems)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_ShowMainWindow)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_RequestUser)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CheckUpdates)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_StartDataUpdateChecking)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CheckScreenSize)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SubmitExceptions)
		  If BeaconUI.WebContentSupported Then
		    Self.mLaunchQueue.Add(AddressOf LaunchQueue_WelcomeWindow)
		  End If
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_StartPusher)
		  Self.NextLaunchQueueTask
		  
		  #if Not TargetMacOS
		    Self.HandleCommandLineData(System.CommandLine, True)
		  #endif
		  
		  Self.AllowAutoQuit = True
		  
		  Tests.RunTests()
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  If Error IsA ThreadEndException Then
		    Return False
		  End If
		  
		  Self.HandleException(Error)
		  
		  Return True
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function EditPreferences() As Boolean Handles EditPreferences.Action
		  PreferencesWindow.Present
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileImport() As Boolean Handles FileImport.Action
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile + BeaconFileTypes.XmlFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.BeaconData + BeaconFileTypes.BeaconIdentity
		  Dialog.AllowMultipleSelections = True
		  
		  Var File As FolderItem = Dialog.ShowModal
		  If File Is Nil Then
		    Return True
		  End If
		  
		  For Each File In Dialog.SelectedFiles
		    Self.OpenFile(File, True)
		  Next
		  
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
		  If (Self.mMainWindow Is Nil) = False Then
		    Self.mMainWindow.Documents(False).NewProject()
		  End If
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNewPreset() As Boolean Handles FileNewPreset.Action
		  If (Self.mMainWindow Is Nil) = False Then
		    Self.mMainWindow.Templates.NewTemplate
		  End If
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
		  Self.ShowOpenDocument()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAboutBeacon() As Boolean Handles HelpAboutBeacon.Action
		  If (Self.mMainWindow Is Nil) = False Then
		    Self.mMainWindow.ShowHome()
		  End If
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAdminSpawnCodes() As Boolean Handles HelpAdminSpawnCodes.Action
		  Self.ShowSpawnCodes()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAPIGuide() As Boolean Handles HelpAPIGuide.Action
		  Call Self.HandleURL("beacon://action/showguide")
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpArkConfigFileReference() As Boolean Handles HelpArkConfigFileReference.Action
		  System.GotoURL(Beacon.WebURL("/help/ark_config_file_reference"))
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpCheckforUpdates() As Boolean Handles HelpCheckforUpdates.Action
		  Self.CheckForUpdates()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpCreateSupportTicket() As Boolean Handles HelpCreateSupportTicket.Action
		  Self.StartTicket()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpEmptyCaches() As Boolean Handles HelpEmptyCaches.Action
		  Var Sources() As Beacon.DataSource = Self.DataSources
		  For Each Source As Beacon.DataSource In Sources
		    Source.EmptyCaches()
		  Next
		  BeaconUI.ShowAlert("Caches have been emptied.", "Hopefully that fixes your issue.")
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpMigrateAccounts() As Boolean Handles HelpMigrateAccounts.Action
		  UserMigratorDialog.Present(False)
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpOpenDataFolder() As Boolean Handles HelpOpenDataFolder.Action
		  Self.ApplicationSupport.Open
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpRefreshBlueprints() As Boolean Handles HelpRefreshBlueprints.Action
		  Self.SyncGamedata(False, True)
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpReleaseNotes() As Boolean Handles HelpReleaseNotes.Action
		  Self.ShowReleaseNotes()
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpShowDiagnosticInfo() As Boolean Handles HelpShowDiagnosticInfo.Action
		  DebugWindow.Present
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpShowWhatsNewWindow() As Boolean Handles HelpShowWhatsNewWindow.Action
		  WhatsNewWindow.Present(99999999)
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpSyncCloudFiles() As Boolean Handles HelpSyncCloudFiles.Action
		  UserCloud.Sync(True)
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpUpdateEngrams() As Boolean Handles HelpUpdateEngrams.Action
		  Self.SyncGamedata(False, False)
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function NewProjectForGameShowGamePicker() As Boolean Handles NewProjectForGameShowGamePicker.Action
		  If (Self.mMainWindow Is Nil) = False Then
		    Self.mMainWindow.Documents(False).NewProject("")
		  End If
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function AffectedBy72314() As Boolean
		  // https://tracker.xojo.com/xojoinc/xojo/-/issues/72314
		  
		  #if TargetMacOS And TargetX86 And XojoVersion < 2023.02
		    Static IsAffected As Boolean
		    Static Tested As Boolean
		    
		    If Tested = False Then
		      IsAffected = SystemInformationMBS.IsVentura
		      Tested = True
		    End If
		    
		    Return IsAffected
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppearanceChanged()
		  NotificationKit.Post(Self.Notification_AppearanceChanged, Nil)
		  OmniBar.RebuildColors()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  #if DebugBuild
		    Const UsePreviewAppSupport = False
		  #else
		    Const UsePreviewAppSupport = Self.UsePreviewMode
		  #endif
		  
		  If (Self.mDataFolder Is Nil) = False Then
		    Return Self.mDataFolder
		  End If
		  
		  Var AppParent As FolderItem = Self.ParentFolder
		  Var PortableFolder As FolderItem = AppParent.Child("Beacon Data")
		  If (PortableFolder Is Nil) = False And PortableFolder.Exists And PortableFolder.IsFolder And PortableFolder.IsWriteable Then
		    Self.mDataFolder = PortableFolder
		    Self.mPortableMode = True
		    Return Self.mDataFolder
		  End If
		  
		  Var FolderName As String = "Beacon"
		  #if DebugBuild
		    FolderName = "Beacon Dev"
		  #endif
		  Var PreviewFolderName As String = FolderName + " Preview"
		  
		  Var AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Call AppSupport.CheckIsFolder
		  Var CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Call CompanyFolder.CheckIsFolder
		  
		  If UsePreviewAppSupport Then
		    Var StableFolderName As String = FolderName
		    FolderName = PreviewFolderName
		    
		    If CompanyFolder.Child(StableFolderName).Exists = True And CompanyFolder.Child(FolderName).Exists = False Then
		      CompanyFolder.Child(StableFolderName).CopyTo(CompanyFolder.Child(FolderName))
		    End If
		  ElseIf CompanyFolder.Child(PreviewFolderName).Exists Then
		    If CompanyFolder.Child(FolderName).Exists Then
		      Call CompanyFolder.Child(FolderName).DeepDelete(False)
		    End If
		    CompanyFolder.Child(PreviewFolderName).MoveTo(CompanyFolder.Child(FolderName))
		  End If
		  
		  Var AppFolder As FolderItem = CompanyFolder.Child(FolderName)
		  Call AppFolder.CheckIsFolder
		  Self.mDataFolder = AppFolder
		  Return Self.mDataFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildNumber() As Integer
		  Return (Self.MajorVersion * 10000000) + (Self.MinorVersion * 100000) + (Self.BugVersion * 1000) + (Self.StageCode * 100) + Self.NonReleaseVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function BuildVersion() As String
		  Var VersionString As String = Self.MajorVersion.ToString(Locale.Raw, "0") + "." + Self.MinorVersion.ToString(Locale.Raw, "0")
		  If Self.BugVersion > 0 Or (Self.StageCode = DesktopApplication.Final And Self.NonReleaseVersion > 0) Or Self.StageCode <> DesktopApplication.Final Then
		    VersionString = VersionString + "." + Self.BugVersion.ToString(Locale.Raw, "0")
		  End If
		  Select Case Self.StageCode
		  Case DesktopApplication.Development
		    Return VersionString + "pa" + Self.NonReleaseVersion.ToString(Locale.Raw, "0")
		  Case DesktopApplication.Alpha
		    Return VersionString + "a" + Self.NonReleaseVersion.ToString(Locale.Raw, "0")
		  Case DesktopApplication.Beta
		    Return VersionString + "b" + Self.NonReleaseVersion.ToString(Locale.Raw, "0")
		  Else
		    If Self.NonReleaseVersion <= 0 Then
		      Return VersionString
		    Else
		      Return VersionString + "." + Self.NonReleaseVersion.ToString(Locale.Raw, "0")
		    End If
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckForUpdates()
		  If Self.GetOnlinePermission() Then
		    #if UpdatesKit.UseSparkle
		      UpdatesKit.Check
		    #else
		      UpdateWindow.Present()
		    #endif
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #if TargetWindows
		    Call WindowsWMIMBS.InitSecurity(False)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSourceForGame(GameId As String) As Beacon.DataSource
		  For Idx As Integer = 0 To Self.mDataSources.LastIndex
		    If Self.mDataSources(Idx).Identifier = GameId Then
		      Return Self.mDataSources(Idx)
		    End If
		  Next Idx
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSources() As Beacon.DataSource()
		  Var Sources() As Beacon.DataSource
		  Sources.ResizeTo(Self.mDataSources.LastIndex)
		  For Idx As Integer = 0 To Sources.LastIndex
		    Sources(Idx) = Self.mDataSources(Idx)
		  Next Idx
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FrameworksFolder() As FolderItem
		  #if TargetMacOS
		    Return Self.ExecutableFile.Parent.Parent.Child("Frameworks")
		  #elseif TargetWindows
		    Var FolderNames() As String = Array(Self.ExecutableFile.NameWithoutExtensionMBS + " Libs", "Libs")
		    For Each FolderName As String In FolderNames
		      Var Folder As FolderItem = Self.ExecutableFile.Parent.Child(FolderName)
		      If Folder.Exists Then
		        Return Folder
		      End If
		    Next FolderName
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenericLootSourceIcon() As Picture
		  Return IconLootStandard
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetIPCPath() As String
		  Return Self.ApplicationSupport.Child("ipc").NativePath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetMutex() As Boolean
		  Var MutexName As String = "com.thezaz.beacon"
		  #if DebugBuild
		    MutexName = MutexName + ".debug"
		  #endif
		  
		  #if TargetWindows
		    Static Lock As New WindowsMutexMBS
		    Lock.Create(MutexName)
		    Return Lock.LastError = 0 And Lock.TryLock
		  #else
		    Static Lock As New Mutex(MutexName)
		    Return Lock.TryEnter
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetOnlinePermission() As Boolean
		  If Self.mIdentityManager.CurrentIdentity <> Nil And Preferences.OnlineEnabled Then
		    Return True
		  End If
		  
		  App.Log("Presenting login window because GetOnlinePermission was called and the identity is nil or online access is disabled.")
		  UserWelcomeWindow.Present(False)
		  Return Preferences.OnlineEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleCommandLineData(Data As String, URLOnly As Boolean)
		  Var Char, BreakChar, Arg As String
		  Var Args() As String
		  
		  BreakChar = " "
		  For I As Integer = 0 To Data.Length - 1
		    Char = Data.Middle(I, 1)
		    If Char = """" Then
		      If BreakChar = " " Then
		        BreakChar = """"
		      Else
		        BreakChar = " "
		      End If
		      Continue
		    End If
		    
		    If Char = BreakChar Then
		      Args.Add(Arg)
		      Arg = ""
		    Else
		      Arg = Arg + Char
		    End If
		  Next
		  
		  If Arg <> "" Then
		    Args.Add(Arg)
		  End If
		  
		  If Args.LastIndex > 0 Then
		    Var Path As String = DefineEncoding(Args(1), Encodings.UTF8)
		    If Beacon.IsBeaconURL(Path) Then
		      // Given a url
		      Call Self.HandleURL(Path, True)
		    ElseIf URLOnly = False Then
		      // Given a file
		      Var File As FolderItem
		      Try
		        File = New FolderItem(Path, FolderItem.PathModes.Native)
		      Catch Err As RuntimeException
		        Self.Log("Tried to open " + Path + " but got an exception: " + Err.Message)
		      End Try
		      If File <> Nil And File.Exists Then
		        Self.OpenFile(File, False)
		      End If
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleException(Error As RuntimeException)
		  If Error IsA EndException Then
		    Return
		  End If
		  
		  If Thread.Current Is Nil Then
		    Self.PresentException(Error)
		  Else
		    Call CallLater.Schedule(0, AddressOf PresentException, Error)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleURL(URL As String, AlreadyConfirmed As Boolean = False) As Boolean
		  If Self.mMainWindow Is Nil Then
		    Self.mPendingURLs.Add(URL)
		    Return True
		  End If
		  
		  If AlreadyConfirmed = False And Beacon.IsBeaconURL(URL) = False Then
		    Return False
		  End If
		  
		  If URL.Left(7) = "action/" Then
		    Var Instructions As String = URL.Middle(7)
		    Var ParamsPos As Integer = Instructions.IndexOf("?")
		    Var Query As String
		    If ParamsPos > -1 Then
		      Query = Instructions.Middle(ParamsPos + 1)
		      Instructions = Instructions.Left(ParamsPos)
		    End If
		    
		    Select Case Instructions
		    Case "showdocuments"
		      Self.mMainWindow.ShowDocuments()
		    Case "showpresets", "showtemplates"
		      Self.mMainWindow.ShowTemplates()
		    Case "showengrams", "showblueprints", "showmods"
		      Self.mMainWindow.ShowBlueprints()
		    Case "showidentity"
		      IdentityWindow.Show()
		    Case "showguide"
		      System.GotoURL(Beacon.WebURL("/docs/api/v" + BeaconAPI.Version.ToString))
		    Case "checkforupdate"
		      Self.CheckForUpdates()
		    Case "checkforengrams"
		      Self.SyncGamedata(False, False)
		    Case "refreshengrams"
		      Self.SyncGamedata(False, True)
		    Case "refreshuser"
		      If Query = "silent=false" Then
		        BeaconAPI.UserController.RefreshUserDetails(BeaconAPI.UserController.VerbosityFull)
		      Else
		        BeaconAPI.UserController.RefreshUserDetails(BeaconAPI.UserController.VerbosityLoginOnly)
		      End If
		    Case "releasenotes"
		      Self.ShowReleaseNotes()
		    Case "enableonline"
		      App.Log("Presenting login window as a result of following beacon://action/enableonline.")
		      UserWelcomeWindow.Present(False)
		    Case "signin"
		      App.Log("Presenting login window as a result of following beacon://action/signin.")
		      UserWelcomeWindow.Present(True)
		    Case "showaccount"
		      System.GotoURL(Beacon.WebURL("/account/", True))
		    Case "spawncodes"
		      Self.ShowSpawnCodes()
		    Case "reportproblem", "newhelpticket"
		      Self.StartTicket()
		    Case "exit"
		      Quit
		    Case "signout"
		      Var Token As BeaconAPI.OAuthToken = Preferences.BeaconAuth
		      If (Token Is Nil) = False Then
		        Var Request As New BeaconAPI.Request("/session", "DELETE")
		        Request.ForceAuthorize(Token)
		        Request.AutoRenew = False
		        BeaconAPI.Send(Request)
		      End If
		      
		      Preferences.OnlineEnabled = False
		      Preferences.BeaconAuth = Nil
		      Self.IdentityManager.CurrentIdentity = Nil
		      
		      App.Log("Presenting login window as a result of following beacon://action/signout.")
		      UserWelcomeWindow.Present(False)
		    Case "syncusercloud"
		      UserCloud.Sync(True)
		    Else
		      Break
		    End Select
		  ElseIf URL.Left(7) = "config/" Then
		    Var ConfigName As String = URL.Middle(7)
		    
		    Var QueryPos As Integer = ConfigName.IndexOf("?")
		    Var Query As String
		    If QueryPos > -1 Then
		      Query = ConfigName.Middle(QueryPos + 1)
		      ConfigName = ConfigName.Left(QueryPos)
		    End If
		    Var QueryMembers() As String = Query.Split("&")
		    Var Parameters As New Dictionary
		    For Each Member As String In QueryMembers
		      Var Pos As Integer = Member.IndexOf("=")
		      If Pos > -1 Then
		        Parameters.Value(Member.Left(Pos)) = Member.Middle(Pos + 1)
		      Else
		        Parameters.Value(Member) = True
		      End If
		    Next
		    
		    Var PathPos As Integer = ConfigName.IndexOf("/")
		    Var Path As String
		    If PathPos > -1 Then
		      Path = ConfigName.Middle(PathPos + 1)
		      ConfigName = ConfigName.Left(PathPos)
		    End If
		    
		    // Something could be done with the query and path
		    Var GameId As String = Ark.Identifier
		    If Parameters.HasKey("game") Then
		      Try
		        GameId = Parameters.Value("game").StringValue
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    Var FrontmostView As DocumentEditorView = Self.mMainWindow.FrontmostDocumentView(GameId)
		    If FrontmostView Is Nil Then
		      Self.mMainWindow.Documents.NewProject(GameId)
		      FrontmostView = Self.mMainWindow.FrontmostDocumentView(GameId)
		    End If
		    If (FrontmostView Is Nil) = False Then
		      FrontmostView.SwitchToEditor(ConfigName)
		    End If
		  ElseIf URL.Left(4) = "run/" Then
		    Var SaveInfo As String = URL.Middle(4)
		    Var QueryPos As Integer = SaveInfo.IndexOf("?")
		    Var QueryString As String
		    If QueryPos > -1 Then
		      QueryString = SaveInfo.Middle(QueryPos + 1)
		      SaveInfo = SaveInfo.Left(QueryPos)
		    End If
		    Try
		      SaveInfo = Beacon.Decompress(DecodeBase64URL(SaveInfo))
		    Catch Err As RuntimeException
		      Self.Log(Err, CurrentMethodName, "Decoding deploy saveinfo")
		      Return True
		    End Try
		    
		    Var Action As Beacon.ScriptAction = Beacon.ScriptAction.FromQueryString(QueryString)
		    If (Action Is Nil) = False Then
		      Var Actions(0) As Beacon.ScriptAction
		      Actions(0) = Action
		      
		      If SaveInfo.BeginsWith(Beacon.ProjectURL.TypeCloud + "://") Or SaveInfo.BeginsWith(Beacon.ProjectURL.TypeLocal + "://") Or SaveInfo.BeginsWith(Beacon.ProjectURL.TypeWeb + "://") Then
		        Self.mMainWindow.Documents.OpenProject(SaveInfo, Actions)
		      Else
		        Var File As BookmarkedFolderItem
		        Try
		          File = BookmarkedFolderItem.FromSaveInfo(SaveInfo)
		        Catch Err As RuntimeException
		          Self.Log(Err, CurrentMethodName, "Decoding save info")
		        End Try
		        If (File Is Nil) = False And File.Exists Then
		          Self.mMainWindow.Documents.OpenProject(File, Actions)
		        End If
		      End If
		    End If
		  Else
		    Var LegacyURL As String = "thezaz.com/beacon/documents.php/"
		    Var Idx As Integer = URL.IndexOf(LegacyURL)
		    If Idx > -1 Then
		      Var DocID As String = URL.Middle(Idx + LegacyURL.Length)
		      URL = BeaconAPI.URL("/projects/" + DocID)
		    End If
		    
		    Var FileURL As String = "https://" + URL
		    Self.mMainWindow.Documents.OpenProject(FileURL)
		  End If
		  
		  Try
		    If Self.WindowCount > 0 Then
		      Var Frontview As DesktopWindow = Self.WindowAt(0)
		      If Frontview IsA BeaconWindow Then
		        BeaconWindow(Frontview).BringToFront()
		      End If
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HelpFile(Topic As String) As FolderItem
		  Var HelpFolder As FolderItem = Self.ApplicationSupport.Child("Help")
		  Var HelpFile As FolderItem = HelpFolder.Child(Topic)
		  
		  If HelpFile = Nil Or HelpFile.Exists = False Then
		    Var SourceFile As Folderitem = Self.ResourcesFolder.Child("Help").Child(Topic)
		    If SourceFile = Nil Or SourceFile.Exists = False Then
		      Return Nil
		    End If
		    
		    If Not HelpFolder.Exists Then
		      HelpFolder.CreateFolder()
		      HelpFile = HelpFolder.Child(Topic)
		    End If
		    
		    SourceFile.CopyTo(HelpFile)
		  End If
		  
		  Return HelpFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IdentityManager() As IdentityManager
		  Return Self.mIdentityManager
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportIdentityFile(File As FolderItem, ParentWindow As DesktopWindow = Nil)
		  If ParentWindow Is Nil Then
		    ParentWindow = MainWindow
		  End If
		  
		  Var Identity As Beacon.Identity = Self.mIdentityManager.Import(File)
		  If Identity Is Nil Then
		    // Try with password
		    Var Password As String = IdentityDecryptDialog.Present(ParentWindow)
		    If Password.IsEmpty Then
		      Return
		    End If
		    
		    Identity = Self.mIdentityManager.Import(File, Password)
		  End If
		  
		  If (Identity Is Nil) = False Then
		    Self.mIdentityManager.CurrentIdentity = Identity
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPortableMode() As Boolean
		  Return Self.mPortableMode
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub LaunchQueueTask()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_CheckBetaExpiration()
		  If Self.StageCode >= 3 Then
		    Self.NextLaunchQueueTask()
		    Return
		  End If
		  
		  Var Limit As DateTime = Self.BuildDateTime + New DateInterval(0, 0, 30)
		  Var Now As DateTime = DateTime.Now
		  If Now > Limit Then
		    BeaconUI.ShowAlert("This beta has expired.", "Please download a new version from " + Beacon.WebURL("/download/"))
		    Quit
		    Return
		  End If
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_CheckScreenSize()
		  // Find the largest screen
		  Var LargestDisplay As DesktopDisplay
		  Var Bound As Integer = DesktopDisplay.DisplayCount - 1
		  For Idx As Integer = 0 To Bound
		    Var Display As DesktopDisplay = DesktopDisplay.DisplayAt(Idx)
		    If LargestDisplay Is Nil Then
		      LargestDisplay = Display
		    Else
		      If (Display.Width * Display.Height) > (LargestDisplay.Width * LargestDisplay.Height) Then
		        LargestDisplay = Display
		      End If
		    End If
		  Next
		  
		  Var ScreenSize As New Size(LargestDisplay.Width, LargestDisplay.Height)
		  Var LastScreen As Size = Preferences.LastUsedScreenSize
		  If LastScreen Is Nil Or ScreenSize.Width <> LastScreen.Width Or ScreenSize.Height <> LastScreen.Height Then
		    // Warn
		    If ScreenSize.Width < 1280 Or ScreenSize.Height < 720 Then
		      BeaconUI.ShowAlert("Beacon was not designed for your screen resolution.", "Beacon needs a screen resolution of at least 1280x720 points. You may find that Beacon's window does not fit nicely on your screen.")
		    End If
		    Preferences.LastUsedScreenSize = ScreenSize
		  End If
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_CheckUpdates()
		  If Preferences.OnlineEnabled Then
		    UpdatesKit.IsCheckingAutomatically = True
		  End If
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_CleanupConfigBackups()
		  Beacon.CleanupConfigBackups()
		  Self.NextLaunchQueueTask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_PrivacyCheck()
		  If Self.mIdentityManager.CurrentIdentity Is Nil Then
		    App.Log("Presenting login window because identity is nil during launch steps.")
		    UserWelcomeWindow.Present(False)
		  Else
		    Self.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_RequestUser()
		  BeaconAPI.UserController.RefreshUserDetails(BeaconAPI.UserController.VerbosityLoginOnly)
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_SetupDatabases()
		  Try
		    Self.mDataSources.Add(Ark.DataSource.Pool.Get(False))
		    Self.mDataSources.Add(Beacon.CommonData.Pool.Get(False))
		    #if SDTD.Enabled
		      Self.mDataSources.Add(SDTD.DataSource.Pool.Get(False))
		    #endif
		    #if ArkSA.Enabled
		      Self.mDataSources.Add(ArkSA.DataSource.Pool.Get(False))
		    #endif
		    #if Palworld.Enabled
		      Self.mDataSources.Add(Palworld.DataSource.Pool.Get(False))
		    #endif
		  Catch Err As RuntimeException
		    // Something is still wrong
		    BeaconUI.ShowAlert("Beacon cannot start due to a problem with a local database.", "Beacon is unable to create or repair a local database. The database error was: `" + Err.Message + "`.")
		    Var AppSupport As FolderItem = Self.ApplicationSupport
		    If (AppSupport Is Nil) = False And AppSupport.Exists Then
		      AppSupport.Open
		    End If
		    Quit
		    Return
		  End Try
		  
		  Var ShouldImportLocal As Boolean
		  For Idx As Integer = Self.mDataSources.FirstIndex To Self.mDataSources.LastIndex
		    If Self.mDataSources(Idx).HasContent = False Then
		      ShouldImportLocal = True
		      Exit
		    End If
		  Next Idx
		  If ShouldImportLocal Then
		    Try
		      Var DataFile As FolderItem = Self.ResourcesFolder.Child("Complete.beacondata")
		      If (DataFile Is Nil) = False And DataFile.Exists Then
		        DataUpdater.Import(DataFile)
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Importing local data archive")
		    End Try
		  End If
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_SetupLogs()
		  Var LogsFolder As FolderItem = Self.ApplicationSupport.Child("Logs")
		  If LogsFolder Is Nil Then
		    BeaconUI.ShowAlert("Unable to start log system", "Beacon was unable to create its logs folder. Disk write access may be disabled or the disk may be full.")
		    Quit
		    Return
		  End If
		  
		  Try
		    Self.mLogManager.Destination = LogsFolder
		  Catch Err As RuntimeException
		    BeaconUI.ShowAlert("Unable to start log system", "Beacon was unable to create its logs folder at " + LogsFolder.NativePath + ". Disk write access may be disabled or the disk may be full.")
		    Quit
		    Return
		  End Try
		  
		  Try
		    Self.mLogManager.Claim(Self.ApplicationSupport.Child("Events.log"))
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.mLogManager.Cleanup
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    Self.mLogManager.Flush
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_SetupNewProjectMenuItems()
		  Var Base As DesktopMenuItem = FileNewProjectForGame
		  Var Games() As Beacon.Game = Beacon.Games
		  If Games.Count = 1 Then
		    Base.Visible = False
		  Else
		    For Each Game As Beacon.Game In Games
		      Var Item As New DesktopMenuItem(Game.Name, Game.Identifier)
		      Item.AutoEnabled = False
		      AddHandler Item.MenuItemSelected, AddressOf mGameMenu_MenuItemSelected
		      Base.AddMenu(Item)
		    Next
		  End If
		  Self.NextLaunchQueueTask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_ShowMainWindow()
		  Self.mMainWindow = New MainWindow
		  Self.mMainWindow.Show()
		  
		  While Self.mPendingURLs.Count > 0
		    Call Self.HandleURL(Self.mPendingURLs(0), False)
		    Self.mPendingURLs.RemoveAt(0)
		  Wend
		  
		  Call CallLater.Schedule(3000, WeakAddressOf PostlaunchGamedataSync)
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_StartDataUpdateChecking()
		  Var DataUpdateTimer As Timer = New Timer
		  DataUpdateTimer.RunMode = Timer.RunModes.Multiple
		  DataUpdateTimer.Period = 21600000 // 6 hours
		  AddHandler DataUpdateTimer.Action, WeakAddressOf mDataUpdateTimer_Action
		  
		  Self.mDataUpdateTimer = DataUpdateTimer
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_StartPusher()
		  Self.mPusher = New Beacon.PusherSocket
		  If (Self.mIdentityManager Is Nil) = False And Self.mIdentityManager.CurrentUserId.IsEmpty = False Then
		    Self.mPusher.Start()
		    Self.SubscribeToPusherPublic()
		  End If
		  Self.NextLaunchQueueTask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_SubmitExceptions()
		  ExceptionWindow.SubmitPendingReports()
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_WelcomeWindow()
		  // Show what's new window if necessary. The method will handle its own "if necessary" part.
		  WhatsNewWindow.Present(Preferences.NewestUsedBuild)
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LaunchUpdate(File As FolderItem, Relaunch As Boolean)
		  If File Is Nil Or File.Exists = False Then
		    Return
		  End If
		  
		  Self.mLaunchOnQuit = True
		  Self.mRelaunchAfterUpdate = Relaunch
		  Self.mUpdateFile = File
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LibrariesFolder(Create As Boolean = True) As FolderItem
		  Var Folder As FolderItem = Self.ApplicationSupport.Child("Libraries")
		  If Folder.Exists = False And Create = True Then
		    Call Folder.CheckIsFolder
		  End If
		  Return Folder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Err As RuntimeException, Location As String, MoreDetail As String = "")
		  If Err IsA ThreadEndException Then
		    Return
		  End If
		  
		  Self.mLogManager.Log(Err, Location, MoreDetail)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String)
		  Self.mLogManager.Log(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LogAPIException(Err As RuntimeException, Location As String, URL As String, HTTPStatus As Integer, RawContent As MemoryBlock)
		  If Err Is Nil Then
		    Return
		  End If
		  
		  If Self.AffectedBy72314() Then
		    Return
		  End If
		  
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Var Base64 As String
		  If RawContent <> Nil And RawContent.Size > 0 Then
		    Base64 = EncodeBase64(RawContent, 0)
		  End If
		  Self.Log("Unhandled " + Info.FullName + " in " + Location + ": HTTP " + HTTPStatus.ToString(Locale.Raw, "0") + " from " + URL + "; Base64 Response: " + Base64)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogsFolder() As FolderItem
		  Return Self.mLogManager.Destination
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainWindow() As MainWindow
		  Return Self.mMainWindow
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MBSLicense() As String
		  Const Chars = Self.MBSKey
		  Return DefineEncoding(DecodeBase64(Chars.Middle(51, 1) + Chars.Middle(43, 1) + Chars.Middle(10, 1) + Chars.Middle(27, 1) + Chars.Middle(1, 1) + Chars.Middle(38, 1) + Chars.Middle(4, 1) + Chars.Middle(37, 1) + Chars.Middle(0, 1) + Chars.Middle(31, 1) + Chars.Middle(50, 1) + Chars.Middle(43, 1) + Chars.Middle(14, 1) + Chars.Middle(2, 1) + Chars.Middle(21, 1) + Chars.Middle(44, 1) + Chars.Middle(35, 1) + Chars.Middle(40, 1) + Chars.Middle(1, 1) + Chars.Middle(7, 1) + Chars.Middle(1, 1) + Chars.Middle(38, 1) + Chars.Middle(4, 1) + Chars.Middle(24, 1) + Chars.Middle(48, 1) + Chars.Middle(52, 1) + Chars.Middle(24, 1) + Chars.Middle(27, 1) + Chars.Middle(46, 1) + Chars.Middle(49, 1) + Chars.Middle(21, 1) + Chars.Middle(48, 1) + Chars.Middle(1, 1) + Chars.Middle(21, 1) + Chars.Middle(11, 1) + Chars.Middle(6, 1) + Chars.Middle(13, 1) + Chars.Middle(46, 1) + Chars.Middle(20, 1) + Chars.Middle(42, 1) + Chars.Middle(14, 1) + Chars.Middle(25, 1) + Chars.Middle(9, 1) + Chars.Middle(45, 1) + Chars.Middle(17, 1) + Chars.Middle(38, 1) + Chars.Middle(10, 1) + Chars.Middle(27, 1) + Chars.Middle(1, 1) + Chars.Middle(38, 1) + Chars.Middle(4, 1) + Chars.Middle(30, 1) + Chars.Middle(29, 1) + Chars.Middle(46, 1) + Chars.Middle(11, 1) + Chars.Middle(23, 1) + Chars.Middle(29, 1) + Chars.Middle(46, 1) + Chars.Middle(13, 1) + Chars.Middle(18, 1) + Chars.Middle(1, 1) + Chars.Middle(36, 1) + Chars.Middle(8, 1) + Chars.Middle(27, 1) + Chars.Middle(1, 1) + Chars.Middle(49, 1) + Chars.Middle(37, 1) + Chars.Middle(38, 1) + Chars.Middle(24, 1) + Chars.Middle(43, 1) + Chars.Middle(47, 1) + Chars.Middle(5, 1) + Chars.Middle(14, 1) + Chars.Middle(31, 1) + Chars.Middle(37, 1) + Chars.Middle(30, 1) + Chars.Middle(14, 1) + Chars.Middle(52, 1) + Chars.Middle(50, 1) + Chars.Middle(6, 1) + Chars.Middle(35, 1) + Chars.Middle(40, 1) + Chars.Middle(1, 1) + Chars.Middle(53, 1) + Chars.Middle(1, 1) + Chars.Middle(38, 1) + Chars.Middle(10, 1) + Chars.Middle(27, 1) + Chars.Middle(1, 1) + Chars.Middle(2, 1) + Chars.Middle(50, 1) + Chars.Middle(41, 1) + Chars.Middle(0, 1) + Chars.Middle(52, 1) + Chars.Middle(18, 1) + Chars.Middle(43, 1) + Chars.Middle(35, 1) + Chars.Middle(28, 1) + Chars.Middle(9, 1) + Chars.Middle(45, 1) + Chars.Middle(15, 1) + Chars.Middle(45, 1) + Chars.Middle(10, 1) + Chars.Middle(43, 1) + Chars.Middle(9, 1) + Chars.Middle(5, 1) + Chars.Middle(1, 1) + Chars.Middle(6, 1) + Chars.Middle(9, 1) + Chars.Middle(5, 1) + Chars.Middle(9, 1) + Chars.Middle(53, 1) + Chars.Middle(1, 1) + Chars.Middle(38, 1) + Chars.Middle(10, 1) + Chars.Middle(27, 1) + Chars.Middle(1, 1) + Chars.Middle(33, 1) + Chars.Middle(11, 1) + Chars.Middle(18, 1) + Chars.Middle(0, 1) + Chars.Middle(2, 1) + Chars.Middle(18, 1) + Chars.Middle(26, 1) + Chars.Middle(14, 1) + Chars.Middle(38, 1) + Chars.Middle(1, 1) + Chars.Middle(7, 1) + Chars.Middle(1, 1) + Chars.Middle(38, 1) + Chars.Middle(4, 1) + Chars.Middle(17, 1) + Chars.Middle(24, 1) + Chars.Middle(2, 1) + Chars.Middle(34, 1) + Chars.Middle(40, 1) + Chars.Middle(9, 1) + Chars.Middle(37, 1) + Chars.Middle(4, 1) + Chars.Middle(47, 1) + Chars.Middle(12, 1) + Chars.Middle(37, 1) + Chars.Middle(50, 1) + Chars.Middle(32, 1) + Chars.Middle(13, 1) + Chars.Middle(22, 1) + Chars.Middle(26, 1) + Chars.Middle(20, 1) + Chars.Middle(14, 1) + Chars.Middle(16, 1) + Chars.Middle(21, 1) + Chars.Middle(31, 1) + Chars.Middle(9, 1) + Chars.Middle(49, 1) + Chars.Middle(20, 1) + Chars.Middle(18, 1) + Chars.Middle(13, 1) + Chars.Middle(21, 1) + Chars.Middle(10, 1) + Chars.Middle(6, 1) + Chars.Middle(11, 1) + Chars.Middle(52, 1) + Chars.Middle(54, 1) + Chars.Middle(23, 1) + Chars.Middle(46, 1) + Chars.Middle(18, 1) + Chars.Middle(32, 1) + Chars.Middle(23, 1) + Chars.Middle(14, 1) + Chars.Middle(33, 1) + Chars.Middle(47, 1) + Chars.Middle(1, 1) + Chars.Middle(46, 1) + Chars.Middle(5, 1) + Chars.Middle(22, 1) + Chars.Middle(25, 1) + Chars.Middle(40, 1) + Chars.Middle(2, 1) + Chars.Middle(44, 1) + Chars.Middle(40, 1) + Chars.Middle(48, 1) + Chars.Middle(22, 1) + Chars.Middle(50, 1) + Chars.Middle(41, 1) + Chars.Middle(40, 1) + Chars.Middle(22, 1) + Chars.Middle(18, 1) + Chars.Middle(39, 1) + Chars.Middle(48, 1) + Chars.Middle(52, 1) + Chars.Middle(6, 1) + Chars.Middle(54, 1) + Chars.Middle(20, 1) + Chars.Middle(49, 1) + Chars.Middle(42, 1) + Chars.Middle(2, 1) + Chars.Middle(24, 1) + Chars.Middle(24, 1) + Chars.Middle(54, 1) + Chars.Middle(7, 1) + Chars.Middle(13, 1) + Chars.Middle(28, 1) + Chars.Middle(13, 1) + Chars.Middle(21, 1) + Chars.Middle(32, 1) + Chars.Middle(37, 1) + Chars.Middle(42, 1) + Chars.Middle(31, 1) + Chars.Middle(11, 1) + Chars.Middle(24, 1) + Chars.Middle(34, 1) + Chars.Middle(3, 1) + Chars.Middle(9, 1) + Chars.Middle(19, 1) + Chars.Middle(6, 1) + Chars.Middle(34, 1) + Chars.Middle(1, 1) + Chars.Middle(45, 1) + Chars.Middle(47, 1) + Chars.Middle(34, 1)),Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDataUpdateTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Preferences.OnlineEnabled = False Or Self.IdentityManager Is Nil Or Self.IdentityManager.CurrentIdentity Is Nil Then
		    Return
		  End If
		  
		  Self.SyncGamedata(True, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mGameMenu_MenuItemSelected(Sender As DesktopMenuItem) As Boolean
		  If (Self.mMainWindow Is Nil) = False Then
		    Self.mMainWindow.Documents(False).NewProject(Sender.Tag.StringValue)
		  End If
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHandoffSocket_DataReceived(Sender As IPCSocket)
		  Do
		    Var Buffer As String = DefineEncoding(Sender.Lookahead, Encodings.UTF8)
		    Var Pos As Integer = Buffer.IndexOf(Encodings.UTF8.Chr(0))
		    If Pos = -1 Then
		      Exit
		    End If
		    
		    Var Command As String = DefineEncoding(Sender.Read(Pos), Encodings.UTF8)
		    Call Sender.Read(1) // To drop the null byte from the buffer
		    Self.Log("Received command line data: " + Command)
		    Self.HandleCommandLineData(Command, False)
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHandoffSocket_Error(Sender As IPCSocket, Err As RuntimeException)
		  Var Code As Integer = Err.ErrorNumber
		  If Code = 102 Then
		    Call CallLater.Schedule(100, AddressOf Sender.Listen)
		  Else
		    App.Log("IPC error " + Code.ToString(Locale.Raw, "0"))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_ClearMenu(Sender As DesktopMenuItem) As Boolean
		  #Pragma Unused Sender
		  
		  Var Projects() As Beacon.ProjectURL
		  Preferences.RecentDocuments = Projects
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_OpenFile(Sender As DesktopMenuItem) As Boolean
		  If (Self.mMainWindow Is Nil) = False Then
		    Var Project As Beacon.ProjectURL = Sender.Tag
		    Self.mMainWindow.Documents.OpenProject(Project)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NextLaunchQueueTask()
		  If Self.mLaunchQueue.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Task As LaunchQueueTask = Self.mLaunchQueue(0)
		  Self.mLaunchQueue.RemoveAt(0)
		  
		  Task.Invoke()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case Preferences.Notification_RecentsChanged
		    Self.RebuildRecentMenu()
		  Case UserCloud.Notification_SyncStarted
		    HelpSyncCloudFiles.Text = "Syncing Cloud Files…"
		    HelpSyncCloudFiles.Enabled = False
		  Case UserCloud.Notification_SyncFinished
		    HelpSyncCloudFiles.Text = "Sync Cloud Files"
		    HelpSyncCloudFiles.Enabled = True
		    If Self.mMigrateAfterSync Then
		      UserMigratorDialog.Present(True)
		      Self.mMigrateAfterSync = False
		    End If
		  Case Preferences.Notification_OnlineStateChanged
		    UpdatesKit.IsCheckingAutomatically = Preferences.OnlineEnabled
		  Case DataUpdater.Notification_ImportStopped
		    If Self.mHasTestedDatabases = False Then
		      For Each Source As Beacon.DataSource In Self.mDataSources
		        Var Result As Beacon.DataSource.PerformanceResults = Source.TestPerformance(True)
		        Select Case Result
		        Case Beacon.DataSource.PerformanceResults.CouldNotRepair
		          App.Log("Database " + Source.Identifier + " is performing poorly and repair did not help.")
		        Case Beacon.DataSource.PerformanceResults.Repaired
		          App.Log("Database " + Source.Identifier + " was performing poorly but has been repaired.")
		        Case Beacon.DataSource.PerformanceResults.RepairsNecessary
		          App.Log("Database " + Source.Identifier + " is performing poorly and should be repaired.")
		        End Select
		      Next Source
		      Self.mHasTestedDatabases = True
		    End If
		  Case IdentityManager.Notification_IdentityChanged
		    If (Self.mPusher Is Nil) = False Then
		      Self.mPusher.Stop
		      Self.mPusher = Nil
		    End If
		    
		    Self.mPusher = New Beacon.PusherSocket
		    If (Self.mIdentityManager Is Nil) = False Then
		      Var UserId As String = Self.mIdentityManager.CurrentUserId
		      If UserId.IsEmpty = False Then
		        Self.mPusher.Start()
		        Self.SubscribeToPusherPublic()
		        Var UserChannelName As String = Beacon.PusherSocket.UserChannelName(UserId)
		        Self.mPusher.Listen(UserChannelName, "user-updated", AddressOf Pusher_UserUpdated)
		        Self.mPusher.Listen(UserChannelName, "cloud-updated", AddressOf Pusher_CloudUpdated)
		      End If
		    End If
		    
		    Self.mMigrateAfterSync = True
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OldestSync() As Double
		  Var MinValue As Double
		  For Idx As Integer = Self.mDataSources.FirstIndex To Self.mDataSources.LastIndex
		    If Idx = Self.mDataSources.FirstIndex Then
		      MinValue = Self.mDataSources(Idx).LastSyncTimestamp
		    Else
		      MinValue = Min(MinValue, Self.mDataSources(Idx).LastSyncTimestamp)
		    End If
		  Next Idx
		  Return MinValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OldestSyncDateTime(Local As Boolean = False) As DateTime
		  Var Value As Double = Self.OldestSync
		  If Value = 0 Then
		    Return Nil
		  End If
		  If Local Then
		    Return New DateTime(Value)
		  Else
		    Return New DateTime(Value, New TimeZone(0))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenFile(File As FolderItem, Import As Boolean)
		  If Self.mIdentityManager Is Nil Or Self.mIdentityManager.CurrentIdentity Is Nil Or Self.mMainWindow Is Nil Then
		    Return
		  End If
		  
		  If Not File.Exists Then
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionDelta) Or File.ExtensionMatches(Beacon.FileExtensionJSON) Then
		    DataUpdater.Import(File)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionPreset, Beacon.FileExtensionTemplate) Then
		    Self.mMainWindow.BringToFront()
		    Self.mMainWindow.Templates.OpenTemplate(File, Import)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionINI) Or File.ExtensionMatches(Beacon.FileExtensionXml) Then
		    Self.mMainWindow.BringToFront()
		    Self.mMainWindow.Documents.ImportFile(File)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionProject) Then
		    Self.mMainWindow.BringToFront()
		    Self.mMainWindow.Documents.OpenProject(File)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionIdentity) Then
		    Call Self.ImportIdentityFile(File)
		    Return
		  End If
		  
		  BeaconUI.ShowAlert("Unable to open file", "Beacon doesn't know what to do with the file " + File.Name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParentFolder() As FolderItem
		  #if TargetMacOS
		    Return Self.ExecutableFile.Parent.Parent.Parent.Parent
		  #else
		    Return Self.ExecutableFile.Parent
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PostlaunchGamedataSync()
		  Self.SyncGamedata(True, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentException(Err As Variant)
		  ExceptionWindow.Present(Err)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pusher() As Beacon.PusherSocket
		  Return Self.mPusher
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_CloudUpdated(ChannelName As String, EventName As String, Payload As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  
		  Try
		    Var Json As JSONItem = New JSONItem(Payload)
		    If Json.HasKey("deviceId") And Json.Value("deviceId").IsNull = False And Json.Value("deviceId").Type = Variant.TypeString And Beacon.HardwareId = Json.Value("deviceId") Then
		      // Message was sent from this device
		      Return
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing cloud update event")
		    Return
		  End Try
		  
		  // Even though the server is telling us changes were made, wait just in case
		  UserCloud.Sync(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_UpdateBlueprints(ChannelName As String, EventName As String, Payload As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  #Pragma Unused Payload
		  
		  If Self.mPusherUpdateBlueprintsKey.IsEmpty = False Then
		    // There is already an action scheduled
		    Return
		  End If
		  
		  Var Delay As Integer = System.Random.InRange(0, 60)
		  Self.mPusherUpdateBlueprintsKey = CallLater.Schedule(Delay * 1000, AddressOf Pusher_UpdateBlueprints_Actual)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_UpdateBlueprints_Actual()
		  Self.SyncGamedata(True, False)
		  Self.mPusherUpdateBlueprintsKey = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pusher_UserUpdated(ChannelName As String, EventName As String, Payload As String)
		  #Pragma Unused ChannelName
		  #Pragma Unused EventName
		  #Pragma Unused Payload
		  
		  BeaconAPI.UserController.RefreshUserDetails(BeaconAPI.UserController.VerbosityLoginOnly)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildRecentMenu()
		  While FileOpenRecent.Count > 0
		    FileOpenRecent.RemoveMenuAt(0)
		  Wend
		  
		  Var Projects() As Beacon.ProjectURL = Preferences.RecentDocuments
		  For Each Project As Beacon.ProjectURL In Projects
		    Var Item As New DesktopMenuItem(Project.Name)
		    Item.Tag = Project
		    Item.Enabled = True
		    AddHandler Item.MenuItemSelected, WeakAddressOf mOpenRecent_OpenFile
		    FileOpenRecent.AddMenu(Item)
		  Next
		  If Projects.LastIndex > -1 Then
		    FileOpenRecent.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		    
		    Var Item As New DesktopMenuItem("Clear Menu")
		    Item.Enabled = True
		    AddHandler Item.MenuItemSelected, WeakAddressOf mOpenRecent_ClearMenu
		    FileOpenRecent.AddMenu(Item)
		  Else
		    Var Item As New DesktopMenuItem("No Items")
		    Item.Enabled = False
		    FileOpenRecent.AddMenu(Item)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReportException(Err As RuntimeException, Comments As String = "")
		  // Does not display the exception to the user, instead uploads it directly to the server.
		  ExceptionWindow.Report(Err, Comments)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourcesFolder() As FolderItem
		  #if TargetMacOS
		    Return Self.ExecutableFile.Parent.Parent.Child("Resources")
		  #else
		    Var Parent As FolderItem = Self.ExecutableFile.Parent
		    If Parent.Child("Resources").Exists Then
		      Return Parent.Child("Resources")
		    Else
		      Var ExtensionLength As Integer
		      #if TargetWindows
		        ExtensionLength = 4
		      #endif
		      Var Name As String = Self.ExecutableFile.Name.Left(Self.ExecutableFile.Name.Length - ExtensionLength)
		      Return Parent.Child(Name + " Resources")
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowOpenDocument(Parent As DesktopWindow = Nil)
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument + BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.BeaconIdentity
		  
		  Var File As FolderItem
		  If Parent Is Nil Then
		    File = Dialog.ShowModal()
		  Else
		    File = Dialog.ShowModal(Parent.TrueWindow)
		  End If
		  If (File Is Nil) = False Then
		    Self.OpenDocument(File)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowReleaseNotes()
		  System.GotoURL(Beacon.WebURL("/history?stage=" + Self.StageCode.ToString(Locale.Raw, "0") + "#build" + Self.BuildNumber.ToString(Locale.Raw, "0")))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSpawnCodes()
		  System.GotoURL(Beacon.WebURL("/spawn/"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTicket()
		  Var Win As New SupportTicketWindow
		  Win.Show
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SubscribeToPusherPublic()
		  Self.mPusher.Subscribe("beacon-public")
		  Self.mPusher.Listen("beacon-public", "update-blueprints", AddressOf Pusher_UpdateBlueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SyncGamedata(Silent As Boolean, ForceRefresh As Boolean)
		  If Silent Then
		    If Preferences.OnlineEnabled = False Then
		      Return
		    End If
		    
		    DataUpdater.CheckNow(ForceRefresh)
		    Return
		  End If
		  
		  If Self.GetOnlinePermission() = False Then
		    Return
		  End If
		  
		  EngramsUpdateWindow.SyncAndShowIfNecessary(ForceRefresh)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TemporarilyInstallFont(File As FolderItem)
		  #if TargetWin32
		    Soft Declare Sub AddFontResourceExW Lib "Gdi32" (Filename As WString, Flags As Integer, Reserved As Integer)
		    If System.IsFunctionAvailable("AddFontResourceExW", "Gdi32") Then
		      AddFontResourceExW(File.NativePath, &h10, 0)
		    End If
		  #else
		    #Pragma Unused File
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Terminate(ReturnCode As Integer)
		  #if TargetMacOS
		    Declare Sub HardTerminate Lib "System" Alias "exit" (Code As Integer)
		    HardTerminate(ReturnCode)
		  #elseif TargetWin32
		    Declare Sub ExitProcess Lib "Kernel32" (uExitCode As UInt32)
		    ExitProcess(ReturnCode)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UninstallTemporaryFont(File As FolderItem)
		  #if TargetWin32
		    Soft Declare Sub RemoveFontResourceExW Lib "Gdi32" (Filename As WString, Flags As Integer, Reserved As Integer)
		    If System.IsFunctionAvailable("RemoveFontResourceExW", "Gdi32") Then
		      RemoveFontResourceExW(File.NativePath, &h10, 0)
		    End If
		  #else
		    #Pragma Unused File
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserAgent() As String
		  If Self.mUserAgent.IsEmpty Then
		    Var Components() As String
		    Components.Add("Language=Xojo/" + XojoVersionString)
		    Components.Add("Platform=" + Beacon.OSName + "/" + Beacon.OSVersionString)
		    #if Target32Bit
		      Components.Add("Architecture=32-bit " + If(TargetARM, "ARM", "Intel"))
		    #else
		      Components.Add("Architecture=64-bit " + If(TargetARM, "ARM", "Intel"))
		    #endif
		    Components.Add("Plugins=MBS/" + MBS.VersionString + "." + MBS.BuildNumber.ToString(Locale.Raw, "0"))
		    
		    Self.mUserAgent = "Beacon/" + Self.BuildVersion + " (" + Components.Join("; ") + ")"
		  End If
		  Return Self.mUserAgent
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDataFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDataSources() As Beacon.DataSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDataUpdateTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandoffSocket As IPCSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasTestedDatabases As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentityManager As IdentityManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLaunchOnQuit As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLaunchQueue() As LaunchQueueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogManager As LogManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMainWindow As MainWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMigrateAfterSync As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingURLs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPortableMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPusher As Beacon.PusherSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPusherUpdateBlueprintsKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRelaunchAfterUpdate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserAgent As String
	#tag EndProperty


	#tag Constant, Name = ForceLiveData, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kEditPreferences, Type = String, Dynamic = False, Default = \"Options\xE2\x80\xA6", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Preferences\xE2\x80\xA6"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant

	#tag Constant, Name = MBSKey, Type = String, Dynamic = False, Default = \"Nice try", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_AppearanceChanged, Type = String, Dynamic = False, Default = \"Appearance Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UsePreviewMode, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
