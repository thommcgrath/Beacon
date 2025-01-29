#tag Class
Protected Class DataSource
Inherits Beacon.DataSource
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub BuildSchema()
		  Self.SQLExecute("CREATE TABLE loot_icons (icon_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, icon_data BLOB NOT NULL, label TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_containers (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, last_update INTEGER NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT COLLATE NOCASE NOT NULL, sort_order INTEGER NOT NULL, icon TEXT COLLATE NOCASE REFERENCES loot_icons(icon_id) ON UPDATE CASCADE ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED, experimental BOOLEAN NOT NULL, notes TEXT NOT NULL, requirements TEXT NOT NULL DEFAULT '{}', min_item_sets INTEGER NOT NULL DEFAULT 1, max_item_sets INTEGER NOT NULL DEFAULT 1, prevent_duplicates BOOLEAN NOT NULL DEFAULT 1, contents TEXT NOT NULL DEFAULT '[]');")
		  Self.SQLExecute("CREATE TABLE loot_container_selectors (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, language TEXT COLLATE NOCASE NOT NULL, code TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE engrams (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, last_update INTEGER NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', entry_string TEXT COLLATE NOCASE, required_level INTEGER, required_points INTEGER, stack_size INTEGER, item_id INTEGER, recipe TEXT NOT NULL DEFAULT '[]');")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE creatures (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, last_update INTEGER NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', incubation_time REAL, mature_time REAL, stats TEXT, used_stats INTEGER, mating_interval_min REAL, mating_interval_max REAL);")
		  Self.SQLExecute("CREATE TABLE maps (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, ark_identifier TEXT COLLATE NOCASE NOT NULL UNIQUE, difficulty_scale REAL NOT NULL, official BOOLEAN NOT NULL, mask BIGINT NOT NULL UNIQUE, sort INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE spawn_points (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, last_update INTEGER NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', sets TEXT NOT NULL DEFAULT '[]', limits TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE spawn_point_populations (population_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, spawn_point_id TEXT COLLATE NOCASE NOT NULL REFERENCES spawn_points(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, map_id TEXT COLLATE NOCASE NOT NULL REFERENCES maps(ark_identifier) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, instances INTEGER NOT NULL, target_population INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE ini_options (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', native_editor_version INTEGER, file TEXT COLLATE NOCASE NOT NULL, header TEXT COLLATE NOCASE NOT NULL, key TEXT COLLATE NOCASE NOT NULL, value_type TEXT COLLATE NOCASE NOT NULL, max_allowed INTEGER, description TEXT NOT NULL, default_value TEXT, nitrado_path TEXT COLLATE NOCASE, nitrado_format TEXT COLLATE NOCASE, nitrado_deploy_style TEXT COLLATE NOCASE, ui_group TEXT COLLATE NOCASE, custom_sort TEXT COLLATE NOCASE, constraints TEXT, gsa_placeholder TEXT COLLATE NOCASE, uwp_changes TEXT);")
		  Self.SQLExecute("CREATE TABLE events (event_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, ark_code TEXT NOT NULL, rates TEXT NOT NULL, colors TEXT NOT NULL, engrams TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE colors (color_id INTEGER NOT NULL PRIMARY KEY, color_uuid TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, hex_value TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE color_sets (color_set_id TEXT COLLATE NOCASE PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL);")
		  
		  Var Categories() As String = Ark.Categories
		  For Each Category As String In Categories
		    Self.SQLExecute("CREATE TABLE tags_" + Category + " (object_id TEXT COLLATE NOCASE NOT NULL REFERENCES " + Category + "(object_id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, tag TEXT COLLATE NOCASE NOT NULL, PRIMARY KEY (object_id, tag));")
		  Next Category
		  
		  Self.ReplaceUserBlueprints()
		End Sub
	#tag EndEvent

	#tag Event
		Sub CloudSyncFinished(Actions() As Dictionary)
		  Var PossibleFilenames() As String = Self.PossibleBlueprintFilenames()
		  For Each Dict As Dictionary In Actions
		    Var Action As String = Dict.Value("Action")
		    Var Path As String = Dict.Value("Path")
		    Var Remote As Boolean = Dict.Value("Remote")
		    
		    If Remote And PossibleFilenames.IndexOf(Path) > -1 And (Action = "GET" Or Action = "DELETE") Then
		      Self.ImportCloudFiles()
		      Return
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function DefineIndexes() As Beacon.DataIndex()
		  Var Indexes() As Beacon.DataIndex
		  Var Categories() As String = Ark.Categories
		  For Each Category As String In Categories
		    Indexes.Add(New Beacon.DataIndex(Category, True, "content_pack_id", "path"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "path"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "class_string"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "content_pack_id"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "label"))
		    Indexes.Add(New Beacon.DataIndex("tags_" + Category, False, "object_id"))
		    Indexes.Add(New Beacon.DataIndex("tags_" + Category, False, "tag"))
		  Next
		  
		  Indexes.Add(New Beacon.DataIndex("maps", False, "content_pack_id"))
		  Indexes.Add(New Beacon.DataIndex("loot_containers", False, "sort_order"))
		  
		  Indexes.Add(New Beacon.DataIndex("engrams", False, "entry_string"))
		  Indexes.Add(New Beacon.DataIndex("ini_options", True, "file", "header", "key"))
		  Indexes.Add(New Beacon.DataIndex("events", True, "ark_code"))
		  Indexes.Add(New Beacon.DataIndex("events", False, "label"))
		  Indexes.Add(New Beacon.DataIndex("colors", True, "color_uuid"))
		  Indexes.Add(New Beacon.DataIndex("colors", False, "label"))
		  Indexes.Add(New Beacon.DataIndex("color_sets", False, "label"))
		  Indexes.Add(New Beacon.DataIndex("color_sets", True, "class_string"))
		  
		  Indexes.Add(New Beacon.DataIndex("spawn_point_populations", False, "spawn_point_id"))
		  Indexes.Add(New Beacon.DataIndex("spawn_point_populations", True, "spawn_point_id", "map_id"))
		  
		  Return Indexes
		End Function
	#tag EndEvent

	#tag Event
		Function DeleteContentPack(ContentPackId As String) As Boolean
		  If ContentPackId = Ark.UserContentPackId Then
		    Self.DeleteDataForContentPack(ContentPackId)
		    Return True
		  End If
		  
		  Self.BeginTransaction()
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT content_pack_id FROM content_packs WHERE content_pack_id = ?1 AND type = ?2;", ContentPackId, Beacon.ContentPack.TypeLocal)
		  If Rows.RowCount = 0 Then
		    Self.RollbackTransaction()
		    Return False
		  End If
		  
		  Self.DeleteDataForContentPack(ContentPackId)
		  Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id = ?1;", ContentPackId)
		  Self.CommitTransaction()
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub EmptyCaches()
		  Self.mBlueprintCache = New Dictionary
		  Self.mConfigOptionCache = New Dictionary
		  Self.mContainerLabelCacheDict = New Dictionary
		  Self.mContainerLabelCacheMask = 0
		  Self.mIconCache = New Dictionary
		  Self.mSpawnLabelCacheDict = New Dictionary
		  Self.mSpawnLabelCacheMask = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub ExportCloudFiles()
		  #if DebugBuild
		    Const CleanupLegacyFiles = True
		  #else
		    Const CleanupLegacyFiles = Not App.UsePreviewMode
		  #endif
		  
		  // Clean up legacy stuff
		  #if CleanupLegacyFiles
		    Var LegacyFiles() As String = Array("/Blueprints.json", "/Engrams.json", "/Ark/Blueprints.json")
		    For Each LegacyFile As String In LegacyFiles
		      If UserCloud.FileExists(LegacyFile) Then
		        Call UserCloud.Delete(LegacyFile)
		      End If
		    Next
		  #endif
		  
		  Const Filename = "/Ark/Blueprints" + Beacon.FileExtensionDelta
		  Var UserPacks() As Beacon.ContentPack = Self.GetContentPacks(Beacon.ContentPack.TypeLocal)
		  If UserPacks.Count = 0 Then
		    Call UserCloud.Delete(Filename)
		    Return
		  End If
		  
		  Var Writer As UserCloud.FileWriter = UserCloud.GetWriter(Filename)
		  If Writer Is Nil Then
		    Return
		  End If
		  
		  If Beacon.BuildExport(UserPacks, Writer.LocalFile, True) = False Then
		    Call UserCloud.Delete(Filename)
		    Return
		  End If
		  
		  Call UserCloud.Write(Writer)
		End Sub
	#tag EndEvent

	#tag Event
		Function GetSchemaVersion() As Integer
		  Return 204
		End Function
	#tag EndEvent

	#tag Event
		Function Import(ChangeDict As Dictionary, StatusData As Dictionary, IsUserData As Boolean) As Boolean
		  Var BuildNumber As Integer = App.BuildNumber
		  
		  Var InitialChanges As Integer
		  Try
		    InitialChanges = Self.TotalChanges()
		  Catch Err As RuntimeException
		    InitialChanges = -1
		  End Try
		  
		  Var EngramsChanged As Boolean
		  If ChangeDict.HasKey("deletions") Then
		    Var Deletions() As Variant = ChangeDict.Value("deletions")
		    Var DeleteOrder() As String = Array(Ark.CategoryLootContainers, Ark.CategorySpawnPoints, Ark.CategoryCreatures, Ark.CategoryEngrams, "loot_icons", "maps", "colors", "events", "ini_options", "mods")
		    Var DeleteGroups As New Dictionary
		    For Each Deletion As Dictionary In Deletions
		      Var ObjectId As String = Deletion.Value("objectId").StringValue
		      Var Group As String = Deletion.Value("group").StringValue
		      Select Case Group
		      Case "loot_sources", "lootDrops", "loot_drops"
		        Group = Ark.CategoryLootContainers
		      Case "spawnPoints"
		        Group = Ark.CategorySpawnPoints
		      End Select
		      
		      Var Siblings() As String
		      If DeleteGroups.HasKey(Group) Then
		        Siblings = DeleteGroups.Value(Group)
		      End If
		      Siblings.Add(ObjectId)
		      DeleteGroups.Value(Group) = Siblings
		    Next Deletion
		    
		    For Each Group As String In DeleteOrder
		      If DeleteGroups.HasKey(Group) = False Then
		        Continue
		      End If
		      Var ObjectIds() As String = DeleteGroups.Value(Group)
		      If ObjectIds.Count = 0 Then
		        Continue
		      End If
		      
		      Select Case Group
		      Case Ark.CategoryLootContainers, Ark.CategorySpawnPoints, Ark.CategoryCreatures, Ark.CategoryEngrams
		        If Self.SaveBlueprints(Nil, ObjectIds, Nil, False, False) Then
		          EngramsChanged = True
		        End If
		      Case "loot_icons"
		        Self.SQLExecute("DELETE FROM loot_icons WHERE icon_id IN ('" + String.FromArray(ObjectIds, "','") + "');")
		      Case "mods"
		        Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id IN ('" + String.FromArray(ObjectIds, "','") + "');")
		      Case "maps"
		        Self.SQLExecute("DELETE FROM maps WHERE object_id IN ('" + String.FromArray(ObjectIds, "','") + "');")
		      Case "colors"
		        Self.SQLExecute("DELETE FROM colors WHERE color_uuid IN ('" + String.FromArray(ObjectIds, "','") + "');")
		      Case "events"
		        Self.SQLExecute("DELETE FROM events WHERE event_id IN ('" + String.FromArray(ObjectIds, "','") + "');")
		      Case "ini_options"
		        Self.SQLExecute("DELETE FROM ini_options WHERE object_id IN ('" + String.FromArray(ObjectIds, "','") + "');")
		      End Select
		    Next
		  End If
		  
		  If ChangeDict.HasKey("contentPacks") Then
		    Var ContentPacks() As Variant = ChangeDict.Value("contentPacks")
		    For Each Dict As Dictionary In ContentPacks
		      Var MinVersion As Double = Dict.Value("minVersion")
		      If MinVersion > BuildNumber Then
		        Continue
		      End If
		      
		      Var Pack As Beacon.ContentPack = Beacon.ContentPack.FromSaveData(Dict)
		      Call Self.SaveContentPack(Pack, False)
		    Next
		  End If
		  
		  // Blueprints must be saved after each chunk, otherwise they can't find each other.
		  
		  If ChangeDict.HasKey("lootDropIcons") Then
		    Var LootSourceIcons() As Variant = ChangeDict.Value("lootDropIcons")
		    For Each Dict As Dictionary In LootSourceIcons
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var IconId As String = Dict.Value("lootDropIconId")
		      Var IconData As MemoryBlock = DecodeBase64(Dict.Value("iconData"))
		      Var IconLabel As String = Dict.Value("label").StringValue
		      
		      IconId = IconId.Lowercase
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT icon_id FROM loot_icons WHERE icon_id = ?1;", IconId)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE loot_icons SET icon_data = ?2, label = ?3 WHERE icon_id = ?1;", IconId, IconData, IconLabel)
		      Else
		        Self.SQLExecute("INSERT INTO loot_icons (icon_id, icon_data, label) VALUES (?1, ?2, ?3);", IconId, IconData, IconLabel)
		      End If
		    Next Dict
		    If LootSourceIcons.LastIndex > -1 Then
		      Self.mIconCache = New Dictionary
		    End If
		  End If
		  
		  If ChangeDict.HasKey("engrams") Then
		    Var Blueprints() As Ark.Blueprint
		    Var Engrams() As Variant = ChangeDict.Value("engrams")
		    For Each Dict As Dictionary In Engrams
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var Engram As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		      If (Engram Is Nil) = False Then
		        Blueprints.Add(Engram)
		      End If
		    Next Dict
		    If Self.SaveBlueprints(Blueprints, Nil, Nil, False, False) Then
		      EngramsChanged = True
		    End If
		  End If
		  
		  If ChangeDict.HasKey("creatures") Then
		    Var Blueprints() As Ark.Blueprint
		    Var Creatures() As Variant = ChangeDict.Value("creatures")
		    For Each Dict As Dictionary In Creatures
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var Creature As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		      If (Creature Is Nil) = False Then
		        Blueprints.Add(Creature)
		      End If
		    Next Dict
		    If Self.SaveBlueprints(Blueprints, Nil, Nil, False, False) Then
		      EngramsChanged = True
		    End If
		  End If
		  
		  If ChangeDict.HasKey("lootDrops") Then
		    Var Blueprints() As Ark.Blueprint
		    Var LootSources() As Variant = ChangeDict.Value("lootDrops")
		    For Each Dict As Dictionary In LootSources
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var Container As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		      If (Container Is Nil) = False Then
		        Blueprints.Add(Container)
		      End If
		    Next Dict
		    If Self.SaveBlueprints(Blueprints, Nil, Nil, False, False) Then
		      EngramsChanged = True
		    End If
		  End If
		  
		  If ChangeDict.HasKey("spawnPoints") Then
		    Var Blueprints() As Ark.Blueprint
		    Var SpawnPoints() As Variant = ChangeDict.Value("spawnPoints")
		    For Each Dict As Dictionary In SpawnPoints
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var Point As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		      If (Point Is Nil) = False Then
		        Blueprints.Add(Point)
		        
		        Try
		          If Dict.HasKey("populations") And Dict.Value("populations").IsNull = False Then
		            Var Populations As Dictionary = Dict.Value("populations")
		            For Each Entry As DictionaryEntry In Populations
		              Var Figures As Dictionary = Entry.Value
		              Var MapIdentifier As String = Entry.Key
		              Var Instances As Integer = Figures.Value("instances")
		              Var TargetPopulation As Integer = Figures.Value("targetPopulation")
		              
		              Var Rows As RowSet = Self.SQLSelect("SELECT population_id FROM spawn_point_populations WHERE spawn_point_id = ?1 AND map_id = ?2;", Point.BlueprintId, MapIdentifier)
		              If Rows.RowCount = 1 Then
		                Var PopulationID As String = Rows.Column("population_id").StringValue
		                Self.SQLExecute("UPDATE spawn_point_populations SET instances = ?2, target_population = ?3 WHERE population_id = ?1 AND (instances != ?2 OR target_population != ?3);", PopulationID, Instances, TargetPopulation)
		              Else
		                Self.SQLExecute("INSERT INTO spawn_point_populations (population_id, spawn_point_id, map_id, instances, target_population) VALUES (?1, ?2, ?3, ?4, ?5);", Beacon.UUID.v4.StringValue, Point.BlueprintId, MapIdentifier, Instances, TargetPopulation)
		              End If
		            Next Entry
		          End If
		        Catch Err As RuntimeException
		          App.Log(Err, CurrentMethodName, "Parsing population figures")
		        End Try
		      End If
		    Next Dict
		    If Self.SaveBlueprints(Blueprints, Nil, Nil, False, False) Then
		      EngramsChanged = True
		    End If
		  End If
		  
		  If ChangeDict.HasKey("configOptions") Then
		    Self.mConfigOptionCache = New Dictionary
		    
		    Var Options() As Variant = ChangeDict.Value("configOptions")
		    For Each Dict As Dictionary In Options
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var ConfigOptionId As String = Dict.Value("configOptionId")
		      Var ContentPackId As String = Dict.Value("contentPackId")
		      Var File As String = Dict.Value("file")
		      Var Header As String = Dict.Value("header")
		      Var Key As String = Dict.Value("key")
		      Var TagString, TagStringForSearching As String
		      Try
		        Var Tags() As String
		        Var Temp() As Variant = Dict.Value("tags")
		        For Each Tag As String In Temp
		          Tags.Add(Tag)
		        Next
		        TagString = Tags.Join(",")
		        Tags.AddAt(0, "object")
		        TagStringForSearching = Tags.Join(",")
		      Catch Err As RuntimeException
		        
		      End Try
		      
		      Var Values(20) As Variant
		      Values(0) = ConfigOptionId
		      Values(1) = Dict.Value("label")
		      Values(2) = ContentPackId
		      Values(3) = Dict.Value("nativeEditorVersion")
		      Values(4) = File
		      Values(5) = Header
		      Values(6) = Key
		      Values(7) = Dict.Value("valueType")
		      Values(8) = Dict.Value("maxAllowed")
		      Values(9) = Dict.Value("description")
		      Values(10) = Dict.Value("defaultValue")
		      Values(11) = Dict.Value("alternateLabel")
		      If Dict.HasKey("nitradoEquivalent") And IsNull(Dict.Value("nitradoEquivalent")) = False Then
		        Var NitradoEq As Dictionary = Dict.Value("nitradoEquivalent")
		        Values(12) = NitradoEq.Value("path")
		        Values(13) = NitradoEq.Value("format")
		        Values(14) = NitradoEq.Value("deployStyle")
		      Else
		        Values(12) = Nil
		        Values(13) = Nil
		        Values(14) = Nil
		      End If
		      Values(15) = TagString
		      If Dict.HasKey("uiGroup") Then
		        Values(16) = Dict.Value("uiGroup")
		      End If
		      If Dict.HasKey("customSort") Then
		        Values(17) = Dict.Value("customSort")
		      End If
		      If Dict.HasKey("constraints") And IsNull(Dict.Value("constraints")) = False Then
		        Try
		          Values(18) = Beacon.GenerateJSON(Dict.Value("constraints"), False)
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      If Dict.HasKey("gsaPlaceholder") And IsNull(Dict.Value("gsaPlaceholder")) = False Then
		        Values(19) = Dict.Value("gsaPlaceholder")
		      End If
		      If Dict.HasKey("uwpChanges") And IsNull(Dict.Value("uwpChanges")) = False Then
		        Try
		          Values(20) = Beacon.GenerateJSON(Dict.Value("uwpChanges"), False)
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM ini_options WHERE object_id = ?1 OR (file = ?2 AND header = ?3 AND key = ?4);", ConfigOptionId, File, Header, Key)
		      If Results.RowCount > 1 Then
		        Self.SQLExecute("DELETE FROM ini_options WHERE object_id = ?1 OR (file = ?2 AND header = ?3 AND key = ?4);", ConfigOptionId, File, Header, Key)
		      End If
		      If Results.RowCount = 1 Then
		        // Update
		        Var OriginalConfigOptionId As String = Results.Column("object_id").StringValue
		        Values.Add(OriginalConfigOptionId)
		        Self.SQLExecute("UPDATE ini_options SET object_id = ?1, label = ?2, content_pack_id = ?3, native_editor_version = ?4, file = ?5, header = ?6, key = ?7, value_type = ?8, max_allowed = ?9, description = ?10, default_value = ?11, alternate_label = ?12, nitrado_path = ?13, nitrado_format = ?14, nitrado_deploy_style = ?15, tags = ?16, ui_group = ?17, custom_sort = ?18, constraints = ?19, gsa_placeholder = ?20, uwp_changes = ?21 WHERE object_id = ?22;", Values)
		      Else
		        // Insert
		        Self.SQLExecute("INSERT INTO ini_options (object_id, label, content_pack_id, native_editor_version, file, header, key, value_type, max_allowed, description, default_value, alternate_label, nitrado_path, nitrado_format, nitrado_deploy_style, tags, ui_group, custom_sort, constraints, gsa_placeholder, uwp_changes) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14, ?15, ?16, ?17, ?18, ?19, ?20, ?21);", Values)
		      End If
		    Next Dict
		  End If
		  
		  If ChangeDict.HasKey("maps") Then
		    Var Maps() As Dictionary = ChangeDict.Value("maps").DictionaryArrayValue
		    For Each MapDict As Dictionary In Maps
		      Var MapId As String = MapDict.Value("mapId")
		      Var ContentPackId As String = MapDict.Value("contentPackId")
		      Var Label As String = MapDict.Value("label")
		      Var Identifier As String = MapDict.Value("arkIdentifier")
		      Var Difficulty As Double = MapDict.Value("difficultyScale")
		      Var Official As Boolean = MapDict.Value("isOfficial")
		      Var Mask As UInt64 = MapDict.Value("mask")
		      Var Sort As Integer = MapDict.Value("sortOrder")
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM maps WHERE object_id = ?1;", MapId)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE maps SET content_pack_id = ?2, label = ?3, ark_identifier = ?4, difficulty_scale = ?5, official = ?6, mask = ?7, sort = ?8 WHERE object_id = ?1;", MapId, ContentPackId, Label, Identifier, Difficulty, Official, Mask, Sort)
		      Else
		        Self.SQLExecute("INSERT INTO maps (object_id, content_pack_id, label, ark_identifier, difficulty_scale, official, mask, sort) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8);", MapId, ContentPackId, Label, Identifier, Difficulty, Official, Mask, Sort)
		      End If
		    Next
		    Ark.Maps.ClearCache
		  End If
		  
		  If ChangeDict.HasKey("gameVariables") Then
		    Var GameVariables() As Variant = ChangeDict.Value("gameVariables")
		    For Each Dict As Dictionary In GameVariables
		      Var Key As String = Dict.Value("key")
		      Var Value As String = Dict.Value("value")
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT key FROM game_variables WHERE key = ?1;", Key)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE game_variables SET value = ?2 WHERE key = ?1;", Key, Value)
		      Else
		        Self.SQLExecute("INSERT INTO game_variables (key, value) VALUES (?1, ?2);", Key, Value)
		      End If
		    Next
		  End If
		  
		  If ChangeDict.HasKey("colors") Then
		    Var Colors() As Variant = ChangeDict.Value("colors")
		    For Each Dict As Dictionary In Colors
		      Var ColorId As Integer = Dict.Value("colorId")
		      Var ColorUUID As String = Beacon.UUID.v5("color " + ColorID.ToString(Locale.Raw, "0"))
		      Var Label As String = Dict.Value("label")
		      Var HexValue As String = Dict.Value("code")
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT color_id FROM colors WHERE color_id = ?1 OR color_uuid = ?2;", ColorId, ColorUUID)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE colors SET color_uuid = ?2, label = ?3, hex_value = ?4 WHERE color_id = ?1;", ColorID, ColorUUID, Label, HexValue)
		      Else
		        Self.SQLExecute("INSERT INTO colors (color_id, color_uuid, label, hex_value) VALUES (?1, ?2, ?3, ?4);", ColorID, ColorUUID, Label, HexValue)
		      End If
		    Next
		  End If
		  
		  If ChangeDict.HasKey("colorSets") Then
		    Var ColorSets() As Variant = ChangeDict.Value("colorSets")
		    For Each Dict As Dictionary In ColorSets
		      Var ColorSetId As String = Dict.Value("colorSetId")
		      Var Label As String = Dict.Value("label")
		      Var ClassString As String = Dict.Value("classString")
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT color_set_id FROM color_sets WHERE color_set_id = ?1;", ColorSetId)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE color_sets SET label = ?2, class_string = ?3 WHERE color_set_id = ?1;", ColorSetId, Label, ClassString)
		      Else
		        Self.SQLExecute("INSERT INTO color_sets (color_set_id, label, class_string) VALUES (?1, ?2, ?3);", ColorSetId, Label, ClassString)
		      End If
		    Next Dict
		  End If
		  
		  If ChangeDict.HasKey("events") Then
		    Var Events() As Variant = ChangeDict.Value("events")
		    For Each Dict As Dictionary In Events
		      Var EventId As String = Dict.Value("eventId")
		      Var Label As String = Dict.Value("label")
		      Var ArkCode As String = Dict.Value("arkCode")
		      Var Rates As String = Beacon.GenerateJSON(Dict.Value("rates"), False)
		      Var Colors As String = Beacon.GenerateJSON(Dict.Value("colors"), False)
		      Var Engrams As String = Beacon.GenerateJSON(Dict.Value("engrams"), False)
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT event_id FROM events WHERE event_id = ?1;", EventId)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE events SET label = ?2, ark_code = ?3, rates = ?4, colors = ?5, engrams = ?6 WHERE event_id = ?1;", EventId, Label, ArkCode, Rates, Colors, Engrams)
		      Else
		        Self.SQLExecute("INSERT INTO events (event_id, label, ark_code, rates, colors, engrams) VALUES (?1, ?2, ?3, ?4, ?5, ?6);", EventId, Label, ArkCode, Rates, Colors, Engrams)
		      End If
		    Next Dict
		  End If
		  
		  Var TotalChanges As Integer
		  Try
		    TotalChanges = Self.TotalChanges()
		  Catch Err As RuntimeException
		    TotalChanges = -2
		  End Try
		  
		  If IsUserData And TotalChanges <> InitialChanges Then
		    Self.ExportCloudFiles()
		  End If
		  
		  StatusData.Value("Engrams Changed") = EngramsChanged
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub ImportCleanup(StatusData As Dictionary)
		  // Do not invalidate mBlueprints, it uses timestamps
		  Self.mConfigOptionCache = New Dictionary
		  Self.mSpawnLabelCacheDict = New Dictionary
		  Self.mIconCache = New Dictionary
		  Self.mContainerLabelCacheDict = New Dictionary
		  Self.mContainerLabelCacheMask = 0
		  
		  If StatusData.Lookup("Engrams Changed", False).BooleanValue Then
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  
		  Self.mOfficialPlayerLevelData = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub ImportCloudFiles()
		  Const ModeBinary = 3
		  Const ModeJson = 2
		  Const ModeLegacy = 1
		  Const ModeNone = 0
		  
		  Var Mode As Integer = ModeNone
		  Var PossibleFilenames() As String = Self.PossibleBlueprintFilenames()
		  Var EngramsContent As MemoryBlock
		  Var MatchedFilename As String
		  For Each Filename As String In PossibleFilenames
		    EngramsContent = UserCloud.Read(Filename)
		    If EngramsContent Is Nil Then
		      Continue
		    End If
		    
		    Select Case Filename
		    Case "/Ark/Blueprints" + Beacon.FileExtensionDelta
		      Mode = ModeBinary
		    Case "/Ark/Blueprints.json", "/Blueprints.json"
		      Mode = ModeJson
		    Case "/Engrams.json"
		      Mode = ModeLegacy
		    End Select
		    
		    MatchedFilename = Filename
		    Exit For Filename
		  Next
		  
		  Select Case Mode
		  Case ModeBinary
		    Self.BeginTransaction()
		    Var ContentPacks() As Beacon.ContentPack = Self.GetContentPacks(Beacon.ContentPack.TypeLocal)
		    Var PacksToRemove As New Dictionary
		    For Each ContentPack As Beacon.ContentPack In ContentPacks
		      PacksToRemove.Value(ContentPack.ContentPackId) = ContentPack
		    Next
		    If PacksToRemove.HasKey(Ark.UserContentPackId) Then
		      PacksToRemove.Remove(Ark.UserContentPackId)
		    End If
		    
		    Try
		      Var Importer As Ark.BlueprintImporter = Ark.BlueprintImporter.ImportAsBinary(EngramsContent)
		      If Importer Is Nil Then
		        App.Log("Could not import Ark cloud files because data file is damaged.")
		        Self.RollbackTransaction()
		        Return
		      End If
		      
		      // Import blueprints first so that SaveContentPack can migrate them if necessary
		      Var Blueprints() As Ark.Blueprint = Importer.Blueprints
		      Var BlueprintsToDelete() As String
		      If Self.SaveBlueprints(Blueprints, BlueprintsToDelete, Nil, True, False) = False Then
		        App.Log("There was an error saving blueprints to database.")
		        Self.RollbackTransaction()
		        Return
		      End If
		      
		      ContentPacks = Importer.ContentPacks
		      For Each ContentPack As Beacon.ContentPack In ContentPacks
		        Call Self.SaveContentPack(ContentPack, False)
		        If PacksToRemove.HasKey(ContentPack.ContentPackId) Then
		          PacksToRemove.Remove(ContentPack.ContentPackId)
		        End If
		      Next
		      
		      For Each Entry As DictionaryEntry In PacksToRemove
		        Call Self.DeleteContentPack(Entry.Key.StringValue, False)
		      Next
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Importing Ark user blueprints")
		      Self.RollbackTransaction()
		      Return
		    End Try
		    
		    Self.RunContentPackMigrations()
		    Self.CleanForeignKeyViolations()
		    
		    Self.CommitTransaction()
		  Case ModeJson
		    Var Blueprints() As Variant
		    Try
		      Var StringContent As String = EngramsContent
		      Blueprints = Beacon.ParseJSON(StringContent.DefineEncoding(Encodings.UTF8))
		    Catch Err As RuntimeException
		      Return
		    End Try
		    
		    Self.BeginTransaction()
		    Var Packs() As Beacon.ContentPack = Self.GetContentPacks(Beacon.ContentPack.TypeLocal)
		    Var KeepPacks As New Beacon.StringList
		    Var RemovePacks As New Beacon.StringList
		    For Idx As Integer = Packs.FirstIndex To Packs.LastIndex
		      If Packs(Idx).ContentPackId = Ark.UserContentPackId Then
		        KeepPacks.Append(Packs(Idx).ContentPackId)
		      Else
		        RemovePacks.Append(Packs(Idx).ContentPackId)
		      End If
		    Next
		    
		    Var Now As DateTime = DateTime.Now
		    Var Unpacked() As Ark.Blueprint
		    For Each Dict As Dictionary In Blueprints
		      Try
		        Var Blueprint As Ark.Blueprint = Ark.UnpackBlueprint(Dict)
		        If (Blueprint Is Nil) = False Then
		          Unpacked.Add(Blueprint)
		          KeepPacks.Append(Blueprint.ContentPackId)
		          RemovePacks.Remove(Blueprint.ContentPackId)
		        ElseIf Dict.HasAllKeys("mod_id", "name", "workshop_id") Then
		          Var ContentPackId As String = Dict.Value("mod_id").StringValue
		          KeepPacks.Append(ContentPackId)
		          RemovePacks.Remove(ContentPackId)
		          If ContentPackId <> Ark.UserContentPackId Then
		            Var Marketplace, MarketplaceId As String
		            If Dict.Value("workshop_id").IsNull = False Then
		              Marketplace = Beacon.MarketplaceSteamWorkshop
		              MarketplaceId = Dict.Value("workshop_id").StringValue
		            End If
		            
		            Self.SQLExecute("INSERT OR REPLACE INTO content_packs (content_pack_id, name, marketplace, marketplace_id, console_safe, default_enabled, type, game_id, last_update, required) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10);", Dict.Value("mod_id").StringValue, Dict.Value("name").StringValue, Marketplace, MarketplaceId, True, False, Beacon.ContentPack.TypeLocal, Self.Identifier, Now.SecondsFrom1970, False)
		          End If
		        End If
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName)
		      End Try
		    Next
		    
		    // Yes, delete the stuff from the packs we want to **keep** because that happens first. It clears out the mods.
		    Call Self.SaveBlueprints(Unpacked, Self.GetBlueprints("", KeepPacks, Nil), Nil, False)
		    For Each ContentPackId As String In RemovePacks
		      Call Self.DeleteContentPack(ContentPackId, False)
		    Next ContentPackId
		    Self.CommitTransaction()
		  Case ModeLegacy
		    Var Blueprints() As Variant
		    Try
		      Var StringContent As String = EngramsContent
		      Blueprints = Beacon.ParseJSON(StringContent.DefineEncoding(Encodings.UTF8))
		    Catch Err As RuntimeException
		      Return
		    End Try
		    
		    Self.BeginTransaction()
		    Self.DeleteDataForContentPack(Ark.UserContentPackId)
		    
		    For Each Dict As Dictionary In Blueprints
		      Try
		        Var Category As String = Dict.Value("category")
		        Var Path As String = Dict.Value("path") 
		        Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM " + Category + " WHERE path = ?1;", Path)
		        If Results.RowCount <> 0 Then
		          Continue
		        End If
		        
		        Var BlueprintId As String = Dict.Value("object_id").StringValue
		        Var ClassString As String = Dict.Value("class_string")
		        Var Label As String = Dict.Value("label")         
		        Var Availability As UInt64 = Dict.Value("availability")
		        Var Tags() As String = Dict.Value("tags").StringValue.Split(",")
		        Var TagObjectIdx As Integer = Tags.IndexOf("object")
		        If TagObjectIdx > -1 Then
		          Tags.RemoveAt(TagObjectIdx)
		        End If
		        Self.SQLExecute("INSERT INTO " + Category + " (object_id, class_string, label, path, availability, tags, content_pack_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);",  BlueprintId, ClassString, Label, Path, Availability, String.FromArray(Tags, ","), Ark.UserContentPackId)     
		        For Each Tag As String In Tags
		          Self.SQLExecute("INSERT OR IGNORE INTO tags_" + Category + " (object_id, tag) VALUES (?1, ?2);", BlueprintId, Tag)
		        Next Tag
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName)
		      End Try
		    Next
		    Self.CommitTransaction()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub ImportTruncate()
		  Var Rows As RowSet = Self.SQLSelect("SELECT name FROM sqlite_master WHERE type = 'table' AND name != 'content_packs' ORDER BY name;")
		  While Not Rows.AfterLastRow
		    Self.SQLExecute("DELETE FROM " + Self.EscapeIdentifier(Rows.Column("name").StringValue) + ";")
		    Rows.MoveToNextRow
		  Wend
		  Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id != $1;", Ark.UserContentPackId)
		End Sub
	#tag EndEvent

	#tag Event
		Sub IndexesBuilt()
		  Self.SQLExecute("DROP VIEW IF EXISTS blueprints;")
		  Self.SQLExecute("CREATE VIEW blueprints AS SELECT object_id, class_string, path, label, alternate_label, tags, availability, content_pack_id, '" + Ark.CategoryEngrams + "' AS category, last_update FROM engrams UNION SELECT object_id, class_string, path, label, alternate_label, tags, availability, content_pack_id, '" + Ark.CategoryCreatures + "' AS category, last_update FROM creatures UNION SELECT object_id, class_string, path, label, alternate_label, tags, availability, content_pack_id, '" + Ark.CategorySpawnPoints + "' AS category, last_update FROM spawn_points UNION SELECT object_id, class_string, path, label, alternate_label, tags, availability, content_pack_id, '" + Ark.CategoryLootContainers + "' AS category, last_update FROM loot_containers")
		  Var DeleteStatements(), Unions() As String
		  Var Categories() As String = Ark.Categories
		  For Each Category As String In Categories
		    DeleteStatements.Add("DELETE FROM " + Category + " WHERE object_id = OLD.object_id;")
		    Unions.Add("SELECT object_id, tag FROM tags_" + Category)
		  Next
		  Self.SQLExecute("CREATE TRIGGER blueprints_delete_trigger INSTEAD OF DELETE ON blueprints FOR EACH ROW BEGIN " + String.FromArray(DeleteStatements, " ") + " END;")
		  
		  Self.SQLExecute("DROP VIEW IF EXISTS tags;")
		  Self.SQLExecute("CREATE VIEW tags AS " + Unions.Join(" UNION ") + ";")
		End Sub
	#tag EndEvent

	#tag Event
		Sub MigrateContentPackData(FromContentPackId As String, ToContentPackId As String)
		  // This will need to change when Ark.MutableConfigOption is introduced
		  
		  Var SimpleTableNames() As String = Array("maps", "loot_container_selectors", "ini_options")
		  Var BlueprintTableNames() As String = Array("engrams", "creatures", "loot_containers", "spawn_points")
		  
		  For Each TableName As String In SimpleTableNames
		    Self.SQLExecute("UPDATE " + TableName + " SET content_pack_id = ?2 WHERE content_pack_id = ?1;", FromContentPackId, ToContentPackId)
		  Next
		  
		  For Each TableName As String In BlueprintTableNames
		    Var Rows As RowSet = Self.SQLSelect("SELECT object_id, path FROM " + TableName + " WHERE content_pack_id = ?1;", FromContentPackId)
		    While Not Rows.AfterLastRow
		      Var OldBlueprintId As String = Rows.Column("object_id").StringValue
		      Var NewBlueprintId As String = Ark.GenerateBlueprintId(ToContentPackId, Rows.Column("path").StringValue)
		      If OldBlueprintId <> NewBlueprintId Then
		        Var Conflict As RowSet = Self.SQLSelect("SELECT object_id FROM " + TableName + " WHERE object_id = ?1;", NewBlueprintId)
		        If Conflict.RowCount = 1 Then
		          // Already exists, delete
		          Self.SQLExecute("DELETE FROM " + TableName + " WHERE object_id = ?1;", OldBlueprintId)
		        Else
		          Self.SQLExecute("UPDATE " + TableName + " SET object_id = ?2, content_pack_id = ?3 WHERE object_id = ?1;", OldBlueprintId, NewBlueprintId, ToContentPackId)
		        End If
		      Else
		        Self.SQLExecute("UPDATE " + TableName + " SET content_pack_id = ?2 WHERE object_id = ?1;", OldBlueprintId, ToContentPackId)
		      End If
		      Rows.MoveToNextRow
		    Wend
		  Next
		  
		  // Do not invalidate mBlueprints. It isn't necessary because it uses timestamps.
		  Self.mConfigOptionCache.RemoveAll
		  Self.mContainerLabelCacheDict.RemoveAll
		  Self.mIconCache.RemoveAll
		  Self.mSpawnLabelCacheDict.RemoveAll
		End Sub
	#tag EndEvent

	#tag Event
		Sub ObtainLock()
		  mLock.Enter
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Var Rows As RowSet = Self.SQLSelect("SELECT type, console_safe, default_enabled, last_update FROM content_packs WHERE content_pack_id = ?1;", Ark.UserContentPackId)
		  If (Rows Is Nil) Or Rows.RowCount = 0 Or Rows.Column("type").IntegerValue <> Beacon.ContentPack.TypeLocal Or Rows.Column("console_safe").BooleanValue = False Or Rows.Column("default_enabled").BooleanValue = False Then
		    Self.ReplaceUserBlueprints()
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReleaseLock()
		  mLock.Leave
		End Sub
	#tag EndEvent

	#tag Event
		Sub TestPerformance()
		  Var TestDoc As New Ark.Project
		  Var Packs As Beacon.StringList = TestDoc.ContentPacks
		  Var Tags As Beacon.TagSpec = Preferences.SelectedTag(Ark.CategoryEngrams, "8e58f9e4") // Use a strange subgroup here to always get the default
		  Call Self.GetBlueprints(Ark.CategoryEngrams, "", Packs, Tags)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AdditionalSupportFiles() As Dictionary
		  Var Files As Dictionary = Super.AdditionalSupportFiles
		  If Files Is Nil Then
		    Files = New Dictionary
		  End If
		  
		  Var Blueprints As MemoryBlock = UserCloud.Read("/Ark/Blueprints.json")
		  If (Blueprints Is Nil) = False And Blueprints.Size > 2 Then
		    Files.Value("Blueprints.json") = Blueprints
		  End If
		  
		  Return Files
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintIsCustom(Item As Ark.Blueprint) As Boolean
		  If Item Is Nil Then
		    Return False
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT type FROM content_packs WHERE content_pack_id = ?1;", Item.ContentPackId)
		  Return Rows.RowCount = 1 And Rows.Column("type").IntegerValue = Beacon.ContentPack.TypeLocal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cache(Blueprint As Ark.Blueprint)
		  If Blueprint Is Nil Then
		    Return
		  End If
		  
		  Select Case Blueprint
		  Case IsA Ark.Creature
		    Self.Cache(Ark.Creature(Blueprint))
		  Case IsA Ark.Engram
		    Self.Cache(Ark.Engram(Blueprint))
		  Case IsA Ark.LootContainer
		    Self.Cache(Ark.LootContainer(Blueprint))
		  Case IsA Ark.SpawnPoint
		    Self.Cache(Ark.SpawnPoint(Blueprint))
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Creatures() As Ark.Creature)
		  For Each Creature As Ark.Creature In Creatures
		    Self.Cache(Creature)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Creature As Ark.Creature)
		  Self.mBlueprintCache.Value(Creature.CreatureId) = Creature
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Engrams() As Ark.Engram)
		  For Each Engram As Ark.Engram In Engrams
		    Self.Cache(Engram)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Engram As Ark.Engram)
		  Self.mBlueprintCache.Value(Engram.EngramId) = Engram
		  
		  If Engram.HasUnlockDetails Then
		    Var SimilarEngrams() As Ark.Engram
		    Var CacheKey As String = "EngramEntry:" + Engram.EntryString
		    If Self.mBlueprintCache.HasKey(CacheKey) Then
		      SimilarEngrams = Self.mBlueprintCache.Value(CacheKey)
		    End If
		    
		    Var Found As Boolean
		    For Idx As Integer = 0 To SimilarEngrams.LastIndex
		      If SimilarEngrams(Idx).EngramId = Engram.EngramId Then
		        SimilarEngrams(Idx) = Engram
		        Found = True
		        Exit For Idx
		      End If
		    Next
		    If Not Found Then
		      SimilarEngrams.Add(Engram)
		    End If
		    Self.mBlueprintCache.Value(CacheKey) = SimilarEngrams
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(LootDrops() As Ark.LootContainer)
		  For Each LootDrop As Ark.LootContainer In LootDrops
		    Self.Cache(LootDrop)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(LootDrop As Ark.LootContainer)
		  Self.mBlueprintCache.Value(LootDrop.LootDropId) = LootDrop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(SpawnPoints() As Ark.SpawnPoint)
		  For Each SpawnPoint As Ark.SpawnPoint In SpawnPoints
		    Self.Cache(SpawnPoint)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(SpawnPoint As Ark.SpawnPoint)
		  Self.mBlueprintCache.Value(SpawnPoint.SpawnPointId) = SpawnPoint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ComputeGFICodes(ContentPacks As Beacon.StringList, Progress As Beacon.ProgressDisplayer = Nil) As String()
		  // This code expects to be run inside a thread
		  
		  If Progress Is Nil Then
		    Progress = New Beacon.DummyProgressDisplayer
		  End If
		  
		  Var Planner As New SQLiteDatabase
		  Planner.Connect
		  Planner.ExecuteSQL("CREATE TABLE plan (code TEXT NOT NULL, class_string TEXT NOT NULL);")
		  Planner.ExecuteSQL("CREATE INDEX plan_code_idx ON plan(code);")
		  Planner.ExecuteSQL("CREATE INDEX plan_class_string_idx ON plan(class_string);")
		  Planner.ExecuteSQL("CREATE UNIQUE INDEX plan_code_class_string_idx ON plan(code, class_string);")
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT DISTINCT class_string, label FROM engrams WHERE content_pack_id IN ('" + ContentPacks.Join("','") + "') GROUP BY class_string ORDER BY LENGTH(class_string), required_level NULLS FIRST, class_string;")
		  Var Numerator As Integer = 0
		  Var Denominator As Integer = Rows.RowCount * 2
		  
		  Progress.Message = "Planning possible matches…"
		  Progress.Detail = ""
		  Progress.Progress = Numerator / Denominator
		  
		  // Plan all candidates for every class. For official content, this results in about 1.2 million rows.
		  For Each Row As DatabaseRow In Rows
		    If Progress.CancelPressed Then
		      Var EmptyArray() As String
		      Return EmptyArray
		    End If
		    
		    Var ClassString As String = Row.Column("class_string").StringValue
		    Progress.Detail = "Planning " + ClassString + "…"
		    
		    If ClassString.EndsWith("_C") Then
		      ClassString = ClassString.Left(ClassString.Length - 2)
		    End If
		    
		    Planner.BeginTransaction()
		    Var ClassStringLower As String = ClassString.Lowercase
		    Var Len As Integer = ClassString.Length
		    For ChunkSize As Integer = 1 To Len
		      For Offset As Integer = 0 To Len - ChunkSize
		        Var Chunk As String = ClassStringLower.Middle(Offset, ChunkSize)
		        If Chunk.BeginsWith("_") Then
		          Continue
		        End If
		        
		        Planner.ExecuteSQL("INSERT OR IGNORE INTO plan (code, class_string) VALUES (?1, ?2);", Chunk, ClassString)
		      Next
		    Next
		    Planner.CommitTransaction()
		    
		    Numerator = Numerator + 1
		    Progress.Progress = Numerator / Denominator
		  Next
		  
		  Progress.Message = "Finding best matches…"
		  Progress.Detail = ""
		  
		  // Loop over again and start resolving class-by-class.
		  Var Lines() As String
		  For Each Row As DatabaseRow In Rows
		    If Progress.CancelPressed Then
		      Var EmptyArray() As String
		      Return EmptyArray
		    End If
		    
		    Var ClassString As String = Row.Column("class_string").StringValue
		    Var Label As String = Row.Column("label").StringValue
		    Var TruncatedClassString As String = ClassString
		    If TruncatedClassString.EndsWith("_C") Then
		      TruncatedClassString = TruncatedClassString.Left(ClassString.Length - 2)
		    End If
		    
		    Progress.Detail = "Finding code for " + ClassString + "…"
		    
		    Var Code As String
		    Var Results As RowSet = Planner.SelectSQL("SELECT code FROM plan WHERE class_string = ?1 ORDER BY LENGTH(code), code LIMIT 1;", TruncatedClassString)
		    If Results.RowCount = 1 Then
		      Code = Results.Column("code").StringValue
		    End If
		    If Code.IsEmpty Then
		      Continue
		    End If
		    
		    Var CodeEscaped As String = Code.ReplaceAll("""", """""")
		    Lines.Add("""" + Label.ReplaceAll("""", """""") + """,""" + CodeEscaped + """,""cheat gfi " + CodeEscaped + " 1 0 0""")
		    
		    Planner.BeginTransaction()
		    Planner.ExecuteSQL("DELETE FROM plan WHERE code IN (SELECT code FROM plan WHERE class_string = ?1);", TruncatedClassString)
		    Planner.CommitTransaction()
		    
		    Numerator = Numerator + 1
		    Progress.Progress = Numerator / Denominator
		  Next
		  
		  Lines.Sort
		  Lines.AddAt(0, """Item Name"",""GFI Code"",""Cheat Code""")
		  
		  Progress.Progress = 1
		  Progress.Message = "Finished"
		  Progress.Detail = ""
		  
		  Return Lines
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(AllowWriting As Boolean)
		  If Self.mBlueprintCache Is Nil Then
		    Self.mBlueprintCache = New Dictionary
		  End If
		  If Self.mConfigOptionCache Is Nil Then
		    Self.mConfigOptionCache = New Dictionary
		  End If
		  If Self.mSpawnLabelCacheDict Is Nil Then
		    Self.mSpawnLabelCacheDict = New Dictionary
		  End If
		  If Self.mIconCache Is Nil Then
		    Self.mIconCache = New Dictionary
		  End If
		  If Self.mContainerLabelCacheDict Is Nil Then
		    Self.mContainerLabelCacheDict = New Dictionary
		    Self.mContainerLabelCacheMask = 0
		  End If
		  
		  If mLock Is Nil Then
		    mLock = New CriticalSection
		  End If
		  
		  Super.Constructor(AllowWriting)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateLocalContentPack(PackName As String, MarketplaceId As String, DoCloudExport As Boolean) As Beacon.ContentPack
		  Return Self.CreateLocalContentPack(PackName, Beacon.MarketplaceSteamWorkshop, MarketplaceId, DoCloudExport)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteDataForContentPack(ContentPackId As String)
		  Self.BeginTransaction()
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT object_id FROM blueprints WHERE content_pack_id = ?1;", ContentPackId)
		  For Each Row As DatabaseRow In Rows
		    Var BlueprintId As String = Row.Column("object_id").StringValue
		    If Self.mBlueprintCache.HasKey(BlueprintId) Then
		      Self.mBlueprintCache.Remove(BlueprintId)
		    End If
		  Next
		  
		  Rows = Self.SQLSelect("SELECT DISTINCT entry_string FROM engrams WHERE content_pack_id = ?1 AND entry_string IS NOT NULL;", ContentPackId)
		  For Each Row As DatabaseRow In Rows
		    Var EntryString As String = Row.Column("entry_string").StringValue
		    If Self.mBlueprintCache.HasKey("EngramEntry:" + EntryString) Then
		      Self.mBlueprintCache.Remove("EngramEntry:" + EntryString)
		    End If
		  Next
		  
		  Self.SQLExecute("DELETE FROM blueprints WHERE content_pack_id = ?1;", ContentPackId)
		  Self.SQLExecute("DELETE FROM loot_container_selectors WHERE content_pack_id = ?1;", ContentPackId)
		  Self.CommitTransaction()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprint(BlueprintId As String, UseCache As Boolean = True) As Ark.Blueprint
		  If UseCache And Self.mBlueprintCache.HasKey(BlueprintId) Then
		    Return Self.mBlueprintCache.Value(BlueprintId)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT category FROM blueprints WHERE object_id = ?1;", BlueprintId)
		  If Rows.RowCount = 0 Then
		    Return Nil
		  End If
		  
		  Select Case Rows.Column("category").StringValue
		  Case Ark.CategoryCreatures
		    Return Self.GetCreature(BlueprintId, UseCache)
		  Case Ark.CategoryEngrams
		    Return Self.GetEngram(BlueprintId, UseCache)
		  Case Ark.CategoryLootContainers
		    Return Self.GetLootContainer(BlueprintId, UseCache)
		  Case Ark.CategorySpawnPoints
		    Return Self.GetSpawnPoint(BlueprintId, UseCache)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As Ark.Blueprint()
		  Var Categories() As String = Ark.Categories
		  Var Blueprints() As Ark.Blueprint
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  For Each Category As String In Categories
		    Var Results() As Ark.Blueprint = Self.GetBlueprints(Category, SearchText, ContentPacks, Tags, ExtraClauses, ExtraValues)
		    For Each Result As Ark.Blueprint In Results
		      Blueprints.Add(Result)
		    Next
		  Next
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(Category As String, SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec) As Ark.Blueprint()
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  Return Self.GetBlueprints(Category, SearchText, ContentPacks, Tags, ExtraClauses, ExtraValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetBlueprints(Category As String, SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec, ExtraClauses() As String, ExtraValues() As Variant) As Ark.Blueprint()
		  Var Blueprints() As Ark.Blueprint
		  
		  Try
		    Var NextPlaceholder As Integer = 1
		    Var Clauses() As String
		    Var Values As New Dictionary
		    If SearchText.IsEmpty = False Then
		      If SearchText.BeginsWith("/") Then
		        Clauses.Add("path = ?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		        Values.Value(NextPlaceholder) = SearchText
		      Else
		        Clauses.Add("label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\' OR (alternate_label IS NOT NULL AND alternate_label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\') OR class_string LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\'")
		        Values.Value(NextPlaceholder) = "%" + Self.EscapeLikeValue(SearchText) + "%"
		      End If
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    
		    Var SQL As String
		    Select Case Category
		    Case Ark.CategoryEngrams
		      SQL = Self.EngramSelectSQL
		    Case Ark.CategoryCreatures
		      SQL = Self.CreatureSelectSQL
		    Case Ark.CategorySpawnPoints
		      SQL = Self.SpawnPointSelectSQL
		    Case Ark.CategoryLootContainers
		      SQL = Self.LootContainerSelectSQL
		    Else
		      Return Blueprints
		    End Select
		    
		    If ContentPacks <> Nil And ContentPacks.LastRowIndex > -1 Then
		      Var Placeholders() As String
		      For Each ContentPackId As String In ContentPacks
		        Placeholders.Add("?" + NextPlaceholder.ToString)
		        Values.Value(NextPlaceholder) = ContentPackId
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.Add("content_packs.content_pack_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    If (Tags Is Nil) = False Then
		      Var RequiredTags(), ExcludedTags() As String
		      Tags.OrganizeTags(RequiredTags, ExcludedTags)
		      Var ObjectTagIndex As Integer = RequiredTags.IndexOf("object")
		      If ObjectTagIndex > -1 Then
		        RequiredTags.RemoveAt(ObjectTagIndex)
		      End If
		      
		      If RequiredTags.Count > 0 Or ExcludedTags.Count > 0 Then
		        If RequiredTags.Count > 0 Then
		          For Each Tag As String In RequiredTags
		            Clauses.Add(Category + ".object_id IN (SELECT object_id FROM tags_" + Category + " WHERE tag = ?" + NextPlaceholder.ToString(Locale.Raw, "0") + ")")
		            Values.Value(NextPlaceholder) = Tag
		            NextPlaceholder = NextPlaceholder + 1
		          Next Tag
		        End If
		        If ExcludedTags.Count > 0 Then
		          Var TagPlaceholders() As String
		          For Each Tag As String In ExcludedTags
		            TagPlaceholders.Add("?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		            Values.Value(NextPlaceholder) = Tag
		            NextPlaceholder = NextPlaceholder + 1
		          Next Tag
		          Clauses.Add(Category + ".object_id NOT IN (SELECT object_id FROM tags_" + Category + " WHERE tag IN (" + TagPlaceholders.Join(",") + "))")
		        End If
		      End If
		    End If
		    
		    If ExtraClauses.LastIndex > -1 And ExtraClauses.LastIndex = ExtraValues.LastIndex Then
		      For I As Integer = 0 To ExtraClauses.LastIndex
		        If ExtraClauses(I).IndexOf(":placeholder:") > -1 Then
		          Var Clause As String = ExtraClauses(I).ReplaceAll(":placeholder:", "?" + NextPlaceholder.ToString)
		          Var Value As Variant = ExtraValues(I)
		          Clauses.Add(Clause)
		          Values.Value(NextPlaceholder) = Value
		          NextPlaceholder = NextPlaceholder + 1
		        Else
		          Clauses.Add(ExtraClauses(I))
		        End If
		      Next
		    End If
		    
		    If Clauses.LastIndex > -1 Then
		      SQL = SQL + " WHERE (" + Clauses.Join(") AND (") + ")"
		    End If
		    SQL = SQL + " ORDER BY label;"
		    
		    Var Results As RowSet
		    #if false
		      Var StartTime As Double = System.Microseconds
		    #endif
		    If Values.KeyCount = 0 Then
		      Results = Self.SQLSelect(SQL)
		    Else
		      Results = Self.SQLSelect(SQL, Values)
		    End If
		    #if false
		      Var Duration As Double = System.Microseconds - StartTime
		      System.DebugLog("Searching for blueprints took " + Duration.ToString(Locale.Raw, "0") + " microseconds")
		      System.DebugLog("EXPLAIN QUERY PLAN " + SQL)
		    #endif
		    
		    Select Case Category
		    Case Ark.CategoryEngrams
		      Var Engrams() As Ark.Engram = Self.RowSetToEngram(Results)
		      Self.Cache(Engrams)
		      For Each Engram As Ark.Engram In Engrams
		        Blueprints.Add(Engram)
		      Next Engram
		    Case Ark.CategoryCreatures
		      Var Creatures() As Ark.Creature = Self.RowSetToCreature(Results)
		      Self.Cache(Creatures)
		      For Each Creature As Ark.Creature In Creatures
		        Blueprints.Add(Creature)
		      Next Creature
		    Case Ark.CategorySpawnPoints
		      Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      Self.Cache(SpawnPoints)
		      For Each SpawnPoint As Ark.SpawnPoint In SpawnPoints
		        Blueprints.Add(SpawnPoint)
		      Next SpawnPoint
		    Case Ark.CategoryLootContainers
		      Var LootContainers() As Ark.LootContainer = Self.RowSetToLootContainer(Results)
		      Self.Cache(LootContainers)
		      For Each LootContainer As Ark.LootContainer In LootContainers
		        Blueprints.Add(LootContainer)
		      Next LootContainer
		    End Select
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByPath(Path As String, ContentPacks As Beacon.StringList, UseCache As Boolean = True) As Ark.Blueprint()
		  Var SQL As String = "SELECT object_id, category FROM blueprints WHERE path = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND content_pack_id IN ('" + ContentPacks.Join("','") + "')"
		  End If
		  
		  Var Blueprints() As Ark.Blueprint
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  If Rows.RowCount = 0 Then
		    Return Blueprints
		  End If
		  
		  While Not Rows.AfterLastRow
		    Var BlueprintId As String = Rows.Column("object_id").StringValue
		    Var Blueprint As Ark.Blueprint
		    Select Case Rows.Column("category").StringValue
		    Case Ark.CategoryCreatures
		      Blueprint = Self.GetCreature(BlueprintId, UseCache)
		    Case Ark.CategoryEngrams
		      Blueprint = Self.GetEngram(BlueprintId, UseCache)
		    Case Ark.CategoryLootContainers
		      Blueprint = Self.GetLootContainer(BlueprintId, UseCache)
		    Case Ark.CategorySpawnPoints
		      Blueprint = Self.GetSpawnPoint(BlueprintId, UseCache)
		    End Select
		    If (Blueprint Is Nil) = False Then
		      Blueprints.Add(Blueprint)
		    End If
		    Rows.MoveToNextRow
		  Wend
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As String, Default As Boolean = False) As Boolean
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Return Value.BooleanValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigHelp(ConfigName As String, ByRef Title As String, ByRef Body As String, ByRef DetailURL As String) As Boolean
		  Try
		    Var Results As RowSet
		    Results = Self.SQLSelect("SELECT title, body, detail_url FROM config_help WHERE config_name = ?1;", ConfigName)
		    If Results.RowCount <> 1 Then
		      Return False
		    End If
		    
		    Title = Results.Column("title").StringValue
		    Body = Results.Column("body").StringValue
		    DetailURL = If(Results.Column("detail_url").Value <> Nil, Results.Column("detail_url").StringValue, "")
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOption(KeyUUID As String) As Ark.ConfigOption
		  If Self.mConfigOptionCache.HasKey(KeyUUID) Then
		    Return Self.mConfigOptionCache.Value(KeyUUID)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect(Self.ConfigOptionSelectSQL + " WHERE object_id = ?1;", KeyUUID)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Results() As Ark.ConfigOption = Self.RowSetToConfigOptions(Rows)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOption(File As String, Header As String, Key As String) As Ark.ConfigOption
		  Var Results() As Ark.ConfigOption = Self.GetConfigOptions(File, Header, Key, False)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOptions(File As String, Header As String, Key As String, SortHuman As Boolean) As Ark.ConfigOption()
		  Var Clauses() As String
		  Var Values As New Dictionary
		  Var Idx As Integer = 1
		  
		  If File = Ark.ConfigFileGameUserSettings Then
		    If Header.IsEmpty = False Then
		      Clauses.Add("file = 'GameUserSettings.ini' AND header = ?" + Idx.ToString)
		      Values.Value(Idx) = Header
		      Idx = Idx + 1
		      
		      If Header = Ark.HeaderServerSettings Then
		        Clauses(Clauses.LastIndex) = "((" + Clauses(Clauses.LastIndex) + ") OR file IN ('CommandLineFlag', 'CommandLineOption'))"
		      End If
		    Else
		      Clauses.Add("file IN ('GameUserSettings.ini', 'CommandLineFlag', 'CommandLineOption')")
		    End If
		  Else
		    If File.IsEmpty = False Then
		      If File = "CommandLine" Then
		        Clauses.Add("file IN ('CommandLineFlag', 'CommandLineOption')")
		      ElseIf File.IndexOf("*") > -1 Then
		        Values.Value(Idx) = Self.EscapeLikeValue(File).ReplaceAll("*", "%")
		        Clauses.Add("file LIKE ?" + Idx.ToString + " ESCAPE '\'")
		        Idx = Idx + 1
		      Else
		        Values.Value(Idx) = File
		        Clauses.Add("file = ?" + Idx.ToString)
		        Idx = Idx + 1
		      End If
		    End If
		    If Header.IsEmpty = False Then
		      Values.Value(Idx) = Header
		      Clauses.Add("header = ?" + Idx.ToString)
		      Idx = Idx + 1
		    End If
		  End If
		  If Key.IsEmpty = False Then
		    If Key.IndexOf("*") > -1 Then
		      Values.Value(Idx) = Self.EscapeLikeValue(Key).ReplaceAll("*", "%")
		      Clauses.Add("key LIKE ?" + Idx.ToString + " ESCAPE '\'")
		    Else
		      Values.Value(Idx) = Key
		      Clauses.Add("key = ?" + Idx.ToString)
		    End If
		    Idx = Idx + 1
		  End If
		  
		  Var SQL As String = Self.ConfigOptionSelectSQL
		  If Clauses.Count > 0 Then
		    SQL = SQL + " WHERE " + Clauses.Join(" AND ")
		  End If
		  If SortHuman Then
		    SQL = SQL + " ORDER BY COALESCE(custom_sort, label)"
		  Else
		    SQL = SQL + " ORDER BY key"
		  End If
		  
		  Var Results() As Ark.ConfigOption
		  Try
		    Results = Self.RowSetToConfigOptions(Self.SQLSelect(SQL, Values))
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		  End Try
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPackWithSteamId(SteamId As String) As Beacon.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT " + Self.ContentPackColumns + " FROM content_packs WHERE marketplace_id = ?1 ORDER BY type DESC LIMIT 1;", SteamId)
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Results)
		  If Packs.Count = 1 Then
		    Return Packs(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPackWithSteamId(SteamId As String, Type As Integer) As Beacon.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT " + Self.ContentPackColumns + " FROM content_packs WHERE marketplace_id = ?1 AND type = ?2 ORDER BY type DESC LIMIT 1;", SteamId, Type)
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Results)
		  If Packs.Count = 1 Then
		    Return Packs(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreature(CreatureId As String, UseCache As Boolean = True) As Ark.Creature
		  If UseCache And Self.mBlueprintCache.HasKey(CreatureId) Then
		    Return Self.mBlueprintCache.Value(CreatureId)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE object_id = ?1;", CreatureId)
		    If Results.RowCount <> 1 Then
		      Return Nil
		    End If
		    
		    Var Creatures() As Ark.Creature = Self.RowSetToCreature(Results, UseCache)
		    Self.Cache(Creatures)
		    Return Creatures(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorByUUID(ID As Integer) As Ark.CreatureColor
		  Var Rows As RowSet = Self.SQLSelect(Self.CreatureColorSelectSQL + " WHERE color_id = ?1;", ID)
		  Var Colors() As Ark.CreatureColor = Self.RowSetToCreatureColors(Rows)
		  If Colors.Count = 1 Then
		    Return Colors(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColors(Label As String = "") As Ark.CreatureColor()
		  Var Rows As RowSet = Self.SQLSelect(Self.CreatureColorSelectSQL + " WHERE label LIKE ?1 ESCAPE '\' ORDER BY label;", "%" + Self.EscapeLikeValue(Label) + "%")
		  Return Self.RowSetToCreatureColors(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorSetByClass(ClassString As String) As Ark.CreatureColorSet
		  Var Rows As RowSet = Self.SQLSelect(Self.CreatureColorSetSelectSQL + " WHERE class_string = ?1;", ClassString)
		  Var Sets() As Ark.CreatureColorSet = Self.RowSetToCreatureColorSets(Rows)
		  If Sets.Count = 1 Then
		    Return Sets(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorSetByUUID(UUID As String) As Ark.CreatureColorSet
		  Var Rows As RowSet = Self.SQLSelect(Self.CreatureColorSetSelectSQL + " WHERE color_set_id = ?1;", UUID)
		  Var Sets() As Ark.CreatureColorSet = Self.RowSetToCreatureColorSets(Rows)
		  If Sets.Count = 1 Then
		    Return Sets(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorSets(Label As String = "") As Ark.CreatureColorSet()
		  Var Rows As RowSet = Self.SQLSelect(Self.CreatureColorSetSelectSQL + " WHERE label LIKE ?1 ESCAPE '\' ORDER BY label;", "%" + Self.EscapeLikeValue(Label) + "%")
		  Return Self.RowSetToCreatureColorSets(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatures(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As Ark.Creature()
		  If ContentPacks Is Nil Then
		    ContentPacks = New Beacon.StringList
		  End If
		  Var Blueprints() As Ark.Blueprint = Self.GetBlueprints(Ark.CategoryCreatures, SearchText, ContentPacks, Tags)
		  Var Creatures() As Ark.Creature
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    If Blueprint IsA Ark.Creature Then
		      Creatures.Add(Ark.Creature(Blueprint))
		    End If
		  Next
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByClass(ClassString As String, ContentPacks As Beacon.StringList) As Ark.Creature()
		  Var SQL As String = Self.CreatureSelectSQL + " WHERE creatures.class_string = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND creatures.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var Creatures() As Ark.Creature = Self.RowSetToCreature(Rows)
		  Self.Cache(Creatures)
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByPath(Path As String, ContentPacks As Beacon.StringList) As Ark.Creature()
		  Var SQL As String = Self.CreatureSelectSQL + " WHERE creatures.path = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND creatures.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var Creatures() As Ark.Creature = Self.RowSetToCreature(Rows)
		  Self.Cache(Creatures)
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As String, Default As Double = 0.0) As Double
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Return Value.DoubleValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngram(EngramId As String, UseCache As Boolean = True) As Ark.Engram
		  If UseCache And Self.mBlueprintCache.HasKey(EngramId) Then
		    Return Self.mBlueprintCache.Value(EngramId)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE object_id = ?1;", EngramId)
		    If Results.RowCount <> 1 Then
		      Return Nil
		    End If
		    
		    Var Engrams() As Ark.Engram = Self.RowSetToEngram(Results, UseCache)
		    Self.Cache(Engrams)
		    Return Engrams(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByItemID(ItemID As Integer) As Ark.Engram
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE item_id = ?1;", ItemID)
		    If Results.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Var Engrams() As Ark.Engram = Self.RowSetToEngram(Results)
		    If Engrams.Count = 1 Then
		      Return Engrams(0)
		    End If
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramEntries(SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec) As Ark.Engram()
		  Var ExtraClauses() As String = Array("entry_string IS NOT NULL")
		  Var ExtraValues(0) As Variant
		  Var Blueprints() As Ark.Blueprint = Self.GetBlueprints(Ark.CategoryEngrams, SearchText, ContentPacks, Tags, ExtraClauses, ExtraValues)
		  Var Engrams() As Ark.Engram
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    If Blueprint IsA Ark.Engram Then
		      Engrams.Add(Ark.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngrams(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As Ark.Engram()
		  If ContentPacks Is Nil Then
		    ContentPacks = New Beacon.StringList
		  End If
		  Var Blueprints() As Ark.Blueprint = Self.GetBlueprints(Ark.CategoryEngrams, SearchText, ContentPacks, Tags)
		  Var Engrams() As Ark.Engram
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    If Blueprint IsA Ark.Engram Then
		      Engrams.Add(Ark.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByClass(ClassString As String, ContentPacks As Beacon.StringList) As Ark.Engram()
		  Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.class_string = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND engrams.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var Engrams() As Ark.Engram = Self.RowSetToEngram(Rows)
		  Self.Cache(Engrams)
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByEntryString(EntryString As String, ContentPacks As Beacon.StringList) As Ark.Engram()
		  If EntryString.Length < 2 Or EntryString.Right(2) <> "_C" Then
		    EntryString = EntryString + "_C"
		  End If
		  
		  Var Engrams() As Ark.Engram
		  If Self.mBlueprintCache.HasKey("EngramEntry:" + EntryString) Then
		    Engrams = Self.mBlueprintCache.Value("EngramEntry:" + EntryString)
		  Else
		    Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.entry_string = ?1;"
		    If (ContentPacks Is Nil) = False Then
		      SQL = SQL.Left(SQL.Length - 1) + " AND engrams.content_pack_id IN (" + ContentPacks.SQLValue + ");"
		    End If
		    
		    Try
		      Var Results As RowSet = Self.SQLSelect(SQL, EntryString)
		      If Results.RowCount = 0 Then
		        Return Engrams
		      End If
		      
		      Engrams = Self.RowSetToEngram(Results)
		      Self.Cache(Engrams)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByPath(Path As String, ContentPacks As Beacon.StringList) As Ark.Engram()
		  Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.path = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND engrams.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var Engrams() As Ark.Engram = Self.RowSetToEngram(Rows)
		  Self.Cache(Engrams)
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGameEventByArkCode(ArkCode As String) As Ark.GameEvent
		  Var Rows As RowSet = Self.SQLSelect(Self.GameEventSelectSQL + " WHERE ark_code = ?1;", ArkCode)
		  Var GameEvents() As Ark.GameEvent = Self.RowSetToGameEvents(Rows)
		  If GameEvents.Count = 1 Then
		    Return GameEvents(0)
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGameEventByUUID(EventUUID As String) As Ark.GameEvent
		  Var Rows As RowSet = Self.SQLSelect(Self.GameEventSelectSQL + " WHERE event_id = ?1;", EventUUID)
		  Var GameEvents() As Ark.GameEvent = Self.RowSetToGameEvents(Rows)
		  If GameEvents.Count = 1 Then
		    Return GameEvents(0)
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGameEvents(Label As String = "") As Ark.GameEvent()
		  Var Rows As RowSet = Self.SQLSelect(Self.GameEventSelectSQL + " WHERE label LIKE ?1 ESCAPE '\' ORDER BY label;", "%" + Self.EscapeLikeValue(Label) + "%")
		  Return Self.RowSetToGameEvents(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As String, Default As Integer = 0) As Integer
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Return Value.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainer(LootDropId As String, UseCache As Boolean = True) As Ark.LootContainer
		  If UseCache And Self.mBlueprintCache.HasKey(LootDropId) Then
		    Return Self.mBlueprintCache.Value(LootDropId)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.LootContainerSelectSQL + " WHERE object_id = ?1;", LootDropId)
		    If Results.RowCount <> 1 Then
		      Return Nil
		    End If
		    
		    Var LootDrops() As Ark.LootContainer = Self.RowSetToLootContainer(Results, UseCache)
		    Self.Cache(LootDrops)
		    Return LootDrops(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainerIcon(Container As Ark.LootContainer, BackgroundColor As Color) As Picture
		  Var ForegroundColor As Color = Container.UIColor
		  Select Case ForegroundColor
		  Case &cFFF02A00
		    ForegroundColor = SystemColors.SystemYellowColor
		  Case &cE6BAFF00
		    ForegroundColor = SystemColors.SystemPurpleColor
		  Case &c00FF0000
		    ForegroundColor = SystemColors.SystemGreenColor
		  Case &cFFBABA00
		    ForegroundColor = SystemColors.SystemRedColor
		  Case &c88C8FF00
		    ForegroundColor = SystemColors.SystemBlueColor
		  Case &c00FFFF00
		    ForegroundColor = SystemColors.SystemTealColor
		  Case &cFFA50000
		    ForegroundColor = SystemColors.SystemOrangeColor
		  End Select
		  
		  Return Self.GetLootContainerIcon(Container, ForegroundColor, BackgroundColor)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainerIcon(Container As Ark.LootContainer, ForegroundColor As Color, BackgroundColor As Color) As Picture
		  // "Fix" background color to account for opacity. It's not perfect, but it's good.
		  Var BackgroundOpacity As Double = (255 - BackgroundColor.Alpha) / 255
		  BackgroundColor = SystemColors.UnderPageBackgroundColor.BlendWith(Color.RGB(BackgroundColor.Red, BackgroundColor.Green, BackgroundColor.Blue), BackgroundOpacity)
		  
		  Var AccentColor As Color
		  Var IconID As String
		  Var SpriteSheet, BadgeSheet As Picture
		  Var Results As RowSet
		  Try
		    Results = Self.SQLSelect("SELECT loot_icons.icon_id, loot_icons.icon_data, loot_containers.experimental FROM loot_containers INNER JOIN loot_icons ON (loot_containers.icon = loot_icons.icon_id) WHERE loot_containers.content_pack_id = ?1 AND loot_containers.path = ?2 LIMIT 1;", Container.ContentPackId, Container.Path)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "ContentPackId: " + Container.ContentPackId + " Path: " + Container.Path)
		  End Try
		  If (Results Is Nil) = False And Results.RowCount = 1 Then
		    SpriteSheet = Results.Column("icon_data").PictureValue
		    IconID = Results.Column("icon_id").StringValue
		  Else
		    SpriteSheet = App.GenericLootSourceIcon()
		    IconID = "3a1f5d12-0b50-4761-9f89-277492dc00e0"
		  End If
		  AccentColor = BackgroundColor
		  
		  IconID = IconID + ForegroundColor.ToHex + BackgroundColor.ToHex
		  If Self.mIconCache.HasKey(IconID) Then
		    Return Self.mIconCache.Value(IconID)
		  End If
		  
		  ForegroundColor = BeaconUI.FindContrastingColor(BackgroundColor, ForegroundColor)
		  
		  Var Height As Integer = (SpriteSheet.Height / 2) / 3
		  Var Width As Integer = (SpriteSheet.Width / 2) / 3
		  
		  If BadgeSheet <> Nil Then
		    Var BadgesMask As New Picture(BadgeSheet.Width, BadgeSheet.Height)
		    BadgesMask.Graphics.DrawingColor = &cFFFFFF
		    BadgesMask.Graphics.FillRectangle(0, 0, BadgesMask.Width, BadgesMask.Height)
		    BadgesMask.Graphics.DrawPicture(BadgeSheet, 0, 0)
		    
		    Var Badges As Picture = New Picture(BadgeSheet.Width, BadgeSheet.Height)
		    Badges.Graphics.DrawingColor = &cFFFFFF
		    Badges.Graphics.FillRectangle(0, 0, Badges.Graphics.Width, Badges.Graphics.Height)
		    Badges.ApplyMask(BadgesMask)
		    
		    Var Sprites As Picture = New Picture(SpriteSheet.Width, SpriteSheet.Height)
		    Sprites.Graphics.DrawPicture(SpriteSheet, 0, 0)
		    Sprites.Graphics.DrawPicture(Badges.Piece(0, 0, Width, Height), 0, Height)
		    Sprites.Graphics.DrawPicture(Badges.Piece(Width, 0, Width * 2, Height * 2), Width, Height * 2)
		    Sprites.Graphics.DrawPicture(Badges.Piece(Width * 3, 0, Width * 3, Height * 3), Width * 3, Height * 3)
		    Badges.Graphics.DrawingColor = &c000000
		    Badges.Graphics.FillRectangle(0, 0, Badges.Graphics.Width, Badges.Graphics.Height)
		    Sprites.Graphics.DrawPicture(Badges, 0, 0)
		    
		    SpriteSheet = Sprites
		  End If
		  
		  Var Highlight1x As Picture = SpriteSheet.Piece(0, 0, Width, Height)
		  Var Highlight2x As Picture = SpriteSheet.Piece(Width, 0, Width * 2, Height * 2)
		  Var Highlight3x As Picture = SpriteSheet.Piece(Width * 3, 0, Width * 3, Height * 3)
		  Var HighlightMask As New Picture(Width, Height, Array(Highlight1x, Highlight2x, Highlight3x))
		  
		  Var Color1x As Picture = SpriteSheet.Piece(0, Height, Width, Height)
		  Var Color2x As Picture = SpriteSheet.Piece(Width, Height * 2, Width * 2, Height * 2)
		  Var Color3x As Picture = SpriteSheet.Piece(Width * 3, Height * 3, Width * 3, Height * 3)
		  Var ColorMask As New Picture(Width, Height, Array(Color1x, Color2x, Color3x))
		  
		  Var Highlight As Picture = HighlightMask.WithColor(ForegroundColor)
		  Var Fill As Picture = ColorMask.WithColor(AccentColor)
		  
		  Var Bitmaps() As Picture
		  For Factor As Integer = 1 To 3
		    Var HighlightRep As Picture = Highlight.BestRepresentation(Width, Height, Factor)
		    Var ColorRep As Picture = Fill.BestRepresentation(Width, Height, Factor)
		    
		    Var Combined As New Picture(Width * Factor, Width * Factor)
		    Combined.VerticalResolution = 72 * Factor
		    Combined.HorizontalResolution = 72 * Factor
		    Combined.Graphics.DrawPicture(HighlightRep, 0, 0, Combined.Width, Combined.Height, 0, 0, HighlightRep.Width, HighlightRep.Height)
		    Combined.Graphics.DrawPicture(ColorRep, 0, 0, Combined.Width, Combined.Height, 0, 0, ColorRep.Width, ColorRep.Height)
		    
		    Bitmaps.Add(Combined)
		  Next
		  
		  Var Icon As New Picture(Width, Height, Bitmaps)
		  Self.mIconCache.Value(IconID) = Icon
		  Return Icon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainerIcons() As Ark.LootContainerIcon()
		  Var Rows As RowSet = Self.SQLSelect("SELECT icon_id, label FROM loot_icons ORDER BY label;")
		  Var Icons() As Ark.LootContainerIcon
		  While Rows.AfterLastRow = False
		    Var IconUUID As String = Rows.Column("icon_id").StringValue
		    Var IconLabel As String = Rows.Column("label").StringValue
		    Icons.Add(New Ark.LootContainerIcon(IconUUID, IconLabel))
		    Rows.MoveToNextRow
		  Wend
		  Return Icons
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainers(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil, IncludeExperimental As Boolean = False) As Ark.LootContainer()
		  If ContentPacks Is Nil Then
		    ContentPacks = New Beacon.StringList
		  End If
		  Var Blueprints() As Ark.Blueprint = Self.GetBlueprints(Ark.CategoryLootContainers, SearchText, ContentPacks, Tags)
		  Var Containers() As Ark.LootContainer
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    If Blueprint IsA Ark.LootContainer And (IncludeExperimental = True Or Ark.LootContainer(Blueprint).Experimental = False) Then
		      Containers.Add(Ark.LootContainer(Blueprint))
		    End If
		  Next
		  Return Containers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByClass(ClassString As String, ContentPacks As Beacon.StringList) As Ark.LootContainer()
		  Var SQL As String = Self.LootContainerSelectSQL + " WHERE loot_containers.class_string = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND loot_containers.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var LootContainers() As Ark.LootContainer = Self.RowSetToLootContainer(Rows)
		  Self.Cache(LootContainers)
		  Return LootContainers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByPath(Path As String, ContentPacks As Beacon.StringList) As Ark.LootContainer()
		  Var SQL As String = Self.LootContainerSelectSQL + " WHERE loot_containers.path = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND loot_containers.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var LootContainers() As Ark.LootContainer = Self.RowSetToLootContainer(Rows)
		  Self.Cache(LootContainers)
		  Return LootContainers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootTemplateByUUID(UUID As String) As Ark.LootTemplate
		  Var Template As Beacon.Template = Beacon.CommonData.Pool.Get(False).GetTemplateByUUID(UUID)
		  If (Template Is Nil) = False And Template IsA Ark.LootTemplate Then
		    Return Ark.LootTemplate(Template)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootTemplates(Filter As String = "") As Ark.LootTemplate()
		  Var Templates() As Beacon.Template = Beacon.CommonData.Pool.Get(False).GetTemplates(Filter, Ark.Identifier)
		  Var Results() As Ark.LootTemplate
		  For Idx As Integer = 0 To Templates.LastIndex
		    If (Templates(Idx) Is Nil) = False And Templates(Idx) IsA Ark.LootTemplate Then
		      Results.Add(Ark.LootTemplate(Templates(Idx)))
		    End If
		  Next Idx
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMap(Named As String) As Ark.Map
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps WHERE label = ?1 OR ark_identifier = ?1 LIMIT 1;", Named)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Return New Ark.Map(Rows.Column("object_id").StringValue, Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("content_pack_id").StringValue, Rows.Column("sort").IntegerValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps() As Ark.Map()
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps ORDER BY official DESC, sort;")
		  Var Maps() As Ark.Map
		  While Rows.AfterLastRow = False
		    Maps.Add(New Ark.Map(Rows.Column("object_id").StringValue, Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("content_pack_id").StringValue, Rows.Column("sort").IntegerValue))
		    Rows.MoveToNextRow
		  Wend
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps(Mask As UInt64) As Ark.Map()
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps WHERE (mask & ?1) = mask ORDER BY official DESC, sort;", Mask)
		  Var Maps() As Ark.Map
		  While Rows.AfterLastRow = False
		    Maps.Add(New Ark.Map(Rows.Column("object_id").StringValue, Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("content_pack_id").StringValue, Rows.Column("sort").IntegerValue))
		    Rows.MoveToNextRow
		  Wend
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPopulationFigures(Point As Ark.SpawnPoint) As Ark.PopulationFigures()
		  Var Figures() As Ark.PopulationFigures
		  Var Rows As RowSet = Self.SQLSelect("SELECT map_id, instances, target_population FROM spawn_point_populations WHERE spawn_point_id = ?1;", Point.SpawnPointId)
		  While Rows.AfterLastRow = False
		    Figures.Add(New Ark.PopulationFigures(Rows.Column("map_id").StringValue, Rows.Column("instances").IntegerValue, Rows.Column("target_population").IntegerValue))
		    Rows.MoveToNextRow
		  Wend
		  Return Figures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPopulationFigures(Point As Ark.SpawnPoint, Map As Ark.Map) As Ark.PopulationFigures()
		  Var Figures() As Ark.PopulationFigures
		  Var Rows As RowSet = Self.SQLSelect("SELECT map_id, instances, target_population FROM spawn_point_populations WHERE spawn_point_id = ?1 AND map_id = ?2;", Point.SpawnPointId, Map.Identifier)
		  While Rows.AfterLastRow = False
		    Figures.Add(New Ark.PopulationFigures(Rows.Column("map_id").StringValue, Rows.Column("instances").IntegerValue, Rows.Column("target_population").IntegerValue))
		    Rows.MoveToNextRow
		  Wend
		  Return Figures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRecipeEngramIds(ContentPacks As Beacon.StringList, Mask As UInt64) As String()
		  // I hate the name of this method
		  
		  Var SQL As String = "SELECT object_id FROM engrams WHERE recipe != '[]' AND (availability & " + Mask.ToString + ") > 0"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    Var List() As String
		    For Each ContentPackId As String In ContentPacks
		      List.Add("'" + ContentPackId + "'")
		    Next
		    SQL = SQL + " AND content_pack_id IN (" + List.Join(",") + ")"
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL)
		  Var Results() As String
		  While Not Rows.AfterLastRow
		    Results.Add(Rows.Column("object_id").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoint(SpawnPointId As String, UseCache As Boolean = True) As Ark.SpawnPoint
		  If UseCache And Self.mBlueprintCache.HasKey(SpawnPointId) Then
		    Return Self.mBlueprintCache.Value(SpawnPointId)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE object_id = ?1;", SpawnPointId)
		    If Results.RowCount <> 1 Then
		      Return Nil
		    End If
		    
		    Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Results, UseCache)
		    Self.Cache(SpawnPoints)
		    Return SpawnPoints(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointLabels(Availability As UInt64) As Dictionary
		  If Self.mSpawnLabelCacheMask <> Availability Then
		    Var Points() As Ark.SpawnPoint = Self.GetSpawnPoints()
		    Var Labels() As String
		    Var Dict As New Dictionary
		    Labels.ResizeTo(Points.LastIndex)
		    
		    For I As Integer = 0 To Points.LastIndex
		      If Points(I).ValidForMask(Availability) = False Then
		        Continue
		      End If
		      
		      Var Label As String = Points(I).Label
		      Var Idx As Integer = Labels.IndexOf(Label)
		      Labels(I) = Label
		      If Idx > -1 Then
		        Var Filtered As UInt64 = Points(Idx).Availability And Availability
		        Var Maps() As Ark.Map = Self.GetMaps(Filtered)
		        Dict.Value(Points(Idx).SpawnPointId) = Points(Idx).Label.Disambiguate(Maps.Label)
		        
		        Filtered = Points(I).Availability And Availability
		        Maps = Self.GetMaps(Filtered)
		        Label = Label.Disambiguate(Maps.Label)
		      End If
		      
		      Dict.Value(Points(I).SpawnPointId) = Label
		    Next
		    
		    Self.mSpawnLabelCacheDict = Dict
		    Self.mSpawnLabelCacheMask = Availability
		  End If
		  
		  Return Self.mSpawnLabelCacheDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoints(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As Ark.SpawnPoint()
		  If ContentPacks Is Nil Then
		    ContentPacks = New Beacon.StringList
		  End If
		  Var Blueprints() As Ark.Blueprint = Self.GetBlueprints(Ark.CategorySpawnPoints, SearchText, ContentPacks, Tags)
		  Var Points() As Ark.SpawnPoint
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    If Blueprint IsA Ark.SpawnPoint Then
		      Points.Add(Ark.SpawnPoint(Blueprint))
		    End If
		  Next
		  Return Points
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByClass(ClassString As String, ContentPacks As Beacon.StringList) As Ark.SpawnPoint()
		  Var SQL As String = Self.SpawnPointSelectSQL + " WHERE spawn_points.class_string = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND spawn_points.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Rows)
		  Self.Cache(SpawnPoints)
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByPath(Path As String, ContentPacks As Beacon.StringList) As Ark.SpawnPoint()
		  Var SQL As String = Self.SpawnPointSelectSQL + " WHERE spawn_points.path = ?1"
		  If (ContentPacks Is Nil) = False And ContentPacks.Count > 0 Then
		    SQL = SQL + " AND spawn_points.content_pack_id IN (" + ContentPacks.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Rows)
		  Self.Cache(SpawnPoints)
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsForCreature(Creature As Ark.Creature, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec) As Ark.SpawnPoint()
		  Var Clauses() As String
		  Var Values() As Variant
		  Clauses.Add("spawn_points.sets LIKE :placeholder:")
		  Values.Add("%" + Creature.CreatureId + "%")
		  
		  Var Blueprints() As Ark.Blueprint = Self.GetBlueprints(Ark.CategorySpawnPoints, "", ContentPacks, Tags, Clauses, Values)
		  Var SpawnPoints() As Ark.SpawnPoint
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    If Blueprint IsA Ark.SpawnPoint Then
		      SpawnPoints.Add(Ark.SpawnPoint(Blueprint))
		    End If
		  Next
		  
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStringVariable(Key As String, Default As String = "") As String
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Var StringValue As String = Value.StringValue
		  If StringValue.Encoding = Nil Then
		    If Encodings.UTF8.IsValidData(StringValue) Then
		      StringValue = StringValue.DefineEncoding(Encodings.UTF8)
		    Else
		      Return Default
		    End If
		  End If
		  Return StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTags(Mods As Beacon.StringList, Category As String = "") As String()
		  Var Results As RowSet
		  If Category.IsEmpty = False Then
		    If Mods.Count > 0 Then
		      Results = Self.SQLSelect("SELECT DISTINCT tags_" + Category + ".tag FROM tags_" + Category + " INNER JOIN " + Category + " ON (tags_" + Category + ".object_id = " + Category + ".object_id) WHERE " + Category + ".content_pack_id IN ('" + Mods.Join("','") + "') ORDER BY tags_" + Category + ".tag;")
		    Else
		      Results = Self.SQLSelect("SELECT DISTINCT tag FROM tags_" + Category + " ORDER BY tag;")
		    End If
		  Else
		    If Mods.Count > 0 Then
		      Results = Self.SQLSelect("SELECT DISTINCT tags.tag FROM tags INNER JOIN blueprints ON (tags.object_id = blueprints.object_id) WHERE blueprints.content_pack_id IN ('" + Mods.Join("','") + "') ORDER BY tags.tag;")
		    Else
		      Results = Self.SQLSelect("SELECT DISTINCT tag FROM tags ORDER BY tag;")
		    End If
		  End If
		  Var Dict As New Dictionary
		  While Not Results.AfterLastRow
		    Var Tags() As String = Results.Column("tag").StringValue.Split(",")
		    For Each Tag As String In Tags
		      Dict.Value(Tag) = True
		    Next
		    Results.MoveToNextRow
		  Wend
		  
		  Var Keys() As Variant = Dict.Keys
		  Var Tags() As String
		  For Each Key As String In Keys
		    Tags.Add(Key)
		  Next
		  Tags.Sort
		  
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplateByUUID(UUID As String) As Ark.Template
		  Var Template As Beacon.Template = Beacon.CommonData.Pool.Get(False).GetTemplateByUUID(UUID)
		  If (Template Is Nil) = False And Template IsA Ark.Template Then
		    Return Ark.Template(Template)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplates(Filter As String = "") As Ark.Template()
		  Var Templates() As Beacon.Template = Beacon.CommonData.Pool.Get(False).GetTemplates(Filter, Ark.Identifier)
		  Var Results() As Ark.Template
		  For Idx As Integer = 0 To Templates.LastIndex
		    If (Templates(Idx) Is Nil) = False And Templates(Idx) IsA Ark.Template Then
		      Results.Add(Ark.Template(Templates(Idx)))
		    End If
		  Next Idx
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUWPConfigOptions() As Ark.ConfigOption()
		  Var SQL As String = Self.ConfigOptionSelectSQL + " WHERE uwp_changes IS NOT NULL;"
		  Var Results() As Ark.ConfigOption
		  Try
		    Results = Self.RowSetToConfigOptions(Self.SQLSelect(SQL))
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		  End Try
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetVariable(Key As String, Default As Variant = Nil) As Variant
		  Var Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").Value
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasExperimentalLootContainers(ContentPacks As Beacon.StringList) As Boolean
		  Try
		    Var Clauses(0) As String
		    Clauses(0) = "experimental = 1"
		    
		    Var Values As New Dictionary
		    Var NextPlaceholder As Integer = 1
		    If ContentPacks.LastRowIndex > -1 Then
		      Var Placeholders() As String
		      For Each PackUUID As String In ContentPacks
		        Placeholders.Add("?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		        Values.Value(NextPlaceholder) = PackUUID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.Add("content_packs.content_pack_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    
		    Var SQL As String = "SELECT COUNT(loot_containers.object_id) FROM loot_containers INNER JOIN content_packs ON (loot_containers.content_pack_id = content_packs.content_pack_id) WHERE (" + Clauses.Join(") AND (") + ");"
		    Var Results As RowSet
		    If Values.KeyCount > 0 Then
		      Results = Self.SQLSelect(SQL, Values)
		    Else
		      Results = Self.SQLSelect(SQL)
		    End If
		    Return Results.ColumnAt(0).IntegerValue > 0
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(Blueprint As Ark.Blueprint)
		  If Blueprint Is Nil Then
		    Return
		  End If
		  
		  If Self.mBlueprintCache.HasKey(Blueprint.BlueprintId) Then
		    Self.mBlueprintCache.Remove(Blueprint.BlueprintId)
		  End If
		  
		  If Blueprint IsA Ark.Engram And Self.mBlueprintCache.HasKey("EngramEntry:" + Ark.Engram(Blueprint).EntryString) Then
		    Self.mBlueprintCache.Remove("EngramEntry:" + Ark.Engram(Blueprint).EntryString)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate(BlueprintId As String)
		  If Self.mBlueprintCache.HasKey(BlueprintId) Then
		    Self.mBlueprintCache.Remove(BlueprintId)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT entry_string FROM engrams WHERE object_id = ?1 AND entry_string IS NOT NULL;")
		  For Each Row As DatabaseRow In Rows
		    If Self.mBlueprintCache.HasKey("EngramEntry:" + Row.Column("entry_string").StringValue) Then
		      Self.mBlueprintCache.Remove("EngramEntry:" + Row.Column("entry_string").StringValue)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadIngredientsForEngram(Engram As Ark.Engram) As Ark.CraftingCostIngredient()
		  Var Ingredients() As Ark.CraftingCostIngredient
		  If (Engram Is Nil) = False Then
		    Var Results As RowSet = Self.SQLSelect("SELECT recipe FROM engrams WHERE object_id = ?1;", Engram.EngramId)
		    If Results.RowCount = 1 Then
		      Ingredients = Ark.CraftingCostIngredient.FromVariant(Results.Column("recipe").Value, Nil)
		    End If
		  End If
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainInstance() As Beacon.DataSource
		  Return Self.Pool.Main()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OfficialPlayerLevelData() As Ark.PlayerLevelData
		  If Self.mOfficialPlayerLevelData Is Nil Then
		    Self.mOfficialPlayerLevelData = Ark.PlayerLevelData.FromString(Self.GetStringVariable("Player Leveling"))
		  End If
		  Return Self.mOfficialPlayerLevelData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Pool() As Ark.DataSourcePool
		  If mPool Is Nil Then
		    mPool = New Ark.DataSourcePool
		  End If
		  Return mPool
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PossibleBlueprintFilenames() As String()
		  Return Array("/Ark/Blueprints" + Beacon.FileExtensionDelta, "/Ark/Blueprints.json", "/Blueprints.json", "/Engrams.json")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReplaceUserBlueprints()
		  If Self.Writeable = False Then
		    Return
		  End If
		  
		  Var Pack As Beacon.ContentPack = Beacon.ContentPack.CreateUserContentPack(Self.Identifier, Ark.UserContentPackName, Ark.UserContentPackId)
		  Call Self.SaveContentPack(Pack, False, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResolvePathFromClassString(ClassString As String) As String
		  Var Results As RowSet = Self.SQLSelect("SELECT path FROM blueprints WHERE class_string = ?1;", ClassString)
		  If Results.RowCount = 0 Then
		    Return ""
		  End If
		  
		  Return Results.Column("path").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToConfigOptions(Results As RowSet) As Ark.ConfigOption()
		  Var Keys() As Ark.ConfigOption
		  Try
		    While Results.AfterLastRow = False
		      Var ConfigOptionId As String = Results.Column("object_id").StringValue
		      If Self.mConfigOptionCache.HasKey(ConfigOptionId) Then
		        Results.MoveToNextRow
		        Keys.Add(Self.mConfigOptionCache.Value(ConfigOptionId))
		        Continue
		      End If
		      
		      Var Label As String = Results.Column("label").StringValue
		      Var ConfigFile As String = Results.Column("file").StringValue
		      Var ConfigHeader As String = Results.Column("header").StringValue
		      Var ConfigOption As String = Results.Column("key").StringValue
		      Var ValueType As Ark.ConfigOption.ValueTypes
		      Select Case Results.Column("value_type").StringValue
		      Case "Numeric"
		        ValueType = Ark.ConfigOption.ValueTypes.TypeNumeric
		      Case "Array"
		        ValueType = Ark.ConfigOption.ValueTypes.TypeArray
		      Case "Structure"
		        ValueType = Ark.ConfigOption.ValueTypes.TypeStructure
		      Case "Boolean"
		        ValueType = Ark.ConfigOption.ValueTypes.TypeBoolean
		      Case "Text"
		        ValueType = Ark.ConfigOption.ValueTypes.TypeText
		      End Select
		      Var MaxAllowed As NullableDouble
		      If IsNull(Results.Column("max_allowed").Value) = False Then
		        MaxAllowed = Results.Column("max_allowed").IntegerValue
		      End If
		      Var Description As String = Results.Column("description").StringValue
		      Var DefaultValue As Variant = Results.Column("default_value").Value
		      Var NitradoPath As NullableString
		      Var NitradoFormat As Ark.ConfigOption.NitradoFormats = Ark.ConfigOption.NitradoFormats.Unsupported
		      Var NitradoDeployStyle As Ark.ConfigOption.NitradoDeployStyles = Ark.ConfigOption.NitradoDeployStyles.Unsupported
		      If IsNull(Results.Column("nitrado_format").Value) = False Then
		        NitradoPath = Results.Column("nitrado_path").StringValue
		        Select Case Results.Column("nitrado_format").StringValue
		        Case "Line"
		          NitradoFormat = Ark.ConfigOption.NitradoFormats.Line
		        Case "Value"
		          NitradoFormat = Ark.ConfigOption.NitradoFormats.Value
		        End Select
		        Select Case Results.Column("nitrado_deploy_style").StringValue
		        Case "Guided"
		          NitradoDeployStyle = Ark.ConfigOption.NitradoDeployStyles.Guided
		        Case "Expert"
		          NitradoDeployStyle = Ark.ConfigOption.NitradoDeployStyles.Expert
		        Case "Both"
		          NitradoDeployStyle = Ark.ConfigOption.NitradoDeployStyles.Both
		        End Select
		      End If
		      Var NativeEditorVersion As NullableDouble = NullableDouble.FromVariant(Results.Column("native_editor_version").Value)
		      Var UIGroup As NullableString = NullableString.FromVariant(Results.Column("ui_group").Value)
		      Var CustomSort As NullableString = NullableString.FromVariant(Results.Column("custom_sort").Value)
		      Var ContentPackId As String = Results.Column("content_pack_id").StringValue
		      Var GSAPlaceholder As NullableString = NullableString.FromVariant(Results.Column("gsa_placeholder").Value)
		      
		      Var Constraints As Dictionary
		      If IsNull(Results.Column("constraints").Value) = False Then
		        Try
		          Var Parsed As Variant = Beacon.ParseJSON(Results.Column("constraints").StringValue)
		          If IsNull(Parsed) = False And Parsed IsA Dictionary Then
		            Constraints = Parsed
		          End If
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      
		      Var UWPChanges As Dictionary
		      If IsNull(Results.Column("uwp_changes").Value) = False Then
		        Try
		          Var Parsed As Variant = Beacon.ParseJSON(Results.Column("uwp_changes").StringValue)
		          If IsNull(Parsed) = False And Parsed IsA Dictionary Then
		            UWPChanges = Parsed
		          End If
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      
		      Var Key As New Ark.ConfigOption(ConfigOptionId, Label, ConfigFile, ConfigHeader, ConfigOption, ValueType, MaxAllowed, Description, DefaultValue, NitradoPath, NitradoFormat, NitradoDeployStyle, NativeEditorVersion, UIGroup, CustomSort, Constraints, ContentPackId, GSAPlaceholder, UWPChanges)
		      Self.mConfigOptionCache.Value(ConfigOptionId) = Key
		      Keys.Add(Key)
		      Results.MoveToNextRow
		    Wend
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		    Keys.ResizeTo(-1)
		  End Try
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToCreature(Results As RowSet, UseCache As Boolean = True) As Ark.Creature()
		  Var Creatures() As Ark.Creature
		  While Not Results.AfterLastRow
		    Var CreatureId As String = Results.Column("object_id").StringValue
		    Var LastUpdate As Double = Results.Column("last_update").DoubleValue
		    If UseCache = False Or Self.mBlueprintCache.HasKey(CreatureId) = False Or Ark.Creature(Self.mBlueprintCache.Value(CreatureId)).LastUpdate < LastUpdate Then
		      Var Creature As New Ark.MutableCreature(Results.Column("path").StringValue, CreatureId)
		      Creature.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Creature.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Creature.Availability = Results.Column("availability").Value
		      Creature.LastUpdate = LastUpdate
		      Creature.TagString = Results.Column("tags").StringValue
		      Creature.ContentPackId = Results.Column("content_pack_id").StringValue
		      Creature.ContentPackName = Results.Column("content_pack_name").StringValue
		      If Results.Column("stats").Value <> Nil And Results.Column("used_stats").Value <> Nil Then
		        Creature.ConsumeStats(Results.Column("stats").StringValue)
		        Creature.StatsMask = Results.Column("used_stats").Value
		      End If
		      
		      If Results.Column("incubation_time").Value <> Nil Then
		        Creature.IncubationTime = Results.Column("incubation_time").DoubleValue
		      End If
		      If Results.Column("mature_time").Value <> Nil Then
		        Creature.MatureTime = Results.Column("mature_time").DoubleValue
		      End If
		      If Results.Column("mating_interval_min").Value <> Nil And Results.Column("mating_interval_max").Value <> Nil Then
		        Creature.MinMatingInterval = Results.Column("mating_interval_min").DoubleValue
		        Creature.MaxMatingInterval = Results.Column("mating_interval_max").DoubleValue
		      End If
		      
		      Self.mBlueprintCache.Value(CreatureId) = Creature.ImmutableVersion
		    End If
		    
		    Creatures.Add(Self.mBlueprintCache.Value(CreatureId))
		    Results.MoveToNextRow
		  Wend
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToCreatureColors(Rows As RowSet) As Ark.CreatureColor()
		  Var CreatureColors() As Ark.CreatureColor
		  While Rows.AfterLastRow = False
		    Var Label As String = Rows.Column("label").StringValue
		    Var ID As Integer = Rows.Column("color_id").IntegerValue
		    Var HexValue As String = Rows.Column("hex_value").StringValue
		    CreatureColors.Add(New Ark.CreatureColor(ID, Label, HexValue))
		    Rows.MoveToNextRow
		  Wend
		  Return CreatureColors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToCreatureColorSets(Rows As RowSet) As Ark.CreatureColorSet()
		  Var Sets() As Ark.CreatureColorSet
		  While Rows.AfterLastRow = False
		    Var Label As String = Rows.Column("label").StringValue
		    Var UUID As String = Rows.Column("color_set_id").StringValue
		    Var ClassString As String = Rows.Column("class_string").StringValue
		    Sets.Add(New Ark.CreatureColorSet(UUID, Label, ClassString))
		    Rows.MoveToNextRow
		  Wend
		  Return Sets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToEngram(Results As RowSet, UseCache As Boolean = True) As Ark.Engram()
		  Var Engrams() As Ark.Engram
		  While Not Results.AfterLastRow
		    Var EngramId As String = Results.Column("object_id").StringValue
		    Var LastUpdate As Double = Results.Column("last_update").DoubleValue
		    If UseCache = False Or Self.mBlueprintCache.HasKey(EngramId) = False Or Ark.Engram(Self.mBlueprintCache.Value(EngramId)).LastUpdate < LastUpdate Then
		      Var Engram As New Ark.MutableEngram(Results.Column("path").StringValue, EngramId)
		      Engram.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Engram.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Engram.Availability = Results.Column("availability").Value
		      Engram.LastUpdate = LastUpdate
		      Engram.TagString = Results.Column("tags").StringValue
		      Engram.ContentPackId = Results.Column("content_pack_id").StringValue
		      Engram.ContentPackName = Results.Column("content_pack_name").StringValue
		      If IsNull(Results.Column("entry_string").Value) = False And Results.Column("entry_string").StringValue.IsEmpty = False Then
		        Engram.EntryString = Results.Column("entry_string").StringValue
		        
		        If IsNull(Results.Column("required_points").Value) = False And IsNull(Results.Column("required_level").Value) = False Then
		          Engram.RequiredPlayerLevel = Results.Column("required_level").IntegerValue
		          Engram.RequiredUnlockPoints = Results.Column("required_points").IntegerValue
		        End If
		      End If
		      If IsNull(Results.Column("stack_size").Value) = False Then
		        Engram.StackSize = Results.Column("stack_size").IntegerValue
		      End If
		      If IsNull(Results.Column("item_id").Value) = False Then
		        Engram.ItemID = Results.Column("item_id").IntegerValue
		      End If
		      Self.mBlueprintCache.Value(EngramId) = Engram.ImmutableVersion
		    End If
		    
		    Engrams.Add(Self.mBlueprintCache.Value(EngramId))
		    Results.MoveToNextRow
		  Wend
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToGameEvents(Rows As RowSet) As Ark.GameEvent()
		  Var GameEvents() As Ark.GameEvent
		  While Rows.AfterLastRow = False
		    Var Label As String = Rows.Column("label").StringValue
		    Var EventUUID As String = Rows.Column("event_id").StringValue
		    Var ArkCode As String = Rows.Column("ark_code").StringValue
		    Var ColorsJSON As String = Rows.Column("colors").StringValue
		    Var RatesJSON As String = Rows.Column("rates").StringValue
		    Var EngramsJSON As String = Rows.Column("engrams").StringValue
		    GameEvents.Add(New Ark.GameEvent(EventUUID, Label, ArkCode, ColorsJSON, RatesJSON, EngramsJSON))
		    Rows.MoveToNextRow
		  Wend
		  Return GameEvents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToLootContainer(Results As RowSet, UseCache As Boolean = True) As Ark.LootContainer()
		  Var Sources() As Ark.LootContainer
		  While Not Results.AfterLastRow
		    Var LootDropId As String = Results.Column("object_id").StringValue
		    Var LastUpdate As Double = Results.Column("last_update").DoubleValue
		    If UseCache = False Or Self.mBlueprintCache.HasKey(LootDropId) = False Or Ark.LootContainer(Self.mBlueprintCache.Value(LootDropId)).LastUpdate < LastUpdate Then
		      Var Requirements As Dictionary
		      #Pragma BreakOnExceptions Off
		      Try
		        Requirements = Beacon.ParseJSON(Results.Column("requirements").StringValue)
		      Catch Err As RuntimeException
		        Requirements = New Dictionary
		      End Try
		      #Pragma BreakOnExceptions Default
		      
		      Var Source As New Ark.MutableLootContainer(Results.Column("path").StringValue, Results.Column("object_id").StringValue)
		      Source.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Source.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Source.Availability = Results.Column("availability").Value
		      Source.LastUpdate = LastUpdate
		      Source.Multipliers = New Beacon.Range(Results.Column("multiplier_min").DoubleValue, Results.Column("multiplier_max").DoubleValue)
		      Source.UIColor = Results.Column("uicolor").StringValue.ToColor
		      Source.SortValue = Results.Column("sort_order").IntegerValue
		      Source.Experimental = Results.Column("experimental").BooleanValue
		      Source.Notes = Results.Column("notes").StringValue
		      Source.ContentPackId = Results.Column("content_pack_id").StringValue
		      Source.ContentPackName = Results.Column("content_pack_name").StringValue
		      Source.TagString = Results.Column("tags").StringValue
		      Source.IconID = Results.Column("icon").StringValue
		      Source.MinItemSets = Results.Column("min_item_sets").IntegerValue
		      Source.MaxItemSets = Results.Column("max_item_sets").IntegerValue
		      Source.PreventDuplicates = Results.Column("prevent_duplicates").BooleanValue
		      Source.ContentsString = Results.Column("contents").StringValue
		      
		      If Requirements.HasKey("min_item_sets") And IsNull(Requirements.Value("min_item_sets")) = False Then
		        Source.RequiredItemSetCount = Requirements.Value("min_item_sets")
		      End If
		      
		      Source.Modified = False
		      Self.mBlueprintCache.Value(Source.LootDropId) = Source.ImmutableVersion
		    End If
		    
		    Sources.Add(Self.mBlueprintCache.Value(LootDropId))
		    Results.MoveToNextRow
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToSpawnPoint(Results As RowSet, UseCache As Boolean = True) As Ark.SpawnPoint()
		  Var SpawnPoints() As Ark.SpawnPoint
		  While Not Results.AfterLastRow
		    Var SpawnPointId As String = Results.Column("object_id").StringValue
		    Var LastUpdate As Double = Results.Column("last_update").DoubleValue
		    If UseCache = False Or Self.mBlueprintCache.HasKey(SpawnPointId) = False Or Ark.SpawnPoint(Self.mBlueprintCache.Value(SpawnPointId)).LastUpdate < LastUpdate Then
		      Var Point As New Ark.MutableSpawnPoint(Results.Column("path").StringValue, SpawnPointId)
		      Point.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Point.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Point.Availability = Results.Column("availability").Value
		      Point.LastUpdate = LastUpdate
		      Point.TagString = Results.Column("tags").StringValue
		      Point.ContentPackId = Results.Column("content_pack_id").StringValue
		      Point.ContentPackName = Results.Column("content_pack_name").StringValue
		      Point.LimitsString = Results.Column("limits").StringValue
		      Point.SetsString = Results.Column("sets").StringValue
		      Point.Modified = False
		      Self.mBlueprintCache.Value(SpawnPointId) = Point.ImmutableVersion
		    End If
		    
		    SpawnPoints.Add(Self.mBlueprintCache.Value(SpawnPointId))
		    Results.MoveToNextRow
		  Wend
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveBlueprints(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As Ark.Blueprint, ErrorDict As Dictionary, DoCloudExport As Boolean) As Boolean
		  Var DeleteUUIDs() As String
		  If (BlueprintsToDelete Is Nil) = False Then
		    For Each Blueprint As Ark.Blueprint In BlueprintsToDelete
		      DeleteUUIDs.Add(Blueprint.BlueprintId)
		    Next Blueprint
		  End If
		  
		  Return Self.SaveBlueprints(BlueprintsToSave, DeleteUUIDs, ErrorDict, True, DoCloudExport)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveBlueprints(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As String, ErrorDict As Dictionary, DoCloudExport As Boolean) As Boolean
		  Return Self.SaveBlueprints(BlueprintsToSave, BlueprintsToDelete, ErrorDict, True, DoCloudExport)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SaveBlueprints(BlueprintsToSave() As Ark.Blueprint, BlueprintsToDelete() As String, ErrorDict As Dictionary, LocalModsOnly As Boolean, DoCloudExport As Boolean) As Boolean
		  If (BlueprintsToDelete Is Nil Or BlueprintsToDelete.Count = 0) And (BlueprintsToSave Is Nil Or BlueprintsToSave.Count = 0) Then
		    // Nothing to do
		    Return True
		  End If
		  
		  Var CountSuccess, CountErrors As Integer
		  Var Now As Double = DateTime.Now.SecondsFrom1970
		  
		  Self.BeginTransaction()
		  If (BlueprintsToDelete Is Nil) = False Then
		    If (BlueprintsToSave Is Nil) = False Then
		      For Idx As Integer = BlueprintsToSave.FirstIndex To BlueprintsToSave.LastIndex
		        Var DeleteIdx As Integer = BlueprintsToDelete.IndexOf(BlueprintsToSave(Idx).BlueprintId)
		        If DeleteIdx > -1 Then
		          BlueprintsToDelete.RemoveAt(DeleteIdx)
		        End If
		      Next Idx
		    End If
		    
		    For Each BlueprintId As String In BlueprintsToDelete
		      Var TransactionStarted As Boolean
		      Try
		        Var Rows As RowSet
		        If LocalModsOnly Then
		          Rows = Self.SQLSelect("SELECT content_pack_id FROM blueprints WHERE object_id = ?1 AND content_pack_id IN (SELECT content_pack_id FROM content_packs WHERE type = ?2);", BlueprintId, Beacon.ContentPack.TypeLocal)
		        Else
		          Rows = Self.SQLSelect("SELECT content_pack_id FROM blueprints WHERE object_id = ?1;", BlueprintId)
		        End If
		        If Rows.RowCount = 0 Then
		          Continue
		        End If
		        
		        Self.BeginTransaction()
		        TransactionStarted = True
		        Self.SQLExecute("UPDATE content_packs SET last_update = ?2 WHERE content_pack_id = ?1;", Rows.Column("content_pack_id").StringValue, Now)
		        Self.SQLExecute("DELETE FROM blueprints WHERE object_id = ?1;", BlueprintId)
		        Self.CommitTransaction()
		        Self.Invalidate(BlueprintId)
		        TransactionStarted = False
		        CountSuccess = CountSuccess + 1
		      Catch Err As RuntimeException
		        If TransactionStarted Then
		          Self.RollbackTransaction()
		        End If
		        If (ErrorDict Is Nil) = False Then
		          ErrorDict.Value(BlueprintId) = Err
		        Else
		          App.Log("Unable to delete blueprint " + BlueprintId + ": Error #" + Err.ErrorNumber.ToString(Locale.Raw, "0") + " " + Err.Message.NthField(EndOfLine, 1))
		        End If
		        CountErrors = CountErrors + 1
		      End Try
		    Next BlueprintId
		  End If
		  
		  If (BlueprintsToSave Is Nil) = False Then
		    For Each Blueprint As Ark.Blueprint In BlueprintsToSave
		      Var TransactionStarted As Boolean
		      Try
		        Var UpdateBlueprintId, CurrentTagString As String
		        Var Results As RowSet
		        If LocalModsOnly Then
		          Results = Self.SQLSelect("SELECT object_id, last_update, content_pack_id IN (SELECT content_pack_id FROM content_packs WHERE type = ?4) AS is_user_blueprint, tags FROM blueprints WHERE object_id = ?1 OR (content_pack_id = ?2 AND path = ?3);", Blueprint.BlueprintId, Blueprint.ContentPackId, Blueprint.Path, Beacon.ContentPack.TypeLocal)
		        Else
		          Results = Self.SQLSelect("SELECT object_id, last_update, tags FROM blueprints WHERE object_id = ?1 OR (content_pack_id = ?2 AND path = ?3);", Blueprint.BlueprintId, Blueprint.ContentPackId, Blueprint.Path)
		        End If
		        If Results.RowCount = 1 Then
		          If LocalModsOnly And Results.Column("is_user_blueprint").BooleanValue = False Then
		            If (ErrorDict Is Nil) = False Then
		              Var UnsupportedErr As New UnsupportedOperationException
		              UnsupportedErr.Message = "Cannot update built-in blueprint."
		              ErrorDict.Value(Blueprint.BlueprintId) = UnsupportedErr
		            End If
		            Continue
		          End If
		          If Blueprint.LastUpdate <= Results.Column("last_update").DoubleValue Then
		            // The version in the database is newer or unchanged
		            CountSuccess = CountSuccess + 1
		            Continue
		          End If
		          UpdateBlueprintId = Results.Column("object_id").StringValue
		          CurrentTagString = Results.Column("tags").StringValue
		        ElseIf Results.RowCount > 1 Then
		          // What the hell?
		          Continue
		        End If
		        
		        If Blueprint.Path.IsEmpty Or Blueprint.ClassString.IsEmpty Then
		          Continue
		        End If
		        
		        Var Category As String = Blueprint.Category
		        Var Columns As New Dictionary
		        Columns.Value("object_id") = Blueprint.BlueprintId
		        Columns.Value("path") = Blueprint.Path
		        Columns.Value("class_string") = Blueprint.ClassString
		        Columns.Value("label") = Blueprint.Label
		        Columns.Value("tags") = Blueprint.TagString
		        Columns.Value("availability") = Blueprint.Availability
		        Columns.Value("content_pack_id") = Blueprint.ContentPackId
		        If Blueprint.AlternateLabel Is Nil Then
		          Columns.Value("alternate_label") = Nil
		        Else
		          Columns.Value("alternate_label") = Blueprint.AlternateLabel.StringValue
		        End If
		        Columns.Value("last_update") = Blueprint.LastUpdate
		        
		        Select Case Blueprint
		        Case IsA Ark.Creature
		          Var Creature As Ark.Creature = Ark.Creature(Blueprint)
		          If Creature.IncubationTime > 0 And Creature.MatureTime > 0 Then
		            Columns.Value("incubation_time") = Creature.IncubationTime
		            Columns.Value("mature_time") = Creature.MatureTime
		          Else
		            Columns.Value("incubation_time") = Nil
		            Columns.Value("mature_time") = Nil
		          End If
		          If Creature.MinMatingInterval > 0 And Creature.MaxMatingInterval > 0 Then
		            Columns.Value("mating_interval_min") = Creature.MinMatingInterval
		            Columns.Value("mating_interval_max") = Creature.MaxMatingInterval
		          Else
		            Columns.Value("mating_interval_min") = Nil
		            Columns.Value("mating_interval_max") = Nil
		          End If
		          Columns.Value("used_stats") = Creature.StatsMask
		          
		          Var StatDicts() As Dictionary
		          Var StatValues() As Ark.CreatureStatValue = Creature.AllStatValues
		          For Each StatValue As Ark.CreatureStatValue In StatValues
		            StatDicts.Add(StatValue.SaveData)
		          Next
		          Columns.Value("stats") = Beacon.GenerateJSON(StatDicts, False)
		        Case IsA Ark.SpawnPoint
		          Columns.Value("sets") = Ark.SpawnPoint(Blueprint).SetsString()
		          Columns.Value("limits") = Ark.SpawnPoint(Blueprint).LimitsString()
		        Case IsA Ark.Engram
		          Var Engram As Ark.Engram = Ark.Engram(Blueprint)
		          Columns.Value("recipe") = Ark.CraftingCostIngredient.ToJSON(Engram.Recipe, False)
		          If Engram.EntryString.IsEmpty Then
		            Columns.Value("entry_string") = Nil
		          Else
		            Columns.Value("entry_string") = Engram.EntryString
		          End If
		          If Engram.RequiredPlayerLevel Is Nil Then
		            Columns.Value("required_level") = Nil
		          Else
		            Columns.Value("required_level") = Engram.RequiredPlayerLevel.IntegerValue
		          End If
		          If Engram.RequiredUnlockPoints Is Nil Then
		            Columns.Value("required_points") = Nil
		          Else
		            Columns.Value("required_points") = Engram.RequiredUnlockPoints.IntegerValue
		          End If
		          If Engram.StackSize Is Nil Then
		            Columns.Value("stack_size") = Nil
		          Else
		            Columns.Value("stack_size") = Engram.StackSize.IntegerValue
		          End If
		        Case IsA Ark.LootContainer
		          Var Container As Ark.LootContainer = Ark.LootContainer(Blueprint)
		          Var Requirements As New Dictionary
		          If Container.RequiredItemSetCount > 0 Then
		            Requirements.Value("min_item_sets") = Container.RequiredItemSetCount
		          End If
		          
		          Columns.Value("multiplier_min") = Container.Multipliers.Min
		          Columns.Value("multiplier_max") = Container.Multipliers.Max
		          Columns.Value("uicolor") = Container.UIColor.ToHex
		          Columns.Value("sort_order") = Container.SortValue
		          Columns.Value("icon") = Container.IconID
		          Columns.Value("experimental") = Container.Experimental
		          Columns.Value("notes") = Container.Notes
		          Columns.Value("requirements") = Beacon.GenerateJSON(Requirements, False)
		          Columns.Value("min_item_sets") = Container.MinItemSets
		          Columns.Value("max_item_sets") = Container.MaxItemSets
		          Columns.Value("prevent_duplicates") = Container.PreventDuplicates
		          Columns.Value("contents") = Container.ContentsString(False)
		        End Select
		        
		        Self.BeginTransaction()
		        TransactionStarted = True
		        If UpdateBlueprintId.IsEmpty = False Then
		          Var Assignments() As String
		          Var Values() As Variant
		          Var NextPlaceholder As Integer = 1
		          Var WhereClause As String
		          For Each Entry As DictionaryEntry In Columns
		            Var MakeAssignment As Boolean
		            If Entry.Key = "object_id" Then
		              WhereClause = "object_id = ?" + NextPlaceholder.ToString
		              MakeAssignment = Entry.Value.StringValue <> Blueprint.BlueprintId
		            Else
		              MakeAssignment = True
		            End If
		            
		            If MakeAssignment Then
		              Assignments.Add(Entry.Key.StringValue + " = ?" + NextPlaceholder.ToString)
		            End If
		            
		            Values.Add(Entry.Value)
		            NextPlaceholder = NextPlaceholder + 1
		          Next
		          
		          Self.SQLExecute("UPDATE " + Category + " SET " + Assignments.Join(", ") + " WHERE " + WhereClause + ";", Values)
		          
		          If Columns.Value("tags").StringValue <> CurrentTagString Then
		            Var DesiredTags() As String = Blueprint.Tags
		            Var CurrentTags() As String
		            Var TagRows As RowSet = Self.SQLSelect("SELECT tag FROM tags_" + Category + " WHERE object_id = ?1;", UpdateBlueprintId)
		            While TagRows.AfterLastRow = False
		              CurrentTags.Add(TagRows.Column("tag").StringValue)
		              TagRows.MoveToNextRow
		            Wend
		            Var TagsToAdd() As String = CurrentTags.NewMembers(DesiredTags)
		            Var TagsToRemove() As String = DesiredTags.NewMembers(CurrentTags)
		            For Each Tag As String In TagsToAdd
		              Self.SQLExecute("INSERT OR IGNORE INTO tags_" + Category + " (object_id, tag) VALUES (?1, ?2);", UpdateBlueprintId, Tag)
		            Next Tag
		            For Each Tag As String In TagsToRemove
		              Self.SQLExecute("DELETE FROM tags_" + Category + " WHERE object_id = ?1 AND tag = ?2;", UpdateBlueprintId, Tag)
		            Next Tag
		          End If
		        Else
		          Var ColumnNames(), Placeholders() As String
		          Var Values() As Variant
		          Var NextPlaceholder As Integer = 1
		          For Each Entry As DictionaryEntry In Columns
		            ColumnNames.Add(Entry.Key.StringValue)
		            Placeholders.Add("?" + NextPlaceholder.ToString)
		            Values.Add(Entry.Value)
		            NextPlaceholder = NextPlaceholder + 1
		          Next
		          
		          Self.SQLExecute("INSERT INTO " + Category + " (" + ColumnNames.Join(", ") + ") VALUES (" + Placeholders.Join(", ") + ");", Values)
		          
		          Var Tags() As String = Blueprint.Tags
		          For Each Tag As String In Tags
		            Self.SQLExecute("INSERT OR IGNORE INTO tags_" + Category + " (object_id, tag) VALUES (?1, ?2);", Blueprint.BlueprintId, Tag)
		          Next Tag
		        End If
		        
		        Self.SQLExecute("UPDATE content_packs SET last_update = MAX(last_update, ?2) WHERE content_pack_id = ?1;", Blueprint.ContentPackId, Blueprint.LastUpdate)
		        
		        Self.CommitTransaction()
		        TransactionStarted = False
		        
		        If Self.mBlueprintCache.HasKey(Blueprint.BlueprintId) Then
		          Self.mBlueprintCache.Remove(Blueprint.BlueprintId)
		        End If
		        If Blueprint IsA Ark.Engram And Ark.Engram(Blueprint).HasUnlockDetails And Self.mBlueprintCache.HasKey("EngramEntry:" + Ark.Engram(Blueprint).EntryString) Then
		          Self.mBlueprintCache.Remove("EngramEntry:" + Ark.Engram(Blueprint).EntryString)
		        End If
		        
		        CountSuccess = CountSuccess + 1
		      Catch Err As RuntimeException
		        If TransactionStarted Then
		          Self.RollbackTransaction()
		        End If
		        If (ErrorDict Is Nil) = False Then
		          ErrorDict.Value(Blueprint.BlueprintId) = Err
		        Else
		          App.Log("Unable to save blueprint " + Blueprint.BlueprintId + ": Error #" + Err.ErrorNumber.ToString(Locale.Raw, "0") + " " + Err.Message.NthField(EndOfLine, 1))
		        End If
		        CountErrors = CountErrors + 1
		      End Try
		    Next Blueprint
		  End If
		  If CountErrors = 0 And CountSuccess > 0 Then
		    Self.CommitTransaction()
		    
		    If DoCloudExport Then
		      Self.ExportCloudFiles()
		    End If
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		    
		    Return True
		  Else
		    Self.RollbackTransaction()
		    
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteableInstance() As Ark.DataSource
		  Return Self.Pool.Get(True)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mBlueprintCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mConfigOptionCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mContainerLabelCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mContainerLabelCacheMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mIconCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOfficialPlayerLevelData As Ark.PlayerLevelData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mPool As Ark.DataSourcePool
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mSpawnLabelCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mSpawnLabelCacheMask As UInt64
	#tag EndProperty


	#tag Constant, Name = ConfigOptionSelectSQL, Type = String, Dynamic = False, Default = \"SELECT object_id\x2C label\x2C file\x2C header\x2C key\x2C value_type\x2C max_allowed\x2C description\x2C default_value\x2C nitrado_path\x2C nitrado_format\x2C nitrado_deploy_style\x2C native_editor_version\x2C ui_group\x2C custom_sort\x2C constraints\x2C gsa_placeholder\x2C content_pack_id\x2C uwp_changes FROM ini_options", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CreatureColorSelectSQL, Type = String, Dynamic = False, Default = \"SELECT colors.color_id\x2C colors.label\x2C colors.hex_value FROM colors", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CreatureColorSetSelectSQL, Type = String, Dynamic = False, Default = \"SELECT color_sets.color_set_id\x2C color_sets.label\x2C color_sets.class_string FROM color_sets", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CreatureSelectSQL, Type = String, Dynamic = False, Default = \"SELECT creatures.object_id\x2C creatures.path\x2C creatures.label\x2C creatures.alternate_label\x2C creatures.availability\x2C creatures.last_update\x2C creatures.tags\x2C creatures.incubation_time\x2C creatures.mature_time\x2C creatures.stats\x2C creatures.mating_interval_min\x2C creatures.mating_interval_max\x2C creatures.used_stats\x2C content_packs.content_pack_id\x2C content_packs.name AS content_pack_name FROM creatures INNER JOIN content_packs ON (creatures.content_pack_id \x3D content_packs.content_pack_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EngramSelectSQL, Type = String, Dynamic = False, Default = \"SELECT engrams.object_id\x2C engrams.path\x2C engrams.label\x2C engrams.alternate_label\x2C engrams.availability\x2C engrams.last_update\x2C engrams.tags\x2C engrams.entry_string\x2C engrams.required_level\x2C engrams.required_points\x2C engrams.stack_size\x2C engrams.item_id\x2C content_packs.content_pack_id\x2C content_packs.name AS content_pack_name FROM engrams INNER JOIN content_packs ON (engrams.content_pack_id \x3D content_packs.content_pack_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = GameEventSelectSQL, Type = String, Dynamic = False, Default = \"SELECT events.event_id\x2C events.label\x2C events.ark_code\x2C events.colors\x2C events.rates\x2C events.engrams FROM events", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LootContainerSelectSQL, Type = String, Dynamic = False, Default = \"SELECT loot_containers.object_id\x2C loot_containers.path\x2C loot_containers.class_string\x2C loot_containers.label\x2C loot_containers.alternate_label\x2C loot_containers.availability\x2C loot_containers.last_update\x2C loot_containers.tags\x2C loot_containers.multiplier_min\x2C loot_containers.multiplier_max\x2C loot_containers.uicolor\x2C loot_containers.requirements\x2C loot_containers.sort_order\x2C loot_containers.experimental\x2C loot_containers.notes\x2C loot_containers.icon\x2C loot_containers.min_item_sets\x2C loot_containers.max_item_sets\x2C loot_containers.prevent_duplicates\x2C loot_containers.contents\x2C content_packs.content_pack_id\x2C content_packs.name AS content_pack_name FROM loot_containers INNER JOIN content_packs ON (loot_containers.content_pack_id \x3D content_packs.content_pack_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_EngramsChanged, Type = String, Dynamic = False, Default = \"Engrams Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SpawnPointSelectSQL, Type = String, Dynamic = False, Default = \"SELECT spawn_points.object_id\x2C spawn_points.path\x2C spawn_points.label\x2C spawn_points.alternate_label\x2C spawn_points.availability\x2C spawn_points.last_update\x2C spawn_points.tags\x2C spawn_points.sets\x2C spawn_points.limits\x2C content_packs.content_pack_id\x2C content_packs.name AS content_pack_name FROM spawn_points INNER JOIN content_packs ON (spawn_points.content_pack_id \x3D content_packs.content_pack_id)", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
