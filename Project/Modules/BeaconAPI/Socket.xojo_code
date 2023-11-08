#tag Class
Protected Class Socket
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mQueueThread = New Beacon.Thread
		  Self.mQueueThread.DebugIdentifier = "BeaconAPI.Socket.QueueThread"
		  AddHandler mQueueThread.Run, WeakAddressOf mQueueThread_Run
		  AddHandler mQueueThread.UserInterfaceUpdate, WeakAddressOf mQueueThread_UserInterfaceUpdate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mQueueThread_Run(Sender As Beacon.Thread)
		  Self.mWorking = True
		  Var StartUpdate As New Dictionary
		  StartUpdate.Value("Event") = "WorkStarted"
		  Sender.AddUserInterfaceUpdate(StartUpdate)
		  
		  While Self.mQueue.Count > 0
		    Var Request As BeaconAPI.Request = Self.mQueue(0)
		    Self.mQueue.RemoveAt(0)
		    
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    Var ResponseUpdate As New Dictionary
		    ResponseUpdate.Value("Event") = "RequestFinished"
		    ResponseUpdate.Value("Request") = Request
		    ResponseUpdate.Value("Response") = Response
		    Sender.AddUserInterfaceUpdate(ResponseUpdate)
		    
		    Sender.Sleep(10)
		  Wend
		  
		  Self.mWorking = False
		  Var FinishUpdate As New Dictionary
		  FinishUpdate.Value("Event") = "WorkCompleted"
		  Sender.AddUserInterfaceUpdate(FinishUpdate)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mQueueThread_UserInterfaceUpdate(Sender As Beacon.Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Each Update As Dictionary In Updates
		    Var EventName As String = Update.Value("Event")
		    Select Case EventName
		    Case "WorkStarted"
		      RaiseEvent WorkStarted
		    Case "WorkCompleted"
		      RaiseEvent WorkCompleted
		    Case "RequestFinished"
		      Var Request As BeaconAPI.Request = Update.Value("Request")
		      Var Response As BeaconAPI.Response = Update.Value("Response")
		      Request.InvokeCallback(Response)
		    End Select
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start(Request As BeaconAPI.Request)
		  Self.mQueue.Add(Request)
		  If Self.mQueue.Count > 0 And Self.mQueueThread.ThreadState = Thread.ThreadStates.NotRunning Then
		    Self.mQueueThread.Start
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Working() As Boolean
		  Return Self.mWorking
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event WorkCompleted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WorkStarted()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mQueue() As BeaconAPI.Request
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQueueThread As Beacon.Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
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
End Class
#tag EndClass
