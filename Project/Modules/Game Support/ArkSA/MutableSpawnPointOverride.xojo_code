#tag Class
Protected Class MutableSpawnPointOverride
Inherits ArkSA.SpawnPointOverride
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Add(Set As ArkSA.SpawnPointSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx > -1 And Self.mSets(Idx).Hash = Set.Hash Then
		    Return
		  End If
		  
		  Self.mSets(Idx) = Set.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPointOverride
		  Return New ArkSA.SpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(CreatureRef As ArkSA.BlueprintReference, Assigns Value As Double)
		  Var HasBlueprint As Boolean = Self.mLimits.HasAttribute(CreatureRef, Self.LimitAttribute)
		  
		  If Value = 1.0 Then
		    If HasBlueprint Then
		      Self.mLimits.Remove(CreatureRef, Self.LimitAttribute)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If HasBlueprint And Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = Value Then
		    Return
		  End If
		  
		  Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(Creature As ArkSA.Creature, Assigns Value As Double)
		  Var HasBlueprint As Boolean = Self.mLimits.HasAttribute(Creature, Self.LimitAttribute)
		  
		  If Value = 1.0 Then
		    If HasBlueprint Then
		      Self.mLimits.Remove(Creature, Self.LimitAttribute)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If HasBlueprint And Self.mLimits.Value(Creature, Self.LimitAttribute) = Value Then
		    Return
		  End If
		  
		  Self.mLimits.Value(Creature, Self.LimitAttribute) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mode(Assigns Value As Integer)
		  If Self.mMode = Value Then
		    Return
		  End If
		  
		  Self.mMode = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableSpawnPointOverride
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Set As ArkSA.SpawnPointSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAt(Idx As Integer) As ArkSA.SpawnPointSet
		  If Idx = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mSets(Idx).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnPointReference(Assigns Ref As ArkSA.BlueprintReference)
		  If Self.mPointRef = Ref Then
		    Return
		  End If
		  
		  Self.mPointRef = Ref
		  Self.Modified = True
		End Sub
	#tag EndMethod


End Class
#tag EndClass
