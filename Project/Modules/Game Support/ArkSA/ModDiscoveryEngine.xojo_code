#tag Class
Protected Class ModDiscoveryEngine
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
		Private Sub mThread_Run(Sender As Beacon.Thread)
		  Sender.YieldToNext
		  
		  Self.StatusMessage = "Building server…"
		  
		  If Self.mCancelled Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Var Searcher As New Regex
		  Searcher.SearchPattern = "^ShooterGame/Mods/([^/]+)/(.+)/(.+)\.uasset\t[\d\-TZ:\.]{24}$"
		  
		  Self.mModsByTag = New Dictionary
		  Self.mTagsByMod = New Dictionary
		  For Each ModId As String In Self.mModIds
		    If Self.mCancelled Then
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		      Return
		    End If
		    
		    Self.StatusMessage = "Downloading mod " + ModId + "…"
		    
		    Try
		      Var LookupSocket As New SimpleHTTP.SynchronousHTTPSocket
		      LookupSocket.RequestHeader("User-Agent") = App.UserAgent
		      LookupSocket.RequestHeader("x-api-key") = Beacon.CurseForgeApiKey
		      LookupSocket.Send("GET", "https://api.curseforge.com/v1/mods/" + ModId)
		      If LookupSocket.LastHTTPStatus <> 200 Then
		        App.Log("Could not find mod " + ModId + ": HTTP #" + LookupSocket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		        Continue For ModId
		      End If
		      
		      Var ResponseJson As New JSONItem(LookupSocket.LastContent)
		      Var ModInfo As JSONItem = ResponseJson.Value("data")
		      Var LatestFiles As JSONItem = ModInfo.Value("latestFiles")
		      If LatestFiles.IsArray = False Then
		        App.Log("Mod " + ModId + " has no files.")
		        Continue For ModId
		      End If
		      
		      Var MainFileId As Integer = ModInfo.Value("mainFileId")
		      Var LatestFile As JSONItem
		      For Idx As Integer = 0 To LatestFiles.Count - 1
		        Var File As JSONItem = LatestFiles.ChildAt(Idx)
		        If File.Value("id") <> MainFileId Or File.Value("isAvailable").BooleanValue = False Then
		          Continue For Idx
		        End If
		        
		        LatestFile = File
		        Exit For Idx
		      Next
		      If LatestFile Is Nil Then
		        App.Log("Could not find main file for mod " + ModId + " in list of files.")
		        Continue For ModId
		      End If
		      
		      Var DownloadUrl As String
		      If LatestFile.HasKey("downloadUrl") And LatestFile.Value("downloadUrl").IsNull = False Then
		        DownloadUrl = LatestFile.Value("downloadUrl")
		      Else
		        // The url is predictable
		        Var FileId As Integer = LatestFile.Value("id")
		        Var ParentFolderId As Integer = Floor(FileId / 1000)
		        Var ChildFolderId As Integer = FileId - (ParentFolderId * 1000)
		        DownloadUrl = "https://edge.forgecdn.net/files/" + ParentFolderId.ToString(Locale.Raw, "0") + "/" + ChildFolderId.ToString(Locale.Raw, "0") + "/" + EncodeURLComponent(LatestFile.Value("fileName").StringValue)
		      End If
		      
		      // This isn't officially supported, so let's pretend we're a browser.
		      Var DownloadSocket As New SimpleHTTP.SynchronousHTTPSocket
		      DownloadSocket.RequestHeader("User-Agent") = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
		      DownloadSocket.Send("GET", DownloadUrl)
		      If DownloadSocket.LastHTTPStatus <> 200 Then
		        App.Log("Mod " + ModId + " was looked up, but the archive could not be downloaded: HTTP #" + DownloadSocket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		        Continue For ModId
		      End If
		      
		      Var Reader As New ArchiveReaderMBS
		      Reader.SupportFilterAll
		      Reader.SupportFormatAll
		      If Not Reader.OpenData(DownloadSocket.LastContent) Then
		        App.Log("Could not open archive for mod " + ModId + ": " + Reader.ErrorString)
		        Continue For ModId
		      End If
		      
		      Var ManifestContent As String
		      Do
		        Var Entry As ArchiveEntryMBS = Reader.NextHeader
		        If Entry Is Nil Then
		          Exit
		        End If
		        
		        If Entry.FileName <> "Manifest_UFSFiles_Win64.txt" Then
		          Continue
		        End If
		        
		        Var TargetSize As UInt64 = Entry.Size
		        Var Offset As Int64
		        Var FileContents As New MemoryBlock(0)
		        While FileContents.Size <> CType(TargetSize, Integer)
		          FileContents = FileContents +  Reader.ReadDataBlockMemory(Offset)
		        Wend
		        
		        ManifestContent = FileContents
		        Exit
		      Loop
		      Reader.Close
		      Reader = Nil
		      
		      Var Lines() As String = ManifestContent.ReplaceLineEndings(EndOfLine.UNIX).Split(EndOfLine.UNIX)
		      Var Candidates As New Dictionary
		      For Each Line As String In Lines
		        Try
		          Var Matches As RegExMatch = Searcher.Search(Line)
		          If Matches Is Nil Then
		            Continue
		          End If
		          
		          Var ModTag As String = Matches.SubExpressionString(1)
		          Var ClassString As String = Matches.SubExpressionString(3)
		          Var NamespaceString As String = Matches.SubExpressionString(2) + "/" + ClassString
		          Var Path As String = "/Game/Mods/" + ModTag + "/" + NamespaceString + "." + ClassString
		          Candidates.Value(Path) = ClassString
		        Catch LineErr As RuntimeException
		        End Try
		      Next
		      
		      Self.ProcessCandidates(Candidates, ModInfo)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to download mod " + ModId)
		    End Try
		  Next
		  
		  If Self.mCancelled Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Self.mSuccess = True
		  Sender.AddUserInterfaceUpdate(New Dictionary("Finished" : True))
		  
		  Exception TopLevelException As RuntimeException
		    App.Log(TopLevelException, CurrentMethodName, "Running the discovery thread")
		    Sender.AddUserInterfaceUpdate(New Dictionary("Error": True, "Message": "Unhandled exception in discover thread.", "Exception": TopLevelException))
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

	#tag Method, Flags = &h21
		Private Sub ProcessCandidates(Candidates As Dictionary, ModInfo As JSONItem)
		  Var ModName As String = ModInfo.Value("name")
		  Var ContentPackId As String = Beacon.ContentPack.GenerateLocalContentPackId(Beacon.MarketplaceCurseForge, ModInfo.Value("id"))
		  Var Pack As New Beacon.ContentPack(ArkSA.Identifier, ModName, ContentPackId)
		  
		  Var EngramEntries(), PrimalItems() As String
		  Var ClassPaths As New Dictionary // Yes, this will break if a mod uses the same class in more than one namespace. This is a crappy implementation anyway, so I don't care.
		  For Each Entry As DictionaryEntry In Candidates
		    Var Path As String = Entry.Key
		    Var ClassString As String = Entry.Value
		    If ClassString.BeginsWith("EngramEntry") Then
		      EngramEntries.Add(ClassString)
		    ElseIf ClassString.BeginsWith("PrimalItem") Then
		      PrimalItems.Add(ClassString)
		    Else
		      Continue
		    End If
		    ClassPaths.Value(ClassString) = Path
		  Next
		  
		  Var Unlocks As New Dictionary
		  
		  For Idx As Integer = PrimalItems.LastIndex DownTo 0
		    Var ClassString As String = PrimalItems(Idx)
		    Var PerfectEngramEntry As String = "EngramEntry" + ClassString.Middle(10)
		    
		    Var BestDistance As Double = 1.0
		    Var BestIndex As Integer
		    
		    For EngramIdx As Integer = EngramEntries.LastIndex DownTo 0
		      Var Distance As Double = LevenshteinDistanceMBS(PerfectEngramEntry, EngramEntries(EngramIdx))
		      If Distance < BestDistance Then
		        BestDistance = Distance
		        BestIndex = EngramIdx
		        If Distance = 0 Then
		          Exit For EngramIdx
		        End If
		      End If
		    Next
		    
		    If BestDistance = 1.0 Then
		      Continue For Idx
		    End If
		    
		    Unlocks.Value(ClassString) = EngramEntries(BestIndex)
		    EngramEntries.RemoveAt(BestIndex)
		    PrimalItems.RemoveAt(Idx)
		  Next
		  
		  // At this point EngramEntries *should* be empty, and PrimalItems will contain only things with no unlock.
		  // Unlockable stuff will be generated from the Unlocks dictionary
		  
		  Var Blueprints() As ArkSA.Blueprint
		  For Each Entry As DictionaryEntry In Unlocks
		    Var ClassString As String = Entry.Key
		    Var EntryString As String = Entry.Value + "_C"
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var Engram As New ArkSA.MutableEngram(Path, "")
		    Engram.ContentPackId = ContentPackId
		    Engram.ContentPackName = ModName
		    Engram.RegenerateBlueprintId()
		    Engram.EntryString = EntryString
		    Engram.RequiredPlayerLevel = 999
		    Engram.RequiredUnlockPoints = 999
		    Engram.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    Blueprints.Add(Engram)
		  Next
		  
		  For Each ClassString As String In PrimalItems
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var Engram As New ArkSA.MutableEngram(Path, "")
		    Engram.ContentPackId = ContentPackId
		    Engram.ContentPackName = ModName
		    Engram.RegenerateBlueprintId()
		    Engram.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    Blueprints.Add(Engram)
		  Next
		  
		  RaiseEvent ContentPackDiscovered(Pack, Blueprints)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(ModIds() As String)
		  If (Self.mActiveInstance Is Nil) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Mod discovery is already running"
		    Raise Err
		  End If
		  
		  Self.mActiveInstance = Self
		  Self.mModIds.ResizeTo(ModIds.LastIndex)
		  For Idx As Integer = 0 To Self.mModIds.LastIndex
		    Self.mModIds(Idx) = ModIds(Idx)
		  Next
		  Self.mStatusMessage = "Initializing…"
		  Self.mSuccess = False
		  Self.mCancelled = False
		  
		  Self.mThread = New Beacon.Thread
		  Self.mThread.DebugIdentifier = "ArkSA.ModDiscoveryEngine"
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
		Private Shared mActiveInstance As ArkSA.ModDiscoveryEngine
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
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuccess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTagsByMod As Dictionary
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
