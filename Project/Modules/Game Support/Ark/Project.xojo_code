#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag Event
		Sub AddingProfile(Profile As Beacon.ServerProfile)
		  If Profile.IsConsole Then
		    Self.ConsoleSafe = True
		    
		    For Each Entry As DictionaryEntry In Self.mContentPacks
		      Var Pack As Ark.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPackWithUUID(Entry.Key.StringValue)
		      If (Pack Is Nil Or Pack.ConsoleSafe = False) And Self.mContentPacks.Value(Entry.Key).BooleanValue = True Then
		        Self.mContentPacks.Value(Entry.Key) = False
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub AdditionalFilesLoaded()
		  Var ContentPacksJson As String = Self.GetFile("Content Packs.json")
		  If ContentPacksJson.IsEmpty Then
		    Return
		  End If
		  
		  Var PackSaveData() As Variant
		  Try
		    PackSaveData = Beacon.ParseJSON(ContentPacksJson)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Var DataSource As Ark.DataSource
		  For Each SaveData As Variant In PackSaveData
		    If SaveData.Type <> Variant.TypeObject Or (SaveData.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var Pack As Ark.ContentPack = Ark.ContentPack.FromSaveData(Dictionary(SaveData.ObjectValue))
		    If Pack Is Nil Then
		      Continue
		    End If
		    
		    Var BlueprintsFilename As String = Pack.ContentPackId + ".json"
		    Var BlueprintsJson As String = Self.GetFile(BlueprintsFilename)
		    If BlueprintsJson.IsEmpty Then
		      Continue
		    End If
		    
		    Var BlueprintDicts() As Variant
		    Try
		      BlueprintDicts = Beacon.ParseJSON(BlueprintsJson)
		    Catch Err As RuntimeException
		      Continue
		    End Try
		    
		    For Each BlueprintDict As Variant In BlueprintDicts
		      If BlueprintDict.Type <> Variant.TypeObject Or (BlueprintDict.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var ProjectBlueprint As Ark.Blueprint = Ark.UnpackBlueprint(Dictionary(BlueprintDict.ObjectValue))
		      If ProjectBlueprint Is Nil Then
		        Continue
		      End If
		      
		      If DataSource Is Nil Then
		        DataSource = Ark.DataSource.Pool.Get(False)
		      End If
		      
		      Var StoredBlueprint As Ark.Blueprint = DataSource.GetBlueprintById(ProjectBlueprint.BlueprintId)
		      If StoredBlueprint Is Nil Or ProjectBlueprint.LastUpdate > StoredBlueprint.LastUpdate Then
		        DataSource.Cache(ProjectBlueprint)
		      End If
		    Next
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused PlainData
		  #Pragma Unused EncryptedData
		  
		  ManifestData.Value("allowUcs") = Self.AllowUCS2
		  ManifestData.Value("isConsole") = Self.ConsoleSafe
		  ManifestData.Value("map") = Self.MapMask
		  ManifestData.Value("modSelections") = Self.mContentPacks
		  ManifestData.Value("uwpCompatibilityMode") = CType(Self.UWPMode, Integer)
		  
		  Var ConfigSets() As Beacon.ConfigSet = Self.ConfigSets
		  Var Editors() As String
		  For Each ConfigSet As Beacon.ConfigSet In ConfigSets
		    Var SetDict As Dictionary = Self.ConfigSetData(ConfigSet)
		    For Each Entry As DictionaryEntry In SetDict
		      Var ConfigName As String = Entry.Key.StringValue
		      If Editors.IndexOf(ConfigName) = -1 Then
		        Editors.Add(ConfigName)
		      End If
		    Next Entry
		  Next ConfigSet
		  Editors.Sort
		  ManifestData.Value("editors") = Editors
		  
		  Var Difficulty As Ark.Configs.Difficulty = Ark.Configs.Difficulty(Self.ConfigGroup(Ark.Configs.NameDifficulty, Beacon.ConfigSet.BaseConfigSet, True))
		  ManifestData.Value("difficulty") = Difficulty.DifficultyValue
		  
		  If Self.UseCompression = False Then
		    Return
		  End If
		  
		  Var PackSaveData() As Variant
		  Var PackSaveJson As String = Self.GetFile("Content Packs.json")
		  If PackSaveJson.IsEmpty = False Then
		    Try
		      PackSaveData = Beacon.ParseJSON(PackSaveJson)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Var PacksCache As New Dictionary
		  Var PackSaveDicts As New Dictionary
		  For Idx As Integer = PackSaveData.LastIndex DownTo 0
		    If PackSaveData(Idx).Type = Variant.TypeObject And PackSaveData(Idx).ObjectValue IsA Dictionary Then
		      Var Pack As Ark.ContentPack = Ark.ContentPack.FromSaveData(PackSaveData(Idx))
		      If Pack Is Nil Then
		        PackSaveData.RemoveAt(Idx)
		        Continue
		      End If
		      
		      If Self.ContentPackEnabled(Pack) = False Then
		        PackSaveData.RemoveAt(Idx)
		        Self.RemoveFile(Pack.ContentPackId + ".json")
		        Continue
		      End If
		      
		      PacksCache.Value(Pack.ContentPackId) = Pack
		      PackSaveDicts.Value(Pack.ContentPackId) = PackSaveData(Idx)
		    Else
		      PackSaveData.RemoveAt(Idx)
		    End If
		  Next
		  
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  Var LocalPacks() As Ark.ContentPack = DataSource.GetContentPacks(Ark.ContentPack.Types.Custom)
		  For Each LocalPack As Ark.ContentPack In LocalPacks
		    If Self.ContentPackEnabled(LocalPack) = False Then
		      Continue
		    End If
		    
		    Var CachedPack As Ark.ContentPack
		    If PacksCache.HasKey(LocalPack.ContentPackId) = True And Ark.ContentPack(PacksCache.Value(LocalPack.ContentPackId)).LastUpdate >= LocalPack.LastUpdate Then
		      Continue
		    End If
		    
		    Var Blueprints() As Ark.Blueprint = DataSource.GetBlueprints("", New Beacon.StringList(LocalPack.ContentPackId), "")
		    If Blueprints.Count = 0 Then
		      If PackSaveDicts.HasKey(LocalPack.ContentPackId) Then
		        PackSaveDicts.Remove(LocalPack.ContentPackId)
		      End If
		      Self.RemoveFile(LocalPack.ContentPackId + ".json")
		      Continue
		    End If
		    
		    Var PackedBlueprints() As Dictionary
		    For Each Blueprint As Ark.Blueprint In Blueprints
		      Var Packed As Dictionary = Blueprint.Pack
		      If (Packed Is Nil) = False Then
		        PackedBlueprints.Add(Packed)
		      End If
		    Next
		    
		    PackSaveDicts.Value(LocalPack.ContentPackId) = LocalPack.SaveData
		    Self.AddFile(LocalPack.ContentPackId + ".json", Beacon.GenerateJSON(PackedBlueprints, False))
		  Next
		  
		  If PackSaveDicts.KeyCount = 0 Then
		    Self.RemoveFile("Content Packs.json")
		  Else
		    PackSaveData.ResizeTo(-1)
		    For Each Entry As DictionaryEntry In PackSaveDicts
		      PackSaveData.Add(Entry.Value)
		    Next
		    Self.AddFile("Content Packs.json", Beacon.GenerateJSON(PackSaveData, False))
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
		  Var SetDict As New Dictionary
		  Var ConvertLootScale As Dictionary
		  For Each Entry As DictionaryEntry In PlainData
		    Try
		      Var InternalName As String = Entry.Key
		      Var GroupData As Dictionary = Entry.Value
		      Select Case InternalName
		      Case "LootScale"
		        ConvertLootScale = GroupData
		      Case "Metadata"
		      Else
		        Var EncryptedGroupData As Dictionary
		        If EncryptedData.HasKey(InternalName) Then
		          Try
		            EncryptedGroupData = EncryptedData.Value(InternalName)
		          Catch EncGroupDataErr As RuntimeException
		          End Try
		        End If
		        
		        Var Instance As Ark.ConfigGroup = Ark.Configs.CreateInstance(InternalName, GroupData, EncryptedGroupData)
		        If (Instance Is Nil) = False Then
		          SetDict.Value(InternalName) = Instance
		        End If
		      End Select
		    Catch Err As RuntimeException
		      App.Log("Unable to load config group " + Entry.Key + " from project " + Self.UUID + " due to an unhandled " + Err.ClassName + ": " + Err.Message)
		    End Try
		  Next
		  If (ConvertLootScale Is Nil) = False Then
		    Try
		      Var OtherSettings As Ark.Configs.OtherSettings
		      If SetDict.HasKey(Ark.Configs.NameOtherSettings) Then
		        OtherSettings = SetDict.Value(Ark.Configs.NameOtherSettings)
		      Else
		        // Don't add it until we know everything worked
		        OtherSettings = Ark.Configs.OtherSettings(Ark.Configs.CreateInstance(Ark.Configs.NameOtherSettings))
		      End If
		      
		      Var Multiplier As Double = ConvertLootScale.Value("Multiplier")
		      OtherSettings.Value(Ark.DataSource.Pool.Get(False).GetConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "SupplyCrateLootQualityMultiplier")) = Multiplier
		      
		      If SetDict.HasKey(Ark.Configs.NameOtherSettings) = False Then
		        SetDict.Value(Ark.Configs.NameOtherSettings) = OtherSettings
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  Return SetDict
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer)
		  #Pragma Unused EncryptedData
		  #Pragma Unused SaveDataVersion
		  #Pragma Unused SavedWithVersion
		  
		  If SaveDataVersion < 2 Then
		    Var Err As New Beacon.ProjectLoadException
		    Err.Message = "This project is too old to be opened with this version of Beacon."
		    Raise Err
		  ElseIf SaveDataVersion = 2 And PlainData.HasAllKeys("DifficultyValue", "LootSources") Then
		    Var DifficultyValue As Double = PlainData.Value("DifficultyValue")
		    Var LootSources() As Variant = PlainData.Value("LootSources")
		    
		    Var Loot As New Ark.Configs.LootDrops
		    For Each Source As Variant In LootSources
		      Try
		        Var Container As Ark.LootContainer = Ark.LootContainer.FromSaveData(Dictionary(Source))
		        If (Container Is Nil) = False Then
		          Loot.Add(Container)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next Source
		    
		    Var ConfigSet As New Dictionary
		    ConfigSet.Value(Ark.Configs.NameDifficulty) = New Ark.Configs.Difficulty(DifficultyValue)
		    ConfigSet.Value(Ark.Configs.NameLootDrops) = Loot
		    
		    Self.ConfigSetData(Beacon.ConfigSet.BaseConfigSet) = ConfigSet
		  End If
		  
		  Self.AllowUCS2 = PlainData.FirstValue("allowUcs", "AllowUCS", Self.AllowUCS2).BooleanValue
		  Self.ConsoleSafe = PlainData.FirstValue("isConsole", "IsConsole", Self.ConsoleSafe).BooleanValue
		  Self.UWPMode = CType(PlainData.FirstValue("uwpCompatibilityMode", "UWPCompatibilityMode", CType(Self.UWPMode, Integer)).IntegerValue, Ark.Project.UWPCompatibilityModes)
		  
		  Self.MapMask = PlainData.FirstValue("map", "Map", "MapPreference", 1)
		  
		  If PlainData.HasKey("modSelections") Or PlainData.HasKey("ModSelections") Then
		    // Newest mod, keys are uuids and values are boolean
		    Var AllPacks() As Ark.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks()
		    Var Selections As Dictionary = PlainData.FirstValue("modSelections", "ModSelections", Nil)
		    Var ConsoleMode As Boolean = Self.ConsoleSafe
		    For Each Pack As Ark.ContentPack In AllPacks
		      If Selections.HasKey(Pack.ContentPackId) = False Then
		        Selections.Value(Pack.ContentPackId) = Pack.DefaultEnabled And (Pack.ConsoleSafe Or ConsoleMode = False)
		      End If
		    Next
		    
		    Self.mContentPacks = Selections
		  ElseIf PlainData.HasKey("Mods") Then
		    // In this mode, an empty list meant "all on" and populated list mean "only enable these."
		    
		    Var AllPacks() As Ark.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks()
		    Var SelectedContentPacks As Beacon.StringList = Beacon.StringList.FromVariant(PlainData.Value("Mods"))
		    Var SelectedPackCount As Integer = CType(SelectedContentPacks.Count, Integer)
		    Var ConsoleMode As Boolean = Self.ConsoleSafe
		    Var Selections As New Dictionary
		    For Each Pack As Ark.ContentPack In AllPacks
		      Selections.Value(Pack.ContentPackId) = (Pack.ConsoleSafe Or ConsoleMode = False) And (SelectedPackCount = 0 Or SelectedContentPacks.IndexOf(Pack.ContentPackId) > -1)
		    Next
		    
		    Self.mContentPacks = Selections
		  ElseIf PlainData.HasKey("ConsoleModsOnly") Then
		    Var ConsolePacksOnly As Boolean = PlainData.Value("ConsoleModsOnly")
		    If ConsolePacksOnly Then
		      Var Selections As New Dictionary
		      Var AllPacks() As Ark.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks()
		      For Each Pack As Ark.ContentPack In AllPacks
		        Selections.Value(Pack.ContentPackId) = Pack.DefaultEnabled And Pack.ConsoleSafe
		      Next
		      
		      Self.ConsoleSafe = True
		      Self.mContentPacks = Selections
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub SaveConfigSet(SetDict As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  For Each Entry As DictionaryEntry In SetDict
		    Var Group As Ark.ConfigGroup = Entry.Value
		    
		    Var GroupData As Dictionary = Group.SaveData()
		    If GroupData Is Nil Then
		      Continue
		    End If
		    
		    If GroupData.HasAllKeys("Plain", "Encrypted") Then
		      PlainData.Value(Group.InternalName) = GroupData.Value("Plain")
		      EncryptedData.Value(Group.InternalName) = GroupData.Value("Encrypted")
		    Else
		      PlainData.Value(Group.InternalName) = GroupData
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Issues As Beacon.ProjectValidationResults)
		  If Self.mMapMask = CType(0, UInt64) Then
		    Issues.Add(New Beacon.Issue("MapMask", "No map has been selected."))
		  End If
		  
		  Var Sets() As Beacon.ConfigSet = Self.ConfigSets()
		  For Each Set As Beacon.ConfigSet In Sets
		    Var Configs() As Ark.ConfigGroup = Self.ImplementedConfigs(Set)
		    For Each Config As Ark.ConfigGroup In Configs
		      Config.Validate(Set.ConfigSetId, Issues, Self)
		    Next
		  Next
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Ark.ConfigGroup)
		  Self.AddConfigGroup(Group, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Ark.ConfigGroup, Set As Beacon.ConfigSet)
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If SetDict Is Nil Then
		    SetDict = New Dictionary
		  End If
		  SetDict.Value(Group.InternalName) = Group
		  Self.ConfigSetData(Set) = SetDict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllowUCS2() As Boolean
		  Return Self.mAllowUCS2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AllowUCS2(Assigns Value As Boolean)
		  If Self.mAllowUCS2 <> Value Then
		    Self.mAllowUCS2 = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity) As Ark.Project
		  Return Ark.Project(Super.Clone(Identity))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, Sets() As Beacon.ConfigSet) As Ark.ConfigGroup
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Siblings() As Ark.ConfigGroup
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    Var SetDict As Dictionary = Self.ConfigSetData(Set)
		    If SetDict Is Nil Or SetDict.HasKey(GroupName) = False Then
		      Continue
		    End If
		    
		    Var Group As Ark.ConfigGroup = SetDict.Value(GroupName)
		    Siblings.Add(Group)
		  Next
		  
		  Return Ark.Configs.Merge(Siblings, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, States() As Beacon.ConfigSetState) As Ark.ConfigGroup
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfig(GroupName, Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(Sets() As Beacon.ConfigSet) As Ark.ConfigGroup()
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Instances As New Dictionary
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    Var Groups() As Ark.ConfigGroup = Self.ImplementedConfigs(Set)
		    For Each Group As Ark.ConfigGroup In Groups
		      Var Siblings() As Ark.ConfigGroup
		      If Instances.HasKey(Group.InternalName) Then
		        Siblings = Instances.Value(Group.InternalName)
		      End If
		      Siblings.Add(Group)
		      Instances.Value(Group.InternalName) = Siblings
		    Next
		  Next
		  
		  Var Combined() As Ark.ConfigGroup
		  For Each Entry As DictionaryEntry In Instances
		    Var Siblings() As Ark.ConfigGroup = Entry.Value
		    Var Merged As Ark.ConfigGroup = Ark.Configs.Merge(Siblings, False)
		    If (Merged Is Nil) = False Then
		      Combined.Add(Merged)
		    End If
		  Next Entry
		  Return Combined
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(States() As Beacon.ConfigSetState) As Ark.ConfigGroup()
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfigs(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Set As Beacon.ConfigSet, Create As Boolean = False) As Ark.ConfigGroup
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    Return SetDict.Value(InternalName)
		  End If
		  
		  If Create Then
		    Var Group As Ark.ConfigGroup = Ark.Configs.CreateInstance(InternalName)
		    If (Group Is Nil) = False Then
		      Group.IsImplicit = True
		      Self.AddConfigGroup(Group, Set)
		    End If
		    Return Group
		  ElseIf Set.IsBase = False And InternalName = Ark.Configs.NameDifficulty Then
		    // Create is false, we're not in the base config set, and we're looking for difficulty.
		    // Return a *clone* of the base difficulty, but don't add it to the config set.
		    Var BaseDifficulty As Ark.ConfigGroup = Self.ConfigGroup(Ark.Configs.NameDifficulty, Beacon.ConfigSet.BaseConfigSet, False)
		    Var Clone As Ark.ConfigGroup
		    If BaseDifficulty Is Nil Then
		      // Should never happen, but just in case
		      Clone = New Ark.Configs.Difficulty
		      Clone.IsImplicit = True
		    Else
		      Clone = Ark.Configs.CloneInstance(BaseDifficulty)
		      Clone.IsImplicit = BaseDifficulty.IsImplicit
		    End If
		    Return Clone
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Create As Boolean = False) As Ark.ConfigGroup
		  Return Self.ConfigGroup(InternalName, Self.ActiveConfigSet, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafe() As Boolean
		  Return Self.mConsoleSafe
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsoleSafe(Assigns Value As Boolean)
		  If Self.mConsoleSafe <> Value Then
		    Self.mConsoleSafe = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMapMask = 1 // Play it safe, do not bother calling Ark.Maps here in case database access is fubar
		  
		  Self.mContentPacks = New Dictionary
		  Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  If (DataSource Is Nil) = False Then
		    Var Packs() As Ark.ContentPack = DataSource.GetContentPacks
		    For Idx As Integer = 0 To Packs.LastIndex
		      Self.mContentPacks.Value(Packs(Idx).ContentPackId) = Packs(Idx).DefaultEnabled
		    Next Idx
		  End If
		  If Self.mContentPacks.HasKey(Ark.UserContentPackId) Then
		    Self.mContentPacks.Value(Ark.UserContentPackId) = True // Force this, if it exists
		  End If
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(Pack As Ark.ContentPack) As Boolean
		  Return Self.ContentPackEnabled(Pack.ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(Pack As Ark.ContentPack, Assigns Value As Boolean)
		  If Pack Is Nil Then
		    Return
		  End If
		  
		  Self.ContentPackEnabled(Pack.ContentPackId) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(ContentPackId As String) As Boolean
		  Return Self.mContentPacks.Lookup(ContentPackId, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(ContentPackId As String, Assigns Value As Boolean)
		  Var WasEnabled As Boolean = Self.mContentPacks.Lookup(ContentPackId, False)
		  If WasEnabled = Value Then
		    Return
		  End If
		  
		  Self.mContentPacks.Value(ContentPackId) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPacks() As Beacon.StringList
		  Var List As New Beacon.StringList
		  For Each Entry As DictionaryEntry In Self.mContentPacks
		    If Entry.Value.BooleanValue = True Then
		      List.Append(Entry.Key.StringValue)
		    End If
		  Next
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertDinoReplacementsToSpawnOverrides() As Integer
		  If Self.HasConfigGroup(Ark.Configs.NameDinoAdjustments) = False Then
		    Return 0
		  End If
		  
		  Var DinoConfig As Ark.Configs.DinoAdjustments = Ark.Configs.DinoAdjustments(Self.ConfigGroup(Ark.Configs.NameDinoAdjustments))
		  If DinoConfig = Nil Then
		    Return 0
		  End If
		  
		  Var SpawnConfig As Ark.Configs.SpawnPoints // Don't create it yet
		  
		  Var CountChanges As Integer
		  Var Behaviors() As Ark.CreatureBehavior = DinoConfig.Behaviors
		  For Each Behavior As Ark.CreatureBehavior In Behaviors
		    Var ReplacedCreature As Ark.Creature = Behavior.TargetCreature
		    Var ReplacementCreature As Ark.Creature = Behavior.ReplacementCreature
		    If ReplacementCreature = Nil Then
		      Continue
		    End If
		    
		    Var ConfigUpdated As Boolean
		    Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.Pool.Get(False).GetSpawnPointsForCreature(ReplacedCreature, Self.ContentPacks, "")
		    For Each SourceSpawnPoint As Ark.SpawnPoint In SpawnPoints
		      If SourceSpawnPoint.ValidForMask(Self.MapMask) = False Then
		        Continue
		      End If
		      
		      Var SpawnPoint As Ark.MutableSpawnPoint = SourceSpawnPoint.MutableClone
		      Ark.DataSource.Pool.Get(False).LoadDefaults(SpawnPoint)
		      
		      Var Limit As Double = SpawnPoint.Limit(ReplacedCreature)
		      Var NewSets() As Ark.SpawnPointSet
		      For Each Set As Ark.SpawnPointSet In SpawnPoint
		        Var NewSet As Ark.MutableSpawnPointSet
		        For Each Entry As Ark.SpawnPointSetEntry In Set
		          If Entry.Creature <> ReplacedCreature Then
		            Continue
		          End If
		          
		          If NewSet Is Nil Then
		            NewSet = New Ark.MutableSpawnPointSet(Set)
		            NewSet.Label = ReplacementCreature.Label + " (Converted)"
		            NewSet.RemoveAll()
		            NewSet.SetId = Beacon.UUID.v4
		          End If
		          
		          Var NewEntry As New Ark.MutableSpawnPointSetEntry(Entry)
		          NewEntry.Creature = ReplacementCreature
		          NewEntry.EntryId = Beacon.UUID.v4
		          NewSet.Append(NewEntry)
		        Next
		        If (NewSet Is Nil) = False And NewSet.Count > 0 Then
		          NewSets.Add(NewSet)
		        End If
		      Next
		      
		      If NewSets.Count > 0 Then
		        If SpawnConfig Is Nil Then
		          SpawnConfig = Ark.Configs.SpawnPoints(Self.ConfigGroup(Ark.Configs.NameSpawnPoints, True))
		          SpawnConfig.IsImplicit = False
		        End If
		        
		        Var Override As Ark.SpawnPoint = SpawnConfig.GetSpawnPoint(SpawnPoint.ObjectID, Ark.SpawnPoint.ModeAppend)
		        If Override = Nil Then
		          Override = SpawnConfig.GetSpawnPoint(SpawnPoint.ObjectID, Ark.SpawnPoint.ModeOverride)
		        End If
		        If Override = Nil Then
		          Override = New Ark.MutableSpawnPoint(SpawnPoint)
		          Ark.MutableSpawnPoint(Override).ResizeTo(-1)
		          Ark.MutableSpawnPoint(Override).LimitsString = "{}"
		          Ark.MutableSpawnPoint(Override).Mode = Ark.SpawnPoint.ModeAppend
		        End If
		        
		        Var Mutable As Ark.MutableSpawnPoint = Override.MutableVersion
		        Mutable.Limit(ReplacementCreature) = Limit
		        For Each Set As Ark.SpawnPointSet In NewSets
		          Mutable.AddSet(Set)
		        Next
		        
		        SpawnConfig.Add(Mutable)
		        ConfigUpdated = True
		      End If
		    Next
		    
		    If ConfigUpdated Then
		      CountChanges = CountChanges + 1
		      
		      Var NewBehavior As New Ark.MutableCreatureBehavior(Behavior)
		      NewBehavior.ProhibitSpawning = True
		      NewBehavior.ReplacementCreature = Nil
		      DinoConfig.RemoveBehavior(ReplacedCreature)
		      DinoConfig.Add(NewBehavior)
		    End If
		  Next
		  
		  Return CountChanges
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateConfigOrganizer(Identity As Beacon.Identity, Profile As Ark.ServerProfile) As Ark.ConfigOrganizer
		  Try
		    If Identity.IsBanned Then
		      Return Self.CreateTrollConfigOrganizer(Profile)
		    End If
		    
		    Var Organizer As New Ark.ConfigOrganizer
		    Var Groups() As Ark.ConfigGroup = Self.CombinedConfigs(Profile.ConfigSetStates)
		    
		    // Add custom content first so it can be overridden or removed later
		    For Idx As Integer = 0 To Groups.LastIndex
		      If Groups(Idx) Is Nil Then
		        Continue
		      End If
		      
		      If Groups(Idx).InternalName = Ark.Configs.NameCustomContent Then
		        Organizer.AddManagedKeys(Groups(Idx).ManagedKeys)
		        Organizer.Add(Groups(Idx).GenerateConfigValues(Self, Identity, Profile))
		        Groups.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    For Each Group As Ark.ConfigGroup In Groups
		      If Group Is Nil Then
		        Continue
		      End If
		      
		      Var ManagedKeys() As Ark.ConfigKey = Group.ManagedKeys
		      Organizer.AddManagedKeys(ManagedKeys)
		      Organizer.Remove(ManagedKeys) // Removes overlapping values found in custom config
		      Organizer.Add(Group.GenerateConfigValues(Self, Identity, Profile))
		    Next
		    
		    Organizer.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "SessionSettings", "SessionName=" + Profile.Name))
		    
		    If (Profile.MessageOfTheDay Is Nil) = False And Profile.MessageOfTheDay.IsEmpty = False Then
		      Organizer.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "MessageOfTheDay", "Message=" + Profile.MessageOfTheDay.ArkMLValue))
		      Organizer.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "MessageOfTheDay", "Duration=" + Profile.MessageDuration.ToString))
		    End If
		    
		    If (Profile.AdminPassword Is Nil) = False Then
		      Organizer.Add(New Ark.ConfigValue("CommandLineOption", "?", "ServerAdminPassword=" + Profile.AdminPassword.StringValue))
		    End If
		    If (Profile.SpectatorPassword Is Nil) = False Then
		      Organizer.Add(New Ark.ConfigValue("CommandLineOption", "?", "SpectatorPassword=" + Profile.SpectatorPassword.StringValue))
		    End If
		    If (Profile.ServerPassword Is Nil) = False Then
		      Organizer.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ServerPassword=" + Profile.ServerPassword.StringValue))
		    End If
		    
		    Organizer.BeaconKey("Maps") = Profile.Mask.ToString(Locale.Raw, "0")
		    
		    Return Organizer
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Generating a config organizer")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTrollConfigOrganizer(Profile As Ark.ServerProfile) As Ark.ConfigOrganizer
		  Var Values As New Ark.ConfigOrganizer
		  
		  If (Profile Is Nil) = False Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "SessionSettings", "SessionName=" + Profile.Name))
		  End If
		  
		  Var Messages() As String
		  Messages.Add("My dog has no nose.\nHow does he smell?\nBad.")
		  Messages.Add("Pet the damn Thylacoleo!")
		  Messages.Add("You are not in the sudoers file.\nThis incident will be reported.")
		  Messages.Add("All our horses are 100% horse-fed for that double-horse juiced-in goodness.")
		  Messages.Add("The intent is to provide players with a sense of pride and accomplishment.")
		  Messages.Add("Dog lips. That is all.")
		  Messages.Add("Maybe question how the server owner pays for this server.")
		  Messages.Add("You're stuck with this message for 5 minutes.")
		  Messages.Add("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA!")
		  Messages.Add("Bonus round! Until further notice, there are no rules! Admin password is 'peanuts' so have fun!")
		  Messages.Add("It's ""Boy in the Bubble"" day! Even a sneeze could kill you! Good luck!")
		  Messages.Add("Children of Men! Dinos won't respawn! Good luck!")
		  Messages.Add("What happens when an Ark spins out of control?")
		  
		  Var Rand As Random = System.Random
		  Rand.RandomizeSeed
		  Var Index As Integer = Rand.InRange(0, Messages.LastIndex)
		  
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "MessageOfTheDay", "Message=" + Messages(Index)))
		  
		  If Index = 9 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ServerAdminPassword=peanuts"))
		  ElseIf Index = 10 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "PlayerResistanceMultiplier=9999"))
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "MaxFallSpeedMultiplier=0.01"))
		  ElseIf Index = 11 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DinoCountMultiplier=0"))
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DinoResistanceMultiplier=9999"))
		  ElseIf Index = 12 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DayCycleSpeedScale=300"))
		  End If
		  
		  If Index = 7 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "MessageOfTheDay", "Duration=360"))
		  Else
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, "MessageOfTheDay", "Duration=30"))
		  End If
		  
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PlayerHarvestingDamageMultiplier=0.000001"))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoHarvestingDamageMultiplier=0.0000001"))
		  
		  Var Packs As Beacon.StringList = Self.ContentPacks
		  Var Containers() As Ark.LootContainer = Ark.DataSource.Pool.Get(False).GetLootContainers("", Packs, "", True)
		  Var Engram As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngramByUUID("41ec2dab-ed50-4c67-bb8a-3b253789fa87")
		  Var Mask As UInt64 = Self.MapMask
		  For Each Container As Ark.LootContainer In Containers
		    If Container.ValidForMask(Mask) = False Then
		      Continue For Container
		    End If
		    
		    Var Entry As New Ark.MutableLootItemSetEntry
		    Entry.Add(New Ark.LootItemSetEntryOption(Engram, 1.0))
		    Entry.MinQuantity = 300
		    Entry.MaxQuantity = 300
		    Entry.MinQuality = Ark.Qualities.Tier1
		    Entry.MaxQuality = Ark.Qualities.Tier1
		    Entry.ChanceToBeBlueprint = 0
		    Entry.SingleItemQuantity = True
		    
		    Var ItemSet As New Ark.MutableLootItemSet
		    ItemSet.Label = "Turds"
		    ItemSet.MinNumItems = 1
		    ItemSet.MaxNumItems = 1
		    ItemSet.Add(Entry)
		    
		    Var Mutable As Ark.MutableLootContainer = Container.MutableVersion
		    Mutable.MinItemSets = 1
		    Mutable.MaxItemSets = 1
		    Mutable.PreventDuplicates = True
		    Mutable.AppendMode = False
		    Mutable.Add(ItemSet)
		    
		    Ark.Configs.LootDrops.BuildOverrides(Mutable, Values, 5.0)
		  Next Container
		  
		  Var Craftable() As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngrams("", Packs, "{""required"":[""blueprintable""],""excluded"":[""generic""]}")
		  Var CoinFlip As Integer = Rand.InRange(0, 1)
		  If CoinFlip = 0 Then
		    // Turdcraft
		    For Each CraftableEngram As Ark.Engram In Craftable
		      Var Cost As New Ark.MutableCraftingCost(CraftableEngram)
		      Cost.Add(Engram, 300.0, False)
		      Values.Add(Ark.Configs.CraftingCosts.ConfigValueForCraftingCost(Cost))
		    Next CraftableEngram
		  Else
		    // Randomcraft
		    Var Choices() As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngrams("", Packs, "{""required"":[""blueprintable""],""excluded"":[""generic""]}")
		    For Each CraftableEngram As Ark.Engram In Craftable
		      Var Idx As Integer = Rand.InRange(Choices.FirstIndex, Choices.LastIndex)
		      
		      Var Cost As New Ark.MutableCraftingCost(CraftableEngram)
		      Cost.Add(Choices(Idx), 1, False)
		      Choices.RemoveAt(Idx)
		      
		      Values.Add(Ark.Configs.CraftingCosts.ConfigValueForCraftingCost(Cost))
		    Next CraftableEngram
		  End If
		  
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Difficulty() As Ark.Configs.Difficulty
		  Var Group As Ark.ConfigGroup = Self.ConfigGroup(Ark.Configs.NameDifficulty, Self.ActiveConfigSet.IsBase)
		  If Group Is Nil Then
		    Return Nil
		  End If
		  Return Ark.Configs.Difficulty(Group)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(InternalName As String) As Boolean
		  Return Self.HasConfigGroup(InternalName, Self.ActiveConfigSet)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(InternalName As String, Set As Beacon.ConfigSet) As Boolean
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If (SetDict Is Nil) = False Then
		    Return SetDict.HasKey(InternalName)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs() As Ark.ConfigGroup()
		  Var Sets() As Beacon.ConfigSet = Self.ConfigSets
		  Var Groups() As Ark.ConfigGroup
		  For Each Set As Beacon.ConfigSet In Sets
		    Var SetGroups() As Ark.ConfigGroup = Self.ImplementedConfigs(Set)
		    For Each Group As Ark.ConfigGroup In SetGroups
		      Groups.Add(Group)
		    Next
		  Next
		  Return Groups
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs(Set As Beacon.ConfigSet) As Ark.ConfigGroup()
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  Var Groups() As Ark.ConfigGroup
		  If (SetDict Is Nil) = False Then
		    For Each Entry As DictionaryEntry In SetDict
		      Var Group As Ark.ConfigGroup = Entry.Value
		      If Group.IsImplicit = False Or Set.IsBase Then
		        Groups.Add(Group)
		      End If
		    Next
		  End If
		  Return Groups
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MapMask() As UInt64
		  Return Self.mMapMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MapMask(Assigns Value As UInt64)
		  If Self.mMapMask <> Value Then
		    Self.mMapMask = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maps() As Ark.Map()
		  Return Ark.Maps.ForMask(Self.mMapMask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Maps(Assigns MapList() As Ark.Map)
		  Var Value As UInt64 = 0
		  For Each Map As Ark.Map In MapList
		    Value = Value Or Map.Mask
		  Next Map
		  Self.MapMask = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  Var Sets() As Beacon.ConfigSet = Self.ConfigSets
		  For Each Set As Beacon.ConfigSet In Sets
		    Var SetDict As Dictionary = Self.ConfigSetData(Set)
		    If SetDict Is Nil Then
		      Continue
		    End If
		    For Each GroupEntry As DictionaryEntry In SetDict
		      Var Group As Ark.ConfigGroup = GroupEntry.Value
		      If Group.Modified Then
		        Return True
		      End If
		    Next
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Value = False Then
		    Var Sets() As Beacon.ConfigSet = Self.ConfigSets
		    For Each Set As Beacon.ConfigSet In Sets
		      Var SetDict As Dictionary = Self.ConfigSetData(Set)
		      If SetDict Is Nil Then
		        Continue
		      End If
		      For Each GroupEntry As DictionaryEntry In SetDict
		        Var Group As Ark.ConfigGroup = GroupEntry.Value
		        Group.Modified = False
		      Next
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(Group As Ark.ConfigGroup)
		  If Group Is Nil Then
		    Return
		  End If
		  
		  Self.RemoveConfigGroup(Group.InternalName, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(Group As Ark.ConfigGroup, Set As Beacon.ConfigSet)
		  If Group Is Nil Then
		    Return
		  End If
		  
		  Self.RemoveConfigGroup(Group.InternalName, Set)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(InternalName As String)
		  Self.RemoveConfigGroup(InternalName, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(InternalName As String, Set As Beacon.ConfigSet)
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    SetDict.Remove(InternalName)
		    Self.ConfigSetData(Set) = SetDict
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMap(Map As Ark.Map) As Boolean
		  Return (Self.MapMask And Map.Mask) = Map.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SupportsMap(Map As Ark.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.MapMask = Self.MapMask Or Map.Mask
		  Else
		    Self.MapMask = Self.MapMask And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesOmniFeaturesWithoutOmni(Identity As Beacon.Identity) As Ark.ConfigGroup()
		  Var Configs() As Ark.ConfigGroup = Self.ImplementedConfigs()
		  Var ExcludedConfigs() As Ark.ConfigGroup
		  For Each Config As Ark.ConfigGroup In Configs
		    If Ark.Configs.ConfigUnlocked(Config, Identity) = False Then
		      ExcludedConfigs.Add(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UWPMode() As Ark.Project.UWPCompatibilityModes
		  Return Self.mUWPMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UWPMode(Assigns Value As Ark.Project.UWPCompatibilityModes)
		  If Self.mUWPMode <> Value Then
		    Self.mUWPMode = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAllowUCS2 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mConsoleSafe As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPacks As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMapMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUWPMode As Ark.Project.UWPCompatibilityModes
	#tag EndProperty


	#tag Enum, Name = UWPCompatibilityModes, Type = Integer, Flags = &h0
		Automatic
		  Never
		Always
	#tag EndEnum


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
