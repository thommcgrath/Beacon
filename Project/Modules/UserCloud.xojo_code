#tag Module
Protected Module UserCloud
	#tag Method, Flags = &h21
		Private Sub Callback_DeleteFile(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  CleanupRequest(Request)
		  
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_GetFile(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Dim Th As New GetThread(Request, Response)
		  Th.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ListFiles(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Dim Th As New ListThread(Request, Response)
		  Th.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_PutFile(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    // Do what?
		    CleanupRequest(Request)
		    Return
		  End If
		  
		  // So where do we put the file now?
		  Dim URL As Text = Response.URL
		  Dim BaseURL As Text = BeaconAPI.URL("/file")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
		    CleanupRequest(Request)
		    Return
		  End If
		  
		  Dim RemotePath As Text = URL.Mid(BaseURL.Length)
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile.Exists Then
		    Try
		      Dim Details As Xojo.Core.Dictionary = Response.JSON
		      LocalFile.ModificationDate = NewDateFromSQLDateTime(Details.Value("modified")).LocalTime
		    Catch Err As RuntimeException
		      
		    End Try
		  End If
		  
		  CleanupRequest(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CleanupEmptyFolders(Folder As FolderItem)
		  If Folder = Nil Or Folder.Exists = False Or Folder.Directory = False Then
		    Return
		  End If
		  
		  For I As Integer = Folder.Count DownTo 1
		    Dim Child As FolderItem = Folder.Item(I)
		    If Not Child.Directory Then
		      Continue
		    End If
		    If Child.Count > 0 Then
		      CleanupEmptyFolders(Child)
		    End If
		    If Child.Count = 0 Then
		      Child.Delete
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
		      
		      NotificationKit.Post(Notification_SyncFinished, Nil)
		      
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
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile.DeepDelete Then
		    SendRequest(New BeaconAPI.Request("file" + RemotePath.ToText, "DELETE", AddressOf Callback_DeleteFile))
		    Sync()
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DiscoverPaths(BasePath As String, Folder As FolderItem, Destination As Dictionary)
		  If Not Folder.Directory Then
		    Return
		  End If
		  
		  For I As Integer = 1 To Folder.Count
		    Dim Child As FolderItem = Folder.Item(I)
		    If Child.Name.BeginsWith(".") Then
		      Continue
		    End If
		    
		    If Child.Directory Then
		      DiscoverPaths(BasePath + "/" + Child.Name, Child, Destination)
		    Else
		      Destination.Value(BasePath + "/" + Child.Name) = Child
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsBusy() As Boolean
		  If PendingRequests = Nil Then
		    PendingRequests = New Dictionary
		  End If
		  Return PendingRequests.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LocalFile(RemotePath As String = "") As FolderItem
		  If RemotePath.Left(1) = "/" Then
		    RemotePath = RemotePath.Mid(2)
		  End If
		  
		  Dim LocalFolder As FolderItem = App.ApplicationSupport
		  LocalFolder.CheckIsFolder
		  LocalFolder = LocalFolder.Child("Cloud")
		  LocalFolder.CheckIsFolder
		  LocalFolder = LocalFolder.Child(App.IdentityManager.CurrentIdentity.Identifier)
		  LocalFolder.CheckIsFolder
		  
		  Dim Components() As String = RemotePath.Split("/")
		  If Components.Ubound = -1 Then
		    Return LocalFolder
		  End If
		  
		  For I As Integer = 0 To Components.Ubound - 1
		    LocalFolder = LocalFolder.Child(Components(I))
		    LocalFolder.CheckIsFolder
		  Next
		  
		  Return LocalFolder.Child(Components(Components.Ubound))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Read(RemotePath As String) As MemoryBlock
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile = Nil Or Not LocalFile.Exists Then
		    Return Nil
		  End If
		  
		  Return LocalFile.Read
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RequestFileFrom(LocalFile As FolderItem, RemotePath As String, ModificationDate As Date)
		  SendRequest(New BeaconAPI.Request("file" + RemotePath.ToText, "GET", AddressOf Callback_GetFile))
		  
		  If Not LocalFile.Exists Then
		    Dim Stream As BinaryStream = BinaryStream.Create(LocalFile, True)
		    Stream.Close // Make a 0 byte file to track the modification date
		    
		    LocalFile.CreationDate = ModificationDate
		  End If
		  LocalFile.ModificationDate = ModificationDate
		  
		  #if DebugBuild
		    App.Log("Requesting " + RemotePath)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SendRequest(Request As BeaconAPI.Request)
		  If PendingRequests = Nil Then
		    PendingRequests = New Dictionary
		  End If
		  
		  Dim Fresh As Boolean = PendingRequests.Count = 0
		  
		  Request.Authenticate(Preferences.OnlineToken)
		  PendingRequests.Value(Request.RequestID) = Request
		  BeaconAPI.Send(Request)
		  
		  If Fresh Then
		    NotificationKit.Post(Notification_SyncStarted, Nil)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Sync()
		  If Preferences.OnlineEnabled = False Or Preferences.OnlineToken = "" Then
		    Return
		  End If
		  If IsBusy Then
		    If SyncKey = "" Then
		      SyncWhenFinished = True
		    End If
		    Return
		  End If
		  
		  If SyncKey <> "" Then
		    CallLater.Cancel(SyncKey)
		    SyncKey = ""
		  End If
		  
		  SyncKey = CallLater.Schedule(3000, AddressOf SyncActual)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SyncActual()
		  SyncKey = ""
		  SendRequest(New BeaconAPI.Request("file", "GET", AddressOf Callback_ListFiles))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadFileTo(LocalFile As FolderItem, RemotePath As String)
		  Dim Stream As BinaryStream = BinaryStream.Open(LocalFile, False)
		  Dim Contents As MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Dim Compressor As New _GZipString
		  Contents = Compressor.Compress(Contents, _GZipString.DefaultCompression)
		  
		  Dim EncryptedContents As Xojo.Core.MemoryBlock = BeaconEncryption.SymmetricEncrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Beacon.ConvertMemoryBlock(Contents))
		  
		  SendRequest(New BeaconAPI.Request("file" + RemotePath.ToText, "PUT", EncryptedContents, "application/octet-stream", AddressOf Callback_PutFile))
		  
		  #if DebugBuild
		    App.Log("Uploading " + RemotePath)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Write(RemotePath As String, Content As MemoryBlock) As Boolean
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile.Write(Content) Then
		    Sync()
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private PendingRequests As Dictionary
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
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
