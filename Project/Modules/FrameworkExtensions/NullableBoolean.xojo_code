#tag Class
Class NullableBoolean
	#tag Method, Flags = &h0
		Function BooleanValue() As Boolean
		  Return Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromBoolean(Value As Boolean) As NullableBoolean
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Boolean) As Integer
		  If Self.mValue <> Other Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As NullableBoolean) As Integer
		  If Other Is Nil Then
		    Return 1
		  ElseIf Self.mValue <> Other.mValue Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Boolean
		  Return Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Value As Boolean)
		  Self.mValue = Value
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValue As Boolean
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
