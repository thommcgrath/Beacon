#tag Class
Protected Class ExternalAccountManager
	#tag Method, Flags = &h0
		Sub Add(Account As Beacon.ExternalAccount)
		  If Account = Nil Then
		    Return
		  End If
		  
		  If Self.mAccounts.HasKey(Account.UUID.StringValue) Then
		    Var CurrentAccount As Beacon.ExternalAccount = Self.mAccounts.Value(Account.UUID.StringValue)
		    If Account = CurrentAccount Then
		      Return
		    End If
		  End If
		  
		  Self.mAccounts.Value(Account.UUID.StringValue) = Account
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function All() As Beacon.ExternalAccount()
		  Var Accounts() As Beacon.ExternalAccount
		  For Each Entry As DictionaryEntry In Self.mAccounts
		    Accounts.AddRow(Entry.Value)
		  Next
		  Return Accounts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsDictionary() As Dictionary
		  // Why is the data organized this way when it could just return an array of dictionaries?
		  // Simple: future-proofing. If there is ever a reason to add even a single additional value
		  // that needs to be stored, this organization choice will make it trivial.
		  
		  Var Accounts() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mAccounts
		    Accounts.AddRow(Beacon.ExternalAccount(Entry.Value).AsDictionary)
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("Accounts") = Accounts
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mAccounts = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mAccounts.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ForProvider(Provider As String) As Beacon.ExternalAccount()
		  Var Accounts() As Beacon.ExternalAccount
		  For Each Entry As DictionaryEntry In Self.mAccounts
		    If Beacon.ExternalAccount(Entry.Value).Provider = Provider Then
		      Accounts.AddRow(Entry.Value)
		    End If
		  Next
		  Return Accounts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDict(Dict As Dictionary) As Beacon.ExternalAccountManager
		  If Not Dict.HasKey("Accounts") Then
		    Return Nil
		  End If
		  
		  Var Accounts() As Variant = Dict.Value("Accounts")
		  Var Manager As New Beacon.ExternalAccountManager
		  For Each AccountDict As Variant In Accounts
		    If IsNull(AccountDict) Or AccountDict.Type <> Variant.TypeObject Or (AccountDict.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Account As Beacon.ExternalAccount = Beacon.ExternalAccount.FromDictionary(AccountDict)
		    If IsNull(Account) Then
		      Continue
		    End If
		    
		    Manager.mAccounts.Value(Account.UUID.StringValue) = Account
		  Next
		  
		  Return Manager
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromLegacyDict(Dict As Dictionary) As Beacon.ExternalAccountManager
		  Var Manager As New Beacon.ExternalAccountManager
		  For Each Entry As DictionaryEntry In Dict
		    Var Provider As String = Entry.Key
		    Var ProviderDict As Dictionary = Entry.Value
		    Var AccessToken As String = ProviderDict.Value("Access Token")
		    Var RefreshToken As String = ProviderDict.Value("Refresh Token")
		    Var Expiration As Double = ProviderDict.Value("Expiration")
		    
		    Manager.Add(New Beacon.ExternalAccount(New v4UUID, Provider, AccessToken, RefreshToken, Expiration))
		  Next
		  Return Manager
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetByUUID(UUID As v4UUID) As Beacon.ExternalAccount
		  If Self.mAccounts.HasKey(UUID.StringValue) Then
		    Return Self.mAccounts.Value(UUID.StringValue)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Other As Beacon.ExternalAccountManager)
		  If Other = Nil Then
		    Return
		  End If
		  
		  Var Accounts() As Beacon.ExternalAccount = Other.All
		  For Each Account As Beacon.ExternalAccount In Accounts
		    Self.Add(Account)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Account As Beacon.ExternalAccount)
		  Self.Remove(Account.UUID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(UUID As v4UUID)
		  If Self.mAccounts.HasKey(UUID.StringValue) Then
		    Self.mAccounts.Remove(UUID.StringValue)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccounts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty


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
