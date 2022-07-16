#tag Class
Protected Class ConfigKey
	#tag Method, Flags = &h0
		Function Constraint(Key As String) As Variant
		  If Self.mConstraints Is Nil Or Self.mConstraints.HasKey(Key) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mConstraints.Value(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.ConfigKey)
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
		  Self.mUIGroup = Source.mUIGroup
		  Self.mContentPackUUID = Source.mContentPackUUID
		  Self.mGSAPlaceholder = Source.mGSAPlaceholder
		  Self.mUWPChanges = Source.mUWPChanges
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
		Sub Constructor(ObjectID As v4UUID, Label As String, File As String, Header As String, Key As String, ValueType As Ark.ConfigKey.ValueTypes, MaxAllowed As NullableDouble, Description As String, DefaultValue As Variant, NitradoPath As NullableString, NitradoFormat As Ark.ConfigKey.NitradoFormats, NitradoDeployStyle As Ark.ConfigKey.NitradoDeployStyles, NativeEditorVersion As NullableDouble, UIGroup As NullableString, CustomSort As NullableString, Constraints As Dictionary, ContentPackUUID As String, GSAPlaceholder As NullableString, UWPChanges As Dictionary)
		  Self.Constructor(File, Header, Key)
		  
		  Self.mUUID = ObjectID
		  Self.mLabel = Label
		  Self.mValueType = ValueType
		  Self.mMaxAllowed = MaxAllowed
		  Self.mDescription = Description
		  Self.mDefaultValue = DefaultValue
		  Self.mNativeEditorVersion = NativeEditorVersion
		  Self.mUIGroup = UIGroup
		  Self.mContentPackUUID = ContentPackUUID
		  Self.mCustomSort = CustomSort
		  Self.mConstraints = Constraints
		  Self.mGSAPlaceholder = GSAPlaceholder
		  Self.mUWPChanges = UWPChanges
		  
		  If (NitradoPath Is Nil) = False Then
		    Self.mNitradoPaths = NitradoPath.Split(";")
		    Self.mNitradoFormat = NitradoFormat
		    Self.mNitradoDeployStyle = NitradoDeployStyle
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackUUID() As String
		  Return Self.mContentPackUUID
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
		Function GSAPlaceholder() As NullableString
		  Return Self.mGSAPlaceholder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNativeEditor() As Boolean
		  Return (Self.mNativeEditorVersion Is Nil) = False And Self.mNativeEditorVersion.IntegerValue >= App.BuildNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNitradoEquivalent() As Boolean
		  Return Self.mNitradoPaths.Count > 0 And Self.mNitradoFormat <> Ark.ConfigKey.NitradoFormats.Unsupported
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
		Function NativeEditorVersion() As NullableDouble
		  Return Self.mNativeEditorVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoDeployStyle() As Ark.ConfigKey.NitradoDeployStyles
		  Return Self.mNitradoDeployStyle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoFormat() As Ark.ConfigKey.NitradoFormats
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
		Function Operator_Compare(Other As Ark.ConfigKey) As Integer
		  If IsNull(Other) Then
		    Return 1
		  End If
		  
		  If IsNull(Self.mUUID) = False And IsNull(Other.mUUID) = False Then
		    Return Self.mUUID.Operator_Compare(Other.mUUID)
		  End If
		  
		  Var StringOne As String = Self.Signature
		  Var StringTwo As String = Other.Signature
		  Return StringOne.Compare(StringTwo, ComparisonOptions.CaseInsensitive, Locale.Raw)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SimplifiedKey() As String
		  // Returns the key without its attribute
		  
		  Return Ark.ConfigValue.SimplifyKey(Self.mKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIGroup() As NullableString
		  Return Self.mUIGroup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As v4UUID
		  Return Self.mUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UWPVersion() As Ark.ConfigKey
		  If Self.mUWPChanges Is Nil Or Self.mUWPChanges.KeyCount = 0 Then
		    Return Self
		  End If
		  
		  Var Copy As New Ark.ConfigKey(Self)
		  Copy.mUUID = Nil
		  
		  Var Changed As Boolean
		  For Each Entry As DictionaryEntry In Self.mUWPChanges
		    Try
		      Select Case Entry.Key
		      Case "file"
		        Copy.mFile = Entry.Value
		        Changed = True
		      Case "header"
		        Copy.mHeader = Entry.Value
		        Changed = True
		      Case "key"
		        Copy.mKey = Entry.Value
		        Changed = True
		      End Select
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Making UWP version")
		    End Try
		  Next Entry
		  
		  If Not Changed Then
		    Return Self
		  End If
		  
		  Return Copy
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
		Function ValueType() As Ark.ConfigKey.ValueTypes
		  Return Self.mValueType
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConstraints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackUUID As String
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
		Private mGSAPlaceholder As NullableString
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
		Private mNativeEditorVersion As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoDeployStyle As Ark.ConfigKey.NitradoDeployStyles
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoFormat As Ark.ConfigKey.NitradoFormats
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoPaths() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUIGroup As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUWPChanges As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValueType As Ark.ConfigKey.ValueTypes
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFile + "." + Self.mHeader + "." + Self.mKey
			End Get
		#tag EndGetter
		Signature As String
	#tag EndComputedProperty


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
