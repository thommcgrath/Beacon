#tag Class
Protected Class HostConfig
Inherits Beacon.HostConfig
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, Version As Integer)
		  #Pragma Unused Version
		  
		  Self.mHost = SaveData.Value("host")
		  Self.mPort = SaveData.Value("port")
		  Self.mUsername = SaveData.Value("user")
		  Self.mPassword = SaveData.Value("pass")
		  Self.mMode = SaveData.Lookup("mode", Beacon.FTPModeOptionalTLS)
		  Self.mVerifyHost = SaveData.Lookup("verifyHost", True)
		  Self.mPrivateKey = SaveData.Lookup("privateKey", "")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary)
		  SaveData.Value("host") = Self.mHost
		  SaveData.Value("port") = Self.mPort
		  SaveData.Value("user") = Self.mUsername
		  SaveData.Value("pass") = Self.mPassword
		  SaveData.Value("mode") = Self.mMode
		  SaveData.Value("verifyHost") = Self.mVerifyHost
		  
		  If Self.mPrivateKey.IsEmpty = False Then
		    SaveData.Value("privateKey") = Self.mPrivateKey
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Host() As String
		  Return Self.mHost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Host(Assigns Value As String)
		  If Self.mHost.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mHost = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPrivateKeyInternal() As Boolean
		  Return Self.mPrivateKey.BeginsWith("---")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsPrivateKeyInternal(Assigns Value As Boolean)
		  If Value = Self.IsPrivateKeyInternal Then
		    Return
		  End If
		  
		  Var PrivateKeyFile As FolderItem = Self.PrivateKeyFile
		  If PrivateKeyFile Is Nil Then
		    Return
		  End If
		  
		  Self.PrivateKeyFile(Value) = PrivateKeyFile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As String
		  Return Self.mMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mode(Assigns Value As String)
		  Select Case Value
		  Case Beacon.FTPModeOptionalTLS, Beacon.FTPModeExplicitTLS, Beacon.FTPModeSSH, Beacon.FTPModeImplicitTLS, Beacon.FTPModeInsecure
		    // Whitelist
		  Else
		    Value = Beacon.FTPModeOptionalTLS
		  End Select
		  
		  If Self.mMode.Compare(Value, ComparisonOptions.CaseSensitive) = 0 Then
		    Return
		  End If
		  
		  Self.mMode = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Password() As String
		  Return Self.mPassword
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Password(Assigns Value As String)
		  If Self.mPassword.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mPassword = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Port() As Integer
		  If Self.mPort = 0 Then
		    Self.mPort = 21
		  End If
		  Return Self.mPort
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Port(Assigns Value As Integer)
		  If Value = 0 Then
		    Value = 21
		  End If
		  If Self.mPort <> Value Then
		    Self.mPort = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrepareKeyFile()
		  If (Self.mPrivateKeyFile Is Nil) = False Or Self.mPrivateKey.IsEmpty Then
		    Return
		  End If
		  
		  If Self.IsPrivateKeyInternal Then
		    // Plain key
		    Var KeysFolder As FolderItem = App.ApplicationSupport.Child("Private Keys")
		    If KeysFolder.Exists = False Then
		      Var Permissions As New Permissions(&o700)
		      Permissions.GidBit = False
		      Permissions.StickyBit = False
		      Permissions.UidBit = False
		      
		      KeysFolder.CreateFolder
		      KeysFolder.Permissions = Permissions
		    End If
		    
		    Var KeyId As String = Beacon.UUID.v5(Self.mPrivateKey, "b763e1c2-809e-45c7-bce4-1d3a7a07ec1f")
		    
		    Self.mPrivateKeyFile = KeysFolder.Child(KeyId)
		    
		    If Self.mPrivateKeyFile.Exists = False Then
		      Call Self.mPrivateKeyFile.Write(Self.mPrivateKey)
		    End If
		  Else
		    // File reference
		    Self.mPrivateKeyFile = BookmarkedFolderItem.FromSaveInfo(Beacon.Decompress(DecodeBase64(Self.mPrivateKey)), True)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKeyFile() As FolderItem
		  Self.PrepareKeyFile()
		  Return Self.mPrivateKeyFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrivateKeyFile(Assigns PrivateKey As String)
		  Self.mPrivateKey = PrivateKey
		  Self.mPrivateKeyFile = Nil
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrivateKeyFile(Internalize As Boolean = False, Assigns PrivateKey As FolderItem)
		  If PrivateKey Is Nil Or PrivateKey.Exists = False Or PrivateKey.IsFolder Then
		    Self.mPrivateKey = ""
		    Self.mPrivateKeyFile = Nil
		    Self.Modified = True
		    Return
		  End If
		  
		  If Internalize Then
		    Self.PrivateKeyFile = PrivateKey.Read(Encodings.UTF8)
		    Return
		  End If
		  
		  Var BookmarkedPrivateKey As New BookmarkedFolderItem(PrivateKey)
		  Self.mPrivateKey = EncodeBase64(Beacon.Compress(BookmarkedPrivateKey.SaveInfo(True)), 0)
		  Self.mPrivateKeyFile = BookmarkedPrivateKey
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderId() As String
		  Return FTP.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Username() As String
		  Return Self.mUsername
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Username(Assigns Value As String)
		  If Self.mUsername.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mUsername = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VerifyHost() As Boolean
		  Return Self.mVerifyHost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyHost(Assigns Value As Boolean)
		  If Self.mVerifyHost <> Value Then
		    Self.mVerifyHost = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHost As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMode As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrivateKeyFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVerifyHost As Boolean
	#tag EndProperty


End Class
#tag EndClass
