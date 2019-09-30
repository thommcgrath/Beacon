#tag Module
Protected Module Tests
	#tag Method, Flags = &h1
		Protected Sub Assert(Value As Boolean, Message As String)
		  If Value = False Then
		    System.DebugLog(Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunTests()
		  #if DebugBuild
		    TestQualities()
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestQualities()
		  #if DebugBuild
		    Dim Quality As Beacon.Quality = Beacon.Qualities.Tier4
		    Dim StandardDifficulty As New BeaconConfigs.Difficulty(5)
		    Dim HighDifficulty As New BeaconConfigs.Difficulty(15)
		    Dim ExtremeDifficulty As New BeaconConfigs.Difficulty(100)
		    Dim Source As Beacon.LootSource = LocalData.SharedInstance.GetLootSource("SupplyCrate_Cave_QualityTier3_ScorchedEarth_C")
		    
		    Dim QualityStandardMin As Double = Quality.Value(Source.Multipliers.Min, StandardDifficulty)
		    Dim QualityStandardMax As Double = Quality.Value(Source.Multipliers.Max, StandardDifficulty)
		    Dim QualityHighMin As Double = Quality.Value(Source.Multipliers.Min, HighDifficulty)
		    Dim QualityHighMax As Double = Quality.Value(Source.Multipliers.Max, HighDifficulty)
		    Dim QualityExtremeMin As Double = Quality.Value(Source.Multipliers.Min, ExtremeDifficulty)
		    Dim QualityExtremeMax As Double = Quality.Value(Source.Multipliers.Max, ExtremeDifficulty)
		    
		    // Compare backwards because we expect lower values for higher difficulties
		    Assert(QualityExtremeMin < QualityHighMin And QualityHighMin < QualityStandardMin And QualityExtremeMax < QualityHighMax And QualityHighMax < QualityStandardMax, "Qualities are equal regardless of difficulty")
		    
		    Dim StandardQualityMin As Beacon.Quality = Beacon.Qualities.ForValue(QualityStandardMin, Source.Multipliers.Min, StandardDifficulty)
		    Dim StandardQualityMax As Beacon.Quality = Beacon.Qualities.ForValue(QualityStandardMax, Source.Multipliers.Max, StandardDifficulty)
		    Dim HighQualityMin As Beacon.Quality = Beacon.Qualities.ForValue(QualityHighMin, Source.Multipliers.Min, HighDifficulty)
		    Dim HighQualityMax As Beacon.Quality = Beacon.Qualities.ForValue(QualityHighMax, Source.Multipliers.Max, HighDifficulty)
		    Dim ExtremeQualityMin As Beacon.Quality = Beacon.Qualities.ForValue(QualityExtremeMin, Source.Multipliers.Min, ExtremeDifficulty)
		    Dim ExtremeQualityMax As Beacon.Quality = Beacon.Qualities.ForValue(QualityExtremeMax, Source.Multipliers.Max, ExtremeDifficulty)
		    
		    Assert(StandardQualityMin = Quality, "Expected quality min " + Language.LabelForQuality(Quality) + " but got " + Language.LabelForQuality(StandardQualityMin) + " for difficulty 5")
		    Assert(StandardQualityMax = Quality, "Expected quality max " + Language.LabelForQuality(Quality) + " but got " + Language.LabelForQuality(StandardQualityMax) + " for difficulty 5")
		    Assert(HighQualityMin = Quality, "Expected quality min " + Language.LabelForQuality(Quality) + " but got " + Language.LabelForQuality(HighQualityMin) + " for difficulty 15")
		    Assert(HighQualityMax = Quality, "Expected quality max " + Language.LabelForQuality(Quality) + " but got " + Language.LabelForQuality(HighQualityMax) + " for difficulty 15")
		    Assert(ExtremeQualityMin = Quality, "Expected quality min " + Language.LabelForQuality(Quality) + " but got " + Language.LabelForQuality(ExtremeQualityMin) + " for difficulty 100")
		    Assert(ExtremeQualityMin = Quality, "Expected quality max " + Language.LabelForQuality(Quality) + " but got " + Language.LabelForQuality(ExtremeQualityMax) + " for difficulty 100")
		  #endif
		End Sub
	#tag EndMethod


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
	#tag EndViewBehavior
End Module
#tag EndModule
