#tag Module
Protected Module Ark
	#tag Method, Flags = &h1
		Protected Function QualityForValue(Quality As Double, Multiplier As Double) As Ark.Qualities
		  Quality = Quality * Multiplier
		  
		  If Quality < Ark.QualityRamshackle Then
		    Return Ark.Qualities.Primitive
		  ElseIf Quality < Ark.QualityApprentice Then
		    Return Ark.Qualities.Ramshackle
		  ElseIf Quality < Ark.QualityJourneyman Then
		    Return Ark.Qualities.Apprentice
		  ElseIf Quality < Ark.QualityMastercraft Then
		    Return Ark.Qualities.Journeyman
		  ElseIf Quality < Ark.QualityAscendant Then
		    Return Ark.Qualities.Mastercraft
		  ElseIf Quality < Ark.QualityAscendantPlus Then
		    Return Ark.Qualities.Ascendant
		  ElseIf Quality < Ark.QualityAscendantPlusPlus Then
		    Return Ark.Qualities.AscendantPlus
		  ElseIf Quality < Ark.QualityAscendantPlusPlusPlus Then
		    Return Ark.Qualities.AscendantPlusPlus
		  Else
		    Return Ark.Qualities.AscendantPlusPlusPlus
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function QualityToText(Quality As Ark.Qualities) As Text
		  Select Case Quality
		  Case Ark.Qualities.Primitive
		    Return "Tier1"
		  Case Ark.Qualities.Ramshackle
		    Return "Tier2"
		  Case Ark.Qualities.Apprentice
		    Return "Tier3"
		  Case Ark.Qualities.Journeyman
		    Return "Tier4"
		  Case Ark.Qualities.Mastercraft
		    Return "Tier5"
		  Case Ark.Qualities.Ascendant
		    Return "Tier6"
		  Case Ark.Qualities.AscendantPlus
		    Return "Tier7"
		  Case Ark.Qualities.AscendantPlusPlus
		    Return "Tier8"
		  Case Ark.Qualities.AscendantPlusPlusPlus
		    Return "Tier9"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextToQuality(Quality As Text) As Ark.Qualities
		  Select Case Quality
		  Case "Tier1"
		    Return Ark.Qualities.Primitive
		  Case "Tier2"
		    Return Ark.Qualities.Ramshackle
		  Case "Tier3"
		    Return Ark.Qualities.Apprentice
		  Case "Tier4"
		    Return Ark.Qualities.Journeyman
		  Case "Tier5"
		    Return Ark.Qualities.Mastercraft
		  Case "Tier6"
		    Return Ark.Qualities.Ascendant
		  Case "Tier7"
		    Return Ark.Qualities.AscendantPlus
		  Case "Tier8"
		    Return Ark.Qualities.AscendantPlusPlus
		  Case "Tier9"
		    Return Ark.Qualities.AscendantPlusPlusPlus
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound(Item As Ark.Countable) As Integer
		  Return Item.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound(Extends Item As Ark.Countable) As Integer
		  Return Item.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValueForQuality(Quality As Ark.Qualities, Multiplier As Double) As Double
		  Select Case Quality
		  Case Ark.Qualities.Primitive
		    Return Ark.QualityPrimitive / Multiplier
		  Case Ark.Qualities.Ramshackle
		    Return Ark.QualityRamshackle / Multiplier
		  Case Ark.Qualities.Apprentice
		    Return Ark.QualityApprentice / Multiplier
		  Case Ark.Qualities.Journeyman
		    Return Ark.QualityJourneyman / Multiplier
		  Case Ark.Qualities.Mastercraft
		    Return Ark.QualityMastercraft / Multiplier
		  Case Ark.Qualities.Ascendant
		    Return Ark.QualityAscendant / Multiplier
		  Case Ark.Qualities.AscendantPlus
		    Return Ark.QualityAscendantPlus / Multiplier
		  Case Ark.Qualities.AscendantPlusPlus
		    Return Ark.QualityAscendantPlusPlus / Multiplier
		  Case Ark.Qualities.AscendantPlusPlusPlus
		    Return Ark.QualityAscendantPlusPlusPlus / Multiplier
		  Else
		    Return Ark.QualityPrimitive / Multiplier
		  End Select
		End Function
	#tag EndMethod


	#tag Constant, Name = QualityApprentice, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendant, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlus, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlusPlus, Type = Double, Dynamic = False, Default = \"12", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendantPlusPlusPlus, Type = Double, Dynamic = False, Default = \"16", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityJourneyman, Type = Double, Dynamic = False, Default = \"3.75", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityMastercraft, Type = Double, Dynamic = False, Default = \"5.5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityPrimitive, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityRamshackle, Type = Double, Dynamic = False, Default = \"1.25", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Qualities, Type = Integer, Flags = &h1
		Primitive
		  Ramshackle
		  Apprentice
		  Journeyman
		  Mastercraft
		  Ascendant
		  AscendantPlus
		  AscendantPlusPlus
		AscendantPlusPlusPlus
	#tag EndEnum


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
