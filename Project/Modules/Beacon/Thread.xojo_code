#tag Class
Protected Class Thread
	#tag Method, Flags = &h0
		Sub Constructor()
		  #if Self.UseClassic
		    Self.mThreadClassic = New Global.Thread
		    AddHandler Self.mThreadClassic.Run, WeakAddressOf Self.mThreadClassic_Run
		  #else
		    Self.mThread = New Xojo.Threading.Thread
		    AddHandler Self.mThread.Run, WeakAddressOf Self.mThread_Run
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function CurrentThread() As Global.Thread
		  Return App.CurrentThread
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Shared Function CurrentThread() As Xojo.Threading.Thread
		  Return Xojo.Threading.Thread.CurrentThread
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LockUserData()
		  #if Not TargetiOS
		    If Self.mUserDataLock = Nil Then
		      Self.mUserDataLock = New CriticalSection
		    End If
		    Self.mUserDataLock.Enter
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub mThreadClassic_Run(Sender As Global.Thread)
		  #Pragma Unused Sender
		  
		  Self.mShouldStop = False
		  RaiseEvent Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private Sub mThread_Run(Sender As Xojo.Threading.Thread)
		  #Pragma Unused Sender
		  
		  Self.mShouldStop = False
		  RaiseEvent Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Resume()
		  #if Self.UseClassic
		    Self.mThreadClassic.Resume
		  #else
		    Self.mThread.Resume
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run()
		  #if Self.UseClassic Then
		    Self.mThreadClassic.Run
		  #else
		    Self.mThread.Run
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sleep(Milliseconds As Integer, WakeEarly As Boolean = False)
		  #if Self.UseClassic
		    Self.mThreadClassic.Sleep(Milliseconds, WakeEarly)
		  #else
		    Self.mThread.Sleep(Milliseconds, WakeEarly)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  Self.mShouldStop = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Suspend()
		  #if Self.UseClassic Then
		    Self.mThreadClassic.Suspend
		  #else
		    Self.mThread.Suspend
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnlockUserData()
		  #if Not TargetiOS
		    If Self.mUserDataLock <> Nil Then
		      Self.mUserDataLock.Leave
		    End If
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Run()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mShouldStop As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private mThread As Xojo.Threading.Thread
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mThreadClassic As Global.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Auto
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mUserDataLock As CriticalSection
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if Self.UseClassic
			    Return Self.mThreadClassic.Priority
			  #else
			    Return Self.mThread.Priority
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #if Self.UseClassic
			    Self.mThreadClassic.Priority = Value
			  #else
			    Self.mThread.Priority = Value
			  #endif
			End Set
		#tag EndSetter
		Priority As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return Self.mShouldStop
			End Get
		#tag EndGetter
		Protected ShouldStop As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if Self.UseClassic
			    Return Self.mThreadClassic.StackSize
			  #else
			    Return Self.mThread.StackSize
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #if Self.UseClassic
			    Self.mThreadClassic.StackSize = Value
			  #else
			    Self.mThread.StackSize = Value
			  #endif
			End Set
		#tag EndSetter
		StackSize As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if Self.UseClassic
			    Select Case Self.mThreadClassic.State
			    Case Global.Thread.Running
			      Return Beacon.Thread.States.Running
			    Case Global.Thread.Waiting
			      Return Beacon.Thread.States.Waiting
			    Case Global.Thread.Suspended
			      Return Beacon.Thread.States.Suspended
			    Case Global.Thread.Sleeping
			      Return Beacon.Thread.States.Sleeping
			    Case Global.Thread.NotRunning
			      Return Beacon.Thread.States.NotRunning
			    End Select
			  #else
			    Select Case Self.mThread.State
			    Case Xojo.Threading.Thread.ThreadStates.Running
			      Return Beacon.Thread.States.Running
			    Case Xojo.Threading.Thread.ThreadStates.Waiting
			      Return Beacon.Thread.States.Waiting
			    Case Xojo.Threading.Thread.ThreadStates.Suspended
			      Return Beacon.Thread.States.Suspended
			    Case Xojo.Threading.Thread.ThreadStates.Sleeping
			      Return Beacon.Thread.States.Sleeping
			    Case Xojo.Threading.Thread.ThreadStates.NotRunning
			      Return Beacon.Thread.States.NotRunning
			    End Select
			  #endif
			End Get
		#tag EndGetter
		State As Beacon.Thread.States
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUserData
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.LockUserData()
			  Self.mUserData = Value
			  Self.UnlockUserData()
			End Set
		#tag EndSetter
		UserData As Auto
	#tag EndComputedProperty


	#tag Constant, Name = PriorityHigh, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PriorityLow, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PriorityNormal, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UseClassic, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
		#Tag Instance, Platform = iOS, Language = Default, Definition  = \"False"
	#tag EndConstant


	#tag Enum, Name = States, Type = Integer, Flags = &h0
		Running
		  Waiting
		  Suspended
		  Sleeping
		NotRunning
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="State"
			Group="Behavior"
			Type="Beacon.Thread.States"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
