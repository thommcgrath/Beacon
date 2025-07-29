#tag Class
Protected Class CustomContent
Inherits ArkSA.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.CustomContent = ArkSA.Configs.CustomContent(Other)
		  
		  Var SelfOrganizer As New ArkSA.ConfigOrganizer
		  SelfOrganizer.Add(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, Self.mGameIniContent)
		  SelfOrganizer.Add(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, Self.mGameUserSettingsIniContent)
		  
		  Var SourceOrganizer As New ArkSA.ConfigOrganizer
		  SourceOrganizer.Add(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, Source.mGameIniContent)
		  SourceOrganizer.Add(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, Source.mGameUserSettingsIniContent)
		  
		  SelfOrganizer.Remove(SourceOrganizer.DistinctKeys)
		  SelfOrganizer.Add(SourceOrganizer.FilteredValues)
		  
		  Var MergedGameIni As String = SelfOrganizer.Build(ArkSA.ConfigFileGame)
		  Var MergedGameUserSettingsIni As String = SelfOrganizer.Build(ArkSA.ConfigFileGameUserSettings)
		  
		  If Self.mGameIniContent <> MergedGameIni Or Self.mGameUserSettingsIniContent <> MergedGameUserSettingsIni Then
		    Self.Modified = True
		    Self.mGameIniContent = MergedGameIni
		    Self.mGameUserSettingsIniContent = MergedGameUserSettingsIni
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Organizer As New ArkSA.ConfigOrganizer(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, Self.CleanupContent(Self.mGameUserSettingsIniContent))
		  Organizer.Add(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, Self.CleanupContent(Self.mGameIniContent.ReplaceAll(ArkSA.HeaderShooterGameUWP, ArkSA.HeaderShooterGame)))
		  
		  Var PotentialCommandLineValues() As ArkSA.ConfigValue = Organizer.FilteredValues(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings)
		  
		  For Each ParsedValue As ArkSA.ConfigValue In PotentialCommandLineValues
		    Var Keys() As ArkSA.ConfigOption = ArkSA.DataSource.Pool.Get(False).GetConfigOptions("CommandLine", "", ParsedValue.SimplifiedKey, False)
		    If Keys.Count <> 1 Then
		      Continue
		    End If
		    
		    Var Key As ArkSA.ConfigOption = Keys(0)
		    Var OverrideCommand As String = ParsedValue.Command
		    Var Value As String = ParsedValue.Value
		    If Key.ValueType = ArkSA.ConfigOption.ValueTypes.TypeBoolean Then
		      Value = Value.Trim
		      Var IsTrue As Boolean = Value = "true" Or Value = "1"
		      Value = If(IsTrue, "True", "False")
		      OverrideCommand = Key.Key + "=" + Value.Titlecase
		    End If
		    Organizer.Add(New ArkSA.ConfigValue(Key, OverrideCommand), True)
		  Next
		  
		  Return Organizer.FilteredValues()
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mGameIniContent.IsEmpty = False Or Self.mGameUserSettingsIniContent.IsEmpty = False
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As Dictionary
		  If EncryptedData.HasKey("Rainbow") Then
		    Try
		      Rainbow = EncryptedData.Value("Rainbow")
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If EncryptedData.HasKey("Salt") Then
		    Self.mSalt = DecodeHex(EncryptedData.Value("Salt").StringValue)
		  End If
		  
		  If SaveData.HasKey(ArkSA.ConfigFileGame) Then
		    Self.mGameIniContent = Self.ReadContent(SaveData.Value(ArkSA.ConfigFileGame), Rainbow)
		  End If
		  
		  If SaveData.HasKey(ArkSA.ConfigFileGameUserSettings) Then
		    Self.mGameUserSettingsIniContent = Self.ReadContent(SaveData.Value(ArkSA.ConfigFileGameUserSettings), Rainbow)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As New Dictionary
		  SaveData.Value(ArkSA.ConfigFileGameUserSettings) = Self.WriteContent(Self.mGameUserSettingsIniContent, Rainbow)
		  SaveData.Value(ArkSA.ConfigFileGame) = Self.WriteContent(Self.mGameIniContent, Rainbow)
		  
		  If Rainbow.KeyCount > 0 Then
		    EncryptedData.Value("Salt") = EncodeHex(Self.mSalt)
		    EncryptedData.Value("Rainbow") = Rainbow
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CleanupContent(Content As String) As String
		  Try
		    // First, remove the encryption tags
		    Content = Content.ReplaceAll(Self.EncryptedTag, "")
		    
		    // Now we need to remove all comment lines
		    Var Lines() As String = Content.ReplaceLineEndings(EndOfLine).Split(EndOfLine)
		    For Idx As Integer = Lines.LastIndex DownTo 0
		      Lines(Idx) = Lines(Idx).Trim
		      If Lines(Idx).IsEmpty Or Lines(Idx).IsCommentLine Then
		        Lines.RemoveAt(Idx)
		      End If
		    Next
		    
		    // And put it all back together
		    Return String.FromArray(Lines, EndOfLine)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName)
		    Return Content
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSalt = Crypto.GenerateRandomBytes(32)
		  
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Organizer As ArkSA.ConfigOrganizer)
		  Self.GameIniContent = Organizer.Build(ArkSA.ConfigFileGame)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + ArkSA.HeaderShooterGame + "]") Then
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
		Sub GameUserSettingsIniContent(Assigns Organizer As ArkSA.ConfigOrganizer)
		  // Make a copy before editing
		  Var WasCloned As Boolean
		  
		  // Remove MOTD
		  If Organizer.HasHeader(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay") Then
		    Organizer = Organizer.Clone
		    WasCloned = True
		    Organizer.Remove(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay")
		  End If
		  
		  // Encrypt some common passwords
		  Var ProtectedKeys() As String = Array("CommandLineOption:?:ServerAdminPassword", ArkSA.ConfigFileGameUserSettings + ":ServerSettings:ServerPassword", ArkSA.ConfigFileGameUserSettings + ":AuctionHouse:MarketID", ArkSA.ConfigFileGameUserSettings + ":BeaconSentinel:AccessKey")
		  For Each KeyPath As String In ProtectedKeys
		    Var Pos As Integer = KeyPath.IndexOf(":")
		    Var File As String = KeyPath.Left(Pos)
		    KeyPath = KeyPath.Middle(Pos + 1)
		    Pos = KeyPath.IndexOf(":")
		    Var Header As String = KeyPath.Left(Pos)
		    Var Key As String = KeyPath.Middle(Pos + 1)
		    Var Values() As ArkSA.ConfigValue = Organizer.FilteredValues(File, Header, Key)
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
		    Organizer.Add(New ArkSA.ConfigValue(File, Header, Key + "=" + Self.EncryptedTag + Value + Self.EncryptedTag))
		  Next
		  
		  // Remove RCON
		  Organizer.Remove(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "RCONEnabled")
		  Organizer.Remove(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "RCONPort")
		  Organizer.Remove(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "RCONServerGameLogBuffer")
		  
		  Self.GameUserSettingsIniContent = Organizer.Build(ArkSA.ConfigFileGameUserSettings)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + ArkSA.HeaderServerSettings + "]") Then
		    Content = Content.Middle(Content.IndexOf("]") + 1).TrimLeft
		  End If
		  
		  If Self.mGameUserSettingsIniContent.Compare(Content, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mGameUserSettingsIniContent = Content
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameCustomConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadContent(Input As String, Rainbow As Dictionary) As String
		  Input = Input.GuessEncoding("/script/")
		  
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
		    Var EncryptedContent As String = Input.Middle(StartPos, EndPos - StartPos)
		    Var DecryptedContent As String
		    If (Rainbow Is Nil) = False And Rainbow.HasKey(EncryptedContent) Then
		      DecryptedContent = Rainbow.Value(EncryptedContent)
		    End If
		    
		    If DecryptedContent.IsEmpty Then
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
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WriteContent(Input As String, Rainbow As Dictionary) As String
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
		    Var Hash As String = EncodeHex(Crypto.HMAC(Self.mSalt, DecryptedContent, Crypto.HashAlgorithms.SHA512)).Lowercase
		    Rainbow.Value(Hash) = DecryptedContent
		    
		    Input = Prefix + Hash + Suffix
		    Pos = Prefix.Length + Hash.Length + Self.EncryptedTag.Length
		  Loop
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mGameIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSalt As String
	#tag EndProperty


	#tag Constant, Name = EncryptedTag, Type = String, Dynamic = False, Default = \"$$BeaconEncrypted$$", Scope = Public
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
