#tag Module
Protected Module Configs
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
		    Var Instance As Ark.ConfigGroup = CreateInstance(InternalName)
		    If (Instance Is Nil) = False Then
		      RequiresOmni = Instance.RequiresOmni
		    End If
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
		Protected Function CreateInstance(InternalName As String, SaveData As Dictionary, Project As Ark.Project, Identity As Beacon.Identity) As Ark.ConfigGroup
		  Select Case InternalName
		  Case NameBreedingMultipliers
		    Return New Ark.Configs.BreedingMultipliers(SaveData, Identity, Project)
		  Case NameCraftingCosts
		    Return New Ark.Configs.CraftingCosts(SaveData, Identity, Project)
		  Case NameCustomContent
		    Return New Ark.Configs.CustomContent(SaveData, Identity, Project)
		  Case NameDayCycle
		    Return New Ark.Configs.DayCycle(SaveData, Identity, Project)
		  Case NameDifficulty
		    Return New Ark.Configs.Difficulty(SaveData, Identity, Project)
		  Case NameDinoAdjustments
		    Return New Ark.Configs.DinoAdjustments(SaveData, Identity, Project)
		  Case NameEngramControl
		    Return New Ark.Configs.EngramControl(SaveData, Identity, Project)
		  Case NameExperienceCurves
		    Return New Ark.Configs.ExperienceCurves(SaveData, Identity, Project)
		  Case NameHarvestRates
		    Return New Ark.Configs.HarvestRates(SaveData, Identity, Project)
		  Case NameLootDrops
		    Return New Ark.Configs.LootDrops(SaveData, Identity, Project)
		  Case NameSpawnPoints
		    Return New Ark.Configs.SpawnPoints(SaveData, Identity, Project)
		  Case NameStackSizes
		    Return New Ark.Configs.StackSizes(SaveData, Identity, Project)
		  Case NameStatLimits
		    Return New Ark.Configs.StatLimits(SaveData, Identity, Project)
		  Case NameStatMultipliers
		    Return New Ark.Configs.StatMultipliers(SaveData, Identity, Project)
		  Case NameSpoilTimers
		    Return New Ark.Configs.SpoilTimers(SaveData, Identity, Project)
		  Case NameOtherSettings
		    Return New Ark.Configs.OtherSettings(SaveData, Identity, Project)
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + InternalName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(InternalName As String, ParsedData As Dictionary, CommandLineOptions As Dictionary, Project As Ark.Project) As Ark.ConfigGroup
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigOmniCache As Dictionary
	#tag EndProperty


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

	#tag Constant, Name = NameOtherSettings, Type = String, Dynamic = False, Default = \"OtherSettings", Scope = Protected
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


End Module
#tag EndModule
