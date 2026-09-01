#tag Class
Private Class IdentityResponse
	#tag Method, Flags = &h0
		Shared Function Failed() As IdentityResponse
		  Var Response As New IdentityResponse
		  Response.mLoginNeeded = True
		  Response.mMode = Modes.LoginNeeded
		  Return Response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As BeaconAPI.IdentityResponse.Modes
		  Return Self.mMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PendingIdentity() As JSONItem
		  Return Self.mPendingIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SecretNeeded(PendingIdentity As JSONItem) As IdentityResponse
		  Var Response As New IdentityResponse
		  Response.mPendingIdentity = PendingIdentity
		  Response.mSecretNeeded = True
		  Response.mMode = Modes.SecretNeeded
		  Return Response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Success(Identity As Beacon.Identity) As IdentityResponse
		  Var Response As New IdentityResponse
		  Response.mIdentity = Identity
		  Response.mMode = Modes.Success
		  Return Response
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoginNeeded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As BeaconAPI.IdentityResponse.Modes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingIdentity As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSecretNeeded As Boolean
	#tag EndProperty


	#tag Enum, Name = Modes, Type = Integer, Flags = &h0
		LoginNeeded
		  Success
		SecretNeeded
	#tag EndEnum


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
			Name="mPendingIdentity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
