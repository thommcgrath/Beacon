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
		  Self.mWeight = 1.0
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
		  Self.mModified = Source.mModified
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
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastRowIndex)
		  For I As Integer = 0 To Source.mEntries.LastRowIndex
		    Self.mEntries(I) = Source.mEntries(I).ImmutableVersion
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
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mEntries.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureReplacementWeight(FromCreature As Beacon.Creature, ToCreature As Beacon.Creature) As NullableDouble
		  If Not Self.mReplacements.HasKey(FromCreature.Path) Then
		    Return Nil
		  End If
		  
		  Var Options As Dictionary = Self.mReplacements.Value(FromCreature.Path)
		  If Options.HasKey(ToCreature.Path) Then
		    Return Options.Value(ToCreature.Path).DoubleValue
		  Else
		    Return Nil
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entries() As Beacon.SpawnPointSetEntry()
		  Var Arr() As Beacon.SpawnPointSetEntry
		  Arr.ResizeTo(Self.mEntries.LastRowIndex)
		  For I As Integer = 0 To Self.mEntries.LastRowIndex
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
		  If SaveData.HasKey("Label") Then
		    Set.Label = SaveData.Value("Label")
		  ElseIf SaveData.HasKey("label") Then
		    Set.Label = SaveData.Value("label")
		  Else
		    Return Nil
		  End If
		  If SaveData.HasKey("Weight") Then
		    Set.Weight = SaveData.Value("Weight")
		  ElseIf SaveData.HasKey("weight") Then
		    Set.Weight = SaveData.Value("weight")
		  Else
		    Return Nil
		  End If
		  
		  If SaveData.HasKey("Entries") Then
		    Var Entries() As Variant = SaveData.Value("Entries")
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
		  
		  If SaveData.HasKey("SpreadRadius") Then
		    Set.SpreadRadius = SaveData.Value("SpreadRadius").DoubleValue
		  End If
		  
		  If SaveData.HasKey("GroupOffset") And SaveData.Value("GroupOffset") <> Nil Then
		    Var GroupOffset As Beacon.Point3D = Beacon.Point3D(SaveData.Value("GroupOffset"))
		    If GroupOffset <> Nil Then
		      Set.GroupOffset = GroupOffset
		    End If
		  End If
		  
		  If SaveData.HasKey("WaterOnlyMinimumHeight") Then
		    Set.WaterOnlyMinimumHeight = SaveData.Value("WaterOnlyMinimumHeight").DoubleValue
		  End If
		  
		  If SaveData.HasKey("MinDistanceFromPlayersMultiplier") Then
		    Set.MinDistanceFromPlayersMultiplier = SaveData.Value("MinDistanceFromPlayersMultiplier").DoubleValue
		  End If
		  
		  If SaveData.HasKey("MinDistanceFromStructuresMultiplier") Then
		    Set.MinDistanceFromStructuresMultiplier = SaveData.Value("MinDistanceFromStructuresMultiplier").DoubleValue
		  End If
		  
		  If SaveData.HasKey("MinDistanceFromTamedDinosMultiplier") Then
		    Set.MinDistanceFromTamedDinosMultiplier = SaveData.Value("MinDistanceFromTamedDinosMultiplier").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Replacements") Then
		    Var Replacements As Dictionary = SaveData.Value("Replacements")
		    For Each Entry As DictionaryEntry In Replacements
		      Var FromPath As String = Entry.Key
		      Var FromCreature As Beacon.Creature = Beacon.Data.GetCreatureByPath(FromPath)
		      If FromCreature = Nil Then
		        FromCreature = Beacon.Creature.CreateFromPath(FromPath)
		      End If
		      
		      Var ToDict As Dictionary = Entry.Value
		      For Each SubEntry As DictionaryEntry In ToDict
		        Var ToPath As String = SubEntry.Key
		        Var Weight As Double = SubEntry.Value
		        Var ToCreature As Beacon.Creature = Beacon.Data.GetCreatureByPath(ToPath)
		        If ToCreature = Nil Then
		          ToCreature = Beacon.Creature.CreateFromPath(ToPath)
		        End If
		        
		        Set.CreatureReplacementWeight(FromCreature, ToCreature) = Weight
		      Next
		    Next
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
		Function ID() As v4UUID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.SpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.SpawnPointSetEntry) As Integer
		  For I As Integer = 0 To Self.mEntries.LastRowIndex
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
		  
		  If Self.mEntries.LastRowIndex = -1 Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Entries() As Variant
		  Entries.ResizeTo(Self.mEntries.LastRowIndex)
		  For I As Integer = 0 To Self.mEntries.LastRowIndex
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
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.mID = Other.mID Then
		    Return 0
		  End If
		  
		  Return Self.mLabel.Compare(Other.mLabel, ComparisonOptions.CaseInsensitive, Locale.Current)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacedCreatures() As Beacon.Creature()
		  Var Arr() As Beacon.Creature
		  For Each Entry As DictionaryEntry In Self.mReplacements
		    Var Path As String = Entry.Key
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		    If Creature = Nil Then
		      Creature = Beacon.Creature.CreateFromPath(Path)
		    End If
		    Arr.AddRow(Creature)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreatures(FromCreature As Beacon.Creature) As Beacon.Creature()
		  Var Arr() As Beacon.Creature
		  If Not Self.mReplacements.HasKey(FromCreature.Path) Then
		    Return Arr
		  End If
		  
		  Var Options As Dictionary = Self.mReplacements.Value(FromCreature.Path)
		  For Each Entry As DictionaryEntry In Options
		    Var Path As String = Entry.Key
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		    If Creature = Nil Then
		      Creature = Beacon.Creature.CreateFromPath(Path)
		    End If
		    Arr.AddRow(Creature)
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
		  Var Entries() As Dictionary
		  For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		    Entries.AddRow(Entry.SaveData)
		  Next
		  
		  Var SaveData As New Dictionary
		  SaveData.Value("Label") = Self.Label
		  SaveData.Value("Weight") = Self.Weight
		  SaveData.Value("Entries") = Entries
		  If Self.mGroupOffset <> Nil Then
		    SaveData.Value("GroupOffset") = Self.mGroupOffset.SaveData
		  End If
		  If Self.mSpreadRadius <> Nil Then
		    SaveData.Value("SpreadRadius") = Self.mSpreadRadius.Value
		  End If
		  If Self.mWaterOnlyMinimumHeight <> Nil Then
		    SaveData.Value("WaterOnlyMinimumHeight") = Self.mWaterOnlyMinimumHeight.Value
		  End If
		  If Self.mMinDistanceFromPlayersMultiplier <> Nil Then
		    SaveData.Value("MinDistanceFromPlayersMultiplier") = Self.mMinDistanceFromPlayersMultiplier.Value
		  End If
		  If Self.mMinDistanceFromStructuresMultiplier <> Nil Then
		    SaveData.Value("MinDistanceFromStructuresMultiplier") = Self.mMinDistanceFromStructuresMultiplier.Value
		  End If
		  If Self.mMinDistanceFromTamedDinosMultiplier <> Nil Then
		    SaveData.Value("MinDistanceFromTamedDinosMultiplier") = Self.mMinDistanceFromTamedDinosMultiplier.Value
		  End If
		  If Self.mReplacements.KeyCount > 0 Then
		    SaveData.Value("Replacements") = Self.mReplacements
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
		Protected mEntries() As Beacon.SpawnPointSetEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGroupOffset As Beacon.Point3D
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
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
