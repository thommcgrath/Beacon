#tag Class
Protected Class SpawnPointSet
Implements Beacon.DocumentItem, Beacon.Countable
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mWeight = 1.0
		  Self.mModified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPointSet)
		  Self.Constructor()
		  
		  Self.mModified = Source.mModified
		  Self.mWeight = Source.mWeight
		  Self.mLabel = Source.mLabel
		  
		  Self.mCreatures.ResizeTo(Source.mCreatures.LastRowIndex)
		  For I As Integer = 0 To Source.mCreatures.LastRowIndex
		    Self.mCreatures(I) = New Beacon.Creature(Source.mCreatures(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Engrams
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mCreatures.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creature(AtIndex As Integer) As Beacon.Creature
		  Return Self.mCreatures(AtIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.SpawnPointSet
		  If SaveData = Nil Then
		    Return Nil
		  End If
		  
		  If SaveData.HasAllKeys("Label", "Weight", "Creatures") = False Then
		    Return Nil
		  End If
		  
		  Var Set As New Beacon.MutableSpawnPointSet
		  Set.Label = SaveData.Value("Label")
		  Set.Weight = SaveData.Value("Weight")
		  
		  Var Paths() As Variant = SaveData.Value("Creatures")
		  For Each Path As String In Paths
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Path)
		    If Creature = Nil Then
		      Continue
		    End If
		    
		    Set.AddCreature(Creature)
		  Next
		  
		  Set.Modified = False
		  Return New Beacon.SpawnPointSet(Set)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Creature As Beacon.Creature) As Integer
		  For I As Integer = 0 To Self.mCreatures.LastRowIndex
		    If Self.mCreatures(I) = Creature Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Document
		  
		  If Self.mCreatures.LastRowIndex = -1 Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Creatures() As Variant
		  For Each Creature As Beacon.Creature In Self.mCreatures
		    Creatures.AddRow(Creature)
		  Next
		  Return New Beacon.GenericIterator(Creatures)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Creatures() As String
		  For Each Creature As Beacon.Creature In Self.mCreatures
		    Creatures.AddRow(Creature.Path)
		  Next
		  
		  Var SaveData As New Dictionary
		  SaveData.Value("Label") = Self.Label
		  SaveData.Value("Weight") = Self.Weight
		  SaveData.Value("Creature") = Creatures
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mCreatures() As Beacon.Creature
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWeight As Double
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
	#tag EndViewBehavior
End Class
#tag EndClass
