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
		    Config.Value("Encryption Key") = EncodeHex(Crypto.GenerateRandomBytes(32)).Lowercase
		  End If
		  Self.EncryptionKey = Self.PrepareKey(Config.Value("Encryption Key"))
		  
		  If Not Config.HasKey("Port") Then
		    Config.Value("Port") = 48962
		  End If
		  Dim Port As Integer = Config.Value("Port").IntegerValue
		  
		  Dim RequiredKeys() As String = Array("Config Folder", "Logs Folder", "Start Command", "Stop Command", "Status Command")
		  For Each Key As String In RequiredKeys
		    If Not Config.HasKey(Key) Then
		      Self.Log("Config is missing the `" + Key + "` value")
		      Quit
		      Return
		    End If
		  Next
		  
		  Try
		    Self.ConfigFolder = New FolderItem(Self.ExpandPath(Config.Value("Config Folder")), FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		  End Try
		  If Self.ConfigFolder = Nil Or Self.ConfigFolder.Exists = False Or Self.ConfigFolder.IsFolder = False Then
		    Self.Log("Config folder path is either missing or not a folder")
		    Quit
		    Return
		  End If
		  
		  Try
		    Self.LogsFolder = New FolderItem(Self.ExpandPath(Config.Value("Logs Folder")), FolderItem.PathModes.Native)
		  Catch Err As RuntimeException
		  End Try
		  If Self.LogsFolder = Nil or Self.LogsFolder.Exists = False Or Self.LogsFolder.IsFolder = False Then
		    Self.Log("Logs folder path is either missing or not a folder")
		    Quit
		    Return
		  End If
		  
		  Try
		    Self.StatusCommand = Config.Value("Status Command")
		    Self.StartCommand = Config.Value("Start Command")
		    Self.StopCommand = Config.Value("Stop Command")
		    If Config.HasKey("Set Parameter Command") Then
		      Self.ChangeParameterCommand = Config.Value("Set Parameter Command")
		    End If
		  Catch Err As RuntimeException
		    Self.Log("One or more commands are malformed")
		    Quit
		    Return
		  End Try
		  
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


	#tag Method, Flags = &h21
		Private Function ExpandPath(Path As String) As String
		  If Path.Left(1) = "~" Then
		    Return SpecialFolder.UserHome.NativePath + Path.Middle(1)
		  Else
		    Return Path
		  End If
		End Function
	#tag EndMethod

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
		Private Function PrepareKey(Value As String) As String
		  Dim Reg As New RegEx
		  Reg.SearchPattern = "^[a-f0-9]{64}$"
		  
		  If Reg.Search(Value.Lowercase) <> Nil Then
		    // It's a hex string
		    Return DecodeHex(Value)
		  End If
		  
		  // It's something else, so let's prepare a key
		  Return Crypto.SHA256(Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function QuoteValue(Value As String) As String
		  #if TargetWin32
		    Value = Value.ReplaceAll("""", """""")
		  #else
		    Value = Value.ReplaceAll("""", "\""")
		  #endif
		  Return """" + Value + """"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadFile(File As FolderItem) As Dictionary
		  If File = Nil Or File.Exists = False Then
		    Dim Response As New Dictionary
		    Response.Value("Error") = "File not found"
		    Return Response
		  End If
		  
		  Try
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Contents As String = Stream.ReadAll(Nil)
		    Stream.Close
		    
		    Dim Hash As String = EncodeHex(Crypto.SHA512(Contents)).Lowercase
		    
		    Dim Compressor As New _GZipString
		    Contents = Compressor.Compress(Contents, _GZipString.BestCompression)
		    
		    Dim Response As New Dictionary
		    Response.Value("Contents") = EncodeBase64(Contents, 0)
		    Response.Value("SHA512") = Hash
		    Response.Value("Compressed") = True
		    Return Response
		  Catch Err As RuntimeException
		    Dim Response As New Dictionary
		    Response.Value("Error") = "Exception while reading file"
		    Return Response
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Socket_MessageReceived(Sender As ControlSocket, Message As Dictionary) As Dictionary
		  #Pragma Unused Sender
		  
		  If Not Message.HasKey("Command") Then
		    Return Nil
		  End If
		  
		  Self.Log("Command: " + Message.Value("Command"))
		  
		  Select Case Message.Value("Command")
		  Case "Start"
		    // Starts the server
		    Dim Sh As New Shell
		    Sh.Execute(Self.StartCommand)
		    
		    Dim Response As New Dictionary
		    Response.Value("Success") = Sh.ExitCode = 0
		    Return Response
		  Case "Stop"
		    // Stops the server
		    Dim Command As String = Self.StopCommand
		    Dim StopMessage As String = Message.Lookup("Message", "")
		    Command = Command.ReplaceAll("%message%", StopMessage)
		    Command = Command.ReplaceAll("escape(%message%)", Self.QuoteValue(StopMessage))
		    
		    Dim Sh As New Shell
		    Sh.Execute(Command)
		    
		    Dim Response As New Dictionary
		    Response.Value("Success") = Sh.ExitCode = 0
		    Return Response
		  Case "Status"
		    // Replies with the status of the server
		    Dim Sh As New Shell
		    Sh.Execute(Self.StatusCommand)
		    
		    Dim Response As New Dictionary
		    Response.Value("Status") = If(Sh.ExitCode = 0, "started", "stopped")
		    Return Response
		  Case "Get Game.ini"
		    // Replies with Game.ini
		    Return Self.ReadFile(Self.ConfigFolder.Child("Game.ini"))
		  Case "Put Game.ini"
		    // Updates Game.ini
		    Dim Response As New Dictionary
		    Response.Value("Success") = Self.WriteFile(Self.ConfigFolder.Child("Game.ini"), Message.Value("Contents"), Message.Value("SHA512"), Message.Value("Compressed"))
		    Return Response
		  Case "Get GameUserSettings.ini"
		    // Replies with GameUserSettings.ini
		    Return Self.ReadFile(Self.ConfigFolder.Child("GameUserSettings.ini"))
		  Case "Put GameUserSettings.ini"
		    // Updates GameUserSettings.ini
		    Dim Response As New Dictionary
		    Response.Value("Success") = Self.WriteFile(Self.ConfigFolder.Child("GameUserSettings.ini"), Message.Value("Contents"), Message.Value("SHA512"), Message.Value("Compressed"))
		    Return Response
		  Case "Log"
		    // Gets the most recent log file
		    Dim Bound As Integer = Self.LogsFolder.Count - 1
		    Dim NewestTime As Double
		    Dim NewestFile As FolderItem
		    For I As Integer = 0 To Bound
		      Dim File As FolderItem = Self.LogsFolder.ChildAt(I)
		      If File.ModificationDateTime <> Nil And File.ModificationDateTime.SecondsFrom1970 > NewestTime Then
		        NewestTime = File.ModificationDateTime.SecondsFrom1970
		        NewestFile = File
		      End If
		    Next
		    Return Self.ReadFile(NewestFile)
		  Case "Param"
		    Dim Response As New Dictionary
		    If Message.HasKey("Param") = False Or Message.HasKey("Value") = False Then
		      Response.Value("Success") = False
		      Response.Value("Reason") = "Missing Param or Value parameters."
		      Return Response
		    End If
		    If Self.ChangeParameterCommand = "" Then
		      // The connector has chosen not to implement this, so pretend all is well.
		      Response.Value("Success") = True
		      Return Response
		    End If
		    
		    Dim Parameter As String = Message.Value("Param")
		    Dim Value As String = Message.Value("Value")
		    Dim Command As String = Self.ChangeParameterCommand
		    Command = Command.ReplaceAll("%key%", Parameter)
		    Command = Command.ReplaceAll("%value%", Value)
		    Command = Command.ReplaceAll("escape(%key)", Self.QuoteValue(Parameter))
		    Command = Command.ReplaceAll("escape(%value%)", Self.QuoteValue(Value))
		    
		    Dim Sh As New Shell
		    Sh.Execute(Command)
		    Response.Value("Success") = Sh.ExitCode = 0
		    Return Response
		  End Select
		  
		  Exception Err As RuntimeException
		    Dim Response As New Dictionary
		    Response.Value("Error") = "Unhandled Exception"
		    Return Response
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WriteFile(File As Folderitem, Contents As String, ExpectedHash As String, Compressed As Boolean) As Boolean
		  If File = Nil Then
		    Return False
		  End If
		  
		  Try
		    Contents = DecodeBase64(Contents)
		    
		    If Compressed Then
		      Dim Compressor As New _GZipString
		      Contents = Compressor.Decompress(Contents)
		    End If
		    
		    Dim ComputedHash As String = EncodeHex(Crypto.SHA512(Contents))
		    If ComputedHash <> ExpectedHash Then
		      Return False
		    End If
		    
		    Dim Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(Contents)
		    Stream.Close
		    
		    Return True
		  Catch Err As RuntimeException
		    Return False
		  End Try
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ChangeParameterCommand As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ConfigFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ConfigFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EncryptionKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Listener As ServerSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LogsFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartCommand As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StatusCommand As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StopCommand As String
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
