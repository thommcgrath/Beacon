#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Callback As BeaconAPI.Request.ReplyCallback = Nil)
		  Self.Constructor(Path, Method, New Dictionary, Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Payload As Dictionary, Callback As BeaconAPI.Request.ReplyCallback = Nil)
		  Self.Constructor(Path, Method, SimpleHTTP.BuildFormData(Payload), "application/x-www-form-urlencoded", Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Payload As MemoryBlock, ContentType As String, Callback As BeaconAPI.Request.ReplyCallback = Nil)
		  If Path.IndexOf("://") = -1 Then
		    Path = BeaconAPI.URL(Path)
		  End If
		  If Path.Length >= 8 And Path.Left(8) <> "https://" Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Only https links are supported"
		    Raise Err
		  End If
		  
		  If Method = "GET" Or ContentType = "application/x-www-form-urlencoded" Then
		    Var QueryIndex As Integer = Path.IndexOf("?")
		    If QueryIndex <> -1 Then
		      Var Query As String = Path.Middle(QueryIndex + 1)
		      If Payload <> Nil Then
		        Payload = Payload + "&" + Query
		      Else
		        Payload = Query
		      End If
		      Path = Path.Left(QueryIndex)
		    End If
		    ContentType = "application/x-www-form-urlencoded"
		  End If
		  
		  Self.mRequestID = New v4UUID
		  Self.mURL = Path
		  Self.mMethod = Method.Uppercase
		  Self.mCallback = Callback
		  Self.mContentType = ContentType
		  Self.mPayload = Payload
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentType() As String
		  Return Self.mContentType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSessionRequest(Callback As BeaconAPI.Request.ReplyCallback) As BeaconAPI.Request
		  Var Path As String = BeaconAPI.URL("session")
		  Var Method As String = "POST"
		  Var Body As String = Beacon.GenerateJSON(New Dictionary("device_id" : Beacon.HardwareID), False)
		  Var Request As New BeaconAPI.Request(Path, Method, Body, "application/json", Callback)
		  Return Request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForceAuthorize(Token As BeaconAPI.OAuthToken)
		  If Token Is Nil Then
		    Return
		  End If
		  
		  Self.RequiresAuthentication = True
		  Self.RequestHeader("Authorization") = Token.AuthHeaderValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InvokeCallback(Response As BeaconAPI.Response)
		  If Beacon.SafeToInvoke(Self.mCallback) Then
		    Self.mCallback.Invoke(Self, Response)
		  End If
		  Self.mCallback = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Method() As String
		  Return Self.mMethod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Payload() As MemoryBlock
		  Return Self.mPayload
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Query() As String
		  If Self.mPayload <> Nil Then
		    Return Self.mPayload
		  End If
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ReplyCallback(Request As BeaconAPI . Request, Response As BeaconAPI . Response)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function RequestHeader(Header As String) As String
		  If Self.mRequestHeaders = Nil Then
		    Return ""
		  End If
		  
		  Return Self.mRequestHeaders.Lookup(Header, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestHeader(Header As String, Assigns Value As String)
		  If Self.mRequestHeaders = Nil Then
		    Self.mRequestHeaders = New Dictionary
		  End If
		  
		  If Value.Length = 0 Then
		    If Self.mRequestHeaders.HasKey(Header) Then
		      Self.mRequestHeaders.Remove(Header)
		    End If
		  Else
		    Self.mRequestHeaders.Value(Header) = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestHeaders() As String()
		  Var Headers() As String
		  If Self.mRequestHeaders <> Nil Then
		    For Each Entry As DictionaryEntry In Self.mRequestHeaders
		      Headers.Add(Entry.Key.StringValue)
		    Next
		  End If
		  Return Headers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestId() As String
		  Return Self.mRequestID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As String
		  Return Self.mURL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mCallback As ReplyCallback
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentType As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMethod As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPayload As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequestHeaders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequestId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mURL As String
	#tag EndProperty

	#tag Property, Flags = &h0
		RequiresAuthentication As Boolean = True
	#tag EndProperty


	#tag Enum, Name = AuthTypes, Type = Integer, Flags = &h0
		Unauthenticated
		  Password
		  Token
		Signature
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresAuthentication"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
