#tag Class
Protected Class Download
	#tag Method, Flags = &h0
		Sub AddSignature(Signature As DownloadSignature)
		  If Signature Is Nil Then
		    Return
		  End If
		  
		  Self.mSignatures.Value(Signature.Format) = Signature
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Arch() As Integer
		  Return Self.mArch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Checksum() As String
		  Return Self.mChecksum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem, URL As String, Arch As Integer, Platform As String)
		  Select Case Platform
		  Case Self.PlatformLinux, Self.PlatformMac, Self.PlatformWindows
		    Self.mFile = File
		    
		    Self.mPlatform = Platform
		    Self.mArch = Arch And (Self.ArchARM64 Or Self.ArchIntel32 Or Self.ArchIntel64)
		    Self.mSignatures = New Dictionary
		    Self.mURL = URL
		    Self.mUUID = New v4UUID
		    
		    Var Regex As New Regex
		    Regex.SearchPattern = "^https://[^/]+/(.+)/([^\?]+)"
		    
		    Var Matches As RegexMatch = Regex.Search(URL)
		    Self.mPath = Matches.SubExpressionString(1)
		    Self.mFilename = Matches.SubExpressionString(2)
		  Else
		    Var Err As New UnsupportedFormatException
		    Err.Message = "Unsupported platform specified"
		    Raise Err
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contents() As MemoryBlock
		  Return Self.mContents
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Filename() As String
		  Return Self.mFilename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Loaded() As Boolean
		  Return (Self.mContents Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadFromDisk() As Boolean
		  Const ChunkSize = 256000
		  Var Stream As BinaryStream = BinaryStream.Open(Self.mFile, False)
		  Var Contents As New MemoryBlock(CType(Stream.Length, Integer))
		  Var Offset As Integer = 0
		  While Stream.EndOfFile = False
		    Var ReadBytes As Integer = Min(ChunkSize, CType(Stream.Length, Integer) - Offset)
		    Contents.StringValue(Offset, ReadBytes) = Stream.Read(ReadBytes, Nil)
		    Offset = Offset + ReadBytes
		    Thread.Current.Sleep(1)
		  Wend
		  Stream.Close
		  
		  Self.mContents = Contents
		  Self.mChecksum = EncodeHex(Crypto.SHA2_256(Contents)).Lowercase
		  
		  Var RSAKey As String = App.PrivateKey
		  Var RSASignature As String = Self.SignRSA(RSAKey, Contents)
		  If RSASignature.IsEmpty Then
		    Return False
		  End If
		  Var DSASignature As String = Self.SignDSA(Self.mFile)
		  If DSASignature.IsEmpty Then
		    Return False
		  End If
		  Var EdDSASignature As String = Self.SignEdDSA(Self.mFile)
		  If EdDSASignature.IsEmpty Then
		    Return False
		  End If
		  
		  Self.AddSignature(New DownloadSignature(RSASignature, DownloadSignature.SignatureRSA))
		  Self.AddSignature(New DownloadSignature(DSASignature, DownloadSignature.SignatureDSA))
		  Self.AddSignature(New DownloadSignature(EdDSASignature, DownloadSignature.SignatureEdDSA))
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Platform() As String
		  Return Self.mPlatform
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveSignature(Signature As DownloadSignature)
		  If Signature Is Nil Then
		    Return
		  End If
		  
		  If Self.mSignatures.HasKey(Signature.Format) Then
		    Self.mSignatures.Remove(Signature.Format)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Signatures() As DownloadSignature()
		  Var Arr() As DownloadSignature
		  For Each Entry As DictionaryEntry In Self.mSignatures
		    Arr.Add(Entry.Value)
		  Next Entry
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SignDSA(File As FolderItem) As String
		  Var Sh As New Shell
		  Sh.Execute(App.SignTool(True).ShellPath + " " + File.ShellPath + " " + App.ApplicationSupport.Child("dsa_priv.pem").ShellPath)
		  Return Sh.Result.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SignEdDSA(File As FolderItem) As String
		  Var Sh As New Shell
		  Sh.Execute(App.SignTool(False).ShellPath + " -f " + App.ApplicationSupport.Child("ed25519").ShellPath + " " + File.ShellPath)
		  
		  Var Result As String = Sh.Result.Trim
		  Var StartPos As Integer = Result.IndexOf("sparkle:edSignature=""")
		  If StartPos = -1 Then
		    // There is a problem
		    Return ""
		  End If
		  
		  StartPos = StartPos + 21
		  Var EndPos As Integer = Result.IndexOf(StartPos, """")
		  If EndPos = -1 Then
		    // What?
		    EndPos = Result.Length
		  End If
		  
		  Return Result.Middle(StartPos, EndPos - StartPos)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SignRSA(Key As String, Content As MemoryBlock) As String
		  Return EncodeHex(Crypto.RSASign(Content, Key)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SuggestedPath(Arch As Integer, Platform As String) As String
		  Var Pieces() As String
		  If (Arch And ArchARM64) = ArchARM64 Then
		    Pieces.Add("arm64")
		  End If
		  If (Arch And ArchIntel64) = ArchIntel64 Then
		    Pieces.Add("x64")
		  End If
		  If (Arch And ArchIntel32) = ArchIntel32 Then
		    Pieces.Add("x86")
		  End If
		  Var Path As String = String.FromArray(Pieces, "_")
		  
		  Select Case Platform
		  Case PlatformMac
		    Return Path + "/Beacon.dmg"
		  Case PlatformWindows
		    Return Path + "/Install_Beacon.exe"
		  Case PlatformLinux
		    Return Path + "/Beacon.rpm" // No idea...
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function URL() As String
		  Return Self.mURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mArch As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChecksum As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContents As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlatform As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignatures As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
	#tag EndProperty


	#tag Constant, Name = ArchARM64, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ArchIntel32, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ArchIntel64, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformLinux, Type = String, Dynamic = False, Default = \"Linux", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformMac, Type = String, Dynamic = False, Default = \"macOS", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PlatformWindows, Type = String, Dynamic = False, Default = \"Windows", Scope = Public
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
