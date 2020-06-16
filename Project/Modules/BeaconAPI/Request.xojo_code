#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Authenticate(Token As String)
		  Self.RequestHeader("Authorization") = "Session " + Token
		  Self.RequestHeader("X-Beacon-Token") = Token
		  Self.mAuthType = BeaconAPI.Request.AuthTypes.Token
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Authenticate(Username As String, Password As String)
		  Self.RequestHeader("Authorization") = "Basic " + EncodeBase64(Username + ":" + Password, 0)
		  Self.RequestHeader("X-Beacon-Token") = ""
		  Self.mAuthType = BeaconAPI.Request.AuthTypes.Password
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Authenticated() As Boolean
		  Return Self.mRequestHeaders <> Nil And Self.mRequestHeaders.HasKey("Authorization")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthType() As BeaconAPI.Request.AuthTypes
		  Return Self.mAuthType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, New Dictionary, Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Payload As Dictionary, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, SimpleHTTP.BuildFormData(Payload), "application/x-www-form-urlencoded", Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Payload As MemoryBlock, ContentType As String, Callback As BeaconAPI.Request.ReplyCallback)
		  If Path.IndexOf("://") = -1 Then
		    Path = BeaconAPI.URL(Path)
		  End If
		  If Path.Length >= 8 And Path.Left(8) <> "https://" Then
		    Var Err As New UnsupportedOperationException
		    Err.Reason = "Only https links are supported"
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
		Sub InvokeCallback(Response As BeaconAPI.Response)
		  Self.mCallback.Invoke(Self, Response)
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
		      Headers.AddRow(Entry.Key.StringValue)
		    Next
		  End If
		  Return Headers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestID() As String
		  Return Self.mRequestID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sign(Identity As Beacon.Identity)
		  Var Content As String = Self.mMethod + Encodings.UTF8.Chr(10) + Self.mURL
		  If Self.mMethod = "GET" Then
		    If Self.mPayload <> Nil And Self.mPayload.Size > 0 Then
		      Content = Content + "?"
		    End If
		  Else
		    Content = Content + Encodings.UTF8.Chr(10)
		  End If
		  
		  Var Payload As MemoryBlock = Content
		  If Self.mPayload <> Nil Then
		    Payload = Payload + Self.mPayload
		  End If
		  
		  Self.Authenticate(Identity.Identifier, Identity.Sign(Payload))
		  Self.mAuthType = BeaconAPI.Request.AuthTypes.Signature
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As String
		  Return Self.mURL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		HasBeenRetried As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAuthType As BeaconAPI.Request.AuthTypes
	#tag EndProperty

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
		Protected mRequestID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mURL As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
