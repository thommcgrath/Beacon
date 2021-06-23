#tag Interface
Protected Interface DataSource
	#tag Method, Flags = &h0
		Sub AddPresetModifier(ParamArray Modifiers() As Beacon.PresetModifier)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddPresetModifier(Modifiers() As Beacon.PresetModifier)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllMods() As Beacon.ModDetails()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafeMods() As Beacon.ModDetails()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeletePreset(Preset As Beacon.Preset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeletePresetModifier(Modifiers() As Beacon.PresetModifier) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeletePresetModifier(ParamArray Modifiers() As Beacon.PresetModifier) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramIsCustom(Engram As Beacon.Engram) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintByID(ObjectID As v4UUID) As Beacon.Blueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.Blueprint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByPath(Path As String, Mods As Beacon.StringList) As Beacon.Blueprint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As String, Default As Boolean = False) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfigKey(KeyUUID As String) As Beacon.ConfigKey
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByID(CreatureID As v4UUID) As Beacon.Creature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorByID(ID As Integer) As Beacon.CreatureColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorSetByClass(ClassString As String) As Beacon.CreatureColorSet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureColorSetByUUID(UUID As String) As Beacon.CreatureColorSet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.Creature()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByPath(Path As String, Mods As Beacon.StringList) As Beacon.Creature()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As String, Default As Double = 0.0) As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByID(EngramID As v4UUID) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByItemID(ItemID As Integer) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByEntryString(EntryString As String, Mods As Beacon.StringList) As Beacon.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByPath(Path As String, Mods As Beacon.StringList) As Beacon.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGameEventByArkCode(ArkCode As String) As Beacon.GameEvent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGameEventByUUID(EventUUID As String) As Beacon.GameEvent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As String, Default As Integer = 0) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As String) As Beacon.LootSource
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMap(Named As String) As Beacon.Map
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps() As Beacon.Map()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMaps(Mask As UInt64) As Beacon.Map()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetModWithID(ModID As v4UUID) As Beacon.ModDetails
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetModWithWorkshopID(WorkshopID As Integer) As Beacon.ModDetails
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPreset(PresetID As String) As Beacon.Preset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifier(ModifierID As String) As Beacon.PresetModifier
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifiers(IncludeOfficial As Boolean = True, IncludeCustom As Boolean = True) As Beacon.PresetModifier()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByID(SpawnPointID As v4UUID) As Beacon.SpawnPoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByClass(ClassString As String, Mods As Beacon.StringList) As Beacon.SpawnPoint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByPath(Path As String, Mods As Beacon.StringList) As Beacon.SpawnPoint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsForCreature(Creature As Beacon.Creature, Mods As Beacon.StringList, Tags As String) As Beacon.SpawnPoint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStringVariable(Key As String, Default As String = "") As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastEditTime() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LoadIngredientsForEngram(Engram As Beacon.Engram) As Beacon.RecipeIngredient()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadPresets()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OfficialPlayerLevelData() As Beacon.PlayerLevelData
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Presets() As Beacon.Preset()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResolvePathFromClassString(ClassString As String) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveBlueprints(BlueprintsToSave() As Beacon.Blueprint, BlueprintsToDelete() As Beacon.Blueprint, ErrorDict As Dictionary) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SavePreset(Preset As Beacon.Preset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForBlueprints(Category As String, SearchText As String, Mods As Beacon.StringList, Tags As String) As Beacon.Blueprint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForConfigKey(File As String, Header As String, Key As String) As Beacon.ConfigKey()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForCreatureColors(Label As String = "") As Beacon.CreatureColor()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForCreatureColorSets(Label As String = "") As Beacon.CreatureColorSet()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForEngramEntries(SearchText As String, Mods As Beacon.StringList, Tags As String) As Beacon.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForGameEvents(Label As String = "") As Beacon.GameEvent()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As String, Mods As Beacon.StringList, IncludeExperimental As Boolean) As Beacon.LootSource()
		  
		End Function
	#tag EndMethod


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
End Interface
#tag EndInterface
