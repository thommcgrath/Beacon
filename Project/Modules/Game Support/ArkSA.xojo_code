#tag Module
Protected Module ArkSA
	#tag Method, Flags = &h1
		Protected Sub ActivateBlueprintProvider(Provider As ArkSA.BlueprintProvider)
		  If Provider Is Nil Then
		    Return
		  End If
		  
		  If mBlueprintProviders Is Nil Then
		    mBlueprintProviders = New Dictionary
		  End If
		  
		  If mBlueprintProviders.HasKey(Provider.BlueprintProviderId) And (WeakRef(mBlueprintProviders.Value(Provider.BlueprintProviderId)).Value Is Nil) = False Then
		    // Provider is already active
		    Return
		  End If
		  
		  mBlueprintProviders.Value(Provider.BlueprintProviderId) = New WeakRef(Provider)
		  
		  #if DebugBuild
		    Var ActiveProviders() As ArkSA.BlueprintProvider = ActiveBlueprintProviders
		    Var ProviderIds() As String
		    For Each ActiveProvider As ArkSA.BlueprintProvider In ActiveProviders
		      ProviderIds.Add(ActiveProvider.BlueprintProviderId)
		    Next
		    System.DebugLog("Active providers is now " + String.FromArray(ProviderIds, ", "))
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ActiveBlueprintProviders() As ArkSA.BlueprintProvider()
		  Var Providers(0) As ArkSA.BlueprintProvider
		  Providers(0) = ArkSA.DataSource.Pool.Get(False)
		  
		  If (mBlueprintProviders Is Nil) = False Then
		    Var ProviderIds() As Variant = mBlueprintProviders.Keys
		    For Each ProviderId As Variant In ProviderIds
		      Var Ref As WeakRef = mBlueprintProviders.Value(ProviderId)
		      If Ref.Value Is Nil Then
		        mBlueprintProviders.Remove(ProviderId)
		        Continue
		      End If
		      
		      Providers.Add(ArkSA.BlueprintProvider(Ref.Value))
		    Next
		  End If
		  
		  Return Providers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTag(Extends Blueprint As ArkSA.MutableBlueprint, ParamArray TagsToAdd() As String)
		  Blueprint.AddTags(TagsToAdd)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTags(Extends Blueprint As ArkSA.MutableBlueprint, TagsToAdd() As String)
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToAdd.LastIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToAdd(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    If Tags.IndexOf(Tag) <> -1 Then
		      Continue
		    End If
		    
		    Tags.Add(Tag)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  Tags.Sort
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AddToArchive(Archive As Beacon.Archive, ContentPack As Beacon.ContentPack, Blueprints() As ArkSA.Blueprint) As String
		  If Archive Is Nil Or ContentPack Is Nil Or Blueprints Is Nil Or Blueprints.Count = 0 Then
		    Return ""
		  End If
		  
		  Var Packs(0) As Dictionary
		  Packs(0) = ContentPack.SaveData
		  
		  Var Payloads(0) As Dictionary
		  Payloads(0) = New Dictionary("gameId": ArkSA.Identifier, "contentPacks": Packs)
		  
		  Var Engrams(), Creatures(), SpawnPoints(), LootDrops() As Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var Packed As Dictionary = Blueprint.Pack(False)
		    If Packed Is Nil Then
		      Continue
		    End If
		    
		    Select Case Blueprint
		    Case IsA ArkSA.Engram
		      Engrams.Add(Packed)
		    Case IsA ArkSA.Creature
		      Creatures.Add(Packed)
		    Case IsA ArkSA.SpawnPoint
		      SpawnPoints.Add(Packed)
		    Case IsA ArkSA.LootContainer
		      LootDrops.Add(Packed)
		    End Select
		  Next
		  
		  If Engrams.Count = 0 And Creatures.Count = 0 And SpawnPoints.Count = 0 And LootDrops.Count = 0 Then
		    Return ""
		  End If
		  
		  Var Payload As New Dictionary
		  Payload.Value("gameId") = ArkSA.Identifier
		  If Creatures.Count > 0 Then
		    Payload.Value("creatures") = Creatures
		  End If
		  If Engrams.Count > 0 Then
		    Payload.Value("engrams") = Engrams
		  End If
		  If LootDrops.Count > 0 Then
		    Payload.Value("lootDrops") = LootDrops
		  End If
		  If SpawnPoints.Count > 0 Then
		    Payload.Value("spawnPoints") = SpawnPoints
		  End If
		  Payloads.Add(Payload)
		  
		  Var Filename As String = ContentPack.ContentPackId + ".json"
		  Var FileContent As String = Beacon.GenerateJson(New Dictionary("payloads": Payloads), False)
		  
		  Archive.AddFile(Filename, FileContent)
		  
		  Return Filename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BlueprintPath(Matches As RegExMatch) As String
		  If Matches Is Nil Then
		    Return ""
		  End If
		  
		  Var Path As String
		  Var Count As Integer = Matches.SubExpressionCount
		  Try
		    If Count >= 12 And Matches.SubExpressionString(11).IsEmpty = False Then
		      Path = Matches.SubExpressionString(11)
		    ElseIf Count >= 11 And Matches.SubExpressionString(10).IsEmpty = False Then
		      Path = Matches.SubExpressionString(10)
		    ElseIf Count >= 9 And Matches.SubExpressionString(8).IsEmpty = False Then
		      Path = Matches.SubExpressionString(8)
		    ElseIf Count >= 7 And Matches.SubExpressionString(6).IsEmpty = False Then
		      Path = Matches.SubExpressionString(6)
		    ElseIf Count >= 5 And Matches.SubExpressionString(4).IsEmpty = False Then
		      Path = Matches.SubExpressionString(4)
		    Else
		      Return ""
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Extracting blueprint path")
		    Return ""
		  End Try
		  Path = ArkSA.CleanupBlueprintPath(Path)
		  Return Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BlueprintPathRegex() As RegEx
		  Static Regex As RegEx
		  If Regex Is Nil Then
		    Const QuotationCharacters = "'‘’""“”"
		    
		    Regex = New Regex
		    Regex.Options.CaseSensitive = False
		    Regex.SearchPattern = "(giveitem|spawndino)?\s*(([" + QuotationCharacters + "]Blueprint[" + QuotationCharacters + "](/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "]BlueprintGeneratedClass[" + QuotationCharacters + "](/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)_C[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "](/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "])|(/Script/Engine\.Blueprint[" + QuotationCharacters + "](/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "])|(/[^/]+/.+\..+))"
		  End If
		  Return Regex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function BuildExport(Blueprints() As ArkSA.Blueprint, Archive As Beacon.Archive, IsUserData As Boolean) As Boolean
		  Var OrganizedBlueprints As New Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var ContentPackId As String = Blueprint.ContentPackId
		    Var Siblings() As ArkSA.Blueprint
		    If OrganizedBlueprints.HasKey(ContentPackId) Then
		      Siblings = OrganizedBlueprints.Value(ContentPackId)
		      Siblings.Add(Blueprint)
		    Else
		      Siblings.Add(Blueprint)
		      OrganizedBlueprints.Value(ContentPackId) = Siblings
		    End If
		  Next
		  
		  Var Filenames() As String
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In OrganizedBlueprints
		    Var ContentPack As Beacon.ContentPack = DataSource.GetContentPackWithId(Entry.Key.StringValue)
		    If ContentPack Is Nil Then
		      Continue
		    End If
		    
		    Var PackBlueprints() As ArkSA.Blueprint = Entry.Value
		    Var Filename As String = AddToArchive(Archive, ContentPack, PackBlueprints)
		    If Filename.IsEmpty = False Then
		      Filenames.Add(Filename)
		    End If
		  Next
		  If Filenames.Count = 0 Then
		    Return False
		  End If
		  Filenames.Sort
		  
		  Var Manifest As New Dictionary
		  Manifest.Value("version") = 7
		  Manifest.Value("minVersion") = 7
		  Manifest.Value("generatedWith") = App.BuildNumber
		  Manifest.Value("isFull") = False
		  Manifest.Value("files") = Filenames
		  Manifest.Value("isUserData") = IsUserData
		  Archive.AddFile("Manifest.json", Beacon.GenerateJson(Manifest, False))
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(Blueprints() As ArkSA.Blueprint, IsUserData As Boolean) As MemoryBlock
		  If Blueprints Is Nil Or Blueprints.Count = 0 Then
		    App.Log("Could not export blueprints because there are no blueprints to export.")
		    Return Nil
		  End If
		  
		  Var Archive As Beacon.Archive = Beacon.Archive.Create()
		  Var Success As Boolean = BuildExport(Blueprints, Archive, IsUserData)
		  Var Mem As MemoryBlock = Archive.Finalize
		  If Success Then
		    Return Mem
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(Blueprints() As ArkSA.Blueprint, Destination As FolderItem, IsUserData As Boolean) As Boolean
		  If Blueprints Is Nil Or Blueprints.Count = 0 Or Destination Is Nil Then
		    App.Log("Could not export blueprints because the destination is invalid or there are no blueprints to export.")
		    Return False
		  End If
		  
		  Var Temp As FolderItem = FolderItem.TemporaryFile
		  Var Archive As Beacon.Archive = Beacon.Archive.Create(Temp)
		  Var Success As Boolean = BuildExport(Blueprints, Archive, IsUserData)
		  Call Archive.Finalize
		  
		  If Success Then
		    Try
		      If Destination.Exists Then
		        Destination.Remove
		      End If
		      Temp.MoveTo(Destination)
		      Return True
		    Catch Err As RuntimeException
		      Return False
		    End Try
		  End If
		  
		  Try
		    Temp.Remove
		  Catch Err As RuntimeException
		  End Try
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(IsUserData As Boolean, ParamArray Blueprints() As ArkSA.Blueprint) As MemoryBlock
		  Return BuildExport(Blueprints, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(Destination As FolderItem, IsUserData As Boolean, ParamArray Blueprints() As ArkSA.Blueprint) As Boolean
		  Return BuildExport(Blueprints, Destination, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Categories() As String()
		  Return Array(ArkSA.CategoryEngrams, ArkSA.CategoryCreatures, ArkSA.CategorySpawnPoints, ArkSA.CategoryLootContainers)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ClassStringFromPath(Path As String) As String
		  Var Components() As String = Path.Split("/")
		  Var Tail As String = Components(Components.LastIndex)
		  Components = Tail.Split(".")
		  
		  Var FirstPart As String = Components(Components.FirstIndex)
		  Var SecondPart As String = Components(Components.LastIndex)
		  
		  If SecondPart.EndsWith("_C") And FirstPart.EndsWith("_C") = False Then
		    // Appears to be a BlueprintGeneratedClass Path
		    SecondPart = SecondPart.Left(SecondPart.Length - 2)
		  End If
		  
		  Return SecondPart + "_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ClassStringToWords(ClassString As String) As String()
		  Static AcronymsPattern As Regex
		  If AcronymsPattern Is Nil Then
		    AcronymsPattern = New Regex
		    AcronymsPattern.SearchPattern = "[A-Z]{2,}"
		    AcronymsPattern.Options.CaseSensitive = True
		  End If
		  
		  Static CapitalsPattern As Regex
		  If CapitalsPattern Is Nil Then
		    CapitalsPattern = New Regex
		    CapitalsPattern.SearchPattern = "[A-Z][a-z]"
		    CapitalsPattern.Options.CaseSensitive = True
		  End If
		  
		  If ClassString.EndsWith("_C") Then
		    ClassString = ClassString.Left(ClassString.Length - 2)
		  End If
		  
		  Var Patterns() As Regex = Array(CapitalsPattern, AcronymsPattern)
		  For Each Pattern As Regex In Patterns
		    Do
		      Var Matches As RegexMatch = Pattern.Search(ClassString)
		      If Matches Is Nil Then
		        Exit Do
		      End If
		      
		      Var BytePosition As Integer = Matches.SubExpressionStartB(0)
		      ClassString = ClassString.LeftBytes(BytePosition) + "_" + Matches.SubExpressionString(0).Lowercase + ClassString.MiddleBytes(BytePosition + Matches.SubExpressionString(0).Bytes)
		    Loop
		  Next
		  
		  Do Until ClassString.IndexOf("__") = -1
		    ClassString = ClassString.ReplaceAll("__", "_")
		  Loop
		  
		  ClassString = ClassString.ReplaceAll("_", " ")
		  ClassString = ClassString.Trim
		  
		  Return ClassString.Split(" ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CleanupBlueprintPath(Path As String) As String
		  // Rather than just looking at wether or not the path ends in _C and remove it,
		  // this looks at the namespace to see if it also ends in _C. Some mod authors
		  // make this mistake and the resulting class ends up being Namespace_C.Class_C_C.
		  
		  Var Components() As String = Path.Split("/")
		  If Components.LastIndex >= 2 And Components(1) = "Game" And Components(2) = "Mods" Then
		    Components.RemoveAt(2)
		    Components.RemoveAt(1)
		  End If
		  If Components.LastIndex >= 2 And Components(2) = "Content" Then
		    Components.RemoveAt(2)
		  End If
		  
		  Var LastComponent As String = Components(Components.LastIndex)
		  Components.RemoveAt(Components.LastIndex)
		  Var Pos As Integer = LastComponent.IndexOf(".")
		  Var NamespaceString As String = LastComponent.Left(Pos)
		  Var ClassString As String = LastComponent.Middle(Pos + 1)
		  
		  If NamespaceString.EndsWith("_C") Then
		    // Class should have one _C
		    If ClassString.EndsWith("_C_C") Then
		      ClassString = ClassString.Left(ClassString.Length - 2)
		    End If
		  Else
		    // Class should have no _C
		    If ClassString.EndsWith("_C_C") Then
		      ClassString = ClassString.Left(ClassString.Length - 4)
		    ElseIf ClassString.EndsWith("_C") Then
		      ClassString = ClassString.Left(ClassString.Length - 2)
		    End If
		  End If
		  
		  Return String.FromArray(Components, "/") + "/" + NamespaceString + "." + ClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CopyFrom(Extends Destination As ArkSA.MutableBlueprint, Source As ArkSA.Blueprint) As Boolean
		  If Source Is Nil Then
		    Return False
		  End If
		  
		  Var Packed As Dictionary = Source.Pack(False)
		  Return Destination.CopyFrom(Packed)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CopyFrom(Extends Destination As ArkSA.MutableBlueprint, Source As Dictionary) As Boolean
		  If Source Is Nil Then
		    Return False
		  End If
		  
		  Var IdProperty, Category As String
		  Var LegacyMode As Boolean
		  If Source.HasKey("engramId") Then
		    Category = ArkSA.CategoryEngrams
		    IdProperty = "engramId"
		  ElseIf Source.HasKey("creatureId") Then
		    Category = ArkSA.CategoryCreatures
		    IdProperty = "creatureId"
		  ElseIf Source.HasKey("spawnPointId") Then
		    Category = ArkSA.CategorySpawnPoints
		    IdProperty = "spawnPointId"
		  ElseIf Source.HasKey("lootDropId") Then
		    Category = ArkSA.CategoryLootContainers
		    IdProperty = "lootDropId"
		  ElseIf Source.HasKey("group") Then
		    Category = Source.Value("group")
		    Select Case Category
		    Case "spawnPoints"
		      Category = ArkSA.CategorySpawnPoints
		    Case "loot_sources", "lootDrops"
		      Category = ArkSA.CategoryLootContainers
		    End Select
		    IdProperty = "id"
		    LegacyMode = True
		  End If
		  
		  If Category.IsEmpty Or Destination.Category <> Category Then
		    Return False
		  End If
		  
		  Var BlueprintId As String
		  Var AlternateLabel As NullableString
		  Var ContentPackId, ContentPackName As String
		  Var LastUpdate As Double
		  If LegacyMode Then
		    BlueprintId = Source.Value("id")
		    AlternateLabel = NullableString.FromVariant(Source.Value("alternate_label"))
		    Var ContentPackInfo As Dictionary = Source.Value("mod")
		    ContentPackId = ContentPackInfo.Value("id")
		    ContentPackName = ContentPackInfo.Value("name")
		  ElseIf Source.HasAllKeys(IdProperty, "label", "alternateLabel", "path", "tags", "availability", "contentPackId", "contentPackName", "lastUpdate") Then
		    BlueprintId = Source.Value(IdProperty)
		    AlternateLabel = NullableString.FromVariant(Source.Value("alternateLabel"))
		    ContentPackId = Source.Value("contentPackId")
		    ContentPackName = Source.Value("contentPackName")
		    LastUpdate = Source.Value("lastUpdate")
		  Else
		    Return False
		  End If
		  
		  Var Label As String = Source.Value("label")
		  Var Path As String = Source.Value("path")
		  
		  If Path.IsEmpty Or BlueprintId.IsEmpty Or Label.IsEmpty Then
		    Return False
		  End If
		  
		  Var Tags() As String
		  If Source.Value("tags").IsArray Then
		    If Source.Value("tags").ArrayElementType = Variant.TypeString Then
		      Tags = Source.Value("tags")
		    ElseIf Source.Value("tags").ArrayElementType = Variant.TypeObject Then
		      Var Temp() As Variant = Source.Value("tags")
		      For Each Tag As Variant In Temp
		        If Tag.Type = Variant.TypeString Then
		          Tags.Add(Tag.StringValue)
		        End If
		      Next
		    End If
		  End If
		  
		  Destination.Path = Path
		  Destination.BlueprintId = BlueprintId
		  Destination.AlternateLabel = AlternateLabel
		  Destination.Availability = Source.Value("availability").UInt64Value
		  Destination.Label = Label
		  If ContentPackId.IsEmpty = False And ContentPackName.IsEmpty = False Then
		    Destination.ContentPackId = ContentPackId
		    Destination.ContentPackName = ContentPackName
		  End If
		  Destination.Tags = Tags
		  Destination.LastUpdate = LastUpdate
		  
		  // Let the blueprint grab whatever additional data it needs
		  Destination.Unpack(Source)
		  
		  Return True
		  Exception Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Copying blueprint data from dictionary")
		    Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DeactivateBlueprintProvider(Provider As ArkSA.BlueprintProvider)
		  If mBlueprintProviders Is Nil Or Provider Is Nil Then
		    // No providers, so nothing to do
		    Return
		  End If
		  
		  If mBlueprintProviders.HasKey(Provider.BlueprintProviderId) Then
		    mBlueprintProviders.Remove(Provider.BlueprintProviderId)
		    
		    #if DebugBuild
		      Var ActiveProviders() As ArkSA.BlueprintProvider = ActiveBlueprintProviders
		      Var ProviderIds() As String
		      For Each ActiveProvider As ArkSA.BlueprintProvider In ActiveProviders
		        ProviderIds.Add(ActiveProvider.BlueprintProviderId)
		      Next
		      System.DebugLog("Active providers is now " + String.FromArray(ProviderIds, ", "))
		    #endif
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DownloadMod(ModInfo As CurseForge.ModInfo) As ArkSA.ModDownload
		  // This should only be run in a thread
		  
		  If mModFilenameSearcher Is Nil Then
		    mModFilenameSearcher = New RegEx
		    mModFilenameSearcher.SearchPattern = "^(.+)-([a-z+]+) (\d+)\.zip$"
		  End If
		  
		  Var ModId As String = ModInfo.ModId.ToString(Locale.Raw, "0")
		  Try
		    Var RawInfo As New JSONItem(ModInfo.ToString(False))
		    
		    Var LatestFiles As JSONItem = RawInfo.Value("latestFiles")
		    If LatestFiles.IsArray = False Then
		      App.Log("Mod " + ModId + " has no files.")
		      Return Nil
		    End If
		    
		    Var MainFileId As Integer = RawInfo.Value("mainFileId")
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
		      Return Nil
		    End If
		    
		    // Need to find the version of the main file
		    Var FilenameInfo As RegexMatch = mModFilenameSearcher.Search(LatestFile.Value("fileName").StringValue)
		    If FilenameInfo Is Nil Then
		      App.Log("Could not parse the filename for mod " + ModId + " in list of files.")
		      Return Nil
		    End If
		    Var FilenameBase As String = FilenameInfo.SubExpressionString(1)
		    Var FilenameVersion As String = FilenameInfo.SubExpressionString(3)
		    
		    // Get the full list of files
		    Var FileListSocket As New SimpleHTTP.SynchronousHTTPSocket
		    FileListSocket.RequestHeader("User-Agent") = App.UserAgent
		    FileListSocket.RequestHeader("x-api-key") = Beacon.CurseForgeApiKey
		    FileListSocket.Send("GET", "https://api.curseforge.com/v1/mods/" + ModId + "/files")
		    If FileListSocket.LastHTTPStatus <> 200 Then
		      App.Log("Could not list files for mod " + ModId + ": HTTP #" + FileListSocket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		      Return Nil
		    End If
		    Var ResponseJson As New JSONItem(FileListSocket.LastContent)
		    Var FileList As JSONItem = ResponseJson.Value("data")
		    
		    // Now look through for the windowsserver file
		    Var DesiredFilename As String = FilenameBase + "-windowsserver " + FilenameVersion + ".zip"
		    Var FileInfo As JSONItem
		    For Idx As Integer = 0 To FileList.Count - 1
		      Var File As JSONItem = FileList.ChildAt(Idx)
		      If File.Value("fileName").StringValue <> DesiredFilename Then
		        Continue For Idx
		      End If
		      
		      FileInfo = File
		      Exit For Idx
		    Next
		    
		    If FileInfo Is Nil Then
		      App.Log("Could not find file " + DesiredFilename + " for mod " + ModId + ".")
		      Return Nil
		    End If
		    
		    Var FileHash As String
		    Var Hashes As JSONItem = FileInfo.Child("hashes")
		    For Idx As Integer = 0 To Hashes.Count - 1
		      Var Hash As JSONItem = Hashes.ChildAt(Idx)
		      If Hash.Value("algo") = 1 Then
		        FileHash = Hash.Value("value")
		        Exit For Idx
		      End If
		    Next
		    
		    Var FileSize As Double = FileInfo.Value("fileLength")
		    Var FileName As String = FileInfo.Value("fileName")
		    
		    Var DownloadUrl As String
		    If FileInfo.HasKey("downloadUrl") And FileInfo.Value("downloadUrl").IsNull = False Then
		      DownloadUrl = FileInfo.Value("downloadUrl")
		    Else
		      // The url is predictable
		      Var FileId As Integer = FileInfo.Value("id")
		      Var ParentFolderId As Integer = Floor(FileId / 1000)
		      Var ChildFolderId As Integer = FileId - (ParentFolderId * 1000)
		      DownloadUrl = "https://edge.forgecdn.net/files/" + ParentFolderId.ToString(Locale.Raw, "0") + "/" + ChildFolderId.ToString(Locale.Raw, "0") + "/" + EncodeURLComponent(FileName)
		    End If
		    
		    // This isn't officially supported, so let's pretend we're a browser.
		    Var DownloadSocket As New SimpleHTTP.SynchronousHTTPSocket
		    DownloadSocket.RequestHeader("User-Agent") = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
		    DownloadSocket.Send("GET", DownloadUrl)
		    If DownloadSocket.LastHTTPStatus <> 200 Then
		      App.Log("Mod " + ModId + " was looked up, but the archive '" + FileName + "' could not be downloaded: HTTP #" + DownloadSocket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		      Return Nil
		    End If
		    
		    Var DownloadedBytes As Double
		    If (DownloadSocket.LastContent Is Nil) = False Then
		      DownloadedBytes = DownloadSocket.LastContent.Size
		    End If
		    If DownloadedBytes <> FileSize Then
		      App.Log("Mod " + ModId + " downloaded " + Beacon.BytesToString(DownloadedBytes) + " of '" + FileName + "' but should have downloaded " + Beacon.BytesToString(FileSize) + ".")
		      Return Nil
		    End If
		    
		    If FileHash.IsEmpty = False And (DownloadSocket.LastContent Is Nil) = False Then
		      Var ComputedHash As String = EncodeHex(Crypto.SHA1(DownloadSocket.LastContent))
		      If ComputedHash <> FileHash Then
		        App.Log("Mod " + ModId + " downloaded '" + FileName + "' but checksum does not match. Expected " + FileHash.Lowercase + ", computed " + ComputedHash.Lowercase)
		        Return Nil
		      End If
		    End If
		    
		    Var Reader As New ArchiveReaderMBS
		    Reader.SupportFilterAll
		    Reader.SupportFormatAll
		    If Not Reader.OpenData(DownloadSocket.LastContent) Then
		      App.Log("Could not open archive '" + FileName + "' for mod " + ModId + ": " + Reader.ErrorString)
		      Return Nil
		    End If
		    
		    Return New ArkSA.ModDownload(Reader, Filename)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Trying to download mod " + ModId)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExportToCSV(Blueprints() As ArkSA.Blueprint) As String
		  If Blueprints.Count = 0 Then
		    Return ""
		  End If
		  
		  // See if all the blueprints are the same category
		  Var Category As String = Blueprints(0).Category
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Blueprint.Category <> Category Then
		      Category = ""
		      Exit
		    End If
		  Next
		  
		  Var Headers() As String = Array("Name", "Class", "Path", "Mod")
		  Select Case Category
		  Case ArkSA.CategoryCreatures
		    Headers.Add("Mature Time")
		    Headers.Add("Incubation Time")
		    Headers.Add("Minimum Cooldown")
		    Headers.Add("Maximum Cooldown")
		  Case ArkSA.CategoryEngrams
		    Headers.Add("Unlock String")
		    Headers.Add("Required Level")
		    Headers.Add("Required Points")
		  Case ArkSA.CategoryLootContainers
		    
		  Case ArkSA.CategorySpawnPoints
		    
		  End Select
		  
		  Var Lines(0) As String
		  Lines(0) = """" + String.FromArray(Headers, """,""") + """"
		  
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var Columns(3) As String
		    Columns(0) = Blueprint.Label.ReplaceAll("""", """""")
		    Columns(1) = Blueprint.ClassString.ReplaceAll("""", """""")
		    Columns(2) = Blueprint.Path.ReplaceAll("""", """""")
		    Columns(3) = Blueprint.ContentPackName.ReplaceAll("""", """""")
		    
		    Select Case Category
		    Case ArkSA.CategoryCreatures
		      Var Creature As ArkSA.Creature = ArkSA.Creature(Blueprint)
		      If Creature.MatureTime > 0 Then
		        Columns.Add(Creature.MatureTime.PrettyText)
		      Else
		        Columns.Add("")
		      End If
		      If Creature.IncubationTime > 0 Then
		        Columns.Add(Creature.IncubationTime.PrettyText)
		      Else
		        Columns.Add("")
		      End If
		      If Creature.MinMatingInterval > 0 Then
		        Columns.Add(Creature.MinMatingInterval.PrettyText)
		      Else
		        Columns.Add("")
		      End If
		      If Creature.MaxMatingInterval > 0 Then
		        Columns.Add(Creature.MaxMatingInterval.PrettyText)
		      Else
		        Columns.Add("")
		      End If
		    Case ArkSA.CategoryEngrams
		      Var Engram As ArkSA.Engram = ArkSA.Engram(Blueprint)
		      Columns.Add(Engram.EntryString.ReplaceAll("""", """"""))
		      If Engram.RequiredPlayerLevel Is Nil Then
		        Columns.Add("")
		      Else
		        Columns.Add(Engram.RequiredPlayerLevel.IntegerValue.ToString(Locale.Raw, "0"))
		      End If
		      If Engram.RequiredUnlockPoints Is Nil Then
		        Columns.Add("")
		      Else
		        Columns.Add(Engram.RequiredUnlockPoints.IntegerValue.ToString(Locale.Raw, "0"))
		      End If
		    Case ArkSA.CategoryLootContainers
		      
		    Case ArkSA.CategorySpawnPoints
		      
		    End Select
		    
		    Lines.Add("""" + String.FromArray(Columns, """,""") + """")
		  Next
		  
		  Return String.FromArray(Lines, EndOfLine)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExportToCSV(Extends Blueprints() As ArkSA.Blueprint) As String
		  Return ExportToCSV(Blueprints)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExtractPath(Source As String) As String
		  Var Matches As RegExMatch = BlueprintPathRegex.Search(Source)
		  Return ArkSA.BlueprintPath(Matches)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindMigratedBlueprint(Migrator As Beacon.BlueprintMigrator, OriginalBlueprint As ArkSA.Blueprint) As ArkSA.Blueprint
		  Return ArkSA.FindMigratedBlueprint(Migrator, New ArkSA.BlueprintReference(OriginalBlueprint)).Resolve()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindMigratedBlueprint(Migrator As Beacon.BlueprintMigrator, OriginalBlueprint As ArkSA.BlueprintReference) As ArkSA.BlueprintReference
		  // Returning Nil means no change
		  
		  If OriginalBlueprint Is Nil Then
		    Return Nil
		  End If
		  
		  Var NewPack As Beacon.ContentPack = Migrator.CounterpartContentPack(OriginalBlueprint.ContentPackId)
		  If NewPack Is Nil Then
		    Return Nil
		  End If
		  
		  Var Siblings() As ArkSA.Blueprint = ArkSA.DataSource.Pool.Get(False).GetBlueprintsByPath(OriginalBlueprint.Path, New Beacon.StringList(NewPack.ContentPackId))
		  If Siblings.Count = 0 Then
		    Return Nil
		  End If
		  
		  Return New ArkSA.BlueprintReference(Siblings(0))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Fingerprint(Extends Providers() As ArkSA.BlueprintProvider) As String
		  Var Members() As String
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    Members.Add(Provider.BlueprintProviderId)
		  Next
		  Return EncodeHex(Crypto.MD5(String.FromArray(Members, ",")))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateBlueprintId(ContentPackId As String, Path As String) As String
		  Return Beacon.UUID.v5(ContentPackId.Lowercase + ":" + Path.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(Extends Providers() As ArkSA.BlueprintProvider, Category As String, SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec, ExtraClauses() As String, ExtraValues() As Variant) As ArkSA.Blueprint()
		  Var Blueprints() As ArkSA.Blueprint
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    Blueprints = Blueprints.Merge(Provider.GetBlueprints(Category, SearchText, ContentPacks, Tags, ExtraClauses, ExtraValues))
		  Next
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(Extends Provider As ArkSA.BlueprintProvider, SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.Blueprint()
		  Var Categories() As String = ArkSA.Categories
		  Var Blueprints() As ArkSA.Blueprint
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  For Each Category As String In Categories
		    Var Results() As ArkSA.Blueprint = Provider.GetBlueprints(Category, SearchText, ContentPacks, Tags, ExtraClauses, ExtraValues)
		    For Each Result As ArkSA.Blueprint In Results
		      Blueprints.Add(Result)
		    Next
		  Next
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(Extends Provider As ArkSA.BlueprintProvider, Category As String, SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec) As ArkSA.Blueprint()
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  Return Provider.GetBlueprints(Category, SearchText, ContentPacks, Tags, ExtraClauses, ExtraValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatures(Extends Providers() As ArkSA.BlueprintProvider, SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.Creature()
		  Var Creatures() As ArkSA.Creature
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    Creatures = Creatures.Merge(Provider.GetCreatures(SearchText, ContentPacks, Tags))
		  Next
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngrams(Extends Providers() As ArkSA.BlueprintProvider, SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.Engram()
		  Var Engrams() As ArkSA.Engram
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    Engrams = Engrams.Merge(Provider.GetEngrams(SearchText, ContentPacks, Tags))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainers(Extends Providers() As ArkSA.BlueprintProvider, SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil, IncludeExperimental As Boolean = False) As ArkSA.LootContainer()
		  Var Containers() As ArkSA.LootContainer
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    Containers = Containers.Merge(Provider.GetLootContainers(SearchText, ContentPacks, Tags, IncludeExperimental))
		  Next
		  Return Containers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoints(Extends Providers() As ArkSA.BlueprintProvider, SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.SpawnPoint()
		  Var SpawnPoints() As ArkSA.SpawnPoint
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    SpawnPoints = SpawnPoints.Merge(Provider.GetSpawnPoints(SearchText, ContentPacks, Tags))
		  Next
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(Extends Blueprint As ArkSA.Blueprint) As String
		  #if DebugBuild
		    Return Beacon.GenerateJSON(ArkSA.PackBlueprint(Blueprint, False), True)
		  #else
		    Return EncodeHex(Crypto.SHA1(Beacon.GenerateJSON(ArkSA.PackBlueprint(Blueprint, False), False))).Lowercase
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Extends Maps() As ArkSA.Map) As String
		  Var Names() As String
		  Names.ResizeTo(Maps.LastIndex)
		  For Idx As Integer = 0 To Names.LastIndex
		    Names(Idx) = Maps(Idx).Name
		  Next Idx
		  
		  If Names.Count = 0 Then
		    Return "No Maps"
		  Else
		    Return Language.EnglishOxfordList(Names)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelFromClassString(ClassString As String) As String
		  If ClassString.EndsWith("_C") Then
		    ClassString = ClassString.Left(ClassString.Length - 2)
		  End If
		  
		  If ClassString.IsEmpty Then
		    Return ""
		  End If
		  
		  Var Prefixes() As String = Array("DinoDropInventoryComponent", "DinoSpawnEntries")
		  Var Blacklist() As String = Array("Character", "BP", "DinoSpawnEntries", "SupplyCrate", "SupplyCreate", "DinoDropInventoryComponent")
		  
		  Try
		    ClassString = ClassString.Replace("T_Ext", "Ext")
		    
		    Var MapName As String
		    
		    Var Parts() As String = ClassString.Split("_")
		    If Parts(0).BeginsWith("PrimalItem") Then
		      Parts.RemoveAt(0)
		    End If
		    
		    For I As Integer = Parts.LastIndex DownTo 0
		      Select Case Parts(I)
		      Case "AB"
		        MapName = "Aberration"
		        Parts.RemoveAt(I)
		        Continue
		      Case "Val"
		        MapName = "Valguero"
		        Parts.RemoveAt(I)
		        Continue
		      Case "SE"
		        MapName = "Scorched"
		        Parts.RemoveAt(I)
		        Continue
		      Case "Ext", "EX"
		        MapName = "Extinction"
		        Parts.RemoveAt(I)
		        Continue
		      Case "JacksonL", "Ragnarok"
		        MapName = "Ragnarok"
		        Parts.RemoveAt(I)
		        Continue
		      Case "TheCenter"
		        MapName = "The Center"
		        Parts.RemoveAt(I)
		        Continue
		      End Select
		      
		      For Each Prefix As String In Prefixes
		        If Parts(I).BeginsWith(Prefix) Then
		          Parts(I) = Parts(I).Middle(Prefix.Length)
		        End If
		      Next
		      
		      For Each Member As String In Blacklist
		        If Parts(I) = Member Then
		          Parts.RemoveAt(I)
		          Continue For I
		        End If
		      Next
		    Next
		    
		    If MapName <> "" Then
		      Parts.AddAt(0, MapName)
		    End If
		    
		    If Parts.Count > 0 Then
		      Return Beacon.MakeHumanReadable(Parts.Join(" "))
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Return Beacon.MakeHumanReadable(ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LootColors() As Pair()
		  Var Colors() As Pair
		  Colors.Add("White" : "FFFFFF00")
		  Colors.Add("Green" : "00FF0000")
		  Colors.Add("Blue" : "88C8FF00")
		  Colors.Add("Purple" : "E6BAFF00")
		  Colors.Add("Yellow" : "FFF02A00")
		  Colors.Add("Red" : "FFBABA00")
		  Colors.Add("Cyan" : "00FFFF00")
		  Colors.Add("Orange" : "FFA50000")
		  Return Colors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask(Extends Maps() As ArkSA.Map) As UInt64
		  Var Bits As UInt64
		  For Each Map As ArkSA.Map In Maps
		    Bits = Bits Or Map.Mask
		  Next
		  Return Bits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Extends Blueprint As ArkSA.Blueprint, Spec As Beacon.TagSpec) As Boolean
		  If Spec Is Nil Then
		    Return True
		  End If
		  
		  Var Tags() As String = Spec.FilteredTags
		  For Each Tag As String In Tags
		    Var State As Integer = Spec.StateOf(Tag)
		    Var IsTagged As Boolean = Blueprint.IsTagged(Tag)
		    If (State = Beacon.TagSpec.StateRequired And IsTagged = False) Or (State = Beacon.TagSpec.StateExcluded And IsTagged = True) Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Extends Blueprint As ArkSA.Blueprint, Rx As PCRE2CodeMBS, Flags As Integer = ArkSA.FlagMatchAny) As Boolean
		  If Rx Is Nil Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchPath) > 0 And (Rx.Match(Blueprint.Path) Is Nil) = False Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchLabel) > 0 And ((Rx.Match(Blueprint.Label) Is Nil) = False Or ((Blueprint.AlternateLabel Is Nil) = False And (Rx.Match(Blueprint.AlternateLabel) Is Nil) = False)) Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchClass) > 0 And (Rx.Match(Blueprint.ClassString) Is Nil) = False Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchBlueprintId) > 0 And (Rx.Match(Blueprint.BlueprintId) Is Nil) = False Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchUnlockString) > 0 And (Blueprint IsA ArkSA.Engram And ArkSA.Engram(Blueprint).EntryString.IsEmpty = False And (Rx.Match(ArkSA.Engram(Blueprint).EntryString) Is Nil) = False) Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Extends Blueprint As ArkSA.Blueprint, Filter As String, Flags As Integer = ArkSA.FlagMatchAny) As Boolean
		  If Filter.IsEmpty Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchPath) > 0 And Blueprint.Path.Contains(Filter) Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchLabel) > 0 And (Blueprint.Label.Contains(Filter) Or ((Blueprint.AlternateLabel Is Nil) = False And Blueprint.AlternateLabel.Contains(Filter))) Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchClass) > 0 And Blueprint.ClassString.Contains(Filter) Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchBlueprintId) > 0 And Blueprint.BlueprintId.Contains(Filter) Then
		    Return True
		  End If
		  
		  If (Flags And FlagMatchUnlockString) > 0 And Blueprint IsA ArkSA.Engram And ArkSA.Engram(Blueprint).EntryString.IsEmpty = False And ArkSA.Engram(Blueprint).EntryString.Contains(Filter) Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Extends Array1() As ArkSA.Blueprint, Array2() As ArkSA.Blueprint) As ArkSA.Blueprint()
		  If Array1 Is Nil Or Array1.Count = 0 Then
		    Return Array2
		  ElseIf Array2 Is Nil Or Array2.Count = 0 Then
		    Return Array1
		  End If
		  
		  Var Unique As New Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Array1
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    Unique.Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  For Each Blueprint As ArkSA.Blueprint In Array2
		    If Blueprint Is Nil Then
		      Continue
		    End If
		    Unique.Value(Blueprint.BlueprintId) = Blueprint
		  Next
		  Var Merged() As ArkSA.Blueprint
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Extends Array1() As ArkSA.Creature, Array2() As ArkSA.Creature) As ArkSA.Creature()
		  If Array1 Is Nil Or Array1.Count = 0 Then
		    Return Array2
		  ElseIf Array2 Is Nil Or Array2.Count = 0 Then
		    Return Array1
		  End If
		  
		  Var Unique As New Dictionary
		  For Each Creature As ArkSA.Creature In Array1
		    If Creature Is Nil Then
		      Continue
		    End If
		    Unique.Value(Creature.BlueprintId) = Creature
		  Next
		  For Each Creature As ArkSA.Creature In Array2
		    If Creature Is Nil Then
		      Continue
		    End If
		    Unique.Value(Creature.BlueprintId) = Creature
		  Next
		  Var Merged() As ArkSA.Creature
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Extends Array1() As ArkSA.Engram, Array2() As ArkSA.Engram) As ArkSA.Engram()
		  If Array1 Is Nil Or Array1.Count = 0 Then
		    Return Array2
		  ElseIf Array2 Is Nil Or Array2.Count = 0 Then
		    Return Array1
		  End If
		  
		  Var Unique As New Dictionary
		  For Each Engram As ArkSA.Engram In Array1
		    If Engram Is Nil Then
		      Continue
		    End If
		    Unique.Value(Engram.BlueprintId) = Engram
		  Next
		  For Each Engram As ArkSA.Engram In Array2
		    If Engram Is Nil Then
		      Continue
		    End If
		    Unique.Value(Engram.BlueprintId) = Engram
		  Next
		  Var Merged() As ArkSA.Engram
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Extends Array1() As ArkSA.LootContainer, Array2() As ArkSA.LootContainer) As ArkSA.LootContainer()
		  If Array1 Is Nil Or Array1.Count = 0 Then
		    Return Array2
		  ElseIf Array2 Is Nil Or Array2.Count = 0 Then
		    Return Array1
		  End If
		  
		  Var Unique As New Dictionary
		  For Each LootContainer As ArkSA.LootContainer In Array1
		    If LootContainer Is Nil Then
		      Continue
		    End If
		    Unique.Value(LootContainer.BlueprintId) = LootContainer
		  Next
		  For Each LootContainer As ArkSA.LootContainer In Array2
		    If LootContainer Is Nil Then
		      Continue
		    End If
		    Unique.Value(LootContainer.BlueprintId) = LootContainer
		  Next
		  Var Merged() As ArkSA.LootContainer
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Merge(Extends Array1() As ArkSA.SpawnPoint, Array2() As ArkSA.SpawnPoint) As ArkSA.SpawnPoint()
		  If Array1 Is Nil Or Array1.Count = 0 Then
		    Return Array2
		  ElseIf Array2 Is Nil Or Array2.Count = 0 Then
		    Return Array1
		  End If
		  
		  Var Unique As New Dictionary
		  For Each SpawnPoint As ArkSA.SpawnPoint In Array1
		    If SpawnPoint Is Nil Then
		      Continue
		    End If
		    Unique.Value(SpawnPoint.BlueprintId) = SpawnPoint
		  Next
		  For Each SpawnPoint As ArkSA.SpawnPoint In Array2
		    If SpawnPoint Is Nil Then
		      Continue
		    End If
		    Unique.Value(SpawnPoint.BlueprintId) = SpawnPoint
		  Next
		  Var Merged() As ArkSA.SpawnPoint
		  For Each Entry As DictionaryEntry In Unique
		    Merged.Add(Entry.Value)
		  Next
		  Return Merged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ModTagFromPath(Path As String) As String
		  If Path.BeginsWith("/Game/Mods/") Then
		    Return Path.NthField("/", 4)
		  ElseIf Path.BeginsWith("/Game/") Then
		    Return ""
		  ElseIf Path.BeginsWith("/") Then
		    Return Path.NthField("/", 2)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NormalizeBlueprintPath(Path As String, FolderName As String) As String
		  Path = Path.Trim
		  
		  If Path.BeginsWith("BlueprintGeneratedClass") Then
		    Path = Path.Middle(23)
		  ElseIf Path.BeginsWith("Blueprint") Then
		    Path = Path.Middle(9)
		  End If
		  
		  If (Path.BeginsWith("'") And Path.EndsWith("'")) Or (Path.BeginsWith("""") And Path.EndsWith("""")) Then
		    Path = Path.Middle(1, Path.Length - 2)
		  End If
		  
		  If Path.BeginsWith("/Game/") Then
		    // Looks like a real path
		    
		    If Path.EndsWith("_C") Then
		      Path = Path.Left(Path.Length - 2)
		    End If
		    
		    Return Path
		  Else
		    // Assume this is a class string
		    Var PossiblePath As String = ArkSA.DataSource.Pool.Get(False).ResolvePathFromClassString(Path)
		    If PossiblePath.IsEmpty = False Then
		      Return PossiblePath
		    Else
		      Return ArkSA.UnknownBlueprintPath(FolderName, Path)
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OmniPurchased(Identity As Beacon.Identity) As Boolean
		  Return (Identity Is Nil) = False And Identity.IsOmniFlagged(ArkSA.OmniFlag)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pack(Extends Blueprint As ArkSA.Blueprint, ForAPI As Boolean) As Dictionary
		  Return PackBlueprint(Blueprint, ForAPI)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PackBlueprint(Blueprint As ArkSA.Blueprint, ForAPI As Boolean) As Dictionary
		  Var Dict As New Dictionary
		  Var IdProperty As String
		  
		  Select Case Blueprint
		  Case IsA ArkSA.Engram
		    Dict.Value("group") = "engrams"
		    IdProperty = "engramId"
		  Case IsA ArkSA.Creature
		    Dict.Value("group") = "creatures"
		    IdProperty = "creatureId"
		  Case IsA ArkSA.SpawnPoint
		    Dict.Value("group") = "spawnPoints"
		    IdProperty = "spawnPointId"
		  Case IsA ArkSA.LootContainer
		    Dict.Value("group") = "lootDrops"
		    IdProperty = "lootDropId"
		  Else
		    Return Nil
		  End Select
		  
		  Dict.Value(IdProperty) = Blueprint.BlueprintId
		  Dict.Value("label") = Blueprint.Label
		  Dict.Value("alternateLabel") = Blueprint.AlternateLabel
		  Dict.Value("tags") = Blueprint.Tags
		  Dict.Value("availability") = Blueprint.Availability
		  Dict.Value("path") = Blueprint.Path
		  Dict.Value("minVersion") = 20000000
		  Dict.Value("lastUpdate") = Blueprint.LastUpdate
		  Dict.Value("contentPackId") = Blueprint.ContentPackId
		  Dict.Value("contentPackName") = Blueprint.ContentPackName
		  
		  // Let the blueprint add whatever additional data it needs
		  Blueprint.Pack(Dict, ForAPI)
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseCommandLine(CommandLine As String, PreserveSyntax As Boolean = False) As Dictionary
		  // This shouldn't take long, but still, probably best to only use this on a thread
		  
		  Var InQuotes As Boolean
		  Var Characters() As String = CommandLine.Split("")
		  Var Buffer, Params() As String
		  For Each Char As String In Characters
		    If Char = """" Then
		      If InQuotes Then
		        Params.Add(Buffer)
		        Buffer = ""
		        InQuotes = False
		      Else
		        InQuotes = True
		      End If
		    ElseIf Char = " " Then
		      If InQuotes = False And Buffer.Length > 0 Then
		        Params.Add(Buffer)
		        Buffer = ""
		      End If
		    ElseIf Char = "-" And Buffer.Length = 0 Then
		      Continue
		    Else
		      Buffer = Buffer + Char
		    End If
		  Next
		  If Buffer.Length > 0 Then
		    Params.Add(Buffer)
		    Buffer = ""
		  End If
		  
		  Var StartupParams() As String = Params.Shift.Split("?")
		  Var Map As String = StartupParams.Shift
		  Call StartupParams.Shift // The listen statement
		  If PreserveSyntax Then
		    For Idx As Integer = 0 To Params.LastIndex
		      Params(Idx) = "-" + Params(Idx)
		    Next
		    For Idx As Integer = 0 To StartupParams.LastIndex
		      StartupParams(Idx) = "?" + StartupParams(Idx)
		    Next
		  End If
		  StartupParams.Merge(Params)
		  
		  Var CommandLineOptions As New Dictionary
		  For Each Parameter As String In StartupParams
		    Var KeyPos As Integer = Parameter.IndexOf("=")
		    Var Key As String
		    Var Value As Variant
		    If KeyPos = -1 Then
		      Key = Parameter
		      Value = True
		    Else
		      Key = Parameter.Left(KeyPos)
		      Value = Parameter.Middle(KeyPos + 1)
		    End If
		    If PreserveSyntax Then
		      Value = Parameter
		    End If
		    CommandLineOptions.Value(Key) = Value
		  Next
		  
		  If PreserveSyntax Then
		    CommandLineOptions.Value("?Map") = Map
		  Else
		    CommandLineOptions.Value("Map") = Map
		  End If
		  Return CommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PickWeightedMember(Members() As ArkSA.Weighted) As ArkSA.Weighted
		  If Members Is Nil Or Members.Count = 0 Then
		    Return Nil
		  ElseIf Members.Count = 1 Then
		    Return Members(0)
		  End If
		  
		  Var SumOfWeights As Double
		  For Idx As Integer = Members.FirstIndex To Members.LastIndex
		    SumOfWeights = SumOfWeights + Members(Idx).RawWeight
		  Next Idx
		  
		  Var Result As Double = System.Random.Number
		  Var CumulativeChance As Double
		  For Idx As Integer = Members.FirstIndex To Members.LastIndex
		    Var Chance As Double = Members(Idx).RawWeight / SumOfWeights
		    Var MinChance As Double = CumulativeChance
		    Var MaxChance As Double = CumulativeChance + Chance
		    CumulativeChance = MaxChance
		    
		    If Result >= MinChance And Result < MaxChance Then
		      Return Members(Idx)
		    End If
		  Next Idx
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PickWeightedMember(Extends Members() As ArkSA.Weighted) As ArkSA.Weighted
		  Return PickWeightedMember(Members)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegenerateBlueprintId(Extends Blueprint As ArkSA.MutableBlueprint)
		  Blueprint.BlueprintId = ArkSA.GenerateBlueprintId(Blueprint.ContentPackId, Blueprint.Path)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTag(Extends Blueprint As ArkSA.MutableBlueprint, ParamArray TagsToRemove() As String)
		  Blueprint.RemoveTags(TagsToRemove)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTags(Extends Blueprint As ArkSA.MutableBlueprint, TagsToRemove() As String)
		  Var Tags() As String = Blueprint.Tags
		  Var Changed As Boolean
		  For I As Integer = 0 To TagsToRemove.LastIndex
		    Var Tag As String  = Beacon.NormalizeTag(TagsToRemove(I))
		    
		    If Tag = "object" Then
		      Continue
		    End If
		    
		    Var Idx As Integer = Tags.IndexOf(Tag)
		    If Idx = -1 Then
		      Continue
		    End If
		    
		    Tags.RemoveAt(Idx)
		    Changed = True
		  Next
		  
		  If Not Changed Then
		    Return
		  End If
		  
		  // No, you don't need to sort here
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(Dict As Dictionary, CreatureIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.Creature
		  Var CreatureId, Path, ClassString As String
		  
		  If CreatureIdKey.IsEmpty = False And Dict.HasKey(CreatureIdKey) Then
		    CreatureId = Dict.Value(CreatureIdKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return ArkSA.ResolveCreature(CreatureId, Path, ClassString, ContentPacks, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(CreatureId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.Creature
		  Var Providers() As ArkSA.BlueprintProvider = ArkSA.ActiveBlueprintProviders()
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    If CreatureId.IsEmpty = False Then
		      Try
		        Var Creature As ArkSA.Creature = Provider.GetCreature(CreatureId)
		        If (Creature Is Nil) = False Then
		          Return Creature
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If Path.IsEmpty = False Then
		      Try
		        Var Creatures() As ArkSA.Creature = Provider.GetCreaturesByPath(Path, ContentPacks)
		        If Creatures.Count > 0 Then
		          Return Creatures(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If ClassString.IsEmpty = False Then
		      Try
		        Var Creatures() As ArkSA.Creature = Provider.GetCreaturesByClass(ClassString, ContentPacks)
		        If Creatures.Count > 0 Then
		          Return Creatures(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		  Next
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveCreature(CreatureId, Path, ClassString, Nil, Create)
		  End If
		  
		  If Create Then
		    Return ArkSA.Creature.CreateCustom(CreatureId, Path, ClassString)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(Dict As Dictionary, EngramIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.Engram
		  Var EngramId, Path, ClassString As String
		  
		  If EngramIdKey.IsEmpty = False And Dict.HasKey(EngramIdKey) Then
		    EngramId = Dict.Value(EngramIdKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return ArkSA.ResolveEngram(EngramId, Path, ClassString, ContentPacks, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(EngramId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.Engram
		  Var Providers() As ArkSA.BlueprintProvider = ArkSA.ActiveBlueprintProviders()
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    If EngramId.IsEmpty = False Then
		      Try
		        Var Engram As ArkSA.Engram = Provider.GetEngram(EngramId)
		        If (Engram Is Nil) = False Then
		          Return Engram
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If Path.IsEmpty = False Then
		      Try
		        Var Engrams() As ArkSA.Engram = Provider.GetEngramsByPath(Path, ContentPacks)
		        If Engrams.Count > 0 Then
		          Return Engrams(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If ClassString.IsEmpty = False Then
		      Try
		        Var Engrams() As ArkSA.Engram = Provider.GetEngramsByClass(ClassString, ContentPacks)
		        If Engrams.Count > 0 Then
		          Return Engrams(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		  Next
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveEngram(EngramId, Path, ClassString, Nil, Create)
		  End If
		  
		  If Create Then
		    Return ArkSA.Engram.CreateCustom(EngramId, Path, ClassString)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(Dict As Dictionary, LootDropIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.LootContainer
		  Var LootDropId, Path, ClassString As String
		  
		  If LootDropIdKey.IsEmpty = False And Dict.HasKey(LootDropIdKey) Then
		    LootDropId = Dict.Value(LootDropIdKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return ArkSA.ResolveLootContainer(LootDropId, Path, ClassString, ContentPacks, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(LootDropId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.LootContainer
		  Var Providers() As ArkSA.BlueprintProvider = ArkSA.ActiveBlueprintProviders()
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    If LootDropId.IsEmpty = False Then
		      Try
		        Var LootContainer As ArkSA.LootContainer = Provider.GetLootContainer(LootDropId)
		        If (LootContainer Is Nil) = False Then
		          Return LootContainer
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If Path.IsEmpty = False Then
		      Try
		        Var LootContainers() As ArkSA.LootContainer = Provider.GetLootContainersByPath(Path, ContentPacks)
		        If LootContainers.Count > 0 Then
		          Return LootContainers(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If ClassString.IsEmpty = False Then
		      Try
		        Var LootContainers() As ArkSA.LootContainer = Provider.GetLootContainersByClass(ClassString, ContentPacks)
		        If LootContainers.Count > 0 Then
		          Return LootContainers(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		  Next
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveLootContainer(LootDropId, Path, ClassString, Nil, Create)
		  End If
		  
		  If Create Then
		    Return ArkSA.LootContainer.CreateCustom(LootDropId, Path, ClassString)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(Dict As Dictionary, SpawnPointIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.SpawnPoint
		  Var SpawnPointId, Path, ClassString As String
		  
		  If SpawnPointIdKey.IsEmpty = False And Dict.HasKey(SpawnPointIdKey) Then
		    SpawnPointId = Dict.Value(SpawnPointIdKey)
		  End If
		  
		  If PathKey.IsEmpty = False And Dict.HasKey(PathKey) Then
		    Path = Dict.Value(PathKey)
		  End If
		  
		  If ClassKey.IsEmpty = False And Dict.HasKey(ClassKey) Then
		    ClassString = Dict.Value(ClassKey)
		  End If
		  
		  Return ArkSA.ResolveSpawnPoint(SpawnPointId, Path, ClassString, ContentPacks, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(SpawnPointId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList, Create As Boolean) As ArkSA.SpawnPoint
		  Var Providers() As ArkSA.BlueprintProvider = ArkSA.ActiveBlueprintProviders()
		  For Each Provider As ArkSA.BlueprintProvider In Providers
		    If SpawnPointId.IsEmpty = False Then
		      Try
		        Var SpawnPoint As ArkSA.SpawnPoint = Provider.GetSpawnPoint(SpawnPointId)
		        If (SpawnPoint Is Nil) = False Then
		          Return SpawnPoint
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If Path.IsEmpty = False Then
		      Try
		        Var SpawnPoints() As ArkSA.SpawnPoint = Provider.GetSpawnPointsByPath(Path, ContentPacks)
		        If SpawnPoints.Count > 0 Then
		          Return SpawnPoints(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    
		    If ClassString.IsEmpty = False Then
		      Try
		        Var SpawnPoints() As ArkSA.SpawnPoint = Provider.GetSpawnPointsByClass(ClassString, ContentPacks)
		        If SpawnPoints.Count > 0 Then
		          Return SpawnPoints(0)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		  Next
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveSpawnPoint(SpawnPointId, Path, ClassString, Nil, Create)
		  End If
		  
		  If Create Then
		    Return ArkSA.SpawnPoint.CreateCustom(SpawnPointId, Path, ClassString)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit)) or  (TargetWeb and (Target32Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Protected Sub SetupCodeEditor(Target As CodeEditor)
		  Const SCE_PROPS_DEFAULT = 0
		  Const SCE_PROPS_COMMENT = 1
		  Const SCE_PROPS_SECTION = 2
		  Const SCE_PROPS_ASSIGNMENT = 3
		  Const SCE_PROPS_DEFVAL = 4
		  Const SCE_PROPS_KEY = 5
		  
		  Target.InitializeLexer("props")
		  
		  Var SectionColor, AssignmentColor, KeywordColor As Color
		  
		  If Color.IsDarkMode Then
		    SectionColor = &cFF7778
		    AssignmentColor = &cCBCBCB
		    KeywordColor = &c19A9FF
		  Else
		    SectionColor = &c7D1012
		    AssignmentColor = &c515151
		    KeywordColor = &c0C51C3
		  End If
		  
		  Target.Style(SCE_PROPS_SECTION).ForeColor = SectionColor
		  Target.Style(SCE_PROPS_ASSIGNMENT).ForeColor = AssignmentColor
		  Target.Style(SCE_PROPS_KEY).ForeColor = KeywordColor
		  Target.Style(SCE_PROPS_SECTION).Bold = True
		  
		  // Unknown colors, make sure they stand out so they can be discovered more readily
		  Target.Style(SCE_PROPS_DEFVAL).ForeColor = &cFF00FF
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Values() As ArkSA.ConfigValue)
		  If Values.Count <= 1 Then
		    Return
		  End If
		  
		  Var Sorts() As String
		  Sorts.ResizeTo(Values.LastIndex)
		  For Idx As Integer = 0 To Sorts.LastIndex
		    Sorts(Idx) = Values(Idx).SortKey
		  Next
		  Sorts.SortWith(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Containers() As ArkSA.LootContainer)
		  Var Bound As Integer = Containers.LastIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As String
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Containers(I).SortValue.ToString(Locale.Raw, "0000") + Containers(I).Label + Containers(I).ClassString
		  Next
		  
		  Order.SortWith(Containers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Overrides() As ArkSA.LootDropOverride)
		  Var Bound As Integer = Overrides.LastIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As String
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Overrides(I).SortValue.ToString(Locale.Raw, "0000") + Overrides(I).Label + Overrides(I).LootDropReference.ClassString
		  Next
		  
		  Order.SortWith(Overrides)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sort(Extends Qualities() As ArkSA.Quality)
		  Var Bound As Integer = Qualities.LastIndex
		  If Bound = -1 Then
		    Return
		  End If
		  
		  Var Order() As Double
		  Order.ResizeTo(Bound)
		  For I As Integer = 0 To Bound
		    Order(I) = Qualities(I).BaseValue
		  Next
		  
		  Order.SortWith(Qualities)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TagString(Extends Blueprint As ArkSA.Blueprint) As String
		  Var Tags() As String = Blueprint.Tags
		  If Tags.IndexOf("object") = -1 Then
		    Tags.AddAt(0, "object")
		  End If
		  Return Tags.Join(",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Extends Blueprint As ArkSA.MutableBlueprint, Assigns Value As String)
		  Var Tags() As String = Value.Split(",")
		  Var Idx As Integer = Tags.IndexOf("object")
		  If Idx > -1 Then
		    Tags.RemoveAt(Idx)
		  End If
		  Blueprint.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnknownBlueprintPath(FolderName As String, ClassString As String) As String
		  Var ClassName As String
		  If ClassString.EndsWith("_C") Then
		    ClassName = ClassString.Left(ClassString.Length - 2)
		  Else
		    ClassName = ClassString
		  End If
		  
		  Return ArkSA.UnknownBlueprintPrefix + FolderName + "/" + ClassName + "." + ClassName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnpackBlueprint(Dict As Dictionary) As ArkSA.MutableBlueprint
		  Var Group As String
		  If Dict.HasKey("engramId") Then
		    Group = ArkSA.CategoryEngrams
		  ElseIf Dict.HasKey("creatureId") Then
		    Group = ArkSA.CategoryCreatures
		  ElseIf Dict.HasKey("spawnPointId") Then
		    Group = ArkSA.CategorySpawnPoints
		  ElseIf Dict.HasKey("lootDropId") Then
		    Group = ArkSA.CategoryLootContainers
		  ElseIf Dict.HasKey("group") Then
		    Group = Dict.Value("group")
		  End If
		  
		  Var Destination As ArkSA.MutableBlueprint
		  Select Case Group
		  Case ArkSA.CategoryEngrams
		    Destination = New ArkSA.MutableEngram
		  Case ArkSA.CategoryCreatures
		    Destination = New ArkSA.MutableCreature
		  Case ArkSA.CategorySpawnPoints, "spawnPoints"
		    Destination = New ArkSA.MutableSpawnPoint
		  Case ArkSA.CategoryLootContainers, "loot_sources", "lootDrops"
		    Destination = New ArkSA.MutableLootContainer
		  Else
		    Return Nil
		  End Select
		  
		  If Destination.CopyFrom(Dict) Then
		    Return Destination
		  Else
		    Return Nil
		  End If
		  
		  Exception Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Unpacking blueprint")
		    Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, RequiredHeaders() As Beacon.StringList) As String()
		  Var MissingHeaders() As String
		  For Each HeaderChoices As Beacon.StringList In RequiredHeaders
		    Var Found As Boolean = False
		    For Each HeaderChoice As String In HeaderChoices
		      If Content.IndexOf("[" + HeaderChoice + "]") > -1 Then
		        Found = True
		        Exit
		      End If
		    Next
		    
		    If Found = False Then
		      MissingHeaders.Add("[" + HeaderChoices(0) + "]")
		    End If
		  Next HeaderChoices
		  MissingHeaders.Sort
		  Return MissingHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateIniContent(Content As String, Filename As String) As String()
		  Var RequiredHeaders() As Beacon.StringList
		  If Filename = ArkSA.ConfigFileGame Then
		    RequiredHeaders = Array(New Beacon.StringList(ArkSA.HeaderShooterGame, ArkSA.HeaderShooterGameUWP))
		  ElseIf Filename = ArkSA.ConfigFileGameUserSettings Then
		    RequiredHeaders = Array(New Beacon.StringList(ArkSA.HeaderSessionSettings), New Beacon.StringList(ArkSA.HeaderServerSettings), New Beacon.StringList(ArkSA.HeaderShooterGameUserSettings))
		  End If
		  Return ArkSA.ValidateIniContent(Content, RequiredHeaders)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Extends Blueprint As ArkSA.Blueprint, Map As ArkSA.Map) As Boolean
		  Return Map Is Nil Or Blueprint.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Extends Blueprint As ArkSA.MutableBlueprint, Map As ArkSA.Map, Assigns Value As Boolean)
		  If (Map Is Nil) = False Then
		    Blueprint.ValidForMask(Map.Mask) = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Extends Blueprint As ArkSA.Blueprint, Mask As UInt64) As Boolean
		  Return Mask = CType(0, UInt64) Or (Blueprint.Availability And Mask) > CType(0, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMask(Extends Blueprint As ArkSA.MutableBlueprint, Mask As UInt64, Assigns Value As Boolean)
		  Var Availability As UInt64 = Blueprint.Availability
		  If Value Then
		    Availability = Availability Or Mask
		  Else
		    Availability = Availability And Not Mask
		  End If
		  If Availability <> Blueprint.Availability Then
		    Blueprint.Availability = Availability
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForProject(Extends Blueprint As ArkSA.Blueprint, Project As ArkSA.Project) As Boolean
		  Return (Project Is Nil) = False And Project.ContentPackEnabled(Blueprint.ContentPackId)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprintProviders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModFilenameSearcher As RegEx
	#tag EndProperty


	#tag Constant, Name = CategoryCreatures, Type = String, Dynamic = False, Default = \"creatures", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryEngrams, Type = String, Dynamic = False, Default = \"engrams", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategoryLootContainers, Type = String, Dynamic = False, Default = \"loot_containers", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CategorySpawnPoints, Type = String, Dynamic = False, Default = \"spawn_points", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileGame, Type = String, Dynamic = False, Default = \"Game.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ConfigFileGameUserSettings, Type = String, Dynamic = False, Default = \"GameUserSettings.ini", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Enabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagMatchAny, Type = Double, Dynamic = False, Default = \"31", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagMatchBlueprintId, Type = Double, Dynamic = False, Default = \"16", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagMatchClass, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagMatchLabel, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagMatchPath, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagMatchUnlockString, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FullName, Type = String, Dynamic = False, Default = \"Ark: Survival Ascended", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderServerSettings, Type = String, Dynamic = False, Default = \"ServerSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderSessionSettings, Type = String, Dynamic = False, Default = \"SessionSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderShooterGame, Type = String, Dynamic = False, Default = \"/script/shootergame.shootergamemode", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderShooterGameUserSettings, Type = String, Dynamic = False, Default = \"/Script/ShooterGame.ShooterGameUserSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HeaderShooterGameUWP, Type = String, Dynamic = False, Default = \"ShooterGameMode_Options", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Identifier, Type = String, Dynamic = False, Default = \"ArkSA", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OmniFlag, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SteamAppId, Type = Double, Dynamic = False, Default = \"2399830", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SteamServerId, Type = Double, Dynamic = False, Default = \"2430930", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UnknownBlueprintPrefix, Type = String, Dynamic = False, Default = \"/BeaconUserBlueprints/", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackId, Type = String, Dynamic = False, Default = \"b2362c68-abcf-4dc2-93b1-5d39074e48b3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackName, Type = String, Dynamic = False, Default = \"Ark: Survival Ascended User Content", Scope = Protected
	#tag EndConstant


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
