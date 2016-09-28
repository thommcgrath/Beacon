#tag Interface
Protected Interface DataSource
	#tag Method, Flags = &h0
		Function MultipliersForBeacon(ClassString As Text) As Beacon.Range
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfBeacon(ClassString As Text) As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfEngram(ClassString As Text) As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As Text) As Beacon.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As Text) As Beacon.LootSource()
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
	#tag EndViewBehavior
End Interface
#tag EndInterface
