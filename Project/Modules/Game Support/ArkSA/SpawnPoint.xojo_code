#tag Class
Protected Class SpawnPoint
Implements ArkSA.Blueprint,Beacon.Countable,Beacon.DisambiguationCandidate
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
		  Self.mLimits = New ArkSA.BlueprintAttributeManager
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
		  Self.mPendingSetsString = Source.mPendingSetsString
		  Self.mPendingLimitsString = Source.mPendingLimitsString
		  
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
		Function Contains(Creature As ArkSA.Creature) As Boolean
		  Self.LoadPendingLimits()
		  Self.LoadPendingSets()
		  
		  If Creature Is Nil Then
		    Return False
		  End If
		  
		  If Self.mLimits.HasBlueprint(Creature.BlueprintId) Then
		    Return True
		  End If
		  
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    If Set.Contains(Creature) Then
		      Return True
		    End If
		  Next
		End Function
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
		  Self.LoadPendingSets()
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
		Function DisambiguationId() As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mSpawnPointId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationSuffix(Mask As UInt64) As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return ArkSA.Maps.LabelForMask(Self.Availability And Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindCreature(CreatureId As String) As ArkSA.BlueprintReference
		  Self.LoadPendingSets()
		  Self.LoadPendingLimits()
		  
		  If Self.mLimits.HasBlueprint(CreatureId) Then
		    Return Self.mLimits.Reference(CreatureId)
		  End If
		  
		  For Each SpawnSet As ArkSA.SpawnPointSet In Self.mSets
		    Var Reference As ArkSA.BlueprintReference = SpawnSet.FindCreature(CreatureId)
		    If (Reference Is Nil) = False Then
		      Return Reference
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPoint
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As ArkSA.SpawnPointSet) As Integer
		  Self.LoadPendingSets()
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
		  
		  Self.LoadPendingSets()
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
		Function Limit(CreatureRef As ArkSA.BlueprintReference) As Double
		  Self.LoadPendingLimits()
		  
		  If Self.mLimits.HasBlueprint(CreatureRef) Then
		    Return Self.mLimits.Value(CreatureRef, Self.LimitAttribute)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(Creature As ArkSA.Creature) As Double
		  Self.LoadPendingLimits()
		  
		  If Self.mLimits.HasBlueprint(Creature) Then
		    Return Self.mLimits.Value(Creature, Self.LimitAttribute)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limits() As Dictionary
		  Self.LoadPendingLimits()
		  
		  Var Limits As New Dictionary
		  Var References() As ArkSA.BlueprintReference = Self.mLimits.References
		  For Each Reference As ArkSA.BlueprintReference In References
		    If Reference.IsCreature = False Then
		      Continue
		    End If
		    
		    Var Limit As Double = Self.mLimits.Value(Reference, Self.LimitAttribute)
		    Limits.Value(ArkSA.Creature(Reference.Resolve)) = Limit
		  Next
		  Return Limits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitsString() As String
		  If Self.mPendingLimitsString.IsEmpty = False Then
		    Return Self.mPendingLimitsString
		  End If
		  
		  Try
		    Return Beacon.GenerateJSON(Self.mLimits.SaveData, False)
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadPendingLimits()
		  If Self.mPendingLimitsString.IsEmpty Then
		    Return
		  End If
		  
		  Try
		    Self.mLimits = ArkSA.BlueprintAttributeManager.FromSaveData(Beacon.ParseJSON(Self.mPendingLimitsString))
		    If Self.mLimits Is Nil Then
		      Self.mLimits = New ArkSA.BlueprintAttributeManager
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.mPendingLimitsString = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LoadPendingSets()
		  If Self.mPendingSetsString.IsEmpty Then
		    Return
		  End If
		  
		  Try
		    Var Names() As String
		    Var Children() As Variant = Beacon.ParseJSON(Self.mPendingSetsString)
		    Self.mSets.ResizeTo(-1)
		    For Each SaveData As Dictionary In Children
		      Var Set As ArkSA.SpawnPointSet = ArkSA.SpawnPointSet.FromSaveData(SaveData)
		      If Set Is Nil Then
		        Continue
		      End If
		      
		      Var Label As String = Set.Label
		      Var AdjustedLabel As String = Beacon.FindUniqueLabel(Label, Names)
		      If AdjustedLabel <> Label Then
		        Var Mutable As New ArkSA.MutableSpawnPointSet(Set)
		        Mutable.Label = AdjustedLabel
		        Set = New ArkSA.SpawnPointSet(Mutable)
		      End If
		      Names.Add(AdjustedLabel)
		      Self.mSets.Add(Set)
		    Next
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.mPendingSetsString = ""
		End Sub
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
		Sub Pack(Dict As Dictionary, ForAPI As Boolean)
		  Self.LoadPendingSets()
		  Self.LoadPendingLimits()
		  
		  Var Sets() As Dictionary
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    Sets.Add(Set.SaveData(ForAPI))
		  Next
		  Dict.Value("sets") = Sets
		  
		  Var Limits() As Dictionary
		  Var References() As ArkSA.BlueprintReference = Self.mLimits.References
		  For Each Reference As ArkSA.BlueprintReference In References
		    If Reference.IsCreature = False Then
		      Continue
		    End If
		    
		    Var Limit As Double = Self.mLimits.Value(Reference, Self.LimitAttribute)
		    If ForAPI Then
		      Limits.Add(New Dictionary("creatureId": Reference.BlueprintId, "maxPercentage": Limit))
		    Else
		      Limits.Add(New Dictionary("creature": Reference.SaveData, "maxPercentage": Limit))
		    End If
		  Next
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
		Function Set(Index As Integer) As ArkSA.SpawnPointSet
		  Self.LoadPendingSets()
		  Return New ArkSA.SpawnPointSet(Self.mSets(Index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetsString() As String
		  If Self.mPendingSetsString.IsEmpty = False Then
		    Return Self.mPendingSetsString
		  End If
		  
		  Var Objects() As Variant
		  For Each Set As ArkSA.SpawnPointSet In Self.mSets
		    If (Set Is Nil) = False Then
		      Objects.Add(Set.SaveData(False))
		    End If
		  Next
		  Try
		    Return Beacon.GenerateJSON(Objects, False)
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
		Protected mLimits As ArkSA.BlueprintAttributeManager
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
		Protected mPendingLimitsString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPendingSetsString As String
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
