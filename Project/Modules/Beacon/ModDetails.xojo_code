#tag Class
Protected Class ModDetails
	#tag Method, Flags = &h0
		Sub Constructor(ModID As String, Name As String, ConsoleSafe As Boolean)
		  Self.mModID = ModID
		  Self.mName = Name
		  Self.mConsoleSafe = ConsoleSafe
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mConsoleSafe
			End Get
		#tag EndGetter
		ConsoleSafe As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mModID
			End Get
		#tag EndGetter
		ModID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConsoleSafe"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ModID"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
