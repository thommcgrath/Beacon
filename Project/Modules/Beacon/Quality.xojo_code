#tag Class
Protected Class Quality
	#tag Method, Flags = &h0
		Function BaseValue() As Double
		  Return Self.mBaseValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BaseValue As Double, Key As Text)
		  Self.mKey = Key
		  Self.mBaseValue = BaseValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As Text
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
		Function Value(CrateQualityMultiplier As Double, DifficultyValue As Double) As Double
		  Dim CrateArbitraryQuality As Double = CrateQualityMultiplier + ((CrateQualityMultiplier - 1) * 0.2)
		  Dim Multiplier As Double = CrateArbitraryQuality * DifficultyValue
		  Return Self.mBaseValue / Multiplier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBaseValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As Text
	#tag EndProperty


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
End Class
#tag EndClass
