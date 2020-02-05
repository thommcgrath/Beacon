#tag Class
Protected Class Quality
	#tag Method, Flags = &h0
		Function BaseValue() As Double
		  Return Self.mBaseValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BaseValue As Double, Key As String)
		  Self.mKey = Key
		  Self.mBaseValue = BaseValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Quality) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.BaseValue > Other.Basevalue Then
		    Return 1
		  ElseIf Self.BaseValue < Other.BaseValue Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(CrateQualityMultiplier As Double, Difficulty As BeaconConfigs.Difficulty) As Double
		  Var CrateArbitraryQuality As Double = CrateQualityMultiplier + ((CrateQualityMultiplier - 1) * 0.2)
		  Return Self.mBaseValue / (Difficulty.BaseArbitraryQuality * CrateArbitraryQuality)
		  
		  // Todo: Self.mBaseValue / (Difficulty.BaseArbitraryQuality * CrateArbitraryQuality) / RatingValueMultiplier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As String
	#tag EndProperty


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
