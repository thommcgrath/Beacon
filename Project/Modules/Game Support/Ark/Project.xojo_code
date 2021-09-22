#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag Event
		Sub AddSaveData(PlainData As Dictionary, EncryptedData As Dictionary)
		  PlainData.Value("AllowUCS") = Self.AllowUCS2
		  PlainData.Value("IsConsole") = Self.ConsoleSafe
		  PlainData.Value("Map") = Self.MapMask
		  PlainData.Value("ModSelections") = Self.mContentPacks
		  
		  Var Profiles() As Dictionary
		  For Each Profile As Ark.ServerProfile In Self.mServerProfiles
		    Profiles.Add(Profile.SaveData)
		  Next
		  EncryptedData.Value("Servers") = Profiles
		  
		  Var Sets As New Dictionary
		  Var EncryptedSets As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mConfigSets
		    Var SetName As String = Entry.Key
		    Var SetDict As Dictionary = Entry.Value
		    Var Groups As New Dictionary
		    Var EncryptedGroups As New Dictionary
		    For Each GroupEntry As DictionaryEntry In SetDict
		      Var Group As Ark.ConfigGroup = GroupEntry.Value
		      Var GroupData As Dictionary = Group.SaveData()
		      If GroupData Is Nil Then
		        GroupData = New Dictionary
		      End If
		      
		      If GroupData.HasAllKeys("Plain", "Encrypted") Then
		        Groups.Value(Group.InternalName) = GroupData.Value("Plain")
		        EncryptedGroups.Value(Group.InternalName) = GroupData.Value("Encrypted")
		      Else
		        Groups.Value(Group.InternalName) = GroupData
		      End If
		    Next
		    Sets.Value(SetName) = Groups
		    If EncryptedGroups.KeyCount > 0 Then
		      EncryptedSets.Value(SetName) = EncryptedGroups
		    End If
		  Next
		  PlainData.Value("Config Sets") = Sets
		  If EncryptedSets.KeyCount > 0 Then
		    EncryptedData.Value("Config Sets") = EncryptedSets
		  End If
		  
		  Var States() As Dictionary
		  For Each State As Ark.ConfigSetState In Self.mConfigSetStates
		    States.Add(State.SaveData)
		  Next
		  PlainData.Value("Config Set Priorities") = States
		End Sub
	#tag EndEvent

	#tag Event
		Function ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer, ByRef FailureReason As String) As Boolean
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
		  
		  If PlainData.HasKey("Config Sets") Then
		    Var Sets As Dictionary = PlainData.Value("Config Sets")
		    Var EncryptedSets As Dictionary
		    If EncryptedData.HasKey("Config Sets") Then
		      Try
		        EncryptedSets = EncryptedData.Value("Config Sets")
		      Catch Err As RuntimeException
		      End Try
		    End If
		    If EncryptedSets Is Nil Then
		      EncryptedSets = New Dictionary
		    End If
		    
		    For Each Entry As DictionaryEntry In Sets
		      Var SetName As String = Entry.Key
		      
		      If Entry.Value IsA Dictionary Then
		        Var EncryptedSetData As Dictionary
		        If EncryptedSets.HasKey(SetName) Then
		          Try
		            EncryptedSetData = EncryptedSets.Value(SetName)
		          Catch Err As RuntimeException
		          End Try
		        End If
		        
		        Self.ConfigSet(SetName) = Self.LoadConfigSet(Dictionary(Entry.Value), EncryptedSetData)
		      Else
		        Self.ConfigSet(SetName) = New Dictionary
		      End If
		    Next
		    
		    // Doc.ConfigSet will add the states. We don't need them.
		    Self.mConfigSetStates.ResizeTo(-1)
		    If PlainData.HasKey("Config Set Priorities") Then
		      Try
		        Var States() As Variant = PlainData.Value("Config Set Priorities")
		        For Each State As Dictionary In States
		          Self.mConfigSetStates.Add(Ark.ConfigSetState.FromSaveData(State))
		        Next
		      Catch Err As RuntimeException
		      End Try
		    End If
		  ElseIf PlainData.HasKey("Configs") Then
		    Self.ConfigSet(Self.BaseConfigSetName) = Self.LoadConfigSet(PlainData.Value("Configs"), Nil)
		  End If
		  
		  If EncryptedData.HasKey("Servers") And EncryptedData.Value("Servers").IsArray Then
		    Var ServerDicts() As Variant = EncryptedData.Value("Servers")
		    For Each ServerDict As Variant In ServerDicts
		      Try
		        Var Dict As Dictionary = ServerDict
		        Var Profile As Ark.ServerProfile = Ark.ServerProfile.FromSaveData(Dict)
		        If Profile Is Nil Then
		          Continue
		        End If
		        
		        // Something about migrating the nitrado account?
		        
		        Self.mServerProfiles.Add(Profile)
		      Catch Err As RuntimeException
		      End Try
		    Next ServerDict
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ActiveConfigSet() As String
		  Return Self.mActiveConfigSet
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ActiveConfigSet(Assigns SetName As String)
		  If Self.mConfigSets.HasKey(SetName) Then
		    Self.mActiveConfigSet = SetName
		  Else
		    Self.mActiveConfigSet = Self.BaseConfigSetName
		  End If
		End Sub
	#tag EndMethod

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
		Sub AddConfigSet(SetName As String)
		  If Self.mConfigSets.HasKey(SetName) = False Then
		    Self.mConfigSets.Value(SetName) = New Dictionary
		    Self.mConfigSetStates.Add(New Ark.ConfigSetState(SetName, False))
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddServerProfile(Profile As Ark.ServerProfile)
		  If Profile Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    If Self.mServerProfiles(Idx) = Profile Then
		      Self.mServerProfiles(Idx) = Profile.Clone
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  If Profile.IsConsole Then
		    Self.ConsoleSafe = True
		    
		    For Each Entry As DictionaryEntry In Self.mContentPacks
		      Var Pack As Ark.ContentPack = Ark.DataSource.SharedInstance.GetContentPackWithUUID(Entry.Key.StringValue)
		      If (Pack Is Nil Or Pack.ConsoleSafe = False) And Self.mContentPacks.Value(Entry.Key).BooleanValue = True Then
		        Self.mContentPacks.Value(Entry.Key) = False
		      End If
		    Next
		  End If
		  
		  Self.mServerProfiles.Add(Profile.Clone)
		  Self.Modified = True
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
		Function CombinedConfigs(States() As Ark.ConfigSetState) As Ark.ConfigGroup()
		  Var Names() As String
		  If States Is Nil Then
		    Names.Add(Self.BaseConfigSetName)
		  Else
		    For Each State As Ark.ConfigSetState In States
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

	#tag Method, Flags = &h1
		Protected Function ConfigSet(SetName As String) As Dictionary
		  If SetName.IsEmpty Then
		    SetName = Self.ActiveConfigSet
		  End If
		  
		  If Self.mConfigSets.HasKey(SetName) Then
		    Return Self.mConfigSets.Value(SetName)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ConfigSet(SetName As String, Assigns Dict As Dictionary)
		  If SetName.IsEmpty Then
		    SetName = Self.ActiveConfigSet
		  End If
		  
		  // Empty sets are valid
		  If Dict Is Nil Then
		    If Self.mConfigSets.HasKey(SetName) Then
		      Self.mConfigSets.Remove(SetName)
		      For Idx As Integer = Self.mConfigSetStates.LastIndex DownTo 1
		        If Self.mConfigSetStates(Idx).Name = SetName Then
		          Self.mConfigSetStates.RemoveAt(Idx)
		        End If
		      Next
		      Self.Modified = True
		    End If
		    Return
		  End If
		  
		  If Self.mConfigSets.HasKey(SetName) = False Then
		    Var Add As Boolean = True
		    For Idx As Integer = 1 To Self.mConfigSetStates.LastIndex
		      If Self.mConfigSetStates(Idx).Name = SetName Then
		        Add = False
		        Exit
		      End If
		    Next
		    If Add Then
		      Self.mConfigSetStates.Add(New Ark.ConfigSetState(SetName, False))
		    End If
		  End If
		  Self.mConfigSets.Value(SetName) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetCount() As Integer
		  Return Self.mConfigSets.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetNames() As String()
		  Var Names() As String
		  For Each Entry As DictionaryEntry In Self.mConfigSets
		    Names.Add(Entry.Key)
		  Next
		  Return Names
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigSetStates() As Ark.ConfigSetState()
		  // Make sure to return a clone of the array. Do not need to clone the members since they are immutable.
		  Var Clone() As Ark.ConfigSetState
		  Var Names() As String
		  For Each State As Ark.ConfigSetState In Self.mConfigSetStates
		    // Do not include any states for sets that don't exist. Should be zero, but just to be sure.
		    If Self.mConfigSets.HasKey(State.Name) = False Then
		      Continue
		    End If
		    
		    Clone.Add(State)
		    Names.Add(State.Name)
		  Next
		  
		  // Make sure any new sets have a state
		  For Each Entry As DictionaryEntry In Self.mConfigSets
		    If Names.IndexOf(Entry.Key.StringValue) = -1 Then
		      Clone.Add(New Ark.ConfigSetState(Entry.Key.StringValue, False))
		    End If
		  Next
		  
		  // First should always be an enabled base
		  Clone(0) = New Ark.ConfigSetState(Self.BaseConfigSetName, True)
		  
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConfigSetStates(Assigns States() As Ark.ConfigSetState)
		  // First decide if the States() array is different from the mConfigSetStates() array. Then, 
		  // update mConfigSetStates() to match. Do not need to clone the members since they are immutable.
		  
		  Var Different As Boolean
		  If Self.mConfigSetStates.Count <> States.Count Then
		    Different = True
		  Else
		    For Idx As Integer = 0 To States.LastIndex
		      If Self.mConfigSetStates(Idx) <> States(Idx) Then
		        Different = True
		        Exit
		      End If
		    Next
		  End If
		  
		  If Not Different Then
		    Return
		  End If
		  
		  Self.mConfigSetStates.ResizeTo(States.LastIndex)
		  For Idx As Integer = 0 To States.LastIndex
		    Self.mConfigSetStates(Idx) = States(Idx)
		  Next
		  Self.Modified = True
		End Sub
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
		  Self.mContentPacks = New Dictionary
		  Self.mMapMask = 1 // Play it safe, do not bother calling Ark.Maps here in case database access is fubar
		  Self.mConfigSets = New Dictionary
		  
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
		Function CreateConfigOrganizer(Identity As Beacon.Identity, Profile As Ark.ServerProfile) As Ark.ConfigOrganizer
		  Try
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
		    
		    Return Organizer
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Generating a config organizer")
		    Return Nil
		  End Try
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

	#tag Method, Flags = &h21
		Private Function LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
		  If EncryptedData Is Nil Then
		    EncryptedData = New Dictionary
		  End If
		  
		  Var SetDict As New Dictionary
		  Var ConvertLootScale As Dictionary
		  For Each Entry As DictionaryEntry In PlainData
		    Try
		      Var InternalName As String = Entry.Key
		      Var GroupData As Dictionary = Entry.Value
		      If InternalName = "LootScale" Then
		        ConvertLootScale = GroupData
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
		      End If
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
		Sub RemoveConfigSet(SetName As String)
		  If SetName.IsEmpty Or SetName = Self.BaseConfigSetName Then
		    Return
		  End If
		  
		  For Idx As Integer = Self.mConfigSetStates.LastIndex DownTo 1
		    If Self.mConfigSetStates(Idx).Name = SetName Then
		      Self.mConfigSetStates.RemoveAt(Idx)
		      Self.Modified = True
		    End If
		  Next
		  
		  Self.ConfigSet(SetName) = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveServerProfile(Profile As Ark.ServerProfile)
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    If Self.mServerProfiles(Idx) = Profile Then
		      Self.mServerProfiles.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RenameConfigSet(OldName As String, NewName As String)
		  If Self.mConfigSets.HasKey(OldName) = False Then
		    Return
		  End If
		  
		  For Idx As Integer = 1 To Self.mConfigSetStates.LastIndex
		    If Self.mConfigSetStates(Idx).Name = OldName Then
		      Self.mConfigSetStates(Idx) = New Ark.ConfigSetState(NewName, Self.mConfigSetStates(Idx).Enabled)
		    End If
		  Next
		  
		  Var OldSet As Dictionary = Self.mConfigSets.Value(OldName)
		  Self.ConfigSet(OldName) = Nil
		  Self.ConfigSet(NewName) = OldSet
		  
		  For Idx As Integer = 0 To Self.mServerProfiles.LastIndex
		    Var Profile As Ark.ServerProfile = Self.mServerProfiles(Idx)
		    Var ConfigSets() As Ark.ConfigSetState = Profile.ConfigSetStates
		    For SetIdx As Integer = 0 To ConfigSets.LastIndex
		      If ConfigSets(SetIdx).Name = OldName Then
		        ConfigSets(SetIdx) = New Ark.ConfigSetState(NewName, ConfigSets(SetIdx).Enabled)
		      End If
		    Next
		    Profile.ConfigSetStates = ConfigSets
		  Next
		  
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfile(Idx As Integer) As Ark.ServerProfile
		  Return Self.mServerProfiles(Idx).Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ServerProfile(Idx As Integer, Assigns Profile As Ark.ServerProfile)
		  Self.mServerProfiles(Idx) = Profile.Clone
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerProfileCount() As Integer
		  Return Self.mServerProfiles.Count
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
		Protected mActiveConfigSet As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAllowUCS2 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mConfigSets As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mConfigSetStates() As Ark.ConfigSetState
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
		Protected mServerProfiles() As Ark.ServerProfile
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
