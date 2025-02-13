#tag Class
Protected Class SpawnPointSet
Implements Beacon.Countable,ArkSA.Weighted,Beacon.Validateable
	#tag Method, Flags = &h0
		Function Clone() As ArkSA.SpawnPointSet
		  Var Clone As New ArkSA.SpawnPointSet(Self)
		  Clone.mSetId = Beacon.UUID.v4
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ColorSetClass() As String
		  Return Self.mColorSetClass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mWeight = 0.5
		  Self.mModified = False
		  Self.mGroupOffset = Nil
		  Self.mSetId = Beacon.UUID.v4
		  Self.mReplacements = New ArkSA.BlueprintAttributeManager
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.SpawnPointSet)
		  Self.Constructor()
		  Self.mSetId = Source.mSetId
		  Self.CopyFrom(Source)
		  Self.mModified = Source.mModified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(Creature As ArkSA.Creature) As Boolean
		  If Creature Is Nil Then
		    Return False
		  End If
		  
		  For Each Entry As ArkSA.SpawnPointSetEntry In Self.mEntries
		    If Entry.CreatureId = Creature.BlueprintId Then
		      Return True
		    End If
		  Next
		  
		  If Self.mReplacements.HasBlueprint(Creature.BlueprintId) Then
		    Return True
		  End If
		  
		  Var BlueprintIds() As String = Self.mReplacements.BlueprintIds
		  For Each BlueprintId As String In BlueprintIds
		    Var Options As ArkSA.BlueprintAttributeManager = Self.mReplacements.Value(BlueprintId, Self.ReplacementsAttribute)
		    If Options.HasBlueprint(Creature.BlueprintId) Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CopyFrom(Source As ArkSA.SpawnPointSet)
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
		  Self.mColorSetClass = Source.mColorSetClass
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastIndex)
		  For I As Integer = 0 To Source.mEntries.LastIndex
		    Self.mEntries(I) = Source.mEntries(I).ImmutableVersion
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mEntries.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureReplacementWeight(FromCreatureRef As ArkSA.BlueprintReference, ToCreatureRef As ArkSA.BlueprintReference) As NullableDouble
		  If FromCreatureRef Is Nil Or ToCreatureRef Is Nil Then
		    Return Nil
		  End If
		  
		  If Not Self.mReplacements.HasBlueprint(FromCreatureRef) Then
		    Return Nil
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager = Self.mReplacements.Value(FromCreatureRef, Self.ReplacementsAttribute)
		  If Options.HasAttribute(ToCreatureRef, "Weight") Then
		    Return Options.Value(ToCreatureRef, "Weight").DoubleValue
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureReplacementWeight(FromCreature As ArkSA.Creature, ToCreature As ArkSA.Creature) As NullableDouble
		  If FromCreature Is Nil Or ToCreature Is Nil Then
		    Return Nil
		  End If
		  
		  If Not Self.mReplacements.HasBlueprint(FromCreature) Then
		    Return Nil
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager = Self.mReplacements.Value(FromCreature, Self.ReplacementsAttribute)
		  If Options.HasAttribute(ToCreature, "Weight") Then
		    Return Options.Value(ToCreature, "Weight").DoubleValue
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureReplacementWeight(FromCreatureId As String, ToCreatureId As String) As NullableDouble
		  If Not Self.mReplacements.HasBlueprint(FromCreatureId) Then
		    Return Nil
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager = Self.mReplacements.Value(FromCreatureId, Self.ReplacementsAttribute)
		  If Options.HasAttribute(ToCreatureId, "Weight") Then
		    Return Options.Value(ToCreatureId, "Weight").DoubleValue
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entries() As ArkSA.SpawnPointSetEntry()
		  Var Arr() As ArkSA.SpawnPointSetEntry
		  Arr.ResizeTo(Self.mEntries.LastIndex)
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    Arr(I) = Self.mEntries(I).ImmutableVersion
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(AtIndex As Integer) As ArkSA.SpawnPointSetEntry
		  Return Self.mEntries(AtIndex).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindCreature(CreatureId As String) As ArkSA.BlueprintReference
		  If (Self.mReplacements Is Nil) = False Then
		    If Self.mReplacements.HasBlueprint(CreatureId) Then
		      Return Self.mReplacements.Reference(CreatureId)
		    End If
		    
		    Var ReplacedCreatures() As ArkSA.BlueprintReference = Self.ReplacedCreatureRefs
		    For Each FromCreatureRef As ArkSA.BlueprintReference In ReplacedCreatures
		      Var ReplacementCreatures() As ArkSA.BlueprintReference = Self.ReplacementCreatures(FromCreatureRef)
		      For Each ToCreatureRef As ArkSA.BlueprintReference In ReplacementCreatures
		        If ToCreatureRef.BlueprintId = CreatureId Then
		          Return ToCreatureRef
		        End If
		      Next
		    Next
		  End If
		  
		  For Each Entry As ArkSA.SpawnPointSetEntry In Self.mEntries
		    Var Reference As ArkSA.BlueprintReference = Entry.CreatureReference
		    If (Reference Is Nil) = False And Reference.BlueprintId = CreatureId Then
		      Return Reference
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As JSONItem) As ArkSA.SpawnPointSet
		  If SaveData Is Nil Then
		    Return Nil
		  End If
		  
		  Var Set As New ArkSA.MutableSpawnPointSet
		  
		  Var SetIdKey As Variant = SaveData.FirstKey("spawnPointSetId", "spawn_point_set_id", "ID")
		  If SetIdKey.IsNull = False Then
		    Set.SetId = SaveData.Value(SetIdKey.StringValue)
		  End If
		  
		  Var LabelKey As Variant = SaveData.FirstKey("label", "Label")
		  If LabelKey.IsNull = False Then
		    Set.Label = SaveData.Value(LabelKey.StringValue)
		  Else
		    Return Nil
		  End If
		  
		  Var WeightKey As Variant = SaveData.FirstKey("weight", "Weight")
		  If WeightKey.IsNull = False Then
		    Set.RawWeight = SaveData.Value(WeightKey.StringValue)
		  Else
		    Return Nil
		  End If
		  
		  Var EntriesKey As Variant = SaveData.FirstKey("entries", "Entries", "creatures")
		  If EntriesKey.IsNull Or SaveData.Value(EntriesKey.StringValue).IsNull Then
		    Return Nil
		  End If
		  Var Entries As JSONItem = SaveData.Child(EntriesKey.StringValue)
		  For Each Entry As JSONEntry In Entries.Iterator
		    If Entry.Value.Type = Variant.TypeObject And Entry.Value.ObjectValue IsA JSONItem Then
		      Var SpawnEntry As ArkSA.SpawnPointSetEntry = ArkSA.SpawnPointSetEntry.FromSaveData(JSONItem(Entry.Value))
		      If (SpawnEntry Is Nil) = False Then
		        Set.Append(SpawnEntry)
		      End If
		    ElseIf Entry.Value.Type = Variant.TypeString Then
		      Var CreaturePath As String = Entry.Value.StringValue
		      Var Creature As ArkSA.Creature = ArkSA.ResolveCreature("", CreaturePath, "", Nil, True)
		      If (Creature Is Nil) = False Then
		        Set.Append(New ArkSA.SpawnPointSetEntry(Creature))
		      End If
		    End If
		  Next
		  
		  Var SpreadKey As Variant = SaveData.FirstKey("spreadRadius", "Spread Radius", "spread_radius", "SpreadRadius")
		  If SpreadKey.IsNull = False Then
		    Set.SpreadRadius = NullableDouble.FromVariant(SaveData.Value(SpreadKey.StringValue))
		  End If
		  
		  Var SpawnOffsetKey As Variant = SaveData.FirstKey("spawnOffset", "Spawn Offset", "spawn_offset", "GroupOffset")
		  If SpawnOffsetKey.IsNull = False Then
		    Var SpawnOffset As Beacon.Point3D = Beacon.Point3D.FromSaveData(JSONItem(SaveData.Child(SpawnOffsetKey.StringValue)))
		    If (SpawnOffset Is Nil) = False Then
		      Set.GroupOffset = SpawnOffset
		    End If
		  End If
		  
		  Var WaterOnlyMinimumHeightKey As Variant = SaveData.FirstKey("waterOnlyMinimumHeight", "Water Only Minimum Height", "water_only_minimum_height", "WaterOnlyMinimumHeight")
		  If WaterOnlyMinimumHeightKey.IsNull = False Then
		    Set.WaterOnlyMinimumHeight = NullableDouble.FromVariant(SaveData.Value(WaterOnlyMinimumHeightKey.StringValue))
		  End If
		  
		  Var MinDistanceFromPlayersMultiplierKey As Variant = SaveData.FirstKey("minDistanceFromPlayersMultiplier", "Min Distance From Players Multiplier", "min_distance_from_players_multiplier", "MinDistanceFromPlayersMultiplier")
		  If MinDistanceFromPlayersMultiplierKey.IsNull = False Then
		    Set.MinDistanceFromPlayersMultiplier = NullableDouble.FromVariant(SaveData.Value(MinDistanceFromPlayersMultiplierKey.StringValue))
		  End If
		  
		  Var MinDistanceFromStructuresMultiplierKey As Variant = SaveData.FirstKey("minDistanceFromStructuresMultiplier", "Min Distance From Structures Multiplier", "min_distance_from_structures_multiplier", "MinDistanceFromStructuresMultiplier")
		  If MinDistanceFromStructuresMultiplierKey.IsNull = False Then
		    Set.MinDistanceFromStructuresMultiplier = NullableDouble.FromVariant(SaveData.Value(MinDistanceFromStructuresMultiplierKey.StringValue))
		  End If
		  
		  Var MinDistanceFromTamedDinosMultiplierKey As Variant = SaveData.FirstKey("minDistanceFromTamedDinosMultiplier", "Min Distance From Tamed Dinos Multiplier", "min_distance_from_tamed_dinos_multiplier", "MinDistanceFromTamedDinosMultiplier")
		  If MinDistanceFromTamedDinosMultiplierKey.IsNull = False Then
		    Set.MinDistanceFromTamedDinosMultiplier = NullableDouble.FromVariant(SaveData.Value(MinDistanceFromTamedDinosMultiplierKey.StringValue))
		  End If
		  
		  Var OffsetBeforeMultiplierKey As Variant = SaveData.FirstKey("offsetBeforeMultiplier", "Offset Before Multiplier", "offset_before_multiplier", "OffsetBeforeMultiplier")
		  If OffsetBeforeMultiplierKey.IsNull = False Then
		    Set.LevelOffsetBeforeMultiplier = SaveData.Value(OffsetBeforeMultiplierKey.StringValue)
		  End If
		  
		  Var ColorSetKey As Variant = SaveData.FirstKey("colorSetClass", "color_set", "Color Set Class") // I'm not confident color_set was ever used
		  If ColorSetKey.IsNull = False Then
		    Set.ColorSetClass = SaveData.Value(ColorSetKey.StringValue)
		  End If
		  
		  Var ReplacementsKey As Variant = SaveData.FirstKey("replacements", "Creature Replacements", "Replacements")
		  If ReplacementsKey.IsNull = False Then
		    Var ReplacementsData As JSONItem = SaveData.Child(ReplacementsKey.StringValue)
		    If (ReplacementsData Is Nil) = False Then
		      // This could be a bunch of things
		      
		      If ReplacementsData.IsArray Then
		        // It was an array of objects
		        For Each ReplacementEntry As JSONEntry In ReplacementsData.Iterator
		          Var Replacement As JSONItem = ReplacementEntry.Value
		          Var FromCreatureId As String
		          Var CreatureIdKey As Variant = Replacement.FirstKey("creatureId", "creature", "creature_id")
		          Var CreatureData As Variant = Replacement.Value(CreatureIdKey.StringValue)
		          If CreatureData.Type = Variant.TypeString Then
		            FromCreatureId = CreatureData.StringValue
		          ElseIf CreatureData.Type = Variant.TypeObject Then
		            Var CreatureRef As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(JSONItem(CreatureData))
		            If (CreatureRef Is Nil) = False Then
		              FromCreatureId = CreatureRef.BlueprintId
		            End If
		          End If
		          
		          Var Choices As JSONItem = Replacement.Child("choices")
		          If Choices.IsArray Then
		            For Each ChoiceEntry As JSONEntry In Choices.Iterator
		              Var ChoiceDict As JSONItem = ChoiceEntry.Value
		              Var ReplacementWeight As Double = ChoiceDict.Value("weight")
		              If ChoiceDict.HasKey("creatureId") Then
		                Var ReplacementCreatureId As String = ChoiceDict.Value("creatureId")
		                Set.CreatureReplacementWeight(FromCreatureId, ReplacementCreatureId) = ReplacementWeight
		              Else
		                Var CreatureRef As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(Dictionary(CreatureData))
		                If (CreatureRef Is Nil) = False Then
		                  Set.CreatureReplacementWeight(FromCreatureId, CreatureRef.BlueprintId) = ReplacementWeight
		                End If
		              End If
		            Next
		          Else
		            For Each ChoiceEntry As JSONEntry In Choices.Iterator
		              Var ReplacementCreatureId As String = ChoiceEntry.Key
		              Var ReplacementWeight As Double = ChoiceEntry.Value
		              Set.CreatureReplacementWeight(FromCreatureId, ReplacementCreatureId) = ReplacementWeight
		            Next
		          End If
		        Next
		      Else
		        Var Manager As ArkSA.BlueprintAttributeManager = ArkSA.BlueprintAttributeManager.FromSaveData(ReplacementsData)
		        If (Manager Is Nil) = False Then
		          // It was a reference manager
		          Var Blueprints() As ArkSA.BlueprintReference = Manager.References
		          For Each Blueprint As ArkSA.BlueprintReference In Blueprints
		            If Blueprint.IsCreature = False Then
		              Continue
		            End If
		            
		            Var Options As ArkSA.BlueprintAttributeManager = Manager.Value(Blueprint, ReplacementsAttribute)
		            Var ReplacementBlueprints() As ArkSA.BlueprintReference = Options.References
		            For Each ReplacementBlueprint As ArkSA.BlueprintReference In ReplacementBlueprints
		              Var ReplacementWeight As Double = Options.Value(ReplacementBlueprint, "Weight")
		              Set.CreatureReplacementWeight(Blueprint.BlueprintId, ReplacementBlueprint.BlueprintId) = ReplacementWeight
		            Next
		          Next
		        Else
		          // It was a dictionary
		          For Each Entry As JSONEntry In ReplacementsData.Iterator
		            Var FromPath As String = Entry.Key
		            Var FromCreature As ArkSA.Creature = ArkSA.ResolveCreature("", FromPath, "", Nil, True)
		            Var ToDict As JSONItem = Entry.Value
		            For Each SubEntry As JSONEntry In ToDict.Iterator
		              Var ToPath As String = SubEntry.Key
		              Var Weight As Double = SubEntry.Value
		              Var ToCreature As ArkSA.Creature = ArkSA.ResolveCreature("", ToPath, "", Nil, True)
		              Set.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		            Next
		          Next
		        End If
		      End If
		    End If
		  End If
		  
		  Set.Modified = False
		  Return New ArkSA.SpawnPointSet(Set)
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
		    Var Raw As String = Beacon.GenerateJSON(Self.SaveData(False), False)
		    Self.mCachedHash = EncodeHex(Crypto.MD5(Raw))
		  End If
		  Return Self.mCachedHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As ArkSA.SpawnPointSet
		  Return New ArkSA.SpawnPointSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As ArkSA.SpawnPointSetEntry) As Integer
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    If Self.mEntries(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
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
		  
		  For Each Entry As ArkSA.SpawnPointSetEntry In Self.mEntries
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
		    For Each Entry As ArkSA.SpawnPointSetEntry In Self.mEntries
		      Entry.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As ArkSA.MutableSpawnPointSet
		  Var Clone As New ArkSA.MutableSpawnPointSet(Self)
		  Clone.SetId = Beacon.UUID.v4
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableSpawnPointSet
		  Return New ArkSA.MutableSpawnPointSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As ArkSA.SpawnPointSet) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mSetId = Other.mSetId And Self.Hash = Other.Hash Then
		    Return 0
		  End If
		  
		  Var CompareLeft As String = Self.mLabel + Self.Hash
		  Var CompareRight As String = Other.mLabel + Other.Hash
		  Return CompareLeft.Compare(CompareRight, ComparisonOptions.CaseInsensitive, Locale.Current)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RawWeight() As Double
		  // Part of the ArkSA.Weighted interface.
		  
		  Return Self.mWeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacedCreatureRefs() As ArkSA.BlueprintReference()
		  Var Arr() As ArkSA.BlueprintReference
		  Var Blueprints() As ArkSA.BlueprintReference = Self.mReplacements.References
		  For Each Blueprint As ArkSA.BlueprintReference In Blueprints
		    If Blueprint.IsCreature Then
		      Arr.Add(Blueprint)
		    End If
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacedCreatures() As ArkSA.Creature()
		  Var Arr() As ArkSA.Creature
		  Var Blueprints() As ArkSA.BlueprintReference = Self.mReplacements.References
		  For Each Blueprint As ArkSA.BlueprintReference In Blueprints
		    If Blueprint.IsCreature Then
		      Arr.Add(ArkSA.Creature(Blueprint.Resolve))
		    End If
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreatures(FromCreatureRef As ArkSA.BlueprintReference) As ArkSA.BlueprintReference()
		  Var Arr() As ArkSA.BlueprintReference
		  If FromCreatureRef Is Nil Then
		    Return Arr
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager = Self.mReplacements.Value(FromCreatureRef, Self.ReplacementsAttribute)
		  If (Options Is Nil) = False Then
		    Var References() As ArkSA.BlueprintReference = Options.References
		    For Each Reference As ArkSA.BlueprintReference In References
		      If Reference.IsCreature = False Then
		        Continue
		      End If
		      Arr.Add(Reference)
		    Next
		  End If
		  
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreatures(FromCreature As ArkSA.Creature) As ArkSA.Creature()
		  Var Arr() As ArkSA.Creature
		  If FromCreature Is Nil Then
		    Return Arr
		  End If
		  
		  Var Options As ArkSA.BlueprintAttributeManager = Self.mReplacements.Value(FromCreature, Self.ReplacementsAttribute)
		  If (Options Is Nil) = False Then
		    Var References() As ArkSA.BlueprintReference = Options.References
		    For Each Reference As ArkSA.BlueprintReference In References
		      If Reference.IsCreature = False Then
		        Continue
		      End If
		      Arr.Add(ArkSA.Creature(Reference.Resolve))
		    Next
		  End If
		  
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacesCreatures() As Boolean
		  Return Self.mReplacements.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(ForAPI As Boolean) As Dictionary
		  Var Entries() As Variant
		  For Each Entry As ArkSA.SpawnPointSetEntry In Self.mEntries
		    Entries.Add(Entry.SaveData(ForAPI))
		  Next
		  
		  Var SaveData As New Dictionary
		  SaveData.Value("spawnPointSetId") = Self.mSetId
		  If ForAPI = False Then
		    SaveData.Value("type") = "SpawnPointSet"
		  End If
		  SaveData.Value("label") = Self.Label
		  SaveData.Value("weight") = Self.RawWeight
		  SaveData.Value("entries") = Entries
		  SaveData.Value("offsetBeforeMultiplier") = Self.mOffsetBeforeMultiplier
		  If Self.mColorSetClass.IsEmpty = False Then
		    SaveData.Value("colorSetClass") = Self.mColorSetClass
		  End If
		  If (Self.mGroupOffset Is Nil) = False Then
		    SaveData.Value("spawnOffset") = Self.mGroupOffset.SaveData
		  End If
		  If (Self.mSpreadRadius Is Nil) = False Then
		    SaveData.Value("spreadRadius") = Self.mSpreadRadius.DoubleValue
		  End If
		  If (Self.mWaterOnlyMinimumHeight Is Nil) = False Then
		    SaveData.Value("waterOnlyMinimumHeight") = Self.mWaterOnlyMinimumHeight.DoubleValue
		  End If
		  If (Self.mMinDistanceFromPlayersMultiplier Is Nil) = False Then
		    SaveData.Value("minDistanceFromPlayersMultiplier") = Self.mMinDistanceFromPlayersMultiplier.DoubleValue
		  End If
		  If (Self.mMinDistanceFromStructuresMultiplier Is Nil) = False Then
		    SaveData.Value("minDistanceFromStructuresMultiplier") = Self.mMinDistanceFromStructuresMultiplier.DoubleValue
		  End If
		  If (Self.mMinDistanceFromTamedDinosMultiplier Is Nil) = False Then
		    SaveData.Value("minDistanceFromTamedDinosMultiplier") = Self.mMinDistanceFromTamedDinosMultiplier.DoubleValue
		  End If
		  If Self.mReplacements.Count > 0 Then
		    If ForAPI Then
		      Var Replacements() As Dictionary
		      Var TargetCreatureRefs() As ArkSA.BlueprintReference = Self.ReplacedCreatureRefs
		      For Each TargetCreatureRef As ArkSA.BlueprintReference In TargetCreatureRefs
		        Var Choices() As Dictionary
		        Var ReplacementCreatureRefs() As ArkSA.BlueprintReference = Self.ReplacementCreatures(TargetCreatureRef)
		        For Each ReplacementCreatureRef As ArkSA.BlueprintReference In ReplacementCreatureRefs
		          Var Weight As NullableDouble = Self.CreatureReplacementWeight(TargetCreatureRef, ReplacementCreatureRef)
		          If Weight Is Nil Then
		            Continue
		          End If
		          
		          Var Choice As New Dictionary
		          Choice.Value("creatureId") = ReplacementCreatureRef.BlueprintId
		          Choice.Value("weight") = Weight.DoubleValue
		          Choices.Add(Choice)
		        Next
		        
		        Var Replacement As New Dictionary
		        Replacement.Value("creatureId") = TargetCreatureRef.BlueprintId
		        Replacement.Value("choices") = Choices
		        Replacements.Add(Replacement)
		      Next
		      
		      SaveData.Value("replacements") = Replacements
		    Else
		      SaveData.Value("replacements") = Self.mReplacements.SaveData
		    End If
		  End If
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetId() As String
		  Return Self.mSetId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpreadRadius() As NullableDouble
		  Return Self.mSpreadRadius
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  // Part of the Beacon.Validateable interface.
		  
		  #Pragma Unused Project
		  
		  Location = Location + Beacon.Issue.Separator + Self.mSetId
		  
		  If Self.mEntries.Count = 0 Then
		    Issues.Add(New Beacon.Issue(Location, "Spawn set '" + Self.Label + "' should contain at least one creature to be spawned."))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WaterOnlyMinimumHeight() As NullableDouble
		  Return Self.mWaterOnlyMinimumHeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mCachedHash As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mColorSetClass As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEntries() As ArkSA.SpawnPointSetEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGroupOffset As Beacon.Point3D
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
		Protected mReplacements As ArkSA.BlueprintAttributeManager
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSetId As String
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


	#tag Constant, Name = ReplacementsAttribute, Type = String, Dynamic = False, Default = \"Replacements", Scope = Protected
	#tag EndConstant


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
