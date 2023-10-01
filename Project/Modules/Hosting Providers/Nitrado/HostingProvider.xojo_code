#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mServerDetailCache = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateCheckpoint(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Name As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  
		  Var FormData As New Dictionary
		  FormData.Value("name") = "Beacon " + Name
		  
		  Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Post("https://api.nitrado.net/services/" + ServiceID.ToString(Locale.Raw, "0") + "/gameservers/settings/sets", Token, "application/x-www-form-urlencoded", SimpleHTTP.BuildFormData(FormData))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.IntegrationEngine.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var FullPath As String = Transfer.Path + "/" + Transfer.Filename
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  
		  Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Get("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/download?file=" + EncodeURLComponent(FullPath), Token)
		  If Not Response.Success Then
		    Select Case FailureMode
		    Case Beacon.IntegrationEngine.DownloadFailureMode.MissingAllowed
		      Var Status As Integer = Response.HTTPStatus
		      If Status = 500 And Response.Message.Contains("File doesn't exist") Then
		        // Nitrado reports a 404 as a 500
		        Status = 404
		      End If
		      If Status = 404 Then
		        Transfer.Success = True
		        Transfer.Content = ""
		      Else
		        Transfer.SetError(Response.Message)
		      End If
		    Case Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed
		      Transfer.Success = True
		      Transfer.Content = ""
		    Case Beacon.IntegrationEngine.DownloadFailureMode.Required
		      Raise Response.Error
		    End Select
		    Return
		  End If
		  
		  Var SizeResponse As Nitrado.APIResponse = Nitrado.APIRequest.GET("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/size?path=" + EncodeURLComponent(FullPath), Token)
		  If Not SizeResponse.Success Then
		    If FailureMode <> Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed Then
		      Raise SizeResponse.Error
		    End If
		    Return
		  End If
		  
		  Var RequiredFileSize As Integer
		  Try
		    Var Parsed As New JSONItem(SizeResponse.Content)
		    RequiredFileSize = Parsed.Child("data").Value("size")
		  Catch Err As RuntimeException
		    Transfer.Content = ""
		    If FailureMode = Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      App.LogAPIException(Err, CurrentMethodName, SizeResponse.Url, SizeResponse.HTTPStatus, SizeResponse.Content)
		      Transfer.SetError(Err.Message)
		    End If
		    Return
		  End Try
		  If RequiredFileSize <= 0 Then
		    // Nothing to download
		    Transfer.Content = ""
		    Transfer.Success = True
		    Return
		  End If
		  
		  Var FetchUrl As String
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    If Parsed.Value("status").StringValue <> "success" Then
		      Transfer.Content = ""
		      If FailureMode = Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed Then
		        Transfer.Success = True
		      Else
		        Transfer.SetError("Error: Could not download " + Transfer.Filename + ".")
		      End If
		      Return
		    End If
		    
		    FetchUrl = Parsed.Child("data").Child("token").Value("url")
		  Catch Err As RuntimeException
		    Transfer.Content = ""
		    If FailureMode = Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      App.LogAPIException(Err, CurrentMethodName, SizeResponse.Url, SizeResponse.HTTPStatus, SizeResponse.Content)
		      Transfer.SetError(Err.Message)
		    End If
		    Return
		  End Try
		  
		  Var FetchResponse As Nitrado.APIResponse = Nitrado.APIRequest.Get(FetchUrl, Token)
		  If Not FetchResponse.Success Then
		    Transfer.Content = ""
		    If FailureMode = Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      Transfer.SetError(FetchResponse.Error.Message)
		    End If
		    Return
		  End If
		  
		  Var Content As String = FetchResponse.Content
		  Var ContentSize As Integer = Content.Bytes
		  If ContentSize = RequiredFileSize Or FailureMode = Beacon.IntegrationEngine.DownloadFailureMode.ErrorsAllowed Then
		    Transfer.Success = True
		    Transfer.Content = Content
		  Else
		    Transfer.SetError("Nitrado returned " + Beacon.BytesToString(ContentSize) + " but told Beacon to expect " + Beacon.BytesToString(RequiredFileSize) + ".")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameSetting(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting) As Variant
		  If Setting Is Nil Or Setting.HasNitradoEquivalent = False Then
		    Return Nil
		  End If
		  
		  Var Paths() As String = Setting.NitradoPaths
		  If Paths.Count = 0 Then
		    Return Nil
		  End If
		  
		  If Self.mServerDetailCache.HasKey(Profile.ProfileId) = False Then
		    Call Self.GetServerStatus(Logger, Profile)
		  End If
		  
		  // Look through each path in order until we find a match
		  Var Settings As JSONItem = Self.mServerDetailCache.Value(Profile.ProfileId)
		  For Each Path As String In Paths
		    Var Found As Boolean
		    Var Value As Variant = Self.ValueByDotNotation(Settings, Path, Found)
		    If Found Then
		      Return Value
		    End If
		  Next
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameSetting(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting, Assigns Value As Variant)
		  If Setting Is Nil Or Setting.HasNitradoEquivalent = False Then
		    Return
		  End If
		  
		  Var Paths() As String = Setting.NitradoPaths
		  If Paths.Count = 0 Then
		    Return
		  End If
		  
		  If Self.mServerDetailCache.HasKey(Profile.ProfileId) = False Then
		    Call Self.GetServerStatus(Logger, Profile)
		  End If
		  Var Settings As JSONItem = Self.mServerDetailCache.Value(Profile.ProfileId)
		  
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  For Each Path As String In Paths
		    Var Found As Boolean
		    Var OldValue As Variant = Self.ValueByDotNotation(Settings, Path, Found)
		    If Found = False Or OldValue = Value Then
		      Continue
		    End If
		    
		    Var Parts() As String = Path.Split(".")
		    Var Key As String = Parts(Parts.LastIndex)
		    Parts.RemoveAt(Parts.LastIndex)
		    Var Category As String = String.FromArray(Parts, ".")
		    
		    Var FormData As New Dictionary
		    FormData.Value("category") = Category
		    FormData.Value("key") = Key
		    FormData.Value("value") = Value
		    
		    Logger.Log("Updating " + Key + "…")
		    
		    Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Post("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/settings", Token, "application/x-www-form-urlencoded", SimpleHTTP.BuildFormData(FormData))
		    If Not Response.Success Then
		      Raise Response.Error
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  Var Response As Nitrado.APIResponse
		  Var RetriesRemaining As Integer = 5
		  Do
		    Response = Nitrado.APIRequest.Get("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers", Token)
		    If Response.Success = False Then
		      If RetriesRemaining > 0 Then
		        RetriesRemaining = RetriesRemaining - 1
		        Thread.Current.Sleep(3000)
		        Continue
		      Else
		        Raise Response.Error
		      End If
		    End If
		  Loop Until (Response Is Nil) = False And Response.Success = True
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Var Data As JSONItem = Parsed.Child("data")
		  Var GameServer As JSONItem = Data.Child("gameserver")
		  Var StatusMessage As String = GameServer.Value("status")
		  
		  // Cache the settings dict for use with game settings later
		  Self.mServerDetailCache.Value(Profile.ProfileId) = GameServer.Child("settings")
		  
		  Var Status As Beacon.ServerStatus
		  Select Case StatusMessage
		  Case "started"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.Started)
		  Case "starting", "restarting"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.Starting)
		  Case "stopping"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.Stopping)
		  Case "stopped"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.Stopped)
		  Case "suspended"
		    Status = New Beacon.ServerStatus("The server is suspended. See your Nitrado control panel to reactivate your server.")
		  Case "guardian_locked"
		    Status = New Beacon.ServerStatus("The server is currently guardian locked. Try again during allowed hours.")
		  Case "gs_installation"
		    Status = New Beacon.ServerStatus("The server is switching games.")
		  Case "backup_restore"
		    Status = New Beacon.ServerStatus("The server is restoring a backup.")
		  Case "backup_creation"
		    Status = New Beacon.ServerStatus("The server is creating a backup.")
		  Case "updating"
		    Status = New Beacon.ServerStatus(Beacon.ServerStatus.Starting, "The server is currently installing an update.")
		  Else
		    Status = New Beacon.ServerStatus("Unknown server status: " + StatusMessage)
		  End Select
		  
		  Return Status
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return "Nitrado"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Logger As Beacon.LogProducer, Token As BeaconAPI.ProviderToken, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Get("https://api.nitrado.net/services", Token)
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var Profiles() As Beacon.ServerProfile
		  
		  Var Parsed As New JSONItem(Response.Content)
		  Var Data As JSONItem = Parsed.Child("data")
		  Var Services As JSONItem = Data.Child("services")
		  If Services.Count = 0 Then
		    Return Profiles
		  End If
		  
		  Var Portlists() As String
		  If Portlists.Count = 0 Then
		    Return Profiles
		  End If
		  
		  Var Bound As Integer = Services.LastRowIndex
		  For Idx As Integer = 0 To Bound
		    Var Service As JSONItem = Services.ChildAt(Idx)
		    If Service.Lookup("type", "").StringValue <> "gameserver" Then
		      Continue
		    End If
		    
		    Var Details As JSONItem = Service.Child("details")
		    Var Portlist As String = Details.Lookup("portlist_short", "")
		    If Portlists.IndexOf(Portlist) = -1 Then
		      Continue
		    End If
		    Var Platform As Integer = Nitrado.HostingProvider.ShortcodeToPlatform(Portlist)
		    If Platform = Beacon.ServerProfile.PlatformUnsupported Then
		      Continue
		    End If
		    
		    Var ServiceId As Integer = Details.Lookup("service_id", 0)
		    If ServiceId = 0 Then
		      Continue
		    End If
		    Var Address As String = Details.Lookup("address", "")
		    Var Name As String = Details.Lookup("name", "")
		    Var Nickname As String = Services.Lookup("comment", "")
		    If (Name.IsEmpty Or Name.BeginsWith("Gameserver - ")) And Nickname.IsEmpty = False Then
		      Name = Nickname
		    End If
		    Var SecondaryName As String = Address + " (" + ServiceId.ToString(Locale.Raw, "0") + ")"
		    
		    Var ProfileId As String = Beacon.UUID.v5("Nitrado:" + ServiceId.ToString(Locale.Raw, "0"))
		    
		    Var Profile As Beacon.ServerProfile
		    Select Case GameId
		    Case Ark.Identifier
		      Profile = New Ark.ServerProfile(Self.Identifier, ProfileId, Name, Nickname, SecondaryName)
		    Case SDTD.Identifier
		      Profile = New SDTD.ServerProfile(Self.Identifier, ProfileId, Name, Nickname, SecondaryName)
		    End Select
		    Profile.ProviderServiceId = ServiceId
		    Profile.ProviderTokenId = Token.TokenId
		    Profile.Provider = Self.Identifier
		    Profile.Platform = Platform
		    Profile.Modified = False
		    
		    Profiles.Add(Profile)
		  Next
		  
		  Return Profiles
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShortcodeToGameId(Shortcode As String) As String
		  Select Case Shortcode
		  Case "arkse", "arksotf", "arkps", "arkxb", "arkswitch", "arkswitchjp", "arkseosg", "arkxbosg", "arkpsosg"
		    Return Ark.Identifier
		  Case "7daystodie", "sevendaysexperimental", "sevendtd"
		    Return SDTD.Identifier
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ShortcodeToPlatform(Shortcode As String) As Integer
		  Select Case Shortcode
		  Case "arkxb", "arkxbosg"
		    Return Beacon.ServerProfile.PlatformXbox
		  Case "arkps", "arkpsosg"
		    Return Beacon.ServerProfile.PlatformPlayStation
		  Case "arkswitch", "arkswitchjp"
		    Return Beacon.ServerProfile.PlatformSwitch
		  Case "arkse", "arksotf", "arkseosg", "7daystodie", "sevendaysexperimental", "sevendtd"
		    Return Beacon.ServerProfile.PlatformPC
		  Case "arkmobile"
		    Return Beacon.ServerProfile.PlatformUnsupported
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon"
		  FormData.Value("restart_message") = Nil
		  
		  Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Post("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/restart", Token, "application/json", Beacon.GenerateJson(FormData, True))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon"
		  FormData.Value("stop_message") = StopMessage
		  
		  Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Post("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/stop", Token, "application/json", Beacon.GenerateJson(FormData, False))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsGameSettings() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  // Part of the Beacon.HostingProvider interface.
		  
		  Var ServiceId As Integer = Profile.ProviderServiceId
		  Var Token As BeaconAPI.ProviderToken = BeaconAPI.GetProviderToken(Profile.ProviderTokenId, True)
		  
		  Var FormData As New Dictionary
		  FormData.Value("path") = Transfer.Path
		  FormData.Value("file") = Transfer.Filename
		  
		  Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Post("https://api.nitrado.net/services/" + ServiceId.ToString(Locale.Raw, "0") + "/gameservers/file_server/upload", Token, "application/x-www-form-urlencoded", SimpleHTTP.BuildFormData(FormData))
		  If Not Response.Success Then
		    Raise Response.Error
		  End If
		  
		  Var PutUrl, PutToken As String
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    Var TokenItem As JSONItem = Parsed.Child("data").Child("token")
		    PutUrl = TokenItem.Value("url")
		    PutToken = TokenItem.Value("token")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Response.Url, Response.HTTPStatus, Response.Content)
		    Transfer.Success = False
		    Transfer.ErrorMessage = Err.Message
		    Return
		  End Try
		  
		  Var Headers As New Dictionary
		  Headers.Value("token") = PutToken
		  Headers.Value("Content-MD5") = EncodeBase64(Crypto.MD5(Transfer.Content))
		  
		  Var PutResponse As Nitrado.APIResponse = Nitrado.APIRequest.Post(PutUrl, Token, Headers, "application/octet-stream", Transfer.Content)
		  If Not PutResponse.Success Then
		    Response.Error.Message = Response.Error.Message + EndOfLine + "Check your " + Transfer.Filename + " file on Nitrado. Nitrado may have accepted partial file content. If you have backups enabled, the originals will be saved to " + App.BackupsFolder.Child(Profile.BackupFolderName).NativePath + "."
		    Raise Response.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ValueByDotNotation(Root As JSONItem, Path As String, ByRef Found As Boolean) As Variant
		  Var Parts() As String = Path.Split(".")
		  Var Key As String = Parts(Parts.LastIndex)
		  Parts.RemoveAt(Parts.LastIndex)
		  
		  Var Parent As JSONItem = Root
		  For Each Part As String In Parts
		    If Parent.HasKey(Part) = False Then
		      Found = False
		      Return Nil
		    End If
		    
		    Parent = Parent.Child(Part)
		  Next
		  
		  If Parent.HasKey(Key) Then
		    Found = True
		    Return Parent.Value(Key)
		  End If
		  
		  Found = False
		  Return Nil
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mServerDetailCache As Dictionary
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
		#tag ViewProperty
			Name="mServerDetailCache"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
