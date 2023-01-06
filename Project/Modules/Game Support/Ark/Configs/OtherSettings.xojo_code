#tag Class
Protected Class OtherSettings
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.OtherSettings = Ark.Configs.OtherSettings(Other)
		  For Each Entry As DictionaryEntry In Source.mSettings
		    Self.mSettings.Value(Entry.Key) = Entry.Value
		  Next Entry
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  Var ConsoleSafe As Boolean = Project.ConsoleSafe
		  Var Configs() As Ark.ConfigValue
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Try
		      Var KeyUUID As String = Entry.Key
		      Var Key As Ark.ConfigKey = DataSource.GetConfigKey(KeyUUID)
		      Var Value As Variant = Entry.Value
		      Var StringValue As String
		      
		      If Key Is Nil Or Project.ContentPackEnabled(Key.ContentPackUUID) = False Then
		        Continue
		      End If
		      
		      If Profile IsA Ark.GSAServerProfile And (Key.GSAPlaceholder Is Nil) = False Then
		        Configs.Add(New Ark.ConfigValue(Key, Key.Key + "=" + Key.GSAPlaceholder.StringValue, Key.SimplifiedKey))
		        Continue
		      End If
		      
		      Var Requirements As Variant = Key.Constraint("other")
		      If IsNull(Requirements) = False Then
		        Var Dict As Dictionary = Requirements
		        Var OtherKeyUUID As String = Dict.Value("key")
		        Var RequiredValue As Boolean = Dict.Value("value")
		        Var CurrentValue As Variant
		        If Self.mSettings.HasKey(OtherKeyUUID) Then
		          CurrentValue = Self.mSettings.Value(OtherKeyUUID)
		        Else
		          Var OtherKey As Ark.ConfigKey = DataSource.GetConfigKey(OtherKeyUUID)
		          If (OtherKey Is Nil) = False Then
		            CurrentValue = OtherKey.DefaultValue
		          End If
		        End If
		        If CurrentValue <> RequiredValue Then
		          Continue
		        End If
		      End If
		      
		      If Key.ValueType = Ark.ConfigKey.ValueTypes.TypeText Then
		        Var AllowedChars As Variant = Key.Constraint("allowed_chars")
		        Var DisallowedChars As Variant = Key.Constraint("disallowed_chars")
		        If IsNull(AllowedChars) = False Then
		          Var Filter As New Regex
		          Filter.SearchPattern = "[^" + AllowedChars.StringValue + "]+"
		          Filter.ReplacementPattern = ""
		          Filter.Options.ReplaceAllMatches = True
		          Value = Filter.Replace(Value.StringValue)
		        ElseIf IsNull(DisallowedChars) = False Then
		          Var Filter As New Regex
		          Filter.SearchPattern = "[" + DisallowedChars.StringValue + "]+"
		          Filter.ReplacementPattern = ""
		          Filter.Options.ReplaceAllMatches = True
		          Value = Filter.Replace(Value.StringValue)
		        End If
		        
		        Var TrimChars As Variant = Key.Constraint("trim_chars")
		        If IsNull(TrimChars) = False Then
		          Var Chars() As Variant = TrimChars
		          For Each Char As String In Chars
		            Value = Value.StringValue.Trim(Char)
		          Next Char
		        End If
		      End If
		      
		      If ConsoleSafe Then
		        Var RequiredPlatform As Variant = Key.Constraint("platform")
		        Var SupportedOnPlatform As Boolean = True
		        If IsNull(RequiredPlatform) = False Then
		          Select Case RequiredPlatform.StringValue
		          Case "pc", "steam", "epic"
		            SupportedOnPlatform = False
		          End Select
		        End If
		        If SupportedOnPlatform = False Then
		          Continue
		        End If
		      ElseIf Profile.Platform <> Ark.ServerProfile.PlatformUnknown Then
		        Var RequiredPlatform As Variant = Key.Constraint("platform")
		        Var SupportedOnPlatform As Boolean = True
		        If IsNull(RequiredPlatform) = False Then
		          Select Case RequiredPlatform.StringValue
		          Case "pc", "steam", "epic"
		            SupportedOnPlatform = (Profile.Platform = Ark.ServerProfile.PlatformPC)
		          Case "xbox"
		            SupportedOnPlatform = (Profile.Platform = Ark.ServerProfile.PlatformXbox)
		          Case "ps"
		            SupportedOnPlatform = (Profile.Platform = Ark.ServerProfile.PlatformPlayStation)
		          Case "switch"
		            SupportedOnPlatform = (Profile.Platform = Ark.ServerProfile.PlatformSwitch)
		          Case "console"
		            SupportedOnPlatform = (Profile.Platform = Ark.ServerProfile.PlatformXbox Or Profile.Platform = Beacon.ServerProfile.PlatformPlayStation)
		          End Select
		          If SupportedOnPlatform = False Then
		            Continue
		          End If
		        End If
		      End If
		      
		      Select Case Key.ValueType
		      Case Ark.ConfigKey.ValueTypes.TypeBoolean
		        StringValue = If(Value.BooleanValue, "True", "False")
		      Case Ark.ConfigKey.ValueTypes.TypeNumeric
		        StringValue = Value.DoubleValue.PrettyText
		      Case Ark.ConfigKey.ValueTypes.TypeText
		        StringValue = Value.StringValue
		      Else
		        Continue
		      End Select
		      
		      Configs.Add(New Ark.ConfigValue(Key, Key.Key + "=" + StringValue, Key.SimplifiedKey))
		    Catch Err As RuntimeException
		      App.ReportException(Err)
		    End Try
		  Next
		  Return Configs
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Var KeyUUID As String = Entry.Key
		    Var Key As Ark.ConfigKey = DataSource.GetConfigKey(KeyUUID)
		    Keys.Add(Key)
		  Next
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mSettings.KeyCount > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Try
		    Self.mSettings = SaveData.Value("Settings")
		  Catch Err As RuntimeException
		    Self.mSettings = New Dictionary
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  SaveData.Value("Settings") = Self.mSettings
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSettings = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.OtherSettings
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var AllContentPacks() As Ark.ContentPack = DataSource.GetContentPacks
		  Var ContentPackLookup As New Dictionary
		  For Each Pack As Ark.ContentPack In AllContentPacks
		    ContentPackLookup.Value(Pack.UUID) = Pack
		  Next Pack
		  
		  Var Config As New Ark.Configs.OtherSettings
		  Var AllKeys() As Ark.ConfigKey = DataSource.GetConfigKeys("", "", "", False)
		  For Each Key As Ark.ConfigKey In AllKeys
		    If KeySupported(Key, ContentPacks) = False Then
		      Continue
		    End If
		    
		    Var LookupKey As String = Key.Key
		    Var Pack As Ark.ContentPack = ContentPackLookup.Lookup(Key.ContentPackUUID, Nil)
		    If (Pack Is Nil) = False And Pack.ConsoleSafe = False Then
		      LookupKey = Key.Header + "." + Key.Key
		    End If
		    
		    Var TargetDict As Dictionary
		    If CommandLineOptions.HasKey(Key.Key) Then
		      TargetDict = CommandLineOptions
		      LookupKey = Key.Key
		    ElseIf ParsedData.HasKey(LookupKey) Then
		      TargetDict = ParsedData
		    Else
		      Continue
		    End If
		    
		    Var Value As Variant
		    Select Case Key.ValueType
		    Case Ark.ConfigKey.ValueTypes.TypeNumeric
		      Value = TargetDict.DoubleValue(LookupKey, Key.DefaultValue.DoubleValue, True)
		    Case Ark.ConfigKey.ValueTypes.TypeBoolean
		      Value = TargetDict.BooleanValue(LookupKey, Key.DefaultValue.BooleanValue, True)
		    Case Ark.ConfigKey.ValueTypes.TypeText
		      Value = TargetDict.StringValue(LookupKey, Key.DefaultValue.StringValue, True)
		    Else
		      Continue
		    End Select
		    
		    Config.Value(Key) = Value
		  Next Key
		  
		  If Config.mSettings.KeyCount > 0 Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameOtherSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function KeySupported(Key As Ark.ConfigKey, ContentPacks As Beacon.StringList) As Boolean
		  If (Key.NativeEditorVersion Is Nil) = False And Key.NativeEditorVersion.IntegerValue <= App.BuildNumber Then
		    // We have a native editor for this key
		    Return False
		  End If
		  If Key.ValueType = Ark.ConfigKey.ValueTypes.TypeArray Or Key.ValueType = Ark.ConfigKey.ValueTypes.TypeStructure Then
		    // Can't support these types
		    Return False
		  End If
		  If Key.MaxAllowed Is Nil Or Key.MaxAllowed.IntegerValue <> 1 Then
		    // Only support single value keys
		    Return False
		  End If
		  If ContentPacks.IndexOf(Key.ContentPackUUID) = -1 Then
		    // Is this not obvious?
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Key As Ark.ConfigKey) As Variant
		  Var UUID As String = Key.UUID
		  If Self.mSettings.HasKey(UUID) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mSettings.Value(UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As Ark.ConfigKey, Assigns NewValue As Variant)
		  Var UUID As String = Key.UUID
		  If NewValue.IsNull Then
		    If Self.mSettings.HasKey(UUID) Then
		      Self.mSettings.Remove(UUID)
		      Self.Modified = True
		      Return
		    End If
		  End If
		  
		  If Self.mSettings.HasKey(UUID) Then
		    Var OldValue As Variant = Self.mSettings.Value(UUID)
		    If Key.ValuesEqual(OldValue, NewValue) = True Then
		      Return
		    End If
		  End If
		  
		  Self.mSettings.Value(UUID) = NewValue
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSettings As Dictionary
	#tag EndProperty


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
