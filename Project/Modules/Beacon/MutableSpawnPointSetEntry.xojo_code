#tag Class
Protected Class MutableSpawnPointSetEntry
Inherits Beacon.SpawnPointSetEntry
	#tag Method, Flags = &h0
		Sub Append(Level As Beacon.SpawnPointLevel)
		  Var Idx As Integer = Self.IndexOf(Level)
		  If Idx = -1 Then
		    Self.mLevels.AddRow(New Beacon.SpawnPointLevel(Level))
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Creature(Assigns Value As Beacon.Creature)
		  If Self.mCreature <> Value Then
		    Self.mCreature = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.SpawnPointSetEntry
		  Return New Beacon.SpawnPointSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Level(AtIndex As Integer, Assigns Value As Beacon.SpawnPointLevel)
		  If Value = Nil Then
		    Return
		  End If
		  
		  Self.mLevels(AtIndex) = New Beacon.SpawnPointLevel(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelBound(Assigns Value As Integer)
		  If Self.mLevels.LastRowIndex <> Value Then
		    Self.mLevels.ResizeTo(Value)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelCount(Assigns Value As Integer)
		  If Self.mLevels.Count <> Value Then
		    Self.mLevels.ResizeTo(Value - 1)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Levels(Assigns NewLevels() As Beacon.SpawnPointLevel)
		  Self.mLevels.ResizeTo(NewLevels.LastRowIndex)
		  For I As Integer = 0 To NewLevels.LastRowIndex
		    Self.mLevels(I) = New Beacon.SpawnPointLevel(NewLevels(I))
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableSpawnPointSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Offset(Assigns Value As Beacon.Point3D)
		  If Value = Nil Then
		    If Self.mOffset <> Nil Then
		      Self.mOffset = Nil
		      Self.Modified = True
		    End If
		  Else
		    If Self.mOffset <> Value Then
		      Self.mOffset = New Beacon.Point3D(Value)
		      Self.Modified = True
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OverridesSpawnChance(Assigns Value As Boolean)
		  If Self.mOverridesSpawnChance <> Value Then
		    Self.mOverridesSpawnChance = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Level As Beacon.SpawnPointLevel)
		  Var Idx As Integer = Self.IndexOf(Level)
		  If Idx > -1 Then
		    Self.mLevels.RemoveRowAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  Self.mLevels.RemoveRowAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnChance(Assigns Value As Double)
		  If Self.mChance <> Value Then
		    Self.mChance = Value
		    Self.mOverridesSpawnChance = True
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
