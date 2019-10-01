#tag Class
Protected Class ConnectorDeploymentEngine
Inherits Beacon.TaskQueue
Implements Beacon.DeploymentEngine
	#tag Event
		Sub Finished()
		  Self.mSocket.Close
		  Self.ClearTasks()
		  Self.mErrored = False
		  Self.mFinished = True
		  Self.mStatus = "Finished"
		  RaiseEvent Finished()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function BackupGameIni() As String
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mGameIniOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupGameUserSettingsIni() As String
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mGameUserSettingsOriginal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Begin(Label As String, Document As Beacon.Document, Identity As Beacon.Identity)
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  #Pragma Unused Label
		  
		  Self.mDocument = Document
		  Self.mIdentity = Identity
		  Self.mStatus = "Connecting…"
		  
		  Self.AppendTask(WeakAddressOf TaskStopServer, WeakAddressOf TaskDownloadLog, WeakAddressOf TaskSetNextCommandLineParam, WeakAddressOf TaskDownloadGameUserSettings, WeakAddressOf TaskDownloadGameIni, WeakAddressOf TaskRewriteIniFiles, WeakAddressOf TaskUploadGameUserSettings, WeakAddressOf TaskUploadGameIni, WeakAddressOf TaskStartServer)
		  
		  Self.mSocket = New Beacon.ConnectorClientSocket
		  AddHandler mSocket.Connected, WeakAddressOf mSocket_Connected
		  AddHandler mSocket.MessageReceived, WeakAddressOf mSocket_MessageReceived
		  AddHandler mSocket.Error, WeakAddressOf mSocket_Error
		  Self.mSocket.Address = Self.mProfile.Address
		  Self.mSocket.Port = Self.mProfile.Port
		  Self.mSocket.Connect(Self.mProfile.PreSharedKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Self.mSocket.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ConnectorServerProfile)
		  Self.mProfile = Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mFinished
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
		  
		  Dim Command As String = Message.Value("Command")
		  Select Case Command
		  Case "Status"
		    Dim Stopped As Boolean = Message.Lookup("Status", "stopped") = "stopped"
		    If Stopped Then
		      Self.RunNextTask()
		      Return
		    End If
		    
		    Self.mServerWasStarted = True
		    Sender.SendSimpleCommand("Stop")
		    Self.mStatus = "Stopping server…"
		  Case "Stop"
		    Dim Stopped As Boolean = Message.Lookup("Success", False).BooleanValue
		    If Not Stopped Then
		      Self.SetError("Server did not stop when requested.")
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Case "Start"
		    Dim Started As Boolean = Message.Lookup("Success", False).BooleanValue
		    If Not Started Then
		      Self.SetError("Server did not start when requested.")
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Case "Log"
		    Dim LogContents As String
		    If Not Sender.UnpackFile(Message, LogContents) Then
		      Self.SetError("Unable to unpack log file.")
		      Return
		    End If
		    
		    Self.ProcessLogContents(LogContents.GuessEncoding)
		  Case "Get Game.ini"
		    Dim FileContents As String
		    If Not Sender.UnpackFile(Message, FileContents) Then
		      Self.SetError("Unable to unpack Game.ini.")
		      Return
		    End If
		    
		    Self.mGameIniOriginal = FileContents
		    Self.RunNextTask()
		  Case "Get GameUserSettings.ini"
		    Dim FileContents As String
		    If Not Sender.UnpackFile(Message, FileContents) Then
		      Self.SetError("Unable to unpack GameUserSettings.ini.")
		      Return
		    End If
		    
		    Self.mGameUserSettingsOriginal = FileContents
		    Self.RunNextTask()
		  Case "Put Game.ini"
		    Dim Success As Boolean = Message.Lookup("Success", False).BooleanValue
		    If Not Success Then
		      Self.SetError("Server was unable to unpack updated Game.ini.")
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Case "Put GameUserSettings.ini"
		    Dim Success As Boolean = Message.Lookup("Success", False).BooleanValue
		    If Not Success Then
		      Self.SetError("Server was unable to unpack updated GameUserSettings.ini.")
		      Return
		    End If
		    
		    Self.RunNextTask()
		  Case "Param"
		    Dim Success As Boolean = Message.Lookup("Success", False).BooleanValue
		    If Not Success Then
		      Self.SetError("Unable to set command line parameter.")
		      Return
		    End If
		    
		    Self.TaskSetNextCommandLineParam()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessLogContents(Contents As String)
		  Self.mStatus = "Analyzing log file…"
		  
		  Dim File As Beacon.LogFile = Beacon.LogFile.Analyze(Contents)
		  If File = Nil Then
		    Self.SetError("There was an error while analyzing the log file")
		    Return
		  End If
		  
		  Self.mMap = File.Maps
		  
		  Dim Groups() As Beacon.ConfigGroup = Self.mDocument.ImplementedConfigs
		  Dim CommandLineOptions() As Beacon.ConfigValue
		  For Each Group As Beacon.ConfigGroup In Groups
		    If Group.ConfigName = BeaconConfigs.CustomContent.ConfigName Then
		      Continue
		    End If
		    
		    Dim Options() As Beacon.ConfigValue = Group.CommandLineOptions(Self.mDocument, Self.mIdentity, Self.mProfile)
		    For Each Option As Beacon.ConfigValue In Options
		      CommandLineOptions.AddRow(Option)
		    Next
		  Next
		  
		  Dim StartParams As Dictionary = File.Options
		  For Each ConfigValue As Beacon.ConfigValue In CommandLineOptions
		    Dim Key As String = ConfigValue.Key
		    Dim Value As String = ConfigValue.Value
		    
		    If Not StartParams.HasKey(Key) Then
		      Continue
		    End If
		    
		    If StartParams.Value(Key) <> Value Then
		      Self.mCommandLineChanges.AddRow(ConfigValue)
		    End If
		  Next
		  
		  Self.RunNextTask()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Rewriter_Finished(Sender As Beacon.Rewriter)
		  Select Case Sender.Mode
		  Case Beacon.RewriteModeGameIni
		    Self.mGameIniRewritten = Sender.UpdatedContent
		  Case Beacon.RewriteModeGameUserSettingsIni
		    Self.mGameUserSettingsRewritten = Sender.UpdatedContent
		  End Select
		  
		  If Self.mGameIniRewritten <> "" And Self.mGameIniRewritten <> "" Then
		    Self.RunNextTask()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerIsStarting() As Boolean
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mServerWasStarted
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Message As String)
		  Self.mErrored = True
		  Self.mFinished = True
		  Self.mStatus = "Error: " + Message
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  // Part of the Beacon.DeploymentEngine interface.
		  
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadGameIni()
		  Self.mSocket.SendSimpleCommand("Get Game.ini")
		  Self.mStatus = "Downloading Game.ini…"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadGameUserSettings()
		  Self.mSocket.SendSimpleCommand("Get GameUserSettings.ini")
		  Self.mStatus = "Downloading Game.ini…"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskDownloadLog()
		  Self.mSocket.SendSimpleCommand("Log")
		  Self.mStatus = "Downloading log file…"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskRewriteIniFiles()
		  Self.mStatus = "Rewriting ini files…"
		  
		  Self.mGameIniRewriter = New Beacon.Rewriter
		  AddHandler mGameIniRewriter.Finished, WeakAddressOf Rewriter_Finished
		  Self.mGameIniRewriter.Rewrite(Self.mGameIniOriginal, Beacon.RewriteModeGameIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		  
		  Self.mGameUserSettingsRewriter = New Beacon.Rewriter
		  AddHandler mGameUserSettingsRewriter.Finished, WeakAddressOf Rewriter_Finished
		  Self.mGameUserSettingsRewriter.Rewrite(Self.mGameUserSettingsOriginal, Beacon.RewriteModeGameUserSettingsIni, Self.mDocument, Self.mIdentity, True, Self.mProfile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskSetNextCommandLineParam()
		  If Self.mCommandLineChanges.LastRowIndex = -1 Then
		    // Move on
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mStatus = "Setting command line parameters…"
		  
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Param"
		  Message.Value("Param") = Self.mCommandLineChanges(0).Key
		  Message.Value("Value") = Self.mCommandLineChanges(0).Value
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskStartServer()
		  If Not Self.mServerWasStarted Then
		    Self.RunNextTask()
		    Return
		  End If
		  
		  Self.mSocket.SendSimpleCommand("Start")
		  Self.mStatus = "Starting server…"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskStopServer()
		  Self.mSocket.SendSimpleCommand("Status")
		  Self.mStatus = "Checking server status…"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskUploadGameIni()
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Put Game.ini"
		  If Not Self.mSocket.PackFile(Message, Self.mGameIniRewritten, True) Then
		    Self.SetError("Unable to pack Game.ini for transport to server…")
		    Return
		  End If
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TaskUploadGameUserSettings()
		  Dim Message As New Dictionary
		  Message.Value("Command") = "Put GameUserSettings.ini"
		  If Not Self.mSocket.PackFile(Message, Self.mGameUserSettingsRewritten, True) Then
		    Self.SetError("Unable to pack GameUserSettings.ini for transport to server…")
		    Return
		  End If
		  Self.mSocket.Write(Message)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCommandLineChanges() As Beacon.ConfigValue
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniRewritten As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsOriginal As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsRewriter As Beacon.Rewriter
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsRewritten As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMap As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ConnectorServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerWasStarted As Boolean
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
