#tag Class
Private Class GetThread
Inherits Thread
	#tag Event
		Sub Run()
		  If Self.mResponse.Success = False Or App.IdentityManager.CurrentIdentity = Nil Then
		    // Do what?
		    CleanupRequest(Self.mRequest)
		    Return
		  End If
		  
		  Dim Content As MemoryBlock = Self.mResponse.Content
		  If BeaconEncryption.IsEncrypted(Content) Then
		    Try
		      Content = BeaconEncryption.SymmetricDecrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Content)
		    Catch Err As CryptoException
		      // Ok?
		      CleanupRequest(Self.mRequest)
		      Return
		    End Try
		    
		    Dim Decompressor As New _GZipString
		    Content = Decompressor.Decompress(Content)
		  End If
		  
		  // So where do we put the file now?
		  Dim URL As String = Self.mResponse.URL
		  Dim BaseURL As String = BeaconAPI.URL("/file")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
		    CleanupRequest(Self.mRequest)
		    Return
		  End If
		  
		  Dim RemotePath As String = URL.Middle(BaseURL.Length)
		  Dim LocalFile As FolderItem = LocalFile(RemotePath)
		  If LocalFile.Exists Then
		    Dim CreationDate As DateTime = LocalFile.CreationDateTime
		    Dim ModificationDate As DateTime = LocalFile.ModificationDateTime
		    Dim Stream As BinaryStream = BinaryStream.Open(LocalFile, True)
		    Stream.BytePosition = 0
		    Stream.Length = 0
		    Stream.Write(Content)
		    Stream.Close
		    LocalFile.CreationDateTime = CreationDate
		    LocalFile.ModificationDateTime = ModificationDate
		  Else
		    Dim Stream As BinaryStream = BinaryStream.Create(LocalFile, True)
		    Stream.Write(Content)
		    Stream.Close
		  End If
		  
		  CleanupRequest(Self.mRequest)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Self.mRequest = Request
		  Self.mResponse = Response
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mRequest As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponse As BeaconAPI.Response
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
