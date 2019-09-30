#tag Class
Protected Class ConnectorDiscoveryEngine
Implements Beacon.DiscoveryEngine
	#tag Method, Flags = &h0
		Sub Begin()
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Self.mSocket = New Beacon.ConnectorClientSocket
		  AddHandler mSocket.Connected, WeakAddressOf mSocket_Connected
		  AddHandler mSocket.Error, WeakAddressOf mSocket_Error
		  AddHandler mSocket.MessageReceived, WeakAddressOf mSocket_MessageReceived
		  Self.mSocket.Address = Self.mProfile.Address
		  Self.mSocket.Port = Self.mProfile.Port
		  Self.mSocket.Connect(Self.mProfile.PreSharedKey)
		  Self.mStatus = "Connecting to server…"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions() As DIctionary
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mCommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ConnectorServerProfile)
		  Self.mProfile = Profile
		  
		  Self.mTasks.Append(WeakAddressOf TaskDownloadLogFile)
		  Self.mTasks.Append(WeakAddressOf TaskDownloadGameUserSettingsIni)
		  Self.mTasks.Append(WeakAddressOf TaskDownloadGameIni)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub DiscoveryTask()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As String
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Map() As UInt64
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mMap
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Connected(Sender As Beacon.ConnectorClientSocket)
		  #Pragma Unused Sender
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As Beacon.ConnectorClientSocket, Err As RuntimeException)
		  // This is not correct, as this event fires on planned disconnect
		  
		  Self.mErrored = True
		  Self.mFinished = True
		  Self.mStatus = "Disconnected"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_MessageReceived(Sender As Beacon.ConnectorClientSocket, Message As Dictionary)
		  If Not Message.HasKey("Command") Then
		    Return
		  End If
		  
		  Select Case Message.Value("Command")
		  Case "Log"
		    Dim LogContents As String
		    If Not Self.UnpackFile(Message, LogContents) Then
		      Self.mErrored = True
		      Self.mFinished = True
		      Self.mStatus = "Unable to unpack log file"
		      Return
		    End If
		    
		    Self.ProcessLogContents(LogContents.GuessEncoding)
		  Case "Get Game.ini"
		    Dim FileContents As String
		    If Not Self.UnpackFile(Message, FileContents) Then
		      Self.mErrored = True
		      Self.mFinished = True
		      Self.mStatus = "Unable to unpack Game.ini file"
		      Return
		    End If
		    
		    Self.mGameIniContent = FileContents.GuessEncoding
		    Self.RunNextTask()
		  Case "Get GameUserSettings.ini"
		    Dim FileContents As String
		    If Not Self.UnpackFile(Message, FileContents) Then
		      Self.mErrored = True
		      Self.mFinished = True
		      Self.mStatus = "Unable to unpack GameUserSettings.ini file"
		      Return
		    End If
		    
		    Self.mGameUserSettingsIniContent = FileContents.GuessEncoding
		    Self.RunNextTask()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessLogContents(Contents As String)
		  Self.mStatus = "Analyzing log file…"
		  
		  Dim Encoding As TextEncoding = Contents.Encoding
		  Contents = Contents.ReplaceLineEndings(EndOfLine)
		  Dim Lines() As String = Contents.Split(EndOfLine)
		  
		  For Each Line As String In Lines
		    Dim StartPos As Integer = Line.IndexOf("CommandLine: ")
		    If StartPos = -1 Then
		      Continue
		    End If
		    
		    Dim EndPos As Integer
		    StartPos = StartPos + 13
		    If (Line.Middle(StartPos, 1) = "=") Then
		      StartPos = StartPos + 1
		      EndPos = Line.IndexOf(StartPos, """")
		    Else
		      EndPos = Line.Length
		    End If
		    
		    Dim LineContent As String = Line.Middle(StartPos, EndPos - StartPos)
		    Dim InQuotes As Boolean
		    Dim Chars() As String = LineContent.Split("")
		    Dim Buffer As New MemoryBlock(0)
		    Dim Params() As String
		    For Each Char As String In Chars
		      If Char = """" Then
		        If InQuotes Then
		          Params.AddRow(Buffer.ToString.DefineEncoding(Encoding))
		          Buffer = New MemoryBlock(0)
		          InQuotes = False
		        Else
		          InQuotes = True
		        End If
		        Continue
		      ElseIf Char = " " Then
		        If InQuotes = False Then
		          Params.AddRow(Buffer.ToString.DefineEncoding(Encoding))
		          Buffer = New MemoryBlock(0)
		        End If
		      ElseIf Char = "-" And Buffer.Size = 0 Then
		        Continue
		      Else
		        Buffer.Append(Char)
		      End If
		    Next
		    If Buffer.Size > 0 Then
		      Params.AddRow(Buffer.ToString.DefineEncoding(Encoding))
		      Buffer = New MemoryBlock(0)
		    End If
		    
		    Dim StartupParams() As String = Params(0).Split("?")
		    Params.Remove(0)
		    
		    Self.mMap = Beacon.Maps.MaskForIdentifier(StartupParams(0))
		    StartupParams.Remove(0)
		    
		    StartupParams.Remove(0) // The Listen statement
		    
		    Dim Merged() As String
		    For Each Param As String In StartupParams
		      Merged.Append(Param)
		    Next
		    For Each Param As String In Params
		      Merged.Append(Param)
		    Next
		    Params.ResizeTo(-1)
		    StartupParams.ResizeTo(-1)
		    
		    Dim Options As New Dictionary
		    For Each Param As String In Merged
		      If Param = "" Then
		        Continue
		      End If
		      
		      Dim EqualsPos As Integer = Param.IndexOf("=")
		      If EqualsPos > -1 Then
		        Options.Value(Param.Left(EqualsPos)) = Param.Middle(EqualsPos + 1)
		      Else
		        Options.Value(Param) = True
		      End If
		    Next
		    Self.mCommandLineOptions = Options
		  Next
		  
		  Self.RunNextTask()
		  
		  Exception Err As RuntimeException
		    Self.mErrored = True
		    Self.mFinished = True
		    Self.mStatus = "There was an exception while analyzing the log file"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mProfile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunNextTask()
		  If Self.mTasks.LastRowIndex = -1 Then
		    Self.mSocket.Close
		    
		    Self.mErrored = False
		    Self.mFinished = True
		    Self.mStatus = "Finished"
		    Return
		  End If
		  
		  Dim Task As DiscoveryTask = Self.mTasks(0)
		  Self.mTasks.Remove(0)
		  
		  Task.Invoke()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadGameIni()
		  Self.mStatus = "Getting Game.ini…"
		  
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Get Game.ini"
		  
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadGameUserSettingsIni()
		  Self.mStatus = "Getting GameUserSettings.ini…"
		  
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Get GameUserSettings.ini"
		  
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadLogFile()
		  Self.mStatus = "Getting log file…"
		  
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Log"
		  
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UnpackFile(Dict As Dictionary, ByRef Contents As String) As Boolean
		  If Dict.HasKey("Error") Then
		    Return False
		  End If
		  
		  Dim Content As String = Dict.Value("Contents")
		  Dim Hash As String = Dict.Value("SHA512")
		  Content = DecodeBase64(Content)
		  Dim ComputedHash As String = EncodeHex(Crypto.SHA512(Content)).Lowercase
		  
		  If ComputedHash = Hash Then
		    Contents = Content
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCommandLineOptions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMap As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ConnectorServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As Beacon.ConnectorClientSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTasks() As DiscoveryTask
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
