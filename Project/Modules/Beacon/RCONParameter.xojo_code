#tag Class
Protected Class RCONParameter
	#tag Method, Flags = &h0
		Sub Constructor(Name As String, DataType As String, Description As String = "")
		  Self.mName = Name
		  Self.mDataType = DataType
		  Self.mDescription = Description
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataType() As String
		  Return Self.mDataType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(Source As JSONItem) As Beacon.RCONParameter
		  Try
		    Var Name As String = Source.Value("name")
		    Var DataType As String = Source.Value("type")
		    Var Description As String = Source.Value("description")
		    Return New Beacon.RCONParameter(Name, DataType, Description)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Creating parameter from json")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(Source As String) As Beacon.RCONParameter
		  Try
		    Var Item As New JSONItem(Source)
		    Return FromJSON(Item)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Decoding JSON")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDataType As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
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
