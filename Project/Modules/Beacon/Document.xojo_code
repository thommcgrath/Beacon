#tag Class
Protected Class Document
Implements Beacon.DocumentItem
	#tag Method, Flags = &h0
		Sub Add(LootSource As Beacon.LootSource)
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops(True)
		  Dim Idx As Integer = Drops.IndexOf(LootSource)
		  If Idx > -1 Then
		    Drops(Idx) = LootSource
		  Else
		    Drops.Append(LootSource)
		  End If
		End Sub
	#tag EndMethod

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
		    Dim SafeMods() As Text = Beacon.Data.ConsoleSafeMods
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
		Function ConfigGroup(GroupName As Text, Create As Boolean = False) As Beacon.ConfigGroup
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
		  Self.mConfigGroups = New Xojo.Core.Dictionary
		  Self.AddConfigGroup(New BeaconConfigs.Difficulty)
		  Self.Difficulty.IsImplicit = True
		  Self.mModified = False
		  Self.mMods = New Beacon.TextList
		  Self.UseCompression = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    For Each Source As Beacon.LootSource In Drops
		      Source.ConsumeMissingEngrams(Engrams)
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateConfigObjects(ByRef CommandLineOptions() As Beacon.ConfigValue, GameIniOptions As Xojo.Core.Dictionary, GameUserSettingsIniOptions As Xojo.Core.Dictionary, Mask As UInt64, Identity As Beacon.Identity, Profile As Beacon.ServerProfile)
		  Dim Groups() As Beacon.ConfigGroup = Self.ImplementedConfigs
		  For Each Group As Beacon.ConfigGroup In Groups
		    If Group.ConfigName = BeaconConfigs.CustomContent.ConfigName Then
		      Continue
		    End If
		    
		    Dim Options() As Beacon.ConfigValue = Group.CommandLineOptions(Self, Identity, Mask)
		    If Options <> Nil Then
		      For Each Option As Beacon.ConfigValue In Options
		        CommandLineOptions.Append(Option)
		      Next
		    End If
		    
		    Beacon.ConfigValue.FillConfigDict(GameIniOptions, Group.GameIniValues(Self, Identity, Mask))
		    Beacon.ConfigValue.FillConfigDict(GameUserSettingsIniOptions, Group.GameUserSettingsIniValues(Self, Identity, Mask))
		  Next
		  
		  Dim CustomContent As BeaconConfigs.CustomContent
		  If Self.HasConfigGroup(BeaconConfigs.CustomContent.ConfigName) Then
		    CustomContent = BeaconConfigs.CustomContent(Self.ConfigGroup(BeaconConfigs.CustomContent.ConfigName))
		    Beacon.ConfigValue.FillConfigDict(GameIniOptions, CustomContent.GameIniValues(Self, GameIniOptions, Profile))
		    Beacon.ConfigValue.FillConfigDict(GameUserSettingsIniOptions, CustomContent.GameUserSettingsIniValues(Self, GameUserSettingsIniOptions, Profile))
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Difficulty() As BeaconConfigs.Difficulty
		  Static GroupName As Text = BeaconConfigs.Difficulty.ConfigName
		  Return BeaconConfigs.Difficulty(Self.ConfigGroup(GroupName, True))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentID() As Text
		  Return Self.mIdentifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Drops(Create As Boolean = False) As BeaconConfigs.LootDrops
		  Static GroupName As Text = BeaconConfigs.LootDrops.ConfigName
		  Dim Group As Beacon.ConfigGroup = Self.ConfigGroup(GroupName, Create)
		  If Group <> Nil Then
		    Return BeaconConfigs.LootDrops(Group)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromText(Contents As Text, Identity As Beacon.Identity) As Beacon.Document
		  Dim Parsed As Auto
		  Try
		    Parsed = Xojo.Data.ParseJSON(Contents)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Dim Doc As New Beacon.Document
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  Dim Version As Integer = 1
		  Dim Dict As Xojo.Core.Dictionary
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    Dict = Parsed
		    Version = Dict.Lookup("Version", 0)
		    If Dict.HasKey("Identifier") Then
		      Doc.mIdentifier = Dict.Value("Identifier")
		    Else
		      Doc.mIdentifier = Beacon.CreateUUID
		    End If
		  End If
		  If Version < 3 Then
		    Return FromTextLegacy(Parsed, Identity)
		  End If
		  
		  // New config system
		  If Dict.HasKey("Configs") Then
		    Dim Groups As Xojo.Core.Dictionary = Dict.Value("Configs")
		    For Each Entry As Xojo.Core.DictionaryEntry In Groups
		      Dim GroupName As Text = Entry.Key
		      Dim GroupData As Xojo.Core.Dictionary = Entry.Value
		      Dim Instance As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(GroupName, GroupData, Identity)
		      If Instance <> Nil Then
		        Doc.mConfigGroups.Value(GroupName) = Instance
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("Mods") Then
		    Dim Mods As Beacon.TextList = Beacon.TextList.FromAuto(Dict.Value("Mods"))
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
		    Dim SecureDict As Xojo.Core.Dictionary = ReadSecureData(Dict.Value("Secure"), Identity)
		    If SecureDict <> Nil Then
		      Doc.mLastSecureDict = Dict.Value("Secure")
		      Doc.mLastSecureHash = Doc.mLastSecureDict.Value("Hash")
		      
		      Dim ServerDicts() As Auto = SecureDict.Value("Servers")
		      For Each ServerDict As Xojo.Core.Dictionary In ServerDicts
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
		  
		  If Dict.HasKey("Timestamp") Then
		    Dim Locale As Xojo.Core.Locale = Xojo.Core.Locale.Raw
		    Dim TextValue As Text = Dict.Value("Timestamp")
		    Dim Year, Month, Day, Hour, Minute, Second As Integer
		    Year = Integer.FromText(TextValue.Mid(0, 4), Locale)
		    Month = Integer.FromText(TextValue.Mid(5, 2), Locale)
		    Day = Integer.FromText(TextValue.Mid(8, 2), Locale)
		    Hour = Integer.FromText(TextValue.Mid(11, 2), Locale)
		    Minute = Integer.FromText(TextValue.Mid(14, 2), Locale)
		    Second = Integer.FromText(TextValue.Mid(17, 2), Locale)
		    Dim GMTOffset As Double = 0
		    
		    #if TargetiOS
		      Doc.mLastSaved = New Xojo.Core.Date(Year, Month, Day, Hour, Minute, Second, 0, New Xojo.Core.TimeZone(GMTOffset))
		    #else
		      Doc.mLastSavedLegacy = New Global.Date(Year, Month, Day, Hour, Minute, Second, GMTOffset)
		    #endif
		  End If
		  
		  Doc.Modified = Version < Beacon.Document.DocumentVersion
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FromTextLegacy(Parsed As Auto, Identity As Beacon.Identity) As Beacon.Document
		  Dim Doc As New Beacon.Document
		  Dim LootSources() As Auto
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Parsed)
		  Dim Version As Integer
		  If Info.FullName = "Xojo.Core.Dictionary" Then
		    // New style document
		    Dim Dict As Xojo.Core.Dictionary = Parsed
		    Try
		      If Dict.HasKey("LootSources") Then
		        LootSources = Dict.Value("LootSources")
		      Else
		        LootSources = Dict.Value("Beacons")
		      End If
		      Doc.mIdentifier = Dict.Value("Identifier")
		      Doc.mUseCompression = True
		      Version = Dict.Lookup("Version", 0)
		      
		      If Dict.HasKey("Title") Then
		        Doc.Title = Dict.Value("Title")
		      End If
		      If Dict.HasKey("Description") Then
		        Doc.Description = Dict.Value("Description")
		      End If
		      If Dict.HasKey("Public") Then
		        Doc.IsPublic = Dict.Value("Public")
		      End If
		      If Dict.HasKey("Map") Then
		        Doc.mMapCompatibility = Dict.Value("Map")
		      ElseIf Dict.HasKey("MapPreference") Then
		        Doc.mMapCompatibility = Dict.Value("MapPreference")
		      Else
		        Doc.mMapCompatibility = 0
		      End If
		      Dim DifficultyConfig As New BeaconConfigs.Difficulty
		      If Dict.HasKey("DifficultyValue") Then
		        DifficultyConfig.MaxDinoLevel = Dict.Value("DifficultyValue") * 30
		      End If
		      Doc.AddConfigGroup(DifficultyConfig)
		      If Dict.HasKey("ConsoleModsOnly") Then
		        Dim ConsoleModsOnly As Boolean = Dict.Value("ConsoleModsOnly")
		        If ConsoleModsOnly Then
		          Doc.mMods = Beacon.Data.ConsoleSafeMods()
		        End If
		      End If
		      If Dict.HasKey("Secure") Then
		        Dim SecureDict As Xojo.Core.Dictionary = ReadSecureData(Dict.Value("Secure"), Identity)
		        If SecureDict <> Nil Then
		          Doc.mLastSecureDict = Dict.Value("Secure")
		          Doc.mLastSecureHash = Doc.mLastSecureDict.Value("Hash")
		          
		          Dim ServerDicts() As Auto = SecureDict.Value("Servers")
		          For Each ServerDict As Xojo.Core.Dictionary In ServerDicts
		            Dim Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromDictionary(ServerDict)
		            If Profile <> Nil Then
		              Doc.mServerProfiles.Append(Profile)
		            End If
		          Next
		          
		          If SecureDict.HasKey("OAuth") Then
		            Doc.mOAuthDicts = SecureDict.Value("OAuth")
		          End If
		        End If
		      ElseIf Dict.HasKey("FTPServers") Then
		        Dim ServerDicts() As Auto = Dict.Value("FTPServers")
		        For Each ServerDict As Xojo.Core.Dictionary In ServerDicts
		          Dim FTPInfo As Xojo.Core.Dictionary = ReadSecureData(ServerDict, Identity, True)
		          If FTPInfo <> Nil And FTPInfo.HasAllKeys("Description", "Host", "Port", "User", "Pass", "Path") Then
		            Dim Profile As New Beacon.FTPServerProfile
		            Profile.Name = FTPInfo.Value("Description")
		            Profile.Host = FTPInfo.Value("Host")
		            Profile.Port = FTPInfo.Value("Port")
		            Profile.Username = FTPInfo.Value("User")
		            Profile.Password = FTPInfo.Value("Pass")
		            
		            Dim Path As Text = FTPInfo.Value("Path")
		            Dim Components() As Text = Path.Split("/")
		            If Components.Ubound > -1 Then
		              Dim LastComponent As Text = Components(Components.Ubound)
		              If LastComponent.Length > 4 And LastComponent.Right(4) = ".ini" Then
		                Components.Remove(Components.Ubound)
		              End If
		            End If
		            Components.Append("Game.ini")
		            Profile.GameIniPath = Components.Join("/")
		            
		            Components(Components.Ubound) = "GameUserSettings.ini"
		            Profile.GameUserSettingsIniPath = Components.Join("/")
		            
		            Doc.mServerProfiles.Append(Profile)
		          End If
		        Next
		      End If
		    Catch Err As RuntimeException
		      // Likely a KeyNotFoundException or TypeMismatchException, either way, we can't handle it
		      Return Nil
		    End Try
		  ElseIf Info.FullName = "Auto()" Then
		    // Old style document
		    LootSources = Parsed
		  Else
		    // What on earth is this?
		    Return Nil
		  End If
		  
		  Dim Presets() As Beacon.Preset
		  If Version < 2 Then
		    // Will need this in a few lines
		    Presets = Beacon.Data.Presets
		  End If
		  If LootSources.Ubound > -1 Then
		    Dim Drops As New BeaconConfigs.LootDrops
		    For Each LootSource As Xojo.Core.Dictionary In LootSources
		      Dim Source As Beacon.LootSource = Beacon.LootSource.ImportFromBeacon(LootSource)
		      If Source <> Nil Then
		        If Version < 2 Then
		          // Match item set names to presets
		          For Each Set As Beacon.ItemSet In Source
		            For Each Preset As Beacon.Preset In Presets
		              If Set.Label = Preset.Label Then
		                // Here's a hack to make assigning a preset possible: save current entries
		                Dim Entries() As Beacon.SetEntry
		                For Each Entry As Beacon.SetEntry In Set
		                  Entries.Append(New Beacon.SetEntry(Entry))
		                Next
		                
		                // Reconfigure
		                Call Set.ReconfigureWithPreset(Preset, Source, Beacon.Maps.TheIsland.Mask, Doc.Mods)
		                
		                // Now "deconfigure" it
		                Redim Set(Entries.Ubound)
		                For I As Integer = 0 To Entries.Ubound
		                  Set(I) = Entries(I)
		                Next
		                Continue For Set
		              End If
		            Next
		          Next
		        End If
		        Drops.Append(Source)
		      End If
		    Next
		    Doc.AddConfigGroup(Drops)
		  End If
		  
		  Doc.mModified = Version < Beacon.Document.DocumentVersion
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(GroupName As Text) As Boolean
		  Return Self.mConfigGroups.HasKey(GroupName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasLootSource(LootSource As Beacon.LootSource) As Boolean
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    Return Drops.IndexOf(LootSource) > -1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs() As Beacon.ConfigGroup()
		  Dim Groups() As Beacon.ConfigGroup
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mConfigGroups
		    Groups.Append(Entry.Value)
		  Next
		  Return Groups
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  If Self.mMapCompatibility = 0 Then
		    Return False
		  End If
		  If Self.DifficultyValue = -1 Then
		    Return False
		  End If
		  
		  Dim Configs() As Beacon.ConfigGroup = Self.ImplementedConfigs()
		  For Each Config As Beacon.ConfigGroup In Configs
		    Dim Issues() As Beacon.Issue = Config.Issues(Self)
		    If Issues <> Nil And Issues.Ubound > -1 Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "Document.IsValid()" )  Function IsValid(Document As Beacon.Document) As Boolean
		  If Document <> Self Then
		    Raise New UnsupportedOperationException
		  End If
		  
		  Return Self.IsValid()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function LastSaved() As Global.Date
		  Return Self.mLastSavedLegacy
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Function LastSaved() As Xojo.Core.Date
		  Return Self.mLastSaved
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSource(Index As Integer) As Beacon.LootSource
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    Return Drops(Index)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSourceCount() As UInteger
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    Return Drops.UBound + 1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LootSources() As Beacon.LootSourceCollection
		  Dim Results As New Beacon.LootSourceCollection
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    For Each LootSource As Beacon.LootSource In Drops
		      Results.Append(LootSource)
		    Next
		  End If
		  Return Results
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
		  Static GroupName As Text = BeaconConfigs.Metadata.ConfigName
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
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mConfigGroups
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
		    For Each Entry As Xojo.Core.DictionaryEntry In Self.mConfigGroups
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
		Function Mods() As Beacon.TextList
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
		Function OAuthData(Provider As Text) As Xojo.Core.Dictionary
		  If Self.mOAuthDicts <> Nil And Self.mOAuthDicts.HasKey(Provider) Then
		    Return Beacon.Clone(Self.mOAuthDicts.Value(Provider))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OAuthData(Provider As Text, Assigns Dict As Xojo.Core.Dictionary)
		  If Self.mOAuthDicts = Nil Then
		    Self.mOAuthDicts = New Xojo.Core.Dictionary
		  End If
		  If Dict = Nil Then
		    If Self.mOAuthDicts.HasKey(Provider) Then
		      Self.mOAuthDicts.Remove(Provider)
		      Self.mModified = True
		    End If
		  Else
		    If Self.mOAuthDicts.HasKey(Provider) Then
		      // Need to compare
		      Dim OldJSON As Text = Xojo.Data.GenerateJSON(Self.mOAuthDicts.Value(Provider))
		      Dim NewJSON As Text = Xojo.Data.GenerateJSON(Dict)
		      If OldJSON = NewJSON Then
		        Return
		      End If
		    End If
		    
		    Self.mOAuthDicts.Value(Provider) = Beacon.Clone(Dict)  
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
		Private Shared Function ReadSecureData(SecureDict As Xojo.Core.Dictionary, Identity As Beacon.Identity, SkipHashVerification As Boolean = False) As Xojo.Core.Dictionary
		  If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		    Return Nil
		  End If
		  
		  Dim Key As Xojo.Core.MemoryBlock = Identity.Decrypt(Beacon.DecodeHex(SecureDict.Value("Key")))
		  If Key = Nil Then
		    Return Nil
		  End If
		  
		  Dim ExpectedHash As Text = SecureDict.Lookup("Hash", "")
		  Dim Vector As Xojo.Core.MemoryBlock = Beacon.DecodeHex(SecureDict.Value("Vector"))
		  Dim Encrypted As Xojo.Core.MemoryBlock = Beacon.DecodeHex(SecureDict.Value("Content"))
		  Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		  AES.SetKey(CType(Key.Data, MemoryBlock).StringValue(0, Key.Size))
		  AES.SetInitialVector(CType(Vector.Data, MemoryBlock).StringValue(0, Vector.Size))
		  
		  Dim Decrypted As String
		  Try
		    Decrypted = AES.DecryptCBC(CType(Encrypted.Data, MemoryBlock).StringValue(0, Encrypted.Size))
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If SkipHashVerification = False Then
		    Dim ComputedHash As Text = Beacon.Hash(Decrypted)
		    If ComputedHash <> ExpectedHash Then
		      Return Nil
		    End If
		  End If
		  
		  If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		    Return Nil
		  End If
		  Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		  
		  Dim DecryptedDict As Xojo.Core.Dictionary
		  Try
		    DecryptedDict = Xojo.Data.ParseJSON(Decrypted.ToText)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  Return DecryptedDict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReconfigurePresets() As UInteger
		  If Self.mMapCompatibility = 0 Then
		    Return 0
		  End If
		  
		  Dim NumChanged As UInteger
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    For Each Source As Beacon.LootSource In Drops
		      NumChanged = NumChanged + Source.ReconfigurePresets(Self.mMapCompatibility, Self.Mods)
		    Next
		  End If
		  Return NumChanged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(LootSource As Beacon.LootSource)
		  Dim Drops As BeaconConfigs.LootDrops = Self.Drops
		  If Drops <> Nil Then
		    Self.Drops.Remove(LootSource)
		  End If
		End Sub
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
		Sub RemoveConfigGroup(GroupName As Text)
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
		Function SupportsLootSource(Source As Beacon.LootSource) As Boolean
		  Return (Source.Availability And Self.mMapCompatibility) > 0
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
		Function ToDictionary(Identity As Beacon.Identity) As Xojo.Core.Dictionary
		  Dim Document As New Xojo.Core.Dictionary
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.DocumentID
		  
		  Dim ModsList() As Text = Self.Mods
		  Document.Value("Mods") = ModsList
		  Document.Value("UseCompression") = Self.UseCompression
		  
		  Dim Locale As Xojo.Core.Locale = Xojo.Core.Locale.Raw
		  #if TargetiOS
		    Dim Now As New Xojo.Core.Date(Xojo.Core.Date.Now, New Xojo.Core.TimeZone(0))
		    Document.Value("Timestamp") = Now.Year.ToText(Locale, "0000") + "-" + Now.Month.ToText(Locale, "00") + "-" + Now.Day.ToText(Locale, "00") + " " + Now.Hour.ToText(Locale, "00") + ":" + Now.Minute.ToText(Locale, "00") + ":" + Now.Second.ToText(Locale, "00")
		  #else
		    Dim Now As New Global.Date
		    Now.GMTOffset = 0
		    Document.Value("Timestamp") = Now.Year.ToText(Locale, "0000") + "-" + Now.Month.ToText(Locale, "00") + "-" + Now.Day.ToText(Locale, "00") + " " + Now.Hour.ToText(Locale, "00") + ":" + Now.Minute.ToText(Locale, "00") + ":" + Now.Second.ToText(Locale, "00")
		  #endif
		  
		  Dim Groups As New Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mConfigGroups
		    Dim Group As Beacon.ConfigGroup = Entry.Value
		    Dim GroupData As Xojo.Core.Dictionary = Group.ToDictionary(Identity)
		    If GroupData = Nil Then
		      GroupData = New Xojo.Core.Dictionary
		    End If
		    
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Group)
		    Groups.Value(Info.Name) = GroupData
		  Next
		  Document.Value("Configs") = Groups
		  
		  If Self.mMapCompatibility > 0 Then
		    Document.Value("Map") = Self.mMapCompatibility
		  End If
		  
		  Dim EncryptedData As New Xojo.Core.Dictionary
		  Dim Profiles() As Xojo.Core.Dictionary
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    Profiles.Append(Profile.ToDictionary)
		  Next
		  EncryptedData.Value("Servers") = Profiles
		  If Self.mOAuthDicts <> Nil Then
		    EncryptedData.Value("OAuth") = Self.mOAuthDicts
		  End If
		  
		  Dim Content As Text = Xojo.Data.GenerateJSON(EncryptedData)
		  Dim Hash As Text = Beacon.Hash(Content)
		  If Hash <> Self.mLastSecureHash Then
		    Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		    Dim Key As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(128)
		    Dim Vector As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		    AES.SetKey(CType(Key.Data, MemoryBlock).StringValue(0, Key.Size))
		    AES.SetInitialVector(CType(Vector.Data, MemoryBlock).StringValue(0, Vector.Size))
		    Dim Encrypted As Global.MemoryBlock = AES.EncryptCBC(Content)
		    
		    Dim SecureDict As New Xojo.Core.Dictionary
		    SecureDict.Value("Key") = Beacon.EncodeHex(Identity.Encrypt(Key))
		    SecureDict.Value("Vector") = Beacon.EncodeHex(Vector)
		    SecureDict.Value("Content") = Beacon.EncodeHex(Encrypted)
		    SecureDict.Value("Hash") = Hash
		    
		    Self.mLastSecureHash = Hash
		    Self.mLastSecureDict = SecureDict
		  End If
		  Document.Value("Secure") = Beacon.Clone(Self.mLastSecureDict)
		  
		  Return Document
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
		Description As Text
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
		Private mConfigGroups As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As Text
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target32Bit or Target64Bit))
		Private mLastSaved As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mLastSavedLegacy As Global.Date
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureDict As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureHash As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapCompatibility As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Beacon.TextList
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOAuthDicts As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerProfiles() As Beacon.ServerProfile
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
		Title As Text
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
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DifficultyValue"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsPublic"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MapCompatibility"
			Group="Behavior"
			Type="UInt64"
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
			Name="Title"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseCompression"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
