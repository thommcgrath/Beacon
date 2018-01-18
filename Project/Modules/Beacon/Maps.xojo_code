#tag Module
Protected Module Maps
	#tag Method, Flags = &h1
		Protected Function Aberration() As Beacon.Map
		  Return New Beacon.Map("Aberration", 16, 5.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Map()
		  Dim Maps(4) As Beacon.Map
		  Maps(0) = Beacon.Maps.TheIsland
		  Maps(1) = Beacon.Maps.ScorchedEarth
		  Maps(2) = Beacon.Maps.TheCenter
		  Maps(3) = Beacon.Maps.Ragnarok
		  Maps(4) = Beacon.Maps.Aberration
		  Return Maps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ForMask(Mask As UInt64) As Beacon.Map()
		  Dim Possibles() As Beacon.Map = All
		  If Mask = 0 Then
		    Return Possibles
		  End If
		  
		  Dim Matches() As Beacon.Map
		  For Each Map As Beacon.Map In Possibles
		    If (Map.Mask And Mask) > 0 Then
		      Matches.Append(Map)
		    End If
		  Next
		  
		  Return Matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GuessMap(Sources() As Beacon.LootSource) As UInt64
		  Dim List() As Beacon.Map = All
		  Dim Counts As New Xojo.Core.Dictionary
		  
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
		  For Each Entry As Xojo.Core.DictionaryEntry In Counts
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
		Protected Function Ragnarok() As Beacon.Map
		  Return New Beacon.Map("Ragnarok", 8, 5.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScorchedEarth() As Beacon.Map
		  Return New Beacon.Map("Scorched Earth", 2, 5.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheCenter() As Beacon.Map
		  Return New Beacon.Map("The Center", 4, 5.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheIsland() As Beacon.Map
		  Return New Beacon.Map("The Island", 1, 4.0)
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
