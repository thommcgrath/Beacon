#tag Class
Protected Class RCONCommand
Implements Iterable
	#tag Method, Flags = &h0
		Function CommandId() As String
		  Return Self.mCommandId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CommandId As String, Name As String, Parameters() As Beacon.RCONParameter, Description As String)
		  Self.mCommandId = CommandId
		  Self.mName = Name
		  Self.mDescription = Description
		  Self.mParameters.ResizeTo(Parameters.LastIndex)
		  For Idx As Integer = 0 To Self.mParameters.LastIndex
		    Self.mParameters(Idx) = Parameters(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CommandId As String, Name As String, ParameterString As String, Description As String)
		  Var Parameters() As Beacon.RCONParameter
		  Try
		    Var ParameterSource As New JSONItem(ParameterString)
		    If ParameterSource.IsArray Then
		      For Idx As Integer = 0 To ParameterSource.LastRowIndex
		        Var Param As Beacon.RCONParameter = Beacon.RCONParameter.FromJSON(ParameterSource.ChildAt(Idx))
		        If (Param Is Nil) = False Then
		          Parameters.Add(Param)
		        End If
		      Next
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Parsing parameter string")
		  End Try
		  Self.Constructor(CommandId, Name, Parameters, Description)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(Source As JSONItem) As Beacon.RCONCommand
		  Try
		    Var CommandId As String = Source.Value("commandId")
		    Var Name As String = Source.Value("name")
		    Var Description As String = Source.Value("description")
		    Var ParameterSource As JSONItem = Source.Value("parameters")
		    Var Parameters() As Beacon.RCONParameter
		    If ParameterSource.IsArray Then
		      For Idx As Integer = 0 To ParameterSource.LastRowIndex
		        Var Param As Beacon.RCONParameter = Beacon.RCONParameter.FromJSON(ParameterSource.ChildAt(Idx))
		        If (Param Is Nil) = False Then
		          Parameters.Add(Param)
		        End If
		      Next
		    End If
		    Return New Beacon.RCONCommand(CommandId, Name, Parameters, Description)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Creating command from json")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(Source As String) As Beacon.RCONCommand
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
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var List() As Variant
		  List.ResizeTo(Self.mParameters.LastIndex)
		  For Idx As Integer = 0 To Self.mParameters.LastIndex
		    List(Idx) = Self.mParameters(Idx)
		  Next
		  Return New Beacon.GenericIterator(List)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParameterAt(Idx As Integer) As Beacon.RCONParameter
		  Return Self.mParameters(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParameterCount() As Integer
		  Return Self.mParameters.Count
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCommandId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParameters() As Beacon.RCONParameter
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
		#tag ViewProperty
			Name="mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
