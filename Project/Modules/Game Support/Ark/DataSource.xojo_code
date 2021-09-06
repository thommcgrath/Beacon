#tag Class
Protected Class DataSource
Inherits Beacon.DataSource
	#tag Event
		Sub BuildSchema()
		  Var ModsOnDelete As String
		  #if DebugBuild
		    ModsOnDelete = "RESTRICT"
		  #else
		    ModsOnDelete = "CASCADE"
		  #endif
		  
		  Self.SQLExecute("CREATE TABLE variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE mods (mod_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, name TEXT COLLATE NOCASE NOT NULL, console_safe INTEGER NOT NULL, default_enabled INTEGER NOT NULL, workshop_id INTEGER NOT NULL UNIQUE, is_user_mod BOOLEAN NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_icons (icon_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, icon_data BLOB NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_containers (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT COLLATE NOCASE NOT NULL, sort_order INTEGER NOT NULL, icon TEXT COLLATE NOCASE NOT NULL REFERENCES loot_icons(icon_id) ON UPDATE CASCADE ON DELETE RESTRICT, experimental BOOLEAN NOT NULL, notes TEXT NOT NULL, requirements TEXT NOT NULL DEFAULT '{}', tags TEXT COLLATE NOCASE NOT NULL DEFAULT '');")
		  Self.SQLExecute("CREATE TABLE engrams (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', entry_string TEXT COLLATE NOCASE, required_level INTEGER, required_points INTEGER, stack_size INTEGER, item_id INTEGER, recipe TEXT NOT NULL DEFAULT '[]');")
		  Self.SQLExecute("CREATE TABLE official_presets (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_presets (user_id TEXT COLLATE NOCASE NOT NULL, object_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE preset_modifiers (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, pattern TEXT NOT NULL, advanced_pattern TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE config_help (config_name TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, title TEXT COLLATE NOCASE NOT NULL, body TEXT COLLATE NOCASE NOT NULL, detail_url TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE creatures (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', incubation_time REAL, mature_time REAL, stats TEXT, used_stats INTEGER, mating_interval_min REAL, mating_interval_max REAL);")
		  Self.SQLExecute("CREATE TABLE spawn_points (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', sets TEXT NOT NULL DEFAULT '[]', limits TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE ini_options (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', native_editor_version INTEGER, file TEXT COLLATE NOCASE NOT NULL, header TEXT COLLATE NOCASE NOT NULL, key TEXT COLLATE NOCASE NOT NULL, value_type TEXT COLLATE NOCASE NOT NULL, max_allowed INTEGER, description TEXT NOT NULL, default_value TEXT, nitrado_path TEXT COLLATE NOCASE, nitrado_format TEXT COLLATE NOCASE, nitrado_deploy_style TEXT COLLATE NOCASE, ui_group TEXT COLLATE NOCASE, custom_sort TEXT COLLATE NOCASE, constraints TEXT);")
		  Self.SQLExecute("CREATE TABLE maps (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, ark_identifier TEXT COLLATE NOCASE NOT NULL UNIQUE, difficulty_scale REAL NOT NULL, official BOOLEAN NOT NULL, mask BIGINT NOT NULL UNIQUE, sort INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE events (event_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, ark_code TEXT NOT NULL, rates TEXT NOT NULL, colors TEXT NOT NULL, engrams TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE colors (color_id INTEGER NOT NULL PRIMARY KEY, color_uuid TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, hex_value TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE color_sets (color_set_id TEXT COLLATE NOCASE PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL);")
		  
		  Self.SQLExecute("CREATE VIRTUAL TABLE searchable_tags USING fts5(tags, object_id, source_table);")
		  
		  Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe, default_enabled, workshop_id, is_user_mod) VALUES (?1, ?2, ?3, ?4, ?5, ?6);", Beacon.UserModID, Beacon.UserModName, True, True, Beacon.UserModWorkshopID, True)
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
		    Indexes.Add(New Beacon.DataIndex(Category, True, "mod_id", "path"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "path"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "class_string"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "mod_id"))
		    Indexes.Add(New Beacon.DataIndex(Category, False, "label"))
		  Next
		  
		  Indexes.Add(New Beacon.DataIndex("maps", False, "mod_id"))
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
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByID(CreatureID As v4UUID) As Ark.Creature
		  Var CreatureUUID As String = CreatureID
		  If Self.mCreatureCache.HasKey(CreatureUUID) Then
		    Return Self.mCreatureCache.Value(CreatureUUID)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE object_id = ?1;", CreatureUUID)
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
		Function GetEngramByID(EngramID As v4UUID) As Ark.Engram
		  If Self.mEngramCache.HasKey(EngramID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE object_id = ?1;", EngramID.StringValue)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var Engrams() As Ark.Engram = Self.RowSetToEngram(Results)
		      Self.Cache(Engrams)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mEngramCache.Value(EngramID.StringValue)
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
		Function GetSpawnPointByID(SpawnPointID As v4UUID) As Ark.SpawnPoint
		  If Self.mSpawnPointCache.HasKey(SpawnPointID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE object_id = ?1;", SpawnPointID.StringValue)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      Self.Cache(SpawnPoints)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mSpawnPointCache.Value(SpawnPointID.StringValue)
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
		      #Pragma Warning "No loot container sql"
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
		      Next
		    Case Ark.CategoryCreatures
		      Var Creatures() As Ark.Creature = Self.RowSetToCreature(Results)
		      Self.Cache(Creatures)
		      For Each Creature As Ark.Creature In Creatures
		        Blueprints.Add(Creature)
		      Next
		    Case Ark.CategorySpawnPoints
		      Var SpawnPoints() As Ark.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      Self.Cache(SpawnPoints)
		      For Each SpawnPoint As Ark.SpawnPoint In SpawnPoints
		        Blueprints.Add(SpawnPoint)
		      Next
		    Case Ark.CategoryLootContainers
		      #Pragma Warning "No code for loot containers"
		    End Select
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Return Blueprints
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
		Private mCreatureCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As Ark.DataSource
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnPointCache As Dictionary
	#tag EndProperty


	#tag Constant, Name = CreatureSelectSQL, Type = String, Dynamic = False, Default = \"SELECT creatures.object_id\x2C creatures.path\x2C creatures.label\x2C creatures.alternate_label\x2C creatures.availability\x2C creatures.tags\x2C creatures.incubation_time\x2C creatures.mature_time\x2C creatures.stats\x2C creatures.mating_interval_min\x2C creatures.mating_interval_max\x2C creatures.used_stats\x2C mods.mod_id\x2C mods.name AS mod_name FROM creatures INNER JOIN mods ON (creatures.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EngramSelectSQL, Type = String, Dynamic = False, Default = \"SELECT engrams.object_id\x2C engrams.path\x2C engrams.label\x2C engrams.alternate_label\x2C engrams.availability\x2C engrams.tags\x2C engrams.entry_string\x2C engrams.required_level\x2C engrams.required_points\x2C engrams.stack_size\x2C engrams.item_id\x2C mods.mod_id\x2C mods.name AS mod_name FROM engrams INNER JOIN mods ON (engrams.mod_id \x3D mods.mod_id)", Scope = Private
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
