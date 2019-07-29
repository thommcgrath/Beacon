#tag Module
Protected Module CallLater
	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub CallNoParams()
	#tag EndDelegateDeclaration

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
		  
		  Dim CallbackTimer As CallLater.TriggerTimer = Timers.Value(Key)
		  Timers.Remove(Key)
		  CallbackTimer.RunMode = Timer.RunModes.Off
		  CallbackTimer.Callback = Nil
		  CallbackTimer.CallbackWithArg = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Schedule(Delay As Integer, Callback As CallLater.CallNoParams) As String
		  Dim CallTimer As New CallLater.TriggerTimer
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
		  Dim CallTimer As New CallLater.TriggerTimer
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
