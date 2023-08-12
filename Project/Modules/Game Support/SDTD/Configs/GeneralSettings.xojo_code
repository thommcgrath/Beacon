#tag Class
Protected Class GeneralSettings
Inherits SDTD.ConfigGroup
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
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
		  
		  Var Config As New SDTD.Configs.GeneralSettings
		  Var AllKeys() As SDTD.ConfigOption = DataSource.GetConfigOptions("", "")
		  For Each Key As SDTD.ConfigOption In AllKeys
		    If KeySupported(Key, ContentPacks) = False Then
		      Continue
		    End If
		    
		    Var Value As Variant
		    Select Case Key.ValueType
		    Case SDTD.ConfigOption.ValueTypes.TypeNumeric
		      Value = ParsedData.DoubleValue(Key.ObjectId, Key.DefaultValue.DoubleValue, True)
		    Case SDTD.ConfigOption.ValueTypes.TypeBoolean
		      Value = ParsedData.BooleanValue(Key.ObjectId, Key.DefaultValue.BooleanValue, True)
		    Case SDTD.ConfigOption.ValueTypes.TypeText
		      Value = ParsedData.StringValue(Key.ObjectId, Key.DefaultValue.StringValue, True)
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
		  Var KeyId As String = Key.ObjectId
		  If Self.mSettings.HasKey(KeyId) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mSettings.Value(KeyId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As SDTD.ConfigOption, Assigns NewValue As Variant)
		  Var KeyId As String = Key.ObjectId
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
