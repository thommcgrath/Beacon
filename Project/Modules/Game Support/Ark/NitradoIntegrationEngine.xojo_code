#tag Class
Protected Class NitradoIntegrationEngine
Inherits Ark.IntegrationEngine
	#tag Event
		Function ApplySettings(Organizer As Ark.ConfigOrganizer) As Boolean
		  Var Keys() As Ark.ConfigKey = Organizer.DistinctKeys
		  Var NewValues As New Dictionary
		  Var KeysForPath As New Dictionary
		  Var ExtraGameIniOrganizer As New Ark.ConfigOrganizer
		  
		  // First we need to determine if guided mode *can* be supported.
		  // Nitrado values are limited to 65,535 characters and not all GameUserSettings.ini
		  // configs are supported in guided mode.
		  
		  For Each ConfigKey As Ark.ConfigKey In Keys
		    If Self.mDoGuidedDeploy And ConfigKey.File = Ark.ConfigFileGameUserSettings And ConfigKey.HasNitradoEquivalent = False Then
		      // Expert mode required because this config cannot be supported.
		      App.Log("Cannot use guided deploy because the key " + ConfigKey.SimplifiedKey + " needs to be in GameUserSettings.ini but Nitrado does not have a config for it.")
		      Self.SwitchToExpertMode(ConfigKey.Key, 0)
		      Return False
		    End If
		    
		    If ConfigKey.HasNitradoEquivalent = False Then
		      If Self.mDoGuidedDeploy And ConfigKey.File = Ark.ConfigFileGame Then
		        ExtraGameIniOrganizer.Add(Organizer.FilteredValues(ConfigKey))
		      End If
		      Continue
		    End If
		    
		    Var SendToNitrado As Boolean = ConfigKey.NitradoDeployStyle = Ark.ConfigKey.NitradoDeployStyles.Both Or ConfigKey.NitradoDeployStyle = If(Self.mDoGuidedDeploy, Ark.ConfigKey.NitradoDeployStyles.Guided, Ark.ConfigKey.NitradoDeployStyles.Expert)
		    If SendToNitrado = False Then
		      Continue
		    End If
		    
		    Var NitradoPaths() As String = ConfigKey.NitradoPaths
		    Var Values() As Ark.ConfigValue = Organizer.FilteredValues(ConfigKey)
		    For Each NitradoPath As String In NitradoPaths
		      KeysForPath.Value(NitradoPath) = ConfigKey
		      
		      Select Case ConfigKey.NitradoFormat
		      Case Ark.ConfigKey.NitradoFormats.Line
		        Var Lines() As String
		        If NewValues.HasKey(NitradoPath) Then
		          Lines = NewValues.Value(NitradoPath)
		        End If
		        For Each Value As Ark.ConfigValue In Values
		          Lines.Add(Value.Command)
		        Next
		        NewValues.Value(NitradoPath) = Lines
		      Case Ark.ConfigKey.NitradoFormats.Value
		        If Values.Count >= 1 Then
		          Var Value As String = Values(Values.LastIndex).Value
		          
		          If ConfigKey.ValueType = Ark.ConfigKey.ValueTypes.TypeBoolean Then
		            Value = Value.Lowercase
		            
		            Var Reversed As NullableBoolean = NullableBoolean.FromVariant(ConfigKey.Constraint("nitrado.boolean.reversed"))
		            If (Reversed Is Nil) = False And Reversed.BooleanValue Then
		              Value = If(Value = "true", "false", "true")
		            End If
		          End If
		          
		          NewValues.Value(NitradoPath) = Value
		        Else
		          // This doesn't make sense
		          Break
		        End If
		      End Select
		    Next
		  Next
		  
		  Var Changes As New Dictionary
		  For Each Entry As DictionaryEntry In NewValues
		    Var NitradoPath As String = Entry.Key
		    Var ConfigKey As Ark.ConfigKey = KeysForPath.Value(NitradoPath)
		    Var CurrentValue As String = Self.GetViaDotNotation(Self.mCurrentSettings, NitradoPath)
		    Var FinishedValue As String
		    If Entry.Value.Type = Variant.TypeString Then
		      // Value comparison
		      If ConfigKey.ValuesEqual(Entry.Value.StringValue, CurrentValue) Then
		        Continue
		      End If
		      FinishedValue = Entry.Value.StringValue
		    ElseIf Entry.Value.IsArray And Entry.Value.ArrayElementType = Variant.TypeString Then
		      // Line comparison, but if there is only one line, go back to value comparison
		      Var NewLines() As String = Entry.Value
		      FinishedValue = NewLines.Join(EndOfLine) // Prepare the finished value before sorting, even if we nay not use it
		      
		      Var CurrentLines() As String = CurrentValue.ReplaceLineEndings(EndOfLine.UNIX).Split(EndOfLine.UNIX)
		      
		      If NewLines.Count = 1 And CurrentLines.Count = 1 And (ConfigKey.ValueType = Ark.ConfigKey.ValueTypes.TypeNumeric Or ConfigKey.ValueType = Ark.ConfigKey.ValueTypes.TypeBoolean Or ConfigKey.ValueType = Ark.ConfigKey.ValueTypes.TypeBoolean) Then
		        Var NewValue As String = NewLines(0).Middle(NewLines(0).IndexOf("=") + 1)
		        CurrentValue = CurrentLines(0).Middle(CurrentLines(0).IndexOf("=") + 1)
		        If ConfigKey.ValuesEqual(NewValue, CurrentValue) Then
		          Continue
		        End If
		        FinishedValue = NewLines(0)
		      Else
		        NewLines.Sort
		        CurrentLines.Sort
		        Var NewHash As String = EncodeHex(Crypto.SHA1(NewLines.Join(EndOfLine.UNIX).Lowercase))
		        Var CurrentHash As String = EncodeHex(Crypto.SHA1(CurrentLines.Join(EndOfLine.UNIX).Lowercase))
		        If NewHash = CurrentHash Then
		          // No change
		          Continue
		        End If
		      End If
		    Else
		      Continue
		    End If
		    
		    If Self.mDoGuidedDeploy And FinishedValue.Length > 65535 Then
		      App.Log("Cannot use guided deploy because the key " + ConfigKey.SimplifiedKey + " needs " + FinishedValue.Length.ToString(Locale.Current, "#,##0") + " characters, and Nitrado has a limit of 65,535 characters.")
		      Self.SwitchToExpertMode(ConfigKey.Key, FinishedValue.Length)
		      Return False
		    End If
		    
		    Changes.Value(NitradoPath) = FinishedValue
		  Next
		  
		  If Self.mDoGuidedDeploy Then
		    // Generate a new user-settings.ini file
		    Var ExtraGameIniSuccess As Boolean
		    Var ExtraGameIni As String = Self.GetFile(Self.mGamePath + "user-settings.ini", DownloadFailureMode.MissingAllowed, False, ExtraGameIniSuccess)
		    If ExtraGameIniSuccess = False Or Self.Finished Then
		      Self.Finished = True
		      Return False
		    End If
		    If ExtraGameIni.BeginsWith("[" + Ark.HeaderShooterGame + "]") = False Then
		      ExtraGameIni = "[" + Ark.HeaderShooterGame + "]" + EndOfLine.UNIX + ExtraGameIni
		    End If
		    Var RewriteError As RuntimeException
		    Var ExtraGameIniRewritten As String = Ark.Rewriter.Rewrite(Ark.Rewriter.Sources.Deploy, ExtraGameIni, Ark.HeaderShooterGame, Ark.ConfigFileGame, ExtraGameIniOrganizer, Self.Project.UUID, Self.Project.LegacyTrustKey, If(Self.Project.AllowUCS2, Ark.Rewriter.EncodingFormat.UCS2AndASCII, Ark.Rewriter.EncodingFormat.ASCII), Ark.Project.UWPCompatibilityModes.Never, Self.NukeEnabled, RewriteError)
		    If (RewriteError Is Nil) = False Then
		      Self.SetError(RewriteError)
		      Return False
		    End If
		    
		    // Need to remove the header that the rewriter adds
		    ExtraGameIniRewritten = ExtraGameIniRewritten.Replace("[" + Ark.HeaderShooterGame + "]", "").Trim
		    
		    // Create a checkpoint before making changes
		    If Self.BackupEnabled Then
		      Var OldFiles As New Dictionary
		      OldFiles.Value("Config.json") = Beacon.GenerateJSON(Self.mCurrentSettings, True)
		      OldFiles.Value("user-settings.ini") = ExtraGameIni
		      
		      Var NewSettings As Dictionary = Self.mCurrentSettings.Clone
		      For Each Entry As DictionaryEntry In Changes
		        Var NitradoPath As String = Entry.Key
		        Var NewValue As String = Entry.Value
		        
		        Var CategoryLength As Integer = NitradoPath.IndexOf(".")
		        Var Category As String = NitradoPath.Left(CategoryLength)
		        Var Key As String = NitradoPath.Middle(CategoryLength + 1)
		        
		        Var CategoryDict As Dictionary = NewSettings.Value(Category)
		        CategoryDict.Value(Key) = NewValue
		      Next
		      
		      Var NewFiles As New Dictionary
		      NewFiles.Value("Config.json") = Beacon.GenerateJSON(NewSettings, True)
		      NewFiles.Value("user-settings.ini") = ExtraGameIniRewritten
		      
		      Self.RunBackup(OldFiles, NewFiles)
		      
		      If Self.Finished Then
		        Return False
		      End If
		    End If
		    
		    If Not Self.PutFile(ExtraGameIniRewritten, Self.mGamePath + "user-settings.ini") Then
		      Self.Finished = True
		      Return False
		    End If
		    If Self.Finished Then
		      Return False
		    End If
		  End If
		  
		  // Deploy changes
		  For Each Entry As DictionaryEntry In Changes
		    Var NitradoPath As String = Entry.Key
		    Var NewValue As String = Entry.Value
		    
		    Var CategoryLength As Integer = NitradoPath.IndexOf(".")
		    Var Category As String = NitradoPath.Left(CategoryLength)
		    Var Key As String = NitradoPath.Middle(CategoryLength + 1)
		    Var FormData As New Dictionary
		    FormData.Value("category") = Category
		    FormData.Value("key") = Key
		    FormData.Value("value") = NewValue
		    
		    Self.Log("Updating " + Key + "…")
		    
		    Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		    Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		    Sock.SetFormData(FormData)
		    Self.SendRequest(Sock, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings")
		    If Self.Finished Or Self.CheckError(Sock) Then
		      Return False
		    End If
		    Var Content As String = Sock.LastString
		    Var Status As Integer = Sock.LastHTTPStatus
		    
		    Try
		      Var Response As Dictionary = Beacon.ParseJSON(Content)
		      If Response.Value("status") <> "success" Then
		        Self.SetError("Error: Unable to change setting: " + FormData.Value("category").StringValue + "." + FormData.Value("value").StringValue)
		        Return False
		      End If
		    Catch Err As RuntimeException
		      App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		      Self.SetError(Err)
		      Return False
		    End Try
		    
		    // So we don't go nuts
		    Thread.SleepCurrent(100)
		  Next
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Begin()
		  Var Token As Variant = Beacon.Cache.Fetch(Profile.ProviderTokenId)
		  If Token.IsNull = False And Token.Type = Variant.TypeObject And Token.ObjectValue IsA BeaconAPI.ProviderToken Then
		    Self.mProviderToken = Token
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub CreateCheckpoint()
		  Self.CreateCheckpoint()
		End Sub
	#tag EndEvent

	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var Servers() As Beacon.DiscoveredData
		  
		  // Get a list of all servers
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  
		  Self.Log("Finding servers…")
		  Self.SendRequest(Socket, "GET", "https://api.nitrado.net/services")
		  If Self.Finished Or Self.CheckError(Socket) Then
		    Return Servers
		  End If
		  Var Content As String = Socket.LastString
		  Var Status As Integer = Socket.LastHTTPStatus
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    App.LogAPIException(Parsed, CurrentMethodName, Socket.LastURL, Status, Content)
		    Self.SetError("There was an exception while retrieving your server list.")
		    Return Servers
		  End Try
		  
		  // If it's not a dictionary, what else can we do
		  If (Parsed IsA Dictionary) = False Then
		    Return Servers
		  End If
		  
		  Var Response As Dictionary = Parsed
		  If Response.Lookup("status", "") <> "success" Or Response.HasKey("data") = False Or IsNull(Response.Value("data")) Or Response.Value("data").Type <> Variant.TypeObject Or (Response.Value("data").ObjectValue IsA Dictionary) = False Then
		    Self.SetError("Nitrado API returned unexpected data.")
		    Return Servers
		  End If
		  
		  Var Data As Dictionary = Dictionary(Response.Value("data").ObjectValue)
		  If Data.HasKey("services") = False Or IsNull(Data.Value("services")) Or Data.Value("services").IsArray = False Then
		    Return Servers
		  End If
		  
		  Var Services() As Variant = Data.Value("services")
		  For Each Service As Variant In Services
		    If IsNull(Service) Or Service.Type <> Variant.TypeObject Or (Service.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Try
		      Var Dict As Dictionary = Service
		      
		      If Dict.Lookup("type", "").StringValue <> "gameserver" Or Dict.Lookup("status", "").StringValue <> "active" Then
		        Continue
		      End If
		      
		      Var Profile As Ark.NitradoServerProfile
		      Try
		        Var Details As Dictionary = Dict.Value("details")
		        Var GameName As String = Details.Value("game")
		        If GameName.BeginsWith("ARK: Survival Evolved") = False Then
		          Continue
		        End If
		        
		        Profile = New Ark.NitradoServerProfile
		        Profile.ProviderTokenId = Self.mProviderToken.TokenId
		        Profile.Name = Details.Value("name")
		        Profile.ServiceID = Dict.Value("id")
		        Profile.Address = Details.Value("address")
		        
		        If Profile.Name.BeginsWith("Gameserver - ") And Dict.HasKey("comment") And IsNull(Dict.Value("comment")) = False Then
		          Profile.Name = Dict.Value("comment")
		        End If
		      Catch Err As RuntimeException
		        Continue
		      End Try
		      
		      Self.Log("Retrieving " + Profile.Name + "…")
		      // Lookup server information
		      Var DetailsSocket As New SimpleHTTP.SynchronousHTTPSocket
		      DetailsSocket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		      Self.SendRequest(DetailsSocket, "GET", "https://api.nitrado.net/services/" + Profile.ServiceID.ToString(Locale.Raw, "#") + "/gameservers")
		      If Self.Finished Or Self.CheckError(DetailsSocket) Then
		        Continue
		      End If
		      Var DetailsContent As String = DetailsSocket.LastString
		      
		      Var DetailsResponse As Dictionary = Beacon.ParseJSON(DetailsContent)
		      Var DetailsData As Dictionary = DetailsResponse.Value("data")
		      Var GameServer As Dictionary = DetailsData.Value("gameserver")
		      Var Settings As Dictionary = GameServer.Value("settings")
		      Var General As Dictionary = Settings.Value("general")
		      Var Config As Dictionary = Settings.Value("config")
		      Var MapText As String = Config.Value("map")
		      Var MapParts() As String = MapText.Split(",")
		      Profile.Mask = Ark.Maps.MaskForIdentifier(MapParts(MapParts.LastIndex))
		      Var GameSpecific As Dictionary = GameServer.Value("game_specific")
		      Var GameShortcode As String = GameServer.Value("game")
		      Profile.ConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		      
		      Select Case GameShortcode
		      Case "arkse"
		        Profile.Platform = Beacon.ServerProfile.PlatformPC
		      Case "arkxb"
		        Profile.Platform = Beacon.ServerProfile.PlatformXbox
		      Case "arkps"
		        Profile.Platform = Beacon.ServerProfile.PlatformPlayStation
		      Case "arkswitch"
		        Profile.Platform = Beacon.ServerProfile.PlatformSwitch
		      Else
		        Profile.Platform = Beacon.ServerProfile.PlatformUnknown
		      End Select
		      
		      Var Server As New Ark.NitradoDiscoveredData(Profile.ServiceID, Self.mProviderToken.AccessToken, Profile.ConfigPath, General.Lookup("PrimitivePlus", False).BooleanValue)
		      Server.Profile = Profile
		      Server.CommandLineOptions = Settings.Value("start-param")
		      
		      If GuidedModeSupportEnabled And General.Lookup("expertMode", False).BooleanValue = False Then
		        // Build our own ini files from known keys
		        Var AllConfigs() As Ark.ConfigKey = Ark.DataSource.Pool.Get(False).GetConfigKeys("", "", "", False) // To retrieve all
		        Var GuidedOrganizer As New Ark.ConfigOrganizer
		        For Each ConfigKey As Ark.ConfigKey In AllConfigs
		          If ConfigKey.HasNitradoEquivalent = False Then
		            Continue
		          End If
		          
		          Var Paths() As String = ConfigKey.NitradoPaths
		          Var Path As String = Paths(0)
		          Var Value As String = Self.GetViaDotNotation(Settings, Path).StringValue.ReplaceLineEndings(EndOfLine.UNIX)
		          If ConfigKey.ValueType = Ark.ConfigKey.ValueTypes.TypeBoolean Then
		            Var IsTrue As Boolean = (Value = "True") Or (Value = "1")
		            Var Reversed As NullableBoolean = NullableBoolean.FromVariant(ConfigKey.Constraint("nitrado.boolean.reversed"))
		            If (Reversed Is Nil) = False And Reversed.BooleanValue Then
		              IsTrue = Not IsTrue
		            End If
		            Value = If(IsTrue, "True", "False")
		          End If
		          Select Case ConfigKey.NitradoFormat
		          Case Ark.ConfigKey.NitradoFormats.Value
		            GuidedOrganizer.Add(New Ark.ConfigValue(ConfigKey, ConfigKey.Key + "=" + Value))
		          Case Ark.ConfigKey.NitradoFormats.Line
		            Var Lines() As String = Value.Split(EndOfLine.UNIX)
		            For LineIdx As Integer = 0 To Lines.LastIndex
		              GuidedOrganizer.Add(New Ark.ConfigValue(ConfigKey, Lines(LineIdx), LineIdx))
		            Next
		          End Select
		        Next
		        
		        Var ExtraGameIniSuccess As Boolean
		        Var ExtraGameIni As String = Self.GetFile(GameSpecific.Value("path") + "user-settings.ini", DownloadFailureMode.MissingAllowed, Profile, False, ExtraGameIniSuccess)
		        If ExtraGameIniSuccess = False Or Self.Finished Then
		          Continue
		        End If
		        GuidedOrganizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, ExtraGameIni)
		        
		        Server.GameIniContent = GuidedOrganizer.Build(Ark.ConfigFileGame)
		        Server.GameUserSettingsIniContent = GuidedOrganizer.Build(Ark.ConfigFileGameUserSettings)
		      Else
		        // This is normally where the ini files would be downloaded, but the NitradoDiscoveredData class will handle that on demand.
		      End If
		      
		      Servers.Add(Server)
		    Catch Err As RuntimeException
		      App.LogAPIException(Err, CurrentMethodName, Socket.LastURL, Status, Content)
		      Continue
		    End Try
		  Next
		  
		  Return Servers
		End Function
	#tag EndEvent

	#tag Event
		Sub DownloadFile(Transfer As Beacon.IntegrationTransfer, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile)
		  If (Profile IsA Ark.NitradoServerProfile) = False Then
		    Transfer.Success = False
		    Transfer.ErrorMessage = "Profile is not a NitradoServerProfile"
		    Return
		  End If
		  
		  Var Filename As String = Transfer.Filename
		  Var Path As String = Transfer.Path
		  If Path.IsEmpty Then
		    If Filename = "user-settings.ini" Then
		      Path = Self.mGamePath
		    Else
		      Path = Ark.NitradoServerProfile(Profile).ConfigPath
		    End If
		  End If
		  Var FullPath As String = Path + "/" + Filename
		  
		  Var ServiceID As Integer = Ark.NitradoServerProfile(Profile).ServiceID
		  
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Sock.RequestHeader("Cache-Control") = "no-cache"
		  Self.SendRequest(Sock, "GET", "https://api.nitrado.net/services/" + ServiceID.ToString(Locale.Raw, "#") + "/gameservers/file_server/download?file=" + EncodeURLComponent(FullPath))
		  Var Content As MemoryBlock = Sock.LastContent
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  If Status <> 200 Then
		    Select Case FailureMode
		    Case DownloadFailureMode.MissingAllowed
		      Var Message As String
		      Call Self.CheckResponseForError(Sock.LastURL, Status, Content, Sock.LastException, Message)
		      If Status = 500 And Message = "Nitrado Error: File doesn't exist (anymore?)" Then
		        // Bad Nitrado
		        Status = 404
		      End If
		      If Status = 404 Then
		        Transfer.Success = True
		        Transfer.Content = ""
		      Else
		        Transfer.SetError(Message)
		      End If
		    Case DownloadFailureMode.ErrorsAllowed
		      Transfer.Success = True
		      Transfer.Content = ""
		    Case DownloadFailureMode.Required
		      Call Self.CheckSocketForError(Sock, Transfer)
		    End Select
		    
		    Return
		  End If
		  
		  Var SizeSocket As New SimpleHTTP.SynchronousHTTPSocket
		  SizeSocket.RequestHeader("Cache-Control") = "no-cache"
		  SizeSocket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Self.SendRequest(SizeSocket, "GET", "https://api.nitrado.net/services/" + ServiceID.ToString(Locale.Raw, "#") + "/gameservers/file_server/size?path=" + EncodeURLComponent(FullPath))
		  If SizeSocket.LastHTTPStatus <> 200 Then
		    Call Self.CheckSocketForError(Sock, Transfer)
		    Return
		  End If
		  Var RequiredFileSize As Integer
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(SizeSocket.LastContent)
		    RequiredFileSize = Dictionary(Response.Value("data")).Value("size")
		  Catch Err As RuntimeException
		    If FailureMode <> DownloadFailureMode.ErrorsAllowed Then
		      App.LogAPIException(Err, CurrentMethodName, SizeSocket.LastURL, SizeSocket.LastHTTPStatus, SizeSocket.LastContent)
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
		  
		  Var FetchURL As String
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Transfer.SetError("Error: Could not download " + Filename + ".")
		      Return
		    End If
		    
		    Var Data As Dictionary = Response.Value("data")
		    Var TokenDict As Dictionary = Data.Value("token")
		    FetchURL = TokenDict.Value("url")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		    Transfer.SetError(Err.Message)
		    Return
		  End Try
		  
		  Var FetchSocket As New SimpleHTTP.SynchronousHTTPSocket
		  FetchSocket.RequestHeader("Cache-Control") = "no-cache"
		  FetchSocket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Self.SendRequest(FetchSocket, "GET", FetchURL)
		  
		  If Self.CheckSocketForError(FetchSocket, Transfer) Then
		    Return
		  End If
		  
		  Var DownloadedContent As MemoryBlock = FetchSocket.LastContent
		  If (DownloadedContent Is Nil) = False Then
		    If DownloadedContent.Size = RequiredFileSize Or FailureMode = DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		      Transfer.Content = DownloadedContent
		    Else
		      Transfer.SetError("Nitrado returned " + Beacon.BytesToString(DownloadedContent.Size) + " but told Beacon to expect " + Beacon.BytesToString(RequiredFileSize) + ".")
		    End If
		  Else
		    Transfer.SetError("Nitrado returned no content")
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub OverrideUWPMode(ByRef UWPMode As Ark.Project.UWPCompatibilityModes)
		  UWPMode = Ark.Project.UWPCompatibilityModes.Never
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadyToUpload()
		  // Since the process is about to upload, we need to find the log file and determine how long to wait
		  // First we need to look up the current time, since we cannot trust the user's clock
		  Var TimeLookupSocket As New SimpleHTTP.SynchronousHTTPSocket
		  Self.SendRequest(TimeLookupSocket, "GET", BeaconAPI.URL("/now"))
		  Var TimeString As String = TimeLookupSocket.LastString
		  Var Now As DateTime
		  Try
		    Now = NewDateFromSQLDateTime(TimeString)
		  Catch Err As RuntimeException
		    Now = DateTime.Now
		  End Try
		  
		  Var LogContentSuccess As Boolean
		  Var LogContent As String = Self.GetFile(Self.mLogFilePath, DownloadFailureMode.ErrorsAllowed, False, LogContentSuccess)
		  Var ServerStopTime As DateTime
		  
		  If LogContentSuccess Then
		    Try
		      Var EOL As String = Encodings.ASCII.Chr(10)
		      Var Lines() As String = LogContent.ReplaceLineEndings(EOL).Split(EOL)
		      Var TimestampFound As Boolean
		      For I As Integer = Lines.LastIndex DownTo 0
		        Var Line As String = Lines(I)
		        If Line.IndexOf("Log file closed") = -1 Then
		          Continue
		        End If
		        
		        Var Year As Integer = Integer.FromString(Line.Middle(1, 4), Locale.Raw)
		        Var Month As Integer = Integer.FromString(Line.Middle(6, 2), Locale.Raw)
		        Var Day As Integer = Integer.FromString(Line.Middle(9, 2), Locale.Raw)
		        Var Hour As Integer = Integer.FromString(Line.Middle(12, 2), Locale.Raw)
		        Var Minute As Integer = Integer.FromString(Line.Middle(15, 2), Locale.Raw)
		        Var Second As Integer = Integer.FromString(Line.Middle(18, 2), Locale.Raw)
		        Var Nanosecond As Integer = (Integer.FromString(Line.Middle(21, 3), Locale.Raw) / 1000) * 1000000000
		        
		        ServerStopTime = New DateTime(Year, Month, Day, Hour, Minute, Second, Nanosecond, New TimeZone(0))
		        TimestampFound = True
		        Exit For I
		      Next
		      
		      If Not TimestampFound Then
		        ServerStopTime = Now
		      End If
		    Catch Err As RuntimeException
		      ServerStopTime = Now
		    End Try
		  Else
		    ServerStopTime = Now
		  End If
		  
		  // Now we can compute how long to wait.
		  Var WaitUntil As DateTime = ServerStopTime + New DateInterval(0, 0, 0, 0, 3, 0)
		  WaitUntil = New DateTime(WaitUntil.SecondsFrom1970, TimeZone.Current)
		  Var Diff As Double = WaitUntil.SecondsFrom1970 - Now.SecondsFrom1970
		  
		  If Diff > 0 Then
		    Self.Log("Waiting until " + WaitUntil.ToString(Locale.Current, DateTime.FormatStyles.None, DateTime.FormatStyles.Medium) + " per Nitrado recommendation…")
		    Self.Wait(Diff * 1000)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RefreshServerStatus()
		  If Self.mProviderToken Is Nil Then
		    Self.SetError("Cannot check server status because there is no Nitrado account assigned to this process. Start the deploy again to authenticate again.")
		    Return
		  End If
		  
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Self.SendRequest(Sock, "GET", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers")
		  If Self.Finished Or Self.CheckError(Sock) Then
		    Return
		  End If
		  Var Content As String = Sock.LastString
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    Var Data As Dictionary = Response.Value("data")
		    Var GameServer As Dictionary = Data.Value("gameserver")
		    
		    Select Case GameServer.Value("status")
		    Case "started"
		      Self.State = Self.StateRunning
		    Case "starting", "restarting"
		      Self.State = Self.StateStarting
		    Case "stopping"
		      Self.State = Self.StateStopping
		    Case "stopped"
		      Self.State = Self.StateStopped
		    Case "suspended"
		      Self.State = Self.StateOther
		      Self.SetError("The server is suspended. See your Nitrado control panel to reactivate your server.")
		    Case "guardian_locked"
		      Self.State = Self.StateOther
		      Self.SetError("The server is currently guardian locked. Try again during allowed hours.")
		    Case "gs_installation"
		      Self.State = Self.StateOther
		      Self.SetError("The server is switching games.")
		    Case "backup_restore"
		      Self.State = Self.StateOther
		      Self.SetError("The server is restoring a backup.")
		    Case "backup_creation"
		      Self.State = Self.StateOther
		      Self.SetError("The server is creating a backup.")
		    Case "updating"
		      Self.State = Self.StateStarting
		      Self.SetError("The server is currently installing an update.")
		    Else
		      Self.State = Self.StateOther
		      Self.SetError("Unknown server status: " + GameServer.Value("status").StringValue)
		    End Select
		    
		    If Self.mInitialStatusQuery And Self.State <> Self.StateOther Then
		      Self.mInitialStatusQuery = False
		      
		      Var Settings As Dictionary = GameServer.Value("settings")
		      Var GeneralSettings As Dictionary = Settings.Value("general")
		      #if GuidedModeSupportEnabled
		        Self.mDoGuidedDeploy = GeneralSettings.Value("expertMode") = "false"
		        Self.mGamePath = Self.GetViaDotNotation(GameServer, "game_specific.path")
		      #else
		        Var ExpertMode As Boolean = Self.GetViaDotNotation(Settings, "general.expertMode") = "true"
		        If ExpertMode = False And Self.Mode = Self.ModeDeploy Then
		          Self.SwitchToExpertMode("")
		        End If
		      #endif
		      
		      // Determine which map the server is running and update the profile if necessary
		      Var Config As Dictionary = Settings.Value("config")
		      Var MapText As String = Config.Value("map")
		      Var MapParts() As String = MapText.Split(",")
		      Self.Profile.Mask = Ark.Maps.MaskForIdentifier(MapParts(MapParts.LastIndex))
		      
		      // Keep track of the current settings for later
		      Self.mCurrentSettings = Settings
		      
		      // Update the profile with less common changes
		      Var GameSpecific As Dictionary = GameServer.Value("game_specific")
		      Self.mLogFilePath = GameSpecific.Value("path") + "ShooterGame/Saved/Logs/ShooterGame.log"
		      Ark.NitradoServerProfile(Self.Profile).ConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		      Ark.NitradoServerProfile(Self.Profile).Address = GameServer.Value("ip") + ":" + GameServer.Value("port")
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		    Self.SetError(Err)
		    Return
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub StartServer()
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Sock.RequestHeader("Connection") = "close"
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server started by Beacon"
		  FormData.Value("restart_message") = Nil
		  
		  Sock.SetJSON(FormData)
		  Self.SendRequest(Sock, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/restart")
		  If Self.Finished Or Self.CheckError(Sock) Then
		    Return
		  End If
		  Var Content As String = Sock.LastString
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.SetError("Error: Nitrado refused to start the server.")
		      #if DebugBuild
		        System.DebugLog("Reason: " + Response.Value("status").StringValue)
		        System.DebugLog(Content)
		      #endif
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		    Self.SetError(Err)
		  End Try 
		End Sub
	#tag EndEvent

	#tag Event
		Sub StopServer()
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Sock.RequestHeader("Connection") = "close"
		  
		  Var FormData As New Dictionary
		  FormData.Value("message") = "Server is being stopped by Beacon"
		  FormData.Value("stop_message") = Self.StopMessage
		  
		  Sock.SetJSON(FormData)
		  Self.SendRequest(Sock, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/stop")
		  If Self.Finished Or Self.CheckError(Sock) Then
		    Return
		  End If
		  Var Content As String = Sock.LastString
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Self.Log("Error: Nitrado refused to stop the server.")
		      #if DebugBuild
		        System.DebugLog("Reason: " + Response.Value("status").StringValue)
		        System.DebugLog(Content)
		      #endif
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		    Self.SetError(Err)
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub UploadFile(Transfer As Beacon.IntegrationTransfer)
		  Var Filename As String = Transfer.Filename
		  Var Path As String = Transfer.Path
		  If Path.IsEmpty Then
		    If Filename = "user-settings.ini" Then
		      Path = Self.mGamePath
		    Else
		      Path = Ark.NitradoServerProfile(Self.Profile).ConfigPath
		    End If
		  End If
		  
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Sock.RequestHeader("Cache-Control") = "no-cache"
		  
		  Var FormData As New Dictionary
		  FormData.Value("path") = Path
		  FormData.Value("file") = Filename
		  Sock.SetFormData(FormData)
		  Self.SendRequest(Sock, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/file_server/upload")
		  Var PermissionErrorMessage As String
		  If Self.CheckSocketForError(Sock, PermissionErrorMessage) Then
		    Transfer.SetError(PermissionErrorMessage)
		    Return
		  End If
		  Var Content As String = Sock.LastString
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  Var PutURL, PutToken As String
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") <> "success" Then
		      Transfer.Success = False
		      Transfer.ErrorMessage = "Error: Could not upload " + Path + "/" + Filename + "."
		      Return
		    End If
		    
		    Var Data As Dictionary = Response.Value("data")
		    Var TokenDict As Dictionary = Data.Value("token")
		    PutURL = TokenDict.Value("url")
		    PutToken = TokenDict.Value("token")
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		    Transfer.Success = False
		    Transfer.ErrorMessage = Err.Message
		    Return
		  End Try
		  
		  // Wait a moment so the receiver server is ready for the file... or something?
		  Self.Wait(1000)
		  
		  Var PutSocket As New SimpleHTTP.SynchronousHTTPSocket
		  PutSocket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  PutSocket.RequestHeader("token") = PutToken
		  PutSocket.RequestHeader("Content-MD5") = EncodeBase64(Crypto.MD5(Transfer.Content))
		  PutSocket.SetRequestContent(Transfer.Content, "application/octet-stream")
		  PutSocket.RequestHeader("Cache-Control") = "no-cache"
		  Self.SendRequest(PutSocket, "POST", PutURL)
		  If Self.CheckSocketForError(Sock, Transfer) Then
		    Var AdditionalLines As String = EndOfLine + "Check your " + Filename + " file on Nitrado. Nitrado may have accepted partial file content."
		    If Self.BackupEnabled Then
		      AdditionalLines = AdditionalLines + EndOfLine + "Your config files were backed up to " + App.BackupsFolder.Child(Self.Profile.BackupFolderName).NativePath
		    End If
		    Transfer.ErrorMessage = Transfer.ErrorMessage + AdditionalLines
		    Return
		  End If
		  
		  Transfer.Success = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CheckError(Socket As SimpleHTTP.SynchronousHTTPSocket) As Boolean
		  Return Self.CheckError(Socket.LastURL, Socket.LastHTTPStatus, Socket.LastContent, Socket.LastException)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CheckError(URL As String, HTTPStatus As Integer, HTTPResponse As MemoryBlock, HTTPException As RuntimeException) As Boolean
		  Var Message As String
		  If Self.CheckResponseForError(URL, HTTPStatus, HTTPResponse, HTTPException, Message) Then
		    Self.SetError(Message)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckResponseForError(URL As String, HTTPStatus As Integer, HTTPResponse As MemoryBlock, HTTPException As RuntimeException, ByRef Message As String) As Boolean
		  Select Case HTTPStatus
		  Case 401
		    Message = "Error: Authorization failed."
		  Case 429
		    Message = "Error: Rate limit has been exceeded."
		  Case 503
		    Message = "Error: Nitrado is offline for maintenance."
		  Case 504
		    Message = "Error: Nitrado appears to be having an unplanned outage."
		  Case 500
		    Var TempMessage As String
		    If (HTTPResponse Is Nil) = False Then
		      Try
		        Var Parsed As Variant = Beacon.ParseJSON(HTTPResponse)
		        If Parsed.Type = Variant.TypeObject And Parsed.ObjectValue IsA Dictionary And Dictionary(Parsed.ObjectValue).HasKey("message") Then
		          TempMessage = "Nitrado Error: " + Dictionary(Parsed.ObjectValue).Value("message").StringValue
		        End If
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If TempMessage <> "" Then
		      Message = TempMessage
		    Else
		      Message = "Error: Nitrado responded with an error but no message."
		    End If
		  Case 0
		    Message = "Connection error #" + HTTPException.ErrorNumber.ToString(Locale.Raw, "0")
		    
		    If (HTTPException Is Nil) = False And HTTPException.Message.IsEmpty = False Then
		      Message = Message + ": " + HTTPException.Message
		    ElseIf (HTTPResponse Is Nil) = False And HTTPResponse.Size > 0 Then
		      Message = Message + ": " + HTTPResponse.StringValue(0, HTTPResponse.Size).GuessEncoding
		    End If
		    
		    If Message.EndsWith(".") = False Then
		      Message = Message + "."
		    End If
		    App.Log(Message)
		    App.Log("Target: " + URL)
		    
		    Message = Message + " Check the Nitrado API status at https://status.usebeacon.app/ for more information."
		  Else
		    Message = ""
		    Return False
		  End Select
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckSocketForError(Socket As SimpleHTTP.SynchronousHTTPSocket, Transfer As Beacon.IntegrationTransfer) As Boolean
		  Var Message As String
		  If CheckResponseForError(Socket.LastURL, Socket.LastHTTPStatus, Socket.LastContent, Socket.LastException, Message) Then
		    Transfer.ErrorMessage = Message
		    Transfer.Success = False
		  Else
		    Transfer.Success = True
		  End If
		  If (Socket.LastContent Is Nil) = False Then
		    Transfer.Content = Socket.LastContent
		  End If
		  Return Not Transfer.Success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CheckSocketForError(Socket As SimpleHTTP.SynchronousHTTPSocket, ByRef Message As String) As Boolean
		  Return CheckResponseForError(Socket.LastURL, Socket.LastHTTPStatus, Socket.LastContent, Socket.LastException, Message)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  Self.mInitialStatusQuery = True
		  
		  If Profile IsA Ark.NitradoServerProfile Then
		    Self.mServiceID = Ark.NitradoServerProfile(Profile).ServiceID
		  End If
		  
		  Super.Constructor(Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CreateCheckpoint()
		  If Self.mCheckpointCreated Then
		    Return
		  End If
		  
		  Self.Log("Saving previous configuration as profile…")
		  
		  Var FormData As New Dictionary
		  FormData.Value("name") = "Beacon " + Self.Label
		  
		  Var Sock As New SimpleHTTP.SynchronousHTTPSocket
		  Sock.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  Sock.SetFormData(FormData)
		  Self.SendRequest(Sock, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings/sets")
		  If Self.Finished Or Self.CheckError(Sock) Then
		    Return
		  End If
		  Var Content As String = Sock.LastString
		  Var Status As Integer = Sock.LastHTTPStatus
		  
		  Try
		    Var Response As Dictionary = Beacon.ParseJSON(Content)
		    If Response.Value("status") = "success" Then
		      Self.mCheckpointCreated = True
		      Self.Log("Created configuration profile """ + FormData.Value("name").StringValue + """")
		    Else
		      Self.SetError("Error: Could not backup current settings.")
		    End If
		  Catch Err As RuntimeException
		    App.LogAPIException(Err, CurrentMethodName, Sock.LastURL, Status, Content)
		    Self.SetError(Err)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetViaDotNotation(Dict As Dictionary, Path As String) As Variant
		  Var Pos As Integer = Path.IndexOf(".")
		  Var Key As String
		  If Pos = -1 Then
		    Key = Path
		    Path = ""
		  Else
		    Key = Path.Left(Pos)
		    Path = Path.Middle(Pos + 1)
		  End If
		  
		  If Dict.HasKey(Key) = False Then
		    Return Nil
		  End If
		  
		  Var Value As Variant = Dict.Value(Key)
		  If Path.IsEmpty Or (Value IsA Dictionary) = False Then
		    Return Value
		  End If
		  
		  Return GetViaDotNotation(Dictionary(Value), Path)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.NitradoServerProfile
		  Return Ark.NitradoServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
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
		Function SupportsWideSettings() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchToExpertMode(OffendingKey As String, ContentLength As Integer)
		  Var UserData As New Dictionary
		  UserData.Value("OffendingKey") = OffendingKey
		  UserData.Value("ContentLength") = ContentLength
		  Var Controller As New Beacon.TaskWaitController("Needs Expert Mode", UserData)
		  
		  Self.Log("Waiting for user action…")
		  Self.Wait(Controller)
		  Self.RemoveLastLog()
		  If Controller.Cancelled Then
		    Self.Cancel
		    Return
		  End If
		  
		  // Create a checkpoint now
		  If Self.BackupEnabled Then
		    Self.CreateCheckpoint()
		    If Self.Finished Then
		      Return
		    End If
		  End If
		  
		  // Start the server, returning it to its previous state
		  Self.Log("Enabling expert mode…")
		  Select Case Self.State
		  Case Self.StateStopped, Self.StateStopping
		    Self.Log("Enabling expert mode - starting server…", True)
		    Self.StartServer(False)
		    If Self.Finished Then
		      Return
		    End If
		    Self.Log("Enabling expert mode - stopping server…", True)
		    Self.StopServer(False)
		    If Self.Finished Then
		      Return
		    End If
		  Case Self.StateRunning, Self.StateStarting
		    Self.Log("Enabling expert mode - stopping server…", True)
		    Self.StopServer(False)
		    If Self.Finished Then
		      Return
		    End If
		    Self.Log("Enabling expert mode - starting server…", True)
		    Self.StartServer(False)
		    If Self.Finished Then
		      Return
		    End If
		  End Select
		  
		  // Now actually change the server
		  Var FormData As New Dictionary
		  FormData.Value("category") = "general"
		  FormData.Value("key") = "expertMode"
		  FormData.Value("value") = "true"
		  
		  Var ExpertToggleSocket As New SimpleHTTP.SynchronousHTTPSocket
		  ExpertToggleSocket.RequestHeader("Authorization") = Self.mProviderToken.AuthHeaderValue
		  ExpertToggleSocket.SetFormData(FormData)
		  
		  Self.Log("Enabling expert mode…", True)
		  Self.SendRequest(ExpertToggleSocket, "POST", "https://api.nitrado.net/services/" + Self.mServiceID.ToString(Locale.Raw, "#") + "/gameservers/settings")
		  If Self.Finished Or Self.CheckError(ExpertToggleSocket) Then
		    Return
		  End If
		  Var ExpertContent As String = ExpertToggleSocket.LastString
		  
		  Var ExpertResponse As Dictionary = Beacon.ParseJSON(ExpertContent)
		  If ExpertResponse.Value("status") <> "success" Then
		    Self.SetError("Error: Could not enable expert mode.")
		    Return
		  End If
		  
		  Self.Log("Expert mode enabled.")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentSettings As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGamePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialStatusQuery As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogFilePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderToken As BeaconAPI.ProviderToken
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceID As Integer
	#tag EndProperty


	#tag Constant, Name = ConnectionTimeout, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GuidedModeSupportEnabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Public
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
