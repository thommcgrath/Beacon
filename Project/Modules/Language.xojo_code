#tag Module
Protected Module Language
	#tag Method, Flags = &h1
		Protected Function LabelForQuality(Quality As Beacon.Qualities) As String
		  Select Case Quality
		  Case Beacon.Qualities.Primitive
		    Return QualityPrimitive
		  Case Beacon.Qualities.Ramshackle
		    Return QualityRamshackle
		  Case Beacon.Qualities.Apprentice
		    Return QualityApprentice
		  Case Beacon.Qualities.Journeyman
		    Return QualityJourneyman
		  Case Beacon.Qualities.Mastercraft
		    Return QualityMastercraft
		  Case Beacon.Qualities.Ascendant
		    Return QualityAscendant
		  Case Beacon.Qualities.AscendantPlus
		    Return QualityAscendantPlus
		  Case Beacon.Qualities.AscendantPlusPlus
		    Return QualityAscendantPlusPlus
		  Case Beacon.Qualities.AscendantPlusPlusPlus
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
