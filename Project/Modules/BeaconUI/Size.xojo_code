#tag Class
Protected Class Size
	#tag Method, Flags = &h0
		Function Area() As Double
		  Return Self.Width * Self.Height
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Other As BeaconUI.Size)
		  Self.Constructor(Other.Width, Other.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Width As Double, Height As Double)
		  Self.Width = Width
		  Self.Height = Height
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Height As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Width As Double
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
			Name="Width"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
