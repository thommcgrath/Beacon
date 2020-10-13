#tag Class
Protected Class IntegrationEngine
	#tag Method, Flags = &h0
		Function AnalyzeEnabled() As Boolean
		  Return (Self.mOptions And (CType(Self.OptionAnalyze, UInt64) Or CType(Self.OptionReview, UInt64))) = (CType(Self.OptionAnalyze, UInt64) Or CType(Self.OptionReview, UInt64))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupEnabled() As Boolean
		  Return (Self.mOptions And CType(Self.OptionBackup, UInt64)) = CType(Self.OptionBackup, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BeginDeploy(Label As String, Document As Beacon.Document, Identity As Beacon.Identity, StopMessage As String, Options As UInt64)
		  Self.mLabel = Label
		  Self.mDocument = Document
		  Self.mIdentity = Identity
		  Self.mStopMessage = StopMessage
		  Self.mOptions = Options
		  Self.mMode = Self.ModeDeploy
		  
		  Self.mRunThread = New Thread
		  Self.mRunThread.Priority = Thread.LowestPriority
		  AddHandler Self.mRunThread.Run, WeakAddressOf RunDeploy
		  Self.mRunThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BeginDiscovery()
		  Self.mMode = Self.ModeDiscover
		  Self.mDocument = New Beacon.Document
		  Self.mRunThread = New Thread
		  Self.mRunThread.Priority = Thread.LowestPriority
		  AddHandler Self.mRunThread.Run, WeakAddressOf RunDiscover
		  Self.mRunThread.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		  Self.mFinished = True
		  Self.Log("Cancelled")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cancelled() As Boolean
		  Return Self.mCancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Profile As Beacon.ServerProfile)
		  Self.mProfile = Profile
		  Self.mID = EncodeHex(Crypto.GenerateRandomBytes(4)).Lowercase()
		  Self.Log("Getting started…")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  While Self.mPendingCalls.Count > 0
		    CallLater.Cancel(Self.mPendingCalls(0))
		    Self.mPendingCalls.RemoveRowAt(0)
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Document() As Beacon.Document
		  Return Self.mDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Errored(Assigns Value As Boolean)
		  Self.mErrored = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorMessage() As String
		  Return Self.mErrorMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ErrorMessage(Assigns Value As String)
		  Self.mErrorMessage = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished Or Self.mErrored Or Self.mCancelled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Finished(Assigns Value As Boolean)
		  Self.mFinished = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FireWaitEvent(Param As Variant)
		  Var Controller As Beacon.TaskWaitController
		  If Param IsA Beacon.TaskWaitController Then
		    Controller = Beacon.TaskWaitController(Param)
		  End If
		  
		  If Controller Is Nil Then
		    Return
		  End If
		  
		  If RaiseEvent Wait(Controller) = False Then
		    Controller.Cancelled = False
		    Controller.ShouldResume = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ID() As String
		  Return Self.mID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Identity() As Beacon.Identity
		  Return Self.mIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Log(Message As String, ReplaceLast As Boolean = False)
		  App.Log(Self.mID + Encodings.ASCII.Chr(9) + Message)
		  
		  If Self.mLogMessages.Count > 0 And Self.mLogMessages(Self.mLogMessages.LastRowIndex) = Message Then
		    // Don't duplicate the logs
		    Return
		  End If
		  
		  If ReplaceLast And Self.mLogMessages.Count > 0 Then
		    Self.mLogMessages(Self.mLogMessages.LastRowIndex) = Message
		  Else
		    Self.mLogMessages.AddRow(Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logs(MostRecent As Boolean = False) As String
		  If Self.mLogMessages.Count = 0 Then
		    Return "Getting started…"
		  End If
		  
		  If MostRecent Then
		    Return Self.mLogMessages(Self.mLogMessages.LastRowIndex)
		  Else
		    Return Self.mLogMessages.Join(EndOfLine)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As Integer
		  Return Self.mMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  Return Self.mProfile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PutFile(Contents As String, Filename As String) As Boolean
		  Var Counter As Integer = 0
		  Var DesiredHash As String = EncodeHex(Crypto.MD5(Contents)).Lowercase
		  Self.Log("Uploading " + Filename + "…")
		  While Counter < 3
		    If Self.Finished Then
		      Return False
		    End If
		    
		    If RaiseEvent UploadFile(Contents, Filename) Then
		      If Self.Finished Then
		        Return False
		      End If
		      
		      Var CheckedContents As String = RaiseEvent DownloadFile(Filename)
		      If Self.Finished Then
		        Return False
		      End If
		      
		      Var CheckedHash As String = EncodeHex(Crypto.MD5(CheckedContents)).Lowercase
		      If DesiredHash = CheckedHash Then
		        Return True
		      Else
		        Self.Log("Checksum of " + Filename + " is " + CheckedHash + ", expected " + DesiredHash + ".")
		        Self.Log(Filename + " checksum does not match, retrying…")
		      End If
		    Else
		      Self.Log(Filename + " upload failed, retrying…")
		    End If
		    Counter = Counter + 1
		  Wend
		  
		  Self.SetError("Could not verify " + Filename + " is correct on the server.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshServerStatus()
		  Var SecondsSinceLastRefresh As Double = (System.Microseconds - Self.mLastRefresh) / 1000000
		  
		  Const WaitTime = 3.0
		  If SecondsSinceLastRefresh < WaitTime Then
		    If App.CurrentThread <> Nil Then
		      App.CurrentThread.Sleep((WaitTime - SecondsSinceLastRefresh) * 1000, False)
		    Else
		      Var Err As New UnsupportedOperationException
		      Err.Message = "Cannot sleep the main thread"
		      Raise Err
		    End If
		  End If
		  
		  Self.mLastRefresh = System.Microseconds
		  RaiseEvent RefreshServerStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RemoveLastLog()
		  If Self.mLogMessages.Count > 0 Then
		    Self.mLogMessages.RemoveRowAt(Self.mLogMessages.LastRowIndex)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReviewEnabled() As Boolean
		  Return (Self.mOptions And CType(Self.OptionReview, UInt64)) = CType(Self.OptionReview, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDeploy(Sender As Thread)
		  #Pragma Unused Sender
		  
		  // Give the implementor time to setup
		  RaiseEvent Begin
		  
		  // Start by querying the server
		  If Self.SupportsStatus Then
		    Self.Log("Getting server status…")
		    Self.RefreshServerStatus()
		    If Self.Finished Then
		      Return
		    End If
		  Else
		    Self.State = Self.StateUnsupported
		  End If
		  Var InitialServerState As Integer = Self.State
		  
		  If Self.mDoGuidedDeploy And Self.SupportsWideSettings Then
		    Var GameIniValues(), GameUserSettingsIniValues(), CommandLineValues() As Beacon.ConfigValue
		    Var Groups() As Beacon.ConfigGroup = Self.Document.ImplementedConfigs
		    Var CustomContent As BeaconConfigs.CustomContent
		    For Each Group As Beacon.ConfigGroup In Groups
		      If Group IsA BeaconConfigs.CustomContent Then
		        CustomContent = BeaconConfigs.CustomContent(Group)
		        Continue
		      End If
		      
		      GameIniValues.AddArray(Group.GameIniValues(Self.Document, Self.Identity, Self.Profile))
		      GameUserSettingsIniValues.AddArray(Group.GameUserSettingsIniValues(Self.Document, Self.Identity, Self.Profile))
		      CommandLineValues.AddArray(Group.CommandLineOptions(Self.Document, Self.Identity, Self.Profile))
		    Next
		    
		    If (CustomContent Is Nil) = False Then
		      Var GameIniDict As New Dictionary
		      Beacon.ConfigValue.FillConfigDict(GameIniDict, GameIniValues)
		      GameIniValues.AddArray(CustomContent.GameIniValues(Self.Document, GameIniDict, Self.Profile))
		      
		      Var GameUserSettingsIniDict As New Dictionary
		      Beacon.ConfigValue.FillConfigDict(GameUserSettingsIniDict, GameUserSettingsIniValues)
		      GameUserSettingsIniValues.AddArray(CustomContent.GameUserSettingsIniValues(Self.Document, GameUserSettingsIniDict, Self.Profile))
		      
		      CommandLineValues.AddArray(CustomContent.CommandLineOptions(Self.Document, Self.Identity, Self.Profile))
		    End If
		    
		    Var GuidedSuccess As Boolean = RaiseEvent ApplySettings(GameIniValues, GameUserSettingsIniValues, CommandLineValues)
		    If Self.Finished Then
		      Return
		    End If
		    
		    If GuidedSuccess Then
		      // Restart the server if it is running
		      If Self.SupportsRestarting And (InitialServerState = Self.StateRunning Or InitialServerState = Self.StateStarting) Then
		        Self.StopServer()
		        Self.StartServer()
		      End If
		      
		      Self.Log("Finished")
		      Self.Finished = True
		      
		      RaiseEvent Finished
		      Return
		    Else
		      Self.mDoGuidedDeploy = False
		    End If
		  End If
		  
		  Var GameIniOriginal, GameUserSettingsIniOriginal As String
		  // Download the ini files
		  Self.Log("Downloading Game.ini…")
		  GameIniOriginal = RaiseEvent DownloadFile("Game.ini")
		  If Self.Finished Then
		    Return
		  End If
		  Self.Log("Downloading GameUserSettings.ini")
		  GameUserSettingsIniOriginal = RaiseEvent DownloadFile("GameUserSettings.ini")
		  If Self.Finished Then
		    Return
		  End If
		  
		  // Build the new ini files
		  Self.Log("Generating new ini files…")
		  
		  Var Format As Beacon.Rewriter.EncodingFormat
		  If Self.Document.AllowUCS Then
		    Format = Beacon.Rewriter.EncodingFormat.UCS2AndASCII
		  Else
		    Format = Beacon.Rewriter.EncodingFormat.ASCII
		  End If
		  
		  Var RewriteErrored As Boolean
		  
		  Var GameIniRewritten As String = Beacon.Rewriter.Rewrite(GameIniOriginal, Beacon.RewriteModeGameIni, Self.Document, Self.Identity, Self.Document.TrustKey, Self.mProfile, Format, RewriteErrored)
		  If RewriteErrored Then
		    Self.SetError("Failed to produce Game.ini")
		    Return
		  End If
		  
		  Var GameUserSettingsIniRewritten As String = Beacon.Rewriter.Rewrite(GameUserSettingsIniOriginal, Beacon.RewriteModeGameUserSettingsIni, Self.Document, Self.Identity, Self.Document.TrustKey, Self.mProfile, Format, RewriteErrored)
		  If RewriteErrored Then
		    Self.SetError("Failed to produce GameUserSettings.ini")
		    Return
		  End If
		  
		  // Verify content looks acceptable
		  If Not Self.ValidateContent(GameUserSettingsIniRewritten, "GameUserSettings.ini") Then
		    Return
		  End If
		  If Not Self.ValidateContent(GameIniRewritten, "Game.ini") Then
		    Return
		  End If
		  
		  Var CommandLine() As Beacon.ConfigValue
		  If Self.SupportsWideSettings Then
		    Var Groups() As Beacon.ConfigGroup = Self.Document.ImplementedConfigs
		    For Each Group As Beacon.ConfigGroup In Groups
		      If Group.ConfigName = BeaconConfigs.CustomContent.ConfigName Then
		        Continue
		      End If
		      
		      Var Options() As Beacon.ConfigValue = Group.CommandLineOptions(Self.Document, Self.Identity, Self.mProfile)
		      For Each Option As Beacon.ConfigValue In Options
		        CommandLine.AddRow(Option)
		      Next
		    Next
		  End If
		  
		  // Allow the user to review the new files if requested
		  If Self.ReviewEnabled And App.IdentityManager.CurrentIdentity.IsBanned = False Then
		    If Self.AnalyzeEnabled Then
		      // Analyzer would go here
		    End If
		    
		    Var Dict As New Dictionary
		    Dict.Value("Game.ini") = GameIniRewritten
		    Dict.Value("GameUserSettings.ini") = GameUserSettingsIniRewritten
		    Dict.Value("Advice") = Nil // The results would go here
		    
		    Var Controller As New Beacon.TaskWaitController("Review Files", Dict)
		    
		    Self.Log("Waiting for user review")
		    Self.Wait(Controller)
		    If Controller.Cancelled Then
		      Return
		    End If
		  End If
		  
		  // Run the backup if requested
		  If Self.BackupEnabled Then
		    Var Dict As New Dictionary
		    Dict.Value("Game.ini") = GameIniOriginal
		    Dict.Value("GameUserSettings.ini") = GameUserSettingsIniOriginal
		    Dict.Value("New Game.ini") = GameIniRewritten
		    Dict.Value("New GameUserSettings.ini") = GameUserSettingsIniRewritten
		    
		    Var Controller As New Beacon.TaskWaitController("Backup", Dict)
		    
		    Self.Log("Backing up config files…")
		    Self.Wait(Controller)
		    If Controller.Cancelled Then
		      Self.Cancel
		      Return
		    End If
		    
		    If Self.SupportsCheckpoints And Self.mCheckpointCreated = False Then
		      RaiseEvent CreateCheckpoint
		      If Self.Finished Then
		        Return
		      End If
		    End If
		  End If
		  
		  // Stop the server
		  If Self.SupportsRestarting Then
		    Self.StopServer()
		  End If
		  
		  // Let the implementor do any final work
		  RaiseEvent ReadyToUpload()
		  
		  // Put the new files on the server
		  If Self.PutFile(GameIniRewritten, "Game.ini") = False Or Self.Finished Then
		    Return
		  End If 
		  If Self.PutFile(GameUserSettingsIniRewritten, "GameUserSettings.ini") = False Or Self.Finished Then
		    Return
		  End If
		  
		  // Make command line changes
		  If Self.SupportsWideSettings And CommandLine.Count > 0 Then
		    Self.Log("Updating other settings…")
		    Var Placeholder() As Beacon.ConfigValue
		    Call RaiseEvent ApplySettings(Placeholder, Placeholder, CommandLine)
		    If Self.Finished Then
		      Return
		    End If
		  End If
		  
		  // And start the server if it was already running
		  If Self.SupportsRestarting And (InitialServerState = Self.StateRunning Or InitialServerState = Self.StateStarting) Then
		    Self.StartServer()
		  End If
		  
		  Self.Log("Finished")
		  Self.Finished = True
		  
		  RaiseEvent Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDiscover(Sender As Thread)
		  #Pragma Unused Sender
		  
		  // Give the implementor time to setup
		  RaiseEvent Begin
		  If Self.Finished Then
		    Return
		  End If
		  
		  // Perform discovery of the needed files
		  Var DiscoveredData() As Beacon.DiscoveredData = RaiseEvent Discover
		  If DiscoveredData = Nil Then
		    If Self.Errored = False Then
		      Self.SetError("Discovery implementation incomplete.")
		    End If
		    Return
		  End If
		  
		  // And done
		  Self.Log("Finished")
		  Self.Finished = True
		  
		  // Need this to fire on the main thread
		  Self.mPendingCalls.AddRow(CallLater.Schedule(1, WeakAddressOf TriggerDiscovered, DiscoveredData))
		  
		  RaiseEvent Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetError(Err As RuntimeException)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Var Reason As String
		  If Err.Reason <> "" Then
		    Reason = Err.Reason
		  ElseIf Err.Message <> "" Then
		    Reason = Err.Message
		  Else
		    Reason = "No details available"
		  End If
		  
		  Self.Log("Error: Unhandled " + Info.FullName + ": '" + Reason + "'")
		  Self.ErrorMessage = "Error: Unhandled " + Info.FullName + ": '" + Reason + "'"
		  Self.Errored = True
		  Self.Finished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetError(Message As String)
		  Self.Log(Message)
		  Self.ErrorMessage = Message
		  Self.Errored = True
		  Self.Finished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StartServer(Verbose As Boolean = True)
		  Var EventFired As Boolean
		  Var Confirmed As Boolean = Self.State = Self.StateRunning
		  While True
		    Self.RefreshServerStatus()
		    
		    Select Case Self.mServerState
		    Case Self.StateRunning
		      If Not Confirmed Then
		        Continue
		      End If
		      If Verbose And EventFired Then
		        Self.Log("Server started.")
		      End If
		      Return
		    Case Self.StateStopped
		      If Not EventFired Then
		        If Verbose Then
		          Self.Log("Starting server…")
		        End If
		        RaiseEvent StartServer()
		        EventFired = True
		      End If
		    Case Self.StateStarting
		      Confirmed = True
		      Continue
		    Case Self.StateStopping
		      Continue
		    Else
		      Self.SetError("Error: Server neither started nor stopped.")
		      Return
		    End Select
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function State() As Integer
		  Return Self.mServerState
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub State(Assigns Value As Integer)
		  Self.mServerState = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StopMessage() As String
		  Return Self.mStopMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StopServer(Verbose As Boolean = True)
		  Var EventFired As Boolean
		  Var Confirmed As Boolean = Self.State = Self.StateStopped
		  While True
		    Self.RefreshServerStatus()
		    
		    Select Case Self.mServerState
		    Case Self.StateRunning
		      If Not EventFired Then
		        If Verbose Then
		          Self.Log("Stopping server…")
		        End If
		        RaiseEvent StopServer()
		        EventFired = True
		      End If
		    Case Self.StateStopped
		      If Not Confirmed Then
		        Continue
		      End If
		      If Verbose And EventFired Then
		        Self.Log("Server stopped.")
		      End If
		      Return
		    Case Self.StateStarting
		      Continue
		    Case Self.StateStopping
		      Confirmed = True
		      Continue
		    Else
		      Self.SetError("Error: Server neither started nor stopped")
		      Return
		    End Select
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsWideSettings() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Terminate()
		  If Self.mRunThread <> Nil And Self.mRunThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.mRunThread.Stop
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerDiscovered(Value As Variant)
		  Var Data() As Beacon.DiscoveredData
		  Try
		    Data = Value
		  Catch Err As RuntimeException
		  End Try
		  RaiseEvent Discovered(Data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ValidateContent(Content As String, Filename As String) As Boolean
		  Var MissingHeaders() As String = Beacon.ValidateIniContent(Content, Filename)
		  
		  If MissingHeaders.Count > 1 Then
		    Self.SetError(Filename + " is not valid because it is missing the following groups: " + MissingHeaders.EnglishOxfordList + ".")
		  ElseIf MissingHeaders.Count = 1 Then
		    Self.SetError(Filename + " is not valid because it is missing its " + MissingHeaders(0) + " group.")
		  End If
		  
		  Return MissingHeaders.Count = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Wait(Controller As Beacon.TaskWaitController)
		  If App.CurrentThread = Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wait cannot be called on the main thread."
		    Raise Err
		    Return
		  End If
		  
		  Self.mActiveWaitController = Controller
		  Self.mPendingCalls.AddRow(CallLater.Schedule(1, WeakAddressOf FireWaitEvent, Controller))
		  
		  While Not Controller.ShouldResume
		    App.CurrentThread.Sleep(100, False)
		  Wend
		  Self.mActiveWaitController = Nil
		  
		  If Controller.Cancelled Then
		    Self.Cancel
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Wait(Milliseconds As Double)
		  If App.CurrentThread = Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wait cannot be called on the main thread."
		    Raise Err
		    Return
		  End If
		  
		  App.CurrentThread.Sleep(Milliseconds, False)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ApplySettings(GameIniValues() As Beacon.ConfigValue, GameUserSettingsIniValues() As Beacon.ConfigValue, CommandLineOptions() As Beacon.ConfigValue) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Begin()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CreateCheckpoint()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Discover() As Beacon.DiscoveredData()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Discovered(Data() As Beacon.DiscoveredData)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DownloadFile(Filename As String) As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadyToUpload()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RefreshServerStatus()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StartServer()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StopServer()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UploadFile(Contents As String, Filename As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Wait(Controller As Beacon.TaskWaitController) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mActiveWaitController <> Nil And Self.mActiveWaitController.ShouldResume = False Then
			    Return Self.mActiveWaitController
			  End If
			End Get
		#tag EndGetter
		ActiveWaitController As Beacon.TaskWaitController
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActiveWaitController As Beacon.TaskWaitController
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCheckpointCreated As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDoGuidedDeploy As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mID As String
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
		Private mLogMessages() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptions As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPendingCalls() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerState As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStopMessage As String
	#tag EndProperty


	#tag Constant, Name = ModeDeploy, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeDiscover, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionAnalyze, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionBackup, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionReview, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateOther, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateRunning, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateStarting, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateStopped, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateStopping, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StateUnsupported, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
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
