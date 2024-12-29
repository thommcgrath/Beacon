#tag Class
Protected Class GeneralSettings
Inherits SDTD.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As SDTD.ConfigGroup)
		  Var Source As SDTD.Configs.GeneralSettings = SDTD.Configs.GeneralSettings(Other)
		  For Each Entry As DictionaryEntry In Source.mSettings
		    Self.mSettings.Value(Entry.Key) = Entry.Value
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As SDTD.Project, Profile As SDTD.ServerProfile) As SDTD.ConfigValue()
		  Var ConsoleSafe As Boolean = Project.IsFlagged(Beacon.Project.FlagConsoleSafe)
		  Var Configs() As SDTD.ConfigValue
		  Var DataSource As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Try
		      Var KeyId As String = Entry.Key
		      Var Key As SDTD.ConfigOption = DataSource.GetConfigOption(KeyId)
		      Var Value As Variant = Entry.Value
		      Var StringValue As String
		      
		      If Key Is Nil Or Project.ContentPackEnabled(Key.ContentPackId) = False Then
		        Continue
		      End If
		      
		      Var Requirements As Variant = Key.Constraint("other")
		      If IsNull(Requirements) = False Then
		        Var Dict As Dictionary = Requirements
		        Var OtherKeyId As String = Dict.Value("key")
		        Var RequiredValue As Boolean = Dict.Value("value")
		        Var CurrentValue As Variant
		        If Self.mSettings.HasKey(OtherKeyId) Then
		          CurrentValue = Self.mSettings.Value(OtherKeyId)
		        Else
		          Var OtherKey As SDTD.ConfigOption = DataSource.GetConfigOption(OtherKeyId)
		          If (OtherKey Is Nil) = False Then
		            CurrentValue = OtherKey.DefaultValue
		          End If
		        End If
		        If CurrentValue <> RequiredValue Then
		          Continue
		        End If
		      End If
		      
		      If Key.ValueType = SDTD.ConfigOption.ValueTypes.TypeText Then
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
		      ElseIf Profile.Platform <> Beacon.PlatformUnknown Then
		        Var RequiredPlatform As Variant = Key.Constraint("platform")
		        Var SupportedOnPlatform As Boolean = True
		        If IsNull(RequiredPlatform) = False Then
		          Select Case RequiredPlatform.StringValue
		          Case "pc", "steam", "epic"
		            SupportedOnPlatform = (Profile.Platform = Beacon.PlatformPC)
		          Case "xbox"
		            SupportedOnPlatform = (Profile.Platform = Beacon.PlatformXbox)
		          Case "ps"
		            SupportedOnPlatform = (Profile.Platform = Beacon.PlatformPlayStation)
		          Case "switch"
		            SupportedOnPlatform = (Profile.Platform = Beacon.PlatformSwitch)
		          Case "console"
		            SupportedOnPlatform = (Profile.Platform = Beacon.PlatformXbox Or Profile.Platform = Beacon.PlatformPlayStation)
		          End Select
		          If SupportedOnPlatform = False Then
		            Continue
		          End If
		        End If
		      End If
		      
		      Select Case Key.ValueType
		      Case SDTD.ConfigOption.ValueTypes.TypeBoolean
		        StringValue = If(Value.BooleanValue, "True", "False")
		      Case SDTD.ConfigOption.ValueTypes.TypeNumeric
		        StringValue = Value.DoubleValue.PrettyText
		      Case SDTD.ConfigOption.ValueTypes.TypeText
		        StringValue = Value.StringValue
		      Else
		        Continue
		      End Select
		      
		      Configs.Add(New SDTD.ConfigValue(Key, StringValue))
		    Catch Err As RuntimeException
		      App.ReportException(Err)
		    End Try
		  Next
		  Return Configs
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As SDTD.ConfigOption()
		  Var Keys() As SDTD.ConfigOption
		  Var DataSource As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Var KeyId As String = Entry.Key
		    Var Key As SDTD.ConfigOption = DataSource.GetConfigOption(KeyId)
		    If (Key Is Nil) = False Then
		      Keys.Add(Key)
		    End If
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
		Shared Function FromImport(ParsedData As Dictionary, ContentPacks As Beacon.StringList) As SDTD.Configs.GeneralSettings
		  Var DataSource As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  Var AllContentPacks() As Beacon.ContentPack = DataSource.GetContentPacks
		  Var ContentPackLookup As New Dictionary
		  For Each Pack As Beacon.ContentPack In AllContentPacks
		    ContentPackLookup.Value(Pack.ContentPackId) = Pack
		  Next Pack
		  
		  Var Doc As XmlDocument = ParsedData.Lookup(SDTD.ConfigFileServerConfigXml, Nil)
		  If Doc Is Nil Then
		    Return Nil
		  End If
		  
		  Var Values As New Dictionary
		  Var PropertyNodes As XmlNodeList = Doc.DocumentElement.XQL("//property")
		  Var Bound As Integer = PropertyNodes.Length - 1
		  For Idx As Integer = 0 To Bound
		    Var PropertyNode As XmlNode = PropertyNodes.Item(Idx)
		    Var Key As String = PropertyNode.GetAttribute("name")
		    Var Value As String = PropertyNode.GetAttribute("value")
		    Values.Value(Key) = Value
		  Next
		  
		  Var Config As New SDTD.Configs.GeneralSettings
		  Var AllKeys() As SDTD.ConfigOption = DataSource.GetConfigOptions("", "")
		  For Each Key As SDTD.ConfigOption In AllKeys
		    If KeySupported(Key, ContentPacks) = False Then
		      Continue
		    End If
		    
		    Var Value As Variant
		    Select Case Key.ValueType
		    Case SDTD.ConfigOption.ValueTypes.TypeNumeric
		      Value = Values.DoubleValue(Key.Key, Key.DefaultValue.DoubleValue, True)
		    Case SDTD.ConfigOption.ValueTypes.TypeBoolean
		      Value = Values.BooleanValue(Key.Key, Key.DefaultValue.BooleanValue, True)
		    Case SDTD.ConfigOption.ValueTypes.TypeText
		      Value = Values.StringValue(Key.Key, Key.DefaultValue.StringValue, True)
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
		  Return SDTD.Configs.NameGeneralSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function KeySupported(Key As SDTD.ConfigOption, ContentPacks As Beacon.StringList) As Boolean
		  If (Key.NativeEditorVersion Is Nil) = False And Key.NativeEditorVersion.IntegerValue <= App.BuildNumber Then
		    // We have a native editor for this key
		    Return False
		  End If
		  If Key.MaxAllowed Is Nil Or Key.MaxAllowed.IntegerValue <> 1 Then
		    // Only support single value keys
		    Return False
		  End If
		  If ContentPacks.IndexOf(Key.ContentPackId) = -1 Then
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
		Function Value(Key As SDTD.ConfigOption) As Variant
		  Var KeyId As String = Key.ConfigOptionId
		  If Self.mSettings.HasKey(KeyId) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mSettings.Value(KeyId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As SDTD.ConfigOption, Assigns NewValue As Variant)
		  Var KeyId As String = Key.ConfigOptionId
		  If NewValue.IsNull Then
		    If Self.mSettings.HasKey(KeyId) Then
		      Self.mSettings.Remove(KeyId)
		      Self.Modified = True
		      Return
		    End If
		  End If
		  
		  If Self.mSettings.HasKey(KeyId) Then
		    Var OldValue As Variant = Self.mSettings.Value(KeyId)
		    If Key.ValuesEqual(OldValue, NewValue) = True Then
		      Return
		    End If
		  End If
		  
		  Self.mSettings.Value(KeyId) = NewValue
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
