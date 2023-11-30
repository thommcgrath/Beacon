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
		    
		    Self.StatusMessage = "Looking up mod " + ModId + "…"
		    
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
		      
		      Var FileHash As String
		      Var Hashes As JSONItem = LatestFile.Child("hashes")
		      For Idx As Integer = 0 To Hashes.Count - 1
		        Var Hash As JSONItem = Hashes.ChildAt(Idx)
		        If Hash.Value("algo") = 1 Then
		          FileHash = Hash.Value("value")
		          Exit For Idx
		        End If
		      Next
		      
		      Var FileSize As Double = LatestFile.Value("fileLength")
		      Var FileName As String = LatestFile.Value("fileName")
		      
		      Var DownloadUrl As String
		      If LatestFile.HasKey("downloadUrl") And LatestFile.Value("downloadUrl").IsNull = False Then
		        DownloadUrl = LatestFile.Value("downloadUrl")
		      Else
		        // The url is predictable
		        Var FileId As Integer = LatestFile.Value("id")
		        Var ParentFolderId As Integer = Floor(FileId / 1000)
		        Var ChildFolderId As Integer = FileId - (ParentFolderId * 1000)
		        DownloadUrl = "https://edge.forgecdn.net/files/" + ParentFolderId.ToString(Locale.Raw, "0") + "/" + ChildFolderId.ToString(Locale.Raw, "0") + "/" + EncodeURLComponent(FileName)
		      End If
		      
		      // This isn't officially supported, so let's pretend we're a browser.
		      Var DownloadSocket As New SimpleHTTP.SynchronousHTTPSocket
		      DownloadSocket.RequestHeader("User-Agent") = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
		      Me.StatusMessage = "Downloading " + FileName + ", " + Beacon.BytesToString(FileSize) + "…"
		      DownloadSocket.Send("GET", DownloadUrl)
		      If DownloadSocket.LastHTTPStatus <> 200 Then
		        App.Log("Mod " + ModId + " was looked up, but the archive could not be downloaded: HTTP #" + DownloadSocket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		        Continue For ModId
		      End If
		      
		      Var DownloadedBytes As Double
		      If (DownloadSocket.LastContent Is Nil) = False Then
		        DownloadedBytes = DownloadSocket.LastContent.Size
		      End If
		      If DownloadedBytes <> FileSize Then
		        App.Log("Mod " + ModId + " downloaded " + Beacon.BytesToString(DownloadedBytes) + " but should have downloaded " + Beacon.BytesToString(FileSize) + ".")
		        Continue For ModId
		      End If
		      
		      If FileHash.IsEmpty = False And (DownloadSocket.LastContent Is Nil) = False Then
		        Var ComputedHash As String = EncodeHex(Crypto.SHA1(DownloadSocket.LastContent))
		        If ComputedHash <> FileHash Then
		          App.Log("Mod " + ModId + " downloaded but checksum does not match. Expected " + FileHash.Lowercase + ", computed " + ComputedHash.Lowercase)
		          Continue For ModId
		        End If
		      End If
		      
		      Var Reader As New ArchiveReaderMBS
		      Reader.SupportFilterAll
		      Reader.SupportFormatAll
		      If Not Reader.OpenData(DownloadSocket.LastContent) Then
		        App.Log("Could not open archive for mod " + ModId + ": " + Reader.ErrorString)
		        Continue For ModId
		      End If
		      
		      Me.StatusMessage = "Locating manifest of " + FileName + "…"
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
		      
		      Me.StatusMessage = "Scanning manifest of " + FileName + "…"
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
		  
		  Me.StatusMessage = "Finished"
		  
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
		  Var Pack As New Beacon.MutableContentPack(ArkSA.Identifier, ModName, ContentPackId)
		  Pack.Marketplace = Beacon.MarketplaceCurseForge
		  Pack.MarketplaceId = ModInfo.Value("id")
		  
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
		  
		  Var Map As New SQLiteDatabase
		  Map.Connect
		  Map.ExecuteSQL("CREATE TABLE map (item_class TEXT COLLATE NOCASE NOT NULL, engram_class TEXT COLATE NOCASE NOT NULL, difference REAL NOT NULL);")
		  Map.ExecuteSQL("CREATE INDEX map_engram_class_idx ON map(engram_class);")
		  
		  For Each ItemClass As String In PrimalItems
		    Var PerfectEngramEntry As String = "EngramEntry" + ItemClass.Middle(10)
		    
		    For Each EngramClass As String In EngramEntries
		      Var Distance As Double = LevenshteinDistanceMBS(PerfectEngramEntry, EngramClass)
		      Map.ExecuteSQL("INSERT INTO map (item_class, engram_class, difference) VALUES (?1, ?2, ?3);", ItemClass, EngramClass, Distance)
		    Next
		  Next
		  
		  Var Unlocks As New Dictionary
		  Do
		    Var Rows As RowSet = Map.SelectSQL("SELECT item_class, difference, engram_class FROM map ORDER BY difference LIMIT 1;")
		    If Rows.RowCount = 0 Then
		      Exit
		    End If
		    
		    Var ItemClass As String = Rows.Column("item_class").StringValue
		    Var Difference As Double = Rows.Column("difference").DoubleValue
		    Var EngramClass As String = Rows.Column("engram_class").StringValue
		    
		    #if DebugBuild
		      System.DebugLog("Matched " + EngramClass + " to " + ItemClass + " with score " + Difference.ToString(Locale.Raw, "0.0000"))
		    #endif
		    
		    Unlocks.Value(ItemClass) = EngramClass + "_C"
		    Map.ExecuteSQL("DELETE FROM map WHERE item_class = ?1 OR engram_class = ?2;", ItemClass, EngramClass)
		  Loop
		  
		  Var Blueprints() As ArkSA.Blueprint
		  For Each ClassString As String In PrimalItems
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var Engram As New ArkSA.MutableEngram(Path, "")
		    Engram.ContentPackId = ContentPackId
		    Engram.ContentPackName = ModName
		    Engram.RegenerateBlueprintId()
		    Engram.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    
		    If Unlocks.HasKey(ClassString) Then
		      Engram.EntryString = Unlocks.Value(ClassString).StringValue
		      Engram.RequiredPlayerLevel = 999
		      Engram.RequiredUnlockPoints = 999
		    End If
		    
		    Blueprints.Add(Engram)
		  Next
		  
		  RaiseEvent ContentPackDiscovered(Pack.ImmutableVersion, Blueprints)
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
