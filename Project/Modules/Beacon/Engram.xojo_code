#tag Class
Protected Class Engram
	#tag Method, Flags = &h0
		Function ClassString() As Text
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassString As Text)
		  Self.mClassString = ClassString
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  Return Beacon.Data.NameOfEngram(Self.mClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(ClassString As Text)
		  Self.Constructor(ClassString)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mClassString As Text
	#tag EndProperty


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
End Class
#tag EndClass
