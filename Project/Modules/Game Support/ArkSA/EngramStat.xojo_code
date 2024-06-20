#tag Class
Protected Class EngramStat
	#tag Method, Flags = &h0
		Function ComputeEffectiveLimit(Value As Double) As Double
		  Return Self.mInitialValueConstant + ((Value * Self.mStateModifierScale) * (Self.mRandomizerRangeMultiplier * Self.mInitialValueConstant))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // Just making it private
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As Dictionary) As ArkSA.EngramStat
		  Var Converted As New JSONItem(Source)
		  Return FromSaveData(Converted)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As JSONItem) As ArkSA.EngramStat
		  Var Stat As New ArkSA.EngramStat
		  Stat.mInitialValueConstant = Source.Value("initialValueConstant")
		  Stat.mRandomizerRangeMultiplier = Source.Value("randomizerRangeMultiplier")
		  Stat.mRandomizerRangeOverride = Source.Value("randomizerRangeOverride")
		  Stat.mRatingValueMultiplier = Source.Value("ratingValueMultiplier")
		  Stat.mStateModifierScale = Source.Value("stateModifierScale")
		  Stat.mStatIndex = Source.Value("statIndex")
		  Return Stat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InitialValueConstant() As Double
		  Return Self.mInitialValueConstant
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RandomizerRangeMultiplier() As Double
		  Return Self.mRandomizerRangeMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RandomizerRangeOverride() As Double
		  Return Self.mRandomizerRangeOverride
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RatingValueMultiplier() As Double
		  Return Self.mRatingValueMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("statIndex") = Self.mStatIndex
		  Dict.Value("randomizerRangeOverride") = Self.mRandomizerRangeOverride
		  Dict.Value("randomizerRangeMultiplier") = Self.mRandomizerRangeMultiplier
		  Dict.Value("stateModifierScale") = Self.mStateModifierScale
		  Dict.Value("ratingValueMultiplier") = Self.mRatingValueMultiplier
		  Dict.Value("initialValueConstant") = Self.mInitialValueConstant
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SolveForDesiredLimit(Limit As Double) As Double
		  Return (Limit - Self.mInitialValueConstant) / (Self.mStateModifierScale * Self.mRandomizerRangeMultiplier * Self.mInitialValueConstant)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StateModifierScale() As Double
		  Return Self.mStateModifierScale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatIndex() As Integer
		  Return Self.mStatIndex
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mInitialValueConstant As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRandomizerRangeMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRandomizerRangeOverride As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRatingValueMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStateModifierScale As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatIndex As Integer
	#tag EndProperty


	#tag Constant, Name = FirstIndex, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexArmor, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexGenericQuality, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexHyperthermal, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexHypothermal, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexMaxDurability, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexWeaponAmmo, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexWeaponDamage, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IndexWeight, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LastIndex, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant


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
End Class
#tag EndClass
