#tag Class
Protected Class PopulationFigures
	#tag Method, Flags = &h0
		Sub Constructor(MapName As String, Instances As Integer, TargetPopulation As Integer)
		  Self.mMapName = MapName
		  Self.mInstances = Instances
		  Self.mTargetPopulation = TargetPopulation
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Instances() As Integer
		  Return Self.mInstances
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MapName() As String
		  Return Self.mMapName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TargetPopulation() As Integer
		  Return Self.mTargetPopulation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mInstances As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetPopulation As Integer
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
