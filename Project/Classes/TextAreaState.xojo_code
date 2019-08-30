#tag Class
Protected Class TextAreaState
	#tag Method, Flags = &h0
		Sub ApplyTo(Area As TextArea)
		  Area.SelectionStart = Self.SelStart
		  Area.SelectionLength = Self.SelLength
		  Area.VerticalScrollPosition = Self.ScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // No need to do anything
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Area As TextArea)
		  Self.ScrollPosition = Area.VerticalScrollPosition
		  Self.SelStart = Area.SelectionStart
		  Self.SelLength = Area.SelectionLength
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ScrollPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SelLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SelStart As Integer
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
			Name="SelStart"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelLength"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
