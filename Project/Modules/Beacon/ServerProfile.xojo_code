#tag Class
Protected Class ServerProfile
	#tag Method, Flags = &h0
		Function AdminNotes() As String
		  Return Self.mAdminNotes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AdminNotes(Assigns Value As String)
		  If Value.Encoding Is Nil Then
		    Value = Value.GuessEncoding
		  ElseIf Value.Encoding <> Encodings.UTF8 Then
		    Value = Value.ConvertEncoding(Encodings.UTF8)
		  End If
		  Value = Value.Trim
		  If Self.mAdminNotes.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mAdminNotes = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BackupFolderName() As String
		  Return Beacon.SanitizeFilename(Self.Name, 60)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.ServerProfile
		  // The project is not necessary since SaveData will always be modern
		  Var Json As String = Beacon.GenerateJson(Self.SaveData(), False)
		  Var SaveData As Dictionary = Beacon.ParseJson(Json)
		  Return Beacon.ServerProfile.FromSaveData(SaveData, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates() As Beacon.ConfigSetState()
		  Beacon.ConfigSetState.Cleanup(Self.mConfigSetStates)
		  Return Beacon.ConfigSetState.CloneArray(Self.mConfigSetStates)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetStates(Assigns States() As Beacon.ConfigSetState)
		  // First decide if the States() array is different from the mConfigSetStates() array. Then, 
		  // update mConfigSetStates() to match. Do not need to clone the members since they are immutable.
		  
		  Beacon.ConfigSetState.Cleanup(States)
		  
		  If Beacon.ConfigSetState.AreArraysEqual(Self.mConfigSetStates, States) Then
		    Return
		  End If
		  
		  Self.mConfigSetStates = Beacon.ConfigSetState.CloneArray(States)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates(ForProject As Beacon.Project) As Beacon.ConfigSetState()
		  // Make sure to return a clone of the array. Do not need to clone the members since they are immutable.
		  Return Beacon.ConfigSetState.FilterStates(Self.ConfigSetStates, ForProject.ConfigSets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Var Err As New UnsupportedOperationException
		  Err.Message = "Do not instantiate this class, only its subclasses."
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Dict As Dictionary, Project As Beacon.Project, Version As Integer)
		  // Optional project is needed to correctly restore legacy config set states
		  
		  Select Case Version
		  Case 2
		    Self.mProviderId = Dict.Value("providerId")
		    Self.mName = Dict.Value("name")
		    Self.mNickname = Dict.Value("nickname")
		    Self.mSecondaryName = Dict.Value("secondaryName")
		    Self.mProfileId = Dict.Value("profileId")
		    Self.mEnabled = Dict.Value("enabled")
		    Self.mPlatform = Dict.Value("platform")
		    Self.mAdminNotes = Dict.Value("notes")
		    Self.mProfileColor = CType(Dict.Lookup("color", 0).IntegerValue, Beacon.ServerProfile.Colors)
		    
		    If Dict.HasKey("configSetPriorities") Then
		      Self.mConfigSetStates = Beacon.ConfigSetState.DecodeArray(Dict.Value("configSetPriorities"))
		    End If
		    
		    If Dict.HasKey("hostConfig") Then
		      Self.mHostConfig = Beacon.HostConfig.FromSaveData(Dictionary(Dict.Value("hostConfig").ObjectValue))
		    End If
		  Case 1
		    If Not Dict.HasAllKeys("Name", "Profile ID", "Enabled") Then
		      Var Err As New KeyNotFoundException
		      Err.Message = "Incomplete server profile"
		      Raise Err
		    End If
		    
		    Self.Name = Dict.Value("Name")
		    Self.NickName = Dict.Lookup("Nickname", "")
		    Self.SecondaryName = Dict.Lookup("Secondary Name", "")
		    Self.Enabled = Dict.Value("Enabled")
		    Self.mProfileID = Dict.Value("Profile ID")
		    Self.mPlatform = Dict.Lookup("Platform", Beacon.PlatformUnknown)
		    Self.mAdminNotes = Dict.Lookup("Admin Notes", "")
		    Self.mProfileColor = CType(Dict.Lookup("Color", 0).IntegerValue, Beacon.ServerProfile.Colors)
		    
		    Self.mProviderId = Dict.Value("Provider")
		    If Self.mProviderId = "GameServerApp" Then
		      Self.mProviderId = GameServerApp.Identifier
		    End If
		    Select Case Self.mProviderId
		    Case Nitrado.Identifier
		      Var HostConfig As New Nitrado.HostConfig
		      HostConfig.ServiceId = Dict.Lookup("Provider Service ID", 0)
		      HostConfig.TokenId = Dict.Lookup("Provider Token Id", "")
		      Self.mHostConfig = HostConfig
		      Self.mSecondaryName = Dict.Lookup("Address", "") + " (" + HostConfig.ServiceId.ToString(Locale.Raw, "0") + ")"
		    Case GameServerApp.Identifier
		      Var HostConfig As New GameServerApp.HostConfig
		      HostConfig.TemplateId = Dict.Lookup("Provider Service ID", 0)
		      HostConfig.TokenId = Dict.Lookup("Provider Token Id", "")
		      Self.mHostConfig = HostConfig
		      Self.mSecondaryName = HostConfig.TemplateId.ToString(Locale.Raw, "0")
		    Case FTP.Identifier
		      Var HostConfig As New FTP.HostConfig
		      HostConfig.Host = Dict.Value("Host").StringValue
		      HostConfig.Port = Dict.Value("Port").IntegerValue
		      HostConfig.Username = Dict.Value("User").StringValue
		      HostConfig.Password = Dict.Value("Pass").StringValue
		      HostConfig.Mode = Dict.Lookup("Mode", Beacon.FTPModeOptionalTLS).StringValue
		      HostConfig.VerifyHost = Dict.Lookup("Verify Host", True).BooleanValue
		      HostConfig.PrivateKeyFile = Dict.Lookup("Private Key", "").StringValue
		      Self.mHostConfig = HostConfig
		      Self.mSecondaryName = HostConfig.Username + "@" + HostConfig.Host + ":" + HostConfig.Port.ToString(Locale.Raw, "0")
		    End Select
		    
		    If Dict.HasKey("External Account") Then
		      Self.mExternalAccountId = Dict.Value("External Account").StringValue
		    End If
		    
		    If Dict.HasKey("Config Set Priorities") Then
		      Self.mConfigSetStates = Beacon.ConfigSetState.DecodeArray(Dict.Value("Config Set Priorities"))
		    ElseIf Dict.HasKey("Config Sets") Then
		      Var States() As Dictionary
		      Try
		        States = Dict.Value("Config Sets").DictionaryArrayValue
		      Catch Err As RuntimeException
		      End Try
		      
		      Var Sets() As Beacon.ConfigSet
		      If (Project Is Nil) = False Then
		        Sets = Project.ConfigSets
		      End If
		      Var SetsMap As New Dictionary
		      For Each Set As Beacon.ConfigSet In Sets
		        SetsMap.Value(Set.Name) = Set
		      Next
		      
		      Self.mConfigSetStates.ResizeTo(-1)
		      For Each State As Dictionary In States
		        Try
		          Var SetName As String = State.Value("Name").StringValue
		          If SetsMap.HasKey(SetName) = False Then
		            Continue
		          End If
		          Var Set As Beacon.ConfigSet = SetsMap.Value(SetName)
		          Self.mConfigSetStates.Add(New Beacon.ConfigSetState(Set, State.Value("Enabled").BooleanValue))
		        Catch Err As RuntimeException
		        End Try
		      Next
		    End If
		  End Select
		  
		  RaiseEvent ReadFromDictionary(Dict, Version)
		  
		  Self.Modified = False // Use the public version so the state will cascade down
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(ProviderId As String, Name As String)
		  Self.mProviderId = ProviderId
		  Self.mProfileId = Beacon.UUID.v4
		  Self.mName = Name
		  Self.mNickname = ""
		  Self.mSecondaryName = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(ProviderId As String, ProfileId As String, Name As String, Nickname As String, SecondaryName As String)
		  Self.mProviderId = ProviderId
		  Self.mProfileId = ProfileId
		  Self.mName = Name
		  Self.mNickname = Nickname
		  Self.mSecondaryName = SecondaryName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeployCapable() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisplayName() As String
		  Var Nickname As String = Self.Nickname
		  If Nickname.IsEmpty = False Then
		    Return Nickname
		  End If
		  Return Self.Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled() As Boolean
		  Return Self.mEnabled
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Enabled(Assigns Value As Boolean)
		  If Self.mEnabled <> Value Then
		    Self.mEnabled = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExternalAccountId() As String
		  // Kept around for support importing
		  Return Self.mExternalAccountId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(Dict As Dictionary, Project As Beacon.Project) As Beacon.ServerProfile
		  // This isn't a great design because the factory needs to know about all its subclasses, but
		  // there aren't better alternatives. Xojo's dead code stripping prevents a lookup from working.
		  
		  Var Version As Integer = Dict.Lookup("version", 1)
		  If Version > Beacon.ServerProfile.Version Then
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Server profile version is too new"
		    Raise Err
		  End If
		  
		  Var GameId As String
		  If Version = 1 Then
		    If Dict.HasAllKeys("Name", "Provider", "Profile ID") = False Then
		      Return Nil
		    End If
		    GameId = Ark.Identifier
		  ElseIf Version >= 2 Then
		    If Dict.HasAllKeys("name", "gameId") = False Then
		      Return Nil
		    End If
		    GameId = Dict.Value("gameId")
		  End If
		  
		  Select Case GameId
		  Case Ark.Identifier
		    Return New Ark.ServerProfile(Dict, Project, Version)
		  Case SDTD.Identifier
		    Return New SDTD.ServerProfile(Dict, Project, Version)
		  Case ArkSA.Identifier
		    Return New ArkSA.ServerProfile(Dict, Project, Version)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As String
		  Var Raw As String
		  Try
		    Raw = Beacon.GenerateJSON(Self.SaveData, False)
		  Catch Err As RuntimeException
		    Raw = Self.Name + "    " + Self.ProfileID
		  End Try
		  Return EncodeHex(Crypto.SHA2_256(Raw)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HostConfig() As Beacon.HostConfig
		  Return Self.mHostConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HostConfig(Assigns Config As Beacon.HostConfig)
		  If Self.mHostConfig = Config Then
		    Return
		  End If
		  
		  If (Config Is Nil) = False And Config.ProviderId <> Self.ProviderId Then
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Incorrect host config for server profile."
		    Raise Err
		  End If
		  
		  Self.mHostConfig = Config
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsConsole() As Boolean
		  Var Platform As Integer = Self.Platform
		  Return Platform = Beacon.PlatformXbox Or Platform = Beacon.PlatformPlayStation Or Platform = Beacon.PlatformSwitch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LinkPrefix() As String
		  Return "Server"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  If (Self.mHostConfig Is Nil) = False And Self.mHostConfig.Modified Then
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value Then
		    Self.mModified = True
		    Return
		  End If
		  
		  Self.mModified = False
		  
		  If (Self.mHostConfig Is Nil) = False Then
		    Self.mHostConfig.Modified = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  If Self.mName.IsEmpty = False Then
		    Return Self.mName.Trim
		  ElseIf Self.SecondaryName.IsEmpty = False Then
		    Return Self.SecondaryName.Trim
		  Else
		    Return Language.DefaultServerName(Self.GameId)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Assigns Value As String)
		  Value = Value.Trim
		  
		  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mName = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Nickname() As String
		  Return Self.mNickname.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Nickname(Assigns Value As String)
		  Value = Value.Trim
		  
		  If Self.Nickname.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mNickname = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mProfileId = Other.mProfileId Then
		    Return 0
		  End If
		  
		  Const PartSeparator = "4337005c"
		  
		  // Don't just compare names. We know these are not equal, but we need them to be sortable.
		  Var SelfCompare As String = Self.mName + PartSeparator + Self.mSecondaryName + PartSeparator + Self.mProfileId
		  Var OtherCompare As String = Other.mName + PartSeparator + Other.mSecondaryName + PartSeparator + Other.mProfileId
		  Return SelfCompare.Compare(OtherCompare, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Platform() As Integer
		  Return Self.mPlatform
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Platform(Assigns Value As Integer)
		  If Self.mPlatform <> Value Then
		    Self.mPlatform = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProfileColor() As Beacon.ServerProfile.Colors
		  Return Self.mProfileColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProfileColor(Assigns Value As Beacon.ServerProfile.Colors)
		  If Self.mProfileColor <> Value Then
		    Self.mProfileColor = Value
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProfileId() As String
		  If Self.mProfileId = "" Then
		    Self.mProfileId = Beacon.UUID.v4
		  End If
		  Return Self.mProfileId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderId() As String
		  Return Self.mProviderId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProviderId(Assigns Value As String)
		  If Self.mProviderId = Value Then
		    Return
		  End If
		  
		  Self.mProviderId = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  Var SaveData As New Dictionary
		  SaveData.Value("version") = Self.Version
		  SaveData.Value("gameId") = Self.GameId
		  SaveData.Value("providerId") = Self.mProviderId
		  SaveData.Value("name") = Self.mName
		  SaveData.Value("nickname") = Self.mNickname
		  SaveData.Value("secondaryName") = Self.mSecondaryName
		  SaveData.Value("profileId") = Self.mProfileId
		  SaveData.Value("enabled") = Self.mEnabled
		  SaveData.Value("platform") = Self.mPlatform
		  SaveData.Value("notes") = Self.mAdminNotes
		  SaveData.Value("color") = CType(Self.mProfileColor, Integer)
		  
		  If Self.mConfigSetStates.Count > 0 Then
		    SaveData.Value("configSetPriorities") = Beacon.ConfigSetState.EncodeArray(Self.mConfigSetStates)
		  End If
		  
		  If (Self.mHostConfig Is Nil) = False Then
		    SaveData.Value("hostConfig") = Self.mHostConfig.SaveData
		  End If
		  
		  Var Dict As New Dictionary
		  RaiseEvent WriteToDictionary(Dict)
		  For Each Entry As DictionaryEntry In Dict
		    If SaveData.HasKey(Entry.Key) Then
		      Continue
		    End If
		    
		    SaveData.Value(Entry.Key) = Entry.Value
		  Next
		  
		  Return SaveData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As String
		  Return Self.mSecondaryName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SecondaryName(Assigns Value As String)
		  If Self.mSecondaryName.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mSecondaryName = Value
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCustomStopMessage() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestart() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateDetailsFrom(Profile As Beacon.ServerProfile)
		  RaiseEvent UpdateDetailsFrom(Profile)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReadFromDictionary(Dict As Dictionary, Version As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateDetailsFrom(Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WriteToDictionary(Dict As Dictionary)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAdminNotes As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetStates() As Beacon.ConfigSetState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExternalAccountId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHostConfig As Beacon.HostConfig
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNickname As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlatform As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileColor As Beacon.ServerProfile.Colors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfileId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSecondaryName As String
	#tag EndProperty


	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Colors, Type = Integer, Flags = &h0
		None
		  Blue
		  Brown
		  Grey
		  Green
		  Indigo
		  Orange
		  Pink
		  Purple
		  Red
		  Teal
		Yellow
	#tag EndEnum


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
