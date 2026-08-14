#tag Class
Private Class EndpointDetails
	#tag Method, Flags = &h0
		Function BaseUrl() As String
		  Return Self.mBaseUrl
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BaseUrl As String, FeatureFlags As UInt64)
		  Self.mBaseUrl = BaseUrl
		  Self.mFeatureFlags = FeatureFlags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FeatureFlags() As UInt64
		  Return Self.mFeatureFlags
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseUrl As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFeatureFlags As UInt64
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
			Name="mBaseUrl"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
