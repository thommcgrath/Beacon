#tag Class
Protected Class Socket
	#tag Method, Flags = &h1
		Protected Sub AdvanceQueue()
		  If UBound(Self.Queue) = -1 Then
		    Self.Working = False
		    Return
		  End If
		  
		  Dim Request As BeaconAPI.Request = Self.Queue(0)
		  Self.Queue.Remove(0)
		  
		  Self.ActiveRequest = Request
		  
		  #if TargetWin32
		    // The socket does not reset itself correctly on Windows, so create a new one
		    Self.Socket = New Xojo.Net.HTTPSocket
		    Self.Socket.ValidateCertificates = True
		    AddHandler Self.Socket.Error, WeakAddressOf Socket_Error
		    AddHandler Self.Socket.PageReceived, WeakAddressOf Socket_PageReceived
		    AddHandler Self.Socket.ReceiveProgress, WeakAddressOf Socket_ReceiveProgress
		  #else
		    Self.Socket.ClearRequestHeaders()
		  #endif
		  
		  Dim URL As Text = Request.URL
		  If Request.Authenticated Then
		    Self.Socket.RequestHeader("Authorization") = Request.AuthHeader
		  End If
		  
		  Self.Socket.RequestHeader("Cache-Control") = "no-cache"
		  
		  If Request.Method = "GET" Then
		    Dim Query As Text = Request.Query
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
		Sub Constructor()
		  Self.Socket = New Xojo.Net.HTTPSocket
		  Self.Socket.ValidateCertificates = True
		  AddHandler Self.Socket.Error, WeakAddressOf Socket_Error
		  AddHandler Self.Socket.PageReceived, WeakAddressOf Socket_PageReceived
		  AddHandler Self.Socket.ReceiveProgress, WeakAddressOf Socket_ReceiveProgress
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
		Private Sub Socket_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  Self.ActiveRequest.InvokeCallback(New BeaconAPI.Response(Err))
		  Self.ActiveRequest = Nil
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  Dim Response As New BeaconAPI.Response(URL, HTTPStatus, Content)
		  Self.ActiveRequest.InvokeCallback(Response)
		  Self.ActiveRequest = Nil
		  
		  Self.mAdvanceQueueCallbackKey = CallLater.Schedule(50, WeakAddressOf AdvanceQueue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_ReceiveProgress(Sender As Xojo.Net.HTTPSocket, BytesReceived As Int64, BytesTotal As Int64, NewData As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused NewData
		  
		  RaiseEvent WorkProgress(Self.ActiveRequest, BytesReceived, BytesTotal)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Request As BeaconAPI.Request)
		  Self.Queue.Append(Request)
		  If UBound(Self.Queue) = 0 And Self.Working = False Then
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
		Private Socket As Xojo.Net.HTTPSocket
	#tag EndProperty


	#tag Constant, Name = Notification_Unauthorized, Type = Text, Dynamic = False, Default = \"Beacon API Unauthorized", Scope = Public
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
