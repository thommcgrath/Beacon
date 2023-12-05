#tag Class
Protected Class Game
	#tag Method, Flags = &h0
		Sub Constructor(Identifier As String, Name As String, OmniFlags As Integer, Features As Integer)
		  Self.mIdentifier = Identifier
		  Self.mName = Name
		  Self.mFlags = OmniFlags
		  Self.mFeatures = Features
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Features() As Integer
		  Return Self.mFeatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flags() As Integer
		  Return Self.mFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasFeature(Feature As Integer) As Boolean
		  Return (Self.mFeatures And Feature) > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFeatures As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty


	#tag Constant, Name = FeatureModDiscovery, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FeatureMods, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FeatureTemplates, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
	#tag EndViewBehavior
End Class
#tag EndClass
