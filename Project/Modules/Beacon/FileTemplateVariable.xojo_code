#tag Class
Protected Class FileTemplateVariable
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mVariableId = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.FileTemplateVariable)
		  If Source Is Nil Then
		    Var Err As New NilObjectException
		    Err.Message = "Source variable is nil"
		    Raise Err
		  End If
		  
		  Self.mName = Source.mName
		  Self.mVariableId = Source.mVariableId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(SaveData As JSONItem)
		  Self.mName = SaveData.Lookup("name", "UntitledVariable")
		  If SaveData.HasKey("variableId") Then
		    Self.mVariableId = SaveData.Value("variableId")
		  Else
		    Self.mVariableId = Beacon.UUID.v4
		  End If
		End Sub
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
		Function ToDictionary() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("name") = Self.mName
		  SaveData.Value("variableId") = Self.mVariableId
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As JSONItem
		  Return New JSONItem(Self.ToDictionary)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mVariableId As String
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
