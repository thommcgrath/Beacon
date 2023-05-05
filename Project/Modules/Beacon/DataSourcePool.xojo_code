#tag Class
Protected Class DataSourcePool
Implements Iterable
	#tag Method, Flags = &h0
		Sub Cleanup()
		  // Don't modify the dictionary while iterating over it.
		  // Don't allow background tasks because other threads could modify the dictionary.
		  
		  #Pragma BackgroundTasks False
		  
		  Var PurgeThreads() As Integer
		  For Each Entry As DictionaryEntry In Self.mThreads
		    Var ThreadID As Integer = Entry.Key
		    Var ThreadRef As WeakRef = Entry.Value
		    
		    If ThreadRef.Value Is Nil Then
		      PurgeThreads.Add(ThreadID)
		    End If
		  Next
		  
		  For Each ThreadID As Integer In PurgeThreads
		    If Self.mThreads.HasKey(ThreadID) Then
		      Self.mThreads.Remove(ThreadID)
		    End If
		    If Self.mInstances.HasKey(ThreadID) Then
		      Beacon.DataSource(Self.mInstances.Value(ThreadID)).Close
		      Self.mInstances.Remove(ThreadID)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CloseAll()
		  #Pragma BackgroundTasks False
		  
		  For Each Entry As DictionaryEntry In Self.mInstances
		    Var Instance As Beacon.DataSource = Entry.Value
		    Instance.Close
		  Next
		  
		  Self.mInstances = New Dictionary
		  Self.mThreads = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mInstances = New Dictionary
		  Self.mThreads = New Dictionary
		  
		  Self.mCleanupTimer = New Timer
		  Self.mCleanupTimer.RunMode = Timer.RunModes.Multiple
		  Self.mCleanupTimer.Period = 5000
		  AddHandler mCleanupTimer.Action, WeakAddressOf mCleanupTimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(Writeable As Boolean) As Beacon.DataSource
		  If Thread.Current Is Nil Then
		    If Writeable Then
		      Var Err As New UnsupportedOperationException
		      Err.Message = "Main thread cannot get writeable database."
		      Raise Err
		    End If
		    
		    Const MainThreadID = "Main"
		    If Self.mInstances.HasKey(MainThreadID) = False Then
		      Self.mInstances.Value(MainThreadID) = RaiseEvent NewInstance(False)
		    End If
		    Return Self.mInstances.Value(MainThreadID)
		  End If
		  
		  Var CurrentThread As Global.Thread = Thread.Current
		  Var CurrentThreadID As Integer = CurrentThread.ThreadID
		  
		  If Self.mInstances.HasKey(CurrentThreadID) = False Then
		    Var Instance As Beacon.DataSource = RaiseEvent NewInstance(Writeable)
		    If Instance Is Nil Then
		      Var Err As New NilObjectException
		      Err.Message = "DataSourcePool.NewInstance returned nil"
		      Raise Err
		    ElseIf Writeable = True And Instance.Writeable = False Then
		      Var Err As New UnsupportedOperationException
		      Err.Message = "DataSourcePool.NewInstance returned a read-only database when a writeable database was requested."
		      Raise Err
		    End If
		    
		    Self.mInstances.Value(CurrentThreadID) = Instance
		  End If
		  
		  If Self.mThreads.HasKey(CurrentThreadID) = False Then
		    Self.mThreads.Value(CurrentThreadID) = New WeakRef(CurrentThread)
		  End If
		  
		  Return Self.mInstances.Value(CurrentThreadID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Items() As Variant
		  For Each Entry As DictionaryEntry In Self.mInstances
		    Items.Add(Entry.Value)
		  Next
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mCleanupTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Self.Cleanup()
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event NewInstance(Writeable As Boolean) As Beacon.DataSource
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCleanupTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInstances As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThreads As Dictionary
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
