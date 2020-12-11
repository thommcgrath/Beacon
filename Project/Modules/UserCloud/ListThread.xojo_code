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
		      
		      If SetupIndexDatabase Then
		        Try
		          Var Results As RowSet = mIndex.SelectSQL("SELECT remote_path FROM actions WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		          If Results.RowCount > 0 Then
		            // Since there is an action pending, we do nothing
		            Continue
		          End If
		        Catch Err As RuntimeException
		          App.Log("Unable to determine action for path " + RemotePath + ": " + Err.Message)
		        End Try
		      End If
		      
		      Var LocalFile As FolderItem = LocalFile(RemotePath, False)
		      Var IsDeleted As Boolean = Dict.Value("deleted")
		      If (LocalFile = Nil Or LocalFile.Exists = False) And IsDeleted Then
		        Continue
		      End If
		      If LocalFile = Nil Then
		        LocalFile = LocalFile(RemotePath, True)
		      End If
		      
		      Var ServerModified As DateTime = NewDateFromSQLDateTime(Dict.Value("modified")).LocalTime
		      Var ServerHash As String = Dict.Value("hash")
		      Var ServerSize As Integer = Dict.Value("size")
		      
		      If LocalFile.Exists Then
		        Var LocalModified As DateTime
		        Var LocalHash As String
		        Var LocalSize As Integer
		        
		        If SetupIndexDatabase Then
		          Try
		            Var Results As RowSet = mIndex.SelectSQL("SELECT * FROM usercloud WHERE user_id = ?1 AND remote_path = ?2;", UserID, RemotePath)
		            If Results.RowCount = 1 Then
		              LocalModified = NewDateFromSQLDateTime(Results.Column("modified").StringValue)
		              LocalHash = Results.Column("hash").StringValue
		              LocalSize = Results.Column("size_in_bytes").IntegerValue
		            End If
		          Catch Err As RuntimeException
		            App.Log("Unable to local file in cloud index: " + Err.Message)
		          End Try
		        End If
		        
		        Var FilesAreDifferent As Boolean = ServerSize <> LocalSize Or ServerHash <> LocalHash
		        Var LocalIsNewer As Boolean = FilesAreDifferent And (LocalModified = Nil Or LocalModified.SecondsFrom1970 > ServerModified.SecondsFrom1970)
		        If LocalIsNewer Then
		          // Put the file
		          UploadFileTo(LocalFile, RemotePath)
		        ElseIf LocalIsNewer = False And IsDeleted = True Then
		          // Delete the file
		          RemoveFileFrom(LocalFile, RemotePath)
		        ElseIf FilesAreDifferent = True And LocalIsNewer = False Then
		          // Retrieve the file
		          RequestFileFrom(LocalFile, RemotePath, ServerModified, ServerSize, ServerHash)
		        End If
		      ElseIf IsDeleted = False Then
		        // Retrieve the file
		        RequestFileFrom(LocalFile, RemotePath, ServerModified, ServerSize, ServerHash)
		      End If
		    Next
		    
		    If SetupIndexDatabase Then
		      Try
		        Var Files As RowSet = mIndex.SelectSQL("SELECT * FROM actions WHERE user_id = ?1;", UserID)
		        While Not Files.AfterLastRow
		          Var RemotePath As String = Files.Column("remote_path").StringValue
		          Var Action As String = Files.Column("action").StringValue
		          Var LocalFile As FolderItem = LocalFile(RemotePath, False)
		          
		          Select Case Action
		          Case "PUT"
		            UploadFileTo(LocalFile, RemotePath)
		          Case "DELETE"
		            RemoveFileFrom(LocalFile, RemotePath)
		          End Select
		          
		          Files.MoveToNextRow
		        Wend
		      Catch Err As RuntimeException
		      End Try
		    End If
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
