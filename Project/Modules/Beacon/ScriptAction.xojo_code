#tag Class
Protected Class ScriptAction
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.mParams = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Action As String)
		  Self.Constructor()
		  Self.Action = Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromJSON(Source As String) As Beacon.ScriptAction
		  Var Params As Dictionary
		  Try
		    Params = Beacon.ParseJSON(Source)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If Params.HasKey("Action") = False Then
		    Return Nil
		  End If
		  
		  Var Action As New Beacon.ScriptAction
		  Action.mParams = Params
		  Return Action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromQueryString(Source As String) As Beacon.ScriptAction
		  Var Params As Dictionary = Beacon.ParseQueryString(Source)
		  If Params.HasKey("Action") = False Then
		    Return Nil
		  End If
		  
		  Var Action As New Beacon.ScriptAction
		  Action.mParams = Params
		  Return Action
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Return EncodeHex(Crypto.SHA3_512(Self.ToQueryString))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys() As String()
		  Var Arr() As String
		  For Each Entry As DictionaryEntry In Self.mParams
		    Arr.Add(Entry.Key.StringValue)
		  Next
		  Arr.Sort
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveKey(Key As String)
		  If Self.mParams.HasKey(Key) And Key <> "Action" Then
		    Self.mParams.Remove(Key)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As String
		  Return Beacon.GenerateJSON(Self.mParams, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToQueryString() As String
		  Var Keys() As String = Self.Keys
		  Var Parts() As String
		  For Each Key As String In Keys
		    Parts.Add(EncodeURLComponent(Key) + "=" + EncodeURLComponent(Self.mParams.Value(Key)))
		  Next
		  Return String.FromArray(Parts, "&")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Key As String) As String
		  Return Self.mParams.Lookup(Key, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As String, Assigns Value As String)
		  Self.mParams.Value(Key) = Value
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mParams.Value("Action")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mParams.Value("Action") = Value
			End Set
		#tag EndSetter
		Action As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mParams As Dictionary
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
			Name="Action"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
