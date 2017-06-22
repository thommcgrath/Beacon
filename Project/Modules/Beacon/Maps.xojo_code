#tag Module
Protected Module Maps
	#tag Method, Flags = &h1
		Protected Function All() As Beacon.Map()
		  Dim Maps(3) As Beacon.Map
		  Maps(0) = Beacon.Maps.TheIsland
		  Maps(1) = Beacon.Maps.ScorchedEarth
		  Maps(2) = Beacon.Maps.TheCenter
		  Maps(3) = Beacon.Maps.Ragnarok
		  Return Maps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Ragnarok() As Beacon.Map
		  Return New Beacon.Map("Ragnarok", 8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScorchedEarth() As Beacon.Map
		  Return New Beacon.Map("Scorched Earth", 2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheCenter() As Beacon.Map
		  Return New Beacon.Map("The Center", 4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TheIsland() As Beacon.Map
		  Return New Beacon.Map("The Island", 1)
		End Function
	#tag EndMethod


End Module
#tag EndModule
