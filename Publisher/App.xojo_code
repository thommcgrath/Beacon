#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Method, Flags = &h0
		Function APIKey() As String
		  Var File As FolderItem = Self.ApplicationSupport.Child("Key.json")
		  If File.Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Var Parsed As Dictionary = Xojo.ParseJSON(Contents)
		    If Parsed.HasKey("apikey") Then
		      Return Parsed.Value("apikey").StringValue
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  Var AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Var CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Self.CheckFolder(CompanyFolder)
		  Var AppFolder As FolderItem = CompanyFolder.Child("Beacon Release Tool")
		  Self.CheckFolder(AppFolder)
		  Return AppFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As FolderItem)
		  If Folder.Exists Then
		    If Not Folder.IsFolder Then
		      Folder.Remove
		      Folder.CreateFolder
		    End If
		  Else
		    Folder.CreateFolder
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey() As String
		  Var File As FolderItem = Self.ApplicationSupport.Child("Key.json")
		  If File.Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Var Item As New JSONItem(Contents)
		    Var Key As String = Item.Value("private").StringValue
		    If Not Crypto.RSAVerifyKey(Key) Then
		      Raise New CryptoException
		    End If
		    Return Key
		  Else
		    Var PrivateKey, PublicKey As String
		    If Not Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) Then
		      Raise New CryptoException
		    End If
		    If Not Crypto.RSAVerifyKey(PrivateKey) Then
		      Raise New CryptoException
		    End If
		    If Not Crypto.RSAVerifyKey(PublicKey) Then
		      Raise New CryptoException
		    End If
		    
		    Var Item As New JSONItem()
		    Item.Value("private") = PrivateKey
		    Item.Value("public") = PublicKey
		    Item.Compact = False
		    
		    Var Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(Item.ToString)
		    Stream.Close
		    
		    Return PrivateKey
		  End If
		End Function
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
