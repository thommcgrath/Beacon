#tag Class
Protected Class BeaconCodeRange
	#tag Method, Flags = &h0
		Sub Constructor(StartPosition As UInteger, Length As UInteger)
		  Self.mStart = StartPosition
		  Self.mLength = Length
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mStart + Self.mLength
			End Get
		#tag EndGetter
		EndPosition As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLength
			End Get
		#tag EndGetter
		Length As UInteger
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mLength As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden ) Private mStart As UInteger
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mStart
			End Get
		#tag EndGetter
		StartPosition As UInteger
	#tag EndComputedProperty


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
		#tag ViewProperty
			Name="EndPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInteger"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
