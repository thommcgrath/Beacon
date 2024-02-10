#tag Class
Protected Class RCONConfig
	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.RCONConfig)
		  Self.Constructor(Source.Name, Source.Host, Source.Port, Source.Password)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Host As String, Port As Integer, Password As String)
		  Self.mName = Name.Trim
		  Self.mHost = Host.Trim
		  Self.mPort = Port
		  Self.mPassword = Password
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  If Self.mName.IsEmpty = False Then
		    Return Self.mName
		  End If
		  
		  If Self.mHost.IsEmpty = False Then
		    If Self.mPort < 1 Or Self.mPort > 65535 Then
		      Return Self.mHost
		    End If
		    Return Self.mHost + ":" + Self.mPort.ToString(Locale.Current, "0")
		  End If
		  
		  Return "New Connection"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Variant) As Beacon.RCONConfig
		  If SaveData.IsNull Or SaveData.IsArray Or SaveData.Type <> Variant.TypeObject Or (SaveData.ObjectValue IsA Dictionary) = False Then
		    Return Nil
		  End If
		  
		  Try
		    Var Dict As Dictionary = Dictionary(SaveData.ObjectValue)
		    Var Name As String = Dict.Value("name")
		    Var Host As String = Dict.Value("host")
		    Var Port As Integer = Dict.Value("port")
		    Var Password As String = Dict.Value("password")
		    Return New Beacon.RCONConfig(Name, Host, Port, Password)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Loading RCON connection info")
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Host() As String
		  Return Self.mHost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.RCONConfig) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Var MyConnectionString As String = Self.Signature
		  Var OtherConnectionString As String = Other.Signature
		  Return MyConnectionString.Compare(OtherConnectionString, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Password() As String
		  Return Self.mPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Port() As Integer
		  Return Self.mPort
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("name") = Self.mName
		  Dict.Value("host") = Self.mHost
		  Dict.Value("port") = Self.mPort
		  Dict.Value("pass") = Self.mPassword
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Signature() As String
		  Return Self.mName.Lowercase + ":" + Self.mHost.Lowercase + ":" + Self.mPort.ToString(Locale.Raw, "0") + ":" + Self.mPassword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
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
			Name="mHost"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
