#tag Class
Protected Class Document
Implements ObservationKit.Observable
	#tag Method, Flags = &h0
		Function Accounts() As Beacon.ExternalAccountManager
		  Return Self.mAccounts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Profile As Beacon.ServerProfile)
		  If Profile = Nil Then
		    Return
		  End If
		  
		  For I As Integer = 0 To Self.mServerProfiles.LastRowIndex
		    If Self.mServerProfiles(I) = Profile Then
		      Self.mServerProfiles(I) = Profile.Clone
		      Self.mModified = True
		      Return
		    End If
		  Next
		  
		  Self.mServerProfiles.AddRow(Profile.Clone)
		  If Profile.IsConsole Then
		    Self.ConsoleMode = True
		    
		    For Each Entry As DictionaryEntry In Self.mMods
		      Var ModInfo As Beacon.ModDetails = Beacon.Data.ModWithID(Entry.Key.StringValue)
		      If (ModInfo Is Nil Or ModInfo.ConsoleSafe = False) And Self.mMods.Value(Entry.Key).BooleanValue = True Then
		        Self.mMods.Value(Entry.Key) = False
		        Self.mModified = True
		        Self.mModChangeTimestamp = System.Microseconds
		      End If
		    Next
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
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Key = "Title" Or Key = "Description" Then
		    Self.Metadata(True).AddObserver(Observer, Key)
		    Return
		  End If
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.AddRow(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddUser(UserID As String, PublicKey As String)
		  Self.mEncryptedPasswords.Value(UserID.Lowercase) = EncodeBase64(Crypto.RSAEncrypt(Self.mDocumentPassword, PublicKey), 0)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(GroupName As String, Create As Boolean = False) As Beacon.ConfigGroup
		  If Self.mConfigGroups.HasKey(GroupName) Then
		    Return Self.mConfigGroups.Value(GroupName)
		  End If
		  
		  If Create Then
		    Var Group As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(GroupName)
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
		  Self.mIdentifier = New v4UUID
		  Self.mMapCompatibility = Beacon.Maps.TheIsland.Mask
		  Self.mConfigGroups = New Dictionary
		  Self.AddConfigGroup(New BeaconConfigs.Difficulty)
		  Self.Difficulty.IsImplicit = True
		  Self.mModified = False
		  Self.UseCompression = True
		  Self.mDocumentPassword = Crypto.GenerateRandomBytes(32)
		  Self.mEncryptedPasswords = New Dictionary
		  Self.mAccounts = New Beacon.ExternalAccountManager
		  
		  Self.mMods = New Dictionary
		  Var AllMods() As Beacon.ModDetails = Beacon.Data.AllMods
		  For Each ModInfo As Beacon.ModDetails In AllMods
		    Self.mMods.Value(ModInfo.ModID) = ModInfo.DefaultEnabled
		  Next
		  Self.mModChangeTimestamp = System.Microseconds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertDinoReplacementsToSpawnOverrides() As Integer
		  If Self.HasConfigGroup(BeaconConfigs.DinoAdjustments.ConfigName) = False Then
		    Return 0
		  End If
		  
		  Var DinoConfig As BeaconConfigs.DinoAdjustments = BeaconConfigs.DinoAdjustments(Self.ConfigGroup(BeaconConfigs.DinoAdjustments.ConfigName))
		  If DinoConfig = Nil Then
		    Return 0
		  End If
		  
		  Var SpawnConfig As BeaconConfigs.SpawnPoints // Don't create it yet
		  
		  Var CountChanges As Integer
		  Var Behaviors() As Beacon.CreatureBehavior = DinoConfig.All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Var ReplacedCreature As Beacon.Creature = Behavior.TargetCreature
		    Var ReplacementCreature As Beacon.Creature = Behavior.ReplacementCreature
		    If ReplacementCreature = Nil Then
		      Continue
		    End If
		    
		    Var ConfigUpdated As Boolean
		    Var SpawnPoints() As Beacon.SpawnPoint = Beacon.Data.GetSpawnPointsForCreature(ReplacedCreature, Self.Mods, "")
		    For Each SpawnPoint As Beacon.SpawnPoint In SpawnPoints
		      Var Limit As Double = SpawnPoint.Limit(ReplacedCreature)
		      Var NewSets() As Beacon.SpawnPointSet
		      For Each Set As Beacon.SpawnPointSet In SpawnPoint
		        Var NewSet As Beacon.MutableSpawnPointSet
		        For Each Entry As Beacon.SpawnPointSetEntry In Set
		          If Entry.Creature = ReplacedCreature Then
		            If NewSet = Nil Then
		              NewSet = New Beacon.MutableSpawnPointSet()
		              NewSet.Weight = Set.Weight
		              NewSet.Label = ReplacementCreature.Label
		              If IsNull(Set.SpreadRadius) Then
		                NewSet.SpreadRadius = 650
		              Else
		                NewSet.SpreadRadius = Set.SpreadRadius
		              End If
		            End If
		            
		            Const SpreadMultiplierHigh = 1.046153846
		            Const SpreadMultiplierLow = 0.523076923
		            
		            Var NewEntry As Beacon.MutableSpawnPointSetEntry
		            
		            NewEntry = New Beacon.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.7
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Beacon.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 1.0
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierHigh), 0.0)
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Beacon.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.2
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierLow), 0.0)
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Beacon.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.25
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierLow) * -1, 0.0)
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Beacon.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.6
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierHigh) * -1, 0.0)
		            NewSet.Append(NewEntry)
		          End If
		        Next
		        If NewSet <> Nil Then
		          NewSets.AddRow(NewSet)
		        End If
		      Next
		      
		      If NewSets.Count > 0 Then
		        If SpawnConfig = Nil Then
		          SpawnConfig = BeaconConfigs.SpawnPoints(Self.ConfigGroup(BeaconConfigs.SpawnPoints.ConfigName, True))
		        End If
		        
		        Var Override As Beacon.SpawnPoint = SpawnConfig.GetSpawnPoint(SpawnPoint.Path, Beacon.SpawnPoint.ModeAppend)
		        If Override = Nil Then
		          Override = SpawnConfig.GetSpawnPoint(SpawnPoint.Path, Beacon.SpawnPoint.ModeOverride)
		        End If
		        If Override = Nil Then
		          Override = New Beacon.MutableSpawnPoint(SpawnPoint)
		          Beacon.MutableSpawnPoint(Override).ResizeTo(-1)
		          Beacon.MutableSpawnPoint(Override).LimitsString = "{}"
		          Beacon.MutableSpawnPoint(Override).Mode = Beacon.SpawnPoint.ModeAppend
		        End If
		        
		        Var Mutable As Beacon.MutableSpawnPoint = Override.MutableVersion
		        Mutable.Limit(ReplacementCreature) = Limit
		        For Each Set As Beacon.SpawnPointSet In NewSets
		          Mutable.AddSet(Set)
		        Next
		        
		        SpawnConfig.Add(Mutable)
		        ConfigUpdated = True
		      End If
		    Next
		    
		    If ConfigUpdated Then
		      CountChanges = CountChanges + 1
		      
		      Var NewBehavior As New Beacon.MutableCreatureBehavior(Behavior)
		      NewBehavior.ProhibitSpawning = True
		      NewBehavior.ReplacementCreature = Nil
		      DinoConfig.RemoveBehavior(ReplacedCreature)
		      DinoConfig.Add(NewBehavior)
		    End If
		  Next
		  
		  Return CountChanges
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(Data As String) As String
		  Return BeaconEncryption.SymmetricDecrypt(Self.mDocumentPassword, DecodeBase64(Data))
		End Function
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
		Function Encrypt(Data As String) As String
		  Return EncodeBase64(BeaconEncryption.SymmetricEncrypt(Self.mDocumentPassword, Data), 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FromLegacy(Parsed As Variant, Identity As Beacon.Identity) As Beacon.Document
		  Var Doc As new Beacon.Document
		  Var LootSources() As Variant
		  Var Version As Integer
		  
		  If Parsed.Type = Variant.TypeObject And Parsed.ObjectValue IsA Dictionary Then
		    Var Dict As Dictionary = Parsed
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
		      If Dict.HasKey("Map") Then
		        Doc.mMapCompatibility = Dict.Value("Map")
		      ElseIf Dict.HasKey("MapPreference") Then
		        Doc.mMapCompatibility = Dict.Value("MapPreference")
		      Else
		        Doc.mMapCompatibility = 0
		      End If
		      Var DifficultyConfig As New BeaconConfigs.Difficulty
		      If Dict.HasKey("DifficultyValue") Then
		        DifficultyConfig.MaxDinoLevel = Dict.Value("DifficultyValue") * 30
		      End If
		      Doc.AddConfigGroup(DifficultyConfig)
		      If Dict.HasKey("ConsoleModsOnly") Then
		        Var ConsoleModsOnly As Boolean = Dict.Value("ConsoleModsOnly")
		        If ConsoleModsOnly Then
		          Var Selections As New Dictionary
		          Var AllMods() As Beacon.ModDetails = Beacon.Data.AllMods
		          For Each ModInfo As Beacon.ModDetails In AllMods
		            Selections.Value(ModInfo.ModID) = ModInfo.DefaultEnabled And ModInfo.ConsoleSafe
		          Next
		          
		          Doc.mConsoleMode = True
		          Doc.mMods = Selections
		          Doc.mModChangeTimestamp = System.Microseconds
		        End If
		      End If
		      
		      If Dict.HasKey("Secure") Then
		        Var SecureDict As Dictionary = ReadSecureData(Dict.Value("Secure"), Identity)
		        If SecureDict <> Nil Then
		          If SecureDict.HasKey("OAuth") Then
		            Var AccountManager As Beacon.ExternalAccountManager = Beacon.ExternalAccountManager.FromLegacyDict(SecureDict.Value("OAuth"))
		            If IsNull(AccountManager) = False Then
		              Doc.mAccounts = AccountManager
		            End If
		          End If
		          
		          Var ServerDicts() As Variant = SecureDict.Value("Servers")
		          LoadServerProfiles(Doc, ServerDicts)
		        End If
		      ElseIf Dict.HasKey("FTPServers") Then
		        Var ServerDicts() As Variant = Dict.Value("FTPServers")
		        For Each ServerDict As Dictionary In ServerDicts
		          Var FTPInfo As Dictionary = ReadSecureData(ServerDict, Identity, True)
		          If FTPInfo <> Nil And FTPInfo.HasAllKeys("Description", "Host", "Port", "User", "Pass", "Path") Then
		            Var Profile As New Beacon.FTPServerProfile
		            Profile.Name = FTPInfo.Value("Description")
		            Profile.Host = FTPInfo.Value("Host")
		            Profile.Port = FTPInfo.Value("Port")
		            Profile.Username = FTPInfo.Value("User")
		            Profile.Password = FTPInfo.Value("Pass")
		            
		            Var Path As String = FTPInfo.Value("Path")
		            Var Components() As String = Path.Split("/")
		            If Components.LastRowIndex > -1 Then
		              Var LastComponent As String = Components(Components.LastRowIndex)
		              If LastComponent.Length > 4 And LastComponent.Right(4) = ".ini" Then
		                Components.RemoveRowAt(Components.LastRowIndex)
		              End If
		            End If
		            Components.AddRow("Game.ini")
		            Profile.GameIniPath = Components.Join("/")
		            
		            Components(Components.LastRowIndex) = "GameUserSettings.ini"
		            Profile.GameUserSettingsIniPath = Components.Join("/")
		            
		            Doc.mServerProfiles.AddRow(Profile)
		          End If
		        Next
		      End If
		    Catch Err As RuntimeException
		      Return Nil
		    End Try
		  ElseIf Parsed.IsArray And Parsed.ArrayElementType = Variant.TypeObject Then
		    LootSources = Parsed
		  Else
		    Return Nil
		  End If
		  
		  Var Presets() As Beacon.Preset
		  If Version < 2 Then
		    // Will need this in a few lines
		    Presets = Beacon.Data.Presets
		  End If
		  If LootSources.LastRowIndex > -1 Then
		    Var Drops As New BeaconConfigs.LootDrops
		    For Each LootSource As Dictionary In LootSources
		      Var Source As Beacon.LootSource = Beacon.LoadLootSourceSaveData(LootSource)
		      If Source <> Nil Then
		        If Version < 2 Then
		          // Match item set names to presets
		          For Each Set As Beacon.ItemSet In Source.ItemSets
		            For Each Preset As Beacon.Preset In Presets
		              If Set.Label = Preset.Label Then
		                // Here's a hack to make assigning a preset possible: save current entries
		                Var Entries() As Beacon.SetEntry
		                For Each Entry As Beacon.SetEntry In Set
		                  Entries.AddRow(New Beacon.SetEntry(Entry))
		                Next
		                
		                // Reconfigure
		                Call Set.ReconfigureWithPreset(Preset, Source, Beacon.Maps.TheIsland.Mask, Doc.Mods)
		                
		                // Now "deconfigure" it
		                Set.ResizeTo(Entries.LastRowIndex)
		                For I As Integer = 0 To Entries.LastRowIndex
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
		Shared Function FromString(Contents As String, Identity As Beacon.Identity) As Beacon.Document
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Contents)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  Var Doc As New Beacon.Document
		  Var Version As Integer = 1
		  Var Dict As Dictionary
		  If Parsed IsA Dictionary Then
		    Dict = Parsed
		    Version = Dict.Lookup("Version", 0)
		    If Dict.HasKey("Identifier") Then
		      Doc.mIdentifier = Dict.Value("Identifier")
		    Else
		      Doc.mIdentifier = New v4UUID
		    End If
		  End If
		  If Version < 3 Then
		    Return Beacon.Document.FromLegacy(Parsed, Identity)
		  End If
		  
		  If Version >= 4 And Dict.HasKey("EncryptionKeys") And Dict.Value("EncryptionKeys") IsA Dictionary Then
		    Var PossibleIdentities(0) As Beacon.Identity
		    PossibleIdentities(0) = Identity
		    
		    Var Passwords As Dictionary = Dict.Value("EncryptionKeys")
		    For Each Entry As DictionaryEntry In Passwords
		      Var UserID As String = Entry.Key
		      If UserID = Identity.Identifier Then
		        Continue
		      End If
		      
		      Var MergedIdentity As Beacon.Identity = IdentityManager.FindMergedIdentity(UserID)
		      If MergedIdentity <> Nil Then
		        PossibleIdentities.AddRow(MergedIdentity)
		      End If
		    Next
		    
		    For Each PossibleIdentity As Beacon.Identity In PossibleIdentities
		      If Passwords.HasKey(PossibleIdentity.Identifier.Lowercase) = False Then
		        Continue
		      End If
		      
		      Try
		        Var DocumentPassword As String = Crypto.RSADecrypt(DecodeBase64(Passwords.Value(PossibleIdentity.Identifier.Lowercase)), PossibleIdentity.PrivateKey)
		        Doc.mDocumentPassword = DocumentPassword
		        Doc.mEncryptedPasswords = Passwords
		        
		        If Passwords.HasKey(Identity.Identifier.Lowercase) = False Then
		          // Add a password for the current user
		          Doc.AddUser(Identity.Identifier, Identity.PublicKey)
		        End If
		        
		        Exit
		      Catch Err As RuntimeException
		        // Leave the encryption fresh
		        Break
		      End Try
		    Next
		  End If
		  
		  // New config system
		  If Dict.HasKey("Configs") Then
		    Var Groups As Dictionary = Dict.Value("Configs")
		    For Each Entry As DictionaryEntry In Groups
		      Try
		        Var GroupName As String = Entry.Key
		        Var GroupData As Dictionary = Entry.Value
		        Var Instance As Beacon.ConfigGroup = BeaconConfigs.CreateInstance(GroupName, GroupData, Identity, Doc)
		        If Instance <> Nil Then
		          Doc.mConfigGroups.Value(GroupName) = Instance
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
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
		  
		  Var SecureDict As Dictionary
		  If Dict.HasKey("EncryptedData") Then
		    Try
		      Doc.mLastSecureData = Dict.Value("EncryptedData")
		      Var Decrypted As String = Doc.Decrypt(Doc.mLastSecureData)
		      Doc.mLastSecureHash = Beacon.Hash(Decrypted)
		      SecureDict = Beacon.ParseJSON(Decrypted)
		    Catch Err As RuntimeException
		      // No secure data
		    End Try
		  ElseIf Dict.HasKey("Secure") Then
		    SecureDict = ReadSecureData(Dict.Value("Secure"), Identity)
		  End If
		  If SecureDict <> Nil Then
		    Var AccountManager As Beacon.ExternalAccountManager
		    Try
		      If SecureDict.HasKey("ExternalAccounts") Then
		        AccountManager = Beacon.ExternalAccountManager.FromDict(SecureDict.Value("ExternalAccounts"))
		      ElseIf SecureDict.HasKey("OAuth") Then
		        AccountManager = Beacon.ExternalAccountManager.FromLegacyDict(SecureDict.Value("OAuth"))
		      End If
		    Catch Err As RuntimeException
		    End Try
		    If IsNull(AccountManager) = False Then
		      Doc.mAccounts = AccountManager
		    End If
		    
		    Var ServerDicts() As Variant = SecureDict.Value("Servers")
		    LoadServerProfiles(Doc, ServerDicts)
		  End If
		  
		  If Dict.HasKey("IsConsole") Then
		    Doc.mConsoleMode = Dict.Value("IsConsole").BooleanValue
		  Else
		    For Each Profile As Beacon.ServerProfile In Doc.mServerProfiles
		      If Profile.IsConsole Then
		        Doc.mConsoleMode = True
		        Exit
		      End If
		    Next
		  End If
		  
		  If Dict.HasKey("ModSelections") Then
		    Var AllMods() As Beacon.ModDetails = Beacon.Data.AllMods
		    Var Selections As Dictionary = Dict.Value("ModSelections")
		    For Each Details As Beacon.ModDetails In AllMods
		      If Selections.HasKey(Details.ModID) = False Then
		        Selections.Value(Details.ModID) = Details.DefaultEnabled And (Details.ConsoleSafe Or Doc.mConsoleMode = False)
		      End If
		    Next
		    
		    Doc.mMods = Selections
		    Doc.mModChangeTimestamp = System.Microseconds
		  ElseIf Dict.HasKey("Mods") Then
		    // In this mode, an empty list meant "all on" and populated list mean "only enable these."
		    
		    Var AllMods() As Beacon.ModDetails = Beacon.Data.AllMods
		    Var SelectedMods As Beacon.StringList = Beacon.StringList.FromVariant(Dict.Value("Mods"))
		    Var Selections As New Dictionary
		    For Each Details As Beacon.ModDetails In AllMods
		      Selections.Value(Details.ModID) = (Details.ConsoleSafe Or Doc.mConsoleMode = False) And (SelectedMods.Count = 0 Or SelectedMods.IndexOf(Details.ModID) > -1)
		    Next
		    
		    Doc.mMods = Selections
		    Doc.mModChangeTimestamp = System.Microseconds
		  ElseIf Dict.HasKey("ConsoleModsOnly") Then
		    Var ConsoleModsOnly As Boolean = Dict.Value("ConsoleModsOnly")
		    If ConsoleModsOnly Then
		      Var Selections As New Dictionary
		      Var AllMods() As Beacon.ModDetails = Beacon.Data.AllMods
		      For Each ModInfo As Beacon.ModDetails In AllMods
		        Selections.Value(ModInfo.ModID) = ModInfo.DefaultEnabled And ModInfo.ConsoleSafe
		      Next
		      
		      Doc.mConsoleMode = True
		      Doc.mMods = Selections
		      Doc.mModChangeTimestamp = System.Microseconds
		    End If
		  End If
		  
		  If Dict.HasKey("Trust") Then
		    Doc.mTrustKey = Dict.Value("Trust")
		  End If
		  
		  If Dict.HasKey("AllowUCS") Then
		    Doc.mAllowUCS = Dict.Value("AllowUCS")
		  End If
		  
		  If Dict.HasKey("Timestamp") Then
		    Doc.mLastSaved = NewDateFromSQLDateTime(Dict.Value("Timestamp"))
		  End If
		  
		  Doc.Modified = Version < Beacon.Document.DocumentVersion
		  
		  Return Doc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUsers() As String()
		  Var Users() As String
		  For Each Entry As DictionaryEntry In Self.mEncryptedPasswords
		    Users.AddRow(Entry.Key)
		  Next
		  Return Users
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(GroupName As String) As Boolean
		  Return Self.mConfigGroups.HasKey(GroupName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasUser(UserID As String) As Boolean
		  Return Self.mEncryptedPasswords.HasKey(UserID.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs() As Beacon.ConfigGroup()
		  Var Groups() As Beacon.ConfigGroup
		  For Each Entry As DictionaryEntry In Self.mConfigGroups
		    Groups.AddRow(Entry.Value)
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
		  
		  Var Configs() As Beacon.ConfigGroup = Self.ImplementedConfigs()
		  For Each Config As Beacon.ConfigGroup In Configs
		    Var Issues() As Beacon.Issue = Config.Issues(Self, Identity)
		    If Issues <> Nil And Issues.LastRowIndex > -1 Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function LastSaved() As DateTime
		  If Self.mLastSaved <> Nil Then
		    Return New DateTime(Self.mLastSaved.SecondsFrom1970, Self.mLastSaved.Timezone)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub LoadServerProfiles(Document As Beacon.Document, ServerDicts() As Variant)
		  Var NitradoAccount As Beacon.ExternalAccount
		  For Each ServerDict As Dictionary In ServerDicts
		    Var Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromDictionary(ServerDict)
		    If Profile <> Nil Then
		      If Profile IsA Beacon.NitradoServerProfile And Profile.ExternalAccountUUID = Nil Then
		        If IsNull(NitradoAccount) Then
		          Var NitradoAccounts() As Beacon.ExternalAccount = Document.mAccounts.ForProvider(Beacon.ExternalAccount.ProviderNitrado)
		          If NitradoAccounts.Count = 1 Then
		            NitradoAccount = NitradoAccounts(0)
		          End If
		        End If
		        If IsNull(NitradoAccount) = False Then
		          Profile.ExternalAccountUUID = NitradoAccount.UUID
		        End If
		      End If
		      
		      Document.mServerProfiles.AddRow(Profile)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Beacon.Map()
		  Var Possibles() As Beacon.Map = Beacon.Maps.All
		  Var Matches() As Beacon.Map
		  For Each Map As Beacon.Map In Possibles
		    If Map.Matches(Self.mMapCompatibility) Then
		      Matches.AddRow(Map)
		    End If
		  Next
		  Return Matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Metadata(Create As Boolean = False) As BeaconConfigs.Metadata
		  Static GroupName As String = BeaconConfigs.Metadata.ConfigName
		  Var Group As Beacon.ConfigGroup = Self.ConfigGroup(GroupName, Create)
		  If Group <> Nil Then
		    Return BeaconConfigs.Metadata(Group)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModEnabled(ModID As v4UUID) As Boolean
		  If ModID = Nil Then
		    Return False
		  End If
		  
		  Return Self.mMods.Lookup(ModID.StringValue, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModEnabled(ModID As v4UUID, Assigns Value As Boolean)
		  If ModID = Nil Then
		    Return
		  End If
		  
		  Var UUID As String = ModID
		  
		  If Self.mMods.HasKey(UUID) = False Or Self.mMods.Value(UUID).BooleanValue <> Value Then
		    Self.mMods.Value(UUID) = Value
		    Self.mModified = True
		    Self.mModChangeTimestamp = System.Microseconds
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  If Self.mAccounts.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mConfigGroups
		    Var Group As Beacon.ConfigGroup = Entry.Value
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
		      Var Group As Beacon.ConfigGroup = Entry.Value
		      Group.Modified = False
		    Next
		    
		    For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		      Profile.Modified = False
		    Next
		    
		    Self.mAccounts.Modified = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mods() As Beacon.StringList
		  Var List As New Beacon.StringList
		  For Each Entry As DictionaryEntry In Self.mMods
		    If Entry.Value.BooleanValue = True Then
		      List.Append(Entry.Key.StringValue)
		    End If
		  Next
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewIdentifier()
		  Self.mIdentifier = New v4UUID
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As String, Value As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Document) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mIdentifier.Compare(Other.mIdentifier, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private Shared Function ReadSecureData(SecureDict As Dictionary, Identity As Beacon.Identity, SkipHashVerification As Boolean = False) As Dictionary
		  If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		    Return Nil
		  End If
		  
		  Var Key As MemoryBlock = Identity.Decrypt(DecodeHex(SecureDict.Value("Key")))
		  If Key = Nil Then
		    Return Nil
		  End If
		  
		  Var ExpectedHash As String = SecureDict.Lookup("Hash", "")
		  Var Vector As MemoryBlock = DecodeHex(SecureDict.Value("Vector"))
		  Var Encrypted As MemoryBlock = DecodeHex(SecureDict.Value("Content"))
		  Var AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		  AES.SetKey(Key)
		  AES.SetInitialVector(Vector)
		  
		  Var Decrypted As String
		  Try
		    Decrypted = AES.DecryptCBC(Encrypted)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If SkipHashVerification = False Then
		    Var ComputedHash As String = Beacon.Hash(Decrypted)
		    If ComputedHash <> ExpectedHash Then
		      Return Nil
		    End If
		  End If
		  
		  If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		    Return Nil
		  End If
		  Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		  
		  Var DecryptedDict As Dictionary
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
		  For I As Integer = 0 To Self.mServerProfiles.LastRowIndex
		    If Self.mServerProfiles(I) = Profile Then
		      Self.mServerProfiles.RemoveRowAt(I)
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
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Key = "Title" Or Key = "Description" Then
		    Self.Metadata(True).RemoveObserver(Observer, Key)
		    Return
		  End If
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveUser(UserID As String)
		  UserID = UserID.Lowercase
		  If Self.mEncryptedPasswords.HasKey(UserID) Then
		    Self.mEncryptedPasswords.Remove(UserID)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceAccount(OldAccount As Beacon.ExternalAccount, NewAccount As Beacon.ExternalAccount)
		  If OldAccount = Nil Or NewAccount = Nil Then
		    Return
		  End If
		  
		  Self.ReplaceAccount(OldAccount.UUID, NewAccount)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceAccount(OldUUID As v4UUID, Account As Beacon.ExternalAccount)
		  If OldUUID = Nil Or Account Is Nil Then
		    Return
		  End If
		  
		  // These will all handle their own modification states
		  
		  If (Self.mAccounts.GetByUUID(OldUUID) Is Nil) = False Then
		    Self.mAccounts.Remove(OldUUID)
		  End If
		  If Self.mAccounts.GetByUUID(Account.UUID) Is Nil Then
		    Self.mAccounts.Add(Account)
		  End If
		  
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.ExternalAccountUUID = OldUUID Then
		      Profile.ExternalAccountUUID = Account.UUID
		    End If
		  Next
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
		  Return Self.mServerProfiles.LastRowIndex + 1
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
		  If Not Self.mEncryptedPasswords.HasKey(Identity.Identifier) Then
		    Self.AddUser(Identity.Identifier, Identity.PublicKey)
		  End If
		  
		  Var Document As New Dictionary
		  Document.Value("Version") = Self.DocumentVersion
		  Document.Value("Identifier") = Self.DocumentID
		  Document.Value("Trust") = Self.TrustKey
		  Document.Value("EncryptionKeys") = Self.mEncryptedPasswords
		  
		  Var ModsList() As String = Self.Mods
		  Document.Value("ModSelections") = Self.mMods
		  Document.Value("Mods") = ModsList
		  Document.Value("UseCompression") = Self.UseCompression
		  Document.Value("Timestamp") = DateTime.Now.SQLDateTimeWithOffset
		  Document.Value("AllowUCS") = Self.AllowUCS
		  Document.Value("IsConsole") = Self.ConsoleMode
		  
		  Var Groups As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mConfigGroups
		    Var Group As Beacon.ConfigGroup = Entry.Value
		    Var GroupData As Dictionary = Group.ToDictionary(Self)
		    If GroupData = Nil Then
		      GroupData = New Dictionary
		    End If
		    
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Group)
		    Groups.Value(Info.Name) = GroupData
		  Next
		  Document.Value("Configs") = Groups
		  
		  If Self.mMapCompatibility > 0 Then
		    Document.Value("Map") = Self.mMapCompatibility
		  End If
		  
		  Var EncryptedData As New Dictionary
		  Var Profiles() As Dictionary
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    Profiles.AddRow(Profile.ToDictionary)
		  Next
		  EncryptedData.Value("Servers") = Profiles
		  If Self.mAccounts.Count > 0 Then
		    EncryptedData.Value("ExternalAccounts") = Self.mAccounts.AsDictionary
		  End If
		  
		  Var Content As String = Beacon.GenerateJSON(EncryptedData, False)
		  Var Hash As String = Beacon.Hash(Content)
		  If Hash <> Self.mLastSecureHash Then
		    Self.mLastSecureData = Self.Encrypt(Content)
		    Self.mLastSecureHash = Hash
		  End If
		  Document.Value("EncryptedData") = Self.mLastSecureData
		  
		  Return Document
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesOmniFeaturesWithoutOmni(Identity As Beacon.Identity) As Beacon.ConfigGroup()
		  Var OmniVersion As Integer = Identity.OmniVersion
		  Var Configs() As Beacon.ConfigGroup = Self.ImplementedConfigs()
		  Var ExcludedConfigs() As Beacon.ConfigGroup
		  For Each Config As Beacon.ConfigGroup In Configs
		    If Config.Purchased(OmniVersion) = False Then
		      ExcludedConfigs.AddRow(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAllowUCS
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAllowUCS <> Value Then
			    Self.mAllowUCS = Value
			    Self.mModified = True
			  End If
			End Set
		#tag EndSetter
		AllowUCS As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mConsoleMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mConsoleMode <> Value Then
			    Self.mConsoleMode = Value
			    Self.mModified = True
			  End If
			End Set
		#tag EndSetter
		ConsoleMode As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var Metadata As BeaconConfigs.Metadata = Self.Metadata
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
			  Var Difficulty As BeaconConfigs.Difficulty = Self.Difficulty
			  If Difficulty <> Nil Then
			    Return Difficulty.DifficultyValue
			  Else
			    Return -1
			  End If
			End Get
		#tag EndGetter
		DifficultyValue As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAllowUCS As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMapCompatibility
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Limit As UInt64 = Beacon.Maps.All.Mask
			  Value = Value And Limit
			  If Self.mMapCompatibility <> Value Then
			    Var Maps() As Beacon.Map = Beacon.Maps.ForMask(Value)
			    For Each Map As Beacon.Map In Maps
			      If Self.mMods.Lookup(Map.ProvidedByModID, False).BooleanValue = False Then
			        Self.mMods.Value(Map.ProvidedByModID) = True
			        Self.mModChangeTimestamp = System.Microseconds
			      End If
			    Next
			    
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
		Private mConsoleMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocumentPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedPasswords As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentifier As String
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Private mLastSaved As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureData As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMapCompatibility As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModChangeTimestamp As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mModChangeTimestamp
			End Get
		#tag EndGetter
		ModChangeTimestamp As Double
	#tag EndComputedProperty

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
			  Var Metadata As BeaconConfigs.Metadata = Self.Metadata
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


	#tag Constant, Name = DocumentVersion, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Type="String"
			EditorType="MultiLineEditor"
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
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowUCS"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConsoleMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
