#tag Module
Protected Module SimpleHTTP
	#tag Method, Flags = &h1
		Protected Sub Delete(URL As String, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Dim Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  If Headers <> Nil Then
		    Dim Keys() As Variant = Headers.Keys
		    For Each Key As Variant In Keys
		      Socket.RequestHeader(Key.StringValue) = Headers.Value(Key).StringValue
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("DELETE", URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Get(URL As String, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Dim Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  If Headers <> Nil Then
		    Dim Keys() As Variant = Headers.Keys
		    For Each Key As Variant In Keys
		      Socket.RequestHeader(Key.StringValue) = Headers.Value(Key).StringValue
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("GET", URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSocket() As SimpleHTTP.SimpleHTTPSocket
		  For I As Integer = 0 To Sockets.Ubound
		    If Sockets(I).IsIdle Then
		      Return Sockets(I)
		    End If
		  Next
		  
		  Dim Socket As New SimpleHTTP.SimpleHTTPSocket
		  Sockets.Append(Socket)
		  Return Socket
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(URL As String, Fields As Dictionary, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Dim Parts() As String
		  Dim Keys() As Variant = Fields.Keys
		  For Each Key As Variant In Keys
		    Parts.Append(Beacon.URLEncode(Key.StringValue) + "=" + Beacon.URLEncode(Fields.Value(Key).StringValue))
		  Next
		  
		  Dim Content As String = Parts.Join("&")
		  Post(URL, "application/x-www-form-urlencoded", Content, Handler, Tag, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(URL As String, ContentType As String, Content As String, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Dim Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  Socket.SetRequestContent(Content, ContentType)
		  If Headers <> Nil Then
		    Dim Keys() As Variant = Headers.Keys
		    For Each Key As Variant In Keys
		      Socket.RequestHeader(Key.StringValue) = Headers.Value(Key).StringValue
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("POST", URL)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub ResponseCallback(URL As String, Status As Integer, Content As String, Tag As Variant)
	#tag EndDelegateDeclaration


	#tag Property, Flags = &h21
		Private Sockets() As SimpleHTTP.SimpleHTTPSocket
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
