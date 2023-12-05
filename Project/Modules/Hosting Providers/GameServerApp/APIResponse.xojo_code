#tag Class
Private Class APIResponse
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
		Shared Function FromSocket(Socket As SimpleHTTP.SynchronousHTTPSocket) As GameServerApp.APIResponse
		  Var Response As New GameServerApp.APIResponse
		  Response.mHTTPStatus = Socket.LastHTTPStatus
		  Response.mUrl = Socket.LastURL
		  Response.mError = Socket.LastException
		  If (Socket.LastContent Is Nil) = False Then
		    Response.mContent = Socket.LastContent
		  End If
		  
		  Select Case Response.mHTTPStatus
		  Case 200, 201, 204
		    Return Response
		  End Select
		  
		  Var SocketErr As RuntimeException = Socket.LastException
		  If SocketErr Is Nil Then
		    Var Err As New GameServerApp.APIException
		    Err.ErrorNumber = Response.mHTTPStatus
		    Select Case Response.mHTTPStatus
		    Case 401
		      Err.Message = "GameServerApp.com rejected the API token."
		    Case 404
		      Err.Message = "GameServerApp.com endpoint not found."
		    Case 429
		      Err.Message = "GameServerApp.com rate limit exceeded."
		    Case 500
		      Err.Message= "GameServerApp.com internal server error."
		    Else
		      Err.Message = "Unexpected HTTP status " + Err.ErrorNumber.ToString(Locale.Raw, "0")
		    End Select
		    
		    If Err.Message.EndsWith(".") = False Then
		      Err.Message = Err.Message + "."
		    End If
		    
		    Response.mError = Err
		  Else
		    If SocketErr.Message.Contains("likely a bad url") Then
		      SocketErr.Message = "Beacon experienced a DNS error while trying to connect to its server. This is often an issue with your internet service provider."
		    ElseIf SocketErr.Message.IsEmpty Then
		      SocketErr.Message = "Connection Error #" + SocketErr.ErrorNumber.ToString(Locale.Raw, "0")
		    Else
		      SocketErr.Message = "Connection Error #" + SocketErr.ErrorNumber.ToString(Locale.Raw, "0") + ": " + SocketErr.Message
		    End If
		    
		    Response.mError = SocketErr
		  End If
		  
		  App.Log("GameServerApp.com API Error #" + Response.mError.ErrorNumber.ToString(Locale.Raw, "0") + ": " + Response.mError.Message)
		  App.Log("Url: " + Response.mUrl)
		  App.Log("Response: " + EncodeBase64MBS(Response.mContent))
		  
		  Return Response
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


	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUrl As String
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
