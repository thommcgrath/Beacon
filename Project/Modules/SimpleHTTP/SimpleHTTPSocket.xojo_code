#tag Class
Private Class SimpleHTTPSocket
	#tag Method, Flags = &h0
		Sub ClearRequestHeaders()
		  #if UseNewSocket
		    Self.mSocket.ClearRequestHeaders
		  #else
		    Self.mLegacySocket.ClearRequestHeaders
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #if UseNewSocket
		    Self.mSocket = New HTTPClientSocket
		    AddHandler Self.mSocket.Error, WeakAddressOf mSocket_Error
		    AddHandler Self.mSocket.ContentReceived, WeakAddressOf mSocket_ContentReceived
		  #else
		    Self.mLegacySocket = New HTTPSecureSocket
		    Self.mLegacySocket.SSLEnabled = True
		    Self.mLegacySocket.SSLConnectionType = SSLSocket.SSLConnectionTypes.TLSv12
		    AddHandler Self.mLegacySocket.Error, WeakAddressOf mLegacySocket_Error
		    AddHandler Self.mLegacySocket.PageReceived, WeakAddressOf mLegacySocket_PageReceived
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsIdle() As Boolean
		  Return Not Self.mWorking
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mLegacySocket_Error(Sender As HTTPSecureSocket, ErrorNum As Integer)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    Dim Reason As String
		    Select Case ErrorNum
		    Case SocketCore.OpenDriverError
		      Reason = "Open driver error"
		    Case SocketCore.LostConnection
		      Reason = "Lost connection"
		    Case SocketCore.NameResolutionError
		      Reason = "Name resolution error"
		    Case SocketCore.AddressInUseError
		      Reason = "Address in use"
		    Case SocketCore.InvalidStateError
		      Reason = "Socket not ready"
		    Case SocketCore.InvalidPortError
		      Reason = "Invalid port"
		    Case SocketCore.OutOfMemoryError
		      Reason = "Out of memory"
		    Else
		      Reason = "Other error " + ErrorNum.ToString
		    End Select
		    Self.Handler.Invoke(Self.mURL, 0, Reason, Self.Tag)
		    Self.Handler = Nil
		  Else
		    Break
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mLegacySocket_PageReceived(Sender As HTTPSecureSocket, URL As String, HTTPStatus As Integer, Headers As InternetHeaders, Content As String)
		  #Pragma Unused Sender
		  #Pragma Unused Headers
		  
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(URL, HTTPStatus, Content, Self.Tag)
		    Self.Handler = Nil
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_ContentReceived(Sender As HTTPClientSocket, URL As String, HTTPStatus As Integer, Content As String)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(URL, HTTPStatus, Content, Self.Tag)
		    Self.Handler = Nil
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As HTTPClientSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(Self.mURL, 0, Err.Reason, Self.Tag)
		    Self.Handler = Nil
		  Else
		    Break
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestHeader(Key As String, Assigns Value As String)
		  #if UseNewSocket
		    Self.mSocket.RequestHeader(Key) = Value
		  #else
		    Self.mLegacySocket.SetRequestHeader(Key, Value)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method As String, URL As String)
		  Self.mWorking = True
		  Self.mURL = URL
		  #if UseNewSocket
		    Self.mSocket.Send(Method, URL)
		  #else
		    Self.mLegacySocket.SendRequest(Method, URL)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequestContent(Content As MemoryBlock, ContentType As String)
		  #if UseNewSocket
		    Self.mSocket.SetRequestContent(Content, ContentType)
		  #else
		    Self.mLegacySocket.SetRequestContent(Content, ContentType)
		  #endif
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Handler As SimpleHTTP.ResponseCallback
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLegacySocket As HTTPSecureSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSocket As HTTPClientSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Variant
	#tag EndProperty


	#tag Constant, Name = UseNewSocket, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"False"
	#tag EndConstant


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
