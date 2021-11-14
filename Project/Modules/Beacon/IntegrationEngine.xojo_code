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

	#tag Method, Flags = &h21
		Private Sub CleanupCallbacks()
		  While Self.mPendingCalls.Count > 0
		    CallLater.Cancel(Self.mPendingCalls(0))
		    Self.mPendingCalls.RemoveAt(0)
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Profile As Beacon.ServerProfile)
		  Self.mProfile = Profile
		  If Profile Is Nil Then
		    Self.mID = EncodeHex(Crypto.GenerateRandomBytes(4)).Lowercase
		  Else
		    Self.mID = Profile.ProfileID.Left(8)
		  End If
		  Self.Log("Getting started…")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.CleanupCallbacks()
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

	#tag Method, Flags = &h1
		Protected Function GetFile(Filename As String, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile, Silent As Boolean, ByRef Success As Boolean) As String
		  Var Counter As Integer = 0
		  Var Message As String
		  Var Basename As String
		  While Counter < 3
		    If Self.Finished Then
		      Success = False
		      Return ""
		    End If
		    
		    Var Transfer As New Beacon.IntegrationTransfer(Filename)
		    Basename = Transfer.Filename
		    If Not Silent Then
		      Self.Log("Downloading " + Transfer.Filename + "…")
		    End If
		    RaiseEvent DownloadFile(Transfer, FailureMode, Profile)
		    
		    If Transfer.Success Then
		      Success = True
		      If Not Silent Then
		        Self.Log("Downloaded " + Transfer.Filename + ", size: " + Beacon.BytesToString(Transfer.Size))
		      End If
		      Return Transfer.Content
		    End If
		    
		    Message = Transfer.ErrorMessage
		    Counter = Counter + 1
		  Wend
		  
		  If Not Silent Then
		    Self.Log("Unable to download " + Basename + ": " + Message)
		  End If
		  
		  Success = False
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFile(Filename As String, FailureMode As DownloadFailureMode, Silent As Boolean, ByRef Success As Boolean) As String
		  Return Self.GetFile(Filename, FailureMode, Self.mProfile, Silent, Success)
		End Function
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
		  
		  If Self.mLogMessages.Count > 0 And Self.mLogMessages(Self.mLogMessages.LastIndex) = Message Then
		    // Don't duplicate the logs
		    Return
		  End If
		  
		  If ReplaceLast And Self.mLogMessages.Count > 0 Then
		    Self.mLogMessages(Self.mLogMessages.LastIndex) = Message
		  Else
		    Self.mLogMessages.Add(Message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logs(MostRecent As Boolean = False) As String
		  If Self.mLogMessages.Count = 0 Then
		    Return "Getting started…"
		  End If
		  
		  If MostRecent Then
		    Return Self.mLogMessages(Self.mLogMessages.LastIndex)
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

	#tag Method, Flags = &h1
		Protected Function PutFile(Contents As String, Filename As String, TriesRemaining As Integer = 2) As Boolean
		  Var Transfer As New Beacon.IntegrationTransfer(Filename, Contents)
		  Var DesiredHash As String = Transfer.SHA256
		  Var OriginalSize As Integer = Transfer.Size // Beacuse the transfer size will change after the event
		  Self.Log("Uploading " + Transfer.Filename + "…")
		  RaiseEvent UploadFile(Transfer)
		  
		  If Transfer.Success Then
		    Var DownloadSuccess As Boolean
		    Var CheckedContents As String = Self.GetFile(Filename, DownloadFailureMode.Required, True, DownloadSuccess)
		    If DownloadSuccess Then
		      Var CheckedHash As String = EncodeHex(Crypto.SHA2_256(CheckedContents)).Lowercase
		      If DesiredHash = CheckedHash Then
		        Self.Log("Uploaded " + Transfer.Filename + ", size: " + Beacon.BytesToString(OriginalSize))
		        Return True
		      Else
		        Self.Log(Transfer.Filename + " checksum does not match.")
		        #if DebugBuild
		          Self.Log("Expected hash " + DesiredHash + ", got " + CheckedHash)
		        #endif
		      End If
		    End If
		  End If
		  
		  If Self.Finished Then
		    Return False
		  End If
		  
		  If TriesRemaining > 0 Then
		    Self.Log(Filename + " upload failed, retrying…")
		    Return Self.PutFile(Contents, Filename, TriesRemaining - 1)
		  End If
		  
		  Self.Log("Could not upload " + Transfer.Filename + " and verify its content is correct on the server.")
		  
		  If Transfer.ErrorMessage.IsEmpty = False Then
		    Self.Log("Reason: " + Transfer.ErrorMessage)
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RefreshServerStatus()
		  Var SecondsSinceLastRefresh As Double = (System.Microseconds - Self.mLastRefresh) / 1000000
		  
		  Const WaitTime = 3.0
		  If SecondsSinceLastRefresh < WaitTime Then
		    If Thread.Current <> Nil Then
		      Thread.Current.Sleep((WaitTime - SecondsSinceLastRefresh) * 1000, False)
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
		    Self.mLogMessages.RemoveAt(Self.mLogMessages.LastIndex)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReviewEnabled() As Boolean
		  Return (Self.mOptions And CType(Self.OptionReview, UInt64)) = CType(Self.OptionReview, UInt64)
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
		  
		  If Self.SupportsCheckpoints And Self.mCheckpointCreated = False Then
		    RaiseEvent CreateCheckpoint
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDeploy(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Self.Log("Starting deploy of " + Self.Profile.Name)
		  
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
		  Var Organizer As Beacon.ConfigOrganizer = Self.Document.CreateConfigOrganizer(Self.mIdentity, Self.mProfile)
		  
		  If Self.mDoGuidedDeploy And Self.SupportsWideSettings Then
		    Var GuidedSuccess As Boolean = RaiseEvent ApplySettings(Organizer)
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
		  Var DownloadSuccess As Boolean
		  GameIniOriginal = Self.GetFile(Beacon.ConfigFileGame, DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finished = True
		    Return
		  End If
		  GameUserSettingsIniOriginal = Self.GetFile(Beacon.ConfigFileGameUserSettings, DownloadFailureMode.MissingAllowed, False, DownloadSuccess)
		  If Self.Finished Or DownloadSuccess = False Then
		    Self.Finished = True
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
		  
		  Var RewriteError As RuntimeException
		  
		  Var GameIniRewritten As String = Beacon.Rewriter.Rewrite(Beacon.Rewriter.Sources.Deploy, GameIniOriginal, Beacon.ShooterGameHeader, Beacon.ConfigFileGame, Organizer, Self.Document.TrustKey, Format, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  Var GameUserSettingsIniRewritten As String = Beacon.Rewriter.Rewrite(Beacon.Rewriter.Sources.Deploy, GameUserSettingsIniOriginal, Beacon.ServerSettingsHeader, Beacon.ConfigFileGameUserSettings, Organizer, Self.Document.TrustKey, Format, RewriteError)
		  If (RewriteError Is Nil) = False Then
		    Self.SetError(RewriteError)
		    Return
		  End If
		  
		  // Verify content looks acceptable
		  If Not Self.ValidateContent(GameUserSettingsIniRewritten, Beacon.ConfigFileGameUserSettings) Then
		    Return
		  End If
		  If Not Self.ValidateContent(GameIniRewritten, Beacon.ConfigFileGame) Then
		    Return
		  End If
		  
		  // Allow the user to review the new files if requested
		  If Self.ReviewEnabled And App.IdentityManager.CurrentIdentity.IsBanned = False Then
		    If Self.AnalyzeEnabled Then
		      // Analyzer would go here
		    End If
		    
		    Var Dict As New Dictionary
		    Dict.Value(Beacon.ConfigFileGame) = GameIniRewritten
		    Dict.Value(Beacon.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
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
		    Var OldFiles As New Dictionary
		    OldFiles.Value(Beacon.ConfigFileGame) = GameIniOriginal
		    OldFiles.Value(Beacon.ConfigFileGameUserSettings) = GameUserSettingsIniOriginal
		    
		    Var NewFiles As New Dictionary
		    NewFiles.Value(Beacon.ConfigFileGame) = GameIniRewritten
		    NewFiles.Value(Beacon.ConfigFileGameUserSettings) = GameUserSettingsIniRewritten
		    
		    Self.RunBackup(OldFiles, NewFiles)
		    
		    If Self.Finished Then
		      Return
		    End If
		  End If
		  
		  // Stop the server
		  If Self.SupportsRestarting Then
		    Self.StopServer()
		  End If
		  
		  // Let the implementor do any final work
		  RaiseEvent ReadyToUpload()
		  
		  // Put the new files on the server
		  If Self.PutFile(GameIniRewritten, Beacon.ConfigFileGame) = False Or Self.Finished Then
		    Self.Finished = True
		    Return
		  End If 
		  If Self.PutFile(GameUserSettingsIniRewritten, Beacon.ConfigFileGameUserSettings) = False Or Self.Finished Then
		    Self.Finished = True
		    Return
		  End If
		  
		  // Make command line changes
		  If Self.SupportsWideSettings Then
		    Self.Log("Updating other settings…")
		    Call RaiseEvent ApplySettings(Organizer)
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
		  Self.mPendingCalls.Add(CallLater.Schedule(1, WeakAddressOf TriggerDiscovered, DiscoveredData))
		  
		  RaiseEvent Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SendRequest(Socket As SimpleHTTP.SynchronousHTTPSocket, Method As String, URL As String)
		  Self.mThrottled = True
		  Var Locked As Boolean = Preferences.SignalConnection()
		  Self.mThrottled = False
		  Self.mActiveSocket = Socket
		  Socket.Send(Method, URL)
		  Self.mActiveSocket = Nil
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetError(Err As RuntimeException)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Var Reason As String
		  If Err.Message <> "" Then
		    Reason = Err.Message
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
		  Var Initial As Boolean = True
		  While True
		    Self.RefreshServerStatus()
		    
		    Select Case Self.mServerState
		    Case Self.StateRunning
		      If Not Confirmed Then
		        Initial = False
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
		      Initial = False
		    Case Self.StateStarting
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish starting…")
		      End If
		      Confirmed = True
		      Initial = False
		      Continue
		    Case Self.StateStopping
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish stopping so it can be started…")
		      End If
		      Initial = False
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

	#tag Method, Flags = &h0
		Function Status() As String
		  If Self.Cancelled Then
		    Return "Cancelled"
		  ElseIf Self.Finished And Self.Errored = False Then
		    Return "Finished"
		  ElseIf Self.Throttled And Self.Errored = False Then
		    Return "Waiting for another action…"
		  ElseIf (Self.mActiveSocket Is Nil) = False And (Self.mActiveSocket.Phase = SimpleHTTP.SynchronousHTTPSocket.Phases.Sending Or Self.mActiveSocket.Phase = SimpleHTTP.SynchronousHTTPSocket.Phases.Receiving) Then
		    Select Case Self.mActiveSocket.Phase
		    Case SimpleHTTP.SynchronousHTTPSocket.Phases.Sending
		      Var Sent As Int64 = Self.mActiveSocket.SentBytes
		      Var Total As Int64 = Self.mActiveSocket.SendingBytes
		      If Total > -1 Then
		        Var Percent As Double = Sent / Total
		        Return "Uploaded " + Beacon.BytesToString(Sent) + " of " + Beacon.BytesToString(Total) + " (" + Percent.ToString(Locale.Current, "0%") + ")"
		      Else
		        Return "Uploaded " + Beacon.BytesToString(Sent)
		      End If
		    Case SimpleHTTP.SynchronousHTTPSocket.Phases.Receiving
		      Var Received As Int64 = Self.mActiveSocket.ReceivedBytes
		      Var Total As Int64 = Self.mActiveSocket.ReceivingBytes
		      If Total > -1 Then
		        Var Percent As Double = Received / Total
		        Return "Downloaded " + Beacon.BytesToString(Received) + " of " + Beacon.BytesToString(Total) + " (" + Percent.ToString(Locale.Current, "0%") + ")"
		      Else
		        Return "Downloaded " + Beacon.BytesToString(Received)
		      End If
		    End Select
		  Else
		    Return Self.Logs(True)
		  End If
		End Function
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
		  Var Initial As Boolean = True
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
		      Initial = False
		    Case Self.StateStopped
		      If Not Confirmed Then
		        Initial = False
		        Continue
		      End If
		      If Verbose And EventFired Then
		        Self.Log("Server stopped.")
		      End If
		      Return
		    Case Self.StateStarting
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish starting so it can be stopped…")
		      End If
		      Initial = False
		      Continue
		    Case Self.StateStopping
		      If Verbose And Initial Then
		        Self.Log("Waiting for server to finish stopping…")
		      End If
		      Confirmed = True
		      Initial = False
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
		  If Not Self.mFinished Then
		    Self.SetError("Terminated")
		  End If
		  
		  If Self.mRunThread <> Nil And Self.mRunThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.mRunThread.Stop
		  End If
		  
		  Self.CleanupCallbacks()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  Return Self.mThrottled
		End Function
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
		  
		  If MissingHeaders.Count = 0 Then
		    Return True
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("File") = Filename
		  Dict.Value("Groups") = MissingHeaders
		  If MissingHeaders.Count > 1 Then
		    Dict.Value("Message") = Filename + " is not valid because it is missing the following groups: " + MissingHeaders.EnglishOxfordList + "."
		  Else
		    Dict.Value("Message") = Filename + " is not valid because it is missing its " + MissingHeaders(0) + " group."
		  End If
		  
		  Var Controller As New Beacon.TaskWaitController("ValidationFailed", Dict)
		  
		  Self.Log("Content validation failed!")
		  Self.Wait(Controller)
		  If Controller.Cancelled Then
		    Self.SetError(Dict.Value("Message").StringValue)
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Wait(Controller As Beacon.TaskWaitController)
		  If Thread.Current = Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wait cannot be called on the main thread."
		    Raise Err
		    Return
		  End If
		  
		  Self.mActiveWaitController = Controller
		  Self.mPendingCalls.Add(CallLater.Schedule(1, WeakAddressOf FireWaitEvent, Controller))
		  
		  While Not Controller.ShouldResume
		    Thread.Current.Sleep(100, False)
		  Wend
		  Self.mActiveWaitController = Nil
		  
		  If Controller.Cancelled Then
		    Self.Cancel
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Wait(Milliseconds As Double)
		  If Thread.Current = Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wait cannot be called on the main thread."
		    Raise Err
		    Return
		  End If
		  
		  Thread.Current.Sleep(Milliseconds, False)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ApplySettings(Organizer As Beacon.ConfigOrganizer) As Boolean
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
		Event DownloadFile(Transfer As Beacon.IntegrationTransfer, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile)
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
		Event UploadFile(Transfer As Beacon.IntegrationTransfer)
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
		Private mActiveSocket As SimpleHTTP.SynchronousHTTPSocket
	#tag EndProperty

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

	#tag Property, Flags = &h21
		Private mThrottled As Boolean
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


	#tag Enum, Name = DownloadFailureMode, Flags = &h1
		Required
		  MissingAllowed
		ErrorsAllowed
	#tag EndEnum


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
