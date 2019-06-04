#tag Class
Protected Class Issue
	#tag Method, Flags = &h0
		Function ConfigName() As Text
		  Return Self.mConfigName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ConfigName As Text, Description As Text, UserData As Auto = Nil)
		  Self.mConfigName = ConfigName
		  Self.mDescription = Description
		  Self.mUserData = UserData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As Text
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData() As Auto
		  Return Self.mUserData
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigName As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Auto
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
