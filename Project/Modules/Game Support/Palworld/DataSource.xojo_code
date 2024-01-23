#tag Class
Protected Class DataSource
Inherits Beacon.DataSource
	#tag Event
		Sub BuildSchema()
		  Self.SQLExecute("CREATE TABLE content_packs (content_pack_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, game_id TEXT COLLATE NOCASE NOT NULL, marketplace TEXT COLLATE NOCASE NOT NULL, marketplace_id TEXT NOT NULL, name TEXT COLLATE NOCASE NOT NULL, console_safe INTEGER NOT NULL, default_enabled INTEGER NOT NULL, is_local BOOLEAN NOT NULL, last_update INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE game_variables (key TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE ini_options (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', native_editor_version INTEGER, file TEXT COLLATE NOCASE NOT NULL, header TEXT COLLATE NOCASE NOT NULL, key TEXT COLLATE NOCASE NOT NULL, value_type TEXT COLLATE NOCASE NOT NULL, max_allowed INTEGER, description TEXT NOT NULL, default_value TEXT, nitrado_path TEXT COLLATE NOCASE, nitrado_format TEXT COLLATE NOCASE, nitrado_deploy_style TEXT COLLATE NOCASE, ui_group TEXT COLLATE NOCASE, custom_sort TEXT COLLATE NOCASE, constraints TEXT, gsa_placeholder TEXT COLLATE NOCASE, uwp_changes TEXT);")
		End Sub
	#tag EndEvent

	#tag Event
		Function DefineIndexes() As Beacon.DataIndex()
		  Var Indexes() As Beacon.DataIndex
		  Indexes.Add(New Beacon.DataIndex("content_packs", True, "marketplace", "marketplace_id", "WHERE is_local = 0"))
		  Indexes.Add(New Beacon.DataIndex("content_packs", True, "marketplace", "marketplace_id", "WHERE is_local = 1 AND (marketplace != '' OR marketplace_id != '')"))
		  Indexes.Add(New Beacon.DataIndex("ini_options", True, "file", "header", "key"))
		  Return Indexes
		End Function
	#tag EndEvent

	#tag Event
		Function DeleteContentPack(ContentPackId As String) As Boolean
		  If ContentPackId = Palworld.UserContentPackId Then
		    Self.DeleteDataForContentPack(ContentPackId)
		    Return True
		  End If
		  
		  Self.BeginTransaction()
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT content_pack_id FROM content_packs WHERE content_pack_id = ?1 AND is_local = 1;", ContentPackId)
		  If Rows.RowCount = 0 Then
		    Self.RollbackTransaction()
		    Return False
		  End If
		  
		  Self.DeleteDataForContentPack(ContentPackId)
		  Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id = ?1;", ContentPackId)
		  Self.CommitTransaction()
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function GetSchemaVersion() As Integer
		  Return 100
		End Function
	#tag EndEvent

	#tag Event
		Sub ObtainLock()
		  mLock.Enter
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReleaseLock()
		  mLock.Leave
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(AllowWriting As Boolean)
		  If Self.mConfigOptionCache Is Nil Then
		    Self.mConfigOptionCache = New Dictionary
		  End If
		  
		  If mLock Is Nil Then
		    mLock = New CriticalSection
		  End If
		  
		  Super.Constructor(AllowWriting)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteDataForContentPack(ContentPackId As String)
		  #Pragma Unused ContentPackId
		  
		  // Nothing needs to happen
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As String, Default As Boolean = False) As Boolean
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Return Value.BooleanValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOption(KeyUUID As String) As Palworld.ConfigOption
		  If Self.mConfigOptionCache.HasKey(KeyUUID) Then
		    Return Self.mConfigOptionCache.Value(KeyUUID)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect(Self.ConfigOptionSelectSQL + " WHERE object_id = ?1;", KeyUUID)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Results() As Palworld.ConfigOption = Self.RowSetToConfigOptions(Rows)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOption(File As String, Header As String, Key As String) As Palworld.ConfigOption
		  Var Results() As Palworld.ConfigOption = Self.GetConfigOptions(File, Header, Key, False)
		  If Results.Count = 1 Then
		    Return Results(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOptions(File As String, Header As String, Key As String, SortHuman As Boolean) As Palworld.ConfigOption()
		  Var Clauses() As String
		  Var Values As New Dictionary
		  Var Idx As Integer = 1
		  
		  If File.IsEmpty = False Then
		    Values.Value(Idx) = File
		    Clauses.Add("file = ?" + Idx.ToString)
		    Idx = Idx + 1
		  End If
		  If Header.IsEmpty = False Then
		    Values.Value(Idx) = Header
		    Clauses.Add("header = ?" + Idx.ToString)
		    Idx = Idx + 1
		  End If
		  If Key.IsEmpty = False Then
		    If Key.IndexOf("*") > -1 Then
		      Values.Value(Idx) = Self.EscapeLikeValue(Key).ReplaceAll("*", "%")
		      Clauses.Add("key LIKE ?" + Idx.ToString + " ESCAPE '\'")
		    Else
		      Values.Value(Idx) = Key
		      Clauses.Add("key = ?" + Idx.ToString)
		    End If
		    Idx = Idx + 1
		  End If
		  
		  Var SQL As String = Self.ConfigOptionSelectSQL
		  If Clauses.Count > 0 Then
		    SQL = SQL + " WHERE " + Clauses.Join(" AND ")
		  End If
		  If SortHuman Then
		    SQL = SQL + " ORDER BY COALESCE(custom_sort, label)"
		  Else
		    SQL = SQL + " ORDER BY key"
		  End If
		  
		  Var Results() As Palworld.ConfigOption
		  Try
		    Results = Self.RowSetToConfigOptions(Self.SQLSelect(SQL, Values))
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		  End Try
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPack(Marketplace As String, MarketplaceId As String) As Beacon.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT content_pack_id, game_id, name, console_safe, default_enabled, marketplace, marketplace_id, is_local, last_update FROM content_packs WHERE marketplace = ?1 AND marketplace_id = ?2 ORDER BY is_local DESC LIMIT 1;", Marketplace, MarketplaceId)
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Results)
		  If Packs.Count = 1 Then
		    Return Packs(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetContentPack(Marketplace As String, MarketplaceId As String, Type As Beacon.ContentPack.Types) As Beacon.ContentPack
		  Var Results As RowSet = Self.SQLSelect("SELECT content_pack_id, game_id, name, console_safe, default_enabled, marketplace, marketplace_id, is_local, last_update FROM content_packs WHERE marketplace = ?1 AND marketplace_id = ?2 AND is_local = ?3 ORDER BY is_local DESC LIMIT 1;", Marketplace, MarketplaceId, Type = Beacon.ContentPack.Types.Custom)
		  Var Packs() As Beacon.ContentPack = Beacon.ContentPack.FromDatabase(Results)
		  If Packs.Count = 1 Then
		    Return Packs(0)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As String, Default As Double = 0.0) As Double
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Return Value.DoubleValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As String, Default As Integer = 0) As Integer
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Return Value.IntegerValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStringVariable(Key As String, Default As String = "") As String
		  Var Value As Variant = Self.GetVariable(Key, Default)
		  Var StringValue As String = Value.StringValue
		  If StringValue.Encoding = Nil Then
		    If Encodings.UTF8.IsValidData(StringValue) Then
		      StringValue = StringValue.DefineEncoding(Encodings.UTF8)
		    Else
		      Return Default
		    End If
		  End If
		  Return StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetVariable(Key As String, Default As Variant = Nil) As Variant
		  Var Results As RowSet = Self.SQLSelect("SELECT value FROM game_variables WHERE key = ?1;", Key)
		  If Results.RowCount = 1 Then
		    Return Results.Column("value").Value
		  Else
		    Return Default
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return Palworld.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Pool() As Palworld.DataSourcePool
		  If mPool Is Nil Then
		    mPool = New Palworld.DataSourcePool
		  End If
		  Return mPool
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ReplaceUserBlueprints()
		  If Self.Writeable = False Then
		    Return
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("INSERT OR REPLACE INTO content_packs (content_pack_id, name, console_safe, default_enabled, is_local, last_update, marketplace, marketplace_id, game_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6, '', '', ?7);", Palworld.UserContentPackId, Palworld.UserContentPackName, True, True, True, Beacon.FixedTimestamp, Palworld.Identifier)
		  Self.CommitTransaction()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowSetToConfigOptions(Results As RowSet) As Palworld.ConfigOption()
		  Var Keys() As Palworld.ConfigOption
		  Try
		    While Results.AfterLastRow = False
		      Var ConfigOptionId As String = Results.Column("object_id").StringValue
		      If Self.mConfigOptionCache.HasKey(ConfigOptionId) Then
		        Results.MoveToNextRow
		        Keys.Add(Self.mConfigOptionCache.Value(ConfigOptionId))
		        Continue
		      End If
		      
		      Var Label As String = Results.Column("label").StringValue
		      Var ConfigFile As String = Results.Column("file").StringValue
		      Var ConfigHeader As String = Results.Column("header").StringValue
		      Var ConfigOption As String = Results.Column("key").StringValue
		      Var ValueType As Palworld.ConfigOption.ValueTypes
		      Select Case Results.Column("value_type").StringValue
		      Case "Numeric"
		        ValueType = Palworld.ConfigOption.ValueTypes.TypeNumeric
		      Case "Array"
		        ValueType = Palworld.ConfigOption.ValueTypes.TypeArray
		      Case "Structure"
		        ValueType = Palworld.ConfigOption.ValueTypes.TypeStructure
		      Case "Boolean"
		        ValueType = Palworld.ConfigOption.ValueTypes.TypeBoolean
		      Case "Text"
		        ValueType = Palworld.ConfigOption.ValueTypes.TypeText
		      End Select
		      Var MaxAllowed As NullableDouble
		      If IsNull(Results.Column("max_allowed").Value) = False Then
		        MaxAllowed = Results.Column("max_allowed").IntegerValue
		      End If
		      Var Description As String = Results.Column("description").StringValue
		      Var DefaultValue As Variant = Results.Column("default_value").Value
		      Var NitradoPath As NullableString
		      Var NitradoFormat As Palworld.ConfigOption.NitradoFormats = Palworld.ConfigOption.NitradoFormats.Unsupported
		      Var NitradoDeployStyle As Palworld.ConfigOption.NitradoDeployStyles = Palworld.ConfigOption.NitradoDeployStyles.Unsupported
		      If IsNull(Results.Column("nitrado_format").Value) = False Then
		        NitradoPath = Results.Column("nitrado_path").StringValue
		        Select Case Results.Column("nitrado_format").StringValue
		        Case "Line"
		          NitradoFormat = Palworld.ConfigOption.NitradoFormats.Line
		        Case "Value"
		          NitradoFormat = Palworld.ConfigOption.NitradoFormats.Value
		        End Select
		        Select Case Results.Column("nitrado_deploy_style").StringValue
		        Case "Guided"
		          NitradoDeployStyle = Palworld.ConfigOption.NitradoDeployStyles.Guided
		        Case "Expert"
		          NitradoDeployStyle = Palworld.ConfigOption.NitradoDeployStyles.Expert
		        Case "Both"
		          NitradoDeployStyle = Palworld.ConfigOption.NitradoDeployStyles.Both
		        End Select
		      End If
		      Var NativeEditorVersion As NullableDouble = NullableDouble.FromVariant(Results.Column("native_editor_version").Value)
		      Var UIGroup As NullableString = NullableString.FromVariant(Results.Column("ui_group").Value)
		      Var CustomSort As NullableString = NullableString.FromVariant(Results.Column("custom_sort").Value)
		      Var ContentPackId As String = Results.Column("content_pack_id").StringValue
		      Var GSAPlaceholder As NullableString = NullableString.FromVariant(Results.Column("gsa_placeholder").Value)
		      
		      Var Constraints As Dictionary
		      If IsNull(Results.Column("constraints").Value) = False Then
		        Try
		          Var Parsed As Variant = Beacon.ParseJSON(Results.Column("constraints").StringValue)
		          If IsNull(Parsed) = False And Parsed IsA Dictionary Then
		            Constraints = Parsed
		          End If
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      
		      Var UWPChanges As Dictionary
		      If IsNull(Results.Column("uwp_changes").Value) = False Then
		        Try
		          Var Parsed As Variant = Beacon.ParseJSON(Results.Column("uwp_changes").StringValue)
		          If IsNull(Parsed) = False And Parsed IsA Dictionary Then
		            UWPChanges = Parsed
		          End If
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      
		      Var Key As New Palworld.ConfigOption(ConfigOptionId, Label, ConfigFile, ConfigHeader, ConfigOption, ValueType, MaxAllowed, Description, DefaultValue, NitradoPath, NitradoFormat, NitradoDeployStyle, NativeEditorVersion, UIGroup, CustomSort, Constraints, ContentPackId, GSAPlaceholder, UWPChanges)
		      Self.mConfigOptionCache.Value(ConfigOptionId) = Key
		      Keys.Add(Key)
		      Results.MoveToNextRow
		    Wend
		  Catch Err As RuntimeException
		    App.ReportException(Err)
		    Keys.ResizeTo(-1)
		  End Try
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteableInstance() As Palworld.DataSource
		  Return Self.Pool.Get(True)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mConfigOptionCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mPool As Palworld.DataSourcePool
	#tag EndProperty


	#tag Constant, Name = ConfigOptionSelectSQL, Type = String, Dynamic = False, Default = \"SELECT object_id\x2C label\x2C file\x2C header\x2C key\x2C value_type\x2C max_allowed\x2C description\x2C default_value\x2C nitrado_path\x2C nitrado_format\x2C nitrado_deploy_style\x2C native_editor_version\x2C ui_group\x2C custom_sort\x2C constraints\x2C gsa_placeholder\x2C content_pack_id\x2C uwp_changes FROM ini_options", Scope = Private
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
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
