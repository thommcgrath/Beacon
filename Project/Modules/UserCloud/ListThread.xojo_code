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
		    Var List() As Variant = Beacon.ParseJSON(Self.mResponse.Content)
		    Var SyncedPaths As New Dictionary
		    For Each Dict As Dictionary In List
		      Var RemotePath As String = Dict.Value("path")
		      SyncedPaths.Value(RemotePath) = True
		      
		      Var LocalFile As FolderItem = LocalFile(RemotePath, False)
		      Var IsDeleted As Boolean = Dict.Value("deleted")
		      If (LocalFile = Nil Or LocalFile.Exists = False) And IsDeleted Then
		        Continue
		      End If
		      If LocalFile = Nil Then
		        LocalFile = LocalFile(RemotePath, True)
		      End If
		      
		      Var ServerModifiedText As String = Dict.Value("modified")
		      Var ServerModified As DateTime = NewDateFromSQLDateTime(ServerModifiedText).LocalTime
		      
		      If LocalFile.Exists And LocalFile.ModificationDate <> Nil Then
		        Var LocalModified As DateTime = LocalFile.ModificationDateTime
		        Var FilesAreDifferent As Boolean = LocalModified.SecondsFrom1970 <> ServerModified.SecondsFrom1970
		        Var LocalIsNewer As Boolean = LocalModified > ServerModified
		        If LocalIsNewer Then
		          // Put the file
		          UploadFileTo(LocalFile, RemotePath)
		        ElseIf LocalIsNewer = False And IsDeleted = True Then
		          // Delete the file
		          LocalFile.Remove
		          Var ActionDict As New Dictionary
		          ActionDict.Value("Action") = "DELETE"
		          ActionDict.Value("Path") = RemotePath
		          SyncActions.AddRow(ActionDict)
		        ElseIf FilesAreDifferent = True And LocalIsNewer = False Then
		          // Retrieve the file
		          RequestFileFrom(LocalFile, RemotePath, ServerModified)
		        End If
		      ElseIf IsDeleted = False Then
		        // Retrieve the file
		        RequestFileFrom(LocalFile, RemotePath, ServerModified)
		      End If
		    Next
		    
		    Var Paths As New Dictionary
		    DiscoverPaths("", LocalFile("/"), Paths)
		    
		    Var Keys() As Variant = Paths.Keys
		    For Each Path As String In Keys
		      If SyncedPaths.HasKey(Path) Then
		        Continue
		      End If
		      
		      Var File As FolderItem = Paths.Value(Path)
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
