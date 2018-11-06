#tag Class
Protected Class TaskQueue
	#tag Method, Flags = &h1
		Protected Sub AppendTask(ParamArray Tasks() As Beacon.TaskQueue.QueueItem)
		  Self.AppendTask(Tasks)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AppendTask(Tasks() As Beacon.TaskQueue.QueueItem)
		  For I As Integer = 0 To Tasks.Ubound
		    Self.mTasks.Append(Tasks(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ClearTasks()
		  Redim Self.mTasks(-1)
		  Self.mNextIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mNextIndex > Self.mTasks.Ubound
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertTask(Tasks() As Beacon.TaskQueue.QueueItem)
		  Dim TargetIndex As Integer = Self.mNextIndex
		  For Each Task As Beacon.TaskQueue.QueueItem In Tasks
		    If Task <> Nil Then
		      Self.mTasks.Insert(TargetIndex, Task)
		      TargetIndex = TargetIndex + 1
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InsertTask(ParamArray Tasks() As Beacon.TaskQueue.QueueItem)
		  Self.InsertTask(Tasks)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub QueueItem()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Sub RunNextTask()
		  If Self.mNextIndex > Self.mTasks.Ubound Then
		    RaiseEvent Finished
		    Return
		  End If
		  
		  Dim Task As Beacon.TaskQueue.QueueItem = Self.mTasks(Self.mNextIndex)
		  Self.mNextIndex = Self.mNextIndex + 1
		  Task.Invoke()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskCount() As Integer
		  Return Self.mTasks.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TaskProgress() As Integer
		  Return Self.mNextIndex - 1
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mNextIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTasks() As Beacon.TaskQueue.QueueItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mTasks()"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
