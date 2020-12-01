#tag Module
Protected Module CallLater
	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub CallNoParams()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub CallTimer_Action(Sender As CallLater.TriggerTimer)
		  If (Sender.Callback Is Nil) = False Then
		    If Beacon.SafeToInvoke(Sender.Callback) Then
		      Sender.Callback.Invoke()
		    Else
		      Sender.Callback = Nil
		    End If
		  ElseIf (Sender.CallbackWithArg Is Nil) = False Then
		    If Beacon.SafeToInvoke(Sender.CallbackWithArg) Then
		      Sender.CallbackWithArg.Invoke(Sender.Argument)
		    Else
		      Sender.CallbackWithArg = Nil
		    End If
		  End If
		  
		  If (Timers Is Nil) = False And Timers.HasKey(Sender.Key) Then
		    Timers.Remove(Sender.Key)
		  End If
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub CallWithArg(Argument As Variant)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Sub Cancel(Key As String)
		  If Timers = Nil Then
		    Timers = New Dictionary
		  End If
		  
		  If Not Timers.HasKey(Key) Then
		    Return
		  End If
		  
		  Var CallbackTimer As CallLater.TriggerTimer = Timers.Value(Key)
		  Timers.Remove(Key)
		  CallbackTimer.RunMode = Timer.RunModes.Off
		  CallbackTimer.Callback = Nil
		  CallbackTimer.CallbackWithArg = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Schedule(Delay As Integer, Callback As CallLater.CallNoParams) As String
		  Var CallTimer As New CallLater.TriggerTimer
		  #if TargetDesktop
		    AddHandler CallTimer.Action, AddressOf CallTimer_Action
		  #else
		    AddHandler CallTimer.Run, AddressOf CallTimer_Run
		  #endif
		  CallTimer.Period = Delay
		  CallTimer.RunMode = Timer.RunModes.Single
		  CallTimer.Key = Crypto.GenerateRandomBytes(20)
		  CallTimer.Callback = Callback
		  
		  If Timers = Nil Then
		    Timers = New Dictionary
		  End If
		  Timers.Value(CallTimer.Key) = CallTimer
		  
		  Return CallTimer.Key
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Schedule(Delay As Integer, Callback As CallLater.CallWithArg, Argument As Variant) As String
		  Var CallTimer As New CallLater.TriggerTimer
		  #if TargetDesktop
		    AddHandler CallTimer.Action, AddressOf CallTimer_Action
		  #else
		    AddHandler CallTimer.Run, AddressOf CallTimer_Run
		  #endif
		  CallTimer.Period = Delay
		  CallTimer.RunMode = Timer.RunModes.Single
		  CallTimer.Key = Crypto.GenerateRandomBytes(20)
		  CallTimer.CallbackWithArg = Callback
		  CallTimer.Argument = Argument
		  
		  If Timers = Nil Then
		    Timers = New Dictionary
		  End If
		  Timers.Value(CallTimer.Key) = CallTimer
		  
		  Return CallTimer.Key
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Timers As Dictionary
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
End Module
#tag EndModule
