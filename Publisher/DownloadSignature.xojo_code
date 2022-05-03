#tag Class
Protected Class DownloadSignature
	#tag Method, Flags = &h0
		Sub Constructor(Signature As String, Format As String)
		  Select Case Format
		  Case Self.SignatureDSA, Self.SignatureEdDSA, Self.SignatureRSA
		    Self.mSignature = Signature
		    Self.mFormat = Format
		    Self.mUUID = New v4UUID
		  Else
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Bad signature format"
		    Raise Err
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Format() As String
		  Return Self.mFormat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Signature() As String
		  Return Self.mSignature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFormat As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
	#tag EndProperty


	#tag Constant, Name = SignatureDSA, Type = String, Dynamic = False, Default = \"DSA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SignatureEdDSA, Type = String, Dynamic = False, Default = \"ed25519", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SignatureRSA, Type = String, Dynamic = False, Default = \"RSA", Scope = Public
	#tag EndConstant


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
			Name="mSignature"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
