#tag Class
Protected Class App
Inherits Application
	#tag Method, Flags = &h0
		Function APIKey() As String
		  Dim File As FolderItem = Self.ApplicationSupport.Child("Key.json")
		  If File.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Dim Item As New JSONItem(Contents)
		    If Item.HasName("apikey") Then
		      Return Item.Value("apikey").StringValue
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplicationSupport() As FolderItem
		  Dim AppSupport As FolderItem = SpecialFolder.ApplicationData
		  Dim CompanyFolder As FolderItem = AppSupport.Child("The ZAZ")
		  Self.CheckFolder(CompanyFolder)
		  Dim AppFolder As FolderItem = CompanyFolder.Child("Beacon Release Tool")
		  Self.CheckFolder(AppFolder)
		  Return AppFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckFolder(Folder As FolderItem)
		  If Folder.Exists Then
		    If Not Folder.Directory Then
		      Folder.Delete
		      Folder.CreateAsFolder
		    End If
		  Else
		    Folder.CreateAsFolder
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateKey() As String
		  Dim File As FolderItem = Self.ApplicationSupport.Child("Key.json")
		  If File.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Contents As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Dim Item As New JSONItem(Contents)
		    Dim Key As String = Item.Value("private").StringValue
		    If Not Crypto.RSAVerifyKey(Key) Then
		      Raise New CryptoException
		    End If
		    Return Key
		  Else
		    Dim PrivateKey, PublicKey As String
		    If Not Crypto.RSAGenerateKeyPair(2048, PrivateKey, PublicKey) Then
		      Raise New CryptoException
		    End If
		    If Not Crypto.RSAVerifyKey(PrivateKey) Then
		      Raise New CryptoException
		    End If
		    If Not Crypto.RSAVerifyKey(PublicKey) Then
		      Raise New CryptoException
		    End If
		    
		    Dim Item As New JSONItem()
		    Item.Value("private") = PrivateKey
		    Item.Value("public") = PublicKey
		    Item.Compact = False
		    
		    Dim Stream As TextOutputStream = TextOutputStream.Create(File)
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
