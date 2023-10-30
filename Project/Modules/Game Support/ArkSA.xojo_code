#tag Module
Protected Module ArkSA
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

	#tag Method, Flags = &h21
		Private Function AddToArchive(Archive As Beacon.Archive, ContentPack As Beacon.ContentPack, Blueprints() As ArkSA.Blueprint) As String
		  If Archive Is Nil Or ContentPack Is Nil Or Blueprints Is Nil Or Blueprints.Count = 0 Then
		    Return ""
		  End If
		  
		  Var Packs(0) As Dictionary
		  Packs(0) = ContentPack.SaveData
		  
		  Var Payloads(0) As Dictionary
		  Payloads(0) = New Dictionary("gameId": ArkSA.Identifier, "contentPacks": Packs)
		  
		  Var Engrams(), Creatures(), SpawnPoints(), LootDrops() As Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var Packed As Dictionary = Blueprint.Pack
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
		  Var Path As String
		  If Matches.SubExpressionCount >= 4 And Matches.SubExpressionString(4).IsEmpty = False Then
		    Path = Matches.SubExpressionString(4)
		  ElseIf Matches.SubExpressionCount >= 6 And Matches.SubExpressionString(6).IsEmpty = False Then
		    Path = Matches.SubExpressionString(6)
		  ElseIf Matches.SubExpressionCount >= 8 And Matches.SubExpressionString(8).IsEmpty = False Then
		    Path = Matches.SubExpressionString(8)
		  End If
		  If Path.IsEmpty = False And Path.EndsWith("_C") Then
		    Path = Path.Left(Path.Length - 2)
		  End If
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
		    Regex.SearchPattern = "(giveitem|spawndino)?\s*(([" + QuotationCharacters + "]Blueprint[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "]BlueprintGeneratedClass[" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)_C[" + QuotationCharacters + "]{2})|([" + QuotationCharacters + "](/Game/[^\<\>\:" + QuotationCharacters + "\\\|\?\*]+)[" + QuotationCharacters + "]))"
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

	#tag Method, Flags = &h21
		Private Function BuildExport(ContentPacks() As Beacon.ContentPack, Archive As Beacon.Archive, IsUserData As Boolean) As Boolean
		  Var Filenames() As String
		  Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		  For Each ContentPack As Beacon.ContentPack In ContentPacks
		    Var Blueprints() As ArkSA.Blueprint = DataSource.GetBlueprints("", New Beacon.StringList(ContentPack.ContentPackId), "")
		    Var Filename As String = AddToArchive(Archive, ContentPack, Blueprints)
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
		Protected Function BuildExport(ContentPacks() As Beacon.ContentPack, IsUserData As Boolean) As MemoryBlock
		  If ContentPacks Is Nil Or ContentPacks.Count = 0 Then
		    App.Log("Could not export blueprints because there are no mods to export.")
		    Return Nil
		  End If
		  
		  Var Archive As Beacon.Archive = Beacon.Archive.Create()
		  Var Success As Boolean = BuildExport(ContentPacks, Archive, IsUserData)
		  Var Mem As MemoryBlock = Archive.Finalize
		  If Success Then
		    Return Mem
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(ContentPacks() As Beacon.ContentPack, Destination As FolderItem, IsUserData As Boolean) As Boolean
		  If ContentPacks Is Nil Or ContentPacks.Count = 0 Or Destination Is Nil Then
		    App.Log("Could not export blueprints because the destination is invalid or there are no mods to export.")
		    Return False
		  End If
		  
		  Var Temp As FolderItem = FolderItem.TemporaryFile
		  Var Archive As Beacon.Archive = Beacon.Archive.Create(Temp)
		  Var Success As Boolean = BuildExport(ContentPacks, Archive, IsUserData)
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
		Protected Function BuildExport(IsUserData As Boolean, ParamArray ContentPacks() As Beacon.ContentPack) As MemoryBlock
		  Return BuildExport(ContentPacks, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(Destination As FolderItem, IsUserData As Boolean, ParamArray Blueprints() As ArkSA.Blueprint) As Boolean
		  Return BuildExport(Blueprints, Destination, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuildExport(Destination As FolderItem, IsUserData As Boolean, ParamArray ContentPacks() As Beacon.ContentPack) As Boolean
		  Return BuildExport(ContentPacks, Destination, IsUserData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Categories() As String()
		  Return Array(ArkSA.CategoryEngrams, ArkSA.CategoryCreatures, ArkSA.CategorySpawnPoints, ArkSA.CategoryLootContainers)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ClassStringFromPath(Path As String) As String
		  If Path.Length <= 6 Or Path.Left(6) <> "/Game/" Then
		    Return EncodeHex(Crypto.MD5(Path)).Lowercase
		  End If
		  
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

	#tag Method, Flags = &h0
		Function CopyFrom(Extends Destination As ArkSA.MutableBlueprint, Source As ArkSA.Blueprint) As Boolean
		  If Source Is Nil Then
		    Return False
		  End If
		  
		  Var Packed As Dictionary = Source.Pack
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

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Creatures() As ArkSA.Creature, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategoryCreatures, Creatures, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Engrams() As ArkSA.Engram, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategoryEngrams, Engrams, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends Containers() As ArkSA.LootContainer, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategoryLootContainers, Containers, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Disambiguate(Extends SpawnPoints() As ArkSA.SpawnPoint, EnabledMaps As UInt64) As Dictionary
		  Return Disambiguate(CategorySpawnPoints, SpawnPoints, EnabledMaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Disambiguate(Category As String, Blueprints() As ArkSA.Blueprint, EnabledMaps As UInt64) As Dictionary
		  // Items in Blueprints() are always included, regardless of maps.
		  
		  Var Results As New Dictionary
		  For Idx As Integer = 0 To Blueprints.LastIndex
		    Results.Value(Blueprints(Idx).BlueprintId) = Blueprints(Idx).Label
		  Next Idx
		  
		  Var All() As ArkSA.Blueprint = ArkSA.DataSource.Pool.Get(False).GetBlueprints(Category, "", New Beacon.StringList, "")
		  Var Labels As New Dictionary
		  For Idx As Integer = 0 To All.LastIndex
		    If All(Idx).ValidForMask(EnabledMaps) = False And Results.HasKey(All(Idx).BlueprintId) = False Then
		      Continue For Idx
		    End If
		    
		    Var Siblings() As ArkSA.Blueprint
		    If Labels.HasKey(All(Idx).Label) Then
		      Siblings = Labels.Value(All(Idx).Label)
		    End If
		    Siblings.Add(All(Idx))
		    Labels.Value(All(Idx).Label) = Siblings
		  Next Idx
		  
		  For Each Entry As DictionaryEntry In Labels
		    Var Siblings() As ArkSA.Blueprint = Entry.Value
		    
		    If Siblings.Count = 1 Then
		      Continue For Entry
		    End If
		    
		    Var Specifiers() As String
		    Var UseClassStrings As Boolean
		    For Idx As Integer = 0 To Siblings.LastIndex
		      If Specifiers.IndexOf(Siblings(Idx).ContentPackName) > -1 Then
		        UseClassStrings = True
		        Exit For Idx
		      Else
		        Specifiers.Add(Siblings(Idx).ContentPackName)
		      End If
		    Next Idx
		    
		    For Idx As Integer = 0 To Siblings.LastIndex
		      Results.Value(Siblings(Idx).BlueprintId) = Siblings(Idx).Label.Disambiguate(If(UseClassStrings, Siblings(Idx).ClassString, Siblings(Idx).ContentPackName))
		    Next Idx
		  Next Entry
		  
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExtractPath(Source As String) As String
		  Var Matches As RegExMatch = BlueprintPathRegex.Search(Source)
		  Return ArkSA.BlueprintPath(Matches)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateBlueprintId(ContentPackId As String, Path As String) As String
		  Return Beacon.UUID.v5(ContentPackId.Lowercase + ":" + Path.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash(Extends Blueprint As ArkSA.Blueprint) As String
		  #if DebugBuild
		    Return Beacon.GenerateJSON(ArkSA.PackBlueprint(Blueprint), True)
		  #else
		    Return EncodeHex(Crypto.SHA1(Beacon.GenerateJSON(ArkSA.PackBlueprint(Blueprint), False))).Lowercase
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
		  ElseIf Names.Count = 1 Then
		    Return Names(0)
		  ElseIf Names.Count = 2 Then
		    Return Names(0) + " & " + Names(1)
		  Else
		    Var Tail As String = Names(Names.LastIndex)
		    Names.RemoveAt(Names.LastIndex)
		    Return Names.Join(", ") + ", & " + Tail
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
		Function Matches(Extends Blueprint As ArkSA.Blueprint, Rx As PCRE2CodeMBS) As Boolean
		  Return (Rx.Match(Blueprint.Path) Is Nil) = False Or (Rx.Match(Blueprint.ClassString) Is Nil) = False Or (Rx.Match(Blueprint.Label) Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Extends Blueprint As ArkSA.Blueprint, Filter As String) As Boolean
		  Return Blueprint.Path.IndexOf(Filter) > -1 Or Blueprint.Path.IndexOf(Filter) > -1 Or Blueprint.Label.IndexOf(Filter) > -1
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
		Function Pack(Extends Blueprint As ArkSA.Blueprint) As Dictionary
		  Return PackBlueprint(Blueprint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PackBlueprint(Blueprint As ArkSA.Blueprint) As Dictionary
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
		  Blueprint.Pack(Dict)
		  
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
		Protected Function ParseCommandLine1(CommandLine As String, PreserveSyntax As Boolean = False) As Dictionary
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
		Protected Function ResolveCreature(Dict As Dictionary, CreatureIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As ArkSA.Creature
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
		  
		  Return ArkSA.ResolveCreature(CreatureId, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveCreature(CreatureId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.Creature
		  If CreatureId.IsEmpty = False Then
		    Try
		      Var Creature As ArkSA.Creature = ArkSA.DataSource.Pool.Get(False).GetCreature(CreatureId)
		      If (Creature Is Nil) = False Then
		        Return Creature
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Creatures() As ArkSA.Creature = ArkSA.DataSource.Pool.Get(False).GetCreaturesByPath(Path, ContentPacks)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Creatures() As ArkSA.Creature = ArkSA.DataSource.Pool.Get(False).GetCreaturesByClass(ClassString, ContentPacks)
		      If Creatures.Count > 0 Then
		        Return Creatures(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveCreature(CreatureId, Path, ClassString, Nil)
		  End If
		  
		  Return ArkSA.Creature.CreateCustom(CreatureId, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(Dict As Dictionary, EngramIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As ArkSA.Engram
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
		  
		  Return ArkSA.ResolveEngram(EngramId, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveEngram(EngramId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.Engram
		  If EngramId.IsEmpty = False Then
		    Try
		      Var Engram As ArkSA.Engram = ArkSA.DataSource.Pool.Get(False).GetEngram(EngramId)
		      If (Engram Is Nil) = False Then
		        Return Engram
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var Engrams() As ArkSA.Engram = ArkSA.DataSource.Pool.Get(False).GetEngramsByPath(Path, ContentPacks)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var Engrams() As ArkSA.Engram = ArkSA.DataSource.Pool.Get(False).GetEngramsByClass(ClassString, ContentPacks)
		      If Engrams.Count > 0 Then
		        Return Engrams(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveEngram(EngramId, Path, ClassString, Nil)
		  End If
		  
		  Return ArkSA.Engram.CreateCustom(EngramId, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(Dict As Dictionary, LootDropIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As ArkSA.LootContainer
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
		  
		  Return ArkSA.ResolveLootContainer(LootDropId, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveLootContainer(LootDropId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.LootContainer
		  If LootDropId.IsEmpty = False Then
		    Try
		      Var LootContainer As ArkSA.LootContainer = ArkSA.DataSource.Pool.Get(False).GetLootContainer(LootDropId)
		      If (LootContainer Is Nil) = False Then
		        Return LootContainer
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var LootContainers() As ArkSA.LootContainer = ArkSA.DataSource.Pool.Get(False).GetLootContainersByPath(Path, ContentPacks)
		      If LootContainers.Count > 0 Then
		        Return LootContainers(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var LootContainers() As ArkSA.LootContainer = ArkSA.DataSource.Pool.Get(False).GetLootContainersByClass(ClassString, ContentPacks)
		      If LootContainers.Count > 0 Then
		        Return LootContainers(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveLootContainer(LootDropId, Path, ClassString, Nil)
		  End If
		  
		  Return ArkSA.LootContainer.CreateCustom(LootDropId, Path, ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(Dict As Dictionary, SpawnPointIdKey As String, PathKey As String, ClassKey As String, ContentPacks As Beacon.StringList) As ArkSA.SpawnPoint
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
		  
		  Return ArkSA.ResolveSpawnPoint(SpawnPointId, Path, ClassString, ContentPacks)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ResolveSpawnPoint(SpawnPointId As String, Path As String, ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.SpawnPoint
		  If SpawnPointId.IsEmpty = False Then
		    Try
		      Var SpawnPoint As ArkSA.SpawnPoint = ArkSA.DataSource.Pool.Get(False).GetSpawnPoint(SpawnPointId)
		      If (SpawnPoint Is Nil) = False Then
		        Return SpawnPoint
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If Path.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As ArkSA.SpawnPoint = ArkSA.DataSource.Pool.Get(False).GetSpawnPointsByPath(Path, ContentPacks)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ClassString.IsEmpty = False Then
		    Try
		      Var SpawnPoints() As ArkSA.SpawnPoint = ArkSA.DataSource.Pool.Get(False).GetSpawnPointsByClass(ClassString, ContentPacks)
		      If SpawnPoints.Count > 0 Then
		        Return SpawnPoints(0)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    // Could not find it using the enabled mods, so let's look through everything
		    Return ResolveSpawnPoint(SpawnPointId, Path, ClassString, Nil)
		  End If
		  
		  Return ArkSA.SpawnPoint.CreateCustom(SpawnPointId, Path, ClassString)
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

	#tag Constant, Name = UnknownBlueprintPrefix, Type = String, Dynamic = False, Default = \"/Game/BeaconUserBlueprints/", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackId, Type = String, Dynamic = False, Default = \"b2362c68-abcf-4dc2-93b1-5d39074e48b3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UserContentPackName, Type = String, Dynamic = False, Default = \"User Blueprints", Scope = Protected
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
