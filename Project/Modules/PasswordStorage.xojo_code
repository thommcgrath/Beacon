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
		            UserId = Entry.Key
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
		    Var UserId As String
		    If SavedPasswords.HasKey(EmailOrUserId) Then
		      PasswordData = SavedPasswords.Value(EmailOrUserId)
		      UserId = EmailOrUserId
		    Else
		      For Each Entry As DictionaryEntry In SavedPasswords
		        Try
		          Var Dict As Dictionary = Entry.Value
		          If Dict.Lookup("email", "") = EmailOrUserId Then
		            UserId = Entry.Key
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
		    
		    Try
		      Var Email As String = PasswordData.Lookup("email", "")
		      Return BeaconEncryption.SlowDecrypt(Email.Lowercase + " " + UserId.Lowercase + " " + Beacon.SystemAccountName + " " + Beacon.HardwareID, PasswordData.Lookup("password", ""))
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
		    PasswordData.Value("password") = BeaconEncryption.SlowEncrypt(Email.Lowercase + " " + UserId.Lowercase + " " + Beacon.SystemAccountName + " " + Beacon.HardwareID, Password)
		    
		    Var SavedPasswords As Dictionary = Preferences.SavedPasswords
		    SavedPasswords.Value(UserId) = PasswordData
		    Preferences.SavedPasswords = SavedPasswords
		    
		    Return True
		  #endif
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
