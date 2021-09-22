#tag Class
Protected Class ConfigSetState
	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Enabled As Boolean)
		  Self.mName = Name
		  Self.mEnabled = Enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled() As Boolean
		  Return Self.mEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary) As Ark.ConfigSetState
		  Try
		    Var Name As String = Dict.Value("Name")
		    Var Enabled As Boolean = Dict.Value("Enabled")
		    Return New Ark.ConfigSetState(Name, Enabled)
		  Catch Err As RuntimeException
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.ConfigSetState) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var Compare As Integer = Self.mName.Compare(Other.mName, ComparisonOptions.CaseInsensitive)
		  If Compare <> 0 Then
		    Return Compare
		  End If
		  
		  If Self.mEnabled = True And Other.mEnabled = False Then
		    Return 1
		  ElseIf Self.mEnabled = False And Other.mEnabled = True Then
		    Return -1
		  Else
		    Return 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Name") = Self.mName
		  Dict.Value("Enabled") = Self.mEnabled
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
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
