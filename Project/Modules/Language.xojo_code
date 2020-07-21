#tag Module
Protected Module Language
	#tag Method, Flags = &h0
		Function EnglishOxfordList(Extends Items() As String) As String
		  Return EnglishOxfordList(Items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EnglishOxfordList(Items() As String) As String
		  If Items.LastRowIndex = -1 Then
		    Return ""
		  ElseIf Items.LastRowIndex = 0 Then
		    Return Items(0)
		  ElseIf Items.LastRowIndex = 1 Then
		    Return Items(0) + " and " + Items(1)
		  Else
		    Var LastItem As String = Items(Items.LastRowIndex)
		    Items.RemoveRowAt(Items.LastRowIndex)
		    Var List As String = Items.Join(", ") + ", and " + LastItem
		    Items.AddRow(LastItem) // Gotta put it back
		    Return List
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FolderItemErrorReason(ErrorCode As Integer) As String
		  Select Case ErrorCode
		  Case FolderItem.DestDoesNotExistError
		    Return "The destination does not exist"
		  Case FolderItem.FileNotFound
		    Return "File not found"
		  Case FolderItem.AccessDenied
		    Return "Permission denied"
		  Case FolderItem.NotEnoughMemory
		    Return "Out of memory"
		  Case FolderItem.FileInUse
		    Return "File is in use"
		  Case FolderItem.InvalidName
		    Return "Filename is invalid"
		  Else
		    Return "Other error #" + ErrorCode.ToString
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(Config As Beacon.ConfigGroup) As String
		  Return Language.LabelForConfig(Config.ConfigName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForConfig(ConfigName As String) As String
		  Select Case ConfigName
		  Case BeaconConfigs.Difficulty.ConfigName
		    Return "Difficulty"
		  Case BeaconConfigs.LootDrops.ConfigName
		    Return "Loot Drop Contents"
		  Case BeaconConfigs.LootScale.ConfigName
		    Return "Loot Quality Scaling"
		  Case BeaconConfigs.Metadata.ConfigName
		    Return "Document Properties"
		  Case BeaconConfigs.ExperienceCurves.ConfigName
		    Return "Player and Tame Levels"
		  Case BeaconConfigs.CustomContent.ConfigName
		    Return "Custom Config Content"
		  Case BeaconConfigs.CraftingCosts.ConfigName
		    Return "Crafting Costs"
		  Case BeaconConfigs.StackSizes.ConfigName
		    Return "Stack Sizes"
		  Case BeaconConfigs.BreedingMultipliers.ConfigName
		    Return "Breeding Multipliers"
		  Case BeaconConfigs.HarvestRates.ConfigName
		    Return "Harvest Rates"
		  Case BeaconConfigs.DinoAdjustments.ConfigName
		    Return "Creature Adjustments"
		  Case BeaconConfigs.StatMultipliers.ConfigName
		    Return "Player and Creature Stat Multipliers"
		  Case BeaconConfigs.DayCycle.ConfigName
		    Return "Day and Night Cycle"
		  Case BeaconConfigs.SpawnPoints.ConfigName
		    Return "Creature Spawn Points"
		  Case BeaconConfigs.StatLimits.ConfigName
		    Return "Item Stat Limits"
		  Case BeaconConfigs.EngramControl.ConfigName
		    Return "Engram Control"
		  Case "deployments"
		    Return "Servers"
		  Case "maps"
		    Return "Maps"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForQuality(Quality As Beacon.Quality, Abbreviated As Boolean = False) As String
		  Select Case Quality.Key
		  Case Beacon.Qualities.Tier1.Key
		    Return If(Abbreviated, QualityTier1Abbreviated, QualityTier1)
		  Case Beacon.Qualities.Tier2.Key
		    Return If(Abbreviated, QualityTier2Abbreviated, QualityTier2)
		  Case Beacon.Qualities.Tier3.Key
		    Return If(Abbreviated, QualityTier3Abbreviated, QualityTier3)
		  Case Beacon.Qualities.Tier4.Key
		    Return If(Abbreviated, QualityTier4Abbreviated, QualityTier4)
		  Case Beacon.Qualities.Tier5.Key
		    Return If(Abbreviated, QualityTier5Abbreviated, QualityTier5)
		  Case Beacon.Qualities.Tier6.Key
		    Return If(Abbreviated, QualityTier6Abbreviated, QualityTier6)
		  Case Beacon.Qualities.Tier7.Key
		    Return If(Abbreviated, QualityTier7Abbreviated, QualityTier7)
		  Case Beacon.Qualities.Tier8.Key
		    Return If(Abbreviated, QualityTier8Abbreviated, QualityTier8)
		  Case Beacon.Qualities.Tier9.Key
		    Return If(Abbreviated, QualityTier9Abbreviated, QualityTier9)
		  Case Beacon.Qualities.Tier10.Key
		    Return If(Abbreviated, QualityTier10Abbreviated, QualityTier10)
		  Else
		    Return Quality.BaseValue.PrettyText(2)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LabelForStat(Stat As Beacon.Stat) As String
		  If Stat Is Nil Then
		    Return "Unknown Stat"
		  End If
		  
		  Select Case Stat
		  Case Beacon.Stats.CraftingSpeed
		    Return "Crafting"
		  Case Beacon.Stats.Food
		    Return "Food"
		  Case Beacon.Stats.Fortitude
		    Return "Fortitude"
		  Case Beacon.Stats.Health
		    Return "Health"
		  Case Beacon.Stats.Melee
		    Return "Melee"
		  Case Beacon.Stats.Oxygen
		    Return "Oxygen"
		  Case Beacon.Stats.Speed
		    Return "Speed"
		  Case Beacon.Stats.Stamina
		    Return "Stamina"
		  Case Beacon.Stats.Temperature
		    Return "Temperature"
		  Case Beacon.Stats.Torpor
		    Return "Torpor"
		  Case Beacon.Stats.Water
		    Return "Water"
		  Case Beacon.Stats.Weight
		    Return "Weight"
		  Else
		    Return "Stat " + Str(Stat.Index, "-0")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NounWithQuantity(Quantity As Integer, Singular As String, Plural As String) As String
		  Return Format(Quantity, "-0,") + " " + If(Quantity = 1, Singular, Plural)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplacePlaceholders(Source As String, ParamArray Values() As String) As String
		  For I As Integer = 0 To Values.LastRowIndex
		    Var Placeholder As String = "?" + Str(I + 1, "0")
		    Source = Source.ReplaceAll(Placeholder, Values(I))
		  Next
		  Return Source
		End Function
	#tag EndMethod


	#tag Constant, Name = ExperimentalWarningActionCaption, Type = String, Dynamic = True, Default = \"Continue", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningCancelCaption, Type = String, Dynamic = True, Default = \"Cancel", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningExplanation, Type = String, Dynamic = True, Default = \"The \"\?1\" loot source is only partially supported by Beacon. Its behavior may be unpredictable\x2C both in terms of item quality and quantity. Are you sure you want to continue\?", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ExperimentalWarningMessage, Type = String, Dynamic = True, Default = \"You are adding an experimental loot source.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindBonus, Type = String, Dynamic = True, Default = \"Bonus Beacon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindCave, Type = String, Dynamic = True, Default = \"Cave", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindSea, Type = String, Dynamic = True, Default = \"Deep Sea && Open Desert", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LootSourceKindStandard, Type = String, Dynamic = True, Default = \"Standard Beacon", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier1, Type = String, Dynamic = False, Default = \"Primitive", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier10, Type = String, Dynamic = False, Default = \"Perfected", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier10Abbreviated, Type = String, Dynamic = False, Default = \"Perf", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier1Abbreviated, Type = String, Dynamic = False, Default = \"Prim", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier2, Type = String, Dynamic = False, Default = \"Ramshackle", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier2Abbreviated, Type = String, Dynamic = False, Default = \"Rams", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier3, Type = String, Dynamic = False, Default = \"Apprentice", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier3Abbreviated, Type = String, Dynamic = False, Default = \"Appr", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier4, Type = String, Dynamic = False, Default = \"Journeyman", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier4Abbreviated, Type = String, Dynamic = False, Default = \"Jrnymn", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier5, Type = String, Dynamic = False, Default = \"Mastercraft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier5Abbreviated, Type = String, Dynamic = False, Default = \"Mstrcft", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier6, Type = String, Dynamic = False, Default = \"Ascendant", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier6Abbreviated, Type = String, Dynamic = False, Default = \"Asndt", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier7, Type = String, Dynamic = False, Default = \"Epic", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier7Abbreviated, Type = String, Dynamic = False, Default = \"Epic", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier8, Type = String, Dynamic = False, Default = \"Legendary", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier8Abbreviated, Type = String, Dynamic = False, Default = \"Lgndry", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier9, Type = String, Dynamic = False, Default = \"Pearlescent", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QualityTier9Abbreviated, Type = String, Dynamic = False, Default = \"Pearl", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
