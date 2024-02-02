#tag Class
Protected Class ServerProfile
Inherits Beacon.ServerProfile
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary, Version As Integer)
		  Select Case Version
		  Case 2
		    Self.mMask = Dict.Lookup("map", 0)
		    
		    If Dict.HasKey("messageOfTheDay") Then
		      Self.mMessageOfTheDay = Ark.ArkML.FromSaveData(Dict.Value("messageOfTheDay").StringValue)
		      Self.mMessageDuration = Dict.Lookup("messageDuration", 30).IntegerValue
		    End If
		    If Self.mMessageOfTheDay Is Nil Then
		      Self.mMessageOfTheDay = New Ark.ArkML
		    End If
		    
		    If Dict.HasKey("adminPassword") Then
		      Self.mAdminPassword = Dict.Value("adminPassword").StringValue
		    End If
		    
		    If Dict.HasKey("serverPassword") Then
		      Self.mServerPassword = Dict.Value("serverPassword").StringValue
		    End If
		    
		    If Dict.HasKey("spectatorPassword") Then
		      Self.mSpectatorPassword = Dict.Value("spectatorPassword").StringValue
		    End If
		    
		    Self.mBasePath = Dict.Lookup("basePath", "").StringValue
		    Self.mGameIniPath = Dict.Lookup("gameIniPath", "").StringValue
		    Self.mGameUserSettingsIniPath = Dict.Lookup("gameUserSettingsIniPath", "").StringValue
		    Self.mLogsPath = Dict.Lookup("logsPath", "").StringValue
		  Case 1
		    Self.mMask = Dict.Lookup("Map", 0)
		    
		    If Dict.HasKey("Message of the Day") Then
		      Var MOTD As Variant = Dict.Value("Message of the Day")
		      If MOTD.Type = Variant.TypeString Then
		        #if Not TargetiOS
		          Self.mMessageOfTheDay = Ark.ArkML.FromRTF(MOTD)
		        #endif
		      Else
		        Var Info As Introspection.TypeInfo = Introspection.GetType(MOTD)
		        If Info.FullName = "Dictionary()" Then
		          Self.mMessageOfTheDay = Ark.ArkML.FromArray(MOTD)
		        ElseIf Info.FullName = "Object()" Then
		          Self.mMessageOfTheDay = Ark.ArkML.FromObjects(MOTD)
		        End If
		      End If
		      Self.mMessageDuration = Dict.Lookup("Message Duration", 30).IntegerValue
		    End If
		    
		    If Self.mMessageOfTheDay Is Nil Then
		      Self.mMessageOfTheDay = New Ark.ArkML
		    End If
		    
		    If Dict.HasKey("Admin Password") Then
		      Self.mAdminPassword = Dict.Value("Admin Password").StringValue
		    End If
		    
		    If Dict.HasKey("Server Password") Then
		      Self.mServerPassword = Dict.Value("Server Password").StringValue
		    End If
		    
		    If Dict.HasKey("Spectator Password") Then
		      Self.mSpectatorPassword = Dict.Value("Spectator Password").StringValue
		    End If
		    
		    If Dict.HasKey("Provider") Then
		      Var Provider As String = Dict.Value("Provider")
		      Select Case Provider
		      Case Nitrado.Identifier
		        Self.mBasePath = Dict.Value("Path").StringValue
		      Case FTP.Identifier
		        Self.mGameIniPath = Dict.Value("Game.ini Path").StringValue
		        Self.mGameUserSettingsIniPath = Dict.Value("GameUserSettings.ini Path").StringValue
		      Case Local.Identifier
		        If Dict.HasKey(Ark.ConfigFileGame) Then
		          Self.mGameIniPath = Dict.Value(Ark.ConfigFileGame).StringValue
		        End If
		        If Dict.HasKey(Ark.ConfigFileGameUserSettings) Then
		          Self.mGameUserSettingsIniPath = Dict.Value(Ark.ConfigFileGameUserSettings).StringValue
		        End If
		        If Self.SecondaryName.IsEmpty Then
		          Var Paths() As String = Array(Self.mGameUserSettingsIniPath, Self.mGameIniPath)
		          For Each Path As String In Paths
		            Try
		              Var File As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(Path)
		              Self.SecondaryName = File.PartialPath
		              Exit
		            Catch Err As RuntimeException
		            End Try
		          Next
		        End If
		      Case GameServerApp.Identifier
		        Self.mGameIniPath = Ark.ConfigFileGame
		        Self.mGameUserSettingsIniPath = Ark.ConfigFileGameUserSettings
		      End Select
		    End If
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("map") = Self.mMask
		  
		  If (Self.mMessageOfTheDay Is Nil) = False And Self.mMessageOfTheDay.IsEmpty = False Then
		    Dict.Value("messageOfTheDay") = Self.mMessageOfTheDay.SaveData
		    Dict.Value("messageDuration") = Self.mMessageDuration
		  End If
		  If (Self.mAdminPassword Is Nil) = False Then
		    Dict.Value("adminPassword") = Self.mAdminPassword.StringValue
		  End If
		  If (Self.mServerPassword Is Nil) = False Then
		    Dict.Value("serverPassword") = Self.mServerPassword.StringValue
		  End If
		  If (Self.mSpectatorPassword Is Nil) = False Then
		    Dict.Value("spectatorPassword") = Self.mSpectatorPassword.StringValue
		  End If
		  
		  If Self.mBasePath.IsEmpty = False Then
		    Dict.Value("basePath") = Self.mBasePath
		  End If
		  If Self.mGameIniPath.IsEmpty = False Then
		    Dict.Value("gameIniPath") = Self.mGameIniPath
		  End If
		  If Self.mGameUserSettingsIniPath.IsEmpty = False Then
		    Dict.Value("gameUserSettingsIniPath") = Self.mGameUserSettingsIniPath
		  End If
		  If Self.mLogsPath.IsEmpty = False Then
		    Dict.Value("logsPath") = Self.mLogsPath
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function AdminPassword() As NullableString
		  Return Self.mAdminPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AdminPassword(Assigns Value As NullableString)
		  If Self.mAdminPassword <> Value Then
		    Self.mAdminPassword = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BasePath() As String
		  Return Self.mBasePath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BasePath(Assigns Value As String)
		  Value = Self.CleanupPath(Value)
		  
		  If Self.mBasePath.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mBasePath = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CleanupPath(Path As String) As String
		  If Path.EndsWith("/") Or Path.EndsWith("\") Then
		    Path = Path.Left(Path.Length - 1)
		  End If
		  Return Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Clone)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String, Name As String)
		  // Making the constructor public
		  Super.Constructor(Provider, Name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String, ProfileId As String, Name As String, Nickname As String, SecondaryName As String)
		  // Making the constructor public
		  Super.Constructor(Provider, ProfileId, Name, Nickname, SecondaryName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Select Case Self.ProviderId
		  Case Nitrado.Identifier, GameServerApp.Identifier
		    Return True
		  Case FTP.Identifier, Local.Identifier
		    Return (Self.GameIniPath.IsEmpty = False And Self.GameUserSettingsIniPath.IsEmpty = False)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniPath() As String
		  If Self.mGameIniPath.IsEmpty = False Then
		    Return Self.mGameIniPath
		  ElseIf Self.mBasePath.IsEmpty = False Then
		    Return Self.mBasePath + "/ShooterGame/Saved/Config/WindowsServer/" + Ark.ConfigFileGame
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniPath(Assigns Value As String)
		  Value = Self.CleanupPath(Value)
		  
		  If Self.mGameIniPath.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mGameIniPath = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniPath() As String
		  If Self.mGameUserSettingsIniPath.IsEmpty = False Then
		    Return Self.mGameUserSettingsIniPath
		  ElseIf Self.mBasePath.IsEmpty = False Then
		    Return Self.mBasePath + "/ShooterGame/Saved/Config/WindowsServer/" + Ark.ConfigFileGameUserSettings
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniPath(Assigns Value As String)
		  Value = Self.CleanupPath(Value)
		  
		  If Self.mGameUserSettingsIniPath.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mGameUserSettingsIniPath = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogsPath() As String
		  If Self.mLogsPath.IsEmpty = False Then
		    Return Self.mLogsPath
		  ElseIf Self.mBasePath.IsEmpty = False Then
		    Return Self.mBasePath + "/ShooterGame/Saved/Logs"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LogsPath(Assigns Value As String)
		  Value = Self.CleanupPath(Value)
		  
		  If Self.mLogsPath.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mLogsPath = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mask() As UInt64
		  If Self.mMask = CType(0, UInt64) Then
		    Return Ark.Maps.UniversalMask
		  Else
		    Return Self.mMask
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mask(Assigns Value As UInt64)
		  If Self.mMask = Value Then
		    Return
		  End If
		  
		  Self.mMask = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MessageDuration() As Integer
		  Return Self.mMessageDuration
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MessageDuration(Assigns Value As Integer)
		  If Self.mMessageDuration = Value Then
		    Return
		  End If
		  
		  Self.mMessageDuration = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MessageOfTheDay() As Ark.ArkML
		  Return Self.mMessageOfTheDay
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MessageOfTheDay(Assigns Value As Ark.ArkML)
		  If Self.mMessageOfTheDay <> Value Then
		    Self.mMessageOfTheDay = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerPassword() As NullableString
		  Return Self.mServerPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerPassword(Assigns Value As NullableString)
		  If Self.mServerPassword <> Value Then
		    Self.mServerPassword = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpectatorPassword() As NullableString
		  Return Self.mSpectatorPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpectatorPassword(Assigns Value As NullableString)
		  If Self.mSpectatorPassword <> Value Then
		    Self.mSpectatorPassword = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportedDeployPlans() As Beacon.DeployPlan()
		  Var Config As Beacon.HostConfig = Self.HostConfig
		  If (Config Is Nil) = False And Config IsA Nitrado.HostConfig Then
		    Return Array(Beacon.DeployPlan.StopUploadStart)
		  Else
		    Return Array(Beacon.DeployPlan.UploadOnly)
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Attributes( Deprecated ) Event ReadFromDictionary(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Attributes( Deprecated ) Event WriteToDictionary(Dict As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAdminPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBasePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogsPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageDuration As Integer = 30
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMessageOfTheDay As Ark.ArkML
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpectatorPassword As NullableString
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
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
