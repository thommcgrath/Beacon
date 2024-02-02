#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub Constructor(Logger As Beacon.LogProducer = Nil)
		  If Logger Is Nil Then
		    Self.mLogger = New Beacon.DummyLogProducer
		  Else
		    Self.mLogger = Logger
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateCheckpoint(Project As Beacon.Project, Profile As Beacon.ServerProfile, Name As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var TemplateId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, TemplateId, Token)
		  
		  Var Response As GameServerApp.APIResponse = Self.RunRequest(New GameServerApp.APIRequest("GET", "https://api.gameserverapp.com/system-api/v1/config-template/" + TemplateId.ToString(Locale.Raw, "0") + "/config/" + EncodeURLComponent(Transfer.Path), Token))
		  If Not Response.Success Then
		    Transfer.Success = (FailureMode = Beacon.Integration.DownloadFailureMode.Required)
		    Transfer.Content = ""
		    Transfer.ErrorMessage = Response.Error.Message
		    Return
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Transfer.Success = True
		  Transfer.Content = Parsed.Value("content")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GameIdToSteamId(GameId As String) As Integer
		  Select Case GameId
		  Case Ark.Identifier
		    Return Ark.SteamAppId
		  Case SDTD.Identifier
		    Return SDTD.SteamAppId
		  Case ArkSA.Identifier
		    Return ArkSA.SteamServerId
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub GetCredentials(Project As Beacon.Project, Profile As Beacon.ServerProfile, ByRef TemplateId As Integer, ByRef Token As BeaconAPI.ProviderToken)
		  Var Config As Beacon.HostConfig = Profile.HostConfig
		  If Config Is Nil Or (Config IsA GameServerApp.HostConfig) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Profile must have a GameServerApp host config object"
		    Raise Err
		  End If
		  
		  TemplateId = GameServerApp.HostConfig(Config).TemplateId
		  Token = BeaconAPI.GetProviderToken(GameServerApp.HostConfig(Config).TokenId, Project, True)
		  If (Token Is Nil) = False Then
		    If Token.IsEncrypted Then
		      Var Err as New UnsupportedOperationException
		      Err.Message = "Provider token is still encrypted. Ask " + Token.UserName + " to resave."
		      Raise Err
		    End If
		  Else
		    // No such token
		    Var Err as New UnsupportedOperationException
		    Err.Message = "Authorization data for the account was not found."
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GSAID() As String
		  Static ID As String
		  If ID = "" Then
		    #if DebugBuild
		      Var Chars As String = App.ResourcesFolder.Child("GSAID.txt").Read
		    #else
		      Var Chars As String = GSAIDEncoded
		    #endif
		    ID = DefineEncoding(DecodeBase64(Chars.Middle(3, 1) + Chars.Middle(3, 1) + Chars.Middle(22, 1) + Chars.Middle(10, 1) + Chars.Middle(13, 1) + Chars.Middle(26, 1) + Chars.Middle(5, 1) + Chars.Middle(9, 1) + Chars.Middle(13, 1) + Chars.Middle(18, 1) + Chars.Middle(17, 1) + Chars.Middle(14, 1) + Chars.Middle(20, 1) + Chars.Middle(23, 1) + Chars.Middle(10, 1) + Chars.Middle(18, 1) + Chars.Middle(24, 1) + Chars.Middle(4, 1) + Chars.Middle(1, 1) + Chars.Middle(16, 1) + Chars.Middle(11, 1) + Chars.Middle(5, 1) + Chars.Middle(5, 1) + Chars.Middle(19, 1) + Chars.Middle(24, 1) + Chars.Middle(13, 1) + Chars.Middle(2, 1) + Chars.Middle(9, 1) + Chars.Middle(2, 1) + Chars.Middle(4, 1) + Chars.Middle(11, 1) + Chars.Middle(9, 1) + Chars.Middle(7, 1) + Chars.Middle(4, 1) + Chars.Middle(22, 1) + Chars.Middle(9, 1) + Chars.Middle(0, 1) + Chars.Middle(8, 1) + Chars.Middle(1, 1) + Chars.Middle(8, 1) + Chars.Middle(3, 1) + Chars.Middle(13, 1) + Chars.Middle(6, 1) + Chars.Middle(0, 1) + Chars.Middle(11, 1) + Chars.Middle(22, 1) + Chars.Middle(17, 1) + Chars.Middle(21, 1) + Chars.Middle(12, 1) + Chars.Middle(13, 1) + Chars.Middle(6, 1) + Chars.Middle(24, 1) + Chars.Middle(11, 1) + Chars.Middle(25, 1) + Chars.Middle(15, 1) + Chars.Middle(15, 1)),Encodings.UTF8)
		  End If
		  Return ID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return GameServerApp.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused StartingPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var SteamId As Integer = Self.GameIdToSteamId(GameId)
		  If SteamId = 0 Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unknown game id " + GameId + "."
		    Raise Err
		  End If
		  
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(GameServerApp.HostConfig(Config).TokenId, Nil, True)
		  Var Profiles() As Beacon.ServerProfile
		  
		  Var Response As GameServerApp.APIResponse = Self.RunRequest(New GameServerApp.APIRequest("GET", "https://api.gameserverapp.com/system-api/v1/config-template", Token))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Var Templates As JSONItem
		  If Parsed.HasKey(SteamId.ToString(Locale.Raw, "0")) Then
		    Templates = Parsed.Value(SteamId.ToString(Locale.Raw, "0"))
		  Else
		    Return Profiles
		  End If
		  
		  Var Bound As Integer = Templates.LastRowIndex
		  For Idx As Integer = 0 To Bound
		    Var Template As JSONItem = Templates.ChildAt(Idx)
		    If Template.Value("can_edit").BooleanValue = False Then
		      Continue
		    End If
		    Var TemplateId As Integer = Template.Value("id").IntegerValue
		    Var TemplateName As String = Template.Value("name").StringValue
		    
		    Var ProfileId As String = Beacon.UUID.v5(Self.Identifier + ":" + TemplateId.ToString(Locale.Raw, "0"))
		    Var ProfileConfig As New GameServerApp.HostConfig
		    ProfileConfig.TokenId = Token.TokenId
		    ProfileConfig.TokenKey = Token.EncryptionKey
		    ProfileConfig.TemplateId = TemplateId
		    
		    Var Profile As Beacon.ServerProfile
		    Select Case GameId
		    Case Ark.Identifier
		      Profile = New Ark.ServerProfile(Self.Identifier, ProfileId, TemplateName, "", TemplateId.ToString(Locale.Raw, "0"))
		      Ark.ServerProfile(Profile).Mask = Ark.Maps.All.Mask
		      Ark.ServerProfile(Profile).GameIniPath = Ark.ConfigFileGame
		      Ark.ServerProfile(Profile).GameUserSettingsIniPath = Ark.ConfigFileGameUserSettings
		    Case ArkSA.Identifier
		      Profile = New ArkSA.ServerProfile(Self.Identifier, ProfileId, TemplateName, "", TemplateId.ToString(Locale.Raw, "0"))
		      ArkSA.ServerProfile(Profile).Mask = ArkSA.Maps.All.Mask
		      ArkSA.ServerProfile(Profile).GameIniPath = ArkSA.ConfigFileGame
		      ArkSA.ServerProfile(Profile).GameUserSettingsIniPath = ArkSA.ConfigFileGameUserSettings
		    Case SDTD.Identifier
		      Profile = New SDTD.ServerProfile(Self.Identifier, ProfileId, TemplateName, "", TemplateId.ToString(Locale.Raw, "0"))
		    End Select
		    Profile.Platform = Beacon.PlatformPC
		    Profile.HostConfig = ProfileConfig
		    Profiles.Add(Profile)
		  Next
		  
		  Return Profiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logger() As Beacon.LogProducer
		  Return Self.mLogger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchesToken(Token As BeaconAPI.ProviderToken) As Boolean
		  Return (Token Is Nil) = False And Token.Provider = BeaconAPI.ProviderToken.ProviderGameServerApp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RunRequest(Request As GameServerApp.APIRequest) As GameServerApp.APIResponse
		  Var Headers As Dictionary = Request.Headers
		  Var Content As MemoryBlock = Request.Content
		  Var RequestMethod As String = Request.RequestMethod
		  Var Url As String = Request.Url
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  For Each Entry As DictionaryEntry In Headers
		    Socket.RequestHeader(Entry.Key) = Entry.Value
		  Next
		  Socket.RequestHeader("GSA-ID") = Self.GSAID()
		  
		  If (Content Is Nil) = False And Content.Size > 0 And Headers.HasKey("Content-Type") Then
		    Socket.SetRequestContent(Content, Headers.Value("Content-Type"))
		  End If
		  
		  Self.mThrottled = True
		  Var Locked As Boolean = Preferences.SignalConnection()
		  Self.mThrottled = False
		  Self.mActiveSocket = Socket
		  Socket.Send(RequestMethod, Url)
		  Self.mActiveSocket = Nil
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		  Return GameServerApp.APIResponse.FromSocket(Socket)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused StopMessage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return Self.mThrottled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var TemplateId As Integer
		  Var Token As BeaconAPI.ProviderToken
		  Self.GetCredentials(Project, Profile, TemplateId, Token)
		  
		  Var Boundary As String = Beacon.UUID.v4
		  Var ContentType As String = "multipart/form-data; charset=utf-8; boundary=" + Boundary
		  Var Parts() As String
		  Parts.Add("Content-Disposition: form-data; name=""content""" + EndOfLine.Windows + EndOfLine.Windows + Transfer.Content)
		  Var PostBody As String = "--" + Boundary + EndOfLine.Windows + Parts.Join(EndOfLine.Windows + "--" + Boundary + EndOfLine.Windows) + EndOfLine.Windows + "--" + Boundary + "--"
		  
		  Var Response As GameServerApp.APIResponse = Self.RunRequest(New GameServerApp.APIRequest("POST", "https://api.gameserverapp.com/system-api/v1/config-template/" + TemplateId.ToString(Locale.Raw, "0") + "/config/" + EncodeURLComponent(Transfer.Path), Token, ContentType, PostBody))
		  If Not Response.Success Then
		    Transfer.Success = False
		    Transfer.SetError(Response.Error.Message)
		    Return
		  End If
		  
		  Transfer.Success = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mActiveSocket As SimpleHTTP.SynchronousHTTPSocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogger As Beacon.LogProducer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThrottled As Boolean
	#tag EndProperty


	#tag Constant, Name = GSAIDEncoded, Type = String, Dynamic = False, Default = \"You didn\'t think it would be that easy did you\?", Scope = Private
	#tag EndConstant


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
