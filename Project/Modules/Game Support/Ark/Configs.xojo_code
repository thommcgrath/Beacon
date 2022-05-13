#tag Module
Protected Module Configs
	#tag Method, Flags = &h1
		Protected Function AllNames(Human As Boolean = False) As String()
		  Static Names() As String
		  If Names.LastIndex = -1 Then
		    Names.Add(NameBreedingMultipliers)
		    Names.Add(NameCraftingCosts)
		    Names.Add(NameCustomContent)
		    Names.Add(NameDayCycle)
		    Names.Add(NameDifficulty)
		    Names.Add(NameDinoAdjustments)
		    Names.Add(NameEngramControl)
		    Names.Add(NameExperienceCurves)
		    Names.Add(NameHarvestRates)
		    Names.Add(NameLootDrops)
		    Names.Add(NameOtherSettings)
		    Names.Add(NameSpawnPoints)
		    Names.Add(NameSpoilTimers)
		    Names.Add(NameStackSizes)
		    Names.Add(NameStatLimits)
		    Names.Add(NameStatMultipliers)
		  End If
		  If Human = True Then
		    Static HumanNames() As String
		    If HumanNames.LastIndex = -1 Then
		      HumanNames.ResizeTo(Names.LastIndex)
		      For I As Integer = 0 To Names.LastIndex
		        HumanNames(I) = Language.LabelForConfig(Names(I))
		      Next
		      HumanNames.Sort
		    End If
		    Return HumanNames
		  Else
		    Return Names
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AllTools() As Ark.ProjectTool()
		  Static Tools() As Ark.ProjectTool
		  Static Generated As DateTime
		  Var Now As DateTime = DateTime.Now
		  If Tools.LastIndex = -1 Or ((Generated Is Nil) = False And Generated.DayOfYear <> Now.DayOfYear) Then
		    Tools.ResizeTo(-1)
		    Tools.Add(New Ark.ProjectTool("Adjust All Crafting Costs", "24376f12-c256-440c-87ca-2c8309a7a754", NameCraftingCosts))
		    Tools.Add(New Ark.ProjectTool("Replace Crafting Ingredient", "6600245b-54b4-4b85-8f26-3792084ca2fa", NameCraftingCosts))
		    Tools.Add(New Ark.ProjectTool("Setup Fibercraft Server", "94eced5b-be7d-441a-a5b3-f4a9bf40a856", NameCraftingCosts))
		    Tools.Add(New Ark.ProjectTool("Setup Transferrable Element", "3db64fe3-9134-4a19-a255-7712c8c70a83", NameCraftingCosts))
		    Tools.Add(New Ark.ProjectTool("Convert Creature Replacements to Spawn Point Additions", "614cfc80-b7aa-437d-b17e-01534f2ab778", NameSpawnPoints, NameDinoAdjustments))
		    Tools.Add(New Ark.ProjectTool("Quick Edit Creature Spawns", "8913bca3-fbae-43bd-a94b-7c3ac06b6ca1", NameSpawnPoints))
		    Tools.Add(New Ark.ProjectTool("Setup Guided Editors", "d29dc6f8-e834-4969-9cfe-b38e1c052156", NameCustomContent))
		    Tools.Add(New Ark.ProjectTool("Convert Global Harvest Rate to Individual Rates", "5265adcd-5c7e-437c-bce2-d10721afde43", NameHarvestRates))
		    Tools.Add(New Ark.ProjectTool("Rebuild Item Sets from Presets", "08efc49c-f39f-4147-820d-201637c206b5", NameLootDrops))
		    If Now.Month = 4 And Now.Day = 1 Then
		      Tools.Add(New Ark.ProjectTool("AI Config Generator", "c5c14eb8-41c9-4fd3-8f92-582e843ac9a0", NameOtherSettings))
		    End If
		    
		    Var Names() As String
		    Names.ResizeTo(Tools.LastIndex)
		    For Idx As Integer = Tools.FirstIndex To Tools.LastIndex
		      Names(Idx) = Language.LabelForConfig(Tools(Idx).FirstGroup) + " - " + Tools(Idx).Caption
		    Next Idx
		    Names.SortWith(Tools)
		    
		    Generated = Now
		  End If
		  Return Tools
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CloneInstance(Group As Ark.ConfigGroup) As Ark.ConfigGroup
		  If Group Is Nil Then
		    Return Nil
		  End If
		  
		  Var NewInstance As Ark.ConfigGroup = CreateInstance(Group.InternalName)
		  NewInstance.CopyFrom(Group)
		  Return NewInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigUnlocked(Config As Ark.ConfigGroup, Identity As Beacon.Identity) As Boolean
		  Return ConfigUnlocked(Config.InternalName, Identity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigUnlocked(InternalName As String, Identity As Beacon.Identity) As Boolean
		  If mConfigOmniCache Is Nil Then
		    mConfigOmniCache = New Dictionary
		  End If
		  
		  Var RequiresOmni As Boolean
		  If mConfigOmniCache.HasKey(InternalName) = False Then
		    Select Case InternalName
		    Case NameServersPseudo, NameMetadataPsuedo, NameAccountsPsuedo
		      RequiresOmni = False
		    Else
		      Var Instance As Ark.ConfigGroup = CreateInstance(InternalName)
		      If (Instance Is Nil) = False Then
		        RequiresOmni = Instance.RequiresOmni
		      End If
		    End Select
		    mConfigOmniCache.Value(InternalName) = RequiresOmni
		  Else
		    RequiresOmni = mConfigOmniCache.Value(InternalName)
		  End If
		  
		  If RequiresOmni Then
		    Return Ark.OmniPurchased(Identity)
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String) As Ark.ConfigGroup
		  Select Case InternalName
		  Case NameBreedingMultipliers
		    Return New Ark.Configs.BreedingMultipliers()
		  Case NameCraftingCosts
		    Return New Ark.Configs.CraftingCosts()
		  Case NameCustomContent
		    Return New Ark.Configs.CustomContent()
		  Case NameDayCycle
		    Return New Ark.Configs.DayCycle()
		  Case NameDifficulty
		    Return New Ark.Configs.Difficulty()
		  Case NameDinoAdjustments
		    Return New Ark.Configs.DinoAdjustments()
		  Case NameEngramControl
		    Return New Ark.Configs.EngramControl()
		  Case NameExperienceCurves
		    Return New Ark.Configs.ExperienceCurves()
		  Case NameHarvestRates
		    Return New Ark.Configs.HarvestRates()
		  Case NameLootDrops
		    Return New Ark.Configs.LootDrops()
		  Case NameSpawnPoints
		    Return New Ark.Configs.SpawnPoints()
		  Case NameStackSizes
		    Return New Ark.Configs.StackSizes()
		  Case NameStatLimits
		    Return New Ark.Configs.StatLimits()
		  Case NameStatMultipliers
		    Return New Ark.Configs.StatMultipliers()
		  Case NameSpoilTimers
		    Return New Ark.Configs.SpoilTimers()
		  Case NameOtherSettings
		    Return New Ark.Configs.OtherSettings()
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String, SaveData As Dictionary, EncryptedData As Dictionary) As Ark.ConfigGroup
		  If EncryptedData Is Nil Then
		    If SaveData.HasAllKeys("Plain", "Encrypted") Then
		      EncryptedData = SaveData.Value("Encrypted")
		      SaveData = SaveData.Value("Plain")
		    Else
		      EncryptedData = New Dictionary
		    End If
		  End If
		  
		  Select Case InternalName
		  Case NameBreedingMultipliers
		    Return New Ark.Configs.BreedingMultipliers(SaveData, EncryptedData)
		  Case NameCraftingCosts
		    Return New Ark.Configs.CraftingCosts(SaveData, EncryptedData)
		  Case NameCustomContent
		    Return New Ark.Configs.CustomContent(SaveData, EncryptedData)
		  Case NameDayCycle
		    Return New Ark.Configs.DayCycle(SaveData, EncryptedData)
		  Case NameDifficulty
		    Return New Ark.Configs.Difficulty(SaveData, EncryptedData)
		  Case NameDinoAdjustments
		    Return New Ark.Configs.DinoAdjustments(SaveData, EncryptedData)
		  Case NameEngramControl
		    Return New Ark.Configs.EngramControl(SaveData, EncryptedData)
		  Case NameExperienceCurves
		    Return New Ark.Configs.ExperienceCurves(SaveData, EncryptedData)
		  Case NameHarvestRates
		    Return New Ark.Configs.HarvestRates(SaveData, EncryptedData)
		  Case NameLootDrops
		    Return New Ark.Configs.LootDrops(SaveData, EncryptedData)
		  Case NameSpawnPoints
		    Return New Ark.Configs.SpawnPoints(SaveData, EncryptedData)
		  Case NameStackSizes
		    Return New Ark.Configs.StackSizes(SaveData, EncryptedData)
		  Case NameStatLimits
		    Return New Ark.Configs.StatLimits(SaveData, EncryptedData)
		  Case NameStatMultipliers
		    Return New Ark.Configs.StatMultipliers(SaveData, EncryptedData)
		  Case NameSpoilTimers
		    Return New Ark.Configs.SpoilTimers(SaveData, EncryptedData)
		  Case NameOtherSettings
		    Return New Ark.Configs.OtherSettings(SaveData, EncryptedData)
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String, ParsedData As Dictionary, CommandLineOptions As Dictionary, Project As Ark.Project) As Ark.ConfigGroup
		  // Why not just pass the project itself to these methods? Because we don't want it to be possible
		  // for the creation of an instance to modify the project. MapMask and ContentPacks are immutable,
		  // but the difficulty object is not, so we'll pass the raw value instead.
		  
		  Var DifficultyValue As Double = Project.Difficulty.DifficultyValue
		  
		  Select Case InternalName
		  Case Ark.Configs.NameBreedingMultipliers
		    Return Ark.Configs.BreedingMultipliers.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameCraftingCosts
		    Return Ark.Configs.CraftingCosts.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameCustomContent
		    Return Nil
		  Case Ark.Configs.NameDayCycle
		    Return Ark.Configs.DayCycle.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameDifficulty
		    Return Nil
		  Case Ark.Configs.NameDinoAdjustments
		    Return Ark.Configs.DinoAdjustments.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameEngramControl
		    Return Ark.Configs.EngramControl.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameExperienceCurves
		    Return Ark.Configs.ExperienceCurves.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameHarvestRates
		    Return Ark.Configs.HarvestRates.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameLootDrops
		    Return Ark.Configs.LootDrops.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameSpawnPoints
		    Return Ark.Configs.SpawnPoints.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameStackSizes
		    Return Ark.Configs.StackSizes.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameStatLimits
		    Return Ark.Configs.StatLimits.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameStatMultipliers
		    Return Ark.Configs.StatMultipliers.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameSpoilTimers
		    Return Ark.Configs.SpoilTimers.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Case Ark.Configs.NameOtherSettings
		    Return Ark.Configs.OtherSettings.FromImport(ParsedData, CommandLineOptions, Project.MapMask, DifficultyValue, Project.ContentPacks)
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Merge(Groups() As Ark.ConfigGroup, ZeroHasPriority As Boolean) As Ark.ConfigGroup
		  // First, make sure all groups are the same type
		  
		  If Groups.Count = 0 Then
		    Return Nil
		  ElseIf Groups.Count = 1 Then
		    Return CloneInstance(Groups(0))
		  End If
		  
		  Var MergeSupported As Boolean = Groups(0).SupportsMerging
		  Var GroupName As String = Groups(0).InternalName
		  For Idx As Integer = 1 To Groups.LastIndex
		    If Groups(Idx) Is Nil Or Groups(Idx).InternalName <> GroupName Then
		      Return Nil
		    End If
		  Next Idx
		  
		  Var NewGroup As Ark.ConfigGroup
		  If ZeroHasPriority Then
		    If MergeSupported Then
		      For Idx As Integer = Groups.LastIndex DownTo 0
		        If NewGroup Is Nil Then
		          NewGroup = CreateInstance(GroupName)
		        End If
		        NewGroup.CopyFrom(Groups(Idx))
		      Next Idx
		    Else
		      NewGroup = CloneInstance(Groups(0))
		    End If
		  Else
		    If MergeSupported Then
		      For Idx As Integer = 0 To Groups.LastIndex
		        If NewGroup Is Nil Then
		          NewGroup = CreateInstance(GroupName)
		        End If
		        NewGroup.CopyFrom(Groups(Idx))
		      Next Idx
		    Else
		      NewGroup = CloneInstance(Groups(Groups.LastIndex))
		    End If
		  End If
		  
		  Return NewGroup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Merge(ZeroHasPriority As Boolean, ParamArray Groups() As Ark.ConfigGroup) As Ark.ConfigGroup
		  Return Merge(Groups, ZeroHasPriority)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SupportsConfigSets(InternalName As String) As Boolean
		  If mConfigSetSupportCache Is Nil Then
		    mConfigSetSupportCache = New Dictionary
		  End If
		  
		  If mConfigSetSupportCache.HasKey(InternalName) = False Then
		    Var Instance As Ark.ConfigGroup
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Instance = CreateInstance(InternalName)
		    Catch Err As RuntimeException
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    If Instance Is Nil Then
		      mConfigSetSupportCache.Value(InternalName) = False
		    Else
		      mConfigSetSupportCache.Value(InternalName) = Instance.SupportsConfigSets
		    End If
		  End If
		  
		  Return mConfigSetSupportCache.Value(InternalName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SupportsMerging(InternalName As String) As Boolean
		  If mMergingSupportCache Is Nil Then
		    mMergingSupportCache = New Dictionary
		  End If
		  
		  If mMergingSupportCache.HasKey(InternalName) = False Then
		    Var Instance As Ark.ConfigGroup
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Instance = CreateInstance(InternalName)
		    Catch Err As RuntimeException
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    If Instance Is Nil Then
		      mMergingSupportCache.Value(InternalName) = False
		    Else
		      mMergingSupportCache.Value(InternalName) = Instance.SupportsMerging
		    End If
		  End If
		  
		  Return mMergingSupportCache.Value(InternalName)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigOmniCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfigSetSupportCache As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMergingSupportCache As Dictionary
	#tag EndProperty


	#tag Constant, Name = NameAccountsPsuedo, Type = String, Dynamic = False, Default = \"accounts", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameBreedingMultipliers, Type = String, Dynamic = False, Default = \"BreedingMultipliers", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameCraftingCosts, Type = String, Dynamic = False, Default = \"CraftingCosts", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameCustomContent, Type = String, Dynamic = False, Default = \"CustomContent", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameDayCycle, Type = String, Dynamic = False, Default = \"DayCycle", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameDifficulty, Type = String, Dynamic = False, Default = \"Difficulty", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameDinoAdjustments, Type = String, Dynamic = False, Default = \"DinoAdjustments", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameEngramControl, Type = String, Dynamic = False, Default = \"EngramControl", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameExperienceCurves, Type = String, Dynamic = False, Default = \"ExperienceCurves", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameHarvestRates, Type = String, Dynamic = False, Default = \"HarvestRates", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameLootDrops, Type = String, Dynamic = False, Default = \"LootDrops", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameMetadataPsuedo, Type = String, Dynamic = False, Default = \"metadata", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameOtherSettings, Type = String, Dynamic = False, Default = \"OtherSettings", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameServersPseudo, Type = String, Dynamic = False, Default = \"deployments", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameSpawnPoints, Type = String, Dynamic = False, Default = \"SpawnPoints", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameSpoilTimers, Type = String, Dynamic = False, Default = \"SpoilTimers", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameStackSizes, Type = String, Dynamic = False, Default = \"StackSizes", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameStatLimits, Type = String, Dynamic = False, Default = \"StatLimits", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameStatMultipliers, Type = String, Dynamic = False, Default = \"StatMultipliers", Scope = Protected
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
End Module
#tag EndModule
