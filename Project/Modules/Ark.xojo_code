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
		  Else
		    Return Ark.Qualities.Ascendant
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function QualityToText(Quality As Ark.Qualities) As Text
		  Select Case Quality
		  Case Ark.Qualities.Primitive
		    Return Ark.LabelPrimitive
		  Case Ark.Qualities.Ramshackle
		    Return Ark.LabelRamshackle
		  Case Ark.Qualities.Apprentice
		    Return Ark.LabelApprentice
		  Case Ark.Qualities.Journeyman
		    Return Ark.LabelJourneyman
		  Case Ark.Qualities.Mastercraft
		    Return Ark.LabelMastercraft
		  Case Ark.Qualities.Ascendant
		    Return Ark.LabelAscendant
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TextToQuality(Quality As Text) As Ark.Qualities
		  Select Case Quality
		  Case Ark.LabelPrimitive
		    Return Ark.Qualities.Primitive
		  Case Ark.LabelRamshackle
		    Return Ark.Qualities.Ramshackle
		  Case Ark.LabelApprentice
		    Return Ark.Qualities.Apprentice
		  Case Ark.LabelJourneyman
		    Return Ark.Qualities.Journeyman
		  Case Ark.LabelMastercraft
		    Return Ark.Qualities.Mastercraft
		  Case Ark.LabelAscendant
		    Return Ark.Qualities.Ascendant
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
		  Else
		    Return Ark.QualityPrimitive / Multiplier
		  End Select
		End Function
	#tag EndMethod


	#tag Constant, Name = LabelApprentice, Type = Text, Dynamic = False, Default = \"Apprentice", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelAscendant, Type = Text, Dynamic = False, Default = \"Ascendant", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelJourneyman, Type = Text, Dynamic = False, Default = \"Journeyman", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelMastercraft, Type = Text, Dynamic = False, Default = \"Mastercraft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelPrimitive, Type = Text, Dynamic = False, Default = \"Primitive", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LabelRamshackle, Type = Text, Dynamic = False, Default = \"Ramshackle", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityApprentice, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityAscendant, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
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
