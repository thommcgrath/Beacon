#tag Class
Protected Class CustomContent
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Var ValuesFromGUS() As Beacon.ConfigValue = Self.IniValues(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, Self.mGameUserSettingsIniContent, New Dictionary, Profile)
		  Var ValuesFromGame() As Beacon.ConfigValue = Self.IniValues(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, Self.mGameIniContent, New Dictionary, Profile)
		  Var Values() As Beacon.ConfigValue
		  
		  For Each ParsedValue As Beacon.ConfigValue In ValuesFromGUS
		    Values.Add(ParsedValue)
		    
		    Var Keys() As Beacon.ConfigKey = Beacon.Data.SearchForConfigKey("CommandLine", "", ParsedValue.SimplifiedKey)
		    If Keys.Count <> 1 Then
		      Continue
		    End If
		    
		    Var Key As Beacon.ConfigKey = Keys(0)
		    Var OverrideCommand As String = ParsedValue.Command
		    Var Value As String = ParsedValue.Value
		    If Key.ValueType = Beacon.ConfigKey.ValueTypes.TypeBoolean Then
		      Value = Value.Trim
		      Var IsTrue As Boolean = Value = "true" Or Value = "1"
		      Value = If(IsTrue, "true", "false")
		      OverrideCommand = Key.Key + "=" + Value.Titlecase
		    End If
		    Values.Add(New Beacon.ConfigValue(Key, Key.Key, Value, OverrideCommand))
		  Next
		  
		  For Each ParsedValue As Beacon.ConfigValue In ValuesFromGame
		    Values.Add(ParsedValue)
		  Next
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.CustomContent = BeaconConfigs.CustomContent(Other)
		  Var EOL As String = Encodings.ASCII.Chr(10)
		  
		  Var GameIniPieces() As String
		  If Self.mGameIniContent.IsEmpty = False Then
		    GameIniPieces.Add(Self.mGameIniContent.Trim)
		  End If
		  If Source.mGameIniContent.IsEmpty = False Then
		    GameIniPieces.Add("[" + Beacon.ShooterGameHeader + "]" + EOL + Source.mGameIniContent.Trim)
		  End If
		  Var MergedGameIni As String = GameIniPieces.Join(EOL + EOL)
		  
		  Var GameUserSettingsIniPieces() As String
		  If Self.mGameUserSettingsIniContent.IsEmpty = False Then
		    GameUserSettingsIniPieces.Add(Self.mGameUserSettingsIniContent.Trim)
		  End If
		  If Source.mGameUserSettingsIniContent.IsEmpty = False Then
		    GameUserSettingsIniPieces.Add("[" + Beacon.ServerSettingsHeader + "]" + EOL + Source.mGameUserSettingsIniContent.Trim)
		  End If
		  Var MergedGameUserSettingsIni As String = GameUserSettingsIniPieces.Join(EOL + EOL)
		  
		  If Self.mGameIniContent <> MergedGameIni Or Self.mGameUserSettingsIniContent <> MergedGameUserSettingsIni Then
		    Self.Modified = True
		    Self.mGameIniContent = MergedGameIni
		    Self.mGameUserSettingsIniContent = MergedGameUserSettingsIni
		    
		    If (Source.mEncryptedValues Is Nil) = False Then
		      For Each Entry As DictionaryEntry In Source.mEncryptedValues
		        Self.mEncryptedValues.Value(Entry.Key) = Entry.Value
		      Next
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  Self.mGameIniContent = Self.ReadContent(Dict.Lookup(Beacon.ConfigFileGame, ""), Identity, Document)
		  Self.mGameUserSettingsIniContent = Self.ReadContent(Dict.Lookup(Beacon.ConfigFileGameUserSettings, ""), Identity, Document)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  Dict.Value(Beacon.ConfigFileGame) = Self.WriteContent(Self.mGameIniContent, Document)
		  Dict.Value(Beacon.ConfigFileGameUserSettings) = Self.WriteContent(Self.mGameUserSettingsIniContent, Document)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity, Document As Beacon.Document) As Beacon.ConfigGroup
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  // Overridden for performance
		  
		  Var Instance As New BeaconConfigs.CustomContent
		  Instance.mGameIniContent = Self.mGameIniContent
		  Instance.mGameUserSettingsIniContent = Self.mGameUserSettingsIniContent
		  If (Self.mEncryptedValues Is Nil) = False Then
		    Instance.mEncryptedValues = Self.mEncryptedValues.Clone
		  Else
		    Instance.mEncryptedValues = Nil
		  End If
		  Return Instance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameCustomContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Decrypt(Input As String, Identity As Beacon.Identity, Document As Beacon.Document) As String
		  Try
		    #Pragma BreakOnExceptions False
		    Var Decrypted As String = Document.Decrypt(Input).DefineEncoding(Encodings.UTF8)
		    #Pragma BreakOnExceptions Default
		    If Self.mEncryptedValues = Nil Then
		      Self.mEncryptedValues = New Dictionary
		    End If
		    Self.mEncryptedValues.Value(EncodeHex(Crypto.SHA512(Decrypted))) = Input
		    Return Decrypted
		  Catch Err As RuntimeException
		  End Try
		  
		  Try
		    #Pragma BreakOnExceptions False
		    Var SecureDict As Dictionary = Beacon.ParseJSON(Input)
		    #Pragma BreakOnExceptions Default
		    If Not SecureDict.HasAllKeys("Key", "Vector", "Content", "Hash") Then
		      Return ""
		    End If
		    
		    Var Key As MemoryBlock = Identity.Decrypt(DecodeHex(SecureDict.Value("Key")))
		    If Key = Nil Then
		      Return ""
		    End If
		    
		    Var Vector As MemoryBlock = DecodeHex(SecureDict.Value("Vector"))
		    Var Encrypted As MemoryBlock = DecodeHex(SecureDict.Value("Content"))
		    Var ExpectedHash As String = SecureDict.Value("Hash")
		    
		    Var Crypt As CipherMBS = CipherMBS.aes_256_cbc
		    If Not Crypt.DecryptInit(BeaconEncryption.FixSymmetricKey(Key, Crypt.KeyLength), Vector) Then
		      Return ""
		    End If
		    
		    Var Decrypted As String
		    Try
		      Decrypted = Crypt.Process(Encrypted)
		    Catch Err As RuntimeException
		      Return ""
		    End Try
		    
		    Var ComputedHash As String = EncodeHex(Crypto.SHA512(Decrypted))
		    If ComputedHash <> ExpectedHash Then
		      Return ""
		    End If
		    
		    If Decrypted = "" Or Not Encodings.UTF8.IsValidData(Decrypted) Then
		      Return ""
		    End If
		    Decrypted = Decrypted.DefineEncoding(Encodings.UTF8)
		    
		    // Do not store to encrypted values when decrypting legacy content so the
		    // new encryption will be used on save.
		    
		    Return Decrypted
		  Catch Err As RuntimeException
		  End Try
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Encrypt(Input As String, Document As Beacon.Document) As String
		  Try
		    Var Hash As String = EncodeHex(Crypto.SHA512(Input))
		    If Self.mEncryptedValues <> Nil And Self.mEncryptedValues.HasKey(Hash) Then
		      Return Self.mEncryptedValues.Value(Hash)
		    End If
		    
		    Var Encrypted As String = Document.Encrypt(Input.ConvertEncoding(Encodings.UTF8))
		    If Self.mEncryptedValues = Nil Then
		      Self.mEncryptedValues = New Dictionary
		    End If
		    Self.mEncryptedValues.Value(Hash) = Encrypted
		    Return Encrypted
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Organizer As Beacon.ConfigOrganizer)
		  Self.GameIniContent = Organizer.Build(Beacon.ConfigFileGame)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + Beacon.ShooterGameHeader + "]") Then
		    Content = Content.Middle(Content.IndexOf("]") + 1).TrimLeft
		  End If
		  
		  If Self.mGameIniContent.Compare(Content, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mGameIniContent = Content
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As String
		  Return Self.mGameUserSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(Assigns Organizer As Beacon.ConfigOrganizer)
		  // Make a copy before editing
		  Var WasCloned As Boolean
		  
		  // Remove MOTD
		  #if Beacon.MOTDEditingEnabled
		    If Organizer.HasHeader(Beacon.ConfigFileGameUserSettings, "MessageOfTheDay") Then
		      Organizer = Organizer.Clone
		      WasCloned = True
		      Organizer.Remove(Beacon.ConfigFileGameUserSettings, "MessageOfTheDay")
		    End If
		  #endif
		  
		  // Encrypt some common passwords
		  Var ProtectedKeys() As String = Array("CommandLineOption:?:ServerAdminPassword", Beacon.ConfigFileGameUserSettings + ":ServerSettings:ServerPassword", Beacon.ConfigFileGameUserSettings + ":AuctionHouse:MarketID")
		  For Each KeyPath As String In ProtectedKeys
		    Var Pos As Integer = KeyPath.IndexOf(":")
		    Var File As String = KeyPath.Left(Pos)
		    KeyPath = KeyPath.Middle(Pos + 1)
		    Pos = KeyPath.IndexOf(":")
		    Var Header As String = KeyPath.Left(Pos)
		    Var Key As String = KeyPath.Middle(Pos + 1)
		    Var Values() As Beacon.ConfigValue = Organizer.FilteredValues(File, Header, Key)
		    If Values.Count = 0 Then
		      Continue
		    End If
		    Var Value As String = Values(Values.LastIndex).Value
		    If Value.IsEmpty Then
		      Continue
		    End If
		    If WasCloned = False Then
		      Organizer = Organizer.Clone
		      WasCloned = True
		    End If
		    Organizer.Remove(File, Header, Key)
		    Organizer.Add(New Beacon.ConfigValue(File, Header, Key, Self.EncryptedTag + Value + Self.EncryptedTag))
		  Next
		  
		  Self.GameUserSettingsIniContent = Organizer.Build(Beacon.ConfigFileGameUserSettings)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + Beacon.ServerSettingsHeader + "]") Then
		    Content = Content.Middle(Content.IndexOf("]") + 1).TrimLeft
		  End If
		  
		  If Self.mGameUserSettingsIniContent.Compare(Content, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mGameUserSettingsIniContent = Content
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IniValues(File As String, InitialHeader As String, Source As String, ExistingConfigs As Dictionary, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  Source = Source.ReplaceAll(Self.EncryptedTag, "")
		  Source = Source.ReplaceLineEndings(Encodings.ASCII.Chr(10))
		  
		  Var Lines() As String = Source.Split(Encodings.ASCII.Chr(10))
		  Var Parser As New CustomContentParser(File, InitialHeader, ExistingConfigs, Profile)
		  For Each Line As String In Lines
		    Var ShouldAlwaysBeNil() As Beacon.ConfigValue = Parser.AddLine(Line)
		    If ShouldAlwaysBeNil <> Nil Then
		      Break
		    End If
		  Next
		  Return Parser.RemainingValues
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadContent(Input As String, Identity As Beacon.Identity, Document As Beacon.Document) As String
		  Input = Input.GuessEncoding
		  
		  Var Pos As Integer
		  Self.mEncryptedValues = New Dictionary
		  
		  Do
		    Pos = Input.IndexOf(Pos, Self.EncryptedTag)
		    If Pos = -1 Then
		      Return Input
		    End If
		    
		    Var StartPos As Integer = Pos + Self.EncryptedTag.Length
		    Var EndPos As Integer = Input.IndexOf(StartPos, Self.EncryptedTag)
		    If EndPos = -1 Then
		      EndPos = Input.Length
		    End If
		    
		    Var Prefix As String = Input.Left(StartPos)
		    Var Suffix As String = Input.Right(Input.Length - EndPos)
		    Var EncryptedContent As String = Input.Middle(StartPos, EndPos - StartPos)
		    Var DecryptedContent As String = Self.Decrypt(EncryptedContent, Identity, Document)
		    
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

	#tag Method, Flags = &h0
		Function RunWhenBanned() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WriteContent(Input As String, Document As Beacon.Document) As String
		  Var Pos As Integer
		  
		  Do
		    Pos = Input.IndexOf(Pos, Self.EncryptedTag)
		    If Pos = -1 Then
		      Return Input
		    End If
		    
		    Var StartPos As Integer = Pos + Self.EncryptedTag.Length
		    Var EndPos As Integer = Input.IndexOf(StartPos, Self.EncryptedTag)
		    If EndPos = -1 Then
		      EndPos = Input.Length
		    End If
		    
		    Var Prefix As String = Input.Left(StartPos)
		    Var Suffix As String = Input.Right(Input.Length - EndPos)
		    Var DecryptedContent As String = Input.Middle(StartPos, EndPos - StartPos)
		    Var EncryptedContent As String = Self.Encrypt(DecryptedContent, Document)
		    
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
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
