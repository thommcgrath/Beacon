#tag Module
Protected Module NotificationKit
	#tag Method, Flags = &h1
		Protected Sub Ignore(Receiver As NotificationKit.Receiver, ParamArray Keys() As String)
		  If mReceivers = Nil Then
		    Return
		  End If
		  
		  For Each Key As String In Keys
		    Dim Refs() As WeakRef
		    If mReceivers.HasKey(Key) Then
		      Refs = mReceivers.Value(Key)
		    End If
		    
		    For I As Integer = Refs.LastRowIndex DownTo 0
		      If Refs(I).Value = Nil Or Refs(I).Value = Receiver Then
		        Refs.RemoveRowAt(I)
		      End If
		    Next
		    
		    If Refs.LastRowIndex > -1 Then
		      mReceivers.Value(Key) = Refs
		    ElseIf mReceivers.HasKey(Key) Then
		      mReceivers.Remove(Key)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mQueueTimer_Action(Sender As Timer)
		  If mPendingNotifications.LastRowIndex = -1 Then
		    Sender.RunMode = Timer.RunModes.Off
		    Return
		  End If
		  
		  Dim Notification As NotificationKit.Invocation = mPendingNotifications(0)
		  mPendingNotifications.RemoveRowAt(0)
		  
		  Notification.Invoke
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(Notification As NotificationKit.Notification)
		  If mReceivers = Nil Or mReceivers.HasKey(Notification.Name) = False Then
		    Return
		  End If
		  
		  Dim Refs() As WeakRef = mReceivers.Value(Notification.Name)
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		    End If
		  Next
		  
		  If Refs.LastRowIndex = -1 Then
		    mReceivers.Remove(Notification.Name)
		    Return
		  End If
		  
		  For Each Ref As WeakRef In Refs
		    Dim Receiver As NotificationKit.Receiver = NotificationKit.Receiver(Ref.Value)
		    mPendingNotifications.AddRow(New NotificationKit.Invocation(Notification, Receiver))
		  Next
		  
		  If mQueueTimer = Nil Then
		    mQueueTimer = New Timer
		    mQueueTimer.RunMode = Timer.RunModes.Multiple
		    mQueueTimer.Period = 1
		    AddHandler mQueueTimer.Action, AddressOf mQueueTimer_Action
		  End If
		  
		  If mQueueTimer.RunMode = Timer.RunModes.Off Then
		    mQueueTimer.RunMode = Timer.RunModes.Multiple
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(Notification As String, UserData As Variant)
		  NotificationKit.Post(New NotificationKit.Notification(Notification, UserData))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Watch(Receiver As NotificationKit.Receiver, ParamArray Keys() As String)
		  If mReceivers = Nil Then
		    mReceivers = New Dictionary
		  End If
		  
		  For Each Key As String In Keys
		    Dim Refs() As WeakRef
		    If mReceivers.HasKey(Key) Then
		      Refs = mReceivers.Value(Key)
		    End If
		    
		    For I As Integer = Refs.LastRowIndex DownTo 0
		      If Refs(I).Value = Nil Then
		        Refs.RemoveRowAt(I)
		      End If
		    Next
		    
		    Refs.AddRow(New WeakRef(Receiver))
		    
		    mReceivers.Value(Key) = Refs
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPendingNotifications() As NotificationKit.Invocation
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueueTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReceivers As Dictionary
	#tag EndProperty


	#tag ViewBehavior
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
End Module
#tag EndModule
