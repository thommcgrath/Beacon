#tag Class
Protected Class Project
Implements ObservationKit.Observable
	#tag Method, Flags = &h0
		Function Accounts() As Beacon.ExternalAccountManager
		  Return Self.mAccounts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ActiveConfigSet() As String
		  Return Self.mActiveConfigSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ActiveConfigSet(Assigns SetName As String)
		  If Self.mConfigSets.HasKey(SetName) Then
		    Self.mActiveConfigSet = SetName
		  Else
		    Self.mActiveConfigSet = Self.BaseConfigSetName
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigSet(SetName As String)
		  If Self.mConfigSets.HasKey(SetName) = False Then
		    Self.mConfigSets.Value(SetName) = New Dictionary
		    Self.mConfigSetStates.Add(New Beacon.ConfigSetState(SetName, False))
		    Self.Modified = True
		  End If
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
		    Var Dict As Dictionary = Self.SaveData(Identity)
		    Var JSONValue As String = Beacon.GenerateJSON(Dict, False)
		    Var FailureReason As String
		    Return FromSaveData(JSONValue, Identity, FailureReason)
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloudSaveData() As Dictionary
		  // Make sure all values are strings
		  
		  Var Dict As New Dictionary
		  Dict.Value("version") = Self.SaveDataVersion.ToString(Locale.Raw, "0")
		  Dict.Value("uuid") = Self.mUUID
		  Dict.Value("description") = Self.mDescription
		  Dict.Value("title") = Self.mTitle
		  Dict.Value("game_id") = Self.GameID()
		  
		  Var Keys() As String
		  For Each Entry As DictionaryEntry In Self.mEncryptedPasswords
		    Keys.Add(Entry.Key.StringValue + ":" + Entry.Value.StringValue)
		  Next
		  Dict.Value("keys") = Keys.Join(",")
		  
		  RaiseEvent AddCloudSaveData(Dict)
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigSet(SetName As String) As Dictionary
		  If SetName.IsEmpty Then
		    SetName = Self.ActiveConfigSet
		  End If
		  
		  If Self.mConfigSets.HasKey(SetName) Then
		    Return Self.mConfigSets.Value(SetName)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ConfigSet(SetName As String, Assigns Dict As Dictionary)
		  If SetName.IsEmpty Then
		    SetName = Self.ActiveConfigSet
		  End If
		  
		  // Empty sets are valid
		  If Dict Is Nil Then
		    If Self.mConfigSets.HasKey(SetName) Then
		      Self.mConfigSets.Remove(SetName)
		      For Idx As Integer = Self.mConfigSetStates.LastIndex DownTo 1
		        If Self.mConfigSetStates(Idx).Name = SetName Then
		          Self.mConfigSetStates.RemoveAt(Idx)
		        End If
		      Next
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If Self.mConfigSets.HasKey(SetName) = False Then
		    Var Add As Boolean = True
		    For Idx As Integer = 1 To Self.mConfigSetStates.LastIndex
		      If Self.mConfigSetStates(Idx).Name = SetName Then
		        Add = False
		        Exit
		      End If
		    Next
		    If Add Then
		      Self.mConfigSetStates.Add(New Beacon.ConfigSetState(SetName, False))
		    End If
		  End If
		  Self.mConfigSets.Value(SetName) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetCount() As Integer
		  Return Self.mConfigSets.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetNames() As String()
		  Var Names() As String
		  For Each Entry As DictionaryEntry In Self.mConfigSets
		    Names.Add(Entry.Key)
		  Next
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates() As Beacon.ConfigSetState()
		  // Make sure to return a clone of the array. Do not need to clone the members since they are immutable.
		  Var Clone() As Beacon.ConfigSetState
		  Var Names() As String
		  For Each State As Beacon.ConfigSetState In Self.mConfigSetStates
		    // Do not include any states for sets that don't exist. Should be zero, but just to be sure.
		    If Self.mConfigSets.HasKey(State.Name) = False Then
		      Continue
		    End If
		    
		    Clone.Add(State)
		    Names.Add(State.Name)
		  Next
		  
		  // Make sure any new sets have a state
		  For Each Entry As DictionaryEntry In Self.mConfigSets
		    If Names.IndexOf(Entry.Key.StringValue) = -1 Then
		      Clone.Add(New Beacon.ConfigSetState(Entry.Key.StringValue, False))
		    End If
		  Next
		  
		  // First should always be an enabled base
		  Clone(0) = New Beacon.ConfigSetState(Self.BaseConfigSetName, True)
		  
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetStates(Assigns States() As Beacon.ConfigSetState)
		  // First decide if the States() array is different from the mConfigSetStates() array. Then, 
		  // update mConfigSetStates() to match. Do not need to clone the members since they are immutable.
		  
		  Var Different As Boolean
		  If Self.mConfigSetStates.Count <> States.Count Then
		    Different = True
		  Else
		    For Idx As Integer = 0 To States.LastIndex
		      If Self.mConfigSetStates(Idx) <> States(Idx) Then
		        Different = True
		        Exit
		      End If
		    Next
		  End If
		  
		  If Not Different Then
		    Return
		  End If
		  
		  Self.mConfigSetStates.ResizeTo(States.LastIndex)
		  For Idx As Integer = 0 To States.LastIndex
		    Self.mConfigSetStates(Idx) = States(Idx)
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // This class should only be created as a subclass
		  
		  Self.mAccounts = New Beacon.ExternalAccountManager
		  Self.mEncryptedPasswords = New Dictionary
		  Self.mProjectPassword = Crypto.GenerateRandomBytes(32)
		  Self.mUUID = New v4UUID
		  Self.mConfigSets = New Dictionary
		  Self.mConfigSets.Value(Self.BaseConfigSetName) = New Dictionary
		  Self.mActiveConfigSet = Self.BaseConfigSetName
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
		Shared Function FromSaveData(SaveData As Dictionary, Identity As Beacon.Identity, ByRef FailureReason As String) As Beacon.Project
		  Var Version As Integer = SaveData.Lookup("Version", 0).IntegerValue
		  Var MinVersion As Integer = SaveData.Lookup("MinVersion", Beacon.Project.SaveDataVersion).IntegerValue
		  Var SavedWithVersion As Integer = SaveData.Lookup("SavedWith", 10501399).IntegerValue // Max possible version before the value should exist
		  Var GameID As String = SaveData.Lookup("Game", Ark.Identifier).StringValue
		  Var UUID As String
		  If SaveData.HasKey("Identifier") Then
		    UUID = SaveData.Value("Identifier").StringValue
		  End If
		  If v4UUID.IsValid(UUID) = False Then
		    UUID = New v4UUID
		  End If
		  
		  If MinVersion > Beacon.Project.SaveDataVersion Then
		    FailureReason = "Unable to load project because the version is " + Version.ToString + " but this version of Beacon only supports up to version " + MinVersion.ToString + "."
		    App.Log(FailureReason)
		    Return Nil
		  End If
		  
		  Var Project As Beacon.Project
		  Select Case GameID
		  Case Ark.Identifier
		    Project = New Ark.Project
		  Else
		    FailureReason = "Unknown game " + GameID + "."
		    App.Log(FailureReason)
		    Return Nil
		  End Select
		  
		  Project.mUUID = UUID
		  If SaveData.HasKey("Description") Then
		    Project.mDescription = SaveData.Value("Description")
		  End If
		  If SaveData.HasKey("Title") Then
		    Project.mTitle = SaveData.Value("Title")
		  End If
		  If SaveData.HasKey("UseCompression") Then
		    Project.mUseCompression = SaveData.Value("UseCompression")
		  End If
		  If SaveData.HasKey("Trust") Then
		    Project.mLegacyTrustKey = SaveData.Value("Trust")
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
		      
		      Var MergedIdentity As Beacon.Identity = IdentityManager.FindMergedIdentity(UserID)
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
		  
		  If SecureDict.HasKey("Servers") And SecureDict.Value("Servers").IsArray Then
		    Var ServerDicts() As Variant = SecureDict.Value("Servers")
		    For Each ServerDict As Variant In ServerDicts
		      Try
		        Var Dict As Dictionary = ServerDict
		        Var Profile As Beacon.ServerProfile = Beacon.ServerProfile.FromSaveData(Dict)
		        If Profile Is Nil Then
		          Continue
		        End If
		        
		        // Something about migrating the nitrado account?
		        
		        Project.mServerProfiles.Add(Profile)
		      Catch Err As RuntimeException
		      End Try
		    Next ServerDict
		  End If
		  
		  If SaveData.HasKey("Config Sets") Then
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
		    
		    For Each Entry As DictionaryEntry In Sets
		      Var SetName As String = Entry.Key
		      
		      If Entry.Value IsA Dictionary Then
		        Var EncryptedSetData As Dictionary
		        If EncryptedSets.HasKey(SetName) Then
		          Try
		            EncryptedSetData = EncryptedSets.Value(SetName)
		          Catch Err As RuntimeException
		          End Try
		        End If
		        
		        Project.ConfigSet(SetName) = Project.LoadConfigSet(Dictionary(Entry.Value), EncryptedSetData)
		      Else
		        Project.ConfigSet(SetName) = New Dictionary
		      End If
		    Next
		    
		    // Doc.ConfigSet will add the states. We don't need them.
		    Project.mConfigSetStates.ResizeTo(-1)
		    If SaveData.HasKey("Config Set Priorities") Then
		      Try
		        Var States() As Variant = SaveData.Value("Config Set Priorities")
		        For Each State As Dictionary In States
		          Project.mConfigSetStates.Add(Beacon.ConfigSetState.FromSaveData(State))
		        Next
		      Catch Err As RuntimeException
		      End Try
		    End If
		  ElseIf SaveData.HasKey("Configs") Then
		    Project.ConfigSet(BaseConfigSetName) = Project.LoadConfigSet(SaveData.Value("Configs"), Nil)
		  End If
		  
		  If Project.ReadSaveData(SaveData, SecureDict, Version, SavedWithVersion, FailureReason) = False Then
		    App.Log(FailureReason)
		    Return Nil
		  End If
		  
		  Project.Modified = Version < Beacon.Project.SaveDataVersion
		  
		  Return Project
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As String, Identity As Beacon.Identity, ByRef FailureReason As String) As Beacon.Project
		  If Beacon.IsCompressed(SaveData) Then
		    SaveData = Beacon.Decompress(SaveData)
		  End If
		  
		  Var Parsed As Dictionary
		  Try
		    Parsed = Beacon.ParseJSON(SaveData)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Failed to parse JSON")
		    Return Nil
		  End Try
		  
		  Try
		    Return FromSaveData(Parsed, Identity, FailureReason)
		  Catch Err As RuntimeException
		    FailureReason = "Untrapped error inside project loader"
		    App.Log(Err, CurrentMethodName, FailureReason)
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
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
		Function HasUser(UserID As String) As Boolean
		  Return Self.mEncryptedPasswords.HasKey(UserID.Lowercase)
		End Function
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
		    
		    If (Self.mAccounts Is Nil) = False Then
		      Self.mAccounts.Modified = False
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewIdentifier()
		  Self.mUUID = New v4UUID
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
		Protected Function ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SavedDataVersion As Integer, SavedWithVersion As Integer, ByRef FailureReason As String) As Boolean
		  Try
		    Return RaiseEvent ReadSaveData(PlainData, EncryptedData, SavedDataVersion, SavedWithVersion, FailureReason)
		  Catch Err As RuntimeException
		    FailureReason = "Untrapped exception in raised event ReadSaveData"
		    App.Log(Err, CurrentMethodName, FailureReason)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigSet(SetName As String)
		  If SetName.IsEmpty Or SetName = Self.BaseConfigSetName Then
		    Return
		  End If
		  
		  For Idx As Integer = Self.mConfigSetStates.LastIndex DownTo 1
		    If Self.mConfigSetStates(Idx).Name = SetName Then
		      Self.mConfigSetStates.RemoveAt(Idx)
		      Self.Modified = True
		    End If
		  Next
		  
		  Self.ConfigSet(SetName) = Nil
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
		Sub RenameConfigSet(OldName As String, NewName As String)
		  If Self.mConfigSets.HasKey(OldName) = False Then
		    Return
		  End If
		  
		  For Idx As Integer = 1 To Self.mConfigSetStates.LastIndex
		    If Self.mConfigSetStates(Idx).Name = OldName Then
		      Self.mConfigSetStates(Idx) = New Beacon.ConfigSetState(NewName, Self.mConfigSetStates(Idx).Enabled)
		    End If
		  Next
		  
		  Var OldSet As Dictionary = Self.mConfigSets.Value(OldName)
		  Self.ConfigSet(OldName) = Nil
		  Self.ConfigSet(NewName) = OldSet
		  
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    Var Profile As Beacon.ServerProfile = Self.mServerProfiles(Idx)
		    Var ConfigSets() As Beacon.ConfigSetState = Profile.ConfigSetStates
		    For SetIdx As Integer = 0 To ConfigSets.LastIndex
		      If ConfigSets(SetIdx).Name = OldName Then
		        ConfigSets(SetIdx) = New Beacon.ConfigSetState(NewName, ConfigSets(SetIdx).Enabled)
		      End If
		    Next
		    Profile.ConfigSetStates = ConfigSets
		  Next
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceAccount(OldAccount As Beacon.ExternalAccount, NewAccount As Beacon.ExternalAccount)
		  If OldAccount Is Nil Or NewAccount Is Nil Then
		    Return
		  End If
		  
		  Self.ReplaceAccount(OldAccount.UUID, NewAccount)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceAccount(OldUUID As String, Account As Beacon.ExternalAccount)
		  If Account Is Nil Then
		    Return
		  End If
		  
		  // These will all handle their own modification states
		  
		  If (Self.mAccounts.GetByUUID(OldUUID) Is Nil) = False Then
		    Self.mAccounts.Remove(OldUUID)
		  End If
		  If Self.mAccounts.GetByUUID(Account.UUID) Is Nil Then
		    Self.mAccounts.Add(Account)
		  End If
		  
		  RaiseEvent AccountReplaced(OldUUID, Account.UUID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData(Identity As Beacon.Identity) As Dictionary
		  If Not Self.mEncryptedPasswords.HasKey(Identity.UserID) Then
		    Self.AddUser(Identity.UserID, Identity.PublicKey)
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value("Version") = Self.SaveDataVersion
		  Dict.Value("MinVersion") = 6
		  Dict.Value("Identifier") = Self.mUUID
		  Dict.Value("Title") = Self.mTitle
		  Dict.Value("Game") = Self.GameID
		  Dict.Value("SavedWith") = App.BuildNumber
		  Dict.Value("EncryptionKeys") = Self.mEncryptedPasswords
		  Dict.Value("UseCompression") = Self.mUseCompression
		  Dict.Value("Timestamp") = DateTime.Now.SQLDateTimeWithOffset
		  Dict.Value("Description") = Self.mDescription
		  If Self.mLegacyTrustKey.IsEmpty = False Then
		    Dict.Value("Trust") = Self.mLegacyTrustKey
		  End If
		  
		  Var EncryptedData As New Dictionary
		  RaiseEvent AddSaveData(Dict, EncryptedData)
		  
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
		  For Each Entry As DictionaryEntry In Self.mConfigSets
		    Var SetName As String = Entry.Key
		    Var SetDict As Dictionary = Entry.Value
		    Var SetPlainData As New Dictionary
		    Var SetEncryptedData As New Dictionary
		    RaiseEvent SaveConfigSet(SetDict, SetPlainData, SetEncryptedData)
		    
		    If SetPlainData.KeyCount > 0 Then
		      Sets.Value(SetName) = SetPlainData
		      If SetEncryptedData.KeyCount > 0 Then
		        EncryptedSets.Value(SetName) = SetEncryptedData
		      End If
		    End If
		  Next
		  Dict.Value("Config Sets") = Sets
		  If EncryptedSets.KeyCount > 0 Then
		    EncryptedData.Value("Config Sets") = EncryptedSets
		  End If
		  
		  Var States() As Dictionary
		  For Each State As Beacon.ConfigSetState In Self.mConfigSetStates
		    States.Add(State.SaveData)
		  Next
		  Dict.Value("Config Set Priorities") = States
		  
		  If EncryptedData.KeyCount > 0 Then
		    Var Content As String = Beacon.GenerateJSON(EncryptedData, False)
		    Var Hash As String = Beacon.Hash(Content)
		    If Hash <> Self.mLastSecureHash Then
		      Self.mLastSecureData = Self.Encrypt(Content)
		      Self.mLastSecureHash = Hash
		    End If
		    Dict.Value("EncryptedData") = Self.mLastSecureData
		  End If
		  
		  Return Dict
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
		Function ServerProfileCount() As Integer
		  Return Self.mServerProfiles.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfiles(Filter As String = "") As Beacon.ServerProfile()
		  Filter = Filter.Trim
		  
		  Var Results() As Beacon.ServerProfile
		  For Idx As Integer = Self.mServerProfiles.FirstIndex To Self.mServerProfiles.LastIndex
		    If Filter.IsEmpty = False And Self.mServerProfiles(Idx).Name.IndexOf(Filter) = -1 And Self.mServerProfiles(Idx).SecondaryName.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Results.Add(Self.mServerProfiles(Idx))
		  Next Idx
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
		Event AccountReplaced(OldUUID As String, NewUUID As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddCloudSaveData(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddingProfile(Profile As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddSaveData(PlainData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer, ByRef FailureReason As String) As Boolean
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
		Private mActiveConfigSet As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSets As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetStates() As Beacon.ConfigSetState
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedPasswords As Dictionary
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


	#tag Constant, Name = BaseConfigSetName, Type = String, Dynamic = False, Default = \"Base", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SaveDataVersion, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
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
