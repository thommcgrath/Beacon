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
		Shared Function FromSocket(Socket As SimpleHTTP.SynchronousHTTPSocket) As Nitrado.APIResponse
		  Var Response As New Nitrado.APIResponse
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
		    Var Err As New Nitrado.APIException
		    Err.ErrorNumber = Response.mHTTPStatus
		    Select Case Response.mHTTPStatus
		      
		    Case 401
		      Err.Message = "Authorization failed."
		    Case 429
		      Err.Message = "Rate limit has been exceeded."
		    Case 503
		      Err.Message = "Nitrado is offline for maintenance."
		    Case 504
		      Err.Message = "Nitrado appears to be having an unplanned outage."
		    Case 500
		      Var TempMessage As String
		      If Response.mContent.IsEmpty = False Then
		        Try
		          Var Parsed As Variant = Beacon.ParseJSON(Response.mContent)
		          If Parsed.Type = Variant.TypeObject And Parsed.ObjectValue IsA Dictionary And Dictionary(Parsed.ObjectValue).HasKey("message") Then
		            TempMessage = Dictionary(Parsed.ObjectValue).Value("message").StringValue
		          End If
		        Catch ParseErr As RuntimeException
		        End Try
		      End If
		      If TempMessage = "The service is currently in state 4 but it expecting state 2,3." Then
		        Err.Message = TempMessage + " The service may be expired."
		      ElseIf TempMessage.IsEmpty = False Then
		        Err.Message = TempMessage
		      Else
		        Err.Message = "Nitrado responded with an error but no message."
		      End If
		    Else
		      Err.Message = "Unexpected HTTP status " + Err.ErrorNumber.ToString(Locale.Raw, "0")
		    End Select
		    
		    If Err.Message.EndsWith(".") = False Then
		      Err.Message = Err.Message + "."
		    End If
		    Err.Message = Err.Message + " Check the Nitrado API status at https://status.usebeacon.app/ for more information."
		    
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
		  
		  App.Log("Nitrado API Error #" + Response.mError.ErrorNumber.ToString(Locale.Raw, "0") + ": " + Response.mError.Message)
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
		#tag ViewProperty
			Name="mContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
