#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub AddSaveData(ManifestData As Dictionary, PlainData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused PlainData
		  #Pragma Unused EncryptedData
		  
		  ManifestData.Value("gameVersion") = Self.mGameVersion
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(PlainData As Dictionary, EncryptedData As Dictionary, SaveDataVersion As Integer, SavedWithVersion As Integer)
		  #Pragma Unused EncryptedData
		  #Pragma Unused SaveDataVersion
		  #Pragma Unused SavedWithVersion
		  
		  Self.mGameVersion = PlainData.Value("gameVersion")
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Beacon.ConfigGroup)
		  If Group IsA SDTD.ConfigGroup Then
		    Super.AddConfigGroup(Group, Self.ActiveConfigSet)
		  Else
		    Var Err As UnsupportedOperationException
		    Err.Message = "Wrong config group subclass for project"
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As Beacon.ConfigGroup, Set As Beacon.ConfigSet)
		  If Group IsA SDTD.ConfigGroup Then
		    Super.AddConfigGroup(Group, Set)
		  Else
		    Var Err As UnsupportedOperationException
		    Err.Message = "Wrong config group subclass for project"
		    Raise Err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(Identity As Beacon.Identity) As SDTD.Project
		  Return SDTD.Project(Super.Clone(Identity))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, Sets() As Beacon.ConfigSet) As SDTD.ConfigGroup
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Siblings() As SDTD.ConfigGroup
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    Var SetDict As Dictionary = Self.ConfigSetData(Set)
		    If SetDict Is Nil Or SetDict.HasKey(GroupName) = False Then
		      Continue
		    End If
		    
		    Var Group As SDTD.ConfigGroup = SetDict.Value(GroupName)
		    Siblings.Add(Group)
		  Next
		  
		  Return SDTD.Configs.Merge(Siblings, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfig(GroupName As String, States() As Beacon.ConfigSetState) As SDTD.ConfigGroup
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfig(GroupName, Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(Sets() As Beacon.ConfigSet) As SDTD.ConfigGroup()
		  If Sets Is Nil Then
		    Sets = Array(Beacon.ConfigSet.BaseConfigSet)
		  ElseIf Sets.Count = 0 Then
		    Sets.Add(Beacon.ConfigSet.BaseConfigSet)
		  End If
		  
		  Var Instances As New Dictionary
		  For Idx As Integer = 0 To Sets.LastIndex
		    Var Set As Beacon.ConfigSet = Sets(Idx)
		    For Each Group As SDTD.ConfigGroup In Self.ImplementedConfigs(Set)
		      Var Siblings() As SDTD.ConfigGroup
		      If Instances.HasKey(Group.InternalName) Then
		        Siblings = Instances.Value(Group.InternalName)
		      End If
		      Siblings.Add(Group)
		      Instances.Value(Group.InternalName) = Siblings
		    Next
		  Next
		  
		  Var Combined() As SDTD.ConfigGroup
		  For Each Entry As DictionaryEntry In Instances
		    Var Siblings() As SDTD.ConfigGroup = Entry.Value
		    Var Merged As SDTD.ConfigGroup = SDTD.Configs.Merge(Siblings, False)
		    If (Merged Is Nil) = False Then
		      Combined.Add(Merged)
		    End If
		  Next Entry
		  Return Combined
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CombinedConfigs(States() As Beacon.ConfigSetState) As SDTD.ConfigGroup()
		  Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(States, Self.ConfigSets)
		  Return Self.CombinedConfigs(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Set As Beacon.ConfigSet, Create As Boolean = False) As SDTD.ConfigGroup
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If (SetDict Is Nil) = False And SetDict.HasKey(InternalName) Then
		    Return SetDict.Value(InternalName)
		  End If
		  
		  If Create Then
		    Var Group As SDTD.ConfigGroup = SDTD.Configs.CreateInstance(InternalName)
		    If (Group Is Nil) = False Then
		      Group.IsImplicit = True
		      Self.AddConfigGroup(Group, Set)
		    End If
		    Return Group
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigGroup(InternalName As String, Create As Boolean = False) As SDTD.ConfigGroup
		  Return Self.ConfigGroup(InternalName, Self.ActiveConfigSet, Create)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		  Self.ContentPackEnabled(SDTD.UserContentPackId) = True // Force it
		  
		  Var DataSource As SDTD.DataSource = SDTD.DataSource.Pool.Get(False)
		  If (DataSource Is Nil) = False Then
		    Self.mGameVersion = DataSource.NewestGameVersion()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateConfigOrganizer(Identity As Beacon.Identity, Profile As SDTD.ServerProfile) As SDTD.ConfigOrganizer
		  Try
		    If Identity.IsBanned Then
		      Return Self.CreateTrollConfigOrganizer(Profile)
		    End If
		    
		    Var Organizer As SDTD.ConfigOrganizer = Self.CreateDefaultConfigOrganizer
		    Var Groups() As SDTD.ConfigGroup = Self.CombinedConfigs(Profile.ConfigSetStates)
		    
		    // Add custom content first so it can be overridden or removed later
		    For Idx As Integer = 0 To Groups.LastIndex
		      If Groups(Idx) Is Nil Then
		        Continue
		      End If
		      
		      If Groups(Idx).InternalName = SDTD.Configs.NameCustomConfig Then
		        Organizer.AddManagedKeys(Groups(Idx).ManagedKeys)
		        Organizer.Add(Groups(Idx).GenerateConfigValues(Self, Identity, Profile))
		        Groups.RemoveAt(Idx)
		        Exit
		      End If
		    Next
		    
		    For Each Group As SDTD.ConfigGroup In Groups
		      If Group Is Nil Then
		        Continue
		      End If
		      
		      Var ManagedKeys() As SDTD.ConfigOption = Group.ManagedKeys
		      Organizer.AddManagedKeys(ManagedKeys)
		      Organizer.Remove(ManagedKeys) // Removes overlapping values found in custom config
		      Organizer.Add(Group.GenerateConfigValues(Self, Identity, Profile))
		    Next
		    
		    Organizer.Add(New SDTD.ConfigValue(SDTD.ConfigFileServerConfigXml, "ServerName", Profile.Name), SDTD.ConfigOrganizer.FlagAddToManaged)
		    
		    Return Organizer
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Generating a config organizer")
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateDefaultConfigOrganizer() As SDTD.ConfigOrganizer
		  Var Options() As SDTD.ConfigOption = SDTD.DataSource.Pool.Get(False).GetConfigOptions(SDTD.ConfigFileServerConfigXml, "", Self.GameVersion, Self.ContentPacks)
		  Var Values() As SDTD.ConfigValue
		  For Each Option As SDTD.ConfigOption In Options
		    Values.Add(New SDTD.ConfigValue(Option, Option.DefaultValue))
		  Next
		  Return New SDTD.ConfigOrganizer(Values)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateTrollConfigOrganizer(Profile As SDTD.ServerProfile) As SDTD.ConfigOrganizer
		  Var Values As SDTD.ConfigOrganizer = Self.CreateDefaultConfigOrganizer
		  
		  If (Profile Is Nil) = False Then
		    Values.Add(New SDTD.ConfigValue(SDTD.ConfigFileServerConfigXml, "ServerName", Profile.Name))
		  End If
		  
		  #if SDTD.Enabled
		    #Pragma Warning "Not fully implemented"
		  #endif
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DataSource(AllowWriting As Boolean) As Beacon.DataSource
		  Return SDTD.DataSource.Pool.Get(AllowWriting)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameId() As String
		  Return SDTD.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameVersion() As Integer
		  Return Self.mGameVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameVersion(Assigns Value As Integer)
		  If Self.mGameVersion <> Value Then
		    Self.mGameVersion = Value
		    Self.Modified = True
		  End If
		End Sub
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
		Sub RemoveConfigGroup(Group As SDTD.ConfigGroup)
		  If Group Is Nil Then
		    Return
		  End If
		  
		  Self.RemoveConfigGroup(Group.InternalName, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveConfigGroup(Group As SDTD.ConfigGroup, Set As Beacon.ConfigSet)
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
		Function UsesOmniFeaturesWithoutOmni(Identity As Beacon.Identity) As SDTD.ConfigGroup()
		  Var ExcludedConfigs() As SDTD.ConfigGroup
		  For Each Config As SDTD.ConfigGroup In Self.ImplementedConfigs()
		    If SDTD.Configs.ConfigUnlocked(Config, Identity) = False Then
		      ExcludedConfigs.Add(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mGameVersion As Integer
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
