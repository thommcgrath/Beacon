#tag Class
Protected Class SynchronousHTTPSocket
Inherits URLConnection
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  Self.mLastContent = Content
		  Self.mLastHTTPStatus = HTTPStatus
		  Self.mLastException = Nil
		  Self.mPhase = SimpleHTTP.SynchronousHTTPSocket.Phases.Finished
		  RaiseEvent PageReceived(URL, HTTPStatus, Content)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Resume
		  End If
		  Self.mOriginThread = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(e As RuntimeException)
		  Self.mLastContent = Nil
		  Self.mLastHTTPStatus = 0
		  Self.mLastException = e
		  Self.mPhase = SimpleHTTP.SynchronousHTTPSocket.Phases.Finished
		  RaiseEvent Error(Self.mLastURL, e)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Resume
		  End If
		  Self.mOriginThread = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub FileReceived(URL As String, HTTPStatus As Integer, file As FolderItem)
		  Var Content As MemoryBlock
		  Try
		    Content = File.Read
		    File.Remove
		  Catch Err As RuntimeException
		  End Try
		  
		  Self.mLastContent = Content
		  Self.mLastHTTPStatus = HTTPStatus
		  Self.mLastException = Nil
		  Self.mPhase = SimpleHTTP.SynchronousHTTPSocket.Phases.Finished
		  RaiseEvent PageReceived(URL, HTTPStatus, Content)
		  If Self.mOriginThread <> Nil Then
		    Self.mOriginThread.Resume
		  End If
		  Self.mOriginThread = Nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReceivingProgressed(bytesReceived As Int64, totalBytes As Int64, newData As String)
		  Self.mPhase = SimpleHTTP.SynchronousHTTPSocket.Phases.Receiving
		  Self.mReceivedBytes = BytesReceived + NewData.Bytes
		  Self.mReceivingBytes = TotalBytes
		  RaiseEvent ReceivingProgressed(BytesReceived, TotalBytes, NewData)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SendingProgressed(bytesSent As Int64, bytesLeft As Int64)
		  Self.mPhase = SimpleHTTP.SynchronousHTTPSocket.Phases.Sending
		  Self.mSendingBytes = BytesLeft
		  Self.mSentBytes = BytesSent
		  RaiseEvent SendingProgressed(BytesSent, BytesLeft)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function LastContent() As MemoryBlock
		  Return Self.mLastContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastException() As RuntimeException
		  Return Self.mLastException
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastHTTPStatus() As Integer
		  Return Self.mLastHTTPStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastString() As String
		  If Self.mLastContent Is Nil Then
		    Return ""
		  Else
		    Return Self.mLastContent
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastURL() As String
		  Return Self.mLastURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Phase() As SimpleHTTP.SynchronousHTTPSocket.Phases
		  Return Self.mPhase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReceivedBytes() As Int64
		  Return Self.mReceivedBytes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReceivingBytes() As Int64
		  Return Self.mReceivingBytes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method As String, URL As String)
		  Try
		    Self.mOriginThread = Thread.Current
		    Self.RequestHeader("User-Agent") = App.UserAgent
		    Self.mLastURL = URL
		    Self.mPhase = SimpleHTTP.SynchronousHTTPSocket.Phases.Connecting
		    #if TargetWindows And XojoVersion >= 2022.01
		      Super.Send(Method, URL, FolderItem.TemporaryFile)
		    #else
		      Super.Send(Method, URL)
		    #endif
		    If Self.mOriginThread <> Nil Then
		      Self.mOriginThread.Pause
		    End If
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Invalid URL: `" + URL + "`")
		    Self.mLastContent = Nil
		    Self.mLastHTTPStatus = 0
		    Self.mLastException = Err
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendingBytes() As Int64
		  Return Self.mSendingBytes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SendSync(method As String, URL As String, file As FolderItem, timeout As Integer = 0)
		  // Don't call this method
		  #Pragma Unused Method
		  #Pragma Unused URL
		  #Pragma Unused File
		  #Pragma Unused Timeout
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendSync(method As String, URL As String, timeout As Integer = 0) As String
		  // Don't call this method
		  #Pragma Unused Method
		  #Pragma Unused URL
		  #Pragma Unused Timeout
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SentBytes() As Int64
		  Return Self.mSentBytes
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Error(URL as String, Err as RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PageReceived(URL As String, HTTPStatus As Integer, Content As MemoryBlock)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReceivingProgressed(BytesReceived As Int64, TotalBytes As Int64, NewData As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SendingProgressed(BytesSent As Int64, BytesLeft As Int64)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mLastContent As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastException As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPhase As SimpleHTTP.SynchronousHTTPSocket.Phases
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReceivedBytes As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReceivingBytes As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSendingBytes As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSentBytes As Int64
	#tag EndProperty


	#tag Enum, Name = Phases, Type = Integer, Flags = &h0
		Idle
		  Connecting
		  Sending
		  Receiving
		Finished
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowCertificateValidation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
