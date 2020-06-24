#tag Class
Protected Class SpawnPointSetEntry
Implements Beacon.DocumentItem,Beacon.NamedItem
	#tag Method, Flags = &h0
		Function Clone() As Beacon.SpawnPointSetEntry
		  Var Clone As New Beacon.SpawnPointSetEntry(Self)
		  Clone.mID = New v4UUID
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mID = New v4UUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Creature As Beacon.Creature)
		  Self.Constructor()
		  Self.mCreature = Creature
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPointSetEntry)
		  Self.Constructor()
		  
		  Self.mID = Source.mID
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
		  
		  Self.mLevels.ResizeTo(Source.mLevels.LastRowIndex)
		  For I As Integer = 0 To Source.mLevels.LastRowIndex
		    Self.mLevels(I) = New Beacon.SpawnPointLevel(Source.mLevels(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Engrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creature() As Beacon.Creature
		  Return Self.mCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.SpawnPointSetEntry
		  If Dict = Nil Or Dict.HasKey("Creature") = False Then
		    Return Nil
		  End If
		  
		  Var Entry As New Beacon.SpawnPointSetEntry
		  Entry.mCreature = Beacon.Data.GetCreatureByPath(Dict.Value("Creature"))
		  If Entry.mCreature = Nil Then
		    Return Nil
		  End If
		  
		  If Dict.HasKey("SpawnChance") Then
		    Entry.mChance = Dict.Value("SpawnChance").DoubleValue
		  ElseIf Dict.HasKey("Chance") Then
		    Entry.mChance = Dict.Value("Chance").DoubleValue
		  End If
		  
		  If Dict.HasKey("Offset") Then
		    Entry.mOffset = Beacon.Point3D.FromSaveData(Dict.Value("Offset"))
		  End If
		  
		  If Dict.HasKey("Levels") Then
		    Var Levels() As Variant = Dict.Value("Levels")
		    For Each LevelData As Dictionary In Levels
		      Var Level As Beacon.SpawnPointLevel = Beacon.SpawnPointLevel.FromSaveData(LevelData)
		      If Level <> Nil Then
		        Entry.mLevels.AddRow(Level)
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("MaxLevelMultiplier") Then
		    Entry.mMaxLevelMultiplier = Dict.Value("MaxLevelMultiplier").DoubleValue
		  End If
		  
		  If Dict.HasKey("MaxLevelOffset") Then
		    Entry.mMaxLevelOffset = Dict.Value("MaxLevelOffset").DoubleValue
		  End If
		  
		  If Dict.HasKey("MinLevelMultiplier") Then
		    Entry.mMinLevelMultiplier = Dict.Value("MinLevelMultiplier").DoubleValue
		  End If
		  
		  If Dict.HasKey("MinLevelOffset") Then
		    Entry.mMinLevelOffset = Dict.Value("MinLevelOffset").DoubleValue
		  End If
		  
		  If Dict.HasKey("LevelOverride") Then
		    Entry.mLevelOverride = Dict.Value("LevelOverride").DoubleValue
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
		Function ID() As v4UUID
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.SpawnPointSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Level As Beacon.SpawnPointLevel) As Integer
		  For I As Integer = 0 To Self.mLevels.LastRowIndex
		    If Self.mLevels(I) = Level Then
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
		  
		  Return Self.mCreature <> Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Return Self.mCreature.Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Level(AtIndex As Integer) As Beacon.SpawnPointLevel
		  Return New Beacon.SpawnPointLevel(Self.mLevels(AtIndex))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelBound() As Integer
		  Return Self.mLevels.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelCount() As Integer
		  Return Self.mLevels.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LevelForDifficulty(Difficulty As Double, NilDefault As Boolean = False) As Beacon.SpawnPointLevel
		  Var Candidate As Beacon.SpawnPointLevel
		  For Each Level As Beacon.SpawnPointLevel In Self.mLevels
		    If Level.Difficulty <= Difficulty And (Candidate = Nil Or Candidate.Difficulty < Level.Difficulty) Then
		      Candidate = Level
		    End If
		  Next
		  If Candidate = Nil And NilDefault = False Then
		    Candidate = Beacon.SpawnPointLevel.FromUserLevel(1.0 * Difficulty, 30.0 * Difficulty, Difficulty)
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
		    Var Levels() As Beacon.SpawnPointLevel
		    Difficulties.ResizeTo(Self.mLevels.LastRowIndex)
		    Levels.ResizeTo(Self.mLevels.LastRowIndex)
		    For Idx As Integer = 0 To Self.mLevels.LastRowIndex
		      Difficulties(Idx) = Self.mLevels(Idx).Difficulty
		      Levels(Idx) = Self.mLevels(Idx)
		    Next
		    Difficulties.SortWith(Levels)
		    
		    // Next we need to find the two difficulties closest to the target difficulty.
		    // For example, for definitions 0.0, 1.0, and 2.0, if asked for 1.5 we need
		    // 1.0 and 2.0. However, if asked for greater than the highest, then we return the lowest
		    // value. Exact matches should use the same definition for the high and low.
		    Var LowDefinition, HighDefinition As Beacon.SpawnPointLevel
		    If Levels.Count = 1 Or Levels(Levels.LastRowIndex).Difficulty < Difficulty Or Levels(0).Difficulty > Difficulty Then
		      LowDefinition = Levels(0)
		      HighDefinition = Levels(0)
		    Else
		      For Idx As Integer = 0 To Levels.LastRowIndex
		        If Levels(Idx).Difficulty = Difficulty Then
		          LowDefinition = Levels(Idx)
		          HighDefinition = Levels(Idx)
		          Exit For Idx
		        ElseIf Idx < Levels.LastRowIndex And Levels(Idx).Difficulty < Difficulty And Levels(Idx + 1).Difficulty > Difficulty Then
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
		Function Levels() As Beacon.SpawnPointLevel()
		  Var Arr() As Beacon.SpawnPointLevel
		  Arr.ResizeTo(Self.mLevels.LastRowIndex)
		  For I As Integer = 0 To Self.mLevels.LastRowIndex
		    Arr(I) = New Beacon.SpawnPointLevel(Self.mLevels(I))
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
		  // Part of the Beacon.DocumentItem interface.
		  
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  // Part of the Beacon.DocumentItem interface.
		  
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableSpawnPointSetEntry
		  Var Clone As New Beacon.MutableSpawnPointSetEntry(Self)
		  Clone.ID = New v4UUID
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableSpawnPointSetEntry
		  Return New Beacon.MutableSpawnPointSetEntry(Self)
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
		Function Operator_Compare(Other As Beacon.SpawnPointSetEntry) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mID.Operator_Compare(Other.mID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Creature") = Self.mCreature.Path
		  Dict.Value("Type") = "SpawnPointSetEntry"
		  If Self.mChance <> Nil Then
		    Dict.Value("SpawnChance") = Self.mChance.DoubleValue
		  End If
		  If Self.mOffset <> Nil Then
		    Dict.Value("Offset") = Self.mOffset.SaveData
		  End If
		  If Self.mLevels.LastRowIndex > -1 Then
		    Var Levels() As Dictionary
		    Levels.ResizeTo(Self.mLevels.LastRowIndex)
		    For I As Integer = 0 To Self.mLevels.LastRowIndex
		      Levels(I) = Self.mLevels(I).SaveData
		    Next
		    Dict.Value("Levels") = Levels
		  End If
		  If Self.mMaxLevelMultiplier <> Nil Then
		    Dict.Value("MaxLevelMultiplier") = Self.mMaxLevelMultiplier.DoubleValue
		  End If
		  If Self.mMaxLevelOffset <> Nil Then
		    Dict.Value("MaxLevelOffset") = Self.mMaxLevelOffset.DoubleValue
		  End If
		  If Self.mMinLevelMultiplier <> Nil Then
		    Dict.Value("MinLevelMultiplier") = Self.mMinLevelMultiplier.DoubleValue
		  End If
		  If Self.mMinLevelOffset <> Nil Then
		    Dict.Value("MinLevelOffset") = Self.mMinLevelOffset.DoubleValue
		  End If
		  If Self.mLevelOverride <> Nil Then
		    Dict.Value("LevelOverride") = Self.mLevelOverride.DoubleValue
		  End If
		  Return Dict
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
		Protected mCreature As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLevelOverride As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLevels() As Beacon.SpawnPointLevel
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
