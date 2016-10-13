#tag Class
Protected Class LocalData
Implements Beacon.DataSource
	#tag Method, Flags = &h21
		Private Sub BuildSchema()
		  Self.SQLExecute("PRAGMA foreign_keys = ON;")
		  Self.SQLExecute("PRAGMA journal_mode = WAL;")
		  
		  Self.SQLExecute("CREATE TABLE ""loot_sources"" (""classstring"" TEXT NOT NULL PRIMARY KEY, ""label"" TEXT NOT NULL, ""kind"" TEXT NOT NULL, ""engram_mask"" INTEGER NOT NULL, ""multiplier_min"" REAL NOT NULL, ""multiplier_max"" REAL NOT NULL);")
		  Self.SQLExecute("CREATE TABLE ""engrams"" (""classstring"" TEXT NOT NULL PRIMARY KEY, ""label"" TEXT NOT NULL, ""availability"" INTEGER NOT NULL, ""can_blueprint"" INTEGER NOT NULL);")
		  Self.SQLExecute("CREATE TABLE ""vars"" (""key"" TEXT NOT NULL PRIMARY KEY, ""value"" TEXT NOT NULL);")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BuiltinPresetsFolder() As FolderItem
		  Return App.ResourcesFolder.Child("Presets")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
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
		  
		  Dim LastBuildNumber As Integer = Val(Self.Variable("app_version"))
		  If LastBuildNumber <> App.NonReleaseVersion Then
		    If Not FirstBuild Then
		      Dim Replacement As New SQLiteDatabase
		      Replacement.DatabaseFile = Self.mBase.DatabaseFile
		      
		      Self.mBase.Close
		      Self.mBase.DatabaseFile.Delete
		      Self.mBase = Replacement
		      
		      If Not Self.mBase.CreateDatabaseFile Then
		        Return
		      End If
		    End If
		    
		    Self.BuildSchema()
		    
		    Dim File As FolderItem = App.ResourcesFolder.Child("Classes.json")
		    If Not File.Exists Then
		      Return
		    End If
		    
		    Dim Stream As TextInputStream = TextInputStream.Open(File)
		    Dim Content As String = Stream.ReadAll(Encodings.UTF8)
		    Stream.Close
		    
		    Self.Import(Content.ToText)
		    Self.Variable("app_version") = Str(App.NonReleaseVersion, "-0")
		  End If
		  
		  Dim LastSync As String = Self.Variable("last_sync")
		  
		  Self.mUpdater = New Xojo.Net.HTTPSocket
		  AddHandler Self.mUpdater.PageReceived, WeakAddressOf Self.mUpdater_PageReceived
		  If LastSync <> "" Then
		    Self.mUpdater.Send("GET", Beacon.WebURL + "/classes.php?changes_since=" + EncodeURLComponent(LastSync).ToText)
		  Else
		    Self.mUpdater.Send("GET", Beacon.WebURL + "/classes.php")
		  End If
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
		  Return Self.CustomPresetsFolder.Child(Preset.Label + BeaconFileTypes.BeaconPreset.PrimaryExtension)
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

	#tag Method, Flags = &h21
		Private Sub Import(Content As Text)
		  Dim ChangeDict As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(Content)
		  
		  Dim SourcesDict As Xojo.Core.Dictionary = ChangeDict.Value("loot_sources")
		  Dim EngramsDict As Xojo.Core.Dictionary = ChangeDict.Value("engrams")
		  Dim LastSync As Text = ChangeDict.Value("timestamp")
		  
		  Dim SourceAdditions() As Auto = SourcesDict.Value("additions")
		  Dim SourceRemovals() As Auto = SourcesDict.Value("removals")
		  If UBound(SourceAdditions) > -1 Or UBound(SourceRemovals) > -1 Then
		    Self.SQLExecute("BEGIN TRANSACTION;")
		    If UBound(SourceRemovals) > -1 Then
		      Dim SourceDeleteStatement As SQLitePreparedStatement = Self.Prepare("DELETE FROM ""loot_sources"" WHERE LOWER(""classstring"") = ?;")
		      SourceDeleteStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      For Each ClassString As Text In SourceRemovals
		        Self.SQLExecute(SourceDeleteStatement, ClassString.Lowercase)
		      Next
		    End If
		    
		    If UBound(SourceAdditions) > -1 Then
		      Dim SourceInsertStatement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO ""loot_sources"" (""classstring"", ""label"", ""kind"", ""engram_mask"", ""multiplier_min"", ""multiplier_max"") VALUES (?, ?, ?, ?, ?, ?);")
		      SourceInsertStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      SourceInsertStatement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		      SourceInsertStatement.BindType(2, SQLitePreparedStatement.SQLITE_TEXT)
		      SourceInsertStatement.BindType(3, SQLitePreparedStatement.SQLITE_INTEGER)
		      SourceInsertStatement.BindType(4, SQLitePreparedStatement.SQLITE_DOUBLE)
		      SourceInsertStatement.BindType(5, SQLitePreparedStatement.SQLITE_DOUBLE)
		      For Each Dict As Xojo.Core.Dictionary In SourceAdditions
		        Dim ClassString As Text = Dict.Value("class")
		        Dim Label As Text = Dict.Value("label")
		        Dim Kind As Text = Dict.Value("kind")
		        Dim Mask As Integer = Dict.Value("mask")
		        Dim MultMin As Double = Dict.Value("mult_min")
		        Dim MultMax As Double = Dict.Value("mult_max")
		        Self.SQLExecute(SourceInsertStatement, ClassString, Label, Kind, Mask, MultMin, MultMax)
		      Next
		    End If
		    Self.SQLExecute("COMMIT TRANSACTION;")
		  End If
		  
		  Dim EngramAdditions() As Auto = EngramsDict.Value("additions")
		  Dim EngramRemovals() As Auto = EngramsDict.Value("removals")
		  If UBound(EngramAdditions) > -1 Or UBound(EngramRemovals) > -1 Then
		    Self.SQLExecute("BEGIN TRANSACTION;")
		    If UBound(EngramRemovals) > -1 Then
		      Dim EngramDeleteStatement As SQLitePreparedStatement = Self.Prepare("DELETE FROM ""engrams"" WHERE LOWER(""classstring"") = ?;")
		      EngramDeleteStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      For Each ClassString As Text In EngramRemovals
		        Self.SQLExecute(EngramDeleteStatement, ClassString.Lowercase)
		      Next
		    End If
		    
		    If UBound(EngramAdditions) > -1 Then
		      Dim EngramInsertStatement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO ""engrams"" (""classstring"", ""label"", ""availability"", ""can_blueprint"") VALUES (?, ?, ?, ?);")
		      EngramInsertStatement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		      EngramInsertStatement.BindType(1, SQLitePreparedStatement.SQLITE_TEXT)
		      EngramInsertStatement.BindType(2, SQLitePreparedStatement.SQLITE_INTEGER)
		      EngramInsertStatement.BindType(3, SQLitePreparedStatement.SQLITE_INTEGER)
		      For Each Dict As Xojo.Core.Dictionary In EngramAdditions
		        Dim ClassString As Text = Dict.Value("class")
		        Dim Label As Text = Dict.Value("label")
		        Dim Availability As Integer = Dict.Value("availability")
		        Dim CanBlueprint As Boolean = (Dict.Value("blueprint") = 1)
		        Self.SQLExecute(EngramInsertStatement, ClassString, Label, Availability, CanBlueprint)
		      Next
		    End If
		    Self.SQLExecute("COMMIT TRANSACTION;")
		  End If
		  
		  Self.Variable("last_sync") = LastSync
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Return File.Exists
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  Dim Folders(1) As FolderItem
		  Folders(0) = Self.BuiltinPresetsFolder
		  Folders(1) = Self.CustomPresetsFolder
		  
		  Dim Extension As String = BeaconFileTypes.BeaconPreset.PrimaryExtension
		  Dim ExtensionLength As Integer = Len(Extension)
		  
		  Redim Self.mPresets(-1)
		  Dim Names() As String
		  
		  For Each Folder As FolderItem In Folders
		    If Folder = Nil Then
		      Continue
		    End If
		    
		    For I As Integer = 1 To Folder.Count
		      Dim File As FolderItem = Folder.Item(I)
		      If Right(File.Name, ExtensionLength) <> Extension Then
		        Continue For I
		      End If
		      
		      Dim Preset As Beacon.Preset = Beacon.Preset.FromFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		      If Preset <> Nil Then
		        Dim Idx As Integer = Names.IndexOf(Preset.Label)
		        If Idx > -1 Then
		          Self.mPresets(Idx) = Preset
		        Else
		          Self.mPresets.Append(Preset)
		          Names.Append(Preset.Label)
		        End If
		      End If
		    Next
		  Next
		  
		  Names.SortWith(Self.mPresets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MultipliersForLootSource(ClassString As Text) As Beacon.Range
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""multiplier_min"", ""multiplier_max"" FROM ""loot_sources"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = ClassString
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return New Beacon.Range(1, 1)
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return New Beacon.Range(1, 1)
		  End If
		  
		  Return New Beacon.Range(RS.Field("multiplier_min").DoubleValue, RS.Field("multiplier_max").DoubleValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdater_PageReceived(Sender As Xojo.Net.HTTPSocket, URL As Text, HTTPStatus As Integer, Content As Xojo.Core.MemoryBlock)
		  #Pragma Unused Sender
		  #Pragma Unused URL
		  
		  If HTTPStatus <> 200 Then
		    Return
		  End If
		  
		  Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content)
		  Self.Import(TextContent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfEngram(ClassString As Text) As Text
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"" FROM ""engrams"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = ClassString
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return ClassString
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return ClassString
		  End If
		  
		  Return RS.Field("label").StringValue.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameOfLootSource(ClassString As Text) As Text
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"" FROM ""loot_sources"" WHERE ""classstring"" = ?;")
		  Statement.BindType(0, SQLitePreparedStatement.SQLITE_TEXT)
		  
		  Dim StringValue As String = ClassString
		  
		  Dim RS As RecordSet
		  Try
		    RS = Self.SQLSelect(Statement, StringValue)
		  Catch Err As UnsupportedOperationException
		    Return ClassString
		  End Try
		  If RS = Nil Or RS.RecordCount = 0 Then
		    Return ClassString
		  End If
		  
		  Return RS.Field("label").StringValue.ToText
		End Function
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
		  Dim File As FolderItem = Self.FileForCustomPreset(Preset)
		  Preset.ToFile(New Xojo.IO.FolderItem(File.NativePath.ToText))
		  Self.LoadPresets()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngrams(SearchText As Text) As Beacon.Engram()
		  // Part of the Beacon.DataSource interface.
		  
		  Dim Results() As Beacon.Engram
		  
		  Dim RS As RecordSet
		  Try
		    If SearchText = "" Then
		      RS = Self.SQLSelect("SELECT ""classstring"" FROM ""engrams"" ORDER BY ""label"";")
		    Else
		      Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"", ""classstring"" FROM ""engrams"" WHERE LOWER(""label"") LIKE LOWER(?1) OR LOWER(""classstring"") LIKE LOWER(?1) ORDER BY ""label"";")
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
		  
		  while Not RS.EOF
		    Results.Append(New Beacon.Engram(RS.Field("classstring").StringValue.ToText))
		    RS.MoveNext
		  wend
		  
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
		      RS = Self.SQLSelect("SELECT ""classstring"" FROM ""loot_sources"" ORDER BY ""label"";")
		    Else
		      Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""label"", ""classstring"" FROM ""loot_sources"" WHERE LOWER(""label"") LIKE LOWER(?1) OR LOWER(""classstring"") LIKE LOWER(?1) ORDER BY ""label"";")
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
		  
		  while Not RS.EOF
		    Results.Append(New Beacon.LootSource(RS.Field("classstring").StringValue.ToText))
		    RS.MoveNext
		  wend
		  
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
		    Dim Statement As SQLitePreparedStatement = Self.Prepare("SELECT ""value"" FROM ""vars"" WHERE ""key"" = ?;")
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
		  Dim Statement As SQLitePreparedStatement = Self.Prepare("INSERT OR REPLACE INTO ""vars"" (""key"", ""value"") VALUES (?, ?);")
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
		Private mPresets() As Beacon.Preset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdater As Xojo.Net.HTTPSocket
	#tag EndProperty


	#tag Constant, Name = CurrentVersion, Type = Double, Dynamic = False, Default = \"1", Scope = Private
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
