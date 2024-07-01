#tag Class
Protected Class ModDiscoveryEngine2
	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		  Self.StatusMessage = "Cancelling…"
		  
		  If (Self.mThread Is Nil) = False And Self.mThread.ThreadState = Thread.ThreadStates.Paused Then
		    Self.mThread.Resume
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsAvailable() As Boolean
		  Return TargetWindows And UpdatesKit.MachineArchitecture = UpdatesKit.Architectures.x86_64
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_Run(Sender As Beacon.Thread)
		  Self.mSuccess = False
		  
		  Var SteamRoot As FolderItem
		  Try
		    SteamRoot = New FolderItem(Preferences.ArkSADedicatedPath, FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		  End Try
		  If SteamRoot Is Nil Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Server root is nil. Check the path of your dedicated server files."))
		    Return
		  ElseIf SteamRoot.Exists = False Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Dedicated server files not found at " + SteamRoot.NativePath + "."))
		    Return
		  ElseIf SteamRoot.IsFolder = False Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Found the dedicated server files, but " + SteamRoot.NativePath + " is not a folder."))
		    Return
		  End If
		  
		  Var PaksFolder As FolderItem
		  Try
		    PaksFolder = SteamRoot.Child("ShooterGame").Child("Content").Child("Paks")
		  Catch Err As RuntimeException
		  End Try
		  If PaksFolder Is Nil Or PaksFolder.Exists = False Or PaksFolder.IsFolder = False Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Could not find " + SteamRoot.NativePath + Beacon.PathSeparator + "ShooterGame" + Beacon.PathSeparator + "Content" + Beacon.PathSeparator + "Paks folder."))
		    Return
		  End If
		  
		  Var DiscoveryRoot As FolderItem = SteamRoot.Child("Beacon Mod Discovery")
		  If Not DiscoveryRoot.CheckIsFolder Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Could not create Beacon Mod Discovery folder in " + SteamRoot.NativePath + "."))
		    Return
		  End If
		  
		  Var Sh As New Shell
		  Var RequiredLinks() As String = Array("global.ucas", "global.utoc", "ShooterGame-WindowsServer.pak", "ShooterGame-WindowsServer.ucas", "ShooterGame-WindowsServer.utoc")
		  For Each Filename As String In RequiredLinks
		    Var DestinationFile As FolderItem = DiscoveryRoot.Child(Filename)
		    Var SourceFile As FolderItem = PaksFolder.Child(Filename)
		    If DestinationFile.Exists Then
		      DestinationFile.Remove
		    End If
		    
		    #if TargetWindows
		      Sh.Execute("mklink /H """ + DestinationFile.NativePath + """ """ + SourceFile.NativePath + """")
		    #elseif TargetLinux or TargetMacOS
		      Sh.Execute("ln " + SourceFile.ShellPath + " " + DestinationFile.ShellPath)
		    #endif
		  Next
		  
		  Var ManifestPattern As New RegEx
		  ManifestPattern.SearchPattern = "^ShooterGame/Mods/([^/]+)/AssetRegistry\.bin\t.+$"
		  
		  Var ModIds() As String = Self.mSettings.ModIds
		  Var ModPackageNames As New Dictionary
		  For Each ModId As String In ModIds
		    Var ModInfo As CurseForge.ModInfo = CurseForge.LookupMod(ModId)
		    If ModInfo Is Nil Then
		      Continue
		    End If
		    
		    Var ModFolder As FolderItem = DiscoveryRoot.Child(ModId)
		    If Not ModFolder.CheckIsFolder Then
		      App.Log("Could not create discovery folder for mod " + ModId)
		      Continue
		    End If
		    Var DownloadRequired As Boolean = True
		    Var InfoFile As FolderItem = ModFolder.Child("Mod.json")
		    If InfoFile.Exists Then
		      Var StoredInfo As New CurseForge.ModInfo(InfoFile)
		      If StoredInfo.LastUpdateString = ModInfo.LastUpdateString Then
		        // We already have this mod downloaded and it does not need updating
		        DownloadRequired = False
		      End If
		    End If
		    
		    If DownloadRequired Then
		      Self.StatusMessage = "Downloading mod " + ModInfo.ModName + "…"
		      Var Download As ArkSA.ModDownload = ArkSA.DownloadMod(ModInfo)
		      If Download Is Nil Then
		        Continue
		      End If
		      
		      Self.StatusMessage = "Extracting " + Download.Filename + "…"
		      Do
		        Var Entry As ArchiveEntryMBS = Download.NextHeader
		        If Entry Is Nil Then
		          Exit
		        End If
		        
		        If Entry.Filename <> "Manifest_UFSFiles_Win64.txt" Then
		          Select Case Entry.Filename.LastField(".")
		          Case "pak", "ucas", "utoc"
		          Else
		            Continue
		          End Select
		        End If
		        
		        Var TargetSize As UInt64 = Entry.Size
		        Var OutStream As BinaryStream = BinaryStream.Create(ModFolder.Child(Entry.Filename), True)
		        While OutStream.Length <> TargetSize
		          OutStream.Write(Download.ReadDataBlockMemory())
		        Wend
		        OutStream.Close
		      Loop
		      Download.CloseArchive()
		    End If
		    
		    Var ManifestFile As FolderItem = ModFolder.Child("Manifest_UFSFiles_Win64.txt")
		    Var ManifestStream As TextInputStream = TextInputStream.Open(ManifestFile)
		    Do Until ManifestStream.EndOfFile
		      Var ManifestLine As String = ManifestStream.ReadLine(Encodings.UTF8)
		      Var Matches As RegExMatch = ManifestPattern.Search(ManifestLine)
		      If (Matches Is Nil) = False Then
		        Var PackageName As String = Matches.SubExpressionString(1)
		        ModPackageNames.Value(ModId) = PackageName
		        Exit
		      End If
		    Loop
		    ManifestStream.Close
		    
		    InfoFile.Write(ModInfo.ToString(True))
		  Next
		  
		  Var ExtractorRoot As FolderItem = App.ApplicationSupport.Child("ASA Extractor")
		  If Not ExtractorRoot.CheckIsFolder Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Could not create folder to the data extractor tool."))
		    Return
		  End If
		  
		  Var RequiredHashes As New Dictionary
		  RequiredHashes.Value("mod_data_extractor.exe") = "24304a3a2d413667e108791f00c3e697"
		  RequiredHashes.Value("CUE4Parse-Natives.dll") = "cb4eec121a03a28426cd45051d770ea1"
		  RequiredHashes.Value("mod_data_extractor.pdb") = "538844aaaf862c15cbdbf3ff442b0266"
		  Var ExtractorReady As Boolean = True
		  For Each Entry As DictionaryEntry In RequiredHashes
		    Var ExtractorFile As FolderItem = ExtractorRoot.Child(Entry.Key.StringValue)
		    If ExtractorFile.Exists = False Then
		      ExtractorReady = False
		      Exit
		    End If
		    Var CorrectHash As String = Entry.Value.StringValue
		    Var ComputedHash As String = MD5DigestMBS.HashFile(ExtractorFile, True)
		    If ComputedHash <> CorrectHash Then
		      ExtractorReady = False
		      Exit
		    End If
		  Next
		  
		  If ExtractorReady = False Then
		    Self.StatusMessage = "Downloading extraction tool…"
		    For Each Entry As DictionaryEntry In RequiredHashes
		      Var ExtractorFile As FolderItem = ExtractorRoot.Child(Entry.Key.StringValue)
		      If ExtractorFile.Exists Then
		        ExtractorFile.Remove
		      End If
		    Next
		    
		    Var DownloadSocket As New SimpleHTTP.SynchronousHTTPSocket
		    DownloadSocket.Send("GET", "https://github.com/jordan-dalby/csharp-asa-mod-data-extractor/releases/download/v8/mod_data_extractor-win-x64.zip")
		    If DownloadSocket.HTTPStatusCode <> 200 Then
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Failed to download extractor tool."))
		      Return
		    End If
		    
		    Var Archive As New ArchiveReaderMBS
		    Archive.SupportFilterAll
		    Archive.SupportFormatAll
		    If Not Archive.OpenData(DownloadSocket.LastContent) Then
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Could not open extractor tool archive: " + Archive.ErrorString))
		      Return
		    End If
		    
		    Do
		      Var Entry As ArchiveEntryMBS = Archive.NextHeader
		      If Entry Is Nil Then
		        Exit
		      End If
		      
		      If RequiredHashes.HasKey(Entry.Filename) = False Then
		        Continue
		      End If
		      
		      Var TargetSize As UInt64 = Entry.Size
		      Var TargetFile As FolderItem = ExtractorRoot.Child(Entry.Filename)
		      Var OutStream As BinaryStream = BinaryStream.Create(TargetFile, True)
		      Var Offset As Int64
		      While OutStream.Length <> TargetSize
		        OutStream.Write(Archive.ReadDataBlockMemory(Offset))
		      Wend
		      OutStream.Close
		      
		      Var CorrectHash As String = RequiredHashes.Value(Entry.Filename)
		      Var ComputedHash As String = MD5DigestMBS.HashFile(TargetFile, True)
		      If ComputedHash <> CorrectHash Then
		        TargetFile.Remove
		        Archive.Close
		        Archive = Nil
		        Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Downloaded extractor tool file " + Entry.Filename + " did not pass integrity check."))
		        Return
		      End If
		    Loop
		    Archive.Close
		    Archive = Nil
		  End If
		  
		  Var BlacklistLines() As String
		  BlacklistLines.Add("Engine/")
		  BlacklistLines.Add("ShooterGame/Content/")
		  BlacklistLines.Add("ShooterGame/Plugins/")
		  
		  Var BlacklistFile As FolderItem = ExtractorRoot.Child("blacklist.txt")
		  Var CurrentLines() As String
		  If BlacklistFile.Exists Then
		    Var InStream As TextInputStream = TextInputStream.Open(BlacklistFile)
		    CurrentLines = InStream.ReadAll(Encodings.UTF8).ReplaceLineEndings(EndOfLine).Split(EndOfLine)
		    InStream.Close
		  End If
		  
		  For Each Line As String In BlacklistLines
		    If CurrentLines.IndexOf(Line) = -1 Then
		      CurrentLines.Add(Line)
		    End If
		  Next
		  CurrentLines.Sort
		  
		  Var BlacklistStream As TextOutputStream = TextOutputStream.Create(BlacklistFile)
		  BlacklistStream.Write(String.FromArray(CurrentLines, EndOfLine))
		  BlacklistStream.Close
		  
		  Var OutputFolder As FolderItem = ExtractorRoot.Child("Output")
		  If Not OutputFolder.CheckIsFolder Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Could not create extraction output folder."))
		    Return
		  End If
		  
		  Self.StatusMessage = "Extracting mod data…"
		  Var InputPath As String = DiscoveryRoot.NativePath
		  If InputPath.EndsWith("\") Then
		    InputPath = InputPath.Left(InputPath.Length - 1)
		  End If
		  Var OutputPath As String = OutputFolder.NativePath
		  If OutputPath.EndsWith("\") Then
		    OutputPath = OutputPath.Left(OutputPath.Length - 1)
		  End If
		  Var Command As String = "cd /d """ + ExtractorRoot.NativePath + """ && .\mod_data_extractor.exe --input """ + InputPath + """ --output """ + OutputPath + """ --badfile """ + BlacklistFile.NativePath + """ --file-types ""uasset"" ""bin"""
		  Var ExtractorShell As New Shell
		  ExtractorShell.ExecuteMode = Shell.ExecuteModes.Interactive
		  ExtractorShell.TimeOut = -1
		  ExtractorShell.Execute(Command)
		  While ExtractorShell.IsRunning
		    Sender.Sleep(10)
		  Wend
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
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

	#tag Method, Flags = &h0
		Function Settings() As ArkSA.ModDiscoverySettings
		  Return Self.mSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Settings As ArkSA.ModDiscoverySettings)
		  If (Self.mActiveInstance Is Nil) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Mod discovery is already running"
		    Raise Err
		  End If
		  
		  Self.mActiveInstance = Self
		  Self.mSettings = Settings
		  Self.mStatusMessage = "Initializing…"
		  Self.mSuccess = False
		  Self.mCancelled = False
		  
		  Self.mThread = New Beacon.Thread
		  Self.mThread.DebugIdentifier = "ArkSA.ModDiscoveryEngine2"
		  AddHandler mThread.Run, WeakAddressOf mThread_Run
		  AddHandler mThread.UserInterfaceUpdate, WeakAddressOf mThread_UserInterfaceUpdate
		  
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
		Event ContentPackDiscovered(ContentPack As Beacon.ContentPack, Blueprints() As ArkSA.Blueprint)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(ErrorMessage As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StatusUpdated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared mActiveInstance As ArkSA.ModDiscoveryEngine2
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettings As ArkSA.ModDiscoverySettings
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuccess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThread As Beacon.Thread
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
