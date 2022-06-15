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
		Sub Constructor(Contents As MemoryBlock, URL As String, Arch As Integer, Platform As String)
		  Select Case Platform
		  Case Self.PlatformLinux, Self.PlatformMac, Self.PlatformWindows
		    Self.mContents = Contents
		    Self.mChecksum = EncodeHex(Crypto.SHA2_256(Contents)).Lowercase
		    
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
