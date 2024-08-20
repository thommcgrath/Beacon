#tag Class
Protected Class FileTemplateVariable
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.FileTemplateVariable)
		  If Source Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Source variable is nil"
		    Raise Err
		  End If
		  
		  Self.mEnumOptions = Source.mEnumOptions.Clone
		  Self.mLabel = Source.mLabel
		  Self.mName = Source.mName
		  Self.mRegexPattern = Source.mRegexPattern
		  Self.mType = Source.mType
		  Self.mVariableId = Source.mVariableId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Type As Integer)
		  Self.mVariableId = Beacon.UUID.v4
		  Self.mType = Type
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(SaveData As JSONItem)
		  Self.mName = SaveData.Value("name")
		  Self.mLabel = SaveData.Value("label")
		  If SaveData.HasKey("variableId") Then
		    Self.mVariableId = SaveData.Value("variableId")
		  Else
		    Self.mVariableId = Beacon.UUID.v4
		  End If
		  
		  Self.mEnumOptions.ResizeTo(-1)
		  Self.mModified = False
		  Self.mRegexPattern = ""
		  
		  Select Case SaveData.Value("type").IntegerValue
		  Case Self.TypeBoolean
		    Self.mType = Self.TypeBoolean
		  Case Self.TypeText
		    Self.mType = Self.TypeText
		    If SaveData.HasKey("pattern") Then
		      Self.mRegexPattern = SaveData.Value("pattern").StringValue
		    End If
		  Case Self.TypeEnum
		    Self.mType = Self.TypeEnum
		    If SaveData.HasKey("values") Then
		      Var Values As JSONItem = SaveData.Child("values")
		      Self.mEnumOptions.ResizeTo(Values.LastRowIndex)
		      For Idx As Integer = 0 To Self.mEnumOptions.LastIndex
		        Self.mEnumOptions(Idx) = Values.ValueAt(Idx)
		      Next
		    End If
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unknown variable type " + SaveData.Value("type").IntegerValue.ToString(Locale.Raw, "0")
		    Raise Err
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Fingerprint() As String
		  Return EncodeHex(Self.ToJSON.ToString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(SaveData As Dictionary) As Beacon.FileTemplateVariable
		  Return FromJSON(New JSONItem(SaveData))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(SaveData As JSONItem) As Beacon.FileTemplateVariable
		  Try
		    Return New Beacon.FileTemplateVariable(SaveData)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableCopy() As Beacon.FileTemplateVariable
		  Return New Beacon.FileTemplateVariable(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.FileTemplateVariable
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableCopy() As Beacon.MutableFileTemplateVariable
		  Return New Beacon.MutableFileTemplateVariable(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableFileTemplateVariable
		  Return New Beacon.MutableFileTemplateVariable(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Options() As String()
		  Return Self.mEnumOptions.Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RegexPattern() As String
		  Return Self.mRegexPattern
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SuggestName(Label As String) As String
		  Static Expression As RegEx
		  If Expression Is Nil Then
		    Expression = New RegEx
		    Expression.SearchPattern = "[^a-zA-Z0-9_]+"
		  End If
		  
		  Do
		    Var Matches As RegExMatch = Expression.Search(Label)
		    If Matches Is Nil Then
		      Return Label
		    End If
		    
		    // Matches.Replace doesn't work
		    Label = Label.ReplaceAll(Matches.SubExpressionString(0), "")
		  Loop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("name") = Self.mName
		  SaveData.Value("label") = Self.mLabel
		  SaveData.Value("variableId") = Self.mVariableId
		  SaveData.Value("type") = Self.mType
		  Select Case Self.mType
		  Case Self.TypeText
		    If Self.mRegexPattern.IsEmpty = False Then
		      SaveData.Value("pattern") = Self.mRegexPattern
		    End If
		  Case Self.TypeEnum
		    SaveData.Value("values") = Self.mEnumOptions
		  End Select
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Return New JSONItem(Self.ToDictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Integer
		  Return Self.mType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ValidateName(Name As String) As Boolean
		  Static Expression As RegEx
		  If Expression Is Nil Then
		    Expression = New RegEx
		    Expression.SearchPattern = "^[a-zA-Z0-9_]+$"
		  End If
		  Return (Expression.Search(Name) Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VariableId() As String
		  Return Self.mVariableId
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEnumOptions() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRegexPattern As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mType As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mVariableId As String
	#tag EndProperty


	#tag Constant, Name = TypeBoolean, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeEnum, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeText, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
