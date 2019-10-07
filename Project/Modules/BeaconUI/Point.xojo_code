#tag Class
Protected Class Point
	#tag Method, Flags = &h0
		Sub Constructor(Other As BeaconUI.Point)
		  Self.Constructor(Other.Left, Other.Top)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Left As Double, Top As Double)
		  Self.Left = Left
		  Self.Top = Top
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Left As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Top As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.Left
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Left = Value
			End Set
		#tag EndSetter
		X As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.Top
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Top = Value
			End Set
		#tag EndSetter
		Y As Double
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
			Name="Left"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="X"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Y"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
