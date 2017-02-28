#tag Class
Protected Class Socket
	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Function ClassicSocket_AuthenticationRequired(Sender As Global.HTTPSecureSocket, Realm as String, Headers as InternetHeaders, ByRef Name as String, ByRef Password as String) As Boolean
		  #Pragma Unused Sender
		  #Pragma Unused Headers
		  
		  Dim TextName, TextPassword As Text
		  Dim Reply As Boolean = RaiseEvent AuthenticationRequired(Realm.ToText, TextName, TextPassword)
		  Name = TextName
		  Password = TextPassword
		  
		  Return Reply
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub ClassicSocket_Error(Sender As Global.HTTPSecureSocket, Code As Integer)
		  #Pragma Unused Sender
		  
		  Dim Err As New UnsupportedOperationException
		  Err.ErrorNumber = Code
		  
		  RaiseEvent Error(Err)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub ClassicSocket_HeadersReceived(Sender As Global.HTTPSecureSocket, Headers as InternetHeaders, HTTPStatus as Integer)
		  #Pragma Unused Sender
		  
		  Self.ResponseHeaders = Headers
		  
		  RaiseEvent HeadersReceived(Self.LastURL, HTTPStatus)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub ClassicSocket_PageReceived(Sender As Global.HTTPSecureSocket, URL as String, HTTPStatus as Integer, Headers as InternetHeaders, Content as String)
		  #Pragma Unused Sender
		  #Pragma Unused Headers
		  
		  RaiseEvent PageReceived(URL.ToText, HTTPStatus, Self.Convert(Content))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Sub ClassicSocket_ReceiveProgress(Sender As Global.HTTPSecureSocket, BytesReceived as Integer, TotalBytes as Integer, NewData as String)
		  #Pragma Unused Sender
		  
		  RaiseEvent ReceiveProgress(BytesReceived, TotalBytes, Self.Convert(NewData))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  #if TargetWin32
		    Soft Declare Sub GetVersionExA Lib "Kernel32" (Response As Ptr)
		    Soft Declare Sub GetVersionExW Lib "Kernel32" (Response As Ptr)
		    
		    Dim VersionInfo As MemoryBlock
		    
		    If System.IsFunctionAvailable("GetVersionExW", "Kernel32") Then
		      VersionInfo =  New MemoryBlock(20 + (2 * 128))
		      VersionInfo.Long(0) = VersionInfo.Size
		      GetVersionExW(VersionInfo)
		    Else
		      VersionInfo =  New MemoryBlock(148)
		      VersionInfo.Long(0) = VersionInfo.Size
		      GetVersionExA(VersionInfo)
		    End If
		    
		    Dim VersionCode As Integer = (VersionInfo.Int32Value(4) * 100) + VersionInfo.Int32Value(8)
		    Self.UseClassic = VersionCode <= 601
		  #endif
		  
		  #if Not TargetiOS
		    If Self.UseClassic Then
		      Self.ClassicSocket = New HTTPSecureSocket
		      Self.ClassicSocket.ConnectionType = SSLSocket.TLSv12
		      Self.ClassicSocket.Secure = True
		      AddHandler Self.ClassicSocket.AuthenticationRequired, WeakAddressOf Self.ClassicSocket_AuthenticationRequired
		      AddHandler Self.ClassicSocket.Error, WeakAddressOf Self.ClassicSocket_Error
		      AddHandler Self.ClassicSocket.HeadersReceived, WeakAddressOf Self.ClassicSocket_HeadersReceived
		      AddHandler Self.ClassicSocket.PageReceived, WeakAddressOf Self.ClassicSocket_PageReceived
		      AddHandler Self.ClassicSocket.ReceiveProgress, WeakAddressOf Self.ClassicSocket_ReceiveProgress
		      Return
		    End If
		  #endif
		  
		  Self.ModernSocket = New Xojo.Net.HTTPSocket
		  Self.ModernSocket.ValidateCertificates = True
		  AddHandler Self.ModernSocket.AuthenticationRequired, WeakAddressOf Self.ModernSocket_AuthenticationRequired
		  AddHandler Self.ModernSocket.Error, WeakAddressOf Self.ModernSocket_Error
		  AddHandler Self.ModernSocket.HeadersReceived, WeakAddressOf Self.ModernSocket_HeadersReceived
		  AddHandler Self.ModernSocket.PageReceived, WeakAddressOf Self.ModernSocket_PageReceived
		  AddHandler Self.ModernSocket.ReceiveProgress, WeakAddressOf Self.ModernSocket_ReceiveProgress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Shared Function Convert(Source As Global.MemoryBlock) As Xojo.Core.MemoryBlock
		  Dim Reply As New Xojo.Core.MutableMemoryBlock(Source.Size)
		  Reply.LittleEndian = Source.LittleEndian
		  For I As Integer = 0 To Source.Size - 1
		    Reply.UInt8Value(I) = Source.UInt8Value(I)
		  Next
		  Return New Xojo.Core.MemoryBlock(Reply)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Shared Function Convert(Source As Xojo.Core.MemoryBlock) As Global.MemoryBlock
		  Dim Reply As New MemoryBlock(Source.Size)
		  Reply.LittleEndian = Source.LittleEndian
		  For I As Integer = 0 To Source.Size - 1
		    Reply.UInt8Value(I) = Source.UInt8Value(I)
		  Next
		  Return Reply
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Disconnect()
		  #if Not TargetiOS
		    If Self.UseClassic Then
		      Self.ClassicSocket.Close
		      Return
		    End If
		  #endif
		  
		  Self.ModernSocket.Disconnect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ModernSocket_AuthenticationRequired(Sender As Xojo.Net.HTTPSocket, Realm As Text, ByRef Name As Text, ByRef Password As Text) As Boolean
		  #Pragma Unused Sender
		  
		  Return RaiseEvent AuthenticationRequired(Realm, Name, Password)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ModernSocket_Error(Sender As Xojo.Net.HTTPSocket, Err As RuntimeException)
		  #Pragma Unused Sender
		  
		  RaiseEvent Error(Err)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ModernSocket_HeadersReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer)
		  #Pragma Unused Sender
		  
		  RaiseEvent HeadersReceived(URL, HTTPStatus)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ModernSocket_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  
		  RaiseEvent PageReceived(URL, HTTPStatus, Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ModernSocket_ReceiveProgress(Sender As Xojo.Net.HTTPSocket, BytesReceived As Int64, TotalBytes As Int64, NewData As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  
		  RaiseEvent ReceiveProgress(BytesReceived, TotalBytes, NewData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestHeader(name As Text) As Text
		  #if Not TargetiOS Then
		    If Self.UseClassic Then
		      Dim Headers As InternetHeaders = Self.ClassicSocket.RequestHeaders
		      If Headers <> Nil Then
		        Return Headers.Value(Name).ToText
		      Else
		        Return ""
		      End If
		    End If
		  #endif
		  
		  Return Self.ModernSocket.RequestHeader(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestHeader(name As Text, Assigns value As Text)
		  #if Not TargetiOS
		    If Self.UseClassic Then
		      Self.ClassicSocket.RequestHeaders.SetHeader(Name, Value)
		      Return
		    End If
		  #endif
		  
		  Self.ModernSocket.RequestHeader(Name) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResponseHeader(name As Text) As Text
		  #if Not TargetiOS
		    If Self.UseClassic Then
		      If Self.ResponseHeaders <> Nil Then
		        Dim Header As String = Self.ResponseHeaders.Value(Name)
		        Header = DefineEncoding(Header, Encodings.UTF8)
		        Return Header.ToText
		      End If
		      Return ""
		    End If
		  #endif
		  
		  Return Self.ModernSocket.ResponseHeader(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Send(method As Text, URL As Text)
		  #if Not TargetiOS
		    Self.LastURL = URL
		    
		    If Self.UseClassic Then
		      Self.ClassicSocket.SendRequest(Method, URL)
		      Return
		    End If
		  #endif
		  
		  Self.ModernSocket.Send(Method, URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequestContent(Data As Xojo.Core.MemoryBlock, mimeType As Text)
		  #if Not TargetiOS
		    If Self.UseClassic Then
		      Self.ClassicSocket.SetRequestContent(Self.Convert(Data), MimeType)
		      Return
		    End If
		  #endif
		  
		  Self.ModernSocket.SetRequestContent(Data, MimeType)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AuthenticationRequired(realm As Text, ByRef name As Text, ByRef password As Text) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(Err As RuntimeException)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HeadersReceived(URL As Text, HTTPStatus As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PageReceived(URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReceiveProgress(BytesReceived As Int64, TotalBytes As Int64, NewData As Xojo.Core.MemoryBlock)
	#tag EndHook


	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private ClassicSocket As HTTPSecureSocket
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private LastURL As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ModernSocket As Xojo.Net.HTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private ResponseHeaders As InternetHeaders
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private UseClassic As Boolean
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
End Class
#tag EndClass
