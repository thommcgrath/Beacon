#tag Class
Protected Class CustomContent
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.CustomContent = Ark.Configs.CustomContent(Other)
		  
		  Var SelfOrganizer As New Ark.ConfigOrganizer
		  SelfOrganizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, Self.mGameIniContent)
		  SelfOrganizer.Add(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, Self.mGameUserSettingsIniContent)
		  
		  Var SourceOrganizer As New Ark.ConfigOrganizer
		  SourceOrganizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, Source.mGameIniContent)
		  SourceOrganizer.Add(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, Source.mGameUserSettingsIniContent)
		  
		  SelfOrganizer.Remove(SourceOrganizer.DistinctKeys)
		  SelfOrganizer.Add(SourceOrganizer.FilteredValues)
		  
		  Var MergedGameIni As String = SelfOrganizer.Build(Ark.ConfigFileGame)
		  Var MergedGameUserSettingsIni As String = SelfOrganizer.Build(Ark.ConfigFileGameUserSettings)
		  
		  If Self.mGameIniContent <> MergedGameIni Or Self.mGameUserSettingsIniContent <> MergedGameUserSettingsIni Then
		    Self.Modified = True
		    Self.mGameIniContent = MergedGameIni
		    Self.mGameUserSettingsIniContent = MergedGameUserSettingsIni
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Organizer As New Ark.ConfigOrganizer(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, Self.CleanupContent(Self.mGameUserSettingsIniContent, Ark.HeaderServerSettings, Profile))
		  Organizer.Add(Ark.ConfigFileGame, Ark.HeaderShooterGame, Self.CleanupContent(Self.mGameIniContent.ReplaceAll(Ark.HeaderShooterGameUWP, Ark.HeaderShooterGame), Ark.HeaderShooterGame, Profile))
		  
		  Var PotentialCommandLineValues() As Ark.ConfigValue = Organizer.FilteredValues(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings)
		  
		  For Each ParsedValue As Ark.ConfigValue In PotentialCommandLineValues
		    Var Keys() As Ark.ConfigKey = Ark.DataSource.SharedInstance.GetConfigKeys("CommandLine", "", ParsedValue.SimplifiedKey, False)
		    If Keys.Count <> 1 Then
		      Continue
		    End If
		    
		    Var Key As Ark.ConfigKey = Keys(0)
		    Var OverrideCommand As String = ParsedValue.Command
		    Var Value As String = ParsedValue.Value
		    If Key.ValueType = Ark.ConfigKey.ValueTypes.TypeBoolean Then
		      Value = Value.Trim
		      Var IsTrue As Boolean = Value = "true" Or Value = "1"
		      Value = If(IsTrue, "True", "False")
		      OverrideCommand = Key.Key + "=" + Value.Titlecase
		    End If
		    Organizer.Add(New Ark.ConfigValue(Key, OverrideCommand), True)
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
		  
		  If SaveData.HasKey(Ark.ConfigFileGame) Then
		    Self.mGameIniContent = Self.ReadContent(SaveData.Value(Ark.ConfigFileGame), Rainbow)
		  End If
		  
		  If SaveData.HasKey(Ark.ConfigFileGameUserSettings) Then
		    Self.mGameUserSettingsIniContent = Self.ReadContent(SaveData.Value(Ark.ConfigFileGameUserSettings), Rainbow)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As New Dictionary
		  SaveData.Value(Ark.ConfigFileGameUserSettings) = Self.WriteContent(Self.mGameUserSettingsIniContent, Rainbow)
		  SaveData.Value(Ark.ConfigFileGame) = Self.WriteContent(Self.mGameIniContent, Rainbow)
		  
		  If Rainbow.KeyCount > 0 Then
		    EncryptedData.Value("Salt") = EncodeHex(Self.mSalt)
		    EncryptedData.Value("Rainbow") = Rainbow
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CleanupContent(Content As String, DefaultHeader As String, Profile As Ark.ServerProfile) As String
		  // First, remove the encryption tags
		  Content = Content.ReplaceAll(Self.EncryptedTag, "")
		  
		  // Now we need to remove all comment lines
		  Var Lines() As String = Content.ReplaceLineEndings(EndOfLine).Split(EndOfLine)
		  For Idx As Integer = Lines.LastIndex DownTo 0
		    Lines(Idx) = Lines(Idx).Trim
		    If Lines(Idx).IsEmpty Or Lines(Idx).BeginsWith("//") Then
		      Lines.RemoveAt(Idx)
		    End If
		  Next
		  
		  Try
		    // Next, server-specific blocks are important
		    Var HeaderStack() As String = Array(DefaultHeader)
		    Var ServersStack() As String = Array("")
		    Var Map As New Dictionary
		    Var MapKey As String = ""
		    For Idx As Integer = 0 To Lines.LastIndex
		      Var Line As String = Lines(Idx)
		      
		      If Line.BeginsWith("#Server") Then
		        Var IDList As String = Line.Middle(Line.IndexOf(" ") + 1).Trim
		        HeaderStack.Add(HeaderStack(HeaderStack.LastIndex))
		        ServersStack.Add(IDList)
		        MapKey = ServersStack.Join(".")
		        Continue
		      ElseIf Line.BeginsWith("#End") Then
		        If ServersStack.Count > 1 Then
		          ServersStack.RemoveAt(ServersStack.LastIndex)
		          HeaderStack.RemoveAt(HeaderStack.LastIndex)
		          MapKey = ServersStack.Join(".")
		          
		          // Switch the context back
		          Line = "[" + HeaderStack(HeaderStack.LastIndex) + "]"
		        End If
		      ElseIf Line.BeginsWith("[") And Line.EndsWith("]") Then
		        Var Header As String = Line.Middle(1, Line.Length - 2)
		        HeaderStack.RemoveAt(HeaderStack.LastIndex)
		        HeaderStack.Add(Header)
		      ElseIf Line.IsEmpty Then
		        Continue
		      End If
		      
		      Var ContextLines() As String
		      If Map.HasKey(MapKey) Then
		        ContextLines = Map.Value(MapKey)
		      End If
		      ContextLines.Add(Line)
		      Map.Value(MapKey) = ContextLines
		    Next
		    
		    Var FinishedLines() As String
		    Var ProfileShort As String
		    If (Profile Is Nil) = False Then
		      ProfileShort = Profile.ProfileID.Left(8)
		    End If
		    For Each Entry As DictionaryEntry In Map
		      Var Key As String = Entry.Key
		      If Key.IsEmpty = False Then
		        If (Profile Is Nil) Then
		          Continue
		        End If
		        
		        Var Components() As String = Key.Split(".")
		        For Each Component As String In Components
		          If Component.IsEmpty = False And Component.IndexOf(ProfileShort) = -1 Then
		            Continue For Entry
		          End If
		        Next
		      End If
		      
		      Var ContextLines() As String = Entry.Value
		      For Each Line As String In ContextLines
		        FinishedLines.Add(Line)
		      Next
		    Next
		    
		    // And put it all back together
		    Return FinishedLines.Join(EndOfLine)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName)
		    Return Lines.Join(EndOfLine)
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
		Function DefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  Return Self.mGameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Organizer As Ark.ConfigOrganizer)
		  Self.GameIniContent = Organizer.Build(Ark.ConfigFileGame)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + Ark.HeaderShooterGame + "]") Then
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
		Sub GameUserSettingsIniContent(Assigns Organizer As Ark.ConfigOrganizer)
		  // Make a copy before editing
		  Var WasCloned As Boolean
		  
		  // Remove MOTD
		  If Organizer.HasHeader(Ark.ConfigFileGameUserSettings, "MessageOfTheDay") Then
		    Organizer = Organizer.Clone
		    WasCloned = True
		    Organizer.Remove(Ark.ConfigFileGameUserSettings, "MessageOfTheDay")
		  End If
		  
		  // Encrypt some common passwords
		  Var ProtectedKeys() As String = Array("CommandLineOption:?:ServerAdminPassword", Ark.ConfigFileGameUserSettings + ":ServerSettings:ServerPassword", Ark.ConfigFileGameUserSettings + ":AuctionHouse:MarketID")
		  For Each KeyPath As String In ProtectedKeys
		    Var Pos As Integer = KeyPath.IndexOf(":")
		    Var File As String = KeyPath.Left(Pos)
		    KeyPath = KeyPath.Middle(Pos + 1)
		    Pos = KeyPath.IndexOf(":")
		    Var Header As String = KeyPath.Left(Pos)
		    Var Key As String = KeyPath.Middle(Pos + 1)
		    Var Values() As Ark.ConfigValue = Organizer.FilteredValues(File, Header, Key)
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
		    Organizer.Add(New Ark.ConfigValue(File, Header, Key + "=" + Self.EncryptedTag + Value + Self.EncryptedTag))
		  Next
		  
		  // Remove RCON
		  Organizer.Remove(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "RCONEnabled")
		  Organizer.Remove(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "RCONPort")
		  Organizer.Remove(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "RCONServerGameLogBuffer")
		  
		  Self.GameUserSettingsIniContent = Organizer.Build(Ark.ConfigFileGameUserSettings)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameUserSettingsIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + Ark.HeaderServerSettings + "]") Then
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
		  Return Ark.Configs.NameCustomContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadContent(Input As String, Rainbow As Dictionary) As String
		  Input = Input.GuessEncoding
		  
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
