#tag Interface
Protected Interface DataSource
	#tag Method, Flags = &h0
		Function MultipliersForLootSource(ClassString As Text) As Beacon.Range
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfEngram(ClassString As Text) As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfLootSource(ClassString As Text) As Text
		  
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
End Interface
#tag EndInterface
