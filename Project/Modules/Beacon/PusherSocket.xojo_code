#tag Class
Protected Class PusherSocket
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mCallbacks = New Dictionary
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
		  If Preferences.OnlineEnabled = False Then
		    Return
		  End If
		  
		  Var ClusterId, AppKey As String
		  Try
		    Var Request As New BeaconAPI.Request("/pusher", "GET")
		    Request.AutoRenew = False
		    
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    If Not Response.Success Then
		      App.Log("Could not fetch pusher credentials")
		      Return
		    End If
		    
		    Var Dict As Dictionary = Response.Json
		    Var Enabled As Boolean = Dict.Lookup("enabled", False)
		    If Not Enabled Then
		      App.Log("Realtime communication is disabled")
		      Return
		    End If
		    ClusterId = Dict.Value("cluster")
		    AppKey = Dict.Value("key")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Getting pusher credentials")
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
		    Return
		  End If
		  
		  Curl.OptionTimeOut = 2
		  
		  Var LastExchangeTime As Double
		  Var SentPing As Boolean
		  Var ActivityTimeout As Integer = 120
		  Var PongWaitTime As Integer = 30
		  While Self.mStopped = False
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
		        Exit While
		      End If
		      
		      Sender.Sleep(500)
		      Continue
		    End If
		    
		    LastExchangeTime = Now
		    SentPing = False
		    
		    If Message.FlagPing Then
		      Call Curl.WebSocketSend("", 0, CURLSWebSocketFrameMBS.kFlagPong)
		      #if DebugBuild
		        System.DebugLog("Sent pong")
		      #endif
		      Continue
		    ElseIf Message.FlagPong Then
		      #if DebugBuild
		        System.DebugLog("Received pong")
		      #endif
		      Continue
		    End If
		    
		    Try
		      Var Json As Dictionary = Beacon.ParseJson(Message.Data)
		      Var EventName As String = Json.Value("event")
		      Select Case EventName
		      Case "pusher:connection_established"
		        Var ConnectionInfo As Dictionary = Beacon.ParseJson(Json.Value("data").StringValue)
		        Self.mSocketId = ConnectionInfo.Value("socket_id")
		        ActivityTimeout = ConnectionInfo.Lookup("activity_timeout", ActivityTimeout)
		        #if DebugBuild
		          System.DebugLog("Connected, socket is " + Self.mSocketId)
		        #endif
		      Else
		        Var ChannelName As String = Json.Value("channel")
		        Sender.AddUserInterfaceUpdate(New Dictionary("Channel": ChannelName, "Event": EventName, "Payload": Json.Value("data")))
		      End Select
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Receiving event from pusher")
		    End Try
		  Wend
		  
		  Self.mCurl = Nil
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
		Function SocketId() As String
		  Return Self.mSocketId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Identity As Beacon.Identity)
		  If Identity Is Nil Then
		    Return
		  End If
		  
		  Self.Start(Identity.UserId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(UserId As String)
		  If UserId.IsEmpty Then
		    Return
		  End If
		  
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Subscribe(Channel As String)
		  Self.mPendingMessages.Add(New Dictionary("event": "pusher:subscribe", "data": New Dictionary("channel": Channel)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unsubscribe(Channel As String)
		  Self.mPendingMessages.Add(New Dictionary("event": "pusher:unsubscribe", "data": New Dictionary("channel": Channel)))
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
		Private mCurl As CURLSMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingMessages() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunThread As Global.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocketId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStopped As Boolean
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
