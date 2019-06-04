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
		    Self.mSocket = New Xojo.Net.HTTPSocket
		    AddHandler Self.mSocket.Error, WeakAddressOf mSocket_Error
		    AddHandler Self.mSocket.PageReceived, WeakAddressOf mSocket_PageReceived
		  #else
		    Self.mLegacySocket = New HTTPSecureSocket
		    Self.mLegacySocket.Secure = True
		    Self.mLegacySocket.ConnectionType = SSLSocket.TLSv12
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
		    Dim Reason As Text
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
		      Reason = "Other error " + ErrorNum.ToText
		    End Select
		    Self.Handler.Invoke(Self.mURL, 0, Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Reason, True), Self.Tag)
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
		    Self.Handler.Invoke(URL.ToText, HTTPStatus, Beacon.ConvertMemoryBlock(Content), Self.Tag)
		    Self.Handler = Nil
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(Self.mURL, 0, Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Err.Reason, True), Self.Tag)
		    Self.Handler = Nil
		  Else
		    Break
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSocket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  
		  If Self.Handler <> Nil Then
		    Self.Handler.Invoke(URL, HTTPStatus, Content, Self.Tag)
		    Self.Handler = Nil
		  End If
		  Self.ClearRequestHeaders()
		  Self.mWorking = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestHeader(Key As Text, Assigns Value As Text)
		  #if UseNewSocket
		    Self.mSocket.RequestHeader(Key) = Value
		  #else
		    Self.mLegacySocket.SetRequestHeader(Key, Value)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(Method as Text, URL as Text)
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
		Sub SetRequestContent(Content As Xojo.Core.MemoryBlock, ContentType As Text)
		  #if UseNewSocket
		    Self.mSocket.SetRequestContent(Content, ContentType)
		  #else
		    Self.mLegacySocket.SetRequestContent(Beacon.ConvertMemoryBlock(Content), ContentType)
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
		Private mSocket As Xojo.Net.HTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorking As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Tag As Auto
	#tag EndProperty


	#tag Constant, Name = UseNewSocket, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"True"
	#tag EndConstant


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
		#tag ViewProperty
			Name="ValidateCertificates"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
