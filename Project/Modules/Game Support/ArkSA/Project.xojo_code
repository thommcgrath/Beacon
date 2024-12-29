#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused PlainData
		  #Pragma Unused EncryptedData
		  
		  ManifestData.Value("allowUcs") = Self.IsFlagged(ArkSA.Project.FlagAllowUCS2)
		  ManifestData.Value("map") = Self.MapMask
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
		  
		  Var Difficulty As ArkSA.Configs.Difficulty = ArkSA.Configs.Difficulty(Self.ConfigGroup(ArkSA.Configs.NameDifficulty, Beacon.ConfigSet.BaseConfigSet, True))
		  ManifestData.Value("difficulty") = Difficulty.DifficultyValue
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function ExportContentPack(Pack As Beacon.ContentPack) As String
		  Var Blueprints() As ArkSA.Blueprint = ArkSA.DataSource.Pool.Get(False).GetBlueprints("", New Beacon.StringList(Pack.ContentPackId), Nil)
		  If Blueprints.Count = 0 Then
		    Return ""
		  End If
		  
		  Var PackedBlueprints() As Dictionary
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
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
		        InternalName = ArkSA.Configs.NameAccounts
		      Case "BreedingMultipliers"
		        InternalName = ArkSA.Configs.NameBreedingMultipliers
		      Case "CraftingCosts"
		        InternalName = ArkSA.Configs.NameCraftingCosts
		      Case "CustomContent"
		        InternalName = ArkSA.Configs.NameCustomConfig
		      Case "DayCycle"
		        InternalName = ArkSA.Configs.NameDayCycle
		      Case "Deployments", "deployments"
		        InternalName = ArkSA.Configs.NameServers
		      Case "Difficulty"
		        InternalName = ArkSA.Configs.NameDifficulty
		      Case "DinoAdjustments"
		        InternalName = ArkSA.Configs.NameCreatureAdjustments
		      Case "EngramControl"
		        InternalName = ArkSA.Configs.NameEngramControl
		      Case "ExperienceCurves"
		        InternalName = ArkSA.Configs.NameLevelsAndXP
		      Case "HarvestRates"
		        InternalName = ArkSA.Configs.NameHarvestRates
		      Case "LootDrops"
		        InternalName = ArkSA.Configs.NameLootDrops
		      Case "Metadata", "metadata"
		        InternalName = ArkSA.Configs.NameProjectSettings
		      Case "OtherSettings"
		        InternalName = ArkSA.Configs.NameGeneralSettings
		      Case "SpawnPoints"
		        InternalName = ArkSA.Configs.NameCreatureSpawns
		      Case "SpoilTimers"
		        InternalName = ArkSA.Configs.NameDecayAndSpoil
		      Case "StackSizes"
		        InternalName = ArkSA.Configs.NameStackSizes
		      Case "StatLimits"
		        InternalName = ArkSA.Configs.NameStatLimits
		      Case "StatMultipliers"
		        InternalName = ArkSA.Configs.NameStatMultipliers
		      End Select
		      
		      Select Case InternalName
		      Case "LootScale"
		        ConvertLootScale = GroupData
		      Case ArkSA.Configs.NameProjectSettings
		      Else
		        Var EncryptedGroupData As Dictionary
		        If EncryptedData.HasKey(InternalName) Then
		          Try
		            EncryptedGroupData = EncryptedData.Value(InternalName)
		          Catch EncGroupDataErr As RuntimeException
		          End Try
		        End If
		        
		        Var Instance As ArkSA.ConfigGroup = ArkSA.Configs.CreateInstance(InternalName, GroupData, EncryptedGroupData)
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
		      Var OtherSettings As ArkSA.Configs.OtherSettings
		      If SetDict.HasKey(ArkSA.Configs.NameGeneralSettings) Then
		        OtherSettings = SetDict.Value(ArkSA.Configs.NameGeneralSettings)
		      Else
		        // Don't add it until we know everything worked
		        OtherSettings = ArkSA.Configs.OtherSettings(ArkSA.Configs.CreateInstance(ArkSA.Configs.NameGeneralSettings))
		      End If
		      
		      Var Multiplier As Double = ConvertLootScale.Value("Multiplier")
		      OtherSettings.Value(ArkSA.DataSource.Pool.Get(False).GetConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "SupplyCrateLootQualityMultiplier")) = Multiplier
		      
		      If SetDict.HasKey(ArkSA.Configs.NameGeneralSettings) = False Then
		        SetDict.Value(ArkSA.Configs.NameGeneralSettings) = OtherSettings
		      End If
		    Catch Err As RuntimeException
		    End Try
		  End If
		  Return SetDict
		End Function
	#tag EndEvent

	#tag Event
		Function ProcessEmbeddedContentPack(Pack As Beacon.ContentPack, FileContent As String) As Boolean
		  // mEmbeddedBlueprints will have keys of BlueprintId and values of Blueprint for fast access
		  // mEmbeddedBlueprintIds will have keys of ContentPackId and values of BlueprintId() to quickly find blueprints of a given pack
		  
		  Var BlueprintDicts() As Variant
		  Try
		    BlueprintDicts = Beacon.ParseJSON(FileContent)
		  Catch Err As RuntimeException
		    Return False
		  End Try
		  
		  Var BlueprintIds() As String
		  Var DataSource As ArkSA.DataSource
		  For Each BlueprintDict As Variant In BlueprintDicts
		    If BlueprintDict.Type <> Variant.TypeObject Or (BlueprintDict.ObjectValue IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Var ProjectBlueprint As ArkSA.Blueprint = ArkSA.UnpackBlueprint(Dictionary(BlueprintDict.ObjectValue))
		    If ProjectBlueprint Is Nil Then
		      Continue
		    End If
		    
		    Self.mEmbeddedBlueprints.Value(ProjectBlueprint.BlueprintId) = ProjectBlueprint
		    BlueprintIds.Add(ProjectBlueprint.BlueprintId)
		    
		    If Self.mHasUnsavedContent = False Then
		      If DataSource Is Nil Then
		        DataSource = ArkSA.DataSource.Pool.Get(False)
		      End If
		      Self.mHasUnsavedContent = DataSource.GetBlueprint(ProjectBlueprint.BlueprintId, False) Is Nil
		    End If
		  Next
		  Self.mEmbeddedBlueprintIds.Value(Pack.ContentPackId) = BlueprintIds
		  
		  Return BlueprintIds.Count > 0
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
		    
		    Var Loot As New ArkSA.Configs.LootDrops
		    For Each Source As Variant In LootSources
		      Try
		        Var Container As ArkSA.LootContainer = ArkSA.LootContainer.FromSaveData(Dictionary(Source))
		        If (Container Is Nil) = False Then
		          Loot.Add(Container, True)
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next Source
		    
		    Var ConfigSet As New Dictionary
		    ConfigSet.Value(ArkSA.Configs.NameDifficulty) = New ArkSA.Configs.Difficulty(DifficultyValue)
		    ConfigSet.Value(ArkSA.Configs.NameLootDrops) = Loot
		    
		    Self.ConfigSetData(Beacon.ConfigSet.BaseConfigSet) = ConfigSet
		  End If
		  
		  Self.UWPMode = CType(PlainData.FirstValue("uwpCompatibilityMode", "UWPCompatibilityMode", CType(Self.UWPMode, Integer)).IntegerValue, ArkSA.Project.UWPCompatibilityModes)
		  
		  Self.MapMask = PlainData.FirstValue("map", "Map", "MapPreference", 1)
		End Sub
	#tag EndEvent

	#tag Event
		Sub SaveConfigSet(SetDict As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  For Each Entry As DictionaryEntry In SetDict
		    Var Group As ArkSA.ConfigGroup = Entry.Value
		    
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
		  If Group IsA ArkSA.ConfigGroup Then
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
		  If Group IsA ArkSA.ConfigGroup Then
		    Super.AddConfigGroup(Group, Set)
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Wrong config group subclass for project"
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity) As ArkSA.Project
		  Return ArkSA.Project(Super.Clone(Identity))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, Sets() As Beacon.ConfigSet) As ArkSA.ConfigGroup
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Siblings() As ArkSA.ConfigGroup
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    Var SetDict As Dictionary = Self.ConfigSetData(Set)
		    If SetDict Is Nil Or SetDict.HasKey(GroupName) = False Then
		      Continue
		    End If
		    
		    Var Group As ArkSA.ConfigGroup = SetDict.Value(GroupName)
		    Siblings.Add(Group)
		  Next
		  
		  Return ArkSA.Configs.Merge(Siblings, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, States() As Beacon.ConfigSetState) As ArkSA.ConfigGroup
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfig(GroupName, Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(Sets() As Beacon.ConfigSet) As ArkSA.ConfigGroup()
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Instances As New Dictionary
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    For Each Group As ArkSA.ConfigGroup In Self.ImplementedConfigs(Set)
		      Var Siblings() As ArkSA.ConfigGroup
		      If Instances.HasKey(Group.InternalName) Then
		        Siblings = Instances.Value(Group.InternalName)
		      End If
		      Siblings.Add(Group)
		      Instances.Value(Group.InternalName) = Siblings
		    Next
		  Next
		  
		  Var Combined() As ArkSA.ConfigGroup
		  For Each Entry As DictionaryEntry In Instances
		    Var Siblings() As ArkSA.ConfigGroup = Entry.Value
		    Var Merged As ArkSA.ConfigGroup = ArkSA.Configs.Merge(Siblings, False)
		    If (Merged Is Nil) = False Then
		      Combined.Add(Merged)
		    End If
		  Next Entry
		  Return Combined
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(States() As Beacon.ConfigSetState) As ArkSA.ConfigGroup()
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfigs(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Set As Beacon.ConfigSet, Create As Boolean = False) As ArkSA.ConfigGroup
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    Return SetDict.Value(InternalName)
		  End If
		  
		  If Create Then
		    Var Group As ArkSA.ConfigGroup = ArkSA.Configs.CreateInstance(InternalName)
		    If (Group Is Nil) = False Then
		      Group.IsImplicit = True
		      Self.AddConfigGroup(Group, Set)
		    End If
		    Return Group
		  ElseIf Set.IsBase = False And InternalName = ArkSA.Configs.NameDifficulty Then
		    // Create is false, we're not in the base config set, and we're looking for difficulty.
		    // Return a *clone* of the base difficulty, but don't add it to the config set.
		    Var BaseDifficulty As ArkSA.ConfigGroup = Self.ConfigGroup(ArkSA.Configs.NameDifficulty, Beacon.ConfigSet.BaseConfigSet, False)
		    Var Clone As ArkSA.ConfigGroup
		    If BaseDifficulty Is Nil Then
		      // Should never happen, but just in case
		      Clone = New ArkSA.Configs.Difficulty
		      Clone.IsImplicit = True
		    Else
		      Clone = ArkSA.Configs.CloneInstance(BaseDifficulty)
		      Clone.IsImplicit = BaseDifficulty.IsImplicit
		    End If
		    Return Clone
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Create As Boolean = False) As ArkSA.ConfigGroup
		  Return Self.ConfigGroup(InternalName, Self.ActiveConfigSet, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMapMask = 1 // Play it safe, do not bother calling ArkSA.Maps here in case database access is fubar
		  Self.mEmbeddedBlueprints = New Dictionary
		  Self.mEmbeddedBlueprintIds = New Dictionary
		  Super.Constructor
		  Self.mBlueprintContainer = New ArkSA.BlueprintContainer(Self.ProjectId, Self.mEmbeddedBlueprints)
		  
		  Self.ContentPackEnabled(ArkSA.UserContentPackId) = True // Force it
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConvertDinoReplacementsToSpawnOverrides() As Integer
		  If Self.HasConfigGroup(ArkSA.Configs.NameCreatureAdjustments) = False Then
		    Return 0
		  End If
		  
		  Var DinoConfig As ArkSA.Configs.DinoAdjustments = ArkSA.Configs.DinoAdjustments(Self.ConfigGroup(ArkSA.Configs.NameCreatureAdjustments))
		  If DinoConfig = Nil Then
		    Return 0
		  End If
		  
		  Var SpawnConfig As ArkSA.Configs.SpawnPoints // Don't create it yet
		  
		  Var CountChanges As Integer
		  Var Behaviors() As ArkSA.CreatureBehavior = DinoConfig.Behaviors
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    Var ReplacedCreature As ArkSA.Creature = Behavior.TargetCreature
		    Var ReplacementCreature As ArkSA.Creature = Behavior.ReplacementCreature
		    If ReplacementCreature = Nil Then
		      Continue
		    End If
		    
		    Var ConfigUpdated As Boolean
		    Var SpawnPoints() As ArkSA.SpawnPoint = ArkSA.DataSource.Pool.Get(False).GetSpawnPointsForCreature(ReplacedCreature, Self.ContentPacks, Nil)
		    For Each SourceSpawnPoint As ArkSA.SpawnPoint In SpawnPoints
		      If SourceSpawnPoint.ValidForMask(Self.MapMask) = False Then
		        Continue
		      End If
		      
		      Var SourceOverride As New ArkSA.MutableSpawnPointOverride(SourceSpawnPoint, ArkSA.SpawnPointOverride.ModeAppend, True)
		      
		      Var Limit As Double = SourceOverride.Limit(ReplacedCreature)
		      Var NewSets() As ArkSA.SpawnPointSet
		      For Each Set As ArkSA.SpawnPointSet In SourceOverride
		        Var NewSet As ArkSA.MutableSpawnPointSet
		        For Each Entry As ArkSA.SpawnPointSetEntry In Set
		          If Entry.Creature <> ReplacedCreature Then
		            Continue
		          End If
		          
		          If NewSet Is Nil Then
		            NewSet = New ArkSA.MutableSpawnPointSet(Set)
		            NewSet.Label = ReplacementCreature.Label + " (Converted)"
		            NewSet.RemoveAll()
		            NewSet.SetId = Beacon.UUID.v4
		          End If
		          
		          Var NewEntry As New ArkSA.MutableSpawnPointSetEntry(Entry)
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
		          SpawnConfig = ArkSA.Configs.SpawnPoints(Self.ConfigGroup(ArkSA.Configs.NameCreatureSpawns, True))
		          SpawnConfig.IsImplicit = False
		        End If
		        
		        Var Override As ArkSA.SpawnPointOverride = SpawnConfig.OverrideForSpawnPoint(SourceSpawnPoint, ArkSA.SpawnPointOverride.ModeAppend)
		        If Override Is Nil Then
		          Override = SpawnConfig.OverrideForSpawnPoint(SourceSpawnPoint, ArkSA.SpawnPointOverride.ModeOverride)
		          If Override Is Nil Then
		            Override = New ArkSA.MutableSpawnPointOverride(SourceSpawnPoint, ArkSA.SpawnPointOverride.ModeAppend, False)
		          End If
		        End If
		        
		        Var Mutable As ArkSA.MutableSpawnPointOverride = Override.MutableVersion
		        Mutable.Limit(ReplacementCreature) = Limit
		        For Each Set As ArkSA.SpawnPointSet In NewSets
		          Mutable.Add(Set)
		        Next
		        
		        SpawnConfig.Add(Mutable)
		        ConfigUpdated = True
		      End If
		    Next
		    
		    If ConfigUpdated Then
		      CountChanges = CountChanges + 1
		      
		      Var NewBehavior As New ArkSA.MutableCreatureBehavior(Behavior)
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
		Function CreateConfigOrganizer(Identity As Beacon.Identity, Profile As ArkSA.ServerProfile) As ArkSA.ConfigOrganizer
		  Try
		    If Identity.IsBanned Then
		      Return Self.CreateTrollConfigOrganizer(Profile)
		    End If
		    
		    Var Organizer As New ArkSA.ConfigOrganizer
		    Var Groups() As ArkSA.ConfigGroup = Self.CombinedConfigs(Profile.ConfigSetStates)
		    
		    // Add custom content first so it can be overridden or removed later
		    For Idx As Integer = 0 To Groups.LastIndex
		      If Groups(Idx) Is Nil Then
		        Continue
		      End If
		      
		      If Groups(Idx).InternalName = ArkSA.Configs.NameCustomConfig Then
		        Organizer.AddManagedKeys(Groups(Idx).ManagedKeys)
		        Organizer.Add(Groups(Idx).GenerateConfigValues(Self, Identity, Profile))
		        Groups.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    For Each Group As ArkSA.ConfigGroup In Groups
		      If Group Is Nil Then
		        Continue
		      End If
		      
		      Var ManagedKeys() As ArkSA.ConfigOption = Group.ManagedKeys
		      Organizer.AddManagedKeys(ManagedKeys)
		      Organizer.Remove(ManagedKeys) // Removes overlapping values found in custom config
		      Organizer.Add(Group.GenerateConfigValues(Self, Identity, Profile))
		    Next
		    
		    Organizer.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderSessionSettings, "SessionName=" + Profile.Name))
		    Organizer.Remove(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "bUseSingleplayerSettings")
		    Organizer.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "bUseSingleplayerSettings=" + If(Self.IsFlagged(ArkSA.Project.FlagSinglePlayer), "True", "False")))
		    
		    If (Profile.MessageOfTheDay Is Nil) = False And Profile.MessageOfTheDay.IsEmpty = False Then
		      Organizer.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay", "Message=" + Profile.MessageOfTheDay.ArkMLValue))
		      Organizer.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay", "Duration=" + Profile.MessageDuration.ToString))
		    End If
		    
		    If (Profile.AdminPassword Is Nil) = False Then
		      Organizer.Add(New ArkSA.ConfigValue("CommandLineOption", "?", "ServerAdminPassword=" + Profile.AdminPassword.StringValue))
		    End If
		    If (Profile.SpectatorPassword Is Nil) = False Then
		      Organizer.Add(New ArkSA.ConfigValue("CommandLineOption", "?", "SpectatorPassword=" + Profile.SpectatorPassword.StringValue))
		    End If
		    If (Profile.ServerPassword Is Nil) = False Then
		      Organizer.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "ServerPassword=" + Profile.ServerPassword.StringValue))
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
		Function CreateTrollConfigOrganizer(Profile As ArkSA.ServerProfile) As ArkSA.ConfigOrganizer
		  Var Values As New ArkSA.ConfigOrganizer
		  Var Providers() As ArkSA.BlueprintProvider = ArkSA.ActiveBlueprintProviders
		  
		  If (Profile Is Nil) = False Then
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "SessionSettings", "SessionName=" + Profile.Name))
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
		  
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay", "Message=" + Messages(Index)))
		  
		  If Index = 9 Then
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "ServerAdminPassword=peanuts"))
		  ElseIf Index = 10 Then
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "PlayerResistanceMultiplier=9999"))
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "MaxFallSpeedMultiplier=0.01"))
		  ElseIf Index = 11 Then
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "DinoCountMultiplier=0"))
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "DinoResistanceMultiplier=9999"))
		  ElseIf Index = 12 Then
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "DayCycleSpeedScale=300"))
		  End If
		  
		  If Index = 7 Then
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay", "Duration=360"))
		  Else
		    Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, "MessageOfTheDay", "Duration=30"))
		  End If
		  
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PlayerHarvestingDamageMultiplier=0.000001"))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoHarvestingDamageMultiplier=0.0000001"))
		  
		  Var Packs As Beacon.StringList = Self.ContentPacks
		  Var Containers() As ArkSA.LootContainer = Providers.GetLootContainers("", Packs, Nil, True)
		  Var Engram As ArkSA.Engram = Providers(0).GetEngram("f25b4d0e-2a1c-57c0-b54c-99d9083b2ca0")
		  Var Mask As UInt64 = Self.MapMask
		  Var LootDrops As New ArkSA.Configs.LootDrops
		  For Each Container As ArkSA.LootContainer In Containers
		    If Container.ValidForMask(Mask) = False Then
		      Continue For Container
		    End If
		    
		    Var Entry As New ArkSA.MutableLootItemSetEntry
		    Entry.Add(New ArkSA.LootItemSetEntryOption(Engram, 1.0))
		    Entry.MinQuantity = 300
		    Entry.MaxQuantity = 300
		    Entry.MinQuality = ArkSA.Qualities.Tier1
		    Entry.MaxQuality = ArkSA.Qualities.Tier1
		    Entry.ChanceToBeBlueprint = 0
		    Entry.SingleItemQuantity = True
		    
		    Var ItemSet As New ArkSA.MutableLootItemSet
		    ItemSet.Label = "Turds"
		    ItemSet.MinNumItems = 1
		    ItemSet.MaxNumItems = 1
		    ItemSet.Add(Entry)
		    
		    Var Override As New ArkSA.MutableLootDropOverride(Container, False)
		    Override.MinItemSets = 1
		    Override.MaxItemSets = 1
		    Override.PreventDuplicates = True
		    Override.AddToDefaults = False
		    Override.Add(ItemSet)
		    
		    LootDrops.Add(Override)
		  Next
		  
		  Var LootValues() As ArkSA.ConfigValue = LootDrops.GenerateConfigValues(Self, App.IdentityManager.CurrentIdentity, Profile)
		  For Each LootValue As ArkSA.ConfigValue In LootValues
		    Values.Add(LootValue)
		  Next
		  
		  Var Craftable() As ArkSA.Engram = Providers.GetEngrams("", Packs, New Beacon.TagSpec(Array("blueprintable"), Array("generic")))
		  Var CoinFlip As Integer = Rand.InRange(0, 1)
		  If CoinFlip = 0 Then
		    // Turdcraft
		    For Each CraftableEngram As ArkSA.Engram In Craftable
		      Var Cost As New ArkSA.MutableCraftingCost(CraftableEngram)
		      Cost.Add(Engram, 300.0, False)
		      Values.Add(ArkSA.Configs.CraftingCosts.ConfigValueForCraftingCost(Cost))
		    Next CraftableEngram
		  Else
		    // Randomcraft
		    Var Choices() As ArkSA.Engram = Providers.GetEngrams("", Packs, New Beacon.TagSpec(Array("blueprintable"), Array("generic")))
		    For Each CraftableEngram As ArkSA.Engram In Craftable
		      Var Idx As Integer = Rand.InRange(Choices.FirstIndex, Choices.LastIndex)
		      
		      Var Cost As New ArkSA.MutableCraftingCost(CraftableEngram)
		      Cost.Add(Choices(Idx), 1, False)
		      Choices.RemoveAt(Idx)
		      
		      Values.Add(ArkSA.Configs.CraftingCosts.ConfigValueForCraftingCost(Cost))
		    Next CraftableEngram
		  End If
		  
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSource(AllowWriting As Boolean) As Beacon.DataSource
		  Return ArkSA.DataSource.Pool.Get(AllowWriting)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Difficulty() As ArkSA.Configs.Difficulty
		  Var Group As ArkSA.ConfigGroup = Self.ConfigGroup(ArkSA.Configs.NameDifficulty, Self.ActiveConfigSet.IsBase)
		  If Group Is Nil Then
		    Return Nil
		  End If
		  Return ArkSA.Configs.Difficulty(Group)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EmbeddedBlueprints(Pack As Beacon.ContentPack, UnsavedOnly As Boolean) As ArkSA.Blueprint()
		  Var Blueprints() As ArkSA.Blueprint
		  If Pack Is Nil Or Self.mEmbeddedBlueprintIds.HasKey(Pack.ContentPackId) = False Then
		    Return Blueprints
		  End If
		  
		  Var SkipBlueprints As New Dictionary
		  If UnsavedOnly Then
		    Var DataSource As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		    Var Categories() As String = ArkSA.Categories
		    Var Packs As New Beacon.StringList(Pack.ContentPackId)
		    For Each Category As String In Categories
		      Var SavedBlueprints() As ArkSA.Blueprint = DataSource.GetBlueprints(Category, "", Packs, Nil)
		      For Each Blueprint As ArkSA.Blueprint In SavedBlueprints
		        SkipBlueprints.Value(Blueprint.BlueprintId) = True
		      Next
		    Next
		  End If
		  
		  Var BlueprintIds() As String = Self.mEmbeddedBlueprintIds.Value(Pack.ContentPackId)
		  For Each BlueprintId As String In BlueprintIds
		    Try
		      Var ProjectBlueprint As ArkSA.Blueprint = Self.mEmbeddedBlueprints.Value(BlueprintId)
		      If ProjectBlueprint Is Nil Or SkipBlueprints.HasKey(ProjectBlueprint.BlueprintId) Then
		        Continue
		      End If
		      
		      Blueprints.Add(ProjectBlueprint)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Return Blueprints
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flags(Assigns Value As UInt64)
		  // Fire a notification if single player status changes
		  Var WasSinglePlayer As Boolean = Self.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		  Super.Flags = Value
		  Var IsSinglePlayer As Boolean = Self.IsFlagged(ArkSA.Project.FlagSinglePlayer)
		  If IsSinglePlayer <> WasSinglePlayer Then
		    Var UserData As New Dictionary
		    UserData.Value("ProjectId") = Self.ProjectId
		    UserData.Value("NewValue") = IsSinglePlayer
		    NotificationKit.Post(Self.Notification_SinglePlayerChanged, UserData)
		    
		    // Find all the matching settings in all the config sets
		    Var Option As ArkSA.ConfigOption = ArkSA.DataSource.Pool.Get(False).GetConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "bUseSingleplayerSettings")
		    Var Sets() As Beacon.ConfigSet = Self.ConfigSets
		    For Each Set As Beacon.ConfigSet In Sets
		      Var Group As Beacon.ConfigGroup = Self.ConfigGroup(ArkSA.Configs.NameGeneralSettings, Set, False)
		      If (Group Is Nil) = False And Group IsA ArkSA.Configs.OtherSettings Then
		        Var GeneralSettings As ArkSA.Configs.OtherSettings = ArkSA.Configs.OtherSettings(Group)
		        If GeneralSettings.Value(Option).IsNull = False Then
		          GeneralSettings.Value(Option) = IsSinglePlayer
		        End If
		      End If
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ForcedContentPacks() As Beacon.StringList
		  Var Mods As Beacon.StringList = Super.ForcedContentPacks()
		  If Mods Is Nil Then
		    Mods = New Beacon.StringList
		  End If
		  
		  Var Maps() As Beacon.Map = ArkSA.Maps.ForMask(Self.mMapMask)
		  For Each Map As Beacon.Map In Maps
		    Mods.Append(Map.ContentPackId)
		  Next
		  
		  Return Mods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return ArkSA.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LegacyFlagValues() As JSONItem
		  Var Flags As JSONItem = Super.LegacyFlagValues
		  Flags.Value("allowUcs") = Ark.Project.FlagAllowUCS2
		  Flags.Value("AllowUCS") = Ark.Project.FlagAllowUCS2
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
		Function Maps() As ArkSA.Map()
		  Return ArkSA.Maps.ForMask(Self.mMapMask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Maps(Assigns MapList() As ArkSA.Map)
		  Var Value As UInt64 = 0
		  For Each Map As ArkSA.Map In MapList
		    Value = Value Or Map.Mask
		  Next Map
		  Self.MapMask = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As ArkSA.BlueprintProvider
		  Return Self.mBlueprintContainer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessEmbeddedContent()
		  Self.mEmbeddedBlueprints.RemoveAll
		  Self.mEmbeddedBlueprintIds.RemoveAll
		  Super.ProcessEmbeddedContent()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMap(Map As ArkSA.Map) As Boolean
		  Return (Self.MapMask And Map.Mask) = Map.Mask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SupportsMap(Map As ArkSA.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.MapMask = Self.MapMask Or Map.Mask
		  Else
		    Self.MapMask = Self.MapMask And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesOmniFeaturesWithoutOmni(Identity As Beacon.Identity) As ArkSA.ConfigGroup()
		  Var ExcludedConfigs() As ArkSA.ConfigGroup
		  For Each Config As ArkSA.ConfigGroup In Self.ImplementedConfigs()
		    If ArkSA.Configs.ConfigUnlocked(Config, Identity) = False Then
		      ExcludedConfigs.Add(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UWPMode() As ArkSA.Project.UWPCompatibilityModes
		  Return Self.mUWPMode
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UWPMode(Assigns Value As ArkSA.Project.UWPCompatibilityModes)
		  If Self.mUWPMode <> Value Then
		    Self.mUWPMode = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprintContainer As ArkSA.BlueprintContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEmbeddedBlueprintIds As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEmbeddedBlueprints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMapMask As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mUWPMode As ArkSA.Project.UWPCompatibilityModes
	#tag EndProperty


	#tag Constant, Name = FlagAllowUCS2, Type = Double, Dynamic = False, Default = \"4294967296", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagSinglePlayer, Type = Double, Dynamic = False, Default = \"8589934592", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Notification_SinglePlayerChanged, Type = String, Dynamic = False, Default = \"ArkSA.Project.SinglePlayerChanged", Scope = Public
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
