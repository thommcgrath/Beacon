#tag Class
Protected Class SpawnPointOverride
Implements Beacon.Countable,Beacon.NamedItem,Beacon.DisambiguationCandidate
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  If Self.mPointRef.IsResolved = False Then
		    Return Self.mAvailability
		  End If
		  
		  Return Ark.SpawnPoint(Self.mPointRef.Resolve()).Availability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Point As Ark.BlueprintReference, Mode As Integer)
		  Self.mPointRef = Point
		  Self.mMode = Mode
		  Self.mLimits = New Ark.BlueprintAttributeManager
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Point As Ark.SpawnPoint, Mode As Integer, IncludeContents As Boolean)
		  Self.Constructor(New Ark.BlueprintReference(Point), Mode)
		  Self.mAvailability = Point.Availability
		  
		  If IncludeContents = False Then
		    Return
		  End If
		  
		  Var SetBound As Integer = Point.Count - 1
		  For Idx As Integer = 0 To SetBound
		    Var Set As Ark.SpawnPointSet = Point.Set(Idx)
		    Self.mSets.Add(Set.ImmutableClone)
		  Next
		  
		  Self.mLimits = Ark.BlueprintAttributeManager.FromSaveData(Point.LimitsString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.SpawnPointOverride)
		  If (Source.mLimits Is Nil) = False Then
		    Self.mLimits = Source.mLimits.Clone
		  Else
		    Self.mLimits = New Ark.BlueprintAttributeManager
		  End If
		  Self.mMode = Source.mMode
		  Self.mModified = Source.mModified
		  Self.mPointRef = New Ark.BlueprintReference(Source.mPointRef)
		  
		  Self.mSets.ResizeTo(Source.mSets.LastIndex)
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    Self.mSets(Idx) = New Ark.SpawnPointSet(Source.mSets(Idx))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationId() As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mPointRef.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.Availability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationSuffix(Mask As UInt64) As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Ark.Maps.LabelForMask(Self.Availability And Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromLegacy(SaveData As Dictionary) As Ark.SpawnPointOverride
		  Try
		    Var SpawnPointRef As Ark.BlueprintReference
		    If SaveData.HasKey("Reference") Then
		      SpawnPointRef = Ark.BlueprintReference.FromSaveData(SaveData.Value("Reference"))
		    ElseIf SaveData.HasKey("spawnPointId") Then
		      SpawnPointRef = New Ark.BlueprintReference(Ark.BlueprintReference.KindSpawnPoint, SaveData.Value("spawnPointId").StringValue, "", "", "", "")
		    Else
		      SpawnPointRef = New Ark.BlueprintReference(Ark.BlueprintReference.KindSpawnPoint, SaveData.Lookup("UUID", "").StringValue, SaveData.Lookup("Path", "").StringValue, SaveData.Lookup("Class", "").StringValue, "", "")
		    End If
		    If SpawnPointRef Is Nil Then
		      Return Nil
		    End If
		    
		    Var Mode As Integer
		    If SaveData.HasKey("mode") Then
		      Mode = SaveData.Value("mode").IntegerValue
		    ElseIf SaveData.HasKey("Mode") Then
		      Mode = SaveData.Value("Mode").IntegerValue
		    Else
		      Return Nil
		    End If
		    
		    Var Override As New Ark.SpawnPointOverride(SpawnPointRef, Mode)
		    
		    Var LimitsVar As Variant = SaveData.FirstValue("limits", "Limits", Nil)
		    If LimitsVar.IsNull = False Then
		      Var Manager As Ark.BlueprintAttributeManager = Ark.BlueprintAttributeManager.FromSaveData(LimitsVar)
		      If (Manager Is Nil) = False Then
		        // A reference manager
		        Var References() As Ark.BlueprintReference = Manager.References
		        For Each Reference As Ark.BlueprintReference In References
		          If Reference.IsCreature = False Then
		            Continue
		          End If
		          
		          Var MaxPercentage As Double = Manager.Value(Reference, LimitAttribute)
		          Override.mLimits.Value(Reference, LimitAttribute) = MaxPercentage
		        Next
		      ElseIf LimitsVar.Type = Variant.TypeObject And LimitsVar.ObjectValue IsA Dictionary Then
		        // A dictionary
		        Var Limits As Dictionary = Dictionary(LimitsVar.ObjectValue)
		        For Each Entry As DictionaryEntry In Limits
		          Var Reference As Ark.BlueprintReference
		          If Beacon.UUID.Validate(Entry.Key.StringValue) Then
		            Reference = New Ark.BlueprintReference(Ark.BlueprintReference.KindCreature, Entry.Key.StringValue, "", "", "", "")
		          Else
		            Reference = New Ark.BlueprintReference(Ark.BlueprintReference.KindCreature, "", Entry.Key.StringValue, "", "", "")
		          End If
		          
		          Override.mLimits.Value(Reference, LimitAttribute) = Entry.Value
		        Next
		      Else
		        // Probably an array of dictionaries
		        Var Limits() As Variant = LimitsVar
		        For Each Limit As Dictionary In Limits
		          Var CreatureId As String = Limit.Value("creatureId")
		          Var MaxPercentage As Double = Limit.Value("maxPercentage")
		          Var Reference As New Ark.BlueprintReference(Ark.BlueprintReference.KindCreature, CreatureId, "", "", "", "")
		          Override.mLimits.Value(Reference, LimitAttribute) = MaxPercentage
		        Next
		      End If
		    End If
		    
		    Var SetSaveData() As Variant
		    If SaveData.HasKey("sets") Then
		      SetSaveData = SaveData.Value("sets")
		    ElseIf SaveData.HasKey("Sets") Then
		      SetSaveData = SaveData.Value("Sets")
		    End If
		    For Each SetDict As Dictionary In SetSaveData
		      Var Set As Ark.SpawnPointSet = Ark.SpawnPointSet.FromSaveData(SetDict)
		      If Set <> Nil Then
		        Override.mSets.Add(Set)
		      End If
		    Next
		    
		    Override.Modified = False
		    Return Override
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Ark.SpawnPointOverride
		  If SaveData.HasAllKeys("definition", "mode") = False Then
		    Return Nil
		  End If
		  
		  Var Definition As Ark.BlueprintReference = Ark.BlueprintReference.FromSaveData(SaveData.Value("definition"))
		  Var Mode As Integer = SaveData.Value("mode")
		  Var Override As New Ark.SpawnPointOverride(Definition, Mode)
		  
		  If SaveData.HasKey("limits") Then
		    Var Limits As Ark.BlueprintAttributeManager = Ark.BlueprintAttributeManager.FromSaveData(SaveData.Value("limits"))
		    If (Limits Is Nil) = False Then
		      Override.mLimits = Limits
		    End If
		  End If
		  
		  If SaveData.HasKey("sets") Then
		    Var SetDicts() As Variant = SaveData.Value("sets")
		    For Each SetDict As Dictionary In SetDicts
		      Var SpawnSet As Ark.SpawnPointSet = Ark.SpawnPointSet.FromSaveData(SetDict)
		      If (SpawnSet Is Nil) = False Then
		        Override.mSets.Add(SpawnSet)
		      End If
		    Next
		  End If
		  
		  Override.mAvailability = SaveData.Value("availability")
		  
		  Return Override
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetUniqueKey(Point As Ark.SpawnPoint, Mode As Integer) As String
		  If Point Is Nil Then
		    Return ""
		  End If
		  
		  Return Point.ClassString.Lowercase + ":" + Mode.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Return EncodeBase64MBS(Beacon.GenerateJSON(Self.SaveData, False))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As Ark.SpawnPointOverride
		  Return New Ark.SpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.SpawnPointOverride
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As Ark.SpawnPointSet) As Integer
		  If Set Is Nil Then
		    Return -1
		  End If
		  
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    If Self.mSets(Idx).SetId = Set.SetId Then
		      Return Idx
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Sets() As Variant
		  Sets.ResizeTo(Self.mSets.LastIndex)
		  For Idx As Integer = 0 To Sets.LastIndex
		    Sets(Idx) = Self.mSets(Idx)
		  Next
		  Return New Beacon.GenericIterator(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Var Label As String = Self.mPointRef.Label
		  If Label.IsEmpty Then
		    Var Point As Ark.Blueprint = Self.mPointRef.Resolve()
		    If (Point Is Nil) = False Then
		      Label = Point.Label
		    End If
		  End If
		  Return Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(CreatureRef As Ark.BlueprintReference) As Double
		  If Self.mLimits.HasBlueprint(CreatureRef) Then
		    Return Self.mLimits.Value(CreatureRef, Self.LimitAttribute)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(Creature As Ark.Creature) As Double
		  If Self.mLimits.HasBlueprint(Creature) Then
		    Return Self.mLimits.Value(Creature, Self.LimitAttribute)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitedCreatureRefs() As Ark.BlueprintReference()
		  Var References() As Ark.BlueprintReference
		  If (Self.mLimits Is Nil) = False Then
		    References = Self.mLimits.References
		  End If
		  Return References
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitedCreatures() As Ark.Creature()
		  Var Creatures() As Ark.Creature
		  Var References() As Ark.BlueprintReference = Self.mLimits.References
		  For Each Reference As Ark.BlueprintReference In References
		    Var Creature As Ark.Blueprint = Reference.Resolve()
		    If Creature Is Nil Or (Creature IsA Ark.Creature) = False Then
		      Continue
		    End If
		    Creatures.Add(Ark.Creature(Creature))
		  Next
		  Return Creatures
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
		  
		  For Each Set As Ark.SpawnPointSet In Self.mSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Value = False Then
		    For Each Set As Ark.SpawnPointSet In Self.mSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As Ark.MutableSpawnPointOverride
		  Return New Ark.MutableSpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableSpawnPointOverride
		  Return New Ark.MutableSpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("definition") = Self.mPointRef.SaveData
		  Dict.Value("mode") = Self.mMode
		  If (Self.mLimits Is Nil) = False And Self.mLimits.Count > 0 Then
		    Dict.Value("limits") = Self.mLimits.SaveData
		  End If
		  If Self.mSets.Count > 0 Then
		    Var SetArray() As Dictionary
		    For Each Set As Ark.SpawnPointSet In Self.mSets
		      SetArray.Add(Set.SaveData(False))
		    Next
		    Dict.Value("sets") = SetArray
		  End If
		  If Self.mPointRef.IsResolved Then
		    Var Blueprint As Ark.Blueprint = Self.mPointRef.Resolve() // Parameters don't matter because it's already been resolved
		    Var Point As Ark.SpawnPoint = Ark.SpawnPoint(Blueprint)
		    Dict.Value("availability") = Point.Availability
		  Else
		    Dict.Value("availability") = Self.mAvailability
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAt(Idx As Integer) As Ark.SpawnPointSet
		  If Idx = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mSets(Idx).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPoint(Pack As Beacon.StringList = Nil, Options As Integer = 3) As Ark.SpawnPoint
		  Var Blueprint As Ark.Blueprint = Self.mPointRef.Resolve(Pack, Options)
		  If Blueprint Is Nil Or (Blueprint IsA Ark.SpawnPoint) = False Then
		    Return Nil
		  End If
		  
		  Return Ark.SpawnPoint(Blueprint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointId() As String
		  Return Self.mPointRef.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointReference() As Ark.BlueprintReference
		  Return Self.mPointRef
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueKey() As String
		  Var ClassString As String = Self.mPointRef.ClassString
		  If ClassString.IsEmpty Then
		    Var Point As Ark.Blueprint = Self.mPointRef.Resolve()
		    If (Point Is Nil) = False Then
		      ClassString = Point.ClassString
		    End If
		  End If
		  Return ClassString.Lowercase + ":" + Self.mMode.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLimits As Ark.BlueprintAttributeManager
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPointRef As Ark.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSets() As Ark.SpawnPointSet
	#tag EndProperty


	#tag Constant, Name = LimitAttribute, Type = String, Dynamic = False, Default = \"limit", Scope = Protected
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
