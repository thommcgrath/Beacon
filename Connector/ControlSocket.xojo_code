#tag Class
Protected Class ControlSocket
Inherits TCPSocket
	#tag Event
		Sub Connected()
		  Self.Buffer = New MemoryBlock(0)
		  
		  Self.mConnectedAddress = Self.RemoteAddress
		  App.Log("Received connection from " + Self.mConnectedAddress)
		  
		  Self.mConnectionKey = Crypto.GenerateRandomBytes(32)
		  Dim Dict As New Dictionary
		  Dict.Value("Key") = EncodeHex(Self.mConnectionKey).Lowercase
		  
		  Self.Write(BeaconEncryption.SymmetricEncrypt(Self.mPreSharedKey, Xojo.GenerateJSON(Dict, False)))
		End Sub
	#tag EndEvent

	#tag Event
		Sub DataReceived()
		  Self.Buffer.Append(Self.ReadAll)
		  
		  While Self.Buffer <> Nil And Self.Buffer.Size > 0
		    Dim PayloadLen As UInt64 = BeaconEncryption.GetLength(Self.Buffer)
		    If PayloadLen = 0 Then
		      Return
		    End If
		    
		    Dim Payload As MemoryBlock
		    If Self.Buffer.Size < PayloadLen Then
		      Return
		    ElseIf Self.Buffer.Size > PayloadLen Then
		      Payload = Self.Buffer.Left(PayloadLen)
		      Self.Buffer = Self.Buffer.Middle(PayloadLen, Self.Buffer.Size - PayloadLen)
		    Else
		      Payload = Self.Buffer
		      Self.Buffer = New MemoryBlock(0)
		    End If
		    
		    Dim Decrypted As MemoryBlock
		    Try
		      Decrypted = BeaconEncryption.SymmetricDecrypt(Self.mConnectionKey, Payload)
		    Catch Err As RuntimeException
		      App.Log("Incorrect encryption key")
		      Self.Disconnect()
		      Return
		    End Try
		    
		    Dim Dict As Dictionary
		    Try
		      Dict = Xojo.ParseJSON(Decrypted)
		    Catch Err As RuntimeException
		      App.Log("Bad JSON payload")
		      Self.Disconnect()
		      Return
		    End Try
		    
		    If Dict.HasKey("Nonce") = False Or Dict.Value("Nonce").IntegerValue <> Self.mNextNonce Then
		      App.Log("Warning: malicious command sequence from " + Self.mConnectedAddress + ", connection will be terminated for safety.")
		      Self.Disconnect()
		      Return
		    End If
		    Dim ReplyNonce As Integer = Self.mNextNonce
		    Self.mNextNonce = Self.mNextNonce + 1
		    
		    Dim Response As Dictionary
		    Try
		      Response = RaiseEvent MessageReceived(Dict)
		    Catch Err As RuntimeException
		      If Not App.HandleException(Err) Then
		        Quit
		      End If
		    End Try
		    If Response = Nil Then
		      Response = New Dictionary
		    End If
		    Response.Value("Nonce") = ReplyNonce
		    
		    If Dict.HasKey("Command") Then
		      Response.Value("Command") = Dict.Value("Command")
		    End If
		    
		    Self.Write(BeaconEncryption.SymmetricEncrypt(Self.mConnectionKey, Xojo.GenerateJSON(Response, False)))
		  Wend
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(err As RuntimeException)
		  #Pragma Unused Err
		  
		  App.Log("Lost connection with " + Self.mConnectedAddress)
		  Self.Reset()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Super.Constructor
		  Self.Reset()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(EncryptionKey As String)
		  Self.mPreSharedKey = EncryptionKey
		  Self.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reset()
		  Self.mNextNonce = 1
		  Self.mConnectedAddress = ""
		  Self.mConnectionKey = ""
		  Self.Purge
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageReceived(Message As Dictionary) As Dictionary
	#tag EndHook


	#tag Property, Flags = &h21
		Private Buffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConnectedAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConnectionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNextNonce As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreSharedKey As String
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
			Name="Address"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
