#tag Class
Protected Class ColorPair
	#tag Method, Flags = &h0
		Function Background() As Color
		  Return Self.mBackground
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As BeaconUI.ColorPair)
		  Self.mForeground = Source.mForeground
		  Self.mBackground = Source.mBackground
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Foreground As Color, Background As Color)
		  Self.mForeground = Foreground
		  Self.mBackground = Background
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contrast() As Double
		  Return Self.mForeground.ContrastAgainst(Self.mBackground)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Foreground() As Color
		  Return Self.mForeground
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mBackground As Color
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mForeground As Color
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
