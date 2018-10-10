#tag Module
Protected Module Language
	#tag Method, Flags = &h1
		Protected Function LabelForConfig(Config As Beacon.ConfigGroup) As Text
		  Return Language.LabelForConfig(Config.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(ConfigName As Text) As Text
		  Select Case ConfigName
		  Case BeaconConfigs.Difficulty.ConfigName
		    Return "Difficulty"
		  Case BeaconConfigs.LootDrops.ConfigName
		    Return "Loot Drop Contents"
		  Case BeaconConfigs.LootScale.ConfigName
		    Return "Loot Quality Scaling"
		  Case BeaconConfigs.Metadata.ConfigName
		    Return "Document Properties"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForQuality(Quality As Beacon.Quality, Abbreviated As Boolean = False) As String
		  Select Case Quality.Key
		  Case Beacon.Qualities.Tier1.Key
		    Return If(Abbreviated, QualityTier1Abbreviated, QualityTier1)
		  Case Beacon.Qualities.Tier2.Key
		    Return If(Abbreviated, QualityTier2Abbreviated, QualityTier2)
		  Case Beacon.Qualities.Tier3.Key
		    Return If(Abbreviated, QualityTier3Abbreviated, QualityTier3)
		  Case Beacon.Qualities.Tier4.Key
		    Return If(Abbreviated, QualityTier4Abbreviated, QualityTier4)
		  Case Beacon.Qualities.Tier5.Key
		    Return If(Abbreviated, QualityTier5Abbreviated, QualityTier5)
		  Case Beacon.Qualities.Tier6.Key
		    Return If(Abbreviated, QualityTier6Abbreviated, QualityTier6)
		  Case Beacon.Qualities.Tier7.Key
		    Return If(Abbreviated, QualityTier7Abbreviated, QualityTier7)
		  Case Beacon.Qualities.Tier8.Key
		    Return If(Abbreviated, QualityTier8Abbreviated, QualityTier8)
		  Case Beacon.Qualities.Tier9.Key
		    Return If(Abbreviated, QualityTier9Abbreviated, QualityTier9)
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

	#tag Constant, Name = QualityTier1Abbreviated, Type = String, Dynamic = False, Default = \"Prim", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier2, Type = String, Dynamic = False, Default = \"Ramshackle", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier2Abbreviated, Type = String, Dynamic = False, Default = \"Rams", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier3, Type = String, Dynamic = False, Default = \"Apprentice", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier3Abbreviated, Type = String, Dynamic = False, Default = \"Appr", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier4, Type = String, Dynamic = False, Default = \"Journeyman", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier4Abbreviated, Type = String, Dynamic = False, Default = \"Jrnymn", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier5, Type = String, Dynamic = False, Default = \"Mastercraft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier5Abbreviated, Type = String, Dynamic = False, Default = \"Mstrcft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier6, Type = String, Dynamic = False, Default = \"Ascendant", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier6Abbreviated, Type = String, Dynamic = False, Default = \"Asndt", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier7, Type = String, Dynamic = False, Default = \"Epic", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier7Abbreviated, Type = String, Dynamic = False, Default = \"Epic", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier8, Type = String, Dynamic = False, Default = \"Legendary", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier8Abbreviated, Type = String, Dynamic = False, Default = \"Lgndry", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier9, Type = String, Dynamic = False, Default = \"Pearlescent", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier9Abbreviated, Type = String, Dynamic = False, Default = \"Pearl", Scope = Protected
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
