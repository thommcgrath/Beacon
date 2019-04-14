#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Authenticate(Token As String)
		  Self.mAuthHeader = "Session " + Token
		  Self.mAuthUser = ""
		  Self.mAuthPassword = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Authenticate(Username As String, Password As String)
		  Self.mAuthHeader = "Basic " + EncodeBase64(Username + ":" + Password, 0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Authenticated() As Boolean
		  Return Self.mAuthHeader <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthHeader() As String
		  Return Self.mAuthHeader
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthPassword() As String
		  Return Self.mAuthPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthUser() As String
		  Return Self.mAuthUser
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, New Dictionary, Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Payload As Dictionary, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, Self.URLEncodeFormData(Payload), "application/x-www-form-urlencoded", Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, Method As String, Payload As String, ContentType As String, Callback As BeaconAPI.Request.ReplyCallback)
		  If Path.IndexOf("://") = -1 Then
		    Path = BeaconAPI.URL(Path)
		  End If
		  If Path.Length >= 8 And Path.Left(8) <> "https://" Then
		    Dim Err As New UnsupportedOperationException
		    Err.Message = "Only https links are supported"
		    Raise Err
		  End If
		  
		  If Method = "GET" Or ContentType = "application/x-www-form-urlencoded" Then
		    Dim QueryIndex As Integer = Path.IndexOf("?")
		    If QueryIndex <> -1 Then
		      Dim Query As String = Path.SubString(QueryIndex + 1)
		      If Payload <> "" Then
		        Payload = Payload + "&" + Query
		      Else
		        Payload = Query
		      End If
		      Path = Path.Left(QueryIndex)
		    End If
		    ContentType = "application/x-www-form-urlencoded"
		  End If
		  
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
		Sub InvokeCallback(Success As Boolean, Message As String, Details As Variant, HTTPStatus As Integer, RawReply As String)
		  Self.mCallback.Invoke(Success, Message, Details, HTTPStatus, RawReply)
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
		  Return Self.mPayload
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ReplyCallback(Success As Boolean, Message As String, Details As Variant, HTTPStatus As Integer, RawReply As String)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Sign(Identity As Beacon.Identity)
		  Dim Content As String = Self.mMethod + &u10 + Self.mURL
		  If Self.mMethod = "GET" Then
		    If Self.mPayload <> "" Then
		      Content = Content + "?"
		    End If
		  Else
		    Content = Content + &u10
		  End If
		  Content = Content + Self.mPayload.StringValue(0, Self.mPayload.Size)
		  
		  Self.Authenticate(Identity.Identifier, EncodeHex(Identity.Sign(Content)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As String
		  Return Self.mURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function URLEncodeFormData(FormData As Dictionary) As String
		  Dim Parts() As String
		  Dim Fields() As Variant = FormData.Keys
		  For Each Field As Variant In Fields
		    Parts.Append(Beacon.URLEncode(Field) + "=" + Beacon.URLEncode(FormData.Value(Field)))
		  Next
		  Return Join(Parts, "&")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAuthHeader As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAuthPassword As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAuthUser As String
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
		Protected mURL As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
