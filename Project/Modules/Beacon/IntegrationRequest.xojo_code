#tag Class
Protected Class IntegrationRequest
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
		  
		  Headers.Value("Cache-Control") = "no-cache"
		  Headers.Value("User-Agent") = App.UserAgent
		  Headers.Value("Want-Repr-Digest") = "sha-512=10,sha-256=9,md5=0,sha=0,unixsum=0,unixcksum=0,adler=0,crc32c=0"
		  If ContentType.IsEmpty = False And (Content Is Nil) = False Then
		    Headers.Value("Content-Type") = ContentType
		  End If
		  If (Token Is Nil) = False Then
		    Var AuthValue As String = RaiseEvent GetAuthHeader(Token)
		    If AuthValue.IsEmpty = False Then
		      Headers.Value("Authorization") = AuthValue
		    End If
		  End If
		  
		  Self.mContent = Content
		  Self.mHeaders = Headers
		  Self.mMethod = RequestMethod
		  Self.mUrl = Url
		  
		  If (Content Is Nil) = False And Content.Size > 0 And Headers.HasKey("Repr-Digest") = False Then
		    Var Hashes() As String
		    Hashes.Add("sha-512=:" + EncodeBase64MBS(Crypto.SHA2_512(Content)) + ":")
		    Hashes.Add("sha-256=:" + EncodeBase64MBS(Crypto.SHA2_256(Content)) + ":")
		    Headers.Value("Repr-Digest") = String.FromArray(Hashes, ",")
		  End If
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
		Function Headers() As Dictionary
		  Return Self.mHeaders.Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestMethod() As String
		  Return Self.mMethod
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Url() As String
		  Return Self.mUrl
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetAuthHeader(Token As BeaconAPI.ProviderToken) As String
	#tag EndHook


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


End Class
#tag EndClass
