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
		Function DSAKey() As Chilkat.DSA
		  Var File As FolderItem = Self.ApplicationSupport.Child("DSA.pem")
		  If File.Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As MemoryBlock = Stream.ReadAll
		    Stream.Close
		    
		    Var DSA As New Chilkat.DSA
		    If DSA.FromPem(Contents) = False Or DSA.VerifyKey = False Then
		      System.DebugLog(DSA.LastErrorText)
		      Return Nil
		    End If
		    
		    Return DSA
		  Else
		    Var DSA As New Chilkat.DSA
		    If DSA.GenKey(2048) = False Then
		      System.DebugLog(DSA.LastErrorText)
		      Return Nil
		    End If
		    
		    Var PEM As String = DSA.ToPem
		    If DSA.LastMethodSuccess = False Then
		      System.DebugLog(DSA.LastErrorText)
		      Return Nil
		    End If
		    Var Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(PEM)
		    Stream.Close
		    
		    Return DSA
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EdDSAKey() As Chilkat.PrivateKey
		  Var File As FolderItem = Self.ApplicationSupport.Child("EdDSA.pem")
		  If File.Exists Then
		    Var Stream As TextInputStream = TextInputStream.Open(File)
		    Var Contents As MemoryBlock = Stream.ReadAll
		    Stream.Close
		    
		    Var Key As New Chilkat.PrivateKey
		    If Key.LoadPem(Contents) = False Then
		      System.DebugLog(Key.LastErrorText)
		      Return Nil
		    End If
		    
		    Return Key
		  Else
		    Var Key As New Chilkat.PrivateKey
		    Var Generator As New Chilkat.Prng
		    Var EdDSA As New Chilkat.EdDSA
		    If EdDSA.GenEd25519Key(Generator, Key) = False Then
		      System.DebugLog(EdDSA.LastErrorText)
		      Return Nil
		    End If
		    
		    Var PEM As String = Key.GetPkcs8Pem
		    If Key.LastMethodSuccess = False Then
		      System.DebugLog(Key.LastErrorText)
		      Return Nil
		    End If
		    Var Stream As TextOutputStream = TextOutputStream.Create(File)
		    Stream.Write(PEM)
		    Stream.Close
		    
		    Return Key
		  End If
		End Function
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
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
