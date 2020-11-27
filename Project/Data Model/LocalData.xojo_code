#tag Class
Protected Class LocalData
Implements Beacon.DataSource,NotificationKit.Receiver
	#tag Method, Flags = &h21
		Private Function AddBlueprintToDatabase(Category As String, BlueprintData As Dictionary, ExtraValues As Dictionary = Nil) As Boolean
		  Try
		    Var ObjectID As v4UUID = BlueprintData.Value("id").StringValue
		    Var Label As String = BlueprintData.Value("label")
		    Var AlternateLabel As Variant = BlueprintData.Lookup("alternate_label", Nil)
		    Var ModID As v4UUID = Dictionary(BlueprintData.Value("mod")).Value("id").StringValue
		    Var Availability As Integer = BlueprintData.Value("availability").IntegerValue
		    Var Path As String = BlueprintData.Value("path").StringValue
		    Var ClassString As String = BlueprintData.Value("class_string").StringValue
		    Var TagString, TagStringForSearching As String
		    Try
		      Var Tags() As String
		      Var Temp() As Variant = BlueprintData.Value("tags")
		      For Each Tag As String In Temp
		        Tags.Add(Tag)
		      Next
		      TagString = Tags.Join(",")
		      Tags.AddAt(0, "object")
		      TagStringForSearching = Tags.Join(",")
		    Catch Err As RuntimeException
		      
		    End Try
		    
		    // Set the extra values first so our values take priority without
		    // using HasKey, which would cost performance
		    Var Columns As New Dictionary
		    If ExtraValues <> Nil Then
		      For Each Entry As DictionaryEntry In ExtraValues
		        Columns.Value(Entry.Key) = Entry.Value
		      Next
		    End If
		    Columns.Value("object_id") = ObjectID.StringValue
		    Columns.Value("mod_id") = ModID.StringValue
		    Columns.Value("label") = Label
		    Columns.Value("alternate_label") = AlternateLabel
		    Columns.Value("availability") = Availability
		    Columns.Value("path") = Path
		    Columns.Value("class_string") = ClassString
		    Columns.Value("tags") = TagString
		    
		    Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM " + Category + " WHERE object_id = ?1 OR path = ?2;", ObjectID.StringValue, Path)
		    If Results.RowCount = 1 And ObjectID = Results.Column("object_id").StringValue Then
		      Var Assignments() As String
		      Var Values() As Variant
		      Var NextPlaceholder As Integer = 1
		      Var WhereClause As String
		      For Each Entry As DictionaryEntry In Columns
		        If Entry.Key = "object_id" Then
		          WhereClause = "object_id = ?" + NextPlaceholder.ToString
		        Else
		          Assignments.Add(Entry.Key.StringValue + " = ?" + NextPlaceholder.ToString)
		        End If
		        Values.Add(Entry.Value)
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      
		      Self.SQLExecute("UPDATE " + Category + " SET " + Assignments.Join(", ") + " WHERE " + WhereClause + ";", Values)
		      Self.SQLExecute("UPDATE searchable_tags SET tags = ?2 WHERE object_id = ?1 AND source_table = ?3;", ObjectID.StringValue, TagStringForSearching, Category)
		    Else
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("DELETE FROM " + Category + " WHERE object_id = ?1;", Results.Column("object_id").StringValue)
		        Self.SQLExecute("DELETE FROM searchable_tags WHERE object_id = ?1 AND source_table = ?3;", Results.Column("object_id").StringValue, Category)
		      End If
		      
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
		      Self.SQLExecute("INSERT INTO searchable_tags (object_id, tags, source_table) VALUES (?1, ?2, ?3);", ObjectID.StringValue, TagStringForSearching, Category)
		    End If
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddPresetModifier(Modifier As Beacon.PresetModifier)
		  Self.BeginTransaction()
		  Var Results As RowSet = Self.SQLSelect("SELECT mod_id FROM preset_modifiers WHERE object_id = ?1;", Modifier.ModifierID)
		  If Results.RowCount = 1 Then
		    If Results.Column("mod_id").StringValue = Beacon.UserModID Then
		      Self.SQLExecute("UPDATE preset_modifiers SET label = ?2, pattern = ?3 WHERE object_id = ?1;", Modifier.ModifierID, Modifier.Label, Modifier.Pattern)
		    End If
		  Else
		    Self.SQLExecute("INSERT INTO preset_modifiers (object_id, mod_id, label, pattern) VALUES (?1, ?2, ?3, ?4);", Modifier.ModifierID, Beacon.UserModID, Modifier.Label, Modifier.Pattern)
		  End If
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AdvanceDeltaQueue()
		  If Self.mDeltaDownloadQueue.Count = 0 Then
		    Return
		  End If
		  
		  Var Downloader As New URLConnection
		  AddHandler Downloader.ContentReceived, WeakAddressOf mDeltaDownload_ContentReceived
		  AddHandler Downloader.Error, WeakAddressOf mDeltaDownload_Error
		  AddHandler Downloader.ReceivingProgressed, WeakAddressOf mDeltaDownload_ReceivingProgressed
		  Downloader.Send("GET", Self.mDeltaDownloadQueue(0))
		  Self.mDeltaDownloadQueue.RemoveAt(0)
		  Self.mDeltaDownloader = Downloader
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllMods() As Beacon.ModDetails()
		  Var Mods() As Beacon.ModDetails
		  Var Results As RowSet = Self.SQLSelect("SELECT mod_id, name, console_safe, default_enabled, workshop_id FROM mods ORDER BY name;")
		  While Not Results.AfterLastRow
		    Mods.Add(New Beacon.ModDetails(Results.Column("mod_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("workshop_id").IntegerValue))
		    Results.MoveToNextRow
		  Wend
		  Return Mods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllPresetModifiers() As Beacon.PresetModifier()
		  Var Results As RowSet = Self.SQLSelect("SELECT object_id, label, pattern FROM preset_modifiers ORDER BY label;")
		  Var Modifiers() As Beacon.PresetModifier
		  While Not Results.AfterLastRow
		    Var Dict As New Dictionary
		    Dict.Value("ModifierID") = Results.Column("object_id").StringValue
		    Dict.Value("Pattern") = Results.Column("pattern").StringValue
		    Dict.Value("Label") = Results.Column("label").StringValue
		    
		    Var Modifier As Beacon.PresetModifier = Beacon.PresetModifier.FromDictionary(Dict)
		    If Modifier <> Nil Then
		      Modifiers.Add(Modifier)
		    End If
		    
		    Results.MoveToNextRow
		  Wend
		  Return Modifiers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllTags(Category As String = "") As String()
		  Var Results As RowSet
		  If Category <> "" Then
		    Results = Self.SQLSelect("SELECT DISTINCT tags FROM searchable_tags WHERE source_table = $1 AND tags != '';", Category)
		  Else
		    Results = Self.SQLSelect("SELECT DISTINCT tags FROM searchable_tags WHERE tags != '';")
		  End If
		  Var Dict As New Dictionary
		  While Not Results.AfterLastRow
		    Var Tags() As String = Results.Column("tags").StringValue.Split(",")
		    For Each Tag As String In Tags
		      If Tag <> "object" Then
		        Dict.Value(Tag) = True
		      End If
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

	#tag Method, Flags = &h21
		Private Sub BeginTransaction()
		  Self.mLock.Enter
		  
		  If Self.mTransactions.LastIndex = -1 Then
		    Self.mTransactions.AddAt(0, "")
		    Self.SQLExecute("BEGIN TRANSACTION;")
		  Else
		    Var Savepoint As String = "Savepoint_" + EncodeHex(Crypto.GenerateRandomBytes(4))
		    Self.mTransactions.AddAt(0, Savepoint)
		    Self.SQLExecute("SAVEPOINT " + Savepoint + ";")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintLabels(Category As String, Mods As Beacon.StringList) As Dictionary
		  Var CacheKey As String = Category + ":" + Mods.Hash
		  If Self.mBlueprintLabelsCacheKey <> CacheKey Then
		    Var Blueprints() As Beacon.Blueprint = Self.SearchForBlueprints(Category, "", Mods, "")
		    Var Temp As New Dictionary
		    For Each Blueprint As Beacon.Blueprint In Blueprints
		      Var Matches() As Beacon.Blueprint
		      If Temp.HasKey(Blueprint.Label) Then
		        Matches = Temp.Value(Blueprint.Label)
		      End If
		      Matches.Add(Blueprint)
		      Temp.Value(Blueprint.Label) = Matches
		    Next
		    
		    Var Dict As New Dictionary
		    For Each Entry As DictionaryEntry In Temp
		      Var Base As String = Entry.Key
		      Var Matches() As Beacon.Blueprint = Entry.Value
		      If Matches.Count = 1 Then
		        Dict.Value(Matches(0).ObjectID) = Base
		      Else
		        For Each Sibling As Beacon.Blueprint In Matches
		          Dict.Value(Sibling.ObjectID) = Base.Disambiguate(Sibling.ModName)
		        Next
		      End If
		    Next
		    
		    Self.mBlueprintLabelsCacheDict = Dict
		    Self.mBlueprintLabelsCacheKey = CacheKey
		  End If
		  
		  Return Self.mBlueprintLabelsCacheDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildSchema()
		  Self.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Var ModsOnDelete As String
		  #if DebugBuild
		    ModsOnDelete = "RESTRICT"
		  #else
		    ModsOnDelete = "CASCADE"
		  #endif
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("CREATE TABLE variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE mods (mod_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, name TEXT COLLATE NOCASE NOT NULL, console_safe INTEGER NOT NULL, default_enabled INTEGER NOT NULL, workshop_id INTEGER NOT NULL UNIQUE);")
		  Self.SQLExecute("CREATE TABLE loot_source_icons (icon_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, icon_data BLOB NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_sources (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT COLLATE NOCASE NOT NULL, sort_order INTEGER NOT NULL, icon TEXT COLLATE NOCASE NOT NULL REFERENCES loot_source_icons(icon_id) ON UPDATE CASCADE ON DELETE RESTRICT, experimental BOOLEAN NOT NULL, notes TEXT NOT NULL, requirements TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE engrams (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', entry_string TEXT COLLATE NOCASE, required_level INTEGER, required_points INTEGER, stack_size INTEGER, item_id INTEGER, recipe TEXT NOT NULL DEFAULT '[]');")
		  Self.SQLExecute("CREATE TABLE official_presets (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_presets (user_id TEXT COLLATE NOCASE NOT NULL, object_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE preset_modifiers (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, pattern TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE config_help (config_name TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, title TEXT COLLATE NOCASE NOT NULL, body TEXT COLLATE NOCASE NOT NULL, detail_url TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE news (uuid TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, title TEXT NOT NULL, detail TEXT, url TEXT, min_version INTEGER, max_version INTEGER, moment TEXT NOT NULL, min_os_version TEXT);")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE creatures (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', incubation_time REAL, mature_time REAL, stats TEXT, used_stats INTEGER, mating_interval_min REAL, mating_interval_max REAL);")
		  Self.SQLExecute("CREATE TABLE spawn_points (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, availability INTEGER NOT NULL, path TEXT COLLATE NOCASE NOT NULL, class_string TEXT COLLATE NOCASE NOT NULL, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', sets TEXT NOT NULL DEFAULT '[]', limits TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE ini_options (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', native_editor_version INTEGER, file TEXT COLLATE NOCASE NOT NULL, header TEXT COLLATE NOCASE NOT NULL, key TEXT COLLATE NOCASE NOT NULL, value_type TEXT COLLATE NOCASE NOT NULL, max_allowed INTEGER, description TEXT NOT NULL, default_value TEXT, nitrado_path TEXT, nitrado_format TEXT);")
		  Self.SQLExecute("CREATE TABLE maps (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, mod_id TEXT COLLATE NOCASE NOT NULL REFERENCES mods(mod_id) ON DELETE " + ModsOnDelete + " DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, ark_identifier TEXT COLLATE NOCASE NOT NULL UNIQUE, difficulty_scale REAL NOT NULL, official BOOLEAN NOT NULL, mask BIGINT NOT NULL UNIQUE, sort INTEGER NOT NULL);")
		  
		  Self.SQLExecute("CREATE VIRTUAL TABLE searchable_tags USING fts5(tags, object_id, source_table);")
		  
		  Self.SQLExecute("CREATE VIEW blueprints AS SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Beacon.CategoryEngrams + "' AS category FROM engrams UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Beacon.CategoryCreatures + "' AS category FROM creatures UNION SELECT object_id, class_string, path, label, tags, availability, mod_id, '" + Beacon.CategorySpawnPoints + "' AS category FROM spawn_points")
		  Var Categories() As String = Beacon.Categories
		  Var DeleteStatements() As String
		  For Each Category As String In Categories
		    DeleteStatements.Add("DELETE FROM " + Category + " WHERE object_id = OLD.object_id;")
		  Next
		  Self.SQLExecute("CREATE TRIGGER blueprints_delete_trigger INSTEAD OF DELETE ON blueprints FOR EACH ROW BEGIN " + DeleteStatements.Join(" ") + " DELETE FROM searchable_tags WHERE object_id = OLD.object_id; END;")
		  
		  For Each Category As String In Categories
		    Self.SQLExecute("CREATE UNIQUE INDEX " + Category + "_path_uidx ON " + Category + "(mod_id, path);")
		    Self.SQLExecute("CREATE INDEX " + Category + "_path_idx ON " + Category + "(path);")
		    Self.SQLExecute("CREATE INDEX " + Category + "_class_string_idx ON " + Category + "(class_string);")
		    Self.SQLExecute("CREATE INDEX " + Category + "_mod_id_idx ON " + Category + "(mod_id);")
		  Next
		  Self.SQLExecute("CREATE INDEX loot_sources_sort_order_idx ON loot_sources(sort_order);")
		  Self.SQLExecute("CREATE INDEX maps_mod_id_idx ON maps(mod_id);")
		  Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_path_idx ON loot_sources(path);")
		  Self.SQLExecute("CREATE UNIQUE INDEX custom_presets_user_id_object_id_idx ON custom_presets(user_id, object_id);")
		  Self.SQLExecute("CREATE INDEX engrams_entry_string_idx ON engrams(entry_string);")
		  Self.SQLExecute("CREATE UNIQUE INDEX ini_options_file_header_key_idx ON ini_options(file, header, key);")
		  
		  Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe, default_enabled, workshop_id) VALUES (?1, ?2, ?3, ?4, ?5);", Beacon.UserModID, Beacon.UserModName, True, True, Beacon.UserModWorkshopID)
		  Self.Commit()
		  
		  Self.mBase.UserVersion = Self.SchemaVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Creatures() As Beacon.Creature)
		  For Each Creature As Beacon.Creature In Creatures
		    Self.mCreatureCache.Value(Creature.ObjectID) = Creature
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Creature As Beacon.Creature)
		  Var Arr(0) As Beacon.Creature
		  Arr(0) = Creature
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(Engrams() As Beacon.Engram)
		  For Each Engram As Beacon.Engram In Engrams
		    Self.mEngramCache.Value(Engram.ObjectID) = Engram
		    
		    If Engram.HasUnlockDetails Then
		      Var SimilarEngrams() As Beacon.Engram
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
		Private Sub Cache(Engram As Beacon.Engram)
		  Var Arr(0) As Beacon.Engram
		  Arr(0) = Engram
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(SpawnPoints() As Beacon.SpawnPoint)
		  For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		    Self.mSpawnPointCache.Value(SpawnPoint.ObjectID) = SpawnPoint
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Cache(SpawnPoint As Beacon.SpawnPoint)
		  Var Arr(0) As Beacon.SpawnPoint
		  Arr(0) = SpawnPoint
		  Self.Cache(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckForEngramUpdates(ForceRefresh As Boolean = False)
		  If Self.mCheckingForUpdates Then
		    Return
		  End If
		  
		  If Self.Importing And ForceRefresh = False Then
		    Self.mCheckForUpdatesAfterImport = True
		    Return
		  End If
		  
		  If Self.mUpdater = Nil Then
		    Self.mUpdater = New URLConnection
		    Self.mUpdater.AllowCertificateValidation = True
		    Self.mUpdater.RequestHeader("Cache-Control") = "no-cache"
		    Self.mUpdater.RequestHeader("User-Agent") = App.UserAgent
		    AddHandler Self.mUpdater.ContentReceived, WeakAddressOf Self.mUpdater_ContentReceived
		    AddHandler Self.mUpdater.Error, WeakAddressOf Self.mUpdater_Error
		  End If
		  
		  Self.mCheckingForUpdates = True
		  Var CheckURL As String = Self.ClassesURL(ForceRefresh)
		  App.Log("Checking for blueprint updates from " + CheckURL)
		  Self.mUpdater.Send("GET", CheckURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ClassesURL(ForceRefresh As Boolean) As String
		  Var CheckURL As String = BeaconAPI.URL("/deltas?version=" + Self.EngramsVersion.ToString(Locale.Raw, "0"))
		  
		  If ForceRefresh = False Then
		    Var LastSync As String = Self.Variable("sync_time")
		    If LastSync <> "" Then
		      CheckURL = CheckURL + "&since=" + EncodeURLComponent(LastSync)
		    End If
		  End If
		  
		  If App.IdentityManager <> Nil And App.IdentityManager.CurrentIdentity <> Nil Then
		    CheckURL = CheckURL + "&user_id=" + EncodeURLComponent(App.IdentityManager.CurrentIdentity.UserID)
		  End If
		  
		  Return CheckURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  NotificationKit.Ignore(Self, UserCloud.Notification_SyncFinished, IdentityManager.Notification_IdentityChanged)
		  
		  If Self.mBase <> Nil Then
		    Try
		      Self.SQLExecute("PRAGMA optimize;")
		      Self.mBase.Close
		    Catch Err As RuntimeException
		    End Try
		    Self.mBase = Nil
		  End If
		  
		  If mInstance = Self Then
		    mInstance = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Commit()
		  If Self.mTransactions.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.RemoveAt(0)
		  
		  If Savepoint = "" Then
		    Self.SQLExecute("COMMIT TRANSACTION;")
		    Self.mLastCommitTime = System.Microseconds
		  Else
		    Self.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafeMods() As Beacon.ModDetails()
		  Var Mods() As Beacon.ModDetails
		  Var Results As RowSet = Self.SQLSelect("SELECT mod_id, name, console_safe, default_enabled, workshop_id FROM mods WHERE console_safe = 1 ORDER BY name;")
		  While Not Results.AfterLastRow
		    Mods.Add(New Beacon.ModDetails(Results.Column("mod_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("workshop_id").IntegerValue))
		    Results.MoveToNextRow
		  Wend
		  Return Mods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramCache = New Dictionary
		  Self.mCreatureCache = New Dictionary
		  Self.mSpawnPointCache = New Dictionary
		  Self.mLock = New CriticalSection
		  Self.mDropsLabelCacheDict = New Dictionary
		  Self.mSpawnLabelCacheDict = New Dictionary
		  Self.mBlueprintLabelsCacheDict = New Dictionary
		  
		  Var AppSupport As FolderItem = App.ApplicationSupport
		  
		  Var LegacyFile As FolderItem = AppSupport.Child("Beacon.sqlite")
		  If LegacyFile.Exists Then
		    LegacyFile.Remove
		  End If
		  
		  Self.mBase = New SQLiteDatabase
		  Self.mBase.DatabaseFile = AppSupport.Child("Library.sqlite")
		  
		  If Self.mBase.DatabaseFile.Exists Then
		    If Not Self.mBase.Connect Then
		      Return
		    End If
		  Else
		    Self.mBase.CreateDatabase
		    
		    Self.BuildSchema()
		  End If
		  
		  Var CurrentSchemaVersion As Integer = Self.mBase.UserVersion
		  Var MigrateFile As FolderItem
		  If CurrentSchemaVersion <> Self.SchemaVersion Then
		    Self.mBase.Close
		    
		    Var BackupsFolder As FolderItem = AppSupport.Child("Old Libraries")
		    If Not BackupsFolder.Exists Then
		      BackupsFolder.CreateFolder
		    End If
		    
		    // Relocate the current library
		    Var Counter As Integer = 1
		    Do
		      Var Destination As FolderItem = BackupsFolder.Child("Library " + CurrentSchemaVersion.ToString(Locale.Raw, "0") + If(Counter > 1, "-" + Counter.ToString(Locale.Raw, "0"), "") + ".sqlite")
		      If Destination.Exists Then
		        Counter = Counter + 1
		        Continue
		      End If
		      Self.mBase.DatabaseFile.MoveTo(Destination)
		      MigrateFile = Destination
		      Exit
		    Loop
		    
		    // See if there is already a library, such as if the user went switched backward and forward between versions
		    Var SearchFolders(1) As FolderItem
		    SearchFolders(0) = BackupsFolder
		    SearchFolders(1) = AppSupport
		    Var SearchPrefix As String = "Library " + Self.SchemaVersion.ToString(Locale.Raw, "0")
		    Var SearchSuffix As String = ".sqlite"
		    For Each SearchFolder As FolderItem In SearchFolders
		      Var Candidates() As FolderItem
		      Var Versions() As Integer
		      For I As Integer = 0 To SearchFolder.Count - 1
		        Var Filename As String = SearchFolder.ChildAt(I).Name
		        If Filename = SearchPrefix + SearchSuffix Then
		          Candidates.Add(SearchFolder.ChildAt(I))
		          Versions.Add(1)
		        ElseIf Filename.BeginsWith(SearchPrefix) And Filename.EndsWith(SearchSuffix) Then
		          Candidates.Add(SearchFolder.ChildAt(I))
		          Versions.Add(Integer.FromString(Filename.Middle(SearchPrefix.Length + 1, Filename.Length - (SearchPrefix.Length + SearchSuffix.Length + 1))))
		        End If
		      Next
		      
		      If Candidates.LastIndex > -1 Then
		        Versions.SortWith(Candidates)
		        
		        Var RestoreFile As FolderItem = Candidates(Candidates.LastIndex)
		        RestoreFile.MoveTo(AppSupport.Child("Library.sqlite"))
		        
		        Self.mBase = New SQLiteDatabase
		        Self.mBase.DatabaseFile = AppSupport.Child("Library.sqlite")
		        Call Self.mBase.Connect
		        Return
		      End If
		    Next
		    
		    Self.mBase = New SQLiteDatabase
		    Self.mBase.DatabaseFile = App.ApplicationSupport.Child("Library.sqlite")
		    Call Self.mBase.CreateDatabase
		    Self.BuildSchema()
		  End If
		  
		  Self.mBase.ExecuteSQL("PRAGMA cache_size = -100000;")
		  
		  NotificationKit.Watch(Self, UserCloud.Notification_SyncFinished, IdentityManager.Notification_IdentityChanged)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprint(Blueprint As Beacon.Blueprint)
		  Var Arr(0) As Beacon.Blueprint
		  Arr(0) = Blueprint
		  Self.DeleteBlueprints(Arr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteBlueprints(Blueprints() As Beacon.Blueprint)
		  Var ObjectIDs() As String
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    ObjectIDs.Add("'" + Blueprint.ObjectID + "'")
		  Next
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM blueprints WHERE mod_id = '" + Beacon.UserModID + "' AND object_id IN (" + ObjectIDs.Join(",") + ");")
		  Self.Commit()
		  
		  Self.SyncUserEngrams()
		  NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteDataForMod(ModID As String)
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM loot_sources WHERE mod_id = ?1;", ModID)
		  Self.SQLExecute("DELETE FROM blueprints WHERE mod_id = ?1;", ModID)
		  Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id = ?1;", ModID)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeletePreset(Preset As Beacon.Preset)
		  If Not Self.IsPresetCustom(Preset) Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, Preset.PresetID)
		  Self.Commit()
		  
		  Call UserCloud.Delete("/Presets/" + Preset.PresetID.Lowercase + BeaconFileTypes.BeaconPreset.PrimaryExtension)
		  
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramIsCustom(Engram As Beacon.Engram) As Boolean
		  If Engram Is Nil Then
		    Return True
		  End If
		  
		  If Engram.ModID = Beacon.UserModID Then
		    Return True
		  End If
		  
		  Var ObjectID As String = Engram.ObjectID
		  
		  If Self.mEngramCache.HasKey(ObjectID) Then
		    Return Beacon.Engram(Self.mEngramCache.Value(ObjectID)).ModID = Beacon.UserModID
		  End If
		  
		  Var Results As RowSet = Self.SQLSelect("SELECT mod_id FROM engrams WHERE object_id = ?1;", ObjectID)
		  Return Results.RowCount = 0 Or Results.Column("mod_id").StringValue = Beacon.UserModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintByID(ObjectID As v4UUID) As Beacon.Blueprint
		  Var Results As RowSet = Self.SQLSelect("SELECT category FROM blueprints WHERE object_id = ?1;", ObjectID.StringValue)
		  If Results.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Select Case Results.Column("category").StringValue
		  Case Beacon.CategoryEngrams
		    Return Self.GetEngramByID(ObjectID)
		  Case Beacon.CategoryCreatures
		    Return Self.GetCreatureByID(ObjectID)
		  Case Beacon.CategorySpawnPoints
		    Return Self.GetSpawnPointByID(ObjectID)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.Blueprint()
		  // This is not the most efficient method, but there shouldn't be a lot
		  // of items with duplicate classes, so it probably won't matter.
		  
		  Var Blueprints() As Beacon.Blueprint
		  
		  Var SQL As String = "SELECT object_id, category FROM blueprints WHERE class_string = ?1;"
		  If (Mods Is Nil) = False Then
		    SQL = SQL.Left(SQL.Length - 1) + " AND mod_id IN (" + Mods.SQLValue + ");"
		  End If
		  
		  Var Results As RowSet = Self.SQLSelect(SQL, ClassString)
		  If Results.RowCount = 0 Then
		    Return Blueprints
		  End If
		  
		  For Each Result As DatabaseRow In Results
		    Var Blueprint As Beacon.Blueprint
		    Var ObjectID As String = Result.Column("object_id").StringValue
		    
		    Select Case Result.Column("category").StringValue
		    Case Beacon.CategoryEngrams
		      Blueprint = Self.GetEngramByID(ObjectID)
		    Case Beacon.CategoryCreatures
		      Blueprint = Self.GetCreatureByID(ObjectID)
		    Case Beacon.CategorySpawnPoints
		      Blueprint = Self.GetSpawnPointByID(ObjectID)
		    End Select
		    If (Blueprint Is Nil) = False Then
		      Blueprints.Add(Blueprint)
		    End If
		  Next
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByPath(Path As String, Mods As Beacon.StringList) As Beacon.Blueprint()
		  // This is not the most efficient method, but there shouldn't be a lot
		  // of items with duplicate paths, so it probably won't matter.
		  
		  Var Blueprints() As Beacon.Blueprint
		  
		  Var SQL As String = "SELECT object_id, category FROM blueprints WHERE path = ?1;"
		  If (Mods Is Nil) = False Then
		    SQL = SQL.Left(SQL.Length - 1) + " AND mod_id IN (" + Mods.SQLValue + ");"
		  End If
		  
		  Var Results As RowSet = Self.SQLSelect(SQL, Path)
		  If Results.RowCount = 0 Then
		    Return Blueprints
		  End If
		  
		  For Each Result As DatabaseRow In Results
		    Var Blueprint As Beacon.Blueprint
		    Var ObjectID As String = Result.Column("object_id").StringValue
		    
		    Select Case Result.Column("category").StringValue
		    Case Beacon.CategoryEngrams
		      Blueprint = Self.GetEngramByID(ObjectID)
		    Case Beacon.CategoryCreatures
		      Blueprint = Self.GetCreatureByID(ObjectID)
		    Case Beacon.CategorySpawnPoints
		      Blueprint = Self.GetSpawnPointByID(ObjectID)
		    End Select
		    If (Blueprint Is Nil) = False Then
		      Blueprints.Add(Blueprint)
		    End If
		  Next
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As String, Default As Boolean = False) As Boolean
		  Var Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").BooleanValue
		  Else
		    Return Default
		  End If
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
		Function GetCreatureByID(CreatureID As v4UUID) As Beacon.Creature
		  // Part of the Beacon.DataSource interface.
		  
		  Var CreatureUUID As String = CreatureID
		  If Self.mCreatureCache.HasKey(CreatureUUID) Then
		    Return Self.mCreatureCache.Value(CreatureUUID)
		  End If
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.CreatureSelectSQL + " WHERE object_id = ?1;", CreatureUUID)
		    If Results.RowCount <> 1 Then
		      Return Nil
		    End If
		    
		    Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Results)
		    Self.Cache(Creatures)
		    Return Creatures(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.Creature()
		  Var SQL As String = Self.CreatureSelectSQL + " WHERE creatures.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND creatures.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Rows)
		  Self.Cache(Creatures)
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByPath(Path As String, Mods As Beacon.StringList) As Beacon.Creature()
		  Var SQL As String = Self.CreatureSelectSQL + " WHERE creatures.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND creatures.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Rows)
		  Self.Cache(Creatures)
		  Return Creatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCustomEngrams() As Beacon.Engram()
		  Try
		    Var RS As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE mods.mod_id = ?1;", Beacon.UserModID)
		    If RS.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Var Engrams() As Beacon.Engram = Self.RowSetToEngram(RS)
		    Self.Cache(Engrams)
		    Return Engrams
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As String, Default As Double = 0.0) As Double
		  Var Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").DoubleValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByID(EngramID As v4UUID) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mEngramCache.HasKey(EngramID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE object_id = ?1;", EngramID.StringValue)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		      Self.Cache(Engrams)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mEngramCache.Value(EngramID.StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByItemID(ItemID As Integer) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE item_id = ?1;", ItemID)
		    If Results.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		    If Engrams.Count = 1 Then
		      Return Engrams(0)
		    End If
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.Engram()
		  Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND engrams.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Rows)
		  Self.Cache(Engrams)
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByEntryString(EntryString As String, Mods As Beacon.StringList) As Beacon.Engram()
		  // Part of the Beacon.DataSource interface.
		  
		  If EntryString.Length < 2 Or EntryString.Right(2) <> "_C" Then
		    EntryString = EntryString + "_C"
		  End If
		  
		  Var Engrams() As Beacon.Engram
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
		Function GetEngramsByPath(Path As String, Mods As Beacon.StringList) As Beacon.Engram()
		  Var SQL As String = Self.EngramSelectSQL + " WHERE engrams.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND engrams.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Rows)
		  Self.Cache(Engrams)
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As String, Default As Integer = 0) As Integer
		  Var Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").IntegerValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As String) As Beacon.LootSource
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    Var Results As RowSet = Self.SQLSelect("SELECT " + Self.LootSourcesSelectColumns + " FROM loot_sources WHERE class_string = ?1;", ClassString)
		    If Results.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Var Sources() As Beacon.LootSource = Self.RowSetToLootSource(Results)
		    Return Sources(0)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMap(Named As String) As Beacon.Map
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps WHERE label = $1 OR ark_identifier = $1 LIMIT 1;", Named)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Return New Beacon.Map(Rows.Column("label").StringValue, Rows.Column("ark_identifier").StringValue, Rows.Column("mask").Value.UInt64Value, Rows.Column("difficulty_scale").DoubleValue, Rows.Column("official").BooleanValue, Rows.Column("mod_id").StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps() As Beacon.Map()
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps ORDER BY official DESC, sort;")
		  Var Maps() As Beacon.Map
		  For Each Row As DatabaseRow In Rows
		    Maps.Add(New Beacon.Map(Row.Column("label").StringValue, Row.Column("ark_identifier").StringValue, Row.Column("mask").Value.UInt64Value, Row.Column("difficulty_scale").DoubleValue, Row.Column("official").BooleanValue, Row.Column("mod_id").StringValue))
		  Next
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps(Mask As UInt64) As Beacon.Map()
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM maps WHERE (mask & $1) = mask ORDER BY official DESC, sort;", Mask)
		  Var Maps() As Beacon.Map
		  For Each Row As DatabaseRow In Rows
		    Maps.Add(New Beacon.Map(Row.Column("label").StringValue, Row.Column("ark_identifier").StringValue, Row.Column("mask").Value.UInt64Value, Row.Column("difficulty_scale").DoubleValue, Row.Column("official").BooleanValue, Row.Column("mod_id").StringValue))
		  Next
		  Return Maps
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetModWithID(ModID As v4UUID) As Beacon.ModDetails
		  If ModID = Nil Then
		    Return Nil
		  End If
		  
		  Var Results As RowSet = Self.SQLSelect("SELECT mod_id, name, console_safe, default_enabled, workshop_id FROM mods WHERE mod_id = ?1;", ModID.StringValue)
		  If Results.RowCount = 1 Then
		    Return New Beacon.ModDetails(Results.Column("mod_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("workshop_id").IntegerValue)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetModWithWorkshopID(WorkshopID As Integer) As Beacon.ModDetails
		  Var Results As RowSet = Self.SQLSelect("SELECT mod_id, name, console_safe, default_enabled, workshop_id FROM mods WHERE workshop_id = ?1;", WorkshopID)
		  If Results.RowCount = 1 Then
		    Return New Beacon.ModDetails(Results.Column("mod_id").StringValue, Results.Column("name").StringValue, Results.Column("console_safe").BooleanValue, Results.Column("default_enabled").BooleanValue, Results.Column("workshop_id").IntegerValue)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNews() As NewsItem()
		  Var OSMajor, OSMinor, OSBug As Integer
		  #if TargetMacOS
		    OSMajor = SystemInformationMBS.MacMajorVersion
		    OSMinor = SystemInformationMBS.MacMinorVersion
		    OSBug = SystemInformationMBS.MacBugFixVersion
		  #elseif TargetWin32
		    OSMajor = SystemInformationMBS.WinMajorVersion
		    OSMinor = SystemInformationMBS.WinMinorVersion
		    OSBug = SystemInformationMBS.WinBuildNumber
		  #endif
		  
		  Var BuildNumber As Integer = App.BuildNumber
		  Var Rows As RowSet = Self.SQLSelect("SELECT uuid, title, COALESCE(detail, '') AS detail, COALESCE(url, '') AS url, min_os_version FROM news WHERE (min_version IS NULL OR min_version <= ?1) AND (max_version IS NULL OR max_version >= ?1) ORDER BY moment DESC;", BuildNumber)
		  Var Items() As NewsItem
		  For Each Row As DatabaseRow In Rows
		    If Row.Column("min_os_version").Value.IsNull = False Then
		      Var MinOSVersionParts() As String = Row.Column("min_os_version").StringValue.Split(".")
		      Var MinOSMajor As Integer = MinOSVersionParts(0).ToInteger
		      Var MinOSMinor As Integer = MinOSVersionParts(1).ToInteger
		      Var MinOSBug As Integer = MinOSVersionParts(2).ToInteger
		      Var Supported As Boolean = OSMajor > MinOSMajor Or (OSMajor = MinOSMajor And OSMinor > MinOSMinor) Or (OSMajor = MinOSMajor And OSMinor = MinOSMinor AND OSBug >= MinOSBug)
		      If Not Supported Then
		        Continue
		      End If
		    End If
		    
		    Var Item As New NewsItem
		    Item.UUID = Row.Column("uuid").StringValue
		    Item.Title = Row.Column("title").StringValue
		    Item.Detail = Row.Column("detail").StringValue
		    Item.URL = Row.Column("url").StringValue
		    Items.Add(Item)
		  Next
		  Return Items
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetObjectIDsWithCraftingCosts(Mods As Beacon.StringList, Mask As UInt64) As String()
		  Var SQL As String = "SELECT object_id FROM engrams WHERE recipe != '[]' AND (availability & " + Mask.ToString + ") > 0"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    Var List() As String
		    For Each ModID As String In Mods
		      List.Add("'" + ModID + "'")
		    Next
		    SQL = SQL + " AND mod_id IN (" + List.Join(",") + ")"
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
		Function GetPreset(PresetID As String) As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    If Preset.PresetID = PresetID Then
		      Return Preset
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifier(ModifierID As String) As Beacon.PresetModifier
		  Var Results As RowSet = Self.SQLSelect("SELECT object_id, label, pattern FROM preset_modifiers WHERE object_id = ?1;", ModifierID)
		  If Results.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("ModifierID") = Results.Column("object_id").StringValue
		  Dict.Value("Pattern") = Results.Column("pattern").StringValue
		  Dict.Value("Label") = Results.Column("label").StringValue
		  Return Beacon.PresetModifier.FromDictionary(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByID(SpawnPointID As v4UUID) As Beacon.SpawnPoint
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mSpawnPointCache.HasKey(SpawnPointID.StringValue) = False Then
		    Try
		      Var Results As RowSet = Self.SQLSelect(Self.SpawnPointSelectSQL + " WHERE object_id = ?1;", SpawnPointID.StringValue)
		      If Results.RowCount <> 1 Then
		        Return Nil
		      End If
		      
		      Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      Self.Cache(SpawnPoints)
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  End If
		  Return Self.mSpawnPointCache.Value(SpawnPointID.StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.SpawnPoint()
		  Var SQL As String = Self.SpawnPointSelectSQL + " WHERE spawn_points.class_string = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND spawn_points.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, ClassString)
		  Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Rows)
		  Self.Cache(SpawnPoints)
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByPath(Path As String, Mods As Beacon.StringList) As Beacon.SpawnPoint()
		  Var SQL As String = Self.SpawnPointSelectSQL + " WHERE spawn_points.path = ?1"
		  If (Mods Is Nil) = False And Mods.Count > CType(0, UInteger) Then
		    SQL = SQL + " AND spawn_points.mod_id IN (" + Mods.SQLValue + ")"
		  End If
		  SQL = SQL + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(SQL, Path)
		  Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Rows)
		  Self.Cache(SpawnPoints)
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsForCreature(Creature As Beacon.Creature, Mods As Beacon.StringList, Tags As String) As Beacon.SpawnPoint()
		  Var Clauses() As String
		  Var Values() As Variant
		  Clauses.Add("spawn_points.sets LIKE :placeholder:")
		  Values.Add("%" + Creature.ObjectID + "%")
		  
		  Var Blueprints() As Beacon.Blueprint = Self.SearchForBlueprints(Beacon.CategorySpawnPoints, "", Mods, Tags, Clauses, Values)
		  Var SpawnPoints() As Beacon.SpawnPoint
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.SpawnPoint Then
		      SpawnPoints.Add(Beacon.SpawnPoint(Blueprint))
		    End If
		  Next
		  
		  Return SpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStringVariable(Key As String, Default As String = "") As String
		  Var Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Var StringValue As String = Results.Column("value").StringValue
		    If StringValue.Encoding = Nil Then
		      If Encodings.UTF8.IsValidData(StringValue) Then
		        StringValue = StringValue.DefineEncoding(Encodings.UTF8)
		      Else
		        Return Default
		      End If
		    End If
		    Return StringValue
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasExperimentalLootSources(Mods As Beacon.StringList) As Boolean
		  Try
		    Var Clauses(0) As String
		    Clauses(0) = "experimental = 1"
		    
		    Var Values As New Dictionary
		    Var NextPlaceholder As Integer = 1
		    If Mods.LastRowIndex > -1 Then
		      Var Placeholders() As String
		      For Each ModID As String In Mods
		        Placeholders.Add("?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		        Values.Value(NextPlaceholder) = ModID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.Add("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    
		    Var SQL As String = "SELECT COUNT(loot_sources.object_id) FROM loot_sources INNER JOIN mods ON (loot_sources.mod_id = mods.mod_id) WHERE (" + Clauses.Join(") AND (") + ");"
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
		Function IconForLootSource(Source As Beacon.LootSource, BackgroundColor As Color) As Picture
		  // "Fix" background color to account for opacity. It's not perfect, but it's good.
		  Var BackgroundOpacity As Double = (255 - BackgroundColor.Alpha) / 255
		  BackgroundColor = SystemColors.UnderPageBackgroundColor.BlendWith(Color.RGB(BackgroundColor.Red, BackgroundColor.Green, BackgroundColor.Blue), BackgroundOpacity)
		  
		  Var PrimaryColor, AccentColor As Color
		  Var IconID As String
		  Var Results As RowSet = Self.SQLSelect("SELECT loot_source_icons.icon_id, loot_source_icons.icon_data, loot_sources.experimental FROM loot_sources INNER JOIN loot_source_icons ON (loot_sources.icon = loot_source_icons.icon_id) WHERE loot_sources.class_string = ?1;", Source.ClassString)
		  Var SpriteSheet, BadgeSheet As Picture
		  If Results.RowCount = 1 Then
		    SpriteSheet = Results.Column("icon_data").PictureValue
		    IconID = Results.Column("icon_id").StringValue
		    PrimaryColor = Source.UIColor
		  Else
		    SpriteSheet = App.GenericLootSourceIcon()
		    IconID = "3a1f5d12-0b50-4761-9f89-277492dc00e0FFFFFF00"
		    PrimaryColor = &cFFFFFF00
		  End If
		  AccentColor = BackgroundColor
		  
		  Select Case PrimaryColor
		  Case &cFFF02A00
		    PrimaryColor = SystemColors.SystemYellowColor
		  Case &cE6BAFF00
		    PrimaryColor = SystemColors.SystemPurpleColor
		  Case &c00FF0000
		    PrimaryColor = SystemColors.SystemGreenColor
		  Case &cFFBABA00
		    PrimaryColor = SystemColors.SystemRedColor
		  Case &c88C8FF00
		    PrimaryColor = SystemColors.SystemBlueColor
		  End Select
		  
		  IconID = IconID + PrimaryColor.ToHex + BackgroundColor.ToHex
		  If Self.IconCache = Nil Then
		    Self.IconCache = New Dictionary
		  End If
		  If IconCache.HasKey(IconID) Then
		    Return IconCache.Value(IconID)
		  End If
		  
		  PrimaryColor = BeaconUI.FindContrastingColor(BackgroundColor, PrimaryColor)
		  
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
		    
		    Var Sprites As Picture = New Picture(SpriteSheet.Width, SpriteSheet.Height, 32)
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
		  
		  Var Highlight As Picture = HighlightMask.WithColor(PrimaryColor)
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
		  Self.IconCache.Value(IconID) = Icon
		  Return Icon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String)
		  Self.mImporting = True
		  Self.mPendingImports.Add(Content)
		  
		  If Self.mImportThread = Nil Then
		    Self.mImportThread = New Thread
		    Self.mImportThread.Priority = Thread.LowestPriority
		    AddHandler Self.mImportThread.Run, WeakAddressOf Self.mImportThread_Run
		  End If
		  
		  If Self.mImportThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.mImportThread.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportCloudEngrams() As Boolean
		  Var EngramsUpdated As Boolean = False
		  Var EngramsContent As MemoryBlock = UserCloud.Read("/Blueprints.json")
		  Var LegacyMode As Boolean
		  If EngramsContent Is Nil Then
		    EngramsContent = UserCloud.Read("/Engrams.json")
		    If EngramsContent Is Nil Then
		      Return False
		    End If
		    LegacyMode = True
		  End If
		  Var Blueprints() As Variant
		  Try
		    Var StringContent As String = EngramsContent
		    Blueprints = Beacon.ParseJSON(StringContent.DefineEncoding(Encodings.UTF8))
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  Self.BeginTransaction()
		  Self.DeleteDataForMod(Beacon.UserModID)
		  If Not LegacyMode Then
		    Var Unpacked() As Beacon.Blueprint
		    For Each Dict As Dictionary In Blueprints
		      Try
		        Var Blueprint As Beacon.Blueprint = Beacon.UnpackBlueprint(Dict)
		        If (Blueprint Is Nil) = False Then
		          Unpacked.Add(Blueprint)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		    Call Self.SaveBlueprints(Unpacked, True)
		  Else
		    For Each Dict As Dictionary In Blueprints
		      Try
		        Var Category As String = Dict.Value("category")
		        Var Path As String = Dict.Value("path") 
		        Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM " + Category + " WHERE path = ?1;", Path)
		        If Results.RowCount <> 0 Then
		          Continue
		        End If
		        
		        Var ObjectID As v4UUID = Dict.Value("object_id").StringValue
		        Var ClassString As String = Dict.Value("class_string")
		        Var Label As String = Dict.Value("label")         
		        Var Availability As UInt64 = Dict.Value("availability")
		        Var Tags As String = Dict.Value("tags")
		        Self.SQLExecute("INSERT INTO " + Category + " (object_id, class_string, label, path, availability, tags, mod_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);",  ObjectID.StringValue, ClassString, Label, Path, Availability, Tags, Beacon.UserModID)      
		        Self.SQLExecute("INSERT INTO searchable_tags (object_id, tags, source_table) VALUES (?1, ?2, ?3);", ObjectID.StringValue, Tags, Category)
		        EngramsUpdated = True
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		  Self.Commit()
		  Return EngramsUpdated
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportCloudFiles()
		  // Import blueprints from disk into the database
		  If Self.ImportCloudEngrams Then
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  
		  // Import presets from disk into the database
		  Self.BeginTransaction()
		  Var PresetPaths() As String = UserCloud.List("/Presets/")
		  For Each RemotePath As String In PresetPaths
		    Var PresetContents As MemoryBlock = UserCloud.Read(RemotePath)
		    If PresetContents <> Nil Then
		      Call Self.ImportPreset(PresetContents)
		    End If
		  Next
		  Self.Commit()
		  
		  // This reloads presets from the database
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportCloudFiles(Actions() As Dictionary)
		  Var EngramsUpdated, PresetsUpdated As Boolean
		  For Each Action As Dictionary In Actions
		    Var RemotePath As String = Action.Value("Path")
		    If RemotePath = "/Engrams.json" Or RemotePath = "/Blueprints.json" Then
		      Select Case Action.Value("Action")
		      Case "DELETE"
		        Self.DeleteDataForMod(Beacon.UserModID)
		        EngramsUpdated = True
		      Case "GET"
		        EngramsUpdated = Self.ImportCloudEngrams() Or EngramsUpdated
		      End Select
		    ElseIf RemotePath.BeginsWith("/Presets") Then
		      Var PresetID As String = RemotePath.Middle(8, 36)
		      Select Case Action.Value("Action")
		      Case "DELETE"
		        Self.BeginTransaction()
		        Self.SQLExecute("DELETE FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, PresetID)
		        Self.Commit()
		        PresetsUpdated = True
		      Case "GET"
		        Var PresetContents As MemoryBlock = UserCloud.Read(RemotePath)
		        If PresetContents = Nil Then
		          Continue
		        End If
		        PresetsUpdated = Self.ImportPreset(PresetContents) Or PresetsUpdated
		      End Select
		    End If
		  Next
		  
		  If EngramsUpdated Then      
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  If PresetsUpdated Then
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Importing() As Boolean
		  Return Self.mImporting
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportInner(Content As String) As Boolean
		  If Content.Bytes < 2 Then
		    Return False
		  End If
		  
		  Content = Beacon.Decompress(Content)
		  
		  Var BuildNumber As Integer = App.BuildNumber
		  
		  Var ChangeDict As Dictionary
		  Try
		    ChangeDict = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    App.Log("Cannot import classes because the data is not valid JSON.")
		    Return False
		  End Try
		  
		  Var RequiredKeys() As String = Array("mods", "loot_source_icons", "loot_sources", "engrams", "presets", "preset_modifiers", "timestamp", "is_full", "beacon_version")
		  For Each RequiredKey As String In RequiredKeys
		    If Not ChangeDict.HasKey(RequiredKey) Then
		      App.Log("Cannot import classes because key '" + RequiredKey + "' is missing.")
		      Return False
		    End If
		  Next
		  
		  Var FileVersion As Integer = ChangeDict.Value("beacon_version")
		  If FileVersion <> Self.EngramsVersion Then
		    App.Log("Cannot import classes because file format is not correct for this version. Get correct classes from " + Self.ClassesURL(True))
		    Return False
		  End If
		  
		  Var ShouldTruncate As Boolean = ChangeDict.Value("is_full") = 1
		  Var PayloadTimestamp As DateTime = NewDateFromSQLDateTime(ChangeDict.Value("timestamp"))
		  Var LastSync As DateTime = Self.LastSync
		  If ShouldTruncate = False And IsNull(LastSync) = False And LastSync.SecondsFrom1970 >= PayloadTimestamp.SecondsFrom1970 Then
		    Return False
		  End If
		  
		  Try
		    Self.BeginTransaction()
		    
		    Var EngramsChanged As Boolean
		    
		    // Drop indexes
		    Var Categories() As String = Beacon.Categories
		    For Each Category As String In Categories
		      Self.SQLExecute("DROP INDEX IF EXISTS " + Category +"_class_string_idx;")
		      Self.SQLExecute("DROP INDEX IF EXISTS " + Category + "_path_idx;")
		    Next
		    Self.SQLExecute("DROP INDEX IF EXISTS loot_sources_sort_order_idx;")
		    Self.SQLExecute("DROP INDEX IF EXISTS loot_sources_path_idx;")
		    
		    If ShouldTruncate Then
		      Self.SQLExecute("DELETE FROM loot_sources WHERE mod_id != ?1;", Beacon.UserModID)
		      Self.SQLExecute("DELETE FROM blueprints WHERE mod_id != ?1;", Beacon.UserModID)
		      Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id != ?1;", Beacon.UserModID)
		      Self.SQLExecute("DELETE FROM official_presets;")
		      Self.SQLExecute("DELETE FROM ini_options WHERE mod_id != ?1;", Beacon.UserModID)
		      Self.SQLExecute("DELETE FROM mods WHERE mod_id != ?1;", Beacon.UserModID) // Mods must be deleted last
		    End If
		    
		    Var Mods() As Variant = ChangeDict.Value("mods")
		    For Each ModData As Dictionary In Mods
		      Var ModID As String = ModData.Value("mod_id").StringValue.Lowercase
		      Var ModName As String = ModData.Value("name").StringValue
		      Var ConsoleSafe As Boolean = ModData.Value("console_safe").BooleanValue
		      Var DefaultEnabled As Boolean = ModData.Value("default_enabled").BooleanValue
		      Var WorkshopID As Integer = ModData.Value("workshop_id").IntegerValue
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT mod_id FROM mods WHERE mod_id = ?1;", ModID)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE mods SET name = ?2, console_safe = ?3, default_enabled = ?4, workshop_id = ?5 WHERE mod_id = ?1 AND (name != ?2 OR console_safe != ?3 OR default_enabled != ?4 OR workshop_id != ?5);", ModID, ModName, ConsoleSafe, DefaultEnabled, WorkshopID)
		      Else
		        Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe, default_enabled, workshop_id) VALUES (?1, ?2, ?3, ?4, ?5);", ModID, ModName, ConsoleSafe, DefaultEnabled, WorkshopID)
		      End If
		    Next
		    
		    // When deleting, loot_source_icons must be done after loot_sources
		    Var Deletions() As Variant = ChangeDict.Value("deletions")
		    Var DeleteIcons() As v4UUID
		    For Each Deletion As Dictionary In Deletions
		      Var ObjectID As v4UUID = Deletion.Value("object_id").StringValue
		      Select Case Deletion.Value("group")
		      Case "loot_sources"
		        Self.SQLExecute("DELETE FROM loot_sources WHERE object_id = ?1;", ObjectID.StringValue)
		      Case "loot_source_icons"
		        DeleteIcons.Add(ObjectID)
		      Case Beacon.CategoryEngrams, Beacon.CategoryCreatures, Beacon.CategorySpawnPoints
		        Self.SQLExecute("DELETE FROM blueprints WHERE object_id = ?1;", ObjectID.StringValue)
		      Case "presets"
		        Self.SQLExecute("DELETE FROM official_presets WHERE object_id = ?1;", ObjectID.StringValue)
		      Case "mods"
		        Self.SQLExecute("DELETE FROM mods WHERE mod_id = ?1;", ObjectID.StringValue)
		      Case "maps"
		        Self.SQLExecute("DELETE FROM maps WHERE object_id = ?1;", ObjectID.StringValue)
		      End Select
		    Next
		    For Each IconID As v4UUID In DeleteIcons
		      Self.SQLExecute("DELETE FROM loot_source_icons WHERE icon_id = ?1;", IconID.StringValue)
		    Next
		    
		    Var LootSourceIcons() As Variant = ChangeDict.Value("loot_source_icons")
		    For Each Dict As Dictionary In LootSourceIcons
		      If Dict.Value("min_version") > BuildNumber Then
		        Continue
		      End If
		      
		      Var IconID As String = Dict.Value("id")
		      Var IconData As MemoryBlock = DecodeBase64(Dict.Value("icon_data"))
		      
		      IconID = IconID.Lowercase
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT icon_id FROM loot_source_icons WHERE icon_id = ?1;", IconID)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE loot_source_icons SET icon_data = ?2 WHERE icon_id = ?1;", IconID, IconData)
		      Else
		        Self.SQLExecute("INSERT INTO loot_source_icons (icon_id, icon_data) VALUES (?1, ?2);", IconID, IconData)
		      End If
		    Next
		    If LootSourceIcons.LastIndex > -1 Then
		      Self.IconCache = Nil
		    End If
		    
		    Var LootSources() As Variant = ChangeDict.Value("loot_sources")
		    For Each Dict As Dictionary In LootSources
		      If Dict.Value("min_version") > BuildNumber Then
		        Continue
		      End If
		      
		      Var ObjectID As v4UUID = Dict.Value("id").StringValue
		      Var Label As String = Dict.Value("label")
		      Var AlternateLabel As Variant = Dict.Lookup("alternate_label", Nil)
		      Var ModID As v4UUID = Dictionary(Dict.Value("mod")).Value("id").StringValue
		      Var Availability As Integer = Dict.Value("availability")
		      Var Path As String = Dict.Value("path")
		      Var ClassString As String = Dict.Value("class_string")
		      Var MultiplierMin As Double = Dictionary(Dict.Value("multipliers")).Value("min")
		      Var MultiplierMax As Double = Dictionary(Dict.Value("multipliers")).Value("max")
		      Var UIColor As String = Dict.Value("ui_color")
		      Var SortOrder As Integer = If(Dict.HasKey("sort"), Dict.Value("sort").IntegerValue, Dict.Value("sort_order").IntegerValue)
		      Var Experimental As Boolean = Dict.Value("experimental")
		      Var Notes As String = Dict.Value("notes")
		      Var IconID As v4UUID = Dict.Value("icon").StringValue
		      Var Requirements As String = Dict.Lookup("requirements", "{}")
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM loot_sources WHERE object_id = ?1 OR path = ?2;", ObjectID.StringValue, Path)
		      If Results.RowCount = 1 And ObjectID = Results.Column("object_id").StringValue Then
		        Self.SQLExecute("UPDATE loot_sources SET mod_id = ?2, label = ?3, availability = ?4, path = ?5, class_string = ?6, multiplier_min = ?7, multiplier_max = ?8, uicolor = ?9, sort_order = ?10, icon = ?11, experimental = ?12, notes = ?13, requirements = ?14, alternate_label = ?15 WHERE object_id = ?1;", ObjectID.StringValue, ModID.StringValue, Label, Availability, Path, ClassString, MultiplierMin, MultiplierMax, UIColor, SortOrder, IconID.StringValue, Experimental, Notes, Requirements, AlternateLabel)
		      Else
		        If Results.RowCount = 1 Then
		          Self.SQLExecute("DELETE FROM loot_sources WHERE object_id = ?1;", Results.Column("object_id").StringValue)
		        End If
		        Self.SQLExecute("INSERT INTO loot_sources (object_id, mod_id, label, availability, path, class_string, multiplier_min, multiplier_max, uicolor, sort_order, icon, experimental, notes, requirements, alternate_label) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14, ?15);", ObjectID.StringValue, ModID.StringValue, Label, Availability, Path, ClassString, MultiplierMin, MultiplierMax, UIColor, SortOrder, IconID.StringValue, Experimental, Notes, Requirements, AlternateLabel)
		      End If
		      EngramsChanged = True
		    Next
		    
		    If ChangeDict.HasKey("engrams") Then
		      Var Engrams() As Variant = ChangeDict.Value("engrams")
		      For Each Dict As Dictionary In Engrams
		        If Dict.Value("min_version") > BuildNumber Then
		          Continue
		        End If
		        
		        Var ExtraColumns As New Dictionary
		        Var EntryString As Variant = Dict.Lookup("entry_string", Nil)
		        If IsNull(EntryString) = False Then
		          ExtraColumns.Value("entry_string") = EntryString
		          ExtraColumns.Value("required_points") = Dict.Lookup("required_points", Nil)
		          ExtraColumns.Value("required_level") = Dict.Lookup("required_level", Nil)
		        End If
		        
		        If Dict.HasKey("stack_size") Then
		          ExtraColumns.Value("stack_size") = Dict.Value("stack_size")
		        End If
		        
		        If Dict.HasKey("item_id") Then
		          ExtraColumns.Value("item_id") = Dict.Value("item_id")
		        End If
		        
		        If Dict.HasKey("recipe") And IsNull(Dict.Value("recipe")) = False Then
		          ExtraColumns.Value("recipe") = Beacon.GenerateJSON(Dict.Value("recipe"), False)
		        End If
		        
		        Var Imported As Boolean = Self.AddBlueprintToDatabase(Beacon.CategoryEngrams, Dict, ExtraColumns)
		        EngramsChanged = EngramsChanged Or Imported
		      Next
		    End If
		    
		    If ChangeDict.HasKey("creatures") Then
		      Var Creatures() As Variant = ChangeDict.Value("creatures")
		      For Each Dict As Dictionary In Creatures
		        If Dict.Value("min_version") > BuildNumber Then
		          Continue
		        End If
		        
		        Var ExtraColumns As New Dictionary
		        ExtraColumns.Value("incubation_time") = Dict.Lookup("incubation_time", Nil)
		        ExtraColumns.Value("mature_time") = Dict.Lookup("mature_time", Nil)
		        ExtraColumns.Value("mating_interval_min") = Dict.Lookup("mating_interval_min", Nil)
		        ExtraColumns.Value("mating_interval_max") = Dict.Lookup("mating_interval_max", Nil)
		        If Dict.HasAllKeys("stats", "used_stats") And IsNull(Dict.Value("stats")) = False And IsNull(Dict.Value("used_stats")) = False Then
		          ExtraColumns.Value("stats") = Beacon.GenerateJSON(Dict.Value("stats"), False)
		          ExtraColumns.Value("used_stats") = Dict.Value("used_stats")
		        Else
		          ExtraColumns.Value("stats") = Nil
		          ExtraColumns.Value("used_stats") = Nil
		        End If
		        
		        Var Imported As Boolean = Self.AddBlueprintToDatabase(Beacon.CategoryCreatures, Dict, ExtraColumns)
		        EngramsChanged = EngramsChanged Or Imported
		      Next
		    End If
		    
		    If ChangeDict.HasKey("spawn_points") Then
		      Var SpawnPoints() As Variant = ChangeDict.Value("spawn_points")
		      For Each Dict As Dictionary In SpawnPoints
		        If Dict.Value("min_version") > BuildNumber Then
		          Continue
		        End If
		        
		        Var ExtraColumns As New Dictionary
		        If IsNull(Dict.Value("sets")) = False Then
		          ExtraColumns.Value("sets") = Beacon.GenerateJSON(Dict.Value("sets"), False)
		        End If
		        If IsNull(Dict.Value("limits")) = False Then
		          ExtraColumns.Value("limits") = Beacon.GenerateJSON(Dict.Value("limits"), False)
		        End If
		        
		        Var Imported As Boolean = Self.AddBlueprintToDatabase(Beacon.CategorySpawnPoints, Dict, ExtraColumns)
		        EngramsChanged = EngramsChanged Or Imported
		      Next
		    End If
		    
		    If ChangeDict.HasKey("ini_options") Then
		      Var Options() As Variant = ChangeDict.Value("ini_options")
		      For Each Dict As Dictionary In Options
		        If Dict.Value("min_version") > BuildNumber Then
		          Continue
		        End If
		        
		        Var ObjectID As v4UUID = Dict.Value("id").StringValue
		        Var ModID As v4UUID = Dictionary(Dict.Value("mod")).Value("id").StringValue
		        Var File As String = Dict.Value("file").StringValue
		        Var Header As String = Dict.Value("header").StringValue
		        Var Key As String = Dict.Value("key").StringValue
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
		        
		        Var Values(14) As Variant
		        Values(0) = ObjectID.StringValue
		        Values(1) = Dict.Value("label")
		        Values(2) = ModID.StringValue
		        Values(3) = Dict.Value("native_editor_version")
		        Values(4) = File
		        Values(5) = Header
		        Values(6) = Key
		        Values(7) = Dict.Value("value_type")
		        Values(8) = Dict.Value("max_allowed")
		        Values(9) = Dict.Value("description")
		        Values(10) = Dict.Value("default_value")
		        Values(11) = Dict.Value("alternate_label")
		        If Dict.HasKey("nitrado_guided_equivalent") And IsNull(Dict.Value("nitrado_guided_equivalent")) = False Then
		          Var NitradoEq As Dictionary = Dict.Value("nitrado_guided_equivalent")
		          Values(12) = NitradoEq.Value("path")
		          Values(13) = NitradoEq.Value("format")
		        Else
		          Values(12) = Nil
		          Values(13) = Nil
		        End If
		        Values(14) = TagString
		        
		        Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM ini_options WHERE object_id = $1 OR (file = $2 AND header = $3 AND key = $4);", ObjectID.StringValue, File, Header, Key)
		        If Results.RowCount > 1 Then
		          Self.SQLExecute("DELETE FROM ini_options WHERE object_id = $1 OR (file = $2 AND header = $3 AND key = $4);", ObjectID.StringValue, File, Header, Key)
		        End If
		        If Results.RowCount = 1 Then
		          // Update
		          Var OriginalObjectID As v4UUID = Results.Column("object_id").StringValue
		          Values.Add(OriginalObjectID.StringValue)
		          Self.SQLExecute("UPDATE ini_options SET object_id = $1, label = $2, mod_id = $3, native_editor_version = $4, file = $5, header = $6, key = $7, value_type = $8, max_allowed = $9, description = $10, default_value = $11, alternate_label = $12, nitrado_path = $13, nitrado_format = $14, tags = $15 WHERE object_id = $16;", Values)
		        Else
		          // Insert
		          Self.SQLExecute("INSERT INTO ini_options (object_id, label, mod_id, native_editor_version, file, header, key, value_type, max_allowed, description, default_value, alternate_label, nitrado_path, nitrado_format, tags) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15);", Values)
		        End If
		      Next
		    End If
		    
		    If ChangeDict.HasKey("maps") Then
		      Var Maps() As Dictionary = ChangeDict.Value("maps").DictionaryArrayValue
		      For Each MapDict As Dictionary In Maps
		        Var MapID As String = MapDict.Value("map_id")
		        Var ModID As String = MapDict.Value("mod_id")
		        Var Label As String = MapDict.Value("label")
		        Var Identifier As String = MapDict.Value("identifier")
		        Var Difficulty As Double = MapDict.Value("difficulty")
		        Var Official As Boolean = MapDict.Value("official")
		        Var Mask As UInt64 = MapDict.Value("mask")
		        Var Sort As Integer = MapDict.Value("sort")
		        
		        Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM maps WHERE object_id = $1;", MapID)
		        If Results.RowCount = 1 Then
		          Self.SQLExecute("UPDATE maps SET mod_id = $2, label = $3, ark_identifier = $4, difficulty_scale = $5, official = $6, mask = $7, sort = $8 WHERE object_id = $1;", MapID, ModID, Label, Identifier, Difficulty, Official, Mask, Sort)
		        Else
		          Self.SQLExecute("INSERT INTO maps (object_id, mod_id, label, ark_identifier, difficulty_scale, official, mask, sort) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);", MapID, ModID, Label, Identifier, Difficulty, Official, Mask, Sort)
		        End If
		      Next
		    End If
		    
		    Var ReloadPresets As Boolean
		    Var Presets() As Variant = ChangeDict.Value("presets")
		    For Each Dict As Dictionary In Presets
		      If Dict.Value("min_version") > BuildNumber Then
		        Continue
		      End If
		      
		      Var ObjectID As v4UUID = Dict.Value("id").StringValue
		      Var Label As String = Dict.Value("label")
		      Var Contents As String = Dict.Value("contents")
		      
		      ReloadPresets = True
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM official_presets WHERE object_id = ?1;", ObjectID.StringValue)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE official_presets SET label = ?2, contents = ?3 WHERE object_id = ?1;", ObjectID.StringValue, Label, Contents)
		      Else
		        Self.SQLExecute("INSERT INTO official_presets (object_id, label, contents) VALUES (?1, ?2, ?3);", ObjectID.StringValue, Label, Contents)
		      End If
		    Next
		    
		    Var PresetModifiers() As Variant = ChangeDict.Value("preset_modifiers")
		    For Each Dict As Dictionary In PresetModifiers
		      If Dict.Value("min_version") > BuildNumber Then
		        Continue
		      End If
		      
		      Var ObjectID As v4UUID = Dict.Value("id").StringValue
		      Var Label As String = Dict.Value("label")
		      Var Pattern As String = Dict.Value("pattern")
		      Var ModID As v4UUID = Dictionary(Dict.Value("mod")).Value("id").StringValue
		      
		      ReloadPresets = True
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM preset_modifiers WHERE object_id = ?1;", ObjectID.StringValue)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE preset_modifiers SET label = ?2, pattern = ?3, mod_id = ?4 WHERE object_id = ?1;", ObjectID.StringValue, Label, Pattern, ModID.StringValue)
		      Else
		        Self.SQLExecute("INSERT INTO preset_modifiers (object_id, label, pattern, mod_id) VALUES (?1, ?2, ?3, ?4);", ObjectID.StringValue, Label, Pattern, ModID.StringValue)
		      End If
		    Next
		    
		    If ChangeDict.HasKey("help_topics") Then
		      Var HelpTopics() As Variant = ChangeDict.Value("help_topics")
		      For Each Dict As Dictionary In HelpTopics
		        Var ConfigName As String = Dict.Value("topic")
		        Var Title As String = Dict.Value("title")
		        Var Body As String = Dict.Value("body")
		        Var DetailURL As String
		        If Dict.Value("detail_url") <> Nil Then
		          DetailURL = Dict.Value("detail_url")
		        End If
		        
		        ConfigName = ConfigName.Lowercase
		        
		        Var Results As RowSet = Self.SQLSelect("SELECT config_name FROM config_help WHERE config_name = ?1;", ConfigName)
		        If Results.RowCount = 1 Then
		          Self.SQLExecute("UPDATE config_help SET title = ?2, body = ?3, detail_url = ?4 WHERE config_name = ?1;", ConfigName, Title, Body, DetailURL)
		        Else
		          Self.SQLExecute("INSERT INTO config_help (config_name, title, body, detail_url) VALUES (?1, ?2, ?3, ?4);", ConfigName, Title, Body, DetailURL)
		        End If
		      Next
		    End If
		    
		    If ChangeDict.HasKey("game_variables") Then
		      Var HelpTopics() As Variant = ChangeDict.Value("game_variables")
		      For Each Dict As Dictionary In HelpTopics
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
		    
		    // Restore Indexes
		    For Each Category As String In Categories
		      Self.SQLExecute("CREATE INDEX " + Category + "_class_string_idx ON " + Category + "(class_string);")
		      Self.SQLExecute("CREATE UNIQUE INDEX " + Category + "_path_idx ON " + Category + "(path);")
		    Next
		    Self.SQLExecute("CREATE INDEX loot_sources_sort_order_idx ON loot_sources(sort_order);")
		    Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_path_idx ON loot_sources(path);")
		    
		    Self.Variable("sync_time") = PayloadTimestamp.SQLDateTimeWithOffset
		    Self.Commit()
		    
		    If ReloadPresets Then
		      Self.LoadPresets()
		    End If
		    
		    Self.mDropsLabelCacheMask = 0
		    Self.mDropsLabelCacheDict = New Dictionary
		    Self.mSpawnLabelCacheMask = 0
		    Self.mSpawnLabelCacheDict = New Dictionary
		    Self.mBlueprintLabelsCacheKey = ""
		    Self.mBlueprintLabelsCacheDict = New Dictionary
		    
		    App.Log("Imported classes. Engrams date is " + PayloadTimestamp.SQLDateTimeWithOffset)
		    
		    If EngramsChanged Then
		      NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		    End If
		    
		    Self.mOfficialPlayerLevelData = Nil
		    
		    Return True
		  Catch Err As RuntimeException
		    Self.Rollback()
		    Return False
		  End Try
		  
		  Exception Err As RuntimeException
		    App.Log("Unhabdled exception in LocalData.Import: " + Err.Message)
		    Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportLocalClasses()
		  Var File As FolderItem = App.ResourcesFolder.Child("Complete.beacondata")
		  If File.Exists Then
		    Var Content As MemoryBlock = File.Read(Encodings.UTF8)
		    If Content <> Nil Then
		      Self.Import(Content)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportPreset(PresetContents As MemoryBlock) As Boolean
		  Var Contents As String = DefineEncoding(PresetContents, Encodings.UTF8)
		  Var Preset As Beacon.Preset
		  Var PresetID As String
		  Try
		    Var Dict As Dictionary = Beacon.ParseJSON(Contents)
		    Preset = Beacon.Preset.FromDictionary(Dict)
		    PresetID = Preset.PresetID
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Var Imported As Boolean
		  Self.BeginTransaction()
		  Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, PresetID)
		  If Results.RowCount = 1 Then
		    Try
		      Var RowsToChange As RowSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE user_id = ?1 AND object_id = ?2 AND label != ?3 AND contents != ?4;", Self.UserID, PresetID, Preset.Label, Contents)
		      If RowsToChange.RowCount > 0 Then
		        Self.SQLExecute("UPDATE custom_presets SET label = ?3, contents = ?4 WHERE user_id = ?1 AND object_id = ?2 AND label != ?3 AND contents != ?4;", Self.UserID, PresetID, Preset.Label, Contents)
		        Imported = True
		      End If
		    Catch Err As RuntimeException
		      Imported = False
		    End Try
		  Else
		    Self.SQLExecute("INSERT INTO custom_presets (user_id, object_id, label, contents) VALUES (?1, ?2, ?3, ?4);", Self.UserID, PresetID, Preset.Label, Contents)
		    Imported = True
		  End If
		  Self.Commit()
		  Return Imported
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, Preset.PresetID)
		  Return Results.RowCount = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastCommitTime() As Double
		  Return Self.mLastCommitTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastEditTime() As Double
		  Return Self.mLastCommitTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSync() As DateTime
		  Var LastSync As String = Self.Variable("sync_time")
		  If LastSync = "" Then
		    Return Nil
		  End If
		  
		  Return NewDateFromSQLDateTime(LastSync)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadDefaults(SpawnPoint As Beacon.MutableSpawnPoint)
		  If SpawnPoint Is Nil Then
		    Return
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT sets, limits FROM spawn_points WHERE object_id = ?1;", SpawnPoint.ObjectID)
		  If Rows.RowCount = 0 Then
		    Return
		  End If
		  
		  SpawnPoint.SetsString = Rows.Column("sets").StringValue
		  SpawnPoint.LimitsString = Rows.Column("limits").StringValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadIngredientsForEngram(Engram As Beacon.Engram) As Beacon.RecipeIngredient()
		  Var Ingredients() As Beacon.RecipeIngredient
		  If (Engram Is Nil) = False Then
		    Var Results As RowSet = Self.SQLSelect("SELECT recipe FROM engrams WHERE object_id = ?1;", Engram.ObjectID)
		    If Results.RowCount = 1 Then
		      Ingredients = Beacon.RecipeIngredient.FromVariant(Results.Column("recipe").Value, Nil)
		    End If
		  End If
		  Return Ingredients
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Self.mPresets.ResizeTo(-1)
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id = ?1;", Beacon.UserModID) // Loading the presets will refill all the needed custom modifiers
		  Self.SQLExecute("DELETE FROM custom_presets WHERE object_id != object_id AND object_id IN (SELECT object_id FROM custom_presets);") // To clean up object_id values that are not lowercase
		  Self.SQLExecute("UPDATE custom_presets SET object_id = object_id WHERE object_id != object_id;")
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM official_presets WHERE object_id NOT IN (SELECT object_id FROM custom_presets WHERE user_id = ?1)", Self.UserID), Beacon.Preset.Types.BuiltIn)
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE user_id = ?1 AND object_id IN (SELECT object_id FROM official_presets)", Self.UserID), Beacon.Preset.Types.CustomizedBuiltIn)
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE user_id = ?1 AND object_id NOT IN (SELECT object_id FROM official_presets)", Self.UserID), Beacon.Preset.Types.Custom)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadPresets(Results As RowSet, Type As Beacon.Preset.Types)
		  While Not Results.AfterLastRow
		    Var Dict As Dictionary = Beacon.ParseJSON(Results.Column("contents").StringValue)
		    Var Preset As Beacon.Preset = Beacon.Preset.FromDictionary(Dict)
		    If Preset <> Nil Then
		      If Type <> Beacon.Preset.Types.BuiltIn And Preset.PresetID <> Results.Column("object_id").StringValue Then
		        // To work around https://github.com/thommcgrath/Beacon/issues/64
		        Var Contents As String = Beacon.GenerateJSON(Preset.ToDictionary, False)
		        Self.BeginTransaction()
		        Self.SQLExecute("UPDATE custom_presets SET object_id = ?3, contents = ?4 WHERE user_id = ?1 AND object_id = ?2;", Self.UserID, Results.Column("object_id").StringValue, Preset.PresetID, Contents)
		        Self.Commit()
		      End If
		      
		      Preset.Type = Type
		      Self.mPresets.Add(Preset)
		    End If
		    Results.MoveToNextRow
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSourceLabels(Availability As UInt64) As Dictionary
		  If Self.mDropsLabelCacheMask <> Availability Then
		    Var Drops() As Beacon.LootSource = Self.SearchForLootSources("", New Beacon.StringList, True)
		    Var Labels() As String
		    Var Dict As New Dictionary
		    Labels.ResizeTo(Drops.LastIndex)
		    
		    For I As Integer = 0 To Drops.LastIndex
		      If Drops(I).ValidForMask(Availability) = False Then
		        Continue
		      End If
		      
		      Var Label As String = Drops(I).Label
		      Var Idx As Integer = Labels.IndexOf(Label)
		      Labels(I) = Label
		      If Idx > -1 Then
		        Var Filtered As UInt64 = Drops(Idx).Availability And Availability
		        Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Filtered)
		        Dict.Value(Drops(Idx).Path) = Drops(Idx).Label.Disambiguate(Maps.Label)
		        
		        Filtered = Drops(I).Availability And Availability
		        Maps = Beacon.Maps.ForMask(Filtered)
		        Label = Label.Disambiguate(Maps.Label)
		      End If
		      
		      Dict.Value(Drops(I).Path) = Label
		    Next
		    
		    Self.mDropsLabelCacheDict = Dict
		    Self.mDropsLabelCacheMask = Availability
		  End If
		  
		  Return Self.mDropsLabelCacheDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDeltaDownload_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Self.mDeltaDownloader = Nil
		  
		  If HTTPStatus < 200 Or HTTPStatus >= 300 Then
		    Self.mDeltaDownloadQueue.RemoveAll
		    App.Log("Failed to download blueprints delta: HTTP " + HTTPStatus.ToString(Locale.Raw, "0"))
		    Self.mCheckingForUpdates = False
		    Return
		  End If
		  
		  Self.Import(Content)
		  Self.AdvanceDeltaQueue()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDeltaDownload_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.mDeltaDownloader = Nil
		  Self.mDeltaDownloadQueue.RemoveAll
		  
		  App.Log("Failed to download blueprints delta: " + Err.Message)
		  Self.mCheckingForUpdates = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mDeltaDownload_ReceivingProgressed(Sender As URLConnection, BytesReceived As Int64, TotalBytes As Int64, NewData As String)
		  #Pragma Unused Sender
		  #Pragma Unused TotalBytes
		  #Pragma Unused NewData
		  
		  Self.mDeltaDownloadedBytes = Self.mDeltaDownloadedBytes + CType(BytesReceived, UInt64)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImportThread_Run(Sender As Thread)
		  #Pragma Unused Sender
		  
		  If Self.mPendingImports.LastIndex = -1 Then
		    Self.mImporting = False
		    Return
		  End If
		  
		  NotificationKit.Post(Self.Notification_ImportStarted, Nil)
		  
		  Var SyncOriginal As DateTime = Self.LastSync
		  Var Success As Boolean
		  While Self.mPendingImports.Count > 0
		    Var Content As String = Self.mPendingImports(0)
		    Self.mPendingImports.RemoveAt(0)
		    
		    Success = Self.ImportInner(Content) Or Success
		  Wend
		  Self.mImporting = False
		  Var SyncNew As DateTime = Self.LastSync
		  
		  If SyncOriginal <> SyncNew Then
		    NotificationKit.Post(Self.Notification_DatabaseUpdated, SyncNew)
		  End If
		  
		  If Success Then
		    NotificationKit.Post(Self.Notification_ImportSuccess, SyncNew)
		  Else
		    NotificationKit.Post(Self.Notification_ImportFailed, SyncNew)
		  End If
		  
		  If Self.mCheckForUpdatesAfterImport Then
		    Self.mCheckForUpdatesAfterImport = False
		    Self.CheckForEngramUpdates()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    App.Log("Blueprint update returned HTTP " + HTTPStatus.ToString(Locale.Raw, "0"))
		    Self.mCheckingForUpdates = False
		    Return
		  End If
		  
		  Try
		    Var Parsed As Variant = Beacon.ParseJSON(Content)
		    If Parsed Is Nil Or (Parsed IsA Dictionary) = False Then
		      App.Log("No blueprint updates available.")
		      Self.mCheckingForUpdates = False
		      Return
		    End If
		    
		    Var Dict As Dictionary = Parsed
		    If Not Dict.HasAllKeys("total_size", "files") Then
		      App.Log("Blueprint update is missing keys.")
		      Self.mCheckingForUpdates = False
		      Return
		    End If
		    
		    Self.mDeltaDownloadedBytes = 0
		    Self.mDeltaDownloadTotalBytes = Dict.Value("total_size")
		    
		    Var Files() As Object = Dict.Value("files")
		    For Each FileInfo As Object In Files
		      Var UpdateURL As String = Dictionary(FileInfo).Lookup("url", "")
		      If UpdateURL.IsEmpty Then
		        Continue
		      End If
		      
		      Self.mDeltaDownloadQueue.Add(UpdateURL)
		    Next
		    
		    If Self.mDeltaDownloadQueue.Count = 0 Then
		      App.Log("No blueprint updates available.")
		      Self.mCheckingForUpdates = False
		      Return
		    End If
		    
		    Self.AdvanceDeltaQueue
		  Catch Err As RuntimeException
		    App.Log("Unable to parse blueprint delta JSON: " + Err.Message)
		    Self.mCheckingForUpdates = False
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_Error(Sender As URLConnection, Error As RuntimeException)
		  #Pragma Unused Sender
		  
		  App.Log("Blueprint check error: " + Error.Reason)
		  Self.mCheckingForUpdates = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case UserCloud.Notification_SyncFinished
		    If Self.mNextSyncImportAll Then
		      Self.mNextSyncImportAll = False
		      Self.ImportCloudFiles()
		    Else
		      Var Actions() As Dictionary = Notification.UserData
		      Self.ImportCloudFiles(Actions)
		    End If
		  Case IdentityManager.Notification_IdentityChanged
		    Self.mNextSyncImportAll = True
		    Self.SyncUserEngrams()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OfficialPlayerLevelData() As Beacon.PlayerLevelData
		  If Self.mOfficialPlayerLevelData = Nil Then
		    Self.mOfficialPlayerLevelData = Beacon.PlayerLevelData.FromString(Self.GetStringVariable("Player Leveling"))
		  End If
		  Return Self.mOfficialPlayerLevelData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  Var Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.Add(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
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
		Private Sub Rollback()
		  If Self.mTransactions.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.RemoveAt(0)
		  
		  If Savepoint = "" Then
		    Self.SQLExecute("ROLLBACK TRANSACTION;")
		  Else
		    Self.SQLExecute("ROLLBACK TRANSACTION TO SAVEPOINT " + Savepoint + ";")
		    Self.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToCreature(Results As RowSet) As Beacon.Creature()
		  Var Creatures() As Beacon.Creature
		  While Not Results.AfterLastRow
		    Var CreatureID As String = Results.Column("object_id").StringValue
		    If Self.mCreatureCache.HasKey(CreatureID) = False Then
		      Var Creature As New Beacon.MutableCreature(Results.Column("path").StringValue, CreatureID)
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
		Private Function RowSetToEngram(Results As RowSet) As Beacon.Engram()
		  Var Engrams() As Beacon.Engram
		  While Not Results.AfterLastRow
		    Var EngramID As String = Results.Column("object_id").StringValue
		    If Self.mEngramCache.HasKey(EngramID) = False Then
		      Var Engram As New Beacon.MutableEngram(Results.Column("path").StringValue, EngramID)
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
		Private Function RowSetToLootSource(Results As RowSet) As Beacon.LootSource()
		  Var Sources() As Beacon.LootSource
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
		    
		    Var Source As New Beacon.CustomLootContainer(Results.Column("class_string").StringValue)
		    Source.Label = Results.Column("label").StringValue
		    Source.Path = Results.Column("path").StringValue
		    Source.Availability = Results.Column("availability").Value
		    Source.Multipliers = New Beacon.Range(Results.Column("multiplier_min").DoubleValue, Results.Column("multiplier_max").DoubleValue)
		    Source.UIColor = Color.RGB(Integer.FromHex(RedHex), Integer.FromHex(GreenHex), Integer.FromHex(BlueHex), Integer.FromHex(AlphaHex))
		    Source.SortValue = Results.Column("sort_order").IntegerValue
		    Source.Experimental = Results.Column("experimental").BooleanValue
		    Source.Notes = Results.Column("notes").StringValue
		    
		    If Requirements.HasKey("mandatory_item_sets") Then
		      Var SetDicts() As Variant = Requirements.Value("mandatory_item_sets")
		      Var Sets() As Beacon.ItemSet
		      For Each Dict As Dictionary In SetDicts
		        Var Set As Beacon.ItemSet = Beacon.ItemSet.FromSaveData(Dict)
		        If Set <> Nil Then
		          Sets.Add(Set)
		        End If
		      Next
		      Source.MandatoryItemSets = Sets
		    End If
		    
		    If Requirements.HasKey("min_item_sets") And IsNull(Requirements.Value("min_item_sets")) = False Then
		      Source.RequiredItemSetCount = Requirements.Value("min_item_sets")
		    End If
		    
		    Sources.Add(New Beacon.LootContainer(Source))
		    Results.MoveToNextRow
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToSpawnPoint(Results As RowSet) As Beacon.SpawnPoint()
		  Var SpawnPoints() As Beacon.SpawnPoint
		  While Not Results.AfterLastRow
		    Var PointID As String = Results.Column("object_id").StringValue
		    If Self.mSpawnPointCache.HasKey(PointID) = False Then
		      Var Point As New Beacon.MutableSpawnPoint(Results.Column("path").StringValue, PointID)
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
		Function SaveBlueprints(Blueprints() As Beacon.Blueprint, Replace As Boolean = True) As Integer
		  Var CountSaved As Integer
		  
		  Self.BeginTransaction()
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    Try
		      Var Update As Boolean
		      Var ObjectID As String
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id, mod_id FROM blueprints WHERE object_id = ?1 OR (mod_id = ?2 AND path = ?3);", Blueprint.ObjectID, Beacon.UserModID, Blueprint.Path)
		      Var CacheDict As Dictionary
		      If Results.RowCount = 1 Then
		        ObjectID = Results.Column("object_id").StringValue
		        
		        If Replace = False Or ObjectID <> Blueprint.ObjectID Then
		          Continue
		        End If
		        
		        Var ModID As String = Results.Column("mod_id").StringValue
		        If ModID <> Beacon.UserModID Then
		          Continue
		        End If
		        
		        Update = True
		      ElseIf Results.RowCount > 1 Then
		        // What the hell?
		        Continue
		      Else
		        Update = False
		        ObjectID = Blueprint.ObjectID
		      End If
		      
		      If Blueprint.Path.IsEmpty Or Blueprint.ClassString.IsEmpty Then
		        Continue
		      End If
		      
		      Var Category As String = Blueprint.Category
		      Var Columns As New Dictionary
		      Columns.Value("object_id") = ObjectID
		      Columns.Value("path") = Blueprint.Path
		      Columns.Value("class_string") = Blueprint.ClassString
		      Columns.Value("label") = Blueprint.Label
		      Columns.Value("tags") = Blueprint.TagString
		      Columns.Value("availability") = Blueprint.Availability
		      Columns.Value("mod_id") = Beacon.UserModID
		      
		      Select Case Blueprint
		      Case IsA Beacon.Creature
		        Var Creature As Beacon.Creature = Beacon.Creature(Blueprint)
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
		        Var StatValues() As Beacon.CreatureStatValue = Creature.AllStatValues
		        For Each StatValue As Beacon.CreatureStatValue In StatValues
		          StatDicts.Add(StatValue.SaveData)
		        Next
		        Columns.Value("stats") = Beacon.GenerateJSON(StatDicts, False)
		        
		        CacheDict = Self.mCreatureCache
		      Case IsA Beacon.SpawnPoint
		        Columns.Value("sets") = Beacon.SpawnPoint(Blueprint).SetsString(False)
		        Columns.Value("limits") = Beacon.SpawnPoint(Blueprint).LimitsString(False)
		        CacheDict = Self.mSpawnPointCache
		      Case IsA Beacon.Engram
		        Var Engram As Beacon.Engram = Beacon.Engram(Blueprint)
		        Columns.Value("recipe") = Beacon.RecipeIngredient.ToJSON(Engram.Recipe, False)
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
		        CacheDict = Self.mEngramCache
		      End Select
		      
		      If Update Then
		        Var Assignments() As String
		        Var Values() As Variant
		        Var NextPlaceholder As Integer = 1
		        Var WhereClause As String
		        For Each Entry As DictionaryEntry In Columns
		          If Entry.Key = "object_id" Then
		            WhereClause = "object_id = ?" + NextPlaceholder.ToString
		          Else
		            Assignments.Add(Entry.Key.StringValue + " = ?" + NextPlaceholder.ToString)
		          End If
		          Values.Add(Entry.Value)
		          NextPlaceholder = NextPlaceholder + 1
		        Next
		        
		        Self.SQLExecute("UPDATE " + Category + " SET " + Assignments.Join(", ") + " WHERE " + WhereClause + ";", Values)
		        Self.SQLExecute("UPDATE searchable_tags SET tags = ?3 WHERE object_id = ?2 AND source_table = ?1;", Category, ObjectID, Blueprint.TagString)
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
		        Self.SQLExecute("INSERT INTO searchable_tags (source_table, object_id, tags) VALUES (?1, ?2, ?3);", Category, ObjectID, Blueprint.TagString)
		      End If
		      
		      If CacheDict <> Nil Then
		        If CacheDict.HasKey(Blueprint.ObjectID) Then
		          CacheDict.Remove(Blueprint.ObjectID)
		        End If
		        If CacheDict.HasKey(Blueprint.Path) Then
		          CacheDict.Remove(Blueprint.Path)
		        End If
		        If CacheDict.HasKey(Blueprint.ClassString) Then
		          CacheDict.Remove(Blueprint.ClassString)
		        End If
		        If Blueprint IsA Beacon.Engram And Beacon.Engram(Blueprint).HasUnlockDetails And CacheDict.HasKey(Beacon.Engram(Blueprint).EntryString) Then
		          CacheDict.Remove(Beacon.Engram(Blueprint).EntryString)
		        End If
		      End If
		      
		      CountSaved = CountSaved + 1
		    Catch Err As RuntimeException
		      Self.Rollback()
		      Return 0
		    End Try
		  Next
		  Self.Commit()
		  
		  If CountSaved > 0 Then
		    Self.SyncUserEngrams()
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  End If
		  
		  Return CountSaved
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  Self.SavePreset(Preset, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SavePreset(Preset As Beacon.Preset, Reload As Boolean)
		  Var Content As String = Beacon.GenerateJSON(Preset.ToDictionary, False)
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("INSERT OR REPLACE INTO custom_presets (user_id, object_id, label, contents) VALUES (?1, ?2, ?3, ?4);", Self.UserID, Preset.PresetID, Preset.Label, Content)
		  Self.Commit()
		  
		  Call UserCloud.Write("/Presets/" + Preset.PresetID.Lowercase + BeaconFileTypes.BeaconPreset.PrimaryExtension, Content)
		  
		  If Reload Then
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String) As Beacon.Blueprint()
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  Return Self.SearchForBlueprints(Category, SearchText, Mods, Tags, ExtraClauses, ExtraValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String, ExtraClauses() As String, ExtraValues() As Variant) As Beacon.Blueprint()
		  Var Blueprints() As Beacon.Blueprint
		  
		  Try
		    Var NextPlaceholder As Integer = 1
		    Var Clauses() As String
		    Var Values As New Dictionary
		    If SearchText <> "" Then
		      Clauses.Add("label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " OR (alternate_label IS NOT NULL AND alternate_label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + ") OR class_string LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		      Values.Value(NextPlaceholder) = "%" + SearchText + "%"
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    
		    Var SQL As String
		    Select Case Category
		    Case Beacon.CategoryEngrams
		      SQL = Self.EngramSelectSQL
		    Case Beacon.CategoryCreatures
		      SQL = Self.CreatureSelectSQL
		    Case Beacon.CategorySpawnPoints
		      SQL = Self.SpawnPointSelectSQL
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
		    If Values.KeyCount = 0 Then
		      Results = Self.SQLSelect(SQL)
		    Else
		      Results = Self.SQLSelect(SQL, Values)
		    End If
		    
		    Select Case Category
		    Case Beacon.CategoryEngrams
		      Var Engrams() As Beacon.Engram = Self.RowSetToEngram(Results)
		      For Each Engram As Beacon.Engram In Engrams
		        Self.Cache(Engram)
		        Blueprints.Add(Engram)
		      Next
		    Case Beacon.CategoryCreatures
		      Var Creatures() As Beacon.Creature = Self.RowSetToCreature(Results)
		      For Each Creature As Beacon.Creature In Creatures
		        Self.mCreatureCache.Value(Creature.Path) = Creature
		        Blueprints.Add(Creature)
		      Next
		    Case Beacon.CategorySpawnPoints
		      Var SpawnPoints() As Beacon.SpawnPoint = Self.RowSetToSpawnPoint(Results)
		      For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		        Self.mSpawnPointCache.Value(SpawnPoint.Path) = SpawnPoint
		        Blueprints.Add(SpawnPoint)
		      Next
		    End Select
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForConfigKey(File As String, Header As String, Key As String) As Beacon.ConfigKey()
		  Var Clauses() As String
		  Var Values As New Dictionary
		  Var Idx As Integer = 1
		  
		  If File.IsEmpty = False Then
		    Values.Value(Idx) = File
		    Clauses.Add("file = ?" + Idx.ToString)
		    Idx = Idx + 1
		  End If
		  If Header.IsEmpty = False Then
		    Values.Value(Idx) = Header
		    Clauses.Add("header = ?" + Idx.ToString)
		    Idx = Idx + 1
		  End If
		  If Key.IsEmpty = False Then
		    If Key.IndexOf("*") > -1 Then
		      Values.Value(Idx) = Key.ReplaceAll("*", "%")
		      Clauses.Add("key LIKE ?" + Idx.ToString)
		    Else
		      Values.Value(Idx) = Key
		      Clauses.Add("key = ?" + Idx.ToString)
		    End If
		    Idx = Idx + 1
		  End If
		  
		  Var SQL As String = "SELECT object_id, label, file, header, key, value_type, max_allowed, description, default_value, nitrado_path, nitrado_format FROM ini_options"
		  If Clauses.Count > 0 Then
		    SQL = SQL + " WHERE " + Clauses.Join(" AND ")
		  End If
		  SQL = SQL + " ORDER BY label"
		  
		  Var Results() As Beacon.ConfigKey
		  Try
		    Var Rows As RowSet = Self.SQLSelect(SQL, Values)
		    While Not Rows.AfterLastRow
		      Var ObjectID As v4UUID = Rows.Column("object_id").StringValue
		      Var Label As String = Rows.Column("label").StringValue
		      Var ConfigFile As String = Rows.Column("file").StringValue
		      Var ConfigHeader As String = Rows.Column("header").StringValue
		      Var ConfigKey As String = Rows.Column("key").StringValue
		      Var ValueType As Beacon.ConfigKey.ValueTypes
		      Select Case Rows.Column("value_type").StringValue
		      Case "Numeric"
		        ValueType = Beacon.ConfigKey.ValueTypes.TypeNumeric
		      Case "Array"
		        ValueType = Beacon.ConfigKey.ValueTypes.TypeArray
		      Case "Structure"
		        ValueType = Beacon.ConfigKey.ValueTypes.TypeStructure
		      Case "Boolean"
		        ValueType = Beacon.ConfigKey.ValueTypes.TypeBoolean
		      Case "Text"
		        ValueType = Beacon.ConfigKey.ValueTypes.TypeText
		      End Select
		      Var MaxAllowed As NullableDouble
		      If IsNull(Rows.Column("max_allowed").Value) = False Then
		        MaxAllowed = Rows.Column("max_allowed").IntegerValue
		      End If
		      Var Description As String = Rows.Column("description").StringValue
		      Var DefaultValue As Variant = Rows.Column("default_value").Value
		      Var NitradoPath As NullableString
		      Var NitradoFormat As Beacon.ConfigKey.NitradoFormats = Beacon.ConfigKey.NitradoFormats.Unsupported
		      If IsNull(Rows.Column("nitrado_format").Value) = False Then
		        NitradoPath = Rows.Column("nitrado_path").StringValue
		        Select Case Rows.Column("nitrado_format").StringValue
		        Case "Line"
		          NitradoFormat = Beacon.ConfigKey.NitradoFormats.Line
		        Case "Value"
		          NitradoFormat = Beacon.ConfigKey.NitradoFormats.Value
		        End Select
		      End If
		      
		      Results.Add(New Beacon.ConfigKey(ObjectID, Label, ConfigFile, ConfigHeader, ConfigKey, ValueType, MaxAllowed, Description, DefaultValue, NitradoPath, NitradoFormat))
		      
		      Rows.MoveToNextRow
		    Wend
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		  End Try
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngramEntries(SearchText As String, Mods As Beacon.StringList, Tags As String) As Beacon.Engram()
		  Var ExtraClauses() As String = Array("entry_string IS NOT NULL")
		  Var ExtraValues(0) As Variant
		  Var Blueprints() As Beacon.Blueprint = Self.SearchForBlueprints(Beacon.CategoryEngrams, SearchText, Mods, Tags, ExtraClauses, ExtraValues)
		  Var Engrams() As Beacon.Engram
		  For Each Blueprint As Beacon.Blueprint In Blueprints
		    If Blueprint IsA Beacon.Engram Then
		      Engrams.Add(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As String, Mods As Beacon.StringList, IncludeExperimental As Boolean) As Beacon.LootSource()
		  // Part of the Beacon.DataSource interface.
		  
		  Var Sources() As Beacon.LootSource
		  
		  Try
		    Var Clauses() As String
		    Var Values As New Dictionary
		    Var NextPlaceholder As Integer = 1
		    If Mods.LastRowIndex > -1 Then
		      Var Placeholders() As String
		      For Each ModID As String In Mods
		        Placeholders.Add("?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		        Values.Value(NextPlaceholder) = ModID
		        NextPlaceholder = NextPlaceholder + 1
		      Next
		      Clauses.Add("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		    End If
		    If SearchText <> "" Then
		      Clauses.Add("label LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0") + " OR class_string LIKE ?" + NextPlaceholder.ToString(Locale.Raw, "0"))
		      Values.Value(NextPlaceholder) = "%" + SearchText + "%"
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    If Not IncludeExperimental Then
		      Clauses.Add("experimental = 0")
		    End If
		    
		    Var SQL As String = "SELECT " + Self.LootSourcesSelectColumns + ", mods.mod_id, mods.name AS mod_name FROM loot_sources INNER JOIN mods ON (loot_sources.mod_id = mods.mod_id)"
		    If Clauses.LastIndex > -1 Then
		      SQL = SQL + " WHERE (" + Clauses.Join(") AND (") + ")"
		    End If
		    SQL = SQL + " ORDER BY sort_order, label;"
		    
		    Var Results As RowSet
		    If Values.KeyCount > 0 Then
		      Results = Self.SQLSelect(SQL, Values)
		    Else
		      Results = Self.SQLSelect(SQL)
		    End If
		    
		    Sources = Self.RowSetToLootSource(Results)
		  Catch Err As RuntimeException
		    
		  End Try
		  
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance(Create As Boolean = True) As LocalData
		  If mInstance = Nil And Create = True Then
		    mInstance = New LocalData
		    Beacon.Data = mInstance
		    Var Results As RowSet = mInstance.SQLSelect("SELECT EXISTS(SELECT 1 FROM blueprints) AS populated;")
		    If Results.Column("populated").BooleanValue = False Then
		      mInstance.mNextSyncImportAll = True
		      mInstance.ImportLocalClasses()
		    End If
		    If Preferences.OnlineEnabled Then
		      mInstance.CheckForEngramUpdates()
		    End If
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointLabels(Availability As UInt64) As Dictionary
		  If Self.mSpawnLabelCacheMask <> Availability Then
		    Var Points() As Beacon.SpawnPoint = Self.SearchForSpawnPoints("", New Beacon.StringList)
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
		        Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Filtered)
		        Dict.Value(Points(Idx).ObjectID) = Points(Idx).Label.Disambiguate(Maps.Label)
		        
		        Filtered = Points(I).Availability And Availability
		        Maps = Beacon.Maps.ForMask(Filtered)
		        Label = Label.Disambiguate(Maps.Label)
		      End If
		      
		      Dict.Value(Points(I).ObjectID) = Label
		    Next
		    
		    Self.mSpawnLabelCacheDict = Dict
		    Self.mSpawnLabelCacheMask = Availability
		  End If
		  
		  Return Self.mSpawnLabelCacheDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(SQLString As String, ParamArray Values() As Variant)
		  Self.mLock.Enter
		  
		  If Values.LastIndex = 0 And Values(0) <> Nil And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Var Dict As Dictionary = Values(0)
		    Values.ResizeTo(-1)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.KeyCount
		        Values.Add(Dict.Value(I))
		      Next
		    Catch Err As TypeMismatchException
		      Values.ResizeTo(-1)
		    End Try
		  ElseIf Values.LastIndex = 0 And Values(0).IsArray Then
		    Values = Values(0)
		  End If
		  
		  For I As Integer = 0 To Values.LastIndex
		    Var Value As Variant = Values(I)
		    If Value.Type <> Variant.TypeObject Then
		      Continue
		    End If
		    Select Case Value.ObjectValue
		    Case IsA MemoryBlock
		      Var Mem As MemoryBlock = Value
		      Values(I) = Mem.StringValue(0, Mem.Size)
		    End Select
		  Next
		  
		  Try
		    Self.mBase.ExecuteSQL(SQLString, Values)
		    Self.mLock.Leave
		  Catch Err As DatabaseException
		    Self.mLock.Leave
		    Var Cloned As New UnsupportedOperationException
		    Cloned.Message = Err.Message + EndOfLine + SQLString
		    Raise Cloned
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(SQLString As String, ParamArray Values() As Variant) As RowSet
		  Self.mLock.Enter
		  
		  If Values.LastIndex = 0 And Values(0) <> Nil And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Var Dict As Dictionary = Values(0)
		    Values.ResizeTo(-1)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.KeyCount
		        Values.Add(Dict.Value(I))
		      Next
		    Catch Err As TypeMismatchException
		      Values.ResizeTo(-1)
		    End Try
		  End If
		  
		  For I As Integer = 0 To Values.LastIndex
		    Var Value As Variant = Values(I)
		    If Value.Type <> Variant.TypeObject Then
		      Continue
		    End If
		    Select Case Value.ObjectValue
		    Case IsA MemoryBlock
		      Var Mem As MemoryBlock = Value
		      Values(I) = Mem.StringValue(0, Mem.Size)
		    End Select
		  Next
		  
		  Try
		    Var Results As RowSet = Self.mBase.SelectSQL(SQLString, Values)
		    Self.mLock.Leave
		    Return Results
		  Catch Err As DatabaseException
		    Self.mLock.Leave
		    Var Cloned As New UnsupportedOperationException
		    Cloned.Message = Err.Message + EndOfLine + SQLString
		    Raise Cloned
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Start()
		  Call SharedInstance(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncUserEngrams()
		  // This way changing lots of engrams rapidly won't require a write to disk
		  // after each action
		  
		  If Self.mSyncUserEngramsKey <> "" Then
		    CallLater.Cancel(Self.mSyncUserEngramsKey)
		    Self.mSyncUserEngramsKey = ""
		  End If
		  
		  Self.mSyncUserEngramsKey = CallLater.Schedule(250, AddressOf SyncUserEngramsActual)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncUserEngramsActual()
		  Var Mods As New Beacon.StringList(Beacon.UserModID)
		  Var Packed() As Dictionary
		  
		  Var Engrams() As Beacon.Engram = Self.SearchForEngrams("", Mods, "")
		  For Each Engram As Beacon.Engram In Engrams
		    Var Dict As Dictionary = Engram.Pack
		    If Dict Is Nil Then
		      Continue
		    End If
		    
		    Packed.Add(Dict)
		  Next
		  
		  Var Creatures() As Beacon.Creature = Self.SearchForCreatures("", Mods, "")
		  For Each Creature As Beacon.Creature In Creatures
		    Var Dict As Dictionary = Creature.Pack
		    If Dict Is Nil Then
		      Continue
		    End If
		    
		    Packed.Add(Dict)
		  Next
		  
		  Var SpawnPoints() As Beacon.SpawnPoint = Self.SearchForSpawnPoints("", Mods, "")
		  For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		    Var Dict As Dictionary = SpawnPoint.Pack
		    If Dict Is Nil Then
		      Continue
		    End If
		    
		    Packed.Add(Dict)
		  Next
		  
		  If Packed.Count > 0 Then
		    Var Content As String = Beacon.GenerateJSON(Packed, True)
		    Call UserCloud.Write("Blueprints.json", Content)
		  Else
		    Call UserCloud.Delete("Blueprints.json")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateNews()
		  Var Socket As New URLConnection
		  AddHandler Socket.ContentReceived, WeakAddressOf UpdateNews_ContentReceived
		  Socket.RequestHeader("User-Agent") = App.UserAgent
		  Socket.Send("GET", Beacon.WebURL("/news?stage=" + App.StageCode.ToString))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateNews_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  
		  If HTTPStatus <> 200 Then
		    Return
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Items() As Dictionary
		  Try
		    Items = Parsed.DictionaryArrayValue
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Self.BeginTransaction()
		  
		  Var Changed As Boolean
		  Var Rows As RowSet = Self.SQLSelect("SELECT uuid FROM news")
		  Var ItemsToRemove() As String
		  For Each Row As DatabaseRow In Rows
		    ItemsToRemove.Add(Row.Column("uuid").StringValue)
		  Next
		  
		  For Each Item As Dictionary In Items
		    Try
		      Var UUID As String = Item.Value("uuid")
		      Var Title As String = Item.Value("title")
		      Var Detail As Variant = Item.Value("detail")
		      Var ItemURL As Variant = Item.Value("url")
		      Var MinVersion As Variant = Item.Value("min_version")
		      Var MaxVersion As Variant = Item.Value("max_version")
		      Var Moment As String = Item.Value("timestamp")
		      Var MinOSVersion As Variant
		      #if TargetMacOS
		        MinOSVersion = Item.Value("mac_min_os")
		      #elseif TargetWindows
		        MinOSVersion = Item.Value("win_min_os")
		      #endif
		      
		      Var Idx As Integer = ItemsToRemove.IndexOf(UUID)
		      If Idx > -1 Then
		        ItemsToRemove.RemoveAt(Idx)
		      Else
		        Self.SQLExecute("INSERT INTO news (uuid, title, detail, url, min_version, max_version, moment, min_os_version) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8);", UUID, Title, Detail, ItemURL, MinVersion, MaxVersion, Moment, MinOSVersion)
		        Changed = True
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Changed = Changed Or ItemsToRemove.Count > 0
		  
		  If ItemsToRemove.Count > 0 Then
		    Self.SQLExecute("DELETE FROM news WHERE uuid IN ('" + ItemsToRemove.Join("','") + "');")
		  End If
		  
		  Self.Commit()
		  
		  If Changed Then
		    NotificationKit.Post(Self.Notification_NewsUpdated, Nil)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UserID() As String
		  Try
		    Return App.IdentityManager.CurrentIdentity.UserID
		  Catch Err As RuntimeException
		    Return v4UUID.CreateNull
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variable(Key As String) As String
		  Try
		    Var Results As RowSet = Self.SQLSelect("SELECT value FROM variables WHERE key = ?1;", Key)
		    If Results.RowCount = 1 Then
		      Return Results.Column("value").StringValue
		    End If
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Variable(Key As String, Assigns Value As String)
		  Try
		    Self.BeginTransaction()
		    Self.SQLExecute("INSERT OR REPLACE INTO variables (key, value) VALUES (?1, ?2);", Key, Value)
		    Self.Commit()
		  Catch Err As RuntimeException
		    Self.Rollback()
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared IconCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBase As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlueprintLabelsCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlueprintLabelsCacheKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckForUpdatesAfterImport As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCheckingForUpdates As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatureCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeltaDownloadedBytes As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeltaDownloader As URLConnection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeltaDownloadQueue() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDeltaDownloadTotalBytes As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDropsLabelCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDropsLabelCacheMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As LocalData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCommitTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNextSyncImportAll As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOfficialPlayerLevelData As Beacon.PlayerLevelData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingImports() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnLabelCacheDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnLabelCacheMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpawnPointCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSyncUserEngramsKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdater As URLConnection
	#tag EndProperty


	#tag Constant, Name = CreatureSelectSQL, Type = String, Dynamic = False, Default = \"SELECT creatures.object_id\x2C creatures.path\x2C creatures.label\x2C creatures.alternate_label\x2C creatures.availability\x2C creatures.tags\x2C creatures.incubation_time\x2C creatures.mature_time\x2C creatures.stats\x2C creatures.mating_interval_min\x2C creatures.mating_interval_max\x2C creatures.used_stats\x2C mods.mod_id\x2C mods.name AS mod_name FROM creatures INNER JOIN mods ON (creatures.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EngramSelectSQL, Type = String, Dynamic = False, Default = \"SELECT engrams.object_id\x2C engrams.path\x2C engrams.label\x2C engrams.alternate_label\x2C engrams.availability\x2C engrams.tags\x2C engrams.entry_string\x2C engrams.required_level\x2C engrams.required_points\x2C engrams.stack_size\x2C engrams.item_id\x2C mods.mod_id\x2C mods.name AS mod_name FROM engrams INNER JOIN mods ON (engrams.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = EngramsVersion, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LootSourcesSelectColumns, Type = String, Dynamic = False, Default = \"path\x2C class_string\x2C label\x2C alternate_label\x2C availability\x2C multiplier_min\x2C multiplier_max\x2C uicolor\x2C sort_order\x2C experimental\x2C notes\x2C requirements", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_DatabaseUpdated, Type = String, Dynamic = False, Default = \"Database Updated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_EngramsChanged, Type = String, Dynamic = False, Default = \"Engrams Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportFailed, Type = String, Dynamic = False, Default = \"Import Failed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportStarted, Type = String, Dynamic = False, Default = \"Import Started", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportSuccess, Type = String, Dynamic = False, Default = \"Import Success", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_NewsUpdated, Type = String, Dynamic = False, Default = \"News Updated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_PresetsChanged, Type = String, Dynamic = False, Default = \"Presets Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SchemaVersion, Type = Double, Dynamic = False, Default = \"19", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SpawnPointSelectSQL, Type = String, Dynamic = False, Default = \"SELECT spawn_points.object_id\x2C spawn_points.path\x2C spawn_points.label\x2C spawn_points.alternate_label\x2C spawn_points.availability\x2C spawn_points.tags\x2C mods.mod_id\x2C mods.name AS mod_name FROM spawn_points INNER JOIN mods ON (spawn_points.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
