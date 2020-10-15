#tag Class
Protected Class SpawnPointSet
Implements Beacon.DocumentItem,Beacon.Countable
	#tag Method, Flags = &h0
		Function Clone() As Beacon.SpawnPointSet
		  Var Clone As New Beacon.SpawnPointSet(Self)
		  Clone.mID = New v4UUID
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mWeight = 0.5
		  Self.mModified = False
		  Self.mGroupOffset = Nil
		  Self.mID = New v4UUID
		  Self.mReplacements = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPointSet)
		  Self.Constructor()
		  Self.mID = Source.mID
		  Self.CopyFrom(Source)
		  Self.mModified = Source.mModified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Engrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CopyFrom(Source As Beacon.SpawnPointSet)
		  Self.mCachedHash = ""
		  Self.mModified = True
		  Self.mWeight = Source.mWeight
		  Self.mLabel = Source.mLabel
		  If Source.mGroupOffset <> Nil Then
		    Self.mGroupOffset = New Beacon.Point3D(Source.mGroupOffset)
		  Else
		    Self.mGroupOffset = Nil
		  End If
		  Self.mSpreadRadius = Source.mSpreadRadius
		  Self.mWaterOnlyMinimumHeight = Source.mWaterOnlyMinimumHeight
		  Self.mReplacements = Source.mReplacements.Clone
		  Self.mMinDistanceFromPlayersMultiplier = Source.mMinDistanceFromPlayersMultiplier
		  Self.mMinDistanceFromStructuresMultiplier = Source.mMinDistanceFromStructuresMultiplier
		  Self.mMinDistanceFromTamedDinosMultiplier = Source.mMinDistanceFromTamedDinosMultiplier
		  Self.mOffsetBeforeMultiplier = Source.mOffsetBeforeMultiplier
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastIndex)
		  For I As Integer = 0 To Source.mEntries.LastIndex
		    Self.mEntries(I) = Source.mEntries(I).ImmutableVersion
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mEntries.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureReplacementWeight(FromCreature As Beacon.Creature, ToCreature As Beacon.Creature) As NullableDouble
		  If FromCreature Is Nil Or ToCreature Is Nil Then
		    Return Nil
		  End If
		  
		  Var FromCreatureUUID As String = FromCreature.ObjectID
		  
		  If Not Self.mReplacements.HasKey(FromCreatureUUID) Then
		    Return Nil
		  End If
		  
		  Var ToCreatureUUID As String = ToCreature.ObjectID
		  
		  Var Options As Dictionary = Self.mReplacements.Value(FromCreatureUUID)
		  If Options.HasKey(ToCreatureUUID) Then
		    Return Options.Value(ToCreatureUUID).DoubleValue
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entries() As Beacon.SpawnPointSetEntry()
		  Var Arr() As Beacon.SpawnPointSetEntry
		  Arr.ResizeTo(Self.mEntries.LastIndex)
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    Arr(I) = Self.mEntries(I).ImmutableVersion
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(AtIndex As Integer) As Beacon.SpawnPointSetEntry
		  Return Self.mEntries(AtIndex).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.SpawnPointSet
		  If SaveData = Nil Then
		    Return Nil
		  End If
		  
		  Var Set As New Beacon.MutableSpawnPointSet
		  If SaveData.HasKey("label") Then
		    Set.Label = SaveData.Value("label")
		  ElseIf SaveData.HasKey("Label") Then
		    Set.Label = SaveData.Value("Label")
		  Else
		    Return Nil
		  End If
		  If SaveData.HasKey("weight") Then
		    Set.Weight = SaveData.Value("weight").DoubleValue
		  ElseIf SaveData.HasKey("Weight") Then
		    Set.Weight = SaveData.Value("Weight").DoubleValue
		  Else
		    Return Nil
		  End If
		  
		  If SaveData.HasKey("entries") Or SaveData.HasKey("Entries") Then
		    Var Entries() As Variant
		    If SaveData.HasKey("entries") Then
		      Entries = SaveData.Value("entries")
		    Else
		      Entries = SaveData.Value("Entries")
		    End If
		    For Each EntrySaveData As Dictionary In Entries
		      Var Entry As Beacon.SpawnPointSetEntry = Beacon.SpawnPointSetEntry.FromSaveData(EntrySaveData)
		      If Entry = Nil Then
		        Continue
		      End If
		      
		      Set.Append(Entry)
		    Next
		  ElseIf SaveData.HasKey("creatures") Then
		    Var Paths() As Variant = SaveData.Value("creatures")
		    For Each Path As String In Paths
		      Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		      If Creature = Nil Then
		        Continue
		      End If
		      
		      Set.Append(New Beacon.SpawnPointSetEntry(Creature))
		    Next
		  Else
		    Return Nil
		  End If
		  
		  If SaveData.HasKey("spread_radius") Then
		    Set.SpreadRadius = NullableDouble.FromVariant(SaveData.Value("spread_radius"))
		  ElseIf SaveData.HasKey("SpreadRadius") Then
		    Set.SpreadRadius = NullableDouble.FromVariant(SaveData.Value("SpreadRadius"))
		  End If
		  
		  Var SpawnOffset As Beacon.Point3D
		  If SaveData.HasKey("spawn_offset") And SaveData.Value("spawn_offset") <> Nil Then
		    SpawnOffset = Beacon.Point3D.FromSaveData(SaveData.Value("spawn_offset"))
		  ElseIf SaveData.HasKey("GroupOffset") And SaveData.Value("GroupOffset") <> Nil Then
		    SpawnOffset = Beacon.Point3D.FromSaveData(SaveData.Value("GroupOffset"))
		  End If
		  If (SpawnOffset Is Nil) = False Then
		    Set.GroupOffset = SpawnOffset
		  End If
		  
		  If SaveData.HasKey("water_only_minimum_height") Then
		    Set.WaterOnlyMinimumHeight = NullableDouble.FromVariant(SaveData.Value("water_only_minimum_height"))
		  ElseIf SaveData.HasKey("WaterOnlyMinimumHeight") Then
		    Set.WaterOnlyMinimumHeight = NullableDouble.FromVariant(SaveData.Value("WaterOnlyMinimumHeight"))
		  End If
		  
		  If SaveData.HasKey("min_distance_from_players_multiplier") Then
		    Set.MinDistanceFromPlayersMultiplier = NullableDouble.FromVariant(SaveData.Value("min_distance_from_players_multiplier"))
		  ElseIf SaveData.HasKey("MinDistanceFromPlayersMultiplier") Then
		    Set.MinDistanceFromPlayersMultiplier = NullableDouble.FromVariant(SaveData.Value("MinDistanceFromPlayersMultiplier"))
		  End If
		  
		  If SaveData.HasKey("min_distance_from_structures_multiplier") Then
		    Set.MinDistanceFromStructuresMultiplier = NullableDouble.FromVariant(SaveData.Value("min_distance_from_structures_multiplier"))
		  ElseIf SaveData.HasKey("MinDistanceFromStructuresMultiplier") Then
		    Set.MinDistanceFromStructuresMultiplier = NullableDouble.FromVariant(SaveData.Value("MinDistanceFromStructuresMultiplier"))
		  End If
		  
		  If SaveData.HasKey("min_distance_from_tamed_dinos_multiplier") Then
		    Set.MinDistanceFromTamedDinosMultiplier = NullableDouble.FromVariant(SaveData.Value("min_distance_from_tamed_dinos_multiplier"))
		  ElseIf SaveData.HasKey("MinDistanceFromTamedDinosMultiplier") Then
		    Set.MinDistanceFromTamedDinosMultiplier = NullableDouble.FromVariant(SaveData.Value("MinDistanceFromTamedDinosMultiplier"))
		  End If
		  
		  If SaveData.HasKey("offset_before_multiplier") Then
		    Set.LevelOffsetBeforeMultiplier = SaveData.Value("offset_before_multiplier").BooleanValue
		  ElseIf SaveData.HasKey("OffsetBeforeMultiplier") Then
		    Set.LevelOffsetBeforeMultiplier = SaveData.Value("OffsetBeforeMultiplier").BooleanValue
		  End If
		  
		  If SaveData.HasKey("replacements") Then
		    Var Replacements As Dictionary = SaveData.Value("replacements")
		    If (Replacements Is Nil) = False Then
		      For Each Entry As DictionaryEntry In Replacements
		        Var FromUUID As String = Entry.Key
		        Var FromCreature As Beacon.Creature = Beacon.ResolveCreature(FromUUID, "", "")
		        Var ToDict As Dictionary = Entry.Value
		        For Each SubEntry As DictionaryEntry In ToDict
		          Var ToUUID As String = SubEntry.Key
		          Var Weight As Double = SubEntry.Value
		          Var ToCreature As Beacon.Creature = Beacon.ResolveCreature(ToUUID, "", "")
		          Set.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		        Next
		      Next
		    End If
		  ElseIf SaveData.HasKey("Replacements") Then
		    Var Replacements As Dictionary = SaveData.Value("Replacements")
		    If (Replacements Is Nil) = False Then
		      For Each Entry As DictionaryEntry In Replacements
		        Var FromPath As String = Entry.Key
		        Var FromCreature As Beacon.Creature = Beacon.ResolveCreature("", FromPath, "")
		        Var ToDict As Dictionary = Entry.Value
		        For Each SubEntry As DictionaryEntry In ToDict
		          Var ToPath As String = SubEntry.Key
		          Var Weight As Double = SubEntry.Value
		          Var ToCreature As Beacon.Creature = Beacon.ResolveCreature("", ToPath, "")
		          Set.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		        Next
		      Next
		    End If
		  End If
		  
		  Set.Modified = False
		  Return New Beacon.SpawnPointSet(Set)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupOffset() As Beacon.Point3D
		  If Self.mGroupOffset <> Nil Then
		    Return New Beacon.Point3D(Self.mGroupOffset)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  If Self.mCachedHash = "" Then
		    Var Raw As String = Beacon.GenerateJSON(Self.SaveData, False)
		    Self.mCachedHash = EncodeHex(Crypto.MD5(Raw))
		  End If
		  Return Self.mCachedHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As v4UUID
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.SpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.SpawnPointSetEntry) As Integer
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    If Self.mEntries(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Document
		  
		  If Self.mEntries.LastIndex = -1 Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Entries() As Variant
		  Entries.ResizeTo(Self.mEntries.LastIndex)
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    Entries(I) = Self.mEntries(I).ImmutableVersion
		  Next
		  Return New Beacon.GenericIterator(Entries)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelOffsetBeforeMultiplier() As Boolean
		  Return Self.mOffsetBeforeMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinDistanceFromPlayersMultiplier() As NullableDouble
		  Return Self.mMinDistanceFromPlayersMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinDistanceFromStructuresMultiplier() As NullableDouble
		  Return Self.mMinDistanceFromStructuresMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinDistanceFromTamedDinosMultiplier() As NullableDouble
		  Return Self.mMinDistanceFromTamedDinosMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		    If Entry.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		      Entry.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableSpawnPointSet
		  Var Clone As New Beacon.MutableSpawnPointSet(Self)
		  Clone.ID = New v4UUID
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableSpawnPointSet
		  Return New Beacon.MutableSpawnPointSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.SpawnPointSet) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mID = Other.mID Then
		    Return 0
		  End If
		  
		  Var CompareLeft As String = Self.mLabel + Self.mID
		  Var CompareRight As String = Other.mLabel + Other.mID
		  Return CompareLeft.Compare(CompareRight, ComparisonOptions.CaseInsensitive, Locale.Current)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacedCreatures() As Beacon.Creature()
		  Var Arr() As Beacon.Creature
		  For Each Entry As DictionaryEntry In Self.mReplacements
		    Var CreatureUUID As String = Entry.Key
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByID(CreatureUUID)
		    If (Creature Is Nil) = False Then
		      Arr.Add(Creature)
		    End If
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreatures(FromCreature As Beacon.Creature) As Beacon.Creature()
		  Var Arr() As Beacon.Creature
		  If FromCreature Is Nil Then
		    Return Arr
		  End If
		  
		  Var CreatureUUID As String = FromCreature.ObjectID
		  If Self.mReplacements.HasKey(CreatureUUID) = False Then
		    Return Arr
		  End If
		  
		  Var Options As Dictionary = Self.mReplacements.Value(CreatureUUID)
		  For Each Entry As DictionaryEntry In Options
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByID(Entry.Key.StringValue)
		    If (Creature Is Nil) = False Then
		      Arr.Add(Creature)
		    End If
		  Next
		  
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacesCreatures() As Boolean
		  Return Self.mReplacements.KeyCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Entries() As Variant
		  For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		    Entries.Add(Entry.SaveData)
		  Next
		  
		  Var SaveData As New Dictionary
		  SaveData.Value("type") = "SpawnPointSet"
		  SaveData.Value("label") = Self.Label
		  SaveData.Value("weight") = Self.Weight
		  SaveData.Value("entries") = Entries
		  SaveData.Value("offset_before_multiplier") = Self.mOffsetBeforeMultiplier
		  If Self.mGroupOffset <> Nil Then
		    SaveData.Value("spawn_offset") = Self.mGroupOffset.SaveData
		  End If
		  If Self.mSpreadRadius <> Nil Then
		    SaveData.Value("spread_radius") = Self.mSpreadRadius.DoubleValue
		  End If
		  If Self.mWaterOnlyMinimumHeight <> Nil Then
		    SaveData.Value("water_only_minimum_height") = Self.mWaterOnlyMinimumHeight.DoubleValue
		  End If
		  If Self.mMinDistanceFromPlayersMultiplier <> Nil Then
		    SaveData.Value("min_distance_from_players_multiplier") = Self.mMinDistanceFromPlayersMultiplier.DoubleValue
		  End If
		  If Self.mMinDistanceFromStructuresMultiplier <> Nil Then
		    SaveData.Value("min_distance_from_structures_multiplier") = Self.mMinDistanceFromStructuresMultiplier.DoubleValue
		  End If
		  If Self.mMinDistanceFromTamedDinosMultiplier <> Nil Then
		    SaveData.Value("min_distance_from_tamed_dinos_multiplier") = Self.mMinDistanceFromTamedDinosMultiplier.DoubleValue
		  End If
		  If Self.mReplacements.KeyCount > 0 Then
		    SaveData.Value("replacements") = Self.mReplacements
		  End If
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpreadRadius() As NullableDouble
		  Return Self.mSpreadRadius
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WaterOnlyMinimumHeight() As NullableDouble
		  Return Self.mWaterOnlyMinimumHeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mCachedHash As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEntries() As Beacon.SpawnPointSetEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGroupOffset As Beacon.Point3D
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String = "New Spawn Set"
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinDistanceFromPlayersMultiplier As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinDistanceFromStructuresMultiplier As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinDistanceFromTamedDinosMultiplier As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mOffsetBeforeMultiplier As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mReplacements As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSpreadRadius As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWaterOnlyMinimumHeight As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWeight As Double
	#tag EndProperty


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
