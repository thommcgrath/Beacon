#tag Module
Protected Module BeaconConfigs
	#tag Method, Flags = &h1
		Protected Function AllConfigNames(Human As Boolean = False) As String()
		  Static Names() As String
		  If Names.LastIndex = -1 Then
		    Names.Add(NameDifficulty)
		    Names.Add(NameLootDrops)
		    Names.Add(NameLootScale)
		    Names.Add(NameMetadata)
		    Names.Add(NameExperienceCurves)
		    Names.Add(NameCustomContent)
		    Names.Add(NameCraftingCosts)
		    Names.Add(NameStackSizes)
		    Names.Add(NameBreedingMultipliers)
		    Names.Add(NameHarvestRates)
		    Names.Add(NameDinoAdjustments)
		    Names.Add(NameStatMultipliers)
		    Names.Add(NameDayCycle)
		    Names.Add(NameSpawnPoints)
		    Names.Add(NameStatLimits)
		    Names.Add(NameEngramControl)
		    #if SpoilingEnabled
		      Names.Add(NameSpoilTimers)
		    #endif
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
		Protected Function ConfigPurchased(Config As Beacon.ConfigGroup, PurchasedVersion As Integer) As Boolean
		  Return ConfigPurchased(Config.ConfigName, PurchasedVersion)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ConfigPurchased(ConfigName As String, PurchasedVersion As Integer) As Boolean
		  Var RequiredVersion As Integer = 0
		  Select Case ConfigName
		  Case NameCraftingCosts, NameDinoAdjustments, NameEngramControl, NameExperienceCurves, NameHarvestRates, NameSpawnPoints, NameStackSizes
		    RequiredVersion = 1
		  End Select
		  
		  Return PurchasedVersion >= RequiredVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String) As Beacon.ConfigGroup
		  Select Case GroupName
		  Case NameBreedingMultipliers
		    Return New BreedingMultipliers()
		  Case NameCraftingCosts
		    Return New CraftingCosts()
		  Case NameCustomContent
		    Return New CustomContent()
		  Case NameDayCycle
		    Return New DayCycle()
		  Case NameDifficulty
		    Return New Difficulty()
		  Case NameDinoAdjustments
		    Return New DinoAdjustments()
		  Case NameEngramControl
		    Return New EngramControl()
		  Case NameExperienceCurves
		    Return New ExperienceCurves()
		  Case NameHarvestRates
		    Return New HarvestRates()
		  Case NameLootDrops
		    Return New LootDrops()
		  Case NameLootScale
		    Return New LootScale()
		  Case NameMetadata
		    Return New Metadata()
		  Case NameSpawnPoints
		    Return New SpawnPoints()
		  Case NameStackSizes
		    Return New StackSizes()
		  Case NameStatLimits
		    Return New StatLimits()
		  Case NameStatMultipliers
		    Return New StatMultipliers()
		    #if SpoilingEnabled
		  Case NameSpoilTimers
		    Return New SpoilTimers
		    #endif
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + GroupName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String, GroupData As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document) As Beacon.ConfigGroup
		  Select Case GroupName
		  Case NameBreedingMultipliers
		    Return New BreedingMultipliers(GroupData, Identity, Document)
		  Case NameCraftingCosts
		    Return New CraftingCosts(GroupData, Identity, Document)
		  Case NameCustomContent
		    Return New CustomContent(GroupData, Identity, Document)
		  Case NameDayCycle
		    Return New DayCycle(GroupData, Identity, Document)
		  Case NameDifficulty
		    Return New Difficulty(GroupData, Identity, Document)
		  Case NameDinoAdjustments
		    Return New DinoAdjustments(GroupData, Identity, Document)
		  Case NameEngramControl
		    Return New EngramControl(GroupData, Identity, Document)
		  Case NameExperienceCurves
		    Return New ExperienceCurves(GroupData, Identity, Document)
		  Case NameHarvestRates
		    Return New HarvestRates(GroupData, Identity, Document)
		  Case NameLootDrops
		    Return New LootDrops(GroupData, Identity, Document)
		  Case NameLootScale
		    Return New LootScale(GroupData, Identity, Document)
		  Case NameMetadata
		    Return New Metadata(GroupData, Identity, Document)
		  Case NameSpawnPoints
		    Return New SpawnPoints(GroupData, Identity, Document)
		  Case NameStackSizes
		    Return New StackSizes(GroupData, Identity, Document)
		  Case NameStatLimits
		    Return New StatLimits(GroupData, Identity, Document)
		  Case NameStatMultipliers
		    Return New StatMultipliers(GroupData, Identity, Document)
		    #if SpoilingEnabled
		  Case NameSpoilTimers
		    Return New SpoilTimers(GroupData, Identity, Document)
		    #endif
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + GroupName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateInstance(GroupName As String, ParsedData As Dictionary, CommandLineOptions As Dictionary, Document As Beacon.Document) As Beacon.ConfigGroup
		  Select Case GroupName
		  Case NameBreedingMultipliers
		    Return BreedingMultipliers.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameCraftingCosts
		    Return CraftingCosts.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameCustomContent
		    Return Nil
		  Case NameDayCycle
		    Return DayCycle.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameDifficulty
		    Return Nil
		  Case NameDinoAdjustments
		    Return DinoAdjustments.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameEngramControl
		    Return EngramControl.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameExperienceCurves
		    Return ExperienceCurves.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameHarvestRates
		    Return HarvestRates.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameLootDrops
		    Return LootDrops.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameLootScale
		    Return LootScale.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameMetadata
		    Return Metadata.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameSpawnPoints
		    Return SpawnPoints.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameStackSizes
		    Return StackSizes.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameStatLimits
		    Return StatLimits.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameStatMultipliers
		    Return StatMultipliers.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		    #if SpoilingEnabled
		  Case NameSpoilTimers
		    Return SpoilTimers.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		    #endif
		  Else
		    Var Err As New FunctionNotFoundException
		    Err.Message = "Config group """ + GroupName + """ is not known."
		    Raise Err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Purchased(Extends Config As Beacon.ConfigGroup, PurchasedVersion As Integer) As Boolean
		  Return ConfigPurchased(Config.ConfigName, PurchasedVersion)
		End Function
	#tag EndMethod


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

	#tag Constant, Name = NameLootScale, Type = String, Dynamic = False, Default = \"LootScale", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameMetadata, Type = String, Dynamic = False, Default = \"Metadata", Scope = Protected
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

	#tag Constant, Name = SpoilingEnabled, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
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
