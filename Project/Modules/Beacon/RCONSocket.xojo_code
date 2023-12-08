#tag Class
Protected Class RCONSocket
	#tag Method, Flags = &h0
		Sub Connect(Host As String, Port As Integer, Password As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mOrphanedReplies = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConnected() As Boolean
		  Return Self.mSocket.IsConnected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendSync(Message As Beacon.RCONMessage) As String
		  Var CurrentThread As Global.Thread = Global.Thread.Current
		  If CurrentThread Is Nil Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Do not execute RCON commands on the main thread"
		    Raise Err
		  End If
		  
		  Var Detector As New Beacon.RCONMessage(Beacon.RCONMessage.TypeResponseValue, "")
		  
		  Self.mSocket.Write(Message.ByteValue)
		  Self.mSocket.Write(Detector.ByteValue)
		  
		  Var GiveUpTime As Double = System.Microseconds + Self.Timeout
		  Var Response As String
		  Do
		    CurrentThread.Sleep(10)
		    
		    Var Reply As Beacon.RCONMessage = Beacon.RCONMessage.FromBuffer(Self.mSocket)
		    If (Reply Is Nil) = False Then
		      If Reply.Id = Message.Id Then
		        Response = Response + Reply.Body
		      ElseIf Reply.Id = Detector.Id Then
		        // Multi-response is finished
		        Return Response
		      End If
		      
		      Self.mOrphanedReplies.Value(Reply.Id) = Reply
		    End If
		  Loop Until System.Microseconds > GiveUpTime
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendSync(Command As String) As String
		  Var Message As New Beacon.RCONMessage(Beacon.RCONMessage.TypeExecuteCommand, Command)
		  Return Self.Execute(Message)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOrphanedReplies As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As TCPSocket
	#tag EndProperty


	#tag Constant, Name = Timeout, Type = Double, Dynamic = False, Default = \"10000000", Scope = Private
	#tag EndConstant


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
