#tag Class
Private Class ControlTweak
	#tag Method, Flags = &h0
		Sub Constructor(TopDelta As Integer, HeightDelta As Integer)
		  Self.mTopDelta = TopDelta
		  Self.mHeightDelta = HeightDelta
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HeightDelta() As Integer
		  Return Self.mHeightDelta
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TopDelta() As Integer
		  Return Self.mTopDelta
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHeightDelta As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTopDelta As Integer
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
