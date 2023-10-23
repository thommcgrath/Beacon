#tag Interface
Protected Interface GameSetting
	#tag Method, Flags = &h0
		Function HasNitradoEquivalent() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsArray() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBoolean() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNumeric() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsString() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsStruct() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoPaths() As String()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValuesEqual(FirstValue As Variant, SecondValue As Variant) As Boolean
		  
		End Function
	#tag EndMethod


	#tag Note, Name = LeakyAbstraction
		Yes, this has Nitrado-specific stuff in it. There's not really a better way. If another hosting provider needs
		something like this, we'll add methods for them too.
		
	#tag EndNote


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
