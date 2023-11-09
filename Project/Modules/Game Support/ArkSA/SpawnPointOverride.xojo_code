#tag Class
Protected Class SpawnPointOverride
Implements Beacon.Countable,Beacon.NamedItem
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  If Self.mPointRef.IsResolved = False Then
		    Return Self.mAvailability
		  End If
		  
		  Return ArkSA.SpawnPoint(Self.mPointRef.Resolve()).Availability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Point As ArkSA.BlueprintReference, Mode As Integer)
		  Self.mPointRef = Point
		  Self.mMode = Mode
		  Self.mLimits = New ArkSA.BlueprintAttributeManager
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Point As ArkSA.SpawnPoint, Mode As Integer)
		  Self.Constructor(New ArkSA.BlueprintReference(Point), Mode)
		  Self.mAvailability = Point.Availability
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.SpawnPointOverride)
		  If (Source.mLimits Is Nil) = False Then
		    Self.mLimits = Source.mLimits.Clone
		  Else
		    Self.mLimits = New ArkSA.BlueprintAttributeManager
		  End If
		  Self.mMode = Source.mMode
		  Self.mModified = Source.mModified
		  Self.mPointRef = New ArkSA.BlueprintReference(Source.mPointRef)
		  Self.mAvailability = Source.mAvailability
		  
		  Self.mSets.ResizeTo(Source.mSets.LastIndex)
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    Self.mSets(Idx) = New ArkSA.SpawnPointSet(Source.mSets(Idx))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromLegacy(SaveData As Dictionary) As ArkSA.SpawnPointOverride
		  Try
		    Var SpawnPointRef As ArkSA.BlueprintReference
		    If SaveData.HasKey("Reference") Then
		      SpawnPointRef = ArkSA.BlueprintReference.FromSaveData(SaveData.Value("Reference"))
		    ElseIf SaveData.HasKey("spawnPointId") Then
		      SpawnPointRef = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindSpawnPoint, SaveData.Value("spawnPointId").StringValue, "", "", "", "", "")
		    Else
		      SpawnPointRef = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindSpawnPoint, SaveData.Lookup("UUID", "").StringValue, SaveData.Lookup("Path", "").StringValue, SaveData.Lookup("Class", "").StringValue, "", "", "")
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
		    
		    Var Override As New ArkSA.SpawnPointOverride(SpawnPointRef, Mode)
		    
		    Var LimitsVar As Variant = SaveData.FirstValue("limits", "Limits", Nil)
		    If LimitsVar.IsNull = False Then
		      Var Manager As ArkSA.BlueprintAttributeManager = ArkSA.BlueprintAttributeManager.FromSaveData(LimitsVar)
		      If (Manager Is Nil) = False Then
		        // A reference manager
		        Var References() As ArkSA.BlueprintReference = Manager.References
		        For Each Reference As ArkSA.BlueprintReference In References
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
		          Var Reference As ArkSA.BlueprintReference
		          If Beacon.UUID.Validate(Entry.Key.StringValue) Then
		            Reference = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, Entry.Key.StringValue, "", "", "", "", "")
		          Else
		            Reference = New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, "", Entry.Key.StringValue, "", "", "", "")
		          End If
		          
		          Override.mLimits.Value(Reference, LimitAttribute) = Entry.Value
		        Next
		      Else
		        // Probably an array of dictionaries
		        Var Limits() As Variant = LimitsVar
		        For Each Limit As Dictionary In Limits
		          Var CreatureId As String = Limit.Value("creatureId")
		          Var MaxPercentage As Double = Limit.Value("maxPercentage")
		          Var Reference As New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindCreature, CreatureId, "", "", "", "", "")
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
		      Var Set As ArkSA.SpawnPointSet = ArkSA.SpawnPointSet.FromSaveData(SetDict)
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
		Shared Function FromSaveData(SaveData As Dictionary) As ArkSA.SpawnPointOverride
		  If SaveData.HasAllKeys("definition", "mode") = False Then
		    Return Nil
		  End If
		  
		  Var Definition As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(SaveData.Value("definition"))
		  Var Mode As Integer = SaveData.Value("mode")
		  Var Override As New ArkSA.SpawnPointOverride(Definition, Mode)
		  
		  If SaveData.HasKey("limits") Then
		    Var Limits As ArkSA.BlueprintAttributeManager = ArkSA.BlueprintAttributeManager.FromSaveData(SaveData.Value("limits"))
		    If (Limits Is Nil) = False Then
		      Override.mLimits = Limits
		    End If
		  End If
		  
		  If SaveData.HasKey("sets") Then
		    Var SetDicts() As Variant = SaveData.Value("sets")
		    For Each SetDict As Dictionary In SetDicts
		      Var SpawnSet As ArkSA.SpawnPointSet = ArkSA.SpawnPointSet.FromSaveData(SetDict)
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
		Shared Function GetUniqueKey(Point As ArkSA.SpawnPoint, Mode As Integer) As String
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
		Function ImmutableCopy() As ArkSA.SpawnPointOverride
		  Return New ArkSA.SpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPointOverride
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As ArkSA.SpawnPointSet) As Integer
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
		    Var Point As ArkSA.Blueprint = Self.mPointRef.Resolve()
		    If (Point Is Nil) = False Then
		      Label = Point.Label
		    End If
		  End If
		  Return Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(CreatureRef As ArkSA.BlueprintReference) As Double
		  If Self.mLimits.HasBlueprint(CreatureRef) Then
		    Return Self.mLimits.Value(CreatureRef, Self.LimitAttribute)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Limit(Creature As ArkSA.Creature) As Double
		  If Self.mLimits.HasBlueprint(Creature) Then
		    Return Self.mLimits.Value(Creature, Self.LimitAttribute)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitedCreatureRefs() As ArkSA.BlueprintReference()
		  Var References() As ArkSA.BlueprintReference
		  If (Self.mLimits Is Nil) = False Then
		    References = Self.mLimits.References
		  End If
		  Return References
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LimitedCreatures() As ArkSA.Creature()
		  Var Creatures() As ArkSA.Creature
		  Var References() As ArkSA.BlueprintReference = Self.mLimits.References
		  For Each Reference As ArkSA.BlueprintReference In References
		    Var Creature As ArkSA.Blueprint = Reference.Resolve()
		    If Creature Is Nil Or (Creature IsA ArkSA.Creature) = False Then
		      Continue
		    End If
		    Creatures.Add(ArkSA.Creature(Creature))
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
		  
		  If Value = False Then
		    For Each Set As ArkSA.SpawnPointSet In Self.mSets
		      Set.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As ArkSA.MutableSpawnPointOverride
		  Return New ArkSA.MutableSpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableSpawnPointOverride
		  Return New ArkSA.MutableSpawnPointOverride(Self)
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
		    For Each Set As ArkSA.SpawnPointSet In Self.mSets
		      SetArray.Add(Set.SaveData)
		    Next
		    Dict.Value("sets") = SetArray
		  End If
		  If Self.mPointRef.IsResolved Then
		    Var Blueprint As ArkSA.Blueprint = Self.mPointRef.Resolve() // Parameters don't matter because it's already been resolved
		    Var Point As ArkSA.SpawnPoint = ArkSA.SpawnPoint(Blueprint)
		    Dict.Value("availability") = Point.Availability
		  Else
		    Dict.Value("availability") = Self.mAvailability
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAt(Idx As Integer) As ArkSA.SpawnPointSet
		  If Idx = -1 Then
		    Return Nil
		  End If
		  
		  Return Self.mSets(Idx).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointId() As String
		  Return Self.mPointRef.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnPointReference() As ArkSA.BlueprintReference
		  Return Self.mPointRef
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UniqueKey() As String
		  Var ClassString As String = Self.mPointRef.ClassString
		  If ClassString.IsEmpty Then
		    Var Point As ArkSA.Blueprint = Self.mPointRef.Resolve()
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
		Protected mLimits As ArkSA.BlueprintAttributeManager
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPointRef As ArkSA.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSets() As ArkSA.SpawnPointSet
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
