#tag Class
Private Class ListThread
Inherits Thread
	#tag Event
		Sub Run()
		  If Not Self.mResponse.Success Then
		    App.Log("UserCloud was unable to list files: " + Self.mResponse.Message)
		    CleanupRequest(Self.mRequest)
		    Return
		  End If
		  
		  Try
		    Dim List() As Variant = Beacon.ParseJSON(Self.mResponse.Content)
		    Dim SyncedPaths As New Dictionary
		    For Each Dict As Dictionary In List
		      Dim RemotePath As String = Dict.Value("path")
		      SyncedPaths.Value(RemotePath) = True
		      
		      Dim LocalFile As FolderItem = LocalFile(RemotePath, False)
		      Dim IsDeleted As Boolean = Dict.Value("deleted")
		      If (LocalFile = Nil Or LocalFile.Exists = False) And IsDeleted Then
		        Continue
		      End If
		      If LocalFile = Nil Then
		        LocalFile = LocalFile(RemotePath, True)
		      End If
		      
		      Dim ServerModifiedText As String = Dict.Value("modified")
		      Dim ServerModified As DateTime = NewDateFromSQLDateTime(ServerModifiedText).LocalTime
		      
		      If LocalFile.Exists And LocalFile.ModificationDate <> Nil Then
		        Dim LocalModified As DateTime = LocalFile.ModificationDateTime
		        Dim FilesAreDifferent As Boolean = LocalModified <> ServerModified
		        Dim LocalIsNewer As Boolean = LocalModified > ServerModified
		        If LocalIsNewer Then
		          // Put the file
		          UploadFileTo(LocalFile, RemotePath)
		        ElseIf LocalIsNewer = False And IsDeleted = True Then
		          // Delete the file
		          LocalFile.Delete
		          Dim ActionDict As New Dictionary
		          ActionDict.Value("Action") = "DELETE"
		          ActionDict.Value("Path") = RemotePath
		          SyncActions.Append(ActionDict)
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
