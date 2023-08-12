#tag Class
Protected Class Project
Inherits Beacon.Project
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As SDTD.ConfigGroup)
		  Self.AddConfigGroup(Group, Self.ActiveConfigSet)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddConfigGroup(Group As SDTD.ConfigGroup, Set As Beacon.ConfigSet)
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  If SetDict Is Nil Then
		    SetDict = New Dictionary
		  End If
		  SetDict.Value(Group.InternalName) = Group
		  Self.ConfigSetData(Set) = SetDict
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
		    Var Groups() As SDTD.ConfigGroup = Self.ImplementedConfigs(Set)
		    For Each Group As SDTD.ConfigGroup In Groups
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
		Function ImplementedConfigs() As SDTD.ConfigGroup()
		  Var Sets() As Beacon.ConfigSet = Self.ConfigSets
		  Var Groups() As SDTD.ConfigGroup
		  For Each Set As Beacon.ConfigSet In Sets
		    Var SetGroups() As SDTD.ConfigGroup = Self.ImplementedConfigs(Set)
		    For Each Group As SDTD.ConfigGroup In SetGroups
		      Groups.Add(Group)
		    Next
		  Next
		  Return Groups
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImplementedConfigs(Set As Beacon.ConfigSet) As SDTD.ConfigGroup()
		  Var SetDict As Dictionary = Self.ConfigSetData(Set)
		  Var Groups() As SDTD.ConfigGroup
		  If (SetDict Is Nil) = False Then
		    For Each Entry As DictionaryEntry In SetDict
		      Var Group As SDTD.ConfigGroup = Entry.Value
		      If Group.IsImplicit = False Or Set.IsBase Then
		        Groups.Add(Group)
		      End If
		    Next
		  End If
		  Return Groups
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
		  Var Configs() As SDTD.ConfigGroup = Self.ImplementedConfigs()
		  Var ExcludedConfigs() As SDTD.ConfigGroup
		  For Each Config As SDTD.ConfigGroup In Configs
		    If SDTD.Configs.ConfigUnlocked(Config, Identity) = False Then
		      ExcludedConfigs.Add(Config)
		    End If
		  Next
		  Return ExcludedConfigs
		End Function
	#tag EndMethod


End Class
#tag EndClass
