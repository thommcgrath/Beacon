#tag Class
Protected Class MutableSpawnPointSet
Inherits ArkSA.SpawnPointSet
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Append(Entry As ArkSA.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx = -1 Then
		    Self.mEntries.Add(Entry.ImmutableVersion)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ColorSetClass(Assigns Value As String)
		  If Self.mColorSetClass = Value Then
		    Return
		  End If
		  
		  Self.mColorSetClass = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Just making it public
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Source As ArkSA.SpawnPointSet)
		  // Public
		  Super.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReplacementWeight(FromCreatureRef As ArkSA.BlueprintReference, ToCreatureRef As ArkSA.BlueprintReference, Assigns Weight As NullableDouble)
		  If FromCreatureRef Is Nil Or ToCreatureRef Is Nil Then
		    Return
		  End If
		  
		  Var CurrentWeight As NullableDouble = Self.CreatureReplacementWeight(FromCreatureRef, ToCreatureRef)
		  If CurrentWeight = Weight Then
		    Return
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager
		  If Self.mReplacements.HasBlueprint(FromCreatureRef) Then
		    Options = Self.mReplacements.Value(FromCreatureRef, Self.ReplacementsAttribute)
		  Else
		    If Weight = Nil Then
		      Return
		    End If
		    Options = New ArkSA.BlueprintAttributeManager
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
		Sub CreatureReplacementWeight(FromCreature As ArkSA.Creature, ToCreature As ArkSA.Creature, Assigns Weight As NullableDouble)
		  If FromCreature Is Nil Or ToCreature Is Nil Then
		    Return
		  End If
		  
		  Var CurrentWeight As NullableDouble = Self.CreatureReplacementWeight(FromCreature, ToCreature)
		  If CurrentWeight = Weight Then
		    Return
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager
		  If Self.mReplacements.HasBlueprint(FromCreature) Then
		    Options = Self.mReplacements.Value(FromCreature, Self.ReplacementsAttribute)
		  Else
		    If Weight = Nil Then
		      Return
		    End If
		    Options = New ArkSA.BlueprintAttributeManager
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
		Sub CreatureReplacementWeight(FromCreatureId As String, ToCreatureId As String, Assigns Weight As NullableDouble)
		  Var FromCreature As ArkSA.Creature = ArkSA.DataSource.Pool.Get(False).GetCreature(FromCreatureID)
		  Var ToCreature As ArkSA.Creature = ArkSA.DataSource.Pool.Get(False).GetCreature(ToCreatureID)
		  Self.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entries(Assigns NewEntries() As ArkSA.SpawnPointSetEntry)
		  Self.mEntries.ResizeTo(NewEntries.LastIndex)
		  For I As Integer = 0 To NewEntries.LastIndex
		    Self.mEntries(I) = NewEntries(I).ImmutableVersion
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entry(AtIndex As Integer, Assigns NewEntry As ArkSA.SpawnPointSetEntry)
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
		Function ImmutableVersion() As ArkSA.SpawnPointSet
		  Return New ArkSA.SpawnPointSet(Self)
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
		  If Self.mOffsetBeforeMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mOffsetBeforeMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromPlayersMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromPlayersMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mMinDistanceFromPlayersMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromStructuresMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromStructuresMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mMinDistanceFromStructuresMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromTamedDinosMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromTamedDinosMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mMinDistanceFromTamedDinosMultiplier = Value
		  Self.Modified = True
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
		Function MutableVersion() As ArkSA.MutableSpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  // Part of the ArkSA.Prunable interface.
		  
		  For Idx As Integer = Self.mEntries.LastIndex DownTo 0
		    Var Entry As ArkSA.SpawnPointSetEntry = Self.mEntries(Idx)
		    Var Reference As ArkSA.BlueprintReference = Entry.CreatureReference
		    Var Creature As ArkSA.Blueprint = Reference.Resolve(ContentPackIds, 0)
		    If Creature Is Nil Then
		      Self.mEntries.RemoveAt(Idx)
		      Self.Modified = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  Value = Max(Abs(Value), 0.00001)
		  If Self.mWeight = Value Then
		    Return
		  End If
		  
		  Self.mWeight = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As ArkSA.SpawnPointSetEntry)
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
		Sub RemoveReplacedCreature(CreatureRef As ArkSA.BlueprintReference)
		  If CreatureRef Is Nil Then
		    Return
		  End If
		  
		  If Self.mReplacements.HasBlueprint(CreatureRef) = False Then
		    Return
		  End If
		  
		  Self.mReplacements.Remove(CreatureRef)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveReplacedCreature(Creature As ArkSA.Creature)
		  If Creature Is Nil Then
		    Return
		  End If
		  
		  If Self.mReplacements.HasBlueprint(Creature) = False Then
		    Return
		  End If
		  
		  Self.mReplacements.Remove(Creature)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveReplacedCreature(CreatureId As String)
		  If Self.mReplacements.HasBlueprint(CreatureId) = False Then
		    Return
		  End If
		  
		  Self.mReplacements.Remove(CreatureId)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetId(Assigns Value As String)
		  // Calling the overridden superclass method.
		  If Self.mSetId = Value Then
		    Return
		  End If
		  
		  Self.mSetId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpreadRadius(Assigns Value As NullableDouble)
		  If Self.mSpreadRadius = Value Then
		    Return
		  End If
		  
		  Self.mSpreadRadius = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WaterOnlyMinimumHeight(Assigns Value As NullableDouble)
		  If Self.mWaterOnlyMinimumHeight = Value Then
		    Return
		  End If
		  
		  Self.mWaterOnlyMinimumHeight = Value
		  Self.Modified = True
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
