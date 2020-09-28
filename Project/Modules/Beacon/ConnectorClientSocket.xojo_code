#tag Class
Protected Class ConnectorClientSocket
Inherits TCPSocket
	#tag Event
		Sub Connected()
		  Self.NextOutboundNonce = 1
		  Self.NextInboundNonce = 1
		  Self.ConnectionKey = ""
		  Self.Buffer = New MemoryBlock(0)
		End Sub
	#tag EndEvent

	#tag Event
		Sub DataAvailable()
		  Self.Buffer.Append(Self.ReadAll)
		  
		  While Self.Buffer <> Nil And Self.Buffer.Size > 0
		    Var PayloadLen As UInt64 = BeaconEncryption.GetLength(Self.Buffer)
		    If PayloadLen = 0 Then
		      Return
		    End If
		    
		    Var Payload As MemoryBlock
		    If Self.Buffer.Size < PayloadLen Then
		      Return
		    ElseIf Self.Buffer.Size > PayloadLen Then
		      Payload = Self.Buffer.Left(PayloadLen)
		      Self.Buffer = Self.Buffer.Middle(PayloadLen, Self.Buffer.Size - PayloadLen)
		    Else
		      Payload = Self.Buffer
		      Self.Buffer = New MemoryBlock(0)
		    End If
		    
		    Var Key As String = If(Self.ConnectionKey <> "", Self.ConnectionKey, Self.PreSharedKey)
		    Var Decrypted As MemoryBlock
		    Try
		      Decrypted = BeaconEncryption.SymmetricDecrypt(Key, Payload)
		    Catch Err As RuntimeException
		      Err.ErrorNumber = Self.IncorrectEncryptionKeyError
		      Err.Message = "Incorrect encryption key"
		      If Self.mTimeoutKey <> "" Then
		        CallLater.Cancel(Self.mTimeoutKey)
		        Self.mTimeoutKey = ""
		      End If
		      RaiseEvent Error(Err)
		      Return
		    End Try
		    
		    Var Dict As Dictionary
		    Try
		      Dict = Xojo.ParseJSON(Decrypted)
		    Catch Err As RuntimeException
		      If Self.mTimeoutKey <> "" Then
		        CallLater.Cancel(Self.mTimeoutKey)
		        Self.mTimeoutKey = ""
		      End If
		      RaiseEvent Error(Err)
		      Return
		    End Try
		    
		    If Self.ConnectionKey = "" Then
		      Self.ConnectionKey = DecodeHex(Dict.Value("Key"))
		      If Self.mTimeoutKey <> "" Then
		        CallLater.Cancel(Self.mTimeoutKey)
		        Self.mTimeoutKey = ""
		      End If
		      RaiseEvent Connected()
		    Else
		      If Dict.HasKey("Nonce") = False Or Dict.Value("Nonce").IntegerValue <> Self.NextInboundNonce Then
		        Self.Disconnect()
		        Return
		      End If
		      Self.NextInboundNonce = Self.NextInboundNonce + 1
		      
		      RaiseEvent MessageReceived(Dict)
		    End If
		  Wend
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(err As RuntimeException)
		  Var Message As String
		  Select Case Err.ErrorNumber
		  Case TCPSocket.LostConnection
		    Message = "A connection was established, but it has been lost."
		  Case TCPSocket.NameResolutionError
		    Message = "Unable to reach host. Check the address and try again."
		  Case 22
		    Message = "Server found, but unable to establish a connection. Check the port and try again."
		  Case Self.IncorrectEncryptionKeyError
		    Message = "The encryption key is not correct."
		  Case Self.TimeoutError
		    Message = "After trying for " + Self.TimeoutSeconds.ToString + " seconds, a connection could not be established. Check the address and try again."
		  Else
		    Message = "Unknown error #" + Err.ErrorNumber.ToString
		    If Err.Message <> "" Then
		      Message = Message + ": " + Err.Message
		    End If
		  End Select
		  
		  Err.Message = Message
		  
		  RaiseEvent Error(Err)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Close()
		  If Self.mTimeoutKey <> "" Then
		    CallLater.Cancel(Self.mTimeoutKey)
		    Self.mTimeoutKey = ""
		  End If
		  Super.Close()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Connect()
		  Super.Connect()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Connect(PreSharedKey As String)
		  Self.PreSharedKey = Self.PrepareKey(PreSharedKey)
		  Self.Connect()
		  Self.mTimeoutKey = CallLater.Schedule(Self.TimeoutSeconds * 1000, WeakAddressOf TimeoutElapsed)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If Self.mTimeoutKey <> "" Then
		    CallLater.Cancel(Self.mTimeoutKey)
		    Self.mTimeoutKey = ""
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Disconnect()
		  If Self.mTimeoutKey <> "" Then
		    CallLater.Cancel(Self.mTimeoutKey)
		    Self.mTimeoutKey = ""
		  End If
		  Super.Disconnect()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PackFile(Dict As Dictionary, File As FolderItem, Compressed As Boolean) As Boolean
		  If File = Nil Or File.Exists = False Then
		    Return False
		  End If
		  
		  Try
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As String = Stream.ReadAll(Nil)
		    Stream.Close
		    
		    Return PackFile(Dict, Contents, Compressed)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PackFile(Dict As Dictionary, Contents As String, Compressed As Boolean) As Boolean
		  Try
		    Var Hash As String = EncodeHex(Crypto.SHA512(Contents)).Lowercase
		    
		    If Compressed Then
		      Var Compressor As New _GZipString
		      Contents = Compressor.Compress(Contents, _GZipString.BestCompression)
		    End If
		    
		    Contents = EncodeBase64(Contents)
		    
		    Dict.Value("Contents") = Contents
		    Dict.Value("SHA512") = Hash
		    Dict.Value("Compressed") = Compressed
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PrepareKey(Value As String) As String
		  Var Reg As New RegEx
		  Reg.SearchPattern = "^[a-f0-9]{64}$"
		  
		  If Reg.Search(Value.Lowercase) <> Nil Then
		    // It's a hex string
		    Return DecodeHex(Value)
		  End If
		  
		  // It's something else, so let's prepare a key
		  Return Crypto.SHA256(Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendSimpleCommand(Command As String)
		  Var Message As New Dictionary
		  Message.Value("Command") = Command
		  Self.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TimeoutElapsed()
		  Self.mTimeoutKey = ""
		  
		  Var Err As New RuntimeException
		  Err.ErrorNumber = Self.TimeoutError
		  Err.Message = "A connection was not established after " + Self.TimeoutSeconds.ToString + " seconds."
		  RaiseEvent Error(Err)
		  
		  Self.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function UnpackFile(Dict As Dictionary, ByRef Contents As String) As Boolean
		  If Dict.HasKey("Error") Then
		    Return False
		  End If
		  
		  Var Content As String = Dict.Value("Contents")
		  Var Hash As String = Dict.Value("SHA512")
		  Var Compressed As Boolean = Dict.Lookup("Compressed", False).BooleanValue
		  Content = DecodeBase64(Content)
		  If Compressed Then
		    Var Compressor As New _GZipString
		    Content = Compressor.Decompress(Content)
		  End If
		  Var ComputedHash As String = EncodeHex(Crypto.SHA512(Content)).Lowercase
		  
		  If ComputedHash = Hash Then
		    Contents = Content
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(Message As Dictionary)
		  Message.Value("Nonce") = Self.NextOutboundNonce
		  Self.NextOutboundNonce = Self.NextOutboundNonce + 1
		  
		  Var Decrypted As String = Xojo.GenerateJSON(Message, False)
		  Var Payload As MemoryBlock = BeaconEncryption.SymmetricEncrypt(Self.ConnectionKey, Decrypted)
		  #if DebugBuild
		    Var PredictedLength As UInt64 = BeaconEncryption.GetLength(Payload)
		    If Payload.Size <> PredictedLength Then
		      Break
		    End If
		  #endif
		  Self.Write(Payload)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Write(Text As String)
		  Super.Write(Text)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Connected()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(Err As RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MessageReceived(Message As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private Buffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ConnectionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimeoutKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NextInboundNonce As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NextOutboundNonce As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PreSharedKey As String
	#tag EndProperty


	#tag Constant, Name = IncorrectEncryptionKeyError, Type = Double, Dynamic = False, Default = \"2850", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TimeoutError, Type = Double, Dynamic = False, Default = \"6449", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TimeoutSeconds, Type = Double, Dynamic = False, Default = \"60", Scope = Public
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
