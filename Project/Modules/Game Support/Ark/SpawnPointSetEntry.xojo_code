#tag Class
Protected Class SpawnPointSetEntry
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function Clone() As Ark.SpawnPointSetEntry
		  Var Clone As New Ark.SpawnPointSetEntry(Self)
		  Clone.mEntryId = Beacon.UUID.v4
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mEntryId = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Creature As Ark.Creature)
		  Self.Constructor()
		  Self.mCreature = Creature
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.SpawnPointSetEntry)
		  Self.Constructor()
		  
		  Self.mEntryId = Source.mEntryId
		  Self.mCreature = Source.mCreature
		  Self.mChance = Source.mChance
		  Self.mModified = Source.mModified
		  Self.mLevelOverride = Source.mLevelOverride
		  Self.mMaxLevelMultiplier = Source.mMaxLevelMultiplier
		  Self.mMaxLevelOffset = Source.mMaxLevelOffset
		  Self.mMinLevelMultiplier = Source.mMinLevelMultiplier
		  Self.mMinLevelOffset = Source.mMinLevelOffset
		  If Source.mOffset <> Nil Then
		    Self.mOffset = New Beacon.Point3D(Source.mOffset)
		  End If
		  
		  Self.mLevels.ResizeTo(Source.mLevels.LastIndex)
		  For I As Integer = 0 To Source.mLevels.LastIndex
		    Self.mLevels(I) = New Ark.SpawnPointLevel(Source.mLevels(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creature() As Ark.Creature
		  Return Self.mCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryId() As String
		  Return Self.mEntryId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Ark.SpawnPointSetEntry
		  If Dict Is Nil Or Dict.HasAnyKey("creature", "Blueprint", "creature_id", "Creature", "creatureId") = False Then
		    Return Nil
		  End If
		  
		  // There are so many possibilities here because this needs to support the
		  // delta versions, v4, and v5 versions of the structure.
		  
		  Var Entry As Ark.SpawnPointSetEntry
		  If Dict.HasKey("creatureId") Then
		    Var Creature As Ark.Creature = Ark.ResolveCreature(Dict.Value("creatureId").StringValue, "", "", Nil)
		    If Creature Is Nil Then
		      Return Nil
		    End If
		    Entry = New Ark.SpawnPointSetEntry(Creature)
		  ElseIf Dict.HasKey("creature") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("creature"))
		    If Reference Is Nil Or Reference.IsCreature = False Then
		      Return Nil
		    End If
		    
		    Var Blueprint As Ark.Blueprint = Reference.Resolve
		    If Blueprint Is Nil Or (Blueprint IsA Ark.Creature) = False Then
		      Return Nil
		    End If
		    Entry = New Ark.SpawnPointSetEntry(Ark.Creature(Blueprint))
		  ElseIf Dict.HasKey("Blueprint") Then
		    Var Reference As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(Dict.Value("Blueprint"))
		    If Reference Is Nil Or Reference.IsCreature = False Then
		      Return Nil
		    End If
		    
		    Var Blueprint As Ark.Blueprint = Reference.Resolve
		    If Blueprint Is Nil Or (Blueprint IsA Ark.Creature) = False Then
		      Return Nil
		    End If
		    Entry = New Ark.SpawnPointSetEntry(Ark.Creature(Blueprint))
		  Else
		    Var Creature As Ark.Creature = Ark.ResolveCreature(Dict, "creature_id", "Creature", "", Nil)
		    If Creature Is Nil Then
		      Return Nil
		    End If
		    Entry = New Ark.SpawnPointSetEntry(Creature)
		  End If
		  
		  If Dict.HasKey("spawnPointSetEntryId") Then
		    Entry.mEntryId = Dict.Value("spawnPointSetEntryId")
		  ElseIf Dict.HasKey("UUID") Then
		    Entry.mEntryId = Dict.Value("UUID").StringValue
		  ElseIf Dict.HasKey("spawn_point_set_entry_id") Then
		    Entry.mEntryId = Dict.Value("spawn_point_set_entry_id").StringValue
		  End If
		  
		  If Dict.HasKey("weight") Then
		    Entry.mChance = NullableDouble.FromVariant(Dict.Value("weight"))
		  ElseIf Dict.HasKey("Weight") Then
		    Entry.mChance = NullableDouble.FromVariant(Dict.Value("Weight"))
		  ElseIf Dict.HasKey("SpawnChance") Then
		    Entry.mChance = NullableDouble.FromVariant(Dict.Value("SpawnChance"))
		  ElseIf Dict.HasKey("Chance") Then
		    Entry.mChance = NullableDouble.FromVariant(Dict.Value("Chance"))
		  End If
		  
		  If Dict.HasKey("spawnOffset") Then
		    Entry.mOffset = Beacon.Point3D.FromSaveData(Dict.Value("spawnOffset"))
		  ElseIf Dict.HasKey("Spawn Offset") Then
		    Entry.mOffset = Beacon.Point3D.FromSaveData(Dict.Value("Spawn Offset"))
		  ElseIf Dict.HasKey("spawn_offset") Then
		    Entry.mOffset = Beacon.Point3D.FromSaveData(Dict.Value("spawn_offset"))
		  ElseIf Dict.HasKey("Offset") Then
		    Entry.mOffset = Beacon.Point3D.FromSaveData(Dict.Value("Offset"))
		  End If
		  
		  Var Levels() As Dictionary
		  If Dict.HasKey("levelOverrides") And Dict.Value("levelOverrides").IsNull = False Then
		    Levels = Dict.Value("levelOverrides").DictionaryArrayValue
		  ElseIf Dict.HasKey("Level Overrides") And Dict.Value("Level Overrides").IsNull = False Then
		    Levels = Dict.Value("Level Overrides").DictionaryArrayValue
		  ElseIf Dict.HasKey("level_overrides") And Dict.Value("level_overrides").IsNull = False Then
		    Levels = Dict.Value("level_overrides").DictionaryArrayValue
		  ElseIf Dict.HasKey("Levels") And Dict.Value("Levels").IsNull = False Then
		    Levels = Dict.Value("Levels").DictionaryArrayValue
		  End If
		  For Each LevelData As Dictionary In Levels
		    Var Level As Ark.SpawnPointLevel = Ark.SpawnPointLevel.FromSaveData(LevelData)
		    If Level <> Nil Then
		      Entry.mLevels.Add(Level)
		    End If
		  Next
		  
		  If Dict.HasKey("maxLevelMultiplier") Then
		    Entry.mMaxLevelMultiplier = NullableDouble.FromVariant(Dict.Value("maxLevelMultiplier"))
		  ElseIf Dict.HasKey("Max Level Multiplier") Then
		    Entry.mMaxLevelMultiplier = NullableDouble.FromVariant(Dict.Value("Max Level Multiplier"))
		  ElseIf Dict.HasKey("max_level_multiplier") Then
		    Entry.mMaxLevelMultiplier = NullableDouble.FromVariant(Dict.Value("max_level_multiplier"))
		  ElseIf Dict.HasKey("MaxLevelMultiplier") Then
		    Entry.mMaxLevelMultiplier = NullableDouble.FromVariant(Dict.Value("MaxLevelMultiplier"))
		  End If
		  
		  If Dict.HasKey("maxLevelOffset") Then
		    Entry.mMaxLevelOffset = NullableDouble.FromVariant(Dict.Value("maxLevelOffset"))
		  ElseIf Dict.HasKey("Max Level Offset") Then
		    Entry.mMaxLevelOffset = NullableDouble.FromVariant(Dict.Value("Max Level Offset"))
		  ElseIf Dict.HasKey("max_level_offset") Then
		    Entry.mMaxLevelOffset = NullableDouble.FromVariant(Dict.Value("max_level_offset"))
		  ElseIf Dict.HasKey("MaxLevelOffset") Then
		    Entry.mMaxLevelOffset = NullableDouble.FromVariant(Dict.Value("MaxLevelOffset"))
		  End If
		  
		  If Dict.HasKey("minLevelMultiplier") Then
		    Entry.mMinLevelMultiplier = NullableDouble.FromVariant(Dict.Value("minLevelMultiplier"))
		  ElseIf Dict.HasKey("Min Level Multiplier") Then
		    Entry.mMinLevelMultiplier = NullableDouble.FromVariant(Dict.Value("Min Level Multiplier"))
		  ElseIf Dict.HasKey("min_level_multiplier") Then
		    Entry.mMinLevelMultiplier = NullableDouble.FromVariant(Dict.Value("min_level_multiplier"))
		  ElseIf Dict.HasKey("MinLevelMultiplier") Then
		    Entry.mMinLevelMultiplier = NullableDouble.FromVariant(Dict.Value("MinLevelMultiplier"))
		  End If
		  
		  If Dict.HasKey("minLevelOffset") Then
		    Entry.mMinLevelOffset = NullableDouble.FromVariant(Dict.Value("minLevelOffset"))
		  ElseIf Dict.HasKey("Min Level Offset") Then
		    Entry.mMinLevelOffset = NullableDouble.FromVariant(Dict.Value("Min Level Offset"))
		  ElseIf Dict.HasKey("min_level_offset") Then
		    Entry.mMinLevelOffset = NullableDouble.FromVariant(Dict.Value("min_level_offset"))
		  ElseIf Dict.HasKey("MinLevelOffset") Then
		    Entry.mMinLevelOffset = NullableDouble.FromVariant(Dict.Value("MinLevelOffset"))
		  End If
		  
		  If Dict.HasKey("override") Then
		    Entry.mLevelOverride = NullableDouble.FromVariant(Dict.Value("override"))
		  ElseIf Dict.HasKey("Level Override") Then
		    Entry.mLevelOverride = NullableDouble.FromVariant(Dict.Value("Level Override"))
		  ElseIf Dict.HasKey("LevelOverride") Then
		    Entry.mLevelOverride = NullableDouble.FromVariant(Dict.Value("LevelOverride"))
		  End If
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasCustomLevelRange() As Boolean
		  Return Self.mLevels.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.SpawnPointSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Level As Ark.SpawnPointLevel) As Integer
		  For I As Integer = 0 To Self.mLevels.LastIndex
		    If Self.mLevels(I) = Level Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.Creature.Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Level(AtIndex As Integer) As Ark.SpawnPointLevel
		  Return New Ark.SpawnPointLevel(Self.mLevels(AtIndex))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelBound() As Integer
		  Return Self.mLevels.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelCount() As Integer
		  Return Self.mLevels.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelForDifficulty(Difficulty As Double, NilDefault As Boolean = False) As Ark.SpawnPointLevel
		  Var Candidate As Ark.SpawnPointLevel
		  For Each Level As Ark.SpawnPointLevel In Self.mLevels
		    If Level.Difficulty <= Difficulty And (Candidate = Nil Or Candidate.Difficulty < Level.Difficulty) Then
		      Candidate = Level
		    End If
		  Next
		  If Candidate = Nil And NilDefault = False Then
		    Candidate = Ark.SpawnPointLevel.FromUserLevel(1.0 * Difficulty, 30.0 * Difficulty, Difficulty)
		  End If
		  Return Candidate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelOverride() As NullableDouble
		  Return Self.mLevelOverride
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelRangeForDifficulty(Difficulty As Double, OffsetBeforeMultiplier As Boolean) As Beacon.Range
		  If Self.HasCustomLevelRange Then
		    // First, sort them.
		    Var Difficulties() As Double
		    Var Levels() As Ark.SpawnPointLevel
		    Difficulties.ResizeTo(Self.mLevels.LastIndex)
		    Levels.ResizeTo(Self.mLevels.LastIndex)
		    For Idx As Integer = 0 To Self.mLevels.LastIndex
		      Difficulties(Idx) = Self.mLevels(Idx).Difficulty
		      Levels(Idx) = Self.mLevels(Idx)
		    Next
		    Difficulties.SortWith(Levels)
		    
		    // Next we need to find the two difficulties closest to the target difficulty.
		    // For example, for definitions 0.0, 1.0, and 2.0, if asked for 1.5 we need
		    // 1.0 and 2.0. However, if asked for greater than the highest, then we return the lowest
		    // value. Exact matches should use the same definition for the high and low.
		    Var LowDefinition, HighDefinition As Ark.SpawnPointLevel
		    If Levels.Count = 1 Or Levels(Levels.LastIndex).Difficulty < Difficulty Or Levels(0).Difficulty > Difficulty Then
		      LowDefinition = Levels(0)
		      HighDefinition = Levels(0)
		    Else
		      For Idx As Integer = 0 To Levels.LastIndex
		        If Levels(Idx).Difficulty = Difficulty Then
		          LowDefinition = Levels(Idx)
		          HighDefinition = Levels(Idx)
		          Exit For Idx
		        ElseIf Idx < Levels.LastIndex And Levels(Idx).Difficulty < Difficulty And Levels(Idx + 1).Difficulty > Difficulty Then
		          LowDefinition = Levels(Idx)
		          HighDefinition = Levels(Idx + 1)
		          Exit For Idx
		        End If
		      Next
		    End If
		    
		    If (LowDefinition Is Nil) = False And (HighDefinition Is Nil) = False Then
		      Var DiffDelta As Double = HighDefinition.Difficulty - Difficulty
		      Var MinLevel As Double = Difficulty * (Floor(LowDefinition.MinLevel) + ((Floor(HighDefinition.MinLevel) - Floor(LowDefinition.MinLevel)) * DiffDelta))
		      Var MaxLevel As Double = Difficulty * (Floor(LowDefinition.MaxLevel) + ((Floor(HighDefinition.MaxLevel) - Floor(LowDefinition.MaxLevel)) * DiffDelta))
		      Return New Beacon.Range(Round(MinLevel), Round(MaxLevel))
		    End If
		  End If
		  
		  // If OffsetBeforeMultiplier is true the formula is:
		  // ((Step + Offset) * Multiplier) * Difficulty
		  
		  // If OffsetBeforeMultiplier is false, the formula is:
		  // ((Step * Multiplier) + Offset) * Difficulty
		  
		  Const MinStep = 1
		  Const MaxStep = 30
		  
		  Var MinLevelOffset, MaxLevelOffset As Double = 0.0
		  Var MinLevelMultiplier, MaxLevelMultiplier As Double = 1.0
		  
		  If Self.MinLevelOffset <> Nil Then
		    MinLevelOffset = Self.MinLevelOffset
		  End If
		  If Self.MaxLevelOffset <> Nil Then
		    MaxLevelOffset = Self.MaxLevelOffset
		  End If
		  If Self.MinLevelMultiplier <> Nil Then
		    MinLevelMultiplier = Self.MinLevelMultiplier
		  End If
		  If Self.MaxLevelMultiplier <> Nil Then
		    MaxLevelMultiplier = Self.MaxLevelMultiplier
		  End If
		  
		  If MinLevelOffset > MaxLevelOffset Then
		    Var Temp As Double = MinLevelOffset
		    MinLevelOffset = MaxLevelOffset
		    MaxLevelOffset = Temp
		  End If
		  
		  If MinLevelMultiplier > MaxLevelMultiplier Then
		    Var Temp As Double = MinLevelMultiplier
		    MinLevelMultiplier = MaxLevelMultiplier
		    MaxLevelMultiplier = Temp
		  End If
		  
		  Var MinLevel, MaxLevel As Integer
		  If OffsetBeforeMultiplier Then
		    MinLevel = Round(((MinStep + MinLevelOffset) * MinLevelMultiplier) * Difficulty)
		    MaxLevel = Round(((MaxStep + MaxLevelOffset) * MaxLevelMultiplier) * Difficulty)
		  Else
		    MinLevel = Round(((MinStep * MinLevelMultiplier) + MinLevelOffset) * Difficulty)
		    MaxLevel = Round(((MaxStep * MaxLevelMultiplier) + MaxLevelOffset) * Difficulty)
		  End If
		  
		  Return New Beacon.Range(MinLevel, MaxLevel)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Levels() As Ark.SpawnPointLevel()
		  Var Arr() As Ark.SpawnPointLevel
		  Arr.ResizeTo(Self.mLevels.LastIndex)
		  For I As Integer = 0 To Self.mLevels.LastIndex
		    Arr(I) = New Ark.SpawnPointLevel(Self.mLevels(I))
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLevelMultiplier() As NullableDouble
		  Return Self.mMaxLevelMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLevelOffset() As NullableDouble
		  Return Self.mMaxLevelOffset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinLevelMultiplier() As NullableDouble
		  Return Self.mMinLevelMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinLevelOffset() As NullableDouble
		  Return Self.mMinLevelOffset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableSpawnPointSetEntry
		  Var Clone As New Ark.MutableSpawnPointSetEntry(Self)
		  Clone.EntryId = Beacon.UUID.v4
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableSpawnPointSetEntry
		  Return New Ark.MutableSpawnPointSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Offset() As Beacon.Point3D
		  If Self.mOffset <> Nil Then
		    Return New Beacon.Point3D(Self.mOffset)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.SpawnPointSetEntry) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Return Self.mEntryId.Compare(Other.mEntryId, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("spawnPointSetEntryId") = Self.mEntryId
		  Dict.Value("creatureId") = Self.mCreature.CreatureId
		  Dict.Value("type") = "SpawnPointSetEntry"
		  If Self.mChance <> Nil Then
		    Dict.Value("weight") = Self.mChance.DoubleValue
		  End If
		  If Self.mOffset <> Nil Then
		    Dict.Value("spawnOffset") = Self.mOffset.SaveData
		  End If
		  If Self.mLevels.LastIndex > -1 Then
		    Var Levels() As Dictionary
		    Levels.ResizeTo(Self.mLevels.LastIndex)
		    For I As Integer = 0 To Self.mLevels.LastIndex
		      Levels(I) = Self.mLevels(I).SaveData
		    Next
		    Dict.Value("levelOverrides") = Levels
		  End If
		  If Self.mMinLevelMultiplier <> Nil Then
		    Dict.Value("minLevelMultiplier") = Self.mMinLevelMultiplier.DoubleValue
		  End If
		  If Self.mMaxLevelMultiplier <> Nil Then
		    Dict.Value("maxLevelMultiplier") = Self.mMaxLevelMultiplier.DoubleValue
		  End If
		  If Self.mMinLevelOffset <> Nil Then
		    Dict.Value("minLevelOffset") = Self.mMinLevelOffset.DoubleValue
		  End If
		  If Self.mMaxLevelOffset <> Nil Then
		    Dict.Value("maxLevelOffset") = Self.mMaxLevelOffset.DoubleValue
		  End If
		  If Self.mLevelOverride <> Nil Then
		    Dict.Value("override") = Self.mLevelOverride.DoubleValue
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SortValue() As String
		  Const Formatter = "000000.000000"
		  
		  Var Candidates(9) As NullableDouble
		  Candidates(0) = Self.mChance
		  Candidates(1) = Self.mMinLevelOffset
		  Candidates(2) = Self.mMinLevelMultiplier
		  Candidates(3) = Self.mMaxLevelOffset
		  Candidates(4) = Self.mMaxLevelMultiplier
		  Candidates(5) = Self.mLevelOverride
		  If (Self.mOffset Is Nil) = False Then
		    Candidates(6) = Self.mOffset.X
		    Candidates(7) = Self.mOffset.Y
		    Candidates(8) = Self.mOffset.Z
		  End If
		  
		  Var Values() As String = Array(Self.Label.Trim)
		  For Each Candidate As NullableDouble In Candidates
		    Var Formatted As String
		    If Candidate Is Nil Then
		      Formatted = Formatter
		    Else
		      Formatted = Candidate.DoubleValue.ToString(Locale.Raw, Formatter)
		    End If
		    If Formatted.BeginsWith("-") Then
		      Formatted = "a" + Formatted.Middle(1)
		    Else
		      Formatted = "b" + Formatted
		    End If
		    Values.Add(Formatted)
		  Next
		  
		  Return String.FromArray(Values, ":")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChance() As NullableDouble
		  Return Self.mChance
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mChance As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCreature As Ark.Creature
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mEntryId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLevelOverride As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLevels() As Ark.SpawnPointLevel
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxLevelMultiplier As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxLevelOffset As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinLevelMultiplier As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinLevelOffset As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mOffset As Beacon.Point3D
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
