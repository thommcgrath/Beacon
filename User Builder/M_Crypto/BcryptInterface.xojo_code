#tag Interface
Protected Interface BcryptInterface
	#tag Method, Flags = &h0
		Sub Encrypt(data As Xojo.Core.MutableMemoryBlock)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expand0State(key As Xojo.Core.MutableMemoryBlock, streamBuffer As Xojo.Core.MutableMemoryBlock, streamBufferPtr As Ptr)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpandState(data As Xojo.Core.MutableMemoryBlock, key As Xojo.Core.MutableMemoryBlock)
		  
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
