#tag Class
Protected Class DinoSpawnWeightMultiplier
	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.DinoSpawnWeightMultiplier)
		  Self.mMultiplier = Source.mMultiplier
		  Self.mLimit = Source.mLimit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Multiplier As Double)
		  Self.Constructor(Multiplier, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Multiplier As Double, Limit As NullableDouble)
		  Self.mMultiplier = Multiplier
		  Self.mLimit = Limit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As Dictionary) As ArkSA.DinoSpawnWeightMultiplier
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  Return FromSaveData(New JSONItem(Source))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Source As JSONItem) As ArkSA.DinoSpawnWeightMultiplier
		  If Source Is Nil Then
		    Return Nil
		  End If
		  
		  Try
		    Var Multiplier As Double = Source.Value("multiplier")
		    Var Limit As NullableDouble = NullableDouble.FromVariant(Source.Value("limit"))
		    Return New ArkSA.DinoSpawnWeightMultiplier(Multiplier, Limit)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As ArkSA.DinoSpawnWeightMultiplier
		  Return New ArkSA.DinoSpawnWeightMultiplier(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.DinoSpawnWeightMultiplier
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit() As NullableDouble
		  Return Self.mLimit
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Multiplier() As Double
		  Return Self.mMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As ArkSA.MutableDinoSpawnWeightMultiplier
		  Return New ArkSA.MutableDinoSpawnWeightMultiplier(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableDinoSpawnWeightMultiplier
		  Return New ArkSA.MutableDinoSpawnWeightMultiplier(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.DinoSpawnWeightMultiplier) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mMultiplier > Other.mMultiplier Then
		    Return 1
		  ElseIf Self.mMultiplier < Other.mMultiplier Then
		    Return -1
		  ElseIf (Self.mLimit Is Nil) = False And Other.mLimit Is Nil Then
		    Return 1
		  ElseIf Self.mLimit Is Nil And (Other.mLimit Is Nil) = False Then
		    Return -1
		  ElseIf Self.mLimit Is Nil And Other.mLimit Is Nil Then
		    Return 0
		  Else
		    Return Self.mLimit.Operator_Compare(Other.mLimit)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("multiplier") = Self.mMultiplier
		  Dict.Value("limit") = NullableDouble.ToVariant(Self.mLimit)
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Return New JSONItem(Self.ToDictionary)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mLimit As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMultiplier As Double
	#tag EndProperty


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
