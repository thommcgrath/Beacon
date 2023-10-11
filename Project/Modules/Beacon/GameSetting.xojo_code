#tag Interface
Protected Interface GameSetting
	#tag Method, Flags = &h0
		Function HasNitradoEquivalent() As Boolean
		  
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


End Interface
#tag EndInterface
