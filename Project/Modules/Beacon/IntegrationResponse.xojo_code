#tag Class
Protected Class IntegrationResponse
	#tag Method, Flags = &h0
		Sub Constructor(Socket As SimpleHTTP.SynchronousHTTPSocket)
		  Self.mHTTPStatus = Socket.LastHTTPStatus
		  Self.mUrl = Socket.LastURL
		  Self.mError = Socket.LastException
		  If (Socket.LastContent Is Nil) = False Then
		    Self.mContent = Socket.LastContent
		  End If
		  
		  // This is not fantastic because duplicate headers are a thing and a Dictionary won't support that
		  Self.mHeaders = New Dictionary
		  For Each Header As Pair In Socket.ResponseHeaders
		    Self.mHeaders.Value(Header.Left) = Header.Right
		  Next
		  
		  Select Case Self.mHTTPStatus
		  Case 200, 201, 202, 204
		    Self.VerifyChecksum()
		    Return
		  End Select
		  
		  Var SocketErr As RuntimeException = Socket.LastException
		  If SocketErr Is Nil Then
		    Var Err As New Beacon.IntegrationException
		    Err.ErrorNumber = Self.mHTTPStatus
		    
		    Var IsUnknown As Boolean
		    Select Case Self.mHTTPStatus
		    Case 401
		      Err.Message = "The connection between Beacon and your host is no longer valid and must be replaced. Use the 'Account Control Panel' option from the user menu in the top right corner of Beacon to access your account, then choose the 'Connections' section."
		    Case 406
		      Err.Message = "The file was not uploaded correctly. This usually means the connection was dropped during transfer. If this issue persists, contact your hosting provider."
		    Case 429
		      Err.Message = "Rate limit has been exceeded."
		    Case 503
		      Err.Message = "Your host is offline for maintenance."
		    Case 502, 504
		      Err.Message = "Your host appears to be having an unplanned outage."
		    Case 500
		      Err.Message = "Internal server error."
		    Else
		      IsUnknown = True
		      Err.Message = "Unexpected HTTP status " + Err.ErrorNumber.ToString(Locale.Raw, "0") + "."
		    End Select
		    
		    RaiseEvent CustomizeError(Err, Socket, IsUnknown)
		    
		    If Err.Message.EndsWith(".") = False Then
		      Err.Message = Err.Message + "."
		    End If
		    
		    Self.mError = Err
		  Else
		    If SocketErr.Message.Contains("likely a bad url") Then
		      SocketErr.Message = "Beacon experienced a DNS error while trying to connect to your host's server. This is often an issue with your internet service provider."
		    ElseIf SocketErr.Message.IsEmpty Then
		      SocketErr.Message = "Connection Error #" + SocketErr.ErrorNumber.ToString(Locale.Raw, "0")
		    Else
		      SocketErr.Message = "Connection Error #" + SocketErr.ErrorNumber.ToString(Locale.Raw, "0") + ": " + SocketErr.Message
		    End If
		    
		    Self.mError = SocketErr
		  End If
		  
		  App.Log("Host API Error #" + Self.mError.ErrorNumber.ToString(Locale.Raw, "0") + ": " + Self.mError.Message)
		  App.Log("Url: " + Self.mUrl)
		  App.Log("Response: " + EncodeBase64MBS(Self.mContent))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Content() As String
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As RuntimeException
		  Return Self.mError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(Key As String) As Boolean
		  Return Self.mHeaders.HasKey(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Header(Key As String) As String
		  Return Self.mHeaders.Value(Key).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Header(Key As String, DefaultValue As String) As String
		  Return Self.mHeaders.Lookup(Key, DefaultValue).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HTTPStatus() As Integer
		  Return Self.mHTTPStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  If (Self.mError Is Nil) = False Then
		    Return Self.mError.Message
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Success() As Boolean
		  Return Self.mError Is Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Url() As String
		  Return Self.mUrl
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub VerifyChecksum()
		  If Self.mHeaders.HasKey("Repr-Digest") = False Then
		    Return
		  End If
		  
		  
		  Var Header As String = Self.mHeaders.Value("Repr-Digest")
		  Var Parts() As String = Header.Split(",")
		  For Each Part As String In Parts
		    Var Pos As Integer = Part.IndexOf("=")
		    If Pos = -1 Then
		      Self.mError = New Beacon.IntegrationException("Host sent a malformed Repr-Digest header.")
		      Return
		    End If
		    
		    Var Algo As String = Header.Left(Pos).Trim
		    Var ExpectedHash As String = Header.Middle(Pos + 1).Trim
		    If ExpectedHash.BeginsWith(":") Then
		      ExpectedHash = ExpectedHash.Middle(1)
		    End If
		    If ExpectedHash.EndsWith(":") Then
		      ExpectedHash = ExpectedHash.Left(ExpectedHash.Length - 1)
		    End If
		    
		    Var ComputedHash As String
		    Select Case Algo
		    Case "sha-512"
		      ComputedHash = EncodeBase64MBS(Crypto.SHA2_512(Content))
		    Case "sha-256"
		      ComputedHash = EncodeBase64MBS(Crypto.SHA2_256(Content))
		    Else
		      Continue
		    End Select
		    
		    If ExpectedHash.Compare(ComputedHash, ComparisonOptions.CaseSensitive) = 0 Then
		      Exit
		    Else
		      Self.mError = New Beacon.IntegrationException("Checksum does not match. This usually means the connection was interrupted. If this problem persists, please contact your hosting provider. Expected " + ExpectedHash + " but received " + ComputedHash + ".")
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CustomizeError(Err As Beacon.IntegrationException, Socket As SimpleHTTP.SynchronousHTTPSocket, IsUnknown As Boolean)
	#tag EndHook


	#tag Property, Flags = &h1
		Protected mContent As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHeaders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUrl As String
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
