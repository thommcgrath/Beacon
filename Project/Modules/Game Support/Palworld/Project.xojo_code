#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag Event
		Sub AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused PlainData
		  #Pragma Unused EncryptedData
		  
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
		End Sub
	#tag EndEvent

	#tag Event
		Function LoadConfigSet(PlainData As Dictionary, EncryptedData As Dictionary) As Dictionary
		  Var SetDict As New Dictionary
		  For Each Entry As DictionaryEntry In PlainData
		    Try
		      Var InternalName As String = Entry.Key
		      Var GroupData As Dictionary = Entry.Value
		      Var EncryptedGroupData As Dictionary
		      If EncryptedData.HasKey(InternalName) Then
		        Try
		          EncryptedGroupData = EncryptedData.Value(InternalName)
		        Catch EncGroupDataErr As RuntimeException
		        End Try
		      End If
		      
		      Var Instance As Palworld.ConfigGroup = Palworld.Configs.CreateInstance(InternalName, GroupData, EncryptedGroupData)
		      If (Instance Is Nil) = False Then
		        SetDict.Value(InternalName) = Instance
		      End If
		    Catch Err As RuntimeException
		      App.Log("Unable to load config group " + Entry.Key + " from project " + Self.ProjectId + " due to an unhandled " + Err.ClassName + ": " + Err.Message)
		    End Try
		  Next
		  Return SetDict
		End Function
	#tag EndEvent

	#tag Event
		Sub SaveConfigSet(SetDict As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  For Each Entry As DictionaryEntry In SetDict
		    Var Group As Palworld.ConfigGroup = Entry.Value
		    
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


	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, Sets() As Beacon.ConfigSet) As Palworld.ConfigGroup
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Siblings() As Palworld.ConfigGroup
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    Var SetDict As Dictionary = Self.ConfigSetData(Set)
		    If SetDict Is Nil Or SetDict.HasKey(GroupName) = False Then
		      Continue
		    End If
		    
		    Var Group As Palworld.ConfigGroup = SetDict.Value(GroupName)
		    Siblings.Add(Group)
		  Next
		  
		  Return Palworld.Configs.Merge(Siblings, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, States() As Beacon.ConfigSetState) As Palworld.ConfigGroup
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfig(GroupName, Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(Sets() As Beacon.ConfigSet) As Palworld.ConfigGroup()
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Instances As New Dictionary
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    For Each Group As Palworld.ConfigGroup In Self.ImplementedConfigs(Set)
		      Var Siblings() As Palworld.ConfigGroup
		      If Instances.HasKey(Group.InternalName) Then
		        Siblings = Instances.Value(Group.InternalName)
		      End If
		      Siblings.Add(Group)
		      Instances.Value(Group.InternalName) = Siblings
		    Next
		  Next
		  
		  Var Combined() As Palworld.ConfigGroup
		  For Each Entry As DictionaryEntry In Instances
		    Var Siblings() As Palworld.ConfigGroup = Entry.Value
		    Var Merged As Palworld.ConfigGroup = Palworld.Configs.Merge(Siblings, False)
		    If (Merged Is Nil) = False Then
		      Combined.Add(Merged)
		    End If
		  Next Entry
		  Return Combined
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(States() As Beacon.ConfigSetState) As Palworld.ConfigGroup()
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfigs(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Set As Beacon.ConfigSet, Create As Boolean = False) As Palworld.ConfigGroup
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    Return SetDict.Value(InternalName)
		  End If
		  
		  If Create Then
		    Var Group As Palworld.ConfigGroup = Palworld.Configs.CreateInstance(InternalName)
		    If (Group Is Nil) = False Then
		      Group.IsImplicit = True
		      Self.AddConfigGroup(Group, Set)
		    End If
		    Return Group
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Create As Boolean = False) As Palworld.ConfigGroup
		  Return Self.ConfigGroup(InternalName, Self.ActiveConfigSet, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  Self.ContentPackEnabled(Palworld.UserContentPackId) = True // Force it
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateConfigOrganizer(Identity As Beacon.Identity, Profile As Palworld.ServerProfile) As Palworld.ConfigOrganizer
		  Try
		    If Identity.IsBanned Then
		      Return Self.CreateTrollConfigOrganizer(Profile)
		    End If
		    
		    Var Organizer As New Palworld.ConfigOrganizer
		    Var Groups() As Palworld.ConfigGroup = Self.CombinedConfigs(Profile.ConfigSetStates)
		    
		    // Add custom content first so it can be overridden or removed later
		    For Idx As Integer = 0 To Groups.LastIndex
		      If Groups(Idx) Is Nil Then
		        Continue
		      End If
		      
		      If Groups(Idx).InternalName = Palworld.Configs.NameCustomConfig Then
		        Organizer.AddManagedKeys(Groups(Idx).ManagedKeys)
		        Organizer.Add(Groups(Idx).GenerateConfigValues(Self, Identity, Profile))
		        Groups.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    For Each Group As Palworld.ConfigGroup In Groups
		      If Group Is Nil Then
		        Continue
		      End If
		      
		      Var ManagedKeys() As Palworld.ConfigOption = Group.ManagedKeys
		      Organizer.AddManagedKeys(ManagedKeys)
		      Organizer.Remove(ManagedKeys) // Removes overlapping values found in custom config
		      Organizer.Add(Group.GenerateConfigValues(Self, Identity, Profile))
		    Next
		    
		    Organizer.Add(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, "OptionSettings", "ServerName", Profile.Name)
		    Organizer.Add(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, "OptionSettings", "ServerDescription", Profile.ServerDescription)
		    If (Profile.AdminPassword Is Nil) = False Then
		      Organizer.Add(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, "OptionSettings", "AdminPassword", Profile.AdminPassword.StringValue)
		    End If
		    If (Profile.ServerPassword Is Nil) = False Then
		      Organizer.Add(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, "OptionSettings", "ServerPassword", Profile.ServerPassword.StringValue)
		    End If
		    
		    Return Organizer
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Generating a config organizer")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTrollConfigOrganizer(Profile As Palworld.ServerProfile) As Palworld.ConfigOrganizer
		  Var Values As New Palworld.ConfigOrganizer
		  
		  #if DebugBuild
		    #Pragma Warning "Needs troll organizer"
		  #else
		    #Pragma Error "Needs troll organizer"
		  #endif
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSource(AllowWriting As Boolean) As Beacon.DataSource
		  Return Palworld.DataSource.Pool.Get(AllowWriting)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return Palworld.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesOmniFeaturesWithoutOmni(Identity As Beacon.Identity) As Palworld.ConfigGroup()
		  Var ExcludedConfigs() As Palworld.ConfigGroup
		  For Each Config As Palworld.ConfigGroup In Self.ImplementedConfigs()
		    If Palworld.Configs.ConfigUnlocked(Config, Identity) = False Then
		      ExcludedConfigs.Add(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod


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
