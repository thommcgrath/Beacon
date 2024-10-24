#tag Class
Protected Class LootSimulatorSelection
	#tag Method, Flags = &h0
		Shared Sub ComputeSimulatorFigures(Pool() As ArkSA.Weighted, WeightScale As Integer, ByRef WeightSum As Double, ByRef Weights() As Double, ByRef WeightLookup As Dictionary)
		  Weights.ResizeTo(-1)
		  WeightLookup = New Dictionary
		  WeightSum = 0
		  
		  For Each Item As ArkSA.Weighted In Pool
		    If Item.RawWeight = 0 Then
		      Continue
		    End If
		    WeightSum = WeightSum + Item.RawWeight
		    Weights.Add(WeightSum * WeightScale)
		    WeightLookup.Value(WeightSum * WeightScale) = Item
		  Next
		  Weights.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Engram.Label + if(Self.IsBlueprint And Engram.IsTagged("blueprintable"), " Blueprint", "")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Engram As ArkSA.Engram
	#tag EndProperty

	#tag Property, Flags = &h0
		IsBlueprint As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Quality As ArkSA.Quality
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
