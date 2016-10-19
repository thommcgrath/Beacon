#tag Interface
Protected Interface Scrollable
	#tag Method, Flags = &h0
		Function ScrollMaximum() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollMaximum(Assigns Value As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollMinimum() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollMinimum(Assigns Value As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScrollPosition() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScrollPosition(Assigns Value As Double)
		  
		End Sub
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
