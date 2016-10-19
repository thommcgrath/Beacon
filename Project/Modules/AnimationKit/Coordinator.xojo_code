#tag Class
Protected Class Coordinator
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h0
		Sub AddTask(Task As AnimationKit.Task)
		  Self.Tasks.Append(Task)
		  RaiseEvent TaskAdded(Task)
		  
		  If Self.Animator.Mode = Xojo.Core.Timer.Modes.Off Then
		    Self.Animator.Mode = Xojo.Core.Timer.Modes.Multiple
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Animator_Action(Sender As Xojo.Core.Timer)
		  Dim AddedTasks(), RemovedTasks() As AnimationKit.Task
		  For I As Integer = UBound(Self.Tasks) DownTo 0
		    If Self.Tasks(I).Cancelled Then
		      RemovedTasks.Append(Self.Tasks(I))
		      Self.Tasks.Remove(I)
		    End If
		  Next
		  
		  Dim Now As Double = Microseconds
		  
		  For Each Task As AnimationKit.Task In Self.Tasks
		    If Task.Completed(Now) Or Now - Task.LastFrameTime >= Self.FramePeriod Then
		      Task.Perform(Now)
		    End If
		  Next
		  
		  For I As Integer = UBound(Self.Tasks) DownTo 0
		    Dim Task As AnimationKit.Task = Self.Tasks(I)
		    If Task.Completed(Now) Then
		      RemovedTasks.Append(Task)
		      Self.Tasks.Remove(I)
		      
		      If Task.NextTask <> Nil Then
		        Self.AddTask(Task.NextTask)
		        AddedTasks.Append(Task.NextTask)
		      End If
		    End If
		  Next
		  
		  If UBound(Self.Tasks) = -1 Then
		    Sender.Mode = Xojo.Core.Timer.Modes.Off
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
		  Self.Animator = New Xojo.Core.Timer
		  Self.Animator.Mode = Xojo.Core.Timer.Modes.Off
		  Self.Animator.Period = 10
		  AddHandler Self.Animator.Action, WeakAddressOf Self.Animator_Action
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
		Private Animator As Xojo.Core.Timer
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
			Group="Behavior"
			InitialValue="60"
			Type="Integer"
		#tag EndViewProperty
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
	#tag EndViewBehavior
End Class
#tag EndClass
