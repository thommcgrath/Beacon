#tag Class
Protected Class SimulatedSelection
	#tag Method, Flags = &h0
		Function Description() As Text
		  Return Engram.Label + if(Self.IsBlueprint And Engram.IsTagged("blueprintable"), " Blueprint", "")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Engram As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h0
		IsBlueprint As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Quality As Beacon.Quality
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsBlueprint"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
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
