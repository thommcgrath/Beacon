#tag Class
Protected Class Document
	#tag Method, Flags = &h0
		Sub Add(Profile As Beacon.ServerProfile)
		  If Profile = Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To Self.mServerProfiles.Ubound
		    If Self.mServerProfiles(I) = Profile Then
		      Self.mServerProfiles(I) = Profile.Clone
		      Self.mModified = True
		      Return
		    End If
		  Next
		  
		  Self.mServerProfiles.Append(Profile.Clone)
		  If Profile.IsConsole Then
		    Dim SafeMods() As String = Beacon.Data.ConsoleSafeMods
		    If Self.mMods = Nil Or Self.mMods.Ubound = -1 Then
		      Self.mMods = SafeMods
		    Else
		      For I As Integer = Self.mMods.Ubound DownTo 0
		        If SafeMods.IndexOf(Self.mMods(I)) = -1 Then
		          Self.mMods.Remove(I)
		        End If
		      Next
		    End If
		  End If
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Beacon.ConfigGroup)
		  Self.mConfigGroups.Value(Group.ConfigName) = Group
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(GroupName As String, Create As Boolean = False) As Beacon.ConfigGroup
		  If Self.mConfigGroups.HasKey(GroupName) Then
		    Return Self.mConfigGroups.Value(GroupName)
		  End If
		  
		  If Create Then
		    Dim Group As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(GroupName)
		    If Group <> Nil Then
		      Group.IsImplicit = True
		      Self.AddConfigGroup(Group)
		    End If
		    Return Group
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mMapCompatibility = Beacon.Maps.TheIsland.Mask
		  Self.mConfigGroups = New Dictionary
		  Self.AddConfigGroup(New BeaconConfigs.Difficulty)
		  Self.Difficulty.IsImplicit = True
		  Self.mModified = False
		  Self.mMods = New Beacon.StringList
		  Self.UseCompression = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Difficulty() As BeaconConfigs.Difficulty
		  Static GroupName As String = BeaconConfigs.Difficulty.ConfigName
		  Return BeaconConfigs.Difficulty(Self.ConfigGroup(GroupName, True))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentID() As String
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(Contents As String, Identity As Beacon.Identity) As Beacon.Document
		  Dim Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Contents)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Dim Doc As New Beacon.Document
		  Dim Version As Integer = 1
		  Dim Dict As Dictionary
		  If Parsed IsA Dictionary Then
		    Dict = Parsed
		    Version = Dict.Lookup("Version", 0)
		    If Dict.HasKey("Identifier") Then
		      Doc.mIdentifier = Dict.Value("Identifier")
		    Else
		      Doc.mIdentifier = Beacon.CreateUUID
		    End If
		  End If
		  If Version < 3 Then
		    Return Nil
		  End If
		  
		  // New config system
		  If Dict.HasKey("Configs") Then
		    Dim Groups As Dictionary = Dict.Value("Configs")
		    For Each Entry As DictionaryEntry In Groups
		      Dim GroupName As String = Entry.Key
		      Dim GroupData As Dictionary = Entry.Value
		      Dim Instance As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(GroupName, GroupData, Identity)
		      If Instance <> Nil Then
		        Doc.mConfigGroups.Value(GroupName) = Instance
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("Mods") Then
		    Dim Mods As Beacon.StringList = Beacon.StringList.FromVariant(Dict.Value("Mods"))
		    If Mods <> Nil Then
		      Doc.mMods = Mods
		    End If
		  ElseIf Dict.HasKey("ConsoleModsOnly") Then
		    Dim ConsoleModsOnly As Boolean = Dict.Value("ConsoleModsOnly")
		    If ConsoleModsOnly Then
		      Doc.mMods = Beacon.Data.ConsoleSafeMods()
		    End If
		  End If
		  If Dict.HasKey("Map") Then
		    Doc.MapCompatibility = Dict.Value("Map")
		  ElseIf Dict.HasKey("MapPreference") Then
		    Doc.MapCompatibility = Dict.Value("MapPreference")
		  Else
		    Doc.MapCompatibility = 0
		  End If
		  If Dict.HasKey("UseCompression") Then
		    Doc.UseCompression = Dict.Value("UseCompression")
		  Else
		    Doc.UseCompression = True
		  End If
		  If Dict.HasKey("Secure") Then
		    Dim SecureDict As Dictionary = ReadSecureData(Dict.Value("Secure"), Identity)
		    If SecureDict <> Nil Then
		      Doc.mLastSecureDict = Dict.Value("Secure")
		      Doc.mLastSecureHash = Doc.mLastSecureDict.Value("Hash")
		      
		      Dim ServerDicts() As Variant = SecureDict.Value("Servers")
		      For Each ServerDict As Dictionary In ServerDicts
		        Dim Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromDictionary(ServerDict)
		        If Profile <> Nil Then
		          Doc.mServerProfiles.Append(Profile)
		        End If
		      Next
		      
		      If SecureDict.HasKey("OAuth") Then
		        Doc.mOAuthDicts = SecureDict.Value("OAuth")
		      End If
		    End If
		  End If
		  If Dict.HasKey("Trust") Then
		    Doc.mTrustKey = Dict.Value("Trust")
		  End If
		  
		  If Dict.HasKey("Timestamp") Then
		    Doc.mLastSaved = NewDateFromSQLDateTime(Dict.Value("Timestamp"))
		  End If
		  
		  Doc.Modified = Version < Beacon.Document.DocumentVersion
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(GroupName As String) As Boolean
		  Return Self.mConfigGroups.HasKey(GroupName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs() As Beacon.ConfigGroup()
		  Dim Groups() As Beacon.ConfigGroup
		  For Each Entry As DictionaryEntry In Self.mConfigGroups
		    Groups.Append(Entry.Value)
		  Next
		  Return Groups
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Identity As Beacon.Identity) As Boolean
		  If Self.mMapCompatibility = 0 Then
		    Return False
		  End If
		  If Self.DifficultyValue = -1 Then
		    Return False
		  End If
		  
		  Dim Configs() As Beacon.ConfigGroup = Self.ImplementedConfigs()
		  For Each Config As Beacon.ConfigGroup In Configs
		    Dim Issues() As Beacon.Issue = Config.Issues(Self, Identity)
		    If Issues <> Nil And Issues.Ubound > -1 Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function LastSaved() As Date
		  If Self.mLastSaved <> Nil Then
		    Return New Date(Self.mLastSaved)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Beacon.Map()
		  Dim Possibles() As Beacon.Map = Beacon.Maps.All
		  Dim Matches() As Beacon.Map
		  For Each Map As Beacon.Map In Possibles
		    If Map.Matches(Self.mMapCompatibility) Then
		      Matches.Append(Map)
		    End If
		  Next
		  Return Matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Metadata(Create As Boolean = False) As BeaconConfigs.Metadata
		  Static GroupName As String = BeaconConfigs.Metadata.ConfigName
		  Dim Group As Beacon.ConfigGroup = Self.ConfigGroup(GroupName, Create)
		  If Group <> Nil Then
		    Return BeaconConfigs.Metadata(Group)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  If Self.mMods.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mConfigGroups
		    Dim Group As Beacon.ConfigGroup = Entry.Value
		    If Group.Modified Then
		      Return True
		    End If
		  Next
		  
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Value = False Then
		    For Each Entry As DictionaryEntry In Self.mConfigGroups
		      Dim Group As Beacon.ConfigGroup = Entry.Value
		      Group.Modified = False
		    Next
		    
		    For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		      Profile.Modified = False
		    Next
		    
		    Self.mMods.Modified = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mods() As Beacon.StringList
		  Return Self.mMods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewIdentifier()
		  Self.mIdentifier = Beacon.CreateUUID
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OAuthData(Provider As String) As Dictionary
		  If Self.mOAuthDicts <> Nil And Self.mOAuthDicts.HasKey(Provider) Then
		    Return Dictionary(Self.mOAuthDicts.Value(Provider)).Clone
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OAuthData(Provider As String, Assigns Dict As Dictionary)
		  If Self.mOAuthDicts = Nil Then
		    Self.mOAuthDicts = New Dictionary
		  End If
		  If Dict = Nil Then
		    If Self.mOAuthDicts.HasKey(Provider) Then
		      Self.mOAuthDicts.Remove(Provider)
		      Self.mModified = True
		    End If
		  Else
		    If Self.mOAuthDicts.HasKey(Provider) Then
		      // Need to compare
		      Dim OldJSON As String = Beacon.GenerateJSON(Self.mOAuthDicts.Value(Provider), False)
		      Dim NewJSON As String = Beacon.GenerateJSON(Dict, False)
		      If OldJSON = NewJSON Then
		        Return
		      End If
		    End If
		    
		    Self.mOAuthDicts.Value(Provider) = Dict.Clone
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Document) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mIdentifier.Compare(Other.mIdentifier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Shared Function ReadSecureData(SecureDict As Dictionary, Identity As Beacon.Identity, SkipHashVerification As Boolean = False) As Dictionary
		  If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		    Return Nil
		  End If
		  
		  Dim Key As MemoryBlock = Identity.Decrypt(DecodeHex(SecureDict.Value("Key")))
		  If Key = Nil Then
		    Return Nil
		  End If
		  
		  Dim ExpectedHash As String = SecureDict.Lookup("Hash", "")
		  Dim Vector As MemoryBlock = DecodeHex(SecureDict.Value("Vector"))
		  Dim Encrypted As MemoryBlock = DecodeHex(SecureDict.Value("Content"))
		  Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		  AES.SetKey(Key)
		  AES.SetInitialVector(Vector)
		  
		  Dim Decrypted As String
		  Try
		    Decrypted = AES.DecryptCBC(Encrypted)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If SkipHashVerification = False Then
		    Dim ComputedHash As String = Beacon.Hash(Decrypted)
		    If ComputedHash <> ExpectedHash Then
		      Return Nil
		    End If
		  End If
		  
		  If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		    Return Nil
		  End If
		  Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		  
		  Dim DecryptedDict As Dictionary
		  Try
		    DecryptedDict = Beacon.ParseJSON(Decrypted)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Return DecryptedDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Profile As Beacon.ServerProfile)
		  For I As Integer = 0 To Self.mServerProfiles.Ubound
		    If Self.mServerProfiles(I) = Profile Then
		      Self.mServerProfiles.Remove(I)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(Group As Beacon.ConfigGroup)
		  Self.RemoveConfigGroup(Group.ConfigName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(GroupName As String)
		  If Self.mConfigGroups.HasKey(GroupName) Then
		    Self.mConfigGroups.Remove(GroupName)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(Index As Integer) As Beacon.ServerProfile
		  Return Self.mServerProfiles(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerProfile(Index As Integer, Assigns Profile As Beacon.ServerProfile)
		  Self.mServerProfiles(Index) = Profile.Clone
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfileCount() As Integer
		  Return Self.mServerProfiles.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMap(Map As Beacon.Map) As Boolean
		  Return Map.Matches(Self.mMapCompatibility)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SupportsMap(Map As Beacon.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.mMapCompatibility = Self.mMapCompatibility Or Map.Mask
		  Else
		    Self.mMapCompatibility = Self.mMapCompatibility And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary(Identity As Beacon.Identity) As Dictionary
		  Dim Document As New Dictionary
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.DocumentID
		  Document.Value("Trust") = Self.TrustKey
		  
		  Dim ModsList() As String = Self.Mods
		  Document.Value("Mods") = ModsList
		  Document.Value("UseCompression") = Self.UseCompression
		  Document.Value("Timestamp") = Date.Now.SQLDateTimeWithOffset
		  
		  Dim Groups As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mConfigGroups
		    Dim Group As Beacon.ConfigGroup = Entry.Value
		    Dim GroupData As Dictionary = Group.ToDictionary(Identity)
		    If GroupData = Nil Then
		      GroupData = New Dictionary
		    End If
		    
		    Dim Info As Introspection.TypeInfo = Introspection.GetType(Group)
		    Groups.Value(Info.Name) = GroupData
		  Next
		  Document.Value("Configs") = Groups
		  
		  If Self.mMapCompatibility > 0 Then
		    Document.Value("Map") = Self.mMapCompatibility
		  End If
		  
		  Dim EncryptedData As New Dictionary
		  Dim Profiles() As Dictionary
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    Profiles.Append(Profile.ToDictionary)
		  Next
		  EncryptedData.Value("Servers") = Profiles
		  If Self.mOAuthDicts <> Nil Then
		    EncryptedData.Value("OAuth") = Self.mOAuthDicts
		  End If
		  
		  Dim Content As String = Beacon.GenerateJSON(EncryptedData, False)
		  Dim Hash As String = Beacon.Hash(Content)
		  If Hash <> Self.mLastSecureHash Then
		    Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		    Dim Key As MemoryBlock = Crypto.GenerateRandomBytes(128)
		    Dim Vector As MemoryBlock = Crypto.GenerateRandomBytes(16)
		    AES.SetKey(Key)
		    AES.SetInitialVector(Vector)
		    Dim Encrypted As MemoryBlock = AES.EncryptCBC(Content)
		    
		    Dim SecureDict As New Dictionary
		    SecureDict.Value("Key") = EncodeHex(Identity.Encrypt(Key))
		    SecureDict.Value("Vector") = EncodeHex(Vector)
		    SecureDict.Value("Content") = EncodeHex(Encrypted)
		    SecureDict.Value("Hash") = Hash
		    
		    Self.mLastSecureHash = Hash
		    Self.mLastSecureDict = SecureDict
		  End If
		  Document.Value("Secure") = Self.mLastSecureDict.Clone
		  
		  Return Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesOmniFeaturesWithoutOmni(Identity As Beacon.Identity) As Beacon.ConfigGroup()
		  Dim OmniVersion As Integer = Identity.OmniVersion
		  Dim Configs() As Beacon.ConfigGroup = Self.ImplementedConfigs()
		  Dim ExcludedConfigs() As Beacon.ConfigGroup
		  For Each Config As Beacon.ConfigGroup In Configs
		    If Config.Purchased(OmniVersion) = False Then
		      ExcludedConfigs.Append(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Metadata As BeaconConfigs.Metadata = Self.Metadata
			  If Metadata <> Nil Then
			    Return Metadata.Description
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Metadata(True).Description = Value
			End Set
		#tag EndSetter
		Description As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Difficulty As BeaconConfigs.Difficulty = Self.Difficulty
			  If Difficulty <> Nil Then
			    Return Difficulty.DifficultyValue
			  Else
			    Return -1
			  End If
			End Get
		#tag EndGetter
		DifficultyValue As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Metadata As BeaconConfigs.Metadata = Self.Metadata
			  If Metadata <> Nil Then
			    Return Metadata.IsPublic
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Metadata(True).IsPublic = Value
			End Set
		#tag EndSetter
		IsPublic As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMapCompatibility
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim Limit As UInt64 = Beacon.Maps.All.Mask
			  Value = Value And Limit
			  If Self.mMapCompatibility <> Value Then
			    If Self.mMods <> Nil And Self.mMods.Count > 0 Then
			      Dim Maps() As Beacon.Map = Beacon.Maps.ForMask(Value)
			      For Each Map As Beacon.Map In Maps
			        Self.mMods.Append(Map.ProvidedByModID)
			      Next
			    End If
			    
			    Self.mMapCompatibility = Value
			    Self.mModified = True
			  End If
			End Set
		#tag EndSetter
		MapCompatibility As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConfigGroups As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Private mLastSaved As Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapCompatibility As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.StringList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthDicts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerProfiles() As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTrustKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseCompression As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim Metadata As BeaconConfigs.Metadata = Self.Metadata
			  If Metadata <> Nil Then
			    Return Metadata.Title
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.Metadata(True).Title = Value
			End Set
		#tag EndSetter
		Title As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mTrustKey = "" Then
			    Self.mTrustKey = EncodeHex(Crypto.GenerateRandomBytes(6))
			    Self.mModified = True
			  End If
			  Return Self.mTrustKey
			End Get
		#tag EndGetter
		TrustKey As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUseCompression
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mUseCompression <> Value Then
			    Self.mUseCompression = Value
			    Self.mModified = True
			  End If
			End Set
		#tag EndSetter
		UseCompression As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = DocumentVersion, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Text"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DifficultyValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="IsPublic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="MapCompatibility"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Text"
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
			Name="UseCompression"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TrustKey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Text"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
