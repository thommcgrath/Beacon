#tag Interface
Protected Interface DataSource
	#tag Method, Flags = &h0
		Function MultipliersForBeacon(ClassString As Text) As Ark.Range
		  
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
		Function SearchForBeacons(SearchText As Text) As Ark.Beacon()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As Text) As Ark.Engram()
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
