#tag Class
Protected Class OtherSettings
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  Var Configs() As Beacon.ConfigValue
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Try
		      Var KeyUUID As String = Entry.Key
		      Var Key As Beacon.ConfigKey = Beacon.Data.GetConfigKey(KeyUUID)
		      Var Value As Variant = Entry.Value
		      Var StringValue As String
		      
		      Select Case Key.ValueType
		      Case Beacon.ConfigKey.ValueTypes.TypeBoolean
		        StringValue = If(Value.BooleanValue, "True", "False")
		      Case Beacon.ConfigKey.ValueTypes.TypeNumeric
		        StringValue = Value.DoubleValue.PrettyText
		      Case Beacon.ConfigKey.ValueTypes.TypeText
		        StringValue = Value.StringValue
		      Else
		        Continue
		      End Select
		      
		      Configs.Add(New Beacon.ConfigValue(Key, Key.Key + "=" + StringValue, Key.SimplifiedKey))
		    Catch Err As RuntimeException
		      App.ReportException(Err)
		    End Try
		  Next
		  Return Configs
		  
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  For Each Entry As DictionaryEntry In Self.mSettings
		    Var KeyUUID As String = Entry.Key
		    Var Key As Beacon.ConfigKey = Beacon.Data.GetConfigKey(KeyUUID)
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
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  If (Other IsA BeaconConfigs.OtherSettings) = False Then
		    Return
		  End If
		  
		  For Each Entry As DictionaryEntry In BeaconConfigs.OtherSettings(Other).mSettings
		    Self.mSettings.Value(Entry.Key) = Entry.Value
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  Try
		    Self.mSettings = Dict.Value("Settings")
		  Catch Err As RuntimeException
		    Self.mSettings = New Dictionary
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Settings") = Self.mSettings
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameOtherSettings
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSettings = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.OtherSettings
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  Var Config As New BeaconConfigs.OtherSettings
		  Var PotentialKeys() As Beacon.ConfigKey = Config.UnimplementedKeys
		  For Each Key As Beacon.ConfigKey In PotentialKeys
		    Var TargetDict As Dictionary
		    If CommandLineOptions.HasKey(Key.Key) Then
		      TargetDict = CommandLineOptions
		    ElseIf ParsedData.HasKey(Key.Key) Then
		      TargetDict = ParsedData
		    Else
		      Continue
		    End If
		    
		    Var Value As Variant
		    Select Case Key.ValueType
		    Case Beacon.ConfigKey.ValueTypes.TypeNumeric
		      Value = TargetDict.DoubleValue(Key.Key, Key.DefaultValue.DoubleValue, False)
		    Case Beacon.ConfigKey.ValueTypes.TypeBoolean
		      Value = TargetDict.BooleanValue(Key.Key, Key.DefaultValue.BooleanValue, False)
		    Case Beacon.ConfigKey.ValueTypes.TypeText
		      Value = TargetDict.StringValue(Key.Key, Key.DefaultValue.StringValue, False)
		    Else
		      Continue
		    End Select
		    
		    Config.Value(Key) = Value
		  Next
		  
		  If Config.mSettings.KeyCount > 0 Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UnimplementedKeys() As Beacon.ConfigKey()
		  Var AllKeys() As Beacon.ConfigKey = Beacon.Data.SearchForConfigKey("", "", "")
		  Var FilteredKeys() As Beacon.ConfigKey
		  Var ImplementedKeys() As Beacon.ConfigKey = Self.ManagedKeys
		  Var ImplementedKeyUUIDs() As String
		  For Each Key As Beacon.ConfigKey In ImplementedKeys
		    ImplementedKeyUUIDs.Add(Key.UUID)
		  Next
		  For Each Key As Beacon.ConfigKey In AllKeys
		    If ((Key.MaxAllowed Is Nil) = False And Key.MaxAllowed.IntegerValue <> 1) Or Key.HasNativeEditor Or ImplementedKeyUUIDs.IndexOf(Key.UUID) > -1 Or Key.ValueType = Beacon.ConfigKey.ValueTypes.TypeArray Or Key.ValueType = Beacon.ConfigKey.ValueTypes.TypeStructure Then
		      Continue
		    End If
		    FilteredKeys.Add(Key)
		  Next
		  Return FilteredKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Key As Beacon.ConfigKey) As Variant
		  Var UUID As String = Key.UUID
		  If Self.mSettings.HasKey(UUID) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mSettings.Value(UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Key As Beacon.ConfigKey, Assigns NewValue As Variant)
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
