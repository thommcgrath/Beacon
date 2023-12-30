#tag Module
Protected Module PasswordStorage
	#tag Method, Flags = &h1
		Protected Sub RemovePassword(EmailOrUserId As String)
		  #if TargetMacOS
		    #Pragma BreakOnExceptions False
		    Try
		      Var Item As New KeyChainItem
		      Item.ServiceName = "Beacon"
		      If Beacon.UUID.Validate(EmailOrUserId) Then
		        Item.AccountName = EmailOrUserId
		      Else
		        Item.Label = EmailOrUserId
		      End If
		      Call System.KeyChain.FindPassword(Item)
		      Item.Remove
		    Catch Err As RuntimeException
		      // Not found
		    End Try
		  #else
		    Var SavedPasswords As JSONItem = Preferences.SavedPasswords
		    
		    Var UserId As String
		    If Beacon.UUID.Validate(EmailOrUserId) Then
		      UserId = EmailOrUserId
		    Else
		      Var Keys() As String = SavedPasswords.Keys
		      For Each Key As String In Keys
		        Try
		          Var Child As JSONItem = SavedPasswords.Child(Key)
		          If Child.Lookup("email", "") = EmailOrUserId Then
		            UserId = Key
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
		      Var IsAccountId As Boolean = Beacon.UUID.Validate(EmailOrUserId)
		      
		      Var Item As New KeyChainItem
		      Item.ServiceName = "Beacon"
		      If IsAccountId Then
		        Item.AccountName = EmailOrUserId
		      Else
		        Item.Label = EmailOrUserId
		      End If
		      
		      Var Password As String = System.KeyChain.FindPassword(Item)
		      If (IsAccountId And Item.AccountName = EmailOrUserId) Or (IsAccountId = False And Item.Label = EmailOrUserId) Then
		        Return Password
		      End If
		    Catch Err As RuntimeException
		      Return ""
		    End Try
		  #else
		    Var PasswordData As JSONItem
		    Var SavedPasswords As JSONItem = Preferences.SavedPasswords
		    Var UserId As String
		    If SavedPasswords.HasKey(EmailOrUserId) Then
		      PasswordData = SavedPasswords.Value(EmailOrUserId)
		      UserId = EmailOrUserId
		    Else
		      Var Keys() As String = SavedPasswords.Keys
		      For Each Key As String In Keys
		        Try
		          Var Child As JSONItem = SavedPasswords.Child(Key)
		          If Child.Lookup("email", "") = EmailOrUserId Then
		            UserId = Key
		            PasswordData = Child
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
		      Return BeaconEncryption.SlowDecrypt(Email.Lowercase + " " + UserId.Lowercase + " " + Beacon.SystemAccountName + " " + Beacon.HardwareId, PasswordData.Lookup("password", ""))
		    Catch Err As RuntimeException
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
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Saving keychain item")
		      Return False
		    End Try
		  #else
		    Var PasswordData As New JSONItem
		    PasswordData.Value("email") = Email
		    PasswordData.Value("password") = BeaconEncryption.SlowEncrypt(Email.Lowercase + " " + UserId.Lowercase + " " + Beacon.SystemAccountName + " " + Beacon.HardwareId, Password)
		    
		    Var SavedPasswords As JSONItem = Preferences.SavedPasswords
		    SavedPasswords.Child(UserId) = PasswordData
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
