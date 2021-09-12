#tag Class
Protected Class DataSource
Inherits Beacon.DataSource
	#tag Event
		Sub BuildSchema()
		  Var ContentPackDeleteBehavior As String
		  #if DebugBuild
		    ContentPackDeleteBehavior = "RESTRICT"
		  #else
		    ContentPackDeleteBehavior = "CASCADE"
		  #endif
		  
		  Self.SQLExecute("CREATE TABLE variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE content_packs (content_pack_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, name TEXT COLLATE NOCASE NOT NULL, console_safe INTEGER NOT NULL, default_enabled INTEGER NOT NULL, workshop_id INTEGER UNIQUE, is_local BOOLEAN NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_icons (icon_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, icon_data BLOB NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_containers (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT COLLATE NOCASE NOT NULL, sort_order INTEGER NOT NULL, icon TEXT COLLATE NOCASE NOT NULL REFERENCES loot_icons(icon_id) ON UPDATE CASCADE ON DELETE RESTRICT, experimental BOOLEAN NOT NULL, notes TEXT NOT NULL, requirements TEXT NOT NULL DEFAULT '{}', tags TEXT COLLATE NOCASE NOT NULL DEFAULT '');")
		  Self.SQLExecute("CREATE TABLE engrams (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', entry_string TEXT COLLATE NOCASE, required_level INTEGER, required_points INTEGER, stack_size INTEGER, item_id INTEGER, recipe TEXT NOT NULL DEFAULT '[]');")
		  Self.SQLExecute("CREATE TABLE official_loot_templates (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_loot_templates (user_id TEXT COLLATE NOCASE NOT NULL, object_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_container_selectors (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, language TEXT COLLATE NOCASE NOT NULL, code TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE config_help (config_name TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, title TEXT COLLATE NOCASE NOT NULL, body TEXT COLLATE NOCASE NOT NULL, detail_url TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE creatures (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', incubation_time REAL, mature_time REAL, stats TEXT, used_stats INTEGER, mating_interval_min REAL, mating_interval_max REAL);")
		  Self.SQLExecute("CREATE TABLE spawn_points (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', sets TEXT NOT NULL DEFAULT '[]', limits TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE ini_options (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', native_editor_version INTEGER, file TEXT COLLATE NOCASE NOT NULL, header TEXT COLLATE NOCASE NOT NULL, key TEXT COLLATE NOCASE NOT NULL, value_type TEXT COLLATE NOCASE NOT NULL, max_allowed INTEGER, description TEXT NOT NULL, default_value TEXT, nitrado_path TEXT COLLATE NOCASE, nitrado_format TEXT COLLATE NOCASE, nitrado_deploy_style TEXT COLLATE NOCASE, ui_group TEXT COLLATE NOCASE, custom_sort TEXT COLLATE NOCASE, constraints TEXT);")
		  Self.SQLExecute("CREATE TABLE maps (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE " + ContentPackDeleteBehavior + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, ark_identifier TEXT COLLATE NOCASE NOT NULL UNIQUE, difficulty_scale REAL NOT NULL, official BOOLEAN NOT NULL, mask BIGINT NOT NULL UNIQUE, sort INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE events (event_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, ark_code TEXT NOT NULL, rates TEXT NOT NULL, colors TEXT NOT NULL, engrams TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE colors (color_id INTEGER NOT NULL PRIMARY KEY, color_uuid TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, hex_value TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE color_sets (color_set_id TEXT COLLATE NOCASE PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL);")
		  
		  Self.SQLExecute("CREATE VIRTUAL TABLE searchable_tags USING fts5(tags, object_id, source_table);")
		  
		  Self.SQLExecute("INSERT INTO content_packs (content_pack_id, name, console_safe, default_enabled, is_local) VALUES (?1, ?2, ?3, ?4, ?5);", Ark.UserContentPackUUID, Ark.UserContentPackName, True, True, True)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Close()
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
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
		  Next
		  
		  Indexes.Add(New Beacon.DataIndex("maps", False, "content_pack_id"))
		  Indexes.Add(New Beacon.DataIndex("loot_containers", False, "sort_order"))
		  
		  Indexes.Add(New Beacon.DataIndex("custom_presets", True, "user_id", "object_id"))
		  Indexes.Add(New Beacon.DataIndex("engrams", False, "entry_string"))
		  Indexes.Add(New Beacon.DataIndex("ini_options", True, "file", "header", "key"))
		  Indexes.Add(New Beacon.DataIndex("events", True, "ark_code"))
		  Indexes.Add(New Beacon.DataIndex("events", False, "label"))
		  Indexes.Add(New Beacon.DataIndex("colors", True, "color_uuid"))
		  Indexes.Add(New Beacon.DataIndex("colors", False, "label"))
		  Indexes.Add(New Beacon.DataIndex("color_sets", False, "label"))
		  Indexes.Add(New Beacon.DataIndex("color_sets", True, "class_string"))
		  
		  Return Indexes
		End Function
	#tag EndEvent

	#tag Event
		Function GetIdentifier() As String
		  Return Ark.Identifier
		End Function
	#tag EndEvent

	#tag Event
		Function GetSchemaVersion() As Integer
		  Return 100
		End Function
	#tag EndEvent

	#tag Event
		Sub IndexesBuilt()
		  Self.SQLExecute("DROP VIEW IF EXISTS blueprints;")
		  Self.SQLExecute("CREATE VIEW blueprints AS SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Ark.CategoryEngrams + "' AS category FROM engrams UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Ark.CategoryCreatures + "' AS category FROM creatures UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Ark.CategorySpawnPoints + "' AS category FROM spawn_points UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Ark.CategoryLootContainers + "' AS category FROM loot_containers")
		  Var DeleteStatements() As String
		  Var Categories() As String = Ark.Categories
		  For Each Category As String In Categories
		    DeleteStatements.Add("DELETE FROM " + Category + " WHERE object_id = OLD.object_id;")
		  Next
		  Self.SQLExecute("CREATE TRIGGER blueprints_delete_trigger INSTEAD OF DELETE ON blueprints FOR EACH ROW BEGIN " + String.FromArray(DeleteStatements, " ") + " DELETE FROM searchable_tags WHERE object_id = OLD.object_id; END;")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Cache(Creatures() As Ark.Creature)
		  For Each Creature As Ark.Creature In Creatures
		    Self.mCreatureCache.Value(Creature.ObjectID) = Creature
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Creature As Ark.Creature)
		  Var Arr(0) As Ark.Creature
		  Arr(0) = Creature
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Engrams() As Ark.Engram)
		  For Each Engram As Ark.Engram In Engrams
		    Self.mEngramCache.Value(Engram.ObjectID) = Engram
		    
		    If Engram.HasUnlockDetails Then
		      Var SimilarEngrams() As Ark.Engram
		      If Self.mEngramCache.HasKey(Engram.EntryString) Then
		        SimilarEngrams = Self.mEngramCache.Value(Engram.EntryString)
		      End If
		      
		      Var Found As Boolean
		      For Idx As Integer = 0 To SimilarEngrams.LastIndex
		        If SimilarEngrams(Idx).ObjectID = Engram.ObjectID Then
		          SimilarEngrams(Idx) = Engram
		          Found = True
		          Exit For Idx
		        End If
		      Next
		      If Not Found Then
		        SimilarEngrams.Add(Engram)
		      End If
		      Self.mEngramCache.Value(Engram.EntryString) = SimilarEngrams
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Engram As Ark.Engram)
		  Var Arr(0) As Ark.Engram
		  Arr(0) = Engram
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(LootContainers() As Ark.LootContainer)
		  For Each LootContainer As Ark.LootContainer In LootContainers
		    Self.mLootContainerCache.Value(LootContainer.ObjectID) = LootContainer
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(LootContainer As Ark.LootContainer)
		  Var Arr(0) As Ark.LootContainer
		  Arr(0) = LootContainer
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(SpawnPoints() As Ark.SpawnPoint)
		  For Each SpawnPoint As Ark.SpawnPoint In SpawnPoints
		    Self.mSpawnPointCache.Value(SpawnPoint.ObjectID) = SpawnPoint
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(SpawnPoint As Ark.SpawnPoint)
		  Var Arr(0) As Ark.SpawnPoint
		  Arr(0) = SpawnPoint
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramCache = New Dictionary
		  Self.mCreatureCache = New Dictionary
		  Self.mSpawnPointCache = New Dictionary
		  Self.mLootContainerCache = New Dictionary
		  Self.mConfigKeyCache = New Dictionary
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigKey(KeyUUID As String) As Ark.ConfigKey
		  If Self.mConfigKeyCache.HasKey(KeyUUID) Then
		    Return Self.mConfigKeyCache.Value(KeyUUID)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect(Self.ConfigKeySelectSQL + " WHERE object_id = ?1;", KeyUUID)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Results() As Ark.ConfigKey = Self.RowSetToConfigKeys(Rows)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigKey(File As String, Header As String, Key As String) As Ark.ConfigKey
		  Var Results() As Ark.ConfigKey = Self.SearchForConfigKey(File, Header, Key, False)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks() As Ark.ContentPack()
		  Var Packs() As Ark.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT content_pack_id, name, console_safe, default_enabled, workshop_id, is_local FROM content_packs ORDER BY name;")
		  While Not Results.AfterLastRow
		    Packs.Add(New Ark.ContentPack(Results.Column("content_pack_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("is_local").BooleanValue, NullableDouble.FromVariant(Results.Column("workshop_id").Value)))
		    Results.MoveToNextRow
		  Wend
		  Return Packs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPackWithUUID(ContentPackUUID As String) As Ark.ContentPack
		  If v4UUID.IsValid(ContentPackUUID) = False Then
		    Return Nil
		  End If
		  
		  Var Results As RowSet = Self.SQLSelect("SELECT content_pack_id, name, console_safe, default_enabled, workshop_id, is_local FROM content_packs WHERE content_pack_id = ?1;", ContentPackUUID)
		  If Results.RowCount = 1 Then
		    Return New Ark.ContentPack(Results.Column("content_pack_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("is_local").BooleanValue, NullableDouble.FromVariant(Results.Column("workshop_id").Value))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPackWithWorkshopID(WorkshopID As Integer) As Ark.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT content_pack_id, name, console_safe, default_enabled, workshop_id, is_local FROM content_packs WHERE workshop_id IS NOT NULL AND workshop_id = ?1;", WorkshopID)
		  If Results.RowCount = 1 Then
		    Return New Ark.ContentPack(Results.Column("content_pack_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("is_local").BooleanValue, NullableDouble.FromVariant(Results.Column("workshop_id").Value))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByID(CreatureID As String) As Ark.Creature
		  If Self.mCreatureCache.HasKey(CreatureID) Then
		    Return Self.mCreatureCache.Value(CreatureID)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE object_id = ?1;", CreatureID)
		    If Results.RowCount <> 1 Then
		      Return Nil
		    End If
		    
		    Var Creatures() As Ark.Creature = Self.RowSetToCreature(Results)
		    Self.Cache(Creatures)
		    Return Creatures(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByClass(ClassString As String, Mods As Beacon.StringList) As Ark.Creature()
		  Var SQL As String = Self.CreatureSelectSQL + " WHERE creatures.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND creatures.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var Creatures() As Ark.Creature = Self.RowSetToCreature(Rows)
		  Self.Cache(Creatures)
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByPath(Path As String, Mods As Beacon.StringList) As Ark.Creature()
		  Var SQL As String = Self.CreatureSelectSQL + " WHERE creatures.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND creatures.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var Creatures() As Ark.Creature = Self.RowSetToCreature(Rows)
		  Self.Cache(Creatures)
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByID(EngramID As String) As Ark.Engram
		  If Self.mEngramCache.HasKey(EngramID) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE object_id = ?1;", EngramID)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var Engrams() As Ark.Engram = Self.RowSetToEngram(Results)
		      Self.Cache(Engrams)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mEngramCache.Value(EngramID)
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
		Function GetEngramsByClass(ClassString As String, Mods As Beacon.StringList) As Ark.Engram()
		  Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND engrams.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var Engrams() As Ark.Engram = Self.RowSetToEngram(Rows)
		  Self.Cache(Engrams)
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByEntryString(EntryString As String, Mods As Beacon.StringList) As Ark.Engram()
		  If EntryString.Length < 2 Or EntryString.Right(2) <> "_C" Then
		    EntryString = EntryString + "_C"
		  End If
		  
		  Var Engrams() As Ark.Engram
		  If Self.mEngramCache.HasKey(EntryString) Then
		    Engrams = Self.mEngramCache.Value(EntryString)
		  Else
		    Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.entry_string = ?1;"
		    If (Mods Is Nil) = False Then
		      SQL = SQL.Left(SQL.Length - 1) + " AND engrams.mod_id IN (" + Mods.SQLValue + ");"
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
		Function GetEngramsByPath(Path As String, Mods As Beacon.StringList) As Ark.Engram()
		  Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND engrams.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var Engrams() As Ark.Engram = Self.RowSetToEngram(Rows)
		  Self.Cache(Engrams)
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainerByID(LootContainerID As String) As Ark.LootContainer
		  If Self.mLootContainerCache.HasKey(LootContainerID) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.LootContainerSelectColumns + " WHERE object_id = ?1;", LootContainerID)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var LootContainers() As Ark.LootContainer = Self.RowSetToLootContainer(Results)
		      Self.Cache(LootContainers)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mLootContainerCache.Value(LootContainerID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByClass(ClassString As String, Mods As Beacon.StringList) As Ark.LootContainer()
		  Var SQL As String = Self.LootContainerSelectColumns + " WHERE loot_containers.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND loot_containers.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var LootContainers() As Ark.LootContainer = Self.RowSetToLootContainer(Rows)
		  Self.Cache(LootContainers)
		  Return LootContainers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByPath(Path As String, Mods As Beacon.StringList) As Ark.LootContainer()
		  Var SQL As String = Self.LootContainerSelectColumns + " WHERE loot_containers.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND loot_containers.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var LootContainers() As Ark.LootContainer = Self.RowSetToLootContainer(Rows)
		  Self.Cache(LootContainers)
		  Return LootContainers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootTemplateSelector(SelectorUUID As String) As Ark.LootContainerSelector
		  Var Results As RowSet = Self.SQLSelect("SELECT object_id, label, language, code FROM loot_container_selectors WHERE object_id = ?1;", SelectorUUID)
		  If Results.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Return New Ark.LootContainerSelector(Results.Column("object_id").StringValue, Results.Column("label").StringValue, Results.Column("language").StringValue, Results.Column("code").StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootTemplateSelectors(IncludeOfficial As Boolean = True, IncludeCustom As Boolean = True) As Ark.LootContainerSelector()
		  Var Selectors() As Ark.LootContainerSelector
		  
		  Var SQL As String = "SELECT object_id, label, language, code FROM loot_container_selectors"
		  If IncludeOfficial = False And IncludeCustom = True Then
		    SQL = SQL + " WHERE mod_id = '" + Beacon.UserModID + "'"
		  ElseIf IncludeOfficial = True And IncludeCustom = False Then
		    SQL = SQL + " WHERE mod_id != '" + Beacon.UserModID + "'"
		  ElseIf IncludeOfficial = False And IncludeCustom = False Then
		    Return Selectors
		  End If
		  SQL = SQL + " ORDER BY label;"
		  
		  Var Results As RowSet = Self.SQLSelect(SQL)
		  While Not Results.AfterLastRow
		    Selectors.Add(New Ark.LootContainerSelector(Results.Column("object_id").StringValue, Results.Column("label").StringValue, Results.Column("language").StringValue, Results.Column("code").StringValue))
		    Results.MoveToNextRow
		  Wend
		  Return Selectors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMap(Named As String) As Ark.Map
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps WHERE label = ?1 OR ark_identifier = ?1 LIMIT 1;", Named)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Return New Ark.Map(Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("mod_id").StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps() As Ark.Map()
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps ORDER BY official DESC, sort;")
		  Var Maps() As Ark.Map
		  While Rows.AfterLastRow = False
		    Maps.Add(New Ark.Map(Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("mod_id").StringValue))
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
		    Maps.Add(New Ark.Map(Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("mod_id").StringValue))
		    Rows.MoveToNextRow
		  Wend
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByID(SpawnPointID As String) As Ark.SpawnPoint
		  If Self.mSpawnPointCache.HasKey(SpawnPointID) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE object_id = ?1;", SpawnPointID)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      Self.Cache(SpawnPoints)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mSpawnPointCache.Value(SpawnPointID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByClass(ClassString As String, Mods As Beacon.StringList) As Ark.SpawnPoint()
		  Var SQL As String = Self.SpawnPointSelectSQL + " WHERE spawn_points.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND spawn_points.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Rows)
		  Self.Cache(SpawnPoints)
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByPath(Path As String, Mods As Beacon.StringList) As Ark.SpawnPoint()
		  Var SQL As String = Self.SpawnPointSelectSQL + " WHERE spawn_points.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND spawn_points.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Rows)
		  Self.Cache(SpawnPoints)
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsForCreature(Creature As Ark.Creature, Mods As Beacon.StringList, Tags As String) As Ark.SpawnPoint()
		  Var Clauses() As String
		  Var Values() As Variant
		  Clauses.Add("spawn_points.sets LIKE :placeholder:")
		  Values.Add("%" + Creature.ObjectID + "%")
		  
		  Var Blueprints() As Ark.Blueprint = Self.SearchForBlueprints(Ark.CategorySpawnPoints, "", Mods, Tags, Clauses, Values)
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
		Function LoadIngredientsForEngram(Engram As Ark.Engram) As Ark.RecipeIngredient()
		  Var Ingredients() As Ark.RecipeIngredient
		  If (Engram Is Nil) = False Then
		    Var Results As RowSet = Self.SQLSelect("SELECT recipe FROM engrams WHERE object_id = ?1;", Engram.ObjectID)
		    If Results.RowCount = 1 Then
		      Ingredients = Ark.RecipeIngredient.FromVariant(Results.Column("recipe").Value, Nil)
		    End If
		  End If
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToConfigKeys(Results As RowSet) As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Try
		    While Results.AfterLastRow = False
		      Var ObjectID As String = Results.Column("object_id").StringValue
		      If Self.mConfigKeyCache.HasKey(ObjectID) Then
		        Results.MoveToNextRow
		        Keys.Add(Self.mConfigKeyCache.Value(ObjectID))
		        Continue
		      End If
		      
		      Var Label As String = Results.Column("label").StringValue
		      Var ConfigFile As String = Results.Column("file").StringValue
		      Var ConfigHeader As String = Results.Column("header").StringValue
		      Var ConfigKey As String = Results.Column("key").StringValue
		      Var ValueType As Ark.ConfigKey.ValueTypes
		      Select Case Results.Column("value_type").StringValue
		      Case "Numeric"
		        ValueType = Ark.ConfigKey.ValueTypes.TypeNumeric
		      Case "Array"
		        ValueType = Ark.ConfigKey.ValueTypes.TypeArray
		      Case "Structure"
		        ValueType = Ark.ConfigKey.ValueTypes.TypeStructure
		      Case "Boolean"
		        ValueType = Ark.ConfigKey.ValueTypes.TypeBoolean
		      Case "Text"
		        ValueType = Ark.ConfigKey.ValueTypes.TypeText
		      End Select
		      Var MaxAllowed As NullableDouble
		      If IsNull(Results.Column("max_allowed").Value) = False Then
		        MaxAllowed = Results.Column("max_allowed").IntegerValue
		      End If
		      Var Description As String = Results.Column("description").StringValue
		      Var DefaultValue As Variant = Results.Column("default_value").Value
		      Var NitradoPath As NullableString
		      Var NitradoFormat As Ark.ConfigKey.NitradoFormats = Ark.ConfigKey.NitradoFormats.Unsupported
		      Var NitradoDeployStyle As Ark.ConfigKey.NitradoDeployStyles = Ark.ConfigKey.NitradoDeployStyles.Unsupported
		      If IsNull(Results.Column("nitrado_format").Value) = False Then
		        NitradoPath = Results.Column("nitrado_path").StringValue
		        Select Case Results.Column("nitrado_format").StringValue
		        Case "Line"
		          NitradoFormat = Ark.ConfigKey.NitradoFormats.Line
		        Case "Value"
		          NitradoFormat = Ark.ConfigKey.NitradoFormats.Value
		        End Select
		        Select Case Results.Column("nitrado_deploy_style").StringValue
		        Case "Guided"
		          NitradoDeployStyle = Ark.ConfigKey.NitradoDeployStyles.Guided
		        Case "Expert"
		          NitradoDeployStyle = Ark.ConfigKey.NitradoDeployStyles.Expert
		        Case "Both"
		          NitradoDeployStyle = Ark.ConfigKey.NitradoDeployStyles.Both
		        End Select
		      End If
		      Var NativeEditorVersion As NullableDouble = NullableDouble.FromVariant(Results.Column("native_editor_version").Value)
		      Var UIGroup As NullableString = NullableString.FromVariant(Results.Column("ui_group").Value)
		      Var CustomSort As NullableString = NullableString.FromVariant(Results.Column("custom_sort").Value)
		      Var ModID As String = Results.Column("mod_id").StringValue
		      
		      Var Constraints As Dictionary
		      If IsNull(Results.Column("constraints").Value) = False Then
		        Try
		          Var Parsed As Variant = Beacon.ParseJSON(Results.Column("constraints").StringValue)
		          If IsNull(Parsed) = False And Parsed IsA Dictionary Then
		            Constraints = Parsed
		          End If
		        Catch JSONErr As JSONException
		        End Try
		      End If
		      
		      Var Key As New Ark.ConfigKey(ObjectID, Label, ConfigFile, ConfigHeader, ConfigKey, ValueType, MaxAllowed, Description, DefaultValue, NitradoPath, NitradoFormat, NitradoDeployStyle, NativeEditorVersion, UIGroup, CustomSort, Constraints, ModID)
		      Self.mConfigKeyCache.Value(ObjectID) = Key
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
		Private Function RowSetToCreature(Results As RowSet) As Ark.Creature()
		  Var Creatures() As Ark.Creature
		  While Not Results.AfterLastRow
		    Var CreatureID As String = Results.Column("object_id").StringValue
		    If Self.mCreatureCache.HasKey(CreatureID) = False Then
		      Var Creature As New Ark.MutableCreature(Results.Column("path").StringValue, CreatureID)
		      Creature.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Creature.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Creature.Availability = Results.Column("availability").Value
		      Creature.TagString = Results.Column("tags").StringValue
		      Creature.ModID = Results.Column("mod_id").StringValue
		      Creature.ModName = Results.Column("mod_name").StringValue
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
		      
		      Self.mCreatureCache.Value(CreatureID) = Creature.ImmutableVersion
		    End If
		    
		    Creatures.Add(Self.mCreatureCache.Value(CreatureID))
		    Results.MoveToNextRow
		  Wend
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToEngram(Results As RowSet) As Ark.Engram()
		  Var Engrams() As Ark.Engram
		  While Not Results.AfterLastRow
		    Var EngramID As String = Results.Column("object_id").StringValue
		    If Self.mEngramCache.HasKey(EngramID) = False Then
		      Var Engram As New Ark.MutableEngram(Results.Column("path").StringValue, EngramID)
		      Engram.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Engram.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Engram.Availability = Results.Column("availability").Value
		      Engram.TagString = Results.Column("tags").StringValue
		      Engram.ModID = Results.Column("mod_id").StringValue
		      Engram.ModName = Results.Column("mod_name").StringValue
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
		      Self.mEngramCache.Value(EngramID) = Engram.ImmutableVersion
		    End If
		    
		    Engrams.Add(Self.mEngramCache.Value(EngramID))
		    Results.MoveToNextRow
		  Wend
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToLootContainer(Results As RowSet) As Ark.LootContainer()
		  Var Sources() As Ark.LootContainer
		  While Not Results.AfterLastRow
		    Var HexColor As String = Results.Column("uicolor").StringValue
		    Var RedHex, GreenHex, BlueHex, AlphaHex As String = "00"
		    If HexColor.Length = 3 Then
		      RedHex = HexColor.Middle(0, 1) + HexColor.Middle(0, 1)
		      GreenHex = HexColor.Middle(1, 1) + HexColor.Middle(1, 1)
		      BlueHex = HexColor.Middle(2, 1) + HexColor.Middle(2, 1)
		    ElseIf HexColor.Length = 4 Then
		      RedHex = HexColor.Middle(0, 1) + HexColor.Middle(0, 1)
		      GreenHex = HexColor.Middle(1, 1) + HexColor.Middle(1, 1)
		      BlueHex = HexColor.Middle(2, 1) + HexColor.Middle(2, 1)
		      AlphaHex = HexColor.Middle(3, 1) + HexColor.Middle(3, 1)
		    ElseIf HexColor.Length = 6 Then
		      RedHex = HexColor.Middle(0, 2)
		      GreenHex = HexColor.Middle(2, 2)
		      BlueHex = HexColor.Middle(4, 2)
		    ElseIf HexColor.Length = 8 Then
		      RedHex = HexColor.Middle(0, 2)
		      GreenHex = HexColor.Middle(2, 2)
		      BlueHex = HexColor.Middle(4, 2)
		      AlphaHex = HexColor.Middle(6, 2)
		    End If
		    
		    Var Requirements As Dictionary
		    #Pragma BreakOnExceptions Off
		    Try
		      Requirements = Beacon.ParseJSON(Results.Column("requirements").StringValue)
		    Catch Err As RuntimeException
		      
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    Var Source As New Ark.MutableLootContainer
		    Source.Label = Results.Column("label").StringValue
		    Source.Path = Results.Column("path").StringValue
		    Source.Availability = Results.Column("availability").Value
		    Source.Multipliers = New Beacon.Range(Results.Column("multiplier_min").DoubleValue, Results.Column("multiplier_max").DoubleValue)
		    Source.UIColor = Color.RGB(Integer.FromHex(RedHex), Integer.FromHex(GreenHex), Integer.FromHex(BlueHex), Integer.FromHex(AlphaHex))
		    Source.SortValue = Results.Column("sort_order").IntegerValue
		    Source.Experimental = Results.Column("experimental").BooleanValue
		    Source.Notes = Results.Column("notes").StringValue
		    Source.ModID = Results.Column("mod_id").StringValue
		    Source.TagString = Results.Column("tags").StringValue
		    
		    If Requirements.HasKey("min_item_sets") And IsNull(Requirements.Value("min_item_sets")) = False Then
		      Source.RequiredItemSetCount = Requirements.Value("min_item_sets")
		    End If
		    
		    Source.Modified = False
		    Sources.Add(Source.ImmutableVersion)
		    Results.MoveToNextRow
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToSpawnPoint(Results As RowSet) As Ark.SpawnPoint()
		  Var SpawnPoints() As Ark.SpawnPoint
		  While Not Results.AfterLastRow
		    Var PointID As String = Results.Column("object_id").StringValue
		    If Self.mSpawnPointCache.HasKey(PointID) = False Then
		      Var Point As New Ark.MutableSpawnPoint(Results.Column("path").StringValue, PointID)
		      Point.Label = Results.Column("label").StringValue
		      If IsNull(Results.Column("alternate_label").Value) = False Then
		        Point.AlternateLabel = Results.Column("alternate_label").StringValue
		      End If
		      Point.Availability = Results.Column("availability").Value
		      Point.TagString = Results.Column("tags").StringValue
		      Point.ModID = Results.Column("mod_id").StringValue
		      Point.ModName = Results.Column("mod_name").StringValue
		      Point.Modified = False
		      Self.mSpawnPointCache.Value(PointID) = Point.ImmutableVersion
		    End If
		    
		    SpawnPoints.Add(Self.mSpawnPointCache.Value(PointID))
		    Results.MoveToNextRow
		  Wend
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String) As Ark.Blueprint()
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  Return Self.SearchForBlueprints(Category, SearchText, Mods, Tags, ExtraClauses, ExtraValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String, ExtraClauses() As String, ExtraValues() As Variant) As Ark.Blueprint()
		  Var Blueprints() As Ark.Blueprint
		  
		  Try
		    Var NextPlaceholder As Integer = 1
		    Var Clauses() As String
		    Var Values As New Dictionary
		    If SearchText <> "" Then
		      Clauses.Add("label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\' OR (alternate_label IS NOT NULL AND alternate_label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\') OR class_string LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " ESCAPE '\'")
		      Values.Value(NextPlaceholder) = "%" + Self.EscapeLikeValue(SearchText) + "%"
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
		      SQL = Self.LootContainerSelectColumns
		    Else
		      Return Blueprints
		    End Select
		    
		    If Mods <> Nil And Mods.LastRowIndex > -1 Then
		      Var Placeholders() As String
		      For Each ModID As String In Mods
		        Placeholders.Add("?" + NextPlaceholder.ToString)
		        Values.Value(NextPlaceholder) = ModID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.Add("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    If Tags <> "" Then
		      SQL = SQL.Replace(Category + " INNER JOIN mods", Category + " INNER JOIN searchable_tags ON (searchable_tags.object_id = " + Category + ".object_id AND searchable_tags.source_table = '" + Category + "') INNER JOIN mods")
		      Clauses.Add("searchable_tags.tags MATCH ?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		      Values.Value(NextPlaceholder) = Tags
		      NextPlaceholder = NextPlaceholder + 1
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
		Function SearchForConfigKey(File As String, Header As String, Key As String, SortHuman As Boolean) As Ark.ConfigKey()
		  Var Clauses() As String
		  Var Values As New Dictionary
		  Var Idx As Integer = 1
		  
		  If File = Beacon.ConfigFileGameUserSettings Then
		    If Header.IsEmpty = False Then
		      Clauses.Add("((file = 'GameUserSettings.ini' AND header = ?" + Idx.ToString + ") OR file IN ('CommandLineFlag', 'CommandLineOption'))")
		      Values.Value(Idx) = Header
		      Idx = Idx + 1
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
		  
		  Var SQL As String = Self.ConfigKeySelectSQL
		  If Clauses.Count > 0 Then
		    SQL = SQL + " WHERE " + Clauses.Join(" AND ")
		  End If
		  If SortHuman Then
		    SQL = SQL + " ORDER BY COALESCE(custom_sort, label)"
		  Else
		    SQL = SQL + " ORDER BY key"
		  End If
		  
		  Var Results() As Ark.ConfigKey
		  Try
		    Results = Self.RowSetToConfigKeys(Self.SQLSelect(SQL, Values))
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		  End Try
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance(Create As Boolean = True) As Ark.DataSource
		  If mInstance Is Nil And Create = True Then
		    mInstance = New Ark.DataSource
		  End If
		  Return mInstance
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigKeyCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatureCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As Ark.DataSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLootContainerCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnPointCache As Dictionary
	#tag EndProperty


	#tag Constant, Name = ConfigKeySelectSQL, Type = String, Dynamic = False, Default = \"SELECT object_id\x2C label\x2C file\x2C header\x2C key\x2C value_type\x2C max_allowed\x2C description\x2C default_value\x2C nitrado_path\x2C nitrado_format\x2C nitrado_deploy_style\x2C native_editor_version\x2C ui_group\x2C custom_sort\x2C constraints\x2C mod_id FROM ini_options", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CreatureSelectSQL, Type = String, Dynamic = False, Default = \"SELECT creatures.object_id\x2C creatures.path\x2C creatures.label\x2C creatures.alternate_label\x2C creatures.availability\x2C creatures.tags\x2C creatures.incubation_time\x2C creatures.mature_time\x2C creatures.stats\x2C creatures.mating_interval_min\x2C creatures.mating_interval_max\x2C creatures.used_stats\x2C mods.mod_id\x2C mods.name AS mod_name FROM creatures INNER JOIN mods ON (creatures.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EngramSelectSQL, Type = String, Dynamic = False, Default = \"SELECT engrams.object_id\x2C engrams.path\x2C engrams.label\x2C engrams.alternate_label\x2C engrams.availability\x2C engrams.tags\x2C engrams.entry_string\x2C engrams.required_level\x2C engrams.required_points\x2C engrams.stack_size\x2C engrams.item_id\x2C mods.mod_id\x2C mods.name AS mod_name FROM engrams INNER JOIN mods ON (engrams.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LootContainerSelectColumns, Type = String, Dynamic = False, Default = \"path\x2C class_string\x2C label\x2C alternate_label\x2C availability\x2C multiplier_min\x2C multiplier_max\x2C uicolor\x2C sort_order\x2C experimental\x2C notes\x2C requirements\x2C loot_sources.mod_id\x2C loot_sources.tags", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SpawnPointSelectSQL, Type = String, Dynamic = False, Default = \"SELECT spawn_points.object_id\x2C spawn_points.path\x2C spawn_points.label\x2C spawn_points.alternate_label\x2C spawn_points.availability\x2C spawn_points.tags\x2C mods.mod_id\x2C mods.name AS mod_name FROM spawn_points INNER JOIN mods ON (spawn_points.mod_id \x3D mods.mod_id)", Scope = Private
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
End Class
#tag EndClass
