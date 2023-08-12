#tag Class
Protected Class DataSource
Inherits Beacon.DataSource
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub BuildSchema()
		  Self.SQLExecute("CREATE TABLE content_packs (content_pack_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, game_id TEXT COLLATE NOCASE NOT NULL, marketplace TEXT COLLATE NOCASE NOT NULL, marketplace_id TEXT NOT NULL, name TEXT COLLATE NOCASE NOT NULL, console_safe INTEGER NOT NULL, default_enabled INTEGER NOT NULL, is_local BOOLEAN NOT NULL, last_update INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE config_options (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, content_pack_id TEXT COLLATE NOCASE NOT NULL REFERENCES content_packs(content_pack_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED, label TEXT COLLATE NOCASE NOT NULL, alternate_label TEXT COLLATE NOCASE, tags TEXT COLLATE NOCASE NOT NULL DEFAULT '', file TEXT NOT NULL, key TEXT NOT NULL, value_type TEXT COLLATE NOCASE NOT NULL, max_allowed INTEGER, description TEXT NOT NULL, default_value TEXT, native_editor_version INTEGER, ui_group TEXT COLLATE NOCASE, custom_sort TEXT COLLATE NOCASE, constraints TEXT);")
		End Sub
	#tag EndEvent

	#tag Event
		Function DefineIndexes() As Beacon.DataIndex()
		  Var Indexes() As Beacon.DataIndex
		  Indexes.Add(New Beacon.DataIndex("content_packs", True, "is_local", "marketplace_id"))
		  Indexes.Add(New Beacon.DataIndex("config_options", True, "file", "key"))
		  Return Indexes
		End Function
	#tag EndEvent

	#tag Event
		Function GetSchemaVersion() As Integer
		  Return 1
		End Function
	#tag EndEvent

	#tag Event
		Function Import(ChangeDict As Dictionary, StatusData As Dictionary, Deletions() As Dictionary) As Boolean
		  Var BuildNumber As Integer = App.BuildNumber
		  Var Now As Double = DateTime.Now.SecondsFrom1970
		  
		  If ChangeDict.HasKey("contentPacks") Then
		    Var ContentPacks() As Variant = ChangeDict.Value("contentPacks")
		    For Each Dict As Dictionary In ContentPacks
		      Var MinVersion As Double = Dict.Value("minVersion")
		      If MinVersion > BuildNumber Then
		        Continue
		      End If
		      
		      Var ContentPackId As String = Dict.Value("contentPackId")
		      Var Name As String = Dict.Value("name")
		      Var ConsoleSafe As Boolean = Dict.Value("isConsoleSafe")
		      Var DefaultEnabled As Boolean = Dict.Value("isDefaultEnabled")
		      Var Marketplace As String = Dict.Lookup("marketplace", "")
		      Var MarketplaceId As String = Dict.Lookup("marketplaceId", "")
		      Var IsLocal As Boolean = MarketplaceId.IsEmpty Or Dict.Lookup("isConfirmed", False).BooleanValue = False
		      Var GameId As String = Dict.Value("gameId")
		      
		      Var Rows As RowSet
		      If MarketplaceId.IsEmpty Then
		        Rows = Self.SQLSelect("SELECT content_pack_id FROM content_packs WHERE content_pack_id = ?1;", ContentPackId)
		      Else
		        Rows = Self.SQLSelect("SELECT content_pack_id FROM content_packs WHERE content_pack_id = ?1 OR (marketplace = ?2 AND marketplace_id = ?3);", ContentPackId, Marketplace, MarketplaceId)
		      End If
		      If Rows.RowCount > 1 Then
		        Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id IS DISTINCT FROM ?1 AND marketplace = ?2 AND marketplace_id = ?3;", ContentPackId, Marketplace, MarketplaceId)
		      End If
		      If Rows.RowCount > 0 Then
		        Self.SQLExecute("UPDATE content_packs SET name = ?2, console_safe = ?3, default_enabled = ?4, marketplace = ?5, marketplace_id = ?6, is_local = ?7, last_update = ?8, game_id = ?9 WHERE content_pack_id = ?1;", ContentPackId, Name, ConsoleSafe, DefaultEnabled, Marketplace, MarketplaceId, IsLocal, Now, GameId)
		      Else
		        Self.SQLExecute("INSERT INTO content_packs (content_pack_id, name, console_safe, default_enabled, marketplace, marketplace_id, is_local, last_update, game_id) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9);", ContentPackId, Name, ConsoleSafe, DefaultEnabled, Marketplace, MarketplaceId, IsLocal, Now, GameId)
		      End If
		    Next
		  End If
		  
		  For Each Deletion As Dictionary In Deletions
		    Var ObjectId As String = Deletion.Value("object_id").StringValue
		    Var ObjectGroup As String = Deletion.Value("group").StringValue
		    
		    Select Case ObjectGroup
		    Case "config_options"
		      Self.SQLExecute("DELETE FROM " + ObjectGroup + " WHERE object_id = ?1;", ObjectId)
		    Case "content_packs"
		      Self.SQLExecute("DELETE FROM content_packs WHERE content_pack_id = ?1;", ObjectId)
		    End Select
		  Next
		  
		  If ChangeDict.HasKey("configOptions") Then
		    Var Options() As Variant = ChangeDict.Value("configOptions")
		    For Each Dict As Dictionary In Options
		      If Dict.Value("minVersion") > BuildNumber Then
		        Continue
		      End If
		      
		      Var ConfigOptionId As String = Dict.Value("configOptionId")
		      Var ContentPackId As String = Dict.Value("contentPackId")
		      Var File As String = Dict.Value("file")
		      Var Key As String = Dict.Value("key")
		      Var TagString, TagStringForSearching As String
		      Try
		        Var Tags() As String
		        Var Temp() As Variant = Dict.Value("tags")
		        For Each Tag As String In Temp
		          Tags.Add(Tag)
		        Next
		        TagString = Tags.Join(",")
		        Tags.AddAt(0, "object")
		        TagStringForSearching = Tags.Join(",")
		      Catch Err As RuntimeException
		      End Try
		      
		      Var Values(14) As Variant
		      Values(0) = ConfigOptionId
		      Values(1) = Dict.Value("label")
		      Values(2) = ContentPackId
		      Values(3) = File
		      Values(4) = Key
		      Values(5) = Dict.Value("valueType")
		      Values(6) = Dict.Value("maxAllowed")
		      Values(7) = Dict.Value("description")
		      Values(8) = Dict.Value("defaultValue")
		      Values(9) = Dict.Value("alternateLabel")
		      Values(10) = TagString
		      If Dict.HasKey("uiGroup") Then
		        Values(11) = Dict.Value("uiGroup")
		      End If
		      If Dict.HasKey("customSort") Then
		        Values(12) = Dict.Value("customSort")
		      End If
		      If Dict.HasKey("constraints") And IsNull(Dict.Value("constraints")) = False Then
		        Try
		          Values(13) = Beacon.GenerateJSON(Dict.Value("constraints"), False)
		        Catch JSONErr As RuntimeException
		        End Try
		      End If
		      If Dict.HasKey("nativeEditorVersion") Then
		        Values(14) = Dict.Value("nativeEditorVersion")
		      End If
		      
		      Var Results As RowSet = Self.SQLSelect("SELECT object_id FROM config_options WHERE object_id = ?1;", ConfigOptionId)
		      If Results.RowCount = 1 Then
		        Self.SQLExecute("UPDATE config_options SET label = ?2, content_pack_id = ?3, file = ?4, key = ?5, value_type = ?6, max_allowed = ?7, description = ?8, default_value = ?9, alternate_label = ?10, tags = ?11, ui_group = ?12, custom_sort = ?13, constraints = ?14, native_editor_version = ?15 WHERE object_id = ?1;", Values)
		      Else
		        Self.SQLExecute("INSERT INTO config_options (object_id, label, content_pack_id, file, key, value_type, max_allowed, description, default_value, alternate_label, tags, ui_group, custom_sort, constraints, native_editor_version) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, ?14, ?15);", Values)
		      End If
		    Next
		  End If
		  
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cache(Option As SDTD.ConfigOption)
		  If Option Is Nil Then
		    Return
		  End If
		  
		  
		  Self.mCache.Value(Option.ObjectId) = Option
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(AllowWriting As Boolean)
		  Self.mCache = New Dictionary
		  Super.Constructor(AllowWriting)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOption(ObjectId As String) As SDTD.ConfigOption
		  If Self.mCache.HasKey(ObjectId) Then
		    Return Self.mCache.Value(ObjectId)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT * FROM config_options WHERE object_id = $1;", ObjectId)
		  If Rows.RowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Option As SDTD.ConfigOption = Self.RowSetToConfigOption(Rows)
		  Self.Cache(Option)
		  Return Option
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOptions(File As String, Key As String) As SDTD.ConfigOption()
		  Return Self.GetConfigOptions(File, Key, New Beacon.StringList)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigOptions(File As String, Key As String, ContentPackIds As Beacon.StringList) As SDTD.ConfigOption()
		  If (ContentPackIds Is Nil) = False Then
		    ContentPackIds = New Beacon.StringList(ContentPackIds) // Make sure we don't edit the original
		    For Idx As Integer = ContentPackIds.LastRowIndex DownTo 0
		      If Beacon.UUID.Validate(ContentPackIds(Idx)) = False Then
		        ContentPackIds.Remove(Idx)
		      End If
		    Next
		  End If
		  
		  Var Clauses() As String
		  Var Values() As Variant
		  Var Idx As Integer = 1
		  
		  If File.IsEmpty = False Then
		    Clauses.Add("file = $" + Idx.ToString(Locale.Raw, "0"))
		    Values.Add(File)
		    Idx = Idx + 1
		  End If
		  If Key.IsEmpty = False Then
		    Clauses.Add("key = $" + Idx.ToString(Locale.Raw, "0"))
		    Values.Add(Key)
		    Idx = Idx + 1
		  End If
		  If (ContentPackIds Is Nil) = False And ContentPackIds.Count > 0 Then
		    Clauses.Add("content_pack_id IN ('" + String.FromArray(ContentPackIds, "','") + "')")
		  End If
		  
		  Var Sql As String = "SELECT * FROM config_options"
		  If Clauses.Count > 0 Then
		    Sql = Sql + " WHERE " + String.FromArray(Clauses, " AND ")
		  End If
		  Sql = Sql + ";"
		  
		  Var Rows As RowSet = Self.SQLSelect(Sql, Values)
		  Var Options() As SDTD.ConfigOption = Self.RowSetToConfigOptions(Rows)
		  For Each Option As SDTD.ConfigOption In Options
		    Self.Cache(Option)
		  Next
		  Return Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return SDTD.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainInstance() As Beacon.DataSource
		  Return Self.Pool.Main()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Pool() As SDTD.DataSourcePool
		  If mPool Is Nil Then
		    mPool = New SDTD.DataSourcePool
		  End If
		  Return mPool
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RowSetToConfigOption(Row As RowSet) As SDTD.ConfigOption
		  Var Label As String = Row.Column("label").StringValue
		  Var File As String = Row.Column("file").StringValue
		  Var Key As String = Row.Column("key").StringValue
		  Var ValueType As SDTD.ConfigOption.ValueTypes
		  Var MaxAllowed As NullableDouble = NullableDouble.FromVariant(Row.Column("max_allowed").Value)
		  Var Description As String = Row.Column("description").StringValue
		  Var DefaultValue As Variant = Row.Column("default_value").Value
		  Var NativeEditorVersion As NullableDouble = NullableDouble.FromVariant(Row.Column("native_editor_version").Value)
		  Var UIGroup As NullableString = NullableString.FromVariant(Row.Column("ui_group").Value)
		  Var CustomSort As NullableString = NullableString.FromVariant(Row.Column("custom_sort").Value)
		  Var Constraints As Dictionary
		  Var ContentPackId As String = Row.Column("content_pack_id").StringValue
		  
		  Select Case Row.Column("value_type").StringValue
		  Case "Numeric"
		    ValueType = SDTD.ConfigOption.ValueTypes.TypeNumeric
		  Case "Boolean"
		    ValueType = SDTD.ConfigOption.ValueTypes.TypeBoolean
		  Case "Text"
		    ValueType = SDTD.ConfigOption.ValueTypes.TypeText
		  End Select
		  
		  If IsNull(Row.Column("constraints").Value) = False Then
		    Try
		      Var Parsed As Variant = Beacon.ParseJSON(Row.Column("constraints").StringValue)
		      If IsNull(Parsed) = False And Parsed IsA Dictionary Then
		        Constraints = Parsed
		      End If
		    Catch JSONErr As JSONException
		    End Try
		  End If
		  
		  Return New SDTD.ConfigOption(Label, File, Key, ValueType, MaxAllowed, Description, DefaultValue, NativeEditorVersion, UIGroup, CustomSort, Constraints, ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RowSetToConfigOptions(Rows As RowSet) As SDTD.ConfigOption()
		  Var Options() As SDTD.ConfigOption
		  While Not Rows.AfterLastRow
		    Var Option As SDTD.ConfigOption = RowSetToConfigOption(Rows)
		    If (Option Is Nil) = False Then
		      Options.Add(Option)
		    End If
		    Rows.MoveToNextRow
		  Wend
		  Return Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteableInstance() As SDTD.DataSource
		  Return Self.Pool.Get(True)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mPool As SDTD.DataSourcePool
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
