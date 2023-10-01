#tag Class
Private Class APIRequest
	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String)
		  Self.Constructor(RequestMethod, Url, Nil, Nil, "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String, Token As BeaconAPI.ProviderToken)
		  Self.Constructor(RequestMethod, Url, Token, Nil, "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String, Token As BeaconAPI.ProviderToken, Headers As Dictionary)
		  Self.Constructor(RequestMethod, Url, Token, Headers, "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String, Token As BeaconAPI.ProviderToken, Headers As Dictionary, ContentType As String, Content As MemoryBlock)
		  If Headers Is Nil Then
		    Headers = New Dictionary
		  Else
		    Headers = Headers.Clone
		  End If
		  
		  Headers.Value("Connection") = "close"
		  Headers.Value("Cache-Control") = "no-cache"
		  Headers.Value("User-Agent") = App.UserAgent
		  If ContentType.IsEmpty = False And (Content Is Nil) = False Then
		    Headers.Value("Content-Type") = ContentType
		  End If
		  If (Token Is Nil) = False Then
		    Headers.Value("Authorization") = Token.AuthHeaderValue
		  End If
		  
		  Self.mContent = Content
		  Self.mHeaders = Headers
		  Self.mMethod = RequestMethod
		  Self.mUrl = Url
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String, Token As BeaconAPI.ProviderToken, ContentType As String, Content As MemoryBlock)
		  Self.Constructor(RequestMethod, Url, Token, Nil, ContentType, Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String, Headers As Dictionary)
		  Self.Constructor(RequestMethod, Url, Nil, Headers, "", Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(RequestMethod As String, Url As String, Headers As Dictionary, ContentType As String, Content As MemoryBlock)
		  Self.Constructor(RequestMethod, Url, Nil, Headers, ContentType, Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Content() As MemoryBlock
		  Return Self.mContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Delete(Url As String) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("DELETE", Url)
		  Return Request.Run
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Delete(Url As String, Token As BeaconAPI.ProviderToken) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("DELETE", Url, Token)
		  Return Request.Run
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Get(Url As String) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("GET", Url)
		  Return Request.Run
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Get(Url As String, Token As BeaconAPI.ProviderToken) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("GET", Url, Token)
		  Return Request.Run
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Get(Url As String, Token As BeaconAPI.ProviderToken, Headers As Dictionary) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("GET", Url, Token, Headers)
		  Return Request.Run
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Get(Url As String, Headers As Dictionary) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("GET", Url, Headers)
		  Return Request.Run
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Headers() As Dictionary
		  Return Self.mHeaders.Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Post(Url As String, Token As BeaconAPI.ProviderToken, Headers As Dictionary, ContentType As String, Content As MemoryBlock) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("POST", Url, Token, Headers, ContentType, Content)
		  Return Request.Run()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Post(Url As String, Token As BeaconAPI.ProviderToken, ContentType As String, Content As MemoryBlock) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("POST", Url, Token, Nil, ContentType, Content)
		  Return Request.Run()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Put(Url As String, Token As BeaconAPI.ProviderToken, Headers As Dictionary, ContentType As String, Content As MemoryBlock) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("PUT", Url, Token, Headers, ContentType, Content)
		  Return Request.Run()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Put(Url As String, Token As BeaconAPI.ProviderToken, ContentType As String, Content As MemoryBlock) As Nitrado.APIResponse
		  Var Request As New Nitrado.APIRequest("PUT", Url, Token, Nil, ContentType, Content)
		  Return Request.Run()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestMethod() As String
		  Return Self.mMethod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Run() As Nitrado.APIResponse
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  For Each Entry As DictionaryEntry In Self.mHeaders
		    Socket.RequestHeader(Entry.Key) = Entry.Value
		  Next
		  
		  If (Self.mContent Is Nil) = False And Self.mContent.Size > 0 And Self.mHeaders.HasKey("Content-Type") Then
		    Socket.SetRequestContent(Content, Self.mHeaders.Value("Content-Type"))
		  End If
		  
		  Var Locked As Boolean = Preferences.SignalConnection()
		  Socket.Send(Self.mMethod, Self.mUrl)
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		  Return Nitrado.APIResponse.FromSocket(Socket)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Url() As String
		  Return Self.mUrl
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContent As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeaders As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMethod As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUrl As String
	#tag EndProperty


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
