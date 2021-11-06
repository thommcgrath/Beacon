#tag Class
Protected Class LootDrops
Inherits Ark.ConfigGroup
Implements Iterable
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.LootDrops = Ark.Configs.LootDrops(Other)
		  For Each Container As Ark.LootContainer In Source
		    Var Idx As Integer = Self.IndexOf(Container)
		    If Idx > -1 Then
		      Self.Operator_Subscript(Idx) = Container
		    Else
		      Self.Add(Container)
		    End If
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
		  
		  If App.IdentityManager.CurrentIdentity.IsBanned Then
		    Var Containers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainers()
		    Var Engram As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramByUUID("1b4d42f4-86ab-4277-a73e-dd688635b324")
		    
		    Var Entry As New Ark.MutableLootItemSetEntry
		    Entry.Add(New Ark.LootItemSetEntryOption(Engram, 1.0))
		    Entry.MinQuantity = 300
		    Entry.MaxQuantity = 300
		    Entry.MinQuality = Ark.Qualities.Tier1
		    Entry.MaxQuality = Ark.Qualities.Tier1
		    Entry.ChanceToBeBlueprint = 0
		    
		    Var Set As New Ark.MutableLootItemSet
		    Set.Label = "Turds"
		    Set.MinNumItems = 1
		    Set.MaxNumItems = 1
		    Set.Add(Entry)
		    
		    Var Values() As Ark.ConfigValue
		    For Each Container As Ark.LootContainer In Containers
		      If Not Container.ValidForMask(Profile.Mask) Then
		        Continue
		      End If
		      
		      Var Mutable As New Ark.MutableLootContainer(Container)
		      Mutable.MinItemSets = 1
		      Mutable.MaxItemSets = 1
		      Call Mutable.Add(Set)
		      
		      Self.BuildOverrides(Mutable, Values, DifficultyValue)
		    Next
		    Return Values
		  End If
		  
		  Var Values() As Ark.ConfigValue
		  For Each Container As Ark.LootContainer In Self.mContainers
		    If Not Container.ValidForMask(Profile.Mask) Then
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
		  Return Self.mContainers.Count > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  If SaveData.HasKey("Contents") = False Then
		    App.Log("Unable to load LootDrops because there is no Contents key.")
		    Return
		  End If
		  
		  // Only keep the most recent of the duplicates
		  Var Contents() As Dictionary = SaveData.Value("Contents").DictionaryArrayValue
		  Var UniqueClasses As New Dictionary
		  For Each DropDict As Dictionary In Contents
		    Var Container As Ark.LootContainer
		    Try
		      Container = Ark.LootContainer.FromSaveData(DropDict)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading DropDict with Beacon.LoadLootSourceSaveData")
		    End Try
		    If Container Is Nil Then
		      Continue
		    End If
		    
		    Var Idx As Integer = UniqueClasses.Lookup(Container.ClassString, -1)
		    If Idx = -1 Then
		      Self.mContainers.Add(Container)
		      UniqueClasses.Value(Container.ClassString) = Self.mContainers.LastIndex
		    Else
		      Self.mContainers(Idx) = Container
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  For Each Container As Ark.LootContainer In Self.mContainers
		    Container.Validate(Location, Issues, Project)
		  Next Container
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  Var Contents() As Dictionary
		  For Each Container As Ark.LootContainer In Self.mContainers
		    Contents.Add(Container.SaveData)
		  Next
		  SaveData.Value("Contents") = Contents
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Container As Ark.LootContainer)
		  Self.mContainers.Add(Container.ImmutableVersion)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub BuildOverrides(Container As Ark.LootContainer, Values() As Ark.ConfigValue, Difficulty As Double)
		  Var Keys() As String
		  Keys.Add("SupplyCrateClassString=""" + Container.ClassString + """")
		  
		  If Container.AppendMode Then
		    Keys.Add("bAppendItemSets=true")
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
		Function Containers() As Ark.LootContainer()
		  Var Results() As Ark.LootContainer
		  For Each Container As Ark.LootContainer In Self.mContainers
		    Results.Add(Container)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mContainers.Count
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
		  Var UniqueClasses As New Dictionary
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
		    
		    Var Idx As Integer = UniqueClasses.Lookup(Container.ClassString, -1)
		    If Idx = -1 Then
		      LootDrops.Add(Container)
		      UniqueClasses.Value(Container.ClassString) = LootDrops.LastIndex
		    Else
		      LootDrops(Idx) = Container
		    End If
		  Next
		  If LootDrops.LastIndex > -1 Then
		    Return LootDrops
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasContainer(Container As Ark.LootContainer) As Boolean
		  Return Self.IndexOf(Container) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Container As Ark.LootContainer) As Integer
		  For I As Integer = 0 To Self.mContainers.LastIndex
		    If Self.mContainers(I).ClassString = Container.ClassString Then
		      Return I
		    End If
		  Next
		  Return -1
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
		  Items.ResizeTo(Self.mContainers.LastIndex)
		  For I As Integer = Items.FirstIndex To Items.LastIndex
		    Items(I) = Self.mContainers(I)
		  Next
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As Integer
		  Return Self.mContainers.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Container As Ark.LootContainer In Self.mContainers
		    If Container.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Value = False Then
		    For Each Container As Ark.LootContainer In Self.mContainers
		      Container.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Ark.LootContainer
		  Return Self.mContainers(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Container As Ark.LootContainer)
		  Self.mContainers(Index) = Container.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Container As Ark.LootContainer)
		  Var Idx As Integer = Self.IndexOf(Container)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mContainers.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewBound As Integer)
		  If NewBound <> Self.mContainers.LastIndex Then
		    Self.mContainers.ResizeTo(NewBound)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunWhenBanned() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContainers() As Ark.LootContainer
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
