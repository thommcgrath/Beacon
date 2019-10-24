#tag Class
Protected Class SpawnPointSet
Implements Beacon.DocumentItem, Beacon.Countable
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mEntities = New Dictionary
		  Self.mWeight = 1.0
		  Self.mModified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPointSet)
		  Self.Constructor()
		  
		  Self.mModified = Source.mModified
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
		  
		  Return Self.mEntities.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Creature(AtIndex As Integer) As Beacon.Creature
		  Return Beacon.Data.GetCreatureByPath(Self.mEntities.Key(AtIndex).StringValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureLimit(Creature As Beacon.Creature) As Double
		  If Self.mEntities.HasKey(Creature.Path) Then
		    Return Self.mEntities.Value(Creature.Path)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.SpawnPointSet
		  If SaveData = Nil Then
		    Return Nil
		  End If
		  
		  If SaveData.HasAllKeys("label", "weight", "creatures") = False Then
		    Return Nil
		  End If
		  
		  Var Set As New Beacon.MutableSpawnPointSet
		  Set.Label = SaveData.Value("label")
		  Set.Weight = SaveData.Value("weight")
		  
		  Var Creatures() As Variant = SaveData.Value("creatures")
		  For Each CreatureData As Dictionary In Creatures
		    Var CreatureID As v4UUID = CreatureData.Value("creature_id").StringValue
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByID(CreatureID)
		    If Creature = Nil Then
		      If CreatureData.HasKey("creature_path") Then
		        Creature = New Beacon.MutableCreature(CreatureData.Value("creature_path").StringValue, CreatureID)
		      Else
		        Continue
		      End If
		    End If
		    
		    Var Limit As Double = CreatureData.Lookup("max_percentage", 1.0)
		    Set.CreatureLimit(Creature) = Limit
		  Next
		  
		  Set.Modified = False
		  Return New Beacon.SpawnPointSet(Set)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCreatureLimited(Creature As Beacon.Creature) As Boolean
		  Return Self.mEntities.HasKey(Creature.Path) And Self.mEntities.Value(Creature.Path) < 1.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  // Part of the Beacon.DocumentItem interface.
		  
		  #Pragma Unused Document
		  
		  If Self.mEntities.KeyCount = 0 Then
		    Return False
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mEntities
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Entry.Key.StringValue)
		    If Creature = Nil Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Creatures() As Variant
		  For Each Entry As DictionaryEntry In Self.mEntities
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Entry.Key)
		    If Creature <> Nil Then
		      Creatures.AddRow(Creature)
		    End If
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
		  Var Creatures() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mEntities
		    Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByPath(Entry.Key.StringValue)
		    If Creature = Nil Then
		      Continue
		    End If
		    
		    Var CreatureData As New Dictionary
		    CreatureData.Value("creature_id") = Creature.ObjectID.StringValue
		    CreatureData.Value("creature_path") = Creature.Path
		    
		    If Entry.Value.DoubleValue < 1.0 Then
		      CreatureData.Value("max_percentage") = Entry.Value
		    End If
		  Next
		  
		  Var SaveData As New Dictionary
		  SaveData.Value("label") = Self.Label
		  SaveData.Value("weight") = Self.Weight
		  SaveData.Value("creatures") = Creatures
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Weight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEntities As Dictionary
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
