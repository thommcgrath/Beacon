#tag Class
Protected Class ConfigOrganizer
	#tag Method, Flags = &h0
		Sub Add(Values() As Ark.ConfigValue, UniqueOnly As Boolean = False)
		  // This code is a little verbose, but it's easier to follow the logic this way.
		  
		  Self.mIndex.BeginTransaction
		  
		  Var Filtered() As Ark.ConfigValue
		  If UniqueOnly Then
		    For Each Value As Ark.ConfigValue In Values
		      If Self.mValues.HasKey(Value.Hash) = False Then
		        Filtered.Add(Value)
		      End If
		    Next
		  Else
		    Filtered = Values
		  End If
		  
		  For Each Value As Ark.ConfigValue In Filtered
		    Var Siblings() As Ark.ConfigValue
		    
		    If Self.mValues.HasKey(Value.Hash) = False Then
		      // Key does not exist yet
		      Siblings.Add(Value)
		      Self.mValues.Value(Value.Hash) = Siblings
		      Self.mIndex.ExecuteSQL("INSERT INTO keymap (hash, file, header, simplekey, sortkey) VALUES (?1, ?2, ?3, ?4, ?5);", Value.Hash, Value.File, Value.Header, Value.SimplifiedKey, Value.SortKey)
		      Continue
		    End If
		    
		    If Value.SingleInstance Then
		      // There should only be one of this key, so replace the older one
		      Siblings.Add(Value)
		      Self.mValues.Value(Value.Hash) = Siblings
		      Continue
		    End If
		    
		    // Add this value to the array of existing values
		    Siblings = Self.mValues.Value(Value.Hash)
		    Siblings.Add(Value)
		    Self.mValues.Value(Value.Hash) = Siblings
		  Next
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Value As Ark.ConfigValue, UniqueOnly As Boolean = False)
		  Var Values(0) As Ark.ConfigValue
		  Values(0) = Value
		  Self.Add(Values, UniqueOnly)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(File As String, DefaultHeader As String, Content As String)
		  Var Tracker As New TimingTracker
		  
		  Content = Content.ReplaceLineEndings(EndOfLine.UNIX)
		  
		  Var Lines() As String = Content.Split(EndOfLine.UNIX)
		  Var Header As String = DefaultHeader
		  Var MessageOfTheDay As String
		  Var Values() As Ark.ConfigValue
		  Var KeyCounts As New Dictionary
		  For LineIdx As Integer = 0 To Lines.LastIndex
		    Var Line As String = Lines(LineIdx).Trim
		    If Line.IsEmpty Then
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      Header = Line.Middle(1, Line.Length - 2)
		      Continue
		    End If
		    
		    Var Pos As Integer = Line.IndexOf("=")
		    If Pos = -1 Then
		      // This line has no equal sign, skip it
		      If Header = "MessageOfTheDay" Then
		        // Unless it's the message of the day
		        MessageOfTheDay = MessageOfTheDay + "\n" + Line
		      End If
		      Continue
		    End If
		    
		    Var AttributedKey As String = Line.Left(Pos)
		    Var KeyIndex As Integer = KeyCounts.Lookup(AttributedKey, 0).IntegerValue
		    KeyCounts.Value(AttributedKey) = KeyIndex + 1
		    Var Config As New Ark.ConfigValue(File, Header, Line, KeyIndex)
		    If Config.File = Ark.ConfigFileGameUserSettings And Config.Header = "MessageOfTheDay" And Config.SimplifiedKey = "Message" Then
		      MessageOfTheDay = Config.Value
		      Continue
		    End If
		    
		    Values.Add(Config)
		  Next
		  If MessageOfTheDay.IsEmpty = False Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "MessageOfTheDay", "Message=" + MessageOfTheDay, 0))
		  End If
		  Tracker.Log("Took %elapsed% to parse " + Content.Length.ToString + " characters of content.")
		  Self.Add(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddManagedKeys(Keys() As Ark.ConfigKey)
		  For Idx As Integer = Keys.FirstIndex To Keys.LastIndex
		    If Keys(Idx) Is Nil Then
		      Continue
		    End If
		    
		    Self.mManagedKeys.Value(Keys(Idx).Signature) = Keys(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconKey(Key As String) As String
		  Return Self.mExtraBeaconKeys.Lookup(Key, "").StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BeaconKey(Key As String, Assigns Value As String)
		  Self.mExtraBeaconKeys.Value(Key) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeaconKeys() As String()
		  Var Keys() As String
		  For Each Entry As DictionaryEntry In Self.mExtraBeaconKeys
		    Keys.Add(Entry.Key)
		  Next Entry
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Build(ForFile As String) As String
		  Var Headers() As String = Self.Headers(ForFile)
		  If ForFile = Ark.ConfigFileGameUserSettings And Headers.IndexOf(Ark.HeaderServerSettings) = -1 Then
		    Headers.Add(Ark.HeaderServerSettings)
		  End If
		  Var Sections() As String
		  Var EOL As String = Encodings.UTF8.Chr(10)
		  
		  For Each Header As String In Headers
		    Var Lines() As String
		    Lines.Add("[" + Header + "]")
		    
		    // This is special cased so that launch options get sorted with the rest of ServerSettings
		    Var Values() As Ark.ConfigValue
		    If ForFile = Ark.ConfigFileGameUserSettings And Header = Ark.HeaderServerSettings Then
		      Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE (file = ?1 AND header = ?2) OR file IN ('CommandLineOption', 'CommandLineFlag') ORDER BY sortkey;", ForFile, Header)
		      Values = Self.FilteredValues(Rows)
		    Else
		      Values = Self.FilteredValues(ForFile, Header)
		    End If
		    Values.Sort
		    For Each Value As Ark.ConfigValue In Values
		      Lines.Add(Value.Command)
		    Next
		    
		    Sections.Add(Lines.Join(EOL))
		  Next
		  
		  Return Sections.Join(EOL + EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.ConfigOrganizer
		  Var Clone As New Ark.ConfigOrganizer
		  Self.mIndex.Backup(Clone.mIndex, Nil, -1)
		  For Each Entry As DictionaryEntry In Self.mValues
		    Clone.mValues.Value(Entry.Key) = Entry.Value
		  Next
		  For Each Entry As DictionaryEntry In Self.mExtraBeaconKeys
		    Clone.mExtraBeaconKeys.Value(Entry.Key) = Entry.Value
		  Next Entry
		  For Each Entry As DictionaryEntry In Self.mManagedKeys
		    Clone.mManagedKeys.Value(Entry.Key) = Entry.Value
		  Next Entry
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mValues = New Dictionary
		  Self.mExtraBeaconKeys = New Dictionary
		  Self.mManagedKeys = New Dictionary
		  Self.mIndex = New SQLiteDatabase
		  Self.mIndex.Connect
		  Self.mIndex.ExecuteSQL("CREATE TABLE keymap (hash TEXT NOT NULL PRIMARY KEY COLLATE NOCASE, file TEXT NOT NULL COLLATE NOCASE, header TEXT NOT NULL COLLATE NOCASE, simplekey TEXT NOT NULL COLLATE NOCASE, sortkey TEXT NOT NULL COLLATE NOCASE);")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Values() As Ark.ConfigValue)
		  Self.Constructor()
		  Self.Add(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, DefaultHeader As String, Content As String)
		  Self.Constructor()
		  Self.Add(File, DefaultHeader, Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mValues.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys() As Ark.ConfigKey()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, simplekey FROM keymap ORDER BY sortkey;")
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DistinctKeys(Rows As RowSet) As Ark.ConfigKey()
		  Var Results() As Ark.ConfigKey
		  While Rows.AfterLastRow = False
		    Var File As String = Rows.Column("file").StringValue
		    Var Header As String = Rows.Column("header").StringValue
		    Var SimpleKey As String = Rows.Column("simplekey").StringValue
		    Var Key As Ark.ConfigKey = Ark.DataSource.SharedInstance.GetConfigKey(File, Header, SimpleKey)
		    If Key Is Nil Then
		      Key = New Ark.ConfigKey(File, Header, SimpleKey)
		    End If
		    Results.Add(Key)
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys(ForFile As String) As Ark.ConfigKey()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, simplekey FROM keymap WHERE file = ?1;", ForFile)
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys(ForFile As String, ForHeader As String) As Ark.ConfigKey()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, simplekey FROM keymap WHERE file = ?1 AND header = ?2;", ForFile, ForHeader)
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues() As Ark.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap ORDER BY file, header, sortkey;")
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(Key As Ark.ConfigKey) As Ark.ConfigValue()
		  Return Self.FilteredValues(Key.File, Key.Header, Key.SimplifiedKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredValues(Rows As RowSet) As Ark.ConfigValue()
		  Var Results() As Ark.ConfigValue
		  While Rows.AfterLastRow = False
		    Var Hash As String = Rows.Column("hash").StringValue
		    Var Values() As Ark.ConfigValue = Self.mValues.Value(Hash)
		    For Each Value As Ark.ConfigValue In Values
		      Results.Add(Value)
		    Next
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String) As Ark.ConfigValue()
		  Var Rows As RowSet
		  If ForFile = Ark.ConfigFileGameUserSettings Then
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file IN (?1, 'CommandLineOption', 'CommandLineFlag') ORDER BY header, sortkey;", ForFile)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 ORDER BY header, sortkey;", ForFile)
		  End If
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String, ForHeader As String) As Ark.ConfigValue()
		  Var Rows As RowSet
		  If ForFile = Ark.ConfigFileGameUserSettings And ForHeader = Ark.HeaderServerSettings Then
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE (file = ?1 AND header = ?2) OR file = 'CommandLineOption' OR file = 'CommandLineFlag' ORDER BY sortkey;", ForFile, ForHeader)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 ORDER BY sortkey;", ForFile, ForHeader)
		  End If
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String, ForHeader As String, ForSimpleKey As String) As Ark.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND simplekey = ?3;", ForFile, ForHeader, ForSimpleKey)
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(InFile As String, Header As String) As Boolean
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT COUNT(hash) AS numkeys FROM keymap WHERE file = ?1 AND header = ?2;", InFile, Header)
		  Return Rows.Column("numkeys").IntegerValue > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Headers(ForFile As String) As String()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT header FROM keymap WHERE file = ?1 ORDER BY header;", ForFile)
		  Var Results() As String
		  While Rows.AfterLastRow = False
		    Results.Add(Rows.Column("header").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys(ForFile As String, ForHeader As String) As String()
		  Var Rows As RowSet
		  If ForFile = Ark.ConfigFileGameUserSettings And ForHeader = Ark.HeaderServerSettings Then
		    Rows = Self.mIndex.SelectSQL("SELECT DISTINCT simplekey FROM keymap WHERE (file = ?1 AND header = ?2) OR file IN ('CommandLineOption', 'CommandLineFlag') ORDER BY sortkey;", ForFile, ForHeader)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT DISTINCT simplekey FROM keymap WHERE file = ?1 AND header = ?2 ORDER BY sortkey;", ForFile, ForHeader)
		  End If
		  Var Keys() As String
		  While Rows.AfterLastRow = False
		    Keys.Add(Rows.Column("simplekey").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManagedKeys() As Ark.ConfigKey()
		  Var Results() As Ark.ConfigKey
		  For Each Entry As DictionaryEntry In Self.mManagedKeys
		    Results.Add(Entry.Value)
		  Next Entry
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Keys() As Ark.ConfigKey)
		  Self.mIndex.BeginTransaction
		  For Each Key As Ark.ConfigKey In Keys
		    If Key Is Nil Then
		      Continue
		    End If
		    Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND simplekey = ?3;", Key.File, Key.Header, Key.Key)
		    While Rows.AfterLastRow = False
		      Var Hash As String = Rows.Column("hash").StringValue
		      Self.mValues.Remove(Hash)
		      Self.mIndex.ExecuteSQL("DELETE FROM keymap WHERE hash = ?1;", Hash)
		      Rows.MoveToNextRow
		    Wend
		  Next
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Key As Ark.ConfigKey)
		  Var Keys(0) As Ark.ConfigKey
		  Keys(0) = Key
		  Self.Remove(Keys)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Values() As Ark.ConfigValue)
		  Self.mIndex.BeginTransaction
		  For Each Value As Ark.ConfigValue In Values
		    If Self.mValues.HasKey(Value.Hash) Then
		      Self.mValues.Remove(Value.Hash)
		      Self.mIndex.ExecuteSQL("DELETE FROM keymap WHERE hash = ?1;", Value.Hash)
		    End If
		  Next
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Value As Ark.ConfigValue)
		  Var Values(0) As Ark.ConfigValue
		  Values(0) = Value
		  Self.Remove(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Remove(Rows As RowSet)
		  Self.mIndex.BeginTransaction
		  While Rows.AfterLastRow = False
		    Var Hash As String = Rows.Column("hash").StringValue
		    Self.mValues.Remove(Hash)
		    Self.mIndex.ExecuteSQL("DELETE FROM keymap WHERE hash = ?1;", Hash)
		    Rows.MoveToNextRow
		  Wend
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ForFile As String)
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1;", ForFile)
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ForFile As String, Header As String)
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2;", ForFile, Header)
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ForFile As String, Header As String, Key As String)
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND simplekey = ?3;", ForFile, Header, Key)
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Swap(TargetKey As Ark.ConfigKey, ReplacementKey As Ark.ConfigKey)
		  If TargetKey Is Nil Or ReplacementKey Is Nil Then
		    Return
		  End If
		  
		  Var Values() As Ark.ConfigValue = Self.FilteredValues(TargetKey)
		  If Values.Count = 0 Then
		    Return
		  End If
		  
		  Self.Remove(Values)
		  Self.Remove(ReplacementKey)
		  
		  If Self.mManagedKeys.HasKey(TargetKey.Signature) Then
		    Self.mManagedKeys.Remove(TargetKey.Signature)
		    Self.mManagedKeys.Value(ReplacementKey.Signature) = ReplacementKey
		  End If
		  
		  Var Replacements() As Ark.ConfigValue
		  For Each Value As Ark.ConfigValue In Values
		    Replacements.Add(New Ark.ConfigValue(ReplacementKey, Value.Command, Value.SortKey))
		  Next Value
		  Self.Add(Replacements)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mExtraBeaconKeys As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndex As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mManagedKeys As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValues As Dictionary
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
