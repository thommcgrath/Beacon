#tag Class
Protected Class OtherSettings
Inherits Palworld.ConfigGroup
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As Palworld.ConfigGroup)
		  Var Source As Palworld.Configs.OtherSettings = Palworld.Configs.OtherSettings(Other)
		  For Each Entry As DictionaryEntry In Source.mSettings
		    Self.mSettings.Value(Entry.Key) = Entry.Value
		  Next Entry
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Palworld.Project, Profile As Palworld.ServerProfile) As Palworld.ConfigValue()
		  Var Configs() As Palworld.ConfigValue
		  Var DataSource As Palworld.DataSource = Palworld.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Try
		      Var KeyUUID As String = Entry.Key
		      Var Key As Palworld.ConfigOption = DataSource.GetConfigOption(KeyUUID)
		      Var Value As Variant = Entry.Value
		      Var StringValue As String
		      
		      If Key Is Nil Or Project.ContentPackEnabled(Key.ContentPackId) = False Then
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
		          Var OtherKey As Palworld.ConfigOption = DataSource.GetConfigOption(OtherKeyUUID)
		          If (OtherKey Is Nil) = False Then
		            CurrentValue = OtherKey.DefaultValue
		          End If
		        End If
		        If CurrentValue <> RequiredValue Then
		          Continue
		        End If
		      End If
		      
		      If Key.ValueType = Palworld.ConfigOption.ValueTypes.TypeText Then
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
		      
		      Select Case Key.ValueType
		      Case Palworld.ConfigOption.ValueTypes.TypeBoolean
		        StringValue = If(Value.BooleanValue, "True", "False")
		      Case Palworld.ConfigOption.ValueTypes.TypeNumeric
		        StringValue = Value.DoubleValue.PrettyText
		      Case Palworld.ConfigOption.ValueTypes.TypeText
		        StringValue = """" + Value.StringValue + """"
		      Else
		        Continue
		      End Select
		      
		      Configs.Add(New Palworld.ConfigValue(Key, Key.Key + "=" + StringValue, Key.SimplifiedKey))
		    Catch Err As RuntimeException
		      App.ReportException(Err)
		    End Try
		  Next
		  Return Configs
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Palworld.ConfigOption()
		  Var Keys() As Palworld.ConfigOption
		  Var DataSource As Palworld.DataSource = Palworld.DataSource.Pool.Get(False)
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Var KeyUUID As String = Entry.Key
		    Var Key As Palworld.ConfigOption = DataSource.GetConfigOption(KeyUUID)
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
		Shared Function FromImport(ParsedData As Dictionary, ContentPacks As Beacon.StringList) As Palworld.Configs.OtherSettings
		  Var DataSource As Palworld.DataSource = Palworld.DataSource.Pool.Get(False)
		  Var AllContentPacks() As Beacon.ContentPack = DataSource.GetContentPacks
		  Var ContentPackLookup As New Dictionary
		  For Each Pack As Beacon.ContentPack In AllContentPacks
		    ContentPackLookup.Value(Pack.ContentPackId) = Pack
		  Next Pack
		  
		  Var Config As New Palworld.Configs.OtherSettings
		  Var AllKeys() As Palworld.ConfigOption = DataSource.GetConfigOptions("", "", "", "", False)
		  For Each Key As Palworld.ConfigOption In AllKeys
		    If KeySupported(Key, ContentPacks) = False Or Key.AutoImported = False Then
		      Continue
		    End If
		    
		    Var LookupKey As String = Key.Key
		    Var Pack As Beacon.ContentPack = ContentPackLookup.Lookup(Key.ContentPackId, Nil)
		    If (Pack Is Nil) = False And Pack.IsConsoleSafe = False Then
		      LookupKey = Key.Header + "." + Key.Key
		    End If
		    
		    Var TargetDict As Dictionary
		    If (Key.Struct Is Nil) = False And ParsedData.HasKey(Key.Struct.StringValue) Then
		      TargetDict = ParsedData.Value(Key.Struct.StringValue)
		    ElseIf ParsedData.HasKey(LookupKey) Then
		      TargetDict = ParsedData
		    Else
		      Continue
		    End If
		    
		    Var Value As Variant
		    Select Case Key.ValueType
		    Case Palworld.ConfigOption.ValueTypes.TypeNumeric
		      Value = TargetDict.DoubleValue(LookupKey, Key.DefaultValue.DoubleValue, True)
		    Case Palworld.ConfigOption.ValueTypes.TypeBoolean
		      Value = TargetDict.BooleanValue(LookupKey, Key.DefaultValue.BooleanValue, True)
		    Case Palworld.ConfigOption.ValueTypes.TypeText
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
		  Return Palworld.Configs.NameGeneralSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function KeySupported(Key As Palworld.ConfigOption, ContentPacks As Beacon.StringList) As Boolean
		  If (Key.NativeEditorVersion Is Nil) = False And Key.NativeEditorVersion.IntegerValue <= App.BuildNumber Then
		    // We have a native editor for this key
		    Return False
		  End If
		  If Key.ValueType = Palworld.ConfigOption.ValueTypes.TypeArray Or Key.ValueType = Palworld.ConfigOption.ValueTypes.TypeStructure Then
		    // Can't support these types
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
		Function RequiresOmni() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Key As Palworld.ConfigOption) As Variant
		  If Self.mSettings.HasKey(Key.ConfigOptionId) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mSettings.Value(Key.ConfigOptionId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As Palworld.ConfigOption, Assigns NewValue As Variant)
		  Var ConfigOptionId As String = Key.ConfigOptionId
		  If NewValue.IsNull Then
		    If Self.mSettings.HasKey(ConfigOptionId) Then
		      Self.mSettings.Remove(ConfigOptionId)
		      Self.Modified = True
		      Return
		    End If
		  End If
		  
		  If Self.mSettings.HasKey(ConfigOptionId) Then
		    Var OldValue As Variant = Self.mSettings.Value(ConfigOptionId)
		    If Key.ValuesEqual(OldValue, NewValue) = True Then
		      Return
		    End If
		  End If
		  
		  Self.mSettings.Value(ConfigOptionId) = NewValue
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
