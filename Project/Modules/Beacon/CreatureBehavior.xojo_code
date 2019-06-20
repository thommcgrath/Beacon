#tag Class
Protected Class CreatureBehavior
	#tag Method, Flags = &h0
		Function Clone(NewTarget As Text) As Beacon.CreatureBehavior
		  Dim Result As New Beacon.CreatureBehavior(Self)
		  Result.mTargetClass = NewTarget
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Creature As Beacon.Creature)
		  Self.Constructor(Creature.ClassString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.CreatureBehavior)
		  Self.mTargetClass = Source.mTargetClass
		  Self.mReplacementClass = Source.mReplacementClass
		  Self.mProhibitSpawning = Source.mProhibitSpawning
		  Self.mModified = Source.mModified
		  Self.mDamageMultiplier = Source.mDamageMultiplier
		  Self.mResistanceMultiplier = Source.mResistanceMultiplier
		  Self.mTamedDamageMultiplier = Source.mTamedDamageMultiplier
		  Self.mTamedResistanceMultiplier = Source.mTamedResistanceMultiplier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As Text)
		  Self.mTargetClass = ClassString
		  Self.mDamageMultiplier = 1.0
		  Self.mResistanceMultiplier = 1.0
		  Self.mTamedDamageMultiplier = 1.0
		  Self.mTamedResistanceMultiplier = 1.0
		  Self.mProhibitSpawning = False
		  Self.mReplacementClass = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DamageMultiplier() As Double
		  Return Self.mDamageMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary) As Beacon.CreatureBehavior
		  If Not Dict.HasKey("Class") Then
		    Return Nil
		  End If
		  
		  Dim ClassString As Text = Dict.Value("Class")
		  Dim Behavior As New Beacon.CreatureBehavior(ClassString)
		  If Dict.HasKey("Prohibit Spawning") Then
		    Behavior.mProhibitSpawning = Dict.Value("Prohibit Spawning")
		  ElseIf Dict.HasKey("Replacement Class") Then
		    Behavior.mReplacementClass = Dict.Value("Replacement Class")
		  Else
		    Behavior.mDamageMultiplier = Dict.Lookup("Damage Multiplier", 1.0)
		    Behavior.mResistanceMultiplier = Dict.Lookup("Resistance Multiplier", 1.0)
		    Behavior.mTamedDamageMultiplier = Dict.Lookup("Tamed Damage Multiplier", 1.0)
		    Behavior.mTamedResistanceMultiplier = Dict.Lookup("Tamed Resistance Multiplier", 1.0)
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
		Function ProhibitSpawning() As Boolean
		  Return Self.mProhibitSpawning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementClass() As Text
		  Return Self.mReplacementClass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreature() As Beacon.Creature
		  If Self.mReplacementClass = "" Then
		    Return Nil
		  End If
		  
		  Dim Creatures() As Beacon.Creature = Beacon.Data.SearchForCreatures(Self.mReplacementClass, New Beacon.TextList)
		  If Creatures = Nil Or Creatures.Ubound <> 0 Then
		    Return Nil
		  End If
		  
		  Return Creatures(0)
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
		Function TargetClass() As Text
		  Return Self.mTargetClass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Class") = Self.mTargetClass
		  If Self.mProhibitSpawning Then
		    Dict.Value("Prohibit Spawning") = True
		  ElseIf Self.mReplacementClass <> "" Then
		    Dict.Value("Replacement Class") = Self.mReplacementClass
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
		Protected mReplacementClass As Text
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
		Protected mTargetClass As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mTargetClass"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
