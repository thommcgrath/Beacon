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
		Sub ProhibitSpawning(Assigns Value As Boolean)
		  If Self.mProhibitSpawning = Value Then
		    Return
		  End If
		  
		  Self.mProhibitSpawning = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplacementClass(Assigns Value As Text)
		  If Self.mReplacementClass = "" Then
		    Return
		  End If
		  
		  Self.mReplacementClass = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplacementCreature(Assigns Value As Beacon.Creature)
		  If Value = Nil Then
		    Self.ReplacementClass = ""
		  Else
		    Self.ReplacementClass = Value.ClassString
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


End Class
#tag EndClass
