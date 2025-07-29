#tag Class
Protected Class CustomContent
Inherits Palworld.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As Palworld.ConfigGroup)
		  Var Source As Palworld.Configs.CustomContent = Palworld.Configs.CustomContent(Other)
		  
		  Var SelfOrganizer As New Palworld.ConfigOrganizer
		  SelfOrganizer.Add(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, Self.mSettingsIniContent)
		  
		  Var SourceOrganizer As New Palworld.ConfigOrganizer
		  SourceOrganizer.Add(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, Source.mSettingsIniContent)
		  
		  SelfOrganizer.Remove(SourceOrganizer.DistinctKeys)
		  SelfOrganizer.Add(SourceOrganizer.FilteredValues)
		  
		  Var MergedSettingsIni As String = SelfOrganizer.Build(Palworld.ConfigFileSettings)
		  
		  If Self.mSettingsIniContent <> MergedSettingsIni Then
		    Self.Modified = True
		    Self.mSettingsIniContent = MergedSettingsIni
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Palworld.Project, Profile As Palworld.ServerProfile) As Palworld.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Organizer As New Palworld.ConfigOrganizer(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, Self.CleanupContent(Self.mSettingsIniContent))
		  Return Organizer.FilteredValues()
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mSettingsIniContent.IsEmpty = False
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
		  
		  If SaveData.HasKey(Palworld.ConfigFileSettings) Then
		    Self.mSettingsIniContent = Self.ReadContent(SaveData.Value(Palworld.ConfigFileSettings), Rainbow)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Rainbow As New Dictionary
		  SaveData.Value(Palworld.ConfigFileSettings) = Self.WriteContent(Self.mSettingsIniContent, Rainbow)
		  
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
		      If Lines(Idx).IsEmpty Or Lines(Idx).BeginsWith("//") Then
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
		Function InternalName() As String
		  Return Palworld.Configs.NameCustomConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDefaultImported() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadContent(Input As String, Rainbow As Dictionary) As String
		  Input = Input.GuessEncoding("/Script/")
		  
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
		Function SettingsIniContent() As String
		  Return Self.mSettingsIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SettingsIniContent(Assigns Organizer As Palworld.ConfigOrganizer)
		  Self.SettingsIniContent = Organizer.Build(Palworld.ConfigFileSettings)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SettingsIniContent(Assigns Content As String)
		  If Content.BeginsWith("[" + Palworld.HeaderPalworldSettings + "]") Then
		    Content = Content.Middle(Content.IndexOf("]") + 1).TrimLeft
		  End If
		  
		  If Self.mSettingsIniContent.Compare(Content, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mSettingsIniContent = Content
		    Self.Modified = True
		  End If
		End Sub
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
		Private mSalt As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingsIniContent As String
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
