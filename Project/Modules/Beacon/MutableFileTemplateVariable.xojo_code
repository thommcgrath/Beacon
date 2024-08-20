#tag Class
Protected Class MutableFileTemplateVariable
Inherits Beacon.FileTemplateVariable
	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.FileTemplateVariable
		  Return New Beacon.FileTemplateVariable(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mLabel = Value
		    Self.mModified = True
		  End If
		  
		  If Self.mName.IsEmpty Then
		    Self.mName = Self.SuggestName(Self.mLabel)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableFileTemplateVariable
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mName = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Options(Assigns Values() As String)
		  If Values Is Nil Or Values.Count = 0 Then
		    Return
		  End If
		  
		  If Self.mType <> Self.TypeEnum Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot set options for variable type " + Self.mType.ToString(Locale.Raw, "0")
		    Raise Err
		  End If
		  
		  Var OriginalValue As String = String.FromArray(Self.mEnumOptions, ",")
		  Var NewValue As String = String.FromArray(Values, ",")
		  If OriginalValue.Compare(NewValue, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mEnumOptions = Values.Clone
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegexPattern(Assigns Value As String)
		  If Self.mType <> Self.TypeText Then
		    If Value.IsEmpty = False Then
		      Var Err As New UnsupportedOperationException
		      Err.Message = "Cannot set regex pattern for variable type " + Self.mType.ToString(Locale.Raw, "0")
		      Raise Err
		    End If
		    Return
		  End If
		  
		  If Self.mRegexPattern.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mRegexPattern = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod


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
