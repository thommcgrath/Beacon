#tag Module
Protected Module Language
	#tag Method, Flags = &h1
		Protected Function LabelForQuality(Quality As Ark.Qualities) As String
		  Select Case Quality
		  Case Ark.Qualities.Primitive
		    Return QualityPrimitive
		  Case Ark.Qualities.Ramshackle
		    Return QualityRamshackle
		  Case Ark.Qualities.Apprentice
		    Return QualityApprentice
		  Case Ark.Qualities.Journeyman
		    Return QualityJourneyman
		  Case Ark.Qualities.Mastercraft
		    Return QualityMastercraft
		  Case Ark.Qualities.Ascendant
		    Return QualityAscendant
		  Case Ark.Qualities.AscendantPlus
		    Return QualityAscendantPlus
		  Case Ark.Qualities.AscendantPlusPlus
		    Return QualityAscendantPlusPlus
		  Case Ark.Qualities.AscendantPlusPlusPlus
		    Return QualityAscendantPlusPlusPlus
		  Else
		    Return ""
		  End Select
		End Function
	#tag EndMethod


	#tag Constant, Name = QualityApprentice, Type = String, Dynamic = False, Default = \"Apprentice", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendant, Type = String, Dynamic = False, Default = \"Ascendant", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlus, Type = String, Dynamic = False, Default = \"Epic", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlusPlus, Type = String, Dynamic = False, Default = \"Legendary", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlusPlusPlus, Type = String, Dynamic = False, Default = \"Pearlescent", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityJourneyman, Type = String, Dynamic = False, Default = \"Journeyman", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityMastercraft, Type = String, Dynamic = False, Default = \"Mastercraft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityPrimitive, Type = String, Dynamic = False, Default = \"Primitive", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityRamshackle, Type = String, Dynamic = False, Default = \"Ramshackle", Scope = Protected
	#tag EndConstant


End Module
#tag EndModule
