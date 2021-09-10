#tag Class
Protected Class Project
	#tag Method, Flags = &h0
		Function Accounts() As Beacon.ExternalAccountManager
		  Return Self.mAccounts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddUser(UserID As String, PublicKey As String)
		  Self.mEncryptedPasswords.Value(UserID.Lowercase) = EncodeBase64(Crypto.RSAEncrypt(Self.mProjectPassword, PublicKey), 0)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloudSaveData() As Dictionary
		  // Make sure all values are strings
		  
		  Var Dict As New Dictionary
		  Dict.Value("version") = Self.SaveDataVersion.ToString(Locale.Raw, "0")
		  Dict.Value("uuid") = Self.mUUID
		  Dict.Value("description") = Self.mDescription
		  Dict.Value("title") = Self.mTitle
		  
		  Var Keys() As String
		  For Each Entry As DictionaryEntry In Self.mEncryptedPasswords
		    Keys.Add(Entry.Key.StringValue + ":" + Entry.Value.StringValue)
		  Next
		  Dict.Value("keys") = Keys.Join(",")
		  
		  RaiseEvent AddCloudSaveData(Dict)
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAccounts = New Beacon.ExternalAccountManager
		  Self.mEncryptedPasswords = New Dictionary
		  Self.mProjectPassword = Crypto.GenerateRandomBytes(32)
		  Self.mUUID = New v4UUID
		End Sub
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
		    Self.mDescription = Value
		    Self.Modified = True
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
		      Var UserID As String = PossibleIdentity.UserIDForEncryption
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
		  
		  If Project.ReadSaveData(SaveData, SecureDict, Version, SavedWithVersion, FailureReason) = False Then
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
		  If Self.mModified = False Then
		    Self.mModified = Value
		    RaiseEvent SaveComplete()
		  End If
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
		Sub RemoveUser(UserID As String)
		  UserID = UserID.Lowercase
		  If Self.mEncryptedPasswords.HasKey(UserID) Then
		    Self.mEncryptedPasswords.Remove(UserID)
		    Self.Modified = True
		  End If
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
		  If Not Self.mEncryptedPasswords.HasKey(Identity.UserIDForEncryption) Then
		    Self.AddUser(Identity.UserIDForEncryption, Identity.PublicKey)
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
		  
		  Var EncryptedData As New Dictionary
		  RaiseEvent AddSaveData(Dict, EncryptedData)
		  
		  If Self.mAccounts.Count > 0 Then
		    EncryptedData.Value("ExternalAccounts") = Self.mAccounts.AsDictionary
		  End If
		  
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
		Function Title() As String
		  Return Self.mTitle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Title(Assigns Value As String)
		  If Self.mTitle.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mTitle = Value
		    Self.Modified = True
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


	#tag Hook, Flags = &h0
		Event AccountReplaced(OldUUID As String, NewUUID As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddCloudSaveData(Dict As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event AddSaveData(PlainData As Dictionary, EncryptedData As Dictionary)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer, ByRef FailureReason As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveComplete()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mAccounts As Beacon.ExternalAccountManager
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mDescription As String
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
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProjectPassword As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTitle As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUseCompression As Boolean
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
