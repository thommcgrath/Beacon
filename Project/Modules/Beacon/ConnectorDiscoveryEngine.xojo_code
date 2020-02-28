#tag Class
Protected Class ConnectorDiscoveryEngine
Inherits Beacon.TaskQueue
Implements Beacon.DiscoveryEngine
	#tag Event
		Sub Finished()
		  Self.mSocket.Close
		  Self.mErrored = False
		  Self.mFinished = True
		  Self.mStatus = "Finished"
		  RaiseEvent Finished()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin()
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Self.AppendThreadedTask(WeakAddressOf TaskDownloadLogFile, WeakAddressOf TaskDownloadGameUserSettingsIni, WeakAddressOf TaskDownloadGameIni)
		  
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
		  #Pragma Unused Sender
		  
		  Self.mErrored = True
		  Self.mFinished = True
		  Self.mStatus = Err.Message
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_MessageReceived(Sender As Beacon.ConnectorClientSocket, Message As Dictionary)
		  If Not Message.HasKey("Command") Then
		    Return
		  End If
		  
		  Select Case Message.Value("Command")
		  Case "Log"
		    Var LogContents As String
		    If Not Sender.UnpackFile(Message, LogContents) Then
		      Self.mErrored = True
		      Self.mFinished = True
		      Self.mStatus = "Unable to unpack log file"
		      Return
		    End If
		    
		    Self.ProcessLogContents(LogContents.GuessEncoding)
		  Case "Get Game.ini"
		    Var FileContents As String
		    If Not Sender.UnpackFile(Message, FileContents) Then
		      Self.mErrored = True
		      Self.mFinished = True
		      Self.mStatus = "Unable to unpack Game.ini file"
		      Return
		    End If
		    
		    Self.mGameIniContent = FileContents.GuessEncoding
		    Self.RunNextTask()
		  Case "Get GameUserSettings.ini"
		    Var FileContents As String
		    If Not Sender.UnpackFile(Message, FileContents) Then
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
		  
		  Var File As Beacon.LogFile = Beacon.LogFile.Analyze(Contents)
		  If File = Nil Then
		    Self.mErrored = True
		    Self.mFinished = True
		    Self.mStatus = "There was an error while analyzing the log file"
		    Return
		  End If
		  
		  Self.mMap = File.Maps
		  Self.mCommandLineOptions = File.Options
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  // Part of the Beacon.DiscoveryEngine interface.
		  
		  Return Self.mProfile
		End Function
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
		  
		  Var Message As New Dictionary
		  Message.Value("Command") = "Get Game.ini"
		  
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadGameUserSettingsIni()
		  Self.mStatus = "Getting GameUserSettings.ini…"
		  
		  Var Message As New Dictionary
		  Message.Value("Command") = "Get GameUserSettings.ini"
		  
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadLogFile()
		  Self.mStatus = "Getting log file…"
		  
		  Var Message As New Dictionary
		  Message.Value("Command") = "Log"
		  
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


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
