#tag Module
Protected Module UpdatesKit
	#tag Method, Flags = &h1
		Protected Function AvailableDisplayVersion() As String
		  Return mAvailableDisplayVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableDownloadURL() As String
		  Return mAvailableDownloadURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableNotes() As String
		  Return mAvailableNotes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableNotesURL() As String
		  Return mAvailableNotesURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailablePreview() As String
		  Return mAvailablePreview
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableSignature() As String
		  Return mAvailableSignature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableUpdateFile() As FolderItem
		  Return mUpdateFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AvailableUpdateFile(Assigns File As FolderItem)
		  mUpdateFile = File
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AvailableUpdateRequired() As Boolean
		  Return mAvailableUpdateRequired
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Cancel()
		  #if Not UseSparkle
		    If (mSocket Is Nil) = False Then
		      mSocket.Disconnect
		      mSocket = Nil
		    End If
		    If (mDownloader Is Nil) = False Then
		      mDownloader.Disconnect
		      mDownloader = Nil
		    End If
		    
		    mChecking = False
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Check()
		  #if UseSparkle
		    #if TargetMacOS
		      If mMacSparkle Is Nil Then
		        Return
		      End If
		      
		      mMacSparkle.CheckForUpdates
		    #elseif TargetWindows
		      If mWinSparkle Is Nil Then
		        Return
		      End If
		      
		      mWinSparkle.CheckUpdateWithUI
		    #endif
		  #else
		    If mChecking Or ((mLastCheckTime Is Nil) = False And mLastCheckTime.SecondsFrom1970 > DateTime.Now.SecondsFrom1970 - 30) Then
		      Return
		    End If
		    
		    mChecking = True
		    mLastCheckTime = DateTime.Now
		    
		    mSocket = New URLConnection
		    mSocket.AllowCertificateValidation = True
		    AddHandler mSocket.Error, AddressOf mSocket_Error
		    AddHandler mSocket.HeadersReceived, AddressOf mSocket_HeadersReceived
		    AddHandler mSocket.ContentReceived, AddressOf mSocket_ContentReceived
		    mSocket.RequestHeader("Cache-Control") = "no-cache"
		    mSocket.RequestHeader("User-Agent") = App.UserAgent
		    
		    Var URL As String = CheckURL()
		    App.Log("Checking for updates from " + URL)
		    mSocket.Send("GET", URL)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckURL() As String
		  Var Params As Dictionary = UpdateCheckParams()
		  #if UseSparkle
		    Return BeaconAPI.URL("/sparkle.php?" + SimpleHTTP.BuildFormData(Params), False)
		  #else
		    Return Beacon.WebURL("/updates?" + SimpleHTTP.BuildFormData(Params))
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Cleanup()
		  #if UseSparkle And TargetWindows
		    If (mWinSparkle Is Nil) = False Then
		      mWinSparkle.Cleanup
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DownloadedBytes() As Int64
		  Return mDownloadedBytes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DownloadRate() As Double
		  Return mDownloadRate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DownloadSecondsRemaining() As Double
		  Return mDownloadSecondsRemaining
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DownloadUpdate()
		  If mUpdateFile Is Nil Then
		    Var PathComponents() As String = FrameworkExtensions.FieldAtPosition(mAvailableDownloadURL, "?", 1).Split("/")
		    Var Filename As String = FrameworkExtensions.FieldAtPosition(PathComponents(PathComponents.LastIndex), "#", 1)
		    Var FilenameParts() As String = Filename.Split(".")
		    Var Extension As String = FilenameParts(FilenameParts.LastIndex)
		    Filename = "Beacon " + mAvailableDisplayVersion + "." + Extension
		    
		    Var Folder As FolderItem = App.ApplicationSupport.Child("Updates")
		    If Not Folder.Exists Then
		      Folder.CreateFolder
		    End If
		    mUpdateFile = Folder.Child(Filename)
		  End If
		  
		  If VerifyFile(mUpdateFile, mAvailableSignature) Then
		    // Start or present the install
		    InstallUpdate()
		    Return
		  ElseIf mUpdateFile.Exists Then
		    mUpdateFile.Remove
		  End If
		  
		  mIsDownloading = True
		  mDownloadStart = System.Microseconds
		  mDownloader = New URLConnection
		  AddHandler mDownloader.ReceivingProgressed, AddressOf mDownloader_ReceivingProgressed
		  AddHandler mDownloader.FileReceived, AddressOf mDownloader_FileReceived
		  AddHandler mDownloader.Error, AddressOf mDownloader_Error
		  mDownloader.Send("GET", mAvailableDownloadURL, mUpdateFile)
		  NotificationKit.Post(Notification_DownloadStarted, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  #if UseSparkle
		    Var CheckInterval As Integer
		    #if DebugBuild
		      CheckInterval = 3600
		    #else
		      CheckInterval = 14400
		    #endif
		    
		    Var URL As String = CheckURL()
		    App.Log("Update check URI is " + URL)
		    
		    #if TargetMacOS
		      If SUUpdaterMBS.IsFrameworkLoaded = False Then
		        Var SparkleFramework As FolderItem = App.FrameworksFolder.Child("Sparkle.framework")
		        If Not SUUpdaterMBS.LoadFramework(SparkleFramework) Then
		          App.Log("Unable to load Sparkle framework")
		          Return
		        End If
		      End If
		      
		      If (mMacSparkle Is Nil) = False Then
		        Return
		      End If
		      
		      Var Updater As New SUUpdaterMBS
		      Updater.FeedURL = URL
		      Updater.AutomaticallyChecksForUpdates = Preferences.OnlineEnabled
		      Updater.AutomaticallyDownloadsUpdates = Preferences.OnlineEnabled And Preferences.AutomaticallyDownloadsUpdates
		      Updater.UpdateCheckInterval = CheckInterval
		      Updater.SendsSystemProfile = False
		      Updater.UserAgentString = App.UserAgent
		      If Updater.AutomaticallyChecksForUpdates And (Updater.LastUpdateCheckDateTime Is Nil Or DateTime.Now.SecondsFrom1970 - Updater.LastUpdateCheckDateTime.SecondsFrom1970 >= Updater.UpdateCheckInterval) Then 
		        Updater.CheckForUpdatesInBackground
		      End If
		      mMacSparkle = Updater
		    #elseif TargetWindows
		      Var SparkleDLL As FolderItem = App.FrameworksFolder.Child("WinSparkle.dll")
		      If WinSparkleMBS.LoadLibrary(SparkleDLL) = False Then
		        App.Log("Could not load Sparkle framework from " + SparkleDLL.NativePath)
		        Return
		      End If
		      
		      Var Updater As New WinSparkleMBS
		      AddHandler Updater.ShutdownRequest, AddressOf mWinSparkle_ShutdownRequest
		      Updater.AppCastURL = CheckURL()
		      Updater.AppName = "Beacon"
		      Updater.AppVersion = App.Version
		      Updater.AutomaticCheckForUpdates = Preferences.OnlineEnabled
		      Updater.BuildVersion = App.MajorVersion.ToString(Locale.Raw, "0") + "." + App.MinorVersion.ToString(Locale.Raw, "0") + "." + App.BugVersion.ToString(Locale.Raw, "0") + "." + App.StageCode.ToString(Locale.Raw, "0") + "." + App.NonReleaseVersion.ToString(Locale.Raw, "0")
		      Updater.CanShutdown = True
		      Updater.CompanyName = "The ZAZ Studios"
		      Updater.DSAPubPEM = WinSparklePublicKey
		      Updater.UpdateCheckInterval = CheckInterval
		      Updater.Initialize
		      mWinSparkle = Updater
		    #endif
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InstallUpdate()
		  If Preferences.AutomaticallyDownloadsUpdates Then
		    App.LaunchUpdate(mUpdateFile, False)
		  End If
		  
		  NotificationKit.Post(Notification_UpdateDownloaded, mUpdateFile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Is64Bit() As Boolean
		  #if Target64Bit
		    // If we're already executing 64-bit code, then we know it's a 64-bit system
		    Return True
		  #endif
		  
		  #if TargetWin32 Then
		    Soft Declare Function GetCurrentProcess Lib "kernel32"  As Integer
		    Var ProcessID As Integer = GetCurrentProcess
		    
		    If System.IsFunctionAvailable("IsWow64Process2", "kernel32") Then
		      Soft Declare Function IsWow64Process2 Lib "kernel32" (Handle As Integer, ByRef ProcessMachine As UInt16, ByRef NativeMachine As UInt16) As Boolean
		      
		      Var ProcessMachine, NativeMachine As UInt16
		      If Not IsWow64Process2(ProcessID, ProcessMachine, NativeMachine) Then
		        Return False
		      End If
		      
		      Return NativeMachine = &h200 Or NativeMachine = &h8664 Or NativeMachine = &hAA64 Or NativeMachine = &h284
		    ElseIf System.IsFunctionAvailable("IsWow64Process", "kernel32") Then
		      Soft Declare Function IsWow64Process Lib "kernel32" (Handle As Integer, ByRef Wow64Process As Boolean) As Boolean
		      
		      Var Wow64Process As Boolean
		      If Not IsWow64Process(ProcessID, Wow64Process) Then
		        Return False
		      End If
		      
		      Return Wow64Process
		    End If
		  #elseif TargetLinux
		    Var ID As New CPUIDMBS
		    Return ID.Flags(CPUIDMBS.kFeatureLM)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsARM() As Boolean
		  #if TargetARM
		    // Since the code is already compiled ARM, we know this to be true
		    Return True
		  #endif
		  
		  Return SystemInformationMBS.IsARM Or SystemInformationMBS.IsTranslated = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsBusy() As Boolean
		  Return mChecking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsCheckingAutomatically() As Boolean
		  #if UseSparkle
		    #if TargetMacOS
		      If (mMacSparkle Is Nil) = False Then
		        Return mMacSparkle.AutomaticallyChecksForUpdates
		      End If
		    #elseif TargetWindows
		      If (mWinSparkle Is Nil) = False Then
		        Return mWinSparkle.AutomaticCheckForUpdates
		      End If
		    #endif
		  #else
		    Return (mAutoCheckTimer Is Nil) = False And mAutoCheckTimer.RunMode = Timer.RunModes.Multiple
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub IsCheckingAutomatically(Assigns Value As Boolean)
		  #if UseSparkle
		    #if TargetMacOS
		      If (mMacSparkle Is Nil) = False Then
		        mMacSparkle.AutomaticallyChecksForUpdates = Value
		      End If
		    #elseif TargetWindows
		      If (mWinSparkle Is Nil) = False Then
		        mWinSparkle.AutomaticCheckForUpdates = Value
		      End If
		    #endif
		  #else
		    If IsCheckingAutomatically = Value Then
		      // No changes necessary
		      Return
		    End If
		    
		    If mAutoCheckTimer Is Nil Then
		      If Value = False Then
		        Return
		      End If
		      
		      mAutoCheckTimer = New Timer
		      mAutoCheckTimer.Period = 60000 // Does not actually check every minute, that is throttled by the event
		      AddHandler mAutoCheckTimer.Action, AddressOf mAutoCheckTimer_Action
		    End If
		    
		    If Value And mAutoCheckTimer.RunMode <> Timer.RunModes.Multiple Then
		      App.Log("Automatic update checking is enabled.")
		      mAutoCheckTimer_Action(mAutoCheckTimer) // Force fire it now to catch up
		      mAutoCheckTimer.RunMode = Timer.RunModes.Multiple
		    ElseIf Value = False And mAutoCheckTimer.RunMode <> Timer.RunModes.Off Then
		      App.Log("Automatic update checking has been stopped.")
		      mAutoCheckTimer.RunMode = Timer.RunModes.Off
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsDownloading() As Boolean
		  Return mIsDownloading
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsUpdateAvailable() As Boolean
		  #if Not UseSparkle
		    Return mAvailableDisplayVersion.IsEmpty = False
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAutoCheckTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  // Check every 4 hours
		  If (mLastCheckTime Is Nil) Or DateTime.Now.SecondsFrom1970 - mLastCheckTime.SecondsFrom1970 >= 14400 Then
		    Check()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDownloader_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  mIsDownloading = False
		  NotificationKit.Post(Notification_DownloadError, Err.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDownloader_FileReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, File As FolderItem)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  #Pragma Unused File
		  
		  mIsDownloading = False
		  
		  If HTTPStatus <> 200 Then
		    Var Message As String
		    If HTTPStatus = 404 Then
		      Message = "The update file could not be found."
		    Else
		      Message = "The update file could not be downloaded due to an HTTP " + HTTPStatus.ToString(Locale.Raw, "0") + " error."
		    End If
		    NotificationKit.Post(Notification_DownloadError, Message)
		    Return
		  End If
		  
		  If VerifyFile(mUpdateFile, mAvailableSignature) = False Then
		    NotificationKit.Post(Notification_DownloadError, "The file was downloaded, but the integrity check did not match. Please report this problem.")
		    Return
		  End If
		  
		  InstallUpdate()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDownloader_ReceivingProgressed(Sender As URLConnection, BytesReceived As Int64, BytesTotal As Int64, NewData As String)
		  #Pragma Unused Sender
		  #Pragma Unused NewData
		  
		  mTotalBytesToDownload = BytesTotal
		  mDownloadedBytes = BytesReceived + NewData.Bytes
		  Var Elapsed As Double = System.Microseconds - mDownloadStart
		  mDownloadRate = mDownloadedBytes / (Elapsed / 1000000)
		  Var RemainingBytes As Int64 = BytesTotal - mDownloadedBytes
		  mDownloadSecondsRemaining = RemainingBytes / mDownloadRate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  #Pragma Unused HTTPStatus
		  
		  If Sender = mSocket Then
		    mChecking = False
		    mSocket = Nil
		  End If
		  
		  Var Dict As Dictionary
		  Try
		    Dict = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    NotificationKit.Post(Notification_Error, "Invalid definition file.")
		    App.Log(Err, CurrentMethodName, "Invalid definition file.")
		    Return
		  End Try
		  
		  If Dict.HasKey("notices") Then
		    // Not needed anymore
		    Dict.Remove("notices")
		  End If
		  
		  If Dict.KeyCount = 0 Then
		    // No update
		    NotificationKit.Post(Notification_NoUpdates, Nil)
		    Return
		  End If
		  
		  Try
		    Var LatestBuild As Integer = Dict.Value("build")
		    If LatestBuild <= App.BuildNumber Then
		      NotificationKit.Post(Notification_NoUpdates, Nil)
		      Return
		    End If
		    
		    mAvailableDisplayVersion = Dict.Value("version")
		    mAvailableNotes = Dict.Value("notes")
		    mAvailableNotesURL = Dict.Lookup("notes_url", "")
		    mAvailablePreview = Dict.Lookup("preview", "")
		    mAvailableUpdateRequired = Dict.Lookup("required", False)
		    Var Location As Dictionary
		    #if TargetMacOS
		      Location = Dict.Value("mac")
		    #elseif TargetWin32
		      Location = Dict.Value("win")
		    #elseif TargetLinux
		      If Dict.HasKey("lin") Then
		        Location = Dict.Value("lin")
		      Else
		        NotificationKit.Post(Notification_NoUpdates, Nil)
		      End If
		    #endif
		    mAvailableDownloadURL = Location.Value("url")
		    mAvailableSignature = Location.Value("signature")
		    
		    If Preferences.AutomaticallyDownloadsUpdates Then
		      DownloadUpdate()
		    End If
		    
		    NotificationKit.Post(Notification_UpdateAvailable, LatestBuild)
		  Catch Err As RuntimeException
		    NotificationKit.Post(Notification_Error, "Invalid definition file.")
		    App.Log(Err, CurrentMethodName, "Invalid definition file.")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As URLConnection, Error As RuntimeException)
		  Sender.Disconnect
		  
		  If Sender = mSocket Then
		    mChecking = False
		    mSocket = Nil
		  End If
		  
		  NotificationKit.Post(Notification_Error, Error.Message)
		  App.Log("Update check socket disconnect: " + Error.Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_HeadersReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer)
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    Sender.Disconnect
		    
		    If Sender = mSocket Then
		      mChecking = False
		      mSocket = Nil
		    End If
		    
		    NotificationKit.Post(Notification_Error, "The update definition was not found.")
		    App.Log("Update check definition error " + HTTPStatus.ToString(Locale.Raw, "0"))
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mWinSparkle_ShutdownRequest(Sender As WinSparkleMBS)
		  #Pragma Unused Sender
		  
		  Quit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function OSVersion() As String
		  Var MajorVersion, MinorVersion, BugVersion As Integer
		  OSVersion(MajorVersion, MinorVersion, BugVersion)
		  Return MajorVersion.ToString(Locale.Raw, "0") + "." + MinorVersion.ToString(Locale.Raw, "0") + "." + BugVersion.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub OSVersion(ByRef MajorVersion As Integer, ByRef MinorVersion As Integer, ByRef BugVersion As Integer)
		  #if TargetMacOS
		    MajorVersion = SystemInformationMBS.MacMajorVersion
		    MinorVersion = SystemInformationMBS.MacMinorVersion
		    BugVersion = SystemInformationMBS.MacBugFixVersion
		  #elseif TargetWin32
		    MajorVersion = SystemInformationMBS.WinMajorVersion
		    MinorVersion = SystemInformationMBS.WinMinorVersion
		    BugVersion = SystemInformationMBS.WinBuildNumber
		  #elseif TargetLinux
		    // System version numbers are pretty pointless on Linux since every distro will have
		    // different values. There's no way to every make this make sense, so just set to 0.
		    MajorVersion = 0
		    MinorVersion = 0
		    BugVersion = 0
		  #else
		    #Pragma Error "No implementation yet"
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshSettings()
		  IsCheckingAutomatically = Preferences.OnlineEnabled
		  
		  #if UseSparkle
		    Var URL As String = CheckURL()
		    App.Log("Update check URI changed to " + URL)
		    
		    #if TargetMacOS
		      If (mMacSparkle Is Nil) = False Then
		        mMacSparkle.FeedURL = URL
		        mMacSparkle.automaticallyDownloadsUpdates = Preferences.OnlineEnabled And Preferences.AutomaticallyDownloadsUpdates
		      End If
		    #elseif TargetWindows
		      If (mWinSparkle Is Nil) = False Then
		        mWinSparkle.AppCastURL = URL
		      End If
		    #endif
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalBytesToDownload() As Int64
		  Return mTotalBytesToDownload
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UpdateCheckParams() As Dictionary
		  Var Params As New Dictionary
		  Params.Value("build") = App.BuildNumber.ToString(Locale.Raw, "0")
		  If Preferences.UpdateChannel = 0 Then
		    Params.Value("stage") = App.StageCode.ToString(Locale.Raw, "0")
		  Else
		    Params.Value("stage") = Preferences.UpdateChannel.ToString(Locale.Raw, "0")
		  End If
		  If IsARM Then
		    If Is64Bit Then
		      Params.Value("arch") = "arm64"
		    Else
		      Params.Value("arch") = "arm"
		    End If
		  Else
		    If Is64Bit Then
		      Params.Value("arch") = "x64"
		    Else
		      Params.Value("arch") = "x86"
		    End If
		  End If
		  
		  Params.Value("osversion") = OSVersion
		  #if TargetMacOS
		    Params.Value("platform") = "mac"
		  #elseif TargetWin32
		    Params.Value("platform") = "win"
		  #elseif TargetLinux
		    Params.Value("platform") = "lin"
		    
		    Try
		      Var DebianFile As New FolderItem("/etc/debian_version", FolderItem.PathModes.Native)
		      Params.Value("installer_format") = If(DebianFile.Exists, "deb", "rpm")
		    Catch Err As RuntimeException
		      Params.Value("installer_format") = "rpm"
		    End Try
		  #endif
		  If App.IsPortableMode Then
		    Params.Value("portable") = "true"
		  End If
		  
		  Return Params
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function VerifyFile(File As Global.FolderItem, Signature As String) As Boolean
		  If File = Nil Or File.Exists = False Then
		    Return False
		  End If
		  
		  Try
		    Var Contents As MemoryBlock = File.Read
		    Return Crypto.RSAVerifySignature(Contents, DecodeHex(Signature), PublicKey)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAutoCheckTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableDisplayVersion As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableDownloadURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableNotes As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableNotesURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailablePreview As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAvailableUpdateRequired As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChecking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadedBytes As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloader As URLConnection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadRate As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadSecondsRemaining As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadStart As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsDownloading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCheckTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMacSparkle As SUUpdaterMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As URLConnection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalBytesToDownload As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWinSparkle As WinSparkleMBS
	#tag EndProperty


	#tag Constant, Name = Notification_DownloadError, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.error", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_DownloadStarted, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.download_started", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_Error, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.error", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_NoUpdates, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.none", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_UpdateAvailable, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.available", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_UpdateDownloaded, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.updates.downloaded", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PublicKey, Type = String, Dynamic = False, Default = \"30820120300D06092A864886F70D01010105000382010D003082010802820101008F9D9B313D28FDE0FD2100032D2E1A7F968A2E4975AF93A507823A95EFFE6A73176BD76D1286CC5DE513D3F4163F6F4E3D2A2FC472D540533020035FA0ED3FDFA33CBA289A94753D70546544459BE69E99B3B08AACBF489DEFA45BA1CC04DE0976DE2DABDC523A13FCEAE701468D994FEC116F30D44B307FD80AB13B1E15E76EA8B1366EC22E814F15D8021993FAE0BA39DF440EEF17550BC3A6CE2831A1B479E93088F2CAACFD19179D1C0744F0293A94C06D8F7D1D73C089D950F86953C2605F70462A889C4A1160B70192C1F97964F0741ED74713E10FF9CDC5BE6205385E5245297D41C31A75067699CB85D9FA6F806E8C770C5E91D706BCD5426C3080B1020111", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UseSparkle, Type = Boolean, Dynamic = False, Default = \"False", Scope = Protected
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"True"
	#tag EndConstant

	#tag Constant, Name = WinSparklePublicKey, Type = String, Dynamic = False, Default = \"-----BEGIN PUBLIC KEY-----\r\nMIIDOjCCAi0GByqGSM44BAEwggIgAoIBAQDI6xZ9nrExgcaSvbX/4gfS7bZQKM05\r\nHIw++81r7YlxOGw+GQEZzD73m/qq2P++jZttHwvIl0AWiILlTsdTeqoykceoz0jm\r\nyag6hZWFwo6jbyB0lvO59JipKyaygov1gx3TGFMxN/BRoKEPoBGkfbB00vS/9pQZ\r\nwk4+28+MeBQQwO4Z1BCm4xZ9l/rCqrfDyPSc1zEIfEHxB/7r5rERsxzIp+Z7bSSs\r\naF1JFwIQb7NISFBWB3S5p+vpGIeGZkE/0fZ9NkUHxpTL/7Er/cVZxAVH+yZgFg3h\r\ndTKwgWE1Hh6oA+31c19J/Oivd+zZVccvu//UXvJ8v1N0u723RaiDIptxAhUA/MRp\r\n4RFNsVJ01KI4K52HuGeuvXUCggEAR1KjYB6sFT2Q23H5afwNq/dsfbiUIq0Vnu7i\r\nE32sa5EQUynMJ07hVi9n4tpDqVvo/GRvqWMLk775aqcw40QYv1XHX3FZoSU7iu4z\r\nVBGqd5VgiCpKsLXGWnDypt+WHv2S1xnsWTGAa7lFldJjbuGL3EOE7tQwaSMeeteA\r\nJD3kl23s8FOVbRkLextddYMdh1adzggRItkHHMuq0Nj+/TkSOiQ9AHrlLJML32hV\r\nGyDqp8sTGt/z7y7jRM49U9V+s18kBNSz3iCnKYaN2iZ3zzE+B2BVH6iLC0TGZRZZ\r\npMM/5vwLTkuzEFjqvj53ZSRupmAF94mt3goXj6nQiMItx78KrQOCAQUAAoIBAD/P\r\ndHzac4YzhZXuz/WZN+J6OKzniYVmU9C41HMpd2Ovl9isDdugg6uulRHXgMtJTkP0\r\nItRb355Eb4eOvJJu3FOrIqfLMk83dX123pMW3URjnQjRf6MQpq/IsmqV2eoOlcN8\r\nfOC0OBHg4TvlTTMui81PtAoM/99qwJn48CGaZj4rZ8pIHWIyvGUHKiJx06chN2Tu\r\npIi2OH084SsAFZ5YQaDPOZciuVYVZUiCZglpEr4ojvG8Gscp36EFjJHZHwEfgnSv\r\nPEkqXo/MqfRXOH868Wk011vRaQyPqdbtc2fbXrcTUe6x37ZN4HQ0nsMt7GDKnfcg\r\nnAfZb9LE8GoPjNBvYQE\x3D\r\n-----END PUBLIC KEY-----\r\n\r\n", Scope = Private
	#tag EndConstant


	#tag Structure, Name = MacOSVersion, Flags = &h21
		Major As Integer
		  Minor As Integer
		Bug As Integer
	#tag EndStructure

	#tag Structure, Name = WinOSVersion, Flags = &h21
		OSVersionInfoSize As UInt32
		  MajorVersion As UInt32
		  MinorVersion As UInt32
		  BuildNumber As UInt32
		  PlatformId As UInt32
		  CSDVersion As String * 256
		  ServicePackMajor As UInt16
		  ServicePackMinor As UInt16
		  SuiteMask As UInt16
		  ProductType As UInt8
		Reserved As UInt8
	#tag EndStructure


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
