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
		    Names.Add(NameSpoilTimers)
		    Names.Add(NameOtherSettings)
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
		Protected Function AllTasks() As BeaconConfigs.Task()
		  Static Tasks() As BeaconConfigs.Task
		  If Tasks.LastIndex = -1 Then
		    Tasks.Add(New BeaconConfigs.Task("Adjust All Crafting Costs", "24376f12-c256-440c-87ca-2c8309a7a754", NameCraftingCosts))
		    Tasks.Add(New BeaconConfigs.Task("Setup Fibercraft Server", "94eced5b-be7d-441a-a5b3-f4a9bf40a856", NameCraftingCosts))
		    Tasks.Add(New BeaconConfigs.Task("Setup Transferrable Element", "3db64fe3-9134-4a19-a255-7712c8c70a83", NameCraftingCosts))
		    Tasks.Add(New BeaconConfigs.Task("Convert Creature Replacements to Spawn Point Additions", "614cfc80-b7aa-437d-b17e-01534f2ab778", NameSpawnPoints, NameDinoAdjustments))
		    Tasks.Add(New BeaconConfigs.Task("Setup Guided Editors", "d29dc6f8-e834-4969-9cfe-b38e1c052156", NameCustomContent))
		    Tasks.Add(New BeaconConfigs.Task("Convert Global Harvest Rate to Individual Rates", "5265adcd-5c7e-437c-bce2-d10721afde43", NameHarvestRates))
		    Tasks.Add(New BeaconConfigs.Task("Rebuild Item Sets from Presets", "08efc49c-f39f-4147-820d-201637c206b5", NameLootDrops))
		  End If
		  Return Tasks
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
		  Case NameSpoilTimers
		    Return New SpoilTimers
		  Case NameOtherSettings
		    Return New OtherSettings
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
		  Case NameSpoilTimers
		    Return New SpoilTimers(GroupData, Identity, Document)
		  Case NameOtherSettings
		    Return New OtherSettings(GroupData, Identity, Document)
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
		  Case NameSpoilTimers
		    Return SpoilTimers.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
		  Case NameOtherSettings
		    Return OtherSettings.FromImport(ParsedData, CommandLineOptions, Document.MapCompatibility, Document.Difficulty, Document.Mods)
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

	#tag Method, Flags = &h1
		Protected Function SupportsConfigSets(ConfigName As String) As Boolean
		  If mConfigSetSupport Is Nil Then
		    mConfigSetSupport = New Dictionary
		  End If
		  
		  If mConfigSetSupport.HasKey(ConfigName) = False Then
		    Var Instance As Beacon.ConfigGroup
		    
		    #Pragma BreakOnExceptions False
		    Try
		      Instance = CreateInstance(ConfigName)
		    Catch Err As RuntimeException
		    End Try
		    #Pragma BreakOnExceptions Default
		    
		    If Instance Is Nil Then
		      mConfigSetSupport.Value(ConfigName) = False
		    Else
		      mConfigSetSupport.Value(ConfigName) = Instance.SupportsConfigSets
		    End If
		  End If
		  
		  Return mConfigSetSupport.Value(ConfigName)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigSetSupport As Dictionary
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

	#tag Constant, Name = NameLootScale, Type = String, Dynamic = False, Default = \"LootScale", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NameMetadata, Type = String, Dynamic = False, Default = \"Metadata", Scope = Protected
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
