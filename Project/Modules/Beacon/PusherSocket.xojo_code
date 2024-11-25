#tag Class
Protected Class PusherSocket
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCallbacks = New Dictionary
		  Self.mState = Beacon.PusherSocket.States.Disconnected
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub EventHandler(ChannelName As String, EventName As String, EventBody As String)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Ignore(ChannelName As String, EventName As String, Callback As Beacon.PusherSocket.EventHandler)
		  Var CallbackKey As String = ChannelName.Lowercase + "+" + EventName.Lowercase
		  
		  If Self.mCallbacks.HasKey(CallbackKey) = False Then
		    Return
		  End If
		  
		  Var Callbacks() As EventHandler = Self.mCallbacks.Value(CallbackKey)
		  For Idx As Integer = Callbacks.LastIndex DownTo 0
		    If Callbacks(Idx) = Callback Then
		      Callbacks.RemoveAt(Idx)
		    End If
		  Next
		  
		  Self.mCallbacks.Value(CallbackKey) = Callbacks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSubscribed(Channel As String) As Boolean
		  Return Self.mChannels.IndexOf(Channel) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Listen(ChannelName As String, EventName As String, Callback As Beacon.PusherSocket.EventHandler)
		  Var CallbackKey As String = ChannelName.Lowercase + "+" + EventName.Lowercase
		  Var Callbacks() As EventHandler
		  If Self.mCallbacks.HasKey(CallbackKey) Then
		    Callbacks = Self.mCallbacks.Value(CallbackKey)
		  End If
		  Callbacks.Add(Callback)
		  Self.mCallbacks.Value(CallbackKey) = Callbacks
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRunThread_Run(Sender As Global.Thread)
		  Const SleepTime = 500
		  
		  ReconnectPoint:
		  
		  If Preferences.OnlineEnabled = False Then
		    Self.State = Beacon.PusherSocket.States.Disabled
		    Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		    Return
		  End If
		  
		  #if DebugBuild
		    Self.State = Beacon.PusherSocket.States.Disabled
		    Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		    Return
		  #endif
		  
		  Sender.YieldToNext
		  
		  Var ClusterId, AppKey As String
		  Try
		    Var Request As New BeaconAPI.Request("/pusher", "GET")
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    If Not Response.Success Then
		      App.Log("Could not fetch pusher credentials")
		      Self.State = Beacon.PusherSocket.States.Errored
		      Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		      Return
		    End If
		    
		    Var Dict As Dictionary = Response.Json
		    Var Enabled As Boolean = Dict.Lookup("enabled", False)
		    If Not Enabled Then
		      App.Log("Realtime communication is disabled")
		      Self.State = Beacon.PusherSocket.States.Disabled
		      Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		      Return
		    End If
		    Self.mRestartWaitPeriod = Dict.Lookup("restartWaitPeriod", 60000)
		    ClusterId = Dict.Value("cluster")
		    AppKey = Dict.Value("key")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Getting pusher credentials")
		    Self.State = Beacon.PusherSocket.States.Errored
		    Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		    Return
		  End Try
		  
		  Var LibraryPlatform As String
		  #if TargetMacOS
		    LibraryPlatform = "macos"
		  #elseif TargetWindows
		    LibraryPlatform = "windows"
		  #elseif TargetLinux
		    LibraryPlatform = "linux"
		  #elseif TargetiOS
		    LibraryPlatform = "ios"
		  #elseif TargetAndroid
		    LibraryPlatform = "android"
		  #else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Pusher platform is not defined"
		    Raise Err
		  #endif
		  
		  Var BugVersion As Integer = (App.BugVersion * 1000) + (App.StageCode * 100) + App.NonReleaseVersion
		  Var VersionString As String = App.MajorVersion.ToString(Locale.Raw, "0") + "." + App.MinorVersion.ToString(Locale.Raw, "0") + "." + BugVersion.ToString(Locale.Raw, "00000")
		  
		  Var Curl As New CURLSMBS
		  Curl.OptionUrl = "wss://ws-" + ClusterId + ".pusher.com:443/app/" + AppKey + "?protocol=7&client=" + LibraryPlatform + "-beacon&version=" + EncodeURLComponent(VersionString)
		  Curl.OptionConnectOnly = 2
		  Curl.OptionConnectionTimeout = 5
		  Self.mCurl = Curl
		  
		  Var ErrCode As Integer = Curl.PerformMT
		  If ErrCode <> 0 Then
		    // Error
		    App.Log("Pusher socket error: " + Curl.LastErrorMessage)
		    Self.State = Beacon.PusherSocket.States.Errored
		    Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		    Return
		  End If
		  
		  Curl.OptionTimeOut = 2
		  
		  Var LastExchangeTime As Double
		  Var SentPing As Boolean
		  Var ActivityTimeout As Integer = 120
		  Var PongWaitTime As Integer = 30
		  Var ShouldReconnect As Boolean
		  Self.State = Beacon.PusherSocket.States.Connected
		  While Self.mStopped = False
		    ShouldReconnect = False
		    
		    If Self.mPendingMessages.Count > 0 Then
		      Var Dict As Dictionary = Self.mPendingMessages(0)
		      Self.mPendingMessages.RemoveAt(0)
		      
		      Var BytesSent As Integer = Curl.WebSocketSend(Beacon.GenerateJson(Dict, False), 0, 1)
		      If BytesSent = 0 Then
		        // Error
		      End
		    End If
		    
		    Var Now As Double = DateTime.Now.SecondsFrom1970
		    If LastExchangeTime = 0 Then
		      LastExchangeTime = Now
		    End If
		    
		    Var Message As CURLSWebSocketFrameMBS = Curl.WebSocketReceive
		    If Message Is Nil Then
		      If SentPing = False And Now - LastExchangeTime > ActivityTimeout Then
		        Call Curl.WebSocketSend("", 0, CURLSWebSocketFrameMBS.kFlagPing)
		        #if DebugBuild
		          System.DebugLog("Sent ping")
		        #endif
		        SentPing = True
		      ElseIf SentPing = True And Now - LastExchangeTime > ActivityTimeout + PongWaitTime Then
		        // Connection has failed
		        App.Log("Pusher connection failed to respond to ping messages.")
		        ShouldReconnect = True
		        Exit While
		      End If
		      
		      Sender.Sleep(SleepTime)
		      Continue
		    End If
		    
		    LastExchangeTime = Now
		    SentPing = False
		    
		    If Message.FlagPing Then
		      Call Curl.WebSocketSend("", 0, CURLSWebSocketFrameMBS.kFlagPong)
		      #if DebugBuild
		        System.DebugLog("Sent pong")
		      #endif
		      Sender.Sleep(SleepTime)
		      Continue
		    ElseIf Message.FlagPong Then
		      #if DebugBuild
		        System.DebugLog("Received pong")
		      #endif
		      Sender.Sleep(SleepTime)
		      Continue
		    End If
		    
		    Try
		      Var Json As New JSONItem(Message.Data)
		      If Json.HasKey("event") = False Or Json.HasKey("data") = False Then
		        #if DebugBuild
		          System.DebugLog("Received a message I don't understand")
		        #endif
		        Sender.Sleep(SleepTime)
		        Continue
		      End If
		      
		      Var EventName As String = Json.Value("event")
		      Var Data As JsonItem
		      Try
		        If Json.HasKey("data") Then
		          Var Payload As Variant = Json.Value("data")
		          Select Case Payload.Type
		          Case Variant.TypeString
		            Data = New JsonItem(Payload.StringValue)
		          Case Variant.TypeObject
		            Data = JsonItem(Payload.ObjectValue)
		          End Select
		        End If
		      Catch Err As RuntimeException
		      End Try
		      
		      Select Case EventName
		      Case "pusher:connection_established"
		        Self.mSocketId = Data.Value("socket_id")
		        ActivityTimeout = Data.Lookup("activity_timeout", ActivityTimeout)
		        #if DebugBuild
		          System.DebugLog("Connected, socket is " + Self.mSocketId)
		        #endif
		      Case "pusher:error"
		        Var ErrorCode As Integer = Data.Value("code")
		        Var ErrorMessage As String = Data.Value("message")
		        App.Log("Pusher error #" + ErrorCode.ToString(Locale.Raw, "0") + ": " + ErrorMessage)
		        ShouldReconnect = True
		      Else
		        If Json.HasKey("channel") Then
		          Var ChannelName As String = Json.Value("channel")
		          Var EventDict As New Dictionary
		          EventDict.Value("Event") = EventName
		          EventDict.Value("Channel") = ChannelName
		          If (Data Is Nil) = False Then
		            EventDict.Value("Payload") = Data.ToString
		          Else
		            EventDict.Value("Payload") = Nil
		          End If
		          Sender.AddUserInterfaceUpdate(EventDict)
		        End If
		      End Select
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Receiving event from pusher")
		      If (Message.Data Is Nil) = False And Message.Data.Size > 0 Then
		        App.Log("Pusher data: " + EncodeBase64MBS(Message.Data))
		      Else
		        App.Log("No message from pusher")
		      End If
		      ShouldReconnect = True
		    End Try
		    
		    Sender.Sleep(500)
		    
		    If ShouldReconnect Then
		      Exit While
		    End If
		  Wend
		  Self.State = Beacon.PusherSocket.States.Disconnected
		  Self.mCurl = Nil
		  
		  If ShouldReconnect Then
		    // Resubscribe to channels
		    For Each Channel As String In Self.mChannels
		      Self.mPendingMessages.Add(New Dictionary("event": "pusher:subscribe", "data": New Dictionary("channel": Channel)))
		    Next
		    GoTo ReconnectPoint
		  End If
		  
		  Self.mThreadStopTime = DateTime.Now.SecondsFrom1970
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mRunThread_UserInterfaceUpdate(Sender As Global.Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.HasAllKeys("Channel", "Event", "Payload") Then
		        Var ChannelName As String = Update.Value("Channel")
		        Var EventName As String = Update.Value("Event")
		        Var Payload As String = Update.Value("Payload")
		        Var CallbackKey As String = ChannelName.Lowercase + "+" + EventName.Lowercase
		        
		        If Self.mCallbacks.HasKey(CallbackKey) Then
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
		        End If
		      End If
		    Catch UpdateErr As RuntimeException
		      App.Log(UpdateErr, CurrentMethodName, "Processing event from pusher thread")
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RestartWaitPeriod() As Integer
		  Return Self.mRestartWaitPeriod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketId() As String
		  Return Self.mSocketId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Force As Boolean = False)
		  Var UserId As String = App.IdentityManager.CurrentUserId
		  If UserId.IsEmpty Then
		    Return
		  End If
		  
		  If Not (Force = True Or Self.mRunThread Is Nil Or (Self.mRunThread.ThreadState = Thread.ThreadStates.NotRunning And Self.mThreadStopTime + (Self.mRestartWaitPeriod / 1000) < DateTime.Now.SecondsFrom1970)) Then
		    Return
		  End If
		  
		  System.DebugLog("Starting new pusher thread")
		  
		  Self.mStopped = False
		  Self.mSocketId = ""
		  Self.mCallbacks = New Dictionary
		  Self.mPendingMessages.ResizeTo(-1)
		  Self.Subscribe(Self.UserChannelName(UserId))
		  
		  Var RunThread As New Global.Thread
		  AddHandler RunThread.Run, AddressOf mRunThread_Run
		  AddHandler RunThread.UserInterfaceUpdate, AddressOf mRunThread_UserInterfaceUpdate
		  RunThread.Start
		  Self.mRunThread = RunThread
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function State() As Beacon.PusherSocket.States
		  Return Self.mState
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub State(Assigns Value As Beacon.PusherSocket.States)
		  If Self.mState = Value Then
		    Return
		  End If
		  
		  Self.mState = Value
		  NotificationKit.Post(Self.Notification_StateChanged, Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  Self.mStopped = True
		  Self.mSocketId = ""
		  Self.mCallbacks = Nil
		  
		  If (Self.mCurl Is Nil) = False Then
		    Self.mCurl.Cancel = True
		    Self.mCurl = Nil
		  End If
		  
		  If (Self.mRunThread Is Nil) = False Then
		    RemoveHandler mRunThread.Run, AddressOf mRunThread_Run
		    RemoveHandler mRunThread.UserInterfaceUpdate, AddressOf mRunThread_UserInterfaceUpdate
		    Self.mRunThread = Nil
		  End If
		  
		  System.DebugLog("Pusher has been stopped")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Subscribe(Channel As String)
		  If Self.IsSubscribed(Channel) Then
		    Return
		  End If
		  
		  Self.mPendingMessages.Add(New Dictionary("event": "pusher:subscribe", "data": New Dictionary("channel": Channel)))
		  Self.mChannels.Add(Channel)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ThreadStopTime() As Double
		  Return Self.mThreadStopTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unsubscribe(Channel As String)
		  Var Idx As Integer = Self.mChannels.IndexOf(Channel)
		  If Idx > -1 Then
		    Self.mPendingMessages.Add(New Dictionary("event": "pusher:unsubscribe", "data": New Dictionary("channel": Channel)))
		    Self.mChannels.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function UserChannelName(UserId As String) As String
		  Return "user-" + UserId.ReplaceAll("-", "").Lowercase
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCallbacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChannels() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurl As CURLSMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingMessages() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRestartWaitPeriod As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunThread As Global.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocketId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mState As Beacon.PusherSocket.States
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStopped As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreadStopTime As Double
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
