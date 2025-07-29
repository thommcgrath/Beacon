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
		  Const UseEncryption = Not DebugBuild
		  
		  Var AppSupport As FolderItem = App.ApplicationSupport
		  
		  Var DatabaseFile As FolderItem = AppSupport.Child("Identities.sqlite")
		  Var Database As New SQLiteDatabase
		  #if UseEncryption
		    Database.EncryptionKey = Self.GenerateKey
		  #endif
		  Database.DatabaseFile = DatabaseFile
		  
		  If DatabaseFile.Exists Then
		    Try
		      Database.Connect
		      Self.mDatabase = Database
		      
		      Var Columns As RowSet = Database.TableColumns("identities")
		      Var HasSubscriptionsColumn As Boolean
		      For Each Row As DatabaseRow In Columns
		        If Row.Column("ColumnName").StringValue = "subscriptions" Then
		          HasSubscriptionsColumn = True
		          Exit
		        End If
		      Next
		      If Not HasSubscriptionsColumn Then
		        Database.ExecuteSQL("ALTER TABLE identities ADD COLUMN subscriptions TEXT NOT NULL DEFAULT '[]';")
		      End If
		      
		      Return
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to connect to identity database")
		    End Try
		    
		    Try
		      DatabaseFile.Remove
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to remove bad database file")
		      // This is a constructor. There's really nothing more we can do here, so raise the exception again.
		      Raise Err
		    End Try
		  End If
		  
		  Preferences.HardwareIdVersion = 6
		  #if UseEncryption
		    Database.EncryptionKey = Self.GenerateKey
		  #endif
		  Database.CreateDatabase
		  Database.ExecuteSQL("CREATE TABLE identities (user_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, public_key TEXT COLLATE NOCASE NOT NULL, private_key TEXT COLLATE NOCASE NOT NULL, cloud_key TEXT NOT NULL DEFAULT '', licenses TEXT NOT NULL DEFAULT '[]', username TEXT COLLATE NOCASE NOT NULL DEFAULT '', anonymous BOOLEAN NOT NULL DEFAULT TRUE, banned BOOLEAN NOT NULL DEFAULT FALSE, signature TEXT NOT NULL DEFAULT '', signature_fields TEXT NOT NULL DEFAULT '[]', expiration TEXT NOT NULL DEFAULT '', active BOOLEAN NOT NULL DEFAULT FALSE, merged BOOLEAN NOT NULL DEFAULT FALSE, subscriptions TEXT NOT NULL DEFAULT '[]');")
		  Self.mDatabase = Database
		  
		  Var MergedFolder As FolderItem = AppSupport.Child("Merged Identities")
		  If MergedFolder.Exists Then
		    For Each Child As FolderItem In MergedFolder.Children(False)
		      Var Identity As Beacon.Identity = Self.Import(Child)
		      If (Identity Is Nil) = False Then
		        #if Not DebugBuild
		          Child.Remove
		        #endif
		      End If
		    Next
		  End If
		  
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
		    Var OldIdentity As Beacon.Identity = Self.mCurrentIdentity
		    Self.mCurrentIdentity = Identity
		    Self.NotifyIdentityChange(OldIdentity, Identity)
		  End If
		  
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
		    UserCloud.Sync(False)
		  End If
		  Self.mDatabase.CommitTransaction
		  Var OldIdentity As Beacon.Identity = Self.mCurrentIdentity
		  Self.mCurrentIdentity = Value
		  
		  Self.NotifyIdentityChange(OldIdentity, Value)
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
		Function Fetch(UserId As String, AllowMerged As Boolean = True) As Beacon.Identity
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE user_id = ?1" + If(AllowMerged = False, " AND merged = FALSE", "") + ";", UserId)
		  If Rows.RowCount = 0 Then
		    Return Nil
		  End If
		  
		  Return Beacon.Identity.Load(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FetchAnonymous(Create As Boolean) As Beacon.Identity
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE anonymous = TRUE AND merged = FALSE AND banned = FALSE ORDER BY LENGTH(public_key) DESC;")
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

	#tag Method, Flags = &h21
		Private Shared Function GenerateKey() As String
		  Var Key As String = Crypto.SHA3_256("8df95865-3fac-4c79-8ee6-8ee98ca199df " + Beacon.SystemAccountName + " " + Beacon.HardwareId)
		  Return "aes256:" + Key.ReplaceAll(Chr(0), Chr(1)) // https://forum.xojo.com/t/sqlitedatabase-encryptionkey-key-derivation/76366/9?u=thom_mcgrath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Import(Dict As Dictionary) As Beacon.Identity
		  Try
		    Var UserId As String = Dict.Value("userId").StringValue
		    Var Username As String = Dict.Value("username").StringValue
		    Var IsAnonymous As Boolean = Dict.Value("isAnonymous").BooleanValue
		    Var PublicKey As String = BeaconEncryption.PEMDecodePublicKey(Dict.Value("publicKey").StringValue)
		    Var Banned As Boolean = Dict.Value("banned").BooleanValue
		    Var Expiration As String = Dict.Lookup("expiration", "").StringValue
		    Var SignatureDetails As Dictionary = Dict.Value("signature")
		    Var Signature As String = SignatureDetails.Value("signed")
		    Var SignatureFields As String = Beacon.GenerateJson(SignatureDetails.Value("fields"), False)
		    Var Licenses As String = Beacon.GenerateJSON(Dict.Value("licenses"), False)
		    Var Subscriptions As String = Beacon.GenerateJSON(Dict.Value("subscriptions"), False)
		    
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
		      Try
		        CloudKey = EncodeBase64(Crypto.RSADecrypt(DecodeBase64(Dict.Value("cloudKey").StringValue), PrivateKey), 0)
		      Catch Err As RuntimeException
		        CloudKey = EncodeBase64(ExistingIdentity.UserCloudKey)
		      End Try
		    End If
		    
		    Self.mDatabase.BeginTransaction
		    Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT user_id FROM identities WHERE user_id = ?1;", UserId)
		    If Rows.RowCount = 0 Then
		      Self.mDatabase.ExecuteSQL("INSERT INTO identities (user_id, public_key, private_key, cloud_key, licenses, username, anonymous, banned, signature, signature_fields, expiration, subscriptions) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12);", UserId, PublicKey, PrivateKey, CloudKey, Licenses, Username, IsAnonymous, Banned, Signature, SignatureFields, Expiration, Subscriptions)
		    Else
		      Self.mDatabase.ExecuteSQL("UPDATE identities SET public_key = ?2, private_key = ?3, cloud_key = ?4, licenses = ?5, username = ?6, anonymous = ?7, banned = ?8, signature = ?9, signature_fields = ?10, expiration = ?11, subscriptions = ?12 WHERE user_id = ?1;", UserId, PublicKey, PrivateKey, CloudKey, Licenses, Username, IsAnonymous, Banned, Signature, SignatureFields, Expiration, Subscriptions)
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
		    If Contents.IsEmpty Then
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
		    Var IsAnonymous As Boolean = Username.IsEmpty
		    
		    Var Expiration As String
		    If Dict.HasKey("Expiration") Then
		      Expiration = Dict.Value("Expiration")
		    End If
		    
		    Var Banned As Boolean
		    If Dict.HasKey("Banned") Then
		      Banned = Dict.Value("Banned")
		    End If
		    
		    Self.mDatabase.BeginTransaction
		    Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT user_id FROM identities WHERE user_id = ?1;", UserId)
		    If Rows.RowCount = 0 Then
		      Self.mDatabase.ExecuteSQL("INSERT INTO identities (user_id, public_key, private_key, cloud_key, licenses, username, anonymous, banned, signature, signature_fields, expiration, subscriptions) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12);", UserId, PublicKey, PrivateKey, CloudKey, "[]", Username, IsAnonymous, Banned, "", "[]", Expiration, "[]")
		    Else
		      Self.mDatabase.ExecuteSQL("UPDATE identities SET public_key = ?2, private_key = ?3, cloud_key = ?4, licenses = ?5, username = ?6, anonymous = ?7, banned = ?8, signature = ?9, signature_fields = ?10, expiration = ?11, subscriptions = ?12 WHERE user_id = ?1;", UserId, PublicKey, PrivateKey, CloudKey, "[]", Username, IsAnonymous, Banned, "", "[]", Expiration, "[]")
		    End If
		    Self.mDatabase.CommitTransaction
		    
		    Return Self.Fetch(UserId)
		  Catch Err As RuntimeException
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MarkMerged(Identity As Beacon.Identity)
		  If Identity Is Nil Then
		    Return
		  End If
		  
		  Self.mDatabase.BeginTransaction
		  Self.mDatabase.ExecuteSQL("UPDATE identities SET merged = 1 WHERE user_id = ?1;", Identity.UserId)
		  Self.mDatabase.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MergeCandidates() As Beacon.Identity()
		  Var Identities() As Beacon.Identity
		  Var Rows As RowSet = Self.mDatabase.SelectSQL("SELECT * FROM identities WHERE active = 0 AND merged = 0 AND anonymous = 1 AND banned = 0;")
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

	#tag Method, Flags = &h21
		Private Sub NotifyIdentityChange(OldIdentity As Beacon.Identity, NewIdentity As Beacon.Identity)
		  Var OldUserId As String
		  If (OldIdentity Is Nil) = False Then
		    OldUserId = OldIdentity.UserId
		  End If
		  
		  Var NewUserId As String
		  If (NewIdentity Is Nil) = False Then
		    NewUserId = NewIdentity.UserId
		  End If
		  
		  NotificationKit.Post(Self.Notification_IdentityChanged, New Dictionary("oldIdentity": OldIdentity, "newIdentity": NewIdentity, "oldUserId": OldUserId, "newUserId": NewUserId))
		End Sub
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
		      Var OldIdentity As Beacon.Identity = Self.mCurrentIdentity
		      Self.mCurrentIdentity = Nil
		      Self.NotifyIdentityChange(OldIdentity, Nil)
		      Return
		    End If
		    
		    Var Identity As Beacon.Identity = Beacon.Identity.Load(Rows)
		    Self.mDatabase.ExecuteSQL("UPDATE identities SET active = TRUE WHERE user_id = ?1;", Identity.UserId)
		    Self.mDatabase.CommitTransaction
		    Var OldIdentity As Beacon.Identity = Self.mCurrentIdentity
		    Self.mCurrentIdentity = Identity
		    Self.NotifyIdentityChange(OldIdentity, Identity)
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
