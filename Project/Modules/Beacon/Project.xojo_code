#tag Class
Protected Class Project
Implements ObservationKit.Observable
	#tag Method, Flags = &h0
		Attributes( Deprecated )  Function Accounts() As Beacon.ExternalAccountManager
		  Return Self.mAccounts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ActiveConfigSet() As Beacon.ConfigSet
		  Return Self.mActiveConfigSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ActiveConfigSet(Assigns Set As Beacon.ConfigSet)
		  If Set Is Nil Then
		    Set = Beacon.ConfigSet.BaseConfigSet
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Self.mActiveConfigSet = Beacon.ConfigSet.BaseConfigSet
		  Else
		    Self.mActiveConfigSet = Self.mConfigSets(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigSet(Set As Beacon.ConfigSet)
		  If Set Is Nil Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx > -1 Then
		    Return
		  End If
		  
		  If Self.HasConfigSet(Set.Name) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "There is already a config set named " + Set.Name + "."
		    Raise Err
		  End If
		  
		  Self.mConfigSets.Add(Set)
		  Self.mConfigSetData.Value(Set.ConfigSetId) = New Dictionary
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers Is Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.Add(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddServerProfile(Profile As Beacon.ServerProfile)
		  If Profile Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    If Self.mServerProfiles(Idx).ProfileID = Profile.ProfileID Then
		      Self.mServerProfiles(Idx) = Profile // They might compare to the same UUID, but could be different objects.
		      If Profile.Modified Then
		        Self.Modified = True
		      End If
		      Return
		    End If
		  Next
		  
		  RaiseEvent AddingProfile(Profile)
		  
		  Self.mServerProfiles.Add(Profile)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddUser(UserID As String, PublicKey As String)
		  Self.mEncryptedPasswords.Value(UserID.Lowercase) = EncodeBase64(Crypto.RSAEncrypt(Self.mProjectPassword, PublicKey), 0)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity) As Beacon.Project
		  // Yes, run this through JSON first to ensure parsing is exactly as compatible as coming from the
		  // disk or cloud. The object types put into the dictionary are not always the same as comes back
		  // in the parsed JSON.
		  
		  Try
		    Var SaveData As MemoryBlock = Self.SaveData(Identity)
		    Return FromSaveData(SaveData, Identity)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetCount() As Integer
		  Return Self.mConfigSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigSetData(Set As Beacon.ConfigSet) As Dictionary
		  If Set Is Nil Then
		    Set = Self.ActiveConfigSet
		  End If
		  
		  If Self.mConfigSetData.HasKey(Set.ConfigSetId) = False Then
		    Self.mConfigSetData.Value(Set.ConfigSetId) = New Dictionary
		    Self.Modified = True
		  End If
		  
		  Return Self.mConfigSetData.Value(Set.ConfigSetId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ConfigSetData(Set As Beacon.ConfigSet, Assigns Dict As Dictionary)
		  If Set Is Nil Then
		    Set = Self.ActiveConfigSet
		  End If
		  
		  // Nil dict should remove the config set
		  If Dict Is Nil Then
		    If Self.mConfigSetData.HasKey(Set.ConfigSetId) Then
		      Self.mConfigSetData.Remove(Set.ConfigSetId)
		    End If
		    
		    Var Idx As Integer = Self.IndexOf(Set)
		    If Idx > -1 Then
		      Self.mConfigSets.RemoveAt(Idx)
		    End If
		    
		    For Idx = 0 To Self.mConfigSetPriorities.LastIndex
		      If Self.mConfigSetPriorities(Idx) = Set Then
		        Self.mConfigSetPriorities.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    Self.Modified = True
		    Return
		  End If
		  
		  // Set will not be added unless necessary
		  Self.AddConfigSet(Set)
		  
		  Self.mConfigSetData.Value(Set.ConfigSetId) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetNames() As String()
		  Var Names() As String
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    Names.Add(Set.Name)
		  Next
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetPriorities() As Beacon.ConfigSetState()
		  Return Beacon.ConfigSetState.CloneArray(Self.mConfigSetPriorities)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetPriorities(Assigns List() As Beacon.ConfigSetState)
		  If Beacon.ConfigSetState.AreArraysEqual(Self.mConfigSetPriorities, List) Then
		    Return
		  End If
		  
		  Self.mConfigSetPriorities = Beacon.ConfigSetState.CloneArray(List)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSets() As Beacon.ConfigSet()
		  // Make sure to return a clone of the array.
		  Var Clone() As Beacon.ConfigSet
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    Clone.Add(New Beacon.ConfigSet(Set))
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // This class should only be created as a subclass
		  
		  Self.mAccounts = New Beacon.ExternalAccountManager
		  Self.mEncryptedPasswords = New Dictionary
		  Self.mProjectPassword = Crypto.GenerateRandomBytes(32)
		  Self.mUUID = New v4UUID
		  
		  Self.mConfigSetData = New Dictionary
		  Var BaseSet As Beacon.ConfigSet = Beacon.ConfigSet.BaseConfigSet
		  Self.AddConfigSet(BaseSet)
		  Self.mActiveConfigSet = BaseSet
		  Self.mConfigSetPriorities.ResizeTo(0)
		  Self.mConfigSetPriorities(0) = New Beacon.ConfigSetState(BaseSet, True)
		  
		  Self.mProviderTokenKeys = New Dictionary
		  
		  Self.mUseCompression = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateForGameID(GameID As String) As Beacon.Project
		  // At the moment, only Ark is supported.
		  
		  #Pragma Unused GameID 
		  Return New Ark.Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(Data As String) As String
		  Return BeaconEncryption.SymmetricDecrypt(Self.mProjectPassword, DecodeBase64(Data))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Description(Assigns Value As String)
		  If Self.mDescription.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Var OldValue As String = Self.mDescription
		    Self.mDescription = Value
		    Self.Modified = True
		    Self.NotifyObservers("Description", OldValue, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(Data As String) As String
		  Return EncodeBase64(BeaconEncryption.SymmetricEncrypt(Self.mProjectPassword, Data), 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindConfigSet(NameOrId As String) As Beacon.ConfigSet
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    If Set.Name = NameOrId Or Set.ConfigSetId = NameOrId Then
		      Return Set
		    End If
		  Next
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary, Identity As Beacon.Identity) As Beacon.Project
		  Var AdditionalProperties As New Dictionary
		  Return FromSaveData(SaveData, Identity, AdditionalProperties)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Dictionary, Identity As Beacon.Identity, AdditionalProperties As Dictionary) As Beacon.Project
		  Var Version As Integer = SaveData.Lookup("Version", 0).IntegerValue
		  Var MinVersion As Integer = SaveData.Lookup("MinVersion", Beacon.Project.SaveDataVersion).IntegerValue
		  Var SavedWithVersion As Integer = SaveData.Lookup("SavedWith", 10501399).IntegerValue // Max possible version before the value should exist
		  Var GameID As String = SaveData.Lookup("Game", Ark.Identifier).StringValue
		  Var UUID As String
		  If SaveData.HasKey("ProjectId") Then
		    UUID = SaveData.Value("ProjectId").StringValue
		  ElseIf SaveData.HasKey("Identifier") Then
		    UUID = SaveData.Value("Identifier").StringValue
		  End If
		  If v4UUID.IsValid(UUID) = False Then
		    UUID = Beacon.UUID.v4
		  End If
		  
		  If MinVersion > Beacon.Project.SaveDataVersion Then
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "This is a v" + Version.ToString(Locale.Raw, "0") + " project, but this version of Beacon only supports up to v" + MinVersion.ToString(Locale.Raw, "0") + " projects. There may be an update available."
		    Raise Err
		  End If
		  
		  Var Project As Beacon.Project
		  Select Case GameID
		  Case Ark.Identifier
		    Project = New Ark.Project
		  Else
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "Unknown game " + GameID + "."
		    Raise Err
		  End Select
		  
		  Project.mUUID = UUID
		  If SaveData.HasKey("Description") Then
		    Project.mDescription = SaveData.Value("Description")
		  End If
		  If SaveData.HasKey("Name") THen
		    Project.mTitle = SaveData.Value("Name")
		  ElseIf SaveData.HasKey("Title") Then
		    Project.mTitle = SaveData.Value("Title")
		  End If
		  If SaveData.HasKey("LegacyTrustKey") Then
		    Project.mLegacyTrustKey = SaveData.Value("LegacyTrustKey")
		  ElseIf SaveData.HasKey("Trust") Then
		    Project.mLegacyTrustKey = SaveData.Value("Trust")
		  End If
		  If SaveData.HasKey("Keep Local Backup") Then
		    Project.mKeepLocalBackup = SaveData.Value("Keep Local Backup")
		  End If
		  
		  If Version >= 4 And SaveData.HasKey("EncryptionKeys") And SaveData.Value("EncryptionKeys") IsA Dictionary Then
		    Var PossibleIdentities(0) As Beacon.Identity
		    PossibleIdentities(0) = Identity
		    
		    Var Passwords As Dictionary = SaveData.Value("EncryptionKeys")
		    For Each Entry As DictionaryEntry In Passwords
		      Var UserID As String = Entry.Key
		      If UserID = Identity.UserID Then
		        Continue
		      End If
		      
		      Var MergedIdentity As Beacon.Identity = App.IdentityManager.Fetch(UserID)
		      If (MergedIdentity Is Nil) = False Then
		        PossibleIdentities.Add(MergedIdentity)
		      End If
		    Next
		    
		    For Each PossibleIdentity As Beacon.Identity In PossibleIdentities
		      Var UserID As String = PossibleIdentity.UserID
		      If Passwords.HasKey(UserID) = False Then
		        Continue
		      End If
		      
		      Try
		        Var DocumentPassword As String = Crypto.RSADecrypt(DecodeBase64(Passwords.Value(UserID)), PossibleIdentity.PrivateKey)
		        Project.mProjectPassword = DocumentPassword
		        Project.mEncryptedPasswords = Passwords
		        
		        If Passwords.HasKey(UserID) = False Then
		          // Add a password for the current user
		          Project.AddUser(UserID, Identity.PublicKey)
		        End If
		        
		        Exit
		      Catch Err As RuntimeException
		        // Leave the encryption fresh
		        Break
		      End Try
		    Next
		  End If
		  
		  Var SecureDict As Dictionary
		  #Pragma BreakOnExceptions False
		  If SaveData.HasKey("EncryptedData") Then
		    Try
		      Project.mLastSecureData = SaveData.Value("EncryptedData")
		      Var Decrypted As String = Project.Decrypt(Project.mLastSecureData)
		      Project.mLastSecureHash = Beacon.Hash(Decrypted)
		      SecureDict = Beacon.ParseJSON(Decrypted)
		    Catch Err As RuntimeException
		      // No secure data
		    End Try
		  ElseIf SaveData.HasKey("Secure") Then
		    SecureDict = ReadLegacySecureData(SaveData.Value("Secure"), Identity)
		  End If
		  #Pragma BreakOnExceptions Default
		  If (SecureDict Is Nil) = False Then
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
		      Project.mAccounts = AccountManager
		    End If
		  Else
		    SecureDict = New Dictionary
		  End If
		  
		  If SaveData.HasKey("Config Set Data") Then
		    Project.mConfigSets.ResizeTo(-1)
		    Var Definitions() As Variant = SaveData.Value("Config Sets")
		    For Each Definition As Variant In Definitions
		      If Definition.Type = Variant.TypeObject And Definition.ObjectValue IsA Dictionary Then
		        Var ConfigSet As Beacon.ConfigSet = Beacon.ConfigSet.FromSaveData(Dictionary(Definition.ObjectValue))
		        Project.mConfigSets.Add(ConfigSet)
		      End If
		    Next
		    
		    Project.mConfigSetPriorities = Beacon.ConfigSetState.DecodeArray(SaveData.Value("Config Set Priorities"))
		    
		    Var SetDicts As Dictionary = SaveData.Value("Config Set Data")
		    Var EncryptedDicts As Dictionary
		    If SecureDict.HasKey("Config Set Data") Then
		      Try
		        EncryptedDicts = SecureDict.Value("Config Set Data")
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If EncryptedDicts Is Nil Then
		      EncryptedDicts = New Dictionary
		    End If
		    
		    Project.mConfigSetData = New Dictionary
		    For Each Entry As DictionaryEntry In SetDicts
		      Var SetId As String = Entry.Key
		      
		      If Entry.Value IsA Dictionary Then
		        Var EncryptedSetData As Dictionary
		        If EncryptedDicts.HasKey(SetId) Then
		          Try
		            EncryptedSetData = EncryptedDicts.Value(SetId)
		          Catch Err As RuntimeException
		          End Try
		        End If
		        
		        Project.mConfigSetData.Value(SetId) = Project.LoadConfigSet(Dictionary(Entry.Value), EncryptedSetData)
		      Else
		        Project.mConfigSetData.Value(SetId) = New Dictionary
		      End If
		    Next
		  ElseIf SaveData.HasKey("Config Sets") Then
		    Var Sets As Dictionary = SaveData.Value("Config Sets")
		    Var EncryptedSets As Dictionary
		    If SecureDict.HasKey("Config Sets") Then
		      Try
		        EncryptedSets = SecureDict.Value("Config Sets")
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If EncryptedSets Is Nil Then
		      EncryptedSets = New Dictionary
		    End If
		    
		    Project.mConfigSets.ResizeTo(-1)
		    Project.mConfigSetData = New Dictionary
		    Project.mConfigSetPriorities.ResizeTo(-1)
		    Var SetsMap As New Dictionary
		    For Each Entry As DictionaryEntry In Sets
		      Var SetName As String = Entry.Key
		      Var Set As Beacon.ConfigSet
		      If SetName = "Base" Then
		        Set = Beacon.ConfigSet.BaseConfigSet
		      Else
		        Set = New Beacon.ConfigSet(SetName)
		      End If
		      SetsMap.Value(Set.Name) = Set
		      Project.mConfigSets.Add(Set)
		      
		      If Entry.Value IsA Dictionary Then
		        Var EncryptedSetData As Dictionary
		        If EncryptedSets.HasKey(SetName) Then
		          Try
		            EncryptedSetData = EncryptedSets.Value(SetName)
		          Catch Err As RuntimeException
		          End Try
		        End If
		        
		        Project.mConfigSetData.Value(Set.ConfigSetId) = Project.LoadConfigSet(Dictionary(Entry.Value), EncryptedSetData)
		      Else
		        Project.mConfigSetData.Value(Set.ConfigSetId) = New Dictionary
		      End If
		    Next
		    
		    If SaveData.HasKey("Config Set Priorities") Then
		      Var States() As Variant = SaveData.Value("Config Set Priorities")
		      For Each State As Variant In States
		        Try
		          If State.Type = Variant.TypeObject And State.ObjectValue IsA Dictionary Then
		            Var StateDict As Dictionary = Dictionary(State.ObjectValue)
		            Var Name As String = StateDict.Value("Name")
		            Var Enabled As Boolean = StateDict.Value("Enabled")
		            If SetsMap.HasKey(Name) = False Then
		              Continue
		            End If
		            Var Set As Beacon.ConfigSet = SetsMap.Value(Name)
		            
		            Project.mConfigSetPriorities.Add(New Beacon.ConfigSetState(Set, Enabled))
		          End If
		        Catch Err As RuntimeException
		        End Try
		      Next
		    End If
		  ElseIf SaveData.HasKey("Configs") Then
		    Project.mConfigSets.ResizeTo(0)
		    Project.mConfigSets(0) = Beacon.ConfigSet.BaseConfigSet
		    Project.mConfigSetPriorities.ResizeTo(0)
		    Project.mConfigSetPriorities(0) = New Beacon.ConfigSetState(Beacon.ConfigSet.BaseConfigSetId, True)
		    Project.mConfigSetData = New Dictionary
		    Project.mConfigSetData.Value(Beacon.ConfigSet.BaseConfigSetId) = Project.LoadConfigSet(SaveData.Value("Configs"), Nil)
		  End If
		  
		  If SecureDict.HasKey("Servers") And SecureDict.Value("Servers").IsArray Then
		    Var ServerDicts() As Variant = SecureDict.Value("Servers")
		    For Each ServerDict As Variant In ServerDicts
		      Try
		        Var Dict As Dictionary = ServerDict
		        Var Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromSaveData(Dict, Project)
		        If Profile Is Nil Then
		          Continue
		        End If
		        
		        // Something about migrating the nitrado account?
		        
		        Project.mServerProfiles.Add(Profile)
		      Catch Err As RuntimeException
		      End Try
		    Next ServerDict
		  End If
		  
		  If SecureDict.HasKey("Provider Token Keys") Then
		    Var KeysDict As Dictionary = SecureDict.Value("Provider Token Keys")
		    For Each Entry As DictionaryEntry In KeysDict
		      Project.mProviderTokenKeys.Value(Entry.Key) = DecodeBase64(Entry.Value)
		    Next
		  End If
		  
		  Project.ReadSaveData(SaveData, SecureDict, Version, SavedWithVersion)
		  
		  If SaveData.HasKey("Other Properties") And (AdditionalProperties Is Nil) = False Then
		    Var Dict As Dictionary = SaveData.Value("Other Properties")
		    For Each Entry As DictionaryEntry In Dict
		      AdditionalProperties.Value(Entry.Key) = Entry.Value
		    Next
		  End If
		  
		  Project.Modified = Version < Beacon.Project.SaveDataVersion
		  
		  Return Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As MemoryBlock, Identity As Beacon.Identity) As Beacon.Project
		  Var AdditionalProperties As New Dictionary
		  Return FromSaveData(SaveData, Identity, AdditionalProperties)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As MemoryBlock, Identity As Beacon.Identity, AdditionalProperties As Dictionary) As Beacon.Project
		  If SaveData Is Nil Or SaveData.Size = 0 Then
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "File is empty."
		    Raise Err
		  End If
		  
		  Var UseCompression As Boolean
		  Var ProjectDict As Dictionary
		  If SaveData.Size >= 8 And (SaveData.UInt64Value(0) = CType(Beacon.Project.BinaryFormatBEBOM, UInt64) Or SaveData.UInt64Value(0) = CType(Beacon.Project.BinaryFormatLEBOM, UInt64)) Then
		    SaveData = SaveData.Middle(8, SaveData.Size - 8)
		    
		    Var Archive As Beacon.Archive = Beacon.Archive.Open(SaveData)
		    Var ManifestData As Dictionary = Beacon.ParseJSON(Archive.GetFile("Manifest.json"))
		    Var Version As Integer = ManifestData.Value("Version")
		    Var ProjectData As Dictionary = Beacon.ParseJSON(Archive.GetFile("v" + Version.ToString(Locale.Raw, "0") + ".json"))
		    
		    For Each Entry As DictionaryEntry In ManifestData
		      ProjectData.Value(Entry.Key) = Entry.Value
		    Next
		    
		    ProjectDict = ProjectData
		    UseCompression = True
		  Else
		    If SaveData.Size >= 2 And SaveData.UInt8Value(0) = &h1F And SaveData.UInt8Value(1) = &h8B Then
		      Var Decompressed As String = Beacon.Decompress(SaveData)
		      If Decompressed.IsEmpty = False Then
		        SaveData = Decompressed.DefineEncoding(Encodings.UTF8)
		        UseCompression = True
		      Else
		        Var Err As New Beacon.ProjectLoadException
		        Err.Message = "Failed to decompress project."
		        Raise Err
		      End If
		    End If
		    
		    ProjectDict = Beacon.ParseJSON(SaveData)
		  End If
		  
		  ProjectDict.Value("UseCompression") = UseCompression
		  
		  Return FromSaveData(ProjectDict, Identity, AdditionalProperties)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Var Err As New UnsupportedOperationException
		  Err.Message = "Project.GameID not overridden"
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUsers() As String()
		  Var Users() As String
		  For Each Entry As DictionaryEntry In Self.mEncryptedPasswords
		    Users.Add(Entry.Key)
		  Next
		  Return Users
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigSet(Set As Beacon.ConfigSet) As Boolean
		  Return Self.IndexOf(Set) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigSet(Named As String) As Boolean
		  For Idx As Integer = 0 To Self.mConfigSets.LastIndex
		    If Self.mConfigSets(Idx).Name = Named Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasUser(UserID As String) As Boolean
		  Return Self.mEncryptedPasswords.HasKey(UserID.Lowercase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IndexOf(Set As Beacon.ConfigSet) As Integer
		  If Set Is Nil Then
		    Return -1
		  End If
		  
		  For Idx As Integer = 0 To Self.mConfigSets.LastIndex
		    If Self.mConfigSets(Idx) = Set Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function KeepLocalBackup() As Boolean
		  Return Self.mKeepLocalBackup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeepLocalBackup(Assigns Value As Boolean)
		  If Self.mKeepLocalBackup <> Value Then
		    Self.mKeepLocalBackup = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LegacyTrustKey() As String
		  Return Self.mLegacyTrustKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
		  If EncryptedData Is Nil Then
		    EncryptedData = New Dictionary
		  End If
		  
		  Return RaiseEvent LoadConfigSet(PlainData, EncryptedData)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified Then
		    Return True
		  End If
		  
		  If Self.mAccounts.Modified Then
		    Return True
		  End If
		  
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.Modified Then
		      Return True
		    End If
		  Next Profile
		  
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Value = False Then
		    For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		      Profile.Modified = False
		    Next Profile
		    
		    For Each Set As Beacon.ConfigSet In Self.mConfigSets
		      Set.Modified = False
		    Next
		    
		    If (Self.mAccounts Is Nil) = False Then
		      Self.mAccounts.Modified = False
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewIdentifier()
		  Self.mUUID = Beacon.UUID.v4
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers Is Nil Then
		    Return
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, OldValue, NewValue)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Project) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mUUID = Other.mUUID Then
		    Return 0
		  End If
		  
		  Var MySort As String = Self.mTitle + ":" + Self.mDescription + ":" + Self.mUUID
		  Var OtherSort As String = Other.mTitle + ":" + Other.mDescription + ":" + Other.mUUID
		  Return MySort.Compare(OtherSort, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderTokenIds() As String()
		  Var TokenIds() As String
		  For Each Entry As DictionaryEntry In Self.mProviderTokenKeys
		    TokenIds.Add(Entry.Key)
		  Next
		  Return TokenIds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderTokenKey(TokenId As String) As String
		  Return Self.mProviderTokenKeys.Lookup(TokenId, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProviderTokenKey(TokenId As String, Assigns Key As String)
		  If Key.IsEmpty Then
		    Self.RemoveProviderTokenKey(TokenId)
		    Return
		  End If
		  
		  If Self.mProviderTokenKeys.HasKey(TokenId) And Self.mProviderTokenKeys.Value(TokenId).StringValue.Compare(Key, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mProviderTokenKeys.Value(TokenId) = Key
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderTokenKeyCount() As Integer
		  Return Self.mProviderTokenKeys.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadLegacySecureData(SecureDict As Dictionary, Identity As Beacon.Identity, SkipHashVerification As Boolean = False) As Dictionary
		  If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		    Return Nil
		  End If
		  
		  Var Key As MemoryBlock = Identity.Decrypt(DecodeHex(SecureDict.Value("Key")))
		  If Key Is Nil Then
		    Return Nil
		  End If
		  
		  Var ExpectedHash As String = SecureDict.Lookup("Hash", "")
		  Var Vector As MemoryBlock = DecodeHex(SecureDict.Value("Vector"))
		  Var Encrypted As MemoryBlock = DecodeHex(SecureDict.Value("Content"))
		  Var Crypt As CipherMBS = CipherMBS.aes_256_cbc
		  If Not Crypt.DecryptInit(BeaconEncryption.FixSymmetricKey(Key, Crypt.KeyLength), Vector) Then
		    Return Nil
		  End If
		  
		  Var Decrypted As String
		  Try
		    Decrypted = Crypt.Process(Encrypted)
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

	#tag Method, Flags = &h1
		Protected Sub ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SavedDataVersion As Integer, SavedWithVersion As Integer)
		  RaiseEvent ReadSaveData(PlainData, EncryptedData, SavedDataVersion, SavedWithVersion)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigSet(Set As Beacon.ConfigSet)
		  If Set Is Nil Or Set.IsBase Then
		    Return
		  End If
		  
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx = -1 Then
		    Return
		  End If
		  
		  Self.mConfigSets.RemoveAt(Idx)
		  Self.mConfigSetData.Remove(Set.ConfigSetId)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers Is Nil Then
		    Return
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveProviderTokenKey(TokenId As String)
		  If Self.mProviderTokenKeys.HasKey(TokenId) Then
		    Self.mProviderTokenKeys.Remove(TokenId)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveServerProfile(Profile As Beacon.ServerProfile)
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    If Self.mServerProfiles(Idx) = Profile Then
		      Self.mServerProfiles.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveUser(UserID As String)
		  UserID = UserID.Lowercase
		  If Self.mEncryptedPasswords.HasKey(UserID) Then
		    Self.mEncryptedPasswords.Remove(UserID)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenameConfigSet(Set As Beacon.ConfigSet, NewName As String)
		  Var OldNameIdx As Integer = Self.IndexOf(Set)
		  If OldNameIdx = -1 Then
		    Return
		  End If
		  
		  Set = Self.mConfigSets(OldNameIdx)
		  If Set.Name = NewName Then
		    Return
		  End If
		  
		  If Self.HasConfigSet(NewName) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "There is already a config set named " + NewName + "."
		    Raise Err
		  End If
		  
		  Set.Name = NewName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Sub ReplaceAccount(OldAccount As Beacon.ExternalAccount, NewAccount As Beacon.ExternalAccount)
		  If OldAccount Is Nil Or NewAccount Is Nil Then
		    Return
		  End If
		  
		  Self.ReplaceAccount(OldAccount.UUID, NewAccount)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Sub ReplaceAccount(OldUUID As String, Account As Beacon.ExternalAccount)
		  If Account Is Nil Then
		    Return
		  End If
		  
		  // These will all handle their own modification states
		  
		  If (Self.mAccounts.GetByUUID(OldUUID) Is Nil) = False Then
		    Self.mAccounts.Remove(OldUUID)
		    Self.Modified = True
		  End If
		  If Self.mAccounts.GetByUUID(Account.UUID) Is Nil Then
		    Self.mAccounts.Add(Account)
		    Self.Modified = True
		  End If
		  
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.ExternalAccountUUID = OldUUID Then
		      Profile.ExternalAccountUUID = Account.UUID
		      Self.Modified = True
		    End If
		  Next
		  
		  RaiseEvent AccountReplaced(OldUUID, Account.UUID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(Identity As Beacon.Identity, AdditionalProperties As Dictionary = Nil) As MemoryBlock
		  If Not Self.mEncryptedPasswords.HasKey(Identity.UserID) Then
		    Self.AddUser(Identity.UserID, Identity.PublicKey)
		  End If
		  
		  Var Manifest, ProjectData As Dictionary = New Dictionary // Intentionally assigning both to the same dictionary
		  If Self.mUseCompression Then
		    ProjectData = New Dictionary
		  End If
		  
		  Manifest.Value("Version") = Self.SaveDataVersion
		  Manifest.Value("MinVersion") = 7
		  Manifest.Value("ProjectId") = Self.mUUID
		  Manifest.Value("UserId") = Identity.UserId
		  Manifest.Value("Name") = Self.mTitle
		  Manifest.Value("Description") = Self.mDescription
		  Manifest.Value("GameId") = Self.GameID()
		  Manifest.Value("EncryptionKeys") = Self.mEncryptedPasswords
		  Manifest.Value("SavedWidth") = App.BuildNumber
		  Manifest.Value("Timestamp") = DateTime.Now.SecondsFrom1970
		  If Self.mLegacyTrustKey.IsEmpty = False Then
		    Manifest.Value("LegacyTrustKey") = Self.mLegacyTrustKey
		  End If
		  
		  Var EncryptedData As New Dictionary
		  RaiseEvent AddSaveData(Manifest, ProjectData, EncryptedData)
		  
		  If Self.mAccounts.Count > 0 Then
		    EncryptedData.Value("ExternalAccounts") = Self.mAccounts.AsDictionary
		  End If
		  
		  If Self.mServerProfiles.Count > 0 Then
		    Var Profiles() As Dictionary
		    For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		      Profiles.Add(Profile.SaveData)
		    Next
		    EncryptedData.Value("Servers") = Profiles
		  End If
		  
		  Var Sets As New Dictionary
		  Var EncryptedSets As New Dictionary
		  Var Definitions() As Dictionary
		  For Each Set As Beacon.ConfigSet In Self.mConfigSets
		    Definitions.Add(Set.SaveData)
		    
		    Var SetDict As Dictionary = Self.mConfigSetData.Value(Set.ConfigSetId)
		    Var SetPlainData As New Dictionary
		    Var SetEncryptedData As New Dictionary
		    RaiseEvent SaveConfigSet(SetDict, SetPlainData, SetEncryptedData)
		    
		    If SetPlainData.KeyCount > 0 Then
		      Sets.Value(Set.ConfigSetId) = SetPlainData
		      If SetEncryptedData.KeyCount > 0 Then
		        EncryptedSets.Value(Set.ConfigSetId) = SetEncryptedData
		      End If
		    End If
		  Next
		  ProjectData.Value("Config Sets") = Definitions
		  ProjectData.Value("Config Set Priorities") = Beacon.ConfigSetState.EncodeArray(Self.mConfigSetPriorities)
		  
		  ProjectData.Value("Config Set Data") = Sets
		  If EncryptedSets.KeyCount > 0 Then
		    EncryptedData.Value("Config Sets Data") = EncryptedSets
		  End If
		  
		  If Self.mProviderTokenKeys.KeyCount > 0 Then
		    Var KeysDict As New Dictionary
		    For Each Entry As DictionaryEntry In Self.mProviderTokenKeys
		      KeysDict.Value(Entry.Key) = EncodeBase64(Entry.Value)
		    Next
		    EncryptedData.Value("Provider Token Keys") = KeysDict
		  End If
		  
		  If EncryptedData.KeyCount > 0 Then
		    Var Content As String = Beacon.GenerateJSON(EncryptedData, False)
		    Var Hash As String = Beacon.Hash(Content)
		    If Hash <> Self.mLastSecureHash Then
		      Self.mLastSecureData = Self.Encrypt(Content)
		      Self.mLastSecureHash = Hash
		    End If
		    ProjectData.Value("EncryptedData") = Self.mLastSecureData
		  End If
		  
		  If (AdditionalProperties Is Nil) = False And AdditionalProperties.KeyCount > 0 Then
		    ProjectData.Value("Other Properties") = AdditionalProperties
		  End If
		  
		  ProjectData.Value("Keep Local Backup") = Self.mKeepLocalBackup
		  
		  If Self.mUseCompression Then
		    Var Archive As Beacon.Archive = Beacon.Archive.Create()
		    Archive.AddFile("Manifest.json", Beacon.GenerateJSON(Manifest, True))
		    Archive.AddFile("v" + Beacon.Project.SaveDataVersion.ToString(Locale.Raw, "0") + ".json", Beacon.GenerateJSON(ProjectData, False))
		    Var ArchiveData As MemoryBlock = Archive.Finalize
		    Var BOM As New MemoryBlock(8)
		    BOM.LittleEndian = ArchiveData.LittleEndian
		    BOM.UInt64Value(0) = If(ArchiveData.LittleEndian, CType(Beacon.Project.BinaryFormatLEBOM, UInt64), CType(Beacon.Project.BinaryFormatBEBOM, UInt64))
		    Return BOM + ArchiveData
		  Else
		    Return Beacon.GenerateJSON(ProjectData, True)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(Idx As Integer) As Beacon.ServerProfile
		  Return Self.mServerProfiles(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerProfile(Idx As Integer, Assigns Profile As Beacon.ServerProfile)
		  Self.mServerProfiles(Idx) = Profile
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(ProfileId As String) As Beacon.ServerProfile
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Profile.ProfileID = ProfileId Then
		      Return Profile
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfileCount() As Integer
		  Return Self.mServerProfiles.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfiles(Filter As String = "") As Beacon.ServerProfile()
		  Filter = Filter.Trim
		  
		  Var Results() As Beacon.ServerProfile
		  For Each Profile As Beacon.ServerProfile In Self.mServerProfiles
		    If Filter.IsEmpty = False And Profile.Name.IndexOf(Filter) = -1 And Profile.SecondaryName.IndexOf(Filter) = -1 And Profile.Nickname.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Results.Add(Profile)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Title() As String
		  Return Self.mTitle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Title(Assigns Value As String)
		  If Self.mTitle.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Var OldValue As String = Self.mTitle
		    Self.mTitle = Value
		    Self.Modified = True
		    Self.NotifyObservers("Title", OldValue, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UseCompression() As Boolean
		  Return Self.mUseCompression
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseCompression(Assigns Value As Boolean)
		  If Self.mUseCompression <> Value Then
		    Self.mUseCompression = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Validate() As Beacon.ProjectValidationResults
		  Var Issues As New Beacon.ProjectValidationResults
		  RaiseEvent Validate(Issues)
		  Return Issues
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Attributes( Deprecated ) Event AccountReplaced(OldUUID As String, NewUUID As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddingProfile(Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveComplete()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveConfigSet(SetDict As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Validate(Issues As Beacon.ProjectValidationResults)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mActiveConfigSet As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetPriorities() As Beacon.ConfigSetState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSets() As Beacon.ConfigSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedPasswords As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeepLocalBackup As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureData As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSecureHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLegacyTrustKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderTokenKeys As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServerProfiles() As Beacon.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTitle As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseCompression As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
	#tag EndProperty


	#tag Constant, Name = BaseConfigSetName, Type = String, Dynamic = False, Default = \"Base", Scope = Public, Attributes = \"Deprecated"
	#tag EndConstant

	#tag Constant, Name = BinaryFormatBEBOM, Type = Double, Dynamic = False, Default = \"3470482855257601832", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BinaryFormatLEBOM, Type = Double, Dynamic = False, Default = \"2916000471902660912", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SaveDataVersion, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
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
