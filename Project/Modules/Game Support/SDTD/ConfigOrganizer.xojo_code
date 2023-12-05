#tag Class
Protected Class ConfigOrganizer
	#tag Method, Flags = &h0
		Sub Add(Values() As SDTD.ConfigValue, UniqueOnly As Boolean = False)
		  Self.Add(Values, If(UniqueOnly, Self.FlagSkipExistingKeys, 0))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Values() As SDTD.ConfigValue, Flags As Integer)
		  // This code is a little verbose, but it's easier to follow the logic this way.
		  
		  Var UniqueOnly As Boolean = (Flags And Self.FlagSkipExistingKeys) = Self.FlagSkipExistingKeys
		  Var AddToManaged As Boolean = (Flags And Self.FlagAddToManaged) = Self.FlagAddToManaged
		  
		  Self.mIndex.BeginTransaction
		  
		  Var Filtered() As SDTD.ConfigValue
		  If UniqueOnly Then
		    For Each Value As SDTD.ConfigValue In Values
		      If Self.mValues.HasKey(Value.Hash) = False Then
		        Filtered.Add(Value)
		      End If
		    Next
		  Else
		    Filtered = Values
		  End If
		  
		  For Each Value As SDTD.ConfigValue In Filtered
		    Var Siblings() As SDTD.ConfigValue
		    
		    If Self.mValues.HasKey(Value.Hash) = False Then
		      // Key does not exist yet
		      Siblings.Add(Value)
		      Self.mValues.Value(Value.Hash) = Siblings
		      Self.mIndex.ExecuteSQL("INSERT INTO keymap (hash, file, key, sortkey) VALUES (?1, ?2, ?3, ?4);", Value.Hash, Value.File, Value.Key, Value.SortKey)
		      If AddToManaged Then
		        Self.mManagedKeys.Value(Value.Details.Signature) = Value.Details
		      End If
		      Continue
		    End If
		    
		    If Value.SingleInstance Then
		      // There should only be one of this key, so replace the older one
		      Siblings.Add(Value)
		      Self.mValues.Value(Value.Hash) = Siblings
		      If AddToManaged Then
		        Self.mManagedKeys.Value(Value.Details.Signature) = Value.Details
		      End If
		      Continue
		    End If
		    
		    // Add this value to the array of existing values
		    Siblings = Self.mValues.Value(Value.Hash)
		    Siblings.Add(Value)
		    Self.mValues.Value(Value.Hash) = Siblings
		    If AddToManaged Then
		      Self.mManagedKeys.Value(Value.Details.Signature) = Value.Details
		    End If
		  Next
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Value As SDTD.ConfigValue, UniqueOnly As Boolean = False)
		  Var Values(0) As SDTD.ConfigValue
		  Values(0) = Value
		  Self.Add(Values, If(UniqueOnly, Self.FlagSkipExistingKeys, 0))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Value As SDTD.ConfigValue, Flags As Integer)
		  Var Values(0) As SDTD.ConfigValue
		  Values(0) = Value
		  Self.Add(Values, Flags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Add(File As String, Content As String, Flags As Integer = 0) As Boolean
		  If Content.IsEmpty Then
		    Return False
		  End If
		  
		  Select Case File
		  Case SDTD.ConfigFileServerConfigXml
		    Try
		      Var Doc As New XmlDocument(Content)
		      Var Root As XmlNode = Doc.DocumentElement
		      If Root.Name <> "ServerSettings" Then
		        Return False
		      End If
		      
		      Var Values() As SDTD.ConfigValue
		      Var Bound As Integer = Root.ChildCount - 1
		      For Idx As Integer = 0 To Bound
		        Var Child As XmlNode = Root.Child(Idx)
		        If Child.Name <> "property" Then
		          Continue
		        End If
		        
		        Var PropertyName As String = Child.GetAttribute("name")
		        Var PropertyValue As String = Child.GetAttribute("value")
		        Values.Add(New SDTD.ConfigValue(SDTD.ConfigFileServerConfigXml, PropertyName, PropertyValue))
		      Next
		      
		      Self.Add(Values, Flags)
		      Return True
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Processing xml file")
		      Return False
		    End Try
		  Else
		    Break
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddManagedKeys(Keys() As SDTD.ConfigOption)
		  For Idx As Integer = Keys.FirstIndex To Keys.LastIndex
		    If Keys(Idx) Is Nil Then
		      Continue
		    End If
		    
		    Self.mManagedKeys.Value(Keys(Idx).Signature) = Keys(Idx)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddManagedKeys(ParamArray Keys() As SDTD.ConfigOption)
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
		Function Clone() As SDTD.ConfigOrganizer
		  Var Clone As New SDTD.ConfigOrganizer
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
		  Self.mIndex.ExecuteSQL("CREATE TABLE keymap (hash TEXT NOT NULL PRIMARY KEY COLLATE NOCASE, file TEXT NOT NULL COLLATE NOCASE, key TEXT NOT NULL, sortkey TEXT NOT NULL COLLATE NOCASE);")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Values() As SDTD.ConfigValue)
		  Self.Constructor()
		  Self.Add(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Content As String)
		  Self.Constructor()
		  Call Self.Add(File, Content)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mValues.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys() As SDTD.ConfigOption()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, key FROM keymap ORDER BY sortkey;")
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DistinctKeys(Rows As RowSet) As SDTD.ConfigOption()
		  Var Results() As SDTD.ConfigOption
		  Var Database As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  While Rows.AfterLastRow = False
		    Var File As String = Rows.Column("file").StringValue
		    Var Key As String = Rows.Column("key").StringValue
		    
		    Var Option As SDTD.ConfigOption
		    Var Options() As SDTD.ConfigOption = Database.GetConfigOptions(File, Key)
		    If Options.Count = 0 Then
		      Option = New SDTD.ConfigOption(File, Key)
		    Else
		      Option = Options(0)
		    End If
		    
		    Results.Add(Option)
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistinctKeys(ForFile As String) As SDTD.ConfigOption()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT file, key FROM keymap WHERE file = ?1 ORDER BY sortkey;", ForFile)
		  Return Self.DistinctKeys(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues() As SDTD.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap ORDER BY file, sortkey;")
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FilteredValues(Rows As RowSet) As SDTD.ConfigValue()
		  Var Results() As SDTD.ConfigValue
		  While Rows.AfterLastRow = False
		    Var Hash As String = Rows.Column("hash").StringValue
		    Var Values() As SDTD.ConfigValue = Self.mValues.Value(Hash)
		    For Each Value As SDTD.ConfigValue In Values
		      Results.Add(Value)
		    Next
		    Rows.MoveToNextRow
		  Wend
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(Key As SDTD.ConfigOption) As SDTD.ConfigValue()
		  Return Self.FilteredValues(Key.File, Key.Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String) As SDTD.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 ORDER BY sortkey;", ForFile)
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilteredValues(ForFile As String, ForSimpleKey As String) As SDTD.ConfigValue()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND key = ?2;", ForFile, ForSimpleKey)
		  Return Self.FilteredValues(Rows)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys(ForFile As String) As String()
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT DISTINCT key FROM keymap WHERE file = ?1 ORDER BY sortkey;", ForFile)
		  Var Keys() As String
		  While Rows.AfterLastRow = False
		    Keys.Add(Rows.Column("simplekey").StringValue)
		    Rows.MoveToNextRow
		  Wend
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ManagedKeys() As SDTD.ConfigOption()
		  Var Results() As SDTD.ConfigOption
		  For Each Entry As DictionaryEntry In Self.mManagedKeys
		    Results.Add(Entry.Value)
		  Next Entry
		  Return Results
		End Function
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
		Sub Remove(Keys() As SDTD.ConfigOption)
		  Self.mIndex.BeginTransaction
		  For Each Key As SDTD.ConfigOption In Keys
		    If Key Is Nil Then
		      Continue
		    End If
		    Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND key = ?2;", Key.File, Key.Key)
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
		Sub Remove(Key As SDTD.ConfigOption)
		  Var Keys(0) As SDTD.ConfigOption
		  Keys(0) = Key
		  Self.Remove(Keys)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Values() As SDTD.ConfigValue)
		  Self.mIndex.BeginTransaction
		  For Each Value As SDTD.ConfigValue In Values
		    If Self.mValues.HasKey(Value.Hash) Then
		      Self.mValues.Remove(Value.Hash)
		      Self.mIndex.ExecuteSQL("DELETE FROM keymap WHERE hash = ?1;", Value.Hash)
		    End If
		  Next
		  Self.mIndex.CommitTransaction
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Value As SDTD.ConfigValue)
		  Var Values(0) As SDTD.ConfigValue
		  Values(0) = Value
		  Self.Remove(Values)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ForFile As String)
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1;", ForFile)
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(ForFile As String, Key As String)
		  Var Rows As RowSet = Self.mIndex.SelectSQL("SELECT hash FROM keymap WHERE file = ?1 AND simplekey = ?2;", ForFile, Key)
		  Self.Remove(Rows)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Swap(TargetKey As SDTD.ConfigOption, ReplacementKey As SDTD.ConfigOption)
		  If TargetKey Is Nil Or ReplacementKey Is Nil Then
		    Return
		  End If
		  
		  Var Values() As SDTD.ConfigValue = Self.FilteredValues(TargetKey)
		  If Values.Count = 0 Then
		    Return
		  End If
		  
		  Self.Remove(Values)
		  Self.Remove(ReplacementKey)
		  
		  If Self.mManagedKeys.HasKey(TargetKey.Signature) Then
		    Self.mManagedKeys.Remove(TargetKey.Signature)
		    Self.mManagedKeys.Value(ReplacementKey.Signature) = ReplacementKey
		  End If
		  
		  Var Replacements() As SDTD.ConfigValue
		  For Each Value As SDTD.ConfigValue In Values
		    Replacements.Add(New SDTD.ConfigValue(ReplacementKey, Value.Value, Value.SortKey))
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


	#tag Constant, Name = FlagAddToManaged, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagSkipExistingKeys, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
