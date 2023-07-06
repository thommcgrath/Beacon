#tag Class
Protected Class ConfigSet
	#tag Method, Flags = &h0
		Shared Function BaseConfigSet() As Beacon.ConfigSet
		  Var Set As New Beacon.ConfigSet
		  Set.mName = "Base"
		  Set.mConfigSetId = BaseConfigSetId
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetId() As String
		  Return Self.mConfigSetId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ConfigSet)
		  Self.mName = Source.mName
		  Self.mConfigSetId = Source.mConfigSetId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String)
		  Self.Constructor()
		  Self.mName = Name
		  Self.mConfigSetId = Beacon.UUID.v4
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary) As Beacon.ConfigSet
		  If SaveData.HasAllKeys("name", "configSetId") = False Then
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "Stored config set metadata is incomplete."
		    Raise Err
		  End If
		  
		  Var Set As New Beacon.ConfigSet
		  Set.mName = SaveData.Value("name")
		  set.mConfigSetId = SaveData.Value("configSetId")
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBase() As Boolean
		  Return Self.mConfigSetId = BaseConfigSetId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  If Self.IsBase Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot change the name of base config set."
		    Raise Err
		  End If
		  
		  Self.mName = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ConfigSet) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mConfigSetId = Other.mConfigSetId Then
		    Return 0
		  End If
		  
		  Return Self.mName.Compare(Other.mName, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("name") = Self.mName
		  Dict.Value("configSetId") = Self.mConfigSetId
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mConfigSetId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty


	#tag Constant, Name = BaseConfigSetId, Type = String, Dynamic = False, Default = \"94c9797d-857d-574a-bdb9-30ee6543ed12", Scope = Public
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
