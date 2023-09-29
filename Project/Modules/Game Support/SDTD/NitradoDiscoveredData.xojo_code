#tag Class
Protected Class NitradoDiscoveredData
Inherits SDTD.DiscoveredData
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function AdminFilename() As String
		  Return Self.mAdminFilename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // To prevent calling without parameters
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ServiceId As Integer, AuthToken As String, ConfigPath As String, AdminFilename As String)
		  Super.Constructor()
		  
		  Self.mServiceId = ServiceId
		  Self.mAuthToken = AuthToken
		  Self.mConfigPath = ConfigPath
		  Self.mAdminFilename = AdminFilename
		  
		  While Self.mConfigPath.EndsWith("/")
		    Self.mConfigPath = Self.mConfigPath.Left(Self.mConfigPath.Length - 1)
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DownloadFile(Filename As String) As String
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = "Bearer " + Self.mAuthToken
		  Sock.RequestHeader("User-Agent") = App.UserAgent
		  
		  Var GetURL As String = "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/file_server/download?file=" + EncodeURLComponent(Self.mConfigPath + "/" + Filename)
		  Var Locked As Boolean = Preferences.SignalConnection
		  Var Content As String
		  Try
		    Sock.Send("GET", GetURL, Ark.NitradoIntegrationEngine.ConnectionTimeout)
		    Content = Sock.LastContent
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Requesting download from " + GetURL)
		  End Try
		  If Locked Then
		    Preferences.ReleaseConnection
		  End If
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  If Status <> 200 Then
		    Return ""
		  End If
		  
		  Var FetchURL As String
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Return ""
		    End If
		    
		    Var Data As Dictionary = Response.Value("data")
		    Var TokenDict As Dictionary = Data.Value("token")
		    FetchURL = TokenDict.Value("url")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, GetURL, Status, Content)
		    Return ""
		  End Try
		  
		  Var FetchSocket As New SimpleHTTP.SynchronousHTTPSocket
		  FetchSocket.RequestHeader("Authorization") = "Bearer " + Self.mAuthToken
		  FetchSocket.RequestHeader("User-Agent") = App.UserAgent
		  Locked = Preferences.SignalConnection
		  Try
		    FetchSocket.Send("GET", FetchURL, Ark.NitradoIntegrationEngine.ConnectionTimeout)
		    Content = FetchSocket.LastContent
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Downloading file from " + FetchURL)
		  End Try
		  If Locked Then
		    Preferences.ReleaseConnection
		  End If
		  Status = FetchSocket.LastHTTPStatus
		  
		  If Status <> 200 Then
		    Return ""
		  End If
		  
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File(Path As String) As String
		  If Self.mFiles.HasKey(Path) = False Then
		    Self.mFiles.Value(Path) = Self.DownloadFile(Path)
		  End If
		  Return Super.File(Path)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAdminFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceId As Integer
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
