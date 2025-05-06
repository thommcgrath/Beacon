#tag Class
Protected Class PusherSocket
	#tag Method, Flags = &h21
		Private Sub APICallback_ChannelAuth(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Try
		    Var Message As JSONItem = Request.Tag
		    Var FormData As Dictionary = SimpleHTTP.ParseFormData(Request.Payload)
		    
		    If Self.mActiveThread Is Nil Or Self.mActiveThread.IsConnected = False Then
		      App.Log("Got channel auth response, but pusher is not connected.")
		      Return
		    End If
		    
		    If FormData.Value("socket_id").StringValue <> Self.mActiveThread.SocketId Then
		      App.Log("Channel auth response is for a socket that is no longer connected. Authorized " + FormData.Value("socket_id").StringValue + ", but current socket is " + Self.mActiveThread.SocketId)
		      Return
		    End If
		    
		    If Not Response.Success Then
		      App.Log("Authorization failed for pusher channel " + Message.Child("data").Value("channel"))
		      App.Log("Server returned " + Response.HTTPStatus.ToString(Locale.Raw, "0") + ": " + EncodeBase64(Response.Content))
		      Return
		    End If
		    
		    
		    Var AuthData As New JSONItem(Response.Content)
		    Var Auth As String = AuthData.Value("auth")
		    Message.Child("data").Value("auth") = Auth
		    
		    Self.mLock.Enter
		    Self.mPendingMessages.Add(Message)
		    Self.mLock.Leave
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Failed to handle auth response")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Bind(EventName As String, Callback As Beacon.PusherSocket.EventHandler)
		  Self.mLock.Enter
		  If Self.mCallbacks Is Nil Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var CallbackKey As String = EventName.Lowercase
		  Var Callbacks() As EventHandler
		  If Self.mCallbacks.HasKey(CallbackKey) Then
		    Callbacks = Self.mCallbacks.Value(CallbackKey)
		  End If
		  Callbacks.Add(Callback)
		  Self.mCallbacks.Value(CallbackKey) = Callbacks
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLock = New CriticalSection
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub EventHandler(ChannelName As String, EventName As String, EventBody As String)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function IsSubscribed(Channel As String) As Boolean
		  Var Subscribed As Boolean
		  Self.mLock.Enter
		  Subscribed = Self.mChannels.IndexOf(Channel) > -1
		  Self.mLock.Leave
		  Return Subscribed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mActiveThread_Connected(Sender As Beacon.PusherThread)
		  #Pragma Unused Sender
		  
		  Self.mLock.Enter
		  Self.mPendingMessages.ResizeTo(-1)
		  For Each Channel As String In Self.mChannels
		    Var MessageData As New JSONItem
		    MessageData.Value("channel") = Channel
		    
		    Var Message As New JSONItem
		    Message.Value("event") = "pusher:subscribe"
		    Message.Value("data") = MessageData
		    
		    If Channel.BeginsWith("private-") Then
		      // Need to request auth from the API
		      Var FormData As New Dictionary
		      FormData.Value("socket_id") = Self.SocketId()
		      FormData.Value("channel_name") = Channel
		      
		      Var Request As New BeaconAPI.Request("/pusher/channelAuth", "POST", FormData, WeakAddressOf APICallback_ChannelAuth)
		      Request.Tag = Message
		      BeaconAPI.Send(Request)
		    Else
		      Self.mPendingMessages.Add(Message)
		    End If
		  Next
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mActiveThread_EventReceived(Sender As Beacon.PusherThread, ChannelName As String, EventName As String, Payload As String)
		  #Pragma Unused Sender
		  
		  Var CallbackKey As String = EventName.Lowercase
		  Self.mLock.Enter
		  If Self.mCallbacks.HasKey(CallbackKey) = False Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var Callbacks() As EventHandler = Self.mCallbacks.Value(CallbackKey)
		  For Idx As Integer = Callbacks.LastIndex DownTo 0
		    If Beacon.SafeToInvoke(Callbacks(Idx)) = False Then
		      Callbacks.RemoveAt(Idx)
		      Continue
		    End If
		    
		    Try
		      Callbacks(Idx).Invoke(ChannelName, EventName, Payload)
		    Catch CallbackErr As RuntimeException
		      App.Log(CallbackErr, CurrentMethodName, "Delivering event to listener")
		    End Try
		  Next
		  Self.mCallbacks.Value(CallbackKey) = Callbacks
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mActiveThread_GetNextPendingMessage(Sender As Beacon.PusherThread) As JSONItem
		  #Pragma Unused Sender
		  
		  Self.mLock.Enter
		  If Self.mPendingMessages.Count = 0 Then
		    Self.mLock.Leave
		    Return Nil
		  End If
		  
		  Var Message As JSONItem = Self.mPendingMessages(0)
		  Self.mPendingMessages.RemoveAt(0)
		  Self.mLock.Leave
		  Return Message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mActiveThread_StateChanged(Sender As Beacon.PusherThread, NewState As Beacon.PusherSocket.States)
		  #Pragma Unused Sender
		  
		  NotificationKit.Post(Self.Notification_StateChanged, NewState)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketId() As String
		  If (Self.mActiveThread Is Nil) = False Then
		    Return Self.mActiveThread.SocketId
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Force As Boolean = False)
		  Var UserId As String = App.IdentityManager.CurrentUserId
		  If UserId.IsEmpty Then
		    Return
		  End If
		  
		  Self.mLock.Enter
		  If Not (Force = True Or Self.mActiveThread Is Nil Or (Self.mActiveThread.ThreadState = Thread.ThreadStates.NotRunning And Self.mActiveThread.ResumeTime < DateTime.Now)) Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  If (Self.mActiveThread Is Nil) = False Then
		    Self.Stop()
		  End If
		  
		  System.DebugLog("Starting new pusher thread")
		  
		  Self.mCallbacks = New Dictionary
		  Self.mPendingMessages.ResizeTo(-1)
		  Self.Subscribe(Self.UserChannelName(UserId))
		  
		  Var ActiveThread As New Beacon.PusherThread
		  AddHandler ActiveThread.EventReceived, AddressOf mActiveThread_EventReceived
		  AddHandler ActiveThread.GetNextPendingMessage, AddressOf mActiveThread_GetNextPendingMessage
		  AddHandler ActiveThread.StateChanged, AddressOf mActiveThread_StateChanged
		  AddHandler ActiveThread.Connected, AddressOf mActiveThread_Connected
		  ActiveThread.Start
		  Self.mActiveThread = ActiveThread
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function State() As Beacon.PusherSocket.States
		  Self.mLock.Enter
		  Var ReturnValue As States
		  If (Self.mActiveThread Is Nil) = False Then
		    ReturnValue = Self.mActiveThread.State
		  Else
		    ReturnValue = States.Disconnected
		  End If
		  Self.mLock.Leave
		  Return ReturnValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  Self.mLock.Enter
		  If (Self.mActiveThread Is Nil) = False Then
		    Self.mActiveThread.Stop()
		    RemoveHandler mActiveThread.EventReceived, AddressOf mActiveThread_EventReceived
		    RemoveHandler mActiveThread.GetNextPendingMessage, AddressOf mActiveThread_GetNextPendingMessage
		    RemoveHandler mActiveThread.StateChanged, AddressOf mActiveThread_StateChanged
		    RemoveHandler mActiveThread.Connected, AddressOf mActiveThread_Connected
		    Self.mActiveThread = Nil
		  End If
		  
		  Self.mCallbacks = Nil
		  Self.mLock.Leave
		  
		  System.DebugLog("Pusher has been stopped")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Subscribe(Channel As String, Auth As String = "")
		  Self.mLock.Enter
		  If Self.IsSubscribed(Channel) Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Self.mChannels.Add(Channel)
		  
		  If (Self.mActiveThread Is Nil) = False And Self.mActiveThread.IsConnected Then
		    Var MessageData As New JSONItem
		    MessageData.Value("channel") = Channel
		    If Auth.IsEmpty = False Then
		      MessageData.Value("auth") = Auth
		    End If
		    
		    Var Message As New JSONItem
		    Message.Value("event") = "pusher:subscribe"
		    Message.Value("data") = MessageData
		    
		    If Channel.BeginsWith("private-") And Auth.IsEmpty Then
		      // Need to request auth from the API
		      Var FormData As New Dictionary
		      FormData.Value("socket_id") = Self.SocketId()
		      FormData.Value("channel_name") = Channel
		      
		      Var Request As New BeaconAPI.Request("/pusher/channelAuth", "POST", FormData, WeakAddressOf APICallback_ChannelAuth)
		      Request.Tag = Message
		      BeaconAPI.Send(Request)
		    Else
		      Self.mPendingMessages.Add(Message)
		    End If
		  End If
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unbind(EventName As String)
		  Self.mLock.Enter
		  If Self.mCallbacks Is Nil Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var CallbackKey As String = EventName.Lowercase
		  If Self.mCallbacks.HasKey(CallbackKey) = False Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Self.mCallbacks.Remove(CallbackKey)
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unbind(EventName As String, Callback As Beacon.PusherSocket.EventHandler)
		  Self.mLock.Enter
		  If Self.mCallbacks Is Nil Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var CallbackKey As String = EventName.Lowercase
		  If Self.mCallbacks.HasKey(CallbackKey) = False Then
		    Self.mLock.Leave
		    Return
		  End If
		  
		  Var Callbacks() As EventHandler = Self.mCallbacks.Value(CallbackKey)
		  For Idx As Integer = Callbacks.LastIndex DownTo 0
		    If Callbacks(Idx) = Callback Then
		      Callbacks.RemoveAt(Idx)
		    End If
		  Next
		  
		  Self.mCallbacks.Value(CallbackKey) = Callbacks
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unsubscribe(Channel As String)
		  Self.mLock.Enter
		  Var Idx As Integer = Self.mChannels.IndexOf(Channel)
		  If Idx > -1 Then
		    Self.mChannels.RemoveAt(Idx)
		    
		    If (Self.mActiveThread Is Nil) = False And Self.mActiveThread.IsConnected Then
		      Var MessageData As New JSONItem
		      MessageData.Value("channel") = Channel
		      
		      Var Message As New JSONItem
		      Message.Value("event") = "pusher:unsubscribe"
		      Message.Value("data") = MessageData
		      
		      Self.mPendingMessages.Add(Message)
		    End If
		  End If
		  Self.mLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function UserChannelName(UserId As String) As String
		  Return "private-users." + UserId.Lowercase
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mActiveThread As Beacon.PusherThread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCallbacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChannels() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingMessages() As JSONItem
	#tag EndProperty


	#tag Constant, Name = Notification_StateChanged, Type = String, Dynamic = False, Default = \"Pusher:StateChanged", Scope = Public
	#tag EndConstant


	#tag Enum, Name = States, Type = Integer, Flags = &h0
		Connected
		  Disconnected
		  Disabled
		Errored
	#tag EndEnum


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
