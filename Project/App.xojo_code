#tag Class
Protected Class App
Inherits Application
Implements NotificationKit.Receiver,Beacon.Application
	#tag Event
		Sub AppearanceChanged()
		  NotificationKit.Post(Self.Notification_AppearanceChanged, Nil)
		  
		  OmniBar.RebuildColors()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  Try
		    Self.UninstallTemporaryFont(Self.ResourcesFolder.Child("Fonts").Child("SourceCodePro").Child("SourceCodePro-Regular.otf"))
		  Catch Err As RuntimeException
		    // Whatever
		  End Try
		  
		  Var LocalData As LocalData = LocalData.SharedInstance(False)
		  If (LocalData Is Nil) = False Then
		    LocalData.Close
		  End If
		  
		  If Self.mMutex <> Nil Then
		    Self.mMutex.Leave
		  End If
		  
		  If Self.LaunchOnQuit <> Nil And Self.LaunchOnQuit.Exists Then
		    Self.Log("Launching " + Self.LaunchOnQuit.NativePath)
		    Self.LaunchOnQuit.Open
		  End If
		  
		  Self.Log("Beacon finished gracefully")
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileNew.Enabled = True
		  FileNewPreset.Enabled = True
		  FileOpen.Enabled = True
		  FileImport.Enabled = True
		  
		  If Preferences.OnlineEnabled Then
		    HelpSyncCloudFiles.Visible = True
		    HelpUpdateEngrams.Visible = True
		    HelpSeparator2.Visible = True
		    
		    If UserCloud.IsBusy = False Then
		      HelpSyncCloudFiles.Enabled = True
		    End If
		    
		    If Keyboard.OptionKey Then
		      HelpUpdateEngrams.Text = "Refresh Blueprints"
		    Else
		      HelpUpdateEngrams.Text = "Update Blueprints"
		    End If
		    HelpUpdateEngrams.Enabled = True
		  Else
		    HelpSyncCloudFiles.Visible = False
		    HelpUpdateEngrams.Visible = False
		    HelpSeparator2.Visible = False
		  End If
		  
		  Var Counter As Integer = 1
		  For I As Integer = 0 To WindowCount - 1
		    Var Win As Window = Window(I)
		    If Win IsA BeaconWindow Then
		      BeaconWindow(Win).UpdateWindowMenu()
		      Counter = Counter + 1
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function HandleAppleEvent(theEvent As AppleEvent, eventClass As String, eventID As String) As Boolean
		  If eventClass = "GURL" And eventID = "GURL" Then
		    Var URL As String = theEvent.StringParam("----")
		    Return Self.HandleURL(URL)
		  Else
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
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
		  
		  Var Lock As New Mutex("com.thezaz.beacon" + If(DebugBuild, ".debug", ""))
		  If Not Lock.TryEnter Then
		    #if Not TargetMacOS
		      Var StartTime As Double = System.Microseconds
		      Var PushSocket As New IPCSocket
		      PushSocket.Path = Self.ApplicationSupport.Child("ipc").NativePath
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
		    Self.mMutex = Lock
		    #if Not TargetMacOS
		      Self.mHandoffSocket = New IPCSocket
		      Self.mHandoffSocket.Path = Self.ApplicationSupport.Child("ipc").NativePath
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
		    UntitledSeparator6.Visible = False
		  #endif
		  Self.RebuildRecentMenu
		  
		  SystemColors.Init
		  
		  NotificationKit.Watch(Self, BeaconAPI.Socket.Notification_Unauthorized, Preferences.Notification_RecentsChanged, UserCloud.Notification_SyncStarted, UserCloud.Notification_SyncFinished, Preferences.Notification_OnlineStateChanged, LocalData.Notification_ImportSuccess)
		  
		  Var IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + Beacon.FileExtensionIdentity)
		  Self.mIdentityManager = New IdentityManager(IdentityFile)
		  AddHandler mIdentityManager.NeedsLogin, WeakAddressOf mIdentityManager_NeedsLogin
		  
		  Try
		    Self.TemporarilyInstallFont(Self.ResourcesFolder.Child("Fonts").Child("SourceCodePro").Child("SourceCodePro-Regular.otf"))
		  Catch Err As RuntimeException
		    // Not critically important
		  End Try
		  
		  #if TargetMacOS
		    EditPrefsSeparator.Visible = False
		  #endif
		  
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CheckBetaExpiration)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SetupLogs)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_PrivacyCheck)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SetupDatabase)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CleanupConfigBackups)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_ShowMainWindow)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_RequestUser)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CheckUpdates)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_CheckScreenSize)
		  Self.mLaunchQueue.Add(AddressOf LaunchQueue_SubmitExceptions)
		  If BeaconUI.WebContentSupported Then
		    Self.mLaunchQueue.Add(AddressOf LaunchQueue_WelcomeWindow)
		  End If
		  Self.NextLaunchQueueTask
		  
		  #if Not TargetMacOS
		    Self.HandleCommandLineData(System.CommandLine, True)
		  #endif
		  
		  Self.AllowAutoQuit = True
		  
		  Tests.RunTests()
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  Self.OpenFile(Item, False)
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
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
			Dialog.Filter = BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.BeaconData + BeaconFileTypes.BeaconIdentity
			
			Var File As FolderItem = Dialog.ShowModal
			If File <> Nil Then
			Self.OpenFile(File, True)
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
			If (Self.mMainWindow Is Nil) = False Then
			Self.mMainWindow.Documents.NewDocument
			End If
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNewPreset() As Boolean Handles FileNewPreset.Action
			If (Self.mMainWindow Is Nil) = False Then
			Self.mMainWindow.Presets.NewPreset
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
		Function HelpAPIBuilder() As Boolean Handles HelpAPIBuilder.Action
			Call Self.HandleURL("beacon://action/showapibuilder")
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
		Function HelpCreateOfflineAuthorizationRequest() As Boolean Handles HelpCreateOfflineAuthorizationRequest.Action
			Var Dialog As New SaveFileDialog
			Dialog.SuggestedFileName = "Authorization Request" + Beacon.FileExtensionAuth
			
			Var File As FolderItem = Dialog.ShowModal()
			If File = Nil Then
			Return True
			End If
			
			Var Identity As Beacon.Identity = Self.IdentityManager.CurrentIdentity
			
			Var HardwareID As String = Beacon.HardwareID
			Var Signed As MemoryBlock = Identity.Sign(HardwareID)
			
			Var Dict As New Dictionary
			Dict.Value("UserID") = Identity.UserID
			Dict.Value("Signed") = EncodeHex(Signed)
			Dict.Value("Device") = HardwareID
			
			Var JSON As String = Beacon.GenerateJSON(Dict, False)
			If Not File.Write(JSON) Then
			BeaconUI.ShowAlert("Could not create offline authorization request.", "There was a problem writing the file to disk.")
			End If
			
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
		Function HelpOpenDataFolder() As Boolean Handles HelpOpenDataFolder.Action
			Self.ApplicationSupport.Open
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
		Function HelpReportAProblem() As Boolean Handles HelpReportAProblem.Action
			Self.ShowBugReporter()
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
			If Keyboard.OptionKey Then
			Call Self.HandleURL(Beacon.URLScheme + "://action/refreshengrams")
			Else
			Call Self.HandleURL(Beacon.URLScheme + "://action/checkforengrams")
			End If
			Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  Var AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Call AppSupport.CheckIsFolder
		  Var CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Call CompanyFolder.CheckIsFolder
		  Var AppFolder As FolderItem = CompanyFolder.Child(if(DebugBuild, "Beacon Debug", "Beacon"))
		  Call AppFolder.CheckIsFolder
		  Return AppFolder
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
		  If Self.BugVersion > 0 Or (Self.StageCode = Application.Final And Self.NonReleaseVersion > 0) Or Self.StageCode <> Application.Final Then
		    VersionString = VersionString + "." + Self.BugVersion.ToString(Locale.Raw, "0")
		  End If
		  Select Case Self.StageCode
		  Case Application.Development
		    Return VersionString + "pa" + Self.NonReleaseVersion.ToString(Locale.Raw, "0")
		  Case Application.Alpha
		    Return VersionString + "a" + Self.NonReleaseVersion.ToString(Locale.Raw, "0")
		  Case Application.Beta
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
		    UpdateWindow.Present()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenericLootSourceIcon() As Picture
		  Return IconLootStandard
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetOnlinePermission() As Boolean
		  If Self.mIdentityManager.CurrentIdentity <> Nil And Preferences.OnlineEnabled Then
		    Return True
		  End If
		  
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
		  
		  If Thread.Current = Nil Then
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
		    If ParamsPos > -1 Then
		      Instructions = Instructions.Left(ParamsPos)
		    End If
		    
		    Select Case Instructions
		    Case "showdocuments"
		      Self.mMainWindow.ShowDocuments()
		    Case "showpresets"
		      Self.mMainWindow.ShowPresets()
		    Case "showengrams", "showblueprints", "showmods"
		      Self.mMainWindow.ShowBlueprints()
		    Case "showidentity"
		      IdentityWindow.Show()
		    Case "showguide"
		      System.GotoURL(Beacon.WebURL("/docs/api/v" + BeaconAPI.Version.ToString))
		    Case "showapibuilder"
		      APIBuilderWindow.Show()
		    Case "shownewsletterprompt"
		      SubscribeDialog.Present()
		    Case "checkforupdate"
		      Self.CheckForUpdates()
		    Case "checkforengrams"
		      If Self.GetOnlinePermission() Then
		        EngramsUpdateWindow.ShowIfNecessary()
		        LocalData.SharedInstance.CheckForEngramUpdates
		      End If
		    Case "refreshengrams"
		      If Self.GetOnlinePermission() Then
		        EngramsUpdateWindow.ShowIfNecessary()
		        LocalData.SharedInstance.CheckForEngramUpdates(True)
		      End If
		    Case "refreshuser"
		      Self.IdentityManager.RefreshUserDetails()
		    Case "releasenotes"
		      Self.ShowReleaseNotes()
		    Case "enableonline"
		      UserWelcomeWindow.Present(False)
		    Case "signin"
		      UserWelcomeWindow.Present(True)
		    Case "showaccount"
		      System.GotoURL(Beacon.WebURL("/account/auth?session_id=" + Preferences.OnlineToken + "&return=" + EncodeURLComponent(Beacon.WebURL("/account/"))))
		    Case "spawncodes"
		      Self.ShowSpawnCodes()
		    Case "reportproblem"
		      Self.ShowBugReporter()
		    Case "newhelpticket"
		      Self.StartTicket()
		    Case "exit"
		      Quit
		    Case "signout"
		      Preferences.OnlineEnabled = False
		      Preferences.OnlineToken = ""
		      Self.IdentityManager.CurrentIdentity = Nil
		      
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
		    
		    Var UserData As New Dictionary
		    UserData.Value("ConfigName") = ConfigName
		    UserData.Value("Path") = Path
		    UserData.Value("Parameters") = Parameters
		    
		    Var FrontmostView As DocumentEditorView = Self.mMainWindow.FrontmostDocumentView
		    If FrontmostView Is Nil Then
		      Self.mMainWindow.Documents.NewDocument
		      FrontmostView = Self.mMainWindow.FrontmostDocumentView
		    End If
		    If (FrontmostView Is Nil) = False Then
		      UserData.Value("DocumentID") = FrontmostView.Document.DocumentID
		      
		      NotificationKit.Post(DocumentEditorView.Notification_SwitchEditors, UserData)
		    End If
		  Else
		    Var LegacyURL As String = "thezaz.com/beacon/documents.php/"
		    Var Idx As Integer = URL.IndexOf(LegacyURL)
		    If Idx > -1 Then
		      Var DocID As String = URL.Middle(Idx + LegacyURL.Length)
		      URL = BeaconAPI.URL("/document/" + DocID)
		    End If
		    
		    Var FileURL As String = "https://" + URL
		    Self.mMainWindow.Documents.OpenDocument(FileURL)
		  End If
		  
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
		Sub ImportIdentityFile(File As FolderItem, ParentWindow As Window = Nil)
		  If ParentWindow = Nil Then
		    ParentWindow = MainWindow
		  End If
		  
		  Var Stream As TextInputStream = TextInputStream.Open(File)
		  Var Contents As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Var Dict As Dictionary
		  Try
		    Dict = Beacon.ParseJSON(Contents)
		  Catch Err As RuntimeException
		    ParentWindow.ShowAlert("Cannot import identity", "File is not an identity file.")
		    Return
		  End Try
		  
		  Var Identity As Beacon.Identity
		  If Beacon.Identity.IsUserDictionary(Dict) Then
		    // Password is needed to decrypt
		    Identity = IdentityDecryptDialog.ShowDecryptIdentityDict(ParentWindow, Dict)
		    If Identity = Nil Then
		      Return
		    End If
		  Else
		    Identity = Beacon.Identity.Import(Dict)
		    If Identity = Nil Then
		      ParentWindow.ShowAlert("Cannot import identity", "File is not an identity file.")
		      Return
		    End If
		  End If
		  
		  Self.IdentityManager.CurrentIdentity = Identity
		End Sub
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
		  Var LargestScreen As Integer = -1
		  Var Bound As Integer = ScreenCount - 1
		  For Idx As Integer = 0 To Bound
		    If LargestScreen = -1 Then
		      LargestScreen = Idx
		    Else
		      If (Screen(Idx).Width * Screen(Idx).Height) > (Screen(LargestScreen).Width * Screen(LargestScreen).Height) Then
		        LargestScreen = Idx
		      End If
		    End If
		  Next
		  
		  Var ScreenSize As New Size(Screen(LargestScreen).Width, Screen(LargestScreen).Height)
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
		  If Self.mIdentityManager.CurrentIdentity = Nil Then
		    UserWelcomeWindow.Present(False)
		  Else
		    Self.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_RequestUser()
		  Self.mIdentityManager.RefreshUserDetails()
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_SetupDatabase()
		  Try
		    LocalData.Start
		  Catch Err As RuntimeException
		    // There was a problem setting up the database, so let's delete the files (probably corrupt) and try again
		    Var AppSupport As FolderItem = Self.ApplicationSupport
		    Try
		      Var Bound As Integer = AppSupport.Count - 1
		      For Idx As Integer = Bound DownTo 0
		        Var Child As FolderItem = AppSupport.ChildAt(Idx)
		        If Child.Name.BeginsWith("Library.sqlite") Then
		          Child.Remove
		        End If
		      Next
		      LocalData.Start
		    Catch BiggerError As RuntimeException
		      // Something is still wrong
		      BeaconUI.ShowAlert("Beacon cannot start due to a problem with the local database.", "Beacon is unable to create or repair its local database. The original database error was: `" + Err.Message + "` and the error while attempting to repair was `" + BiggerError.Message + "`.")
		      If (AppSupport Is Nil) = False ANd AppSupport.Exists Then
		        AppSupport.Open
		      End If
		      Quit
		      Return
		    End Try
		  End Try
		  
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
		Private Sub LaunchQueue_ShowMainWindow()
		  Self.mMainWindow = New MainWindow
		  Self.mMainWindow.Show()
		  
		  While Self.mPendingURLs.Count > 0
		    Call Self.HandleURL(Self.mPendingURLs(0), False)
		    Self.mPendingURLs.RemoveAt(0)
		  Wend
		  
		  Self.NextLaunchQueueTask()
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
		  If Preferences.NewestUsedBuild < App.BuildNumber Then
		    // Show what's new window.
		    WhatsNewWindow.Present
		  End If
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Err As RuntimeException, Location As String, MoreDetail As String = "")
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
		  If Err = Nil Then
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
		  Return DefineEncoding(DecodeBase64(Chars.Middle(46, 1) + Chars.Middle(33, 1) + Chars.Middle(20, 1) + Chars.Middle(41, 1) + Chars.Middle(7, 1) + Chars.Middle(13, 1) + Chars.Middle(9, 1) + Chars.Middle(33, 1) + Chars.Middle(0, 1) + Chars.Middle(36, 1) + Chars.Middle(26, 1) + Chars.Middle(4, 1) + Chars.Middle(12, 1) + Chars.Middle(18, 1) + Chars.Middle(16, 1) + Chars.Middle(42, 1) + Chars.Middle(16, 1) + Chars.Middle(1, 1) + Chars.Middle(6, 1) + Chars.Middle(31, 1) + Chars.Middle(12, 1) + Chars.Middle(18, 1) + Chars.Middle(23, 1) + Chars.Middle(5, 1) + Chars.Middle(45, 1) + Chars.Middle(9, 1) + Chars.Middle(31, 1) + Chars.Middle(44, 1) + Chars.Middle(38, 1) + Chars.Middle(47, 1) + Chars.Middle(6, 1) + Chars.Middle(41, 1) + Chars.Middle(12, 1) + Chars.Middle(34, 1) + Chars.Middle(1, 1) + Chars.Middle(50, 1) + Chars.Middle(7, 1) + Chars.Middle(33, 1) + Chars.Middle(16, 1) + Chars.Middle(28, 1) + Chars.Middle(16, 1) + Chars.Middle(43, 1) + Chars.Middle(23, 1) + Chars.Middle(51, 1) + Chars.Middle(15, 1) + Chars.Middle(13, 1) + Chars.Middle(4, 1) + Chars.Middle(51, 1) + Chars.Middle(12, 1) + Chars.Middle(13, 1) + Chars.Middle(38, 1) + Chars.Middle(11, 1) + Chars.Middle(2, 1) + Chars.Middle(11, 1) + Chars.Middle(20, 1) + Chars.Middle(22, 1) + Chars.Middle(45, 1) + Chars.Middle(1, 1) + Chars.Middle(10, 1) + Chars.Middle(44, 1) + Chars.Middle(45, 1) + Chars.Middle(13, 1) + Chars.Middle(21, 1) + Chars.Middle(4, 1) + Chars.Middle(7, 1) + Chars.Middle(34, 1) + Chars.Middle(30, 1) + Chars.Middle(1, 1) + Chars.Middle(37, 1) + Chars.Middle(34, 1) + Chars.Middle(38, 1) + Chars.Middle(11, 1) + Chars.Middle(14, 1) + Chars.Middle(17, 1) + Chars.Middle(20, 1) + Chars.Middle(1, 1) + Chars.Middle(46, 1) + Chars.Middle(24, 1) + Chars.Middle(23, 1) + Chars.Middle(39, 1) + Chars.Middle(7, 1) + Chars.Middle(36, 1) + Chars.Middle(9, 1) + Chars.Middle(19, 1) + Chars.Middle(16, 1) + Chars.Middle(27, 1) + Chars.Middle(31, 1) + Chars.Middle(33, 1) + Chars.Middle(10, 1) + Chars.Middle(3, 1) + Chars.Middle(16, 1) + Chars.Middle(33, 1) + Chars.Middle(10, 1) + Chars.Middle(3, 1) + Chars.Middle(10, 1) + Chars.Middle(28, 1) + Chars.Middle(16, 1) + Chars.Middle(43, 1) + Chars.Middle(22, 1) + Chars.Middle(1, 1) + Chars.Middle(7, 1) + Chars.Middle(36, 1) + Chars.Middle(1, 1) + Chars.Middle(51, 1) + Chars.Middle(0, 1) + Chars.Middle(17, 1) + Chars.Middle(16, 1) + Chars.Middle(42, 1) + Chars.Middle(16, 1) + Chars.Middle(8, 1) + Chars.Middle(4, 1) + Chars.Middle(18, 1) + Chars.Middle(10, 1) + Chars.Middle(26, 1) + Chars.Middle(16, 1) + Chars.Middle(19, 1) + Chars.Middle(22, 1) + Chars.Middle(36, 1) + Chars.Middle(4, 1) + Chars.Middle(29, 1) + Chars.Middle(9, 1) + Chars.Middle(1, 1) + Chars.Middle(6, 1) + Chars.Middle(34, 1) + Chars.Middle(15, 1) + Chars.Middle(13, 1) + Chars.Middle(26, 1) + Chars.Middle(17, 1) + Chars.Middle(6, 1) + Chars.Middle(19, 1) + Chars.Middle(6, 1) + Chars.Middle(1, 1) + Chars.Middle(37, 1) + Chars.Middle(34, 1) + Chars.Middle(22, 1) + Chars.Middle(50, 1) + Chars.Middle(6, 1) + Chars.Middle(49, 1) + Chars.Middle(30, 1) + Chars.Middle(42, 1) + Chars.Middle(15, 1) + Chars.Middle(25, 1) + Chars.Middle(26, 1) + Chars.Middle(19, 1) + Chars.Middle(22, 1) + Chars.Middle(41, 1) + Chars.Middle(45, 1) + Chars.Middle(41, 1) + Chars.Middle(7, 1) + Chars.Middle(38, 1) + Chars.Middle(1, 1) + Chars.Middle(14, 1) + Chars.Middle(10, 1) + Chars.Middle(35, 1) + Chars.Middle(37, 1) + Chars.Middle(20, 1) + Chars.Middle(10, 1) + Chars.Middle(9, 1) + Chars.Middle(51, 1) + Chars.Middle(32, 1) + Chars.Middle(7, 1) + Chars.Middle(24, 1) + Chars.Middle(9, 1) + Chars.Middle(54, 1) + Chars.Middle(38, 1) + Chars.Middle(38, 1) + Chars.Middle(15, 1) + Chars.Middle(50, 1) + Chars.Middle(22, 1) + Chars.Middle(27, 1) + Chars.Middle(6, 1) + Chars.Middle(25, 1) + Chars.Middle(53, 1) + Chars.Middle(3, 1) + Chars.Middle(23, 1) + Chars.Middle(31, 1) + Chars.Middle(38, 1) + Chars.Middle(34, 1) + Chars.Middle(51, 1) + Chars.Middle(53, 1) + Chars.Middle(10, 1) + Chars.Middle(25, 1) + Chars.Middle(39, 1) + Chars.Middle(25, 1) + Chars.Middle(10, 1) + Chars.Middle(13, 1) + Chars.Middle(7, 1) + Chars.Middle(40, 1) + Chars.Middle(12, 1) + Chars.Middle(53, 1) + Chars.Middle(51, 1) + Chars.Middle(3, 1) + Chars.Middle(10, 1) + Chars.Middle(3, 1) + Chars.Middle(25, 1) + Chars.Middle(11, 1) + Chars.Middle(52, 1) + Chars.Middle(45, 1) + Chars.Middle(48, 1) + Chars.Middle(48, 1)),Encodings.UTF8)
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
		Private Sub mIdentityManager_NeedsLogin(Sender As IdentityManager)
		  #Pragma Unused Sender
		  
		  UserWelcomeWindow.Present(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_ClearMenu(Sender As MenuItem) As Boolean
		  #Pragma Unused Sender
		  
		  Var Documents() As Beacon.DocumentURL
		  Preferences.RecentDocuments = Documents
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_OpenFile(Sender As MenuItem) As Boolean
		  If (Self.mMainWindow Is Nil) = False Then
		    Var Document As Beacon.DocumentURL = Sender.Tag
		    Self.mMainWindow.Documents.OpenDocument(Document)
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
		  Case BeaconAPI.Socket.Notification_Unauthorized
		    Preferences.OnlineToken = ""
		  Case Preferences.Notification_RecentsChanged
		    Self.RebuildRecentMenu()
		  Case UserCloud.Notification_SyncStarted
		    HelpSyncCloudFiles.Text = "Syncing Cloud Files…"
		    HelpSyncCloudFiles.Enabled = False
		  Case UserCloud.Notification_SyncFinished
		    HelpSyncCloudFiles.Text = "Sync Cloud Files"
		    HelpSyncCloudFiles.Enabled = True
		  Case Preferences.Notification_OnlineStateChanged
		    UpdatesKit.IsCheckingAutomatically = Preferences.OnlineEnabled
		  Case LocalData.Notification_ImportSuccess
		    If Self.mHasTestedDatabase = False Then
		      Var Result As LocalData.PerformanceResults = LocalData.SharedInstance.TestPerformance(True)
		      Select Case Result
		      Case LocalData.PerformanceResults.CouldNotRepair
		        App.Log("Database is performing poorly and repair did not help.")
		      Case LocalData.PerformanceResults.Repaired
		        App.Log("Database was performing poorly but has been repaired.")
		      Case LocalData.PerformanceResults.RepairsNecessary
		        App.Log("Database is performing poorly and should be repaired.")
		      End Select
		      Self.mHasTestedDatabase = True
		    End If
		  End Select
		End Sub
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
		    Try
		      Var Content As String = File.Read(Encodings.UTF8)
		      LocalData.SharedInstance.Import(Content)
		    Catch Err As RuntimeException
		      
		    End Try
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionPreset) Then
		    Self.mMainWindow.BringToFront()
		    Self.mMainWindow.Presets.OpenPreset(File, Import)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionINI) Then
		    Self.mMainWindow.BringToFront()
		    Self.mMainWindow.Documents.ImportFile(File)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionProject) Then
		    Self.mMainWindow.BringToFront()
		    Self.mMainWindow.Documents.OpenDocument(File)
		    Return
		  End If
		  
		  If File.ExtensionMatches(Beacon.FileExtensionIdentity) Then
		    Call Self.ImportIdentityFile(File)
		    Return
		  End If
		  
		  BeaconUI.ShowAlert("Unable to open file", "Beacon doesn't know what to do with the file " + File.Name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentException(Err As Variant)
		  ExceptionWindow.Present(Err)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildRecentMenu()
		  While FileOpenRecent.Count > 0
		    FileOpenRecent.RemoveMenuAt(0)
		  Wend
		  
		  Var Documents() As Beacon.DocumentURL = Preferences.RecentDocuments
		  For Each Document As Beacon.DocumentURL In Documents
		    Var Item As New MenuItem(Document.Name)
		    Item.Tag = Document
		    Item.Enabled = True
		    AddHandler Item.Action, WeakAddressOf mOpenRecent_OpenFile
		    FileOpenRecent.AddMenu(Item)
		  Next
		  If Documents.LastIndex > -1 Then
		    FileOpenRecent.AddMenu(New MenuItem(MenuItem.TextSeparator))
		    
		    Var Item As New MenuItem("Clear Menu")
		    Item.Enabled = True
		    AddHandler Item.Action, WeakAddressOf mOpenRecent_ClearMenu
		    FileOpenRecent.AddMenu(Item)
		  Else
		    Var Item As New MenuItem("No Items")
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
		Sub ShowBugReporter(ExceptionHash As String = "")
		  Var Path As String = "/reportaproblem?build=" + Self.BuildNumber.ToString
		  If ExceptionHash <> "" Then
		    Path = Path + "&exception=" + ExceptionHash
		  End If
		  
		  System.GotoURL(Beacon.WebURL(Path))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowOpenDocument(Parent As Window = Nil)
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.BeaconDocument + BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.BeaconIdentity
		  
		  Var File As FolderItem
		  If Parent Is Nil Then
		    File = Dialog.ShowModal
		  Else
		    File = Dialog.ShowModalWithin(Parent.TrueWindow)
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
		    Components.Add("Platform=" + SystemInformationMBS.OSName + "/" + SystemInformationMBS.OSVersionString)
		    #if Target32Bit
		      Components.Add("Architecture=32-bit " + If(TargetARM, "ARM", "Intel"))
		    #else
		      Components.Add("Architecture=64-bit " + If(TargetARM, "ARM", "Intel"))
		    #endif
		    
		    Self.mUserAgent = "Beacon/" + Self.BuildVersion + " (" + Components.Join("; ") + ")"
		  End If
		  Return Self.mUserAgent
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		LaunchOnQuit As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAPISocket As BeaconAPI.Socket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHandoffSocket As IPCSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasTestedDatabase As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentityManager As IdentityManager
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
		Private mMutex As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingURLs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserAgent As String
	#tag EndProperty


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

	#tag Constant, Name = Notification_AppearanceChanged, Type = Text, Dynamic = False, Default = \"Appearance Changed", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
