#tag Class
Protected Class Quality
	#tag Method, Flags = &h0
		Function BaseValue() As Double
		  Return Self.mBaseValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BaseValue As Double)
		  Self.mKey = Self.KeyCustomQuality
		  Self.mBaseValue = BaseValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BaseValue As Double, Key As String)
		  Self.mKey = Key
		  Self.mBaseValue = BaseValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Variant) As ArkSA.Quality
		  If SaveData.IsNull Then
		    Return Nil
		  End If
		  
		  Select Case SaveData.Type
		  Case Variant.TypeString
		    Return ArkSA.Qualities.ForKey(SaveData.StringValue)
		  Case Variant.TypeDouble
		    Return New ArkSA.Quality(SaveData.DoubleValue)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCustom() As Boolean
		  Return Self.mKey = Self.KeyCustomQuality
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Full As Boolean = True) As String
		  Select Case Self.mKey
		  Case ArkSA.Qualities.Tier0.Key
		    Return If(Full, Self.QualityTier00, Self.QualityTier00Short)
		  Case ArkSA.Qualities.Tier1.Key
		    Return If(Full, Self.QualityTier01, Self.QualityTier01Short)
		  Case ArkSA.Qualities.Tier2.Key
		    Return If(Full, Self.QualityTier02, Self.QualityTier02Short)
		  Case ArkSA.Qualities.Tier3.Key
		    Return If(Full, Self.QualityTier03, Self.QualityTier03Short)
		  Case ArkSA.Qualities.Tier4.Key
		    Return If(Full, Self.QualityTier04, Self.QualityTier04Short)
		  Case ArkSA.Qualities.Tier5.Key
		    Return If(Full, Self.QualityTier05, Self.QualityTier05Short)
		  Case ArkSA.Qualities.Tier6.Key
		    Return If(Full, Self.QualityTier06, Self.QualityTier06Short)
		  Case ArkSA.Qualities.Tier7.Key
		    Return If(Full, Self.QualityTier07, Self.QualityTier07Short)
		  Case ArkSA.Qualities.Tier8.Key
		    Return If(Full, Self.QualityTier08, Self.QualityTier08Short)
		  Case ArkSA.Qualities.Tier9.Key
		    Return If(Full, Self.QualityTier09, Self.QualityTier09Short)
		  Case ArkSA.Qualities.Tier10.Key
		    Return If(Full, Self.QualityTier10, Self.QualityTier10Short)
		  Else
		    Return Self.mBaseValue.PrettyText(2)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.Quality) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyStringValue As String = Self.mBaseValue.PrettyText + ":" + Self.mKey.Lowercase
		  Var OtherStringValue As String = Other.mBaseValue.PrettyText + ":" + Other.mKey.Lowercase
		  Return MyStringValue.Compare(OtherStringValue, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Variant
		  If Self.IsCustom Then
		    Return Self.mBaseValue
		  Else
		    Return Self.mKey
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(CrateQualityMultiplier as Double, BaseArbitraryQuality as Double) As Double
		  If Self.mKey = Self.KeyCustomQuality Then
		    Return Self.mBaseValue
		  Else
		    Var CrateArbitraryQuality As Double = CrateQualityMultiplier + ((CrateQualityMultiplier - 1) * 0.2)
		    Return Self.mBaseValue / (BaseArbitraryQuality * CrateArbitraryQuality)
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As String
	#tag EndProperty


	#tag Constant, Name = KeyCustomQuality, Type = String, Dynamic = False, Default = \"Custom", Scope = Private
	#tag EndConstant

	#tag Constant, Name = QualityTier00, Type = String, Dynamic = False, Default = \"No Quality", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier00Short, Type = String, Dynamic = False, Default = \"None", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier01, Type = String, Dynamic = False, Default = \"Primitive", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier01Short, Type = String, Dynamic = False, Default = \"Prim", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier02, Type = String, Dynamic = False, Default = \"Ramshackle", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier02Short, Type = String, Dynamic = False, Default = \"Rams", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier03, Type = String, Dynamic = False, Default = \"Apprentice", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier03Short, Type = String, Dynamic = False, Default = \"Appr", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier04, Type = String, Dynamic = False, Default = \"Journeyman", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier04Short, Type = String, Dynamic = False, Default = \"Jrnymn", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier05, Type = String, Dynamic = False, Default = \"Mastercraft", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier05Short, Type = String, Dynamic = False, Default = \"Mstrcft", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier06, Type = String, Dynamic = False, Default = \"Ascendant", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier06Short, Type = String, Dynamic = False, Default = \"Asndt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier07, Type = String, Dynamic = False, Default = \"Epic", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier07Short, Type = String, Dynamic = False, Default = \"Epic", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier08, Type = String, Dynamic = False, Default = \"Legendary", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier08Short, Type = String, Dynamic = False, Default = \"Lgndry", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier09, Type = String, Dynamic = False, Default = \"Pearlescent", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier09Short, Type = String, Dynamic = False, Default = \"Pearl", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier10, Type = String, Dynamic = False, Default = \"Perfected", Scope = Public
	#tag EndConstant

	#tag Constant, Name = QualityTier10Short, Type = String, Dynamic = False, Default = \"Perf", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RatingValueMultiplierArmor, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RatingValueMultiplierDurability, Type = Double, Dynamic = False, Default = \"0.65", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RatingValueMultiplierOther, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RatingValueMultiplierSaddles, Type = Double, Dynamic = False, Default = \"1.55", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RatingValueMultiplierWeapons, Type = Double, Dynamic = False, Default = \"1.025", Scope = Private
	#tag EndConstant


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
