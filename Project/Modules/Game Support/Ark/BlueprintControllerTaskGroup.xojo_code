#tag Class
Protected Class BlueprintControllerTaskGroup
Inherits Ark.BlueprintControllerTask
Implements Beacon.Countable, Iterable
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function Child(Idx As Integer) As Ark.BlueprintControllerTask
		  Return Self.mChildren(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Tasks() As Ark.BlueprintControllerTask)
		  If Tasks Is Nil Or Tasks.Count = 0 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Group must contain at least one task."
		    Raise Err
		  End If
		  
		  Var Mode As Integer = Tasks(0).Mode
		  For Idx As Integer = 1 To Tasks.LastIndex
		    If Tasks(Idx).Mode <> Mode Then
		      Var Err As New UnsupportedOperationException
		      Err.Message = "All tasks in group must use the same mode."
		      Raise Err
		    End If
		  Next
		  
		  Super.Constructor(Mode)
		  Self.mChildren.ResizeTo(Tasks.LastIndex)
		  For Idx As Integer = 0 To Tasks.LastIndex
		    Self.mChildren(Idx) = Tasks(Idx)
		  Next
		  Self.mFinishedTasks = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Mode As Integer)
		  Super.Constructor(Mode)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mChildren.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorCount() As Integer
		  Var Count As Integer
		  For Idx As Integer = 0 To Self.mChildren.LastIndex
		    If Self.mChildren(Idx).Errored Then
		      Count = Count + 1
		    End If
		  Next
		  Return Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  For Idx As Integer = 0 To Self.mChildren.LastIndex
		    If Self.mChildren(Idx).Errored Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Errored(Assigns Value As Boolean)
		  // Do nothing
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorMessage() As String
		  For Idx As Integer = 0 To Self.mChildren.LastIndex
		    If Self.mChildren(Idx).Errored Then
		      Return Self.mChildren(Idx).ErrorMessage
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ErrorMessage(Assigns Value As String)
		  // Do nothing
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindTask(TaskId As String) As Ark.BlueprintControllerTask
		  For Idx As Integer = 0 To Self.mChildren.LastIndex
		    If Self.mChildren(Idx).TaskId = TaskId Then
		      Return Self.mChildren(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinishedTasks.KeyCount = Self.mChildren.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FinishTask(Task As Ark.BlueprintControllerTask)
		  If Task Is Nil Or Self.mFinishedTasks.HasKey(Task.TaskId) Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mChildren.LastIndex
		    If Self.mChildren(Idx).TaskId = Task.TaskId Then
		      Self.mFinishedTasks.Value(Task.TaskId) = Task
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  Var Items() As Variant
		  Items.ResizeTo(Self.mChildren.LastIndex)
		  For Idx As Integer = 0 To Items.LastIndex
		    Items(Idx) = Self.mChildren(Idx)
		  Next
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As Integer
		  Return Self.mChildren.LastIndex
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mChildren() As Ark.BlueprintControllerTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinishedTasks As Dictionary
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
		#tag ViewProperty
			Name="TaskId"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ErrorMessage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Errored"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
