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
		Sub Constructor(Source As Dictionary, ActiveUserId As String)
		  Self.mProjectId = Source.Value("projectId")
		  Self.mGameId = Source.Value("gameId")
		  Self.mUserId = Source.Value("userId")
		  Self.mRole = Source.Value("role")
		  If Self.mUserId = ActiveUserId And Self.mRole = Beacon.ProjectMember.RoleOwner Then
		    Self.mType = Self.TypeOwned
		  ElseIf Self.mUserId = ActiveUserId Then
		    Self.mType = Self.TypeGuest
		  Else
		    Self.mType = Self.TypeCommunity
		  End If
		  Self.mName = Source.Value("name")
		  Self.mDescription = Source.Value("description")
		  Self.mRevision = Source.Value("revision")
		  Self.mDownloadCount = Source.Value("downloadCount")
		  Self.mLastUpdated = Source.Value("lastUpdate")
		  Self.mConsoleSafe = Source.Value("consoleSafe")
		  Self.mPublishState = Source.Value("communityStatus")
		  
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
		Attributes( Deprecated = "Type" )  Function IsGuest() As Boolean
		  Return Self.mType = Self.TypeGuest
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
		Function Role() As String
		  Return Self.mRole
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Integer
		  Return Self.mType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Beacon.ProjectUrl
		  Var Type As String = Beacon.ProjectURL.TypeCloud
		  Select Case Self.mType
		  Case Self.TypeGuest
		    Type = Beacon.ProjectURL.TypeShared
		  Case Self.TypeCommunity
		    Type = Beacon.ProjectURL.TypeCommunity
		  End Select
		  Return New Beacon.ProjectUrl(Self.mGameId, Self.mName, BeaconAPI.URL("/projects/" + EncodeURLComponent(Self.mProjectId)), Self.mProjectId, "", Type)
		  
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
		Private mProjectId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublishState As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRevision As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRole As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As Integer
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

	#tag Constant, Name = TypeCommunity, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeGuest, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeOwned, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
