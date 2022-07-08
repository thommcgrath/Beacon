#tag Class
Protected Class MutableSpawnPointSet
Inherits Ark.SpawnPointSet
	#tag Method, Flags = &h0
		Sub Append(Entry As Ark.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx = -1 Then
		    Self.mEntries.Add(Entry.ImmutableVersion)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ColorSetClass(Assigns Value As String)
		  If Self.mColorSetClass <> Value Then
		    Self.mColorSetClass = Value
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
		Sub CopyFrom(Source As Ark.SpawnPointSet)
		  // Public
		  Super.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReplacementWeight(FromCreatureRef As Ark.BlueprintReference, ToCreatureRef As Ark.BlueprintReference, Assigns Weight As NullableDouble)
		  If FromCreatureRef Is Nil Or ToCreatureRef Is Nil Then
		    Return
		  End If
		  
		  Var CurrentWeight As NullableDouble = Self.CreatureReplacementWeight(FromCreatureRef, ToCreatureRef)
		  If CurrentWeight = Weight Then
		    Return
		  End If
		  
		  Var Options As Ark.BlueprintAttributeManager
		  If Self.mReplacements.HasBlueprint(FromCreatureRef) Then
		    Options = Self.mReplacements.Value(FromCreatureRef, Self.ReplacementsAttribute)
		  Else
		    If Weight = Nil Then
		      Return
		    End If
		    Options = New Ark.BlueprintAttributeManager
		  End If
		  
		  If Weight = Nil Then
		    Options.Remove(ToCreatureRef)
		  Else
		    Options.Value(ToCreatureRef, "Weight") = Weight.DoubleValue
		  End If
		  
		  If Options.Count = 0 And Self.mReplacements.HasBlueprint(FromCreatureRef) Then
		    Self.mReplacements.Remove(FromCreatureRef)
		  Else
		    Self.mReplacements.Value(FromCreatureRef, Self.ReplacementsAttribute) = Options
		  End If
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReplacementWeight(FromCreature As Ark.Creature, ToCreature As Ark.Creature, Assigns Weight As NullableDouble)
		  If FromCreature Is Nil Or ToCreature Is Nil Then
		    Return
		  End If
		  
		  Var CurrentWeight As NullableDouble = Self.CreatureReplacementWeight(FromCreature, ToCreature)
		  If CurrentWeight = Weight Then
		    Return
		  End If
		  
		  Var Options As Ark.BlueprintAttributeManager
		  If Self.mReplacements.HasBlueprint(FromCreature) Then
		    Options = Self.mReplacements.Value(FromCreature, Self.ReplacementsAttribute)
		  Else
		    If Weight = Nil Then
		      Return
		    End If
		    Options = New Ark.BlueprintAttributeManager
		  End If
		  
		  If Weight = Nil Then
		    Options.Remove(ToCreature)
		  Else
		    Options.Value(ToCreature, "Weight") = Weight.DoubleValue
		  End If
		  
		  If Options.Count = 0 And Self.mReplacements.HasBlueprint(FromCreature) Then
		    Self.mReplacements.Remove(FromCreature)
		  Else
		    Self.mReplacements.Value(FromCreature, Self.ReplacementsAttribute) = Options
		  End If
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReplacementWeight(FromCreatureID As String, ToCreatureID As String, Assigns Weight As NullableDouble)
		  Var FromCreature As Ark.Creature = Ark.DataSource.SharedInstance.GetCreatureByUUID(FromCreatureID)
		  Var ToCreature As Ark.Creature = Ark.DataSource.SharedInstance.GetCreatureByUUID(ToCreatureID)
		  Self.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entries(Assigns NewEntries() As Ark.SpawnPointSetEntry)
		  Self.mEntries.ResizeTo(NewEntries.LastIndex)
		  For I As Integer = 0 To NewEntries.LastIndex
		    Self.mEntries(I) = NewEntries(I).ImmutableVersion
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entry(AtIndex As Integer, Assigns NewEntry As Ark.SpawnPointSetEntry)
		  Self.mEntries(AtIndex) = NewEntry
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GroupOffset(Assigns Offset As Beacon.Point3D)
		  If Self.mGroupOffset <> Offset Then
		    If Offset Is Nil Then
		      Self.mGroupOffset = Nil
		    Else
		      Self.mGroupOffset = New Beacon.Point3D(Offset)
		    End If
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
		Function ImmutableVersion() As Ark.SpawnPointSet
		  Return New Ark.SpawnPointSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Value = Value.ReplaceLineEndings(" ").Trim
		  
		  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.mLabel = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelOffsetBeforeMultiplier(Assigns Value As Boolean)
		  If Self.mOffsetBeforeMultiplier <> Value Then
		    Self.mOffsetBeforeMultiplier = Value
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
		Function MutableVersion() As Ark.MutableSpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As Ark.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.mEntries.RemoveAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(AtIndex As Integer)
		  Self.mEntries.RemoveAt(AtIndex)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  If Self.mEntries.Count = 0 Then
		    Return
		  End If
		  
		  Self.mEntries.RemoveAll
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
