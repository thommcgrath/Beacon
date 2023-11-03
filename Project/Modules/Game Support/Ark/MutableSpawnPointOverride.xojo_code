#tag Class
Protected Class MutableSpawnPointOverride
Inherits Ark.SpawnPointOverride
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Add(Set As Ark.SpawnPointSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx > -1 Then
		    If Self.mSets(Idx).Hash = Set.Hash Then
		      Return
		    End If
		    Self.mSets(Idx) = Set.ImmutableVersion
		  Else
		    Self.mSets.Add(Set.ImmutableVersion)
		  End If
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.SpawnPointOverride
		  Return New Ark.SpawnPointOverride(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(CreatureRef As Ark.BlueprintReference, Assigns Value As Double)
		  Var HasBlueprint As Boolean = Self.mLimits.HasAttribute(CreatureRef, Self.LimitAttribute)
		  
		  If Value >= 1.0 Or Value < 0.0 Then
		    If HasBlueprint Then
		      Self.mLimits.Remove(CreatureRef, Self.LimitAttribute)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If HasBlueprint And Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = Value Then
		    Return
		  End If
		  
		  Self.mLimits.Value(CreatureRef, Self.LimitAttribute) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Limit(Creature As Ark.Creature, Assigns Value As Double)
		  Var HasBlueprint As Boolean = Self.mLimits.HasAttribute(Creature, Self.LimitAttribute)
		  
		  If Value >= 1.0 Or Value < 0.0 Then
		    If HasBlueprint Then
		      Self.mLimits.Remove(Creature, Self.LimitAttribute)
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If HasBlueprint And Self.mLimits.Value(Creature, Self.LimitAttribute) = Value Then
		    Return
		  End If
		  
		  Self.mLimits.Value(Creature, Self.LimitAttribute) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadDefaults()
		  Ark.DataSource.Pool.Get(False).LoadDefaults(Self)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadDefaults(SetsString As String, LimitsString As String)
		  Var Sets() As Variant = Beacon.ParseJSON(SetsString)
		  For Each Set As Dictionary In Sets
		    Var Created As Ark.SpawnPointSet = Ark.SpawnPointSet.FromSaveData(Set)
		    If (Created Is Nil) = False Then
		      Self.Add(Created)
		    End If
		  Next
		  
		  Var Limits As Ark.BlueprintAttributeManager = Ark.BlueprintAttributeManager.FromSaveData(Beacon.ParseJSON(LimitsString))
		  Var References() As Ark.BlueprintReference = Limits.References
		  For Each Reference As Ark.BlueprintReference In References
		    Var Limit As Double = Limits.Value(Reference, LimitAttribute)
		    Self.Limit(Reference) = Limit
		  Next
		  
		  Exception Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Loading spawn set defaults")
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
		Function MutableVersion() As Ark.MutableSpawnPointOverride
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Set As Ark.SpawnPointSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mSets.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveCreature(CreatureRef As Ark.BlueprintReference)
		  Self.Limit(CreatureRef) = 1.0
		  
		  For SetIdx As Integer = Self.mSets.LastIndex DownTo 0
		    Var MutableSet As Ark.MutableSpawnPointSet = Self.mSets(SetIdx).MutableVersion
		    For EntryIdx As Integer = MutableSet.LastIndex DownTo 0
		      If MutableSet.Entry(EntryIdx).CreatureReference = CreatureRef Then
		        MutableSet.Remove(EntryIdx)
		      End If
		    Next
		    If MutableSet.Count = 0 Then
		      Self.Remove(MutableSet)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveCreature(Creature As Ark.Creature)
		  Self.RemoveCreature(New Ark.BlueprintReference(Creature))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetAt(Idx As Integer, Assigns Set As Ark.SpawnPointSet)
		  If Set Is Nil Then
		    Return
		  End If
		  
		  Self.mSets(Idx) = Set.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnPointReference(Assigns Ref As Ark.BlueprintReference)
		  If Self.mPointRef = Ref Then
		    Return
		  End If
		  
		  Self.mPointRef = Ref
		  Self.Modified = True
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
