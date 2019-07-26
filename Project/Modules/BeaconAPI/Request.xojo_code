#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Authenticate(Token As Text)
		  Self.mAuthHeader = "Session " + Token
		  Self.mAuthUser = ""
		  Self.mAuthPassword = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Authenticate(Username As Text, Password As Text)
		  Self.mAuthHeader = "Basic " + Beacon.EncodeBase64(Username + ":" + Password, Xojo.Core.TextEncoding.UTF8)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Authenticated() As Boolean
		  Return Self.mAuthHeader <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthHeader() As Text
		  Return Self.mAuthHeader
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthPassword() As Text
		  Return Self.mAuthPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AuthUser() As Text
		  Return Self.mAuthUser
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text, Method As Text, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, New Xojo.Core.Dictionary, Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text, Method As Text, Payload As Text, ContentType As Text, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Payload), ContentType, Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text, Method As Text, Payload As Xojo.Core.Dictionary, Callback As BeaconAPI.Request.ReplyCallback)
		  Self.Constructor(Path, Method, Self.URLEncodeFormData(Payload), "application/x-www-form-urlencoded", Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text, Method As Text, Payload As Xojo.Core.MemoryBlock, ContentType As Text, Callback As BeaconAPI.Request.ReplyCallback)
		  If Path.IndexOf("://") = -1 Then
		    Path = BeaconAPI.URL(Path)
		  End If
		  If Path.Length >= 8 And Path.Left(8) <> "https://" Then
		    Dim Err As New UnsupportedOperationException
		    Err.Reason = "Only https links are supported"
		    Raise Err
		  End If
		  
		  If Method = "GET" Or ContentType = "application/x-www-form-urlencoded" Then
		    Dim QueryIndex As Integer = Path.IndexOf("?")
		    If QueryIndex <> -1 Then
		      Dim Query As Text = Path.Mid(QueryIndex + 1)
		      If Payload <> Nil Then
		        Dim Mutable As New Xojo.Core.MutableMemoryBlock(Payload)
		        Mutable.Append(Xojo.Core.TextEncoding.UTF8.ConvertTextToData("&" + Query))
		        Payload = Mutable
		      Else
		        Payload = Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Query)
		      End If
		      Path = Path.Left(QueryIndex)
		    End If
		    ContentType = "application/x-www-form-urlencoded"
		  End If
		  
		  Self.mRequestID = Beacon.CreateUUID
		  Self.mURL = Path
		  Self.mMethod = Method.Uppercase
		  Self.mCallback = Callback
		  Self.mContentType = ContentType
		  Self.mPayload = Payload
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentType() As Text
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
		Function Method() As Text
		  Return Self.mMethod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Payload() As Xojo.Core.MemoryBlock
		  Return Self.mPayload
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Query() As Text
		  Return Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Self.mPayload, True)
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ReplyCallback(Request As BeaconAPI . Request, Response As BeaconAPI . Response)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function RequestID() As Text
		  Return Self.mRequestID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sign(Identity As Beacon.Identity)
		  Dim Content As Text = Self.mMethod + Text.FromUnicodeCodepoint(10) + Self.mURL
		  If Self.mMethod = "GET" Then
		    If Self.mPayload <> Nil And Self.mPayload.Size > 0 Then
		      Content = Content + "?"
		    End If
		  Else
		    Content = Content + Text.FromUnicodeCodepoint(10)
		  End If
		  
		  Dim Payload As New Xojo.Core.MutableMemoryBlock(0)
		  Payload.Append(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Content))
		  Payload.Append(Self.mPayload)
		  
		  Self.Authenticate(Identity.Identifier, Beacon.EncodeHex(Identity.Sign(Payload)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Text
		  Return Self.mURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function URLEncodeFormData(FormData As Xojo.Core.Dictionary) As Text
		  Dim Parts() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In FormData
		    Parts.Append(Beacon.EncodeURLComponent(Entry.Key) + "=" + Beacon.EncodeURLComponent(Entry.Value))
		  Next
		  Return Parts.Join("&")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAuthHeader As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAuthPassword As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAuthUser As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCallback As ReplyCallback
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentType As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMethod As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPayload As Xojo.Core.MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mRequestID As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mURL As Text
	#tag EndProperty


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
