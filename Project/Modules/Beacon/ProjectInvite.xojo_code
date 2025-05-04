#tag Class
Protected Class ProjectInvite
	#tag Method, Flags = &h0
		Function Code() As String
		  Return Self.mCode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expiration() As Double
		  Return Self.mExpiration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(Source As JSONItem) As Beacon.ProjectInvite
		  Try
		    Var Invite As New Beacon.ProjectInvite
		    Invite.mCode = Source.Value("inviteCode")
		    Invite.mProjectId = Source.Value("projectId")
		    Invite.mExpiration = Source.Value("expirationDate")
		    Invite.mRole = Source.Value("role")
		    Invite.mRedeemUrl = Source.Value("redeemUrl")
		    Return Invite
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Decoding JSON into ProjectInvite")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProjectId() As String
		  Return Self.mProjectId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RedeemUrl() As String
		  Return Self.mRedeemUrl
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Role() As String
		  Return Self.mRole
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExpiration As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRedeemUrl As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRole As String
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
End Class
#tag EndClass
