#tag Class
Protected Class MutableSpawnPointSet
Inherits ArkSA.SpawnPointSet
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Append(Entry As ArkSA.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx = -1 Then
		    Self.mEntries.Add(Entry.ImmutableVersion)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ColorSetClass(Assigns Value As String)
		  #Pragma StackOverflowChecking False
		  If Self.mColorSetClass = Value Then
		    Return
		  End If
		  
		  Self.mColorSetClass = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Just making it public
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Source As ArkSA.SpawnPointSet)
		  // Public
		  Super.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReplacementWeight(FromCreature As ArkSA.Creature, ToCreature As ArkSA.Creature, Assigns Weight As NullableDouble)
		  If FromCreature Is Nil Or ToCreature Is Nil Then
		    Return
		  End If
		  
		  Self.CreatureReplacementWeight(FromCreature.CreatureId, ToCreature.CreatureId) = Weight
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureReplacementWeight(FromCreatureId As String, ToCreatureId As String, Assigns Weight As NullableDouble)
		  If Self.mReplacements.HasKey(FromCreatureId) = False Then
		    Self.mReplacements.Value(FromCreatureId) = New Dictionary
		  End If
		  
		  Var Choices As Dictionary = Self.mReplacements.Value(FromCreatureId)
		  If Choices.HasKey(ToCreatureId) Then
		    If Weight Is Nil Then
		      Choices.Remove(ToCreatureId)
		      Self.Modified = True
		    ElseIf Choices.Value(ToCreatureId).DoubleValue.Equals(Weight.DoubleValue, 1) = False Then
		      Choices.Value(ToCreatureId) = Weight.DoubleValue
		      Self.Modified = True
		    End If
		  ElseIf (Weight Is Nil) = False Then
		    Choices.Value(ToCreatureId) = Weight.DoubleValue
		    Self.Modified = True
		  End If
		  
		  // No modify here, the previous block will have done that
		  If Choices.KeyCount = 0 Then
		    Self.mReplacements.Remove(FromCreatureId)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entries(Assigns NewEntries() As ArkSA.SpawnPointSetEntry)
		  Self.mEntries.ResizeTo(NewEntries.LastIndex)
		  For I As Integer = 0 To NewEntries.LastIndex
		    Self.mEntries(I) = NewEntries(I).ImmutableVersion
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entry(AtIndex As Integer, Assigns NewEntry As ArkSA.SpawnPointSetEntry)
		  Self.mEntries(AtIndex) = NewEntry
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GroupOffset(Assigns Offset As Beacon.Point3D)
		  If Self.mGroupOffset <> Offset Then
		    If Offset Is Nil Then
		      Self.mGroupOffset = Nil
		    Else
		      Self.mGroupOffset = New Beacon.Point3D(Offset)
		    End If
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.SpawnPointSet
		  Return New ArkSA.SpawnPointSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Value = Value.ReplaceLineEndings(" ").Trim
		  
		  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.mLabel = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LevelOffsetBeforeMultiplier(Assigns Value As Boolean)
		  #Pragma StackOverflowChecking False
		  If Self.mOffsetBeforeMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mOffsetBeforeMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromPlayersMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromPlayersMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mMinDistanceFromPlayersMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromStructuresMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromStructuresMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mMinDistanceFromStructuresMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinDistanceFromTamedDinosMultiplier(Assigns Value As NullableDouble)
		  If Self.mMinDistanceFromTamedDinosMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mMinDistanceFromTamedDinosMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  #Pragma StackOverflowChecking False
		  If Value = True Then
		    Self.mCachedHash = ""
		  End If
		  Super.Modified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableSpawnPointSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  #Pragma StackOverflowChecking False
		  Value = Max(Abs(Value), 0.00001)
		  If Self.mWeight = Value Then
		    Return
		  End If
		  
		  Self.mWeight = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As ArkSA.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.mEntries.RemoveAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(AtIndex As Integer)
		  Self.mEntries.RemoveAt(AtIndex)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  If Self.mEntries.Count = 0 Then
		    Return
		  End If
		  
		  Self.mEntries.RemoveAll
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetId(Assigns Value As String)
		  // Calling the overridden superclass method.
		  #Pragma StackOverflowChecking False
		  If Self.mSetId = Value Then
		    Return
		  End If
		  
		  Self.mSetId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpreadRadius(Assigns Value As NullableDouble)
		  #Pragma StackOverflowChecking False
		  If Self.mSpreadRadius = Value Then
		    Return
		  End If
		  
		  Self.mSpreadRadius = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WaterOnlyMinimumHeight(Assigns Value As NullableDouble)
		  #Pragma StackOverflowChecking False
		  If Self.mWaterOnlyMinimumHeight = Value Then
		    Return
		  End If
		  
		  Self.mWaterOnlyMinimumHeight = Value
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
