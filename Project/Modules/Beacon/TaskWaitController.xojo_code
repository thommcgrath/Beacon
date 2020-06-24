#tag Class
Protected Class TaskWaitController
	#tag Method, Flags = &h0
		Function Action() As String
		  Return Self.mAction
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Action As String, UserData As Variant = Nil)
		  Self.mAction = Action
		  Self.UserData = UserData
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Cancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAction As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ShouldResume As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		UserData As Variant
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
			Name="Cancelled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShouldResume"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
