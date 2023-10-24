#tag Class
Protected Class DeployIntegration
Inherits Beacon.Integration
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub Run()
		  Self.Log("Starting deploy of " + Self.Profile.Name)
		  
		  // Start by querying the server
		  Self.RefreshServerStatus(True)
		  If Self.Finished Then
		    Return
		  End If
		  
		  Var InitialServerState As Beacon.ServerStatus = Self.mStatus
		  
		  // Let the game-specific engine do its work
		  RaiseEvent Run()
		  
		  If Self.Finished Then
		    Return
		  End If
		  
		  // And start the server if it was already running
		  If (InitialServerState = Beacon.ServerStatus.States.Running Or InitialServerState = Beacon.ServerStatus.States.Starting) Then
		    Self.StartServer()
		  End If
		  
		  If Self.Finished Then
		    Return
		  End If
		  
		  Self.Log("Finished")
		  Self.Finish()
		  
		  Var Dict As New Dictionary
		  Dict.Value("Event") = "Finished"
		  Self.Thread.AddUserInterfaceUpdate(Dict)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AnalyzeEnabled() As Boolean
		  Return Self.OptionEnabled(Self.OptionAnalyze)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupEnabled() As Boolean
		  Return Self.OptionEnabled(Self.OptionBackup)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Begin(Label As String, Identity As Beacon.Identity, StopMessage As String, Options As UInt64)
		  Self.mLabel = Label
		  Self.mIdentity = Identity
		  Self.mStopMessage = StopMessage
		  Self.mOptions = Options And CType(Self.OptionAnalyze Or Self.OptionBackup Or Self.OptionNuke Or Self.OptionReview, UInt64)
		  Super.Begin()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CreateCheckpoint()
		  If Self.BackupEnabled = False Or Self.Provider.SupportsCheckpoints = False Or Self.mCheckpointCreated = True Then
		    Return
		  End If
		  
		  Try
		    Self.Log("Saving previous configuration as profile…")
		    Var CheckpointName As String = "Beacon " + Self.Label
		    Self.Provider.CreateCheckpoint(Self.Project, Self.Profile, CheckpointName)
		    Self.Log("Created configuration profile """ + CheckpointName + """")
		    Self.mCheckpointCreated = True
		  Catch Err As RuntimeException
		    Self.SetError("Failed to create configuration backup: " + Err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FireEvent(EventName As String, UpdateData As Dictionary)
		  Select Case EventName
		  Case "Discovered"
		    RaiseEvent Finished()
		  Else
		    Super.FireEvent(EventName, UpdateData)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NukeEnabled() As Boolean
		  // Backup must be enabled for nuke to be enabled
		  
		  Return Self.OptionEnabled(Self.OptionNuke Or Self.OptionBackup)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OptionEnabled(Option As UInt64) As Boolean
		  Return (Self.mOptions And CType(Option, UInt64)) = CType(Option, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Options() As UInt64
		  Return Self.mOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshServerStatus(Verbose As Boolean = False)
		  If Self.Provider.SupportsStatus = False Then
		    Self.mStatus = New Beacon.ServerStatus(Beacon.ServerStatus.States.Unsupported)
		    Return
		  End If
		  
		  Var SecondsSinceLastRefresh As Double = (System.Microseconds - Self.mLastRefresh) / 1000000
		  
		  Const WaitTime = 3.0
		  If SecondsSinceLastRefresh < WaitTime Then
		    Self.Thread.Sleep((WaitTime - SecondsSinceLastRefresh) * 1000, False)
		  End If
		  
		  If Verbose Then
		    Self.Log("Getting server status…")
		  End If
		  Self.mLastRefresh = System.Microseconds
		  
		  Try
		    Self.mStatus = Self.Provider.GetServerStatus(Self.Project, Self.Profile)
		  Catch Err As RuntimeException
		    Self.SetError("Failed to get server status: " + Err.Message)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReviewEnabled() As Boolean
		  Return Self.OptionEnabled(Self.OptionReview)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunBackup(OldFiles As Dictionary, NewFiles As Dictionary)
		  Var Dict As New Dictionary
		  Dict.Value("Old Files") = OldFiles
		  Dict.Value("New Files") = NewFiles
		  
		  Var Controller As New Beacon.TaskWaitController("Backup", Dict)
		  
		  Self.Log("Creating backup…")
		  Self.Wait(Controller)
		  If Controller.Cancelled Then
		    Self.Cancel
		    Return
		  ElseIf Self.Finished Then
		    Return
		  End If
		  Self.Log("Backup finished")
		  
		  Self.CreateCheckpoint()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StartServer(Verbose As Boolean = True)
		  If Self.Provider.SupportsRestarting = False Then
		    Return
		  End If
		  
		  Var EventFired As Boolean
		  Var Initial As Boolean = True
		  While True
		    Self.RefreshServerStatus()
		    If Self.Finished Then
		      Return
		    End If
		    
		    Select Case Self.mStatus.State
		    Case Beacon.ServerStatus.States.Running
		      If Verbose And EventFired Then
		        Self.Log("Server started.")
		      End If
		      Return
		    Case Beacon.ServerStatus.States.Stopped
		      If Not EventFired Then
		        If Verbose Then
		          Self.Log("Starting server…")
		        End If
		        
		        Try
		          Self.Provider.StartServer(Self.Project, Self.Profile)
		        Catch Err As RuntimeException
		          Self.SetError("Failed to stop server: " + Err.Message)
		          Return
		        End Try
		        
		        EventFired = True
		      End If
		    Case Beacon.ServerStatus.States.Starting
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish starting…")
		      End If
		    Case Beacon.ServerStatus.States.Stopping
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish stopping so it can be started…")
		      End If
		    Else
		      Self.SetError("Unexpected server state:" + Self.mStatus.Message)
		      Return
		    End Select
		    
		    Initial = False
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Beacon.ServerStatus
		  Return Self.mStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StopServer(Verbose As Boolean = True)
		  If Self.Provider.SupportsRestarting = False Then
		    Return
		  End If
		  
		  Var EventFired As Boolean
		  Var Initial As Boolean = True
		  While True
		    Self.RefreshServerStatus()
		    If Self.Finished Then
		      Return
		    End If
		    
		    Select Case Self.mStatus.State
		    Case Beacon.ServerStatus.States.Running
		      If Not EventFired Then
		        If Verbose Then
		          Self.Log("Stopping server…")
		        End If
		        
		        Try
		          Self.Provider.StopServer(Self.Project, Self.Profile, Self.mStopMessage)
		        Catch Err As RuntimeException
		          Self.SetError("Failed to stop server: " + Err.Message)
		          Return
		        End Try
		        
		        EventFired = True
		      End If
		    Case Beacon.ServerStatus.States.Stopped
		      If Verbose And EventFired Then
		        Self.Log("Server stopped.")
		      End If
		      Return
		    Case Beacon.ServerStatus.States.Starting
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish starting so it can be stopped…")
		      End If
		    Case Beacon.ServerStatus.States.Stopping
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish stopping…")
		      End If
		    Else
		      Self.SetError("Unexpected server state:" + Self.mStatus.Message)
		      Return
		    End Select
		    
		    Initial = False
		  Wend
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 4669726573206F6E20746865206D61696E20746872656164207768656E20746865206465706C6F79206973207375636365737366756C6C7920636F6D706C6574652E
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Run()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCheckpointCreated As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRefresh As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptions As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As Beacon.ServerStatus
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStopMessage As String
	#tag EndProperty


	#tag Constant, Name = OptionAnalyze, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionBackup, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionNuke, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionReview, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ThreadPriority"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
