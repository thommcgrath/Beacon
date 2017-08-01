#tag Module
Protected Module Qualities
	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Quality()
		  Dim Qualities(8) As Beacon.Quality
		  Qualities(0) = Tier1
		  Qualities(1) = Tier2
		  Qualities(2) = Tier3
		  Qualities(3) = Tier4
		  Qualities(4) = Tier5
		  Qualities(5) = Tier6
		  Qualities(6) = Tier7
		  Qualities(7) = Tier8
		  Qualities(8) = Tier9
		  Return Qualities
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForBaseValue(BaseValue As Double) As Beacon.Quality
		  Dim List() As Beacon.Quality = All
		  For I As Integer = 0 To UBound(List)
		    If BaseValue < List(I).BaseValue Then
		      If I = 0 Then
		        Return List(0)
		      Else
		        Return List(I - 1)
		      End If
		    End If
		  Next
		  Return List(UBound(List))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForKey(Key As Text) As Beacon.Quality
		  Dim List() As Beacon.Quality = All
		  For Each Quality As Beacon.Quality In List
		    If Quality.Key = Key Then
		      Return Quality
		    End If
		  Next
		  Return List(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForValue(Value As Double, CrateQualityMultiplier As Double, DifficultyValue As Double) As Beacon.Quality
		  Dim CrateArbitraryQuality As Double = CrateQualityMultiplier + ((CrateQualityMultiplier - 1) * 0.2)
		  Dim Multiplier As Double = CrateArbitraryQuality * DifficultyValue
		  Dim Quality As Double = Value * Multiplier
		  
		  // Thanks to math, we can get the quality as 15.99999 instead of 16. So rounding it is.
		  Quality = Xojo.Math.Round(Quality * 10000) / 10000
		  
		  Return ForBaseValue(Quality)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier1() As Beacon.Quality
		  Return New Beacon.Quality(0.0, "Tier1")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier2() As Beacon.Quality
		  Return New Beacon.Quality(4.0, "Tier2")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier3() As Beacon.Quality
		  Return New Beacon.Quality(6.4, "Tier3")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier4() As Beacon.Quality
		  Return New Beacon.Quality(12.0, "Tier4")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier5() As Beacon.Quality
		  Return New Beacon.Quality(17.6, "Tier5")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier6() As Beacon.Quality
		  Return New Beacon.Quality(22.4, "Tier6")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier7() As Beacon.Quality
		  Return New Beacon.Quality(28.8, "Tier7")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier8() As Beacon.Quality
		  Return New Beacon.Quality(35.2, "Tier8")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Tier9() As Beacon.Quality
		  Return New Beacon.Quality(44.8, "Tier9")
		End Function
	#tag EndMethod


End Module
#tag EndModule
