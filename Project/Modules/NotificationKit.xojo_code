#tag Module
Protected Module NotificationKit
	#tag Method, Flags = &h1
		Protected Sub Ignore(Receiver As NotificationKit.Receiver, ParamArray Keys() As Text)
		  If mReceivers = Nil Then
		    Return
		  End If
		  
		  For Each Key As Text In Keys
		    Dim Refs() As Xojo.Core.WeakRef
		    If mReceivers.HasKey(Key) Then
		      Refs = mReceivers.Value(Key)
		    End If
		    
		    For I As Integer = UBound(Refs) DownTo 0
		      If Refs(I).Value = Nil Or Refs(I).Value = Receiver Then
		        Refs.Remove(I)
		      End If
		    Next
		    
		    If UBound(Refs) > -1 Then
		      mReceivers.Value(Key) = Refs
		    ElseIf mReceivers.HasKey(Key) Then
		      mReceivers.Remove(Key)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mQueueTimer_Action(Sender As Xojo.Core.Timer)
		  If UBound(mPendingNotifications) = -1 Then
		    Sender.Mode = Xojo.Core.Timer.Modes.Off
		    Return
		  End If
		  
		  Dim Notification As NotificationKit.Invocation = mPendingNotifications(0)
		  mPendingNotifications.Remove(0)
		  
		  Notification.Invoke
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(Notification As NotificationKit.Notification)
		  If mReceivers = Nil Or mReceivers.HasKey(Notification.Name) = False Then
		    Return
		  End If
		  
		  Dim Refs() As Xojo.Core.WeakRef = mReceivers.Value(Notification.Name)
		  For I As Integer = UBound(Refs) DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.Remove(I)
		    End If
		  Next
		  
		  If UBound(Refs) = -1 Then
		    mReceivers.Remove(Notification.Name)
		    Return
		  End If
		  
		  For Each Ref As Xojo.Core.WeakRef In Refs
		    Dim Receiver As NotificationKit.Receiver = NotificationKit.Receiver(Ref.Value)
		    mPendingNotifications.Append(New NotificationKit.Invocation(Notification, Receiver))
		  Next
		  
		  If mQueueTimer = Nil Then
		    mQueueTimer = New Xojo.Core.Timer
		    mQueueTimer.Mode = Xojo.Core.Timer.Modes.Multiple
		    mQueueTimer.Period = 1
		    AddHandler mQueueTimer.Action, AddressOf mQueueTimer_Action
		  End If
		  
		  If mQueueTimer.Mode = Xojo.Core.Timer.Modes.Off Then
		    mQueueTimer.Mode = Xojo.Core.Timer.Modes.Multiple
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(Notification As Text, UserData As Auto)
		  NotificationKit.Post(New NotificationKit.Notification(Notification, UserData))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Watch(Receiver As NotificationKit.Receiver, ParamArray Keys() As Text)
		  If mReceivers = Nil Then
		    mReceivers = New Xojo.Core.Dictionary
		  End If
		  
		  For Each Key As Text In Keys
		    Dim Refs() As Xojo.Core.WeakRef
		    If mReceivers.HasKey(Key) Then
		      Refs = mReceivers.Value(Key)
		    End If
		    
		    For I As Integer = UBound(Refs) DownTo 0
		      If Refs(I).Value = Nil Then
		        Refs.Remove(I)
		      End If
		    Next
		    
		    Refs.Append(Xojo.Core.WeakRef.Create(Receiver))
		    
		    mReceivers.Value(Key) = Refs
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPendingNotifications() As NotificationKit.Invocation
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueueTimer As Xojo.Core.Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReceivers As Xojo.Core.Dictionary
	#tag EndProperty


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
End Module
#tag EndModule
