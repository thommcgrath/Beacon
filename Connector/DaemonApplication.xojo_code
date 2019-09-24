#tag Class
Protected Class DaemonApplication
Inherits ServiceApplication
	#tag Event
		Function DontDaemonize() As Boolean
		  #if DebugBuild
		    Return True
		  #endif
		  
		  Return RaiseEvent DontDaemonize
		End Function
	#tag EndEvent

	#tag Event
		Function Run(args() as String) As Integer
		  Self.ShouldRun = True
		  
		  Try
		    RaiseEvent Open(Args)
		  Catch ShouldQuit As EndException
		    Self.ShouldRun = False
		  Catch Err As RuntimeException
		    If Not RaiseEvent UnhandledException(Err) Then
		      Return -1
		    End If
		  End Try
		  
		  If Self.ShouldRun Then
		    RegisterSignal(Signals.SIGTERM)
		    RegisterSignal(Signals.SIGINT)
		  End If
		  
		  While Self.ShouldRun
		    Try
		      Self.DoEvents(10)
		    Catch EE As EndException
		      Self.ShouldRun = False
		    Catch Err As RuntimeException
		      If Not RaiseEvent UnhandledException(Err) Then
		        Return -1
		      End If
		    End Try
		  Wend
		  
		  Try
		    RaiseEvent Close
		  Catch ShouldQuit As EndException
		    // Yeah, we know
		  Catch Err As RuntimeException
		    If Not RaiseEvent UnhandledException(Err) Then
		      Return -1
		    End If
		  End Try
		  
		  Return 0
		End Function
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Return RaiseEvent UnhandledException(Error)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function HandleException(Err As RuntimeException) As Boolean
		  Return RaiseEvent UnhandledException(Err)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub HandleSignal(Signal As Signals)
		  #if Not TargetWin32
		    Try
		      If Signal = Signals.SIGTERM Then
		        // Must shutdown now
		        
		        #if TargetLinux
		          Declare Sub exit_func Lib "libc" Alias "exit" (exitCode As Integer)
		        #elseif TargetMacOS
		          Declare Sub exit_func Lib "System.framework" Alias "exit" (exitCode As Integer)
		        #endif
		        
		        exit_func(0)
		      ElseIf App IsA DaemonApplication Then
		        DaemonApplication(App).ReceiveSignal(Signal)
		      End If
		      
		    Catch Err As RuntimeException
		      
		    End Try
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String)
		  Self.Log(Message, System.LogLevelDebug)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(Message As String, Level As Integer)
		  #if DebugBuild
		    Print Message
		  #endif
		  
		  RaiseEvent ReceivedLogMessage(Message, Level)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReceiveSignal(Signal As Signals)
		  Dim Handled As Boolean = RaiseEvent SignalReceived(Signal)
		  If Not Handled Then
		    Select Case Signal
		    Case Signals.SIGINT, Signals.SIGQUIT
		      // Graceful shutdown
		      Self.ShouldRun = False
		    End Select
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RegisterSignal(Signal As Signals)
		  #if Not TargetWin32
		    Dim Action As SignalAction
		    Action.Handler = AddressOf HandleSignal
		    
		    #if TargetLinux
		      Declare Function sigaction Lib "libc" (Sig As Signals, ByRef Action As SignalAction, OldAction As Ptr) As Integer
		    #elseif TargetMacOS
		      Declare Function sigaction Lib "System.framework" (Sig As Signals, ByRef Action As SignalAction, OldAction As Ptr) As Integer
		    #endif
		    
		    If sigaction(Signal, Action, Nil) = -1 Then
		      // Error
		      Self.Log("Unable to register to receive signal " + Str(CType(Signal, Integer), "-0"), System.LogLevelError)
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnRegisterSignal(Signal As Signals)
		  #if Not TargetWin32
		    Dim Action As SignalAction
		    
		    #if TargetLinux
		      Declare Function sigaction Lib "libc" (Sig As Signals, ByRef Action As SignalAction, OldAction As Ptr) As Integer
		    #elseif TargetMacOS
		      Declare Function sigaction Lib "System.framework" (Sig As Signals, ByRef Action As SignalAction, OldAction As Ptr) As Integer
		    #endif
		    
		    If sigaction(Signal, Action, Nil) = -1 Then
		      // Error
		      Self.Log("Unable to unregister signal " + Str(CType(Signal, Integer), "-0"), System.LogLevelError)
		    End If
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DontDaemonize() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open(Args() As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReceivedLogMessage(Message As String, Level As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SignalReceived(Signal As Signals) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UnhandledException(Err As RuntimeException) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private ShouldRun As Boolean
	#tag EndProperty


	#tag Structure, Name = SignalAction, Flags = &h21
		Handler As Ptr
		  Mask As UInt64
		  Flags As UInt32
		Restorer As Ptr
	#tag EndStructure


	#tag Enum, Name = Signals, Flags = &h0
		SIGINT = 2
		  SIGQUIT = 3
		SIGTERM = 15
	#tag EndEnum


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
