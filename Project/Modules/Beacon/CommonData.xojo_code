#tag Class
Protected Class CommonData
Inherits Beacon.DataSource
	#tag Event
		Sub BuildSchema()
		  Self.SQLExecute("CREATE TABLE news (uuid TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, title TEXT NOT NULL, detail TEXT, url TEXT, min_version INTEGER, max_version INTEGER, moment TEXT NOT NULL, min_os_version TEXT);")
		  Self.SQLExecute("CREATE TABLE official_templates (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, game_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_templates (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, user_id TEXT COLLATE NOCASE NOT NULL, game_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, contents TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE official_template_selectors (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, game_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, language TEXT COLLATE NOCASE NOT NULL, code TEXT COLLATE NOCASE NOT NULL);")
		  Self.SQLExecute("CREATE TABLE custom_template_selectors (object_id TEXT COLLATE NOCASE NOT NULL PRIMARY KEY, user_id TEXT COLLATE NOCASE NOT NULL, game_id TEXT COLLATE NOCASE NOT NULL, label TEXT COLLATE NOCASE NOT NULL, language TEXT COLLATE NOCASE NOT NULL, code TEXT COLLATE NOCASE NOT NULL);")
		End Sub
	#tag EndEvent

	#tag Event
		Sub CloudSyncFinished(Actions() As Dictionary)
		  For Each Dict As Dictionary In Actions
		    Var Action As String = Dict.Value("Action")
		    Var Path As String = Dict.Value("Path")
		    Var Remote As Boolean = Dict.Value("Remote")
		    
		    If Remote And Path.EndsWith(Beacon.FileExtensionTemplate) And (Action = "GET" Or Action = "DELETE") Then
		      Self.ImportCloudFiles()
		      Return
		    End If
		  Next Dict
		End Sub
	#tag EndEvent

	#tag Event
		Function DefineIndexes() As Beacon.DataIndex()
		  Var Indexes() As Beacon.DataIndex
		  Indexes.Add(New Beacon.DataIndex("custom_templates", False, "user_id"))
		  Indexes.Add(New Beacon.DataIndex("custom_templates", True, "user_id", "object_id"))
		  Indexes.Add(New Beacon.DataIndex("custom_template_selectors", False, "user_id"))
		  Indexes.Add(New Beacon.DataIndex("custom_template_selectors", True, "user_id", "object_id"))
		  Return Indexes
		End Function
	#tag EndEvent

	#tag Event
		Sub ExportCloudFiles()
		  Var TemplateSelectors() As Beacon.TemplateSelector = Self.GetTemplateSelectors(Self.FlagIncludeUserItems)
		  Var SaveData() As Dictionary
		  For Idx As Integer = TemplateSelectors.FirstIndex To TemplateSelectors.LastIndex
		    Var Dict As Dictionary = TemplateSelectors(Idx).SaveData
		    If (Dict Is Nil) = False Then
		      SaveData.Add(Dict)
		    End If
		  Next Idx
		  If SaveData.Count > 0 Then
		    Var JSON As String = Beacon.GenerateJSON(SaveData, True)
		    Call UserCloud.Write("/Selectors.json", JSON)
		  Else
		    Call UserCloud.Delete("/Selectors.json")
		  End If
		  
		  Var ApprovedFilenames() As String
		  Var Templates() As Beacon.Template = Self.GetTemplates(Self.FlagIncludeUserItems)
		  For Idx As Integer = Templates.FirstIndex To Templates.LastIndex
		    Var Dict As Dictionary = Templates(Idx).SaveData
		    If Dict Is Nil Then
		      Continue For Idx
		    End If
		    
		    Var JSON As String = Beacon.GenerateJSON(Dict, True)
		    Var Filename As String = "/Templates/" + Templates(Idx).UUID.Lowercase + Beacon.FileExtensionTemplate
		    Call UserCloud.Write(Filename, JSON)
		    ApprovedFilenames.Add(Filename)
		  Next Idx
		  
		  Var Files() As String = UserCloud.List("/Templates/")
		  For Idx As Integer = Files.FirstIndex To Files.LastIndex
		    If ApprovedFilenames.IndexOf(Files(Idx)) > -1 Then
		      Continue
		    End If
		    
		    Call UserCloud.Delete(Files(Idx))
		  Next Idx
		  
		  // Cleanup old stuff
		  Call UserCloud.Delete("/Modifiers.json")
		  Var Presets() As String = UserCloud.List("/Presets/")
		  For Idx As Integer = Presets.FirstIndex To Presets.LastIndex
		    Call UserCloud.Delete(Presets(Idx))
		  Next Idx
		End Sub
	#tag EndEvent

	#tag Event
		Function GetSchemaVersion() As Integer
		  Return 101
		End Function
	#tag EndEvent

	#tag Event
		Function Import(ChangeDict As Dictionary, StatusData As Dictionary, Deletions() As Dictionary) As Boolean
		  Var BuildNumber As Integer = App.BuildNumber
		  Self.DropIndexes()
		  
		  For Each Dict As Dictionary In Deletions
		    Try
		      If Dict.HasKey("min_version") Then
		        Var MinVersion As Integer = Dict.Value("min_version").IntegerValue
		        If MinVersion > BuildNumber Then
		          Continue
		        End If
		      End If
		      
		      Var ObjectID As String = Dict.Value("object_id").StringValue
		      Var GameID As String = Dict.Value("game").StringValue
		      Var TableName As String = Dict.Value("group").StringValue
		      If GameID = Ark.Identifier And (TableName = "presets" Or TableName = "preset_modifiers") Then
		        Select Case TableName
		        Case "presets"
		          Self.SQLExecute("DELETE FROM official_templates WHERE object_id = :object_id;", ObjectID)
		        Case "preset_modifiers"
		          Self.SQLExecute("DELETE FROM official_template_selectors WHERE object_id = :object_id;", ObjectID)
		        End Select
		      End If
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Handling delete records")
		    End Try
		  Next Dict
		  
		  If ChangeDict.HasKey("templates") Then
		    Var Templates() As Variant = ChangeDict.Value("templates")
		    For Each Value As Variant In Templates
		      Try
		        Var Dict As Dictionary = Value
		        Var MinVersion As Integer = Dict.Value("min_version").IntegerValue
		        If MinVersion > BuildNumber Then
		          Continue
		        End If
		        
		        Var Contents As String = Dict.Value("contents")
		        Var Raw As Dictionary = Beacon.ParseJSON(Contents)
		        
		        Var Template As Beacon.Template = Beacon.Template.FromSaveData(Raw)
		        If Template Is Nil Then
		          Continue
		        End If
		        
		        Self.SaveTemplate(Template, True)
		        StatusData.Value("Imported Template") = True
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Importing template")
		      End Try
		    Next Value
		  End If
		  
		  If ChangeDict.HasKey("template_selectors") Then
		    Var TemplateSelectors() As Variant = ChangeDict.Value("template_selectors")
		    For Each Value As Variant In TemplateSelectors
		      Try
		        Var Dict As Dictionary = Value
		        Var MinVersion As Integer = Dict.Value("min_version").IntegerValue
		        If MinVersion > BuildNumber Then
		          Continue
		        End If
		        
		        Var SelectorUUID As String = Dict.Value("id").StringValue
		        Var GameID As String = Dict.Value("game").StringValue
		        Var Label As String = Dict.Value("label").StringValue
		        Var Language As Beacon.TemplateSelector.Languages = Beacon.TemplateSelector.StringToLanguage(Dict.Value("language").StringValue)
		        Var Code As String = Dict.Value("code").StringValue
		        
		        Var TemplateSelector As New Beacon.TemplateSelector(SelectorUUID, Label, GameID, Language, Code)
		        Self.SaveTemplateSelector(TemplateSelector, True)
		        StatusData.Value("Imported Template Selector") = True
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Importing template selector")
		      End Try
		    Next Value
		  End If
		  
		  Self.BuildIndexes()
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub ImportCleanup(StatusData As Dictionary)
		  If StatusData.Lookup("Imported Template", False).BooleanValue Then
		    Self.mTemplateCache = New Dictionary
		  End If
		  If StatusData.Lookup("Imported Template Selector", False).BooleanValue Then
		    Self.mSelectorCache = New Dictionary
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub ImportCloudFiles()
		  Self.BeginTransaction()
		  
		  Var CurrentTemplates() As Beacon.Template = Self.GetTemplates(FlagIncludeUserItems)
		  Var RemoveTemplateUUIDs As New Beacon.StringList
		  For Idx As Integer = CurrentTemplates.FirstIndex To CurrentTemplates.LastIndex
		    RemoveTemplateUUIDs.Append(CurrentTemplates(Idx).UUID)
		  Next Idx
		  Var PossibleFolders() As String = Array("/Templates/", "/Presets/")
		  For Each FolderName As String In PossibleFolders
		    Var FileList() As String = UserCloud.List(FolderName)
		    If FileList.Count = 0 Then
		      Continue For FolderName
		    End If
		    
		    For Idx As Integer = FileList.FirstIndex To FileList.LastIndex
		      Try
		        Var Contents As MemoryBlock = UserCloud.Read(FileList(Idx))
		        If Contents Is Nil Then
		          Continue For Idx
		        End If
		        
		        Var StringValue As String = Contents
		        Var Parsed As Dictionary = Beacon.ParseJSON(StringValue.DefineEncoding(Encodings.UTF8))
		        Var Template As Beacon.Template = Beacon.Template.FromSaveData(Parsed)
		        If (Template Is Nil) = False Then
		          Self.SaveTemplate(Template, False)
		          RemoveTemplateUUIDs.Remove(Template.UUID)
		        End If
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Importing cloud template")
		      End Try
		    Next Idx
		    
		    Exit For FolderName
		  Next FolderName
		  For Each TemplateUUID As String In RemoveTemplateUUIDs
		    Self.DeleteTemplate(TemplateUUID)
		  Next TemplateUUID
		  
		  
		  Var CurrentSelectors() As Beacon.TemplateSelector = Self.GetTemplateSelectors(FlagIncludeUserItems)
		  Var RemoveSelectorUUIDs As New Beacon.StringList
		  For Idx As Integer = CurrentSelectors.FirstIndex To CurrentSelectors.LastIndex
		    RemoveSelectorUUIDs.Append(CurrentSelectors(Idx).UUID)
		  Next Idx
		  Var PossibleFiles() As String = Array("/Selectors.json", "/Modifiers.json")
		  For Each FileName As String In PossibleFiles
		    Try
		      Var Contents As MemoryBlock = UserCloud.Read(FileName)
		      If Contents Is Nil Then
		        Continue For FileName
		      End If
		      
		      Var StringValue As String = Contents
		      Var Parsed() As Variant = Beacon.ParseJSON(StringValue.DefineEncoding(Encodings.UTF8))
		      For Each Dict As Dictionary In Parsed
		        Var TemplateSelector As Beacon.TemplateSelector = Beacon.TemplateSelector.FromSaveData(Dict)
		        If (TemplateSelector Is Nil) = False Then
		          Self.SaveTemplateSelector(TemplateSelector, False)
		          RemoveSelectorUUIDs.Remove(TemplateSelector.UUID)
		        End If
		      Next Dict
		      
		      Exit For FileName
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Importing cloud template selectors")
		    End Try
		  Next FileName
		  For Each SelectorUUID As String In RemoveSelectorUUIDs
		    Self.DeleteTemplateSelector(SelectorUUID)
		  Next SelectorUUID
		  
		  Self.CommitTransaction()
		End Sub
	#tag EndEvent

	#tag Event
		Sub ImportTruncate()
		  Var TableNames() As String = Array("official_templates", "official_template_selectors", "custom_templates", "custom_template_selectors")
		  For Each TableName As String In TableNames
		    Self.SQLExecute("DELETE FROM " + Self.EscapeIdentifier(TableName) + ";")
		  Next TableName
		End Sub
	#tag EndEvent

	#tag Event
		Sub IndexesBuilt()
		  Self.SQLExecute("DROP VIEW IF EXISTS templates;")
		  Self.SQLExecute("CREATE VIEW templates AS SELECT object_id, user_id, game_id, label, contents FROM custom_templates UNION SELECT object_id, '00000000-0000-0000-0000-000000000000' AS user_id, game_id, label, contents FROM official_templates WHERE object_id NOT IN (SELECT object_id FROM custom_templates);")
		  
		  Self.SQLExecute("DROP VIEW IF EXISTS template_selectors;")
		  Self.SQLExecute("CREATE VIEW template_selectors AS SELECT object_id, user_id, game_id, label, language, code FROM custom_template_selectors UNION SELECT object_id, '00000000-0000-0000-0000-000000000000' AS user_id, game_id, label, language, code FROM official_template_selectors WHERE object_id NOT IN (SELECT object_id FROM custom_template_selectors);")
		End Sub
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
		  Self.mTemplateCache = New Dictionary
		  Self.mSelectorCache = New Dictionary
		  
		  If mLock Is Nil Then
		    mLock = New CriticalSection
		  End If
		  
		  Super.Constructor(AllowWriting)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTemplate(Template As Beacon.Template)
		  If Template Is Nil Then
		    Return
		  End If
		  
		  Self.DeleteTemplate(Template.UUID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTemplate(TemplateUUID As String)
		  Var UserID As String = App.IdentityManager.CurrentUserID
		  If Self.mTemplateCache.HasKey(UserID + ":" + TemplateUUID) Then
		    Self.mTemplateCache.Remove(UserID + ":" + TemplateUUID)
		  End If
		  
		  Self.BeginTransaction()
		  Self.SQLExecute("DELETE FROM custom_templates WHERE object_id = ?1 AND user_id = ?2;", TemplateUUID, UserID)
		  Self.CommitTransaction()
		  
		  Self.ExportCloudFiles()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTemplateSelector(ParamArray TemplateSelectors() As Beacon.TemplateSelector)
		  Self.DeleteTemplateSelector(TemplateSelectors)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTemplateSelector(TemplateSelectors() As Beacon.TemplateSelector)
		  Var SelectorUUIDs() As String
		  For Idx As Integer = TemplateSelectors.FirstIndex To TemplateSelectors.LastIndex
		    SelectorUUIDs.Add(TemplateSelectors(Idx).UUID)
		  Next Idx
		  Self.DeleteTemplateSelector(SelectorUUIDs)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTemplateSelector(ParamArray SelectorUUIDs() As String)
		  Self.DeleteTemplateSelector(SelectorUUIDs)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteTemplateSelector(SelectorUUIDs() As String)
		  Var UserID As String = App.IdentityManager.CurrentUserID
		  
		  Self.BeginTransaction()
		  For Idx As Integer = SelectorUUIDs.FirstIndex To SelectorUUIDs.LastIndex
		    If Self.mSelectorCache.HasKey(UserID + ":" + SelectorUUIDs(Idx)) Then
		      Self.mSelectorCache.Remove(UserID + ":" + SelectorUUIDs(Idx))
		    End If
		    Self.SQLExecute("DELETE FROM custom_template_selectors WHERE object_id = ?1 AND user_id = ?2;", SelectorUUIDs(Idx), UserID)
		  Next Idx
		  Self.CommitTransaction()
		  
		  Self.ExportCloudFiles()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNews() As NewsItem()
		  Var OSMajor, OSMinor, OSBug As Integer
		  UpdatesKit.OSVersion(OSMajor, OSMinor, OSBug)
		  
		  Var BuildNumber As Integer = App.BuildNumber
		  Var Rows As RowSet = Self.SQLSelect("SELECT uuid, title, COALESCE(detail, '') AS detail, COALESCE(url, '') AS url, min_os_version FROM news WHERE (min_version IS NULL OR min_version <= ?1) AND (max_version IS NULL OR max_version >= ?1) ORDER BY moment DESC;", BuildNumber)
		  Var Items() As NewsItem
		  While Rows.AfterLastRow = False
		    If Rows.Column("min_os_version").Value.IsNull = False Then
		      Var MinOSVersionParts() As String = Rows.Column("min_os_version").StringValue.Split(".")
		      Var MinOSMajor As Integer = MinOSVersionParts(0).ToInteger
		      Var MinOSMinor As Integer = MinOSVersionParts(1).ToInteger
		      Var MinOSBug As Integer = MinOSVersionParts(2).ToInteger
		      Var Supported As Boolean = OSMajor > MinOSMajor Or (OSMajor = MinOSMajor And OSMinor > MinOSMinor) Or (OSMajor = MinOSMajor And OSMinor = MinOSMinor AND OSBug >= MinOSBug)
		      If Not Supported Then
		        Rows.MoveToNextRow
		        Continue
		      End If
		    End If
		    
		    Var Item As New NewsItem
		    Item.UUID = Rows.Column("uuid").StringValue
		    Item.Title = Rows.Column("title").StringValue
		    Item.Detail = Rows.Column("detail").StringValue
		    Item.URL = Rows.Column("url").StringValue
		    Items.Add(Item)
		    Rows.MoveToNextRow
		  Wend
		  Return Items
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplateByUUID(TemplateUUID As String) As Beacon.Template
		  Var UserID As String = App.IdentityManager.CurrentUserID
		  Var NullUUID As String = v4UUID.CreateNull
		  
		  If Self.mTemplateCache.HasKey(UserID + ":" + TemplateUUID) Then
		    Return Self.mTemplateCache.Value(UserID + ":" + TemplateUUID)
		  ElseIf Self.mTemplateCache.HasKey(NullUUID + ":" + TemplateUUID) Then
		    Return Self.mTemplateCache.Value(NullUUID + ":" + TemplateUUID)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT contents, user_id FROM templates WHERE object_id = :object_id AND (user_id = :user_id OR user_id = '" + NullUUID + "');")
		  If Rows.RowCount = 1 Then
		    Var Template As Beacon.Template = Beacon.Template.FromSaveData(Rows.Column("contents").StringValue)
		    If (Template Is Nil) = False Then
		      Self.mTemplateCache.Value(Rows.Column("user_id").StringValue + ":" + TemplateUUID) = Template
		      Return Template
		    End If
		  End If
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplates(Flags As Integer, Filter As String = "", GameID As String = "") As Beacon.Template()
		  Var Templates() As Beacon.Template
		  Var Rows As RowSet
		  Var Clauses() As String
		  Var Values() As Variant
		  
		  Var UserIDs() As String
		  If (Flags And Self.FlagIncludeOfficialItems) = Self.FlagIncludeOfficialItems Then
		    UserIDs.Add("'" + v4UUID.CreateNull + "'")
		  End If
		  If (Flags And Self.FlagIncludeUserItems) = Self.FlagIncludeUserItems Then
		    UserIDs.Add(":user_id")
		    Values.Add(App.IdentityManager.CurrentUserID)
		  End If
		  If UserIDs.Count = 0 Then
		    Return Templates()
		  End If
		  Clauses.Add("user_id IN (" + String.FromArray(UserIDs, ", ") + ")")
		  
		  If GameID.IsEmpty = False Then
		    Clauses.Add("game_id = :game_id")
		    Values.Add(GameID)
		  End If
		  
		  If Filter.IsEmpty = False Then
		    Clauses.Add("label LIKE :filter ESCAPE '\'")
		    Values.Add(Self.EscapeLikeValue(Filter))
		  End If
		  
		  Rows = Self.SQLSelect("SELECT object_id, user_id, contents FROM templates WHERE " + String.FromArray(Clauses, " AND ") + ";", Values)
		  While Rows.AfterLastRow = False
		    Var TemplateUUID As String = Rows.Column("object_id").StringValue
		    Var CacheKey As String = Rows.Column("user_id").StringValue + ":" + TemplateUUID
		    
		    If Self.mTemplateCache.HasKey(CacheKey) Then
		      Templates.Add(Self.mTemplateCache.Value(CacheKey))
		    Else
		      Var Template As Beacon.Template = Beacon.Template.FromSaveData(Rows.Column("contents").StringValue)
		      If (Template Is Nil) = False Then
		        Templates.Add(Template)
		        Self.mTemplateCache.Value(CacheKey) = Template
		      End If
		    End If
		    
		    Rows.MoveToNextRow
		  Wend
		  
		  Return Templates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplates(Filter As String = "", GameID As String = "") As Beacon.Template()
		  Return Self.GetTemplates(Self.FlagIncludeOfficialItems Or Self.FlagIncludeUserItems, Filter, GameID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplateSelectorByUUID(SelectorUUID As String) As Beacon.TemplateSelector
		  Var UserID As String = App.IdentityManager.CurrentUserID
		  Var NullUUID As String = v4UUID.CreateNull
		  
		  If Self.mSelectorCache.HasKey(UserID + ":" + SelectorUUID) Then
		    Return Self.mSelectorCache.Value(UserID + ":" + SelectorUUID)
		  ElseIf Self.mSelectorCache.HasKey(NullUUID + ":" + SelectorUUID) Then
		    Return Self.mSelectorCache.Value(NullUUID + ":" + SelectorUUID)
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT object_id, user_id, game_id, label, language, code FROM template_selectors WHERE object_id = :object_id AND (user_id = :user_id OR user_id = '" + NullUUID + "');")
		  If Rows.RowCount = 0 Then
		    Return Nil
		  End If
		  
		  Var CacheKey As String = Rows.Column("user_id").StringValue + ":" + SelectorUUID
		  Var GameID As String = Rows.Column("game_id").StringValue
		  Var Label As String = Rows.Column("label").StringValue
		  Var Language As Beacon.TemplateSelector.Languages = Beacon.TemplateSelector.StringToLanguage(Rows.Column("language").StringValue)
		  Var Code As String = Rows.Column("code").StringValue
		  Var TemplateSelector As New Beacon.TemplateSelector(SelectorUUID, Label, GameID, Language, Code)
		  
		  Self.mSelectorCache.Value(CacheKey) = TemplateSelector
		  Return TemplateSelector
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplateSelectors(Flags As Integer, Filter As String = "", GameID As String = "") As Beacon.TemplateSelector()
		  Var Selectors() As Beacon.TemplateSelector
		  Var Rows As RowSet
		  Var Clauses() As String
		  Var Values() As Variant
		  
		  Var UserIDs() As String
		  If (Flags And Self.FlagIncludeOfficialItems) = Self.FlagIncludeOfficialItems Then
		    UserIDs.Add("'" + v4UUID.CreateNull + "'")
		  End If
		  If (Flags And Self.FlagIncludeUserItems) = Self.FlagIncludeUserItems Then
		    UserIDs.Add(":user_id")
		    Values.Add(App.IdentityManager.CurrentUserID)
		  End If
		  If UserIDs.Count = 0 Then
		    Return Selectors()
		  End If
		  Clauses.Add("user_id IN (" + String.FromArray(UserIDs, ", ") + ")")
		  
		  If GameID.IsEmpty = False Then
		    Clauses.Add("game_id = :game_id")
		    Values.Add(GameID)
		  End If
		  
		  If Filter.IsEmpty = False Then
		    Clauses.Add("label LIKE :filter ESCAPE '\'")
		    Values.Add(Self.EscapeLikeValue(Filter))
		  End If
		  
		  Rows = Self.SQLSelect("SELECT object_id, user_id, game_id, label, language, code FROM template_selectors WHERE " + String.FromArray(Clauses, " AND ") + ";", Values)
		  While Rows.AfterLastRow = False
		    Var SelectorUUID As String = Rows.Column("object_id").StringValue
		    Var CacheKey As String = Rows.Column("user_id").StringValue + ":" + SelectorUUID
		    
		    If Self.mSelectorCache.HasKey(CacheKey) Then
		      Selectors.Add(Self.mSelectorCache.Value(CacheKey))
		    Else
		      Var TemplateSelector As New Beacon.TemplateSelector(SelectorUUID, Rows.Column("label").StringValue, Rows.Column("game_id").StringValue, Beacon.TemplateSelector.StringToLanguage(Rows.Column("language").StringValue), Rows.Column("code").StringValue)
		      Selectors.Add(TemplateSelector)
		      Self.mSelectorCache.Value(CacheKey) = TemplateSelector
		    End If
		    
		    Rows.MoveToNextRow
		  Wend
		  
		  Return Selectors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTemplateSelectors(Filter As String = "", GameID As String = "") As Beacon.TemplateSelector()
		  Return Self.GetTemplateSelectors(Self.FlagIncludeOfficialItems Or Self.FlagIncludeUserItems, Filter, GameID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  Return "Common"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTemplateCustom(Template As Beacon.Template) As Boolean
		  If Template Is Nil Then
		    Return False
		  End If
		  
		  Return Self.IsTemplateCustom(Template.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTemplateCustom(TemplateUUID As String) As Boolean
		  Var UserID As String = App.IdentityManager.CurrentUserID
		  
		  If Self.mTemplateCache.HasKey(UserID + ":" + TemplateUUID) Then
		    Return True
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT object_id FROM custom_templates WHERE object_id = ?1 AND user_id = ?2;", TemplateUUID, UserID)
		  Return Rows.RowCount = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTemplateOfficial(Template As Beacon.Template) As Boolean
		  If Template Is Nil Then
		    Return False
		  End If
		  
		  Return Self.IsTemplateOfficial(Template.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTemplateOfficial(TemplateUUID As String) As Boolean
		  If Self.mTemplateCache.HasKey(TemplateUUID) Then
		    Return True
		  End If
		  
		  Var Rows As RowSet = Self.SQLSelect("SELECT object_id FROM official_templates WHERE object_id = ?1;", TemplateUUID)
		  Return Rows.RowCount = 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Pool() As Beacon.CommonDataPool
		  If mPool Is Nil Then
		    mPool = New Beacon.CommonDataPool
		  End If
		  Return mPool
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveTemplate(Template As Beacon.Template)
		  Self.SaveTemplate(Template, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SaveTemplate(Template As Beacon.Template, Official As Boolean)
		  If Template Is Nil Then
		    Return
		  End If
		  
		  Var Contents As String = Beacon.GenerateJSON(Template.SaveData, False)
		  Self.BeginTransaction()
		  Var CacheKey As String
		  If Official Then
		    CacheKey = v4UUID.CreateNull + ":" + Template.UUID
		    Self.SQLExecute("INSERT OR REPLACE INTO official_templates (object_id, game_id, label, contents) VALUES (:object_id, :game_id, :label, :contents);", Template.UUID, Template.GameID, Template.Label, Contents)
		  Else
		    Var UserID As String = App.IdentityManager.CurrentUserID
		    CacheKey = UserID + ":" + Template.UUID
		    Self.SQLExecute("INSERT OR REPLACE INTO custom_templates (object_id, game_id, label, contents, user_id) VALUES (:object_id, :game_id, :label, :contents, :user_id);", Template.UUID, Template.GameID, Template.Label, Contents, UserID)
		  End If
		  Self.CommitTransaction()
		  
		  Self.mTemplateCache.Value(CacheKey) = Template
		  
		  If Official = False Then
		    Self.ExportCloudFiles() 
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveTemplateSelector(TemplateSelectors() As Beacon.TemplateSelector)
		  Self.SaveTemplateSelector(TemplateSelectors, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SaveTemplateSelector(TemplateSelectors() As Beacon.TemplateSelector, Official As Boolean)
		  Self.BeginTransaction()
		  For Each TemplateSelector As Beacon.TemplateSelector In TemplateSelectors
		    If TemplateSelector Is Nil Then
		      Continue
		    End If
		    
		    Var CacheKey As String
		    If Official Then
		      CacheKey = v4UUID.CreateNull + ":" + TemplateSelector.UUID
		      Self.SQLExecute("INSERT OR REPLACE INTO official_template_selectors (object_id, game_id, label, language, code) VALUES (:object_id, :game_id, :label, :language, :code);", TemplateSelector.UUID, TemplateSelector.GameID, TemplateSelector.Label, Beacon.TemplateSelector.LanguageToString(TemplateSelector.Language), TemplateSelector.Code)
		    Else
		      Var UserID As String = App.IdentityManager.CurrentUserID
		      CacheKey = UserID + ":" + TemplateSelector.UUID
		      Self.SQLExecute("INSERT OR REPLACE INTO custom_template_selectors (object_id, game_id, label, language, code, user_id) VALUES (:object_id, :game_id, :label, :language, :code, :user_id);", TemplateSelector.UUID, TemplateSelector.GameID, TemplateSelector.Label, Beacon.TemplateSelector.LanguageToString(TemplateSelector.Language), TemplateSelector.Code, UserID)
		    End If
		    Self.mSelectorCache.Value(CacheKey) = TemplateSelector
		  Next TemplateSelector
		  Self.CommitTransaction()
		  
		  If Official = False Then
		    Self.ExportCloudFiles()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveTemplateSelector(TemplateSelector As Beacon.TemplateSelector)
		  Self.SaveTemplateSelector(TemplateSelector, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SaveTemplateSelector(TemplateSelector As Beacon.TemplateSelector, Official As Boolean)
		  If TemplateSelector Is Nil Then
		    Return
		  End If
		  
		  Var Arr(0) As Beacon.TemplateSelector
		  Arr(0) = TemplateSelector
		  Self.SaveTemplateSelector(Arr, Official)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SyncURL(ForceRefresh As Boolean) As String
		  #Pragma Unused ForceRefresh
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateNews()
		  If (Self.mUpdateNewsThread Is Nil) = False And Self.mUpdateNewsThread.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Return
		  End If
		  
		  Var Th As New Thread
		  Th.Priority = Thread.LowestPriority
		  Th.DebugIdentifier = "News Updater"
		  AddHandler Th.Run, WeakAddressOf UpdateNewsThread_Run
		  Th.Start
		  Self.mUpdateNewsThread = Th
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateNewsThread_Run(Sender As Thread)
		  #Pragma Unused Sender
		  
		  Var Socket As New URLConnection
		  Socket.RequestHeader("User-Agent") = App.UserAgent
		  Var Content As String
		  Try
		    Content = Socket.SendSync("GET", Beacon.WebURL("/news?stage=" + App.StageCode.ToString))
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Updating local news cache")
		  End Try
		  
		  If Socket.HTTPStatusCode <> 200 Then
		    Self.mUpdateNewsThread = Nil
		    Return
		  End If
		  
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Content)
		  Catch Err As RuntimeException
		    Self.mUpdateNewsThread = Nil
		    Return
		  End Try
		  
		  Var Items() As Dictionary
		  Try
		    Items = Parsed.DictionaryArrayValue
		  Catch Err As RuntimeException
		    Self.mUpdateNewsThread = Nil
		    Return
		  End Try
		  
		  Var Instance As Beacon.CommonData = Beacon.CommonData.Pool.Get(True)
		  Instance.BeginTransaction()
		  
		  Var Changed As Boolean
		  Var Rows As RowSet = Instance.SQLSelect("SELECT uuid FROM news")
		  Var ItemsToRemove() As String
		  While Rows.AfterLastRow = False
		    ItemsToRemove.Add(Rows.Column("uuid").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  
		  For Each Item As Dictionary In Items
		    Try
		      Var UUID As String = Item.Value("uuid")
		      Var Title As String = Item.Value("title")
		      Var Detail As Variant = Item.Value("detail")
		      Var ItemURL As Variant = Item.Value("url")
		      Var MinVersion As Variant = Item.Value("min_version")
		      Var MaxVersion As Variant = Item.Value("max_version")
		      Var Moment As String = Item.Value("timestamp")
		      Var MinOSVersion As Variant
		      #if TargetMacOS
		        MinOSVersion = Item.Value("mac_min_os")
		      #elseif TargetWindows
		        MinOSVersion = Item.Value("win_min_os")
		      #endif
		      
		      Var Idx As Integer = ItemsToRemove.IndexOf(UUID)
		      If Idx > -1 Then
		        ItemsToRemove.RemoveAt(Idx)
		      Else
		        Instance.SQLExecute("INSERT INTO news (uuid, title, detail, url, min_version, max_version, moment, min_os_version) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8);", UUID, Title, Detail, ItemURL, MinVersion, MaxVersion, Moment, MinOSVersion)
		        Changed = True
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Changed = Changed Or ItemsToRemove.Count > 0
		  
		  If ItemsToRemove.Count > 0 Then
		    Instance.SQLExecute("DELETE FROM news WHERE uuid IN ('" + ItemsToRemove.Join("','") + "');")
		  End If
		  
		  Instance.CommitTransaction()
		  
		  If Changed Then
		    NotificationKit.Post(Self.Notification_NewsUpdated, Nil)
		  End If
		  
		  Self.mUpdateNewsThread = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteableInstance() As Beacon.CommonData
		  Return Self.Pool.Get(True)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mPool As Beacon.CommonDataPool
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSelectorCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemplateCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateNewsThread As Thread
	#tag EndProperty


	#tag Constant, Name = FlagIncludeOfficialItems, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagIncludeUserItems, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_NewsUpdated, Type = String, Dynamic = False, Default = \"News Updated", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
