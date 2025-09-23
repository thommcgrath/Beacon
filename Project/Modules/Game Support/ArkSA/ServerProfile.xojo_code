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
		      Self.mMessageOfTheDay = ArkSA.ArkML.FromSaveData(Dict.Value("messageOfTheDay").StringValue)
		      Self.mMessageDuration = Dict.Lookup("messageDuration", 30).IntegerValue
		    End If
		    If Self.mMessageOfTheDay Is Nil Then
		      Self.mMessageOfTheDay = New ArkSA.ArkML
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
		    Self.mCustomGUS = Dict.Lookup("customGUS", "").StringValue
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
		  
		  If Self.mCustomGUS.IsEmpty = False Then
		    Dict.Value("customGUS") = Self.mCustomGUS
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
		Function Clone() As ArkSA.ServerProfile
		  Return ArkSA.ServerProfile(Super.Clone)
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
		Function CustomGUS() As String
		  Return Self.mCustomGUS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CustomGUS(Assigns Value As String)
		  If Self.mCustomGUS.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mCustomGUS = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Select Case Self.ProviderId
		  Case Nitrado.Identifier, GameServerApp.Identifier, ASAManager.Identifier
		    Return True
		  Case FTP.Identifier, Local.Identifier
		    Return (Self.GameIniPath.IsEmpty = False And Self.GameUserSettingsIniPath.IsEmpty = False)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return ArkSA.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniPath() As String
		  If Self.mGameIniPath.IsEmpty = False Then
		    Return Self.mGameIniPath
		  ElseIf Self.mBasePath.IsEmpty = False Then
		    Return Self.mBasePath + "/ShooterGame/Saved/Config/WindowsServer/" + ArkSA.ConfigFileGame
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
		    Return Self.mBasePath + "/ShooterGame/Saved/Config/WindowsServer/" + ArkSA.ConfigFileGameUserSettings
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
		Function IsConsole() As Boolean
		  Return False
		End Function
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
		    Return ArkSA.Maps.UniversalMask
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
		Function MessageOfTheDay() As ArkSA.ArkML
		  Return Self.mMessageOfTheDay
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MessageOfTheDay(Assigns Value As ArkSA.ArkML)
		  If Self.mMessageOfTheDay <> Value Then
		    Self.mMessageOfTheDay = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Platform() As Integer
		  Return Beacon.PlatformUniversal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Platform(Assigns Value As Integer)
		  #Pragma Unused Value
		  Super.Platform = Beacon.PlatformUniversal
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
		  Var Provider As Beacon.HostingProvider
		  If (Config Is Nil) = False Then
		    Provider = Config.CreateProvider()
		  End If
		  
		  If (Config Is Nil) = False And (Provider Is Nil) = False And Provider.SupportsRestarting Then
		    Return Array(Beacon.DeployPlan.StopUploadStart, Beacon.DeployPlan.UploadRestart, Beacon.DeployPlan.UploadOnly)
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
		Private mCustomGUS As String
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
		Private mMessageOfTheDay As ArkSA.ArkML
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
