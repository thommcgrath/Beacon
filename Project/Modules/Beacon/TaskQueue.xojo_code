#tag Class
Protected Class TaskQueue
	#tag Method, Flags = &h1
		Protected Sub AppendTask(ParamArray Tasks() As Beacon.TaskQueue.QueueItem)
		  Self.AppendTask(Tasks, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AppendTask(Tasks() As Beacon.TaskQueue.QueueItem, Threaded As Boolean)
		  For I As Integer = 0 To Tasks.LastRowIndex
		    Self.mTasks.AddRow(Tasks(I))
		    Self.mThreaded.AddRow(Threaded)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AppendThreadedTask(ParamArray Tasks() As Beacon.TaskQueue.QueueItem)
		  Self.AppendTask(Tasks, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClearTasks()
		  Self.mTasks.ResizeTo(-1)
		  Self.mThreaded.ResizeTo(-1)
		  Self.mNextIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mNextIndex > Self.mTasks.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FireWaitEvent(Param As Variant)
		  Var Controller As Beacon.TaskWaitController
		  If Param IsA Beacon.TaskWaitController Then
		    Controller = Beacon.TaskWaitController(Param)
		  Else
		    Return
		  End If
		  
		  If IsEventImplemented("Wait") Then
		    RaiseEvent Wait(Controller)
		  Else
		    Controller.Cancelled = False
		    Controller.ShouldResume = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertTask(ParamArray Tasks() As Beacon.TaskQueue.QueueItem)
		  Self.InsertTask(Tasks, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertTask(Tasks() As Beacon.TaskQueue.QueueItem, Threaded As Boolean)
		  Var TargetIndex As Integer = Self.mNextIndex
		  For Each Task As Beacon.TaskQueue.QueueItem In Tasks
		    If Task <> Nil Then
		      Self.mTasks.AddRowAt(TargetIndex, Task)
		      Self.mThreaded.AddRowAt(TargetIndex, Threaded)
		      TargetIndex = TargetIndex + 1
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertThreadedTask(ParamArray Tasks() As Beacon.TaskQueue.QueueItem)
		  Self.InsertTask(Tasks, True)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub QueueItem()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Sub RunNextTask()
		  If Self.mNextIndex > Self.mTasks.LastRowIndex Then
		    RaiseEvent Finished
		    Return
		  End If
		  
		  Var Task As Beacon.TaskQueue.QueueItem = Self.mTasks(Self.mNextIndex)
		  Var Threaded As Boolean = Self.mThreaded(Self.mNextIndex)
		  Self.mNextIndex = Self.mNextIndex + 1
		  If Threaded Then
		    Var RunThread As New Beacon.Thread
		    RunThread.UserData = Task
		    AddHandler RunThread.Run, WeakAddressOf RunThread_Run
		    RunThread.Start
		  Else
		    If App.CurrentThread = Nil Then
		      Task.Invoke()
		    Else
		      Call CallLater.Schedule(1, AddressOf RunTask, Task)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunTask(Task As Variant)
		  If Task IsA Beacon.TaskQueue.QueueItem Then
		    Beacon.TaskQueue.QueueItem(Task).Invoke
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunThread_Run(Sender As Beacon.Thread)
		  If Sender.UserData IsA Beacon.TaskQueue.QueueItem Then
		    Beacon.TaskQueue.QueueItem(Sender.UserData).Invoke
		  End If
		  Sender.UserData = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskCount() As Integer
		  Return Self.mTasks.LastRowIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskProgress() As Integer
		  Return Self.mNextIndex - 1
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
		  
		  Call CallLater.Schedule(1, AddressOf FireWaitEvent, Controller)
		  
		  While Not Controller.ShouldResume
		    App.SleepCurrentThread(20)
		  Wend
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
		  
		  Var Limit As Double = Milliseconds * 1000
		  Var StartTime As Double = System.Microseconds
		  While System.Microseconds - StartTime < Limit
		    App.SleepCurrentThread(20)
		  Wend
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Wait(Controller As Beacon.TaskWaitController)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mNextIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTasks() As Beacon.TaskQueue.QueueItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreaded() As Boolean
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
End Class
#tag EndClass
