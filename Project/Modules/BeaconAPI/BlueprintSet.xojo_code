#tag Class
Protected Class BlueprintSet
	#tag Method, Flags = &h0
		Function ActiveBlueprints() As Beacon.MutableBlueprint()
		  Var Blueprints() As Beacon.MutableBlueprint
		  For Each Entry As DictionaryEntry In Self.mCurrentBlueprints
		    Blueprints.AddRow(Beacon.MutableBlueprint(Entry.Value))
		  Next
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Blueprint As Beacon.Blueprint)
		  If Blueprint.Path = "" Then
		    Return
		  End If
		  
		  Var Mutable As Beacon.MutableBlueprint
		  If Blueprint IsA Beacon.MutableBlueprint Then
		    Mutable = Beacon.MutableBlueprint(Mutable)
		  Else
		    Mutable = Blueprint.MutableClone
		  End If
		  
		  Var Key As String = Mutable.ObjectID
		  
		  If Self.mCurrentBlueprints.HasKey(Key) Then
		    Var PreviousBlueprint As Beacon.MutableBlueprint = Self.mCurrentBlueprints.Value(Key)
		    If Mutable.Hash = PreviousBlueprint.Hash Then
		      // The blueprint is unchanged, so do nothing
		      Return
		    End If
		  End If
		  
		  Self.mCurrentBlueprints.Value(Key) = Mutable
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintsToDelete() As Beacon.Blueprint()
		  Var NewUUIDs() As String
		  For Each Entry As DictionaryEntry In Self.mCurrentBlueprints
		    NewUUIDs.AddRow(Beacon.MutableBlueprint(Entry.Value).ObjectID)
		  Next
		  
		  Var DeleteBlueprints() As Beacon.Blueprint
		  For Each Entry As DictionaryEntry In Self.mOriginalBlueprints
		    Var Original As Beacon.Blueprint = Entry.Value
		    If NewUUIDs.IndexOf(Original.ObjectID) = -1 Then
		      DeleteBlueprints.AddRow(Original.Clone)
		    End If
		  Next
		  
		  Return DeleteBlueprints()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintsToSave() As Beacon.Blueprint()
		  Var OriginalBlueprints As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mOriginalBlueprints
		    OriginalBlueprints.Value(Beacon.Blueprint(Entry.Value).ObjectID.StringValue) = Beacon.Blueprint(Entry.Value)
		  Next
		  
		  Var ModifiedBlueprints() As Beacon.Blueprint
		  For Each Entry As DictionaryEntry In Self.mCurrentBlueprints
		    Var Blueprint As Beacon.Blueprint = Entry.Value
		    If OriginalBlueprints.HasKey(Blueprint.ObjectID.StringValue) Then
		      // Might have changed
		      Var OriginalBlueprint As Beacon.Blueprint = OriginalBlueprints.Value(Blueprint.ObjectID.StringValue)
		      If Blueprint.Hash <> OriginalBlueprint.Hash Then
		        ModifiedBlueprints.AddRow(Blueprint.Clone)
		      End If
		    Else
		      // Confirmed addition
		      ModifiedBlueprints.AddRow(Blueprint.Clone)
		    End If
		  Next
		  
		  Return ModifiedBlueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearModifications(Revert As Boolean = True)
		  If Revert Then
		    Self.mCurrentBlueprints.RemoveAll
		    For Each Entry As DictionaryEntry In Self.mOriginalBlueprints
		      Var Blueprint As Beacon.Blueprint = Entry.Value
		      Self.mCurrentBlueprints.Value(Entry.Key) = Blueprint.MutableClone
		    Next
		  Else
		    Self.mOriginalBlueprints.RemoveAll
		    For Each Entry As DictionaryEntry In Self.mCurrentBlueprints
		      Var Blueprint As Beacon.MutableBlueprint = Entry.Value
		      Self.mOriginalBlueprints.Value(Entry.Key) = Blueprint.Clone
		    Next
		  End If
		  Self.mModified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mOriginalBlueprints = New Dictionary
		  Self.mCurrentBlueprints = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExportChanges() As String
		  Var Additions() As Beacon.Blueprint = Self.BlueprintsToSave()
		  Var Deletions() As Beacon.Blueprint = Self.BlueprintsToDelete()
		  
		  Var ChangedBlueprints() As Dictionary
		  For Each ModifiedBlueprint As Beacon.Blueprint In Additions
		    ChangedBlueprints.AddRow(ModifiedBlueprint.ToDictionary)
		  Next
		  
		  Var DeletedUUIDs() As String
		  For Each DeletedBlueprint As Beacon.Blueprint In Deletions
		    DeletedUUIDs.AddRow(DeletedBlueprint.ObjectID)
		  Next
		  
		  Var Dump As New Dictionary
		  If ChangedBlueprints.LastRowIndex > -1 Then
		    Dump.Value("Changed") = ChangedBlueprints
		  End If
		  If DeletedUUIDs.LastRowIndex > -1 Then
		    Dump.Value("Deleted") = DeletedUUIDs
		  End If
		  If Dump.KeyCount > 0 Then
		    Return Beacon.GenerateJSON(Dump, True)
		  Else
		    Return "{}"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportChanges(Dump As Dictionary)
		  If Dump.HasKey("Changed") Then
		    Var ChangedBlueprints() As Dictionary = Dump.Value("Changed")
		    For Each Dict As Dictionary In ChangedBlueprints
		      Var Blueprint As Beacon.Blueprint = Beacon.BlueprintFromDictionary(Dict)
		      If Blueprint <> Nil Then
		        Self.Add(Blueprint)
		      End If
		    Next
		  End If
		  
		  If Dump.HasKey("Deleted") Then
		    Var DeletedUUIDs() As String = Dump.Value("Deleted")
		    For Each UUID As String In DeletedUUIDs
		      If Self.mCurrentBlueprints.HasKey(UUID) Then
		        Self.mCurrentBlueprints.Remove(UUID)
		        Self.mModified = True
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Blueprint As Beacon.Blueprint)
		  If Blueprint.Path = "" Then
		    Return
		  End If
		  
		  If Self.mCurrentBlueprints.HasKey(Blueprint.ObjectID.StringValue) Then
		    Self.mCurrentBlueprints.Remove(Blueprint.ObjectID.StringValue)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalBlueprints As Dictionary
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
		#tag ViewProperty
			Name="mModified"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
