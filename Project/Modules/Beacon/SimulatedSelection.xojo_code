#tag Class
Protected Class SimulatedSelection
	#tag Method, Flags = &h0
		Function Description() As Text
		  Dim Engram As Beacon.Engram = Beacon.Data.GetEngram(Self.ClassString)
		  Dim Label As Text = if(Engram <> Nil, Engram.Label, Engram.ClassString)
		  Return Beacon.QualityToText(Self.Quality) + " " + Label + if(Self.IsBlueprint, " Blueprint", "")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ClassString As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		IsBlueprint As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Quality As Beacon.Qualities
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ClassString"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
