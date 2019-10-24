#tag Class
Protected Class MutableSpawnPointSet
Inherits Beacon.SpawnPointSet
	#tag Method, Flags = &h0
		Sub AddCreature(Creature As Beacon.Creature, Limit As Double = 1.0)
		  Self.CreatureLimit(Creature) = Limit
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Just making it public
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureLimit(Creature As Beacon.Creature, Assigns Limit As Double)
		  Limit = Min(Max(Limit, 0.0), 1.0)
		  
		  If Self.mEntities.HasKey(Creature.Path) = False Or Self.mEntities.Value(Creature.Path) <> Limit Then
		    Self.mEntities.Value(Creature.Path) = Limit
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.mLabel = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveCreature(Creature As Beacon.Creature)
		  If Self.mEntities.HasKey(Creature.Path) Then
		    Self.mEntities.Remove(Creature.Path)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Weight(Assigns Value As Double)
		  Value = Abs(Value)
		  If Self.mWeight <> Value Then
		    Self.mWeight = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
