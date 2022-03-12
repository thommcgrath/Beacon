#tag Class
Protected Class DataSource
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
		  Const YieldInterval = 100
		  
		  Var SchemaVersion As Integer = RaiseEvent GetSchemaVersion
		  Var DatafileName As String = Self.Identifier + ".sqlite"
		  Var DatabaseFile As FolderItem = App.LibrariesFolder.Child(DatafileName)
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
		        Self.mDatabase.ExecuteSQL("PRAGMA writable_schema = 1;")
		        Self.mDatabase.ExecuteSQL("DELETE FROM sqlite_master;")
		        Self.mDatabase.ExecuteSQL("PRAGMA writable_schema = 0;")
		        Self.mDatabase.ExecuteSQL("VACUUM;")
		        
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
		  
		  If BuildSchema Then
		    Self.SQLExecute("PRAGMA journal_mode = WAL;")
		    
		    Self.BeginTransaction()
		    Self.SQLExecute("CREATE TABLE variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT COLLATE NOCASE NOT NULL);")
		    RaiseEvent BuildSchema
		    Self.mDatabase.UserVersion = SchemaVersion
		    Self.BuildIndexes
		    Self.CommitTransaction()
		  End If
		  
		  Self.SQLExecute("PRAGMA cache_size = -100000;")
		  Self.SQLExecute("PRAGMA analysis_limit = 0;")
		  Self.ForeignKeys = True
		  
		  RaiseEvent Open()
		End Sub
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
		Sub ExportCloudFiles()
		  // This way changing lots of engrams rapidly won't require a write to disk
		  // after each action
		  
		  If Self.mExportCloudFilesCallbackKey.IsEmpty = False Then
		    CallLater.Cancel(Self.mExportCloudFilesCallbackKey)
		    Self.mExportCloudFilesCallbackKey = ""
		  End If
		  
		  Self.mExportCloudFilesCallbackKey = CallLater.Schedule(250, AddressOf ExportCloudFiles_Delayed)
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

	#tag Method, Flags = &h21
		Private Function ForeignKeys() As Boolean
		  Try
		    Var Tmp As RowSet = Self.SQLSelect("PRAGMA foreign_keys;")
		    Return Tmp.ColumnAt(0).IntegerValue = 1
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
		    Var Rows As RowSet
		    Try
		      Rows = Self.SQLSelect("PRAGMA foreign_key_check;")
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Getting list of broken foreign keys")
		    End Try
		    If (Rows Is Nil) = False Then
		      While Rows.AfterLastRow = False
		        Var TransactionStarted As Boolean
		        Try
		          Var TableName As String = Rows.Column("table").StringValue
		          Var RowID As Integer = Rows.Column("rowid").IntegerValue
		          Self.BeginTransaction
		          TransactionStarted = True
		          Self.SQLExecute("DELETE FROM """ + TableName.ReplaceAll("""", """""") + """ WHERE rowid = ?1;", RowID)
		          Self.CommitTransaction
		          TransactionStarted = False
		        Catch Err As RuntimeException
		          App.Log(Err, CurrentMethodName, "Deleting broken foreign key row")
		          If TransactionStarted Then
		            Self.RollbackTransaction
		          End If
		        End Try
		        Rows.MoveToNextRow
		      Wend
		    End If
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
		Function HasContent() As Boolean
		  Var Rows As RowSet = Self.SQLSelect("SELECT EXISTS(SELECT 1 FROM variables) AS populated;")
		  Return Rows.Column("populated").BooleanValue
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
		Function Import(Data As Dictionary, ShouldTruncate As Boolean, Deletions() As Dictionary) As Boolean
		  // The DataUpdater module will call this method inside a thread with its own database connection
		  
		  If Data.HasKey(Self.Identifier.Lowercase) = False Then
		    Return True
		  End If
		  
		  Var Timestamp As Double
		  Try
		    Timestamp = Data.Value("timestamp").DoubleValue
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Invalid timestamp value")
		    Return False
		  End Try
		  
		  If Timestamp <= Self.LastSyncTimestamp And ShouldTruncate = False Then
		    // Already imported
		    Return True
		  End If
		  
		  Var StatusData As New Dictionary
		  Var OriginalDepth As Integer = Self.TransactionDepth
		  Self.BeginTransaction()
		  Self.mImporting = True
		  
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
		  
		  Try
		    Var ChangeDict As Dictionary = Data.Value(Self.Identifier.Lowercase)
		    If Import(ChangeDict, StatusData, Deletions) Then
		      Self.LastSyncTimestamp = Timestamp
		      Self.CommitTransaction
		    Else
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
		Sub ImportCloudFiles()
		  RaiseEvent ImportCloudFiles()
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
		Private Sub ObtainLock()
		  // This method exists to provide easy insertion points for debug data
		  
		  RaiseEvent ObtainLock
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Optimize()
		  Self.SQLExecute("ANALYZE;")
		  Self.SQLExecute("VACUUM;")
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
		  
		  RaiseEvent ReleaseLock
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
		Function TotalChanges() As Integer
		  Var Rows As RowSet = Self.SQLSelect("SELECT total_changes();")
		  Return Rows.ColumnAt(0).IntegerValue
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
		Event ExportCloudFiles()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetSchemaVersion() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Import(ChangeDict As Dictionary, StatusData As Dictionary, Deletions() As Dictionary) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportCleanup(StatusData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportCloudFiles()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ImportTruncate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event IndexesBuilt()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ObtainLock()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
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
		Private Shared mConnectionCounts As Dictionary
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
		Private mLastCommitTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As String
	#tag EndProperty


	#tag Constant, Name = FlagCreateIfNeeded, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagFallbackToMainThread, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagUseWeakRef, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
