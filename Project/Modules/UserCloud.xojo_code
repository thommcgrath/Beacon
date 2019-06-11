#tag Module
Protected Module UserCloud
	#tag Method, Flags = &h21
		Private Sub Callback_DeleteFile(Response As BeaconAPI.Response)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_GetFile(Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    // Do what?
		    Return
		  End If
		  
		  Dim Content As Xojo.Core.MemoryBlock = Response.Content
		  If BeaconEncryption.IsEncrypted(Content) Then
		    Try
		      Content = BeaconEncryption.SymmetricDecrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Content)
		    Catch Err As Xojo.Crypto.CryptoException
		      // Ok?
		      Return
		    End Try
		    
		    Dim Decompressor As New _GZipString
		    Content = Beacon.ConvertMemoryBlock(Decompressor.Decompress(Beacon.ConvertMemoryBlock(Content)))
		  End If
		  
		  // So where do we put the file now?
		  Dim URL As Text = Response.URL
		  Dim BaseURL As Text = BeaconAPI.URL("/file")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
		    Return
		  End If
		  
		  Dim RemotePath As Text = URL.Mid(BaseURL.Length)
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile.Exists Then
		    Dim CreationDate As Date = LocalFile.CreationDate
		    Dim ModificationDate As Date = LocalFile.ModificationDate
		    Dim Stream As BinaryStream = BinaryStream.Open(LocalFile, True)
		    Stream.Position = 0
		    Stream.Length = 0
		    Stream.Write(Beacon.ConvertMemoryBlock(Content))
		    Stream.Close
		    LocalFile.CreationDate = CreationDate
		    LocalFile.ModificationDate = ModificationDate
		  Else
		    Dim Stream As BinaryStream = BinaryStream.Create(LocalFile, True)
		    Stream.Write(Beacon.ConvertMemoryBlock(Content))
		    Stream.Close
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_ListFiles(Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    App.Log("UserCloud was unable to list files: " + Response.Message)
		    mSyncing = False
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Response.Content)
		    Dim List() As Auto = Xojo.Data.ParseJSON(TextContent)
		    Dim SyncedPaths As New Dictionary
		    For Each Dict As Xojo.Core.Dictionary In List
		      Dim RemotePath As String = Dict.Value("path")
		      SyncedPaths.Value(RemotePath) = True
		      
		      Dim LocalFile As FolderItem = LocalFile(RemotePath)
		      
		      Dim IsDeleted As Boolean = Dict.Value("deleted")
		      If LocalFile.Exists = False And IsDeleted Then
		        Continue
		      End If
		      
		      Dim ServerModifiedText As Text = Dict.Value("modified")
		      Dim ServerModified As Date = NewDateFromSQLDateTime(ServerModifiedText).LocalTime
		      
		      If LocalFile.Exists And LocalFile.ModificationDate <> Nil Then
		        Dim LocalModified As Date = LocalFile.ModificationDate
		        Dim FilesAreDifferent As Boolean = LocalModified <> ServerModified
		        Dim LocalIsNewer As Boolean = LocalModified > ServerModified
		        If LocalIsNewer Then
		          // Put the file
		          UploadFileTo(LocalFile, RemotePath)
		        ElseIf LocalIsNewer = False And IsDeleted = True Then
		          // Delete the file
		          LocalFile.Delete
		        ElseIf FilesAreDifferent = True And LocalIsNewer = False Then
		          // Retrieve the file
		          RequestFileFrom(LocalFile, RemotePath, ServerModified)
		        End If
		      ElseIf IsDeleted = False Then
		        // Retrieve the file
		        RequestFileFrom(LocalFile, RemotePath, ServerModified)
		      End If
		    Next
		    
		    Dim Paths As New Dictionary
		    DiscoverPaths("", LocalFile("/"), Paths)
		    
		    Dim Keys() As Variant = Paths.Keys
		    For Each Path As String In Keys
		      If SyncedPaths.HasKey(Path) Then
		        Continue
		      End If
		      
		      Dim File As FolderItem = Paths.Value(Path)
		      UploadFileTo(File, Path)
		    Next
		  Catch Err As RuntimeException
		    App.Log("UserCloud was unable to list files due to exception: " + Err.Explanation)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_PutFile(Response As BeaconAPI.Response)
		  If Not Response.Success Then
		    // Do what?
		    Return
		  End If
		  
		  // So where do we put the file now?
		  Dim URL As Text = Response.URL
		  Dim BaseURL As Text = BeaconAPI.URL("/file")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
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
		End Sub
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
		  
		  Dim Stream As BinaryStream = BinaryStream.Open(LocalFile, False)
		  Dim Content As MemoryBlock = Stream.Read(Stream.Length)
		  Stream.Close
		  
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RequestFileFrom(LocalFile As FolderItem, RemotePath As String, ModificationDate As Date)
		  Dim Request As New BeaconAPI.Request("file" + RemotePath.ToText, "GET", AddressOf Callback_GetFile)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		  
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

	#tag Method, Flags = &h1
		Protected Sub Sync()
		  If mSyncing Or Not Preferences.OnlineEnabled Or Preferences.OnlineToken = "" Then
		    Return
		  End If
		  
		  mSyncing = True
		  
		  Dim Request As New BeaconAPI.Request("file", "GET", AddressOf Callback_ListFiles)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
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
		  
		  Dim Request As New BeaconAPI.Request("file" + RemotePath.ToText, "PUT", EncryptedContents, "application/octet-stream", AddressOf Callback_PutFile)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		  
		  #if DebugBuild
		    App.Log("Uploading " + RemotePath)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Write(RemotePath As String, Content As MemoryBlock)
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  Dim Stream As BinaryStream = BinaryStream.Create(LocalFile, True)
		  Stream.Write(Content)
		  Stream.Close
		  Sync()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSyncing As Boolean
	#tag EndProperty


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
