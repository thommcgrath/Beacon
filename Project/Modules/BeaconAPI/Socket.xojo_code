#tag Class
Protected Class Socket
	#tag Method, Flags = &h1
		Protected Sub AdvanceQueue()
		  If Self.Queue.Ubound = -1 Then
		    Self.Working = False
		    Return
		  End If
		  
		  Dim Request As BeaconAPI.Request = Self.Queue(0)
		  Self.Queue.Remove(0)
		  
		  Self.ActiveRequest = Request
		  
		  Self.Socket = New URLConnection
		  AddHandler Self.Socket.Error, WeakAddressOf Socket_Error
		  AddHandler Self.Socket.ContentReceived, WeakAddressOf Socket_ContentReceived
		  AddHandler Self.Socket.ReceivingProgressed, WeakAddressOf Socket_ReceivingProgressed
		  
		  Dim URL As String = Request.URL
		  If Request.Authenticated Then
		    Self.Socket.RequestHeader("Authorization") = Request.AuthHeader
		  End If
		  
		  Self.Socket.RequestHeader("Cache-Control") = "no-cache"
		  
		  If Request.Method = "GET" Then
		    Dim Query As String = Request.Query
		    If Query <> "" Then
		      URL = URL + "?" + Query
		    End If
		    Self.Socket.Send("GET", URL)
		  Else
		    Self.Socket.SetRequestContent(Request.Payload, Request.ContentType)
		    Self.Socket.Send(Request.Method, URL)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mAdvanceQueueCallbackKey)
		  
		  If Self.Socket <> Nil Then
		    Self.Socket.Disconnect
		    Self.Socket = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ContentReceived(Sender As URLConnection, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Dim Details As Variant
		  If Content <> "" Then
		    Try
		      Details = Beacon.ParseJSON(Content)
		    Catch Err As UnsupportedFormatException
		      Dim Dict As New Dictionary
		      Dict.Value("message") = "Invalid JSON"
		      Dict.Value("details") = Content
		      Details = Dict
		      HTTPStatus = 500
		    End Try
		  Else
		    Details = New Dictionary
		  End If
		  
		  If HTTPStatus = 200 Then
		    Self.ActiveRequest.InvokeCallback(True, "", Details, HTTPStatus, Content)
		  Else
		    If HTTPStatus = 401 Or HTTPStatus = 403 Then
		      NotificationKit.Post(Self.Notification_Unauthorized, Self.ActiveRequest)
		    End If
		    
		    Dim Dict As Dictionary = Details
		    Dim Message As String = Dict.Lookup("message", "")
		    Details = Dict.Lookup("details", Nil)
		    Self.ActiveRequest.InvokeCallback(False, Message, Details, HTTPStatus, Content)
		  End If
		  
		  Self.ActiveRequest = Nil
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_Error(Sender As URLConnection, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.ActiveRequest.InvokeCallback(False, Err.Reason, Nil, 0, "")
		  Self.ActiveRequest = Nil
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
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
		  Self.Queue.Append(Request)
		  If Self.Queue.Ubound = 0 And Self.Working = False Then
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
