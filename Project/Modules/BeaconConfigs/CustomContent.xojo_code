#tag Class
Protected Class CustomContent
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity)
		  Self.mGameIniContent = Self.ReadContent(Dict.Lookup("Game.ini", ""), Identity)
		  Self.mGameUserSettingsIniContent = Self.ReadContent(Dict.Lookup("GameUserSettings.ini", ""), Identity)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Identity As Beacon.Identity)
		  Dict.Value("Game.ini") = Self.WriteContent(Self.mGameIniContent, Identity)
		  Dict.Value("GameUserSettings.ini") = Self.WriteContent(Self.mGameUserSettingsIniContent, Identity)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "CustomContent"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decrypt(Input As String, Identity As Beacon.Identity) As String
		  Try
		    Dim SecureDict As Dictionary = Beacon.ParseJSON(Input.ToText)
		    If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		      Return ""
		    End If
		    
		    Dim Key As MemoryBlock = Identity.Decrypt(DecodeHex(SecureDict.Value("Key")))
		    If Key = Nil Then
		      Return ""
		    End If
		    
		    Dim Vector As MemoryBlock = DecodeHex(SecureDict.Value("Vector"))
		    Dim Encrypted As MemoryBlock = DecodeHex(SecureDict.Value("Content"))
		    Dim ExpectedHash As String = SecureDict.Value("Hash")
		    
		    #if Not TargetiOS
		      Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		      AES.SetKey(Key)
		      AES.SetInitialVector(Vector)
		      
		      Dim Decrypted As String
		      Try
		        Decrypted = AES.DecryptCBC(Encrypted)
		      Catch Err As RuntimeException
		        Return ""
		      End Try
		      
		      Dim ComputedHash As String = Beacon.SHA512(Decrypted)
		      If ComputedHash <> ExpectedHash Then
		        Return ""
		      End If
		      
		      If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		        Return ""
		      End If
		      Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		      
		      If Self.mEncryptedValues = Nil Then
		        Self.mEncryptedValues = New Dictionary
		      End If
		      Self.mEncryptedValues.Value(ComputedHash) = Input
		      
		      Return Decrypted
		    #else
		      #Pragma Error "Not implemented"
		    #endif
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Encrypt(Input As String, Identity As Beacon.Identity) As String
		  Try
		    Dim Hash As String = Beacon.SHA512(Input)
		    If Self.mEncryptedValues <> Nil And Self.mEncryptedValues.HasKey(Hash) Then
		      Return Self.mEncryptedValues.Value(Hash)
		    End If
		    
		    #if Not TargetiOS
		      Dim AES As New M_Crypto.AES_MTC(AES_MTC.EncryptionBits.Bits256)
		      Dim Key As MemoryBlock = Crypto.GenerateRandomBytes(128)
		      Dim Vector As MemoryBlock = Crypto.GenerateRandomBytes(16)
		      AES.SetKey(Key)
		      AES.SetInitialVector(Vector)
		      Dim Encrypted As Global.MemoryBlock = AES.EncryptCBC(Input)
		      
		      Dim SecureDict As New Dictionary
		      SecureDict.Value("Key") = EncodeHex(Identity.Encrypt(Key))
		      SecureDict.Value("Vector") = EncodeHex(Vector)
		      SecureDict.Value("Content") = EncodeHex(Encrypted)
		      SecureDict.Value("Hash") = Hash
		      
		      Dim JSON As String = Beacon.GenerateJSON(SecureDict)
		      If Self.mEncryptedValues = Nil Then
		        Self.mEncryptedValues = New Dictionary
		      End If
		      Self.mEncryptedValues.Value(Hash) = JSON
		      
		      Return JSON
		    #else
		      #Pragma Error "Not implemented"
		    #endIf
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilterIniText(Input As String) As String
		  Dim EOL As String = Encodings.ASCII.Chr(10)
		  Input = ReplaceLineEndings(Input, EOL)
		  
		  Dim InsideBeaconSection As Boolean
		  Dim Lines() As String = Input.Split(EOL)
		  Dim FilteredLines() As String
		  For I As Integer = 0 To Lines.Ubound
		    Dim Line As String = Lines(I).Trim
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
		Function GameIniContent() As String
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(SupportedConfigs As Dictionary = Nil, Assigns Value As String)
		  If SupportedConfigs <> Nil Then
		    Dim ConfigValues() As Beacon.ConfigValue = Self.IniValues(Beacon.ShooterGameHeader, Value, SupportedConfigs)
		    Dim ConfigDict As New Dictionary
		    Beacon.ConfigValue.FillConfigDict(ConfigDict, ConfigValues)
		    Value = Beacon.RewriteIniContent("", ConfigDict, False)
		  End If
		  
		  If StrComp(Self.mGameIniContent, Value, 0) <> 0 Then
		    Self.mGameIniContent = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Return Self.GameIniValues(SourceDocument, New Dictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document, ExistingConfigs As Dictionary) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Return Self.IniValues(Beacon.ShooterGameHeader, Self.mGameIniContent, ExistingConfigs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As String
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(SupportedConfigs As Dictionary = Nil, Assigns Value As String)
		  If SupportedConfigs <> Nil Then
		    Dim ConfigValues() As Beacon.ConfigValue = Self.IniValues(Beacon.ServerSettingsHeader, Value, SupportedConfigs)
		    
		    Dim ProtectedKeys As New Dictionary
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
		    
		    Dim ConfigDict As New Dictionary
		    Beacon.ConfigValue.FillConfigDict(ConfigDict, ConfigValues)
		    Value = Beacon.RewriteIniContent("", ConfigDict, False)
		  End If
		  
		  If StrComp(Self.mGameUserSettingsIniContent, Value, 0) <> 0 Then
		    Self.mGameUserSettingsIniContent = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Return Self.GameUserSettingsIniValues(SourceDocument, New Dictionary)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document, ExistingConfigs As Dictionary) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Return Self.IniValues(Beacon.ServerSettingsHeader, Self.mGameUserSettingsIniContent, ExistingConfigs)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSkippedKeys(Header As String, ExistingConfigs As Dictionary) As String()
		  Dim SkippedKeys() As String
		  If Not ExistingConfigs.HasKey(Header) Then
		    Return SkippedKeys
		  End If
		  
		  Dim Siblings As Dictionary = ExistingConfigs.Value(Header)
		  For Each Entry As DictionaryMember In Siblings.Members
		    SkippedKeys.Append(Entry.Key)
		  Next
		  Return SkippedKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IniValues(InitialHeader As String, Source As String, ExistingConfigs As Dictionary) As Beacon.ConfigValue()
		  Source = Source.ReplaceAll(Self.EncryptedTag, "")
		  Source = ReplaceLineEndings(Source, Encodings.ASCII.Chr(10))
		  
		  Dim Lines() As String = Source.Split(Encodings.ASCII.Chr(10))
		  Dim CurrentHeader As String = InitialHeader
		  Dim Values() As Beacon.ConfigValue
		  Dim SkippedKeys() As String = Self.GetSkippedKeys(CurrentHeader, ExistingConfigs)
		  For Each Line As String In Lines
		    Line = Line.Trim
		    
		    If Line.Length = 0 Then
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      CurrentHeader = Line.SubString(1, Line.Length - 2)
		      SkippedKeys = Self.GetSkippedKeys(CurrentHeader, ExistingConfigs)
		    End If
		    
		    If CurrentHeader = "" Then
		      Continue
		    End If
		    
		    Dim KeyPos As Integer = Line.IndexOf("=")
		    If KeyPos = -1 Then
		      Continue
		    End If
		    
		    Dim Key As String = Line.Left(KeyPos).Trim
		    If SkippedKeys.IndexOf(Key) > -1 Then
		      Continue
		    End If
		    
		    Dim Value As String = Line.SubString(KeyPos + 1).Trim
		    Values.Append(New Beacon.ConfigValue(CurrentHeader.ToText, Key.ToText, Value.ToText))
		  Next
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadContent(Input As String, Identity As Beacon.Identity) As String
		  Input = Input.GuessEncoding
		  
		  Dim Pos As Integer
		  Self.mEncryptedValues = New Dictionary
		  
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
		    
		    Dim Prefix As String = Input.Left(StartPos)
		    Dim Suffix As String = Input.Right(Input.Length - EndPos)
		    Dim EncryptedContent As String = Input.SubString(StartPos, EndPos - StartPos)
		    Dim DecryptedContent As String = Self.Decrypt(EncryptedContent, Identity)
		    
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
		Private Function WriteContent(Input As String, Identity As Beacon.Identity) As String
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
		    
		    Dim Prefix As String = Input.Left(StartPos)
		    Dim Suffix As String = Input.Right(Input.Length - EndPos)
		    Dim DecryptedContent As String = Input.SubString(StartPos, EndPos - StartPos)
		    Dim EncryptedContent As String = Self.Encrypt(DecryptedContent, Identity)
		    
		    Input = Prefix + EncryptedContent + Suffix
		    Pos = Prefix.Length + EncryptedContent.Length + Self.EncryptedTag.Length
		  Loop
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEncryptedValues As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As String
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
