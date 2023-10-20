#tag Class
Protected Class Integration
Implements Beacon.LogProducer
	#tag Method, Flags = &h1
		Protected Sub Begin()
		  Self.mThread.Start
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

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  If Profile Is Nil Then
		    Var Err As New RuntimeException
		    Err.Message = "Nil profile"
		    Raise Err
		  End If
		  
		  Self.mProfile = Profile
		  Self.mProvider = Profile.CreateHostingProvider()
		  Self.mIntegrationId = Profile.ProfileId.Left(8)
		  
		  Self.mThread = New Global.Thread
		  #if DebugBuild
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Self)
		    Self.mThread.DebugIdentifier = Info.FullName + ".RunThread"
		  #endif
		  AddHandler mThread.Run, WeakAddressOf mThread_Run
		  AddHandler mThread.UserInterfaceUpdate, WeakAddressOf mThread_UserInterfaceUpdate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EnterResourceIntenseMode()
		  If Self.mResourceIntenseLock Is Nil Then
		    Self.mResourceIntenseLock = New CriticalSection
		  End If
		  
		  Self.mResourceIntenseLock.Enter
		  Self.mInResourceIntenseMode = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorMessage() As String
		  Return Self.mErrorMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExitResourceIntenseMode()
		  If Self.mResourceIntenseLock Is Nil Then
		    Return
		  End If
		  
		  Self.mInResourceIntenseMode = False
		  Self.mResourceIntenseLock.Leave
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Finish()
		  Self.mFinished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FireEvent(EventName As String, UpdateData As Dictionary)
		  Select Case EventName
		  Case "Wait"
		    Var Controller As Beacon.TaskWaitController = UpdateData.Value("Controller")
		    If RaiseEvent Wait(Controller) = False Then
		      Controller.Cancelled = False
		      Controller.ShouldResume = True
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFile(Path As String, DisplayName As String, FailureMode As Beacon.Integration.DownloadFailureMode, Profile As Beacon.ServerProfile, Silent As Boolean, ByRef Success As Boolean) As String
		  Var Counter As Integer = 0
		  Var Message As String
		  While Counter < 3
		    If Self.Finished Then
		      Success = False
		      Return ""
		    End If
		    
		    Var Transfer As New Beacon.IntegrationTransfer(Path)
		    If Not Silent Then
		      Self.Log("Downloading " + DisplayName + "…")
		    End If
		    
		    Try
		      Self.mProvider.DownloadFile(Self, Profile, Transfer, FailureMode)
		      If Not Silent Then
		        Self.Log("Downloaded " + DisplayName + ", size: " + Beacon.BytesToString(Transfer.Size))
		      End If
		      Success = True
		      Return Transfer.Content
		    Catch Err As RuntimeException
		      Message = Transfer.ErrorMessage
		      Counter = Counter + 1
		    End Try
		  Wend
		  
		  If Not Silent Then
		    Self.Log("Unable to download " + DisplayName + ": " + Message)
		  End If
		  
		  Success = False
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFile(Path As String, DisplayName As String, FailureMode As Beacon.Integration.DownloadFailureMode, Silent As Boolean, ByRef Success As Boolean) As String
		  Return Self.GetFile(Path, DisplayName, FailureMode, Self.mProfile, Silent, Success)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IntegrationId() As String
		  Return Self.mIntegrationId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsInResourceIntenseMode() As Boolean
		  Return Self.mInResourceIntenseMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Log(Message As String, ReplaceLast As Boolean = False)
		  // Part of the Beacon.LogProducer interface.
		  
		  Var Lines() As String = Message.Trim.Split(EndOfLine)
		  For Each Line As String In Lines
		    Line = Line.Trim
		    If Line.IsEmpty Then
		      Continue
		    End If
		    
		    App.Log(Self.mIntegrationId + Encodings.ASCII.Chr(9) + Line)
		    
		    If Self.mLogMessages.Count > 0 And Self.mLogMessages(Self.mLogMessages.LastIndex) = Line Then
		      // Don't duplicate the logs
		      Return
		    End If
		    
		    If ReplaceLast And Self.mLogMessages.Count > 0 Then
		      Self.mLogMessages(Self.mLogMessages.LastIndex) = Line
		    Else
		      Self.mLogMessages.Add(Line)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logs(MostRecent As Boolean = False) As String
		  // Part of the Beacon.LogProducer interface.
		  
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

	#tag Method, Flags = &h21
		Private Sub mThread_Run(Sender As Global.Thread)
		  Sender.YieldToNext
		  
		  Self.mRunning = True
		  #if TargetMacOS
		    Var ProcessInfo As NSProcessInfoMBS = NSProcessInfoMBS.ProcessInfo
		    Var Activity As NSProcessInfoActivityMBS = ProcessInfo.BeginActivity(NSProcessInfoMBS.NSActivityUserInitiated, "Interacting with a game server")
		  #endif
		  Try
		    RaiseEvent Run()
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Running integration thread")
		    Self.SetError(Err)
		  End Try
		  #if TargetMacOS
		    ProcessInfo.EndActivity(Activity)
		  #endif
		  Self.mFinished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_UserInterfaceUpdate(Sender As Global.Thread, Updates() As Dictionary)
		  For Each Update As Dictionary In Updates
		    Try
		      If Update.HasKey("Event") Then
		        Var EventName As String = Update.Value("Event")
		        Self.FireEvent(EventName, Update)
		      End If 
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Executing an integration event")
		    End Try
		  Next
		End Sub
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

	#tag Method, Flags = &h0
		Function Provider() As Beacon.HostingProvider
		  Return Self.mProvider
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PutFile(Contents As String, Path As String, DisplayName As String, TriesRemaining As Integer = 2) As Boolean
		  Var Transfer As New Beacon.IntegrationTransfer(Path, Contents)
		  Var DesiredHash As String = Transfer.SHA256
		  Var OriginalSize As Integer = Transfer.Size // Beacuse the transfer size will change after the event
		  Self.Log("Uploading " + DisplayName + "…")
		  Try
		    Self.mProvider.UploadFile(Self, Self.mProfile, Transfer)
		    
		    Var DownloadSuccess As Boolean
		    Var CheckedContents As String = Self.GetFile(Path, DisplayName, DownloadFailureMode.Required, True, DownloadSuccess)
		    If DownloadSuccess Then
		      Var CheckedHash As String = EncodeHex(Crypto.SHA2_256(CheckedContents)).Lowercase
		      If DesiredHash = CheckedHash Then
		        Self.Log("Uploaded " + DisplayName + ", size: " + Beacon.BytesToString(OriginalSize))
		        Return True
		      Else
		        Self.Log(DisplayName + " checksum does not match.")
		        #if DebugBuild
		          Self.Log("Expected hash " + DesiredHash + ", got " + CheckedHash)
		        #endif
		      End If
		    End If
		  Catch Err As RuntimeException
		  End Try
		  
		  If Self.Finished Then
		    Return False
		  End If
		  
		  If TriesRemaining > 0 Then
		    Self.Log(DisplayName + " upload failed, retrying…")
		    Return Self.PutFile(Contents, Path, DisplayName, TriesRemaining - 1)
		  End If
		  
		  Self.SetError("Could not upload " + DisplayName + " and verify its content is correct on the server.")
		  
		  If Transfer.ErrorMessage.IsEmpty = False Then
		    Self.Log("Reason: " + Transfer.ErrorMessage)
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RemoveLastLog()
		  // Part of the Beacon.LogProducer interface.
		  
		  If Self.mLogMessages.Count > 0 Then
		    Self.mLogMessages.RemoveAt(Self.mLogMessages.LastIndex)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Running() As Boolean
		  Return Self.mRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetError(Err As RuntimeException)
		  Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Var Reason As String
		  If Err.Message.IsEmpty = False Then
		    Reason = Err.Message
		  Else
		    Reason = "No details available"
		  End If
		  
		  Self.SetError("Error: Unhandled " + Info.FullName + ": '" + Reason + "'")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetError(Message As String)
		  Self.Log(Message)
		  Self.mErrorMessage = Message
		  Self.mErrored = True
		  Self.mFinished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusMessage() As String
		  If Self.Cancelled Then
		    Return "Cancelled"
		  ElseIf Self.Finished And Self.Errored = False Then
		    Return "Finished"
		  ElseIf Self.Throttled And Self.Errored = False Then
		    Return "Waiting for another action…"
		  End If
		  
		  Var SocketStatus As String = Self.Provider.SocketStatus
		  If SocketStatus.IsEmpty = False Then
		    Return SocketStatus
		  End If
		  
		  Return Self.Logs(True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Terminate()
		  If Not Self.mFinished Then
		    Self.SetError("Terminated")
		  End If
		  
		  If (Self.mThread Is Nil) = False And Self.mThread.ThreadState <> Global.Thread.ThreadStates.NotRunning Then
		    Self.mThread.Stop
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Thread() As Global.Thread
		  Return Self.mThread
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  Return Self.Provider.Throttled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Wait(Controller As Beacon.TaskWaitController)
		  If Self.Finished Then
		    Return
		  End If
		  
		  Self.mActiveWaitController = Controller
		  
		  Var Dict As New Dictionary
		  Dict.Value("Controller") = Controller
		  Dict.Value("Event") = "Wait"
		  Self.mThread.AddUserInterfaceUpdate(Dict)
		  
		  While Not Controller.ShouldResume
		    Self.mThread.Sleep(100, False)
		  Wend
		  Self.mActiveWaitController = Nil
		  
		  If Controller.Cancelled Then
		    Self.Cancel
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Wait(Milliseconds As Double)
		  If Self.Finished Then
		    Return
		  End If
		  
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
		Event Run()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Wait(Controller As Beacon.TaskWaitController) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If (Self.mActiveWaitController Is Nil) = False And Self.mActiveWaitController.ShouldResume = False Then
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
		Private mInResourceIntenseMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIntegrationId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogMessages() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProvider As Beacon.HostingProvider
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mResourceIntenseLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRunning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThread As Global.Thread
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mThread Is Nil Then
			    Return Thread.NormalPriority
			  End If
			  
			  Return Self.mThread.Priority
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mThread Is Nil Then
			    Return
			  End If
			  
			  Self.mThread.Priority = Value
			End Set
		#tag EndSetter
		ThreadPriority As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mThread Is Nil Then
			    Return Global.Thread.ThreadStates.NotRunning
			  End If
			  
			  Return Self.mThread.ThreadState
			End Get
		#tag EndGetter
		ThreadState As Global.Thread.ThreadStates
	#tag EndComputedProperty


	#tag Enum, Name = DownloadFailureMode, Flags = &h0
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
		#tag ViewProperty
			Name="ThreadPriority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
