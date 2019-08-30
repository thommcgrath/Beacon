#tag Class
Protected Class IdentityManager
	#tag Method, Flags = &h21
		Private Sub APICallback_CreateUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  // When trying to save the current user, the server will reply with a failure.
		  // We should consider this a success though. So if the creation failed but the
		  // UserID and PublicKey match what we're saving, then manually consider it a success
		  Dim Success As Boolean = Response.Success
		  Try
		    If Success = False And Response.JSON IsA Dictionary Then
		      Dim Dict As Dictionary = Response.JSON
		      Dim PublicKey As String = Dict.Value("public_key")
		      Dim UserID As String = Dict.Value("user_id")
		      
		      Dim ConvertedPublicKey As MemoryBlock = BeaconEncryption.PEMDecodePublicKey(PublicKey)
		      Dim TestValue As MemoryBlock = Crypto.GenerateRandomBytes(12)
		      Dim Encrypted As MemoryBlock = Crypto.RSAEncrypt(TestValue, ConvertedPublicKey)
		      Dim Decrypted As MemoryBlock = Crypto.RSADecrypt(Encrypted, Self.mPendingIdentity.PrivateKey)
		      
		      If Self.mPendingIdentity.Identifier = UserID And TestValue = Decrypted Then
		        Success = True
		      End If
		    End If
		  Catch Err As RuntimeException
		    // This is ok even if a CryptoException happens
		  End Try
		  
		  If Success Then
		    Self.CurrentIdentity = Self.mPendingIdentity
		  End If
		  Self.mPendingIdentity = Nil
		  
		  Self.FinishProcess()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_GetSessionToken(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.Success Then
		    Try
		      Dim Dict As Dictionary = Response.JSON
		      Dim Token As String = Dict.Value("session_id")
		      Preferences.OnlineToken = Token
		      
		      Self.RefreshUserDetails()
		    Catch Err As RuntimeException
		      
		    End Try
		  End If
		  
		  Self.FinishProcess()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_MergeUser(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  #Pragma Unused Response
		  
		  Self.FinishProcess()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub APICallback_RefreshUserDetails(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  If Response.Success Then
		    Try
		      Dim Identity As Beacon.Identity
		      If Self.mUserPassword <> "" Then
		        Identity = Beacon.Identity.FromUserDictionary(Response.JSON, Self.mUserPassword)
		        Self.CurrentIdentity(False) = Identity
		      ElseIf Self.CurrentIdentity <> Nil Then
		        Identity = Self.CurrentIdentity.Clone
		        If Identity.ConsumeUserDictionary(Response.JSON) Then
		          Identity.Validate()
		          Self.CurrentIdentity(False) = Identity
		        End If
		      End If
		      UserCloud.Sync() // Will only trigger is necessary
		    Catch Err As RuntimeException
		      
		    End Try
		  ElseIf Response.HTTPStatus = 401 Or Response.HTTPStatus = 403 Then
		    // Need to get a new token
		    Self.GetSessionToken()
		  End If
		  
		  Self.FinishProcess()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Busy() As Boolean
		  Return Self.mProcessCount >= 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem)
		  Self.mFile = File
		  
		  If Self.mFile = Nil Then
		    Return
		  End If
		  
		  If Not Self.mFile.Exists Then
		    Return
		  End If
		  
		  Try
		    Dim Contents As String = Self.mFile.Read(Encodings.UTF8)
		    If Contents = "" Then
		      Return
		    End If
		    
		    Dim Dict As Dictionary = Beacon.ParseJSON(Contents)
		    Self.mCurrentIdentity = Beacon.Identity.Import(Dict)
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Create()
		  If Self.mFile = Nil Or Self.Busy Then
		    Return
		  End If
		  
		  If Not Preferences.OnlineEnabled Then
		    Self.StartProcess()
		    Self.CurrentIdentity = New Beacon.Identity()
		    Self.FinishProcess()
		    Return
		  End If
		  
		  Self.StartProcess()
		  Self.mPendingIdentity = New Beacon.Identity()
		  
		  Dim Params As New Dictionary
		  Params.Value("user_id") = Self.mPendingIdentity.Identifier
		  Params.Value("public_key") = Self.mPendingIdentity.PublicKey
		  
		  Dim Body As String = Beacon.GenerateJSON(Params, False)
		  Dim Request As New BeaconAPI.Request("user", "POST", Body, "application/json", AddressOf APICallback_CreateUser)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentIdentity() As Beacon.Identity
		  Return Self.mCurrentIdentity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CurrentIdentity(Assigns Value As Beacon.Identity)
		  Self.CurrentIdentity(True) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CurrentIdentity(CheckSessionToken As Boolean, Assigns Value As Beacon.Identity)
		  If Self.mCurrentIdentity = Value Then
		    Return
		  End If
		  
		  Dim OldUserID As String = If(Self.mCurrentIdentity <> Nil, Self.mCurrentIdentity.Identifier, "")
		  Dim NewUserID As String = If(Value <> Nil, Value.Identifier, "")
		  Dim ReplaceToken As Boolean = CheckSessionToken And OldUserID <> NewUserID
		  
		  Self.MergeIdentities(Value, Self.mCurrentIdentity)
		  Self.mCurrentIdentity = Value
		  Self.Write()
		  NotificationKit.Post(Self.Notification_IdentityChanged, Self.mCurrentIdentity)
		  
		  If ReplaceToken Then
		    Preferences.OnlineToken = ""
		    
		    If Not Preferences.OnlineEnabled Then
		      Return
		    End If
		    
		    Self.GetSessionToken()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FinishProcess()
		  Self.mProcessCount = Self.mProcessCount - 1
		  If Self.mProcessCount = 0 Then
		    RaiseEvent Finished()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetSessionToken()
		  Self.StartProcess()
		  
		  Dim Identity As Beacon.Identity = Self.CurrentIdentity
		  If Identity = Nil Then
		    RaiseEvent NeedsLogin()
		    Return
		  End If
		  
		  Dim Request As New BeaconAPI.Request("session", "POST", AddressOf APICallback_GetSessionToken)
		  Request.Sign(Identity)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As String
		  Return Self.mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MergeIdentities(Destination As Beacon.Identity, Source As Beacon.Identity)
		  If Destination = Nil Or Source = Nil Or Preferences.OnlineEnabled = False Then
		    Return
		  End If
		  
		  If Destination.Identifier = Source.Identifier Or Destination.LoginKey = "" Then
		    // Not eligible for merging
		    Return
		  End If
		  
		  Self.StartProcess()
		  
		  Dim SignedValue As String = Beacon.CreateUUID
		  Dim Signature As String = EncodeHex(Source.Sign(SignedValue))
		  
		  Dim MergeKeys As New Dictionary
		  MergeKeys.Value("user_id") = Destination.Identifier
		  MergeKeys.Value("login_key") = Destination.LoginKey
		  MergeKeys.Value("signed_value") = SignedValue
		  MergeKeys.Value("signature") = Signature
		  
		  Dim Request As New BeaconAPI.Request("user", "POST", Beacon.GenerateJSON(MergeKeys, False), "application/json", AddressOf APICallback_MergeUser)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshUserDetails(UserPassword As String = "")
		  If Preferences.OnlineEnabled = False Then
		    Return
		  End If
		  
		  If Preferences.OnlineToken = "" Then
		    Self.GetSessionToken()
		    Return
		  End If
		  
		  Self.StartProcess()
		  Self.mUserPassword = UserPassword
		  
		  Dim Fields As New Dictionary
		  Fields.Value("hardware_id") = Beacon.HardwareID
		  
		  Dim Request As New BeaconAPI.Request("user", "GET", Fields, AddressOf APICallback_RefreshUserDetails)
		  Request.Authenticate(Preferences.OnlineToken)
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartProcess()
		  Self.mProcessCount = Self.mProcessCount + 1
		  If Self.mProcessCount = 1 Then
		    RaiseEvent Started()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Write()
		  If Self.mFile = Nil Then
		    Return
		  End If
		  
		  If Self.mCurrentIdentity <> Nil Then
		    Dim Writer As New Beacon.JSONWriter(Self.mCurrentIdentity.Export, Self.mFile)
		    Writer.Start
		  Else
		    If Self.mFile.Exists Then
		      Self.mFile.Remove
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NeedsLogin()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCurrentIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPendingIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProcessCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserPassword As String
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
