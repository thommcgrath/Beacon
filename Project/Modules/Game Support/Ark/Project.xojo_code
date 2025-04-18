#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub AddingProfile(Profile As Beacon.ServerProfile)
		  If Profile.IsConsole Then
		    Self.IsFlagged(Ark.Project.FlagConsoleSafe) = True
		    
		    Var DataSource As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		    Var PackIds() As String = Self.ContentPacks()
		    For Each PackId As String In PackIds
		      Var Pack As Beacon.ContentPack = DataSource.GetContentPackWithId(PackId)
		      If Pack Is Nil Or Pack.IsConsoleSafe = False Then
		        Self.ContentPackEnabled(PackId) = False
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused PlainData
		  #Pragma Unused EncryptedData
		  
		  ManifestData.Value("allowUcs") = Self.IsFlagged(Ark.Project.FlagAllowUCS2)
		  ManifestData.Value("map") = Self.MapMask
		  ManifestData.Value("uwpCompatibilityMode") = CType(Self.UWPMode, Integer)
		  ManifestData.Value("isConsole") = Self.IsFlagged(Ark.Project.FlagConsoleSafe) // legacy
		  
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
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function ExportContentPack(Pack As Beacon.ContentPack) As String
		  Var Blueprints() As Ark.Blueprint = Ark.DataSource.Pool.Get(False).GetBlueprints("", New Beacon.StringList(Pack.ContentPackId), Nil)
		  If Blueprints.Count = 0 Then
		    Return ""
		  End If
		  
		  Var PackedBlueprints() As Dictionary
		  For Each Blueprint As Ark.Blueprint In Blueprints
		    Var Packed As Dictionary = Blueprint.Pack(False)
		    If (Packed Is Nil) = False Then
		      PackedBlueprints.Add(Packed)
		    End If
		  Next
		  
		  Return Beacon.GenerateJson(PackedBlueprints, False)
		End Function
	#tag EndEvent

	#tag Event
		Function LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
		  Var SetDict As New Dictionary
		  Var ConvertLootScale As Dictionary
		  For Each Entry As DictionaryEntry In PlainData
		    Try
		      Var InternalName As String = Entry.Key
		      Var GroupData As Dictionary = Entry.Value
		      
		      // Convert old names into new ones
		      Select Case InternalName
		      Case "Accounts", "accounts"
		        InternalName = Ark.Configs.NameAccounts
		      Case "BreedingMultipliers"
		        InternalName = Ark.Configs.NameBreedingMultipliers
		      Case "CraftingCosts"
		        InternalName = Ark.Configs.NameCraftingCosts
		      Case "CustomContent"
		        InternalName = Ark.Configs.NameCustomConfig
		      Case "DayCycle"
		        InternalName = Ark.Configs.NameDayCycle
		      Case "Deployments", "deployments"
		        InternalName = Ark.Configs.NameServers
		      Case "Difficulty"
		        InternalName = Ark.Configs.NameDifficulty
		      Case "DinoAdjustments"
		        InternalName = Ark.Configs.NameCreatureAdjustments
		      Case "EngramControl"
		        InternalName = Ark.Configs.NameEngramControl
		      Case "ExperienceCurves"
		        InternalName = Ark.Configs.NameLevelsAndXP
		      Case "HarvestRates"
		        InternalName = Ark.Configs.NameHarvestRates
		      Case "LootDrops"
		        InternalName = Ark.Configs.NameLootDrops
		      Case "Metadata", "metadata"
		        InternalName = Ark.Configs.NameProjectSettings
		      Case "OtherSettings"
		        InternalName = Ark.Configs.NameGeneralSettings
		      Case "SpawnPoints"
		        InternalName = Ark.Configs.NameCreatureSpawns
		      Case "SpoilTimers"
		        InternalName = Ark.Configs.NameDecayAndSpoil
		      Case "StackSizes"
		        InternalName = Ark.Configs.NameStackSizes
		      Case "StatLimits"
		        InternalName = Ark.Configs.NameStatLimits
		      Case "StatMultipliers"
		        InternalName = Ark.Configs.NameStatMultipliers
		      End Select
		      
		      Select Case InternalName
		      Case "LootScale"
		        ConvertLootScale = GroupData
		      Case Ark.Configs.NameProjectSettings
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
		      App.Log("Unable to load config group " + Entry.Key + " from project " + Self.ProjectId + " due to an unhandled " + Err.ClassName + ": " + Err.Message)
		    End Try
		  Next
		  If (ConvertLootScale Is Nil) = False Then
		    Try
		      Var OtherSettings As Ark.Configs.OtherSettings
		      If SetDict.HasKey(Ark.Configs.NameGeneralSettings) Then
		        OtherSettings = SetDict.Value(Ark.Configs.NameGeneralSettings)
		      Else
		        // Don't add it until we know everything worked
		        OtherSettings = Ark.Configs.OtherSettings(Ark.Configs.CreateInstance(Ark.Configs.NameGeneralSettings))
		      End If
		      
		      Var Multiplier As Double = ConvertLootScale.Value("Multiplier")
		      OtherSettings.Value(Ark.DataSource.Pool.Get(False).GetConfigOption(Ark.ConfigFileGame, Ark.HeaderShooterGame, "SupplyCrateLootQualityMultiplier")) = Multiplier
		      
		      If SetDict.HasKey(Ark.Configs.NameGeneralSettings) = False Then
		        SetDict.Value(Ark.Configs.NameGeneralSettings) = OtherSettings
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  Return SetDict
		End Function
	#tag EndEvent

	#tag Event
		Function ProcessEmbeddedContentPack(Pack As Beacon.ContentPack, FileContent As String) As Boolean
		  Var BlueprintDicts() As Variant
		  Try
		    BlueprintDicts = Beacon.ParseJSON(FileContent)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Var FreshBlueprints() As Ark.Blueprint
		  For Each BlueprintDict As Variant In BlueprintDicts
		    If BlueprintDict.Type <> Variant.TypeObject Or (BlueprintDict.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var ProjectBlueprint As Ark.Blueprint = Ark.UnpackBlueprint(Dictionary(BlueprintDict.ObjectValue))
		    If ProjectBlueprint Is Nil Then
		      Continue
		    End If
		    
		    Var StoredBlueprint As Ark.Blueprint = Ark.DataSource.Pool.Get(False).GetBlueprint(ProjectBlueprint.BlueprintId, False)
		    If StoredBlueprint Is Nil Or ProjectBlueprint.LastUpdate > StoredBlueprint.LastUpdate Then
		      FreshBlueprints.Add(ProjectBlueprint)
		    End If
		  Next
		  
		  If FreshBlueprints.Count > 0 Then
		    Self.mEmbeddedBlueprints.Value(Pack.ContentPackId) = FreshBlueprints
		    Self.mHasUnsavedContent = True
		    Return True
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer)
		  #Pragma Unused EncryptedData
		  #Pragma Unused SaveDataVersion
		  #Pragma Unused SavedWithVersion
		  
		  If SaveDataVersion = 2 And PlainData.HasAllKeys("DifficultyValue", "LootSources") Then
		    Var DifficultyValue As Double = PlainData.Value("DifficultyValue")
		    Var LootSources() As Variant = PlainData.Value("LootSources")
		    
		    Var Loot As New Ark.Configs.LootDrops
		    For Each Source As Variant In LootSources
		      Try
		        Var Container As Ark.LootContainer = Ark.LootContainer.FromSaveData(Dictionary(Source))
		        If (Container Is Nil) = False Then
		          Loot.Add(Container, True)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next Source
		    
		    Var ConfigSet As New Dictionary
		    ConfigSet.Value(Ark.Configs.NameDifficulty) = New Ark.Configs.Difficulty(DifficultyValue)
		    ConfigSet.Value(Ark.Configs.NameLootDrops) = Loot
		    
		    Self.ConfigSetData(Beacon.ConfigSet.BaseConfigSet) = ConfigSet
		  End If
		  
		  Self.UWPMode = CType(PlainData.FirstValue("uwpCompatibilityMode", "UWPCompatibilityMode", CType(Self.UWPMode, Integer)).IntegerValue, Ark.Project.UWPCompatibilityModes)
		  
		  Self.MapMask = PlainData.FirstValue("map", "Map", "MapPreference", 1)
		  
		  If PlainData.HasKey("modSelections") Or PlainData.HasKey("ModSelections") Then
		    // Handled by the parent class
		  ElseIf PlainData.HasKey("Mods") Then
		    // In this mode, an empty list meant "all on" and populated list mean "only enable these."
		    
		    Var AllPacks() As Beacon.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks()
		    Var SelectedContentPacks As Beacon.StringList = Beacon.StringList.FromVariant(PlainData.Value("Mods"))
		    Var SelectedPackCount As Integer = CType(SelectedContentPacks.Count, Integer)
		    Var ConsoleMode As Boolean = Self.IsFlagged(Ark.Project.FlagConsoleSafe)
		    For Each Pack As Beacon.ContentPack In AllPacks
		      Self.ContentPackEnabled(Pack.ContentPackId) = (Pack.IsConsoleSafe Or ConsoleMode = False) And (SelectedPackCount = 0 Or SelectedContentPacks.IndexOf(Pack.ContentPackId) > -1)
		    Next
		  ElseIf PlainData.HasKey("ConsoleModsOnly") Then
		    Var ConsolePacksOnly As Boolean = PlainData.Value("ConsoleModsOnly")
		    If ConsolePacksOnly Then
		      Var AllPacks() As Beacon.ContentPack = Ark.DataSource.Pool.Get(False).GetContentPacks()
		      For Each Pack As Beacon.ContentPack In AllPacks
		        Self.ContentPackEnabled(Pack.ContentPackId) = Pack.IsDefaultEnabled And Pack.IsConsoleSafe
		      Next
		      
		      Self.IsFlagged(Ark.Project.FlagConsoleSafe) = True
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
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Beacon.ConfigGroup)
		  If Group IsA Ark.ConfigGroup Then
		    Super.AddConfigGroup(Group, Self.ActiveConfigSet)
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wrong config group subclass for project"
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Beacon.ConfigGroup, Set As Beacon.ConfigSet)
		  If Group IsA Ark.ConfigGroup Then
		    Super.AddConfigGroup(Group, Set)
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wrong config group subclass for project"
		    Raise Err
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
		    For Each Group As Ark.ConfigGroup In Self.ImplementedConfigs(Set)
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
		Sub Constructor()
		  Self.mMapMask = 1 // Play it safe, do not bother calling Ark.Maps here in case database access is fubar
		  Self.mEmbeddedBlueprints = New Dictionary
		  
		  Super.Constructor
		  
		  Self.ContentPackEnabled(Ark.UserContentPackId) = True // Force it
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertDinoReplacementsToSpawnOverrides() As Integer
		  If Self.HasConfigGroup(Ark.Configs.NameCreatureAdjustments) = False Then
		    Return 0
		  End If
		  
		  Var DinoConfig As Ark.Configs.DinoAdjustments = Ark.Configs.DinoAdjustments(Self.ConfigGroup(Ark.Configs.NameCreatureAdjustments))
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
		    Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.Pool.Get(False).GetSpawnPointsForCreature(ReplacedCreature, Self.ContentPacks, Nil)
		    For Each SourceSpawnPoint As Ark.SpawnPoint In SpawnPoints
		      If SourceSpawnPoint.ValidForMask(Self.MapMask) = False Then
		        Continue
		      End If
		      
		      Var SourceOverride As New Ark.MutableSpawnPointOverride(SourceSpawnPoint, Ark.SpawnPointOverride.ModeAppend, True)
		      
		      Var Limit As Double = SourceOverride.Limit(ReplacedCreature)
		      Var NewSets() As Ark.SpawnPointSet
		      For Each Set As Ark.SpawnPointSet In SourceOverride
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
		          SpawnConfig = Ark.Configs.SpawnPoints(Self.ConfigGroup(Ark.Configs.NameCreatureSpawns, True))
		          SpawnConfig.IsImplicit = False
		        End If
		        
		        Var Override As Ark.SpawnPointOverride = SpawnConfig.OverrideForSpawnPoint(SourceSpawnPoint, Ark.SpawnPointOverride.ModeAppend)
		        If Override Is Nil Then
		          Override = SpawnConfig.OverrideForSpawnPoint(SourceSpawnPoint, Ark.SpawnPointOverride.ModeOverride)
		          If Override Is Nil Then
		            Override = New Ark.MutableSpawnPointOverride(SourceSpawnPoint, Ark.SpawnPointOverride.ModeAppend, False)
		          End If
		        End If
		        
		        Var Mutable As Ark.MutableSpawnPointOverride = Override.MutableVersion
		        Mutable.Limit(ReplacementCreature) = Limit
		        For Each Set As Ark.SpawnPointSet In NewSets
		          Mutable.Add(Set)
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
		      
		      If Groups(Idx).InternalName = Ark.Configs.NameCustomConfig Then
		        Organizer.AddManagedKeys(Groups(Idx).ManagedKeys)
		        Organizer.Add(Groups(Idx).GenerateConfigValues(Self, Identity, Profile))
		        Groups.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    // Server custom is prioritized higher than project custom, but lower than guided
		    Var ServerCustom As New Ark.ConfigOrganizer(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, Profile.CustomGUS)
		    Var ServerCustomHeaders() As String = ServerCustom.Headers(Ark.ConfigFileGameUserSettings)
		    Var ServerCustomOptions() As Ark.ConfigOption
		    For Each Header As String In ServerCustomHeaders
		      Var Keys() As String = ServerCustom.Keys(Ark.ConfigFileGameUserSettings, Header)
		      For Each Key As String In Keys
		        ServerCustomOptions.Add(New Ark.ConfigOption(Ark.ConfigFileGameUserSettings, Header, Key))
		        Organizer.Remove(Ark.ConfigFileGameUserSettings, Header, Key)
		      Next
		    Next
		    Organizer.AddManagedKeys(ServerCustomOptions)
		    Organizer.Remove(ServerCustomOptions)
		    Organizer.Add(ServerCustom.FilteredValues, False)
		    
		    For Each Group As Ark.ConfigGroup In Groups
		      If Group Is Nil Then
		        Continue
		      End If
		      
		      Var ManagedKeys() As Ark.ConfigOption = Group.ManagedKeys
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
		  Var Containers() As Ark.LootContainer = Ark.DataSource.Pool.Get(False).GetLootContainers("", Packs, Nil, True)
		  Var Engram As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngram("41ec2dab-ed50-4c67-bb8a-3b253789fa87")
		  Var Mask As UInt64 = Self.MapMask
		  Var LootDrops As New Ark.Configs.LootDrops
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
		    
		    Var Override As New Ark.MutableLootDropOverride(Container, False)
		    Override.MinItemSets = 1
		    Override.MaxItemSets = 1
		    Override.PreventDuplicates = True
		    Override.AddToDefaults = False
		    Override.Add(ItemSet)
		    
		    LootDrops.Add(Override)
		  Next Container
		  
		  Var LootValues() As Ark.ConfigValue = LootDrops.GenerateConfigValues(Self, App.IdentityManager.CurrentIdentity, Profile)
		  For Each LootValue As Ark.ConfigValue In LootValues
		    Values.Add(LootValue)
		  Next
		  
		  Var Craftable() As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngrams("", Packs, New Beacon.TagSpec(Array("blueprintable"), Array("generic")))
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
		    Var Choices() As Ark.Engram = Ark.DataSource.Pool.Get(False).GetEngrams("", Packs, New Beacon.TagSpec(Array("blueprintable"), Array("generic")))
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
		Function DataSource(AllowWriting As Boolean) As Beacon.DataSource
		  Return Ark.DataSource.Pool.Get(AllowWriting)
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
		Function EmbeddedBlueprints(Pack As Beacon.ContentPack) As Ark.Blueprint()
		  Var Blueprints() As Ark.Blueprint
		  If Pack Is Nil Or Self.mEmbeddedBlueprints.HasKey(Pack.ContentPackId) = False Then
		    Return Blueprints
		  End If
		  Return Self.mEmbeddedBlueprints.Value(Pack.ContentPackId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LegacyFlagValues() As JSONItem
		  Var Flags As JSONItem = Super.LegacyFlagValues
		  Flags.Value("allowUcs") = Ark.Project.FlagAllowUCS2
		  Flags.Value("AllowUCS") = Ark.Project.FlagAllowUCS2
		  Flags.Value("isConsole") = Ark.Project.FlagConsoleSafe
		  Flags.Value("IsConsole") = Ark.Project.FlagConsoleSafe
		  Return Flags
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
		Sub ProcessEmbeddedContent()
		  Self.mEmbeddedBlueprints = New Dictionary
		  Super.ProcessEmbeddedContent()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SupportsContentPack(Pack As Beacon.ContentPack) As Boolean
		  Return Pack.IsConsoleSafe Or Self.IsFlagged(Ark.Project.FlagConsoleSafe) = False
		End Function
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
		  Var ExcludedConfigs() As Ark.ConfigGroup
		  For Each Config As Ark.ConfigGroup In Self.ImplementedConfigs()
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


	#tag Property, Flags = &h21
		Private mEmbeddedBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMapMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUWPMode As Ark.Project.UWPCompatibilityModes
	#tag EndProperty


	#tag Constant, Name = FlagAllowUCS2, Type = Double, Dynamic = False, Default = \"4294967296", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagConsoleSafe, Type = Double, Dynamic = False, Default = \"8589934592", Scope = Public
	#tag EndConstant


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
