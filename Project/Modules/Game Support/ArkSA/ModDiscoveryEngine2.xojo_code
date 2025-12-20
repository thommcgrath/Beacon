#tag Class
Protected Class ModDiscoveryEngine2
	#tag Method, Flags = &h21
		Private Sub AddBlueprint(Blueprint As ArkSA.Blueprint, LowConfidence As Boolean)
		  Var TargetDict As Dictionary = If(LowConfidence, Self.mLowConfidenceBlueprints, Self.mFoundBlueprints)
		  Var ContentPackId As String = Blueprint.ContentPackId
		  Var Siblings() As ArkSA.Blueprint
		  If TargetDict.HasKey(ContentPackId) Then
		    Siblings = TargetDict.Value(ContentPackId)
		  Else
		    TargetDict.Value(ContentPackId) = Siblings
		  End If
		  Siblings.Add(Blueprint.ImmutableVersion)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddTagsToPath(Path As String, ParamArray AdditionalTags() As String)
		  Self.AddTagsToPath(Path, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddTagsToPath(Path As String, AdditionalTags() As String)
		  Var Tags() As String
		  If Self.mTags.HasKey(Path) Then
		    Tags = Self.mTags.Value(Path)
		  Else
		    Self.mTags.Value(Path) = Tags
		  End If
		  
		  For Each Tag As String In AdditionalTags
		    If Tags.IndexOf(Tag) = -1 Then
		      Tags.Add(Tag)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddTagToPath(Path As String, Tag As String)
		  Self.AddTagsToPath(Path, Tag)
		End Sub
	#tag EndMethod

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
		Private Shared Function CleanupName(Name As String) As String
		  Name = Name.ReplaceLineEndings(" ").Trim
		  While Name.Contains("  ")
		    Name = Name.ReplaceAll("  ", " ")
		  Wend
		  Return Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ClearDictionaries()
		  Self.mContentPackIdsByPackage = New Dictionary
		  Self.mPropertiesCache = New Dictionary
		  Self.mUnlockDetails = New Dictionary
		  Self.mItemPaths = New Dictionary
		  Self.mCreaturePaths = New Dictionary
		  Self.mLootPaths = New Dictionary
		  Self.mSpawnPaths = New Dictionary
		  Self.mTags = New Dictionary
		  Self.mPathsScanned = New Dictionary
		  Self.mContentPacks = New Dictionary
		  Self.mFoundBlueprints = New Dictionary
		  Self.mInventoryNames = New Dictionary
		  Self.mBossPaths = New Dictionary
		  Self.mScriptedObjectPaths = New Dictionary
		  Self.mLowConfidenceBlueprints = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ComputeBreedingStats(Properties As JSONMBS, Creature As ArkSA.MutableCreature) As Boolean
		  Try
		    Var IncubationTime As Integer
		    
		    Var bUseBabyGestation As Boolean = Properties.Lookup("bUseBabyGestation", False).BooleanValue
		    If bUseBabyGestation Then
		      Var BabyGestationSpeed As Double = Properties.Lookup("BabyGestationSpeed", 0.000035).DoubleValue
		      Var ExtraBabyGestationSpeedMultiplier As Double = Properties.Lookup("ExtraBabyGestationSpeedMultiplier", 1.0).DoubleValue
		      If BabyGestationSpeed = 0 Or ExtraBabyGestationSpeedMultiplier = 0 Then
		        Return False
		      End If
		      IncubationTime = Round(1 / BabyGestationSpeed / ExtraBabyGestationSpeedMultiplier)
		    Else
		      If Properties.HasChild("FertilizedEggItemsToSpawn") = False Or Properties.Child("FertilizedEggItemsToSpawn").Count = 0 Then
		        Return False
		      End If
		      
		      Var Egg As JSONMBS
		      Var EggsList As JSONMBS = Properties.Child("FertilizedEggItemsToSpawn")
		      If Properties.HasChild("FertilizedEggWeightsToSpawn") Then
		        // Find the best egg
		        Var EggWeights As JSONMBS = Properties.Child("FertilizedEggWeightsToSpawn")
		        Var MaxWeight As Double
		        Var BestIndex As Integer = -1
		        For Idx As Integer = 0 To EggWeights.LastRowIndex
		          If EggWeights.ValueAt(Idx).IsNull Or EggsList.LastRowIndex < Idx Then
		            Continue
		          End If
		          If EggWeights.ValueAt(Idx) > MaxWeight Then
		            BestIndex = Idx
		            MaxWeight = EggWeights.ValueAt(Idx)
		          End If
		        Next
		        If BestIndex > -1 THen
		          Egg = EggsList.ChildAt(BestIndex)
		        End If
		      Else
		        Egg = EggsList.ChildAt(0)
		      End If
		      If Egg Is Nil Or Egg.IsNull Then
		        Return False
		      End If
		      
		      Var EggPath As String = Self.NormalizePath(Egg.Value("ObjectPath"))
		      Var EggProperties As JSONMBS = Self.PropertiesForPath(EggPath)
		      If EggProperties Is Nil Then
		        Return False
		      End If
		      Var EggLoseDurabilityPerSecond As Double = EggProperties.Lookup("EggLoseDurabilityPerSecond", 0.005556).DoubleValue
		      Var ExtraEggLoseDurabilityPerSecondMultiplier As Double = EggProperties.Lookup("ExtraEggLoseDurabilityPerSecondMultiplier", 1.0).DoubleValue
		      If EggLoseDurabilityPerSecond = 0 Or ExtraEggLoseDurabilityPerSecondMultiplier = 0 Then
		        Return False
		      End If
		      IncubationTime = Round(100 / EggLoseDurabilityPerSecond / ExtraEggLoseDurabilityPerSecondMultiplier)
		    End If
		    Var BabyAgeSpeed As Double = Properties.Lookup("BabyAgeSpeed", 0.000003).DoubleValue
		    Var ExtraBabyAgeSpeedMultiplier As Double = Properties.Lookup("ExtraBabyAgeSpeedMultiplier", 1.0).DoubleValue
		    If BabyAgeSpeed = 0 Or ExtraBabyAgeSpeedMultiplier = 0 Then
		      Return False
		    End If
		    
		    Creature.IncubationTime = IncubationTime
		    Creature.MatureTime = Round(1 / (BabyAgeSpeed * ExtraBabyAgeSpeedMultiplier))
		    Creature.MinMatingInterval = Properties.Lookup("NewFemaleMinTimeBetweenMating", 68400).IntegerValue
		    Creature.MaxMatingInterval = Properties.Lookup("NewFemaleMaxTimeBetweenMating", 172800).IntegerValue
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ContentPackIdForPath(Path As String) As String
		  Var PackageName As String = Path.NthField("/", 2)
		  Return Self.mContentPackIdsByPackage.Lookup(PackageName, ArkSA.OfficialContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateObjectId(Path As String, ContentPackId As String = "") As String
		  If ContentPackId.IsEmpty Then
		    ContentPackId = Self.ContentPackIdForPath(Path)
		  End If
		  Return Beacon.UUID.v5(ContentPackId + ":" + Path.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FileForPath(Path As String) As FolderItem
		  Var ClassString As String
		  Return Self.FileForPath(Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FileForPath(Path As String, ByRef ClassString As String) As FolderItem
		  Var PathComponents() As String = Path.Split("/")
		  PathComponents.RemoveAt(0) // empty string before leading slash
		  
		  Var File As FolderItem = Self.mRoot.Child("ShooterGame")
		  If PathComponents(0) = "Game" Then
		    File = File.Child("Content")
		  Else
		    File = File.Child("Mods").Child(PathComponents(0)).Child("Content")
		  End If
		  If File Is Nil Or File.Exists = False Then
		    Return Nil
		  End If
		  PathComponents.RemoveAt(0) // remove the package name
		  ClassString = PathComponents(PathComponents.LastIndex).NthField(".", 1)
		  PathComponents(PathComponents.LastIndex) = ClassString + ".json"
		  
		  For Each Component As String In PathComponents
		    Var Child As FolderItem = File.Child(Component)
		    If Child Is Nil Or Child.Exists = False Then
		      Return Nil
		    End If
		    File = Child
		  Next
		  
		  Return File
		  
		  Exception Err As RuntimeException
		    Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsAvailable() As Boolean
		  Return TargetWindows And UpdatesKit.MachineArchitecture = UpdatesKit.Architectures.x86_64
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Merge(Destination As JSONMBS, Source As JSONMBS)
		  // As of MBS 24.2, this method is no longer necessary
		  
		  If Destination.IsArray <> Source.IsArray Then
		    Var Err As New RuntimeException
		    Err.Message = "Cannot merge arrays and objects"
		    Raise Err
		  End If
		  
		  If Destination.IsArray Then
		    Var Values() As Variant = Source.Values
		    For Each Value As Variant In Values
		      Var Node As JSONMBS = JSONMBS.Convert(Value)
		      If Destination.FindValueInArray(Node) > -1 Then
		        Continue
		      End If
		      
		      Destination.Add(Value)
		    Next
		  Else
		    Var Keys() As String = Source.Keys
		    For Each Key As String In Keys
		      If Destination.HasKey(Key) = False Then
		        Destination.Value(Key) = Source.Value(Key)
		        Continue
		      End If
		      
		      Var DestinationValue As Variant = Destination.Value(Key)
		      Var SourceValue As Variant = Source.Value(Key)
		      
		      If SourceValue.Type <> Variant.TypeObject Or DestinationValue.Type <> Variant.TypeObject Then
		        Destination.Value(Key) = SourceValue
		        Continue
		      End If
		      
		      Merge(JSONMBS(DestinationValue.ObjectValue), JSONMBS(SourceValue.ObjectValue))
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_Run(Sender As Beacon.Thread)
		  Self.mSuccess = False
		  Self.mTimestamp = Round(DateTime.Now.SecondsFrom1970)
		  Self.ClearDictionaries()
		  
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
		  
		  Var RequiredNames As New Dictionary
		  For Each File As FolderItem In PaksFolder.Children(False)
		    If File.Name.EndsWith(".ucas") Or File.Name.EndsWith(".utoc") Or File.Name.EndsWith(".pak") Then
		      RequiredNames.Value(File.Name) = True
		    End If
		  Next
		  
		  Var DiscoveryBound As Integer = DiscoveryRoot.Count - 1
		  For FileIdx As Integer = DiscoveryBound DownTo 0
		    Try
		      Var DestinationFile As FolderItem = DiscoveryRoot.ChildAt(FileIdx)
		      If RequiredNames.HasKey(DestinationFile.Name) Then
		        // The destination already has this link
		        RequiredNames.Remove(DestinationFile.Name)
		        Continue
		      End If
		      If DestinationFile.Name.EndsWith(".ucas") Or DestinationFile.Name.EndsWith(".utoc") Or DestinationFile.Name.EndsWith(".pak") Then
		        // Destination has a file that is not needed, remove it
		        DestinationFile.Remove
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to delete existing junction")
		    End Try
		  Next
		  
		  Var Sh As New Shell
		  For Each Entry As DictionaryEntry In RequiredNames
		    Try
		      Var SourceFile As FolderItem = PaksFolder.Child(Entry.Key.StringValue)
		      Var DestinationFile As FolderItem = DiscoveryRoot.Child(SourceFile.Name)
		      
		      #if TargetWindows
		        Sh.Execute("mklink /H """ + DestinationFile.NativePath + """ """ + SourceFile.NativePath + """")
		      #elseif TargetLinux or TargetMacOS
		        Sh.Execute("ln " + SourceFile.ShellPath + " " + DestinationFile.ShellPath)
		      #endif
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var ManifestPattern As New RegEx
		  ManifestPattern.SearchPattern = "^ShooterGame/Mods/([^/]+)/AssetRegistry\.bin\t.+$"
		  
		  Var ModIds() As String = Self.mSettings.ModIds
		  Var ModPackageNames As New Dictionary
		  Var ModInfos As New Dictionary
		  Var HadSomeSuccess As Boolean
		  For Each ModId As String In ModIds
		    Try
		      Var ModInfo As CurseForge.ModInfo = CurseForge.LookupMod(ModId)
		      If ModInfo Is Nil Then
		        Continue
		      ElseIf ModInfo.IsArkSA = False Then
		        App.Log("Mod " + ModInfo.ModName + " (" + ModId + ") is not an Ark: Survival Ascended mod.")
		        Continue
		      End If
		      ModInfos.Value(ModId) = ModInfo
		      
		      Var ModFolder As FolderItem = DiscoveryRoot.Child(ModId)
		      If Not ModFolder.CheckIsFolder Then
		        App.Log("Could not create discovery folder for mod " + ModId)
		        Continue
		      End If
		      Var DownloadRequired As Boolean = True
		      Var InfoFile As FolderItem = ModFolder.Child("Mod.json")
		      If InfoFile.Exists Then
		        Var StoredInfo As New CurseForge.ModInfo(InfoFile)
		        If StoredInfo.MainFileId = ModInfo.MainFileId Then
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
		      Var Found As Boolean
		      Do Until ManifestStream.EndOfFile
		        Var ManifestLine As String = ManifestStream.ReadLine(Encodings.UTF8)
		        Var Matches As RegExMatch = ManifestPattern.Search(ManifestLine)
		        If (Matches Is Nil) = False Then
		          Var PackageName As String = Matches.SubExpressionString(1)
		          ModPackageNames.Value(ModId) = PackageName
		          Var ContentPackId As String = Self.mSettings.ContentPackId(ModId)
		          Self.mContentPackIdsByPackage.Value(PackageName) = ContentPackId
		          
		          Var Pack As New Beacon.MutableContentPack(ArkSA.Identifier, ModInfo.ModName, ContentPackId)
		          Pack.Marketplace = Beacon.MarketplaceCurseForge
		          Pack.MarketplaceId = ModId
		          Self.mContentPacks.Value(ContentPackId) = Pack
		          
		          Found = True
		          Exit
		        End If
		      Loop
		      ManifestStream.Close
		      
		      If Not Found Then
		        App.Log("Could not find package name for " + ModId)
		        Continue
		      End If
		      
		      InfoFile.Write(ModInfo.ToString(True))
		      HadSomeSuccess = True
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to download mod " + ModId)
		    End Try
		  Next
		  
		  If Not HadSomeSuccess Then
		    If ModIds.Count = 1 Then
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "The requested mod could not be downloaded."))
		    Else
		      Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "None of the requested mods could be downloaded."))
		    End If
		    Return
		  End If
		  
		  Var ExtractorRoot As FolderItem = App.ApplicationSupport.Child("ASA Extractor")
		  If Not ExtractorRoot.CheckIsFolder Then
		    Sender.AddUserInterfaceUpdate(New Dictionary("Finished": True, "Error": True, "Message": "Could not create folder to the data extractor tool."))
		    Return
		  End If
		  
		  Var RequiredHashes As New Dictionary
		  RequiredHashes.Value("CUE4Parse-Conversion.pdb") = "7dfad8413a3a297bba7ee2b99fd102c4"
		  RequiredHashes.Value("CUE4Parse-Natives.dll") = "d019d5da83b37911f25ba7a89d6552a0"
		  RequiredHashes.Value("CUE4Parse.pdb") = "792da56029cf02417ca08ce9ac07ecfe"
		  RequiredHashes.Value("blake3_dotnet.dll") = "7ce74ad9c157ec818b45fa1f0b2c1b95"
		  RequiredHashes.Value("libSkiaSharp.dll") = "ef1fabce43fe32ca83260481253f5476"
		  RequiredHashes.Value("mod_data_extractor.exe") = "7f259d2cd0f24c30327cc5175fb2bf99"
		  RequiredHashes.Value("mod_data_extractor.pdb") = "319824c006744e71ac2dfc2bc3cf9fa8"
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
		    DownloadSocket.Send("GET", "https://updates.usebeacon.app/tools/arksa_data_extractor/v1.2.0.zip")
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
		  Var Targets() As String
		  Targets.Add("ShooterGame/Content/.*LootItemSet")
		  Targets.Add("ShooterGame/Content/.*Egg")
		  For Each Entry As DictionaryEntry In ModPackageNames
		    Targets.Add("ShooterGame/Mods/" + Entry.Value.StringValue + "/")
		  Next
		  
		  Var ParseVersions() As String = Array("GAME_ARKSurvivalAscended")
		  Var Now As New DateTime(Self.mTimestamp)
		  For Each ParseVersion As String In ParseVersions
		    Var Command As String = "cd /d """ + ExtractorRoot.NativePath + """ && .\mod_data_extractor.exe --debug --input """ + InputPath + """ --output """ + OutputPath + """ --file-types ""uasset"" ""umap"" ""bin"" --targets """ + String.FromArray(Targets, """ """) + """ --version """ + ParseVersion + """"
		    Var ExtractorShell As New Shell
		    ExtractorShell.ExecuteMode = Shell.ExecuteModes.Interactive
		    ExtractorShell.TimeOut = -1
		    ExtractorShell.Execute(Command)
		    While ExtractorShell.IsRunning
		      Sender.Sleep(10)
		    Wend
		    
		    Var LogsFolder As FolderItem = App.LogsFolder
		    If (LogsFolder Is Nil) = False And LogsFolder.CheckIsFolder(True) Then
		      Var DiscoveryLogsFolder As FolderItem = LogsFolder.Child("Mod Discovery")
		      If DiscoveryLogsFolder.CheckIsFolder(True) Then
		        Var LogFileBackup As FolderItem = DiscoveryLogsFolder.Child(Beacon.SanitizeFilename(Now.SQLDateTimeWithOffset + ".log"))
		        Var BackupStream As TextOutputStream = TextOutputStream.Open(LogFileBackup)
		        BackupStream.Write(ExtractorShell.Result)
		        BackupStream.Close
		      End If
		    End If
		    
		    For Each Entry As DictionaryEntry In ModPackageNames
		      Var PackageName As String = Entry.Value.StringValue
		      Var RegistryFile As FolderItem = OutputFolder.Child("ShooterGame").Child("Mods").Child(PackageName).Child("AssetRegistry.json")
		      If RegistryFile.Exists And RegistryFile.ModificationDateTime.SecondsFrom1970 > Now.SecondsFrom1970 Then
		        // Good
		        Var Target As String = "ShooterGame/Mods/" + PackageName + "/"
		        Var TargetIdx As Integer = Targets.IndexOf(Target)
		        If TargetIdx > -1 Then
		          Targets.RemoveAt(TargetIdx)
		        End If
		      End If
		    Next
		    
		    If Targets.Count = 2 Then
		      // All the mods processed successfully so no need to run again
		      Exit
		    End If
		  Next
		  
		  Self.mRoot = OutputFolder
		  For Each ModId As String In ModIds
		    Try
		      Var PackageName As String = ModPackageNames.Value(ModId)
		      Var ModInfo As CurseForge.ModInfo = ModInfos.Value(ModId)
		      Self.StatusMessage = "Planning blueprints for " + ModInfo.ModName + "…"
		      Self.ScanMod(PackageName)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Scanning mod " + ModId)
		      Continue
		    End Try
		  Next
		  
		  If Self.mItemPaths.KeyCount > 0 Then
		    Self.StatusMessage = "Building items…"
		    For Each Entry As DictionaryEntry In Self.mItemPaths
		      Var ItemPath As String = Entry.Key
		      Self.SyncItem(ItemPath)
		    Next
		  End If
		  
		  If Self.mCreaturePaths.KeyCount > 0 Then
		    Self.StatusMessage = "Building creatures…"
		    For Each Entry As DictionaryEntry In Self.mCreaturePaths
		      Var CreaturePath As String = Entry.Key
		      Self.SyncCreature(CreaturePath)
		    Next
		  End If
		  
		  If Self.mLootPaths.KeyCount > 0 Then
		    Self.StatusMessage = "Building loot drops…"
		    For Each Entry As DictionaryEntry In Self.mLootPaths
		      Var DropPath As String = Entry.Key
		      Var Type As LootDropType = Entry.Value
		      Self.SyncLootDrop(DropPath, Type)
		    Next
		  End If
		  
		  If Self.mSpawnPaths.KeyCount > 0 Then
		    Self.StatusMessage = "Building spawn points…"
		    For Each Entry As DictionaryEntry In Self.mSpawnPaths
		      Var SpawnPath As String = Entry.Key
		      Self.SyncSpawnContainer(SpawnPath)
		    Next
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mContentPacks
		    Var ContentPackId As String = Entry.Key
		    Var Pack As Beacon.ContentPack = Entry.Value
		    Var ConfirmedBlueprints() As ArkSA.Blueprint
		    Var UnconfirmedBlueprints() As ArkSA.Blueprint
		    If Self.mFoundBlueprints.HasKey(ContentPackId) Then
		      ConfirmedBlueprints = Self.mFoundBlueprints.Value(ContentPackId)
		    End If
		    If Self.mLowConfidenceBlueprints.HasKey(ContentPackId) Then
		      UnconfirmedBlueprints = Self.mLowConfidenceBlueprints.Value(ContentPackId)
		    End If
		    
		    If ConfirmedBlueprints.Count > 0 Or UnconfirmedBlueprints.Count > 0 Then
		      RaiseEvent ContentPackDiscovered(Pack, ConfirmedBlueprints, UnconfirmedBlueprints)
		    End If
		  Next
		  
		  // So these things are not taking up memory they don't need to
		  Self.ClearDictionaries()
		  
		  Self.mSuccess = True
		  Sender.AddUserInterfaceUpdate(New Dictionary("Finished" : True))
		  
		  Exception TopLevelException As RuntimeException
		    Self.ClearDictionaries()
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
		Private Shared Function NormalizePath(Path As String) As String
		  If Path.IsEmpty Then
		    Return Path
		  End If
		  
		  Var Components() As String = Path.Split("/")
		  Var LastComponent As String = Components(Components.LastIndex)
		  Components.RemoveAt(Components.LastIndex)
		  
		  If LastComponent.EndsWith("_C") Then
		    LastComponent = LastComponent.Left(LastComponent.Length - 2)
		  End If
		  
		  Var ClassString As String
		  If LastComponent.Contains(".") Then
		    Var Parts() As String = LastComponent.Split(".")
		    Components.Add(Parts(0))
		    If Parts(1).IsNumeric Then
		      ClassString = Parts(0)
		    Else
		      ClassString = Parts(1)
		    End If
		  Else
		    Components.Add(LastComponent)
		    ClassString = LastComponent
		  End If
		  
		  Return String.FromArray(Components, "/") + "." + ClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PropertiesForPath(Path As String) As JSONMBS
		  If Self.mPropertiesCache.HasKey(Path) Then
		    Return Self.mPropertiesCache.Value(Path)
		  End If
		  
		  Var ClassString As String
		  Var File As FolderItem = Self.FileForPath(Path, ClassString)
		  If File Is Nil Or File.Exists = False Then
		    Self.mPropertiesCache.Value(Path) = Nil
		    Return Nil
		  End If
		  Var Stream As TextInputStream = TextInputStream.Open(File)
		  Var Parsed As New JSONMBS(Stream.ReadAll(Encodings.UTF8))
		  Stream.Close
		  
		  Var EntryPoint As JSONMBS
		  Var FallbackEntry As JSONMBS
		  For Idx As Integer = 0 To Parsed.LastRowIndex
		    Var Child As JSONMBS = Parsed.ChildAt(Idx)
		    If Child.Value("Type") = "BlueprintGeneratedClass" Or Child.Value("Type") = "WidgetBlueprintGeneratedClass" Then
		      EntryPoint = Child
		      Exit For Idx
		    ElseIf (FallbackEntry Is Nil) And Child.Value("Name") = ClassString And Child.HasKey("Properties") Then
		      FallbackEntry = Child.Child("Properties")
		    End If
		  Next
		  
		  If EntryPoint Is Nil Then
		    Self.mPropertiesCache.Value(Path) = FallbackEntry
		    Return FallbackEntry
		  End If
		  
		  Var DefaultPath As String = EntryPoint.Child("ClassDefaultObject").Value("ObjectPath")
		  Var DefaultIndex As Integer = Integer.FromString(DefaultPath.LastField("."), Locale.Raw)
		  Var DefaultObject As JSONMBS = Parsed.ChildAt(DefaultIndex)
		  If DefaultObject.HasChild("Properties") = False Then
		    Self.mPropertiesCache.Value(Path) = FallbackEntry
		    Return FallbackEntry
		  End If
		  
		  Var DefaultProperties As JSONMBS = DefaultObject.Child("Properties")
		  DefaultProperties.Value("X-Beacon-Self") = Self.NormalizePath(DefaultPath)
		  If EntryPoint.HasChild("Super") Then
		    Var SuperPath As String = Self.NormalizePath(EntryPoint.Child("Super").Value("ObjectPath"))
		    DefaultProperties.Value("X-Beacon-Super") = SuperPath
		  End If
		  
		  If DefaultObject.HasKey("SerializedSparseClassData") Then
		    #if MBS.VersionNumber >= 24.2
		      DefaultProperties.Merge()
		    #else
		      Self.Merge(DefaultProperties, DefaultObject.Child("SerializedSparseClassData"))
		    #endif
		  End If
		  
		  Var ChildPaths As JSONMBS = EntryPoint.Query("$.ChildProperties[*].PropertyClass.ObjectPath")
		  Var Children As New JSONMBS
		  For Idx As Integer = 0 To ChildPaths.LastRowIndex
		    Var ChildPath As String = Self.NormalizePath(ChildPaths.ValueAt(Idx))
		    Var ChildClassString As String = ChildPath.LastField(".") + "_C"
		    Var ChildObjects As JSONMBS = Parsed.Query("$[?(@.Type == """ + ChildClassString + """)]")
		    For ChildIdx As Integer = 0 To ChildObjects.LastRowIndex
		      Children.Add(ChildObjects.ChildAt(ChildIdx))
		    Next
		  Next
		  
		  ChildPaths = EntryPoint.Query("$.Children[*].ObjectPath")
		  For Idx As Integer = 0 To ChildPaths.LastRowIndex
		    Var ChildPath As String = ChildPaths.ValueAt(Idx)
		    Var ChildOffset As Integer = Integer.FromString(ChildPath.LastField("."))
		    Var Child As JSONMBS = Parsed.ChildAt(ChildOffset)
		    Children.Add(Child)
		  Next
		  
		  If Children.Count > 0 Then
		    DefaultProperties.Child("X-Beacon-Children") = Children
		  End If
		  
		  Self.mPropertiesCache.Value(Path) = DefaultProperties
		  Return DefaultProperties
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanCreature(Path As String, Options As Integer, AdditionalTags() As String)
		  Self.AddTagsToPath(Path, AdditionalTags)
		  
		  Var IsBoss As Boolean = (Options And Self.CreatureOptionIsBoss) <> 0
		  Var LowConfidence As Boolean = (Options And Self.CreatureOptionLowConfidence) <> 0
		  If Self.ShouldScanPath(Path, LowConfidence) = False Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  If Properties Is Nil Then
		    Return
		  End If
		  
		  Self.mCreaturePaths.Value(Path) = True
		  If IsBoss Then
		    Self.mBossPaths.Value(Path) = True
		  End If
		  
		  // If killing the creature grants items, those should be directly associated.
		  Var GrantItemPaths As JSONMBS = Properties.Query("$.DeathGiveItemClasses[*].ObjectPath")
		  For Idx As Integer = 0 To GrantItemPaths.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(GrantItemPaths.ValueAt(Idx))
		    Self.ScanItem(ItemPath, "reward")
		  Next
		  
		  // If killing the creature unlocks items, scan them but don't associate them
		  Var UnlockItemPaths As JSONMBS = Properties.Query("$.DeathGiveEngramClasses[*].ObjectPath")
		  For Idx As Integer = 0 To UnlockItemPaths.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(UnlockItemPaths.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		  
		  // Make sure dino drop inventories are found.
		  Var ClassString As String = Path.NthField(".", 2)
		  Var Label As String = Self.CleanupName(Properties.Lookup("DescriptiveName", "").StringValue)
		  If Label.IsEmpty Then
		    Label = ArkSA.LabelFromClassString(ClassString)
		  End If
		  If IsBoss Then
		    If ClassString.Contains("Easy") Or ClassString.Contains("Gamma") Then
		      Label = Label + " Easy"
		    ElseIf ClassString.Contains("Medium") Or ClassString.Contains("Beta") Then
		      Label = Label + " Medium"
		    ElseIf ClassString.Contains("Hard") Or ClassString.Contains("Alpha") Then
		      Label = Label + " Hard"
		    End If
		  End If
		  Var Inventories As JSONMBS = Properties.Query("$.DeathInventoryTemplates.AssociatedObjects[*].ObjectPath")
		  For Idx As Integer = 0 To Inventories.LastRowIndex
		    Var InventoryPath As String = Self.NormalizePath(Inventories.ValueAt(Idx))
		    Self.ScanLootDrop(InventoryPath, If(IsBoss, LootDropType.Boss, LootDropType.Dino))
		    
		    Var Names() As String
		    If Self.mInventoryNames.HasKey(InventoryPath) Then
		      Names = Self.mInventoryNames.Value(InventoryPath)
		    Else
		      Self.mInventoryNames.Value(InventoryPath) = Names
		    End If
		    If Names.IndexOf(Label) = -1 Then
		      Names.Add(Label)
		    End If
		  Next
		  
		  // Anything that can be harvested from a dino that spawns on the map, should be available to the map.
		  If Properties.HasKey("DeathHarvestingComponent") And Properties.Value("DeathHarvestingComponent").IsNull = False Then
		    Var HarvestPath As String = Self.NormalizePath(Properties.Child("DeathHarvestingComponent").Value("ObjectPath"))
		    Var HarvestProperties As JSONMBS = Self.PropertiesForPath(HarvestPath)
		    If (HarvestProperties Is Nil) = False Then
		      Var Resources As JSONMBS = HarvestProperties.Query("$.HarvestResourceEntries[*].ResourceItem.ObjectPath")
		      For Idx As Integer = 0 To Resources.LastRowIndex
		        Var ItemPath As String = Self.NormalizePath(Resources.ValueAt(Idx))
		        Self.ScanItem(ItemPath, "harvestable", "resource")
		      Next
		    End If
		  End If
		  
		  // Include things that can be found in the dino.
		  If Properties.HasKey("TamedInventoryComponentTemplate") And Properties.Value("TamedInventoryComponentTemplate").IsNull = False Then
		    Var TamedInventoryComponentPath As String = Self.NormalizePath(Properties.Child("TamedInventoryComponentTemplate").Value("ObjectPath"))
		    Var TamedInventoryProperties As JSONMBS = Self.PropertiesForPath(TamedInventoryComponentPath)
		    If (TamedInventoryProperties Is Nil) = False Then
		      Var Resources As JSONMBS = TamedInventoryProperties.Query("$.DefaultInventoryItems[*].ObjectPath")
		      For Idx As Integer = 0 To Resources.LastRowIndex
		        Var ItemPath As String = Self.NormalizePath(Resources.ValueAt(Idx))
		        Self.ScanItem(ItemPath)
		      Next
		    End If
		  End If
		  
		  // Need eggs.
		  Var Eggs As JSONMBS = Properties.Query("$.EggItemsToSpawn[*].ObjectPath")
		  For Idx As Integer = 0 To Eggs.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(Eggs.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		  
		  // And fertilized eggs.
		  Var FertilizedEggs As JSONMBS = Properties.Query("$.FertilizedEggItemsToSpawn[*].ObjectPath")
		  For Idx As Integer = 0 To FertilizedEggs.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(FertilizedEggs.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		  
		  // Poops are generic and should not be directly associated with a creature. We grab the value here to make sure they are scanned.
		  If Properties.HasKey("PoopItemClass") And Properties.Value("PoopItemClass").IsNull = False Then
		    Var PoopPath As String = Self.NormalizePath(Properties.Child("PoopItemClass").Value("ObjectPath"))
		    Self.ScanItem(PoopPath)
		  End If
		  
		  // Alt poops are creature-specific, like achatina paste.
		  If Properties.HasKey("PoopAltItemClass") And Properties.Value("PoopAltItemClass").IsNull = False Then
		    Var PoopPath As String = Self.NormalizePath(Properties.Child("PoopAltItemClass").Value("ObjectPath"))
		    Self.ScanItem(PoopPath)
		  End If
		  
		  // Some creatures add their items this way.
		  Var DefaultInventoryItems As JSONMBS = Properties.Query("$.DinoExtraDefaultInventoryItems[*].DefaultItemsToGive[*].ObjectPath")
		  For Idx As Integer = 0 To DefaultInventoryItems.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(DefaultInventoryItems.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanCreature(Path As String, Options As Integer, ParamArray AdditionalTags() As String)
		  Self.ScanCreature(Path, Options, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanCreature(Path As String, ParamArray AdditionalTags() As String)
		  Self.ScanCreature(Path, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanCreature(Path As String, AdditionalTags() As String)
		  Self.ScanCreature(Path, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanInventory(Path As String)
		  If Self.ShouldScanPath(Path, False) = False Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  If Properties Is Nil Then
		    Return
		  End If
		  
		  Var InventoryPaths As JSONMBS = Properties.Query("$.DefaultInventoryItems[*].ObjectPath")
		  For Idx As Integer = 0 To InventoryPaths.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(InventoryPaths.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanItem(Path As String, Options As Integer, ParamArray AdditionalTags() As String)
		  Self.ScanItem(Path, Options, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanItem(Path As String, Options As Integer, AdditionalTags() As String)
		  Self.AddTagsToPath(Path, AdditionalTags)
		  
		  Var NoSync As Boolean = (Options And Self.ItemOptionNoSync) <> 0
		  Var LowConfidence As Boolean = (Options And Self.ItemOptionLowConfidence) <> 0
		  If Self.ShouldScanPath(Path, LowConfidence) = False Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  If Properties Is Nil Then
		    Return
		  End If
		  
		  If Properties.HasKey("DescriptiveNameBase") And NoSync = False Then
		    Self.mItemPaths.Value(Path) = True
		  End If
		  
		  If Properties.HasChild("ActiveRequiresFuelItems") Then
		    Var FuelItems As JSONMBS = Properties.Child("ActiveRequiresFuelItems")
		    For Idx As Integer = 0 To FuelItems.LastRowIndex
		      Var FuelItem As JSONMBS = FuelItems.ChildAt(Idx)
		      If FuelItem Is Nil Or FuelItem.IsNull Then
		        Continue
		      End If
		      Var FuelItemPath As String = Self.NormalizePath(FuelItem.Value("ObjectPath"))
		      Self.ScanItem(FuelItemPath)
		    Next
		  End If
		  
		  If Properties.HasChild("FuelItemsConsumedGiveItems") Then
		    Var GeneratedItems As JSONMBS = Properties.Child("FuelItemsConsumedGiveItems")
		    For Idx As Integer = 0 To GeneratedItems.LastRowIndex
		      Var GeneratedItem As JSONMBS = GeneratedItems.ChildAt(Idx)
		      If GeneratedItem Is Nil Or GeneratedItem.IsNull Then
		        Continue
		      End If
		      Var GeneratedItemPath As String = Self.NormalizePath(GeneratedItem.Value("ObjectPath"))
		      Self.ScanItem(GeneratedItemPath)
		    Next
		  End If
		  
		  If Properties.HasChild("BaseCraftingResourceRequirements") Then
		    Var BaseCraftingResourceRequirements As JSONMBS = Properties.Child("BaseCraftingResourceRequirements")
		    For Idx As Integer = 0 To BaseCraftingResourceRequirements.LastRowIndex
		      Var Requirement As JSONMBS = BaseCraftingResourceRequirements.ChildAt(Idx)
		      If Requirement Is Nil Or Requirement.IsNull Or Requirement.HasChild("ResourceItemType") = False Or Requirement.Child("ResourceItemType").IsNull Then
		        Continue
		      End If
		      
		      Var IngredientPath As String = Self.NormalizePath(Requirement.Child("ResourceItemType").Value("ObjectPath"))
		      Self.ScanItem(IngredientPath, "resource")
		    Next
		  End If
		  
		  If Properties.HasChild("GiveItemWhenUsed") Then
		    Var ItemPath As String = Self.NormalizePath(Properties.Child("GiveItemWhenUsed").Value("ObjectPath"))
		    Self.ScanItem(ItemPath)
		  End If
		  
		  If Properties.HasChild("CraftingActorToSpawn") Then
		    // Need to look for BossArenaClass (another file), OverrideBossClass, or BossClass
		    Var ActorProperties As JSONMBS = Self.PropertiesForPath(Self.NormalizePath(Properties.Child("CraftingActorToSpawn").Value("AssetPathName")))
		    Var BossPaths() As String
		    If ActorProperties.HasKey("OverrideBossClass") Then
		      BossPaths.Add(Self.NormalizePath(ActorProperties.Child("OverrideBossClass").Value("ObjectPath")))
		    ElseIf ActorProperties.HasKey("BossClass") Then
		      BossPaths.Add(Self.NormalizePath(ActorProperties.Child("BossClass").Value("ObjectPath")))
		    ElseIf ActorProperties.HasKey("BossArenaClass") Then
		      Var ArenaPath As String = Self.NormalizePath(ActorProperties.Child("BossArenaClass").Value("ObjectPath"))
		      Var ArenaProperties As JSONMBS = Self.PropertiesForPath(ArenaPath)
		      If ArenaProperties Is Nil Then
		        Return
		      End If
		      
		      If ArenaProperties.HasKey("BossClass") Then
		        BossPaths.Add(Self.NormalizePath(ArenaProperties.Child("BossClass").Value("AssetPathName")))
		      End If
		      If ArenaProperties.HasKey("SecondBossClass") Then
		        BossPaths.Add(Self.NormalizePath(ArenaProperties.Child("SecondBossClass").Value("AssetPathName")))
		      End If
		    End If
		    
		    If BossPaths.Count > 0 Then
		      Self.AddTagsToPath(Path, "tribute")
		    End If
		    
		    For Each BossPath As String In BossPaths
		      Self.ScanCreature(BossPath, Self.CreatureOptionIsBoss)
		    Next
		  End If
		  
		  If Properties.HasKey("StructureToBuild") Then
		    Var StructureToBuild As JSONMBS = Properties.Child("StructureToBuild")
		    Var StructurePath As String
		    If StructureToBuild.HasKey("AssetPathName") Then
		      StructurePath = Self.NormalizePath(StructureToBuild.Value("AssetPathName"))
		    ElseIf StructureToBuild.HasKey("ObjectPath") Then
		      StructurePath = Self.NormalizePath(StructureToBuild.Value("ObjectPath"))
		    End If
		    If StructurePath.IsEmpty = False Then
		      Self.ScanItem(StructurePath, Self.ItemOptionNoSync)
		    End If
		  End If
		  
		  If Properties.HasKey("DungeonArenaManagerClass") And Properties.Value("DungeonArenaManagerClass").IsNull = False Then
		    Self.AddTagsToPath(Path, "tribute")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanItem(Path As String, ParamArray AdditionalTags() As String)
		  Self.ScanItem(Path, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanItem(Path As String, AdditionalTags() As String)
		  Self.ScanItem(Path, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanLootDrop(Path As String, Type As LootDropType, Options As Integer, ParamArray AdditionalTags() As String)
		  Self.ScanLootDrop(Path, Type, Options, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanLootDrop(Path As String, Type As LootDropType, Options As Integer, AdditionalTags() As String)
		  Self.AddTagsToPath(Path, AdditionalTags)
		  
		  Var LowConfidence As Boolean = (Options And Self.DropOptionLowConfidence) <> 0
		  #if DebugBuild
		    System.DebugLog("Scanning drop " + Path + ". Low confidence = " + If(LowConfidence, "True", "False"))
		  #endif
		  If Self.ShouldScanPath(Path, LowConfidence) = False Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  If Properties Is Nil Then
		    Return
		  End If
		  
		  If Properties.HasKey("ItemSets") = False Then
		    #if DebugBuild
		      System.DebugLog("Skipping " + Path + " because it has no ItemSets property.")
		    #endif
		    Return
		  End If
		  
		  Self.mLootPaths.Value(Path) = Type
		  
		  Var AdditionalItemPaths As JSONMBS = Properties.Query("$.AdditionalItemSets[*].ItemEntries[*].Items[*].ObjectPath")
		  For Idx As Integer = 0 To AdditionalItemPaths.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(AdditionalItemPaths.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		  
		  Var ItemSets As JSONMBS = Properties.Child("ItemSets")
		  For Idx As Integer = 0 To ItemSets.LastRowIndex
		    Var ItemSet As JSONMBS = ItemSets.ChildAt(Idx)
		    If ItemSet.HasKey("ItemSetOverride") And ItemSet.Value("ItemSetOverride").IsNull = False Then
		      Var OverridePath As String = Self.NormalizePath(ItemSet.Child("ItemSetOverride").Value("ObjectPath").StringValue)
		      Var OverrideProperties As JSONMBS = Self.PropertiesForPath(OverridePath)
		      If OverrideProperties Is Nil Then
		        Continue
		      End If
		      ItemSet = OverrideProperties.Child("ItemSet")
		    End If
		    
		    Var ItemPaths As JSONMBS = ItemSet.Query("$.ItemEntries[*].Items[*].ObjectPath")
		    For ItemPathIdx As Integer = 0 To ItemPaths.LastRowIndex
		      Var ItemPath As String = Self.NormalizePath(ItemPaths.ValueAt(ItemPathIdx))
		      Self.ScanItem(ItemPath)
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanLootDrop(Path As String, Type As LootDropType, ParamArray AdditionalTags() As String)
		  Self.ScanLootDrop(Path, Type, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanLootDrop(Path As String, Type As LootDropType, AdditionalTags() As String)
		  Self.ScanLootDrop(Path, Type, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanMap(Path As String, MapName As String)
		  Var MapFile As FolderItem = Self.FileForPath(Path)
		  
		  Var MapFolder As FolderItem = MapFile.Parent.Child(MapName)
		  If MapFolder.Exists And MapFolder.Child("_Generated_").Exists Then
		    Var Generated As FolderItem = MapFolder.Child("_Generated_")
		    For Each GridFile As FolderItem In Generated.Children
		      Self.ScanMapGrid(GridFile)
		    Next
		  End If
		  
		  Var Stream As TextInputStream = TextInputStream.Open(MapFile)
		  Var Parsed As New JSONMBS(Stream.ReadAll(Encodings.UTF8))
		  Stream.Close
		  
		  Var DefaultInventoryPaths As JSONMBS = Parsed.Query("$[*].Properties.DefaultInventoryItems[*].ObjectPath")
		  For Idx As Integer = 0 To DefaultInventoryPaths.LastRowIndex
		    Var ItemPath As String = Self.NormalizePath(DefaultInventoryPaths.ValueAt(Idx))
		    Self.ScanItem(ItemPath)
		  Next
		  
		  Var BossClassDifficultyPaths As JSONMBS = Parsed.Query("$[*].Properties.BossClassDifficultyMap[*].ObjectPath")
		  For Idx As Integer = 0 To BossClassDifficultyPaths.LastRowIndex
		    Var BossPath As String = Self.NormalizePath(BossClassDifficultyPaths.ValueAt(Idx))
		    Self.ScanCreature(BossPath, Self.CreatureOptionIsBoss)
		  Next
		  
		  Var NPCRandomSpawnClassWeights As JSONMBS = Parsed.Query("$[*].Properties.NPCRandomSpawnClassWeights[*]")
		  For Idx As Integer = 0 To NPCRandomSpawnClassWeights.LastRowIndex
		    Var NPCRandomSpawnClassWeight As JSONMBS = NPCRandomSpawnClassWeights.ChildAt(Idx)
		    Var ToClasses As JSONMBS = NPCRandomSpawnClassWeight.Child("ToClasses")
		    Var Weights As JSONMBS = NPCRandomSpawnClassWeight.Child("Weights")
		    For ReplacementIdx As Integer = 0 To ToClasses.LastRowIndex
		      Var ToPath As String = Self.NormalizePath(ToClasses.ChildAt(ReplacementIdx).Value("AssetPathName"))
		      If ToPath.IsEmpty Then
		        Continue
		      End If
		      If ReplacementIdx > Weights.LastRowIndex Or Weights.ValueAt(ReplacementIdx).DoubleValue > 0.0 Then
		        Self.ScanCreature(ToPath)
		      End If
		    Next
		  Next
		  
		  Var NPCSpawnEntriesContainerObjects As JSONMBS = Parsed.Query("$[*].Properties.NPCSpawnEntriesContainerObject.AssetPathName")
		  For Idx As Integer = 0 To NPCSpawnEntriesContainerObjects.LastRowIndex
		    Var SpawnContainerPath As String = Self.NormalizePath(NPCSpawnEntriesContainerObjects.ValueAt(Idx))
		    Self.ScanSpawnContainer(SpawnContainerPath)
		  Next
		  
		  Var SupplyDropPaths As JSONMBS = Parsed.Query("$[*].Properties.LinkedSupplyCrateEntries[*].CrateTemplate.AssetPathName")
		  For Idx As Integer = 0 To SupplyDropPaths.LastRowIndex
		    Var SupplyDropPath As String = Self.NormalizePath(SupplyDropPaths.ValueAt(Idx))
		    Self.ScanLootDrop(SupplyDropPath, LootDropType.Regular)
		  Next
		  
		  Var MoreDropPaths As JSONMBS = Parsed.Query("$[*].Properties.LinkedSpawnPointEntries[*].OverrideSupplyCrateEntries[*].CrateTemplate.AssetPathName")
		  For Idx As Integer = 0 To MoreDropPaths.LastRowIndex
		    Var SupplyDropPath As String = Self.NormalizePath(MoreDropPaths.ValueAt(Idx))
		    Self.ScanLootDrop(SupplyDropPath, LootDropType.Regular)
		  Next
		  
		  Var DesiredPrefix As String = "/Game/" + MapName + "."
		  Var ActorPaths As JSONMBS = Parsed.Query("$[*].Actors[*].ObjectPath")
		  For Idx As Integer = 0 To ActorPaths.LastRowIndex
		    Var ActorPath As String = ActorPaths.ValueAt(Idx)
		    If ActorPath.BeginsWith(DesiredPrefix) = False Then
		      Continue
		    End If
		    
		    Var Offset As Integer = Integer.FromString(ActorPath.LastField("."), Locale.Raw)
		    Var Member As JSONMBS = Parsed.ChildAt(Offset)
		    Var BlueprintCreatedComponents As JSONMBS = Member.Query("$.Properties.BlueprintCreatedComponents[*].ObjectPath")
		    For ComponentIdx As Integer = 0 To BlueprintCreatedComponents.LastRowIndex
		      Var ComponentPath As String = BlueprintCreatedComponents.ValueAt(ComponentIdx)
		      If ComponentPath.BeginsWith(DesiredPrefix) = False Then
		        Continue
		      End If
		      
		      Var ComponentOffset As Integer = Integer.FromString(ComponentPath.LastField("."), Locale.Raw)
		      Var Component As JSONMBS = Parsed.ChildAt(ComponentOffset)
		      Var DefaultInventoryItems As JSONMBS = Component.Query("$.Properties.DefaultInventoryItems[*].ObjectPath")
		      For ItemIdx As Integer = 0 To DefaultInventoryItems.LastRowIndex
		        Var ItemPath As String = Self.NormalizePath(DefaultInventoryItems.ValueAt(ItemIdx))
		        Self.ScanItem(ItemPath)
		      Next
		    Next
		  Next
		  
		  Var WorldSettingsList As JSONMBS = Parsed.Query("$[?(@.Type == ""PrimalWorldSettings"")].Properties")
		  If WorldSettingsList.Count = 1 Then
		    Var WorldSettings As JSONMBS = WorldSettingsList.ChildNode
		    
		    Var AddedInventoryPaths As JSONMBS = WorldSettings.Query("$['InventoryComponentAppends','InventoryComponentAppendsNonDedicated'][*]['AddItems'][*]['ObjectPath']")
		    For Idx As Integer = 0 To AddedInventoryPaths.LastRowIndex
		      Var ItemPath As String = Self.NormalizePath(AddedInventoryPaths.ValueAt(Idx).StringValue)
		      Self.ScanItem(ItemPath)
		    Next
		  Else
		    Break
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanMapGrid(File As FolderItem)
		  Var Stream As TextInputStream = TextInputStream.Open(File)
		  Var Parsed As New JSONMBS(Stream.ReadAll(Encodings.UTF8))
		  Stream.Close
		  
		  Var Results As JSONMBS = Parsed.Query("$[*].Properties.AttachedComponentClass.ObjectPath")
		  For Idx As Integer = 0 To Results.LastRowIndex
		    Var HarvestComponentPath As String = Self.NormalizePath(Results.ValueAt(Idx))
		    Var HarvestComponent As JSONMBS = Self.PropertiesForPath(HarvestComponentPath)
		    If HarvestComponent Is Nil Then
		      Continue
		    End If
		    
		    Var ItemPaths As JSONMBS = HarvestComponent.Query("$.HarvestResourceEntries[*].ResourceItem.ObjectPath")
		    For ItemIdx As Integer = 0 To ItemPaths.LastRowIndex
		      Self.ScanItem(Self.NormalizePath(ItemPaths.ValueAt(ItemIdx)), "harvestable", "resource")
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanMod(PackageName As String)
		  Var NativeParents As New Dictionary
		  Var RegistryFile As FolderItem = Self.mRoot.Child("ShooterGame").Child("Mods").Child(PackageName).Child("AssetRegistry.json")
		  If RegistryFile.Exists = False Then
		    Var ModDir As FolderItem = Self.mRoot.Child("ShooterGame").Child("Mods").Child(PackageName).Child("Content")
		    Var PrimalGameDataName As String
		    For Each File As FolderItem In ModDir.Children
		      If File.Name.BeginsWith("PrimalGameData") = False Then
		        Continue
		      End If
		      
		      PrimalGameDataName = File.Name.Left(File.Name.Length - 5)
		      Exit
		    Next
		    
		    If PrimalGameDataName.IsEmpty = False Then
		      Self.ScanPrimalGameData("/" + PackageName + "/" + PrimalGameDataName + "." + PrimalGameDataName)
		    End If
		    Return
		  End If
		  
		  Var Registry As JSONMBS
		  Try
		    Registry = New JSONMBS(RegistryFile.Read(Encodings.UTF8))
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Reading AssetRegistry")
		    Return
		  End Try
		  Var PreallocatedAssetDataBuffers As JSONMBS = Registry.Child("PreallocatedAssetDataBuffers")
		  For Idx As Integer = 0 To PreallocatedAssetDataBuffers.LastRowIndex
		    Var Asset As JSONMBS = PreallocatedAssetDataBuffers.ChildAt(Idx)
		    Var AssetClass As String = Asset.Value("AssetClass")
		    If AssetClass <> "BlueprintGeneratedClass" Then
		      Continue
		    End If
		    Var ObjectPath As String = Self.NormalizePath(Asset.Value("ObjectPath"))
		    Var NativeParent As String = Asset.Child("TagsAndValues").Value("NativeParentClass")
		    
		    Var Siblings As Dictionary
		    If NativeParents.HasKey(NativeParent) Then
		      Siblings = NativeParents.Value(NativeParent)
		    Else
		      Siblings = New Dictionary
		      NativeParents.Value(NativeParent) = Siblings
		    End If
		    Siblings.Value(ObjectPath) = Asset
		  Next
		  
		  // The primal game data is the kicking off point for most mods
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalGameData'") Then
		    Var PrimalGameDataPaths As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalGameData'")
		    For Each Entry As DictionaryEntry In PrimalGameDataPaths
		      Self.ScanPrimalGameData(Entry.Key.StringValue)
		    Next
		  End If
		  
		  // Map mods will have a level script actor
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/Engine.LevelScriptActor'") Then
		    Var ScriptActorPaths As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/Engine.LevelScriptActor'")
		    For Each Entry As DictionaryEntry In ScriptActorPaths
		      Var Asset As JSONMBS = Entry.Value
		      Var MapName As String = Asset.Child("TagsAndValues").Value("ModuleName")
		      Self.ScanMap(Entry.Key.StringValue, MapName)
		    Next
		  End If
		  
		  // ScanPrimalGameData will fill mScriptedObjectPaths. We can compare those paths against
		  // certain parents to take a good guess at what the script makes use of. The problem
		  // with this is it cannot detect *how* something is used, so a boss won't be seen as a
		  // boss since if it isn't linked through traditional means.
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalDinoCharacter'") Then
		    Var DinoAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalDinoCharacter'")
		    For Each Entry As DictionaryEntry In DinoAssets
		      Var DinoPath As String = Entry.Key.StringValue
		      Var DinoOptions As Integer
		      If Self.mScriptedObjectPaths.HasKey(DinoPath) = False Then
		        DinoOptions = DinoOptions Or Self.CreatureOptionLowConfidence
		      End If
		      Self.ScanCreature(DinoPath, DinoOptions)
		    Next
		  End If
		  
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalItem'") Then
		    Var ItemAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalItem'")
		    For Each Entry As DictionaryEntry In ItemAssets
		      Var ItemPath As String = Entry.Key.StringValue
		      Var ItemOptions As Integer
		      If Self.mScriptedObjectPaths.HasKey(ItemPath) = False Then
		        ItemOptions = ItemOptions Or Self.ItemOptionLowConfidence
		      End If
		      Self.ScanItem(ItemPath, ItemOptions)
		    Next
		  End If
		  
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalStructureItemContainer_SupplyCrate'") Then
		    Var DropAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalStructureItemContainer_SupplyCrate'")
		    For Each Entry As DictionaryEntry In DropAssets
		      Var DropPath As String = Entry.Key.StringValue
		      Var DropOptions As Integer
		      If Self.mScriptedObjectPaths.HasKey(DropPath) = False Then
		        DropOptions = DropOptions Or Self.DropOptionLowConfidence
		      End If
		      Self.ScanLootDrop(DropPath, LootDropType.Regular, DropOptions)
		    Next
		  End If
		  
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.NPCSpawnEntriesContainer'") Then
		    Var SpawnAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.NPCSpawnEntriesContainer'")
		    For Each Entry As DictionaryEntry In SpawnAssets
		      Var SpawnPath As String = Entry.Key.StringValue
		      Var SpawnOptions As Integer
		      If Self.mScriptedObjectPaths.HasKey(SpawnPath) = False Then
		        SpawnOptions = SpawnOptions Or Self.SpawnOptionLowConfidence
		      End If
		      Self.ScanSpawnContainer(SpawnPath, SpawnOptions)
		    Next
		  End If
		  
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalEngramEntry'") Then
		    Var UnlockAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalEngramEntry'")
		    For Each Entry As DictionaryEntry In UnlockAssets
		      Var UnlockPath As String = Entry.Key.StringValue
		      Var UnlockOptions As Integer
		      If Self.mScriptedObjectPaths.HasKey(UnlockPath) = False Then
		        UnlockOptions = UnlockOptions Or Self.UnlockOptionLowConfidence
		      End If
		      Self.ScanUnlock(UnlockPath, UnlockOptions)
		    Next
		  End If
		  
		  // These are the inventories of things like crafting stations
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalInventoryComponent'") Then
		    Var InventoryAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalInventoryComponent'")
		    For Each Entry As DictionaryEntry In InventoryAssets
		      Self.ScanInventory(Entry.Key.StringValue)
		    Next
		  End If
		  
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalItem_ItemTrait'") Then
		    Var TraitAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalItem_ItemTrait'")
		    For Each Entry As DictionaryEntry In TraitAssets
		      Var TraitPath As String = Entry.Key.StringValue
		      Var TraitOptions As Integer
		      If Self.mScriptedObjectPaths.HasKey(TraitPath) = False Then
		        TraitOptions = TraitOptions Or Self.ItemOptionLowConfidence
		      End If
		      Self.ScanItem(TraitPath, TraitOptions)
		    Next
		  End If
		  
		  If NativeParents.HasKey("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalSupplyCrateItemSet'") Then
		    Var ItemSetAssets As Dictionary = NativeParents.Value("/Script/CoreUObject.Class'/Script/ShooterGame.PrimalSupplyCrateItemSet'")
		    For Each Entry As DictionaryEntry In ItemSetAssets
		      Var ItemSetPath As String = Self.NormalizePath(Entry.Key.StringValue)
		      If Self.ShouldScanPath(ItemSetPath, True) = False Then
		        Continue
		      End If
		      
		      Var ItemSetProperties As JSONMBS = Self.PropertiesForPath(ItemSetPath)
		      If ItemSetProperties Is Nil Then
		        Continue
		      End If
		      
		      Var ItemPaths As JSONMBS = ItemSetProperties.Query("$.ItemSet.ItemEntries[*].Items[*].ObjectPath")
		      For Idx As Integer = 0 To ItemPaths.LastRowIndex
		        Var ItemPath As String = Self.NormalizePath(ItemPaths.ValueAt(Idx))
		        Var ItemOptions As Integer
		        If Self.mScriptedObjectPaths.HasKey(ItemPath) = False Then
		          ItemOptions = ItemOptions Or Self.ItemOptionLowConfidence
		        End If
		        Self.ScanItem(ItemPath, ItemOptions)
		      Next
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanPrimalGameData(Path As String)
		  Var PrimalGameData As JSONMBS = Self.PropertiesForPath(Path)
		  Var AssetContainers() As JSONMBS = Array(PrimalGameData)
		  
		  If PrimalGameData.HasKey("AdditionalModDataAsset") And PrimalGameData.Value("AdditionalModDataAsset").IsNull = False Then
		    Var AdditionalModDataAssetPath As String = Self.NormalizePath(PrimalGameData.Child("AdditionalModDataAsset").Value("ObjectPath"))
		    Var AdditionalModDataAsset As JSONMBS = Self.PropertiesForPath(AdditionalModDataAssetPath)
		    If (AdditionalModDataAsset Is Nil) = False Then
		      AssetContainers.Add(AdditionalModDataAsset)
		    End If
		  End If
		  
		  For Each AssetContainer As JSONMBS In AssetContainers
		    // Additional skins
		    Var ItemSkinPaths As JSONMBS = AssetContainer.Query("$.ModCustomCosmeticEntries[*].ModSkinItem.AssetPathName")
		    Var StructureSkinPaths As JSONMBS = AssetContainer.Query("$.ModCustomCosmeticEntries[*].ModSkinStructure.AssetPathName")
		    Var SkinPaths() As JSONMBS = Array(ItemSkinPaths, StructureSkinPaths)
		    For Each PathArray As JSONMBS In SkinPaths
		      For Idx As Integer = 0 To PathArray.LastRowIndex
		        Var SkinPath As String = PathArray.ValueAt(Idx)
		        If SkinPath.IsEmpty Then
		          Continue
		        End If
		        
		        Self.ScanItem(Self.NormalizePath(SkinPath), "skin")
		      Next
		    Next
		    
		    // Additional unlocks
		    Var AdditionalEngramPaths As JSONMBS = AssetContainer.Query("$.AdditionalEngramBlueprintClasses[*].ObjectPath")
		    For Idx As Integer = 0 To AdditionalEngramPaths.LastRowIndex
		      Var UnlockPath As String = AdditionalEngramPaths.ValueAt(Idx)
		      If UnlockPath.IsEmpty Then
		        Continue
		      End If
		      
		      Self.ScanUnlock(Self.NormalizePath(UnlockPath))
		    Next
		    
		    // Stuff added to crafting stations
		    Var AdditionalStructureEngrams As JSONMBS = AssetContainer.Query("$.AdditionalStructureEngrams[*].ClassAdditions[*].AssetPathName")
		    For Idx As Integer = 0 To AdditionalStructureEngrams.LastRowIndex
		      Var ItemPath As String = AdditionalStructureEngrams.ValueAt(Idx)
		      If ItemPath.IsEmpty Then
		        Continue
		      End If
		      
		      Self.ScanItem(Self.NormalizePath(ItemPath))
		    Next
		    
		    // Creatures the mod injects
		    Var InjectedCreaturePaths As JSONMBS = AssetContainer.Query("$.TheNPCSpawnEntriesContainerAdditions[*].AdditionalNPCSpawnEntries[*].NPCsToSpawn[*].AssetPathName")
		    Var InjectedLimitPaths As JSONMBS = AssetContainer.Query("$.TheNPCSpawnEntriesContainerAdditions[*].AdditionalNPCSpawnLimits[*].NPCClass.AssetPathName")
		    Var InjectedReplacementPaths As JSONMBS = AssetContainer.Query("$.GlobalNPCRandomSpawnClassWeights[*].ToClasses[*].AssetPathName")
		    Var CreaturePaths() As JSONMBS = Array(InjectedCreaturePaths, InjectedLimitPaths, InjectedReplacementPaths)
		    For Each PathList As JSONMBS In CreaturePaths
		      For Idx As Integer = 0 To PathList.LastRowIndex
		        Var CreaturePath As String = PathList.ValueAt(Idx)
		        If CreaturePath.IsEmpty Then
		          Continue
		        End If
		        
		        Self.ScanCreature(Self.NormalizePath(CreaturePath))
		      Next
		    Next
		    
		    // Remapped unlocks
		    Var RemappedUnlockPaths As JSONMBS = AssetContainer.Query("$.Remap_Engrams[*].ToClass.AssetPathName")
		    For Idx As Integer = 0 To RemappedUnlockPaths.LastRowIndex
		      Var UnlockPath As String = Self.NormalizePath(RemappedUnlockPaths.ValueAt(Idx))
		      Self.ScanUnlock(UnlockPath)
		    Next
		    
		    // Remapped items
		    Var RemappedItemPaths As JSONMBS = AssetContainer.Query("$['Remap_Items','Remap_ResourceComponents'][*]['ToClass']['AssetPathName']")
		    For Idx As Integer = 0 To RemappedItemPaths.LastRowIndex
		      Var ItemPath As String = Self.NormalizePath(RemappedItemPaths.ValueAt(Idx))
		      Self.ScanItem(ItemPath)
		    Next
		    
		    // Remapped creatures
		    Var RemappedCreaturePaths As JSONMBS = AssetContainer.Query("$.Remap_NPC[*].ToClass.AssetPathName")
		    For Idx As Integer = 0 To RemappedCreaturePaths.LastRowIndex
		      Var CreaturePath As String = Self.NormalizePath(RemappedCreaturePaths.ValueAt(Idx))
		      Self.ScanCreature(CreaturePath)
		    Next
		    
		    // Remapped loot drops
		    Var RemappedLootDrops As JSONMBS = AssetContainer.Query("$.Remap_SupplyCrates[*].ToClass.AssetPathName")
		    For Idx As Integer = 0 To RemappedLootDrops.LastRowIndex
		      Var DropPath As String = Self.NormalizePath(RemappedLootDrops.ValueAt(Idx))
		      Self.ScanLootDrop(DropPath, LootDropType.Regular)
		    Next
		    Var RemappedEventDrops As JSONMBS = AssetContainer.Query("$.Remap_ActiveEventSupplyCrates[*].ReplacementCrateClasses[*].AssetPathName")
		    For Idx As Integer = 0 To RemappedEventDrops.LastRowIndex
		      Var DropPath As String = Self.NormalizePath(RemappedEventDrops.ValueAt(Idx))
		      Self.ScanLootDrop(DropPath, LootDropType.Regular)
		    Next
		    
		    // Remapped spawn points
		    Var RemappedSpawnPoints As JSONMBS = AssetContainer.Query("$.Remap_NPCSpawnEntries[*].ToClass.AssetPathName")
		    For Idx As Integer = 0 To RemappedSpawnPoints.LastRowIndex
		      Var SpawnPath As String = Self.NormalizePath(RemappedSpawnPoints.ValueAt(Idx))
		      Self.ScanSpawnContainer(SpawnPath)
		    Next
		    
		    // These are essentially script objects that are unpredictable. So for each, we're going to grab every path
		    // and see which ones are found in the asset registry.
		    If AssetContainer.HasKey("ServerExtraWorldSingletonActorClasses") Then
		      Var ActorPaths As JSONMBS = AssetContainer.Query("$.ServerExtraWorldSingletonActorClasses[*].ObjectPath")
		      For Idx As Integer = 0 To ActorPaths.LastRowIndex
		        Var ActorPath As String = Self.NormalizePath(ActorPaths.ValueAt(Idx))
		        Var ActorProperties As JSONMBS = Self.PropertiesForPath(ActorPath)
		        If ActorProperties Is Nil Then
		          Continue
		        End If
		        
		        Var AllObjectPaths As JSONMBS = ActorProperties.Query("$..ObjectPath")
		        For PathIdx As Integer = 0 To AllObjectPaths.LastRowIndex
		          Var ObjectPath As String = Self.NormalizePath(AllObjectPaths.ValueAt(PathIdx))
		          Self.mScriptedObjectPaths.Value(ObjectPath) = True
		        Next
		      Next
		    End If
		    
		    #if false
		      // Singletons - not useful yet
		      Var Singletons As JSONMBS = AssetContainer.Query("$.ServerExtraWorldSingletonActorClasses[*].ObjectPath")
		      For Idx As Integer = 0 To Singletons.LastRowIndex
		        Var SingletonPath As String = Self.NormalizePath(Singletons.ValueAt(Idx))
		        Break
		      Next
		    #endif
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanSpawnContainer(Path As String, Options As Integer, AdditionalTags() As String)
		  Self.AddTagsToPath(Path, AdditionalTags)
		  
		  Var LowConfidence As Boolean = (Options And Self.SpawnOptionLowConfidence) <> 0
		  If Self.ShouldScanPath(Path, LowConfidence) = False Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  If Properties Is Nil Then
		    Return
		  End If
		  
		  Self.mSpawnPaths.Value(Path) = True
		  
		  Var SpawnedCreaturePaths As JSONMBS = Properties.Query("$.NPCSpawnEntries[*].NPCsToSpawn[*].AssetPathName")
		  Var ReplacedCreaturePaths As JSONMBS = Properties.Query("$.NPCSpawnEntries[*].NPCRandomSpawnClassWeights[*].FromClass.AssetPathName")
		  Var ReplacementCreaturePaths As JSONMBS = Properties.Query("$.NPCSpawnEntries[*].NPCRandomSpawnClassWeights[*].ToClasses[*].AssetPathName")
		  Var LimitedCreaturePaths As JSONMBS = Properties.Query("$.NPCSpawnLimits[*].NPCClass.AssetPathName")
		  Var PathLists() As JSONMBS = Array(SpawnedCreaturePaths, LimitedCreaturePaths, ReplacedCreaturePaths, ReplacementCreaturePaths)
		  
		  For Each PathList As JSONMBS In PathLists
		    For Idx As Integer = 0 To PathList.LastRowIndex
		      Var CreaturePath As String = Self.NormalizePath(PathList.ValueAt(Idx))
		      Self.ScanCreature(CreaturePath)
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanSpawnContainer(Path As String, Options As Integer, ParamArray AdditionalTags() As String)
		  Self.ScanSpawnContainer(Path, Options, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanSpawnContainer(Path As String, AdditionalTags() As String)
		  Self.ScanSpawnContainer(Path, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanSpawnContainer(Path As String, ParamArray AdditionalTags() As String)
		  Self.ScanSpawnContainer(Path, 0, AdditionalTags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanUnlock(Path As String)
		  Self.ScanUnlock(Path, 0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScanUnlock(Path As String, Options As Integer)
		  Var LowConfidence As Boolean = (Options And Self.UnlockOptionLowConfidence) <> 0
		  If Self.ShouldScanPath(Path, LowConfidence) = False Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  If Properties Is Nil Then
		    Return
		  End If
		  
		  Var ItemOptions As Integer
		  If LowConfidence Then
		    ItemOptions = ItemOptions Or Self.ItemOptionLowConfidence
		  End If
		  
		  Var UnlockString As String = Path.NthField(".", 2) + "_C"
		  Var RequiredLevel As Variant
		  Var RequiredPoints As Variant
		  If Properties.Lookup("bCanBeManuallyUnlocked", True).BooleanValue = True Then
		    RequiredPoints = Properties.Lookup("RequiredEngramPoints", 0).IntegerValue
		    RequiredLevel = Properties.Lookup("RequiredCharacterLevel", 1).IntegerValue
		  End If
		  
		  If Properties.HasChild("BluePrintEntry") And (Properties.Child("BluePrintEntry") Is Nil) = False And Properties.Child("BluePrintEntry").HasKey("ObjectPath") Then
		    Var ItemPath As String = Self.NormalizePath(Properties.Child("BluePrintEntry").Value("ObjectPath"))
		    If Self.mUnlockDetails.HasKey(ItemPath) = False Or LowConfidence = False Then
		      Self.mUnlockDetails.Value(ItemPath) = New Dictionary("UnlockString": UnlockString, "RequiredLevel": RequiredLevel, "RequiredPoints": RequiredPoints)
		    End If
		    Self.ScanItem(ItemPath, ItemOptions)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Settings() As ArkSA.ModDiscoverySettings
		  Return Self.mSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldScanPath(Path As String, LowConfidence As Boolean) As Boolean
		  If Self.mPathsScanned.HasKey(Path) Then
		    // If was previously scanned in low confidence mode, and we're not scanning in low confidence mode now, switch it away from low confidence.
		    If Self.mPathsScanned.Value(Path).BooleanValue = True And LowConfidence = False Then
		      Self.mPathsScanned.Value(Path) = False
		    End If
		    Return False
		  Else
		    Self.mPathsScanned.Value(Path) = LowConfidence
		    Return True
		  End If
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
		  Self.mThread.Priority = Thread.LowestPriority
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

	#tag Method, Flags = &h21
		Private Sub SyncCreature(Path As String)
		  Var ContentPackId As String = Self.ContentPackIdForPath(Path)
		  If ContentPackId = ArkSA.OfficialContentPackId Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  
		  Var ClassString As String = Path.NthField(".", 2)
		  Var CreatureName As String = Self.CleanupName(Properties.Lookup("DescriptiveName", "").StringValue)
		  If CreatureName.IsEmpty Then
		    CreatureName = ArkSA.LabelFromClassString(ClassString)
		  End If
		  
		  Var Pack As Beacon.ContentPack = Self.mContentPacks.Value(ContentPackId)
		  Var CreatureId As String = Self.CreateObjectId(Path, ContentPackId)
		  Var Creature As New ArkSA.MutableCreature(Path, CreatureId)
		  Creature.Availability = ArkSA.Maps.UniversalMask
		  Creature.ContentPackId = ContentPackId
		  Creature.ContentPackName = Pack.Name
		  Creature.Label = CreatureName
		  
		  If Properties.HasKey("DinoNameTag") And Properties.Value("DinoNameTag").IsNull = False And Properties.Value("DinoNameTag").StringValue.IsEmpty = False Then
		    Creature.NameTag = Properties.Value("DinoNameTag").StringValue
		  ElseIf Properties.HasKey("CustomTag") And Properties.Value("CustomTag").IsNull = False And Properties.Value("CustomTag").StringValue.IsEmpty = False Then
		    Creature.NameTag = Properties.Value("CustomTag").StringValue
		  End If
		  
		  Var CanBeTamed As Boolean = Properties.Lookup("bCanBeTamed", True).BooleanValue
		  Var CanHaveBaby As Boolean = Properties.Lookup("bCanHaveBaby", False).BooleanValue
		  If (CanBeTamed And CanHaveBaby And Self.ComputeBreedingStats(Properties, Creature)) = False Then
		    Creature.IncubationTime = 0
		    Creature.MatureTime = 0
		    Creature.MinMatingInterval = 0
		    Creature.MaxMatingInterval = 0
		  End If
		  
		  Var Results As JSONMBS = Properties.Query("$['X-Beacon-Children'][*][?(@.CraftingSpeedMultiplier)]")
		  Static AdditionalBaseValue() As Integer = Array(0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1)
		  If Results.Count = 1 Then
		    Var StatusComponent As JSONMBS = Results.Child(0)
		    Var StatInfos(11) As JSONMBS
		    StatInfos(0) = StatusComponent.Child("Health")
		    StatInfos(1) = StatusComponent.Child("Stamina")
		    StatInfos(2) = StatusComponent.Child("Torpidity")
		    StatInfos(3) = StatusComponent.Child("Oxygen")
		    StatInfos(4) = StatusComponent.Child("Food")
		    StatInfos(5) = StatusComponent.Child("Water")
		    StatInfos(6) = StatusComponent.Child("Temperature")
		    StatInfos(7) = StatusComponent.Child("Weight")
		    StatInfos(8) = StatusComponent.Child("MeleeDamageMultiplier")
		    StatInfos(9) = StatusComponent.Child("SpeedMultiplier")
		    StatInfos(10) = StatusComponent.Child("Fortitude")
		    StatInfos(11) = StatusComponent.Child("CraftingSpeedMultiplier")
		    
		    Var UsedStats As Integer = 0
		    Var UsesOxygenWild As Boolean = StatusComponent.Lookup("bCanSuffocate", True).BooleanValue
		    Var UsesOxygenTamed As Boolean = UsesOxygenWild Or StatusComponent.Lookup("bCanSuffocateIfTamed", False).BooleanValue
		    Var ForceOxygen As Boolean = StatusComponent.Lookup("bForceGainOxygen", False).BooleanValue
		    Var DoesntUseOxygen As Boolean = Not (UsesOxygenTamed Or ForceOxygen)
		    Var IsFlyer As Boolean = Properties.Lookup("bIsFlyerDino", False).BooleanValue
		    
		    For StatIndex As Integer = 0 To StatInfos.LastIndex
		      Var StatInfo As JSONMBS = StatInfos(StatIndex)
		      Var CanLevel As Boolean = StatIndex = 2 Or StatInfo.Value("CanLevelUpValue").BooleanValue
		      Var DontUse As Boolean = StatInfo.Value("DontUseValue").BooleanValue
		      If DontUse = False And Not (StatIndex = 3 And DoesntUseOxygen) Then
		        UsedStats = UsedStats Or Bitwise.ShiftLeft(1, StatIndex)
		      End If
		      If DontUse And Not CanLevel Then
		        Continue
		      End If
		      
		      Var WildMultiplier As Integer = If(CanLevel, 1, 0)
		      Var DomesticMultiplier As Integer = If(StatIndex = 9 And IsFlyer, 1, WildMultiplier)
		      Var ExtraTamedHealthMultiplier As Double = 1.0
		      If StatIndex = 0 Then
		        ExtraTamedHealthMultiplier = StatusComponent.Lookup("ExtraTamedHealthMultiplier", 1.35)
		      End If
		      
		      Var WildPerLevel As Double = StatInfo.Value("WildPerLevel")
		      If StatIndex = 2 Then
		        WildPerLevel = StatusComponent.Lookup("TheMaxTorporIncreasePerBaseLevel", 0.06)
		      End If
		      
		      Var Stat As ArkSA.Stat = ArkSA.Stats.WithIndex(StatIndex)
		      Var BaseValue As Double = StatInfo.Value("BaseValue") + AdditionalBaseValue(StatIndex)
		      Var PerLevelWildMultiplier As Double = WildPerLevel * WildMultiplier
		      Var PerLevelTamedMultiplier As Double = StatInfo.Value("TamedPerLevel").DoubleValue * ExtraTamedHealthMultiplier * DomesticMultiplier
		      Var AddMultiplier As Double = StatInfo.Value("TamingReward")
		      Var AffinityMultiplier As Double = StatInfo.Value("EffectivenessReward")
		      Creature.AddStatValue(New ArkSA.CreatureStatValue(Stat, BaseValue, PerLevelWildMultiplier, PerLevelTamedMultiplier, AddMultiplier, AffinityMultiplier))
		    Next
		    Creature.StatsMask = UsedStats
		  Else
		    Creature.StatsMask = 0
		  End If
		  
		  If Self.mBossPaths.HasKey(Path) Then
		    Creature.AddTag("boss")
		    
		    If ClassString.Contains("Easy") Or ClassString.Contains("Gamma") Then
		      Creature.Label = Creature.Label + " Easy"
		    ElseIf ClassString.Contains("Medium") Or ClassString.Contains("Beta") Then
		      Creature.Label = Creature.Label + " Medium"
		    ElseIf ClassString.Contains("Hard") Or ClassString.Contains("Alpha") Then
		      Creature.Label = Creature.Label + " Hard"
		    End If
		  End If
		  
		  If Self.mTags.HasKey(Path) Then
		    Var Tags() As String = Self.mTags.Value(Path)
		    Creature.AddTags(Tags)
		  End If
		  
		  Creature.LastUpdate = Self.mTimestamp
		  Self.AddBlueprint(Creature, Self.mPathsScanned.Lookup(Path, False).BooleanValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncItem(Path As String)
		  Var ContentPackId As String = Self.ContentPackIdForPath(Path)
		  If ContentPackId = ArkSA.OfficialContentPackId Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  
		  Var ItemName As String = Self.CleanupName(Properties.Lookup("DescriptiveNameBase", "").StringValue)
		  If ItemName.IsEmpty Then
		    ItemName = ArkSA.LabelFromClassString(Path.NthField(".", 2))
		  End If
		  
		  Var Pack As Beacon.ContentPack = Self.mContentPacks.Value(ContentPackId)
		  Var ItemId As String = Self.CreateObjectId(Path, ContentPackId)
		  Var Item As New ArkSA.MutableEngram(Path, ItemId)
		  Item.Availability = ArkSA.Maps.UniversalMask
		  Item.ContentPackId = ContentPackId
		  Item.ContentPackName = Pack.Name
		  Item.StackSize = Properties.Lookup("MaxItemQuantity", 1).IntegerValue
		  Item.Label = ItemName
		  
		  If Self.mUnlockDetails.HasKey(Path) Then
		    Var UnlockDetails As Dictionary = Self.mUnlockDetails.Value(Path)
		    Item.EntryString = UnlockDetails.Value("UnlockString")
		    Item.RequiredPlayerLevel = NullableDouble.FromVariant(UnlockDetails.Value("RequiredLevel"))
		    Item.RequiredUnlockPoints = NullableDouble.FromVariant(UnlockDetails.Value("RequiredPoints"))
		  End If
		  
		  Var Ingredients() As ArkSA.CraftingCostIngredient
		  If Properties.HasChild("BaseCraftingResourceRequirements") Then
		    Var BaseCraftingResourceRequirements As JSONMBS = Properties.Child("BaseCraftingResourceRequirements")
		    If (BaseCraftingResourceRequirements Is Nil) = False And BaseCraftingResourceRequirements.IsNull = False And BaseCraftingResourceRequirements.IsArray = True Then
		      For Idx As Integer = 0 To BaseCraftingResourceRequirements.LastRowIndex
		        Var Requirement As JSONMBS = BaseCraftingResourceRequirements.ChildAt(Idx)
		        If Requirement Is Nil Or Requirement.IsNull Or Requirement.HasChild("ResourceItemType") = False Or Requirement.Child("ResourceItemType").IsNull Then
		          Continue
		        End If
		        
		        Var Quantity As Integer = Requirement.Value("BaseResourceRequirement")
		        If Quantity <= 0 Then
		          Continue
		        End If
		        Var RequireExact As Boolean = Requirement.Value("bCraftingRequireExactResourceType")
		        Var IngredientPath As String = Self.NormalizePath(Requirement.Child("ResourceItemType").Value("ObjectPath"))
		        Var IngredientId As String = Self.CreateObjectId(IngredientPath)
		        Var Ingredient As New ArkSA.CraftingCostIngredient(New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindEngram, IngredientId, IngredientPath), Quantity, RequireExact)
		        Ingredients.Add(Ingredient)
		      Next
		    End If
		  End If
		  Item.Recipe = Ingredients
		  
		  If Properties.HasKey("GenericQuality") Then
		    Var StatInfos(7) As JSONMBS
		    StatInfos(0) = Properties.Child("GenericQuality")
		    StatInfos(1) = Properties.Child("Armor")
		    StatInfos(2) = Properties.Child("MaxDurability")
		    StatInfos(3) = Properties.Child("WeaponDamagePercent")
		    StatInfos(4) = Properties.Child("WeaponClipAmmo")
		    StatInfos(5) = Properties.Child("HypothermalInsulation")
		    StatInfos(6) = Properties.Child("Weight")
		    StatInfos(7) = Properties.Child("HyperthermalInsulation")
		    
		    For StatIndex As Integer = 0 To StatInfos.LastIndex
		      Var StatInfo As JSONMBS = StatInfos(StatIndex)
		      If StatInfo.Value("Used").BooleanValue = False Then
		        Continue
		      End If
		      
		      Var RandomizerRangeOverride As Double = StatInfo.Value("RandomizerRangeOverride")
		      Var RandomizerRangeMultiplier As Double = StatInfo.Value("RandomizerRangeMultiplier")
		      Var StateModifierScale As Double = StatInfo.Value("StateModifierScale")
		      Var RatingValueMultiplier As Double = StatInfo.Value("RatingValueMultiplier")
		      Var InitialValueConstant As Double = StatInfo.Value("InitialValueConstant").DoubleValue + If(StatInfo.Value("DisplayAsPercent").BooleanValue, 100.0, 0.0)
		      Var Stat As New ArkSA.EngramStat(StatIndex, RandomizerRangeOverride, RandomizerRangeMultiplier, StateModifierScale, RatingValueMultiplier, InitialValueConstant)
		      Item.Stat(StatIndex) = Stat
		    Next
		  End If
		  
		  If Properties.Lookup("bTekItem", False).BooleanValue Then
		    Item.AddTag("tek")
		  End If
		  
		  If Properties.Lookup("bCanBeBlueprint", true).BooleanValue Then
		    Item.AddTag("blueprintable")
		  End If
		  
		  If Properties.Lookup("bIsEgg", False).BooleanValue Then
		    Item.AddTag("egg")
		  End If
		  
		  If Self.mTags.HasKey(Path) Then
		    Var Tags() As String = Self.mTags.Value(Path)
		    Item.AddTags(Tags)
		  End If
		  
		  Item.LastUpdate = Self.mTimestamp
		  Self.AddBlueprint(Item, Self.mPathsScanned.Lookup(Path, False).BooleanValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncLootDrop(Path As String, Type As LootDropType)
		  Var ContentPackId As String = Self.ContentPackIdForPath(Path)
		  If ContentPackId = ArkSA.OfficialContentPackId Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  
		  Var Pack As Beacon.ContentPack = Self.mContentPacks.Value(ContentPackId)
		  Var DropId As String = Self.CreateObjectId(Path, ContentPackId)
		  Var Drop As New ArkSA.MutableLootContainer(Path, DropId)
		  Var ClassString As String = Path.NthField(".", 2)
		  
		  If Self.mInventoryNames.HasKey(Path) Then
		    Var Names() As String = Self.mInventoryNames.Value(Path)
		    Drop.Label = Language.EnglishOxfordList(Names, "and", 2)
		  Else
		    Var DescriptiveName As String = Properties.Lookup("DescriptiveName", "")
		    Select Case DescriptiveName
		    Case "", "Loot Crate", "Supply Crate", "Corpse", "Buried Treasure Cache", "Buried Treasure", "Artifact", "Boss Loot", "Boss Loot Gamma", "Boss Loot Beta", "Boss Loot Alpha"
		      Drop.Label = ArkSA.LabelFromClassString(ClassString)
		    Else
		      // Allows mod authors to set good names... but they won't
		      #if DebugBuild
		        System.DebugLog("Found a loot drop named " + DescriptiveName)
		      #endif
		      Drop.Label = DescriptiveName
		    End Select
		  End If
		  
		  Var MinQualityMultiplier As Double = Properties.Lookup("MinQualityMultiplier", 1.0)
		  Var MaxQualityMultiplier As Double = Properties.Lookup("MaxQualityMultiplier", 1.0)
		  Drop.Multipliers = New Beacon.Range(MinQualityMultiplier, MaxQualityMultiplier)
		  
		  Drop.MinItemSets = Properties.Lookup("MinItemSets", 1)
		  Drop.MaxItemSets = Properties.Lookup("MaxItemSets", 1)
		  Drop.PreventDuplicates = Properties.Lookup("bSetsRandomWithoutReplacement", False)
		  Drop.ContentPackId = ContentPackId
		  Drop.ContentPackName = Pack.Name
		  Drop.UIColor = &cFFFFFF00
		  
		  Select Case Type
		  Case LootDropType.Regular
		    Var RequiredLevel As Integer = Properties.Lookup("RequiredLevelToAccess", 3).IntegerValue
		    Var IsBonus As Boolean = ClassString.Contains("Double")
		    If RequiredLevel >= 55 Then
		      Drop.UIColor = &cFFBABA00
		      Drop.AddTag("red")
		      Drop.SortValue = 11
		    ElseIf RequiredLevel >= 40 Then
		      Drop.UIColor = &cFFF02A00
		      Drop.AddTag("yellow")
		      Drop.SortValue = 9
		    ElseIf RequiredLevel >= 35 Then
		      Drop.UIColor = &cE6BAFF00
		      Drop.AddTag("purple")
		      Drop.SortValue = 7
		    ElseIf RequiredLevel >= 25 Then
		      Drop.UIColor = &c88C8FF00
		      Drop.AddTag("blue")
		      Drop.SortValue = 5
		    ElseIf RequiredLevel >= 10 Then
		      Drop.UIColor = &c00FF0000
		      Drop.AddTag("green")
		      Drop.SortValue = 3
		    Else
		      Drop.AddTag("white")
		      Drop.SortValue = 1
		    End If
		    If IsBonus Then
		      Drop.SortValue = Drop.SortValue + 1
		    End If
		    
		    If ClassString.Contains("Cave") Then
		      Drop.IconID = If(IsBonus, "d66cd81d-a51d-574a-9b69-826f3e75a4b2", "fccfbd07-424c-5902-b5bb-9c6165fe828f")
		      Drop.AddTag("crate")
		    ElseIf ClassString.Contains("Artifact") Then
		      Drop.IconID = If(IsBonus, "d66cd81d-a51d-574a-9b69-826f3e75a4b2", "fccfbd07-424c-5902-b5bb-9c6165fe828f")
		      Drop.AddTag("crate")
		      Drop.AddTag("artifact")
		    ElseIf ClassString.Contains("Ocean") Then
		      Drop.IconID = If(IsBonus, "d66cd81d-a51d-574a-9b69-826f3e75a4b2", "fccfbd07-424c-5902-b5bb-9c6165fe828f")
		      Drop.AddTag("crate")
		      Drop.AddTag("rare")
		    ElseIf ClassString.Contains("Beaver") Then
		      Drop.IconID = "53f23d4d-658d-511b-bc53-f0c987d288bc"
		      Drop.AddTag("beaver")
		    Else
		      Drop.AddTag("drop")
		      Drop.IconID = If(IsBonus, "ca8cdf82-cbf8-5531-808a-fb91d413505d", "d5bb71e5-fba5-51f3-b120-f1abadc1fa6e")
		    End If
		  Case LootDropType.Boss
		    Drop.IconID = "b7548942-53be-5046-892a-74816e43a938"
		    Drop.SortValue = 150
		    Drop.AddTag("boss")
		    
		    If ClassString.Contains("Easy") Or ClassString.Contains("Gamma") Then
		      Drop.UIColor = &c00FF0000
		      Drop.AddTag("easy")
		    ElseIf ClassString.Contains("Medium") Or ClassString.Contains("Beta") Then
		      Drop.UIColor = &cFFF02A00
		      Drop.AddTag("medium")
		      Drop.SortValue = Drop.SortValue + 1
		    ElseIf ClassString.Contains("Hard") Or ClassString.Contains("Alpha") Then
		      Drop.UIColor = &cFFBABA00
		      Drop.AddTag("hard")
		      Drop.SortValue = Drop.SortValue + 2
		    End If
		  Case LootDropType.Dino
		    Drop.IconID = "b7548942-53be-5046-892a-74816e43a938"
		    Drop.SortValue = 200
		    Drop.Experimental = True
		    Drop.AddTag("dino")
		    
		    If ClassString.Contains("Mega") Then
		      Drop.UIColor = &cFFBABA00
		    End If
		  End Select
		  
		  Var ItemSetsList As JSONMBS = Properties.Child("ItemSets")
		  Var ItemSets() As JSONMBS
		  Var Labels() As String
		  Var ItemSetsByLabel As New Dictionary
		  For Idx As Integer = 0 To ItemSetsList.LastRowIndex
		    Var ItemSet As JSONMBS = ItemSetsList.ChildAt(Idx)
		    If ItemSet.HasKey("ItemSetOverride") And ItemSet.Value("ItemSetOverride").IsNull = False Then
		      Var OverridePath As String = Self.NormalizePath(ItemSet.Child("ItemSetOverride").Value("ObjectPath").StringValue)
		      Var OverrideProperties As JSONMBS = Self.PropertiesForPath(OverridePath)
		      If OverrideProperties Is Nil Then
		        Continue
		      End If
		      Var OriginalItemSet As JSONMBS = ItemSet
		      ItemSet = New JSONMBS(OverrideProperties.Child("ItemSet")) // Make sure to use a clone or you update the override item set
		      
		      Var Keys() As String  = OriginalItemSet.Keys
		      For Each Key As String In Keys
		        If ItemSet.HasKey(Key) = False Then
		          ItemSet.Value(Key) = OriginalItemSet.Value(Key)
		        End If
		      Next
		    End If
		    
		    ItemSets.Add(ItemSet)
		    
		    Var Label As String = ItemSet.Lookup("SetName", "").StringValue.Trim
		    If Label.IsEmpty Then
		      Label = "Unnamed Item Set"
		    End If
		    
		    Var Siblings() As JSONMBS
		    If ItemSetsByLabel.HasKey(Label) Then
		      Siblings = ItemSetsByLabel.Value(Label)
		    Else
		      ItemSetsByLabel.Value(Label) = Siblings
		    End If
		    Siblings.Add(ItemSet)
		    
		    If Labels.IndexOf(Label) = -1 Then
		      Labels.Add(Label)
		    End If
		  Next
		  
		  For Each Label As String In Labels
		    Var Siblings() As JSONMBS = ItemSetsByLabel.Value(Label)
		    If Siblings.Count = 0 Then
		      Continue
		    ElseIf Siblings.Count = 1 Then
		      Siblings(0).Value("SetName") = Label
		      Continue
		    End If
		    
		    For Idx As Integer = 0 To Siblings.LastIndex
		      Var Suffix As Integer = Idx + 1
		      Siblings(Idx).Value("SetName") = Label + " " + Suffix.ToString(Locale.Raw, "0")
		    Next
		  Next
		  
		  For Idx As Integer = 0 To ItemSets.LastIndex
		    Var ItemSetId As String = Beacon.UUID.v5(DropId + ":" + Idx.ToString(Locale.Raw, "0"))
		    Self.SyncLootItemSet(Drop, MinQualityMultiplier, MaxQualityMultiplier, ItemSetId, ItemSets(Idx))
		  Next
		  
		  If Self.mTags.HasKey(Path) Then
		    Var Tags() As String = Self.mTags.Value(Path)
		    Drop.AddTags(Tags)
		  End If
		  
		  Drop.LastUpdate = Self.mTimestamp
		  Self.AddBlueprint(Drop, Self.mPathsScanned.Lookup(Path, False).BooleanValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncLootItemSet(Drop As ArkSA.MutableLootContainer, MinQualityMultiplier As Double, MaxQualityMultiplier As Double, ItemSetId As String, Source As JSONMBS)
		  If Source.HasKey("ItemEntries") = False Or Source.Value("ItemEntries").IsNull Then
		    Return
		  End If
		  
		  Var ItemSet As New ArkSA.MutableLootItemSet
		  ItemSet.UUID = ItemSetId
		  ItemSet.Label = Source.Value("SetName").StringValue
		  ItemSet.MinNumItems = Source.Value("MinNumItems").DoubleValue
		  ItemSet.MaxNumItems = Source.Value("MaxNumItems").DoubleValue
		  ItemSet.RawWeight = Min(Source.Value("SetWeight").DoubleValue * 500, 9999999999.999999)
		  ItemSet.ItemsRandomWithoutReplacement = Source.Value("bItemsRandomWithoutReplacement").BooleanValue
		  
		  Var Entries As JSONMBS = Source.Child("ItemEntries")
		  For Idx As Integer = 0 To Entries.LastRowIndex
		    Var EntryId As String = Beacon.UUID.v5(ItemSetId + ":" + Idx.ToString(Locale.Raw, "0"))
		    Self.SyncLootItemSetEntry(ItemSet, MinQualityMultiplier, MaxQualityMultiplier, EntryId, Entries.ChildAt(Idx))
		  Next
		  
		  If ItemSet.Count > 0 Then
		    Drop.Add(ItemSet)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncLootItemSetEntry(ItemSet As ArkSA.MutableLootItemSet, MinQualityMultiplier As Double, MaxQualityMultiplier As Double, EntryId As String, Source As JSONMBS)
		  If Source.HasKey("Items") = False Or Source.Value("Items").IsNull Then
		    Return
		  End If
		  
		  Var Options As JSONMBS = Source.Child("Items")
		  If Options.Count = 0 Then
		    Return
		  End If
		  
		  Var BaseArbitraryQuality As Double = ArkSA.Configs.Difficulty.BaseArbitraryQuality(5.0)
		  Var Entry As New ArkSA.MutableLootItemSetEntry
		  Entry.EntryId = EntryId
		  Entry.MinQuantity = Source.Value("MinQuantity")
		  Entry.MaxQuantity = Source.Value("MaxQuantity")
		  Entry.MinQuality = ArkSA.Qualities.ForValue(Source.Value("MinQuality").DoubleValue, MinQualityMultiplier, BaseArbitraryQuality)
		  Entry.MaxQuality = ArkSA.Qualities.ForValue(Source.Value("MaxQuality").DoubleValue, MaxQualityMultiplier, BaseArbitraryQuality)
		  Entry.ChanceToBeBlueprint = If(Source.Value("bForceBlueprint").BooleanValue, 1.0, Source.Value("ChanceToBeBlueprintOverride").DoubleValue)
		  Entry.SingleItemQuantity = Source.Lookup("bApplyQuantityToSingleItem", False).BooleanValue
		  Entry.PreventGrinding = Source.Lookup("bForcePreventGrinding", False).BooleanValue
		  Entry.StatClampMultiplier = Source.Lookup("ItemStatClampsMultiplier", 1.0).DoubleValue
		  
		  Var Weights As JSONMBS = Source.Child("ItemsWeights")
		  For Idx As Integer = 0 To Options.LastRowIndex
		    Var Option As JSONMBS = Options.ChildAt(Idx)
		    If Option Is Nil Or Option.IsNull Then
		      Continue
		    End If
		    
		    Var OptionId As String = Beacon.UUID.v5(EntryId + ":" + Idx.ToString(Locale.Raw, "0"))
		    Var WeightIdx As Integer = Min(Idx, Weights.LastRowIndex)
		    Var Weight As Double = If(WeightIdx >= 0, Weights.ValueAt(WeightIdx).DoubleValue * 100, 50)
		    Var EngramPath As String = Self.NormalizePath(Options.ChildAt(Idx).Value("ObjectPath"))
		    If EngramPath.IsEmpty Then
		      Continue
		    End If
		    Var EngramId As String = Self.CreateObjectId(EngramPath)
		    
		    Entry.Add(New ArkSA.LootItemSetEntryOption(New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindEngram, EngramId, EngramPath), Weight, OptionId))
		  Next
		  
		  If Entry.Count > 0 Then
		    ItemSet.Add(Entry)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncSpawnContainer(Path As String)
		  Var ContentPackId As String = Self.ContentPackIdForPath(Path)
		  If ContentPackId = ArkSA.OfficialContentPackId Then
		    Return
		  End If
		  
		  Var Properties As JSONMBS = Self.PropertiesForPath(Path)
		  
		  Var Pack As Beacon.ContentPack = Self.mContentPacks.Value(ContentPackId)
		  Var SpawnContainerId As String = Self.CreateObjectId(Path, ContentPackId)
		  Var SpawnContainer As New ArkSA.MutableSpawnPoint(Path, SpawnContainerId)
		  SpawnContainer.ContentPackId = ContentPackId
		  SpawnContainer.ContentPackName = Pack.Name
		  
		  Var ClassString As String = Path.NthField(".", 2)
		  SpawnContainer.Label = ArkSA.LabelFromClassString(ClassString)
		  
		  Var Limits As JSONMBS
		  If Properties.HasChild("NPCSpawnLimits") Then
		    Limits = Properties.Child("NPCSpawnLimits")
		  End If
		  If (Limits Is Nil) = False Then
		    For Idx As Integer = 0 To Limits.LastRowIndex
		      Var Limit As JSONMBS = Limits.ChildAt(Idx)
		      Var ClassInfo As JSONMBS = Limit.Child("NPCClass")
		      If ClassInfo Is Nil Or ClassInfo.IsNull Then
		        Continue
		      End If
		      Var CreaturePath As String = Self.NormalizePath(ClassInfo.Value("AssetPathName"))
		      Var CreatureId As String = Self.CreateObjectId(CreaturePath)
		      Var CreatureRef As New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, CreatureId, CreaturePath)
		      SpawnContainer.Limit(CreatureRef) = Limit.Value("MaxPercentageOfDesiredNumToAllow")
		    Next
		  End If
		  
		  Var SpawnSetsList As JSONMBS
		  If Properties.HasChild("NPCSpawnEntries") Then
		    SpawnSetsList = Properties.Child("NPCSpawnEntries")
		  End If
		  If (SpawnSetsList Is Nil) = False Then
		    Var SpawnSets() As JSONMBS
		    Var Labels() As String
		    Var SpawnSetsByLabel As New Dictionary
		    
		    For Idx As Integer = 0 To SpawnSetsList.LastRowIndex
		      Var SpawnSet As JSONMBS = SpawnSetsList.ChildAt(Idx)
		      SpawnSets.Add(SpawnSet)
		      
		      Var Label As String = SpawnSet.Value("AnEntryName").StringValue.Trim
		      If Label.IsEmpty Then
		        Label = "Unnamed Spawn Set"
		      End If
		      
		      Var Siblings() As JSONMBS
		      If SpawnSetsByLabel.HasKey(Label) Then
		        Siblings = SpawnSetsByLabel.Value(Label)
		      Else
		        SpawnSetsByLabel.Value(Label) = Siblings
		      End If
		      Siblings.Add(SpawnSet)
		      
		      If Labels.IndexOf(Label) = -1 Then
		        Labels.Add(Label)
		      End If
		    Next
		    
		    For Each Label As String In Labels
		      Var Siblings() As JSONMBS = SpawnSetsByLabel.Value(Label)
		      If Siblings.Count = 0 Then
		        Continue
		      ElseIf Siblings.Count = 1 Then
		        Siblings(0).Value("AnEntryName") = Label
		        Continue
		      End If
		      
		      For Idx As Integer = 0 To Siblings.LastIndex
		        Var Suffix As Integer = Idx + 1
		        Siblings(Idx).Value("AnEntryName") = Label + " " + Suffix.ToString(Locale.Raw, "0")
		      Next
		    Next
		    
		    For Idx As Integer = 0 To SpawnSets.LastIndex
		      Var SpawnSetId As String = Beacon.UUID.v5(SpawnContainerId + ":" + Idx.ToString(Locale.Raw, "0"))
		      Self.SyncSpawnSet(SpawnContainer, SpawnSetId, SpawnSets(Idx))
		    Next
		  End If
		  
		  If Self.mTags.HasKey(Path) Then
		    Var Tags() As String = Self.mTags.Value(Path)
		    SpawnContainer.AddTags(Tags)
		  End If
		  
		  SpawnContainer.LastUpdate = Self.mTimestamp
		  Self.AddBlueprint(SpawnContainer, Self.mPathsScanned.Lookup(Path, False).BooleanValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncSpawnSet(SpawnContainer As ArkSA.MutableSpawnPoint, SpawnSetId As String, Source As JSONMBS)
		  Var SpawnSet As New ArkSA.MutableSpawnPointSet
		  SpawnSet.SetId = SpawnSetId
		  SpawnSet.Label = Source.Value("AnEntryName")
		  SpawnSet.RawWeight = Source.Value("EntryWeight")
		  SpawnSet.MinDistanceFromPlayersMultiplier = NullableDouble.FromVariant(Source.Value("SpawnMinDistanceFromPlayersMultiplier"), True)
		  SpawnSet.MinDistanceFromStructuresMultiplier = NullableDouble.FromVariant(Source.Value("SpawnMinDistanceFromStructuresMultiplier"), True)
		  SpawnSet.MinDistanceFromTamedDinosMultiplier = NullableDouble.FromVariant(Source.Value("SpawnMinDistanceFromTamedDinosMultiplier"), True)
		  SpawnSet.SpreadRadius = NullableDouble.FromVariant(Source.Value("ManualSpawnPointSpreadRadius"), True)
		  SpawnSet.WaterOnlyMinimumHeight = NullableDouble.FromVariant(Source.Value("WaterOnlySpawnMinimumWaterHeight"), True)
		  SpawnSet.LevelOffsetBeforeMultiplier = Source.Lookup("bAddLevelOffsetBeforeMultiplier", False).BooleanValue
		  SpawnSet.GroupOffset = Beacon.Point3d.FromSaveData(Source.Child("GroupSpawnOffset"))
		  
		  Var NPCsToSpawn As JSONMBS = Source.Child("NPCsToSpawn")
		  Var NPCsSpawnOffsets As JSONMBS = Source.Child("NPCsSpawnOffsets")
		  Var NPCsToSpawnPercentageChance As JSONMBS = Source.Child("NPCsToSpawnPercentageChance")
		  Var NPCMinLevelOffset As JSONMBS = Source.Child("NPCMinLevelOffset")
		  Var NPCMaxLevelOffset As JSONMBS = Source.Child("NPCMaxLevelOffset")
		  Var NPCMinLevelMultiplier As JSONMBS = Source.Child("NPCMinLevelMultiplier")
		  Var NPCMaxLevelMultiplier As JSONMBS = Source.Child("NPCMaxLevelMultiplier")
		  Var NPCOverrideLevel As JSONMBS = Source.Child("NPCOverrideLevel")
		  Var NPCDifficultyLevelRanges As JSONMBS = Source.Child("NPCDifficultyLevelRanges")
		  
		  For Idx As Integer = 0 To NPCsToSpawn.LastRowIndex
		    Var SpawnObj As JSONMBS = NPCsToSpawn.ChildAt(Idx)
		    Var CreaturePath As String = Self.NormalizePath(SpawnObj.Value("AssetPathName").StringValue)
		    Var CreatureId As String = Self.CreateObjectId(CreaturePath)
		    Var CreatureRef As New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, CreatureId, CreaturePath)
		    
		    Var Entry As New ArkSA.MutableSpawnPointSetEntry(CreatureRef)
		    Entry.EntryId = Beacon.UUID.v5(SpawnSetId + ":" + Idx.ToString(Locale.Raw, "0"))
		    If NPCsToSpawnPercentageChance.LastRowIndex >= Idx Then
		      Entry.SpawnChance = NPCsToSpawnPercentageChance.ValueAt(Idx).DoubleValue
		    Else
		      Entry.SpawnChance = Nil
		    End If
		    If NPCsSpawnOffsets.LastRowIndex >= Idx Then
		      Entry.Offset = Beacon.Point3D.FromSaveData(NPCsSpawnOffsets.ChildAt(Idx))
		    Else
		      Entry.Offset = Nil
		    End If
		    If NPCMinLevelOffset.LastRowIndex >= Idx And NPCMaxLevelOffset.LastRowIndex >= Idx Then
		      Entry.MinLevelOffset = NPCMinLevelOffset.ValueAt(Idx).DoubleValue
		      Entry.MaxLevelOffset = NPCMaxLevelOffset.ValueAt(Idx).DoubleValue
		    Else
		      Entry.MinLevelOffset = Nil
		      Entry.MaxLevelOffset = Nil
		    End If
		    If NPCMinLevelMultiplier.LastRowIndex >= Idx ANd NPCMaxLevelMultiplier.LastRowIndex >= Idx Then
		      Entry.MinLevelMultiplier = NPCMinLevelMultiplier.ValueAt(Idx).DoubleValue
		      Entry.MaxLevelMultiplier = NPCMaxLevelMultiplier.ValueAt(Idx).DoubleValue
		    Else
		      Entry.MinLevelMultiplier = Nil
		      Entry.MaxLevelMultiplier = Nil
		    End If
		    If NPCOverrideLevel.LastRowIndex >= Idx Then
		      Entry.LevelOverride = NPCOverrideLevel.ValueAt(Idx).DoubleValue
		    Else
		      Entry.LevelOverride = Nil
		    End If
		    
		    If NPCDifficultyLevelRanges.LastRowIndex >= Idx Then
		      Var LevelRange As JSONMBS = NPCDifficultyLevelRanges.ChildAt(Idx)
		      Var MinLevels As JSONMBS = LevelRange.Child("EnemyLevelsMin")
		      Var MaxLevels As JSONMBS = LevelRange.Child("EnemyLevelsMax")
		      Var Difficulties As JSONMBS = LevelRange.Child("GameDifficulties")
		      Var LevelBound As Integer = Min(MinLevels.LastRowIndex, MaxLevels.LastRowIndex, Difficulties.LastRowIndex)
		      For LevelIdx As Integer = 0 To LevelBound
		        Var MinLevel As Double = MinLevels.ValueAt(LevelIdx).DoubleValue
		        Var MaxLevel As Double = MaxLevels.ValueAt(LevelIdx).DoubleValue
		        Var Difficulty As Double = Difficulties.ValueAt(LevelIdx).DoubleValue
		        Entry.Append(New ArkSA.SpawnPointLevel(MinLevel, MaxLevel, Difficulty))
		      Next
		    End If
		    
		    SpawnSet.Append(Entry)
		  Next
		  
		  Var NPCRandomSpawnClassWeights As JSONMBS = Source.Child("NPCRandomSpawnClassWeights")
		  For Idx As Integer = 0 To NPCRandomSpawnClassWeights.LastRowIndex
		    Var NPCRandomSpawnClassWeight As JSONMBS = NPCRandomSpawnClassWeights.ChildAt(Idx)
		    Var FromCreaturePath As String = Self.NormalizePath(NPCRandomSpawnClassWeight.Child("FromClass").Value("AssetPathName"))
		    Var FromCreatureId As String = Self.CreateObjectId(FromCreaturePath)
		    Var FromCreatureRef As New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, FromCreatureId, FromCreaturePath)
		    Var ToClasses As JSONMBS = NPCRandomSpawnClassWeight.Child("ToClasses")
		    Var Weights As JSONMBS = NPCRandomSpawnClassWeight.Child("Weights")
		    For ReplacementIdx As Integer = 0 To ToClasses.LastRowIndex
		      Var ToCreaturePath As String = Self.NormalizePath(ToClasses.ChildAt(ReplacementIdx).Value("AssetPathName"))
		      Var ToCreatureId As String = Self.CreateObjectId(ToCreaturePath)
		      Var ToCreatureRef As New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, ToCreatureId, ToCreaturePath)
		      Var Weight As Double = Weights.ValueAt(Min(ReplacementIdx, Weights.LastRowIndex))
		      
		      SpawnSet.CreatureReplacementWeight(FromCreatureRef, ToCreatureRef) = Weight
		    Next
		  Next
		  
		  SpawnContainer.AddSet(SpawnSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TagsForPath(Path As String) As String()
		  Var Tags() As String
		  If Self.mTags.HasKey(Path) Then
		    Tags = Self.mTags.Value(Path)
		  End If
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WasSuccessful() As Boolean
		  Return Self.mSuccess
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ContentPackDiscovered(ContentPack As Beacon.ContentPack, ConfirmedBlueprints() As ArkSA.Blueprint, UnconfirmedBlueprints() As ArkSA.Blueprint)
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
		Private mBossPaths As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackIdsByPackage As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreaturePaths As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFoundBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInventoryNames As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mItemPaths As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootPaths As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLowConfidenceBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPathsScanned As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPropertiesCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRoot As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScriptedObjectPaths As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettings As ArkSA.ModDiscoverySettings
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnPaths As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuccess As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTags As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimestamp As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUnlockDetails As Dictionary
	#tag EndProperty


	#tag Constant, Name = CreatureOptionIsBoss, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CreatureOptionLowConfidence, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DropOptionLowConfidence, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ItemOptionLowConfidence, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ItemOptionNoSync, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SpawnOptionLowConfidence, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UnlockOptionLowConfidence, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


	#tag Enum, Name = LootDropType, Flags = &h21
		Regular
		  Dino
		Boss
	#tag EndEnum


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
