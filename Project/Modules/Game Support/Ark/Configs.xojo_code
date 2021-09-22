#tag Module
Protected Module Configs
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
