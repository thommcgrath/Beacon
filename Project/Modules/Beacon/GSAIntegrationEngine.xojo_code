#tag Class
Protected Class GSAIntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Function ApplySettings(Organizer As Beacon.ConfigOrganizer) As Boolean
		  If (Profile IsA Beacon.GSAServerProfile) = False Then
		    Self.SetError("Profile is not a GSAServerProfile")
		    Return False
		  End If
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Socket.RequestHeader("GSA-ID") = Beacon.GSAIntegrationEngine.GSAID
		  Self.SendRequest(Socket, "GET", "https://api.gameserverapp.com/system-api/v1/config-template/" + Beacon.GSAServerProfile(Profile).TemplateID.ToString(Locale.Raw, "0") + "/config/chain")
		  If Self.CheckSocketForError(Socket) Then
		    Return False
		  End If
		  
		  Var Chain As String
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    Chain = Parsed.Value("content")
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return False
		  End Try
		  
		  Socket = New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Socket.RequestHeader("GSA-ID") = Beacon.GSAIntegrationEngine.GSAID
		  Self.SendRequest(Socket, "GET", "https://api.gameserverapp.com/system-api/v1/config-template/" + Beacon.GSAServerProfile(Profile).TemplateID.ToString(Locale.Raw, "0") + "/config/end")
		  If Self.CheckSocketForError(Socket) Then
		    Return False
		  End If
		  
		  Var Tail As String
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    Tail = Parsed.Value("content")
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return False
		  End Try
		  
		  Var Launch As String = "TheIsland?listen" + Chain + " " + Tail
		  Var CommandLine As Dictionary = Beacon.ParseCommandLine(Launch, True)
		  If CommandLine.HasKey("?Map") Then
		    CommandLine.Remove("?Map")
		  ElseIf CommandLine.HasKey("Map") Then
		    CommandLine.Remove("Map")
		  End If
		  
		  // Options are key value pairs, flags are just keys
		  Var Options() As Beacon.ConfigValue = Organizer.FilteredValues("CommandLineOption")
		  Var Flags() As Beacon.ConfigValue = Organizer.FilteredValues("CommandLineFlag")
		  
		  For Each Option As Beacon.ConfigValue In Options
		    Var Key As String = Option.Header + Option.AttributedKey
		    CommandLine.Value(Key) = Option.Command
		  Next
		  For Each Flag As Beacon.ConfigValue In Flags
		    Var Key As String = Flag.Header + Flag.AttributedKey
		    CommandLine.Value(Key) = Flag.AttributedKey
		  Next
		  
		  Var ChainElements(), TailElements() As String
		  For Each Entry As DictionaryEntry In CommandLine
		    Var Key As String = Entry.Key
		    Var Command As String = Entry.Value
		    If Key.BeginsWith("-") Then
		      If Command.BeginsWith("-") = False Then
		        Command = "-" + Command
		      End If
		      TailElements.Add(Command)
		    ElseIf Key.BeginsWith("?") Then
		      If Command.BeginsWith("?") = False Then
		        Command = "?" + Command
		      End If
		      ChainElements.Add(Command)
		    End If
		  Next
		  
		  Var NewChain As String = ChainElements.Join("")
		  Var NewTail As String = TailElements.Join(" ")
		  
		  If Not Self.PutFile(NewChain, "chain") Then
		    Return False
		  End If
		  
		  If Not Self.PutFile(NewTail, "end") Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub Begin()
		  If Self.mAccount Is Nil Then
		    Self.mAccount = Self.Document.Accounts.GetByUUID(Self.Profile.ExternalAccountUUID)
		    If Self.mAccount Is Nil Then
		      Self.SetError("No account is available for this server. Check Beacon's Accounts editor.")
		      Return
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var Servers() As Beacon.DiscoveredData
		  If Self.mAccount Is Nil Then
		    Self.mAccount = Self.Document.Accounts.GetByUUID(Self.Profile.ExternalAccountUUID)
		    If Self.mAccount Is Nil Then
		      Self.SetError("Cannot list templates because the required account is no longer available. Check the Accounts editor in your Beacon project.")
		      Return Servers
		    End If
		  End If
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Socket.RequestHeader("GSA-ID") = Beacon.GSAIntegrationEngine.GSAID
		  Self.SendRequest(Socket, "GET", "https://api.gameserverapp.com/system-api/v1/config-template")
		  If Self.CheckSocketForError(Socket) Then
		    Return Servers
		  End If
		  
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    Var Templates() As Variant
		    If Parsed.HasKey(Self.ArkAppID) Then
		      Templates = Parsed.Value(Self.ArkAppID)
		    ElseIf Parsed.HasKey(Self.ArkAppID.ToString(Locale.Raw, "0")) Then
		      Templates = Parsed.Value(Self.ArkAppID.ToString(Locale.Raw, "0"))
		    End If
		    
		    For Each Dict As Dictionary In Templates
		      If Dict.Value("can_edit").BooleanValue = False Then
		        Continue
		      End If
		      Var TemplateID As Integer = Dict.Value("id").IntegerValue
		      Var TemplateName As String = Dict.Value("name").StringValue
		      
		      Var Profile As New Beacon.GSAServerProfile(TemplateID, TemplateName)
		      Profile.ExternalAccountUUID = Self.mAccount.UUID
		      Profile.Mask = Beacon.Maps.All.Mask
		      
		      Var Server As New Beacon.GSADiscoveredData(TemplateID, Self.mAccount.AccessToken)
		      Server.Profile = Profile
		      
		      Servers.Add(Server)
		    Next
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		  End Try
		  
		  Return Servers
		End Function
	#tag EndEvent

	#tag Event
		Sub DownloadFile(Transfer As Beacon.IntegrationTransfer, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile)
		  #Pragma Unused FailureMode
		  
		  If (Profile IsA Beacon.GSAServerProfile) = False Then
		    Transfer.Success = False
		    Transfer.ErrorMessage = "Profile is not a GSAServerProfile"
		    Return
		  End If
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Socket.RequestHeader("GSA-ID") = Beacon.GSAIntegrationEngine.GSAID
		  Self.SendRequest(Socket, "GET", "https://api.gameserverapp.com/system-api/v1/config-template/" + Beacon.GSAServerProfile(Profile).TemplateID.ToString(Locale.Raw, "0") + "/config/" + Transfer.Filename)
		  If Self.CheckSocketForError(Socket) Then
		    Transfer.Success = False
		    Transfer.SetError(Self.ErrorMessage)
		    Return
		  End If
		  
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    Transfer.Content = Parsed.Value("content")
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    Transfer.SetError(Err)
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub UploadFile(Transfer As Beacon.IntegrationTransfer)
		  If (Self.Profile IsA Beacon.GSAServerProfile) = False Then
		    Transfer.Success = False
		    Transfer.ErrorMessage = "Profile is not a GSAServerProfile"
		    Return
		  End If
		  
		  Var Boundary As String = new v4UUID
		  Var ContentType As String = "multipart/form-data; charset=utf-8; boundary=" + Boundary
		  Var Parts() As String
		  Parts.Add("Content-Disposition: form-data; name=""content""" + EndOfLine.Windows + EndOfLine.Windows + Transfer.Content)
		  Var PostBody As String = "--" + Boundary + EndOfLine.Windows + Parts.Join(EndOfLine.Windows + "--" + Boundary + EndOfLine.Windows) + EndOfLine.Windows + "--" + Boundary + "--"
		  
		  Var TemplateID As Integer = Beacon.GSAServerProfile(Self.Profile).TemplateID
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Socket.RequestHeader("GSA-ID") = Beacon.GSAIntegrationEngine.GSAID
		  Socket.SetRequestContent(PostBody, ContentType)
		  Self.SendRequest(Socket, "POST", "https://api.gameserverapp.com/system-api/v1/config-template/" + TemplateID.ToString(Locale.Raw, "0") + "/config/" + Transfer.Filename)
		  If Self.CheckSocketForError(Socket) Then
		    Transfer.Success = False
		    Transfer.SetError(Self.ErrorMessage)
		    Return
		  End If
		  
		  Transfer.Success = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CheckSocketForError(Socket As SimpleHTTP.SynchronousHTTPSocket) As Boolean
		  If Socket.LastHTTPStatus <> 200 Or Socket.LastString.IsEmpty Then
		    // Something went wrong
		    If Socket.LastException Is Nil Then
		      Var Reason As String
		      Select Case Socket.LastHTTPStatus
		      Case 200
		        Reason = "GameServerApp.com sent an empty response."
		      Case 401
		        Reason = "GameServerApp.com rejected the API token."
		      Case 404
		        Reason = "GameServerApp.com endpoint not found."
		      Case 429
		        Reason = "GameServerApp.com rate limit exceeded."
		      Case 500
		        Reason = "GameServerApp.com internal server error."
		      Else
		        Reason = "HTTP " + Socket.LastHTTPStatus.ToString(Locale.Raw, "0") + " response"
		      End Select
		      App.Log("GameServerApp.com URL: " + Socket.LastURL)
		      App.Log("GameServerApp.com Response: " + EncodeBase64(Socket.LastString, 0))
		      Self.SetError(Reason)
		    Else
		      Self.SetError(Socket.LastException)
		    End If
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Account As Beacon.ExternalAccount)
		  // Simply changing the scope of the constructor
		  Self.mAccount = Account
		  Super.Constructor(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  // Simply changing the scope of the constructor
		  Super.Constructor(Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GSAID() As String
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
		Function SupportsWideSettings() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccount As Beacon.ExternalAccount
	#tag EndProperty


	#tag Constant, Name = ArkAppID, Type = Double, Dynamic = False, Default = \"376030", Scope = Public
	#tag EndConstant

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
