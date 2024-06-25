#tag Class
Protected Class ConfigOrganizer
	#tag Method, Flags = &h0
		Sub Add(Values() As Palworld.ConfigValue, Options As Integer = 0)
		  // This code is a little verbose, but it's easier to follow the logic this way.
		  
		  Var UniqueOnly As Boolean = (Options And Self.OptionAddOnlyUnique) > 0
		  Var IsManaged As Boolean = (Options And Self.OptionValueIsManaged) > 0
		  
		  Self.mIndex.BeginTransaction
		  
		  Var Filtered() As Palworld.ConfigValue
		  If UniqueOnly Then
		    For Each Value As Palworld.ConfigValue In Values
		      If Self.mValues.HasKey(Value.Hash) = False Then
		        Filtered.Add(Value)
		      End If
		    Next
		  Else
		    Filtered = Values
		  End If
		  
		  For Each Value As Palworld.ConfigValue In Filtered
		    Var Siblings() As Palworld.ConfigValue
		    
		    If Self.mValues.HasKey(Value.Hash) = False Then
		      // Key does not exist yet
		      Siblings.Add(Value)
		      Self.mValues.Value(Value.Hash) = Siblings
		      Self.mIndex.ExecuteSQL("INSERT INTO keymap (hash, file, header, struct, simplekey, sortkey) VALUES (?1, ?2, ?3, ?4, ?5, ?6);", Value.Hash, Value.File, Value.Header, NullableString.ToVariant(Value.Struct), Value.SimplifiedKey, Value.SortKey)
		      If IsManaged Then
		        Self.AddManagedKeys(Value.Details)
		      End If
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
		Sub Add(Value As Palworld.ConfigValue, Options As Integer = 0)
		  Var Values(0) As Palworld.ConfigValue
		  Values(0) = Value
		  Self.Add(Values, Options)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(File As String, Header As String, Struct As NullableString, Key As String, Value As Variant, Options As Integer = 0)
		  Var StringValue As String
		  Select Case Value.Type
		  Case Variant.TypeBoolean
		    StringValue = If(Value.BooleanValue, "True", "False")
		  Case Variant.TypeInt32, Variant.TypeInt64, Variant.TypeDouble, Variant.TypeSingle, Variant.TypeCurrency
		    StringValue = Value.DoubleValue.PrettyText
		  Else
		    StringValue = """" + Value.StringValue.ReplaceAll("""", "\""") + """"
		  End Select
		  
		  Self.Add(New Palworld.ConfigValue(File, Header, Struct, Key + "=" + StringValue), Options)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(File As String, DefaultHeader As String, Content As String)
		  Var Tracker As New TimingTracker
		  
		  Content = Content.ReplaceLineEndings(EndOfLine.UNIX)
		  
		  Var DataSource As Palworld.DataSource = Palworld.DataSource.Pool.Get(False)
		  Var Lines() As String = Content.Split(EndOfLine.UNIX)
		  Var Header As String = DefaultHeader
		  Var Values() As Palworld.ConfigValue
		  Var KeyCounts As New Dictionary
		  Var Structs() As String = DataSource.GetConfigStructs(File, Header)
		  
		  For LineIdx As Integer = 0 To Lines.LastIndex
		    Var Line As String = Lines(LineIdx).Trim
		    If Line.IsEmpty Then
		      Continue
		    End If
		    
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      Header = Line.Middle(1, Line.Length - 2)
		      Structs = DataSource.GetConfigStructs(File, Header)
		      Continue
		    End If
		    
		    Var Parsed As Variant = Palworld.ImportThread.ParseLine(Line + EndOfLine.UNIX)
		    If Parsed.IsNull Or Parsed.Type <> Variant.TypeObject Or (Parsed.ObjectValue IsA Beacon.KeyValuePair) = False Then
		      Continue
		    End If
		    
		    Var Result As Beacon.KeyValuePair = Parsed
		    Var AttributedKey As String = Result.Key
		    Var KeyIndex As Integer = KeyCounts.Lookup(AttributedKey, 0).IntegerValue
		    KeyCounts.Value(AttributedKey) = KeyIndex + 1
		    
		    If Structs.IndexOf(AttributedKey) > -1 And Result.Value.Type = Variant.TypeObject ANd Result.Value.ObjectValue IsA Dictionary Then
		      Var Struct As String = AttributedKey
		      Var StructData As Dictionary = Result.Value
		      For Each Entry As DictionaryEntry In StructData
		        Var Key As String = Entry.Key
		        Var Command As String
		        Select Case Entry.Value.Type
		        Case Variant.TypeBoolean
		          Command = Key + "=" + If(Entry.Value.BooleanValue, "True", "False")
		        Case Variant.TypeDouble, Variant.TypeSingle, Variant.TypeInt32, Variant.TypeInt64, Variant.TypeCurrency
		          Command = Key + "=" + Entry.Value.DoubleValue.PrettyText
		        Else
		          Command = Key + "=""" + Entry.Value.StringValue + """"
		        End Select
		        
		        Values.Add(New Palworld.ConfigValue(File, Header, Struct, Command))
		      Next
		      Continue
		    End If
		    
		    Values.Add(New Palworld.ConfigValue(File, Header, Nil, Line, KeyIndex))
		  Next
		  Tracker.Log("Took %elapsed% to parse " + Content.Length.ToString + " characters of content.")
		  Self.Add(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddManagedKeys(Keys() As Palworld.ConfigOption)
		  For Idx As Integer = Keys.FirstIndex To Keys.LastIndex
		    If Keys(Idx) Is Nil Then
		      Continue
		    End If
		    
		    Self.mManagedKeys.Value(Keys(Idx).Signature) = Keys(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddManagedKeys(ParamArray Keys() As Palworld.ConfigOption)
		  Self.AddManagedKeys(Keys)
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
		  If ForFile = Palworld.ConfigFileSettings And Headers.IndexOf(Palworld.HeaderPalworldSettings) = -1 Then
		    Headers.Add(Palworld.HeaderPalworldSettings)
		  End If
		  Var Sections() As String
		  Var EOL As String = Encodings.UTF8.Chr(10)
		  
		  For Each Header As String In Headers
		    Var Lines() As String
		    Lines.Add("[" + Header + "]")
		    
		    Var Structs() As String = Self.Structs(ForFile, Header)
		    For Each Struct As String In Structs
		      Var Values() As Palworld.ConfigValue = Self.FilteredValues(ForFile, Header, Struct)
		      Var Members() As String
		      Values.Sort
		      For Each Value As Palworld.ConfigValue In Values
		        Members.Add(Value.Command)
		      Next
		      If Members.Count > 0 Then
		        Lines.Add(Struct + "=(" + String.FromArray(Members, ",") + ")")
		      End If
		    Next
		    
		    Var Values() As Palworld.ConfigValue = Self.FilteredValues(ForFile, Header, Nil)
		    Values.Sort
		    For Each Value As Palworld.ConfigValue In Values
		      Lines.Add(Value.Command)
		    Next
		    
		    Sections.Add(Lines.Join(EOL))
		  Next
		  
		  Return Sections.Join(EOL + EOL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Palworld.ConfigOrganizer
		  Var Clone As New Palworld.ConfigOrganizer
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
		  Self.mIndex.ExecuteSQL("CREATE TABLE keymap (hash TEXT NOT NULL PRIMARY KEY COLLATE NOCASE, file TEXT NOT NULL COLLATE NOCASE, header TEXT NOT NULL COLLATE NOCASE, struct TEXT COLLATE NOCASE, simplekey TEXT NOT NULL COLLATE NOCASE, sortkey TEXT NOT NULL COLLATE NOCASE);")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Values() As Palworld.ConfigValue)
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
		Function DistinctKeys() As Palworld.ConfigOption()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, struct, simplekey FROM keymap ORDER BY sortkey;")
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DistinctKeys(Rows As RowSet) As Palworld.ConfigOption()
		  Var Results() As Palworld.ConfigOption
		  While Rows.AfterLastRow = False
		    Var File As String = Rows.Column("file").StringValue
		    Var Header As String = Rows.Column("header").StringValue
		    Var Struct As NullableString = NullableString.FromVariant(Rows.Column("struct").Value)
		    Var SimpleKey As String = Rows.Column("simplekey").StringValue
		    Var Key As Palworld.ConfigOption = Palworld.DataSource.Pool.Get(False).GetConfigOption(File, Header, Struct, SimpleKey)
		    If Key Is Nil Then
		      Key = New Palworld.ConfigOption(File, Header, Struct, SimpleKey)
		    End If
		    Results.Add(Key)
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys(ForFile As String) As Palworld.ConfigOption()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, struct, simplekey FROM keymap WHERE file = ?1;", ForFile)
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys(ForFile As String, ForHeader As String) As Palworld.ConfigOption()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, struct, simplekey FROM keymap WHERE file = ?1 AND header = ?2;", ForFile, ForHeader)
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys(ForFile As String, ForHeader As String, ForStruct As String) As Palworld.ConfigOption()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, header, struct, simplekey FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3;", ForFile, ForHeader, ForStruct)
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues() As Palworld.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap ORDER BY file, header, sortkey;")
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(Key As Palworld.ConfigOption) As Palworld.ConfigValue()
		  Return Self.FilteredValues(Key.File, Key.Header, Key.Struct, Key.SimplifiedKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredValues(Rows As RowSet) As Palworld.ConfigValue()
		  Var Results() As Palworld.ConfigValue
		  While Rows.AfterLastRow = False
		    Var Hash As String = Rows.Column("hash").StringValue
		    Var Values() As Palworld.ConfigValue = Self.mValues.Value(Hash)
		    For Each Value As Palworld.ConfigValue In Values
		      Results.Add(Value)
		    Next
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String) As Palworld.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 ORDER BY header, sortkey;", ForFile)
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String, ForHeader As String) As Palworld.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 ORDER BY sortkey;", ForFile, ForHeader)
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String, ForHeader As String, ForStruct As NullableString) As Palworld.ConfigValue()
		  Var Rows As RowSet
		  If ForStruct Is Nil Then
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct IS NULL ORDER BY sortkey;", ForFile, ForHeader)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3 ORDER BY sortkey;", ForFile, ForHeader, ForStruct.StringValue)
		  End If
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String, ForHeader As String, ForStruct As NullableString, ForSimpleKey As String) As Palworld.ConfigValue()
		  Var Rows As RowSet
		  If ForStruct Is Nil Then
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct IS NULL AND simplekey = ?3;", ForFile, ForHeader, ForSimpleKey)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3 AND simplekey = ?4;", ForFile, ForHeader, ForStruct.StringValue, ForSimpleKey)
		  End If
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
		Function HasStruct(InFile As String, Header As String, Struct As String) As Boolean
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT COUNT(hash) AS numkeys FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3;", InFile, Header, Struct)
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
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT simplekey FROM keymap WHERE file = ?1 AND header = ?2 ORDER BY sortkey;", ForFile, ForHeader)
		  Var Keys() As String
		  While Rows.AfterLastRow = False
		    Keys.Add(Rows.Column("simplekey").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManagedKeys() As Palworld.ConfigOption()
		  Var Results() As Palworld.ConfigOption
		  For Each Entry As DictionaryEntry In Self.mManagedKeys
		    Results.Add(Entry.Value)
		  Next Entry
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ParseLine(Line As String, ByRef Key As String, ByRef Value As Variant)
		  Line = Line.ReplaceAll("\""", "2488dddbde7c")
		  
		  Var EqualsPos As Integer = Line.IndexOf("=")
		  If EqualsPos = -1 Then
		    Key = ""
		    Value = Nil
		    Return
		  End If
		  
		  Var StartPos As Integer = EqualsPos + 1
		  Var ParsedValue As Variant = ParseValue(Line, StartPos)
		  
		  Key = Line.Left(EqualsPos)
		  Value = ParsedValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ParseStruct(File As String, Header As String, Line As String) As Palworld.ConfigValue()
		  Var Values() As Palworld.ConfigValue
		  #if false
		    Var EqualsPos As Integer = Line.IndexOf("=")
		    Var OpenPos As Integer = Line.IndexOf("(")
		    If EqualsPos = -1 Or OpenPos = -1 Or OpenPos <> EqualsPos + 1 Then
		      Return Values
		    End If
		    
		    Var StartPos As Integer = OpenPos + 1
		    Do
		      Var KeyEqualsPos As Integer = Line.IndexOf(StartPos, "=")
		      Var ValueStartPos As Integer = KeyEqualsPos + 1
		      Var ValueEndPos As Integer
		      If Line.Middle(ValueStartPos, 1) = """" Then
		        ValueStartPos = ValueStartPos + 1
		        ValueEndPos = Line.IndexOf(ValueStartPos, """")
		      ElseIf Line.Middle(ValueStartPos, 1) = "(" Then
		        ValueStartPos = ValueStartPos + 1
		        ValueEndPos
		      Else
		        ValueEndPos = Min(Line.IndexOf(ValueStartPos, ","), Line.IndexOf(ValueStartPos, ")"))
		      End If
		    Loop Until
		  #endif
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ParseValue(Line As String, ByRef StartPos As Integer) As Variant
		  If Line.Middle(StartPos, 1) = """" Then
		    // Quoted string
		    StartPos = StartPos + 1
		    Var EndPos As Integer = Line.IndexOf(StartPos, """")
		    If EndPos = -1 Then
		      EndPos = Line.Length
		    End If
		    
		    Var Value As String = Line.Middle(StartPos, EndPos - StartPos).ReplaceAll("2488dddbde7c", """")
		    StartPos = EndPos
		    Return Value
		  End If
		  
		  If Line.Middle(StartPos, 1) = "(" Then
		    // Struct or array
		    StartPos = StartPos + 1
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Keys() As Palworld.ConfigOption)
		  Self.mIndex.BeginTransaction
		  For Each Key As Palworld.ConfigOption In Keys
		    If Key Is Nil Then
		      Continue
		    End If
		    Var Rows As RowSet
		    If Key.Struct Is Nil Then
		      Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct IS NULL AND simplekey = ?3;", Key.File, Key.Header, Key.Key)
		    Else
		      Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3 AND simplekey = ?4;", Key.File, Key.Header, Key.Struct.StringValue, Key.Key)
		    End If
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
		Sub Remove(Key As Palworld.ConfigOption)
		  Var Keys(0) As Palworld.ConfigOption
		  Keys(0) = Key
		  Self.Remove(Keys)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Values() As Palworld.ConfigValue)
		  Self.mIndex.BeginTransaction
		  For Each Value As Palworld.ConfigValue In Values
		    If Self.mValues.HasKey(Value.Hash) Then
		      Self.mValues.Remove(Value.Hash)
		      Self.mIndex.ExecuteSQL("DELETE FROM keymap WHERE hash = ?1;", Value.Hash)
		    End If
		  Next
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Value As Palworld.ConfigValue)
		  Var Values(0) As Palworld.ConfigValue
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
		Sub Remove(ForFile As String, Header As String, Struct As NullableString)
		  Var Rows As RowSet
		  If Struct Is Nil Then
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct IS NULL;", ForFile, Header)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3;", ForFile, Header, Struct.StringValue)
		  End If
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ForFile As String, Header As String, Struct As NullableString, Key As String)
		  Var Rows As RowSet
		  If Struct Is Nil Then
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct IS NULL AND simplekey = ?3;", ForFile, Header, Key)
		  Else
		    Rows = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND header = ?2 AND struct = ?3 AND simplekey = ?4;", ForFile, Header, Struct.StringValue, Key)
		  End If
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Structs(ForFile As String, ForHeader As String) As String()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT struct FROM keymap WHERE file = ?1 AND header = ?2 AND struct IS NOT NULL ORDER BY struct", ForFile, ForHeader)
		  Var Results() As String
		  While Rows.AfterLastRow = False
		    Results.Add(Rows.Column("struct").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Swap(TargetKey As Palworld.ConfigOption, ReplacementKey As Palworld.ConfigOption)
		  If TargetKey Is Nil Or ReplacementKey Is Nil Then
		    Return
		  End If
		  
		  Var Values() As Palworld.ConfigValue = Self.FilteredValues(TargetKey)
		  If Values.Count = 0 Then
		    Return
		  End If
		  
		  Self.Remove(Values)
		  Self.Remove(ReplacementKey)
		  
		  If Self.mManagedKeys.HasKey(TargetKey.Signature) Then
		    Self.mManagedKeys.Remove(TargetKey.Signature)
		    Self.mManagedKeys.Value(ReplacementKey.Signature) = ReplacementKey
		  End If
		  
		  Var Replacements() As Palworld.ConfigValue
		  For Each Value As Palworld.ConfigValue In Values
		    Replacements.Add(New Palworld.ConfigValue(ReplacementKey, Value.Command, Value.SortKey))
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


	#tag Constant, Name = OptionAddOnlyUnique, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OptionValueIsManaged, Type = Double, Dynamic = False, Default = \"2", Scope = Public
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
	#tag EndViewBehavior
End Class
#tag EndClass
