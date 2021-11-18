#tag Class
Protected Class DataSource
	#tag Method, Flags = &h21
		Private Sub AdvanceDeltaQueue()
		  If Self.mDeltaDownloadQueue.Count = 0 Then
		    Self.Syncing = False
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

	#tag Method, Flags = &h1
		Protected Sub BeginTransaction()
		  Self.ObtainLock()
		  
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

	#tag Method, Flags = &h1
		Protected Sub BuildIndexes()
		  If Self.mIndexes.Count = 0 Then
		    Var Indexes() As Beacon.DataIndex = RaiseEvent DefineIndexes
		    If Indexes Is Nil Then
		      Return
		    End If
		    Self.mIndexes = Indexes
		  End If
		  
		  Self.BeginTransaction()
		  For Idx As Integer = 0 To Self.mIndexes.LastIndex
		    Self.SQLExecute(Self.mIndexes(Idx).CreateStatement)
		  Next Idx
		  RaiseEvent IndexesBuilt()
		  Self.CommitTransaction()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  RaiseEvent Close()
		  
		  If (Self.mDatabase Is Nil) = false Then
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
		  
		  Self.ReleaseLock()
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
		Sub Constructor()
		  Self.mLock = New CriticalSection
		  
		  Const YieldInterval = 100
		  
		  Var DatafileName As String = Self.DatafileName
		  Var DatabaseFile As FolderItem = App.LibrariesFolder.Child(DatafileName)
		  Self.mDatabase = New SQLiteDatabase
		  Self.mDatabase.ThreadYieldInterval = YieldInterval
		  Self.mDatabase.DatabaseFile = DatabaseFile
		  Var Connected As Boolean
		  If DatabaseFile.Exists Then
		    Try
		      Self.mDatabase.Connect
		      Self.ConnectionCount = Self.ConnectionCount + 1
		      Connected = True
		    Catch Err As RuntimeException
		      Self.mDatabase.Close
		      If Self.ConnectionCount = 0 Then
		        Var Parent As FolderItem = DatabaseFile.Parent
		        Var Bound As Integer = Parent.Count - 1
		        For Idx As Integer = Bound DownTo 0
		          If Parent.ChildAt(Idx).Name.BeginsWith(DatafileName) Then
		            Parent.ChildAt(Idx).Remove
		          End If
		        Next Idx
		      End If
		    End Try
		  End If
		  
		  If Not Connected Then
		    Self.mDatabase.CreateDatabase
		    Self.ConnectionCount = Self.ConnectionCount + 1
		    
		    Self.SQLExecute("PRAGMA foreign_keys = ON;")
		    Self.SQLExecute("PRAGMA journal_mode = WAL;")
		    
		    Self.BeginTransaction()
		    Self.SQLExecute("CREATE TABLE variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT COLLATE NOCASE NOT NULL);")
		    RaiseEvent BuildSchema
		    Self.BuildIndexes
		    Self.CommitTransaction()
		  End If
		  
		  Self.SQLExecute("PRAGMA cache_size = -100000;")
		  Self.SQLExecute("PRAGMA analysis_limit = 0;")
		  
		  RaiseEvent Open()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DatafileName() As String
		  Var Identifier As String = Self.Identifier
		  Var Version As Integer = RaiseEvent GetSchemaVersion
		  Return Identifier + " " + Version.ToString(Locale.Raw, "0") + ".sqlite"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DropIndexes()
		  If Self.mIndexes.Count = 0 Then
		    Var Indexes() As Beacon.DataIndex = RaiseEvent DefineIndexes
		    If Indexes Is Nil Then
		      Return
		    End If
		    Self.mIndexes = Indexes
		  End If
		  
		  Self.BeginTransaction()
		  For Idx As Integer = 0 To Self.mIndexes.LastIndex
		    Self.SQLExecute(Self.mIndexes(Idx).DropStatement)
		  Next Idx
		  Self.CommitTransaction()
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
		Function Identifier() As String
		  Var Err As New RuntimeException
		  Err.Message = "DataSource.Identifier was not overridden"
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String)
		  Self.mImporting = True
		  Self.mPendingImports.Add(Content)
		  
		  If Self.mImportThread = Nil Then
		    Self.mImportThread = New Thread
		    Self.mImportThread.DebugIdentifier = "Import"
		    Self.mImportThread.Priority = Thread.LowestPriority
		    AddHandler Self.mImportThread.Run, WeakAddressOf Self.mImportThread_Run
		  End If
		  
		  If Self.mImportThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.mImportThread.Start
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
		  
		  Var StartTime As Double = System.Microseconds
		  Content = Beacon.Decompress(Content)
		  
		  Var StatusData As New Dictionary
		  
		  Var ChangeDict As Dictionary
		  Try
		    ChangeDict = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    App.Log("Cannot import because the data is not valid JSON.")
		    Return False
		  End Try
		  
		  If ChangeDict.HasKey("game") And ChangeDict.Value("game").IsNull = False And ChangeDict.Value("game").Type = Variant.TypeString And ChangeDict.Value("game").StringValue <> Self.Identifier Then
		    App.Log("Cannot import because the data is for the wrong game.")
		    Return False
		  End If
		  
		  Var FileVersion As Integer = ChangeDict.Value("beacon_version")
		  If FileVersion <> Self.DeltaFormat Then
		    App.Log("Cannot import because file format is not correct for this version. Get a correct file from " + Self.SyncURL(True))
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
		    If ShouldTruncate Then
		      RaiseEvent ImportTruncate
		    End If
		    If RaiseEvent Import(ChangeDict, StatusData) Then
		      Self.LastSync = PayloadTimestamp
		      Self.CommitTransaction()
		    Else
		      Self.RollbackTransaction()
		      Return False
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Importing")
		    While Self.InTransaction
		      Self.RollbackTransaction
		    Wend
		  End Try
		  
		  Var Duration As Double = (System.Microseconds - StartTime) / 1000000
		  System.DebugLog("Took " + Duration.ToString(Locale.Raw, "0.00") + "ms import data")
		  
		  // Force analyze
		  StartTime = System.Microseconds
		  Self.SQLExecute("ANALYZE;")
		  Self.SQLExecute("VACUUM;")
		  Duration = (System.Microseconds - StartTime) / 1000000
		  System.DebugLog("Took " + Duration.ToString(Locale.Raw, "0.00") + "ms to optimize")
		  
		  Try
		    RaiseEvent ImportCleanup(StatusData)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Cleaning up after import")
		  End Try
		  
		  App.Log("Imported delta update. Sync date is " + PayloadTimestamp.SQLDateTimeWithOffset)
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function InTransaction() As Boolean
		  Return Self.mTransactions.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSync() As DateTime
		  Var LastSync As String = Self.Variable("sync_time")
		  If LastSync.IsEmpty Then
		    Return Nil
		  End If
		  
		  Return NewDateFromSQLDateTime(LastSync)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LastSync(Assigns Value As DateTime)
		  Self.Variable("sync_time") = Value.SQLDateTimeWithOffset
		End Sub
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
		    Catch Err As TypeMismatchException
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
		Private Sub mDeltaDownload_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Self.mDeltaDownloader = Nil
		  
		  If HTTPStatus < 200 Or HTTPStatus >= 300 Then
		    Self.mDeltaDownloadQueue.RemoveAll
		    App.Log("Failed to download sync delta: HTTP " + HTTPStatus.ToString(Locale.Raw, "0"))
		    Self.Syncing = False
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
		  
		  App.Log("Failed to download sync delta: " + Err.Message)
		  Self.Syncing = False
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
		  If Self.mPendingImports.LastIndex = -1 Then
		    Self.mImporting = False
		    Return
		  End If
		  
		  NotificationKit.Post(Self.Notification_ImportStarted, Nil)
		  
		  Sender.Sleep(500)
		  
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
		  
		  If Self.mSyncAfterImport Then
		    Self.mSyncAfterImport = False
		    Self.Sync()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateCheckTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  // Check every four hours
		  If DateTime.Now.SecondsFrom1970 - Self.mUpdateCheckTime.SecondsFrom1970 >= 14400 Then
		    Self.Sync(False)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Self.mUpdater = Nil
		  
		  If HTTPStatus <> 200 Then
		    App.Log("Sync returned HTTP " + HTTPStatus.ToString(Locale.Raw, "0"))
		    Self.Syncing = False
		    Return
		  End If
		  
		  Try
		    Var Parsed As Variant = Beacon.ParseJSON(Content)
		    If Parsed Is Nil Or (Parsed IsA Dictionary) = False Then
		      App.Log("No changes available.")
		      Self.Syncing = False
		      Return
		    End If
		    
		    Var Dict As Dictionary = Parsed
		    If Not Dict.HasAllKeys("total_size", "files") Then
		      App.Log("Sync data is missing keys.")
		      Self.Syncing = False
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
		      App.Log("No changes available.")
		      Self.Syncing = False
		      Return
		    End If
		    
		    Self.AdvanceDeltaQueue
		  Catch Err As RuntimeException
		    App.Log("Unable to parse sync delta JSON: " + Err.Message)
		    Self.Syncing = False
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_Error(Sender As URLConnection, Error As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.mUpdater = Nil
		  
		  App.Log("Sync error: " + Error.Message)
		  Self.Syncing = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ObtainLock()
		  // This method exists to provide easy insertion points for debug data
		  
		  Self.mLock.Enter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Prefix() As String
		  Return Self.Identifier.Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReleaseLock()
		  // This method exists to provide easy insertion points for debug data
		  
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RollbackTransaction()
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
		  
		  Self.ReleaseLock()
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
		  Catch Err As DatabaseException
		    Self.ReleaseLock()
		    Var Cloned As New DatabaseException
		    Cloned.ErrorNumber = Err.ErrorNumber
		    Cloned.Message = "#" + Err.ErrorNumber.ToString(Locale.Raw, "0") + ": " + Err.Message + EndOfLine + SQL
		    Raise Cloned
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
		  Catch Err As DatabaseException
		    Self.ReleaseLock()
		    Var Cloned As New DatabaseException
		    Cloned.ErrorNumber = Err.ErrorNumber
		    Cloned.Message = "#" + Err.ErrorNumber.ToString(Locale.Raw, "0") + ": " + Err.Message + EndOfLine + SQL
		    Raise Cloned
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sync(ForceRefresh As Boolean = False)
		  If Self.Syncing Then
		    Return
		  End If
		  
		  If Self.Importing And ForceRefresh = False Then
		    Self.mSyncAfterImport = True
		    Return
		  End If
		  
		  Self.mUpdater = New URLConnection
		  Self.mUpdater.AllowCertificateValidation = True
		  Self.mUpdater.RequestHeader("Cache-Control") = "no-cache"
		  Self.mUpdater.RequestHeader("User-Agent") = App.UserAgent
		  AddHandler Self.mUpdater.ContentReceived, WeakAddressOf Self.mUpdater_ContentReceived
		  AddHandler Self.mUpdater.Error, WeakAddressOf Self.mUpdater_Error
		  
		  Self.Syncing = True
		  Self.mUpdateCheckTime = DateTime.Now
		  If Self.mUpdateCheckTimer.RunMode = Timer.RunModes.Off Then
		    Self.mUpdateCheckTimer.RunMode = Timer.RunModes.Multiple
		  End If
		  Var CheckURL As String = Self.SyncURL(ForceRefresh)
		  App.Log("Syncing " + Self.Identifier + " database with " + CheckURL)
		  Self.mUpdater.Send("GET", CheckURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Syncing() As Boolean
		  Return Self.mSyncing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Syncing(Assigns Value As Boolean)
		  If Self.mSyncing = Value Then
		    Return
		  End If
		  
		  Self.mSyncing = Value
		  If Value Then
		    NotificationKit.Post(Self.Notification_SyncStarted, Nil)
		  Else
		    NotificationKit.Post(Self.Notification_SyncFinished, Self.LastSync)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SyncURL(ForceRefresh As Boolean) As String
		  Var Err As New RuntimeException
		  Err.Message = "DataSource.SyncURL was not overridden"
		  Raise Err
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
		  End If
		  
		  Self.mDatabase.ExecuteSQL("ANALYZE;")
		  Self.mDatabase.ExecuteSQL("VACUUM;")
		  
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
		    Self.RollbackTransaction()
		  End Try
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BuildSchema()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DefineIndexes() As Beacon.DataIndex()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetSchemaVersion() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Import(ChangeDict As Dictionary, StatusData As Dictionary) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportCleanup(StatusData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportTruncate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event IndexesBuilt()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TestPerformance()
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared mConnectionCounts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDatabase As SQLiteDatabase
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
		Private mImporting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndexes() As Beacon.DataIndex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCommitTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingImports() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSyncAfterImport As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSyncing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateCheckTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateCheckTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdater As URLConnection
	#tag EndProperty


	#tag Constant, Name = DeltaFormat, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_DatabaseUpdated, Type = String, Dynamic = False, Default = \"Database Updated", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportFailed, Type = String, Dynamic = False, Default = \"Import Failed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportStarted, Type = String, Dynamic = False, Default = \"Import Started", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_ImportSuccess, Type = String, Dynamic = False, Default = \"Import Success", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_SyncFinished, Type = String, Dynamic = False, Default = \"Sync Finished", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_SyncStarted, Type = String, Dynamic = False, Default = \"Sync Started", Scope = Public
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
	#tag EndViewBehavior
End Class
#tag EndClass
