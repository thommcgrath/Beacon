#tag Class
Protected Class MutableSpawnPointSet
Inherits Beacon.SpawnPointSet
	#tag Method, Flags = &h0
		Sub AddCreature(Creature As Beacon.Creature)
		  Var Idx As Integer = Self.IndexOf(Creature)
		  If Idx = -1 Then
		    Self.mCreatures.AddRow(New Beacon.Creature(Creature))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Just making it public
		  Super.Constructor()
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
		  Var Idx As Integer = Self.IndexOf(Creature)
		  If Idx > -1 Then
		    Self.mCreatures.RemoveRowAt(Idx)
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
