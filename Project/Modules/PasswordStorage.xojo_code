#tag Module
Protected Module PasswordStorage
	#tag Method, Flags = &h1
		Protected Sub RemovePassword(EmailOrUserId As String)
		  #if TargetMacOS
		    #Pragma BreakOnExceptions False
		    Try
		      Var Item As New KeyChainItem
		      Item.ServiceName = "Beacon"
		      If v4UUID.IsValid(EmailOrUserId) Then
		        Item.AccountName = EmailOrUserId
		      Else
		        Item.Label = EmailOrUserId
		      End If
		      Call System.KeyChain.FindPassword(Item)
		      Item.Remove
		    Catch Err As KeychainException
		      // Not found
		    End Try
		  #else
		    Var SavedPasswords As Dictionary = Preferences.SavedPasswords
		    
		    Var UserId As String
		    If v4UUID.IsValid(EmailOrUserId) Then
		      UserId = EmailOrUserId
		    Else
		      For Each Entry As DictionaryEntry In SavedPasswords
		        Try
		          Var Dict As Dictionary = Entry.Value
		          If Dict.Lookup("email", "") = EmailOrUserId Then
		            UserId = Dict.Key
		            Exit
		          End If
		        Catch Err As RuntimeException
		          App.Log(Err, CurrentMethodName, "Looping over saved passwords")
		        End Try
		      Next
		    End If
		    
		    If SavedPasswords.HasKey(UserId) Then
		      SavedPasswords.Remove(UserId)
		      Preferences.SavedPasswords = SavedPasswords
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RetrievePassword(EmailOrUserId As String) As String
		  #if TargetMacOS
		    #Pragma BreakOnExceptions False
		    Try
		      Var Item As New KeyChainItem
		      Item.ServiceName = "Beacon"
		      If v4UUID.IsValid(EmailOrUserId) Then
		        Item.AccountName = EmailOrUserId
		      Else
		        Item.Label = EmailOrUserId
		      End If
		      Return System.KeyChain.FindPassword(Item)
		    Catch Err As KeychainException
		      Return ""
		    End Try
		  #else
		    Var PasswordData As Dictionary
		    Var SavedPasswords As Dictionary = Preferences.SavedPasswords
		    If SavedPasswords.HasKey(EmailOrUserId) Then
		      PasswordData = SavedPasswords.Value(EmailOrUserId)
		    Else
		      For Each Entry As DictionaryEntry In SavedPasswords
		        Try
		          Var Dict As Dictionary = Entry.Value
		          If Dict.Lookup("email", "") = EmailOrUserId Then
		            PasswordData = Dict
		            Exit
		          End If
		        Catch Err As RuntimeException
		          App.Log(Err, CurrentMethodName, "Looping over saved passwords")
		        End Try
		      Next
		    End If
		    
		    If PasswordData Is Nil Then
		      Return ""
		    End If
		    
		    Var Encrypted As String = DecodeBase64(PasswordData.Lookup("password", ""))
		    Try
		      Var Decrypted As String = BeaconEncryption.SymmetricDecrypt(Beacon.HardwareID, Encrypted)
		      Return Decrypted
		    Catch Err As CryptoException
		      Return ""
		    End Try
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SavePassword(Email As String, UserId As String, Password As String) As Boolean
		  #if TargetMacOS
		    RemovePassword(UserId)
		    RemovePassword(Email)
		    
		    Var Item As New KeyChainItem
		    Item.Label = Email
		    Item.ServiceName = "Beacon"
		    Item.AccountName = UserId
		    Try
		      System.KeyChain.AddPassword(Item, Password)
		      Return True
		    Catch Err As KeyChainException
		      App.Log(Err, CurrentMethodName, "Saving keychain item")
		      Return False
		    End Try
		  #else
		    Var PasswordData As New Dictionary
		    PasswordData.Value("email") = Email
		    PasswordData.Value("password") = EncodeBase64(BeaconEncryption.SymmetricEncrypt(Beacon.HardwareID, Password), 0)
		    
		    Var SavedPasswords As Dictionary = Preferences.SavedPasswords
		    SavedPasswords.Value(UserId) = PasswordData
		    Preferences.SavedPasswords = SavedPasswords
		    
		    Return True
		  #endif
		End Function
	#tag EndMethod


End Module
#tag EndModule
