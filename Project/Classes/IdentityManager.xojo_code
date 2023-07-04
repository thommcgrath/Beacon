#tag Class
Protected Class IdentityManager
	#tag Method, Flags = &h0
		Function All() As Beacon.Identity()
		  Var Identities() As Beacon.Identity
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities")
		  While Not Rows.AfterLastRow
		    Var Identity As Beacon.Identity = Beacon.Identity.Load(Rows)
		    If (Identity Is Nil) = False Then
		      Identities.Add(Identity)
		    End If
		    Rows.MoveToNextRow
		  Wend
		  Return Identities
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Var AppSupport As FolderItem = App.ApplicationSupport
		  
		  Var DatabaseFile As FolderItem = AppSupport.Child("Identities.sqlite")
		  Var Database As New SQLiteDatabase
		  #if Not DebugBuild
		    Var Key As String = Crypto.SHA3_256("8df95865-3fac-4c79-8ee6-8ee98ca199df" + " " + Beacon.SystemAccountName + " " + Beacon.HardwareID)
		    Database.EncryptionKey = "aes256:" + Key.ReplaceAll(Chr(0), Chr(1)) // https://forum.xojo.com/t/sqlitedatabase-encryptionkey-key-derivation/76366/9?u=thom_mcgrath
		  #endif
		  Database.DatabaseFile = DatabaseFile
		  
		  If DatabaseFile.Exists Then
		    Try
		      Database.Connect
		      Self.mDatabase = Database
		      Return
		    Catch Err As RuntimeException
		    End Try
		    
		    DatabaseFile.Remove
		  End If
		  
		  Database.CreateDatabase
		  Database.ExecuteSQL("CREATE TABLE identities (user_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, public_key TEXT COLLATE NOCASE NOT NULL, private_key TEXT COLLATE NOCASE NOT NULL, cloud_key TEXT NOT NULL DEFAULT '', licenses TEXT NOT NULL DEFAULT '[]', username TEXT COLLATE NOCASE NOT NULL DEFAULT '', banned BOOLEAN NOT NULL DEFAULT FALSE, signature TEXT NOT NULL DEFAULT '', signature_version INTEGER NOT NULL DEFAULT 1, expiration TEXT NOT NULL DEFAULT '', active BOOLEAN NOT NULL DEFAULT FALSE, merged BOOLEAN NOT NULL DEFAULT FALSE);")
		  Self.mDatabase = Database
		  
		  Var MergedFolder As FolderItem = AppSupport.Child("Merged Identities")
		  For Each Child As FolderItem In MergedFolder.Children(False)
		    Var Identity As Beacon.Identity = Self.Import(Child)
		    If (Identity Is Nil) = False Then
		      #if Not DebugBuild
		        Child.Remove
		      #endif
		    End If
		  Next
		  
		  Database.BeginTransaction
		  Database.ExecuteSQL("UPDATE identities SET merged = TRUE;")
		  Database.CommitTransaction
		  
		  Var DefaultIdentity As FolderItem = AppSupport.Child("Default" + Beacon.FileExtensionIdentity)
		  If DefaultIdentity.Exists Then
		    Var Default As Beacon.Identity = Self.Import(DefaultIdentity)
		    If (Default Is Nil) = False Then
		      Self.CurrentIdentity = Default
		      #if Not DebugBuild
		        DefaultIdentity.Remove
		      #endif
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Create(SetCurrent As Boolean = True) As Beacon.Identity
		  Var UserId As String = Beacon.UUID.v4
		  Var PublicKey, PrivateKey As String
		  Call Crypto.RSAGenerateKeyPair(4096, PrivateKey, PublicKey)
		  
		  Self.mDatabase.BeginTransaction
		  If SetCurrent Then
		    Self.mDatabase.ExecuteSQL("UPDATE identities SET active = FALSE WHERE active = TRUE;")
		  End If
		  Self.mDatabase.ExecuteSQL("INSERT INTO identities (user_id, public_key, private_key, active) VALUES (?1, ?2, ?3, ?4);", UserId, PublicKey, PrivateKey, SetCurrent)
		  Self.mDatabase.CommitTransaction
		  
		  Var Identity As Beacon.Identity = Self.Fetch(UserId)
		  If SetCurrent Then
		    Self.mCurrentIdentity = Identity
		  End If
		  NotificationKit.Post(Self.Notification_IdentityChanged, Identity)
		  
		  Return Identity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentIdentity() As Beacon.Identity
		  If Self.mCurrentIdentity Is Nil Then
		    Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE active = TRUE;")
		    If Rows.RowCount = 0 Then
		      Return Nil
		    End If
		    
		    Self.mCurrentIdentity = Beacon.Identity.Load(Rows)
		  End If
		  
		  Return Self.mCurrentIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentIdentity(Assigns Value As Beacon.Identity)
		  Self.mDatabase.BeginTransaction
		  Self.mDatabase.ExecuteSQL("UPDATE identities SET active = FALSE WHERE active = TRUE;")
		  If (Value Is Nil) = False Then
		    Self.mDatabase.ExecuteSQL("UPDATE identities SET active = TRUE WHERE user_id = ?1;", Value.UserId)
		  End If
		  Self.mDatabase.CommitTransaction
		  Self.mCurrentIdentity = Value
		  
		  NotificationKit.Post(Self.Notification_IdentityChanged, Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentUserId() As String
		  If Self.mCurrentIdentity Is Nil Then
		    Return Beacon.UUID.Null
		  Else
		    Return Self.mCurrentIdentity.UserId
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Fetch(UserId As String) As Beacon.Identity
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE user_id = ?1;", UserId)
		  If Rows.RowCount = 0 Then
		    Return Nil
		  End If
		  
		  Return Beacon.Identity.Load(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchAnonymous(Create As Boolean) As Beacon.Identity
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE username = '' AND merged = FALSE AND banned = FALSE ORDER BY LENGTH(public_key) DESC, signature_version DESC, LENGTH(signature) DESC;")
		  If Rows.RowCount = 0 Then
		    If Create Then
		      Return Self.Create()
		    Else
		      Return Nil
		    End If
		  End If
		  
		  Return Beacon.Identity.Load(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Import(Dict As Dictionary) As Beacon.Identity
		  Try
		    Var UserId As String = Dict.Value("userId").StringValue
		    Var Username As String = Dict.Value("username").StringValue
		    Var PublicKey As String = BeaconEncryption.PEMDecodePublicKey(Dict.Value("publicKey").StringValue)
		    Var Banned As Boolean = Dict.Value("banned").BooleanValue
		    Var Expiration As String = Dict.Lookup("expiration", "").StringValue
		    Var Signatures As Dictionary = Dict.Value("signatures")
		    Var Signature As String = Signatures.Value("3").StringValue
		    Var SignatureVersion As Integer = 3
		    Var LicenseArray() As Variant = Dict.Value("licenses")
		    Var LicenseSaveData() As Variant
		    For Each Member As Variant In LicenseArray
		      If Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var LicenseData As Dictionary = Member
		      Var License As New Beacon.OmniLicense(LicenseData.Value("productId").StringValue, LicenseData.Value("flags").IntegerValue, LicenseData.Lookup("expiration", "").StringValue)
		      LicenseSaveData.Add(License.SaveData)
		    Next
		    Var Licenses As String = Beacon.GenerateJSON(LicenseSaveData, False)
		    
		    Var PrivateKey, CloudKey As String
		    If Dict.HasKey("privateKey") Then
		      Var PrivateKeyDict As Dictionary = Dict.Value("privateKey")
		      Var EncryptionVersion As Integer = PrivateKeyDict.Value("version")
		      If EncryptionVersion > 1 Then
		        App.Log("Unable to import identity because encryption version is too new.")
		        Return Nil
		      End If
		      
		      Var KeyEncrypted As String = PrivateKeyDict.Value("key")
		      Var PrivateKeyEncrypted As String = PrivateKeyDict.Value("message")
		      
		      Try
		        Var Key As String = Crypto.RSADecrypt(DecodeBase64(KeyEncrypted), Preferences.DevicePrivateKey)
		        PrivateKey = BeaconEncryption.PEMDecodePrivateKey(BeaconEncryption.SymmetricDecrypt(Key, DecodeBase64(PrivateKeyEncrypted)))
		        CloudKey = EncodeBase64(Crypto.RSADecrypt(DecodeBase64(Dict.Value("cloudKey").StringValue), PrivateKey), 0)
		      Catch Err As RuntimeException
		        App.Log("Unable to import identity because private key could not be decrypted.")
		        Return Nil
		      End Try
		    Else
		      Var ExistingIdentity As Beacon.Identity = Self.Fetch(UserId)
		      If ExistingIdentity Is Nil Then
		        App.Log("Unable to import identity because the profile is anonymous and the private key is not known.")
		        Return Nil
		      End
		      
		      PrivateKey = ExistingIdentity.PrivateKey
		      CloudKey = EncodeBase64(ExistingIdentity.UserCloudKey)
		    End If
		    
		    Self.mDatabase.BeginTransaction
		    Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT user_id FROM identities WHERE user_id = ?1;", UserId)
		    If Rows.RowCount = 0 Then
		      Self.mDatabase.ExecuteSQL("INSERT INTO identities (user_id, public_key, private_key, cloud_key, licenses, username, banned, signature, signature_version, expiration) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10);", UserId, PublicKey, PrivateKey, CloudKey, Licenses, Username, Banned, Signature, SignatureVersion, Expiration)
		    Else
		      Self.mDatabase.ExecuteSQL("UPDATE identities SET public_key = ?2, private_key = ?3, cloud_key = ?4, licenses = ?5, username = ?6, banned = ?7, signature = ?8, signature_version = ?9, expiration = ?10 WHERE user_id = ?1;", UserId, PublicKey, PrivateKey, CloudKey, Licenses, Username, Banned, Signature, SignatureVersion, Expiration)
		    End If
		    Self.mDatabase.CommitTransaction
		    
		    Return Self.Fetch(UserId)
		  Catch Err As RuntimeException
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Import(File As FolderItem, Password As String = "") As Beacon.Identity
		  If Not File.Exists Then
		    Return Nil
		  End If
		  
		  Try
		    Var Contents As String = File.Read(Encodings.UTF8)
		    If Contents = "" Then
		      Return Nil
		    End If
		    
		    Var Dict As Dictionary = Beacon.ParseJSON(Contents)
		    Var UserId As String = Dict.Value("Identifier")
		    Var Version As Integer = Dict.Lookup("Version", 1)
		    Var PublicKey, PrivateKey As String
		    Var IsEncrypted As Boolean
		    Var CloudKey As String
		    
		    Select Case Version
		    Case 2, 3
		      PublicKey = Dict.Value("Public")
		      PrivateKey = Dict.Value("Private")
		      IsEncrypted = Dict.HasKey("Private Salt")
		    Case 1
		      PublicKey = DecodeHex(Dict.Value("Public"))
		      PrivateKey = DecodeHex(Dict.Value("Private"))
		    End Select
		    
		    If IsEncrypted Then
		      If Password.IsEmpty Then
		        Password = PasswordStorage.RetrievePassword(UserId)
		        If Password.IsEmpty Then
		          App.Log("Could not import identity file because there is no stored password.")
		          Return Nil
		        End If
		      End If
		      
		      Var Salt As String = DecodeBase64(Dict.Value("Private Salt"))
		      Var Iterations As Integer = Dict.Value("Private Iterations")
		      Try
		        Var Key As MemoryBlock = Crypto.PBKDF2(Salt, Password, Iterations, 56, Crypto.HashAlgorithms.SHA512)
		        PrivateKey = DefineEncoding(BeaconEncryption.SymmetricDecrypt(Key, DecodeBase64(PrivateKey)), Encodings.UTF8)
		      Catch Err As RuntimeException
		        App.Log("Could not import identity file because the password is not correct.")
		        Return Nil
		      End Try
		      
		      If Dict.HasKey("Cloud Key") Then
		        CloudKey = EncodeBase64(Crypto.RSADecrypt(DecodeBase64(Dict.Value("Cloud Key").StringValue), PrivateKey))
		      End If
		    Else
		      If Dict.HasKey("Cloud Key") Then
		        CloudKey = EncodeBase64(DecodeHex(Dict.Value("Cloud Key").StringValue))
		      End If
		    End If
		    
		    If Crypto.RSAVerifyKey(PublicKey) = False Or Crypto.RSAVerifyKey(PrivateKey) = False Then
		      App.Log("Could not import identity file because the keys are not valid.")
		      Return Nil
		    End If
		    
		    Try
		      Var Original As MemoryBlock = Crypto.GenerateRandomBytes(12)
		      Var Encrypted As String = Crypto.RSAEncrypt(Original, PublicKey)
		      Var Decrypted As String = Crypto.RSADecrypt(Encrypted, PrivateKey)
		      If Decrypted <> Original Then
		        App.Log("Could not import identity file because public key does not match the private key.")
		        Return Nil
		      End If
		      
		      Var Signature As MemoryBlock = Crypto.RSASign(Original, PrivateKey)
		      If Crypto.RSAVerifySignature(Original, Signature, PublicKey) = False Then
		        App.Log("Could not import identity file because the private key is not valid for signing.")
		        Return Nil
		      End If
		    Catch Err As RuntimeException
		      App.Log("Could not import identity file due to an exception.")
		      App.Log(Err, CurrentMethodName, "Testing key validity.")
		    End Try
		    
		    Var Username As String
		    If Dict.HasKey("Username") Then
		      Username = Dict.Value("Username")
		    ElseIf Dict.HasKey("LoginKey") Then
		      Username = Dict.Value("LoginKey")
		    End If
		    
		    Var Signature As String
		    Var SignatureVersion As Integer = 0
		    If Dict.HasKey("Signature") Then
		      Signature = EncodeBase64(DecodeHex(Dict.Value("Signature")))
		      If Dict.HasKey("Signature Version") Then
		        SignatureVersion = Dict.Value("Signature Version")
		      Else
		        SignatureVersion = 2
		      End If
		    End If
		    
		    Var Expiration As String
		    If Dict.HasKey("Expiration") Then
		      Expiration = Dict.Value("Expiration")
		    End If
		    
		    Var Banned As Boolean
		    If Dict.HasKey("Banned") Then
		      Banned = Dict.Value("Banned")
		    End If
		    
		    Var Licenses As String = "[]"
		    If Dict.HasKey("Licenses") Then
		      Var LicenseArray() As Variant = Dict.Value("Licenses")
		      Var LicenseSaveData() As Variant
		      For Each Member As Variant In LicenseArray
		        If Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		          Continue
		        End If
		        
		        Var LicenseData As Dictionary = Member
		        Var License As New Beacon.OmniLicense(LicenseData.Value("Product ID").StringValue, LicenseData.Value("Flags").IntegerValue, LicenseData.Lookup("Expiration", "").StringValue)
		        LicenseSaveData.Add(License.SaveData)
		      Next
		      Licenses = Beacon.GenerateJSON(LicenseSaveData, False)
		    ElseIf Dict.Value("Omni Version") Then
		      Var License As New Beacon.OmniLicense("972f9fc5-ad64-4f9c-940d-47062e705cc5", Dict.Value("Omni Version").IntegerValue, "")
		      Var LicenseSaveData() As Variant
		      LicenseSaveData.Add(License.SaveData)
		      Licenses = Beacon.GenerateJSON(LicenseSaveData, False)
		    End If
		    
		    Self.mDatabase.BeginTransaction
		    Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT user_id FROM identities WHERE user_id = ?1;", UserId)
		    If Rows.RowCount = 0 Then
		      Self.mDatabase.ExecuteSQL("INSERT INTO identities (user_id, public_key, private_key, cloud_key, licenses, username, banned, signature, signature_version, expiration) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10);", UserId, PublicKey, PrivateKey, CloudKey, Licenses, Username, Banned, Signature, SignatureVersion, Expiration)
		    Else
		      Self.mDatabase.ExecuteSQL("UPDATE identities SET public_key = ?2, private_key = ?3, cloud_key = ?4, licenses = ?5, username = ?6, banned = ?7, signature = ?8, signature_version = ?9, expiration = ?10 WHERE user_id = ?1;", UserId, PublicKey, PrivateKey, CloudKey, Licenses, Username, Banned, Signature, SignatureVersion, Expiration)
		    End If
		    Self.mDatabase.CommitTransaction
		    
		    Return Self.Fetch(UserId)
		  Catch Err As RuntimeException
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Identity As Beacon.Identity)
		  If Identity Is Nil Then
		    Return
		  End If
		  
		  Self.Remove(Identity.UserId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(UserId As String)
		  Self.mDatabase.BeginTransaction
		  Self.mDatabase.ExecuteSQL("DELETE FROM identities WHERE user_id = ?1;", UserId)
		  
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE active = TRUE LIMIT 1;")
		  If Rows.RowCount = 0 Then
		    Rows = Self.mDatabase.SelectSQL("SELECT * FROM identities LIMIT 1;")
		    If Rows.RowCount = 0 Then
		      Self.mDatabase.CommitTransaction
		      Self.mCurrentIdentity = Nil
		      NotificationKit.Post(Self.Notification_IdentityChanged, Nil)
		      Return
		    End If
		    
		    Var Identity As Beacon.Identity = Beacon.Identity.Load(Rows)
		    Self.mDatabase.ExecuteSQL("UPDATE identities SET active = TRUE WHERE user_id = ?1;", Identity.UserId)
		    Self.mDatabase.CommitTransaction
		    Self.mCurrentIdentity = Identity
		    NotificationKit.Post(Self.Notification_IdentityChanged, Identity)
		    Return
		  End If
		  
		  Self.mDatabase.CommitTransaction
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCurrentIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDatabase As SQLiteDatabase
	#tag EndProperty


	#tag Constant, Name = Notification_IdentityChanged, Type = Text, Dynamic = False, Default = \"Identity Changed", Scope = Public
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
