#tag Class
Protected Class CustomContent
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  Self.mGameIniContent = Self.ReadContent(Dict.Lookup("Game.ini", ""), Identity)
		  Self.mGameUserSettingsIniContent = Self.ReadContent(Dict.Lookup("GameUserSettings.ini", ""), Identity)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  Dict.Value("Game.ini") = Self.WriteContent(Self.mGameIniContent, Identity)
		  Dict.Value("GameUserSettings.ini") = Self.WriteContent(Self.mGameUserSettingsIniContent, Identity)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "CustomContent"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decrypt(Input As Text, Identity As Beacon.Identity) As Text
		  Try
		    Dim SecureDict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Input)
		    If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		      Return ""
		    End If
		    
		    Dim Key As Xojo.Core.MemoryBlock = Identity.Decrypt(Beacon.DecodeHex(SecureDict.Value("Key")))
		    If Key = Nil Then
		      Return ""
		    End If
		    
		    Dim ExpectedHash As Text = SecureDict.Value("Hash")
		    Dim Vector As Xojo.Core.MemoryBlock = Beacon.DecodeHex(SecureDict.Value("Vector"))
		    Dim Encrypted As Xojo.Core.MemoryBlock = Beacon.DecodeHex(SecureDict.Value("Content"))
		    
		    #if Not TargetiOS
		      Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		      AES.SetKey(CType(Key.Data, MemoryBlock).StringValue(0, Key.Size))
		      AES.SetInitialVector(CType(Vector.Data, MemoryBlock).StringValue(0, Vector.Size))
		      
		      Dim Decrypted As String
		      Try
		        Decrypted = AES.DecryptCBC(CType(Encrypted.Data, MemoryBlock).StringValue(0, Encrypted.Size))
		      Catch Err As RuntimeException
		        Return ""
		      End Try
		      
		      Dim ComputedHash As Text = Beacon.Hash(Decrypted)
		      If ComputedHash <> ExpectedHash Then
		        Return ""
		      End If
		      
		      If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		        Return ""
		      End If
		      Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		      
		      Dim TextValue As Text = Decrypted.ToText
		      If Self.mEncryptedValues = Nil Then
		        Self.mEncryptedValues = New Xojo.Core.Dictionary
		      End If
		      Self.mEncryptedValues.Value(ComputedHash) = Input
		      
		      Return TextValue
		    #else
		      #Pragma Error "Not implemented"
		    #endif
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Encrypt(Input As Text, Identity As Beacon.Identity) As Text
		  Try
		    Dim Hash As Text = Beacon.Hash(Input)
		    If Self.mEncryptedValues <> Nil And Self.mEncryptedValues.HasKey(Hash) Then
		      Return Self.mEncryptedValues.Value(Hash)
		    End If
		    
		    #if Not TargetiOS
		      Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		      Dim Key As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(128)
		      Dim Vector As Xojo.Core.MemoryBlock = Xojo.Crypto.GenerateRandomBytes(16)
		      AES.SetKey(CType(Key.Data, MemoryBlock).StringValue(0, Key.Size))
		      AES.SetInitialVector(CType(Vector.Data, MemoryBlock).StringValue(0, Vector.Size))
		      Dim Encrypted As Global.MemoryBlock = AES.EncryptCBC(Input)
		      
		      Dim SecureDict As New Xojo.Core.Dictionary
		      SecureDict.Value("Key") = Beacon.EncodeHex(Identity.Encrypt(Key))
		      SecureDict.Value("Vector") = Beacon.EncodeHex(Vector)
		      SecureDict.Value("Content") = Beacon.EncodeHex(Encrypted)
		      SecureDict.Value("Hash") = Hash
		      
		      Dim TextValue As Text = Xojo.Data.GenerateJSON(SecureDict)
		      If Self.mEncryptedValues = Nil Then
		        Self.mEncryptedValues = New Xojo.Core.Dictionary
		      End If
		      Self.mEncryptedValues.Value(Hash) = TextValue
		      
		      Return TextValue
		    #else
		      #Pragma Error "Not implemented"
		    #endIf
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilterIniText(Input As Text) As Text
		  Dim EOL As Text = Text.FromUnicodeCodepoint(10)
		  Input = Beacon.ReplaceLineEndings(Input, EOL)
		  
		  Dim InsideBeaconSection As Boolean
		  Dim Lines() As Text = Input.Split(EOL)
		  Dim FilteredLines() As Text
		  For I As Integer = 0 To Lines.Ubound
		    Dim Line As Text = Lines(I).Trim
		    If Line = "[Beacon]" Then
		      InsideBeaconSection = True
		    ElseIf Line.BeginsWith("[") And Line.EndsWith("]") Then
		      InsideBeaconSection = False
		    End If
		    
		    If Not InsideBeaconSection Then
		      FilteredLines.Append(Line)
		    End If
		  Next
		  
		  Input = FilteredLines.Join(EOL)
		  Return Input.Trim
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As Text
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(SupportedConfigs As Xojo.Core.Dictionary = Nil, Assigns Value As Text)
		  If SupportedConfigs <> Nil Then
		    Dim ConfigValues() As Beacon.ConfigValue = Self.IniValues(Beacon.ShooterGameHeader, Value, SupportedConfigs)
		    Dim ConfigDict As New Xojo.Core.Dictionary
		    Beacon.ConfigValue.FillConfigDict(ConfigDict, ConfigValues)
		    Value = Beacon.RewriteIniContent("", ConfigDict, False)
		  End If
		  
		  Value = Self.FilterIniText(Value)
		  
		  If Self.mGameIniContent.Compare(Value, Text.CompareCaseSensitive, Xojo.Core.Locale.Raw) <> 0 Then
		    Self.mGameIniContent = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Return Self.GameIniValues(SourceDocument, New Xojo.Core.Dictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document, ExistingConfigs As Xojo.Core.Dictionary) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Return Self.IniValues(Beacon.ShooterGameHeader, Self.mGameIniContent, ExistingConfigs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As Text
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(SupportedConfigs As Xojo.Core.Dictionary = Nil, Assigns Value As Text)
		  If SupportedConfigs <> Nil Then
		    Dim ConfigValues() As Beacon.ConfigValue = Self.IniValues(Beacon.ServerSettingsHeader, Value, SupportedConfigs)
		    
		    Dim ProtectedKeys As New Xojo.Core.Dictionary
		    ProtectedKeys.Value("ServerSettings.ServerAdminPassword") = True
		    ProtectedKeys.Value("ServerSettings.ServerPassword") = True
		    ProtectedKeys.Value("AuctionHouse.MarketID") = True
		    
		    // Make sure passwords get encrypted on save
		    For I As Integer = ConfigValues.Ubound DownTo 0
		      Dim ConfigValue As Beacon.ConfigValue = ConfigValues(I)
		      If ConfigValue.Value = "" Then
		        Continue
		      End If
		      
		      If ProtectedKeys.HasKey(ConfigValue.Header + "." + ConfigValue.Key) Then
		        ConfigValues(I) = New Beacon.ConfigValue(ConfigValue.Header, ConfigValue.Key, Self.EncryptedTag + ConfigValue.Value + Self.EncryptedTag)
		      End If
		    Next
		    
		    Dim ConfigDict As New Xojo.Core.Dictionary
		    Beacon.ConfigValue.FillConfigDict(ConfigDict, ConfigValues)
		    Value = Beacon.RewriteIniContent("", ConfigDict, False)
		  End If
		  
		  Value = Self.FilterIniText(Value)
		  
		  If Self.mGameUserSettingsIniContent.Compare(Value, Text.CompareCaseSensitive, Xojo.Core.Locale.Raw) <> 0 Then
		    Self.mGameUserSettingsIniContent = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Return Self.GameUserSettingsIniValues(SourceDocument, New Xojo.Core.Dictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document, ExistingConfigs As Xojo.Core.Dictionary) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Return Self.IniValues(Beacon.ServerSettingsHeader, Self.mGameUserSettingsIniContent, ExistingConfigs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSkippedKeys(Header As Text, ExistingConfigs As Xojo.Core.Dictionary) As Text()
		  Dim SkippedKeys() As Text
		  If Not ExistingConfigs.HasKey(Header) Then
		    Return SkippedKeys
		  End If
		  
		  Dim Siblings As Xojo.Core.Dictionary = ExistingConfigs.Value(Header)
		  For Each Entry As Xojo.Core.DictionaryEntry In Siblings
		    SkippedKeys.Append(Entry.Key)
		  Next
		  Return SkippedKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IniValues(InitialHeader As Text, Source As Text, ExistingConfigs As Xojo.Core.Dictionary) As Beacon.ConfigValue()
		  Source = Source.ReplaceAll(Self.EncryptedTag, "")
		  Source = Source.ReplaceLineEndings(Text.FromUnicodeCodepoint(10))
		  
		  Dim Lines() As Text = Source.Split(Text.FromUnicodeCodepoint(10))
		  Dim CurrentHeader As Text = InitialHeader
		  Dim Values() As Beacon.ConfigValue
		  Dim SkippedKeys() As Text = Self.GetSkippedKeys(CurrentHeader, ExistingConfigs)
		  For Each Line As Text In Lines
		    Line = Line.Trim
		    
		    If Line.Length = 0 Then
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      CurrentHeader = Line.Mid(1, Line.Length - 2)
		      SkippedKeys = Self.GetSkippedKeys(CurrentHeader, ExistingConfigs)
		    End If
		    
		    If CurrentHeader = "" Then
		      Continue
		    End If
		    
		    Dim KeyPos As Integer = Line.IndexOf("=")
		    If KeyPos = -1 Then
		      Continue
		    End If
		    
		    Dim Key As Text = Line.Left(KeyPos).Trim
		    If SkippedKeys.IndexOf(Key) > -1 Then
		      Continue
		    End If
		    
		    Dim Value As Text = Line.Mid(KeyPos + 1).Trim
		    Values.Append(New Beacon.ConfigValue(CurrentHeader, Key, Value))
		  Next
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadContent(Input As Text, Identity As Beacon.Identity) As Text
		  Dim Pos As Integer
		  Self.mEncryptedValues = New Xojo.Core.Dictionary
		  
		  Do
		    Pos = Input.IndexOf(Pos, Self.EncryptedTag)
		    If Pos = -1 Then
		      Return Input
		    End If
		    
		    Dim StartPos As Integer = Pos + Self.EncryptedTag.Length
		    Dim EndPos As Integer = Input.IndexOf(StartPos, Self.EncryptedTag)
		    If EndPos = -1 Then
		      EndPos = Input.Length
		    End If
		    
		    Dim Prefix As Text = Input.Left(StartPos)
		    Dim Suffix As Text = Input.Right(Input.Length - EndPos)
		    Dim EncryptedContent As Text = Input.Mid(StartPos, EndPos - StartPos)
		    Dim DecryptedContent As Text = Self.Decrypt(EncryptedContent, Identity)
		    
		    If DecryptedContent = "" Then
		      Prefix = Prefix.Left(Prefix.Length - Self.EncryptedTag.Length)
		      Suffix = Suffix.Right(Suffix.Length - Self.EncryptedTag.Length)
		      Input = Prefix + Suffix
		      Pos = Prefix.Length
		    Else
		      Input = Prefix + DecryptedContent + Suffix
		      Pos = Prefix.Length + DecryptedContent.Length + Self.EncryptedTag.Length
		    End If
		  Loop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WriteContent(Input As Text, Identity As Beacon.Identity) As Text
		  Dim Pos As Integer
		  
		  Do
		    Pos = Input.IndexOf(Pos, Self.EncryptedTag)
		    If Pos = -1 Then
		      Return Input
		    End If
		    
		    Dim StartPos As Integer = Pos + Self.EncryptedTag.Length
		    Dim EndPos As Integer = Input.IndexOf(StartPos, Self.EncryptedTag)
		    If EndPos = -1 Then
		      EndPos = Input.Length
		    End If
		    
		    Dim Prefix As Text = Input.Left(StartPos)
		    Dim Suffix As Text = Input.Right(Input.Length - EndPos)
		    Dim DecryptedContent As Text = Input.Mid(StartPos, EndPos - StartPos)
		    Dim EncryptedContent As Text = Self.Encrypt(DecryptedContent, Identity)
		    
		    Input = Prefix + EncryptedContent + Suffix
		    Pos = Prefix.Length + EncryptedContent.Length + Self.EncryptedTag.Length
		  Loop
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEncryptedValues As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As Text
	#tag EndProperty


	#tag Constant, Name = EncryptedTag, Type = Text, Dynamic = False, Default = \"$$BeaconEncrypted$$", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
