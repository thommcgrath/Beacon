#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag Event
		Sub AddingProfile(Profile As Beacon.ServerProfile)
		  If Profile.IsConsole Then
		    Self.ConsoleSafe = True
		    
		    For Each Entry As DictionaryEntry In Self.mContentPacks
		      Var Pack As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPackWithUUID(Entry.Key.StringValue)
		      If (Pack Is Nil Or Pack.ConsoleSafe = False) And Self.mContentPacks.Value(Entry.Key).BooleanValue = True Then
		        Self.mContentPacks.Value(Entry.Key) = False
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub AddSaveData(PlainData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  PlainData.Value("AllowUCS") = Self.AllowUCS2
		  PlainData.Value("IsConsole") = Self.ConsoleSafe
		  PlainData.Value("Map") = Self.MapMask
		  PlainData.Value("ModSelections") = Self.mContentPacks
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
		      OtherSettings.Value(Ark.DataSource.SharedInstance.GetConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "SupplyCrateLootQualityMultiplier")) = Multiplier
		      
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
		Function ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer, ByRef FailureReason As String) As Boolean
		  #Pragma Unused EncryptedData
		  #Pragma Unused SaveDataVersion
		  #Pragma Unused SavedWithVersion
		  #Pragma Unused FailureReason
		  
		  Self.AllowUCS2 = PlainData.Lookup("AllowUCS", Self.AllowUCS2).BooleanValue
		  Self.ConsoleSafe = PlainData.Lookup("IsConsole", Self.ConsoleSafe).BooleanValue
		  
		  If PlainData.HasKey("Map") Then
		    Self.MapMask = PlainData.Value("Map")
		  ElseIf PlainData.HasKey("MapPreference") Then
		    Self.MapMask = PlainData.Value("MapPreference")
		  End If
		  
		  If PlainData.HasKey("ModSelections") Then
		    // Newest mod, keys are uuids and values are boolean
		    Var AllPacks() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks()
		    Var Selections As Dictionary = PlainData.Value("ModSelections")
		    Var ConsoleMode As Boolean = Self.ConsoleSafe
		    For Each Pack As Ark.ContentPack In AllPacks
		      If Selections.HasKey(Pack.UUID) = False Then
		        Selections.Value(Pack.UUID) = Pack.DefaultEnabled And (Pack.ConsoleSafe Or ConsoleMode = False)
		      End If
		    Next
		    
		    Self.mContentPacks = Selections
		  ElseIf PlainData.HasKey("Mods") Then
		    // In this mode, an empty list meant "all on" and populated list mean "only enable these."
		    
		    Var AllPacks() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks()
		    Var SelectedContentPacks As Beacon.StringList = Beacon.StringList.FromVariant(PlainData.Value("Mods"))
		    Var SelectedPackCount As Integer = CType(SelectedContentPacks.Count, Integer)
		    Var ConsoleMode As Boolean = Self.ConsoleSafe
		    Var Selections As New Dictionary
		    For Each Pack As Ark.ContentPack In AllPacks
		      Selections.Value(Pack.UUID) = (Pack.ConsoleSafe Or ConsoleMode = False) And (SelectedPackCount = 0 Or SelectedContentPacks.IndexOf(Pack.UUID) > -1)
		    Next
		    
		    Self.mContentPacks = Selections
		  ElseIf PlainData.HasKey("ConsoleModsOnly") Then
		    Var ConsolePacksOnly As Boolean = PlainData.Value("ConsoleModsOnly")
		    If ConsolePacksOnly Then
		      Var Selections As New Dictionary
		      Var AllPacks() As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPacks()
		      For Each Pack As Ark.ContentPack In AllPacks
		        Selections.Value(Pack.UUID) = Pack.DefaultEnabled And Pack.ConsoleSafe
		      Next
		      
		      Self.ConsoleSafe = True
		      Self.mContentPacks = Selections
		    End If
		  End If
		  
		  Return True
		End Function
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
		  
		  Var SetNames() As String = Self.ConfigSetNames()
		  For Each SetName As String In SetNames
		    Var Configs() As Ark.ConfigGroup = Self.ImplementedConfigs(SetName)
		    For Each Config As Ark.ConfigGroup In Configs
		      Config.Validate(SetName, Issues, Self)
		    Next Config
		  Next SetName
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Ark.ConfigGroup)
		  Self.AddConfigGroup(Group, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Ark.ConfigGroup, SetName As String)
		  Var SetDict As Dictionary = Self.ConfigSet(SetName)
		  If SetDict Is Nil Then
		    SetDict = New Dictionary
		  End If
		  SetDict.Value(Group.InternalName) = Group
		  Self.ConfigSet(SetName) = SetDict
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
		Function CombinedConfigs(States() As Beacon.ConfigSetState) As Ark.ConfigGroup()
		  Var Names() As String
		  If States Is Nil Then
		    Names.Add(Self.BaseConfigSetName)
		  Else
		    For Each State As Beacon.ConfigSetState In States
		      If State.Enabled Then
		        Names.Add(State.Name)
		      End If
		    Next
		  End If
		  Return Self.CombinedConfigs(Names)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(SetNames() As String) As Ark.ConfigGroup()
		  If SetNames Is Nil Then
		    SetNames = Array(Self.BaseConfigSetName)
		  ElseIf SetNames.Count = 0 Then
		    SetNames.Add(Self.BaseConfigSetName)
		  End If
		  
		  Var Instances As New Dictionary
		  For Idx As Integer = 0 To SetNames.LastIndex
		    Var SetName As String = SetNames(Idx)
		    Var Groups() As Ark.ConfigGroup = Self.ImplementedConfigs(SetName)
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
		Function ConfigGroup(InternalName As String, Create As Boolean = False) As Ark.ConfigGroup
		  Return Self.ConfigGroup(InternalName, Self.ActiveConfigSet, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, SetName As String, Create As Boolean = False) As Ark.ConfigGroup
		  Var SetDict As Dictionary = Self.ConfigSet(SetName)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    Return SetDict.Value(InternalName)
		  End If
		  
		  If Create Then
		    Var Group As Ark.ConfigGroup = Ark.Configs.CreateInstance(InternalName)
		    If (Group Is Nil) = False Then
		      Group.IsImplicit = True
		      Self.AddConfigGroup(Group, InternalName)
		    End If
		    Return Group
		  ElseIf SetName <> BaseConfigSetName And InternalName = Ark.Configs.NameDifficulty Then
		    // Create is false, we're not in the base config set, and we're looking for difficulty.
		    // Return a *clone* of the base difficulty, but don't add it to the config set.
		    Var BaseDifficulty As Ark.ConfigGroup = Self.ConfigGroup(Ark.Configs.NameDifficulty, BaseConfigSetName, False)
		    Var Clone As Ark.ConfigGroup
		    If BaseDifficulty Is Nil Then
		      // Should never happen, but just in case
		      Clone = New Ark.Configs.Difficulty
		    Else
		      Clone = Ark.Configs.CloneInstance(BaseDifficulty)
		    End If
		    Clone.IsImplicit = BaseDifficulty.IsImplicit
		    Return Clone
		  End If
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
		  Var DataSource As Ark.DataSource = Ark.DataSource.SharedInstance(Ark.DataSource.FlagFallbackToMainThread)
		  If (DataSource Is Nil) = False Then
		    Var Packs() As Ark.ContentPack = DataSource.GetContentPacks
		    For Idx As Integer = 0 To Packs.LastIndex
		      Self.mContentPacks.Value(Packs(Idx).UUID) = Packs(Idx).DefaultEnabled
		    Next Idx
		  End If
		  If Self.mContentPacks.HasKey(Ark.UserContentPackUUID) Then
		    Self.mContentPacks.Value(Ark.UserContentPackUUID) = True // Force this, if it exists
		  End If
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(Pack As Ark.ContentPack) As Boolean
		  Return Self.ContentPackEnabled(Pack.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(Pack As Ark.ContentPack, Assigns Value As Boolean)
		  Self.ContentPackEnabled(Pack.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackEnabled(UUID As String) As Boolean
		  Return Self.mContentPacks.Lookup(UUID, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackEnabled(UUID As String, Assigns Value As Boolean)
		  If v4UUID.IsValid(UUID) = False Then
		    Return
		  End If
		  
		  If Self.mContentPacks.HasKey(UUID) = False Or Self.mContentPacks.Value(UUID).BooleanValue <> Value Then
		    Self.mContentPacks.Value(UUID) = Value
		    Self.Modified = True
		  End If
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
		    Var SpawnPoints() As Ark.SpawnPoint = Ark.DataSource.SharedInstance.GetSpawnPointsForCreature(ReplacedCreature, Self.ContentPacks, "")
		    For Each SourceSpawnPoint As Ark.SpawnPoint In SpawnPoints
		      If SourceSpawnPoint.ValidForMask(Self.MapMask) = False Then
		        Continue
		      End If
		      
		      Var SpawnPoint As Ark.MutableSpawnPoint = SourceSpawnPoint.MutableClone
		      Ark.DataSource.SharedInstance.LoadDefaults(SpawnPoint)
		      
		      Var Limit As Double = SpawnPoint.Limit(ReplacedCreature)
		      Var NewSets() As Ark.SpawnPointSet
		      For Each Set As Ark.SpawnPointSet In SpawnPoint
		        Var NewSet As Ark.MutableSpawnPointSet
		        For Each Entry As Ark.SpawnPointSetEntry In Set
		          If Entry.Creature = ReplacedCreature Then
		            If NewSet = Nil Then
		              NewSet = New Ark.MutableSpawnPointSet()
		              NewSet.Weight = Set.Weight
		              NewSet.Label = ReplacementCreature.Label + " (Converted)"
		              If IsNull(Set.SpreadRadius) Then
		                NewSet.SpreadRadius = 650
		              Else
		                NewSet.SpreadRadius = Set.SpreadRadius
		              End If
		            End If
		            
		            Const SpreadMultiplierHigh = 1.046153846
		            Const SpreadMultiplierLow = 0.523076923
		            
		            Var NewEntry As Ark.MutableSpawnPointSetEntry
		            
		            NewEntry = New Ark.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.7
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Ark.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 1.0
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierHigh), 0.0)
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Ark.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.2
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierLow), 0.0)
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Ark.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.25
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierLow) * -1, 0.0)
		            NewSet.Append(NewEntry)
		            
		            NewEntry = New Ark.MutableSpawnPointSetEntry(ReplacementCreature)
		            NewEntry.SpawnChance = 0.6
		            NewEntry.Offset = New Beacon.Point3D(0.0, Round(NewSet.SpreadRadius * SpreadMultiplierHigh) * -1, 0.0)
		            NewSet.Append(NewEntry)
		          End If
		        Next
		        If (NewSet Is Nil) = False Then
		          NewSets.Add(NewSet)
		        End If
		      Next
		      
		      If NewSets.Count > 0 Then
		        If SpawnConfig Is Nil Then
		          SpawnConfig = Ark.Configs.SpawnPoints(Self.ConfigGroup(Ark.Configs.NameSpawnPoints, True))
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
		  Var Containers() As Ark.LootContainer = Ark.DataSource.SharedInstance.GetLootContainers("", Packs, "", True)
		  Var Engram As Ark.Engram = Ark.DataSource.SharedInstance.GetEngramByUUID("41ec2dab-ed50-4c67-bb8a-3b253789fa87")
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
		  
		  Var Craftable() As Ark.Engram = Ark.DataSource.SharedInstance.GetEngrams("", Packs, "{""required"":[""blueprintable""],""excluded"":[""generic""]}")
		  For Each CraftableEngram As Ark.Engram In Craftable
		    Var Cost As New Ark.MutableCraftingCost(CraftableEngram)
		    Cost.Add(Engram, 300.0, False)
		    Values.Add(Ark.Configs.CraftingCosts.ConfigValueForCraftingCost(Cost))
		  Next CraftableEngram
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Difficulty() As Ark.Configs.Difficulty
		  Var Group As Ark.ConfigGroup = Self.ConfigGroup(Ark.Configs.NameDifficulty, Self.ActiveConfigSet = Self.BaseConfigSetName)
		  If Group Is Nil Then
		    Return Nil
		  End If
		  Return Ark.Configs.Difficulty(Group)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameID() As String
		  Return Ark.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(InternalName As String) As Boolean
		  Return Self.HasConfigGroup(InternalName, Self.ActiveConfigSet)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigGroup(InternalName As String, SetName As String) As Boolean
		  Var SetDict As Dictionary = Self.ConfigSet(SetName)
		  If (SetDict Is Nil) = False Then
		    Return SetDict.HasKey(InternalName)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs() As Ark.ConfigGroup()
		  Var Names() As String = Self.ConfigSetNames
		  Var Groups() As Ark.ConfigGroup
		  For Each SetName As String In Names
		    Var SetGroups() As Ark.ConfigGroup = Self.ImplementedConfigs(SetName)
		    For Each Group As Ark.ConfigGroup In SetGroups
		      Groups.Add(Group)
		    Next
		  Next
		  Return Groups
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs(SetName As String) As Ark.ConfigGroup()
		  Var SetDict As Dictionary = Self.ConfigSet(SetName)
		  Var Groups() As Ark.ConfigGroup
		  If (SetDict Is Nil) = False Then
		    For Each Entry As DictionaryEntry In SetDict
		      Var Group As Ark.ConfigGroup = Entry.Value
		      If Group.IsImplicit = False Or SetName = Self.BaseConfigSetName Then
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
		  
		  Var ConfigSetNames() As String = Self.ConfigSetNames
		  For Each ConfigSetName As String In ConfigSetNames
		    Var SetDict As Dictionary = Self.ConfigSet(ConfigSetName)
		    If SetDict Is Nil Then
		      Continue
		    End If
		    For Each GroupEntry As DictionaryEntry In SetDict
		      Var Group As Ark.ConfigGroup = GroupEntry.Value
		      If Group.Modified Then
		        Return True
		      End If
		    Next GroupEntry
		  Next ConfigSetName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Value = False Then
		    Var ConfigSetNames() As String = Self.ConfigSetNames
		    For Each ConfigSetName As String In ConfigSetNames
		      Var SetDict As Dictionary = Self.ConfigSet(ConfigSetName)
		      If SetDict Is Nil Then
		        Continue
		      End If
		      For Each GroupEntry As DictionaryEntry In SetDict
		        Var Group As Ark.ConfigGroup = GroupEntry.Value
		        Group.Modified = False
		      Next GroupEntry
		    Next ConfigSetName
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
		Sub RemoveConfigGroup(Group As Ark.ConfigGroup, SetName As String)
		  If Group Is Nil Then
		    Return
		  End If
		  
		  Self.RemoveConfigGroup(Group.InternalName, SetName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(InternalName As String)
		  Self.RemoveConfigGroup(InternalName, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(InternalName As String, SetName As String)
		  Var SetDict As Dictionary = Self.ConfigSet(SetName)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    Self.ConfigSet(SetName) = SetDict
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
