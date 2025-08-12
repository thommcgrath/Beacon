#tag Class
Protected Class ServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Dictionary, Version As Integer)
		  Select Case Version
		  Case 2
		    If Dict.HasKey("adminPassword") Then
		      Self.mAdminPassword = NullableString.FromVariant(Dict.Value("adminPassword"))
		    End If
		    
		    If Dict.HasKey("serverPassword") Then
		      Self.mServerPassword = NullableString.FromVariant(Dict.Value("serverPassword"))
		    End If
		    
		    If Dict.HasKey("serverDescription") Then
		      Self.mServerDescription = Dict.Value("serverDescription").StringValue
		    End If
		    
		    Self.mBasePath = Dict.Lookup("basePath", "").StringValue
		    Self.mSettingsIniPath = Dict.Lookup("palWorldSettingsIniPath", "").StringValue
		    Self.mLogsPath = Dict.Lookup("logsPath", "").StringValue
		    Self.mCrossplay = Dict.Lookup("crossplay", Self.CrossplayAll).IntegerValue
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("adminPassword") = NullableString.ToVariant(Self.mAdminPassword)
		  Dict.Value("serverPassword") = NullableString.ToVariant(Self.mServerPassword)
		  Dict.Value("serverDescription") = Self.mServerDescription
		  Dict.Value("crossplay") = Self.mCrossplay
		  
		  If Self.mBasePath.IsEmpty = False Then
		    Dict.Value("basePath") = Self.mBasePath
		  End If
		  If Self.mSettingsIniPath.IsEmpty = False Then
		    Dict.Value("palWorldSettingsIniPath") = Self.mSettingsIniPath
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
		  If NullableString.Compare(Self.mAdminPassword, Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mAdminPassword = Value
		  Self.Modified = True
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
		Function Clone() As Palworld.ServerProfile
		  Return Palworld.ServerProfile(Super.Clone)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String, Name As String)
		  // Making the constructor public
		  Self.mCrossplay = Self.CrossplayAll
		  Super.Constructor(Provider, Name)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Provider As String, ProfileId As String, Name As String, Nickname As String, SecondaryName As String)
		  // Making the constructor public
		  Self.mCrossplay = Self.CrossplayAll
		  Super.Constructor(Provider, ProfileId, Name, Nickname, SecondaryName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Crossplay() As Integer
		  Return Self.mCrossplay
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Crossplay(Assigns Value As Integer)
		  Value = Value And Self.CrossplayAll
		  If Self.mCrossplay = Value Then
		    Return
		  End If
		  
		  Self.mCrossplay = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Crossplay(Mask As Integer) As Boolean
		  Return (Self.mCrossplay And Mask) = Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Crossplay(Mask As Integer, Assigns Value As Boolean)
		  Mask = Mask And Self.CrossplayAll
		  
		  Var NewMask As Integer
		  If Value Then
		    NewMask = Self.mCrossplay Or Mask
		  Else
		    NewMask = Self.mCrossplay And Not Mask
		  End If
		  
		  If Self.mCrossplay = NewMask Then
		    Return
		  End If
		  
		  Self.mCrossplay = NewMask
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Select Case Self.ProviderId
		  Case Nitrado.Identifier, GameServerApp.Identifier
		    Return True
		  Case FTP.Identifier, Local.Identifier
		    Return Self.mSettingsIniPath.IsEmpty = False
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Palworld.Identifier
		End Function
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
		Function Platform() As Integer
		  Return Beacon.PlatformPC
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Platform(Assigns Value As Integer)
		  #Pragma Unused Value
		  Super.Platform = Beacon.PlatformPC
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerDescription() As String
		  Return Self.mServerDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerDescription(Assigns Value As String)
		  If Self.mServerDescription.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mServerDescription = Value
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
		  If NullableString.Compare(Self.mServerPassword, Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mServerPassword = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SettingsIniPath() As String
		  If Self.mSettingsIniPath.IsEmpty = False Then
		    Return Self.mSettingsIniPath
		  ElseIf Self.mBasePath.IsEmpty = False Then
		    Return Self.mBasePath + "/Pal/Saved/Config/WindowsServer/" + Palworld.ConfigFileSettings
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SettingsIniPath(Assigns Value As String)
		  Value = Self.CleanupPath(Value)
		  
		  If Self.mSettingsIniPath.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) = 0 Then
		    Return
		  End If
		  
		  Self.mSettingsIniPath = Value
		  Self.Modified = True
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


	#tag Property, Flags = &h21
		Private mAdminPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBasePath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCrossplay As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLogsPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerPassword As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingsIniPath As String
	#tag EndProperty


	#tag Constant, Name = CrossplayAll, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CrossplayMac, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CrossplayPlaystation, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CrossplaySteam, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CrossplayXbox, Type = Double, Dynamic = False, Default = \"2", Scope = Public
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
