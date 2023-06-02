#tag Class
Protected Class PublicUserInfo
	#tag Method, Flags = &h0
		Sub Constructor(Source As RowSet)
		  Self.mPublicKey = Source.Column("public_key").StringValue
		  Self.mUserId = Source.Column("user_id").StringValue
		  Self.mUsername = Source.Column("username").StringValue
		  
		  If Source.Column("email").Value.IsNull = False Then
		    Self.mEmail = Source.Column("email").StringValue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Email() As String
		  Return Self.mEmail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PublicKey() As String
		  Return Self.mPublicKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserId() As String
		  Return Self.mUserId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Username(Full As Boolean = False) As String
		  If Full Then
		    Return Self.mUsername + "#" + Self.mUserId.Left(8).Lowercase
		  End If
		  
		  Return Self.mUsername
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEmail As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
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
		#tag ViewProperty
			Name="mUserId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
