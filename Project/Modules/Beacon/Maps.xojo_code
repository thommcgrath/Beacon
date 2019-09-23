#tag Module
Protected Module Maps
	#tag Method, Flags = &h1
		Protected Function Aberration() As Beacon.Map
		  Return New Beacon.Map("Aberration", "Aberration_P", 16, 4.0, True, "38b6b5ae-1a60-4f2f-9bc6-9a23620b56d8")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Map()
		  Dim Maps(7) As Beacon.Map
		  Maps(0) = Beacon.Maps.TheIsland
		  Maps(1) = Beacon.Maps.ScorchedEarth
		  Maps(2) = Beacon.Maps.Aberration
		  Maps(3) = Beacon.Maps.Extinction
		  Maps(4) = Beacon.Maps.TheCenter
		  Maps(5) = Beacon.Maps.Ragnarok
		  Maps(6) = Beacon.Maps.Valguero
		  Maps(7) = Beacon.Maps.Genesis
		  Return Maps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Extinction() As Beacon.Map
		  Return New Beacon.Map("Extinction", "Extinction", 32, 4.0, True, "687cce7c-f1c4-440d-9bea-bd80f2717e2b")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt64) As Beacon.Map()
		  Dim Possibles() As Beacon.Map = All
		  Dim Matches() As Beacon.Map
		  For Each Map As Beacon.Map In Possibles
		    If (Map.Mask And Mask) > 0 Then
		      Matches.AddRow(Map)
		    End If
		  Next
		  
		  Return Matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Genesis() As Beacon.Map
		  Return New Beacon.Map("Genesis", "Genesis_P", 128, 4.0, True, "abbc2e33-f7c9-4b31-b906-bfdc8adc3685")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GuessMap(Sources() As Beacon.LootSource) As UInt64
		  Dim List() As Beacon.Map = All
		  Dim Counts As New Dictionary
		  
		  For Each Map As Beacon.Map In List
		    For Each Source As Beacon.LootSource In Sources
		      If Source.Availability = Map.Mask Then
		        // Source is exclusive to this map, so give it a very high score
		        Counts.Value(Map.Mask) = Counts.Lookup(Map.Mask, 0) + 100
		      ElseIf Source.ValidForMap(Map) Then
		        Counts.Value(Map.Mask) = Counts.Lookup(Map.Mask, 0) + 1
		      End If
		    Next
		  Next
		  
		  Dim BestMask As UInt64
		  Dim MaxCount As UInteger
		  For Each Entry As DictionaryEntry In Counts
		    Dim Mask As UInt64 = Entry.Key
		    Dim Count As UInteger = Entry.Value
		    
		    If Count > MaxCount Then
		      BestMask = Mask
		      MaxCount = Count
		    End If
		  Next
		  
		  If BestMask = 0 Then
		    BestMask = TheIsland.Mask
		  End If
		  
		  Return BestMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MaskForIdentifier(Identifier As String) As UInt64
		  Dim Possibles() As Beacon.Map = All
		  For Each Map As Beacon.Map In Possibles
		    If Map.Identifier = Identifier Then
		      Return Map
		    End If
		  Next
		  
		  Return Beacon.Maps.All.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Ragnarok() As Beacon.Map
		  Return New Beacon.Map("Ragnarok", "Ragnarok", 8, 5.0, False, "d23706bb-9875-46f4-b2aa-c137516aa65f")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScorchedEarth() As Beacon.Map
		  Return New Beacon.Map("Scorched Earth", "ScorchedEarth_P", 2, 4.0, True, "55dd6a68-7041-46aa-9405-9adc5ae1825f")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheCenter() As Beacon.Map
		  Return New Beacon.Map("The Center", "TheCenter", 4, 5.0, False, "4dd9a0a5-add5-439c-9e80-103c6197d620")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheIsland() As Beacon.Map
		  Return New Beacon.Map("The Island", "TheIsland", 1, 4.0, True, "30bbab29-44b2-4f4b-a373-6d4740d9d3b5")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Valguero() As Beacon.Map
		  Return New Beacon.Map("Valguero", "Valguero_P", 64, 5.0, False, "c9e5d408-078d-4a30-b15c-ae28be7b8c0b")
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
