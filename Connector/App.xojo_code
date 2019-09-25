#tag Class
Protected Class App
Inherits DaemonApplication
	#tag Event
		Sub Close()
		  Self.Log("Connector has ended gracefully")
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open(Args() As String)
		  Dim ConfigPath As String = "config.json"
		  
		  Args.RemoveRowAt(0)
		  
		  For I As Integer = Args.LastRowIndex DownTo 0
		    Select Case Args(I)
		    Case "--config"
		      ConfigPath = Args(I + 1)
		      Args.RemoveRowAt(I + 1)
		      Args.RemoveRowAt(I)
		    End Select
		  Next
		  
		  Self.ConfigFile = New FolderItem(ConfigPath, FolderItem.PathModes.Native)
		  If Self.ConfigFile = Nil Then
		    Self.Log("Path to config file is not valid.")
		    Quit
		    Return
		  End If
		  
		  Dim Config As Dictionary
		  Dim ConfigHash As String
		  Dim QuitEarly As Boolean
		  If Self.ConfigFile.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(Self.ConfigFile)
		    Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Config = Xojo.ParseJSON(Contents)
		    ConfigHash = EncodeHex(Contents)
		  Else
		    Config = New Dictionary
		  End If
		  
		  If Args.LastRowIndex = 2 And Args(0) = "set" Then
		    Dim Key As String = Args(1)
		    Dim Value As String = Args(2)
		    Config.Value(Key) = Value
		    QuitEarly = True
		  End If
		  
		  If Not Config.HasKey("Encryption Key") Then
		    Config.Value("Encryption Key") = EncodeHex(Crypto.GenerateRandomBytes(16)).Lowercase
		  End If
		  Self.EncryptionKey = Config.Value("Encryption Key")
		  
		  If Not Config.HasKey("Port") Then
		    Config.Value("Port") = 48962
		  End If
		  Dim Port As Integer = Config.Value("Port").IntegerValue
		  
		  Dim ConfigContents As String = Xojo.GenerateJSON(Config, True)
		  If ConfigHash <> EncodeHex(ConfigContents) Then
		    Dim Stream As TextOutputStream = TextOutputStream.Create(Self.ConfigFile)
		    Stream.Write(ConfigContents)
		    Stream.Close
		  End If
		  ConfigContents = ""
		  
		  If QuitEarly Then
		    Quit
		    Return
		  End If
		  
		  Self.Listen(Port)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Listen(Port As Integer)
		  If Self.Listener <> Nil Then
		    Self.Listener.StopListening
		    RemoveHandler Listener.SocketRequested, WeakAddressOf Listener_SocketRequested
		    RemoveHandler Listener.Error, WeakAddressOf Listener_Error
		    Self.Listener = Nil
		  End If
		  
		  Self.Listener = New ServerSocket
		  Self.Listener.Port = Port
		  Self.Listener.MinimumSocketsAvailable = 1
		  Self.Listener.MaximumSocketsConnected = 4
		  AddHandler Listener.SocketRequested, WeakAddressOf Listener_SocketRequested
		  AddHandler Listener.Error, WeakAddressOf Listener_Error
		  Self.Listener.Listen
		  
		  Self.Log("Now listening on port " + Str(Port, "-0"))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Listener_Error(Sender As ServerSocket, ErrorCode As Integer, Err As RuntimeException)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Listener_SocketRequested(Sender As ServerSocket) As TCPSocket
		  #Pragma Unused Sender
		  
		  Dim Sock As New ControlSocket(Self.EncryptionKey)
		  AddHandler Sock.MessageReceived, WeakAddressOf Socket_MessageReceived
		  Return Sock
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Socket_MessageReceived(Sender As ControlSocket, Message As Dictionary) As Dictionary
		  #Pragma Unused Sender
		  
		  Break
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ConfigFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EncryptionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Listener As ServerSocket
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
