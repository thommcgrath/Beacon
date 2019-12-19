#tag Class
Protected Class MutableSpawnPointSet
Inherits Beacon.SpawnPointSet
	#tag Method, Flags = &h0
		Sub Append(Entry As Beacon.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx = -1 Then
		    Self.mEntries.AddRow(Entry.ImmutableVersion)
		    Self.Modified = True
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
		Sub CreatureReplacementWeight(FromCreature As Beacon.Creature, ToCreature As Beacon.Creature, Assigns Weight As NullableDouble)
		  Var CurrentWeight As NullableDouble = Self.CreatureReplacementWeight(FromCreature, ToCreature)
		  If CurrentWeight = Weight Then
		    Return
		  End If
		  
		  Var Options As Dictionary
		  If Self.mReplacements.HasKey(FromCreature.Path) Then
		    Options = Self.mReplacements.Value(FromCreature.Path)
		  Else
		    If Weight = Nil Then
		      Return
		    End If
		    Options = New Dictionary
		  End If
		  
		  If Weight = Nil Then
		    If Options.HasKey(ToCreature.Path) Then
		      Options.Remove(ToCreature.Path)
		    End If
		  Else
		    Options.Value(ToCreature.Path) = Weight.Value
		  End If
		  
		  If Options.KeyCount = 0 And Self.mReplacements.HasKey(FromCreature.Path) Then
		    Self.mReplacements.Remove(FromCreature.Path)
		  Else
		    Self.mReplacements.Value(FromCreature.Path) = Options
		  End If
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entries(Assigns NewEntries() As Beacon.SpawnPointSetEntry)
		  Self.mEntries.ResizeTo(NewEntries.LastRowIndex)
		  For I As Integer = 0 To NewEntries.LastRowIndex
		    Self.mEntries(I) = NewEntries(I).ImmutableVersion
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GroupOffset(Assigns Offset As Beacon.Point3D)
		  If Self.mGroupOffset <> Offset Then
		    Self.mGroupOffset = New Beacon.Point3D(Offset)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ID(Assigns Value As v4UUID)
		  If Not IsNull(Value) Then
		    Self.mID = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.SpawnPointSet
		  Return New Beacon.SpawnPointSet(Self)
		End Function
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
		Sub MinDistanceFromPlayersMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromPlayersMultiplier <> Value Then
		    Self.mMinDistanceFromPlayersMultiplier = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromStructuresMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromStructuresMultiplier <> Value Then
		    Self.mMinDistanceFromStructuresMultiplier = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromTamedDinosMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromTamedDinosMultiplier <> Value Then
		    Self.mMinDistanceFromTamedDinosMultiplier = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = True Then
		    Self.mCachedHash = ""
		  End If
		  Super.Modified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableSpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As Beacon.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.mEntries.RemoveRowAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(AtIndex As Integer)
		  Self.mEntries.RemoveRowAt(AtIndex)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpreadRadius(Assigns Value As NullableDouble)
		  If Self.mSpreadRadius <> Value Then
		    Self.mSpreadRadius = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WaterOnlyMinimumHeight(Assigns Value As NullableDouble)
		  If Self.mWaterOnlyMinimumHeight <> Value Then
		    Self.mWaterOnlyMinimumHeight = Value
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
