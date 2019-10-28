#tag Class
Protected Class SpawnPointSet
Implements Beacon.DocumentItem, Beacon.Countable
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mWeight = 1.0
		  Self.mModified = False
		  Self.mGroupOffset = Nil
		  Self.mSpreadRadius = 650
		  Self.mIncludeSpreadRadius = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SpawnPointSet)
		  Self.Constructor()
		  
		  Self.mModified = Source.mModified
		  Self.mWeight = Source.mWeight
		  Self.mLabel = Source.mLabel
		  If Source.mGroupOffset <> Nil Then
		    Self.mGroupOffset = New Beacon.Point3D(Source.mGroupOffset)
		  Else
		    Self.mGroupOffset = Nil
		  End If
		  Self.mSpreadRadius = Source.mSpreadRadius
		  Self.mIncludeSpreadRadius = Source.mIncludeSpreadRadius
		  Self.mWaterOnlyMinimumHeight = Source.mWaterOnlyMinimumHeight
		  Self.mIncludeWaterOnlyMinimumHeight = Source.mIncludeWaterOnlyMinimumHeight
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastRowIndex)
		  For I As Integer = 0 To Source.mEntries.LastRowIndex
		    Self.mEntries(I) = Source.mEntries(I).ImmutableVersion
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
		  
		  Return Self.mEntries.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entries() As Beacon.SpawnPointSetEntry()
		  Var Arr() As Beacon.SpawnPointSetEntry
		  Arr.ResizeTo(Self.mEntries.LastRowIndex)
		  For I As Integer = 0 To Self.mEntries.LastRowIndex
		    Arr(I) = Self.mEntries(I).ImmutableVersion
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(AtIndex As Integer) As Beacon.SpawnPointSetEntry
		  Return Self.mEntries(AtIndex).ImmutableVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.SpawnPointSet
		  If SaveData = Nil Then
		    Return Nil
		  End If
		  
		  If SaveData.HasAllKeys("Label", "Weight", "Entries") = False Then
		    Return Nil
		  End If
		  
		  Var Set As New Beacon.MutableSpawnPointSet
		  Set.Label = SaveData.Value("Label")
		  Set.Weight = SaveData.Value("Weight")
		  
		  Var Entries() As Variant = SaveData.Value("Entries")
		  For Each EntrySaveData As Dictionary In Entries
		    Var Entry As Beacon.SpawnPointSetEntry = Beacon.SpawnPointSetEntry.FromSaveData(EntrySaveData)
		    If Entry = Nil Then
		      Continue
		    End If
		    
		    Set.Append(Entry)
		  Next
		  
		  If SaveData.HasKey("SpreadRadius") And SaveData.Value("SpreadRadius") <> Nil Then
		    Set.SpreadRadius = SaveData.Value("SpreadRadius")
		    Set.OverridesSpreadRadius = True
		  End If
		  
		  If SaveData.HasKey("GroupOffset") And SaveData.Value("GroupOffset") <> Nil Then
		    Var GroupOffset As Beacon.Point3D = Beacon.Point3D(SaveData.Value("GroupOffset"))
		    If GroupOffset <> Nil Then
		      Set.GroupOffset = GroupOffset
		    End If
		  End If
		  
		  If SaveData.HasKey("WaterOnlyMinimumHeight") Then
		    Set.WaterOnlyMinimumHeight = SaveData.Value("WaterOnlyMinimumHeight")
		    Set.OverridesWaterOnlyMinimumHeight = True
		  End If
		  
		  Set.Modified = False
		  Return New Beacon.SpawnPointSet(Set)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupOffset() As Beacon.Point3D
		  If Self.mGroupOffset <> Nil Then
		    Return New Beacon.Point3D(Self.mGroupOffset)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.SpawnPointSetEntry) As Integer
		  For I As Integer = 0 To Self.mEntries.LastRowIndex
		    If Self.mEntries(I) = Entry Then
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
		  
		  If Self.mEntries.LastRowIndex = -1 Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Entries() As Variant
		  Entries.ResizeTo(Self.mEntries.LastRowIndex)
		  For I As Integer = 0 To Self.mEntries.LastRowIndex
		    Entries(I) = Self.mEntries(I).ImmutableVersion
		  Next
		  Return New Beacon.GenericIterator(Entries)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		    If Entry.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Not Value Then
		    For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		      Entry.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverridesSpreadRadius() As Boolean
		  Return Self.mIncludeSpreadRadius
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverridesWaterOnlyMinimumHeight() As Boolean
		  Return Self.mIncludeWaterOnlyMinimumHeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Entries() As Dictionary
		  For Each Entry As Beacon.SpawnPointSetEntry In Self.mEntries
		    Entries.AddRow(Entry.SaveData)
		  Next
		  
		  Var SaveData As New Dictionary
		  SaveData.Value("Label") = Self.Label
		  SaveData.Value("Weight") = Self.Weight
		  SaveData.Value("Entries") = Entries
		  If Self.mGroupOffset <> Nil Then
		    SaveData.Value("GroupOffset") = Self.mGroupOffset.SaveData
		  End If
		  If Self.mIncludeSpreadRadius Then
		    SaveData.Value("SpreadRadius") = Self.mSpreadRadius
		  End If
		  If Self.mIncludeWaterOnlyMinimumHeight Then
		    SaveData.Value("WaterOnlyMinimumHeight") = Self.mWaterOnlyMinimumHeight
		  End If
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpreadRadius() As Double
		  Return Self.mSpreadRadius
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WaterOnlyMinimumHeight() As Double
		  Return Self.mWaterOnlyMinimumHeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  Return Self.mWeight
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEntries() As Beacon.SpawnPointSetEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGroupOffset As Beacon.Point3D
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIncludeSpreadRadius As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIncludeWaterOnlyMinimumHeight As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mSpreadRadius As Double = 650
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWaterOnlyMinimumHeight As Double
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
