#tag Class
Protected Class CreatureBehavior
	#tag Method, Flags = &h0
		Function Clone(NewTarget As Ark.Creature) As Ark.CreatureBehavior
		  Var Result As New Ark.CreatureBehavior(Self)
		  Result.mTargetCreature = New Ark.BlueprintReference(NewTarget)
		  Result.mModified = True
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Reference As Ark.BlueprintReference)
		  Self.mTargetCreature = Reference
		  Self.mDamageMultiplier = 1.0
		  Self.mResistanceMultiplier = 1.0
		  Self.mTamedDamageMultiplier = 1.0
		  Self.mTamedResistanceMultiplier = 1.0
		  Self.mProhibitSpawning = False
		  Self.mReplacementCreature = Nil
		  Self.mProhibitTaming = False
		  Self.mProhibitTransfer = False
		  Self.mSpawnWeightMultiplier = 1.0
		  Self.mSpawnLimitPercent = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Creature As Ark.Creature)
		  Self.Constructor(New Ark.BlueprintReference(Creature))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.CreatureBehavior)
		  Self.mTargetCreature = Source.mTargetCreature
		  Self.mReplacementCreature = Source.mReplacementCreature
		  Self.mProhibitSpawning = Source.mProhibitSpawning
		  Self.mModified = Source.mModified
		  Self.mDamageMultiplier = Source.mDamageMultiplier
		  Self.mResistanceMultiplier = Source.mResistanceMultiplier
		  Self.mTamedDamageMultiplier = Source.mTamedDamageMultiplier
		  Self.mTamedResistanceMultiplier = Source.mTamedResistanceMultiplier
		  Self.mProhibitTaming = Source.mProhibitTaming
		  Self.mProhibitTransfer = Source.mProhibitTransfer
		  Self.mSpawnWeightMultiplier = Source.mSpawnWeightMultiplier
		  Self.mSpawnLimitPercent = Source.mSpawnLimitPercent
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DamageMultiplier() As Double
		  Return Self.mDamageMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Ark.CreatureBehavior
		  
		  Var Behavior As Ark.CreatureBehavior
		  If Dict.HasKey("Target") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("Target"))
		    If Reference Is Nil Or Reference.IsCreature = False Then
		      Return Nil
		    End If
		    Behavior = New Ark.CreatureBehavior(Reference)
		  ElseIf Dict.HasAnyKey("UUID", "Path", "Class") Then
		    Var Creature As Ark.Creature = Ark.ResolveCreature(Dict, "UUID", "Path", "Class", Nil)
		    If Creature Is Nil Then
		      Return Nil
		    End If
		    Behavior = New Ark.CreatureBehavior(Creature)
		  Else
		    Return Nil
		  End If
		  
		  If Dict.HasKey("Prohibit Spawning") Then
		    Behavior.mProhibitSpawning = Dict.Value("Prohibit Spawning")
		  ElseIf Dict.HasKey("Replacement") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("Replacement"))
		    If (Reference Is Nil) = False And Reference.IsCreature Then
		      Behavior.mReplacementCreature = Reference
		    End If
		  ElseIf Dict.HasAnyKey("Replacement UUID", "Replacement Path", "Replacement Class") Then
		    Var Creature As Ark.Creature = Ark.ResolveCreature(Dict, "Replacement UUID", "Replacement Path", "Replacement Class", Nil)
		    If (Creature Is Nil) = False Then
		      Behavior.mReplacementCreature = New Ark.BlueprintReference(Creature)
		    End If
		  Else
		    Behavior.mDamageMultiplier = Dict.Lookup("Damage Multiplier", 1.0)
		    Behavior.mResistanceMultiplier = Dict.Lookup("Resistance Multiplier", 1.0)
		    Behavior.mTamedDamageMultiplier = Dict.Lookup("Tamed Damage Multiplier", 1.0)
		    Behavior.mTamedResistanceMultiplier = Dict.Lookup("Tamed Resistance Multiplier", 1.0)
		    Behavior.mSpawnWeightMultiplier = Dict.Lookup("Spawn Weight Multiplier", 1.0)
		    If Dict.HasKey("Spawn Limit Percent") Then
		      Behavior.mSpawnLimitPercent = Dict.Value("Spawn Limit Percent").DoubleValue
		    Else
		      Behavior.mSpawnLimitPercent = Nil
		    End If
		  End If
		  Behavior.mProhibitTaming = Dict.Lookup("Prevent Taming", False)
		  Behavior.mProhibitTransfer = Dict.Lookup("Prohibit Transfer", False)
		  
		  Return Behavior
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  Return Self.mTargetCreature.ObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitSpawning() As Boolean
		  Return Self.mProhibitSpawning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitTaming() As Boolean
		  Return Self.mProhibitTaming
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitTransfer() As Boolean
		  Return Self.mProhibitTransfer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreature() As Ark.Creature
		  If (Self.mReplacementCreature Is Nil) = False Then
		    Return Ark.Creature(Self.mReplacementCreature.Resolve)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResistanceMultiplier() As Double
		  Return Self.mResistanceMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnLimitPercent() As NullableDouble
		  Return Self.mSpawnLimitPercent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnWeightMultiplier() As Double
		  Return Self.mSpawnWeightMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedDamageMultiplier() As Double
		  Return Self.mTamedDamageMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedResistanceMultiplier() As Double
		  Return Self.mTamedResistanceMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TargetCreature() As Ark.Creature
		  Return Ark.Creature(Self.mTargetCreature.Resolve)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Target") = Self.mTargetCreature.SaveData
		  If Self.mProhibitSpawning Then
		    Dict.Value("Prohibit Spawning") = True
		  ElseIf IsNull(Self.mReplacementCreature) = False Then
		    Dict.Value("Replacement") = Self.mReplacementCreature.SaveData
		  Else
		    If Self.mDamageMultiplier <> 1.0 Then
		      Dict.Value("Damage Multiplier") = Self.mDamageMultiplier
		    End If
		    If Self.mResistanceMultiplier <> 1.0 Then
		      Dict.Value("Resistance Multiplier") = Self.mResistanceMultiplier
		    End If
		    If Self.mTamedDamageMultiplier <> 1.0 Then
		      Dict.Value("Tamed Damage Multiplier") = Self.mTamedDamageMultiplier
		    End If
		    If Self.mTamedResistanceMultiplier <> 1.0 Then
		      Dict.Value("Tamed Resistance Multiplier") = Self.mTamedResistanceMultiplier
		    End If
		    If Self.mSpawnWeightMultiplier <> 1.0 Then
		      Dict.Value("Spawn Weight Multiplier") = Self.mSpawnWeightMultiplier
		    End If
		    If (Self.mSpawnLimitPercent Is Nil) = False Then
		      Dict.Value("Spawn Limit Percent") = Self.mSpawnLimitPercent.DoubleValue
		    End If
		  End If
		  If Self.mProhibitTaming Then
		    Dict.Value("Prevent Taming") = True
		  End If
		  If Self.mProhibitTransfer Then
		    Dict.Value("Prohibit Transfer") = True
		  End If
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitSpawning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitTaming As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitTransfer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mReplacementCreature As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mResistanceMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSpawnLimitPercent As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSpawnWeightMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedResistanceMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTargetCreature As Ark.BlueprintReference
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
