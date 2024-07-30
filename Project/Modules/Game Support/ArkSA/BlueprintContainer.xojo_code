#tag Class
Protected Class BlueprintContainer
Implements ArkSA.BlueprintProvider
	#tag Method, Flags = &h0
		Function BlueprintIsCustom(Item As ArkSA.Blueprint) As Boolean
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  #Pragma Unused Item
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintProviderId() As String
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Return Self.mBlueprintProviderId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BlueprintProviderId As String, Sources() As Dictionary)
		  Self.mBlueprintProviderId = BlueprintProviderId
		  
		  // We want the contents of the dictionaries to be editable be callers, but not the list of dictionaries
		  For Each Source As Dictionary In Sources
		    If Source Is Nil Then
		      Continue
		    End If
		    
		    Self.mSources.Add(Source)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BlueprintProviderId As String, ParamArray Sources() As Dictionary)
		  Self.Constructor(BlueprintProviderId, Sources)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprint(BlueprintId As String, UseCache As Boolean = True) As ArkSA.Blueprint
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  #Pragma Unused UseCache
		  
		  For Each Source As Dictionary In Self.mSources
		    If Source.HasKey(BlueprintId) = False Then
		      Continue
		    End If
		    
		    Var Value As Variant = Source.Value(BlueprintId)
		    If Value.Type <> Variant.TypeObject Or Value.IsNull Then
		      // Not continue because it means this source has the blueprint id, but it's not a blueprint.
		      // This would be something like BlueprintController which stores strings for deleted
		      // blueprints in its mChanges dictionary.
		      Return Nil
		    End If
		    
		    Return ArkSA.Blueprint(Value.ObjectValue)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprints(Category As String, SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec, ExtraClauses() As String, ExtraValues() As Variant) As ArkSA.Blueprint()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  #if DebugBuild
		    If ExtraClauses.Count > 0 Or ExtraValues.Count > 0 Then
		      Break
		    End If
		  #endif
		  
		  Var SearchFlags As Integer
		  If SearchText.IsEmpty = False Then
		    If SearchText.BeginsWith("path:") Then
		      SearchFlags = ArkSA.FlagMatchPath
		      SearchText = SearchText.Middle(5)
		    ElseIf SearchText.BeginsWith("label:") Then
		      SearchFlags = ArkSA.FlagMatchLabel
		      SearchText = SearchText.Middle(6)
		    ElseIf SearchText.BeginsWith("class:") Then
		      SearchFlags = ArkSA.FlagMatchClass
		      SearchText = SearchText.Middle(6)
		    ElseIf SearchText.BeginsWith("unlock:") Then
		      SearchFlags = ArkSA.FlagMatchUnlockString
		      SearchText = SearchText.Middle(7)
		    ElseIf SearchText.BeginsWith("id:") Then
		      SearchFlags = ArkSA.FlagMatchBlueprintId
		      SearchText = SearchText.Middle(3)
		    Else
		      SearchFlags = ArkSA.FlagMatchAny
		    End If
		  End If
		  
		  Var Results() As ArkSA.Blueprint
		  Var CheckedIds As New Dictionary
		  Var MatchSearchText As Boolean = SearchText.IsEmpty = False
		  Var MatchCategory As Boolean = Category.IsEmpty = False
		  Var MatchContentPack As Boolean = (ContentPacks Is Nil) = False And ContentPacks.Count > 0
		  Var MatchTags As Boolean = (Tags Is Nil) = False And Tags.IsEmpty = False
		  For Each Source As Dictionary In Self.mSources
		    For Each Entry As DictionaryEntry In Source
		      Var BlueprintId As String = Entry.Key
		      If CheckedIds.HasKey(BlueprintId) Then
		        Continue
		      End If
		      CheckedIds.Value(BlueprintId) = True
		      
		      If Entry.Value.Type <> Variant.TypeObject Or (Entry.Value.ObjectValue IsA ArkSA.Blueprint) = False Then
		        Continue
		      End If
		      
		      Var Blueprint As ArkSA.Blueprint = Entry.Value
		      If MatchCategory And Blueprint.Category <> Category Then
		        Continue
		      End If
		      
		      If MatchSearchText And Blueprint.Matches(SearchText, SearchFlags) = False Then
		        Continue
		      End If
		      
		      If MatchTags And Blueprint.Matches(Tags) = False Then
		        Continue
		      End If
		      
		      If MatchContentPack And ContentPacks.Contains(Blueprint.ContentPackId) = False Then
		        Continue
		      End If
		      
		      Results.Add(Blueprint)
		    Next
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintsByPath(Path As String, ContentPacks As Beacon.StringList, UseCache As Boolean = True) As ArkSA.Blueprint()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  #Pragma Unused UseCache
		  Return Self.GetBlueprints("", "path:" + Path, ContentPacks, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreature(CreatureId As String, UseCache As Boolean = True) As ArkSA.Creature
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprint As ArkSA.Blueprint = Self.GetBlueprint(CreatureId, UseCache)
		  If (Blueprint Is Nil) = False And Blueprint IsA ArkSA.Creature Then
		    Return ArkSA.Creature(Blueprint)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatures(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.Creature()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryCreatures, SearchText, ContentPacks, Tags)
		  Var Results() As ArkSA.Creature
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Creature(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.Creature()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryCreatures, "class:" + ClassString, ContentPacks, Nil)
		  Var Results() As ArkSA.Creature
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Creature(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreaturesByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.Creature()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryCreatures, "path:" + Path, ContentPacks, Nil)
		  Var Results() As ArkSA.Creature
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Creature(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngram(EngramId As String, UseCache As Boolean = True) As ArkSA.Engram
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprint As ArkSA.Blueprint = Self.GetBlueprint(EngramId, UseCache)
		  If (Blueprint Is Nil) = False And Blueprint IsA ArkSA.Engram Then
		    Return ArkSA.Engram(Blueprint)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByItemID(ItemId As Integer) As ArkSA.Engram
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryEngrams, "", Nil, Nil)
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Blueprint IsA ArkSA.Engram And (ArkSA.Engram(Blueprint).ItemID Is Nil) = False And ArkSA.Engram(Blueprint).ItemID.IntegerValue = ItemId Then
		      Return ArkSA.Engram(Blueprint)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramEntries(SearchText As String, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec) As ArkSA.Engram()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryEngrams, SearchText, ContentPacks, Tags)
		  Var Results() As ArkSA.Engram
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    If Blueprint IsA ArkSA.Engram And ArkSA.Engram(Blueprint).HasUnlockDetails Then
		      Results.Add(ArkSA.Engram(Blueprint))
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngrams(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.Engram()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryEngrams, SearchText, ContentPacks, Tags)
		  Var Results() As ArkSA.Engram
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Engram(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.Engram()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryEngrams, "class:" + ClassString, ContentPacks, Nil)
		  Var Results() As ArkSA.Engram
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Engram(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByEntryString(EntryString As String, ContentPacks As Beacon.StringList) As ArkSA.Engram()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryEngrams, "unlock:" + EntryString, ContentPacks, Nil)
		  Var Results() As ArkSA.Engram
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Engram(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramsByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.Engram()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryEngrams, "path:" + Path, ContentPacks, Nil)
		  Var Results() As ArkSA.Engram
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.Engram(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainer(LootDropId As String, UseCache As Boolean = True) As ArkSA.LootContainer
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprint As ArkSA.Blueprint = Self.GetBlueprint(LootDropId, UseCache)
		  If (Blueprint Is Nil) = False And Blueprint IsA ArkSA.LootContainer Then
		    Return ArkSA.LootContainer(Blueprint)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainers(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil, IncludeExperimental As Boolean = False) As ArkSA.LootContainer()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryLootContainers, SearchText, ContentPacks, Tags)
		  Var Results() As ArkSA.LootContainer
		  For Idx As Integer = 0 To Blueprints.LastIndex
		    Var Container As ArkSA.LootContainer = ArkSA.LootContainer(Blueprints(Idx))
		    If Container Is Nil Then
		      Continue
		    End If
		    If IncludeExperimental = True Or Container.Experimental = False Then
		      Results.Add(Container)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.LootContainer()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryLootContainers, "class:" + ClassString, ContentPacks, Nil)
		  Var Results() As ArkSA.LootContainer
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.LootContainer(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootContainersByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.LootContainer()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategoryLootContainers, "path:" + Path, ContentPacks, Nil)
		  Var Results() As ArkSA.LootContainer
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.LootContainer(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRecipeEngramIds(ContentPacks As Beacon.StringList, Mask As UInt64) As String()
		  Var Engrams() As ArkSA.Engram = Self.GetEngrams("", ContentPacks, Nil)
		  Var Matches() As String
		  For Each Engram As ArkSA.Engram In Engrams
		    If (Engram.Availability And Mask) = 0 Then
		      Continue
		    End If
		    
		    Var Ingredients() As ArkSA.CraftingCostIngredient = Engram.Recipe()
		    If Ingredients Is Nil Or Ingredients.Count = 0 Then
		      Continue
		    End If
		    
		    Matches.Add(Engram.BlueprintId)
		  Next
		  Return Matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoint(SpawnPointId As String, UseCache As Boolean = True) As ArkSA.SpawnPoint
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprint As ArkSA.Blueprint = Self.GetBlueprint(SpawnPointId, UseCache)
		  If (Blueprint Is Nil) = False And Blueprint IsA ArkSA.SpawnPoint Then
		    Return ArkSA.SpawnPoint(Blueprint)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoints(SearchText As String = "", ContentPacks As Beacon.StringList = Nil, Tags As Beacon.TagSpec = Nil) As ArkSA.SpawnPoint()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategorySpawnPoints, SearchText, ContentPacks, Tags)
		  Var Results() As ArkSA.SpawnPoint
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.SpawnPoint(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByClass(ClassString As String, ContentPacks As Beacon.StringList) As ArkSA.SpawnPoint()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategorySpawnPoints, "class:" + ClassString, ContentPacks, Nil)
		  Var Results() As ArkSA.SpawnPoint
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.SpawnPoint(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsByPath(Path As String, ContentPacks As Beacon.StringList) As ArkSA.SpawnPoint()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(ArkSA.CategorySpawnPoints, "path:" + Path, ContentPacks, Nil)
		  Var Results() As ArkSA.SpawnPoint
		  Results.ResizeTo(Blueprints.LastIndex)
		  For Idx As Integer = 0 To Results.LastIndex
		    Results(Idx) = ArkSA.SpawnPoint(Blueprints(Idx))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointsForCreature(Creature As ArkSA.Creature, ContentPacks As Beacon.StringList, Tags As Beacon.TagSpec) As ArkSA.SpawnPoint()
		  Var Points() As ArkSA.SpawnPoint = Self.GetSpawnPoints("", ContentPacks, Tags)
		  Var Matches() As ArkSA.SpawnPoint
		  For Each Point As ArkSA.SpawnPoint In Points
		    If Point.Contains(Creature) Then
		      Matches.Add(Point)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTags(ContentPackIds As Beacon.StringList, Category As String = "") As String()
		  // Part of the ArkSA.BlueprintProvider interface.
		  
		  Var ExtraClauses() As String
		  Var ExtraValues() As Variant
		  Var Blueprints() As ArkSA.Blueprint = Self.GetBlueprints(Category, "", ContentPackIds, Nil, ExtraClauses, ExtraValues)
		  Var Unique As New Dictionary
		  Var Tags() As String
		  
		  For Each Blueprint As ArkSA.Blueprint In Blueprints
		    Var BlueprintTags() As String = Blueprint.Tags
		    For Each BlueprintTag As String In BlueprintTags
		      If Unique.HasKey(BlueprintTag) Then
		        Continue
		      End If
		      
		      Tags.Add(BlueprintTag)
		      Unique.Value(BlueprintTag) = True
		    Next
		  Next
		  Tags.Sort
		  
		  Return Tags
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBlueprintProviderId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSources() As Dictionary
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
