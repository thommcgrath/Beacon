#tag Module
Protected Module Language
	#tag Method, Flags = &h1
		Protected Function LabelForQuality(Quality As Beacon.Quality) As String
		  Select Case Quality.Key
		  Case Beacon.Qualities.Tier1.Key
		    Return QualityTier1
		  Case Beacon.Qualities.Tier2.Key
		    Return QualityTier2
		  Case Beacon.Qualities.Tier3.Key
		    Return QualityTier3
		  Case Beacon.Qualities.Tier4.Key
		    Return QualityTier4
		  Case Beacon.Qualities.Tier5.Key
		    Return QualityTier5
		  Case Beacon.Qualities.Tier6.Key
		    Return QualityTier6
		  Case Beacon.Qualities.Tier7.Key
		    Return QualityTier7
		  Case Beacon.Qualities.Tier8.Key
		    Return QualityTier8
		  Case Beacon.Qualities.Tier9.Key
		    Return QualityTier9
		  Else
		    Return ""
		  End Select
		End Function
	#tag EndMethod


	#tag Constant, Name = LootSourceKindBonus, Type = String, Dynamic = True, Default = \"Bonus Beacon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindCave, Type = String, Dynamic = True, Default = \"Cave", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindSea, Type = String, Dynamic = True, Default = \"Deep Sea && Open Desert", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindStandard, Type = String, Dynamic = True, Default = \"Standard Beacon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier1, Type = String, Dynamic = False, Default = \"Primitive", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier2, Type = String, Dynamic = False, Default = \"Ramshackle", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier3, Type = String, Dynamic = False, Default = \"Apprentice", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier4, Type = String, Dynamic = False, Default = \"Journeyman", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier5, Type = String, Dynamic = False, Default = \"Mastercraft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier6, Type = String, Dynamic = False, Default = \"Ascendant", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier7, Type = String, Dynamic = False, Default = \"Epic", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier8, Type = String, Dynamic = False, Default = \"Legendary", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier9, Type = String, Dynamic = False, Default = \"Pearlescent", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
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
End Module
#tag EndModule
