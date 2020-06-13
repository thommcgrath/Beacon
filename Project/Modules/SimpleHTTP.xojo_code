#tag Module
Protected Module SimpleHTTP
	#tag Method, Flags = &h1
		Protected Function BuildFormData(Fields As Dictionary) As String
		  If Fields = Nil Then
		    Fields = New Dictionary
		  End If
		  
		  Var Parts() As String
		  Var Keys() As Variant = Fields.Keys
		  For Each Key As Variant In Keys
		    Var Value As Variant = Fields.Value(Key)
		    
		    Parts.AddRow(EncodeURLComponent(Key) + "=" + EncodeURLComponent(Value))
		  Next
		  
		  Return Parts.Join("&")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Delete(URL As String, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Var Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  If Headers <> Nil Then
		    For Each Entry As DictionaryEntry In Headers
		      Socket.RequestHeader(Entry.Key) = Entry.Value
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("DELETE", URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Get(URL As String, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Var Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  If Headers <> Nil Then
		    For Each Entry As DictionaryEntry In Headers
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
		  For I As Integer = 0 To Sockets.LastRowIndex
		    If Sockets(I).IsIdle Then
		      Return Sockets(I)
		    End If
		  Next
		  
		  Var Socket As New SimpleHTTP.SimpleHTTPSocket
		  Sockets.AddRow(Socket)
		  Return Socket
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(URL As String, Fields As Dictionary, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Post(URL, "application/x-www-form-urlencoded", BuildFormData(Fields), Handler, Tag, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Post(URL As String, ContentType As String, Content As MemoryBlock, Handler As SimpleHTTP.ResponseCallback, Tag As Variant, Headers As Dictionary = Nil)
		  Var Socket As SimpleHTTP.SimpleHTTPSocket = GetSocket()
		  Socket.SetRequestContent(Content, ContentType)
		  If Headers <> Nil Then
		    For Each Entry As DictionaryEntry In Headers
		      Socket.RequestHeader(Entry.Key) = Entry.Value
		    Next
		  End If
		  Socket.Handler = Handler
		  Socket.Tag = Tag
		  Socket.Send("POST", URL)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub ResponseCallback(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub SetFormData(Extends Socket As URLConnection, Fields As Dictionary)
		  Socket.SetRequestContent(BuildFormData(Fields), "application/x-www-form-urlencoded")
		End Sub
	#tag EndMethod


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
