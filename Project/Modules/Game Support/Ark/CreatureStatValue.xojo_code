#tag Class
Protected Class CreatureStatValue
	#tag Method, Flags = &h0
		Function AddMultiplier() As Double
		  Return Self.mAddMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AffinityMultiplier() As Double
		  Return Self.mAffinityMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BaseValue() As Double
		  Return Self.mBaseValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Stat As Ark.Stat, BaseValue As Double, WildMultiplier As Double, TamedMultiplier As Double, AddMultiplier As Double, AffinityMultiplier As Double)
		  Self.mStat = Stat
		  Self.mBaseValue = BaseValue
		  Self.mWildMultiplier = WildMultiplier
		  Self.mTamedMultiplier = TamedMultiplier
		  Self.mAddMultiplier = AddMultiplier
		  Self.mAffinityMultiplier = AffinityMultiplier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Ark.CreatureStatValue
		  If Dict Is Nil Or Dict.HasAllKeys("stat_index", "base_value", "per_level_wild_multiplier", "per_level_tamed_multiplier", "add_multiplier", "affinity_multiplier") = False Then
		    Return Nil
		  End If
		  
		  Var Stat As Ark.Stat = Ark.Stats.WithIndex(Dict.Value("stat_index").IntegerValue)
		  If Stat Is Nil Then
		    Return Nil
		  End If
		  
		  Return New Ark.CreatureStatValue(Stat, Dict.Value("base_value").DoubleValue, Dict.Value("per_level_wild_multiplier").DoubleValue, Dict.Value("per_level_tamed_multiplier").DoubleValue, Dict.Value("add_multiplier").DoubleValue, Dict.Value("affinity_multiplier").DoubleValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt16
		  Return Self.mStat.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.CreatureStatValue) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var Result As Integer = Self.mStat.Operator_Compare(Other.mStat)
		  If Result <> 0 Then
		    Return Result
		  End If
		  
		  If Self.mBaseValue > Other.mBaseValue Then
		    Return 1
		  ElseIf Self.mBaseValue < Other.mBaseValue Then
		    Return -1
		  End If
		  
		  If Self.mWildMultiplier > Other.mWildMultiplier Then
		    Return 1
		  ElseIf Self.mWildMultiplier < Other.mWildMultiplier Then
		    Return -1
		  End If
		  
		  If Self.mTamedMultiplier > Other.mTamedMultiplier Then
		    Return 1
		  ElseIf Self.mTamedMultiplier < Other.mTamedMultiplier Then
		    Return -1
		  End If
		  
		  If Self.mAddMultiplier > Other.mAddMultiplier Then
		    Return 1
		  ElseIf Self.mAddMultiplier < Other.mAddMultiplier Then
		    Return -1
		  End If
		  
		  If Self.mAffinityMultiplier > Other.mAffinityMultiplier Then
		    Return 1
		  ElseIf Self.mAffinityMultiplier < Other.mAffinityMultiplier Then
		    Return -1
		  End If
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("stat_index") = Self.mStat.Index
		  Dict.Value("base_value") = Self.mBaseValue
		  Dict.Value("per_level_wild_multiplier") = Self.mWildMultiplier
		  Dict.Value("per_level_tamed_multiplier") = Self.mTamedMultiplier
		  Dict.Value("add_multiplier") = Self.mAddMultiplier
		  Dict.Value("affinity_multiplier") = Self.mAffinityMultiplier
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Stat() As Ark.Stat
		  Return Self.mStat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedMultiplier() As Double
		  Return Self.mTamedMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WildMultiplier() As Double
		  Return Self.mWildMultiplier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAddMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAffinityMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBaseValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStat As Ark.Stat
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTamedMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWildMultiplier As Double
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
