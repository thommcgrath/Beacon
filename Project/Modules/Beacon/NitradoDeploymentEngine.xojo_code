#tag Class
Protected Class NitradoDeploymentEngine
	#tag Method, Flags = &h0
		Sub DownloadGameIni(Profile As Beacon.NitradoServerProfile, AccessToken As Text)
		  If Profile = Nil Or AccessToken = "" Or Profile.ConfigPath = "" Then
		    RaiseEvent GameIniContent(Profile, Nil)
		    Return
		  End If
		  
		  // The path may not yet be complete, so we'll need to do some discovery first
		  If Profile.ConfigPath.EndsWith("Server") Then
		    SimpleHTTP.Get("https://api.nitrado.net/services/" + Profile.ServiceID.ToText + "/gameservers/file_server/download?access_token=" + Beacon.EncodeURLComponent(AccessToken) + "&file=" + Beacon.EncodeURLComponent(Profile.ConfigPath + "/Game.ini"), AddressOf DownloadGameIni_Prepare_Callback, Profile)
		  Else
		    SimpleHTTP.Get("https://api.nitrado.net/services/" + Profile.ServiceID.ToText + "/gameservers/file_server/list?access_token=" + Beacon.EncodeURLComponent(AccessToken) + "&dir=" + Beacon.EncodeURLComponent(Profile.ConfigPath), AddressOf DownloadGameIni_List_Callback, Profile)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni_Actual_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  If Status = 200 Then
		    RaiseEvent GameIniContent(Tag, Content)
		  Else
		    RaiseEvent GameIniContent(Tag, Nil)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni_List_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  If Status <> 200 Then
		    RaiseEvent GameIniContent(Tag, Nil)
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Reply As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    If Reply.HasKey("status") = False Or Reply.Value("status") <> "success" Then
		      RaiseEvent GameIniContent(Tag, Nil)
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Reply.Value("data")
		    Dim Entries() As Auto = Data.Value("entries")
		    Dim Found As Boolean
		    Dim Profile As Beacon.NitradoServerProfile = Tag
		    For Each Entry As Xojo.Core.Dictionary In Entries
		      // Looking for a type:dir that ends with Server
		      If Entry.Value("type") <> "dir" Then
		        Continue
		      End If
		      
		      Dim Path As Text = Entry.Value("path")
		      If Path.EndsWith("Server") Then
		        Found = True
		        Profile.ConfigPath = Path
		        Exit
		      End If
		    Next
		    
		    If Not Found Then
		      RaiseEvent GameIniContent(Profile, Nil)
		      Return
		    End If
		    
		    // Extract the access token from the url
		    // IT WILL ALREADY BE URL ENCODED
		    Dim TokenPrefix As Text = "?access_token="
		    Dim TokenSuffix As Text = "&dir="
		    Dim PrefixPos As Integer = URL.IndexOf(TokenPrefix) + TokenPrefix.Length
		    Dim SuffixPos As Integer = URL.IndexOf(PrefixPos, TokenSuffix)
		    Dim AccessToken As Text = URL.Mid(PrefixPos, SuffixPos - PrefixPos)
		    
		    SimpleHTTP.Get("https://api.nitrado.net/services/" + Profile.ServiceID.ToText + "/gameservers/file_server/download?access_token=" + AccessToken + "&file=" + Beacon.EncodeURLComponent(Profile.ConfigPath + "/Game.ini"), AddressOf DownloadGameIni_Prepare_Callback, Profile)
		  Catch Err As RuntimeException
		    RaiseEvent GameIniContent(Tag, Nil)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadGameIni_Prepare_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  If Status <> 200 Then
		    RaiseEvent GameIniContent(Tag, Nil)
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Reply As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    If Reply.HasKey("status") = False Or Reply.Value("status") <> "success" Then
		      RaiseEvent GameIniContent(Tag, Nil)
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Reply.Value("data")
		    Dim Token As Xojo.Core.Dictionary = Data.Value("token")
		    
		    SimpleHTTP.Get(Token.Value("url"), AddressOf DownloadGameIni_Actual_Callback, Tag)
		  Catch Err As RuntimeException
		    RaiseEvent GameIniContent(Tag, Nil)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListServers(AccessToken As Text)
		  If AccessToken = "" Then
		    Break
		    Return
		  End If
		  
		  Dim URL As Text = "https://api.nitrado.net/services?access_token=" + Beacon.EncodeURLComponent(AccessToken)
		  SimpleHTTP.Get(URL, AddressOf ListServers_Callback, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListServers_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  #Pragma Unused URL
		  
		  Dim Profiles() As Beacon.NitradoServerProfile
		  
		  If Status <> 200 Then
		    RaiseEvent ServersFound(Profiles)
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    
		    Dim Reply As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    If Reply.HasKey("status") = False Or Reply.Value("status") <> "success" Then
		      RaiseEvent ServersFound(Profiles)
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Reply.Value("data")
		    Dim Services() As Auto = Data.Value("services")
		    For Each Service As Xojo.Core.Dictionary In Services
		      Dim Type As Text = Service.Value("type")
		      If Type <> "gameserver" Then
		        Continue
		      End If
		      
		      Dim Details As Xojo.Core.Dictionary = Service.Value("details")
		      Dim Game As Text = Details.Value("game")
		      If Not Game.BeginsWith("Ark: Survival Evolved") Then
		        Continue
		      End If
		      
		      Dim ServerName As Text = Details.Value("name")
		      If Service.Lookup("comment", Nil) <> Nil Then
		        ServerName = Service.Value("comment") + " (" + ServerName + ")"
		      End If
		      
		      Dim Profile As New Beacon.NitradoServerProfile
		      Profile.Name = ServerName
		      Profile.Address = Details.Value("address")
		      Profile.ServiceID = Service.Value("id")
		      Profiles.Append(Profile)
		    Next
		  Catch Err As RuntimeException
		    // Nope
		  End Try
		  
		  RaiseEvent ServersFound(Profiles)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LookupServer(Profile As Beacon.NitradoServerProfile, AccessToken As Text)
		  Dim URL As Text = "https://api.nitrado.net/services/" + Profile.ServiceID.ToText + "/gameservers"//?access_token=" + Beacon.EncodeURLComponent(AccessToken)
		  Dim Headers As New Xojo.Core.Dictionary
		  Headers.Value("Authorization") = "Bearer " + AccessToken
		  SimpleHTTP.Get(URL, AddressOf LookupServer_Callback, Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LookupServer_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock, Tag As Auto)
		  Dim Profile As Beacon.NitradoServerProfile = Tag
		  
		  If Status <> 200 Then
		    RaiseEvent ServerDetails(Profile, Nil, 0.0)
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    
		    Dim Reply As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    Dim Data As Xojo.Core.Dictionary = Reply.Value("data")
		    Dim GameServer As Xojo.Core.Dictionary = Data.Value("gameserver")
		    Dim GameSpecific As Xojo.Core.Dictionary = GameServer.Value("game_specific")
		    
		    If Profile.ConfigPath = "" Then
		      Profile.ConfigPath = GameSpecific.Value("path") + "ShooterGame/Saved/Config/WindowsServer"
		    End If
		    
		    Dim Settings As Xojo.Core.Dictionary = GameServer.Value("settings")
		    Dim Config As Xojo.Core.Dictionary = Settings.Value("config")
		    Dim CommandLineParams As Xojo.Core.Dictionary = Settings.Value("start-param")
		    
		    Dim Map As Beacon.Map
		    Dim MapText As Text = Config.Value("map")
		    Dim MapParts() As Text = MapText.Split(",")
		    Select Case MapParts(MapParts.Ubound)
		    Case "ScorchedEarth_P"
		      Map = Beacon.Maps.ScorchedEarth
		    Case "Aberration_P"
		      Map = Beacon.Maps.Aberration
		    Case "TheCenter"
		      Map = Beacon.Maps.TheCenter
		    Case "Ragnarok"
		      Map = Beacon.Maps.Ragnarok
		    Else
		      Map = Beacon.Maps.TheIsland
		    End Select
		    
		    Dim DifficultyValue As Double
		    If CommandLineParams.HasKey("OverrideOfficialDifficulty") Then
		      DifficultyValue = Double.FromText(CommandLineParams.Value("OverrideOfficialDifficulty"))
		    ElseIf Config.HasKey("difficulty-offset") Then
		      DifficultyValue = Map.DifficultyValue(Double.FromText(Config.Value("difficulty-offset")))
		    Else
		      DifficultyValue = Map.DifficultyValue(1.0)
		    End If
		    
		    RaiseEvent ServerDetails(Profile, Map, DifficultyValue)
		  Catch Err As RuntimeException
		    RaiseEvent ServerDetails(Profile, Nil, 0.0)
		  End Try
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GameIniContent(Profile As Beacon.NitradoServerProfile, Content As Xojo.Core.MemoryBlock)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServerDetails(Profile As Beacon.NitradoServerProfile, Map As Beacon.Map, DifficultyValue As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServersFound(Servers() As Beacon.NitradoServerProfile)
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
