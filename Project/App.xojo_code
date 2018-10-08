#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
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
		  #if TargetMacOS
		    Self.Log("Beacon " + Str(Self.NonReleaseVersion, "-0") + " for Mac.")
		  #elseif TargetWin32
		    Self.Log("Beacon " + Str(Self.NonReleaseVersion, "-0") + " for Windows.")
		  #endif
		  
		  Dim Lock As New Mutex("com.thezaz.beacon")
		  If Not Lock.TryEnter Then
		    #if TargetWin32
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
		    #endif
		    
		    Quit
		    Return
		  Else
		    Self.mMutex = Lock
		    #if TargetWin32
		      Self.mHandoffSocket = New IPCSocket
		      Self.mHandoffSocket.Path = Self.ApplicationSupport.Child("ipc").NativePath
		      AddHandler Self.mHandoffSocket.DataAvailable, WeakAddressOf Self.mHandoffSocket_DataAvailable
		      AddHandler Self.mHandoffSocket.Error, WeakAddressOf Self.mHandoffSocket_Error
		      Self.mHandoffSocket.Listen
		    #endif
		  End If
		  
		  #if TargetMacOS
		    UntitledSeparator6.Visible = False
		  #endif
		  Self.RebuildRecentMenu()
		  
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + BeaconFileTypes.BeaconIdentity.PrimaryExtension)
		  If IdentityFile.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(IdentityFile)
		    Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Contents.ToText)
		    Dim Identity As Beacon.Identity = Beacon.Identity.Import(Dict)
		    Self.mIdentity = Identity
		  End If
		  
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_PrivacyCheck)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_SetupDatabase)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_ShowMainWindow)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_RequestUser)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_CheckUpdates)
		  Self.mLaunchQueue.Append(AddressOf LaunchQueue_NewsletterPrompt)
		  Self.NextLaunchQueueTask()
		  
		  #if TargetWin32
		    Self.HandleCommandLineData(System.CommandLine, True)
		  #endif
		  
		  BeaconUI.RegisterSheetPositionHandler()
		  
		  Self.AutoQuit = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  If Self.mIdentity = Nil Then
		    Return
		  End If
		  
		  Dim File As Beacon.FolderItem = Item
		  
		  If Not File.Exists Then
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.JsonFile) Then
		    Try
		      Dim Content As Text = File.Read(Xojo.Core.TextEncoding.UTF8)
		      
		      If LocalData.SharedInstance.Import(Content) Then
		        Dim LastSync As Xojo.Core.Date = LocalData.SharedInstance.LastSync
		        
		        Dim Dialog As New MessageDialog
		        Dialog.Title = ""
		        Dialog.Message = "Engram database has been updated"
		        Dialog.Explanation = "Engrams, loot sources, and presets are now current as of " + LastSync.ToText(Xojo.Core.Locale.Current, Xojo.Core.Date.FormatStyles.Long, Xojo.Core.Date.FormatStyles.Short) + " UTC."
		        Call Dialog.ShowModal
		        Return
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		    
		    Dim Dialog As New MessageDialog
		    Dialog.Title = ""
		    Dialog.Message = "Unable to import engram data"
		    Dialog.Explanation = "Sorry about that. The file may not be correctly formatted."
		    Call Dialog.ShowModal
		    
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.BeaconPreset) Then
		    Self.AddToRecentDocuments(File)
		    MainWindow.Presets.OpenPreset(File)
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.IniFile) Then
		    MainWindow.Documents.ImportFile(File)
		    Return
		  End If
		  
		  If File.IsType(BeaconFileTypes.BeaconDocument) Then
		    MainWindow.Documents.OpenFile(File)
		    Return
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Unable to open file"
		  Dialog.Explanation = "Beacon doesn't know what to do with the file " + File.Name
		  Call Dialog.ShowModal
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Error)
		  Dim Stack() As Xojo.Core.StackFrame = Error.CallStack
		  Dim Location As String = "Unknown"
		  If UBound(Stack) >= 0 Then
		    Location = Stack(0).Name
		  End If
		  Dim Reason As String = Error.Reason
		  If Reason = "" Then
		    Reason = Error.Message
		  End If
		  
		  Self.Log("Unhandled " + Info.FullName + " in " + Location + ": " + Reason)
		  
		  Return False
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function FileImport() As Boolean Handles FileImport.Action
			Dim Dialog As New OpenDialog
			Dialog.Filter = BeaconFileTypes.IniFile + BeaconFileTypes.BeaconPreset + BeaconFileTypes.JsonFile
			
			Dim File As Beacon.FolderItem = Dialog.ShowModal
			If File <> Nil Then
			Self.OpenDocument(File)
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
		Function HelpMakeADonation() As Boolean Handles HelpMakeADonation.Action
			Self.ShowDonation()
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
		Sub AddToRecentDocuments(File As FolderItem)
		  Dim Hash As String = EncodeHex(Crypto.MD5(File.NativePath))
		  Dim Documents() As FolderItem = Self.RecentDocuments
		  For I As Integer = Documents.Ubound DownTo 0
		    If EncodeHex(Crypto.MD5(Documents(I).NativePath)) = Hash Then
		      Documents.Remove(I)
		    End If
		  Next
		  Documents.Insert(0, File)
		  While Documents.Ubound > 9
		    Documents.Remove(Documents.Ubound)
		  Wend
		  Self.RecentDocuments = Documents
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_CreateSession(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Message
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  If Not Success Then
		    Return
		  End If
		  
		  Try
		    Dim Dict As Xojo.Core.Dictionary = Details
		    Dim Token As Text = Dict.Value("session_id")
		    Preferences.OnlineToken = Token
		    
		    Dim Request As New BeaconAPI.Request("user.php", "GET", AddressOf APICallback_GetCurrentUser)
		    Request.Authenticate(Token)
		    BeaconAPI.Send(Request)
		  Catch Err As RuntimeException
		    
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_GetCurrentUser(Success As Boolean, Message As Text, Details As Auto, HTTPStatus As Integer, RawReply As Xojo.Core.MemoryBlock)
		  #Pragma Unused Message
		  #Pragma Unused HTTPStatus
		  #Pragma Unused RawReply
		  
		  If Success Then
		    Try
		      Dim Identity As Beacon.Identity = Self.Identity
		      If Identity.ConsumeUserDictionary(Details) Then
		        Self.Identity = Identity
		      End If
		    Catch Err As RuntimeException
		      
		    End Try
		  ElseIf HTTPStatus = 401 Then
		    // Need to get a new token
		    Dim Request As New BeaconAPI.Request("session.php", "POST", AddressOf APICallback_CreateSession)
		    Request.Sign(Self.Identity)
		    BeaconAPI.Send(Request)
		  End If
		End Sub
	#tag EndMethod

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
		  If Preferences.OnlineEnabled = False Then
		    If Not Silent Then
		      Dim WelcomeWindow As New UserWelcomeWindow
		      WelcomeWindow.Show()
		    End If
		    Return
		  End If
		  
		  If Silent Then
		    If Self.mUpdateChecker = Nil Then
		      Self.mUpdateChecker = New UpdateChecker
		      AddHandler Self.mUpdateChecker.UpdateAvailable, WeakAddressOf Self.mUpdateChecker_UpdateAvailable
		      AddHandler Self.mUpdateChecker.NoUpdate, WeakAddressOf Self.mUpdateChecker_NoUpdate
		    End If
		    
		    Self.mUpdateChecker.Check(False)
		  Else
		    UpdateWindow.Present()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleCommandLineData(Data As String, URLOnly As Boolean)
		  Dim Char, BreakChar, Arg as string
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
		        Self.OpenDocument(File)
		      End If
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HandleURL(URL As String, AlreadyConfirmed As Boolean = False) As Boolean
		  If AlreadyConfirmed = False And Beacon.IsBeaconURL(URL) = False Then
		    Return False
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
		    Else
		      Break
		    End Select
		  ElseIf URL.Left(6) = "oauth?" Then
		    // Do nothing
		    Return False
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
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Identity(Assigns Value As Beacon.Identity)
		  Dim OriginalUIColor As Color = BeaconUI.PrimaryColor()
		  Self.mIdentity = Value
		  Self.WriteIdentity()
		  Dim NewUIColor As Color = BeaconUI.PrimaryColor()
		  If OriginalUIColor <> NewUIColor Then
		    NotificationKit.Post("UI Color Changed", New BeaconUI.ColorProfile(NewUIColor))
		  End If
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub LaunchQueueTask()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_CheckUpdates()
		  Self.CheckForUpdates(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_NewsletterPrompt()
		  If Preferences.HasShownSubscribeDialog Then
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
		  If Self.mIdentity = Nil Then
		    Dim WelcomeWindow As New UserWelcomeWindow
		    WelcomeWindow.Show()
		  Else
		    Self.NextLaunchQueueTask()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchQueue_RequestUser()
		  If Preferences.OnlineEnabled And Preferences.OnlineToken <> "" Then
		    Dim Request As New BeaconAPI.Request("user.php", "GET", AddressOf APICallback_GetCurrentUser)
		    Request.Authenticate(Preferences.OnlineToken)
		    BeaconAPI.Send(Request)
		  End If
		  
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
		  
		  #if DebugBuild
		    System.DebugLog(Message)
		  #else
		    Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		    Dim LogFile As FolderItem = Self.ApplicationSupport.Child("Events.log")
		    Dim Stream As TextOutputStream = TextOutputStream.Append(LogFile)
		    Stream.WriteLine(Now.ToText + Str(Now.Nanosecond / 1000000000, ".0000000000") + " " + Now.TimeZone.Abbreviation + Chr(9) + Message)
		    Stream.Close
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
		    Xojo.Core.Timer.CallLater(100, AddressOf Sender.Listen)
		  Else
		    App.Log("IPC error " + Str(Code, "-0"))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_ClearMenu(Sender As MenuItem) As Boolean
		  #Pragma Unused Sender
		  
		  Dim Documents() As FolderItem
		  Self.RecentDocuments = Documents
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mOpenRecent_OpenFile(Sender As MenuItem) As Boolean
		  Dim File As FolderItem = Sender.Tag
		  If File <> Nil And File.Exists Then
		    Self.OpenDocument(File)
		  Else
		    BeaconUI.ShowAlert("File not found.", "Sorry, the file may have been deleted.")
		  End If
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
		Private Sub mUpdateChecker_UpdateAvailable(Sender As UpdateChecker, Version As String, Notes As String, URL As String, Signature As String)
		  #Pragma Unused Sender
		  
		  Dim Data As New Xojo.Core.Dictionary
		  Data.Value("Version") = Version.ToText
		  Data.Value("Notes") = Notes.ToText
		  Data.Value("Download") = URL.ToText
		  Data.Value("Signature") = Signature.ToText
		  
		  Dim Notification As New Beacon.UserNotification("Beacon " + Version.ToText + " is now available!")
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

	#tag Method, Flags = &h21
		Private Sub RebuildRecentMenu()
		  While FileOpenRecent.Count > 0
		    FileOpenRecent.Remove(0)
		  Wend
		  
		  Dim Documents() As FolderItem = Self.RecentDocuments()
		  For Each Document As FolderItem In Documents
		    Dim Item As New MenuItem(Document.DisplayName)
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
		Function RecentDocuments() As FolderItem()
		  Dim SaveData() As Text = Preferences.RecentDocuments
		  
		  Dim Documents() As FolderItem
		  For Each Data As Text In SaveData
		    Dim File As FolderItem = GetFolderItem(DecodeBase64(Data), FolderItem.PathTypeNative)
		    If File <> Nil Then
		      Documents.Append(File)
		    End If
		  Next
		  
		  Return Documents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RecentDocuments(Assigns Documents() As FolderItem)
		  Dim SaveData() As Text
		  For Each Document As FolderItem In Documents
		    If Document <> Nil And Document.Exists Then
		      Dim Data As String = Document.GetSaveInfo(Nil)
		      SaveData.Append(EncodeBase64(Data, 0).ToText)
		    End If
		  Next
		  Preferences.RecentDocuments = SaveData
		  Self.RebuildRecentMenu()
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
		Sub ShowBugReporter()
		  ShowURL(Beacon.WebURL("/reportaproblem.php"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowDonation()
		  ShowURL(Beacon.WebURL("/donate.php"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowReleaseNotes()
		  ShowURL(Beacon.WebURL("/history.php#build" + Self.NonReleaseVersion.ToText(Xojo.Core.Locale.Raw, "0")))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSpawnCodes()
		  ShowURL(Beacon.WebURL("/spawn/"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteIdentity()
		  Dim IdentityFile As FolderItem = Self.ApplicationSupport.Child("Default" + BeaconFileTypes.BeaconIdentity.PrimaryExtension)
		  Dim Writer As New Beacon.JSONWriter(Self.mIdentity.Export, IdentityFile)
		  Writer.Run
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
		Private mIdentity As Beacon.Identity
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


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
