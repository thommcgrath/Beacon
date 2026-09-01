#tag Class
Protected Class IdentityImportResponse
	#tag Method, Flags = &h0
		Sub Constructor(Status As IdentityImportResponse.Statuses, Identity As Beacon.Identity = Nil)
		  Self.mStatus = Status
		  Self.mIdentity = Identity
		  
		  If Status = Statuses.Success And Identity Is Nil Then
		    Raise New UnsupportedOperationException("Status is success, but no identity was included")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Identity As Beacon.Identity)
		  Self.Constructor(Statuses.Success, Identity)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Status As IdentityImportResponse.Statuses)
		  Self.Constructor(Status, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As IdentityImportResponse.Statuses
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Success() As Boolean
		  Return Self.mStatus = Statuses.Success
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As IdentityImportResponse.Statuses
	#tag EndProperty


	#tag Enum, Name = Statuses, Type = Integer, Flags = &h0
		Success
		  NoPrivateKey
		  SecretNeeded
		  IncompatibleEncryption
		GeneralError
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
			Name="mIdentity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
