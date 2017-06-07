#tag Class
Protected Class APIRequest
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
		Function CommandLineVersion() As Text
		  Dim Cmd As Text = "curl"
		  If Self.mMethod <> "GET" Then
		    Cmd = Cmd + " --request '" + Self.Method + "' --data '" + Self.mPayload + "' --header 'Content-Type: " + Self.mContentType + "'"
		  End If
		  If Self.mAuthUser <> "" And Self.mAuthPassword <> "" Then
		    Cmd = Cmd + " --user " + Self.mAuthUser + ":" + Self.mAuthPassword
		  End If
		  Cmd = Cmd + " " + Self.URL
		  If Self.mMethod = "GET" And Self.mPayload <> "" Then
		    Cmd = Cmd + "?" + Self.mPayload
		  End If
		  Return Cmd
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text, Method As Text, Callback As APIRequest.ReplyCallback)
		  Self.Constructor(Path, Method, New Xojo.Core.Dictionary, Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text, Method As Text, Payload As Text, ContentType As Text, Callback As APIRequest.ReplyCallback)
		  If Path.IndexOf("://") = -1 Then
		    Path = Beacon.WebURL + "/api/" + Path
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
		Sub Constructor(Path As Text, Method As Text, Payload As Xojo.Core.Dictionary, Callback As APIRequest.ReplyCallback)
		  Dim Parts() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In Payload
		    Parts.Append(Self.URLEncode(Entry.Key) + "=" + Self.URLEncode(Entry.Value))
		  Next
		  
		  Self.Constructor(Path, Method, Text.Join(Parts, "&"), "application/x-www-form-urlencoded", Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentType() As Text
		  Return Self.mContentType
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InvokeCallback(Success As Boolean, Message As Text, Details As Auto)
		  Self.mCallback.Invoke(Success, Message, Details)
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
		  Return Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Self.mPayload)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PHPVersion() As Text
		  Dim EOL As Text
		  #if TargetWin32
		    EOL = Text.FromUnicodeCodepoint(13) + Text.FromUnicodeCodepoint(10)
		  #else
		    EOL = Text.FromUnicodeCodepoint(10)
		  #endif
		  
		  Dim Authenticated As Boolean = Self.mAuthUser <> "" And Self.mAuthPassword <> ""
		  
		  Dim Lines() As Text
		  
		  Lines.Append("$url = '" + Self.URL.ReplaceAll("'", "\'") + "';")
		  Lines.Append("$method = '" + Self.Method.ReplaceAll("'", "\'").Uppercase + "';")
		  Lines.Append("$body = '" + Self.Query.ReplaceAll("'", "\'") + "';")
		  
		  If Authenticated Then
		    Lines.Append("")
		    If Self.mMethod = "GET" Then
		      If Self.mPayload <> "" Then
		        Lines.Append("$auth = $method . chr(10) . $url . '?' . $body;")
		      Else
		        Lines.Append("$auth = $method . chr(10) . $url;")
		      End If
		    Else
		      Lines.Append("$auth = $method . chr(10) . $url  . chr(10) . $body;")
		    End If
		    Lines.Append("// Change Myself.beaconidentiy to point to your identity file!")
		    Lines.Append("$identity = json_decode(file_get_contents('Myself.beaconidentity'), true);")
		    Lines.Append("$username = $identity['Identifier'];")
		    Lines.Append("$private_key = $identity['Private'];")
		    Lines.Append("$private_key = trim(chunk_split(base64_encode(hex2bin($private_key)), 64, ""\n""));")
		    Lines.Append("$private_key = ""-----BEGIN RSA PRIVATE KEY-----\n$private_key\n-----END RSA PRIVATE KEY-----"";")
		    Lines.Append("openssl_sign($auth, $password, $private_key) or die('Unable to authenticate action');")
		  End If
		  
		  Lines.Append("")
		  Lines.Append("$http = curl_init();")
		  Lines.Append("curl_setopt($http, CURLOPT_URL, $url);")
		  Lines.Append("curl_setopt($http, CURLOPT_RETURNTRANSFER, 1);")
		  If Self.mMethod <> "GET" Then
		    Lines.Append("curl_setopt($http, CURLOPT_CUSTOMREQUEST, $method);")
		    Lines.Append("curl_setopt($http, CURLOPT_POSTFIELDS, $body);")
		    Lines.Append("curl_setopt($http, CURLOPT_HTTPHEADER, array('Content-Type: " + Self.ContentType.ReplaceAll("'", "\'") + "'));")
		  End If
		  If Authenticated Then
		    Lines.Append("curl_setopt($http, CURLOPT_USERPWD, $username . ':' . bin2hex($password));")
		  End If
		  Lines.Append("$response = curl_exec($http);")
		  Lines.Append("$http_status = curl_getinfo($http, CURLINFO_HTTP_CODE);")
		  Lines.Append("curl_close($http);")
		  
		  Return Text.Join(Lines, EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Query() As Text
		  Return Self.mPayload
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ReplyCallback(Success As Boolean, Message As Text, Details As Auto)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Sign(Identity As Beacon.Identity)
		  Dim Content As Text = Self.mMethod + Text.FromUnicodeCodepoint(10) + Self.mURL
		  If Self.mMethod = "GET" Then
		    If Self.mPayload <> "" Then
		      Content = Content + "?"
		    End If
		  Else
		    Content = Content + Text.FromUnicodeCodepoint(10)
		  End If
		  Content = Content + Self.mPayload
		  
		  Self.mAuthUser = Identity.Identifier
		  Self.mAuthPassword = Beacon.EncodeHex(Identity.Sign(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Content)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As Text
		  Return Self.mURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function URLEncode(Value As Text) As Text
		  Dim Encoded() As Text
		  For Each CodePoint As UInt32 In Value.Codepoints
		    If (CodePoint >= 48 And CodePoint <= 57) Or (CodePoint >= 65 And CodePoint <= 90) Or (CodePoint >= 97 And CodePoint <= 122) Then
		      Encoded.Append(Text.FromUnicodeCodepoint(CodePoint))
		    Else
		      Encoded.Append("%" + CodePoint.ToHex(2))
		    End If
		  Next
		  Return Text.Join(Encoded, "")
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		AuthCount As Integer
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
		Protected mPayload As Text
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mURL As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AuthCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
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
