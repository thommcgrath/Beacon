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

	#tag Method, Flags = &h21
		Private Sub BuildIndexes()
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

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLock = New CriticalSection
		  
		  Const YieldInterval = 100
		  
		  Var DatabaseFile As FolderItem = App.LibrariesFolder.Child(Self.DatafileName)
		  Self.mDatabase = New SQLiteDatabase
		  Self.mDatabase.ThreadYieldInterval = YieldInterval
		  Self.mDatabase.DatabaseFile = DatabaseFile
		  If DatabaseFile.Exists Then
		    Self.mDatabase.Connect
		  Else
		    Self.mDatabase.CreateDatabase
		    
		    Self.SQLExecute("PRAGMA foreign_keys = ON;")
		    Self.SQLExecute("PRAGMA journal_mode = WAL;")
		    
		    Self.BeginTransaction()
		    RaiseEvent BuildSchema
		    Self.BuildIndexes
		    Self.CommitTransaction()
		  End If
		  
		  Self.mDatabase.ExecuteSQL("PRAGMA cache_size = -100000;")
		  Self.mDatabase.ExecuteSQL("PRAGMA analysis_limit = 0;")
		  
		  RaiseEvent Open()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DatafileName() As String
		  Var Identifier As String = RaiseEvent GetIdentifier
		  Var Version As Integer = RaiseEvent GetSchemaVersion
		  Return Identifier + " " + Version.ToString(Locale.Raw, "0") + ".sqlite"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DropIndexes()
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
		  
		  Self.mLock.Enter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Prefix() As String
		  Var Identifier As String = RaiseEvent GetIdentifier
		  Return Identifier.Lowercase
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
		Event GetIdentifier() As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetSchemaVersion() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event IndexesBuilt()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDatabase As SQLiteDatabase
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
		Private mTransactions() As String
	#tag EndProperty


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
