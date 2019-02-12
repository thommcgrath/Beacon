#tag Class
Protected Class App
Inherits Application
Implements NotificationKit.Receiver
	#tag Event
		Sub AppearanceChanged()
		  NotificationKit.Post(Self.Notification_AppearanceChanged, Nil)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  Try
		    Self.UninstallTemporaryFont(Self.ResourcesFolder.Child("Fonts").Child("SourceCodePro").Child("SourceCodePro-Regular.otf"))
		  Catch Err As RuntimeException
		    // Whatever
		  End Try
		  
		  If Self.mMutex <> Nil Then
		    Self.mMutex.Leave
		  End If
		  
		  If Self.LaunchOnQuit <> Nil And Self.LaunchOnQuit.Exists Then
		    Self.Log("Launching " + Self.LaunchOnQuit.NativePath)
		    Self.LaunchOnQuit.Launch
		  End If
		  
		  Self.Log("Beacon finished gracefully")
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  FileNew.Enable
		  FileNewPreset.Enable
		  FileOpen.Enable
		  FileImport.Enable
		  
		  Dim Counter As Integer = 1
		  For I As Integer = 0 To WindowCount - 1
		    Dim Win As Window = Window(I)
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
		    Dim URL As String = theEvent.StringParam("----")
		    Return Self.HandleURL(URL)
		  Else
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  #If TargetMacOS
		    Self.Log("Beacon " + Str(Self.BuildNumber, "-0") + " for Mac.")
		  #ElseIf TargetWin32
		    Self.Log("Beacon " + Str(Self.BuildNumber, "-0") + " for Windows.")
		  #EndIf
		  
		  Dim Lock As New Mutex("com.thezaz.beacon")
		  If Not Lock.TryEnter Then
		    #If TargetWin32
		      Dim StartTime As Double = Microseconds
		      Dim PushSocket As New IPCSocket
		      PushSocket.Path = Self.ApplicationSupport.Child("ipc").NativePath
		      PushSocket.Connect
		      Do Until PushSocket.IsConnected Or Microseconds - StartTime > 5000000
		        PushSocket.Poll
		      Loop
		      If PushSocket.IsConnected Then
		        PushSocket.Write(System.CommandLine + Chr(0))
		        Do Until PushSocket.BytesLeftToSend = 0 Or Microseconds - StartTime > 5000000
		          PushSocket.Poll
		        Loop
		        PushSocket.Close
		      End If
		    #EndIf
		    
		    Quit
		    Return
		  Else
		    Self.mMutex = Lock
		    #If TargetWin32
		      Self.mHandoffSocket = New IPCSocket
		      Self.mHandoffSocket.Path = Self.ApplicationSupport.Child("ipc").NativePath
		      AddHandler Self.mHandoffSocket.DataAvailable, WeakAddressOf Self.mHandoffSocket_DataAvailable
		      AddHandler Self.mHandoffSocket.Error, WeakAddressOf Self.mHandoffSocket_Error
		      Self.mHandoffSocket.Listen
		    #EndIf
		  End If
		  
		  #If TargetMacOS
		    UntitledSeparator6.Visible = False
		  #EndIf
		  Self.RebuildRecentMenu
		  
		  NotificationKit.Watch(Self, BeaconAPI.Socket.Notification_Unauthorized, Preferences.Notification_RecentsChanged)
		  
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + BeaconFileTypes.BeaconIdentity.PrimaryExtension)
		  Self.mIdentityManager = New IdentityManager(IdentityFile)
		  
		  Try
		    Self.TemporarilyInstallFont(Self.ResourcesFolder.Child("Fonts").Child("SourceCodePro").Child("SourceCodePro-Regular.otf"))
		  Catch Err As RuntimeException
		    // Not critically important
		  End Try
		  
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_CheckBetaExpiration)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_PrivacyCheck)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_SetupDatabase)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_ShowMainWindow)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_RequestUser)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_CheckUpdates)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_NewsletterPrompt)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_GettingStarted)
		  Self.NextLaunchQueueTask
		  
		  #If TargetWin32
		    Self.HandleCommandLineData(System.CommandLine, True)
		  #EndIf
		  
		  BeaconUI.RegisterSheetPositionHandler
		  
		  Self.AutoQuit = True
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
		Function FileImport() As Boolean Handles FileImport.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.JsonFile + BeaconFileTypes.BeaconIdentity
			
			Dim File As Beacon.FolderItem = Dialog.ShowModal
			If File <> Nil Then
			Self.OpenFile(File, True)
			End If
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
			MainWindow.Documents.NewDocument
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNewPreset() As Boolean Handles FileNewPreset.Action
			MainWindow.Presets.NewPreset
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			MainWindow.Documents.ShowOpenDocument()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAboutBeacon() As Boolean Handles HelpAboutBeacon.Action
			MainWindow.ShowView(Nil)
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
		Function HelpCheckforUpdates() As Boolean Handles HelpCheckforUpdates.Action
			Self.CheckForUpdates(False)
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpCreateOfflineAuthorizationRequest() As Boolean Handles HelpCreateOfflineAuthorizationRequest.Action
			Dim Dialog As New SaveAsDialog
			Dialog.SuggestedFileName = "Authorization Request" + BeaconFileTypes.BeaconAuth.PrimaryExtension
			
			Dim File As FolderItem = Dialog.ShowModal()
			If File = Nil Then
			Return True
			End If
			
			Dim HardwareID As Text = Beacon.HardwareID
			Dim SigningData As Xojo.Core.MemoryBlock = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(HardwareID)
			Dim Signed As Xojo.Core.MemoryBlock = Identity.Sign(SigningData)
			
			Dim Identity As Beacon.Identity = Self.Identity
			Dim Dict As New Xojo.Core.Dictionary
			Dict.Value("UserID") = Identity.Identifier
			Dict.Value("Signed") = Beacon.EncodeHex(Signed)
			Dict.Value("Device") = HardwareID
			
			Dim JSON As Text = Xojo.Data.GenerateJSON(Dict)
			Dim Stream As TextOutputStream = TextOutputStream.Create(File)
			Stream.Write(JSON)
			Stream.Close
			
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpMakeADonation() As Boolean Handles HelpMakeADonation.Action
			Self.ShowDonation()
			Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpOpenDataFolder() As Boolean Handles HelpOpenDataFolder.Action
			Self.ShowFile(Self.ApplicationSupport)
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


	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  Dim AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Dim CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Self.CheckFolder(CompanyFolder)
		  Dim AppFolder As FolderItem = CompanyFolder.Child(if(DebugBuild, "Beacon Debug", "Beacon"))
		  Self.CheckFolder(AppFolder)
		  Return AppFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AutosaveFolder(Create As Boolean = False) As FolderItem
		  Dim Folder As FolderItem = Self.ApplicationSupport.Child("Autosave")
		  If Folder = Nil Then
		    Return Nil
		  End If
		  If Not Folder.Exists Then
		    If Create Then
		      Folder.CreateAsFolder
		    Else
		      Return Nil
		    End If
		  End If
		  Return Folder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildNumber() As Integer
		  Return (Self.MajorVersion * 10000000) + (Self.MinorVersion * 100000) + (Self.BugVersion * 1000) + (Self.StageCode * 100) + Self.NonReleaseVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BuildVersion() As String
		  Dim VersionString As String = Str(Self.MajorVersion, "0") + "." + Str(Self.MinorVersion, "0") + "." + Str(Self.BugVersion, "0")
		  Select Case Self.StageCode
		  Case 0
		    Return VersionString + "pa" + Str(Self.NonReleaseVersion, "0")
		  Case 1
		    Return VersionString + "a" + Str(Self.NonReleaseVersion, "0")
		  Case 2
		    Return VersionString + "b" + Str(Self.NonReleaseVersion, "0")
		  Else
		    Return VersionString
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As FolderItem)
		  If Folder.Exists Then
		    If Not Folder.Directory Then
		      Folder.Delete
		      Folder.CreateAsFolder
		    End If
		  Else
		    Folder.CreateAsFolder
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckForUpdates(Silent As Boolean)
		  If Silent Then
		    If Not Preferences.OnlineEnabled Then
		      Return
		    End If
		    
		    If Self.mUpdateChecker = Nil Then
		      Self.mUpdateChecker = New UpdateChecker
		      AddHandler Self.mUpdateChecker.UpdateAvailable, WeakAddressOf Self.mUpdateChecker_UpdateAvailable
		      AddHandler Self.mUpdateChecker.NoUpdate, WeakAddressOf Self.mUpdateChecker_NoUpdate
		    End If
		    
		    Self.mUpdateChecker.Check(False)
		  Else
		    If Self.GetOnlinePermission() Then
		      UpdateWindow.Present()
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetOnlinePermission() As Boolean
		  If Self.mIdentityManager.CurrentIdentity <> Nil And Preferences.OnlineEnabled Then
		    Return True
		  End If
		  
		  Dim WelcomeWindow As New UserWelcomeWindow
		  WelcomeWindow.ShowModal()
		  
		  Return Preferences.OnlineEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleCommandLineData(Data As String, URLOnly As Boolean)
		  Dim Char, BreakChar, Arg As String
		  Dim Args() As String
		  
		  BreakChar = " "
		  For I As Integer = 1 To Data.Len
		    Char = Data.Mid(I, 1)
		    If Char = """" Then
		      If BreakChar = " " Then
		        BreakChar = """"
		      Else
		        BreakChar = " "
		      End If
		      Continue
		    End If
		    
		    If Char = BreakChar Then
		      Args.Append(Arg)
		      Arg = ""
		    Else
		      Arg = Arg + Char
		    End If
		  Next
		  
		  If Arg <> "" Then
		    Args.Append(Arg)
		  End If
		  
		  If Args.Ubound > 0 Then
		    Dim Path As String = DefineEncoding(Args(1), Encodings.UTF8)
		    If Beacon.IsBeaconURL(Path) Then
		      // Given a url
		      Call Self.HandleURL(Path, True)
		    ElseIf URLOnly = False Then
		      // Given a file
		      Dim File As FolderItem = GetFolderItem(Path, FolderItem.PathTypeNative)
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
		  
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Error)
		  Dim Stack() As Xojo.Core.StackFrame = Error.CallStack
		  While Stack.Ubound >= 0 And (Stack(0).Name = "RuntimeRaiseException" Or (Stack(0).Name.BeginsWith("Raise") And Stack(0).Name.EndsWith("Exception")))
		    Stack.Remove(0)
		  Wend
		  
		  Dim Location As String = "Unknown"
		  If Stack.Ubound >= 0 Then
		    Location = Stack(0).Name
		  End If
		  Dim Reason As String = Error.Reason
		  If Reason = "" Then
		    Reason = Error.Message
		  End If
		  
		  Self.Log("Unhandled " + Info.FullName + " in " + Location + ": " + Reason)
		  
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Object") = Error
		  Dict.Value("Reason") = Error.Explanation
		  Dict.Value("Location") = Location.ToText
		  Dict.Value("Type") = Info.FullName
		  Dict.Value("Trace") = Stack
		  
		  If Self.CurrentThread = Nil Then
		    Self.PresentException(Dict)
		  Else
		    Call CallLater.Schedule(0, AddressOf PresentException, Dict)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleURL(URL As String, AlreadyConfirmed As Boolean = False) As Boolean
		  If AlreadyConfirmed = False And Beacon.IsBeaconURL(URL) = False Then
		    Return False
		  End If
		  
		  If Beacon.OAuth2Client.HandleURL(URL.ToText) Then
		    Return True
		  End If
		  
		  If URL.Left(7) = "action/" Then
		    Dim Instructions As String = Mid(URL, 8)
		    Dim ParamsPos As Integer = InStr(Instructions, "?") - 1
		    Dim Params As String
		    If ParamsPos > -1 Then
		      Params = Mid(Instructions, ParamsPos + 1)
		      Instructions = Left(Instructions, ParamsPos)
		    End If
		    
		    Select Case Instructions
		    Case "showdocuments"
		      NotificationKit.Post(LibraryPane.Notification_ShowPane, LibraryPane.PaneDocuments)
		    Case "showpresets"
		      NotificationKit.Post(LibraryPane.Notification_ShowPane, LibraryPane.PanePresets)
		    Case "showengrams"
		      NotificationKit.Post(LibraryPane.Notification_ShowPane, LibraryPane.PaneEngrams)
		    Case "showmods"
		      MainWindow.Tools.ShowMods()
		    Case "showidentity"
		      MainWindow.Tools.ShowIdentity()
		    Case "showguide"
		      MainWindow.Tools.ShowAPIGuide()
		    Case "showapibuilder"
		      MainWindow.Tools.ShowAPIBuilder()
		    Case "shownewsletterprompt"
		      SubscribeDialog.Present()
		    Case "checkforupdate"
		      Self.CheckForUpdates(False)
		    Case "checkforengrams"
		      If Self.GetOnlinePermission() Then
		        EngramsUpdateWindow.ShowIfNecessary()
		        LocalData.SharedInstance.CheckForEngramUpdates
		      End If
		    Case "refreshuser"
		      Self.IdentityManager.RefreshUserDetails()
		      MainWindow.ShowLibraryPane(LibraryPane.PaneMenu)
		    Else
		      Break
		    End Select
		  Else
		    Dim LegacyURL As Text = "thezaz.com/beacon/documents.php/"
		    Dim TextURL As Text = URL.ToText
		    Dim Idx As Integer = TextURL.IndexOf(LegacyURL)
		    If Idx > -1 Then
		      Dim DocID As Text = TextURL.Mid(Idx + LegacyURL.Length)
		      URL = BeaconAPI.URL("/document.php/" + DocID)
		    End If
		    
		    Dim FileURL As String = "https://" + URL
		    MainWindow.Documents.OpenURL(FileURL.ToText)
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HelpFile(Topic As String) As FolderItem
		  Dim HelpFolder As FolderItem = Self.ApplicationSupport.Child("Help")
		  Dim HelpFile As FolderItem = HelpFolder.Child(Topic)
		  
		  If HelpFile = Nil Or HelpFile.Exists = False Then
		    Dim SourceFile As Folderitem = Self.ResourcesFolder.Child("Help").Child(Topic)
		    If SourceFile = Nil Or SourceFile.Exists = False Then
		      Return Nil
		    End If
		    
		    If Not HelpFolder.Exists Then
		      HelpFolder.CreateAsFolder()
		      HelpFile = HelpFolder.Child(Topic)
		    End If
		    
		    SourceFile.CopyFileTo(HelpFile)
		  End If
		  
		  Return HelpFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "App.IdentityManager.CurrentIdentity" )  Function Identity() As Beacon.Identity
		  Return Self.mIdentityManager.CurrentIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "App.IdentityManager.CurrentIdentity" )  Sub Identity(Assigns Value As Beacon.Identity)
		  Self.mIdentityManager.CurrentIdentity = Value
		End Sub
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
		  
		  Dim Stream As TextInputStream = TextInputStream.Open(File)
		  Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Dim Dict As Xojo.Core.Dictionary
		  Try
		    Dict = Xojo.Data.ParseJSON(Contents.ToText)
		  Catch Err As RuntimeException
		    ParentWindow.ShowAlert("Cannot import identity", "File is not an identity file.")
		    Return
		  End Try
		  
		  Dim Identity As Beacon.Identity
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
		  
		  Self.Identity = Identity
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
		  
		  Dim Limit As New Date(Self.BuildDate)
		  Limit.Day = Limit.Day + 30
		  Dim Now As New Date
		  If Now > Limit Then
		    BeaconUI.ShowAlert("This beta has expired.", "Please download a new version from " + Beacon.WebURL("/download/"))
		    Quit
		    Return
		  End If
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_CheckUpdates()
		  If Preferences.OnlineEnabled Then
		    Self.CheckForUpdates(True)
		  Else
		    Self.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_GettingStarted()
		  Dim Notification As New Beacon.UserNotification("How about a nice tutorial video?")
		  Notification.SecondaryMessage = "Click here to watch a video for first-time users of Beacon, or just to get a better understanding of how loot works."
		  Notification.ActionURL = Beacon.WebURL("/help/gettingstarted.php")
		  Notification.DoNotResurrect = True
		  
		  LocalData.SharedInstance.SaveNotification(Notification)
		  
		  Self.NextLaunchQueueTask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_NewsletterPrompt()
		  If Preferences.HasShownSubscribeDialog Then
		    Self.NextLaunchQueueTask
		    Return
		  End If
		  
		  Dim Notification As New Beacon.UserNotification("Welcome to Beacon!")
		  Notification.SecondaryMessage = "Beacon has an announcement list used to inform users of important updates and changes. Click here to sign up."
		  Notification.ActionURL = "beacon://action/shownewsletterprompt"
		  Notification.DoNotResurrect = True
		  
		  LocalData.SharedInstance.SaveNotification(Notification)
		  Preferences.HasShownSubscribeDialog = True
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_PrivacyCheck()
		  If Self.mIdentityManager.CurrentIdentity = Nil Then
		    Dim WelcomeWindow As New UserWelcomeWindow
		    WelcomeWindow.ShowModal()
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
		  LocalData.Start
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_ShowMainWindow()
		  MainWindow.Show()
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String)
		  If Self.mLogLock = Nil Then
		    Self.mLogLock = New CriticalSection
		  End If
		  
		  Self.mLogLock.Enter
		  
		  Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		  Dim DetailedMessage As String = Now.ToText + Str(Now.Nanosecond / 1000000000, ".0000000000") + " " + Now.TimeZone.Abbreviation + Chr(9) + Message
		  
		  #if DebugBuild
		    System.DebugLog(DetailedMessage)
		  #else
		    Try
		      Self.mQueuedLogMessages.Append(DetailedMessage)
		      
		      Dim LogFile As FolderItem = Self.ApplicationSupport.Child("Events.log")
		      Dim Stream As TextOutputStream = TextOutputStream.Append(LogFile)
		      While Self.mQueuedLogMessages.Ubound > -1
		        Stream.WriteLine(Self.mQueuedLogMessages(0))
		        Self.mQueuedLogMessages.Remove(0)
		      Wend
		      Stream.Close
		    Catch Err As IOException
		    End Try
		  #endif
		  
		  Self.mLogLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHandoffSocket_DataAvailable(Sender As IPCSocket)
		  Do
		    Dim Buffer As String = DefineEncoding(Sender.Lookahead, Encodings.UTF8)
		    Dim Pos As Integer = Buffer.InStr(Chr(0))
		    If Pos = 0 Then
		      Exit
		    End If
		    
		    Dim Command As String = DefineEncoding(Sender.Read(Pos), Encodings.UTF8)
		    Command = Command.Left(Command.Len - 1) // Drop the null byte
		    Self.Log("Received command line data: " + Command)
		    Self.HandleCommandLineData(Command, False)
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mHandoffSocket_Error(Sender As IPCSocket)
		  Dim Code As Integer = Sender.LastErrorCode
		  If Code = 102 Then
		    Call CallLater.Schedule(100, AddressOf Sender.Listen)
		  Else
		    App.Log("IPC error " + Str(Code, "-0"))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_ClearMenu(Sender As MenuItem) As Boolean
		  #Pragma Unused Sender
		  
		  Dim Documents() As Beacon.DocumentURL
		  Preferences.RecentDocuments = Documents
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_OpenFile(Sender As MenuItem) As Boolean
		  Dim Document As Beacon.DocumentURL = Sender.Tag
		  MainWindow.Documents.OpenURL(Document)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateChecker_NoUpdate(Sender As UpdateChecker)
		  #Pragma Unused Sender
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateChecker_UpdateAvailable(Sender As UpdateChecker, Version As String, PreviewText As String, Notes As String, URL As String, Signature As String)
		  #Pragma Unused Sender
		  
		  Dim Data As New Xojo.Core.Dictionary
		  Data.Value("Version") = Version.ToText
		  Data.Value("Notes") = Notes.ToText
		  Data.Value("Download") = URL.ToText
		  Data.Value("Signature") = Signature.ToText
		  
		  Dim Notification As New Beacon.UserNotification("Beacon " + Version.ToText + " is now available!")
		  Notification.SecondaryMessage = PreviewText.ToText
		  Notification.ActionURL = "beacon://action/checkforupdate"
		  Notification.UserData = Data
		  Notification.DoNotResurrect = True
		  
		  Beacon.Data.SaveNotification(Notification)
		  
		  Self.NextLaunchQueueTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NextLaunchQueueTask()
		  If Self.mLaunchQueue.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim Task As LaunchQueueTask = Self.mLaunchQueue(0)
		  Self.mLaunchQueue.Remove(0)
		  
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
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenFile(File As Beacon.FolderItem, Import As Boolean)
		  If Self.mIdentityManager = Nil Or Self.mIdentityManager.CurrentIdentity = Nil Then
		    Return
		  End If
		  
		  If Not File.Exists Then
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.JsonFile) Then
		    Try
		      Dim Content As Text = File.Read(Xojo.Core.TextEncoding.UTF8)
		      LocalData.SharedInstance.Import(Content)
		    Catch Err As RuntimeException
		      
		    End Try
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.BeaconPreset) Then
		    MainWindow.BringToFront()
		    MainWindow.Presets.OpenPreset(File, Import)
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.IniFile) Then
		    MainWindow.BringToFront()
		    MainWindow.Documents.ImportFile(File)
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.BeaconDocument) Then
		    MainWindow.BringToFront()
		    MainWindow.Documents.OpenFile(File)
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.BeaconIdentity) Then
		    Call Self.ImportIdentityFile(File)
		    Return
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to open file"
		  Dialog.Explanation = "Beacon doesn't know what to do with the file " + File.Name
		  Call Dialog.ShowModal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PresentException(Details As Auto)
		  ExceptionWindow.Present(Details)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RebuildRecentMenu()
		  While FileOpenRecent.Count > 0
		    FileOpenRecent.Remove(0)
		  Wend
		  
		  Dim Documents() As Beacon.DocumentURL = Preferences.RecentDocuments
		  For Each Document As Beacon.DocumentURL In Documents
		    Dim Item As New MenuItem(Document.Name)
		    Item.Tag = Document
		    Item.Enable
		    AddHandler Item.Action, WeakAddressOf mOpenRecent_OpenFile
		    FileOpenRecent.Append(Item)
		  Next
		  If Documents.Ubound > -1 Then
		    FileOpenRecent.Append(New MenuItem(MenuItem.TextSeparator))
		    
		    Dim Item As New MenuItem("Clear Menu")
		    Item.Enable
		    AddHandler Item.Action, WeakAddressOf mOpenRecent_ClearMenu
		    FileOpenRecent.Append(Item)
		  Else
		    Dim Item As New MenuItem("No Items")
		    Item.Enabled = False
		    FileOpenRecent.Append(Item)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResourcesFolder() As FolderItem
		  #if TargetMacOS
		    Return Self.ExecutableFile.Parent.Parent.Child("Resources")
		  #else
		    Dim Parent As FolderItem = Self.ExecutableFile.Parent
		    If Parent.Child("Resources").Exists Then
		      Return Parent.Child("Resources")
		    Else
		      Dim Name As String = Left(Self.ExecutableFile.Name, Len(Self.ExecutableFile.Name) - 4)
		      Return Parent.Child(Name + " Resources")
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowBugReporter(ExceptionHash As Text = "")
		  Dim Path As Text = "/reportaproblem.php?build=" + Self.BuildNumber.ToText
		  If ExceptionHash <> "" Then
		    Path = Path + "&exception=" + ExceptionHash
		  End If
		  
		  ShowURL(Beacon.WebURL(Path))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowDonation()
		  ShowURL(Beacon.WebURL("/donate.php"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowFile(File As FolderItem)
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (ClassName As CString) As Ptr
		    Declare Function GetSharedWorkspace Lib "Cocoa" Selector "sharedWorkspace" (Target As Ptr) As Ptr
		    Declare Sub SelectFile Lib "Cocoa" Selector "selectFile:inFileViewerRootedAtPath:" (Target As Ptr, Path As CFStringRef, RootPath As CFStringRef)
		    
		    Dim Workspace As Ptr = GetSharedWorkspace(objc_getClass("NSWorkspace"))
		    If Workspace <> Nil Then
		      SelectFile(Workspace, File.NativePath, "")
		    End If
		  #else
		    File.Launch
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowReleaseNotes()
		  ShowURL(Beacon.WebURL("/history.php?stage=" + Self.StageCode.ToText(Xojo.Core.Locale.Raw, "0") + "#build" + Self.BuildNumber.ToText(Xojo.Core.Locale.Raw, "0")))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSpawnCodes()
		  ShowURL(Beacon.WebURL("/spawn/"))
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
		Private mIdentityManager As IdentityManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLaunchQueue() As LaunchQueueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMutex As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueuedLogMessages() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateChecker As UpdateChecker
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant

	#tag Constant, Name = Notification_AppearanceChanged, Type = Text, Dynamic = False, Default = \"Appearance Changed", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
