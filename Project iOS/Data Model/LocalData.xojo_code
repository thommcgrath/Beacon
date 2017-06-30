#tag Class
Protected Class LocalData
Implements Beacon.DataSource
	#tag Method, Flags = &h21
		Private Sub BeginTransaction()
		  If UBound(Self.mTransactions) = -1 Then
		    Self.mTransactions.Insert(0, "")
		    Self.mBase.SQLExecute("BEGIN TRANSACTION;")
		  Else
		    Dim Savepoint As Text = "Savepoint_" + Beacon.EncodeHex(Xojo.Crypto.GenerateRandomBytes(4))
		    Self.mTransactions.Insert(0, Savepoint)
		    Self.mBase.SQLExecute("SAVEPOINT " + Savepoint + ";")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildSchema()
		  Self.mBase.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.mBase.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Self.mBase.SQLExecute("CREATE TABLE loot_sources (class_string TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, kind TEXT NOT NULL, engram_mask INTEGER NOT NULL, multiplier_min REAL NOT NULL, multiplier_max REAL NOT NULL, uicolor TEXT NOT NULL, icon BLOB NOT NULL, sort INTEGER NOT NULL UNIQUE, use_blueprints INTEGER NOT NULL);")
		  Self.mBase.SQLExecute("CREATE TABLE engrams (path TEXT NOT NULL PRIMARY KEY, class_string TEXT NOT NULL, label TEXT NOT NULL, availability INTEGER NOT NULL, can_blueprint INTEGER NOT NULL, built_in INTEGER NOT NULL);")
		  Self.mBase.SQLExecute("CREATE TABLE variables (key TEXT NOT NULL PRIMARY KEY, value TEXT NOT NULL);")
		  Self.mBase.SQLExecute("CREATE TABLE presets (preset_id TEXT NOT NULL PRIMARY KEY, label TEXT NOT NULL, contents TEXT NOT NULL);")
		  Self.mBase.SQLExecute("CREATE INDEX engrams_class_string_idx ON engrams(class_string);")
		  
		  Self.mBase.UserVersion = Self.SchemaVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Commit()
		  If UBound(Self.mTransactions) = -1 Then
		    Return
		  End If
		  
		  Dim Savepoint As Text = Self.mTransactions(0)
		  Self.mTransactions.Remove(0)
		  
		  If Savepoint = "" Then
		    Self.mBase.SQLExecute("COMMIT TRANSACTION;")
		  Else
		    Self.mBase.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mEngramCache = New Dictionary
		  
		  Self.mBase = New iOSSQLiteDatabase
		  Self.mBase.DatabaseFile = App.ApplicationSupport.Child("Library.sqlite")
		  
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
		    Dim SourceFile As Xojo.IO.FolderItem = Self.mBase.DatabaseFile
		    Self.mBase = Nil
		    Try
		      SourceFile.MoveTo(App.ApplicationSupport.Child("Library " + CurrentSchemaVersion.ToText + ".sqlite"))
		    Catch Err As RuntimeException
		      SourceFile.Delete
		    End Try
		    
		    Self.mBase = New iOSSQLiteDatabase
		    Self.mBase.DatabaseFile = App.ApplicationSupport.Child("Library.sqlite")
		    Call Self.mBase.CreateDatabaseFile
		    Self.BuildSchema()
		  End If
		  
		  If CurrentSchemaVersion < Self.SchemaVersion Then
		    Self.MigrateData(App.ApplicationSupport.Child("Library " + CurrentSchemaVersion.ToText + ".sqlite"), CurrentSchemaVersion)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CustomPresetsFolder() As FolderItem
		  Dim PresetsFolder As Xojo.IO.FolderItem = App.ApplicationSupport.Child("Presets")
		  If PresetsFolder.Exists Then
		    If Not PresetsFolder.IsFolder Then
		      PresetsFolder.Delete
		      PresetsFolder.CreateAsFolder
		    End If
		  Else
		    PresetsFolder.CreateAsFolder
		  End If
		  Return PresetsFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FileForCustomPreset(Preset As Beacon.Preset) As FolderItem
		  Return Self.CustomPresetsFolder.Child(Preset.PresetID + App.PresetExtension)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByClass(ClassString As Text) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    If ClassString.Length < 2 Or ClassString.Right(2) <> "_C" Then
		      ClassString = ClassString + "_C"
		    End If
		    
		    Dim Results As iOSSQLiteRecordSet = Self.mBase.SQLSelect("SELECT path, label, availability, can_blueprint FROM engrams WHERE LOWER(class_string) = LOWER(?1);", ClassString)
		    If Results.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Engrams() As Beacon.Engram = Self.RecordSetToEngram(Results)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		    Return Engrams(0)
		  Catch Err As iOSSQLiteException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByPath(Path As Text) As Beacon.Engram
		  // Part of the Beacon.DataSource interface.
		  
		  // Part of the Beacon.DataSource interface.
		  
		  If Self.mEngramCache.HasKey(Path) Then
		    Return Self.mEngramCache.Value(Path)
		  End If
		  
		  Try
		    Dim Results As iOSSQLiteRecordSet = Self.mBase.SQLSelect("SELECT path, label, availability, can_blueprint FROM engrams WHERE LOWER(path) = LOWER(?1);", Path)
		    If Results.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Engrams() As Beacon.Engram = Self.RecordSetToEngram(Results)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		    Return Engrams(0)
		  Catch Err As iOSSQLiteException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As Text) As Beacon.LootSource
		  // Part of the Beacon.DataSource interface.
		  
		  Try
		    Dim Results As iOSSQLiteRecordSet = Self.mBase.SQLSelect("SELECT class_string, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, hex(icon) AS icon_hex, sort, use_blueprints FROM loot_sources WHERE LOWER(class_string) = LOWER(?1);", ClassString)
		    If Results.RecordCount = 0 Then
		      Return Nil
		    End If
		    
		    Dim Sources() As Beacon.LootSource = Self.RecordSetToLootSource(Results)
		    Return Sources(0)
		  Catch Err As iOSSQLiteException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  // Part of the Beacon.DataSource interface.
		  
		  Dim File As Xojo.IO.FolderItem = Self.FileForCustomPreset(Preset)
		  Return File.Exists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSync() As Xojo.Core.Date
		  Dim LastSync As Text = Self.Variable("last_sync")
		  If LastSync = "" Then
		    Return Nil
		  End If
		  
		  Dim Now As Xojo.Core.Date = Xojo.Core.Date.Now
		  Dim TempDate As Xojo.Core.Date = Xojo.Core.Date.FromText(LastSync)
		  Return New Xojo.Core.Date(TempDate.SecondsFrom1970 + (Now.TimeZone.SecondsFromGMT * 3600), New Xojo.Core.TimeZone("UTC"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Presets As New Xojo.Core.Dictionary
		  
		  Dim BuiltInIDs() As Text
		  Dim Results As iOSSQLiteRecordSet = Self.mBase.SQLSelect("SELECT contents FROM presets")
		  While Not Results.EOF
		    Dim Dict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Results.Field("contents").TextValue)
		    Dim Preset As Beacon.Preset = Beacon.Preset.FromDictionary(Dict)
		    If Preset <> Nil Then
		      Preset.Type = Beacon.Preset.Types.BuiltIn
		      Presets.Value(Preset.PresetID) = Preset
		      BuiltInIDs.Append(Preset.PresetID)
		    End If
		    Results.MoveNext
		  Wend
		  
		  Dim Folder As Xojo.IO.FolderItem = Self.CustomPresetsFolder
		  If Folder <> Nil Then
		    Dim Extension As Text = App.PresetExtension
		    Dim ExtensionLength As Integer = Extension.Length
		    
		    For Each File As Xojo.IO.FolderItem In Folder.Children
		      If File.Name.Length < ExtensionLength Or File.Name.Right(ExtensionLength) <> Extension Then
		        Continue
		      End If
		      
		      Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(File)
		      If Preset <> Nil Then
		        Dim CorrectFile As Xojo.IO.FolderItem = Self.FileForCustomPreset(Preset)
		        If File.Path <> CorrectFile.Path Then
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
		  
		  Redim Self.mPresets(-1)
		  For Each Entry As Xojo.Core.DictionaryEntry In Presets
		    Self.mPresets.Append(Entry.Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MigrateData(Source As Xojo.IO.FolderItem, FromSchemaVersion As Integer)
		  If Not Self.mBase.AttachDatabase(Source, "legacy") Then
		    //App.Log("Unable to attach database " + Source.NativePath)
		    Return
		  End If
		  
		  Dim Commands() As Text
		  Select Case FromSchemaVersion
		  Case 1
		    Commands.Append("INSERT INTO loot_sources SELECT *, 1 AS use_blueprints FROM legacy.loot_sources;")
		    Commands.Append("INSERT INTO engrams SELECT * FROM legacy.engrams;")
		    Commands.Append("INSERT INTO variables SELECT * FROM legacy.variables;")
		    Commands.Append("INSERT INTO presets SELECT * FROM legacy.presets;")
		  End Select
		  
		  If UBound(Commands) > -1 Then
		    Self.BeginTransaction()
		    Try
		      For Each Command As Text In Commands
		        Self.mBase.SQLExecute(Command)
		      Next
		    Catch Err As UnsupportedOperationException
		      Self.Rollback()
		      Self.mBase.DetachDatabase("legacy")
		      //App.Log("Unable to migrate data: " + Err.Message)
		      Return
		    End Try
		    Self.Commit()
		  End If
		  
		  Self.mBase.DetachDatabase("legacy")
		  Source.Delete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Results() As Beacon.Preset
		  For Each Preset As Beacon.Preset In Self.mPresets
		    Results.Append(New Beacon.Preset(Preset))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecordSetToEngram(Results As iOSSQLiteRecordSet) As Beacon.Engram()
		  Dim Engrams() As Beacon.Engram
		  While Not Results.EOF
		    Dim Engram As New Beacon.MutableEngram(Results.Field("path").TextValue)
		    Engram.Label = Results.Field("label").TextValue
		    Engram.Availability = Results.Field("availability").IntegerValue
		    Engram.CanBeBlueprint = Results.Field("can_blueprint").BooleanValue
		    Engrams.Append(Engram)
		    Results.MoveNext
		  Wend
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function RecordSetToLootSource(Results As iOSSQLiteRecordSet) As Beacon.LootSource()
		  Dim Sources() As Beacon.LootSource
		  While Not Results.EOF
		    Dim HexColor As Text = Results.Field("uicolor").TextValue
		    Dim RedHex, GreenHex, BlueHex, AlphaHex As Text = "00"
		    If HexColor.Length = 3 Then
		      RedHex = HexColor.Mid(0, 1) + HexColor.Mid(0, 1)
		      GreenHex = HexColor.Mid(1, 1) + HexColor.Mid(1, 1)
		      BlueHex = HexColor.Mid(2, 1) + HexColor.Mid(2, 1)
		    ElseIf HexColor.Length = 4 Then
		      RedHex = HexColor.Mid(0, 1) + HexColor.Mid(0, 1)
		      GreenHex = HexColor.Mid(1, 1) + HexColor.Mid(1, 1)
		      BlueHex = HexColor.Mid(2, 1) + HexColor.Mid(2, 1)
		      AlphaHex = HexColor.Mid(3, 1) + HexColor.Mid(3, 1)
		    ElseIf HexColor.Length = 6 Then
		      RedHex = HexColor.Mid(0, 2)
		      GreenHex = HexColor.Mid(2, 2)
		      BlueHex = HexColor.Mid(4, 2)
		    ElseIf HexColor.Length = 8 Then
		      RedHex = HexColor.Mid(0, 2)
		      GreenHex = HexColor.Mid(2, 2)
		      BlueHex = HexColor.Mid(4, 2)
		      AlphaHex = HexColor.Mid(6, 2)
		    End If
		    
		    Dim Source As New Beacon.MutableLootSource(Results.Field("class_string").TextValue, True)
		    Source.Label = Results.Field("label").TextValue
		    Source.Kind = Beacon.LootSource.TextToKind(Results.Field("kind").TextValue)
		    Source.Availability = Results.Field("engram_mask").IntegerValue
		    Source.Multipliers = New Beacon.Range(Results.Field("multiplier_min").DoubleValue, Results.Field("multiplier_max").DoubleValue)
		    Source.UIColor = Color.RGBA(Integer.FromHex(RedHex), Integer.FromHex(GreenHex), Integer.FromHex(BlueHex), Integer.FromHex(AlphaHex))
		    Source.SortValue = Results.Field("sort").IntegerValue
		    Source.UseBlueprints = Results.Field("use_blueprints").BooleanValue
		    Sources.Append(New Beacon.LootSource(Source))
		    Results.MoveNext
		  Wend
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePreset(Preset As Beacon.Preset)
		  // Part of the Beacon.DataSource interface.
		  
		  Dim File As Xojo.IO.FolderItem = Self.FileForCustomPreset(Preset)
		  If File.Exists Then
		    File.Delete
		    Self.LoadPresets()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Rollback()
		  If UBound(Self.mTransactions) = -1 Then
		    Return
		  End If
		  
		  Dim Savepoint As Text = Self.mTransactions(0)
		  Self.mTransactions.Remove(0)
		  
		  If Savepoint = "" Then
		    Self.mBase.SQLExecute("ROLLBACK TRANSACTION;")
		  Else
		    Self.mBase.SQLExecute("ROLLBACK TRANSACTION TO SAVEPOINT " + Savepoint + ";")
		    Self.mBase.SQLExecute("RELEASE SAVEPOINT " + Savepoint + ";")
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
		  // Part of the Beacon.DataSource interface.
		  
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
		  
		  Dim Engrams() As Beacon.Engram
		  
		  Try
		    Dim Results As iOSSQLiteRecordSet
		    If SearchText = "" Then
		      Results = Self.mBase.SQLSelect("SELECT path, label, availability, can_blueprint FROM engrams ORDER BY label;")
		    Else
		      Results = Self.mBase.SQLSelect("SELECT path, label, availability, can_blueprint FROM engrams WHERE LOWER(label) LIKE LOWER(?1) OR LOWER(class_string) LIKE LOWER(?1) ORDER BY label;", "%" + SearchText + "%")
		    End If
		    
		    Engrams = Self.RecordSetToEngram(Results)
		    For Each Engram As Beacon.Engram In Engrams
		      Self.mEngramCache.Value(Engram.Path) = Engram
		    Next
		  Catch Err As iOSSQLiteException
		    
		  End Try
		  
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As Text) As Beacon.LootSource()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Sources() As Beacon.LootSource
		  
		  Try
		    Dim Results As iOSSQLiteRecordSet
		    If SearchText = "" Then
		      Results = Self.mBase.SQLSelect("SELECT class_string, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, hex(icon) AS icon_hex, sort, use_blueprints FROM loot_sources ORDER BY label;")
		    Else
		      Results = Self.mBase.SQLSelect("SELECT class_string, label, kind, engram_mask, multiplier_min, multiplier_max, uicolor, hex(icon) AS icon_hex, sort, use_blueprints FROM loot_sources WHERE LOWER(label) LIKE LOWER(?1) OR LOWER(class_string) LIKE LOWER(?1) ORDER BY label;", "%" + SearchText + "%")
		    End If
		    
		    Sources = Self.RecordSetToLootSource(Results)
		  Catch Err As iOSSQLiteException
		    
		  End Try
		  
		  Return Sources
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SharedInstance(Create As Boolean = True) As LocalData
		  If mInstance = Nil And Create = True Then
		    mInstance = New LocalData
		    Beacon.Data = mInstance
		    #if false
		      Dim Results As RecordSet = mInstance.SQLSelect("SELECT COUNT(class_string) AS source_count FROM loot_sources;")
		      If Results.Field("source_count").IntegerValue = 0 Then
		        mInstance.ImportLocalClasses()
		      End If
		      mInstance.CheckForEngramUpdates()
		    #endif
		  End If
		  Return mInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Start()
		  Call SharedInstance(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Variable(Key As Text) As Text
		  Try
		    Dim Results As iOSSQLiteRecordSet = Self.mBase.SQLSelect("SELECT value FROM variables WHERE LOWER(key) = LOWER(?1);", Key)
		    If Results.RecordCount = 1 Then
		      Return Results.Field("value").TextValue
		    End If 
		  Catch Err As iOSSQLiteException
		    Return ""
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Variable(Key As Text, Assigns Value As Text)
		  Try
		    Self.BeginTransaction()
		    Self.mBase.SQLExecute("INSERT OR REPLACE INTO variables (key, value) VALUES (?1, ?2);", Key, Value)
		    Self.Commit()
		  Catch Err As iOSSQLiteException
		    Self.Rollback()
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBase As iOSSQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEngramCache As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mInstance As LocalData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransactions() As Text
	#tag EndProperty


	#tag Constant, Name = SchemaVersion, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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
			Name="mBase"
			Group="Behavior"
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
