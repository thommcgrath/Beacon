#tag Class
Protected Class ModDiscoveryEngine
	#tag Method, Flags = &h21
		Private Shared Function BuildCommand(Type As Int32, Command As String) As MemoryBlock
		  Var CommandLen As Integer = Command.Bytes
		  Var Mem As New MemoryBlock(CommandLen + 14)
		  Mem.LittleEndian = True
		  Mem.Int32Value(0) = CommandLen + 10 // Size
		  Mem.Int32Value(4) = System.Random.InRange(1, 9999) // ID
		  Mem.Int32Value(8) = Type // Type
		  Mem.StringValue(12, CommandLen) = Command
		  Return Mem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		  Self.StatusMessage = "Cancelling…"
		  
		  If (Self.mRCONSocket Is Nil) = False Then
		    RemoveHandler mRCONSocket.Connected, WeakAddressOf mRCONSocket_Connected
		    RemoveHandler mRCONSocket.DataAvailable, WeakAddressOf mRCONSocket_DataAvailable
		    RemoveHandler mRCONSocket.Error, WeakAddressOf mRCONSocket_Error
		    Self.mRCONSocket.Close
		    Self.mRCONSocket = Nil
		  End If
		  
		  If (Self.mRCONTimer Is Nil) = False Then
		    RemoveHandler mRCONTimer.Action, WeakAddressOf mRCONTimer_Action
		    Self.mRCONTimer.RunMode = Timer.RunModes.Off
		    Self.mRCONTimer = Nil
		  End If
		  
		  If (Self.mShell Is Nil) = False Then
		    RemoveHandler mShell.Completed, WeakAddressOf mShell_Completed
		    RemoveHandler mShell.DataAvailable, WeakAddressOf mShell_DataAvailable
		    Self.mShell.Close
		    Self.mShell = Nil
		  End If
		  
		  If (Self.mThread Is Nil) = False And Self.mThread.ThreadState = Thread.ThreadStates.Paused Then
		    Self.mThread.Resume
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cleanup(HostDir As FolderItem)
		  #if Not DebugBuild
		    Try
		      If HostDir Is Nil Or HostDir.Exists = False Or HostDir.DeepDelete(False) Then
		        Return
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Cleaning up host directory")
		    End Try
		    App.Log("Host folder " + HostDir.NativePath + " was not deleted")
		  #else
		    #Pragma Unused HostDir
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetModIdForTag(Tag As String) As String
		  If (Self.mModsByTag Is Nil) = False Then
		    Return Self.mModsByTag.Lookup(Tag, "")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTagForModId(ModId As String) As String
		  If (Self.mTagsByMod Is Nil) = False Then
		    Return Self.mTagsByMod.Lookup(ModId, "")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRunning() As Boolean
		  Return (Self.mActiveInstance Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModIds() As String()
		  Var ModIds() As String
		  ModIds.ResizeTo(Self.mModIds.LastIndex)
		  For Idx As Integer = 0 To Self.mModIds.LastIndex
		    ModIds(Idx) = Self.mModIds(Idx)
		  Next
		  Return ModIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRCONSocket_Connected(Sender As TCPSocket)
		  #if DebugBuild
		    System.DebugLog("RCON connected")
		  #endif
		  Self.StatusMessage = "RCON Connected. Waiting for mod data…"
		  
		  Var PassLen As Int32 = Self.mRCONPassword.Bytes
		  Var Auth As New MemoryBlock(PassLen + 14)
		  Auth.LittleEndian = True
		  Auth.Int32Value(0) = PassLen + 10// Size
		  Auth.Int32Value(4) = System.Random.InRange(1, 9999) // ID
		  Auth.Int32Value(8) = 3 // Type
		  Auth.StringValue(12, PassLen) = Self.mRCONPassword
		  
		  Var AuthResponse As New MemoryBlock(14)
		  AuthResponse.LittleEndian = True
		  AuthResponse.Int32Value(0) = 10
		  AuthResponse.Int32Value(4) = Auth.Int32Value(4)
		  AuthResponse.Int32Value(8) = 2
		  Self.mRCONAuthResponse = AuthResponse
		  
		  Sender.Write(Auth)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRCONSocket_DataAvailable(Sender As TCPSocket)
		  Var Message As String = Sender.ReadAll
		  
		  #if DebugBuild
		    System.DebugLog(EncodeHex(Message))
		  #endif
		  
		  If Self.mRCONAuthenticated = False Then
		    Self.mRCONAuthenticated = Message = Self.mRCONAuthResponse
		    Return
		  End If
		  
		  If Message.IndexOf("End Dino Drop Inventory Data From Spawns") > -1 Then
		    // Finished
		    
		    Self.mRCONTimer.RunMode = Timer.RunModes.Off
		    
		    Var Mem As MemoryBlock = Self.BuildCommand(2, "DoExit")
		    Sender.Write(Mem)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRCONSocket_Error(Sender As TCPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  #if DebugBuild
		    System.DebugLog("Socket error: " + Err.Message)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRCONTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Self.mRCONSocket.IsConnected = False THen
		    Self.mRCONSocket.Close
		    Self.mRCONSocket.Address = "127.0.0.1"
		    Self.mRCONSocket.Port = Self.mRCONPort
		    Self.mRCONSocket.Connect
		    Return
		  End If
		  
		  If Self.mRCONAuthenticated = False Then
		    Return
		  End If
		  
		  Var Mem As MemoryBlock = Self.BuildCommand(2, "GetGameLog")
		  Self.mRCONSocket.Write(Mem)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mShell_Completed(Sender As Shell)
		  #Pragma Unused Sender
		  
		  #if DebugBuild
		    System.DebugLog("Completed")
		  #endif
		  Self.mRCONSocket.Close
		  Self.mRCONTimer.RunMode = Timer.RunModes.Off
		  Self.mThread.Resume
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mShell_DataAvailable(Sender As Shell)
		  #if DebugBuild
		    System.DebugLog(Sender.ReadAll)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_Run(Sender As Thread)
		  Sender.YieldToNext
		  
		  Self.StatusMessage = "Building server…"
		  
		  Var Port As Integer = System.Random.InRange(2000, 65000)
		  Var QueryPort As Integer = Port + 1
		  Var RCONPort As Integer = Port + 2
		  Var Password As String = EncodeHex(Crypto.GenerateRandomBytes(4)).Lowercase
		  
		  Var ConfigLines() As String
		  ConfigLines.Add("[" + Ark.HeaderServerSettings + "]")
		  ConfigLines.Add("ActiveMods=" + Self.mModIds.Join(","))
		  ConfigLines.Add("ServerPassword=" + Password)
		  ConfigLines.Add("ServerAdminPassword=" + Password)
		  ConfigLines.Add("RCONEnabled=True")
		  ConfigLines.Add("RCONPort=" + RCONPort.ToString(Locale.Raw, "0"))
		  ConfigLines.Add("RCONPassword=" + Password)
		  
		  Var CustomConfig As New Ark.Configs.CustomContent
		  CustomConfig.GameUserSettingsIniContent = ConfigLines.Join(EndOfLine)
		  
		  Var Profile As New Ark.ServerProfile(Local.Identifier, "Mod Discovery")
		  Var Project As New Ark.Project
		  Project.AddConfigGroup(CustomConfig)
		  Project.AddServerProfile(Profile)
		  
		  If Self.mCancelled Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Try
		    If Self.mArkRoot.Exists = False Then
		      Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Ark game files do not exist at " + Self.mArkRoot.NativePath + "."))
		      Return
		    End If
		    App.Log("Ark Root: " + Self.mArkRoot.NativePath)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Getting Ark root folder")
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Could not get path to Ark game files.", "Exception": Err))
		    Return
		  End Try
		  
		  Var HostDir As FolderItem
		  #if TargetWindows
		    HostDir = Self.mArkRoot.ParentVolumeMBS.Child("Beacon Dedicated Servers")
		    If HostDir.CheckIsFolder(True) Then
		      HostDir.Visible = False
		    End If
		  #else
		    HostDir = App.ApplicationSupport.Child("Servers")
		  #endif
		  
		  If Ark.DedicatedServer.Configure(Project, Profile, Self.mArkRoot, HostDir) = False Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Could not build server directory."))
		    Return
		  End If
		  
		  If Self.mCancelled Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Var ServerFolder As FolderItem = HostDir.Child(Profile.ProfileID)
		  App.Log("Server Root: " + ServerFolder.NativePath)
		  
		  Var ModsFolder As FolderItem
		  Try
		    ModsFolder = ServerFolder.Child("ShooterGame").Child("Content").Child("Mods")
		    If ModsFolder.CheckIsFolder(True) = False Then
		      Self.Cleanup(HostDir)
		      App.Log("Mods folder could not be created.")
		      Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Mods folder could not be created."))
		      Return
		    End If
		    App.Log("Mods Root: " + ModsFolder.NativePath)
		  Catch Err As RuntimeException
		    Self.Cleanup(HostDir)
		    App.Log(Err, CurrentMethodName, "Getting Ark mods folder")
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Could not find ShooterGame/Content/Mods folder.", "Exception": Err))
		    Return
		  End Try
		  
		  Var SteamCMD As FolderItem 
		  Try
		    SteamCMD = Ark.DedicatedServer.SteamCMD(ServerFolder)
		    If SteamCMD Is Nil Or SteamCMD.Exists = False Then
		      Self.Cleanup(HostDir)
		      App.Log("SteamCMD is not installed.")
		      Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "SteamCMD is not installed."))
		      Return
		    End If
		    App.Log("SteamCMD: " + SteamCMD.NativePath)
		  Catch Err As RuntimeException
		    Self.Cleanup(HostDir)
		    App.Log(Err, CurrentMethodName, "Getting steamcmd path")
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Could not find path to SteamCMD.", "Exception": Err))
		    Return
		  End Try
		  Var SteamCMDPath As String = """" + SteamCMD.NativePath + """"
		  Var DownloadCommands() As String
		  For Each ModId As String In Self.mModIds
		    DownloadCommands.Add("+workshop_download_item 346110 " + ModId)
		  Next
		  
		  If Self.mCancelled Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Self.StatusMessage = "Installing mods…"
		  
		  Var SteamShell As New Shell
		  SteamShell.TimeOut = -1
		  SteamShell.ExecuteMode = Shell.ExecuteModes.Asynchronous
		  
		  Var DownloadCommand As String = SteamCMDPath + " +login anonymous " + String.FromArray(DownloadCommands, " ") + " +quit"
		  App.Log("Download Command: " + DownloadCommand)
		  SteamShell.Execute(DownloadCommand)
		  
		  While SteamShell.IsRunning
		    If Self.mCancelled Then
		      Self.Cleanup(HostDir)
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		      Return
		    End If
		    
		    Sender.Sleep(10)
		  Wend
		  
		  Var SteamResult As String = SteamShell.Result
		  Var SteamExitCode As Integer = SteamShell.ExitCode
		  App.Log("Steam Exit Code: " + SteamExitCode.ToString(Locale.Raw, "0"))
		  App.Log(SteamResult)
		  
		  Var WorkshopFolder As FolderItem
		  Try
		    WorkshopFolder = SteamCMD.Parent.Child("steamapps").Child("workshop").Child("content").Child("346110")
		  Catch Err As RuntimeException
		    Self.Cleanup(HostDir)
		    App.Log(Err, CurrentMethodName, "Getting workshop data path")
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Could not find path to SteamCMD downloaded content.", "Exception": Err))
		    Return
		  End Try
		  
		  For Each ModId As String In Self.mModIds
		    If Self.mCancelled Then
		      Self.Cleanup(HostDir)
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		      Return
		    End If
		    
		    Try
		      Ark.DedicatedServer.InstallMod(ModId, WorkshopFolder, ModsFolder)
		    Catch Err As RuntimeException
		      Self.Cleanup(HostDir)
		      App.Log(Err, CurrentMethodName, "Attempting to install mod " + ModId)
		      Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Mod " + ModId + " did not install.", "Exception": Err))
		      Return
		    End Try
		  Next
		  
		  Self.StatusMessage = "Launching server…"
		  Var Executable As FolderItem = Ark.DedicatedServer.ShooterGameServer(ServerFolder)
		  Var CommandLine As String = """TheIsland?listen?SessionName=Beacon?MaxPlayers=10?Port=" + Port.ToString(Locale.Raw, "0") + "?QueryPort=" + QueryPort.ToString(Locale.Raw, "0") + """ -server -servergamelog -nobattleye"
		  
		  #if TargetWindows
		    If (Self.mShell Is Nil) = False Then
		      Self.mShell.Execute("""" + Executable.NativePath + """ " + CommandLine)
		    End If
		  #else
		    #Pragma Unused Executable
		  #endif
		  
		  App.Log("Launching server with " + CommandLine)
		  App.Log("Server port is " + Port.ToString(Locale.Raw, "0"))
		  
		  Self.mRCONPort = RCONPort
		  Self.mRCONPassword = Password
		  If (Self.mRCONTimer Is Nil) = False Then
		    Self.mRCONTimer.RunMode = Timer.RunModes.Multiple
		  End If
		  
		  Sender.Pause
		  
		  If Self.mCancelled Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Self.mModsByTag = New Dictionary
		  Self.mTagsByMod = New Dictionary
		  If (ModsFolder Is Nil) = False Then
		    Self.StatusMessage = "Collecting mod info…"
		    
		    For Each ModId As String In Self.mModIds
		      If Self.mCancelled Then
		        Self.Cleanup(HostDir)
		        Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		        Return
		      End If
		      
		      Try
		        Var ModInfoFile As FolderItem = ModsFolder.Child(ModId).Child("mod.info")
		        Var Stream As BinaryStream = BinaryStream.Open(ModInfoFile, False)
		        Stream.LittleEndian = True
		        Var ModTag As String = ReadUnrealString(Stream)
		        Stream.Close
		        
		        Self.mTagsByMod.Value(ModId) = ModTag
		        Self.mModsByTag.Value(ModTag) = ModId
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Reading mod info file")
		      End Try
		    Next
		  End If
		  
		  Self.StatusMessage = "Reading log file…"
		  
		  Var LogFile As FolderItem
		  Try
		    LogFile = ServerFolder.Child("ShooterGame").Child("Saved").Child("Logs").Child("ShooterGame.log")
		  Catch Err As RuntimeException
		  End Try
		  If LogFile Is Nil Or LogFile.Exists = False Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Could not find ShooterGame.log file."))
		    Return
		  End If
		  
		  Var Stream As TextInputStream = TextInputStream.Open(LogFile)
		  Var LogContents As String = Stream.ReadAll(Encodings.UTF8)
		  Stream.Close
		  
		  Var LogsFolder As FolderItem = App.LogsFolder
		  If (LogsFolder Is Nil) = False And LogsFolder.CheckIsFolder(True) Then
		    Var DiscoveryLogsFolder As FolderItem = LogsFolder.Child("Mod Discovery")
		    If DiscoveryLogsFolder.CheckIsFolder(True) Then
		      Var Now As DateTime = DateTime.Now
		      Var LogFileBackup As FolderItem = DiscoveryLogsFolder.Child(Beacon.SanitizeFilename(Now.SQLDateTimeWithOffset + ".log"))
		      Var BackupStream As TextOutputStream = TextOutputStream.Create(LogFileBackup)
		      BackupStream.Write(LogContents)
		      BackupStream.Close
		    End If
		  End If
		  
		  If Self.mCancelled Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Self.StatusMessage = "Discovering blueprints…"
		  RaiseEvent Import(LogContents)
		  
		  If Self.mCancelled Then
		    Self.Cleanup(HostDir)
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Self.Cleanup(HostDir)
		  
		  Self.mSuccess = True
		  Sender.AddUserInterfaceUpdate(New Dictionary("Finished" : True))
		  
		  Exception TopLevelException As RuntimeException
		    Self.Cleanup(HostDir)
		    App.Log(TopLevelException, CurrentMethodName, "Running the discovery thread")
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Unhandled exception in discover thread.", "Exception": TopLevelException))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_UserInterfaceUpdate(Sender As Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    If Update.HasKey("Event") Then
		      Select Case Update.Value("Event").StringValue
		      Case "StatusUpdated"
		        RaiseEvent StatusUpdated
		      End Select
		    End If
		    
		    Var Error As Boolean = Update.Lookup("Error", False).BooleanValue
		    Var Finished As Boolean = Error Or Update.Lookup("Finished", False).BooleanValue
		    If Error Then
		      Var ErrorMessage As String = Update.Lookup("Message", "").StringValue
		      RaiseEvent Error(ErrorMessage)
		    End If
		    If Finished Then
		      Self.mActiveInstance = Nil
		      RaiseEvent Finished()
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadUnrealString(Stream As BinaryStream) As String
		  Var Len As UInt32 = Stream.ReadUInt32
		  If Len <> 0 Then
		    Var St As String = Stream.Read(Len - 1).DefineEncoding(Encodings.UTF8)
		    Call Stream.Read(1) // To advance past the trailing null
		    Return St
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(ArkRoot As FolderItem, ModIds() As String)
		  Var Executable As FolderItem = Ark.DedicatedServer.ShooterGameServer(ArkRoot)
		  If Executable Is Nil Then
		    Var Err As New IOException
		    Err.Message = "Beacon could not find the Ark server executable in the selected path."
		    Raise Err
		  End If
		  
		  If (Self.mActiveInstance Is Nil) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Mod discovery is already running"
		    Raise Err
		  End If
		  
		  Self.mActiveInstance = Self
		  Self.mArkRoot = ArkRoot
		  Self.mModIds.ResizeTo(ModIds.LastIndex)
		  For Idx As Integer = 0 To Self.mModIds.LastIndex
		    Self.mModIds(Idx) = ModIds(Idx)
		  Next
		  If Self.mModIds.IndexOf("2171967557") = -1 Then
		    Self.mModIds.AddAt(0, "2171967557")
		  End If
		  Self.mStatusMessage = "Initializing…"
		  Self.mSuccess = False
		  Self.mCancelled = False
		  
		  Self.mThread = New Thread
		  AddHandler mThread.Run, WeakAddressOf mThread_Run
		  AddHandler mThread.UserInterfaceUpdate, WeakAddressOf mThread_UserInterfaceUpdate
		  
		  Self.mShell = New Shell
		  Self.mShell.ExecuteMode = Shell.ExecuteModes.Interactive
		  Self.mShell.TimeOut = 0
		  AddHandler mShell.Completed, WeakAddressOf mShell_Completed
		  AddHandler mShell.DataAvailable, WeakAddressOf mShell_DataAvailable
		  
		  Self.mRCONTimer = New Timer
		  Self.mRCONTimer.RunMode = Timer.RunModes.Off
		  Self.mRCONTimer.Period = 3000
		  AddHandler mRCONTimer.Action, WeakAddressOf mRCONTimer_Action
		  
		  Self.mRCONSocket = New TCPSocket
		  Self.mRCONSocket.Address = "127.0.0.1"
		  AddHandler mRCONSocket.Connected, WeakAddressOf mRCONSocket_Connected
		  AddHandler mRCONSocket.DataAvailable, WeakAddressOf mRCONSocket_DataAvailable
		  AddHandler mRCONSocket.Error, WeakAddressOf mRCONSocket_Error
		  
		  Self.mThread.Start
		  
		  RaiseEvent Started()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusMessage() As String
		  If Self.mCancelled Then
		    Return "Cancelling…"
		  Else
		    Return Self.mStatusMessage
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StatusMessage(Assigns Message As String)
		  If Self.mStatusMessage.Compare(Message, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mStatusMessage = Message
		  
		  If Thread.Current Is Nil Then
		    RaiseEvent StatusUpdated()
		  Else
		    Self.mThread.AddUserInterfaceUpdate(New Dictionary("Event": "StatusUpdated"))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WasSuccessful() As Boolean
		  Return Self.mSuccess
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(ErrorMessage As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Import(LogContents As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StatusUpdated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared mActiveInstance As Ark.ModDiscoveryEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArkRoot As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModIds() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModsByTag As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONAuthenticated As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONAuthResponse As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONSocket As TCPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRCONTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShell As Shell
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuccess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTagsByMod As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThread As Thread
	#tag EndProperty


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
