#tag Class
Protected Class DataSource
Implements NotificationKit.Receiver
	#tag Method, Flags = &h0
		Function AdditionalSupportFiles() As Dictionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub BeginTransaction()
		  If Not Self.mAllowWriting Then
		    Var Err As New DatabaseException
		    Err.Message = "Cannot begin transaction in read-only database."
		    Raise Err
		  End If
		  
		  Self.ObtainLock()
		  
		  If Self.mTransactions.LastIndex = -1 Then
		    Self.mTransactions.AddAt(0, "")
		    Self.mDatabase.ExecuteSQL("BEGIN TRANSACTION;")
		  Else
		    Var Savepoint As String = "Savepoint_" + EncodeHex(Crypto.GenerateRandomBytes(4))
		    Self.mTransactions.AddAt(0, Savepoint)
		    Self.mDatabase.ExecuteSQL("SAVEPOINT " + Savepoint + ";")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub BuildIndexes()
		  Self.DefineIndexes()
		  
		  Self.BeginTransaction()
		  For Idx As Integer = 0 To Self.mIndexes.LastIndex
		    Self.SQLExecute(Self.mIndexes(Idx).CreateStatement)
		  Next Idx
		  RaiseEvent IndexesBuilt()
		  Self.CommitTransaction()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CleanForeignKeyViolations()
		  Var Tables As New Dictionary
		  Try
		    Var TableRows As RowSet = Self.SQLSelect("SELECT sqlite_master.name, info.name AS primary_key FROM sqlite_master INNER JOIN pragma_table_info(sqlite_master.name) AS info ON (info.pk = 1) WHERE sqlite_master.type = 'table' AND sqlite_master.name NOT LIKE 'sqlite_%';")
		    While Not TableRows.AfterLastRow
		      Tables.Value(TableRows.Column("name").StringValue) = TableRows.Column("primary_key").StringValue
		      TableRows.MoveToNextRow
		    Wend
		  Catch Err As RuntimeException
		    App.Log("Failed to clean foreign key violations because database schema is not ready.")
		    Return
		  End Try
		  
		  For Each Entry As DictionaryEntry In Tables
		    Var TableName As String = Entry.Key
		    Var PrimaryKeyName As String = Entry.Value
		    
		    Var ViolationRows As RowSet = Self.SQLSelect("SELECT violations.rowid, constraints.""from"" AS source_column, constraints.""table"" AS target_table, constraints.""to"" AS target_column FROM pragma_foreign_key_check(?1) AS violations INNER JOIN pragma_foreign_key_list(?1) AS constraints ON (violations.fkid = constraints.id);", TableName)
		    While Not ViolationRows.AfterLastRow
		      Var RowId As Integer = ViolationRows.Column("rowid").IntegerValue
		      Var SourceColumnName As String = ViolationRows.Column("source_column").StringValue
		      Var TargetTableName As String = ViolationRows.Column("target_table").StringValue
		      Var TargetColumnName As String = ViolationRows.Column("target_column").StringValue
		      Var Rows As RowSet = Self.SQLSelect("SELECT " + Self.EscapeIdentifier(PrimaryKeyName) + ", " + Self.EscapeIdentifier(SourceColumnName) + " FROM " + Self.EscapeIdentifier(TableName) + " WHERE rowid = ?1;", RowId)
		      While Not Rows.AfterLastRow
		        Try
		          Self.SQLExecute("DELETE FROM " + Self.EscapeIdentifier(TableName) + " WHERE rowid = ?1;", RowId)
		        Catch Err As RuntimeException
		        End Try
		        
		        Try
		          Var PrimaryKey As String = Rows.Column(PrimaryKeyName).StringValue
		          Var ViolatedValue As String = Rows.Column(SourceColumnName).StringValue
		          App.Log("Removed row from " + TableName + "(" + PrimaryKeyName + "=" + PrimaryKey + "): " + TargetTableName + "." + TargetColumnName + " has no member " + ViolatedValue + ".")
		        Catch Err As RuntimeException
		        End Try
		        
		        Rows.MoveToNextRow
		      Wend
		      
		      ViolationRows.MoveToNextRow
		    Wend
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  RaiseEvent Close()
		  
		  If (Self.mDatabase Is Nil) = False Then
		    Try
		      Self.mDatabase.ExecuteSQL("PRAGMA optimize;")
		      Self.mDatabase.Close
		      Self.ConnectionCount = Self.ConnectionCount - 1
		    Catch Err As RuntimeException
		    End Try
		    Self.mDatabase = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CommitTransaction()
		  If Not Self.mAllowWriting Then
		    Var Err As New DatabaseException
		    Err.Message = "Cannot commit transaction in read-only database."
		    Raise Err
		  End If
		  
		  If Self.mTransactions.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.RemoveAt(0)
		  
		  Try
		    If Savepoint.IsEmpty Then
		      Self.mDatabase.ExecuteSQL("COMMIT TRANSACTION;")
		    Else
		      Self.mDatabase.ExecuteSQL("RELEASE SAVEPOINT " + Savepoint + ";")
		    End If
		    Self.ReleaseLock()
		  Catch Err As RuntimeException
		    // Put the transaction back into the stack
		    Self.mTransactions.AddAt(0, Savepoint)
		    Self.ReleaseLock()
		    Raise Err
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConnectionCount() As Integer
		  If Self.mConnectionCounts Is Nil Then
		    Return 0
		  End If
		  
		  Var Identifier As String = Self.Identifier
		  Return Self.mConnectionCounts.Lookup(Identifier, 0).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConnectionCount(Assigns Value As Integer)
		  If Self.mConnectionCounts Is Nil Then
		    Self.mConnectionCounts = New Dictionary
		  End If
		  
		  Self.mConnectionCounts.Value(Self.Identifier) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(AllowWriting As Boolean)
		  Const YieldInterval = 75
		  
		  Self.mAllowWriting = AllowWriting
		  
		  Var SchemaVersion As Integer = RaiseEvent GetSchemaVersion
		  Var DatafileName As String = Self.Identifier + ".sqlite"
		  Var LibrariesFolder As FolderItem = App.LibrariesFolder
		  Var DatabaseFile As FolderItem = LibrariesFolder.Child(DatafileName)
		  Self.mDatabase = New SQLiteDatabase
		  Self.mDatabase.ThreadYieldInterval = YieldInterval
		  Self.mDatabase.DatabaseFile = DatabaseFile
		  Var Connected As Boolean
		  If DatabaseFile.Exists Then
		    Try
		      Self.mDatabase.Connect
		      Connected = True
		    Catch Err As RuntimeException
		      Self.mDatabase.Close
		      
		      Var Parent As FolderItem = DatabaseFile.Parent
		      Var Bound As Integer = Parent.Count - 1
		      For Idx As Integer = Bound DownTo 0
		        If Parent.ChildAt(Idx).Name.BeginsWith(DatafileName) Then
		          Parent.ChildAt(Idx).Remove
		        End If
		      Next Idx
		    End Try
		  End If
		  
		  Var BuildSchema As Boolean
		  Try
		    If Connected Then
		      If Self.mDatabase.UserVersion <> SchemaVersion Then
		        Self.mDatabase.Close
		        Self.mDatabase = Nil
		        
		        Var WALFile As FolderItem = LibrariesFolder.Child(DatafileName + "-wal")
		        Var SHMFile As FolderItem = LibrariesFolder.Child(DatafileName + "-shm")
		        
		        DatabaseFile.Remove
		        If WALFile.Exists Then
		          WALFile.Remove
		        End If
		        If SHMFile.Exists Then
		          SHMFile.Remove
		        End If
		        
		        Self.mDatabase = New SQLiteDatabase
		        Self.mDatabase.ThreadYieldInterval = YieldInterval
		        Self.mDatabase.DatabaseFile = DatabaseFile
		        
		        Self.mDatabase.CreateDatabase
		        BuildSchema = True
		      End If
		    Else
		      Self.mDatabase.CreateDatabase
		      BuildSchema = True
		    End If
		  Catch Err As RuntimeException
		    // I guess we'll use an in-memory database
		    Self.mDatabase = New SQLiteDatabase
		    Self.mDatabase.ThreadYieldInterval = YieldInterval
		    Self.mDatabase.CreateDatabase
		    BuildSchema = True
		  End Try
		  
		  Self.mDatabase.WriteAheadLogging = True
		  
		  If BuildSchema Then
		    Var WasWriteable As Boolean = Self.mAllowWriting
		    Self.mAllowWriting = True
		    
		    Self.BeginTransaction()
		    Self.SQLExecute("CREATE TABLE variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT COLLATE NOCASE NOT NULL);")
		    Self.SQLExecute("CREATE TABLE content_packs (content_pack_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, game_id TEXT COLLATE NOCASE NOT NULL, marketplace TEXT COLLATE NOCASE NOT NULL, marketplace_id TEXT NOT NULL, name TEXT COLLATE NOCASE NOT NULL, console_safe INTEGER NOT NULL, default_enabled INTEGER NOT NULL, type INTEGER NOT NULL CHECK (type & (type - 1) = 0), last_update INTEGER NOT NULL, required BOOLEAN NOT NULL DEFAULT FALSE, is_local BOOLEAN GENERATED ALWAYS AS (type = " + Beacon.ContentPack.TypeLocal.ToString(Locale.Raw, "0") + ") STORED, is_official BOOLEAN GENERATED ALWAYS AS (type = " + Beacon.ContentPack.TypeOfficial.ToString(Locale.Raw, "0") + ") STORED);")
		    RaiseEvent BuildSchema
		    Self.mDatabase.UserVersion = SchemaVersion
		    Self.BuildIndexes
		    Self.CommitTransaction()
		    
		    Self.mAllowWriting = WasWriteable
		  End If
		  
		  Self.mDatabase.ExecuteSQL("PRAGMA cache_size = -10000000;")
		  Self.mDatabase.ExecuteSQL("PRAGMA analysis_limit = 0;")
		  Self.ForeignKeys = True
		  
		  RaiseEvent Open()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountContentPacks(Filter As String, Types As Integer = Beacon.ContentPack.TypeAny) As Integer
		  Var Clauses() As String
		  Var Values() As Variant
		  If Filter.IsEmpty = False Then
		    Clauses.Add("name LIKE :filter ESCAPE '\'")
		    Values.Add("%" + Self.EscapeLikeValue(Filter) + "%")
		  End If
		  
		  Clauses.Add("type & :types > 0")
		  Values.Add(Types)
		  
		  Var SQL As String = "SELECT COUNT(content_pack_id) FROM content_packs"
		  If Clauses.Count > 0 Then
		    SQL = SQL + " WHERE " + String.FromArray(Clauses, " AND ")
		  End If
		  SQL = SQL + ";"
		  
		  Var Results As RowSet = Self.SQLSelect(SQL, Values)
		  Return Results.ColumnAt(0).IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateLocalContentPack(PackName As String, DoCloudExport As Boolean) As Beacon.ContentPack
		  Return Self.CreateLocalContentPack(PackName, "", "", DoCloudExport)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateLocalContentPack(PackName As String, Marketplace As String, MarketplaceId As String, DoCloudExport As Boolean) As Beacon.ContentPack
		  Var ContentPackId As String
		  If MarketplaceId.IsEmpty Or Marketplace.IsEmpty Then
		    ContentPackId = Beacon.UUID.v4
		    Marketplace = ""
		    MarketplaceId = ""
		  Else
		    ContentPackId = Beacon.ContentPack.GenerateLocalContentPackId(Marketplace, MarketplaceId)
		  End If
		  Self.BeginTransaction()
		  Var Rows As RowSet = Self.SQLSelect("INSERT OR IGNORE INTO content_packs (content_pack_id, game_id, marketplace, marketplace_id, name, console_safe, default_enabled, type, last_update, required) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10) RETURNING *;", ContentPackId, Self.Identifier, Marketplace, MarketplaceId, PackName, False, False, Beacon.ContentPack.TypeLocal, DateTime.Now.SecondsFrom1970, False)
		  If Rows.RowCount <> 1 Then
		    Self.RollbackTransaction()
		    Return Nil
		  End If
		  Self.CommitTransaction()
		  If DoCloudExport Then
		    Self.ExportCloudFiles()
		  End If
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Rows)
		  Return Packs(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DefineIndexes()
		  If Self.mIndexes.Count > 0 Then
		    Return
		  End If
		  
		  Self.mIndexes.Add(New Beacon.DataIndex("content_packs", True, "marketplace", "marketplace_id", "WHERE type != " + Beacon.ContentPack.TypeLocal.ToString(Locale.Raw, "0")))
		  Self.mIndexes.Add(New Beacon.DataIndex("content_packs", True, "marketplace", "marketplace_id", "WHERE type = " + Beacon.ContentPack.TypeLocal.ToString(Locale.Raw, "0") + " AND (marketplace != '' OR marketplace_id != '')"))
		  
		  Var Indexes() As Beacon.DataIndex = RaiseEvent DefineIndexes
		  If (Indexes Is Nil) = False Then
		    For Each Index As Beacon.DataIndex In Indexes
		      Self.mIndexes.Add(Index)
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteContentPack(Pack As Beacon.ContentPack, DoCloudExport As Boolean) As Boolean
		  Return Self.DeleteContentPack(Pack.ContentPackId, DoCloudExport)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteContentPack(ContentPackId As String, DoCloudExport As Boolean) As Boolean
		  Var Deleted As Boolean = RaiseEvent DeleteContentPack(ContentPackId)
		  If Deleted And DoCloudExport Then
		    Self.ExportCloudFiles()
		  End If
		  Return Deleted
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  NotificationKit.Ignore(Self, UserCloud.Notification_SyncFinished)
		  
		  Self.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DropIndexes()
		  Self.DefineIndexes()
		  
		  Self.BeginTransaction()
		  For Idx As Integer = 0 To Self.mIndexes.LastIndex
		    Self.SQLExecute(Self.mIndexes(Idx).DropStatement)
		  Next Idx
		  Self.CommitTransaction()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EditContentPack(Pack As Beacon.ContentPack, NewName As String, NewMarketplace As String, NewMarketplaceId As String) As Boolean
		  Var Changed As Boolean
		  
		  Self.BeginTransaction()
		  
		  If Pack.Name.Compare(NewName, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.SQLExecute("UPDATE content_packs SET name = ?2 WHERE content_pack_id = ?1;", Pack.ContentPackId, NewName)
		    Changed = True
		  End If
		  
		  Var OldContentPackId, NewContentPackId As String
		  If (NewMarketplace.IsEmpty Or NewMarketplaceId.IsEmpty) And (Pack.Marketplace.IsEmpty = False Or Pack.MarketplaceId.IsEmpty = False) Then
		    // Switch to random uuid
		    OldContentPackId = Pack.ContentPackId
		    NewContentPackId = Beacon.UUID.v4
		  ElseIf Pack.MarketplaceId.Compare(NewMarketplaceId, ComparisonOptions.CaseSensitive) <> 0 Or Pack.Marketplace.Compare(NewMarketplace, ComparisonOptions.CaseSensitive) <> 0 Then
		    OldContentPackId = Pack.ContentPackId
		    NewContentPackId = Beacon.ContentPack.GenerateLocalContentPackId(NewMarketplace, NewMarketplaceId)
		  End If
		  
		  If OldContentPackId <> NewContentPackId Then
		    Var Rows As RowSet = Self.SQLSelect("SELECT content_pack_id FROM content_packs WHERE content_pack_id = ?1;", NewContentPackId)
		    If Rows.RowCount <> 0 Then
		      Self.RollbackTransaction()
		      Return False
		    End If
		    
		    // Need to migrate
		    Var RunMigrations As Boolean
		    If Self.mContentPackMigration Is Nil Then
		      Self.mContentPackMigration = New Dictionary
		      RunMigrations = True
		    End If
		    
		    Self.SQLExecute("UPDATE content_packs SET content_pack_id = ?2, marketplace = ?3, marketplace_id = ?4 WHERE content_pack_id = ?1;", OldContentPackId, NewContentPackId, NewMarketplace, NewMarketplaceId)
		    Self.ScheduleContentPackMigration(OldContentPackId, NewContentPackId)
		    
		    If RunMigrations Then
		      Self.RunContentPackMigrations()
		      Self.mContentPackMigration = Nil
		    End If
		    
		    Changed = True
		  End If
		  
		  If Changed Then
		    Self.CommitTransaction()
		    Self.ExportCloudFiles()
		  Else
		    Self.RollbackTransaction()
		  End If
		  
		  Return Changed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptyCaches()
		  RaiseEvent EmptyCaches
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function EscapeIdentifier(Identifier As String) As String
		  Return """" + Identifier.ReplaceAll("""", """""") + """"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function EscapeLikeValue(Value As String, EscapeChar As String = "\") As String
		  Return Value.ReplaceAll("%", EscapeChar + "%").ReplaceAll("_", EscapeChar + "_")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExportCloudFiles()
		  // This way changing lots of engrams rapidly won't require a write to disk
		  // after each action
		  
		  Var MainInstance As Beacon.DataSource = Self.MainInstance // Could be self
		  If MainInstance Is Nil Then
		    Return
		  End If
		  
		  If MainInstance.mExportCloudFilesCallbackKey.IsEmpty = False Then
		    CallLater.Cancel(MainInstance.mExportCloudFilesCallbackKey)
		    MainInstance.mExportCloudFilesCallbackKey = ""
		  End If
		  
		  MainInstance.mExportCloudFilesCallbackKey = CallLater.Schedule(250, AddressOf MainInstance.ExportCloudFiles_Delayed)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExportCloudFiles_Delayed()
		  If Self.mExportCloudFilesCallbackKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mExportCloudFilesCallbackKey)
		    Self.mExportCloudFilesCallbackKey = ""
		  End If
		  
		  If Self.Importing Then
		    // Don't write while importing, so wait a little longer
		    Self.ExportCloudFiles()
		    Return
		  End If
		  
		  RaiseEvent ExportCloudFiles()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindContentPackCounterpart(ContentPack As Beacon.ContentPack) As Beacon.ContentPack
		  If ContentPack Is Nil Then
		    Return Nil
		  End If
		  
		  Return Self.FindContentPackCounterpart(ContentPack.ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindContentPackCounterpart(ContentPackId As String) As Beacon.ContentPack
		  Var Rows As RowSet = Self.SQLSelect("SELECT marketplace, marketplace_id, type FROM content_packs WHERE content_pack_id = ?1;", ContentPackId)
		  If Rows.RowCount = 0 Then
		    Return Nil
		  End If
		  
		  Var Marketplace As String = Rows.Column("marketplace").StringValue
		  Var MarketplaceId As String = Rows.Column("marketplace_id").StringValue
		  Var CounterpartType As Integer
		  Select Case Rows.Column("type").IntegerValue
		  Case Beacon.ContentPack.TypeOfficial, Beacon.ContentPack.TypeThirdParty
		    CounterpartType = Beacon.ContentPack.TypeLocal
		  Else
		    CounterpartType = Beacon.ContentPack.TypeOfficial Or Beacon.ContentPack.TypeThirdParty
		  End Select
		  Return Self.GetContentPack(Marketplace, MarketplaceId, CounterpartType)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ForeignKeys() As Boolean
		  Try
		    Var Tmp As RowSet = Self.SQLSelect("PRAGMA foreign_keys;")
		    Return (Tmp Is Nil) = False And Tmp.ColumnAt(0).IntegerValue = 1
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Checking foreign key status")
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ForeignKeys(Assigns Value As Boolean)
		  If Self.ForeignKeys = Value Then
		    Return
		  End If
		  
		  If Value Then
		    Try
		      Self.SQLExecute("PRAGMA foreign_keys = ON;")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Turning on foreign keys")
		    End Try
		  Else
		    Try
		      Self.SQLExecute("PRAGMA foreign_keys = OFF;")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Turning off foreign keys")
		    End Try
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPack(Marketplace As String, MarketplaceId As String, Types As Integer) As Beacon.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT " + Self.ContentPackColumns + " FROM content_packs WHERE marketplace = ?1 AND marketplace_id = ?2 AND type & ?3 > 0 ORDER BY type;", Marketplace, MarketplaceId, Types)
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Results)
		  If Packs.Count = 1 Then
		    Return Packs(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Type As Integer) As Beacon.ContentPack()
		  Return Self.GetContentPacks("", Type, 0, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Type As Integer, Offset As Integer, Limit As Integer) As Beacon.ContentPack()
		  Return Self.GetContentPacks("", Type, Offset, Limit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Filter As String = "") As Beacon.ContentPack()
		  Return Self.GetContentPacks(Filter, Beacon.ContentPack.TypeAny, 0, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Filter As String, Type As Integer) As Beacon.ContentPack()
		  Return Self.GetContentPacks(Filter, Type, 0, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Filter As String, Offset As Integer, Limit As Integer) As Beacon.ContentPack()
		  Return Self.GetContentPacks(Filter, Beacon.ContentPack.TypeAny, Offset, Limit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Filter As String, Types As Integer, Offset As Integer, Limit As Integer) As Beacon.ContentPack()
		  Var Clauses() As String
		  Var Values() As Variant
		  If Filter.IsEmpty = False Then
		    Clauses.Add("(name LIKE :filter ESCAPE '\' OR marketplace_id LIKE :filter ESCAPE '/')")
		    Values.Add("%" + Self.EscapeLikeValue(Filter) + "%")
		  End If
		  Clauses.Add("type & :types > 0")
		  Values.Add(Types)
		  
		  Var SQL As String = "SELECT " + Self.ContentPackColumns + " FROM content_packs"
		  If Clauses.Count > 0 Then
		    SQL = SQL + " WHERE " + String.FromArray(Clauses, " AND ")
		  End If
		  SQL = SQL + " ORDER BY name"
		  If Limit > 0 Then
		    SQL = SQL + " LIMIT " + Limit.ToString(Locale.Raw, "0") + " OFFSET " + Offset.ToString(Locale.Raw, "0")
		  End If
		  SQL = SQL + ";"
		  
		  Var Results As RowSet = Self.SQLSelect(SQL, Values)
		  Return Beacon.ContentPack.FromDatabase(Results)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPacks(Marketplace As String, MarketplaceId As String) As Beacon.ContentPack()
		  Var Results As RowSet = Self.SQLSelect("SELECT " + Self.ContentPackColumns + " FROM content_packs WHERE marketplace = ?1 AND marketplace_id = ?2 ORDER BY type", Marketplace, MarketplaceId)
		  Return Beacon.ContentPack.FromDatabase(Results)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPackWithId(ContentPackId As String) As Beacon.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT " + Self.ContentPackColumns + " FROM content_packs WHERE content_pack_id = ?1;", ContentPackId)
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Results)
		  If Packs.Count = 1 Then
		    Return Packs(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasContent() As Boolean
		  Try
		    Var Rows As RowSet = Self.SQLSelect("SELECT EXISTS(SELECT 1 FROM variables) AS populated;")
		    Return Rows.Column("populated").BooleanValue
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Var Err As New RuntimeException
		  Err.Message = "DataSource.Identifier was not overridden"
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Import(ShouldTruncate As Boolean, Payloads() As Dictionary, Timestamp As NullableDouble, IsUserData As Boolean) As Boolean
		  // The DataUpdater module will call this method inside a thread with its own database connection
		  
		  Var StatusData As New Dictionary
		  Var OriginalDepth As Integer = Self.TransactionDepth
		  Self.mImporting = True
		  Self.BeginTransaction()
		  Self.SQLExecute("PRAGMA defer_foreign_keys = TRUE;")
		  Self.DropIndexes()
		  
		  If ShouldTruncate Then
		    Try
		      RaiseEvent ImportTruncate
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Truncating")
		      While Self.TransactionDepth > OriginalDepth
		        Self.RollbackTransaction
		      Wend
		      Self.mImporting = False
		      Return False
		    End Try
		  End If
		  
		  For Each Parsed As Dictionary In Payloads
		    If Parsed.HasKey("payloads") = False Then
		      Continue
		    End If
		    
		    Var ChildPayloads() As Variant = Parsed.Value("payloads")
		    For Each ChildPayload As Dictionary In ChildPayloads
		      Var GameId As String = ChildPayload.Lookup("gameId", "")
		      If GameId <> Self.Identifier Then
		        Continue
		      End If
		      
		      Try
		        If Import(ChildPayload, StatusData, IsUserData) = False Then
		          Self.RollbackTransaction
		          Self.mImporting = False
		          Return False
		        End If
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Importing")
		        While Self.TransactionDepth > OriginalDepth
		          Self.RollbackTransaction
		        Wend
		        Self.mImporting = False
		        Return False
		      End Try
		    Next
		  Next
		  
		  If (Timestamp Is Nil) = False Then
		    Self.LastSyncTimestamp = Timestamp
		  End If
		  Self.BuildIndexes()
		  
		  Self.RunContentPackMigrations()
		  Self.CleanForeignKeyViolations()
		  
		  Var Rows As RowSet = Self.SQLSelect("PRAGMA foreign_key_check;")
		  If Rows.RowCount > 0 Then
		    While Not Rows.AfterLastRow
		      Var RowId As Integer = Rows.Column("rowid").IntegerValue
		      Var TableName As String = Rows.Column("table").StringValue
		      Var TargetTableName As String = Rows.Column("parent").StringValue
		      
		      If TargetTableName = "content_packs" And (TableName = "loot_containers" Or TableName = "engrams" Or TableName = "creatures" Or TableName = "spawn_points") Then
		        Var Row As RowSet = Self.SQLSelect("SELECT path, content_pack_id FROM " + TableName + " WHERE rowid = ?1;", RowId)
		        System.DebugLog("Object " + Row.Column("path").StringValue + " of " + TableName + " references non-existent content_pack_id " + Row.Column("content_pack_id").StringValue + ".")
		      Else
		        System.DebugLog("Row " + RowId.ToString(Locale.Raw, "0") + " of table " + TableName + " is missing a reference to " + TargetTableName + ".")
		      End If
		      
		      Rows.MoveToNextRow
		    Wend
		    
		    While Self.TransactionDepth > OriginalDepth
		      Self.RollbackTransaction
		    Wend
		    Self.mImporting = False
		    Return False
		  End If
		  
		  Try
		    Self.CommitTransaction()
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Trying to commit import")
		    While Self.TransactionDepth > OriginalDepth
		      Self.RollbackTransaction
		    Wend
		    Self.mImporting = False
		    Return False
		  End Try
		  
		  Try
		    RaiseEvent ImportCleanup(StatusData)
		    
		    If ShouldTruncate Then
		      RaiseEvent ImportCloudFiles()
		    End If
		    Self.mImporting = False
		    Return True
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Cleaning up after import")
		    While Self.TransactionDepth > OriginalDepth
		      Self.RollbackTransaction
		    Wend
		    Self.mImporting = False
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportChainBegin()
		  Self.mContentPackMigration = New Dictionary
		  Try
		    RaiseEvent ImportStarting
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Starting import")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportChainFinished()
		  Try
		    RaiseEvent ImportFinishing
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Finishing import")
		  End Try
		  Self.mContentPackMigration = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportCloudFiles()
		  If Self.mAllowWriting Then
		    RaiseEvent ImportCloudFiles()
		    NotificationKit.Post(Self.Notification_ImportCloudFilesFinished, Self.Identifier)
		    Return
		  End If
		  
		  Var Th As New Beacon.Thread
		  Th.DebugIdentifier = CurrentMethodName
		  Th.Retain
		  AddHandler Th.Run, AddressOf ImportCloudFiles_Threaded
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportCloudFiles_Threaded(Sender As Beacon.Thread)
		  Var Database As Beacon.DataSource = Self.WriteableInstance()
		  If (Database Is Nil) = False Then
		    Database.ImportCloudFiles()
		  End If
		  Sender.Release
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Importing() As Boolean
		  Return Self.mImporting
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function InTransaction() As Boolean
		  Return Self.mTransactions.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastSyncDateTime(Assigns Value As DateTime)
		  If Value Is Nil Then
		    Self.LastSyncTimestamp = 0
		  Else
		    Self.LastSyncTimestamp = Value.SecondsFrom1970
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSyncDateTime(Local As Boolean) As DateTime
		  Var Timestamp As Double = Self.LastSyncTimestamp
		  If Timestamp = 0 Then
		    Return Nil
		  End If
		  
		  If Local Then
		    Return New DateTime(Timestamp)
		  Else
		    Return New DateTime(Timestamp, New TimeZone(0))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSyncTimestamp() As Double
		  Var Value As String = Self.Variable("Last Sync")
		  If Value.IsEmpty Then
		    Return 0
		  End If
		  
		  Try
		    Return Double.FromString(Value, Locale.Raw)
		  Catch Err As RuntimeException
		    Return 0
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastSyncTimestamp(Assigns Value As Double)
		  Self.Variable("Last Sync") = Value.ToString(Locale.Raw, "0")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainInstance() As Beacon.DataSource
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MassageValues(Values() As Variant) As Variant()
		  Var FinalValues() As Variant
		  If Values.LastIndex = 0 And (Values(0) Is Nil) = False And Values(0).Type = Variant.TypeObject And Values(0).ObjectValue IsA Dictionary Then
		    // Dictionary keys are placeholder values, values are... values
		    Var Dict As Dictionary = Values(0)
		    
		    Try
		      // I know this line looks insane, but it's correct. Placeholders start at 1.
		      For I As Integer = 1 To Dict.KeyCount
		        FinalValues.Add(Dict.Value(I))
		      Next
		    Catch Err As RuntimeException
		      FinalValues.ResizeTo(-1)
		    End Try
		  ElseIf Values.LastIndex = 0 And Values(0).IsArray Then
		    FinalValues = Values(0)
		  Else
		    FinalValues.ResizeTo(Values.LastIndex)
		    For Idx As Integer = 0 To Values.LastIndex
		      FinalValues(Idx) = Values(Idx)
		    Next Idx
		  End If
		  
		  For Idx As Integer = 0 To FinalValues.LastIndex
		    Var Value As Variant = FinalValues(Idx)
		    If Value.Type <> Variant.TypeObject Then
		      Continue
		    End If
		    Select Case Value.ObjectValue
		    Case IsA MemoryBlock
		      Var Mem As MemoryBlock = Value
		      FinalValues(Idx) = Mem.StringValue(0, Mem.Size)
		    End Select
		  Next Idx
		  
		  Return FinalValues
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mOptimizeThread_Run(Sender As Beacon.Thread)
		  #Pragma Unused Sender
		  
		  Self.Optimize()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case UserCloud.Notification_SyncFinished
		    Var Actions() As Dictionary
		    Try
		      Actions = Notification.UserData
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Getting user cloud sync actions")
		      Return
		    End Try
		    
		    If Actions.Count > 0 Then
		      RaiseEvent CloudSyncFinished(Actions)
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ObtainLock()
		  // This method exists to provide easy insertion points for debug data
		  
		  If Self.mAllowWriting Then
		    RaiseEvent ObtainLock()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Optimize()
		  If Self.mAllowWriting Then
		    Try
		      Self.SQLExecute("ANALYZE;")
		      Self.SQLExecute("REINDEX;")
		      Self.SQLExecute("VACUUM;")
		      App.Log("Database " + Self.Identifier + " has been optimized.")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to optimize database")
		    End Try
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PerformMaintenance()
		  RaiseEvent PerformMaintenance
		  
		  Self.CleanForeignKeyViolations()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Prefix() As String
		  Return Self.Identifier.Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Prepare(Query As String, ParamArray Types() As Integer) As SQLitePreparedStatement
		  Var Statement As SQLitePreparedStatement = Self.mDatabase.Prepare(Query)
		  For Idx As Integer = 0 To Types.LastIndex
		    Statement.BindType(Idx, Types(Idx))
		  Next
		  Return Statement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReleaseLock()
		  // This method exists to provide easy insertion points for debug data
		  
		  If Self.mAllowWriting Then
		    RaiseEvent ReleaseLock()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RollbackTransaction()
		  If Not Self.mAllowWriting Then
		    Var Err As New DatabaseException
		    Err.Message = "Cannot rollback transaction in read-only database."
		    Raise Err
		  End If
		  
		  If Self.mTransactions.LastIndex = -1 Then
		    Return
		  End If
		  
		  Var Savepoint As String = Self.mTransactions(0)
		  Self.mTransactions.RemoveAt(0)
		  
		  Try
		    If Savepoint.IsEmpty Then
		      Self.mDatabase.ExecuteSQL("ROLLBACK TRANSACTION;")
		    Else
		      Self.mDatabase.ExecuteSQL("ROLLBACK TRANSACTION TO SAVEPOINT " + Savepoint + ";")
		      Self.mDatabase.ExecuteSQL("RELEASE SAVEPOINT " + Savepoint + ";")
		    End If
		    Self.ReleaseLock()
		  Catch Err As RuntimeException
		    // Put the transaction back into the stack
		    Self.mTransactions.AddAt(0, Savepoint)
		    Self.ReleaseLock()
		    Raise Err
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunContentPackMigrations()
		  If Self.mContentPackMigration Is Nil Then
		    Return
		  End If
		  
		  Var Keys() As Variant = Self.mContentPackMigration.Keys
		  For Each Key As Variant In Keys
		    Var FromContentPackId As String = Key
		    Var ToContentPackId As String = Self.mContentPackMigration.Value(Key)
		    
		    Try
		      App.Log("Migrating content pack data from " + FromContentPackId + " to " + ToContentPackId + "…")
		      RaiseEvent MigrateContentPackData(FromContentPackId, ToContentPackId)
		      App.Log("Migration complete")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Migrating content pack data")
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveContentPack(Pack As Beacon.ContentPack, DoCloudExport As Boolean, Force As Boolean = False) As Boolean
		  If Pack Is Nil Or Pack.GameId <> Self.Identifier Then
		    Return False
		  End If
		  
		  // If the pack is local, work only with local packs. If the pack is official, work only with official packs.
		  // No conversion should ever happen between local and official.
		  
		  Var Rows As RowSet
		  If Pack.MarketplaceId.IsEmpty Then
		    Rows = Self.SQLSelect("SELECT content_pack_id, last_update FROM content_packs WHERE content_pack_id = ?1;", Pack.ContentPackId)
		  Else
		    Rows = Self.SQLSelect("SELECT content_pack_id, last_update FROM content_packs WHERE marketplace = ?1 AND marketplace_id = ?2 AND type = ?3;", Pack.Marketplace, Pack.MarketplaceId, Pack.Type)
		  End If
		  
		  Var DidSave as Boolean
		  Var NewContentPackId As String = Pack.ContentPackId
		  Var ShouldInsert As Boolean = True
		  If Rows.RowCount > 0 Then
		    While Not Rows.AfterLastRow
		      Var OldContentPackId As String = Rows.Column("content_pack_id").StringValue
		      If OldContentPackId = NewContentPackId Then
		        If Force Or Pack.LastUpdate > Rows.Column("last_update").DoubleValue Then
		          Self.SQLExecute("UPDATE content_packs SET name = ?2, console_safe = ?3, default_enabled = ?4, marketplace = ?5, marketplace_id = ?6, type = ?7, last_update = ?8, game_id = ?9, required = ?10 WHERE content_pack_id = ?1;", Pack.ContentPackId, Pack.Name, Pack.IsConsoleSafe, Pack.IsDefaultEnabled, Pack.Marketplace, Pack.MarketplaceId, Pack.Type, Pack.LastUpdate, Pack.GameId, Pack.Required)
		          DidSave = True
		        End If
		        ShouldInsert = False
		        Rows.MoveToNextRow
		        Continue
		      End If
		      
		      Self.ScheduleContentPackMigration(OldContentPackId, NewContentPackId)
		      Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id = ?1;", OldContentPackId)
		      Rows.MoveToNextRow
		    Wend
		  End If
		  
		  If ShouldInsert Then
		    Self.SQLExecute("INSERT INTO content_packs (content_pack_id, name, console_safe, default_enabled, marketplace, marketplace_id, type, last_update, game_id, required) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10);", Pack.ContentPackId, Pack.Name, Pack.IsConsoleSafe, Pack.IsDefaultEnabled, Pack.Marketplace, Pack.MarketplaceId, Pack.Type, Pack.LastUpdate, Pack.GameId, Pack.Required)
		    DidSave = True
		  End If
		  
		  If DidSave And DoCloudExport Then
		    Self.ExportCloudFiles()
		  End If
		  Return DidSave
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ScheduleContentPackMigration(FromContentPackId As String, ToContentPackId As String)
		  If Self.mContentPackMigration Is Nil Then
		    Return
		  End If
		  
		  App.Log("Scheduled content pack " + FromContentPackId + " to be migrated to " + ToContentPackId + ".")
		  Self.mContentPackMigration.Value(FromContentPackId) = ToContentPackId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SchemaVersion() As Integer
		  Return RaiseEvent GetSchemaVersion()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SQLExecute(SQL As String, ParamArray Values() As Variant)
		  Self.ObtainLock()
		  
		  Var PreparedValues() As Variant = Self.MassageValues(Values)
		  Try
		    Self.mDatabase.ExecuteSQL(SQL, PreparedValues)
		    Self.ReleaseLock()
		  Catch Err As RuntimeException
		    Self.ReleaseLock()
		    
		    Err.Message = Err.Message + EndOfLine + SQL
		    Raise Err
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SQLSelect(SQL As String, ParamArray Values() As Variant) As RowSet
		  Self.ObtainLock()
		  
		  Var PreparedValues() As Variant = Self.MassageValues(Values)
		  Try
		    Var Results As RowSet = Self.mDatabase.SelectSQL(SQL, PreparedValues)
		    Self.ReleaseLock()
		    Return Results
		  Catch Err As RuntimeException
		    Self.ReleaseLock()
		    
		    Err.Message = Err.Message + EndOfLine + SQL
		    Raise Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TestPerformance(AttemptRepair As Boolean, ThresholdMicroseconds As Double = 250000) As Beacon.DataSource.PerformanceResults
		  Var StartTime As Double = System.Microseconds
		  RaiseEvent TestPerformance()
		  Var InitialDuration As Double = System.Microseconds - StartTime
		  If InitialDuration <= ThresholdMicroseconds Then
		    Return PerformanceResults.NoRepairsNecessary
		  End If
		  If AttemptRepair = False Then
		    Return PerformanceResults.RepairsNecessary
		  ElseIf Self.mAllowWriting = False Then
		    If Self.mOptimizeThread Is Nil Or Self.mOptimizeThread.ThreadState = Thread.ThreadStates.NotRunning Then
		      Self.mOptimizeThread = New Beacon.Thread
		      Self.mOptimizeThread.DebugIdentifier = Self.Identifier + ".DataSource.mOptimizeThread"
		      AddHandler mOptimizeThread.Run, WeakAddressOf mOptimizeThread_Run
		      Self.mOptimizeThread.Start
		    End If
		    Return PerformanceResults.RepairsNecessary
		  End If
		  
		  Self.Optimize()
		  
		  StartTime = System.Microseconds
		  RaiseEvent TestPerformance()
		  Var RepairedDuration As Double = System.Microseconds - StartTime
		  If RepairedDuration <= ThresholdMicroseconds Then
		    Return PerformanceResults.Repaired
		  Else
		    Return PerformanceResults.CouldNotRepair
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalChanges() As Integer
		  Try
		    Var Rows As RowSet = Self.SQLSelect("SELECT total_changes();")
		    Return Rows.ColumnAt(0).IntegerValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Checking for database changes")
		    Return 0
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TransactionDepth() As Integer
		  Return Self.mTransactions.Count
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
		    Self.CommitTransaction()
		  Catch Err As RuntimeException
		    If Self.InTransaction Then
		      Self.RollbackTransaction()
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Writeable() As Boolean
		  Return mAllowWriting
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteableInstance() As Beacon.DataSource
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BuildSchema()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CloudSyncFinished(Actions() As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DefineIndexes() As Beacon.DataIndex()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DeleteContentPack(ContentPackId As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EmptyCaches()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ExportCloudFiles()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetSchemaVersion() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Import(ChangeDict As Dictionary, StatusData As Dictionary, IsUserData As Boolean) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportCleanup(StatusData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportCloudFiles()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportFinishing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportStarting()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportTruncate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event IndexesBuilt()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MigrateContentPackData(FromContentPackId As String, ToContentPackId As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ObtainLock()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformMaintenance()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReleaseLock()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestPerformance()
	#tag EndHook


	#tag Property, Flags = &h0
		DebugIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowWriting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mConnectionCounts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackMigration As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDatabase As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExportCloudFilesCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImporting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexes() As Beacon.DataIndex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptimizeThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As String
	#tag EndProperty


	#tag Constant, Name = CommonFlagsWriteable, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ContentPackColumns, Type = String, Dynamic = False, Default = \"content_pack_id\x2C game_id\x2C name\x2C console_safe\x2C default_enabled\x2C marketplace\x2C marketplace_id\x2C type\x2C last_update\x2C required", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FlagAllowWriting, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagCreateIfNeeded, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagFallbackToMainThread, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagUseWeakRef, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ForeignKeyReportSQL, Type = String, Dynamic = False, Default = \"SELECT violations.\"table\" AS source_table\x2C violations.rowid AS source_row_id\x2C constraints.\"from\" AS source_column\x2C constraints.\"table\" AS target_table\x2C constraints.\"to\" AS target_column FROM pragma_foreign_key_check AS violations INNER JOIN pragma_foreign_key_list(violations.\"table\") AS constraints ON (violations.fkid \x3D constraints.id);", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Notification_ImportCloudFilesFinished, Type = String, Dynamic = False, Default = \"DataSource:ImportCloudFiles:Finished", Scope = Public
	#tag EndConstant


	#tag Enum, Name = PerformanceResults, Flags = &h0
		NoRepairsNecessary
		  Repaired
		  CouldNotRepair
		RepairsNecessary
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
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
