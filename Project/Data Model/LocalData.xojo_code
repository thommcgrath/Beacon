#tag Class
Protected Class LocalData
Implements Beacon.DataSource
	#tag Method, Flags = &h0
		Sub AddPresetModifier(Modifier As Beacon.PresetModifier)
		  Self.BeginTransaction()
		  Dim Results As RecordSet = Self.SQLSelect("SELECT mod_id FROM preset_modifiers WHERE object_id = ?1;", Modifier.ModifierID)
		  If Results.RecordCount = 1 Then
		    If Results.Field("mod_id").StringValue = Self.UserModID Then
		      Self.SQLExecute("UPDATE preset_modifiers SET label = ?2, pattern = ?3 WHERE object_id = ?1;", Modifier.ModifierID, Modifier.Label, Modifier.Pattern)
		    End If
		  Else
		    Self.SQLExecute("INSERT INTO preset_modifiers (object_id, mod_id, label, pattern) VALUES (?1, ?2, ?3, ?4);", Modifier.ModifierID, Self.UserModID, Modifier.Label, Modifier.Pattern)
		  End If
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllPresetModifiers() As Beacon.PresetModifier()
		  Dim Results As RecordSet = Self.SQLSelect("SELECT object_id, label, pattern FROM preset_modifiers ORDER BY label;")
		  Dim Modifiers() As Beacon.PresetModifier
		  While Not Results.EOF
		    Dim Dict As New Xojo.Core.Dictionary
		    Dict.Value("ModifierID") = Results.Field("object_id").StringValue.ToText
		    Dict.Value("Pattern") = Results.Field("pattern").StringValue.ToText
		    Dict.Value("Label") = Results.Field("label").StringValue.ToText
		    
		    Dim Modifier As Beacon.PresetModifier = Beacon.PresetModifier.FromDictionary(Dict)
		    If Modifier <> Nil Then
		      Modifiers.Append(Modifier)
		    End If
		    
		    Results.MoveNext
		  Wend
		  Return Modifiers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllTags() As String()
		  Dim Results As RecordSet = Self.SQLSelect("SELECT DISTINCT tags FROM engrams WHERE tags != '';")
		  Dim Dict As New Dictionary
		  While Not Results.EOF
		    Dim Tags() As String = Results.Field("tags").StringValue.Split(",")
		    For Each Tag As String In Tags
		      Dict.Value(Tag) = True
		    Next
		    Results.MoveNext
		  Wend
		  
		  Dim Keys() As Variant = Dict.Keys
		  Dim Tags() As String
		  For Each Key As String In Keys
		    Tags.Append(Key)
		  Next
		  Tags.Sort
		  
		  Return Tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginTransaction()
		  Self.mLock.Enter
		  
		  If UBound(Self.mTransactions) = -1 Then
		    Self.mTransactions.Insert(0, "")
		    Self.SQLExecute("BEGIN TRANSACTION;")
		  Else
		    Dim Savepoint As String = "Savepoint_" + EncodeHex(Crypto.GenerateRandomBytes(4))
		    Self.mTransactions.Insert(0, Savepoint)
		    Self.SQLExecute("SAVEPOINT " + Savepoint + ";")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildSchema()
		  Self.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("CREATE TABLE variables (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE mods (mod_id TEXT NOT NULL PRIMARY KEY, name TEXT NOT NULL, console_safe INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_source_icons (icon_id TEXT NOT NULL PRIMARY KEY, icon_data BLOB NOT NULL);")
		  Self.SQLExecute("CREATE TABLE loot_sources (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE CASCADE, label TEXT NOT NULL, availability INTEGER NOT NULL, path TEXT NOT NULL, class_string TEXT NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT NOT NULL, sort_order INTEGER NOT NULL, icon TEXT NOT NULL REFERENCES loot_source_icons(icon_id) ON UPDATE CASCADE ON DELETE RESTRICT, experimental BOOLEAN NOT NULL, notes TEXT NOT NULL, requirements TEXT NOT NULL DEFAULT '{}');")
		  Self.SQLExecute("CREATE TABLE engrams (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE CASCADE, label TEXT NOT NULL, availability INTEGER NOT NULL, path TEXT NOT NULL, class_string TEXT NOT NULL, tags TEXT NOT NULL DEFAULT '');")
		  Self.SQLExecute("CREATE TABLE official_presets (object_id TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, contents TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_presets (object_id TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, contents TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE preset_modifiers (object_id TEXT NOT NULL PRIMARY KEY, mod_id TEXT NOT NULL REFERENCES mods(mod_id) ON DELETE CASCADE, label TEXT NOT NULL, pattern TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE config_help (config_name TEXT NOT NULL PRIMARY KEY, title TEXT NOT NULL, body TEXT NOT NULL, detail_url TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE notifications (notification_id TEXT NOT NULL PRIMARY KEY, message TEXT NOT NULL, secondary_message TEXT, user_data TEXT NOT NULL, moment TEXT NOT NULL, read INTEGER NOT NULL, action_url TEXT, deleted INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  
		  Self.SQLExecute("CREATE VIRTUAL TABLE searchable_tags USING fts4(tags, object_id, source_table);")
		  
		  Self.SQLExecute("CREATE INDEX engrams_class_string_idx ON engrams(class_string);")
		  Self.SQLExecute("CREATE UNIQUE INDEX engrams_path_idx ON engrams(path);")
		  Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_sort_order_idx ON loot_sources(sort_order);")
		  Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_path_idx ON loot_sources(path);")
		  
		  Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe) VALUES (?1, ?2, ?3);", Self.UserModID, "User Custom", False)
		  Self.Commit()
		  
		  Self.mBase.UserVersion = Self.SchemaVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(SQLString As String) As RuntimeException
		  If Self.mBase.Error Then
		    Dim Err As New UnsupportedOperationException
		    Err.Message = Self.mBase.ErrorMessage + EndOfLine + SQLString
		    Return Err
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckForEngramUpdates()
		  If Self.mCheckingForUpdates Then
		    Return
		  End If
		  
		  If Self.mUpdater = Nil Then
		    Self.mUpdater = New Xojo.Net.HTTPSocket
		    Self.mUpdater.ValidateCertificates = True
		    Self.mUpdater.RequestHeader("Cache-Control") = "no-cache"
		    AddHandler Self.mUpdater.PageReceived, WeakAddressOf Self.mUpdater_PageReceived
		    AddHandler Self.mUpdater.Error, WeakAddressOf Self.mUpdater_Error
		  End If
		  
		  Self.mCheckingForUpdates = True
		  Dim CheckURL As Text = Self.ClassesURL()
		  App.Log("Checking for engram updates from " + CheckURL)
		  Self.mUpdater.Send("GET", CheckURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassesURL() As Text
		  Dim Version As Integer = App.BuildNumber
		  
		  Dim LastSync As String = Self.Variable("sync_time")
		  Dim CheckURL As Text = Beacon.WebURL("/download/classes.php?version=" + Version.ToText)
		  If LastSync <> "" Then
		    CheckURL = CheckURL + "&changes_since=" + EncodeURLComponent(LastSync).ToText
		  End If
		  Return CheckURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Commit()
		  If UBound(Self.mTransactions) = -1 Then
		    Return
		  End If
		  
		  Dim Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.Remove(0)
		  
		  If Savepoint = "" Then
		    Self.SQLExecute("COMMIT TRANSACTION;")
		  Else
		    Self.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramCache = New Dictionary
		  Self.mLock = New CriticalSection
		  
		  Dim AppSupport As FolderItem = App.ApplicationSupport
		  
		  Dim LegacyFile As FolderItem = AppSupport.Child("Beacon.sqlite")
		  If LegacyFile.Exists Then
		    LegacyFile.Delete
		  End If
		  
		  Self.mBase = New SQLiteDatabase
		  Self.mBase.DatabaseFile = AppSupport.Child("Library.sqlite")
		  
		  If Self.mBase.DatabaseFile.Exists Then
		    If Not Self.mBase.Connect Then
		      Return
		    End If
		  Else
		    If Not Self.mBase.CreateDatabaseFile Then
		      Return
		    End If
		    
		    Self.BuildSchema()
		  End If
		  
		  Dim CurrentSchemaVersion As Integer = Self.mBase.UserVersion
		  Dim MigrateFile As FolderItem
		  If CurrentSchemaVersion <> Self.SchemaVersion Then
		    Self.mBase.Close
		    
		    Dim BackupsFolder As FolderItem = AppSupport.Child("Old Libraries")
		    If Not BackupsFolder.Exists Then
		      BackupsFolder.CreateAsFolder
		    End If
		    
		    // Relocate the current library
		    Dim Counter As Integer = 1
		    Do
		      Dim Destination As FolderItem = BackupsFolder.Child("Library " + Str(CurrentSchemaVersion, "-0") + If(Counter > 1, "-" + Str(Counter, "-0"), "") + ".sqlite")
		      If Destination.Exists Then
		        Counter = Counter + 1
		        Continue
		      End If
		      Self.mBase.DatabaseFile.MoveFileTo(Destination)
		      MigrateFile = Destination
		      Exit
		    Loop
		    
		    // See if there is already a library, such as if the user went switched backward and forward between versions
		    Dim SearchFolders(1) As FolderItem
		    SearchFolders(0) = BackupsFolder
		    SearchFolders(1) = AppSupport
		    Dim SearchPrefix As String = "Library " + Str(Self.SchemaVersion, "-0")
		    Dim SearchSuffix As String = ".sqlite"
		    For Each SearchFolder As FolderItem In SearchFolders
		      Dim Candidates() As FolderItem
		      Dim Versions() As Integer
		      For I As Integer = 1 To SearchFolder.Count
		        Dim Filename As String = SearchFolder.Item(I).Name
		        If Filename = SearchPrefix + SearchSuffix Then
		          Candidates.Append(SearchFolder.Item(I))
		          Versions.Append(1)
		        ElseIf Filename.BeginsWith(SearchPrefix) And Filename.EndsWith(SearchSuffix) Then
		          Candidates.Append(SearchFolder.Item(I))
		          Versions.Append(Val(Filename.Mid(SearchPrefix.Length + 2, Filename.Length - (SearchPrefix.Length + SearchSuffix.Length))))
		        End If
		      Next
		      
		      If Candidates.Ubound > -1 Then
		        Versions.SortWith(Candidates)
		        
		        Dim RestoreFile As FolderItem = Candidates(Candidates.Ubound)
		        RestoreFile.MoveFileTo(AppSupport.Child("Library.sqlite"))
		        
		        Self.mBase = New SQLiteDatabase
		        Self.mBase.DatabaseFile = AppSupport.Child("Library.sqlite")
		        Call Self.mBase.Connect
		        Return
		      End If
		    Next
		    
		    Self.mBase = New SQLiteDatabase
		    Self.mBase.DatabaseFile = App.ApplicationSupport.Child("Library.sqlite")
		    Call Self.mBase.CreateDatabaseFile
		    Self.BuildSchema()
		  End If
		  
		  Self.mBase.SQLExecute("PRAGMA cache_size = -100000;")
		  
		  If MigrateFile <> Nil And MigrateFile.Exists And CurrentSchemaVersion < Self.SchemaVersion Then
		    Self.MigrateData(MigrateFile, CurrentSchemaVersion)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteEngram(Engram As Beacon.Engram) As Boolean
		  Try
		    Dim Results As RecordSet = Self.SQLSelect("SELECT mod_id FROM engrams WHERE LOWER(path) = LOWER(?1);", Engram.Path)
		    If Results.RecordCount = 1 And Results.Field("mod_id").StringValue <> Self.UserModID Then
		      Return False
		    End If
		    
		    Self.BeginTransaction()
		    Self.SQLExecute("DELETE FROM engrams WHERE LOWER(path) = LOWER(?1) AND mod_id = ?2;", Engram.Path, Self.UserModID)
		    Self.Commit()
		    
		    Return True
		  Catch Err As UnsupportedOperationException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteNotification(Notification As Beacon.UserNotification)
		  If Notification = Nil Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("UPDATE notifications SET deleted = 1 WHERE notification_id = ?1;", Notification.Identifier)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.SQLExecute("PRAGMA optimize;")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As Text) As Boolean
		  Dim Results As RecordSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RecordCount = 1 Then
		    Return Results.Field("value").BooleanValue
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigHelp(ConfigName As String, ByRef Title As String, ByRef Body As String, ByRef DetailURL As String) As Boolean
		  Dim Results As RecordSet = Self.SQLSelect("SELECT title, body, detail_url FROM config_help WHERE config_name = ?1;", Lowercase(ConfigName))
		  If Results.RecordCount <> 1 Then
		    Return False
		  End If
		  
		  Title = Results.Field("title").StringValue
		  Body = Results.Field("body").StringValue
		  DetailURL = If(Results.Field("detail_url").Value <> Nil, Results.Field("detail_url").StringValue, "")
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCustomEngrams() As Beacon.Engram()
		  Try
		    Dim RS As RecordSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE mods.mod_id = ?1;", Self.UserModID)
		    If RS.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Engrams() As Beacon.Engram = Self.RecordSetToEngram(RS)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		    Return Engrams
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As Text) As Double
		  Dim Results As RecordSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RecordCount = 1 Then
		    Return Results.Field("value").DoubleValue
		  Else
		    Return 0.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByClass(ClassString As Text) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    If ClassString.Length < 2 Or ClassString.Right(2) <> "_C" Then
		      ClassString = ClassString + "_C"
		    End If
		    
		    Dim RS As RecordSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE LOWER(class_string) = ?1;", ClassString.Lowercase)
		    If RS.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Engrams() As Beacon.Engram = Self.RecordSetToEngram(RS)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		    Return Engrams(0)
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByPath(Path As Text) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mEngramCache.HasKey(Path) Then
		    Return Self.mEngramCache.Value(Path)
		  End If
		  
		  Try
		    Dim RS As RecordSet = Self.SQLSelect(Self.EngramSelectSQL + " WHERE LOWER(path) = ?1;", Path.Lowercase)
		    If RS.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Engrams() As Beacon.Engram = Self.RecordSetToEngram(RS)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		    Return Engrams(0)
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As Text) As Integer
		  Dim Results As RecordSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RecordCount = 1 Then
		    Return Results.Field("value").IntegerValue
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As Text) As Beacon.LootSource
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    Dim Results As RecordSet = Self.SQLSelect("SELECT " + Self.LootSourcesSelectColumns + " FROM loot_sources WHERE LOWER(class_string) = ?1;", ClassString.Lowercase)
		    If Results.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Sources() As Beacon.LootSource = Self.RecordSetToLootSource(Results)
		    Return Sources(0)
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNotifications() As Beacon.UserNotification()
		  Dim Notifications() As Beacon.UserNotification
		  Dim Results As RecordSet = Self.SQLSelect("SELECT * FROM notifications WHERE deleted = 0 ORDER BY moment DESC;")
		  While Not Results.EOF
		    Dim Notification As New Beacon.UserNotification
		    Notification.Message = Results.Field("message").StringValue.ToText
		    Notification.SecondaryMessage = Results.Field("secondary_message").StringValue.ToText
		    Notification.ActionURL = Results.Field("action_url").StringValue.ToText
		    Notification.Read = Results.Field("read").BooleanValue
		    Notification.Timestamp = Self.TextToDate(Results.Field("moment").StringValue.ToText)
		    Notification.UserData = Xojo.Data.ParseJSON(Results.Field("user_data").StringValue.ToText)
		    Notifications.Append(Notification)
		    
		    Results.MoveNext
		  Wend
		  Return Notifications
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPreset(PresetID As Text) As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    If Preset.PresetID = PresetID Then
		      Return Preset
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifier(ModifierID As Text) As Beacon.PresetModifier
		  Dim Results As RecordSet = Self.SQLSelect("SELECT object_id, label, pattern FROM preset_modifiers WHERE LOWER(object_id) = LOWER(?1);", ModifierID)
		  If Results.RecordCount <> 1 Then
		    Return Nil
		  End If
		  
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("ModifierID") = Results.Field("object_id").StringValue.ToText
		  Dict.Value("Pattern") = Results.Field("pattern").StringValue.ToText
		  Dict.Value("Label") = Results.Field("label").StringValue.ToText
		  Return Beacon.PresetModifier.FromDictionary(Dict)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTextVariable(Key As Text) As Text
		  Dim Results As RecordSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RecordCount = 1 Then
		    Dim StringValue As String = Results.Field("value").StringValue
		    If StringValue.Encoding = Nil Then
		      If Encodings.UTF8.IsValidData(StringValue) Then
		        StringValue = StringValue.DefineEncoding(Encodings.UTF8)
		      Else
		        Return ""
		      End If
		    End If
		    Return StringValue.ToText
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasExperimentalLootSources(ConsoleSafe As Boolean) As Boolean
		  Try
		    Dim Clauses(0) As String
		    Clauses(0) = "experimental = 1"
		    If ConsoleSafe Then
		      Clauses.Append("mods.console_safe = 1")
		    End If
		    
		    Dim SQL As String = "SELECT COUNT(loot_sources.object_id) FROM loot_sources INNER JOIN mods ON (loot_sources.mod_id = mods.mod_id) WHERE " + Clauses.Join(" AND ") + ";"
		    Dim Results As RecordSet = Self.SQLSelect(SQL)
		    Return Results.IdxField(1).IntegerValue > 0
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IconForLootSource(Source As Beacon.LootSource, BackgroundColor As Color) As Picture
		  Const IncludeExperimentalBadge = False
		  
		  // "Fix" background color to account for opacity. It's not perfect, but it's good.
		  Dim BackgroundOpacity As Double = (255 - BackgroundColor.Alpha) / 255
		  BackgroundColor = SystemColors.UnderPageBackgroundColor.BlendWith(RGB(BackgroundColor.Red, BackgroundColor.Green, BackgroundColor.Blue), BackgroundOpacity)
		  
		  Dim PrimaryColor, AccentColor As Color
		  Dim IconID As String
		  Dim Results As RecordSet = Self.SQLSelect("SELECT loot_source_icons.icon_id, loot_source_icons.icon_data, loot_sources.experimental FROM loot_sources INNER JOIN loot_source_icons ON (loot_sources.icon = loot_source_icons.icon_id) WHERE loot_sources.class_string = ?1;", Source.ClassString)
		  Dim SpriteSheet, BadgeSheet As Picture
		  If Results.RecordCount = 1 Then
		    SpriteSheet = Results.Field("icon_data").PictureValue
		    If IncludeExperimentalBadge And Results.Field("experimental").BooleanValue Then
		      BadgeSheet = IconExperimentalBadge
		      IconID = IconID + "exp"
		    End If
		    IconID = Results.Field("icon_id").StringValue
		    PrimaryColor = Source.UIColor
		  Else
		    SpriteSheet = IconLootStandard
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
		  
		  Dim Height As Integer = (SpriteSheet.Height / 2) / 3
		  Dim Width As Integer = (SpriteSheet.Width / 2) / 3
		  
		  If BadgeSheet <> Nil Then
		    Dim Badges As Picture = New Picture(BadgeSheet.Width, BadgeSheet.Height, 32)
		    Badges.Graphics.ForeColor = &cFFFFFF
		    Badges.Graphics.FillRect(0, 0, Badges.Graphics.Width, Badges.Graphics.Height)
		    Badges.Mask.Graphics.DrawPicture(BadgeSheet, 0, 0)
		    
		    Dim Sprites As Picture = New Picture(SpriteSheet.Width, SpriteSheet.Height, 32)
		    Sprites.Graphics.DrawPicture(SpriteSheet, 0, 0)
		    Sprites.Graphics.DrawPicture(Badges.Piece(0, 0, Width, Height), 0, Height)
		    Sprites.Graphics.DrawPicture(Badges.Piece(Width, 0, Width * 2, Height * 2), Width, Height * 2)
		    Sprites.Graphics.DrawPicture(Badges.Piece(Width * 3, 0, Width * 3, Height * 3), Width * 3, Height * 3)
		    Badges.Graphics.ForeColor = &c000000
		    Badges.Graphics.FillRect(0, 0, Badges.Graphics.Width, Badges.Graphics.Height)
		    Sprites.Graphics.DrawPicture(Badges, 0, 0)
		    
		    SpriteSheet = Sprites
		  End If
		  
		  Dim Highlight1x As Picture = SpriteSheet.Piece(0, 0, Width, Height)
		  Dim Highlight2x As Picture = SpriteSheet.Piece(Width, 0, Width * 2, Height * 2)
		  Dim Highlight3x As Picture = SpriteSheet.Piece(Width * 3, 0, Width * 3, Height * 3)
		  Dim HighlightMask As New Picture(Width, Height, Array(Highlight1x, Highlight2x, Highlight3x))
		  
		  Dim Color1x As Picture = SpriteSheet.Piece(0, Height, Width, Height)
		  Dim Color2x As Picture = SpriteSheet.Piece(Width, Height * 2, Width * 2, Height * 2)
		  Dim Color3x As Picture = SpriteSheet.Piece(Width * 3, Height * 3, Width * 3, Height * 3)
		  Dim ColorMask As New Picture(Width, Height, Array(Color1x, Color2x, Color3x))
		  
		  Dim Highlight As Picture = HighlightMask.WithColor(PrimaryColor)
		  Dim Fill As Picture = ColorMask.WithColor(AccentColor)
		  
		  Dim Bitmaps() As Picture
		  For Factor As Integer = 1 To 3
		    Dim HighlightRep As Picture = Highlight.BestRepresentation(Width, Height, Factor)
		    Dim ColorRep As Picture = Fill.BestRepresentation(Width, Height, Factor)
		    
		    Dim Combined As New Picture(Width * Factor, Width * Factor)
		    Combined.VerticalResolution = 72 * Factor
		    Combined.HorizontalResolution = 72 * Factor
		    Combined.Graphics.DrawPicture(HighlightRep, 0, 0, Combined.Width, Combined.Height, 0, 0, HighlightRep.Width, HighlightRep.Height)
		    Combined.Graphics.DrawPicture(ColorRep, 0, 0, Combined.Width, Combined.Height, 0, 0, ColorRep.Width, ColorRep.Height)
		    
		    Bitmaps.Append(Combined)
		  Next
		  
		  Dim Icon As New Picture(Width, Height, Bitmaps)
		  Self.IconCache.Value(IconID) = Icon
		  Return Icon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As Text)
		  Self.mPendingImports.Append(Content)
		  
		  If Self.mImportThread = Nil Then
		    Self.mImportThread = New Thread
		    AddHandler Self.mImportThread.Run, WeakAddressOf Self.mImportThread_Run
		  End If
		  
		  If Self.mImportThread.State = Thread.NotRunning Then
		    Self.mImportThread.Run
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ImportInner(Content As Text) As Boolean
		  Dim ChangeDict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Content)
		  
		  Dim RequiredKeys() As Text = Array("mods", "loot_source_icons", "loot_sources", "engrams", "presets", "preset_modifiers", "timestamp", "is_full", "beacon_version")
		  For Each RequiredKey As Text In RequiredKeys
		    If Not ChangeDict.HasKey(RequiredKey) Then
		      App.Log("Cannot import classes because key '" + RequiredKey + "' is missing.")
		      Return False
		    End If
		  Next
		  
		  Dim FileVersion As Integer = ChangeDict.Value("beacon_version")
		  If FileVersion <> 4 Then
		    App.Log("Cannot import classes because file format is not correct for this version. Get correct classes from " + Self.ClassesURL())
		    Return False
		  End If
		  
		  Dim PayloadTimestamp As Xojo.Core.Date = Self.TextToDate(ChangeDict.Value("timestamp"))
		  Dim LastSync As Xojo.Core.Date = Self.LastSync
		  If LastSync <> Nil And LastSync.SecondsFrom1970 >= PayloadTimestamp.SecondsFrom1970 Then
		    Return False
		  End If
		  
		  Try
		    Self.BeginTransaction()
		    
		    Dim EngramsChanged As Boolean
		    
		    // Drop indexes
		    Self.SQLExecute("DROP INDEX engrams_class_string_idx;")
		    Self.SQLExecute("DROP INDEX engrams_path_idx;")
		    Self.SQLExecute("DROP INDEX loot_sources_sort_order_idx;")
		    Self.SQLExecute("DROP INDEX loot_sources_path_idx;")
		    
		    Dim ShouldTruncate As Boolean = ChangeDict.Value("is_full") = 1
		    If ShouldTruncate Then
		      Self.SQLExecute("DELETE FROM mods WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM loot_sources WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM engrams WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id != ?1;", Self.UserModID)
		      Self.SQLExecute("DELETE FROM official_presets;")
		    End If
		    
		    // Caution!! This field always contains all mods.
		    Dim Mods() As Auto = ChangeDict.Value("mods")
		    Dim RetainMods() As Text
		    RetainMods.Append(Self.UserModID.ToText)
		    For Each ModData As Xojo.Core.Dictionary In Mods
		      Dim ModID As Text = ModData.Value("mod_id")
		      Dim ModName As Text = ModData.Value("name")
		      Dim ConsoleSafe As Boolean = ModData.Value("console_safe")
		      
		      ModID = ModID.Lowercase
		      
		      Dim Results As RecordSet = Self.SQLSelect("SELECT name, console_safe FROM mods WHERE mod_id = ?1;", ModID)
		      If Results.RecordCount = 1 Then
		        If ModName.Compare(Results.Field("name").StringValue.ToText, Text.CompareCaseSensitive) <> 0 Or ConsoleSafe <> Results.Field("console_safe").BooleanValue Then
		          Self.SQLExecute("UPDATE mods SET name = ?2, console_safe = ?3 WHERE mod_id = ?1;", ModID, ModName, ConsoleSafe)
		        End If
		      Else
		        Self.SQLExecute("INSERT INTO mods (mod_id, name, console_safe) VALUES (?1, ?2, ?3);", ModID, ModName, ConsoleSafe)
		      End If
		      
		      RetainMods.Append(ModID)
		    Next
		    Dim ModResults As RecordSet = Self.SQLSelect("SELECT mod_id FROM mods;")
		    While Not ModResults.EOF
		      Dim ModID As Text = ModResults.Field("mod_id").StringValue.ToText.Lowercase
		      If RetainMods.IndexOf(ModID) = -1 Then
		        Self.SQLExecute("DELETE FROM mods WHERE mod_id = ?1;", ModID)
		      End If
		      ModResults.MoveNext
		    Wend
		    
		    // When deleting, loot_source_icons must be done after loot_sources
		    Dim Deletions() As Auto = ChangeDict.Value("deletions")
		    Dim DeleteIcons() As Text
		    For Each Deletion As Xojo.Core.Dictionary In Deletions
		      Dim ObjectID As Text = Deletion.Value("object_id")
		      ObjectID = ObjectID.Lowercase
		      Select Case Deletion.Value("group")
		      Case "loot_sources"
		        Self.SQLExecute("DELETE FROM loot_sources WHERE object_id = ?1;", ObjectID)
		      Case "loot_source_icons"
		        DeleteIcons.Append(ObjectID)
		      Case "engrams"
		        Self.SQLExecute("DELETE FROM engrams WHERE object_id = ?1;", ObjectID)
		      Case "presets"
		        Self.SQLExecute("DELETE FROM official_presets WHERE object_id = ?1;", ObjectID)
		      End Select
		    Next
		    For Each IconID As Text In DeleteIcons
		      Self.SQLExecute("DELETE FROM loot_source_icons WHERE icon_id = ?1;", IconID)
		    Next
		    
		    Dim LootSourceIcons() As Auto = ChangeDict.Value("loot_source_icons")
		    For Each Dict As Xojo.Core.Dictionary In LootSourceIcons
		      Dim IconID As Text = Dict.Value("id")
		      Dim IconData As Xojo.Core.MemoryBlock = Beacon.DecodeBase64(Dict.Value("icon_data"))
		      
		      IconID = IconID.Lowercase
		      
		      Dim Results As RecordSet = Self.SQLSelect("SELECT icon_id FROM loot_source_icons WHERE icon_id = ?1;", IconID)
		      If Results.RecordCount = 1 Then
		        Self.SQLExecute("UPDATE loot_source_icons SET icon_data = ?2 WHERE icon_id = ?1;", IconID, IconData)
		      Else
		        Self.SQLExecute("INSERT INTO loot_source_icons (icon_id, icon_data) VALUES (?1, ?2);", IconID, IconData)
		      End If
		    Next
		    If LootSourceIcons.Ubound > -1 Then
		      Self.IconCache = Nil
		    End If
		    
		    Dim LootSources() As Auto = ChangeDict.Value("loot_sources")
		    For Each Dict As Xojo.Core.Dictionary In LootSources
		      Dim ObjectID As Text = Dict.Value("id")
		      Dim Label As Text = Dict.Value("label")
		      Dim ModID As Text = Xojo.Core.Dictionary(Dict.Value("mod")).Value("id")
		      Dim Availability As Integer = Dict.Value("availability")
		      Dim Path As Text = Dict.Value("path")
		      Dim ClassString As Text = Dict.Value("class_string")
		      Dim MultiplierMin As Double = Xojo.Core.Dictionary(Dict.Value("multipliers")).Value("min")
		      Dim MultiplierMax As Double = Xojo.Core.Dictionary(Dict.Value("multipliers")).Value("max")
		      Dim UIColor As Text = Dict.Value("ui_color")
		      Dim SortOrder As Integer = Dict.Value("sort_order")
		      Dim Experimental As Boolean = Dict.Value("experimental")
		      Dim Notes As Text = Dict.Value("notes")
		      Dim IconID As Text = Dict.Value("icon")
		      Dim Requirements As Text = Dict.Lookup("requirements", "{}")
		      
		      ObjectID = ObjectID.Lowercase
		      ModID = ModID.Lowercase
		      IconID = IconID.Lowercase
		      
		      Dim Results As RecordSet = Self.SQLSelect("SELECT object_id FROM loot_sources WHERE object_id = ?1 OR LOWER(path) = ?2;", ObjectID, Path.Lowercase)
		      If Results.RecordCount = 1 And ObjectID = Results.Field("object_id").StringValue Then
		        Self.SQLExecute("UPDATE loot_sources SET mod_id = ?2, label = ?3, availability = ?4, path = ?5, class_string = ?6, multiplier_min = ?7, multiplier_max = ?8, uicolor = ?9, sort_order = ?10, icon = ?11, experimental = ?12, notes = ?13, requirements = ?14 WHERE object_id = ?1;", ObjectID, ModID, Label, Availability, Path, ClassString, MultiplierMin, MultiplierMax, UIColor, SortOrder, IconID, Experimental, Notes, Requirements)
		      Else
		        If Results.RecordCount = 1 Then
		          Self.SQLExecute("DELETE FROM loot_sources WHERE object_id = ?1;", Results.Field("object_id").StringValue)
		        End If
		        Self.SQLExecute("INSERT INTO loot_sources (object_id, mod_id, label, availability, path, class_string, multiplier_min, multiplier_max, uicolor, sort_order, icon, experimental, notes, requirements) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14);", ObjectID, ModID, Label, Availability, Path, ClassString, MultiplierMin, MultiplierMax, UIColor, SortOrder, IconID, Experimental, Notes, Requirements)
		      End If
		    Next
		    
		    Dim Engrams() As Auto = ChangeDict.Value("engrams")
		    For Each Dict As Xojo.Core.Dictionary In Engrams
		      Dim ObjectID As Text = Dict.Value("id")
		      Dim Label As Text = Dict.Value("label")
		      Dim ModID As Text = Xojo.Core.Dictionary(Dict.Value("mod")).Value("id")
		      Dim Availability As Integer = Dict.Value("availability")
		      Dim Path As Text = Dict.Value("path")
		      Dim ClassString As Text = Dict.Value("class_string")
		      Dim TagString As String
		      Try
		        Dim Tags() As Text
		        Dim Temp() As Auto = Dict.Value("tags")
		        For Each Tag As Text In Temp
		          Tags.Append(Tag)
		        Next
		        TagString = Text.Join(Tags, ",")
		      Catch Err As TypeMismatchException
		        
		      End Try
		      
		      ObjectID = ObjectID.Lowercase
		      ModID = ModID.Lowercase
		      
		      Dim Results As RecordSet = Self.SQLSelect("SELECT object_id FROM engrams WHERE object_id = ?1 OR LOWER(path) = ?2;", ObjectID, Path.Lowercase)
		      If Results.RecordCount = 1 And ObjectID = Results.Field("object_id").StringValue Then
		        Self.SQLExecute("UPDATE engrams SET mod_id = ?2, label = ?3, availability = ?4, path = ?5, class_string = ?6, tags = ?7 WHERE object_id = ?1;", ObjectID, ModID, Label, Availability, Path, ClassString, TagString)
		        Self.SQLExecute("UPDATE searchable_tags SET tags = ?2 WHERE object_id = ?1 AND source_table = 'engrams';", ObjectID, TagString)
		      Else
		        If Results.RecordCount = 1 Then
		          Self.SQLExecute("DELETE FROM engrams WHERE object_id = ?1;", Results.Field("object_id").StringValue)
		          Self.SQLExecute("DELETE FROM searchable_tags WHERE object_id = ?1 AND source_table = 'engrams';", Results.Field("object_id").StringValue)
		        End If
		        Self.SQLExecute("INSERT INTO engrams (object_id, mod_id, label, availability, path, class_string, tags) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);", ObjectID, ModID, Label, Availability, Path, ClassString, TagString)
		        Self.SQLExecute("INSERT INTO searchable_tags (object_id, tags, source_table) VALUES (?1, ?2, 'engrams');", ObjectID, TagString)
		      End If
		      EngramsChanged = True
		    Next
		    
		    Dim ReloadPresets As Boolean
		    Dim Presets() As Auto = ChangeDict.Value("presets")
		    For Each Dict As Xojo.Core.Dictionary In Presets
		      Dim ObjectID As Text = Dict.Value("id")
		      Dim Label As Text = Dict.Value("label")
		      Dim Contents As Text = Dict.Value("contents")
		      
		      ObjectID = ObjectID.Lowercase
		      
		      ReloadPresets = True
		      Dim Results As RecordSet = Self.SQLSelect("SELECT object_id FROM official_presets WHERE object_id = ?1;", ObjectID)
		      If Results.RecordCount = 1 Then
		        Self.SQLExecute("UPDATE official_presets SET label = ?2, contents = ?3 WHERE object_id = ?1;", ObjectID, Label, Contents)
		      Else
		        Self.SQLExecute("INSERT INTO official_presets (object_id, label, contents) VALUES (?1, ?2, ?3);", ObjectID, Label, Contents)
		      End If
		    Next
		    
		    Dim PresetModifiers() As Auto = ChangeDict.Value("preset_modifiers")
		    For Each Dict As Xojo.Core.Dictionary In PresetModifiers
		      Dim ObjectID As Text = Dict.Value("id")
		      Dim Label As Text = Dict.Value("label")
		      Dim Pattern As Text = Dict.Value("pattern")
		      Dim ModID As Text = Xojo.Core.Dictionary(Dict.Value("mod")).Value("id")
		      
		      ObjectID = ObjectID.Lowercase
		      
		      ReloadPresets = True
		      Dim Results As RecordSet = Self.SQLSelect("SELECT object_id FROM preset_modifiers WHERE object_id = ?1;", ObjectID)
		      If Results.RecordCount = 1 Then
		        Self.SQLExecute("UPDATE preset_modifiers SET label = ?2, pattern = ?3, mod_id = ?4 WHERE object_id = ?1;", ObjectID, Label, Pattern, ModID)
		      Else
		        Self.SQLExecute("INSERT INTO preset_modifiers (object_id, label, pattern, mod_id) VALUES (?1, ?2, ?3, ?4);", ObjectID, Label, Pattern, ModID)
		      End If
		    Next
		    
		    If ChangeDict.HasKey("help_topics") Then
		      Dim HelpTopics() As Auto = ChangeDict.Value("help_topics")
		      For Each Dict As Xojo.Core.Dictionary In HelpTopics
		        Dim ConfigName As Text = Dict.Value("topic")
		        Dim Title As Text = Dict.Value("title")
		        Dim Body As Text = Dict.Value("body")
		        Dim DetailURL As Text
		        If Dict.Value("detail_url") <> Nil Then
		          DetailURL = Dict.Value("detail_url")
		        End If
		        
		        ConfigName = ConfigName.Lowercase
		        
		        Dim Results As RecordSet = Self.SQLSelect("SELECT config_name FROM config_help WHERE config_name = ?1;", ConfigName)
		        If Results.RecordCount = 1 Then
		          Self.SQLExecute("UPDATE config_help SET title = ?2, body = ?3, detail_url = ?4 WHERE config_name = ?1;", ConfigName, Title, Body, DetailURL)
		        Else
		          Self.SQLExecute("INSERT INTO config_help (config_name, title, body, detail_url) VALUES (?1, ?2, ?3, ?4);", ConfigName, Title, Body, DetailURL)
		        End If
		      Next
		    End If
		    
		    If ChangeDict.HasKey("game_variables") Then
		      Dim HelpTopics() As Auto = ChangeDict.Value("game_variables")
		      For Each Dict As Xojo.Core.Dictionary In HelpTopics
		        Dim Key As Text = Dict.Value("key")
		        Dim Value As Text = Dict.Value("value")
		        
		        Dim Results As RecordSet = Self.SQLSelect("SELECT key FROM game_variables WHERE key = ?1;", Key)
		        If Results.RecordCount = 1 Then
		          Self.SQLExecute("UPDATE game_variables SET value = ?2 WHERE key = ?1;", Key, Value)
		        Else
		          Self.SQLExecute("INSERT INTO game_variables (key, value) VALUES (?1, ?2);", Key, Value)
		        End If
		      Next
		    End If
		    
		    // Restore Indexes
		    Self.SQLExecute("CREATE INDEX engrams_class_string_idx ON engrams(class_string);")
		    Self.SQLExecute("CREATE UNIQUE INDEX engrams_path_idx ON engrams(path);")
		    Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_sort_order_idx ON loot_sources(sort_order);")
		    Self.SQLExecute("CREATE UNIQUE INDEX loot_sources_path_idx ON loot_sources(path);")
		    
		    Self.Variable("sync_time") = PayloadTimestamp.ToText()
		    Self.Commit()
		    
		    If ReloadPresets Then
		      Self.LoadPresets()
		    End If
		    
		    App.Log("Imported classes. Engrams date is " + PayloadTimestamp.ToText())
		    
		    If EngramsChanged Then
		      NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		    End If
		    
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
		  Dim File As FolderItem = App.ResourcesFolder.Child("Classes.json")
		  If File.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Self.Import(Content.ToText)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Dim Results As RecordSet = Self.SQLSelect("SELECT object_id FROM custom_presets WHERE LOWER(object_id) = LOWER(?1);", Preset.PresetID)
		  Return Results.RecordCount = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSync() As Xojo.Core.Date
		  Dim LastSync As String = Self.Variable("sync_time")
		  If LastSync = "" Then
		    Return Nil
		  End If
		  
		  Return Self.TextToDate(LastSync.ToText)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Redim Self.mPresets(-1)
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM preset_modifiers WHERE mod_id = ?1;", Self.UserModID) // Loading the presets will refill all the needed custom modifiers
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM official_presets WHERE LOWER(object_id) NOT IN (SELECT LOWER(object_id) FROM custom_presets)"), Beacon.Preset.Types.BuiltIn)
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE LOWER(object_id) IN (SELECT LOWER(object_id) FROM official_presets)"), Beacon.Preset.Types.CustomizedBuiltIn)
		  Self.LoadPresets(Self.SQLSelect("SELECT object_id, contents FROM custom_presets WHERE LOWER(object_id) NOT IN (SELECT LOWER(object_id) FROM official_presets)"), Beacon.Preset.Types.Custom)
		  Self.Commit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadPresets(Results As RecordSet, Type As Beacon.Preset.Types)
		  While Not Results.EOF
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Results.Field("contents").StringValue.ToText)
		    Dim Preset As Beacon.Preset = Beacon.Preset.FromDictionary(Dict)
		    If Preset <> Nil Then
		      If Type <> Beacon.Preset.Types.BuiltIn And Preset.PresetID <> Results.Field("object_id").StringValue Then
		        // To work around https://github.com/thommcgrath/Beacon/issues/64
		        Dim Contents As Text = Xojo.Data.GenerateJSON(Preset.ToDictionary)
		        Self.BeginTransaction()
		        Self.SQLExecute("UPDATE custom_presets SET LOWER(object_id) = LOWER(?2), contents = ?3 WHERE object_id = ?1;", Results.Field("object_id").StringValue, Preset.PresetID, Contents)
		        Self.Commit()
		      End If
		      
		      Preset.Type = Type
		      Self.mPresets.Append(Preset)
		    End If
		    Results.MoveNext
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MigrateData(Source As FolderItem, FromSchemaVersion As Integer)
		  If Not Self.mBase.AttachDatabase(Source, "legacy") Then
		    App.Log("Unable to attach database " + Source.NativePath)
		    Return
		  End If
		  
		  Dim MigrateLegacyCustomEngrams As Boolean = FromSchemaVersion <= 5
		  Dim Commands() As String
		  
		  // Mods
		  If FromSchemaVersion >= 6 Then
		    Commands.Append("INSERT INTO mods SELECT * FROM legacy.mods WHERE mod_id != '" + Self.UserModID + "';")
		  End If
		  
		  // Loot Sources
		  If FromSchemaVersion >= 8 Then  
		    Commands.Append("INSERT INTO loot_source_icons SELECT * FROM legacy.loot_source_icons;")
		    Commands.Append("INSERT INTO loot_sources SELECT * FROM legacy.loot_sources;")
		  End If
		  
		  // Engrams
		  If FromSchemaVersion >= 9 Then
		    Commands.Append("INSERT INTO engrams SELECT * FROM legacy.engrams;")
		  End If
		  
		  // Variables
		  If FromSchemaVersion >= 6 Then
		    Commands.Append("INSERT INTO variables SELECT * FROM legacy.variables WHERE LOWER(legacy.variables.key) != 'sync_time';")
		  End If
		  
		  // Official Presets
		  If FromSchemaVersion >= 6 Then
		    Commands.Append("INSERT INTO official_presets SELECT * FROM legacy.official_presets;")
		  End If
		  
		  // Notifications
		  If FromSchemaVersion >= 6 Then
		    Commands.Append("INSERT INTO notifications SELECT * FROM legacy.notifications;")
		  End If
		  
		  // Config Help
		  If FromSchemaVersion >= 6 Then
		    Commands.Append("INSERT INTO config_help (config_name, title, body, detail_url) SELECT LOWER(config_name), title, body, detail_url FROM legacy.config_help;")
		  End If
		  
		  // Preset Modifiers
		  If FromSchemaVersion >= 6 Then
		    Commands.Append("INSERT INTO preset_modifiers SELECT * FROM legacy.preset_modifiers")
		  End If
		  
		  // Game Variables
		  If FromSchemaVersion >= 7 Then
		    Commands.Append("INSERT INTO game_variables SELECT * FROM legacy.game_variables;")
		  End If
		  
		  // Custom Presets
		  If FromSchemaVersion >= 3 Then
		    Commands.Append("INSERT INTO custom_presets SELECT * FROM legacy.custom_presets;")
		  End If
		  
		  // Searchable Tags
		  If FromSchemaVersion >= 9 Then
		    Commands.Append("INSERT INTO searchable_tags SELECT * FROM legacy.searchable_tags;")
		  End If
		  
		  If UBound(Commands) > -1 Then
		    Self.BeginTransaction()
		    Try
		      For Each Command As String In Commands
		        Self.SQLExecute(Command)
		      Next
		    Catch Err As UnsupportedOperationException
		      Self.Rollback()
		      Self.mBase.DetachDatabase("legacy")
		      App.Log("Unable to migrate data: " + Err.Message)
		      Return
		    End Try
		    
		    If MigrateLegacyCustomEngrams Then
		      Dim Results As RecordSet = Self.SQLSelect("SELECT path, class_string, label, availability, can_blueprint FROM legacy.engrams WHERE built_in = 0;")
		      While Not Results.EOF
		        Try
		          Dim ObjectID As String = Beacon.CreateUUID
		          Dim Tags As String = If(Results.Field("can_blueprint").BooleanValue, "blueprintable", "")
		          Self.SQLExecute("INSERT INTO engrams (object_id, mod_id, path, class_string, label, availability, tags) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);", ObjectID, Self.UserModID, Results.Field("path").StringValue, Results.Field("class_string").StringValue, Results.Field("label").StringValue, Results.Field("availability").IntegerValue, Tags)
		          Self.SQLExecute("INSERT INTO searchable_tags (object_id, source_table, tags) VALUES (?1, ?2, ?3);", ObjectID, "engrams", Tags)
		        Catch Err As UnsupportedOperationException
		          Self.Rollback()
		          Self.mBase.DetachDatabase("legacy")
		          App.Log("Unable to migrate data: " + Err.Message)
		          Return
		        End Try
		        
		        Results.MoveNext
		      Wend
		    End If
		    
		    Self.Commit()
		  End If
		  
		  Self.mBase.DetachDatabase("legacy")
		  
		  If FromSchemaVersion <= 2 Then
		    Dim SupportFolder As FolderItem = App.ApplicationSupport
		    Dim PresetsFolder As FolderItem = SupportFolder.Child("Presets")
		    If PresetsFolder.Exists Then
		      For I As Integer = PresetsFolder.Count DownTo 1
		        Dim File As Beacon.FolderItem = PresetsFolder.Item(I)
		        If Not File.IsType(BeaconFileTypes.BeaconPreset) Then
		          File.Delete
		          Continue
		        End If
		        
		        Dim Content As Text = File.Read(Xojo.Core.TextEncoding.UTF8)
		        
		        Try
		          Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Content)
		          Dim PresetID As Text = Dict.Value("ID")
		          Dim Label As Text = Dict.Value("Label")
		          
		          Self.BeginTransaction()
		          Self.SQLExecute("INSERT OR REPLACE INTO custom_presets (object_id, label, contents) VALUES (LOWER(?1), ?2, ?3);", PresetID, Label, Content)
		          Self.Commit()
		          
		          File.Delete
		        Catch Err As RuntimeException
		          While Self.mTransactions.Ubound > -1
		            Self.Rollback()
		          Wend
		          Continue
		        End Try
		      Next
		      
		      PresetsFolder.Delete
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImportThread_Run(Sender As Thread)
		  #Pragma Unused Sender
		  
		  If Self.mPendingImports.Ubound = -1 Then
		    Return
		  End If
		  
		  Dim SyncOriginal As Xojo.Core.Date = Self.LastSync
		  Dim Success As Boolean
		  For I As Integer = 0 To Self.mPendingImports.Ubound
		    Dim Content As Text = Self.mPendingImports(I)
		    Self.mPendingImports.Remove(I)
		    
		    Success = Self.ImportInner(Content) Or Success
		  Next
		  Dim SyncNew As Xojo.Core.Date = Self.LastSync
		  
		  If SyncOriginal <> SyncNew Then
		    NotificationKit.Post(Self.Notification_DatabaseUpdated, SyncNew)
		  End If
		  
		  If Success Then
		    NotificationKit.Post(Self.Notification_ImportSuccess, SyncNew)
		  Else
		    NotificationKit.Post(Self.Notification_ImportFailed, SyncNew)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_Error(Sender As Xojo.Net.HTTPSocket, Error As RuntimeException)
		  #Pragma Unused Sender
		  
		  App.Log("Engram check error: " + Error.Reason)
		  NotificationKit.Post(Self.Notification_ImportFailed, Self.LastSync)
		  
		  Self.mCheckingForUpdates = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    App.Log("Engram update returned HTTP " + Str(HTTPStatus, "-0"))
		    NotificationKit.Post(Self.Notification_ImportFailed, Self.LastSync)
		    Return
		  End If
		  
		  Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Dim ExpectedHash As Text = Sender.ResponseHeader("Content-MD5")
		  Dim ComputedHash As Text = EncodeHex(Crypto.MD5(TextContent)).ToText
		  
		  If ComputedHash <> ExpectedHash Then
		    App.Log("Engram update hash mismatch. Expected " + ExpectedHash + ", computed " + ComputedHash + ".")
		    NotificationKit.Post(Self.Notification_ImportFailed, Self.LastSync)
		    Return
		  End If
		  
		  Self.Import(TextContent)
		  
		  Self.mCheckingForUpdates = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  Dim Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.Append(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecordSetToEngram(Results As RecordSet) As Beacon.Engram()
		  Dim Engrams() As Beacon.Engram
		  While Not Results.EOF
		    Dim Engram As New Beacon.MutableEngram(Results.Field("path").StringValue.ToText)
		    Engram.Label = Results.Field("label").StringValue.ToText
		    Engram.Availability = Results.Field("availability").IntegerValue
		    Engram.TagString = Results.Field("tags").StringValue.ToText
		    Engram.ConsoleSafe = Results.Field("console_safe").BooleanValue
		    Engram.ModID = Results.Field("mod_id").StringValue.ToText
		    Engram.ModName = Results.Field("mod_name").StringValue.ToText
		    Engrams.Append(Engram)
		    Results.MoveNext
		  Wend
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecordSetToLootSource(Results As RecordSet) As Beacon.LootSource()
		  Dim Sources() As Beacon.LootSource
		  While Not Results.EOF
		    Dim HexColor As String = Results.Field("uicolor").StringValue
		    Dim RedHex, GreenHex, BlueHex, AlphaHex As String = "00"
		    If Len(HexColor) = 3 Then
		      RedHex = Mid(HexColor, 1, 1) + Mid(HexColor, 1, 1)
		      GreenHex = Mid(HexColor, 2, 1) + Mid(HexColor, 2, 1)
		      BlueHex = Mid(HexColor, 3, 1) + Mid(HexColor, 3, 1)
		    ElseIf Len(HexColor) = 4 Then
		      RedHex = Mid(HexColor, 1, 1) + Mid(HexColor, 1, 1)
		      GreenHex = Mid(HexColor, 2, 1) + Mid(HexColor, 2, 1)
		      BlueHex = Mid(HexColor, 3, 1) + Mid(HexColor, 3, 1)
		      AlphaHex = Mid(HexColor, 4, 1) + Mid(HexColor, 4, 1)
		    ElseIf Len(HexColor) = 6 Then
		      RedHex = Mid(HexColor, 1, 2)
		      GreenHex = Mid(HexColor, 3, 2)
		      BlueHex = Mid(HexColor, 5, 2)
		    ElseIf Len(HexColor) = 8 Then
		      RedHex = Mid(HexColor, 1, 2)
		      GreenHex = Mid(HexColor, 3, 2)
		      BlueHex = Mid(HexColor, 5, 2)
		      AlphaHex = Mid(HexColor, 7, 2)
		    End If
		    
		    Dim Requirements As Xojo.Core.Dictionary
		    #Pragma BreakOnExceptions Off
		    Try
		      Requirements = Xojo.Data.ParseJSON(Results.Field("requirements").StringValue.ToText)
		    Catch Err As Xojo.Data.InvalidJSONException
		      
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    Dim Source As New Beacon.MutableLootSource(Results.Field("class_string").StringValue.ToText, True)
		    Source.Label = Results.Field("label").StringValue.ToText
		    Source.Availability = Results.Field("availability").IntegerValue
		    Source.Multipliers = New Beacon.Range(Results.Field("multiplier_min").DoubleValue, Results.Field("multiplier_max").DoubleValue)
		    Source.UIColor = RGB(Integer.FromHex(RedHex.ToText), Integer.FromHex(GreenHex.ToText), Integer.FromHex(BlueHex.ToText), Integer.FromHex(AlphaHex.ToText))
		    Source.SortValue = Results.Field("sort_order").IntegerValue
		    Source.UseBlueprints = False
		    Source.Experimental = Results.Field("experimental").BooleanValue
		    Source.Notes = Results.Field("notes").StringValue.ToText
		    
		    If Requirements.HasKey("mandatory_item_sets") Then
		      Dim SetDicts() As Auto = Requirements.Value("mandatory_item_sets")
		      Dim Sets() As Beacon.ItemSet
		      For Each Dict As Xojo.Core.Dictionary In SetDicts
		        Dim Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromBeacon(Dict)
		        If Set <> Nil Then
		          Sets.Append(Set)
		        End If
		      Next
		      Source.MandatoryItemSets = Sets
		    End If
		    
		    If Requirements.HasKey("min_item_sets") Then
		      Source.RequiredItemSets = Requirements.Value("min_item_sets")
		    End If
		    
		    Sources.Append(New Beacon.LootSource(Source))
		    Results.MoveNext
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePreset(Preset As Beacon.Preset)
		  If Not Self.IsPresetCustom(Preset) Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM custom_presets WHERE LOWER(object_id) = LOWER(?1);", Preset.PresetID)
		  Self.Commit()
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Rollback()
		  If UBound(Self.mTransactions) = -1 Then
		    Return
		  End If
		  
		  Dim Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.Remove(0)
		  
		  If Savepoint = "" Then
		    Self.SQLExecute("ROLLBACK TRANSACTION;")
		  Else
		    Self.SQLExecute("ROLLBACK TRANSACTION TO SAVEPOINT " + Savepoint + ";")
		    Self.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveEngram(Engram As Beacon.Engram, Replace As Boolean = True) As Boolean
		  If Not Engram.IsValid Then
		    Return False
		  End If
		  
		  Self.BeginTransaction()
		  Try
		    Dim Results As RecordSet = Self.SQLSelect("SELECT object_id, mod_id FROM engrams WHERE LOWER(path) = LOWER(?1);", Engram.Path)
		    If Results.RecordCount = 1 Then
		      If Replace = False Then
		        Self.Rollback()
		        Return False
		      End If
		      
		      Dim ModID As String = Results.Field("mod_id").StringValue
		      If ModID <> Self.UserModID Then
		        Self.Rollback()
		        Return False
		      End If
		      
		      Self.SQLExecute("UPDATE engrams SET path = ?1, class_string = ?2, label = ?3, tags = ?4, availability = ?5 WHERE LOWER(path) = LOWER(?1);", Engram.Path, Engram.ClassString, Engram.Label, Engram.TagString, Engram.Availability)
		      Self.SQLExecute("UPDATE searchable_tags SET tags = ?2 WHERE object_id = ?1 AND source_table = 'engrams';", Results.Field("object_id").StringValue, Engram.TagString)
		    Else
		      Dim ObjectID As String = Beacon.CreateUUID
		      Self.SQLExecute("INSERT INTO engrams (object_id, path, class_string, label, tags, availability, mod_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7);", ObjectID, Engram.Path, Engram.ClassString, Engram.Label, Engram.TagString, Engram.Availability, Self.UserModID)
		      Self.SQLExecute("INSERT INTO searchable_tags (object_id, tags, source_table) VALUES (?1, ?2, 'engrams');", ObjectID, Engram.TagString)
		    End If
		    Self.Commit()
		    
		    NotificationKit.Post(Self.Notification_EngramsChanged, Nil)
		  Catch Err As UnsupportedOperationException
		    Self.RollBack()
		    Return False
		  End Try
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveNotification(Notification As Beacon.UserNotification)
		  If Notification = Nil Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Dim Results As RecordSet = Self.SQLSelect("SELECT deleted, read FROM notifications WHERE notification_id = ?1;", Notification.Identifier)
		  Dim Deleted As Boolean = Results.RecordCount = 1 And Results.Field("deleted").BooleanValue = True
		  Dim Read As Boolean = Results.RecordCount = 1 And Results.Field("read").BooleanValue
		  If Notification.DoNotResurrect And (Deleted Or Read)  Then
		    Self.Rollback
		    Return
		  End If
		  
		  Dim Notify As Boolean = Results.RecordCount = 0 Or Deleted Or Read
		  Self.SQLExecute("INSERT OR REPLACE INTO notifications (notification_id, message, secondary_message, moment, read, action_url, user_data, deleted) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, 0);", Notification.Identifier, Notification.Message, Notification.SecondaryMessage, Notification.Timestamp.ToText, If(Notification.Read, 1, 0), Notification.ActionURL, If(Notification.UserData <> Nil, Xojo.Data.GenerateJSON(Notification.UserData), "{}"))
		  Self.Commit
		  
		  If Notify Then
		    NotificationKit.Post(Self.Notification_NewAppNotification, Notification)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  Self.SavePreset(Preset, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SavePreset(Preset As Beacon.Preset, Reload As Boolean)
		  Dim Content As Text = Xojo.Data.GenerateJSON(Preset.ToDictionary)
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("INSERT OR REPLACE INTO custom_presets (object_id, label, contents) VALUES (LOWER(?1), ?2, ?3);", Preset.PresetID, Preset.Label, Content)
		  Self.Commit()
		  
		  If Reload Then
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As Text, ConsoleSafe As Boolean, Filter As Beacon.EngramSearchFilter = Nil) As Beacon.Engram()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Engrams() As Beacon.Engram
		  
		  Try
		    Dim NextPlaceholder As Integer = 1
		    Dim Clauses() As String
		    Dim Values As New Dictionary
		    If ConsoleSafe Then
		      Clauses.Append("mods.console_safe = 1")
		    End If
		    If SearchText <> "" Then
		      Clauses.Append("LOWER(label) LIKE LOWER(?" + Str(NextPlaceholder) + ") OR LOWER(class_string) LIKE LOWER(?" + Str(NextPlaceholder) + ")")
		      Values.Value(NextPlaceholder) = "%" + SearchText + "%"
		      NextPlaceholder = NextPlaceholder + 1
		    End If
		    
		    Dim SQL As String = Self.EngramSelectSQL
		    If Filter <> Nil Then
		      If Filter.Mods.Ubound > -1 Then
		        Dim Placeholders() As String
		        For Each ModID As Text In Filter.Mods
		          Placeholders.Append("?" + Str(NextPlaceholder))
		          Values.Value(NextPlaceholder) = ModID
		          NextPlaceholder = NextPlaceholder + 1
		        Next
		        Clauses.Append("mods.mod_id IN (" + Placeholders.Join(", ") + ")")
		      End If
		      If Filter.Tags.Ubound > -1 Then
		        SQL = SQL.Replace("engrams INNER JOIN mods", "engrams INNER JOIN searchable_tags ON (searchable_tags.object_id = engrams.object_id AND searchable_tags.source_table = 'engrams') INNER JOIN mods")
		        Clauses.Append("searchable_tags.tags MATCH ?" + Str(NextPlaceholder))
		        Values.Value(NextPlaceholder) = Filter.Tags.Join(" OR ")
		        NextPlaceholder = NextPlaceholder + 1
		      End If
		    End If
		    
		    If Clauses.Ubound > -1 Then
		      SQL = SQL + " WHERE " + Join(Clauses, " AND ")
		    End If
		    SQL = SQL + " ORDER BY label;"
		    
		    Dim Results As RecordSet
		    If Values.Count = 0 Then
		      Results = Self.SQLSelect(SQL)
		    Else
		      Results = Self.SQLSelect(SQL, Values)
		    End If
		    
		    Engrams = Self.RecordSetToEngram(Results)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		  Catch Err As UnsupportedOperationException
		    
		  End Try
		  
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As Text, ConsoleSafe As Boolean, IncludeExperimental As Boolean) As Beacon.LootSource()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Sources() As Beacon.LootSource
		  
		  Try
		    Dim Clauses() As String
		    If ConsoleSafe Then
		      Clauses.Append("mods.console_safe = 1")
		    End If
		    If SearchText <> "" Then
		      Clauses.Append("LOWER(label) LIKE LOWER(?1) OR LOWER(class_string) LIKE LOWER(?1)")
		    End If
		    If Not IncludeExperimental Then
		      Clauses.Append("experimental = 0")
		    End If
		    
		    Dim SQL As String = "SELECT " + Self.LootSourcesSelectColumns + ", mods.console_safe, mods.mod_id, mods.name AS mod_name FROM loot_sources INNER JOIN mods ON (loot_sources.mod_id = mods.mod_id)"
		    If Clauses.Ubound > -1 Then
		      SQL = SQL + " WHERE " + Join(Clauses, " AND ")
		    End If
		    SQL = SQL + " ORDER BY label;"
		    
		    Dim Results As RecordSet
		    If SearchText = "" Then
		      Results = Self.SQLSelect(SQL)
		    Else
		      Results = Self.SQLSelect(SQL, "%" + SearchText + "%")
		    End If
		    
		    Sources = Self.RecordSetToLootSource(Results)
		  Catch Err As UnsupportedOperationException
		    
		  End Try
		  
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance(Create As Boolean = True) As LocalData
		  If mInstance = Nil And Create = True Then
		    mInstance = New LocalData
		    Beacon.Data = mInstance
		    Dim Results As RecordSet = mInstance.SQLSelect("SELECT COUNT(class_string) AS source_count FROM loot_sources;")
		    If Results.Field("source_count").IntegerValue = 0 Then
		      mInstance.ImportLocalClasses()
		    End If
		    If Preferences.OnlineEnabled Then
		      mInstance.CheckForEngramUpdates()
		    End If
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(SQLString As String, ParamArray Values() As Variant)
		  Self.mLock.Enter
		  
		  If Values.Ubound = 0 And Values(0) <> Nil And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Dim Dict As Dictionary = Values(0)
		    Redim Values(-1)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.Count
		        Values.Append(Dict.Value(I))
		      Next
		    Catch Err As TypeMismatchException
		      Redim Values(-1)
		    End Try
		  End If
		  
		  If Values.Ubound = -1 Then
		    Self.mBase.SQLExecute(SQLString)
		    Dim Err As RuntimeException = Self.CheckError(SQLString)
		    Self.mLock.Leave
		    If Err <> Nil Then
		      Raise Err
		    End If
		    Return
		  End If
		  
		  Dim Statement As SQLitePreparedStatement = Self.mBase.Prepare(SQLString)
		  Dim Err As RuntimeException = Self.CheckError(SQLString)
		  If Err <> Nil Then
		    Self.mLock.Leave
		    Raise Err
		  End If
		  
		  For I As Integer = 0 To Values.Ubound
		    Dim Value As Variant = Values(I)
		    Select Case Value.Type
		    Case Variant.TypeInteger, Variant.TypeInt32
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_INTEGER)
		    Case Variant.TypeInt64
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_INT64)
		    Case Variant.TypeCurrency, Variant.TypeDouble, Variant.TypeSingle
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_DOUBLE)
		    Case Variant.TypeText
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_TEXT)
		      Dim StringValue As String = Value.TextValue
		      Value = StringValue
		    Case Variant.TypeNil
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_NULL)
		    Case Variant.TypeBoolean
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_BOOLEAN)
		    Case Variant.TypeObject
		      Dim Obj As Object = Value.ObjectValue
		      Select Case Obj
		      Case IsA Xojo.Core.MemoryBlock
		        Dim Mem As Xojo.Core.MemoryBlock = Value
		        Statement.BindType(I, SQLitePreparedStatement.SQLITE_BLOB)
		        Value = CType(Mem.Data, Global.MemoryBlock).StringValue(0, Mem.Size)
		      End Select
		    Else
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_TEXT)
		    End Select
		    
		    Statement.Bind(I, Value)
		  Next
		  
		  Statement.SQLExecute()
		  Err = Self.CheckError(SQLString)
		  Self.mLock.Leave
		  If Err <> Nil Then
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(SQLString As String, ParamArray Values() As Variant) As RecordSet
		  Self.mLock.Enter
		  
		  Dim RS As RecordSet
		  
		  If Values.Ubound = 0 And Values(0) <> Nil And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Dim Dict As Dictionary = Values(0)
		    Redim Values(-1)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.Count
		        Values.Append(Dict.Value(I))
		      Next
		    Catch Err As TypeMismatchException
		      Redim Values(-1)
		    End Try
		  End If
		  
		  If Values.Ubound = -1 Then
		    RS = Self.mBase.SQLSelect(SQLString)
		    Dim Err As RuntimeException = Self.CheckError(SQLString)
		    Self.mLock.Leave
		    If Err <> Nil Then
		      Raise Err
		    End If
		    Return RS
		  End If
		  
		  Dim Statement As SQLitePreparedStatement = Self.mBase.Prepare(SQLString)
		  Dim Err As RuntimeException = Self.CheckError(SQLString)
		  If Err <> Nil Then
		    Self.mLock.Leave
		    Raise Err
		  End If
		  
		  For I As Integer = 0 To Values.Ubound
		    Dim Value As Variant = Values(I)
		    Select Case Value.Type
		    Case Variant.TypeInteger, Variant.TypeInt32
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_INTEGER)
		    Case Variant.TypeInt64
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_INT64)
		    Case Variant.TypeCurrency, Variant.TypeDouble, Variant.TypeSingle
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_DOUBLE)
		    Case Variant.TypeText
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_TEXT)
		      Dim StringValue As String = Value.TextValue
		      Value = StringValue
		    Case Variant.TypeNil
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_NULL)
		    Case Variant.TypeBoolean
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_BOOLEAN)
		    Case Variant.TypeObject
		      Dim Obj As Object = Value.ObjectValue
		      Select Case Obj
		      Case IsA Xojo.Core.MemoryBlock
		        Dim Mem As Xojo.Core.MemoryBlock = Value
		        Statement.BindType(I, SQLitePreparedStatement.SQLITE_BLOB)
		        Value = CType(Mem.Data, Global.MemoryBlock).StringValue(0, Mem.Size)
		      End Select
		    Else
		      Statement.BindType(I, SQLitePreparedStatement.SQLITE_TEXT)
		    End Select
		    
		    Statement.Bind(I, Value)
		  Next
		  
		  RS = Statement.SQLSelect()
		  Err = Self.CheckError(SQLString)
		  Self.mLock.Leave
		  If Err <> Nil Then
		    Raise Err
		  End If
		  Return RS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Start()
		  Call SharedInstance(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaggedEngrams(Tag As Text) As Beacon.Engram()
		  Dim SelectSQL As String = Self.EngramSelectSQL.Replace("engrams INNER JOIN mods", "engrams INNER JOIN searchable_tags ON (searchable_tags.object_id = engrams.object_id AND searchable_tags.source_table = 'engrams') INNER JOIN mods")
		  
		  Dim Engrams() As Beacon.Engram
		  Try
		    Tag = Beacon.Engram.NormalizeTag(Tag)
		    Dim RS As RecordSet = Self.SQLSelect(SelectSQL + " WHERE searchable_tags.tags MATCH ?1;", Tag)
		    If RS.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Engrams = Self.RecordSetToEngram(RS)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		  Catch Err As UnsupportedOperationException
		  End Try  
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TextToDate(Source As Text) As Xojo.Core.Date
		  Dim Now As New Date
		  Dim TempDate As Xojo.Core.Date = Xojo.Core.Date.FromText(Source)
		  Return New Xojo.Core.Date(TempDate.SecondsFrom1970 + (Now.GMTOffset * 3600), New Xojo.Core.TimeZone("UTC"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variable(Key As String) As String
		  Try
		    Dim Results As RecordSet = Self.SQLSelect("SELECT value FROM variables WHERE LOWER(key) = LOWER(?1);", Key)
		    If Results.RecordCount = 1 Then
		      Return Results.Field("value").StringValue
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
		  Catch Err As UnsupportedOperationException
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
		Private mCheckingForUpdates As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As LocalData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingImports() As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdater As Xojo.Net.HTTPSocket
	#tag EndProperty


	#tag Constant, Name = EngramSelectSQL, Type = String, Dynamic = False, Default = \"SELECT engrams.path\x2C engrams.label\x2C engrams.availability\x2C engrams.tags\x2C mods.console_safe\x2C mods.mod_id\x2C mods.name AS mod_name FROM engrams INNER JOIN mods ON (engrams.mod_id \x3D mods.mod_id)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LootSourcesSelectColumns, Type = String, Dynamic = False, Default = \"class_string\x2C label\x2C availability\x2C multiplier_min\x2C multiplier_max\x2C uicolor\x2C sort_order\x2C experimental\x2C notes\x2C requirements", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_DatabaseUpdated, Type = Text, Dynamic = False, Default = \"Database Updated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_EngramsChanged, Type = Text, Dynamic = False, Default = \"Engrams Changed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportFailed, Type = Text, Dynamic = False, Default = \"Import Failed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportSuccess, Type = Text, Dynamic = False, Default = \"Import Success", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_NewAppNotification, Type = Text, Dynamic = False, Default = \"New App Notification", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SchemaVersion, Type = Double, Dynamic = False, Default = \"9", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UserModID, Type = String, Dynamic = False, Default = \"23ecf24c-377f-454b-ab2f-d9d8f31a5863", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
