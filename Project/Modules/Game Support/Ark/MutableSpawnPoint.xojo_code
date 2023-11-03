#tag Class
Protected Class MutableSpawnPoint
Inherits Ark.SpawnPoint
Implements Ark.MutableBlueprint
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub AddSet(Set As Ark.SpawnPointSet, Replace As Boolean = False)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Self.mSets.Add(Set.ImmutableVersion)
		    Self.Modified = True
		  ElseIf Replace Then
		    Self.mSets(Idx) = Set.ImmutableVersion
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  If Self.mAlternateLabel = Value Then
		    Return
		  End If
		  
		  Self.mAlternateLabel = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  If Self.mAvailability = Value Then
		    Return
		  End If
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintId(Assigns Value As String)
		  If Self.mSpawnPointId = Value Then
		    Return
		  End If
		  
		  Self.mSpawnPointId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearLimits()
		  Self.mLimits = New Ark.BlueprintAttributeManager
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.MutableSpawnPoint
		  Return New Ark.MutableSpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Making it public
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, SpawnPointId As String)
		  Super.Constructor()
		  Self.mSpawnPointId = SpawnPointId
		  Self.mAvailability = Ark.Maps.UniversalMask
		  Self.Path = Path
		  Self.Label = Ark.LabelFromClassString(Self.ClassString)
		  Self.Modified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackId(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  If Self.mContentPackId = Value Then
		    Return
		  End If
		  
		  Self.mContentPackId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackName(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  If Self.mContentPackName = Value Then
		    Return
		  End If
		  
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.SpawnPoint
		  Return New Ark.SpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Tag = Beacon.NormalizeTag(Tag)
		  Var Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.RemoveAt(Idx)
		    Self.Modified = True
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.Add(Tag)
		    Self.mTags.Sort()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  If Self.mLabel = Value Then
		    Return
		  End If
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastUpdate(Assigns Value As Double)
		  If Self.mLastUpdate = Value Then
		    Return
		  End If
		  
		  Self.mLastUpdate = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(CreatureRef As Ark.BlueprintReference, Assigns Value As Double)
		  Value = Min(Abs(Value), 1.0)
		  
		  Var Exists As Boolean = Self.mLimits.HasBlueprint(CreatureRef)
		  
		  If Exists And Value = 1.0 Then
		    Self.mLimits.Remove(CreatureRef)
		    Self.Modified = True
		    Return
		  End If
		  
		  If Exists = False Or Self.mLimits.Value(CreatureRef, Self.LimitAttribute).DoubleValue <> Value Then
		    Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(Creature As Ark.Creature, Assigns Value As Double)
		  Value = Min(Abs(Value), 1.0)
		  
		  Var Exists As Boolean = Self.mLimits.HasBlueprint(Creature)
		  
		  If Exists And Value = 1.0 Then
		    Self.mLimits.Remove(Creature)
		    Self.Modified = True
		    Return
		  End If
		  
		  If Exists = False Or Self.mLimits.Value(Creature, Self.LimitAttribute).DoubleValue <> Value Then
		    Self.mLimits.Value(Creature, Self.LimitAttribute) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LimitsString(Assigns Value As String)
		  Try
		    Var Parsed As Variant = Beacon.ParseJSON(Value)
		    Var Manager As Ark.BlueprintAttributeManager = Ark.BlueprintAttributeManager.FromSaveData(Parsed)
		    If (Manager Is Nil) = False Then
		      Self.mLimits = Manager
		    ElseIf Parsed.IsNull = False And Parsed.Type = Variant.TypeObject And Parsed IsA Dictionary Then
		      Var Dict As Dictionary = Parsed
		      Manager = New Ark.BlueprintAttributeManager
		      For Each Entry As DictionaryEntry In Dict
		        Var Creature As Ark.Creature = Ark.ResolveCreature(Entry.Key.StringValue, "", "", Nil)
		        If (Creature Is Nil) = False Then
		          Manager.Value(Creature, Self.LimitAttribute) = Entry.Value.DoubleValue
		        End If
		      Next
		    End If
		    Self.mLimits = Manager
		    Self.Modified = True
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mode(Assigns Value As Integer)
		  If Self.mMode = Value Then
		    Return
		  End If
		  
		  Self.mMode = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableSpawnPoint
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  If Self.mPath = Value Then
		    Return
		  End If
		  
		  Self.mPath = Value
		  Self.mClassString = Ark.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveCreature(Creature As Ark.Creature)
		  Self.Limit(Creature) = 0
		  
		  For SetIdx As Integer = Self.mSets.LastIndex DownTo 0
		    Var MutableSet As Ark.MutableSpawnPointSet = Self.mSets(SetIdx).MutableVersion
		    For EntryIdx As Integer = MutableSet.LastIndex DownTo 0
		      If MutableSet.Entry(EntryIdx).Creature.CreatureId = Creature.CreatureId Then
		        MutableSet.Remove(EntryIdx)
		      End If
		    Next EntryIdx
		    If MutableSet.Count = 0 Then
		      Self.RemoveSet(MutableSet)
		    End If
		  Next SetIdx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveSet(Set As Ark.SpawnPointSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx > -1 Then
		    Self.mSets.RemoveAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  Self.ResizeTo(-1)
		  Self.ClearLimits()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mSets.ResizeTo(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(Index As Integer, Assigns Value As Ark.SpawnPointSet)
		  If Self.mSets(Index) <> Value Then
		    Self.mSets(Index) = Value.ImmutableVersion
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetsString(Assigns Value As String)
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Value)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var Children() As Variant = Parsed
		  Self.mSets.ResizeTo(-1)
		  For Each SaveData As Dictionary In Children
		    Var Set As Ark.SpawnPointSet = Ark.SpawnPointSet.FromSaveData(SaveData)
		    If Set <> Nil Then
		      Self.mSets.Add(Set)
		    End If
		  Next
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnPointId(Assigns Value As String)
		  If Self.mSpawnPointId = Value Then
		    Return
		  End If
		  
		  Self.mSpawnPointId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.Add(Tag)
		  Next
		  Self.mTags.Sort
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unpack(Dict As Dictionary)
		  Self.mLimits = New Ark.BlueprintAttributeManager
		  If Dict.HasKey("limits") Then
		    Try
		      Var Limits As Variant = Dict.Value("limits")
		      If IsNull(Limits) = False And Limits.Type = Variant.TypeObject And Limits.ObjectValue IsA Dictionary Then
		        Var LimitsDict As Dictionary = Dictionary(Limits.ObjectValue)
		        For Each Entry As DictionaryEntry In LimitsDict
		          Var CreatureRef As New Ark.BlueprintReference(Ark.BlueprintReference.KindCreature, Entry.Key.StringValue, "", "", "", "")
		          Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = Entry.Value.DoubleValue
		        Next
		      ElseIf IsNull(Limits) = False And Limits.IsArray And Limits.ArrayElementType = Variant.TypeObject Then
		        Var Members() As Dictionary = Limits.DictionaryArrayValue
		        For Each Limit As Dictionary In Members
		          Var MaxPercent As Double = Limit.FirstValue("maxPercentage", "max_percent", 1.0).DoubleValue
		          Var CreatureRef As Ark.BlueprintReference
		          If Limit.HasKey("creatureId") Then
		            CreatureRef = New Ark.BlueprintReference(Ark.BlueprintReference.KindCreature, Limit.Value("creatureId").StringValue, "", "", "", "")
		          ElseIf Limit.HasKey("creature") Then
		            CreatureRef = Ark.BlueprintReference.FromSaveData(Limit.Value("creature"))
		          End If
		          If (CreatureRef Is Nil) = False Then
		            Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = MaxPercent
		          End If
		        Next
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Unpacking limits")
		    End Try
		  End If
		  
		  Self.mSets.ResizeTo(-1)
		  If Dict.HasKey("sets") And Dict.Value("sets").IsNull = False Then
		    Var Sets() As Dictionary
		    Try
		      Sets = Dict.Value("sets").DictionaryArrayValue
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Unpacking spawn point sets value.")
		    End Try
		    
		    For Each PackedSet As Dictionary In Sets
		      Var Set As Ark.SpawnPointSet = Ark.SpawnPointSet.FromSaveData(PackedSet)
		      If (Set Is Nil) = False Then
		        Self.mSets.Add(Set)
		      End If
		    Next
		  ElseIf Dict.HasKey("groups") And Dict.Value("groups").IsNull = False Then
		    Var SpawnDicts() As Dictionary
		    Try
		      SpawnDicts = Dict.Value("groups").DictionaryArrayValue
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Unpacking spawn point groups value.")
		    End Try
		    
		    For Each SpawnDict As Dictionary In SpawnDicts
		      Var Creatures() As String
		      Var Arr As Variant = SpawnDict.Lookup("creatures", Nil)
		      If IsNull(Arr) = False And Arr.IsArray Then
		        Select Case Arr.ArrayElementType
		        Case Variant.TypeString
		          Creatures = Arr
		        Case Variant.TypeObject
		          Var Temp() As Variant = Arr
		          For Each Path As String In Temp
		            Creatures.Add(Path)
		          Next
		        End Select
		      End If
		      
		      Var Set As New Ark.MutableSpawnPointSet
		      Set.Label = SpawnDict.Lookup("label", "Untitled Spawn Set").StringValue
		      Set.SetId = SpawnDict.Lookup("group_id", Beacon.UUID.v4).StringValue
		      Set.RawWeight = SpawnDict.Lookup("weight", 0.1).DoubleValue
		      For Each Path As String In Creatures
		        Var Creature As Ark.Creature = Ark.ResolveCreature("", Path, "", Nil)
		        Set.Append(New Ark.MutableSpawnPointSetEntry(Creature))
		      Next
		      Self.mSets.Add(Set)
		    Next
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
