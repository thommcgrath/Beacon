#tag Class
Protected Class Socket
	#tag Method, Flags = &h1
		Protected Sub AdvanceQueue()
		  If Self.Queue.LastIndex = -1 Then
		    Self.Working = False
		    Return
		  End If
		  
		  Var Request As BeaconAPI.Request = Self.Queue(0)
		  Var AuthHeader As String
		  If Request.RequiresAuthentication Then
		    If Request.RequestHeader("Authorization").IsEmpty = False Then
		      AuthHeader = Request.RequestHeader("Authorization")
		    Else
		      Var Token As BeaconAPI.OAuthToken = Preferences.BeaconAuth
		      If (Token Is Nil) = False Then
		        If Token.AccessTokenExpired Then
		          // insert a new refresh request
		          Var Params As New Dictionary
		          Params.Value("grant_type") = "refresh_token"
		          Params.Value("client_id") = BeaconAPI.ClientId
		          Params.Value("refresh_token") = Token.RefreshToken
		          Params.Value("scope") = Token.Scope
		          
		          Request = New BeaconAPI.Request("/login", "POST", Params, AddressOf APICallback_RefreshToken)
		          Request.RequiresAuthentication = False
		          Self.Queue.AddAt(0, Request)
		        Else
		          AuthHeader = Token.AuthHeaderValue
		        End If
		      End If
		    End If
		  End If
		  Self.Queue.RemoveAt(0)
		  
		  Self.ActiveRequest = Request
		  
		  Self.Constructor()
		  
		  Var URL As String = SetupSocket(Self.Socket, Request, AuthHeader)
		  Self.Socket.Send(Request.Method, URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_RefreshToken(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.HTTPStatus = 201 Then
		    Var Token As BeaconAPI.OAuthToken = BeaconAPI.OAuthToken.Load(Response.Content)
		    Preferences.BeaconAuth = Token
		  Else
		    Preferences.BeaconAuth = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Socket = New URLConnection
		  Self.Socket.AllowCertificateValidation = True
		  AddHandler Self.Socket.Error, WeakAddressOf Socket_Error
		  AddHandler Self.Socket.ContentReceived, WeakAddressOf Socket_ContentReceived
		  AddHandler Self.Socket.ReceivingProgressed, WeakAddressOf Socket_ReceivingProgressed
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mAdvanceQueueCallbackKey)
		  
		  Self.Socket.Disconnect
		  Self.Socket = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  Var Headers As New Dictionary
		  For Each Header As Pair In Sender.ResponseHeaders
		    Headers.Value(Header.Left) = Header.Right
		  Next
		  
		  Var Response As New BeaconAPI.Response(URL, HTTPStatus, Content, Headers)
		  #if DebugBuild
		    System.DebugLog(Self.ActiveRequest.Method + " " + URL + ": " + HTTPStatus.ToString(Locale.Raw, "0"))
		  #endif
		  Self.ActiveRequest.InvokeCallback(Response)
		  Self.ActiveRequest = Nil
		  
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(10, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.ActiveRequest.InvokeCallback(New BeaconAPI.Response(Err))
		  Self.ActiveRequest = Nil
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(10, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ReceivingProgressed(Sender As URLConnection, BytesReceived As Int64, BytesTotal As Int64, NewData As String)
		  #Pragma Unused Sender
		  #Pragma Unused NewData
		  
		  RaiseEvent WorkProgress(Self.ActiveRequest, BytesReceived, BytesTotal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Request As BeaconAPI.Request)
		  Self.Queue.Add(Request)
		  If Self.Queue.LastIndex = 0 And Self.Working = False Then
		    Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
		    Self.Working = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Working() As Boolean
		  Return Self.mWorking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Working(Assigns Value As Boolean)
		  If Self.mWorking = Value Then
		    Return
		  End If
		  
		  Self.mWorking = Value
		  If Self.mWorking Then
		    RaiseEvent WorkStarted
		  Else
		    RaiseEvent WorkCompleted
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event WorkCompleted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkProgress(Request As BeaconAPI.Request, BytesReceived As Int64, BytesTotal As Int64)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkStarted()
	#tag EndHook


	#tag Property, Flags = &h21
		Private ActiveRequest As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAdvanceQueueCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Queue() As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Socket As URLConnection
	#tag EndProperty


	#tag Constant, Name = Notification_Unauthorized, Type = String, Dynamic = False, Default = \"Beacon API Unauthorized", Scope = Public
	#tag EndConstant


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
