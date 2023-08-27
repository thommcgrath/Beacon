#tag Class
Protected Class ConfigOption
	#tag Method, Flags = &h0
		Function Constraint(Key As String) As Variant
		  If Self.mConstraints Is Nil Or Self.mConstraints.HasKey(Key) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mConstraints.Value(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As SDTD.ConfigOption)
		  Self.mConstraints = If(Source.mConstraints Is Nil, Nil, Source.mConstraints.Clone)
		  Self.mContentPackId = Source.mContentPackId
		  Self.mCustomSort = Source.mCustomSort
		  Self.mDefaultValue = Source.mDefaultValue
		  Self.mDescription = Source.mDescription
		  Self.mFile = Source.mFile
		  Self.mKey = Source.mKey
		  Self.mLabel = Source.mLabel
		  Self.mMaxAllowed = Source.mMaxAllowed
		  Self.mNativeEditorVersion = Source.mNativeEditorVersion
		  Self.mObjectId = Source.mObjectId
		  Self.mUIGroup = Source.mUIGroup
		  Self.mValueType = Source.mValueType
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Key As String)
		  // Convenience method for quickly creating an unknown setting
		  Self.Constructor(Key, File, Key, ValueTypes.TypeText, 1, "", "", Nil, Nil, Nil, Nil, SDTD.UserContentPackId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Label As String, File As String, Key As String, ValueType As SDTD.ConfigOption.ValueTypes, MaxAllowed As NullableDouble, Description As String, DefaultValue As Variant, NativeEditorVersion As NullableDouble, UIGroup As NullableString, CustomSort As NullableString, Constraints As Dictionary, ContentPackId As String)
		  Self.mConstraints = If(Constraints Is Nil, Nil, Constraints.Clone)
		  Self.mContentPackId = ContentPackId
		  Self.mCustomSort = CustomSort
		  Self.mDefaultValue = DefaultValue
		  Self.mDescription = Description
		  Self.mFile = File
		  Self.mKey = Key
		  Self.mLabel = Label
		  Self.mMaxAllowed = MaxAllowed
		  Self.mNativeEditorVersion = NativeEditorVersion
		  Self.mObjectId = Self.GenerateId(ContentPackId, File, Key)
		  Self.mUIGroup = UIGroup
		  Self.mValueType = ValueType
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CustomSort() As NullableString
		  Return Self.mCustomSort
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultValue() As Variant
		  Return Self.mDefaultValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File() As String
		  Return Self.mFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenerateId(ContentPackId As String, Filename As String, Key As String) As String
		  Return Beacon.UUID.v5(ContentPackId.Lowercase + "." + Filename + "." + Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNativeEditor() As Boolean
		  Return (Self.mNativeEditorVersion Is Nil) = False And Self.mNativeEditorVersion.IntegerValue >= App.BuildNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxAllowed() As NullableDouble
		  Return Self.mMaxAllowed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NativeEditorVersion() As NullableDouble
		  Return Self.mNativeEditorVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectId() As String
		  Return Self.mObjectId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As SDTD.ConfigOption) As Integer
		  If IsNull(Other) Then
		    Return 1
		  End If
		  
		  If Self.mObjectId.Compare(Other.mObjectId, ComparisonOptions.CaseInsensitive, Locale.Raw) = 0 Then
		    Return 0
		  End If
		  
		  Var MyValue As String = Self.mLabel + "-" + Self.mObjectId
		  Var OtherValue As String = Other.mLabel + "-" + Other.mObjectId
		  Return MyValue.Compare(OtherValue, ComparisonOptions.CaseInsensitive, Locale.Raw)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIGroup() As NullableString
		  Return Self.mUIGroup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValuesEqual(FirstValue As String, SecondValue As String) As Boolean
		  Select Case Self.mValueType
		  Case ValueTypes.TypeNumeric
		    #Pragma BreakOnExceptions False
		    Var FirstNumber, SecondNumber As Double
		    Try
		      FirstNumber = Double.FromString(FirstValue, Locale.Raw)
		    Catch Err As RuntimeException
		    End Try
		    Try
		      SecondNumber = Double.FromString(SecondValue, Locale.Raw)
		    Catch Err As RuntimeException
		    End Try
		    #Pragma BreakOnExceptions Default
		    Return FirstNumber = SecondNumber
		  Case ValueTypes.TypeText
		    Return FirstValue.Compare(SecondValue, ComparisonOptions.CaseSensitive, Locale.Raw) = 0
		  Case ValueTypes.TypeBoolean
		    Var FirstValueIsTrue As Boolean = (FirstValue = "True") Or (FirstValue = "1")
		    Var SecondValueIsTrue As Boolean = (SecondValue = "True") Or (SecondValue = "1")
		    Return FirstValueIsTrue = SecondValueIsTrue
		  Else
		    Return FirstValue.Compare(SecondValue, ComparisonOptions.CaseSensitive, Locale.Raw) = 0
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValueType() As SDTD.ConfigOption.ValueTypes
		  Return Self.mValueType
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConstraints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCustomSort As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxAllowed As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNativeEditorVersion As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObjectId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUIGroup As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValueType As SDTD.ConfigOption.ValueTypes
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFile + "." + Self.mKey
			End Get
		#tag EndGetter
		Signature As String
	#tag EndComputedProperty


	#tag Enum, Name = ValueTypes, Type = Integer, Flags = &h0
		TypeNumeric
		  TypeBoolean
		TypeText
	#tag EndEnum


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
