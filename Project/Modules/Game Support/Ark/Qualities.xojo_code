#tag Module
Protected Module Qualities
	#tag Method, Flags = &h1
		Protected Function All() As Ark.Quality()
		  Var Qualities(9) As Ark.Quality
		  Qualities(0) = Tier1
		  Qualities(1) = Tier2
		  Qualities(2) = Tier3
		  Qualities(3) = Tier4
		  Qualities(4) = Tier5
		  Qualities(5) = Tier6
		  Qualities(6) = Tier7
		  Qualities(7) = Tier8
		  Qualities(8) = Tier9
		  Qualities(9) = Tier10
		  Return Qualities
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForBaseValue(BaseValue As Double) As Ark.Quality
		  Var List() As Ark.Quality = All
		  For I As Integer = 0 To List.LastIndex
		    If BaseValue < List(I).BaseValue Then
		      If I = 0 Then
		        Return List(0)
		      Else
		        Return List(I - 1)
		      End If
		    End If
		  Next
		  Return List(List.LastIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForKey(Key As String) As Ark.Quality
		  Var List() As Ark.Quality = All
		  For Each Quality As Ark.Quality In List
		    If Quality.Key = Key Then
		      Return Quality
		    End If
		  Next
		  Return List(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForValue(Value As Double, CrateQualityMultiplier As Double, BaseArbitraryQuality As Double) As Ark.Quality
		  Var CrateArbitraryQuality As Double = CrateQualityMultiplier + ((CrateQualityMultiplier - 1) * 0.2)
		  Var Multiplier As Double = CrateArbitraryQuality * BaseArbitraryQuality
		  Var Quality As Double = Value * Multiplier
		  
		  // Thanks to math, we can get the quality as 15.99999 instead of 16. So rounding it is.
		  Quality = Round(Quality * 10000) / 10000
		  
		  Return ForBaseValue(Quality)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier1() As Ark.Quality
		  Return New Ark.Quality(0.5, "Tier1")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier10() As Ark.Quality
		  Return New Ark.Quality(100.0, "Tier10")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier2() As Ark.Quality
		  Return New Ark.Quality(3.0, "Tier2")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier3() As Ark.Quality
		  Return New Ark.Quality(5.0, "Tier3")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier4() As Ark.Quality
		  Return New Ark.Quality(8.7, "Tier4")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier5() As Ark.Quality
		  Return New Ark.Quality(12.5, "Tier5")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier6() As Ark.Quality
		  Return New Ark.Quality(20.0, "Tier6")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier7() As Ark.Quality
		  Return New Ark.Quality(40.0, "Tier7")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier8() As Ark.Quality
		  Return New Ark.Quality(60.0, "Tier8")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier9() As Ark.Quality
		  Return New Ark.Quality(80.0, "Tier9")
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
