#tag Class
Protected Class MutableSpawnPointSetEntry
Inherits ArkSA.SpawnPointSetEntry
Implements Beacon.BlueprintConsumer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Append(Level As ArkSA.SpawnPointLevel)
		  Var Idx As Integer = Self.IndexOf(Level)
		  If Idx = -1 Then
		    Self.mLevels.Add(New ArkSA.SpawnPointLevel(Level))
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Creature(Assigns Value As ArkSA.Creature)
		  If Value Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Cannot assign to nil creature"
		    Raise Err
		  End If
		  
		  Var Reference As New ArkSA.BlueprintReference(Value)
		  If Self.mCreatureRef = Reference Then
		    Return
		  End If
		  
		  Self.mCreatureRef = Reference
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReference(Assigns Value As ArkSA.BlueprintReference)
		  If Value Is Nil Or Value.Kind <> ArkSA.BlueprintReference.KindCreature Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Expected creature reference"
		    Raise Err
		  End If
		  
		  If Self.mCreatureRef = Value Then
		    Return
		  End If
		  
		  Self.mCreatureRef = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EntryId(Assigns Value As String)
		  If Self.mEntryId = Value Then
		    Return
		  End If
		  
		  Self.mEntryId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPointSetEntry
		  Return New ArkSA.SpawnPointSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Level(AtIndex As Integer, Assigns Value As ArkSA.SpawnPointLevel)
		  If Value = Nil Then
		    Return
		  End If
		  
		  Self.mLevels(AtIndex) = New ArkSA.SpawnPointLevel(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelBound(Assigns Value As Integer)
		  If Self.mLevels.LastIndex <> Value Then
		    Self.mLevels.ResizeTo(Value)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelCount(Assigns Value As Integer)
		  If Self.mLevels.Count <> Value Then
		    Self.mLevels.ResizeTo(Value - 1)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelOverride(Assigns Value As NullableDouble)
		  If Self.mLevelOverride <> Value Then
		    Self.mLevelOverride = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Levels(Assigns NewLevels() As ArkSA.SpawnPointLevel)
		  Self.mLevels.ResizeTo(NewLevels.LastIndex)
		  For I As Integer = 0 To NewLevels.LastIndex
		    Self.mLevels(I) = New ArkSA.SpawnPointLevel(NewLevels(I))
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxLevelMultiplier(Assigns Value As NullableDouble)
		  If Self.mMaxLevelMultiplier <> Value Then
		    Self.mMaxLevelMultiplier = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxLevelOffset(Assigns Value As NullableDouble)
		  If Self.mMaxLevelOffset <> Value Then
		    Self.mMaxLevelOffset = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var NewCreatureRef As ArkSA.BlueprintReference = ArkSA.FindMigratedBlueprint(Migrator, Self.mCreatureRef)
		  If NewCreatureRef Is Nil Or NewCreatureRef.IsCreature = False Then
		    Return False
		  End If
		  
		  Self.mCreatureRef = NewCreatureRef
		  Self.Modified = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinLevelMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinLevelMultiplier <> Value Then
		    Self.mMinLevelMultiplier = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinLevelOffset(Assigns Value As NullableDouble)
		  If Self.mMinLevelOffset <> Value Then
		    Self.mMinLevelOffset = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableSpawnPointSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Offset(Assigns Value As Beacon.Point3D)
		  If Value Is Nil Then
		    If Self.mOffset <> Nil Then
		      Self.mOffset = Nil
		      Self.Modified = True
		    End If
		  Else
		    If Self.mOffset <> Value Then
		      Self.mOffset = New Beacon.Point3D(Value)
		      Self.Modified = True
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Level As ArkSA.SpawnPointLevel)
		  Var Idx As Integer = Self.IndexOf(Level)
		  If Idx > -1 Then
		    Self.mLevels.RemoveAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  Self.mLevels.RemoveAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpawnChance(Assigns Value As NullableDouble)
		  If Self.mChance <> Value Then
		    Self.mChance = Value
		    Self.Modified = True
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
