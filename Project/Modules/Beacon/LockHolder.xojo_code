#tag Class
Protected Class LockHolder
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Lock As CriticalSection)
		  Self.mCriticalSection = Lock
		  Lock.Enter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Lock As Semaphore)
		  Self.mSemaphore = Lock
		  Lock.Signal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  If (Self.mCriticalSection Is Nil) = False Then
		    Try
		      Self.mCriticalSection.Leave
		    Catch Err As IllegalLockingException
		    End Try
		    Self.mCriticalSection = Nil
		  End If
		  
		  If (Self.mSemaphore Is Nil) = False Then
		    Try
		      Self.mSemaphore.Release
		    Catch Err As IllegalLockingException
		    End Try
		    Self.mSemaphore = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TryLock(Lock As CriticalSection) As Beacon.LockHolder
		  If Lock.TryEnter Then
		    Var Holder As New LockHolder
		    Holder.mCriticalSection = Lock
		    Return Holder
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TryLock(Lock As Semaphore) As Beacon.LockHolder
		  If Lock.TrySignal Then
		    Var Holder As New LockHolder
		    Holder.mSemaphore = Lock
		    Return Holder
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCriticalSection As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSemaphore As Semaphore
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
