#tag Interface
Protected Interface BlueprintProvider
	#tag Method, Flags = &h0
		Function AuthoritativeForContentPackIds() As String()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintIsCustom(Item As ArkSA.Blueprint) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintProviderId() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprint(BlueprintId As String, UseCache As Boolean = True) As ArkSA.Blueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(Category As String, SearchText As String, ContentPacks As Beacon.StringList, Tags As String, ExtraClauses() As String, ExtraValues() As Variant) As ArkSA.Blueprint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByPath(Path As String, ContentPacks As Beacon.StringList, UseCache As Boolean = True) As ArkSA.Blueprint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreature(CreatureId As String, UseCache As Boolean = True) As ArkSA.Creature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatures(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As String = "") As ArkSA.Creature()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.Creature()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.Creature()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngram(EngramId As String, UseCache As Boolean = True) As ArkSA.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByItemID(ItemId As Integer) As ArkSA.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramEntries(SearchText As String, ContentPacks As Beacon.StringList, Tags As String) As ArkSA.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngrams(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As String = "") As ArkSA.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByEntryString(EntryString As String, ContentPacks As Beacon.StringList) As ArkSA.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainer(LootDropId As String, UseCache As Boolean = True) As ArkSA.LootContainer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainers(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As String = "", IncludeExperimental As Boolean = False) As ArkSA.LootContainer()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.LootContainer()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.LootContainer()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoint(SpawnPointId As String, UseCache As Boolean = True) As ArkSA.SpawnPoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoints(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As String = "") As ArkSA.SpawnPoint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.SpawnPoint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.SpawnPoint()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTags(ContentPackIds As Beacon.StringList, Category As String = "") As String()
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
