#tag Class
Protected Class ConfigKey
	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ConfigKey)
		  Self.mUUID = Source.mUUID
		  Self.mLabel = Source.mLabel
		  Self.mFile = Source.mFile
		  Self.mHeader = Source.mHeader
		  Self.mKey = Source.mKey
		  Self.mValueType = Source.mValueType
		  Self.mMaxAllowed = Source.mMaxAllowed
		  Self.mDescription = Source.mDescription
		  Self.mDefaultValue = Source.mDefaultValue
		  Self.mNitradoPaths = Source.NitradoPaths // Use this version to make a clone of the array
		  Self.mNitradoFormat = Source.mNitradoFormat
		  Self.mNitradoDeployStyle = Source.mNitradoDeployStyle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Header As String, Key As String)
		  Self.mFile = File
		  Self.mHeader = Header
		  Self.mKey = Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ObjectID As v4UUID, Label As String, File As String, Header As String, Key As String, ValueType As Beacon.ConfigKey.ValueTypes, MaxAllowed As NullableDouble, Description As String, DefaultValue As Variant, NitradoPath As NullableString, NitradoFormat As Beacon.ConfigKey.NitradoFormats, NitradoDeployStyle As Beacon.ConfigKey.NitradoDeployStyles)
		  Self.Constructor(File, Header, Key)
		  
		  Self.mUUID = ObjectID
		  Self.mLabel = Label
		  Self.mValueType = ValueType
		  Self.mMaxAllowed = MaxAllowed
		  Self.mDescription = Description
		  Self.mDefaultValue = DefaultValue
		  
		  If (NitradoPath Is Nil) = False Then
		    Self.mNitradoPaths = NitradoPath.Split(";")
		    Self.mNitradoFormat = NitradoFormat
		    Self.mNitradoDeployStyle = NitradoDeployStyle
		  End If
		End Sub
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
		Function HasNitradoEquivalent() As Boolean
		  Return Self.mNitradoPaths.Count > 0 And Self.mNitradoFormat <> Beacon.ConfigKey.NitradoFormats.Unsupported
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Header() As String
		  Return Self.mHeader
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
		Function NitradoDeployStyle() As Beacon.ConfigKey.NitradoDeployStyles
		  Return Self.mNitradoDeployStyle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoFormat() As Beacon.ConfigKey.NitradoFormats
		  Return Self.mNitradoFormat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoPaths() As String()
		  Var Clone() As String
		  Clone.ResizeTo(Self.mNitradoPaths.LastIndex)
		  For Idx As Integer = 0 To Clone.LastIndex
		    Clone(Idx) = Self.mNitradoPaths(Idx)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ConfigKey) As Integer
		  If IsNull(Other) Then
		    Return 1
		  End If
		  
		  If IsNull(Self.mUUID) = False And IsNull(Other.mUUID) = False Then
		    Return Self.mUUID.Operator_Compare(Other.mUUID)
		  End If
		  
		  Var StringOne As String = Self.mFile + "." + Self.mHeader + "." + Self.mKey
		  Var StringTwo As String = Other.mFile + "." + Other.mHeader + "." + Other.mKey
		  Return StringOne.Compare(StringTwo, ComparisonOptions.CaseInsensitive, Locale.Raw)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SimplifiedKey() As String
		  // Returns the key without its attribute
		  
		  Return Beacon.ConfigValue.SimplifyKey(Self.mKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As v4UUID
		  Return Self.mUUID
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
		  Case ValueTypes.TypeText, ValueTypes.TypeArray, ValueTypes.TypeStructure
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
		Function ValueType() As Beacon.ConfigKey.ValueTypes
		  Return Self.mValueType
		End Function
	#tag EndMethod


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
		Private mHeader As String
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
		Private mNitradoDeployStyle As Beacon.ConfigKey.NitradoDeployStyles
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoFormat As Beacon.ConfigKey.NitradoFormats
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoPaths() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValueType As Beacon.ConfigKey.ValueTypes
	#tag EndProperty


	#tag Enum, Name = NitradoDeployStyles, Type = Integer, Flags = &h0
		Unsupported
		  Guided
		  Expert
		Both
	#tag EndEnum

	#tag Enum, Name = NitradoFormats, Type = Integer, Flags = &h0
		Unsupported
		  Line
		Value
	#tag EndEnum

	#tag Enum, Name = ValueTypes, Type = Integer, Flags = &h0
		TypeNumeric
		  TypeArray
		  TypeStructure
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
