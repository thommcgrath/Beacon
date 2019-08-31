#tag Class
Protected Class NitradoDiscoveryEngine
Implements Beacon.DiscoveryEngine
	#tag Method, Flags = &h0
		Sub Begin()
		  Self.GetServerStatus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Could not download Game.ini")
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadGameIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameIni_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As String = Content
		    Self.mGameIniContent = TextContent.Trim
		    Self.DownloadGameUserSettingsIni
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Could not download GameUserSettings.ini")
		      Return
		    End If
		    
		    Dim Data As Dictionary = Response.Value("data")
		    Dim TokenDict As Dictionary = Data.Value("token")
		    
		    Dim Headers As New Dictionary
		    Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		    
		    SimpleHTTP.Get(TokenDict.Value("url"), AddressOf Callback_DownloadGameUserSettingsIni_Content, Nil, Headers)
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_DownloadGameUserSettingsIni_Content(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Dim TextContent As String = Content
		    Self.mGameUserSettingsIniContent = TextContent.Trim
		    
		    Self.mStatus = "Finished"
		    Self.mErrored = False
		    Self.mFinished = True
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_GetServerStatus(URL As String, Status As Integer, Content As MemoryBlock, Tag As Variant)
		  #Pragma Unused URL
		  #Pragma Unused Tag
		  
		  If Self.CheckError(Status, Content) Then
		    Return
		  End If
		  
		  Try
		    Dim Response As Dictionary = Beacon.ParseJSON(Content)
		    Dim Data As Dictionary = Response.Value("data")
		    Dim GameServer As Dictionary = Data.Value("gameserver")
		    
		    Dim Settings As Dictionary = GameServer.Value("settings")
		    
		    Self.mCommandLineOptions = Settings.Value("start-param")
		    
		    Dim GameSpecific As Dictionary = GameServer.Value("game_specific")
		    Self.mProfile.ConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		    
		    Dim Config As Dictionary = Settings.Value("config")
		    Dim MapText As String = Config.Value("map")
		    Dim MapParts() As String = MapText.Split(",")
		    
		    Self.mMap = Beacon.Maps.MaskForIdentifier(MapParts(MapParts.LastRowIndex))
		    Self.mProfile.GameShortcode = GameServer.Value("game")
		    
		    Self.DownloadGameIni()
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(HTTPStatus As Integer, HTTPResponse As MemoryBlock) As Boolean
		  Select Case HTTPStatus
		  Case 401
		    Self.mStatus = "Error: Authorization failed."
		  Case 429
		    Self.mStatus = "Error: Rate limit has been exceeded."
		  Case 503
		    Self.mStatus = "Error: Nitrado is offline for maintenance."
		  Case 0
		    If HTTPResponse <> Nil And HTTPResponse.Size > 0 Then
		      Self.mStatus = "Connection error: " + HTTPResponse.StringValue(0, HTTPResponse.Size).GuessEncoding
		    Else
		      Self.mStatus = "Connection error"
		    End If
		  Else
		    Self.mErrored = False
		    Return False
		  End Select
		  
		  Self.mErrored = True
		  Self.mFinished = True
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions() As DIctionary
		  Return Self.mCommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.NitradoServerProfile, AccessToken As String)
		  Self.mProfile = Profile
		  Self.mAccessToken = AccessToken
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni()
		  Self.mStatus = "Downloading Game.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As String = Self.mProfile.ConfigPath + "/Game.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/file_server/download?file=" + EncodeURLComponent(FilePath), AddressOf Callback_DownloadGameIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameUserSettingsIni()
		  Self.mStatus = "Downloading GameUserSettings.ini…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  
		  Dim FilePath As String = Self.mProfile.ConfigPath + "/GameUserSettings.ini"
		  
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers/file_server/download?file=" + EncodeURLComponent(FilePath), AddressOf Callback_DownloadGameUserSettingsIni, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return Self.mErrored
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As String
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetServerStatus()
		  Self.mStatus = "Getting server status…"
		  
		  Dim Headers As New Dictionary
		  Headers.Value("Authorization") = "Bearer " + Self.mAccessToken
		  SimpleHTTP.Get("https://api.nitrado.net/services/" + Self.mProfile.ServiceID.ToString + "/gameservers", AddressOf Callback_GetServerStatus, Nil, Headers)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Map() As UInt64
		  Return Self.mMap
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Return Self.mProfile.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Beacon.ServerProfile
		  Return Self.mProfile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Err As RuntimeException)
		  Dim Info As Introspection.TypeInfo = Introspection.GetType(Err)
		  Dim Reason As String
		  If Err.Reason <> "" Then
		    Reason = Err.Reason
		  ElseIf Err.Message <> "" Then
		    Reason = Err.Message
		  Else
		    Reason = "No details available"
		  End If
		  
		  Self.SetError("Unhandled " + Info.FullName + ": '" + Reason + "'")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetError(Message As String)
		  Self.mStatus = "Error: " + Message
		  Self.mErrored = True
		  Self.mFinished = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  Return Self.mStatus
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccessToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCommandLineOptions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrored As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMap As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Beacon.NitradoServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatus As String
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
