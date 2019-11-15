#tag Class
Protected Class Coordinator
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h0
		Sub AddTask(Task As AnimationKit.Task)
		  Self.Tasks.AddRow(Task)
		  RaiseEvent TaskAdded(Task)
		  
		  If Self.Animator.RunMode = Timer.RunModes.Off Then
		    Self.Animator.RunMode = Timer.RunModes.Multiple
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Animator_Run(Sender As Timer)
		  Dim AddedTasks(), RemovedTasks() As AnimationKit.Task
		  For I As Integer = Self.Tasks.LastRowIndex DownTo 0
		    If Self.Tasks(I).Cancelled Then
		      RemovedTasks.AddRow(Self.Tasks(I))
		      Self.Tasks.RemoveRowAt(I)
		    End If
		  Next
		  
		  Dim Now As Double = System.Microseconds
		  
		  For Each Task As AnimationKit.Task In Self.Tasks
		    If Task.Completed(Now) Or Now - Task.LastFrameTime >= Self.FramePeriod Then
		      Task.Perform(Now)
		    End If
		  Next
		  
		  For I As Integer = Self.Tasks.LastRowIndex DownTo 0
		    Dim Task As AnimationKit.Task = Self.Tasks(I)
		    If Task.Completed(Now) Then
		      RemovedTasks.AddRow(Task)
		      Self.Tasks.RemoveRowAt(I)
		      
		      If Task.NextTask <> Nil Then
		        Self.AddTask(Task.NextTask)
		        AddedTasks.AddRow(Task.NextTask)
		      End If
		    End If
		  Next
		  
		  If Self.Tasks.LastRowIndex = -1 Then
		    Sender.RunMode = Timer.RunModes.Off
		  End If
		  
		  For Each Task As AnimationKit.Task In RemovedTasks
		    RaiseEvent TaskRemoved(Task)
		  Next
		  For Each Task As AnimationKit.Task In AddedTasks
		    RaiseEvent TaskAdded(Task)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Animator = New Timer
		  Self.Animator.RunMode = Timer.RunModes.Off
		  Self.Animator.Period = 10
		  AddHandler Self.Animator.Action, WeakAddressOf Self.Animator_Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FramePeriod() As Double
		  return 1000000 / Self.FramesPerSecond
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event TaskAdded(Task As AnimationKit.Task)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TaskRemoved(Task As AnimationKit.Task)
	#tag EndHook


	#tag Property, Flags = &h21
		Private Animator As Timer
	#tag EndProperty

	#tag Property, Flags = &h0
		FramesPerSecond As Integer = 60
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Tasks() As AnimationKit.Task
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="FramesPerSecond"
			Visible=false
			Group="Behavior"
			InitialValue="60"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
