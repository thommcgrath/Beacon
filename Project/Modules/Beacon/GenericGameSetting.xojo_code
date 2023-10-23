#tag Class
Protected Class GenericGameSetting
Implements Beacon.GameSetting
	#tag Method, Flags = &h0
		Sub Constructor(Type As Integer, NitradoPaths() As String)
		  Self.mType = Type
		  Self.mPaths = NitradoPaths
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Type As Integer, NitradoPath As String)
		  Self.Constructor(Type, Array(NitradoPath))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNitradoEquivalent() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsArray() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mType = Self.TypeArray
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBoolean() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mType = Self.TypeBoolean
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNumeric() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mType = Self.TypeNumeric
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsString() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mType = Self.TypeNumeric
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsStruct() As Boolean
		  #Pragma StackOverflowChecking False
		  Return Self.mType = Self.TypeStruct
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoPaths() As String()
		  Return Self.mPaths
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NitradoPaths(Assigns Paths() As String)
		  Self.mPaths = Paths
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Integer
		  #Pragma StackOverflowChecking False
		  Return Self.mType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Type(Assigns NewType As Integer)
		  #Pragma StackOverflowChecking False
		  Self.mType = NewType
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValuesEqual(FirstValue As Variant, SecondValue As Variant) As Boolean
		  // For this generic implementation, keep it simple
		  
		  Select Case Self.mType
		  Case Self.TypeNumeric
		    Var FirstDouble, SecondDouble As Double
		    Try
		      FirstDouble = FirstValue.DoubleValue
		    Catch Err As RuntimeException
		      Return False
		    End Try
		    Try
		      SecondDouble = SecondValue.DoubleValue
		    Catch Err As RuntimeException
		      Return False
		    End Try
		    Return FirstDouble = SecondDouble
		  Case Self.TypeBoolean
		    Return FirstValue.IsTruthy = SecondValue.IsTruthy
		  Case Self.TypeString
		    Var FirstString As String = Beacon.VariantToString(FirstValue)
		    Var SecondString As String = Beacon.VariantToString(SecondValue)
		    Return FirstString.Compare(SecondString, ComparisonOptions.CaseSensitive, Locale.Raw) = 0
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPaths() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As Integer
	#tag EndProperty


	#tag Constant, Name = TypeArray, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeBoolean, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeNumeric, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeString, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeStruct, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant


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
