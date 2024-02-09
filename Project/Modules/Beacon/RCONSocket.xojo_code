#tag Class
Protected Class RCONSocket
	#tag Method, Flags = &h0
		Sub Connect(Host As String, Port As Integer, Password As String)
		  If Self.mSocket.IsConnected Then
		    Return
		  End If
		  
		  Self.mHost = Host
		  Self.mPort = Port
		  Self.mPassword = Password
		  
		  Self.mSocket.Address = Host
		  Self.mSocket.Port = Port
		  Self.mSocket.Connect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSocket = New TCPSocket
		  AddHandler mSocket.Connected, WeakAddressOf mSocket_Connected
		  AddHandler mSocket.DataAvailable, WeakAddressOf mSocket_DataAvailable
		  AddHandler mSocket.Error, WeakAddressOf mSocket_Error
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Disconnect()
		  Self.mSocket.Purge
		  Self.mSocket.Close
		  
		  Self.mMessages.RemoveAll
		  Self.mPendingMessages.RemoveAll
		  Self.mHost = ""
		  Self.mPassword = ""
		  Self.mAuthenticated = False
		  Self.mAuthMessage = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAuthenticated() As Boolean
		  Return Self.mAuthenticated
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConnected() As Boolean
		  Return Self.mSocket.IsConnected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Connected(Sender As TCPSocket)
		  #Pragma Unused Sender
		  
		  Self.mAuthenticated = False
		  RaiseEvent Connected
		  Self.StartAuthentication()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_DataAvailable(Sender As TCPSocket)
		  Do
		    Var Buffer As String = Sender.Lookahead
		    If Buffer.IsEmpty Then
		      Return
		    End If
		    
		    #if DebugBuild
		      System.DebugLog("RCON: Buffer is now `" + EncodeHex(Buffer) + "`")
		    #endif
		    
		    Var NewMessage As Beacon.RCONMessage = Beacon.RCONMessage.FromBuffer(Sender)
		    If NewMessage Is Nil Then
		      Return
		    End If
		    
		    #if DebugBuild
		      System.DebugLog("RCON: Received `" + EncodeHex(NewMessage.ByteValue) + "`")
		    #endif
		    
		    If Not Self.mAuthenticated Then
		      If NewMessage.Type = Beacon.RCONMessage.TypeResponseValue Then
		        // Partial success?
		      ElseIf NewMessage.Type = Beacon.RCONMessage.TypeAuthResponse Then
		        If NewMessage.Id = Self.mAuthMessage.Id Then
		          // Success
		          Self.mAuthenticated = True
		          Try
		            RaiseEvent Authenticated()
		          Catch Err As RuntimeException
		          End Try
		          
		          While Self.mPendingMessages.Count > 0
		            Var NextMessage As Beacon.RCONMessage = Self.mPendingMessages(0)
		            Self.mPendingMessages.RemoveAt(0)
		            Self.Send(NextMessage)
		          Wend
		          
		          #if DebugBuild
		            System.DebugLog("RCON: Authenticated with `" + NewMessage.Body + "`")
		          #endif
		        Else
		          // Failure
		          Try
		            RaiseEvent AuthenticationFailed()
		          Catch Err As RuntimeException
		          End Try
		          #if DebugBuild
		            System.DebugLog("RCON: Authentication failed.")
		          #endif
		        End If
		      Else
		        // Failure
		        Try
		          RaiseEvent AuthenticationFailed()
		        Catch Err As RuntimeException
		        End Try
		        #if DebugBuild
		          System.DebugLog("RCON: Unexpected auth reply.")
		        #endif
		      End If
		      Continue
		    End If
		    
		    For Idx As Integer = Self.mMessages.LastIndex DownTo 0
		      Var Original As Beacon.RCONMessage = Self.mMessages(Idx)
		      If Original.Consume(NewMessage) = False Then
		        Continue
		      End If
		      
		      If Original.ResponseReceived Then
		        Try
		          RaiseEvent ReplyReceived(Original)
		        Catch Err As RuntimeException
		        End Try
		        
		        Self.mMessages.RemoveAt(Idx)
		      End If
		      
		      Continue Do
		    Next
		    
		    Try
		      RaiseEvent MessageReceived(NewMessage)
		    Catch Err As RuntimeException
		    End Try
		  Loop
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As TCPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  #Pragma Unused Err
		  
		  System.DebugLog("RCON: Disconnected with " + Err.ErrorNumber.ToString(Locale.Raw, "0"))
		  RaiseEvent Disconnected
		  Self.mAuthenticated = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Message As Beacon.RCONMessage)
		  If Message Is Nil Or Message.ResponseReceived Then
		    Return
		  End If
		  
		  If Message.Type <> Beacon.RCONMessage.TypeAuth Then
		    Self.mMessages.Add(Message)
		  End If
		  
		  If Self.mSocket.IsConnected Then
		    Self.mSocket.Write(Message.ByteValue)
		    Self.mSocket.Flush
		    Self.mSocket.Write(Message.Detector.ByteValue)
		    #if DebugBuild
		      System.DebugLog("RCON: Sent `" + EncodeHex(Message.ByteValue) + "`")
		    #endif
		  Else
		    Self.mPendingMessages.Add(Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Send(Command As String) As Beacon.RCONMessage
		  Var Message As New Beacon.RCONMessage(Beacon.RCONMessage.TypeExecuteCommand, Command)
		  Self.Send(Message)
		  Return Message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartAuthentication()
		  If Self.mAuthenticated Then
		    Return
		  End If
		  
		  Var AuthMessage As New Beacon.RCONMessage(Beacon.RCONMessage.TypeAuth, Self.mPassword)
		  Self.mAuthMessage = AuthMessage
		  Self.Send(AuthMessage)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Authenticated()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AuthenticationFailed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Connected()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Disconnected()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MessageReceived(Message As Beacon.RCONMessage)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReplyReceived(Message As Beacon.RCONMessage)
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
		Private mAuthMessage As Beacon.RCONMessage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessages() As Beacon.RCONMessage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingMessages() As Beacon.RCONMessage
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
