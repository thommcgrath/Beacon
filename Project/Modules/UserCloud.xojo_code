#tag Module
Protected Module UserCloud
	#tag Method, Flags = &h21
		Private Sub Callback_DeleteFile(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Response
		  
		  CleanupRequest(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_GetFile(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Var Th As New GetThread(Request, Response)
		  Th.Priority = Thread.LowestPriority
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ListFiles(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Var Th As New ListThread(Request, Response)
		  Th.Priority = Thread.LowestPriority
		  Th.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_PutFile(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    // Do what?
		    If Response.HTTPStatus = 446 Then
		      // This response means the path is not allowed, so we're going to delete the local file
		      Var URL As String = Response.URL
		      Var BaseURL As String = BeaconAPI.URL("/files")
		      Var RemotePath As String = URL.Middle(BaseURL.Length)
		      Var LocalFile As FolderItem = LocalFile(RemotePath)
		      Try
		        If LocalFile.Exists Then
		          LocalFile.Remove
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    CleanupRequest(Request)
		    Return
		  End If
		  
		  // So where do we put the file now?
		  Var URL As String = Response.URL
		  Var BaseURL As String = BeaconAPI.URL("/files")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
		    CleanupRequest(Request)
		    Return
		  End If
		  
		  Var RemotePath As String = URL.Middle(BaseURL.Length)
		  Var LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile.Exists Then
		    Try
		      Var Details As Dictionary = Response.JSON
		      LocalFile.ModificationDateTime = NewDateFromSQLDateTime(Details.Value("modified")).LocalTime
		    Catch Err As RuntimeException
		      
		    End Try
		  End If
		  
		  CleanupRequest(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupEmptyFolders(Folder As FolderItem)
		  If Folder = Nil Or Folder.Exists = False Or Folder.IsFolder = False Then
		    Return
		  End If
		  
		  For I As Integer = Folder.Count - 1 DownTo 0
		    Var Child As FolderItem = Folder.ChildAt(I)
		    If Not Child.IsFolder Then
		      Continue
		    End If
		    If Child.Count > 0 Then
		      CleanupEmptyFolders(Child)
		    End If
		    If Child.Count = 0 Then
		      Child.Remove
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupRequest(Request As BeaconAPI.Request)
		  If PendingRequests = Nil Then
		    Return
		  End If
		  
		  If PendingRequests.HasKey(Request.RequestID) Then
		    PendingRequests.Remove(Request.RequestID)
		    If Not IsBusy Then
		      CleanupEmptyFolders(LocalFile("/"))
		      
		      Var Actions() As Dictionary
		      For Each Dict As Dictionary In SyncActions
		        Actions.Add(Dict)
		      Next
		      NotificationKit.Post(Notification_SyncFinished, Actions)
		      SyncActions.ResizeTo(-1)
		      
		      If SyncWhenFinished Then
		        SyncWhenFinished = False
		        Sync()
		      End If
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Delete(RemotePath As String) As Boolean
		  If RemotePath.BeginsWith("/") = False Then
		    RemotePath = "/" + RemotePath
		  End If
		  
		  Var LocalFile As FolderItem = LocalFile(RemotePath, False)
		  If (LocalFile Is Nil) = False And LocalFile.DeepDelete Then
		    SetActionForPath(RemotePath, "DELETE")
		    Sync()
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FileExists(RemotePath As String) As Boolean
		  Var LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile Is Nil Then
		    Return False
		  End If
		  Return LocalFile.Exists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetWriter(RemotePath As String) As UserCloud.FileWriter
		  Var LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile Is Nil Then
		    Return Nil
		  End If
		  
		  Var OriginalHash As String
		  If LocalFile.Exists Then
		    Var ExistingContent As MemoryBlock = LocalFile.Read
		    OriginalHash = EncodeHex(Crypto.SHA2_256(ExistingContent))
		  End If
		  
		  Return New UserCloud.FileWriter(RemotePath, LocalFile, OriginalHash)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HasPendingSync() As Boolean
		  Return SyncKey.IsEmpty = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsBusy() As Boolean
		  If PendingRequests = Nil Then
		    PendingRequests = New Dictionary
		  End If
		  Return PendingRequests.KeyCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function List(Prefix As String = "/") As String()
		  Var Results() As String
		  If SetupIndexDatabase Then
		    Try
		      Var Files As RowSet = mIndex.SelectSQL("SELECT remote_path FROM usercloud WHERE user_id = ?1 ORDER BY remote_path;", UserID)
		      While Not Files.AfterLastRow
		        Var RemotePath As String = Files.Column("remote_path").StringValue
		        If RemotePath.BeginsWith(Prefix) Then
		          Results.Add(Files.Column("remote_path").StringValue)
		        End If
		        Files.MoveToNextRow
		      Wend
		    Catch Err As RuntimeException
		      App.Log("Unable to list cloud files: " + Err.Message)
		    End Try
		  End If
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LocalFile(RemotePath As String = "", Create As Boolean = True) As FolderItem
		  If App.IdentityManager.CurrentIdentity Is Nil Then
		    Return Nil
		  End If
		  
		  If RemotePath.Left(1) = "/" Then
		    RemotePath = RemotePath.Middle(1)
		  End If
		  
		  Var LocalFolder As FolderItem = App.ApplicationSupport
		  If Not LocalFolder.CheckIsFolder(Create) Then
		    Return Nil
		  End If
		  LocalFolder = LocalFolder.Child("Cloud")
		  If Not LocalFolder.CheckIsFolder(Create) Then
		    Return Nil
		  End If
		  LocalFolder = LocalFolder.Child(UserID)
		  If Not LocalFolder.CheckIsFolder(Create) Then
		    Return Nil
		  End If
		  
		  Var Components() As String = RemotePath.Split("/")
		  If Components.LastIndex = -1 Then
		    Return LocalFolder
		  End If
		  
		  Var Encoding As TextEncoding = RemotePath.Encoding
		  If Encoding = Nil Then
		    If Encodings.UTF16.IsValidData(RemotePath) Then
		      Encoding = Encodings.UTF16
		    Else
		      Encoding = Encodings.UTF8
		    End If
		  End If
		  
		  For I As Integer = 0 To Components.LastIndex - 1
		    LocalFolder = LocalFolder.Child(DecodeURLComponent(Components(I), Encoding))
		    If Not LocalFolder.CheckIsFolder(Create) Then
		      Return Nil
		    End If
		  Next
		  
		  Return LocalFolder.Child(DecodeURLComponent(Components(Components.LastIndex), Encoding))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Read(RemotePath As String) As MemoryBlock
		  Var LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile Is Nil Or Not LocalFile.Exists Then
		    Return Nil
		  End If
		  
		  Var Mem As MemoryBlock = LocalFile.Read
		  If BeaconEncryption.IsEncrypted(Mem) Then
		    Try
		      Mem = BeaconEncryption.SymmetricDecrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Mem)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Cloud file is encrypted, but could not be decrypted by the active identity.")
		      Return Nil
		    End Try
		  End If
		  If Beacon.IsCompressed(Mem) Then
		    Mem = Beacon.Decompress(Mem)
		  End If
		  Return Mem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RemoveFileFrom(LocalFile As FolderItem, RemotePath As String, IsRemote As Boolean)
		  If LocalFile.Exists Then
		    Try
		      LocalFile.Remove
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to delete local cloud file")
		    End Try
		  End If
		  
		  SendRequest(New BeaconAPI.Request("files" + RemotePath, "DELETE", AddressOf Callback_DeleteFile))
		  
		  Var ActionDict As New Dictionary
		  ActionDict.Value("Action") = "DELETE"
		  ActionDict.Value("Path") = RemotePath
		  ActionDict.Value("Remote") = IsRemote
		  SyncActions.Add(ActionDict)
		  
		  If SetupIndexDatabase Then
		    Try
		      Var UserID As String = UserID
		      mIndex.BeginTransaction
		      mIndex.ExecuteSQL("DELETE FROM usercloud WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		      mIndex.ExecuteSQL("DELETE FROM actions WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		      mIndex.CommitTransaction
		    Catch Err As RuntimeException
		      App.Log("Unable to remove cloud file from local index: " + Err.Message)
		    End Try
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RequestFileFrom(LocalFile As FolderItem, RemotePath As String, ModificationDate As DateTime, ServerSizeBytes As Integer, ServerHash As String)
		  SendRequest(New BeaconAPI.Request("files" + RemotePath, "GET", AddressOf Callback_GetFile))
		  
		  If Not LocalFile.Exists Then
		    Var Stream As BinaryStream = BinaryStream.Create(LocalFile, True)
		    Stream.Close // Make a 0 byte file to track the modification date
		    
		    #if Not TargetLinux
		      LocalFile.CreationDateTime = ModificationDate
		    #endif
		  End If
		  LocalFile.ModificationDateTime = ModificationDate
		  
		  If SetupIndexDatabase Then
		    Try
		      Var UserID As String = UserID
		      mIndex.BeginTransaction
		      Var Results As RowSet = mIndex.SelectSQL("SELECT remote_path FROM usercloud WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		      If Results.RowCount > 0 Then
		        mIndex.ExecuteSQL("UPDATE usercloud SET size_in_bytes = ?3, hash = ?4, modified = ?5 WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath, ServerSizeBytes, ServerHash, ModificationDate.SQLDateTimeWithOffset)
		      Else
		        mIndex.ExecuteSQL("INSERT INTO usercloud (user_id, remote_path, size_in_bytes, hash, modified) VALUES (?1, ?2, ?3, ?4, ?5);", UserID, RemotePath, ServerSizeBytes, ServerHash, ModificationDate.SQLDateTimeWithOffset)
		      End If
		      mIndex.ExecuteSQL("DELETE FROM actions WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		      mIndex.CommitTransaction
		    Catch Err As RuntimeException
		      App.Log("Unable to add cloud file to local index: " + Err.Message)
		    End Try
		  End If
		  
		  Var ActionDict As New Dictionary
		  ActionDict.Value("Action") = "GET"
		  ActionDict.Value("Path") = RemotePath
		  ActionDict.Value("Remote") = True
		  SyncActions.Add(ActionDict)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SendRequest(Request As BeaconAPI.Request)
		  If PendingRequests = Nil Then
		    PendingRequests = New Dictionary
		  End If
		  
		  Var Fresh As Boolean = PendingRequests.KeyCount = 0
		  
		  If App.Pusher.SocketId.IsEmpty = False Then
		    Request.RequestHeader("X-Beacon-Pusher-Id") = App.Pusher.SocketId
		  End If
		  
		  PendingRequests.Value(Request.RequestID) = Request
		  BeaconAPI.Send(Request)
		  
		  If Fresh Then
		    NotificationKit.Post(Notification_SyncStarted, Nil)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetActionForPath(RemotePath As String, Action As String)
		  If Not SetupIndexDatabase Then
		    Return
		  End If
		  
		  If RemotePath.BeginsWith("/") = False Then
		    RemotePath = "/" + RemotePath
		  End If
		  
		  Try
		    Var UserID As String = UserID
		    Var Results As RowSet = mIndex.SelectSQL("SELECT action FROM actions WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		    If Results.RowCount = 0 Then
		      mIndex.BeginTransaction
		      mIndex.ExecuteSQL("INSERT INTO actions (user_id, remote_path, action) VALUES (?1, ?2, ?3);", UserID, RemotePath, Action)
		      mIndex.CommitTransaction
		    Else
		      If Results.Column("action").StringValue <> Action Then
		        mIndex.BeginTransaction
		        mIndex.ExecuteSQL("UPDATE actions SET action = ?3 WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath, Action)
		        mIndex.CommitTransaction
		      End If
		    End If
		  Catch Err As RuntimeException
		    App.Log("Unable to add " + Action + " action to cloud index: " + Err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SetupIndexDatabase() As Boolean
		  If mIndex <> Nil Then
		    Return True
		  End If
		  
		  Var DatabaseFile As FolderItem = App.ApplicationSupport
		  If Not DatabaseFile.CheckIsFolder(True) Then
		    Return False
		  End If
		  DatabaseFile = DatabaseFile.Child("Cloud")
		  If Not DatabaseFile.CheckIsFolder(True) Then
		    Return False
		  End If
		  DatabaseFile = DatabaseFile.Child("Index.sqlite")
		  
		  Var Index As New SQLiteDatabase
		  Index.DatabaseFile = DatabaseFile
		  
		  Var Created As Boolean
		  
		  If Index.DatabaseFile.Exists Then
		    Try
		      Index.Connect
		    Catch DBErr As RuntimeException
		      App.Log("Unable to connect to database at " + Index.DatabaseFile.NativePath + ": " + DBErr.Message)
		      Try
		        Index.DatabaseFile.Remove
		      Catch DelErr As RuntimeException
		        App.Log("Unable to remove bad database at " + Index.DatabaseFile.NativePath + ": " + DelErr.Message)
		        Return False
		      End Try
		      Try
		        Index.CreateDatabase
		        Created = True
		      Catch CreateErr As RuntimeException
		        // Docs say IOException, but I'm not confident
		        App.Log("Unable to create replacement database at " + Index.DatabaseFile.NativePath + ": " + CreateErr.Message)
		        Return False
		      End Try
		    End Try
		  Else
		    Try
		      Index.CreateDatabase
		      Created = True
		    Catch CreateErr As RuntimeException
		      App.Log("Unable to create database at " + Index.DatabaseFile.NativePath + ": " + CreateErr.Message)
		      Return False
		    End Try
		  End If
		  
		  If Created = False And Index.UserVersion < 2 Then
		    Try
		      Index.ExecuteSQL("ALTER TABLE usercloud RENAME TO usercloud_old;")
		      Index.ExecuteSQL("ALTER TABLE actions RENAME TO actions_old;")
		      
		      If Not SetupIndexSchema(Index) Then
		        Return False
		      End If
		      
		      Index.ExecuteSQL("INSERT INTO usercloud (user_id, remote_path, size_in_bytes, hash, modified) SELECT ?1 AS user_id, remote_path, size_in_bytes, hash, modified FROM usercloud_old;", UserID)
		      Index.ExecuteSQL("INSERT INTO actions (user_id, remote_path, action) SELECT ?1 AS user_id, remote_path, action FROM actions_old;", UserID)
		      Index.ExecuteSQL("DROP TABLE usercloud_old;")
		      Index.ExecuteSQL("DROP TABLE actions_old;")
		    Catch Err As RuntimeException
		      App.Log("Could not update database schema: " + Err.Message)
		      Index.Close
		      Try
		        Index.DatabaseFile.Remove
		      Catch DelErr As RuntimeException
		        App.Log("Also unable to delete the database file at " + Index.DatabaseFile.NativePath + ": " + DelErr.Message)
		      End Try
		      Return False
		    End Try
		  ElseIf Created Then
		    If Not SetupIndexSchema(Index) Then
		      Return False
		    End If
		  End If
		  
		  Index.ExecuteSQL("PRAGMA foreign_keys = ON;")
		  mIndex = Index
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SetupIndexSchema(Index As SQLiteDatabase) As Boolean
		  Try
		    Index.ExecuteSQL("CREATE TABLE usercloud (user_id TEXT NOT NULL, remote_path TEXT NOT NULL, size_in_bytes INTEGER NOT NULL, hash TEXT NOT NULL, modified TEXT NOT NULL);")
		    Index.ExecuteSQL("CREATE TABLE actions (user_id TEXT NOT NULL, remote_path TEXT NOT NULL, action TEXT NOT NULL);")
		    Index.ExecuteSQL("CREATE UNIQUE INDEX usercloud_user_id_remote_path_idx ON usercloud(user_id, remote_path);")
		    Index.ExecuteSQL("CREATE UNIQUE INDEX actions_user_id_remote_path_idx ON actions(user_id, remote_path);")
		    Index.ExecuteSQL("PRAGMA journal_mode = WAL;")
		    Index.UserVersion = 2
		    Return True
		  Catch Err As RuntimeException
		    App.Log("Could not create database schema: " + Err.Message)
		    Index.Close
		    Try
		      Index.DatabaseFile.Remove
		    Catch DelErr As RuntimeException
		      App.Log("Also unable to delete the database file at " + Index.DatabaseFile.NativePath + ": " + DelErr.Message)
		    End Try
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sync(NoWait As Boolean = False)
		  If Preferences.OnlineEnabled = False Or Preferences.BeaconAuth Is Nil Then
		    Return
		  End If
		  If IsBusy Then
		    If SyncKey.IsEmpty Then
		      SyncWhenFinished = True
		    End If
		    Return
		  End If
		  
		  If SyncKey.IsEmpty = False Then
		    CallLater.Cancel(SyncKey)
		    SyncKey = ""
		  End If
		  
		  If NoWait Then
		    SyncActual()
		  Else
		    SyncKey = CallLater.Schedule(3000, AddressOf SyncActual)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncActual()
		  If SyncKey.IsEmpty = False Then
		    CallLater.Cancel(SyncKey)
		    SyncKey = ""
		  End If
		  
		  If DataUpdater.IsImporting Or DataUpdater.IsCheckingOnline Then
		    SyncKey = CallLater.Schedule(3000, AddressOf SyncActual)
		    Return
		  End If
		  
		  SyncActions.ResizeTo(-1)
		  SendRequest(New BeaconAPI.Request("files", "GET", AddressOf Callback_ListFiles))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadFileTo(LocalFile As FolderItem, RemotePath As String)
		  If App.IdentityManager.CurrentIdentity Is Nil Then
		    Return
		  End If
		  
		  Var Contents As MemoryBlock
		  Try
		    Contents = LocalFile.Read()
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Could not read local file for remote path '" + RemotePath + "'.")
		    Return
		  End Try
		  Contents = Beacon.Compress(Contents)
		  
		  Var EncryptedContents As MemoryBlock = BeaconEncryption.SymmetricEncrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Contents)
		  
		  SendRequest(New BeaconAPI.Request("files" + RemotePath, "PUT", EncryptedContents, "application/octet-stream", AddressOf Callback_PutFile))
		  
		  If SetupIndexDatabase Then
		    Var EncryptedContentsHash As String = EncodeHex(Crypto.SHA2_256(EncryptedContents)).Lowercase
		    Var EncryptedContentsSize As Integer = EncryptedContents.Size
		    Var Modified As String = DateTime.Now.SQLDateTimeWithOffset
		    Var UserID As String = UserID
		    Try
		      mIndex.BeginTransaction
		      Var Results As RowSet = mIndex.SelectSQL("SELECT remote_path FROM usercloud WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		      If Results.RowCount > 0 Then
		        mIndex.ExecuteSQL("UPDATE usercloud SET size_in_bytes = ?3, hash = ?4, modified = ?5 WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath, EncryptedContentsSize, EncryptedContentsHash, Modified)
		      Else
		        mIndex.ExecuteSQL("INSERT INTO usercloud (user_id, remote_path, size_in_bytes, hash, modified) VALUES (?1, ?2, ?3, ?4, ?5);", UserID, RemotePath, EncryptedContentsSize, EncryptedContentsHash, Modified)
		      End If
		      mIndex.ExecuteSQL("DELETE FROM actions WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		      mIndex.CommitTransaction
		    Catch Err As RuntimeException
		      App.Log("Unable to add cloud file to local index: " + Err.Message)
		    End Try
		  End If
		  
		  Var ActionDict As New Dictionary
		  ActionDict.Value("Action") = "PUT"
		  ActionDict.Value("Path") = RemotePath
		  ActionDict.Value("Remote") = False
		  SyncActions.Add(ActionDict)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UserID() As String
		  Try
		    If (App.IdentityManager.CurrentIdentity Is Nil) = False Then
		      Return App.IdentityManager.CurrentIdentity.UserId
		    End If
		  Catch Err As RuntimeException
		  End Try
		  Return Beacon.UUID.Null
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Write(RemotePath As String, Content As MemoryBlock) As Boolean
		  Var LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile Is Nil Then
		    Return False
		  End If
		  
		  If LocalFile.Exists Then
		    Var ExistingContent As MemoryBlock = LocalFile.Read
		    Var ExistingHash As String = EncodeHex(Crypto.SHA2_256(ExistingContent))
		    Var NewHash As String = EncodeHex(Crypto.SHA2_256(Content))
		    If NewHash = ExistingHash Then
		      // They are already the same
		      Return True
		    End If
		  End If
		  
		  Try
		    LocalFile.Write(Content)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  SetActionForPath(RemotePath, "PUT")
		  Sync()
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Write(Writer As UserCloud.FileWriter) As Boolean
		  If Writer Is Nil Or Writer.LocalFile.Exists = False Then
		    Return False
		  End If
		  
		  Var NewContent As MemoryBlock
		  Var NewHash As String
		  Try
		    NewContent = Writer.LocalFile.Read()
		    NewHash = EncodeHex(Crypto.SHA2_256(NewContent))
		  Catch Err As RuntimeException
		  End Try
		  
		  If NewHash = Writer.OriginalHash Then
		    // No changes were made
		    Return True
		  End If
		  
		  SetActionForPath(Writer.RemotePath, "PUT")
		  Sync()
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIndex As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PendingRequests As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SyncActions() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SyncKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SyncWhenFinished As Boolean
	#tag EndProperty


	#tag Constant, Name = Notification_SyncFinished, Type = Text, Dynamic = False, Default = \"Cloud Sync Finished", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Notification_SyncStarted, Type = Text, Dynamic = False, Default = \"Cloud Sync Started", Scope = Protected
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
