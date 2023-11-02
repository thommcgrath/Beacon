#tag Class
Protected Class SpawnPointOverride
Implements ArkSA.Prunable
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.SpawnPointOverride)
		  Self.mLimits = Source.mLimits.Clone
		  Self.mMode = Source.mMode
		  Self.mModified = Source.mModified
		  Self.mPointRef = New ArkSA.BlueprintReference(Source.mPointRef)
		  
		  Self.mSets.ResizeTo(Source.mSets.LastIndex)
		  For Idx As Integer = 0 To Self.mSets.LastIndex
		    Self.mSets(Idx) = New ArkSA.SpawnPointSet(Source.mSets(Idx))
		  Next
		End Sub
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
		    Override.mLimits = ArkSA.BlueprintAttributeManager.FromSaveData(SaveData.Value("limits"))
		  End If
		  
		  If SaveData.HasKey("sets") Then
		    Var SetDicts() As Variant = SaveData.Value("sets")
		    For Each SetDict As Dictionary In SetDicts
		      Var SpawnSet As ArkSA.SpawnPointSet = ArkSA.SpawnPointSet.FromSaveData(SetDict)
		      If (SpawnSet Is Nil) = False Then
		        SetDicts.Add(SpawnSet)
		      End If
		    Next
		  End If
		  
		  Return Override
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
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  // Part of the ArkSA.Prunable interface.
		  
		  For Idx As Integer = Self.mSets.LastIndex DownTo 0
		    Var Mutable As New ArkSA.MutableSpawnPointSet(Self.mSets(Idx))
		    Mutable.PruneUnknownContent(ContentPackIds)
		    If Mutable.Count = 0 Then
		      Self.mSets.RemoveAt(Idx)
		      Self.Modified = True
		    End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("definition") = Self.mPointRef.SaveData
		  Dict.Value("mode") = Self.mMode
		  If Self.mLimits.Count > 0 Then
		    Dict.Value("limits") = Self.mLimits.SaveData
		  End If
		  If Self.mSets.Count > 0 Then
		    Var SetArray() As Dictionary
		    For Each Set As ArkSA.SpawnPointSet In Self.mSets
		      SetArray.Add(Set.SaveData)
		    Next
		    Dict.Value("sets") = SetArray
		  End If
		  Return Dict
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
		  Return Self.mPointRef.ClassString.Lowercase + ":" + Self.mMode.ToString(Locale.Raw, "0")
		End Function
	#tag EndMethod


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
		#tag ViewProperty
			Name="mPointRef"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
