#tag Class
Private Class GetThread
Inherits Thread
	#tag Event
		Sub Run()
		  If Not Self.mResponse.Success Then
		    // Do what?
		    CleanupRequest(Self.mRequest)
		    Return
		  End If
		  
		  Dim Content As Xojo.Core.MemoryBlock = Self.mResponse.Content
		  If BeaconEncryption.IsEncrypted(Content) Then
		    Try
		      Content = BeaconEncryption.SymmetricDecrypt(App.IdentityManager.CurrentIdentity.UserCloudKey, Content)
		    Catch Err As Xojo.Crypto.CryptoException
		      // Ok?
		      CleanupRequest(Self.mRequest)
		      Return
		    End Try
		    
		    Dim Decompressor As New _GZipString
		    Content = Beacon.ConvertMemoryBlock(Decompressor.Decompress(Beacon.ConvertMemoryBlock(Content)))
		  End If
		  
		  // So where do we put the file now?
		  Dim URL As Text = Self.mResponse.URL
		  Dim BaseURL As Text = BeaconAPI.URL("/file")
		  If Not URL.BeginsWith(BaseURL) Then
		    // What the hell is going on here?
		    CleanupRequest(Self.mRequest)
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
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
