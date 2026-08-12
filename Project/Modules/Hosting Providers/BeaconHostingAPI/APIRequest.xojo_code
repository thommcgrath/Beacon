#tag Class
Private Class APIRequest
Inherits Beacon.IntegrationRequest
	#tag Event
		Sub Authorize(Token As BeaconAPI.ProviderToken, Headers As Dictionary)
		  Headers.Value("Authorization") = "KEY " + Token.AccessToken
		  
		  #if false
		    // Didn't feel right to throw away this code, but this level of security probably isn't necessary
		    Var RequestId As String = Beacon.UUID.v7
		    
		    Var Url As String = Self.Url
		    Var SchemePos As Integer = Url.IndexOf("://")
		    If SchemePos = -1 Then
		      Var Err As New UnsupportedFormatException
		      Err.Message = "Request URL should include a scheme"
		      Raise Err
		    End If
		    Var Path As String = Url.Middle(SchemePos + 3)
		    Var SlashPosition As Integer = Url.IndexOf("/")
		    If SlashPosition = -1 Then
		      Var Err As New UnsupportedFormatException
		      Err.Message = "Could not extract path from URL because a / character was not found."
		      Raise Err
		    End If
		    Path = Path.Middle(SlashPosition + 1)
		    
		    Var Parts() As String
		    Parts.Add(Self.RequestMethod)
		    Parts.Add(Path)
		    Parts.Add(RequestId)
		    Parts.Add(Self.Content)
		    Var Hash As String = EncodeBase64MBS(Crypto.HMAC(Token.AccessToken, String.FromArray(Parts, EndOfLine.UNIX), Crypto.HashAlgorithms.SHA2_256))
		    
		    Headers.Value("X-Beacon-Request-Id") = RequestId
		    Headers.Value("X-Beacon-Client-Id") = Token.ProviderSpecific("clientId", "")
		    Headers.Value("Authorization") = "HMAC " + Hash
		  #endif
		End Sub
	#tag EndEvent


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
