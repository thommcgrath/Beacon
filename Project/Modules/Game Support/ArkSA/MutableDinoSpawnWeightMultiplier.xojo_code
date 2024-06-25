#tag Class
Protected Class MutableDinoSpawnWeightMultiplier
Inherits ArkSA.DinoSpawnWeightMultiplier
	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.DinoSpawnWeightMultiplier
		  Return New ArkSA.DinoSpawnWeightMultiplier(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(Assigns Value As NullableDouble)
		  Self.mLimit = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Multiplier(Assigns Value As Double)
		  Self.mMultiplier = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableDinoSpawnWeightMultiplier
		  Return Self
		End Function
	#tag EndMethod


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
