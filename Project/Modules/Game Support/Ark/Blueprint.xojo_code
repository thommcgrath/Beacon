#tag Interface
Protected Interface Blueprint
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.Blueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.Blueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableBlueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableBlueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  
		End Function
	#tag EndMethod


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
End Interface
#tag EndInterface
