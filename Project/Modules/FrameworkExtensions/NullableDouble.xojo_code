#tag Class
Class NullableDouble
	#tag Method, Flags = &h0
		Function Operator_Add(RHS As Double) As Double
		  Return Self.mValue + RHS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_AddRight(LHS As Double) As Double
		  Return LHS + Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Double) As Integer
		  If Self.mValue > Other Then
		    Return 1
		  ElseIf Self.mValue < Other Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As NullableDouble) As Integer
		  If Other = Nil Or Self.mValue > Other.mValue Then
		    Return 1
		  ElseIf Self.mValue < Other.mValue Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Double
		  Return Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Value As Double)
		  Self.mValue = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(RHS As Double) As Double
		  Return Self.mValue / RHS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_DivideRight(LHS As Double) As Double
		  Return LHS / Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(RHS As Double) As Double
		  Return Self.mValue * RHS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_MultiplyRight(LHS As Double) As Double
		  Return LHS * Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_SubstractRight(LHS As Double) As Double
		  Return LHS - Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(RHS As Double) As Double
		  Return Self.mValue - RHS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Double
		  Return Self.mValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValue As Double
	#tag EndProperty


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
End Class
#tag EndClass
