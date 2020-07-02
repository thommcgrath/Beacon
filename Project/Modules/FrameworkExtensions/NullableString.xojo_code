#tag Class
Class NullableString
	#tag Method, Flags = &h0
		Function Asc() As Integer
		  Return Self.mValue.Asc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AscByte() As Integer
		  Return Self.mValue.AscByte
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeginsWith(Value As String, Options As ComparisonOptions = ComparisonOptions.CaseInsensitive, Locale As Locale = Nil) As Boolean
		  Return Self.mValue.BeginsWith(Value, Options, Locale)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Bytes() As Integer
		  Return Self.mValue.Bytes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Compare(Other As String, Compare As ComparisonOptions = ComparisonOptions.CaseInsensitive, Locale As Locale = Nil) As Integer
		  Return Self.mValue.Compare(Other, Compare, Locale)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertEncoding(NewEncoding As TextEncoding) As String
		  Return Self.mValue.ConvertEncoding(NewEncoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountFields(Separator As String) As Integer
		  Return Self.mValue.CountFields(Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefineEncoding(NewEncoding As TextEncoding) As String
		  Return Self.mValue.DefineEncoding(NewEncoding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encoding() As TextEncoding
		  Return Self.mValue.Encoding
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndsWith(Value As String, Options As ComparisonOptions = ComparisonOptions.CaseInsensitive, Locale As Locale = Nil) As Boolean
		  Return Self.mValue.EndsWith(Value, Options, Locale)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(Value As String) As NullableString
		  Return Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromVariant(Value As Variant) As NullableString
		  If IsNull(Value) Then
		    Return Nil
		  End If
		  
		  Select Case Value.Type
		  Case Variant.TypeString
		    Return NullableString.FromString(Value.StringValue)
		  Case Variant.TypeText
		    Return NullableString.FromString(Value.TextValue)
		  Else
		    Return Nil
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Start As Integer, Find As String, Options As ComparisonOptions = ComparisonOptions.CaseInsensitive, Locale As Locale = Nil) As Integer
		  Return Self.mValue.IndexOf(Start, Find, Options, Locale)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Find As String, Options As ComparisonOptions = ComparisonOptions.CaseInsensitive, Locale As Locale = Nil) As Integer
		  Return Self.mValue.IndexOf(Find, Options, Locale)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOfBytes(Start As Integer, Find As String) As Integer
		  Return Self.mValue.IndexOfBytes(Start, Find)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOfBytes(Find As String) As Integer
		  Return Self.mValue.IndexOfBytes(Find)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty() As Boolean
		  Return Self.mValue.IsEmpty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastField(Separator As String) As String
		  Return Self.mValue.LastField(Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(Count As Integer) As String
		  Return Self.mValue.Left(Count)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LeftBytes(Count As Integer) As String
		  Return Self.mValue.LeftBytes(Count)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As Integer
		  Return Self.mValue.Length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lowercase() As String
		  Return Self.mValue.Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Middle(Start As Integer) As String
		  Return Self.mValue.Middle(Start)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Middle(Start As Integer, Length As Integer) As String
		  Return Self.mValue.Middle(Start, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MiddleBytes(Start As Integer) As String
		  Return Self.mValue.MiddleBytes(Start)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MiddleBytes(Start As Integer, Length As Integer) As String
		  Return Self.mValue.MiddleBytes(Start, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NthField(Separator As String, FieldNumber As Integer) As String
		  Return Self.mValue.NthField(Separator, FieldNumber)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As NullableString) As Integer
		  If Other Is Nil Then
		    Return 1
		  Else
		    Return Self.Operator_Compare(Other.mValue)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As String) As Integer
		  Return Self.mValue.Compare(Other, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Return Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Value As String)
		  Self.mValue = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Replace(OldString As String, NewString As String) As String
		  Return Self.mValue.Replace(OldString, NewString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplaceAll(OldString As String, NewString As String) As String
		  Return Self.mValue.ReplaceAll(OldString, NewString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplaceAllBytes(OldString As String, NewString As String) As String
		  Return Self.mValue.ReplaceAllBytes(OldString, NewString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplaceBytes(OldString As String, NewString As String) As String
		  Return Self.mValue.ReplaceBytes(OldString, NewString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplaceLineEndings(LineEnding As String) As String
		  Return Self.mValue.ReplaceLineEndings(LineEnding)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(Count As Integer) As String
		  Return Self.mValue.Right(Count)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RightBytes(Count As Integer) As String
		  Return Self.mValue.RightBytes(Count)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Split(Delimiter As String) As String()
		  Return Self.mValue.Split(Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SplitBytes(Delimiter As String) As String()
		  Return Self.mValue.SplitBytes(Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  Return Self.mValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Titlecase() As String
		  Return Self.mValue.Titlecase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDouble() As Double
		  Return Self.mValue.ToDouble
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger() As Integer
		  Return Self.mValue.ToInteger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ToVariant(Value As NullableString) As Variant
		  If Value Is Nil Then
		    Return Nil
		  End If
		  
		  Return Value.StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trim() As String
		  Return Self.mValue.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TrimLeft() As String
		  Return Self.mValue.TrimLeft
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TrimRight() As String
		  Return Self.mValue.TrimRight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Uppercase() As String
		  Return Self.mValue.Uppercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Val() As Double
		  Return Self.mValue.Val
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValue As String
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
