#tag Class
Protected Class RCONSocket
	#tag Method, Flags = &h0
		Sub Connect(Host As String, Port As Integer, Password As String, Wait As Boolean = False)
		  If Self.mSocket.IsConnected Then
		    Return
		  End If
		  
		  Self.mHost = Host
		  Self.mPort = Port
		  Self.mPassword = Password
		  
		  If Wait Then
		    Call Self.SendSync("echo connected")
		  Else
		    Self.Send("echo connected")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New TCPSocket
		  AddHandler mSocket.Connected, WeakAddressOf mSocket_Connected
		  AddHandler mSocket.Error, WeakAddressOf mSocket_Error
		  
		  Self.mAsyncThread = New Beacon.Thread
		  Self.mAsyncThread.DebugIdentifier = "Beacon.RCONSocket.AsyncThread"
		  AddHandler mAsyncThread.Run, WeakAddressOf mAsyncThread_Run
		  AddHandler mAsyncThread.UserInterfaceUpdate, WeakAddressOf mAsyncThread_UserInterfaceUpdate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConnected() As Boolean
		  Return Self.mSocket.IsConnected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAsyncThread_Run(Sender As Beacon.Thread)
		  While True
		    If Self.mAsyncQueue.Count = 0 Then
		      Return
		    End If
		    
		    Var Message As Beacon.RCONMessage = Self.mAsyncQueue(0)
		    Self.mAsyncQueue.RemoveAt(0)
		    
		    Var Response As String = Self.SendSync(Message)
		    Var ResponseUpdate As New Dictionary
		    ResponseUpdate.Value("Event") = "ReplyReceived"
		    ResponseUpdate.Value("Message") = Message
		    ResponseUpdate.Value("Response") = Response
		    Sender.AddUserInterfaceUpdate(ResponseUpdate)
		    
		    Sender.Sleep(10)
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mAsyncThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Var EventName As String = Update.Value("Event")
		    Select Case EventName
		    Case "ReplyReceived"
		      Var Message As Beacon.RCONMessage = Update.Value("Message")
		      Var Response As String = Update.Value("Response")
		      RaiseEvent ReplyReceived(Message, Response)
		    End Select
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Connected(Sender As TCPSocket)
		  #Pragma Unused Sender
		  
		  System.DebugLog("RCON: Connected")
		  Self.mAuthenticated = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As TCPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  #Pragma Unused Err
		  
		  System.DebugLog("RCON: Disconnected with " + Err.ErrorNumber.ToString(Locale.Raw, "0"))
		  Self.mAuthenticated = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Message As Beacon.RCONMessage)
		  If Message Is Nil Then
		    Return
		  End If
		  
		  Self.mAsyncQueue.Add(Message)
		  
		  If Self.mAsyncThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.mAsyncThread.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Command As String)
		  Var Message As New Beacon.RCONMessage(Beacon.RCONMessage.TypeExecuteCommand, Command)
		  Self.Send(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendSync(Message As Beacon.RCONMessage) As String
		  If Message Is Nil Then
		    Return ""
		  End If
		  
		  Var CurrentThread As Global.Thread = Global.Thread.Current
		  If CurrentThread Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Do not execute RCON commands on the main thread"
		    Raise Err
		  End If
		  
		  Var GiveUpTime As Double
		  
		  If Self.mAuthenticated = False Then
		    Self.mSocket.Address = Self.mHost
		    Self.mSocket.Port = Self.mPort
		    Self.mSocket.Connect
		    
		    Var Failed As Boolean = True
		    GiveUpTime = System.Microseconds + Self.Timeout
		    Do
		      Self.mSocket.Poll
		      CurrentThread.Sleep(10)
		      If Self.mSocket.IsConnected Then
		        Failed = False
		        Exit
		      End If
		    Loop Until System.Microseconds > GiveUpTime
		    
		    If Failed Then
		      Break
		      Return ""
		    End If
		    
		    System.DebugLog("RCON: Sending password")
		    Var AuthMessage As New Beacon.RCONMessage(Beacon.RCONMessage.TypeAuth, Self.mPassword)
		    Self.mSocket.Write(AuthMessage.ByteValue)
		    System.DebugLog("RCON: Sent password")
		    Failed = True
		    GiveUpTime = System.Microseconds + Self.Timeout
		    
		    Var InitialAuthReply As Beacon.RCONMessage
		    Do
		      Self.mSocket.Poll
		      CurrentThread.Sleep(10)
		      
		      Var AuthReply As Beacon.RCONMessage = Beacon.RCONMessage.FromBuffer(Self.mSocket)
		      If AuthReply Is Nil Then
		        Continue
		      End If
		      
		      System.DebugLog("RCON: Received `" + EncodeHex(AuthReply.ByteValue) + "`")
		      
		      If AuthReply.Type = Beacon.RCONMessage.TypeResponseValue Then
		        // Partial success
		        System.DebugLog("RCON: Partial Success")
		        InitialAuthReply = AuthReply
		        Continue
		      ElseIf AuthReply.Type = Beacon.RCONMessage.TypeAuthResponse Then
		        // Success
		        If AuthReply.Id = AuthMessage.Id Then
		          Failed = False
		          Self.mAuthenticated = True
		          System.DebugLog("RCON: Authenticated with `" + AuthReply.Body + "`")
		        Else
		          System.DebugLog("RCON: Authentication failure")
		        End If
		      Else
		        // Failure
		        System.DebugLog("RCON: Unexpected auth reply")
		        Return ""
		      End If
		      
		      Exit
		    Loop Until System.Microseconds > GiveUpTime
		    
		    If Failed Then
		      Break
		      Return ""
		    End If
		  End If
		  
		  System.DebugLog("RCON: Sent `" + EncodeHex(Message.ByteValue) + "`")
		  
		  Var Detector As New Beacon.RCONMessage(Beacon.RCONMessage.TypeResponseValue, "")
		  
		  Self.mSocket.Write(Message.ByteValue)
		  Self.mSocket.Flush
		  Self.mSocket.Write(Detector.ByteValue)
		  
		  GiveUpTime = System.Microseconds + Self.Timeout
		  Var Response As String
		  Do
		    Self.mSocket.Poll
		    CurrentThread.Sleep(10)
		    
		    Var Buffer As String = Self.mSocket.Lookahead
		    If Buffer.IsEmpty = False Then
		      System.DebugLog("RCON: Buffer is now `" + EncodeHex(Buffer) + "`")
		    End If
		    
		    Do
		      Var Reply As Beacon.RCONMessage = Beacon.RCONMessage.FromBuffer(Self.mSocket)
		      If Reply Is Nil Then
		        Exit
		      End If
		      
		      System.DebugLog("RCON: Received `" + EncodeHex(Reply.ByteValue) + "`")
		      
		      If Reply.Id = Message.Id Then
		        Response = Response + Reply.Body
		      ElseIf Reply.Id = Detector.Id Then
		        // Multi-response is finished
		        System.DebugLog("RCON: Received `" + Response + "`")
		        Return Response
		      End If
		    Loop
		  Loop Until System.Microseconds > GiveUpTime
		  
		  System.DebugLog("RCON: Timed out. Buffer contents = `" + EncodeHex(Self.mSocket.Lookahead) + "`")
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendSync(Command As String) As String
		  Var Message As New Beacon.RCONMessage(Beacon.RCONMessage.TypeExecuteCommand, Command)
		  Return Self.SendSync(Message)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartAuthentication()
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReplyReceived(Message As Beacon.RCONMessage, Response As String)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAsyncQueue() As Beacon.RCONMessage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAsyncThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthenticated As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As TCPSocket
	#tag EndProperty


	#tag Constant, Name = Timeout, Type = Double, Dynamic = False, Default = \"30000000", Scope = Private
	#tag EndConstant


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
