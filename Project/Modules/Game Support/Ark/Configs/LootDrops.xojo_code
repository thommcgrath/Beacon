#tag Class
Protected Class LootDrops
Inherits Ark.ConfigGroup
Implements Iterable
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.LootDrops = Ark.Configs.LootDrops(Other)
		  For Each Entry As DictionaryEntry In Source.mContainers
		    Self.Add(Ark.LootContainer(Entry.Value))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  Var Difficulty As Ark.Configs.Difficulty = Project.Difficulty
		  If Difficulty Is Nil Then
		    Difficulty = New Ark.Configs.Difficulty
		  End If
		  Var DifficultyValue As Double = Difficulty.DifficultyValue
		  
		  Var Values() As Ark.ConfigValue
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Var Container As Ark.LootContainer = Entry.Value
		    If Container.ValidForMask(Profile.Mask) = False Then
		      Continue
		    End If
		    
		    Self.BuildOverrides(Container, Values, DifficultyValue)
		  Next
		  Return Values()
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, ConfigOverrideSupplyCrateItems))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mContainers.KeyCount > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("Contents") = False Then
		    App.Log("Unable to load LootDrops because there is no Contents key.")
		    Return
		  End If
		  
		  // Only keep the most recent of the duplicates
		  Var Contents() As Dictionary = SaveData.Value("Contents").DictionaryArrayValue
		  For Each DropDict As Dictionary In Contents
		    Var Container As Ark.LootContainer
		    Try
		      Container = Ark.LootContainer.FromSaveData(DropDict)
		      If Container Is Nil Then
		        Continue For DropDict
		      End If
		      Self.mContainers.Value(Container.ClassString) = Container
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading DropDict with Beacon.LoadLootSourceSaveData")
		    End Try
		    If Container Is Nil Then
		      Continue
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Ark.LootContainer(Entry.Value).Validate(Location, Issues, Project)
		  Next Entry
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Var Contents() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Contents.Add(Ark.LootContainer(Entry.Value).SaveData)
		  Next
		  SaveData.Value("Contents") = Contents
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Container As Ark.LootContainer)
		  If (Container Is Nil) = False Then
		    Self.mContainers.Value(Container.ClassString) = Container.ImmutableVersion
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub BuildOverrides(Container As Ark.LootContainer, Organizer As Ark.ConfigOrganizer, Difficulty As Double)
		  Var Values() As Ark.ConfigValue
		  BuildOverrides(Container, Values, Difficulty)
		  For Each Value As Ark.ConfigValue In Values
		    Organizer.Add(Value)
		  Next Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub BuildOverrides(Container As Ark.LootContainer, Values() As Ark.ConfigValue, Difficulty As Double)
		  Var Keys() As String
		  Keys.Add("SupplyCrateClassString=""" + Container.ClassString + """")
		  
		  If Container.AppendMode Then
		    Keys.Add("bAppendItemSets=True")
		  Else
		    Var MinSets As Integer = Min(Container.MinItemSets, Container.MaxItemSets)
		    Var MaxSets As Integer = Max(Container.MaxItemSets, Container.MinItemSets)
		    
		    Keys.Add("MinItemSets=" + MinSets.ToString)
		    Keys.Add("MaxItemSets=" + MaxSets.ToString)
		    Keys.Add("NumItemSetsPower=1.0")
		    Keys.Add("bSetsRandomWithoutReplacement=" + If(Container.PreventDuplicates, "True", "False"))
		  End If
		  
		  Var GeneratedSets() As String
		  For Each Set As Ark.LootItemSet In Container
		    GeneratedSets.Add(Set.StringValue(Container.Multipliers, False, Difficulty))
		  Next
		  Keys.Add("ItemSets=(" + GeneratedSets.Join(",") + ")")
		  
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, ConfigOverrideSupplyCrateItems + "=(" + Keys.Join(",") + ")", ConfigOverrideSupplyCrateItems + ":" + Container.ClassString))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mContainers = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Containers(Filter As String = "") As Ark.LootContainer()
		  Filter = Filter.Trim
		  
		  Var Results() As Ark.LootContainer
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Var Container As Ark.LootContainer = Entry.Value
		    If Filter.IsEmpty = False And Container.Label.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Results.Add(Container.ImmutableVersion)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mContainers.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.LootDrops
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  
		  If Not ParsedData.HasKey(ConfigOverrideSupplyCrateItems) Then
		    Return Nil
		  End If
		  
		  Var Value As Variant = ParsedData.Value(ConfigOverrideSupplyCrateItems)
		  If IsNull(Value) Then
		    Return Nil
		  End If
		  
		  Var Dicts() As Variant
		  If Value.Type = Variant.TypeObject And Value.ObjectValue IsA Dictionary Then
		    Dicts.Add(Dictionary(Value.ObjectValue))
		  ElseIf Value.IsArray And Value.ArrayElementType = Value.TypeObject Then
		    Dicts = Value
		  End If
		  
		  // Only keep the most recent of the duplicates
		  Var LootDrops As New Ark.Configs.LootDrops
		  For Each Member As Variant In Dicts
		    If IsNull(Member) Or Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Container As Ark.LootContainer
		    Try
		      Container = Ark.LootContainer.ImportFromConfig(Dictionary(Member.ObjectValue), Difficulty, ContentPacks)
		    Catch Err As RuntimeException
		      Continue
		    End Try
		    
		    If Container Is Nil Then
		      Continue
		    End If
		    
		    LootDrops.Add(Container)
		  Next
		  If LootDrops.Count > 0 Then
		    Return LootDrops
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasContainer(Container As Ark.LootContainer) As Boolean
		  If (Container Is Nil) = False Then
		    Return Self.mContainers.HasKey(Container.ClassString)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameLootDrops
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Items() As Variant
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Items.Add(Ark.LootContainer(Entry.Value).ImmutableVersion)
		  Next
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RebuildItemSets(Mask As UInt64, ContentPacks As Beacon.StringList) As Integer
		  If Mask = CType(0, UInt64) Then
		    Return 0
		  End If
		  
		  Var NumChanged As Integer
		  For Each Entry As DictionaryEntry In Self.mContainers
		    Var Mutable As Ark.MutableLootContainer = Ark.LootContainer(Entry.Value).MutableVersion
		    Var Num As Integer = Mutable.RebuildItemSets(Mask, ContentPacks)
		    If Num > 0 Then
		      NumChanged = NumChanged + Num
		      Self.mContainers.Value(Mutable.ClassString) = Mutable.ImmutableVersion
		    End If
		  Next Entry
		  Return NumChanged
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Container As Ark.LootContainer)
		  If Container Is Nil Then
		    Return
		  End If
		  
		  If Self.mContainers.HasKey(Container.ClassString) Then
		    Self.mContainers.Remove(Container.ClassString)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  Self.mContainers = New Dictionary
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContainers As Dictionary
	#tag EndProperty


	#tag Constant, Name = ConfigOverrideSupplyCrateItems, Type = String, Dynamic = False, Default = \"ConfigOverrideSupplyCrateItems", Scope = Private
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
