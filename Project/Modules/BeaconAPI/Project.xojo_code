#tag Class
Protected Class Project
	#tag Method, Flags = &h0
		Function ArkDifficulty() As Double
		  Return Self.mArkDifficulty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ArkMapMask() As UInt64
		  Return Self.mArkMapMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafe() As Boolean
		  Return Self.mConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Dictionary)
		  Self.mProjectId = Source.Value("projectId")
		  Self.mGameId = Source.Value("gameId")
		  Self.mUserID = Source.Value("userId")
		  Self.mOwnerId = Source.Value("ownerId")
		  Self.mName = Source.Value("name")
		  Self.mDescription = Source.Value("description")
		  Self.mRevision = Source.Value("revision")
		  Self.mDownloadCount = Source.Value("downloadCount")
		  Self.mLastUpdated = Source.Value("lastUpdate")
		  Self.mConsoleSafe = Source.Value("consoleSafe")
		  Self.mPublishState = Source.Value("published")
		  
		  Select Case Self.mGameId
		  Case Ark.Identifier
		    Self.mArkMapMask = Source.Value("mapMask")
		    Self.mArkDifficulty = Source.Value("difficulty")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DownloadCount() As UInteger
		  Return Self.mDownloadCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Self.mGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsGuest() As Boolean
		  Return Self.mUserId <> Self.mOwnerId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPublished() As Boolean
		  Self.mPublishState = Self.PublishStateApproved
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdated(InTimeZone As TimeZone = Nil) As DateTime
		  Return New DateTime(Self.mLastUpdated, InTimeZone)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As BeaconAPI.Project) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mProjectId.Compare(Other.mProjectId, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OwnerId() As String
		  Return Self.mOwnerId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProjectId() As String
		  Return Self.mProjectId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublishState() As String
		  Return Self.mPublishState
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Revision() As UInteger
		  Return Self.mRevision
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL(Scheme As String = "https") As String
		  Return BeaconAPI.URL("/projects/" + Self.mProjectId + "?name=" + EncodeURLComponent(Self.mName), True, Scheme)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserId() As String
		  Return Self.mUserID
		End Function
	#tag EndMethod


	#tag Note, Name = Beacon.Project
		Yes, they are different. An BeaconAPI.Project is metadata, no content, and includes stats.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mArkDifficulty As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mArkMapMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadCount As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastUpdated As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwnerId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublishState As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRevision As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserId As String
	#tag EndProperty


	#tag Constant, Name = PublishStateApproved, Type = String, Dynamic = False, Default = \"Approved", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PublishStateApprovedPrivate, Type = String, Dynamic = False, Default = \"Approved But Private", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PublishStateDenied, Type = String, Dynamic = False, Default = \"Denied", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PublishStatePending, Type = String, Dynamic = False, Default = \"Pending", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PublishStatePrivate, Type = String, Dynamic = False, Default = \"Private", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
