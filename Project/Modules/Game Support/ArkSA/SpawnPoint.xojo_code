#tag Class
Protected Class SpawnPoint
Implements ArkSA.Blueprint,Beacon.Countable
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintId() As String
		  Return Self.mSpawnPointId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return ArkSA.CategorySpawnPoints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ArkSA.SpawnPoint
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.SpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = ArkSA.Maps.UniversalMask
		  Self.mLimits = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.SpawnPoint)
		  Self.Constructor()
		  
		  Self.mSpawnPointId = Source.mSpawnPointId
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mClassString = Source.mClassString
		  Self.mLabel = Source.mLabel
		  Self.mContentPackId = Source.mContentPackId
		  Self.mContentPackName = Source.mContentPackName
		  Self.mModified = Source.mModified
		  Self.mLimits = Source.mLimits.Clone
		  Self.mMode = Source.mMode
		  Self.mLastUpdate = Source.mLastUpdate
		  
		  Self.mSets.ResizeTo(Source.mSets.LastIndex)
		  For I As Integer = Source.mSets.FirstRowIndex To Source.mSets.LastIndex
		    Self.mSets(I) = Source.mSets(I).ImmutableVersion
		  Next
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Add(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(BlueprintId As String, Path As String, ClassString As String) As ArkSA.SpawnPoint
		  Var SpawnPoint As New ArkSA.SpawnPoint
		  SpawnPoint.mContentPackId = ArkSA.UserContentPackId
		  SpawnPoint.mContentPackName = ArkSA.UserContentPackName
		  
		  If BlueprintId.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "BeaconSpawn_NoData_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = "BeaconSpawn_" + BlueprintId + "_C"
		    End If
		    Path = ArkSA.UnknownBlueprintPath("SpawnPoints", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = ArkSA.ClassStringFromPath(Path)
		  End If
		  If BlueprintId.IsEmpty Then
		    BlueprintId = Beacon.UUID.v5(SpawnPoint.mContentPackId.Lowercase + ":" + Path.Lowercase)
		  End If
		  
		  SpawnPoint.mClassString = ClassString
		  SpawnPoint.mPath = Path
		  SpawnPoint.mSpawnPointId = BlueprintId
		  SpawnPoint.mLabel = ArkSA.LabelFromClassString(ClassString)
		  Return SpawnPoint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As ArkSA.SpawnPoint
		  Try
		    Var SpawnPoint As ArkSA.SpawnPoint
		    If Dict.HasKey("spawnPointId") Then
		      SpawnPoint = ArkSA.ResolveSpawnPoint(Dict.Value("spawnPointId").StringValue, "", "", Nil)
		    ElseIf Dict.HasKey("Reference") Then
		      Var Reference As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(Dict.Value("Reference"))
		      If Reference Is Nil Then
		        Return Nil
		      End If
		      SpawnPoint = ArkSA.SpawnPoint(Reference.Resolve)
		    Else
		      SpawnPoint = ArkSA.ResolveSpawnPoint(Dict, "UUID", "Path", "Class", Nil)
		    End If
		    
		    SpawnPoint = New ArkSA.SpawnPoint(SpawnPoint)
		    SpawnPoint.mSets.ResizeTo(-1)
		    
		    If Dict.HasKey("limits") Then
		      Var Limits() As Variant = Dict.Value("limits")
		      For Each Limit As Dictionary In Limits
		        Var CreatureId As String = Limit.Value("creatureId")
		        Var MaxPercentage As Double = Limit.Value("maxPercentage")
		        SpawnPoint.mLimits.Value(CreatureId) = MaxPercentage
		      Next
		    ElseIf Dict.HasKey("Limits") Then
		      Var Manager As ArkSA.BlueprintAttributeManager = ArkSA.BlueprintAttributeManager.FromSaveData(Dict.Value("Limits"))
		      If (Manager Is Nil) = False Then
		        Var References() As ArkSA.BlueprintReference = Manager.References
		        For Each Reference As ArkSA.BlueprintReference In References
		          If Reference.IsCreature = False Then
		            Continue
		          End If
		          
		          Var MaxPercentage As Double = Manager.Value(Reference, LimitAttribute)
		          SpawnPoint.mLimits.Value(Reference.BlueprintId) = MaxPercentage
		        Next
		      Else
		        Var Limits As Dictionary = Dict.Value("Limits")
		        For Each Entry As DictionaryEntry In Limits
		          Var CreatureId As String
		          If Beacon.UUID.Validate(Entry.Key.StringValue) Then
		            CreatureId = Entry.Key
		          Else
		            Var CreaturePath As String = Entry.Key
		            Var Creature As ArkSA.Creature = ArkSA.ResolveCreature("", CreaturePath, "", Nil)
		            If (Creature Is Nil) = False Then
		              CreatureId = Creature.CreatureId
		            End If
		          End If
		          
		          If CreatureId.IsEmpty = False Then
		            SpawnPoint.mLimits.Value(CreatureId) = Entry.Value
		          End If
		        Next
		      End If
		    End If
		    
		    Var SetSaveData() As Variant
		    If Dict.HasKey("sets") Then
		      SetSaveData = Dict.Value("sets")
		    ElseIf Dict.HasKey("Sets") Then
		      SetSaveData = Dict.Value("Sets")
		    End If
		    For Each SetDict As Dictionary In SetSaveData
		      Var Set As ArkSA.SpawnPointSet = ArkSA.SpawnPointSet.FromSaveData(SetDict)
		      If Set <> Nil Then
		        SpawnPoint.mSets.Add(Set)
		      End If
		    Next
		    
		    If Dict.HasKey("mode") Then
		      SpawnPoint.mMode = Dict.Value("mode").IntegerValue
		    ElseIf Dict.HasKey("Mode") Then
		      SpawnPoint.mMode = Dict.Value("Mode").IntegerValue
		    End If
		    
		    SpawnPoint.Modified = False
		    Return SpawnPoint
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPoint
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As ArkSA.SpawnPointSet) As Integer
		  For I As Integer = 0 To Self.mSets.LastIndex
		    If Self.mSets(I) = Set Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Sets() As Variant
		  Sets.ResizeTo(Self.mSets.LastIndex)
		  For I As Integer = 0 To Self.mSets.LastIndex
		    Sets(I) = Self.mSets(I)
		  Next
		  Return New Beacon.GenericIterator(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(Creature As ArkSA.Creature) As Double
		  If Creature Is Nil Then
		    Return 1.0
		  End If
		  
		  Return Self.Limit(Creature.CreatureId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(CreatureId As String) As Double
		  If Self.mLimits.HasKey(CreatureId) Then
		    Return Self.mLimits.Value(CreatureId)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limits(ResolveBlueprints As Boolean = True) As Dictionary
		  Var Limits As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mLimits
		    Var CreatureId As String = Entry.Key
		    Var MaxPercentage As Double = Entry.Value
		    If ResolveBlueprints Then
		      Var Creature As ArkSA.Creature = ArkSA.ResolveCreature(CreatureId, "", "", Nil)
		      If (Creature Is Nil) = False Then
		        Limits.Value(Creature) = MaxPercentage
		      End If
		    Else
		      Limits.Value(CreatureId) = MaxPercentage
		    End If
		  Next
		  Return Limits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitsString(Pretty As Boolean = False) As String
		  Try
		    Return Beacon.GenerateJSON(Self.mLimits, Pretty)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As Integer
		  Return Self.mMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Set As ArkSA.SpawnPointSet In Self.mSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As ArkSA.MutableSpawnPoint
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.MutableSpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableSpawnPoint
		  Return New ArkSA.MutableSpawnPoint(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "SpawnPointId" )  Function ObjectID() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mSpawnPointId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  Var Sets() As Dictionary
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    Sets.Add(Set.SaveData)
		  Next
		  
		  Var Limits() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mLimits
		    Var Limit As New Dictionary
		    Limit.Value("creatureId") = Entry.Key
		    Limit.Value("maxPercentage") = Entry.Value
		    Limits.Add(Limit)
		  Next
		  
		  Dict.Value("sets") = Sets
		  Dict.Value("limits") = Limits
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Children() As Variant
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    Children.Add(Set.SaveData)
		  Next
		  
		  Var Keys As New Dictionary
		  Keys.Value("spawnPointId") = Self.mSpawnPointId
		  Keys.Value("mode") = Self.Mode
		  If Children.LastIndex > -1 Then
		    Keys.Value("sets") = Children
		  End If
		  If Self.mLimits.KeyCount > 0 Then
		    Var Limits() As Dictionary
		    For Each Entry As DictionaryEntry In Self.mLimits
		      Var Limit As New Dictionary
		      Limit.Value("creatureId") = Entry.Key
		      Limit.Value("maxPercentage") = Entry.Value
		      Limits.Add(Limit)
		    Next
		    Keys.Value("limits") = Limits
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Set(Index As Integer) As ArkSA.SpawnPointSet
		  Return New ArkSA.SpawnPointSet(Self.mSets(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetsString(Pretty As Boolean = False) As String
		  Var Objects() As Variant
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    If Set <> Nil Then
		      Objects.Add(Set.SaveData)
		    End If
		  Next
		  Try
		    Return Beacon.GenerateJSON(Objects, Pretty)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointId() As String
		  Return Self.mSpawnPointId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  // Part of the ArkSA.Blueprint interface.
		  
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastIndex)
		  For I As Integer = 0 To Self.mTags.LastIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueKey() As String
		  Return Self.UniqueKey(Self.SpawnPointId, Self.Mode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function UniqueKey(SpawnPointId As String, Mode As Integer) As String
		  Var Key As String = SpawnPointId
		  Select Case Mode
		  Case ArkSA.SpawnPoint.ModeOverride
		    Key = Key + ":Override"
		  Case ArkSA.SpawnPoint.ModeAppend
		    Key = Key + ":Append"
		  Case ArkSA.SpawnPoint.ModeRemove
		    Key = Key + ":Remove"
		  End Select
		  Return Key
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAlternateLabel As NullableString
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastUpdate As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLimits As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSets() As ArkSA.SpawnPointSet
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSpawnPointId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As String
	#tag EndProperty


	#tag Constant, Name = LimitAttribute, Type = String, Dynamic = False, Default = \"Limit", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ModeAppend, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeOverride, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeRemove, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
