#tag Class
Protected Class CreatureBehavior
	#tag Method, Flags = &h0
		Function Clone(NewTarget As Beacon.Creature) As Beacon.CreatureBehavior
		  Var Result As New Beacon.CreatureBehavior(Self)
		  Result.mTargetCreature = NewTarget
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Creature As Beacon.Creature)
		  Self.mTargetCreature = Creature
		  Self.mDamageMultiplier = 1.0
		  Self.mResistanceMultiplier = 1.0
		  Self.mTamedDamageMultiplier = 1.0
		  Self.mTamedResistanceMultiplier = 1.0
		  Self.mProhibitSpawning = False
		  Self.mReplacementCreature = Nil
		  Self.mPreventTaming = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.CreatureBehavior)
		  Self.mTargetCreature = Source.mTargetCreature
		  Self.mReplacementCreature = Source.mReplacementCreature
		  Self.mProhibitSpawning = Source.mProhibitSpawning
		  Self.mModified = Source.mModified
		  Self.mDamageMultiplier = Source.mDamageMultiplier
		  Self.mResistanceMultiplier = Source.mResistanceMultiplier
		  Self.mTamedDamageMultiplier = Source.mTamedDamageMultiplier
		  Self.mTamedResistanceMultiplier = Source.mTamedResistanceMultiplier
		  Self.mPreventTaming = Source.mPreventTaming
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As String)
		  Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByClass(ClassString)
		  If IsNull(Creature) Then
		    Creature = Beacon.Creature.CreateFromClass(ClassString)
		  End If
		  Self.Constructor(Creature)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DamageMultiplier() As Double
		  Return Self.mDamageMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.CreatureBehavior
		  Var Creature As Beacon.Creature
		  If Dict.HasKey("Path") Then
		    Creature = Beacon.Data.GetCreatureByPath(Dict.Value("Path").StringValue)
		    If IsNull(Creature) Then
		      Creature = Beacon.Creature.CreateFromPath(Dict.Value("Path").StringValue)
		    End If
		  ElseIf Dict.HasKey("Class") Then
		    Creature = Beacon.Data.GetCreatureByClass(Dict.Value("Class").StringValue)
		    If IsNull(Creature) Then
		      Creature = Beacon.Creature.CreateFromClass(Dict.Value("Class").StringValue)
		    End If
		  Else
		    Return Nil
		  End If
		  
		  Var Behavior As New Beacon.CreatureBehavior(Creature)
		  If Dict.HasKey("Prohibit Spawning") Then
		    Behavior.mProhibitSpawning = Dict.Value("Prohibit Spawning")
		  ElseIf Dict.HasKey("Replacement Path") Then
		    Var Replacement As Beacon.Creature = Beacon.Data.GetCreatureByPath(Dict.Value("Replacement Path").StringValue)
		    If IsNull(Replacement) Then
		      Replacement = Beacon.Creature.CreateFromPath(Dict.Value("Replacement Path").StringValue)
		    End If
		    Behavior.mReplacementCreature = Replacement
		  ElseIf Dict.HasKey("Replacement Class") Then
		    Var Replacement As Beacon.Creature = Beacon.Data.GetCreatureByClass(Dict.Value("Replacement Class").StringValue)
		    If IsNull(Replacement) Then
		      Replacement = Beacon.Creature.CreateFromClass(Dict.Value("Replacement Class").StringValue)
		    End If
		    Behavior.mReplacementCreature = Replacement
		  Else
		    Behavior.mDamageMultiplier = Dict.Lookup("Damage Multiplier", 1.0)
		    Behavior.mResistanceMultiplier = Dict.Lookup("Resistance Multiplier", 1.0)
		    Behavior.mTamedDamageMultiplier = Dict.Lookup("Tamed Damage Multiplier", 1.0)
		    Behavior.mTamedResistanceMultiplier = Dict.Lookup("Tamed Resistance Multiplier", 1.0)
		    Behavior.mPreventTaming = Dict.Lookup("PreventTaming", False)
		  End If
		  
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
		Function PreventTaming() As Boolean
		  Return Self.mPreventTaming
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitSpawning() As Boolean
		  Return Self.mProhibitSpawning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementClass() As String
		  Return Self.mReplacementCreature.ClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreature() As Beacon.Creature
		  Return Self.mReplacementCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResistanceMultiplier() As Double
		  Return Self.mResistanceMultiplier
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
		Function TargetClass() As String
		  Return Self.mTargetCreature.ClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TargetCreature() As Beacon.Creature
		  Return Self.mTargetCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Class") = Self.mTargetCreature.ClassString
		  Dict.Value("Path") = Self.mTargetCreature.Path
		  If Self.mProhibitSpawning Then
		    Dict.Value("Prohibit Spawning") = True
		  ElseIf IsNull(Self.mReplacementCreature) = False Then
		    Dict.Value("Replacement Class") = Self.mReplacementCreature.ClassString
		    Dict.Value("Replacement Path") = Self.mReplacementCreature.Path
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
		    If Self.mPreventTaming Then
		      Dict.Value("Prevent Taming") = True
		    End If
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
		Protected mPreventTaming As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitSpawning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mReplacementCreature As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mResistanceMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedResistanceMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTargetCreature As Beacon.Creature
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
