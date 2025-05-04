#tag Class
Protected Class PusherThread
Inherits Global.Thread
	#tag Event
		Sub Run()
		  Try
		    Self.RunHandler()
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Running pusher socket thread")
		    Self.State = Beacon.PusherSocket.States.Errored
		  End Try
		  
		  #if DebugBuild
		    System.DebugLog("Pusher thread " + Self.ThreadID.ToString(Locale.Raw, "0") + " has finished")
		  #endif
		  
		  Self.mLock.Enter
		  Self.mStopTime = DateTime.Now.SecondsFrom1970
		  Self.mLock.Leave
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  For Each Update As Dictionary In Data
		    Try
		      If Update.HasAllKeys("Channel", "Event", "Payload") Then
		        Var ChannelName As String = Update.Value("Channel")
		        Var EventName As String = Update.Value("Event")
		        Var Payload As String = Update.Value("Payload")
		        RaiseEvent EventReceived(ChannelName, EventName, Payload)
		      End If
		    Catch UpdateErr As RuntimeException
		      App.Log(UpdateErr, CurrentMethodName, "Processing event from pusher thread")
		    End Try
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLock = New CriticalSection
		  Self.mState = Beacon.PusherSocket.States.Disconnected
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConnected() As Boolean
		  Return Self.State = Beacon.PusherSocket.States.Connected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResumeTime() As DateTime
		  Var Time As DateTime
		  Self.mLock.Enter
		  Time = New DateTime(Self.mStopTime + (Self.mWaitPeriod / 1000))
		  Self.mLock.Leave
		  Return Time
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunHandler()
		  Const SleepTime = 250
		  
		  ReconnectPoint:
		  
		  If Preferences.OnlineEnabled = False Then
		    Self.State = Beacon.PusherSocket.States.Disabled
		    Return
		  End If
		  
		  #if DebugBuild
		    Self.State = Beacon.PusherSocket.States.Disabled
		    Return
		  #endif
		  
		  Self.YieldToNext
		  
		  Var ClusterId, AppKey As String
		  Try
		    Var Request As New BeaconAPI.Request("/pusher", "GET")
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    If Response.HTTPStatus = 401 Or Response.HTTPStatus = 403 Then
		      Self.State = Beacon.PusherSocket.States.Disabled
		      Return
		    ElseIf Response.Success = False Then
		      App.Log("Could not fetch pusher credentials")
		      Self.State = Beacon.PusherSocket.States.Errored
		      Return
		    End If
		    
		    Var Dict As Dictionary = Response.Json
		    Var Enabled As Boolean = Dict.Lookup("enabled", False)
		    If Not Enabled Then
		      App.Log("Realtime communication is disabled")
		      Self.State = Beacon.PusherSocket.States.Disabled
		      Return
		    End If
		    Self.mLock.Enter
		    Self.mWaitPeriod = Dict.Lookup("restartWaitPeriod", 60000)
		    Self.mLock.Leave
		    ClusterId = Dict.Value("cluster")
		    AppKey = Dict.Value("key")
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Getting pusher credentials")
		    Self.State = Beacon.PusherSocket.States.Errored
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
		    Return
		  End If
		  
		  Curl.OptionTimeOut = 2
		  
		  Var LastExchangeTime As Double
		  Var SentPing As Boolean
		  Var ActivityTimeout As Integer = 120
		  Var PongWaitTime As Integer = 30
		  Var ShouldReconnect As Boolean
		  Self.State = Beacon.PusherSocket.States.Connected
		  While True
		    Self.mLock.Enter
		    If Self.mKeepRunning = False Then
		      Self.mLock.Leave
		      Exit
		    Else
		      Self.mLock.Leave
		    End If
		    
		    ShouldReconnect = False
		    
		    Var PendingMessage As JSONItem = RaiseEvent GetNextPendingMessage()
		    If (PendingMessage Is Nil) = False Then
		      PendingMessage.Compact = True
		      Call Curl.WebSocketSend(PendingMessage.ToString, 0, 1)
		      #if DebugBuild
		        System.DebugLog("Sent " + PendingMessage.ToString)
		      #endif
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
		      
		      Self.Sleep(SleepTime)
		      Continue
		    End If
		    
		    LastExchangeTime = Now
		    SentPing = False
		    
		    If Message.FlagPing Then
		      Call Curl.WebSocketSend("", 0, CURLSWebSocketFrameMBS.kFlagPong)
		      #if DebugBuild
		        System.DebugLog("Sent pong")
		      #endif
		      Self.Sleep(SleepTime)
		      Continue
		    ElseIf Message.FlagPong Then
		      #if DebugBuild
		        System.DebugLog("Received pong")
		      #endif
		      Self.Sleep(SleepTime)
		      Continue
		    End If
		    
		    Try
		      Var Json As New JSONItem(Message.Data)
		      If Json.HasKey("event") = False Or Json.HasKey("data") = False Then
		        #if DebugBuild
		          System.DebugLog("Received a message I don't understand")
		        #endif
		        Self.Sleep(SleepTime)
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
		        Self.mLock.Enter
		        Self.mSocketId = Data.Value("socket_id")
		        Self.mLock.Leave
		        ActivityTimeout = Data.Lookup("activity_timeout", ActivityTimeout)
		        #if DebugBuild
		          System.DebugLog("Connected, socket is " + Self.mSocketId)
		        #endif
		        RaiseEvent Connected()
		      Case "pusher:error"
		        Var ErrorCode As Integer = Data.Value("code")
		        Var ErrorMessage As String = Data.Value("message")
		        App.Log("Pusher error #" + ErrorCode.ToString(Locale.Raw, "0") + ": " + ErrorMessage)
		        ShouldReconnect = True
		      Case "reconnect"
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
		          Self.AddUserInterfaceUpdate(EventDict)
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
		    
		    Self.Sleep(500)
		    
		    If ShouldReconnect Then
		      Exit While
		    End If
		  Wend
		  Self.State = Beacon.PusherSocket.States.Disconnected
		  Self.mCurl = Nil
		  
		  If ShouldReconnect Then
		    GoTo ReconnectPoint
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketId() As String
		  Var SocketId As String
		  Self.mLock.Enter
		  SocketId = Self.mSocketId
		  Self.mLock.Leave
		  Return SocketId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  Self.mLock.Enter
		  Self.mKeepRunning = True
		  Self.mLock.Leave
		  Super.Start()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function State() As Beacon.PusherSocket.States
		  Var State As Beacon.PusherSocket.States
		  Self.mLock.Enter
		  State = Self.mState
		  Self.mLock.Leave
		  Return State
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub State(Assigns Value As Beacon.PusherSocket.States)
		  If Self.mState = Value Then
		    Return
		  End If
		  
		  Self.mState = Value
		  RaiseEvent StateChanged(Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  Self.mLock.Enter
		  Self.mKeepRunning = False
		  Self.mLock.Leave
		  Super.Stop()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StopTime() As Double
		  Var Time As Double
		  Self.mLock.Enter
		  Time = Self.mStopTime
		  Self.mLock.Leave
		  Return Time
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WaitPeriod() As Integer
		  Var Period As Integer
		  Self.mLock.Enter
		  Period = Self.mWaitPeriod
		  Self.mLock.Leave
		  Return Period
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Connected()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EventReceived(ChannelName As String, EventName As String, Payload As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetNextPendingMessage() As JSONItem
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StateChanged(NewState As Beacon.PusherSocket.States)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurl As CURLSMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeepRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocketId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mState As Beacon.PusherSocket.States
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStopTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWaitPeriod As Integer
	#tag EndProperty


	#tag ViewBehavior
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
			InitialValue=""
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
