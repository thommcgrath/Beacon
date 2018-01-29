#tag Module
Protected Module SimpleHTTP
	#tag Method, Flags = &h1
		Protected Sub Delete(URL As Text, Handler As SimpleHTTP.ResponseCallback, Tag As Auto, Headers As Xojo.Core.Dictionary = Nil)
		  Dim Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  If Headers <> Nil Then
		    For Each Entry As Xojo.Core.DictionaryEntry In Headers
		      Socket.RequestHeader(Entry.Key) = Entry.Value
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("DELETE", URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Get(URL As Text, Handler As SimpleHTTP.ResponseCallback, Tag As Auto, Headers As Xojo.Core.Dictionary = Nil)
		  Dim Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  If Headers <> Nil Then
		    For Each Entry As Xojo.Core.DictionaryEntry In Headers
		      Socket.RequestHeader(Entry.Key) = Entry.Value
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
		Protected Sub Post(URL As Text, ContentType As Text, Content As Xojo.Core.MemoryBlock, Handler As SimpleHTTP.ResponseCallback, Tag As Auto, Headers As Xojo.Core.Dictionary = Nil)
		  Dim Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  Socket.SetRequestContent(Content, ContentType)
		  If Headers <> Nil Then
		    For Each Entry As Xojo.Core.DictionaryEntry In Headers
		      Socket.RequestHeader(Entry.Key) = Entry.Value
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("POST", URL)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub ResponseCallback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
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
