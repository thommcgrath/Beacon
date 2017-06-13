#tag Class
Protected Class LocalData
Implements Beacon.DataSource
	#tag Method, Flags = &h21
		Private Sub BuildSchema()
		  Self.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Self.SQLExecute("CREATE TABLE loot_sources (classstring TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, kind TEXT NOT NULL, engram_mask INTEGER NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT NOT NULL, sort INTEGER NOT NULL UNIQUE);")
		  Self.SQLExecute("CREATE TABLE engrams (classstring TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, availability INTEGER NOT NULL, can_blueprint INTEGER NOT NULL, built_in INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE variables (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.SQLExecute("CREATE TABLE presets (preset_id TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, contents TEXT NOT NULL);")
		  
		  Self.mBase.UserVersion = Self.SchemaVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckForEngramUpdates()
		  Dim CheckURL As Text = Self.ClassesURL()
		  App.Log("Checking for engram updates from " + CheckURL)
		  
		  If Self.mUpdater = Nil Then
		    Self.mUpdater = New Xojo.Net.HTTPSocket
		    Self.mUpdater.ValidateCertificates = True
		    AddHandler Self.mUpdater.PageReceived, WeakAddressOf Self.mUpdater_PageReceived
		    AddHandler Self.mUpdater.Error, WeakAddressOf Self.mUpdater_Error
		  End If
		  Self.mUpdater.Send("GET", CheckURL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassesURL() As Text
		  Dim LastSync As String = Self.Variable("last_sync")
		  Dim CheckURL As Text = Beacon.WebURL("/download/classes.php?version=" + App.NonReleaseVersion.ToText)
		  If LastSync <> "" Then
		    CheckURL = CheckURL + "&changes_since=" + EncodeURLComponent(LastSync).ToText
		  End If
		  Return CheckURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramCache = New Dictionary
		  
		  Dim LegacyFile As FolderItem = App.ApplicationSupport.Child("Beacon.sqlite")
		  If LegacyFile.Exists Then
		    LegacyFile.Delete
		  End If
		  
		  Self.mBase = New SQLiteDatabase
		  Self.mBase.DatabaseFile = App.ApplicationSupport.Child("LocalData.sqlite")
		  
		  Dim FirstBuild As Boolean
		  If Self.mBase.DatabaseFile.Exists Then
		    If Not Self.mBase.Connect Then
		      Return
		    End If
		    FirstBuild = False
		  Else
		    If Not Self.mBase.CreateDatabaseFile Then
		      Return
		    End If
		    FirstBuild = True
		  End If
		  
		  Dim CurrentSchemaVersion As Integer = Self.mBase.UserVersion
		  If CurrentSchemaVersion <> Self.SchemaVersion Then
		    Self.mBase.Close
		    Self.mBase.DatabaseFile.MoveFileTo(App.ApplicationSupport.Child("LocalData " + Str(CurrentSchemaVersion, "-0") + ".sqlite"))
		    
		    Self.mBase = New SQLiteDatabase
		    Self.mBase.DatabaseFile = App.ApplicationSupport.Child("LocalData.sqlite")
		    Call Self.mBase.CreateDatabaseFile
		    Self.BuildSchema()
		  End If
		  
		  If CurrentSchemaVersion < Self.SchemaVersion Then
		    Self.MigrateData(App.ApplicationSupport.Child("LocalData " + Str(CurrentSchemaVersion, "-0") + ".sqlite"), CurrentSchemaVersion)
		  End If
		  
		  Self.CheckForEngramUpdates()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CustomPresetsFolder() As FolderItem
		  Dim SupportFolder As FolderItem = App.ApplicationSupport
		  Dim PresetsFolder As FolderItem = SupportFolder.Child("Presets")
		  If PresetsFolder.Exists Then
		    If Not PresetsFolder.Directory Then
		      PresetsFolder.Delete
		      PresetsFolder.CreateAsFolder
		    End If
		  Else
		    PresetsFolder.CreateAsFolder
		  End If
		  Return PresetsFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FileForCustomPreset(Preset As Beacon.Preset) As FolderItem
		  Return Self.CustomPresetsFolder.Child(Preset.PresetID + BeaconFileTypes.BeaconPreset.PrimaryExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngram(ClassString As Text) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mEngramCache.HasKey(ClassString) Then
		    Return Self.mEngramCache.Value(ClassString)
		  End If
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT classstring, label, availability, can_blueprint FROM engrams WHERE LOWER(classstring) = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = Lowercase(ClassString)
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return Nil
		  End If
		  
		  Dim Engrams() As Beacon.Engram = Self.RecordSetToEngram(RS)
		  For Each Engram As Beacon.Engram In Engrams
		    Self.mEngramCache.Value(Engram.ClassString) = Engram
		  Next
		  Return Engrams(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As Text) As Beacon.LootSource
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort FROM loot_sources WHERE LOWER(classstring) = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = Lowercase(ClassString)
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return Nil
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return Nil
		  End If
		  
		  Dim Sources() As Beacon.LootSource = Self.RecordSetToLootSource(RS)
		  Return Sources(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleError(SQLString As String, ErrorCode As Integer, ErrorMessage As String)
		  #Pragma Unused ErrorCode
		  
		  Dim Err As New UnsupportedOperationException
		  Err.Message = ErrorMessage + EndOfLine + SQLString
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IconForLootSource(Source As Beacon.LootSource, HighlightColor As Color) As Picture
		  Const Size = 24
		  
		  Dim HighlightMask As Picture
		  Dim ColorMask As Picture
		  
		  Select Case Source.Kind
		  Case Beacon.LootSource.Kinds.Bonus
		    HighlightMask = IconLootBonus
		    ColorMask = IconLootBonusColorMask
		  Case Beacon.LootSource.Kinds.Cave
		    HighlightMask = IconLootCave
		    ColorMask = IconLootCaveColorMask
		  Case Beacon.LootSource.Kinds.Sea
		    HighlightMask = IconLootSea
		    ColorMask = IconLootSeaColorMask
		  Case Beacon.LootSource.Kinds.BossSpider
		    HighlightMask = IconLootSpider
		    ColorMask = IconLootSpiderColorMask
		  Case Beacon.LootSource.Kinds.BossGorilla
		    HighlightMask = IconLootGorilla
		    ColorMask = IconLootGorillaColorMask
		  Case Beacon.LootSource.Kinds.BossDragon
		    HighlightMask = IconLootDragon
		    ColorMask = IconLootDragonColorMask
		  Case Beacon.LootSource.Kinds.BossManticore
		    HighlightMask = IconLootManticore
		    ColorMask = IconLootManticoreColorMask
		  Else
		    HighlightMask = IconLootStandard
		    ColorMask = IconLootStandardColorMask
		  End Select
		  
		  Dim HighlightOpacity As Integer = HighlightColor.Alpha
		  Dim FillOpacity As Integer = Source.UIColor.Alpha
		  
		  Dim Bitmaps() As Picture
		  For Factor As Integer = 1 To 3
		    Dim HighlightRep As Picture = HighlightMask.BestRepresentation(Size, Size, Factor)
		    Dim ColorRep As Picture = ColorMask.BestRepresentation(Size, Size, Factor)
		    
		    Dim Highlight As New Picture(Size * Factor, Size * Factor, 32)
		    Highlight.VerticalResolution = 72 * Factor
		    Highlight.HorizontalResolution = 72 * Factor
		    Highlight.Graphics.ForeColor = RGB(HighlightColor.Red, HighlightColor.Green, HighlightColor.Blue)
		    Highlight.Graphics.FillRect(0, 0, Highlight.Width, Highlight.Height)
		    Highlight.Mask.Graphics.DrawPicture(HighlightRep, 0, 0, Highlight.Width, Highlight.Height, 0, 0, HighlightRep.Width, HighlightRep.Height)
		    Highlight.Mask.Graphics.ForeColor = RGB(255, 255, 255, 255 - HighlightOpacity)
		    Highlight.Mask.Graphics.FillRect(0, 0, Highlight.Width, Highlight.Height)
		    
		    Dim Fill As New Picture(Size * Factor, Size * Factor, 32)
		    Fill.VerticalResolution = 72 * Factor
		    Fill.HorizontalResolution = 72 * Factor
		    Fill.Graphics.ForeColor = Source.UIColor
		    Fill.Graphics.FillRect(0, 0, Fill.Width, Fill.Height)
		    Fill.Mask.Graphics.DrawPicture(ColorRep, 0, 0, Fill.Width, Fill.Height, 0, 0, ColorRep.Width, ColorRep.Height)
		    Fill.Mask.Graphics.ForeColor = RGB(255, 255, 255, 255 - FillOpacity)
		    Fill.Mask.Graphics.FillRect(0, 0, Fill.Width, Fill.Height)
		    
		    Dim Combined As New Picture(Size * Factor, Size * Factor)
		    Combined.VerticalResolution = 72 * Factor
		    Combined.HorizontalResolution = 72 * Factor
		    Combined.Graphics.DrawPicture(Highlight, 0, 0, Combined.Width, Combined.Height, 0, 0, Highlight.Width, Highlight.Height)
		    Combined.Graphics.DrawPicture(Fill, 0, 0, Combined.Width, Combined.Height, 0, 0, Fill.Width, Fill.Height)
		    
		    Bitmaps.Append(Combined)
		  Next
		  Return New Picture(Size, Size, Bitmaps)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Import(Content As Text) As Boolean
		  Dim ChangeDict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Content)
		  
		  Dim RequiredKeys() As Text = Array("loot_sources", "engrams", "presets", "timestamp", "is_full", "beacon_version")
		  For Each RequiredKey As Text In RequiredKeys
		    If Not ChangeDict.HasKey(RequiredKey) Then
		      App.Log("Cannot import classes because key '" + RequiredKey + "' is missing.")
		      Return False
		    End If
		  Next
		  
		  Try
		    Self.SQLExecute("BEGIN TRANSACTION;")
		    
		    Dim ShouldTruncate As Boolean = ChangeDict.Value("is_full") = 1
		    If ShouldTruncate Then
		      Self.SQLExecute("DELETE FROM loot_sources;")
		      Self.SQLExecute("DELETE FROM engrams;")
		      Self.SQLExecute("DELETE FROM presets;")
		    End If
		    
		    Dim SourcesDict As Xojo.Core.Dictionary = ChangeDict.Value("loot_sources")
		    Dim EngramsDict As Xojo.Core.Dictionary = ChangeDict.Value("engrams")
		    Dim PresetsDict As Xojo.Core.Dictionary = ChangeDict.Value("presets")
		    Dim LastSync As Text = ChangeDict.Value("timestamp")
		    
		    Dim SourceAdditions() As Auto = SourcesDict.Value("additions")
		    Dim SourceRemovals() As Auto = SourcesDict.Value("removals")
		    If UBound(SourceAdditions) > -1 Or UBound(SourceRemovals) > -1 Then
		      If UBound(SourceRemovals) > -1 Then
		        Dim SourceDeleteStatement As SQLitePreparedStatement = Self.Prepare("DELETE FROM loot_sources WHERE LOWER(classstring) = ?;")
		        SourceDeleteStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		        For Each ClassString As Text In SourceRemovals
		          Self.SQLExecute(SourceDeleteStatement, ClassString.Lowercase)
		        Next
		      End If
		      
		      If UBound(SourceAdditions) > -1 Then
		        Dim SourceInsertStatement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO loot_sources (classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort) VALUES (?, ?, ?, ?, ?, ?, ?, ?);")
		        SourceInsertStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		        SourceInsertStatement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		        SourceInsertStatement.BindType(2, SQLitePreparedStatement.SQLITE_TEXT)
		        SourceInsertStatement.BindType(3, SQLitePreparedStatement.SQLITE_INTEGER)
		        SourceInsertStatement.BindType(4, SQLitePreparedStatement.SQLITE_DOUBLE)
		        SourceInsertStatement.BindType(5, SQLitePreparedStatement.SQLITE_DOUBLE)
		        SourceInsertStatement.BindType(6, SQLitePreparedStatement.SQLITE_TEXT)
		        SourceInsertStatement.BindType(7, SQLitePreparedStatement.SQLITE_INTEGER)
		        For Each Dict As Xojo.Core.Dictionary In SourceAdditions
		          If Dict.HasKey("version") And Dict.Value("version") > App.NonReleaseVersion Then
		            Continue
		          End If
		          
		          Dim ClassString As Text = Dict.Value("class")
		          Dim Label As Text = Dict.Value("label")
		          Dim Kind As Text = Dict.Value("kind")
		          Dim Mask As Integer = Dict.Value("mask")
		          Dim MultMin As Double = Dict.Value("mult_min")
		          Dim MultMax As Double = Dict.Value("mult_max")
		          Dim UIColor As Text = Dict.Value("uicolor")
		          Dim SortValue As Integer = Dict.Value("sort")
		          Self.SQLExecute(SourceInsertStatement, ClassString, Label, Kind, Mask, MultMin, MultMax, UIColor, SortValue)
		        Next
		      End If
		    End If
		    
		    Dim EngramAdditions() As Auto = EngramsDict.Value("additions")
		    Dim EngramRemovals() As Auto = EngramsDict.Value("removals")
		    If UBound(EngramAdditions) > -1 Or UBound(EngramRemovals) > -1 Then
		      If UBound(EngramRemovals) > -1 Then
		        Dim EngramDeleteStatement As SQLitePreparedStatement = Self.Prepare("DELETE FROM engrams WHERE LOWER(classstring) = ?;")
		        EngramDeleteStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		        For Each ClassString As Text In EngramRemovals
		          Self.SQLExecute(EngramDeleteStatement, ClassString.Lowercase)
		        Next
		      End If
		      
		      If UBound(EngramAdditions) > -1 Then
		        Dim EngramInsertStatement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO engrams (classstring, label, availability, can_blueprint, built_in) VALUES (?, ?, ?, ?, ?);")
		        EngramInsertStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		        EngramInsertStatement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		        EngramInsertStatement.BindType(2, SQLitePreparedStatement.SQLITE_INTEGER)
		        EngramInsertStatement.BindType(3, SQLitePreparedStatement.SQLITE_INTEGER)
		        For Each Dict As Xojo.Core.Dictionary In EngramAdditions
		          If Dict.HasKey("version") And Dict.Value("version") > App.NonReleaseVersion Then
		            Continue
		          End If
		          
		          Dim ClassString As Text = Dict.Value("class")
		          Dim Label As Text = Dict.Value("label")
		          Dim Availability As Integer = Dict.Value("availability")
		          Dim CanBlueprint As Boolean = (Dict.Value("blueprint") = 1)
		          Self.SQLExecute(EngramInsertStatement, ClassString, Label, Availability, CanBlueprint)
		        Next
		      End If
		    End If
		    
		    Dim PresetAdditions() As Auto = PresetsDict.Value("additions")
		    Dim PresetRemovals() As Auto = PresetsDict.Value("removals")
		    Dim ReloadPresets As Boolean = False
		    If UBound(PresetAdditions) > -1 Or UBound(PresetRemovals) > -1 Then
		      If UBound(PresetRemovals) > -1 Then
		        Dim PresetDeleteStatement As SQLitePreparedStatement = Self.Prepare("DELETE FROM presets WHERE LOWER(preset_id) = ?;")
		        PresetDeleteStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		        For Each PresetID As Text In PresetRemovals
		          Self.SQLExecute(PresetDeleteStatement, PresetID.Lowercase)
		        Next
		      End If
		      
		      If UBound(PresetAdditions) > -1 Then
		        Dim PresetInsertStatement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO presets (preset_id, label, contents) VALUES (?, ?, ?);")
		        PresetInsertStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		        PresetInsertStatement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		        PresetInsertStatement.BindType(2, SQLitePreparedStatement.SQLITE_TEXT)
		        For Each Dict As Xojo.Core.Dictionary In PresetAdditions
		          Dim PresetID As Text = Dict.Value("id")
		          Dim Label As Text = Dict.Value("label")
		          Dim Contents As Text = Dict.Value("contents")
		          Self.SQLExecute(PresetInsertStatement, PresetID, Label, Contents)
		        Next
		      End If
		      
		      ReloadPresets = True
		    End If
		    
		    Self.SQLExecute("COMMIT TRANSACTION;")
		    If ReloadPresets Then
		      Self.LoadPresets()
		    End If
		    
		    Self.Variable("last_sync") = LastSync
		    App.Log("Imported classes. Engrams date is " + LastSync)
		    
		    Return True
		  Catch Err As RuntimeException
		    Self.SQLExecute("ROLLBACK TRANSACTION;")
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ImportLocalClasses()
		  Dim File As FolderItem = App.ResourcesFolder.Child("Classes.json")
		  If File.Exists Then
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Call Self.Import(Content.ToText)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Return File.Exists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSync() As Xojo.Core.Date
		  Dim LastSync As String = Self.Variable("last_sync")
		  If LastSync = "" Then
		    Return Nil
		  End If
		  
		  Dim Now As New Date
		  Dim TempDate As Xojo.Core.Date = Xojo.Core.Date.FromText(LastSync.ToText)
		  Return New Xojo.Core.Date(TempDate.SecondsFrom1970 + (Now.GMTOffset * 3600), New Xojo.Core.TimeZone("UTC"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Dim Presets As New Dictionary
		  
		  Dim BuiltInIDs() As Text
		  Dim Results As RecordSet = Self.SQLSelect("SELECT contents FROM presets")
		  While Not Results.EOF
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Results.Field("contents").StringValue.ToText)
		    Dim Preset As Beacon.Preset = Beacon.Preset.FromDictionary(Dict)
		    If Preset <> Nil Then
		      Preset.Type = Beacon.Preset.Types.BuiltIn
		      Presets.Value(Preset.PresetID) = Preset
		      BuiltInIDs.Append(Preset.PresetID)
		    End If
		    Results.MoveNext
		  Wend
		  
		  Dim Folder As FolderItem = Self.CustomPresetsFolder
		  If Folder <> Nil Then
		    Dim Extension As String = BeaconFileTypes.BeaconPreset.PrimaryExtension
		    Dim ExtensionLength As Integer = Len(Extension)
		    
		    For I As Integer = 1 To Folder.Count
		      Dim File As FolderItem = Folder.Item(I)
		      If Right(File.Name, ExtensionLength) <> Extension Then
		        Continue For I
		      End If
		      
		      Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		      If Preset <> Nil Then
		        Dim CorrectFile As FolderItem = Self.FileForCustomPreset(Preset)
		        If File.NativePath <> CorrectFile.NativePath Then
		          If Not CorrectFile.Exists Then
		            Self.SavePreset(Preset, False)
		          End If
		          File.Delete
		        End If
		        
		        Preset.Type = if(BuiltInIDs.IndexOf(Preset.PresetID) > -1, Beacon.Preset.Types.CustomizedBuiltIn, Beacon.Preset.Types.Custom)
		        Presets.Value(Preset.PresetID) = Preset
		      End If
		    Next
		  End If
		  
		  Redim Self.mPresets(Presets.Count - 1)
		  Dim Keys() As Variant = Presets.Keys
		  For I As Integer = 0 To UBound(Keys)
		    Self.mPresets(I) = Presets.Value(Keys(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MigrateData(Source As FolderItem, FromSchemaVersion As Integer)
		  If Not Self.mBase.AttachDatabase(Source, "legacy") Then
		    App.Log("Unable to attach database " + Source.NativePath)
		    Return
		  End If
		  
		  Dim Commands() As String
		  If FromSchemaVersion = 0 Then
		    Commands.Append("INSERT INTO engrams (classstring, label, availability, can_blueprint, built_in) SELECT legacy.engrams.classstring, legacy.engrams.label, legacy.engrams.availability, legacy.engrams.can_blueprint, '1' FROM legacy.engrams;")
		    Commands.Append("INSERT INTO loot_sources (classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort) SELECT legacy.loot_sources.classstring, legacy.loot_sources.label, legacy.loot_sources.kind, legacy.loot_sources.engram_mask, legacy.loot_sources.multiplier_min, legacy.loot_sources.multiplier_max, legacy.loot_sources.uicolor, legacy.loot_sources.sort FROM legacy.loot_sources;")
		    Commands.Append("INSERT INTO variables (key, value) SELECT legacy.vars.key, legacy.vars.value FROM legacy.vars WHERE legacy.vars.key = 'last_sync';")
		    Commands.Append("INSERT INTO presets (preset_id, label, contents) SELECT legacy.presets.preset_id, legacy.presets.label, legacy.presets.contents FROM legacy.presets;")
		  End If
		  
		  If UBound(Commands) > -1 Then
		    Self.mBase.SQLExecute("BEGIN TRANSACTION;")
		    For Each Command As String In Commands
		      Self.mBase.SQLExecute(Command)
		      If Self.mBase.Error Then
		        App.Log("Unable to migrate data: " + Self.mBase.ErrorMessage)
		        Self.mBase.SQLExecute("ROLLBACK TRANSACTION;")
		        Self.mBase.DetachDatabase("legacy")
		        Return
		      End If
		    Next
		    Self.mBase.SQLExecute("COMMIT TRANSACTION;")
		  End If
		  
		  Self.mBase.DetachDatabase("legacy")
		  Source.Delete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_Error(Sender As Xojo.Net.HTTPSocket, Error As RuntimeException)
		  #Pragma Unused Sender
		  
		  App.Log("Engram check error: " + Error.Reason)
		  Self.ImportLocalClasses()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    App.Log("Engram update returned HTTP " + Str(HTTPStatus, "-0"))
		    Self.ImportLocalClasses()
		    Return
		  End If
		  
		  Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Dim ExpectedHash As Text = Sender.ResponseHeader("Content-MD5")
		  Dim ComputedHash As Text = EncodeHex(Crypto.MD5(TextContent)).ToText
		  
		  If ComputedHash <> ExpectedHash Then
		    App.Log("Engram update hash mismatch. Expected " + ExpectedHash + ", computed " + ComputedHash + ".")
		    Return
		  End If
		  
		  Call Self.Import(TextContent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Prepare(SQLString As String) As SQLitePreparedStatement
		  Dim Statement As SQLitePreparedStatement = Self.mBase.Prepare(SQLString)
		  If Self.mBase.Error Then
		    Self.HandleError(SQLString, Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		    Return Nil
		  End If
		  Return Statement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  Dim Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.Append(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecordSetToEngram(Results As RecordSet) As Beacon.Engram()
		  Dim Engrams() As Beacon.Engram
		  While Not Results.EOF
		    Dim Engram As New Beacon.MutableEngram(Results.Field("classstring").StringValue.ToText)
		    Engram.Label = Results.Field("label").StringValue.ToText
		    Engram.Availability = Results.Field("availability").IntegerValue
		    Engram.CanBeBlueprint = Results.Field("can_blueprint").BooleanValue
		    Engrams.Append(Engram)
		    Results.MoveNext
		  Wend
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecordSetToLootSource(Results As RecordSet) As Beacon.LootSource()
		  Dim Sources() As Beacon.LootSource
		  While Not Results.EOF
		    Dim HexColor As String = Results.Field("uicolor").StringValue
		    Dim RedHex, GreenHex, BlueHex, AlphaHex As String = "00"
		    If Len(HexColor) = 3 Then
		      RedHex = Mid(HexColor, 1, 1) + Mid(HexColor, 1, 1)
		      GreenHex = Mid(HexColor, 2, 1) + Mid(HexColor, 2, 1)
		      BlueHex = Mid(HexColor, 3, 1) + Mid(HexColor, 3, 1)
		    ElseIf Len(HexColor) = 4 Then
		      RedHex = Mid(HexColor, 1, 1) + Mid(HexColor, 1, 1)
		      GreenHex = Mid(HexColor, 2, 1) + Mid(HexColor, 2, 1)
		      BlueHex = Mid(HexColor, 3, 1) + Mid(HexColor, 3, 1)
		      AlphaHex = Mid(HexColor, 4, 1) + Mid(HexColor, 4, 1)
		    ElseIf Len(HexColor) = 6 Then
		      RedHex = Mid(HexColor, 1, 2)
		      GreenHex = Mid(HexColor, 3, 2)
		      BlueHex = Mid(HexColor, 5, 2)
		    ElseIf Len(HexColor) = 8 Then
		      RedHex = Mid(HexColor, 1, 2)
		      GreenHex = Mid(HexColor, 3, 2)
		      BlueHex = Mid(HexColor, 5, 2)
		      AlphaHex = Mid(HexColor, 7, 2)
		    End If
		    
		    Dim Source As New Beacon.MutableLootSource(Results.Field("classstring").StringValue.ToText, True)
		    Source.Label = Results.Field("label").StringValue.ToText
		    Source.Kind = Beacon.LootSource.TextToKind(Results.Field("kind").StringValue.ToText)
		    Source.Package = Beacon.LootSource.IntegerToPackage(Results.Field("engram_mask").IntegerValue)
		    Source.Multipliers = New Beacon.Range(Results.Field("multiplier_min").DoubleValue, Results.Field("multiplier_max").DoubleValue)
		    Source.UIColor = RGB(Integer.FromHex(RedHex.ToText), Integer.FromHex(GreenHex.ToText), Integer.FromHex(BlueHex.ToText), Integer.FromHex(AlphaHex.ToText))
		    Source.SortValue = Results.Field("sort").IntegerValue
		    Sources.Append(New Beacon.LootSource(Source))
		    Results.MoveNext
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePreset(Preset As Beacon.Preset)
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  If File.Exists Then
		    File.Delete
		    Self.LoadPresets
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  Self.SavePreset(Preset, True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SavePreset(Preset As Beacon.Preset, Reload As Boolean)
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Preset.ToFile(File)
		  If Reload Then
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As Text) As Beacon.Engram()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Results() As Beacon.Engram
		  
		  Dim RS As RecordSet
		  Try
		    If SearchText = "" Then
		      RS = Self.SQLSelect("SELECT classstring, label, availability, can_blueprint FROM engrams ORDER BY label;")
		    Else
		      Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT classstring, label, availability, can_blueprint FROM engrams WHERE LOWER(label) LIKE LOWER(?1) OR LOWER(classstring) LIKE LOWER(?1) ORDER BY label;")
		      Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      
		      Dim StringValue As String = SearchText
		      RS = Self.SQLSelect(Statement, "%" + StringValue + "%")
		    End If
		  Catch Err As UnsupportedOperationException
		    Return Results()
		  End Try
		  If RS = Nil Then
		    Return Results()
		  End If
		  
		  Results = Self.RecordSetToEngram(RS)
		  For Each Engram As Beacon.Engram In Results
		    Self.mEngramCache.Value(Engram.ClassString) = Engram
		  Next
		  Return Results()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As Text) As Beacon.LootSource()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Results() As Beacon.LootSource
		  
		  Dim RS As RecordSet
		  Try
		    If SearchText = "" Then
		      RS = Self.SQLSelect("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort FROM loot_sources ORDER BY label;")
		    Else
		      Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT classstring, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, sort FROM loot_sources WHERE LOWER(label) LIKE LOWER(?1) OR LOWER(classstring) LIKE LOWER(?1) ORDER BY label;")
		      Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      
		      Dim StringValue As String = SearchText
		      RS = Self.SQLSelect(Statement, "%" + StringValue + "%")
		    End If
		  Catch Err As UnsupportedOperationException
		    Return Results()
		  End Try
		  If RS = Nil Then
		    Return Results()
		  End If
		  
		  Results = Self.RecordSetToLootSource(RS)
		  
		  Return Results()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(Statement As SQLitePreparedStatement, ParamArray Values() As Variant)
		  For I As Integer = 0 To UBound(Values)
		    Statement.Bind(I, Values(I))
		  Next
		  Statement.SQLExecute()
		  If Self.mBase.Error Then
		    Self.HandleError("Statement", Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SQLExecute(SQLString As String)
		  Self.mBase.SQLExecute(SQLString)
		  If Self.mBase.Error Then
		    Self.HandleError(SQLString, Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(Statement As SQLitePreparedStatement, ParamArray Values() As Variant) As RecordSet
		  For I As Integer = 0 To UBound(Values)
		    Statement.Bind(I, Values(I))
		  Next
		  Dim RS As RecordSet = Statement.SQLSelect()
		  If Self.mBase.Error Then
		    Self.HandleError("Statement", Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		    Return Nil
		  End If
		  Return RS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SQLSelect(SQLString As String) As RecordSet
		  Dim RS As RecordSet = Self.mBase.SQLSelect(SQLString)
		  If Self.mBase.Error Then
		    Self.HandleError(SQLString, Self.mBase.ErrorCode, Self.mBase.ErrorMessage)
		    Return Nil
		  End If
		  Return RS
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variable(Key As String) As String
		  Try
		    Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT value FROM variables WHERE key = ?;")
		    Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		    
		    Dim Results As RecordSet = Self.SQLSelect(Statement, Lowercase(Key))
		    If Results.RecordCount = 1 Then
		      Return Results.Field("value").StringValue
		    End If
		  Catch Err As RuntimeException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Variable(Key As String, Assigns Value As String)
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO variables (key, value) VALUES (?, ?);")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  Statement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Self.SQLExecute("BEGIN TRANSACTION;")
		  Self.SQLExecute(Statement, Lowercase(Key), Value)
		  Self.SQLExecute("COMMIT TRANSACTION;")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBase As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdater As Xojo.Net.HTTPSocket
	#tag EndProperty


	#tag Constant, Name = SchemaVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
