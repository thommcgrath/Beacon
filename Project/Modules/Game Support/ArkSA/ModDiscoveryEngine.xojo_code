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

	#tag Method, Flags = &h21
		Private Sub mThread_Run(Sender As Beacon.Thread)
		  Sender.YieldToNext
		  
		  Self.StatusMessage = "Building server…"
		  
		  If Self.mCancelled Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		    Return
		  End If
		  
		  Var Searcher As New Regex
		  Searcher.SearchPattern = "^ShooterGame/Mods/([^/]+)/Content(.*)/([^/]+)\.uasset\t[\d\-TZ:\.]{24}$"
		  
		  Self.mModsByTag = New Dictionary
		  Self.mTagsByMod = New Dictionary
		  Var ModIds() As String = Self.mSettings.ModIds
		  For Each ModId As String In ModIds
		    If Self.mCancelled Then
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True))
		      Return
		    End If
		    
		    Var ModInfo As CurseForge.ModInfo = CurseForge.LookupMod(ModId)
		    If ModInfo Is Nil Then
		      Continue
		    End If
		    
		    Self.StatusMessage = "Downloading mod " + ModInfo.ModName + "…"
		    Var Download As ArkSA.ModDownload = ArkSA.DownloadMod(ModInfo)
		    If Download Is Nil Then
		      Continue
		    End If
		    
		    Try
		      Me.StatusMessage = "Locating manifest of " + Download.Filename + "…"
		      Var ManifestContent As String
		      Do
		        Var Entry As ArchiveEntryMBS = Download.NextHeader
		        If Entry Is Nil Then
		          Exit
		        End If
		        
		        If Entry.FileName <> "Manifest_UFSFiles_Win64.txt" Then
		          Continue
		        End If
		        
		        Var TargetSize As UInt64 = Entry.Size
		        Var FileContents As New MemoryBlock(0)
		        While FileContents.Size <> CType(TargetSize, Integer)
		          FileContents = FileContents +  Download.ReadDataBlockMemory()
		        Wend
		        
		        ManifestContent = FileContents
		        Exit
		      Loop
		      Download.CloseArchive()
		      
		      Me.StatusMessage = "Scanning manifest of " + Download.Filename + "…"
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
		          Var Path As String = "/" + ModTag + NamespaceString + "." + ClassString
		          Candidates.Value(Path) = ClassString
		        Catch LineErr As RuntimeException
		        End Try
		      Next
		      
		      Self.ProcessCandidates(Candidates, ModInfo)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to scan mod " + ModId)
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
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Unhandled exception in discover thread.", "Exception": TopLevelException))
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
		Private Shared Sub NormalizeWords(Words() As String)
		  If mNormalization Is Nil Then
		    mNormalization = New Dictionary
		    mNormalization.Value("karkino") = "crab"
		    mNormalization.Value("ravager") = "cavewolf"
		    mNormalization.Value(Array("cave", "wolf")) = "cavewolf"
		    mNormalization.Value("dunkle") = "dunkleosteus"
		    mNormalization.Value("galli") = "gallimimus"
		    mNormalization.Value("plesi") = "plesio"
		    mNormalization.Value("plesia") = "plesio"
		    mNormalization.Value("procop") = "procoptodon"
		    mNormalization.Value("therizino") = "therizinosaurus"
		    mNormalization.Value("titano") = "titan"
		    mNormalization.Value("trope") = "tropeognathus"
		    mNormalization.Value("rollrat") = "molerat"
		    mNormalization.Value(Array("roll", "rat")) = "molerat"
		    mNormalization.Value(Array("mole", "rat")) = "molerat"
		    mNormalization.Value(Array("shadow", "drake")) = Array("rock", "drake")
		    mNormalization.Value("shadowdrake") = Array("rock", "drake")
		    mNormalization.Value("rockdrake") = Array("rock", "drake")
		    mNormalization.Value("milkglider") = Array("milk", "glider")
		  End If
		  
		  For Each Entry As DictionaryEntry In mNormalization
		    Var InitialIdx As Integer
		    
		    If Entry.Key.IsArray Then
		      Var MatchWords() As String = Entry.Key
		      InitialIdx = Words.IndexOf(MatchWords(0))
		      If InitialIdx = -1 Or InitialIdx + MatchWords.Count > Words.LastIndex Then
		        Continue
		      End If
		      For MatchIdx As Integer = 1 To MatchWords.LastIndex
		        If Words(InitialIdx + MatchIdx) <> MatchWords(MatchIdx) Then
		          Continue For Entry
		        End If
		      Next
		      For Iter As Integer = 1 To MatchWords.Count
		        Words.RemoveAt(InitialIdx)
		      Next
		    Else
		      InitialIdx = Words.IndexOf(Entry.Key.StringValue)
		      If InitialIdx = -1 Then
		        Continue
		      End If
		      Words.RemoveAt(InitialIdx)
		    End If
		    
		    Var ReplaceWords() As String
		    If Entry.Value.IsArray Then
		      ReplaceWords = Entry.Value
		    Else
		      ReplaceWords = Array(Entry.Value.StringValue)
		    End If
		    For Idx As Integer = 0 To ReplaceWords.LastIndex
		      Words.AddAt(InitialIdx + Idx, ReplaceWords(Idx))
		    Next
		  Next
		  
		  Words.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessCandidates(Candidates As Dictionary, ModInfo As CurseForge.ModInfo)
		  Var ModName As String = ModInfo.ModName
		  Var ModId As String = ModInfo.ModId.ToString(Locale.Raw, "0")
		  Var ContentPackId As String = Beacon.ContentPack.GenerateLocalContentPackId(Beacon.MarketplaceCurseForge, ModId)
		  Var Pack As New Beacon.MutableContentPack(ArkSA.Identifier, ModName, ContentPackId)
		  Pack.Marketplace = Beacon.MarketplaceCurseForge
		  Pack.MarketplaceId = ModId
		  
		  Var DataSource As ArkSA.DataSource
		  Var OfficialPackIds As Beacon.StringList
		  If Self.mSettings.IgnoreBuiltInClasses Then
		    DataSource = ArkSA.DataSource.Pool.Get(False)
		    Var OfficialPacks() As Beacon.ContentPack = DataSource.GetContentPacks(Beacon.ContentPack.TypeOfficial)
		    OfficialPackIds = New Beacon.StringList
		    For Each OfficialPack As Beacon.ContentPack In OfficialPacks
		      OfficialPackIds.Append(OfficialPack.ContentPackId)
		    Next
		  End If
		  
		  Var EngramEntries(), PrimalItems(), Creatures(), SupplyCrates(), DinoInventories(), SpawnPoints() As String
		  Var ClassPaths As New Dictionary // Yes, this will break if a mod uses the same class in more than one namespace. This is a crappy implementation anyway, so I don't care.
		  For Each Entry As DictionaryEntry In Candidates
		    Var Path As String = Entry.Key
		    Var ClassString As String = Entry.Value
		    
		    If ClassString.BeginsWith("EngramEntry") Then
		      If Self.mSettings.IgnoreBuiltInClasses Then
		        Var OfficialMatches() As ArkSA.Engram = DataSource.GetEngramsByEntryString(ClassString + "_C", OfficialPackIds)
		        If OfficialMatches.Count = 0 Then
		          EngramEntries.Add(ClassString)
		        End If
		      Else
		        EngramEntries.Add(ClassString)
		      End If
		    ElseIf ClassString.BeginsWith("PrimalItem") Then
		      If Self.mSettings.IgnoreBuiltInClasses Then
		        Var OfficialMatches() As ArkSA.Engram = DataSource.GetEngramsByClass(ClassString + "_C", OfficialPackIds)
		        If OfficialMatches.Count = 0 Then
		          PrimalItems.Add(ClassString)
		        End If
		      Else
		        PrimalItems.Add(ClassString)
		      End If
		    ElseIf ClassString.Contains("Character_BP") Or ClassString.Contains("BP_Character") Then
		      If Self.mSettings.IgnoreBuiltInClasses Then
		        Var OfficialMatches() As ArkSA.Creature = DataSource.GetCreaturesByClass(ClassString + "_C", OfficialPackIds)
		        If OfficialMatches.Count = 0 Then
		          Creatures.Add(ClassString)
		        End If
		      Else
		        Creatures.Add(ClassString)
		      End If
		    ElseIf ClassString.BeginsWith("SupplyCrate") Then
		      If Self.mSettings.IgnoreBuiltInClasses Then
		        Var OfficialMatches() As ArkSA.LootContainer = DataSource.GetLootContainersByClass(ClassString + "_C", OfficialPackIds)
		        If OfficialMatches.Count = 0 Then
		          SupplyCrates.Add(ClassString)
		        End If
		      Else
		        SupplyCrates.Add(ClassString)
		      End If
		    ElseIf ClassString.BeginsWith("DinoDropInventory") Or ClassString.BeginsWith("DinoInventory") Then
		      If Self.mSettings.IgnoreBuiltInClasses Then
		        Var OfficialMatches() As ArkSA.LootContainer = DataSource.GetLootContainersByClass(ClassString + "_C", OfficialPackIds)
		        If OfficialMatches.Count = 0 Then
		          DinoInventories.Add(ClassString)
		        End If
		      Else
		        DinoInventories.Add(ClassString)
		      End If
		    ElseIf ClassString.BeginsWith("DinoSpawnEntries") Then
		      If Self.mSettings.IgnoreBuiltInClasses Then
		        Var OfficialMatches() As ArkSA.SpawnPoint = DataSource.GetSpawnPointsByClass(ClassString + "_C", OfficialPackIds)
		        If OfficialMatches.Count = 0 Then
		          SpawnPoints.Add(ClassString)
		        End If
		      Else
		        SpawnPoints.Add(ClassString)
		      End If
		    Else
		      Continue
		    End If
		    ClassPaths.Value(ClassString) = Path
		  Next
		  
		  Var Map As New SQLiteDatabase
		  Map.Connect
		  Map.ExecuteSQL("CREATE TABLE map (item_class TEXT COLLATE NOCASE NOT NULL, engram_class TEXT COLATE NOCASE NOT NULL, distance REAL NOT NULL);")
		  Map.ExecuteSQL("CREATE INDEX map_engram_class_idx ON map(engram_class);")
		  
		  Var PotentialPrefixes() As String = Array("PrimalItemArmor_", "PrimalItemConsumable_", "PrimalItemResource_", "PrimalItemAmmo_", "PrimalItemCostume_", "PrimalItemDye_", "PrimalItemSkin_", "PrimalItemStructure_", "PrimalItem_Weapon", "PrimalItemWeapon_", "PrimalItem_", "PrimalItem") // Make sure PrimalItem_ and PrimalItem are last
		  Var Aliases As New Dictionary
		  Aliases.Value("cavewolf") = "ravager"
		  Aliases.Value("crab") = "karkino"
		  For Each ItemClass As String In PrimalItems
		    Var Offset As Integer
		    For Each Prefix As String In PotentialPrefixes
		      If ItemClass.BeginsWith(Prefix) Then
		        Offset = Prefix.Length
		        Exit For Prefix
		      End If
		    Next
		    Var PerfectEngramWords() As String = ArkSA.ClassStringToWords(ItemClass.Middle(Offset))
		    Self.NormalizeWords(PerfectEngramWords)
		    Var PerfectEngramPhrase As String = String.FromArray(PerfectEngramWords, " ")
		    
		    For Each EngramClass As String In EngramEntries
		      Var EngramWords() As String = ArkSA.ClassStringToWords(EngramClass.Middle(11))
		      Self.NormalizeWords(EngramWords)
		      Var EngramPhrase As String = String.FromArray(EngramWords, " ")
		      
		      Var Distance As Double = LevenshteinDistanceMBS(PerfectEngramPhrase, EngramPhrase)
		      Map.ExecuteSQL("INSERT INTO map (item_class, engram_class, distance) VALUES (?1, ?2, ?3);", ItemClass, EngramClass, Distance)
		    Next
		  Next
		  
		  Map.ExecuteSQL("DELETE FROM map WHERE distance > ?1;", Self.mSettings.Threshold)
		  
		  Var Unlocks As New Dictionary
		  Do
		    Var Rows As RowSet = Map.SelectSQL("SELECT item_class, distance, engram_class FROM map ORDER BY distance LIMIT 1;")
		    If Rows.RowCount = 0 Then
		      Exit
		    End If
		    
		    Var ItemClass As String = Rows.Column("item_class").StringValue
		    Var Distance As Double = Rows.Column("distance").DoubleValue
		    Var EngramClass As String = Rows.Column("engram_class").StringValue
		    
		    #if DebugBuild
		      System.DebugLog("Matched " + EngramClass + " to " + ItemClass + " with score " + Distance.ToString(Locale.Raw, "0.0000"))
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
		    Engram.Tags = Array("blueprintable")
		    
		    If Unlocks.HasKey(ClassString) Then
		      Engram.EntryString = Unlocks.Value(ClassString).StringValue
		      Engram.RequiredPlayerLevel = 999
		      Engram.RequiredUnlockPoints = 999
		    End If
		    
		    Blueprints.Add(Engram)
		  Next
		  
		  For Each ClassString As String In Creatures
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var Creature As New ArkSA.MutableCreature(Path, "")
		    Creature.ContentPackId = ContentPackId
		    Creature.ContentPackName = ModName
		    Creature.RegenerateBlueprintId()
		    Creature.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    Blueprints.Add(Creature)
		  Next
		  
		  For Each ClassString As String In SupplyCrates
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var SupplyCrate As New ArkSA.MutableLootContainer(Path, "")
		    SupplyCrate.ContentPackId = ContentPackId
		    SupplyCrate.ContentPackName = ModName
		    SupplyCrate.RegenerateBlueprintId()
		    SupplyCrate.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    SupplyCrate.UIColor = &cFFFFFF00
		    SupplyCrate.IconId = "d5bb71e5-fba5-51f3-b120-f1abadc1fa6e"
		    SupplyCrate.SortValue = 199
		    Blueprints.Add(SupplyCrate)
		  Next
		  
		  For Each ClassString As String In DinoInventories
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var DinoLoot As New ArkSA.MutableLootContainer(Path, "")
		    DinoLoot.ContentPackId = ContentPackId
		    DinoLoot.ContentPackName = ModName
		    DinoLoot.RegenerateBlueprintId()
		    DinoLoot.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    DinoLoot.UIColor = &cFFFFFF00
		    DinoLoot.IconId = "b7548942-53be-5046-892a-74816e43a938"
		    DinoLoot.SortValue = 200
		    DinoLoot.Tags = Array("dino")
		    DinoLoot.Experimental = True
		    Blueprints.Add(DinoLoot)
		  Next
		  
		  For Each ClassString As String In SpawnPoints
		    Var Path As String = ClassPaths.Value(ClassString)
		    Var Point As New ArkSA.MutableSpawnPoint(Path, "")
		    Point.ContentPackId = ContentPackId
		    Point.ContentPackName = ModName
		    Point.RegenerateBlueprintId()
		    Point.Label = ArkSA.LabelFromClassString(ClassString + "_C")
		    Blueprints.Add(Point)
		  Next
		  
		  RaiseEvent ContentPackDiscovered(Pack.ImmutableVersion, Blueprints)
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
		Private mModsByTag As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mNormalization As Dictionary
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
