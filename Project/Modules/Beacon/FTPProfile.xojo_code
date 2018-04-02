#tag Class
Protected Class FTPProfile
	#tag Method, Flags = &h21
		Private Shared Function Clone(Source As Xojo.Core.Dictionary) As Xojo.Core.Dictionary
		  // This method only exists because the built-in clone method causes crashes.
		  // However, this only handles basic cases.
		  
		  If Source = Nil Then
		    // That was easy
		    Return Nil
		  End If
		  
		  Dim Clone As New Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Source
		    Clone.Value(Entry.Key) = Entry.Value
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.FTPProfile)
		  Self.Constructor()
		  
		  If Source <> Nil Then
		    Self.mHost = Source.mHost
		    Self.mPort = Source.mPort
		    Self.mUsername = Source.mUsername
		    Self.mPassword = Source.mPassword
		    Self.mPath = Source.mPath
		    Self.mDescription = Source.mDescription
		    Self.mCacheDictionary = Self.Clone(Source.mCacheDictionary)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DescriptiveHost() As Text
		  Dim Output As Text = Self.Username + "@" + Self.Host
		  If Self.Port <> 21 Then
		    Output = Output + ":" + Self.Port.ToText
		  End If
		  Return Output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Shared Function FromDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity) As Beacon.FTPProfile
		  If Not Dict.HasAllKeys("Key", "Vector", "Details") Then
		    Return Nil
		  End If
		  
		  Dim Key As Xojo.Core.MemoryBlock = Identity.Decrypt(Beacon.DecodeHex(Dict.Value("Key")))
		  If Key = Nil Then
		    Return Nil
		  End If
		  Dim Vector As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Dict.Value("Vector"))
		  Dim Encrypted As Xojo.Core.MemoryBlock = Beacon.DecodeHex(Dict.Value("Details"))
		  Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		  AES.SetKey(Beacon.ConvertMemoryBlock(Key))
		  AES.SetInitialVector(Beacon.ConvertMemoryBlock(Vector))
		  
		  Dim Decrypted As String
		  Try
		    Decrypted = AES.DecryptCBC(Beacon.ConvertMemoryBlock(Encrypted))
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		  
		  If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		    Return Nil
		  End If
		  Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		  
		  Dim CacheDict As Xojo.Core.Dictionary = Clone(Dict)
		  
		  Try
		    Dict = Xojo.Data.ParseJSON(Decrypted.ToText)
		  Catch Err As Xojo.Data.InvalidJSONException
		    Return Nil
		  End Try
		  
		  If Not Dict.HasAllKeys("Host", "Port", "User", "Pass", "Path", "Description") Then
		    Return Nil
		  End If
		  
		  Dim Profile As New Beacon.FTPProfile
		  Profile.mHost = Dict.Value("Host")
		  Profile.mPort = Dict.Value("Port")
		  Profile.mUsername = Dict.Value("User")
		  Profile.mPassword = Dict.Value("Pass")
		  Profile.mPath = Dict.Value("Path")
		  Profile.mDescription = Dict.Value("Description")
		  Profile.mCacheDictionary = CacheDict
		  Return Profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Text
		  Return Beacon.EncodeHex(Xojo.Crypto.MD5(Xojo.Core.TextEncoding.UTF8.ConvertTextToData(Self.QueryString)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.FTPProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.Hash = Other.Hash Then
		    Return 0
		  End If
		  
		  Return Self.DescriptiveHost.Compare(Other.DescriptiveHost)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QueryString() As Text
		  Dim Pieces() As Text
		  Pieces.Append("host=" + Beacon.EncodeURLComponent(Self.Host))
		  Pieces.Append("port=" + Self.Port.ToText)
		  Pieces.Append("user=" + Beacon.EncodeURLComponent(Self.Username))
		  Pieces.Append("pass=" + Beacon.EncodeURLComponent(Self.Password))
		  Pieces.Append("path=" + Beacon.EncodeURLComponent(Self.Path))
		  Return Text.Join(Pieces, "&")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Function ToDictionary(Identity As Beacon.Identity) As Xojo.Core.Dictionary
		  If Self.mCacheDictionary <> Nil Then
		    Return Self.Clone(Self.mCacheDictionary)
		  End If
		  
		  Dim Dict As New Xojo.Core.Dictionary
		  Dict.Value("Host") = Self.Host
		  Dict.Value("Port") = Self.Port
		  Dict.Value("User") = Self.Username
		  Dict.Value("Pass") = Self.Password
		  Dict.Value("Path") = Self.Path
		  Dict.Value("Description") = Self.Description
		  Dim Content As String = Xojo.Data.GenerateJSON(Dict)
		  
		  Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		  Dim Key As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(128)
		  Dim Vector As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		  AES.SetKey(Beacon.ConvertMemoryBlock(Key))
		  AES.SetInitialVector(Beacon.ConvertMemoryBlock(Vector))
		  Dim Encrypted As String = AES.EncryptCBC(Content)
		  
		  Dict = New Xojo.Core.Dictionary
		  Dict.Value("Key") = Beacon.EncodeHex(Identity.Encrypt(Key))
		  Dict.Value("Vector") = Beacon.EncodeHex(Vector)
		  Dict.Value("Details") = EncodeHex(Encrypted).ToText
		  Self.mCacheDictionary = Self.Clone(Dict)
		  Return Dict
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDescription
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDescription.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mDescription = Value
			    Self.mCacheDictionary = Nil
			  End If
			End Set
		#tag EndSetter
		Description As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHost
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHost.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mHost = Value
			    Self.mCacheDictionary = Nil
			  End If
			End Set
		#tag EndSetter
		Host As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCacheDictionary As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHost As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPath As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPassword.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mPassword = Value
			    Self.mCacheDictionary = Nil
			  End If
			End Set
		#tag EndSetter
		Password As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPath.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mPath = Value
			    Self.mCacheDictionary = Nil
			  End If
			End Set
		#tag EndSetter
		Path As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mPort = 0 Then
			    Self.mPort = 21
			  End If
			  Return Self.mPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = 0 Then
			    Value = 21
			  End If
			  If Self.mPort <> Value Then
			    Self.mPort = Value
			    Self.mCacheDictionary = Nil
			  End If
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUsername
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mUsername.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mUsername = Value
			    Self.mCacheDictionary = Nil
			  End If
			End Set
		#tag EndSetter
		Username As Text
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Host"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Path"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
