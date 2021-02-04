#tag Class
Protected Class MutableCreatureBehavior
Inherits Beacon.CreatureBehavior
	#tag Method, Flags = &h0
		Sub DamageMultiplier(Assigns Value As Double)
		  If Self.mDamageMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mDamageMultiplier = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventTaming(Assigns Value As Boolean)
		  If Self.mPreventTaming = Value Then
		    Return
		  End If
		  
		  Self.mPreventTaming = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProhibitSpawning(Assigns Value As Boolean)
		  If Self.mProhibitSpawning = Value Then
		    Return
		  End If
		  
		  Self.mProhibitSpawning = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplacementCreature(Assigns Value As Beacon.Creature)
		  If Self.mReplacementCreature <> Value Then
		    Self.mReplacementCreature = New Beacon.BlueprintReference(Value)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResistanceMultiplier(Assigns Value As Double)
		  If Self.mResistanceMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mResistanceMultiplier = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedDamageMultiplier(Assigns Value As Double)
		  If Self.mTamedDamageMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mTamedDamageMultiplier = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedResistanceMultiplier(Assigns Value As Double)
		  If Self.mTamedResistanceMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mTamedResistanceMultiplier = Value
		  Self.mModified = True
		End Sub
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
