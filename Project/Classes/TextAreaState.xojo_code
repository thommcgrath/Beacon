#tag Class
Protected Class TextAreaState
	#tag Method, Flags = &h0
		Sub ApplyTo(Area As TextArea)
		  Area.SelStart = Self.SelStart
		  Area.SelLength = Self.SelLength
		  Area.ScrollPosition = Self.ScrollPosition
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // No need to do anything
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Area As TextArea)
		  Self.ScrollPosition = Area.ScrollPosition
		  Self.SelStart = Area.SelStart
		  Self.SelLength = Area.SelLength
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
		#tag ViewProperty
			Name="SelStart"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
