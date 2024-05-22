#tag Class
Protected Class SpawnPoints
Inherits ArkSA.ConfigGroup
Implements Beacon.BlueprintConsumer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.SpawnPoints = ArkSA.Configs.SpawnPoints(Other)
		  For Each Override As ArkSA.SpawnPointOverride In Source.mOverrides
		    If Override.Mode = ArkSA.SpawnPointOverride.ModeOverride Then
		      // Remove add and subtract
		      Self.Remove(Override.SpawnPointReference, ArkSA.SpawnPointOverride.ModeAppend)
		      Self.Remove(Override.SpawnPointReference, ArkSA.SpawnPointOverride.ModeRemove)
		    Else
		      // Remove replace
		      Self.Remove(Override.SpawnPointReference, ArkSA.SpawnPointOverride.ModeOverride)
		    End If
		    
		    Self.Add(Override)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Project
		  
		  Var ContentPackIds As Beacon.StringList = Project.ContentPacks
		  Var Values() As ArkSA.ConfigValue
		  For Each Override As ArkSA.SpawnPointOverride In Self.mOverrides
		    Var SpawnPoint As ArkSA.Blueprint = Override.SpawnPointReference.Resolve(ContentPackIds)
		    If SpawnPoint Is Nil Or SpawnPoint.ValidForMask(Profile.Mask) = False Then
		      Continue
		    End If
		    
		    Var Value As ArkSA.ConfigValue = Self.ConfigValueForOverride(Override)
		    If (Value Is Nil) = False Then
		      Values.Add(Value)
		    End If
		  Next
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ConfigOverrideNPCSpawnEntriesContainer"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ConfigAddNPCSpawnEntriesContainer"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "ConfigSubtractNPCSpawnEntriesContainer"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mOverrides.Count > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  For Idx As Integer = Self.mOverrides.LastIndex DownTo 0
		    If Self.mOverrides(Idx).SpawnPointReference.Resolve(ContentPackIds, 0) Is Nil Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		      Continue
		    End If
		    
		    Var Mutable As New ArkSA.MutableSpawnPointOverride(Self.mOverrides(Idx))
		    Mutable.PruneUnknownContent(ContentPackIds)
		    If Mutable.Count = 0 Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		    ElseIf Mutable.Hash <> Self.mOverrides(Idx).Hash Then
		      Self.mOverrides(Idx) = New ArkSA.SpawnPointOverride(Mutable)
		      Self.Modified = True
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("overrides") = False Then
		    If SaveData.HasKey("Points") Then
		      // Old style
		      Var Points() As Dictionary
		      Try
		        Points = SaveData.Value("Points").DictionaryArrayValue
		      Catch Err As RuntimeException
		      End Try
		      
		      For Each PointData As Dictionary In Points
		        Var Override As ArkSA.SpawnPointOverride
		        Try
		          Override = ArkSA.SpawnPointOverride.FromLegacy(PointData)
		        Catch Err As RuntimeException
		        End Try
		        If Override Is Nil Then
		          Continue
		        End If
		        
		        Self.mOverrides.Add(Override)
		      Next
		    End If
		    Return
		  End If
		  
		  Var OverrideDicts() As Dictionary
		  Try
		    OverrideDicts = SaveData.Value("overrides").DictionaryArrayValue
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  For Each Dict As Dictionary In OverrideDicts
		    Var Override As ArkSA.SpawnPointOverride
		    Try
		      Override = ArkSA.SpawnPointOverride.FromSaveData(Dict)
		    Catch Err As RuntimeException
		    End Try
		    If Override Is Nil Then
		      Continue
		    End If
		    
		    Self.mOverrides.Add(Override)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  For Each Override As ArkSA.SpawnPointOverride In Self.mOverrides
		    Override.Validate(Location, Issues, Project)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Var Overrides() As Dictionary
		  Overrides.ResizeTo(Self.mOverrides.LastIndex)
		  For Idx As Integer = 0 To Overrides.LastIndex
		    Overrides(Idx) = Self.mOverrides(Idx).SaveData
		  Next
		  SaveData.Value("overrides") = Overrides
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(SpawnPointRef As ArkSA.BlueprintReference, Mode As Integer)
		  If SpawnPointRef Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPointRef.BlueprintId And Self.mOverrides(Idx).Mode = Mode Then
		      Self.mOverrides(Idx) = New ArkSA.SpawnPointOverride(SpawnPointRef, Mode)
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  Self.mOverrides.Add(New ArkSA.SpawnPointOverride(SpawnPointRef, Mode))
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(SpawnPoint As ArkSA.SpawnPoint, Mode As Integer)
		  If SpawnPoint Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPoint.SpawnPointId And Self.mOverrides(Idx).Mode = Mode Then
		      Self.mOverrides(Idx) = New ArkSA.SpawnPointOverride(SpawnPoint, Mode, False)
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  Self.mOverrides.Add(New ArkSA.SpawnPointOverride(SpawnPoint, Mode, False))
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Override As ArkSA.SpawnPointOverride)
		  If Override Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).UniqueKey = Override.UniqueKey Then
		      Self.mOverrides(Idx) = New ArkSA.SpawnPointOverride(Override)
		      Self.Modified = True
		      Return
		    End If
		  Next
		  
		  Self.mOverrides.Add(New ArkSA.SpawnPointOverride(Override))
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ConfigValueForOverride(Override As ArkSA.SpawnPointOverride) As ArkSA.ConfigValue
		  Var RenderedEntries() As String
		  
		  Var Config As String
		  Select Case Override.Mode
		  Case ArkSA.SpawnPointOverride.ModeOverride
		    Config = "ConfigOverrideNPCSpawnEntriesContainer"
		  Case ArkSA.SpawnPointOverride.ModeAppend
		    Config = "ConfigAddNPCSpawnEntriesContainer"
		  Case ArkSA.SpawnPointOverride.ModeRemove
		    Config = "ConfigSubtractNPCSpawnEntriesContainer"
		  Else
		    Return Nil
		  End Select
		  
		  For Each Set As ArkSA.SpawnPointSet In Override
		    Var CreatureClasses(), LevelMembers(), OffsetMembers(), SpawnChanceMembers(), MinLevelMultiplierMembers(), MinLevelOffsetMembers(), MaxLevelMultiplierMembers(), MaxLevelOffsetMembers(), LevelOverrideMembers() As String
		    Var IncludeLevels, IncludeOffsets, IncludeSpawnChance, IncludeMinLevelMultiplier, IncludeMaxLevelMultiplier, IncludeMinLevelOffset, IncludeMaxLevelOffset, IncludeLevelOverride As Boolean
		    Var Entries() As ArkSA.SpawnPointSetEntry = Set.Entries
		    
		    For Each Entry As ArkSA.SpawnPointSetEntry In Entries
		      IncludeLevels = IncludeLevels Or Entry.LevelCount > 0
		      IncludeOffsets = IncludeOffsets Or Entry.Offset <> Nil
		      IncludeSpawnChance = IncludeSpawnChance Or (Entry.SpawnChance Is Nil) = False
		      IncludeMinLevelMultiplier = IncludeMinLevelMultiplier Or Entry.MinLevelMultiplier <> Nil
		      IncludeMinLevelOffset = IncludeMinLevelOffset Or Entry.MinLevelOffset <> Nil
		      IncludeMaxLevelMultiplier = IncludeMaxLevelMultiplier Or Entry.MaxLevelMultiplier <> Nil
		      IncludeMaxLevelOffset = IncludeMaxLevelOffset Or Entry.MaxLevelOffset <> Nil
		      IncludeLevelOverride = IncludeLevelOverride Or Entry.LevelOverride <> Nil
		    Next
		    For Each Entry As ArkSA.SpawnPointSetEntry In Entries
		      // ASA uses full paths *with* _C suffix.
		      CreatureClasses.Add("""" + Entry.Creature.Path + "_C""")
		      
		      If IncludeLevels Then
		        Var Levels() As ArkSA.SpawnPointLevel = Entry.Levels
		        Var MinLevels(), MaxLevels(), Difficulties() As String
		        If Levels.Count > 0 Then
		          For Each Level As ArkSA.SpawnPointLevel In Levels
		            MinLevels.Add(Level.MinLevel.PrettyText)
		            MaxLevels.Add(Level.MaxLevel.PrettyText)
		            Difficulties.Add(Level.Difficulty.PrettyText)
		          Next
		        Else
		          MinLevels.Add("1")
		          MaxLevels.Add("30.999999")
		          Difficulties.Add("0")
		        End If
		        LevelMembers.Add("(EnemyLevelsMin=(" + MinLevels.Join(",") + "),EnemyLevelsMax=(" + MaxLevels.Join(",") + "),GameDifficulties=(" + Difficulties.Join(",") + "))")
		      End If
		      If IncludeOffsets Then
		        Var Offset As Beacon.Point3D = Entry.Offset
		        If Offset <> Nil Then
		          OffsetMembers.Add("(X=" + Offset.X.PrettyText + ",Y=" + Offset.Y.PrettyText + ",Z=" + Offset.Z.PrettyText + ")")
		        Else
		          OffsetMembers.Add("(X=0.0,Y=0.0,Z=0.0)")
		        End If
		      End If
		      If IncludeSpawnChance Then
		        Var Chance As Double = If((Entry.SpawnChance Is Nil) = False, Max(Min(Entry.SpawnChance.DoubleValue, 1.0), 0.0), 1.0)
		        SpawnChanceMembers.Add(Chance.PrettyText)
		      End If
		      If IncludeMinLevelMultiplier Then
		        Var Multiplier As Double = If(Entry.MinLevelMultiplier <> Nil, Entry.MinLevelMultiplier.DoubleValue, 1.0)
		        MinLevelMultiplierMembers.Add(Multiplier.PrettyText)
		      End If
		      If IncludeMinLevelOffset Then
		        Var Offset As Double = If(Entry.MinLevelOffset <> Nil, Entry.MinLevelOffset.DoubleValue, 0.0)
		        MinLevelOffsetMembers.Add(Offset.PrettyText)
		      End If
		      If IncludeMaxLevelMultiplier Then
		        Var Multiplier As Double = If(Entry.MaxLevelMultiplier <> Nil, Entry.MaxLevelMultiplier.DoubleValue, 1.0)
		        MaxLevelMultiplierMembers.Add(Multiplier.PrettyText)
		      End If
		      If IncludeMaxLevelOffset Then
		        Var Offset As Double = If(Entry.MaxLevelOffset <> Nil, Entry.MaxLevelOffset.DoubleValue, 0.0)
		        MaxLevelOffsetMembers.Add(Offset.PrettyText)
		      End If
		      If IncludeLevelOverride Then
		        Var LevelOverride As UInt8 = Round(If(Entry.LevelOverride <> Nil, Entry.LevelOverride.DoubleValue, 1.0))
		        LevelOverrideMembers.Add(LevelOverride.ToString(Locale.Raw, "0"))
		      End If
		    Next
		    
		    Var Members(2) As String
		    Members(0) = "AnEntryName=""" + Set.Label + """"
		    Members(1) = "EntryWeight=" + Set.RawWeight.PrettyText
		    Members(2) = "NPCsToSpawn=(" + CreatureClasses.Join(",") + ")"
		    
		    If IncludeLevels Then
		      Members.Add("NPCDifficultyLevelRanges=(" + LevelMembers.Join(",") + ")")
		    End If
		    If IncludeOffsets Then
		      Members.Add("NPCsSpawnOffsets=(" + OffsetMembers.Join(",") + ")")
		    End If
		    If IncludeSpawnChance Then
		      Members.Add("NPCsToSpawnPercentageChance=(" + SpawnChanceMembers.Join(",") + ")")
		    End If
		    If IncludeMinLevelMultiplier Then
		      Members.Add("NPCMinLevelMultiplier=(" + MinLevelMultiplierMembers.Join(",") + ")")
		    End If
		    If IncludeMinLevelOffset Then
		      Members.Add("NPCMinLevelOffset=(" + MinLevelOffsetMembers.Join(",") + ")")
		    End If
		    If IncludeMaxLevelMultiplier Then
		      Members.Add("NPCMaxLevelMultiplier=(" + MaxLevelMultiplierMembers.Join(",") + ")")
		    End If
		    If IncludeMaxLevelOffset Then
		      Members.Add("NPCMaxLevelOffset=(" + MaxLevelOffsetMembers.Join(",") + ")")
		    End If
		    If IncludeLevelOverride Then
		      Members.Add("NPCOverrideLevel=(" + LevelOverrideMembers.Join(",") + ")")
		    End If
		    
		    If Set.SpreadRadius <> Nil Then
		      Members.Add("ManualSpawnPointSpreadRadius=" + Set.SpreadRadius.DoubleValue.PrettyText)
		    End If
		    
		    If Set.WaterOnlyMinimumHeight <> Nil Then
		      Members.Add("WaterOnlySpawnMinimumWaterHeight=" + Set.WaterOnlyMinimumHeight.DoubleValue.PrettyText)
		    End If
		    
		    If Set.MinDistanceFromStructuresMultiplier <> Nil Then
		      Members.Add("SpawnMinDistanceFromStructuresMultiplier=" + Set.MinDistanceFromStructuresMultiplier.DoubleValue.PrettyText)
		    End If
		    
		    If Set.MinDistanceFromPlayersMultiplier <> Nil Then
		      Members.Add("SpawnMinDistanceFromPlayersMultiplier=" + Set.MinDistanceFromPlayersMultiplier.DoubleValue.PrettyText)
		    End If
		    
		    If Set.MinDistanceFromTamedDinosMultiplier <> Nil Then
		      Members.Add("SpawnMinDistanceFromTamedDinosMultiplier=" + Set.MinDistanceFromTamedDinosMultiplier.DoubleValue.PrettyText)
		    End If
		    
		    If Set.GroupOffset <> Nil Then
		      Var Offset As Beacon.Point3D = Set.GroupOffset
		      Members.Add("GroupSpawnOffset=(X=" + Offset.X.PrettyText + ",Y=" + Offset.Y.PrettyText + ",Z=" + Offset.Z.PrettyText + ")")
		    End If
		    
		    If Set.ReplacesCreatures Then
		      Var ReplacedCreatures() As ArkSA.Creature = Set.ReplacedCreatures()
		      Var Replacements() As String
		      For Each FromCreature As ArkSA.Creature In ReplacedCreatures
		        Var ReplacementCreatures() As ArkSA.Creature = Set.ReplacementCreatures(FromCreature)
		        Var ReplacementClasses(), ReplacementWeights() As String
		        
		        For Each ToCreature As ArkSA.Creature In ReplacementCreatures
		          Var Weight As NullableDouble = Set.CreatureReplacementWeight(FromCreature, ToCreature)
		          If Weight Is Nil Then
		            App.Log("Warning: Could not find weight for replacing " + FromCreature.ClassString + " with " + ToCreature.ClassString)
		            Continue
		          End If
		          ReplacementClasses.Add("""" + ToCreature.Path + "_C""")
		          ReplacementWeights.Add(Weight.DoubleValue.PrettyText)
		        Next
		        
		        If ReplacementClasses.Count > 0 Then
		          Replacements.Add("(FromClass=""" + FromCreature.Path + "_C"",ToClasses=(" + ReplacementClasses.Join(",") + "),Weights=(" + ReplacementWeights.Join(",") + "))")
		        End If
		      Next
		      
		      If Replacements.Count > 0 Then
		        Members.Add("NPCRandomSpawnClassWeights=(" + Replacements.Join(",") + ")")
		      End If
		    End If
		    
		    If IncludeMinLevelMultiplier Or IncludeMaxLevelMultiplier Or IncludeMinLevelOffset Or IncludeMaxLevelOffset Or IncludeLevelOverride Then
		      Members.Add("bAddLevelOffsetBeforeMultiplier=" + If(Set.LevelOffsetBeforeMultiplier, "True", "False"))
		    End If
		    
		    If Set.ColorSetClass.IsEmpty = False Then
		      Members.Add("ColorSets=""" + Set.ColorSetClass + """")
		    End If
		    
		    RenderedEntries.Add("(" + Members.Join(",") + ")")
		  Next
		  
		  Var Pieces() As String
		  Pieces.Add("NPCSpawnEntriesContainerClassString=""" + Override.SpawnPointReference.ClassString + """")
		  Pieces.Add("NPCSpawnEntries=(" + RenderedEntries.Join(",") + ")")
		  
		  Var LimitedCreatureRefs() As ArkSA.BlueprintReference = Override.LimitedCreatureRefs
		  If LimitedCreatureRefs.Count > 0 Then
		    Var LimitConfigs() As String
		    For Each CreatureRef As ArkSA.BlueprintReference In LimitedCreatureRefs
		      Var Limit As Double = Override.Limit(CreatureRef)
		      If Limit >= 1.0 Then
		        Continue
		      End If
		      Var LimitPath As String = CreatureRef.Path
		      If LimitPath.IsEmpty Then
		        Var Creature As ArkSA.Blueprint = CreatureRef.Resolve()
		        If Creature Is Nil Then
		          Continue
		        End If
		        LimitPath = Creature.Path
		      End If
		      LimitConfigs.Add("(NPCClass=""" + LimitPath + "_C"",MaxPercentageOfDesiredNumToAllow=" + Limit.PrettyText + ")")
		    Next
		    If LimitConfigs.Count > 0 Then
		      Pieces.Add("NPCSpawnLimits=(" + LimitConfigs.Join(",") + ")")
		    End If
		  End If
		  
		  Return New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, Config + "=(" + Pieces.Join(",") + ")", Config + ":" + Override.SpawnPointReference.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mOverrides.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.SpawnPoints
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var SpawnPoints As New ArkSA.Configs.SpawnPoints
		  HandleConfig(SpawnPoints, ParsedData, "ConfigOverrideNPCSpawnEntriesContainer", ContentPacks)
		  HandleConfig(SpawnPoints, ParsedData, "ConfigAddNPCSpawnEntriesContainer", ContentPacks)
		  HandleConfig(SpawnPoints, ParsedData, "ConfigSubtractNPCSpawnEntriesContainer", ContentPacks)
		  If SpawnPoints.Count > 0 Then
		    Return SpawnPoints
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub HandleConfig(SpawnPoints As ArkSA.Configs.SpawnPoints, ParsedData As Dictionary, ConfigOption As String, ContentPacks As Beacon.StringList)
		  If Not ParsedData.HasKey(ConfigOption) Then
		    Return
		  End If
		  
		  Var Dicts() As Variant
		  #Pragma BreakOnExceptions False
		  Try
		    Dicts = ParsedData.Value(ConfigOption)
		  Catch Err As RuntimeException
		    Dicts.Add(ParsedData.Value(ConfigOption))
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  Var Mode As Integer
		  If ConfigOption.BeginsWith("ConfigAdd") Then
		    Mode = ArkSA.SpawnPointOverride.ModeAppend
		  ElseIf ConfigOption.BeginsWith("ConfigSubtract") Then
		    Mode = ArkSA.SpawnPointOverride.ModeRemove
		  Else
		    Mode = ArkSA.SpawnPointOverride.ModeOverride
		  End If
		  
		  For Each Obj As Variant In Dicts
		    If IsNull(Obj) Or Obj.Type <> Variant.TypeObject Or (Obj IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Try
		      Var Dict As Dictionary = Obj
		      If Not Dict.HasKey("NPCSpawnEntriesContainerClassString") Then
		        Continue
		      End If
		      
		      Var ClassString As String = Dict.Value("NPCSpawnEntriesContainerClassString")
		      Var SpawnPointRef As New ArkSA.BlueprintReference(ArkSA.BlueprintReference.KindSpawnPoint, "", "", ClassString, "", "", "")
		      Var SpawnPoint As ArkSA.SpawnPoint = ArkSA.SpawnPoint(SpawnPointRef.Resolve(ContentPacks))
		      Var Override As New ArkSA.MutableSpawnPointOverride(SpawnPoint, Mode, False)
		      
		      // make changes
		      If Dict.HasKey("NPCSpawnEntries") Then
		        Var Entries() As Variant = Dict.Value("NPCSpawnEntries")
		        For Each Member As Variant In Entries
		          If IsNull(Member) Or Member.Type <> Variant.TypeObject Or (Member.ObjectValue IsA Dictionary) = False Then
		            Continue
		          End If
		          
		          Var Entry As Dictionary = Dictionary(Member.ObjectValue)
		          
		          Try
		            Var Classes() As Variant
		            If Entry.HasKey("NPCsToSpawn") Then
		              Classes = Entry.Value("NPCsToSpawn")
		            ElseIf Entry.HasKey("NPCsToSpawnStrings") Then
		              Classes = Entry.Value("NPCsToSpawnStrings")
		            End If
		            If Classes.LastIndex = -1 Then
		              Continue
		            End If
		            
		            Var LevelMembers(), OffsetMembers(), SpawnChanceMembers(), MinLevelOffsetMembers(), MaxLevelOffsetMembers(), MinLevelMultiplierMembers(), MaxLevelMultipliersMembers(), LevelOverrideMembers() As Variant
		            
		            If Entry.HasKey("NPCDifficultyLevelRanges") Then
		              LevelMembers = Entry.Value("NPCDifficultyLevelRanges")
		            End If
		            If Entry.HasKey("NPCsSpawnOffsets") Then
		              OffsetMembers = Entry.Value("NPCsSpawnOffsets")
		            End If
		            If Entry.HasKey("NPCsToSpawnPercentageChance") Then
		              SpawnChanceMembers = Entry.Value("NPCsToSpawnPercentageChance")
		            End If
		            If Entry.HasKey("NPCMinLevelMultiplier") Then
		              MinLevelMultiplierMembers = Entry.Value("NPCMinLevelMultiplier")
		            End If
		            If Entry.HasKey("NPCMinLevelOffset") Then
		              MinLevelOffsetMembers = Entry.Value("NPCMinLevelOffset")
		            End If
		            If Entry.HasKey("NPCMaxLevelMultiplier") Then
		              MaxLevelMultipliersMembers = Entry.Value("NPCMaxLevelMultiplier")
		            End If
		            If Entry.HasKey("NPCMaxLevelOffset") Then
		              MaxLevelOffsetMembers = Entry.Value("NPCMaxLevelOffset")
		            End If
		            If Entry.HasKey("NPCOverrideLevel") Then
		              LevelOverrideMembers = Entry.Value("NPCOverrideLevel")
		            End If
		            
		            Var Set As New ArkSA.MutableSpawnPointSet
		            Set.Label = Entry.Lookup("AnEntryName", "Untitled Spawn Set")
		            Set.RawWeight = Entry.Lookup("EntryWeight", 1.0)
		            Set.ColorSetClass = Entry.Lookup("ColorSets", "")
		            
		            For I As Integer = 0 To Classes.LastIndex
		              Var CreaturePath As String
		              Var CreatureClass As String = Classes(I).StringValue
		              If CreatureClass.Contains("/") Then
		                CreaturePath = ArkSA.CleanupBlueprintPath(CreatureClass)
		                CreatureClass = ""
		              End If
		              
		              Var Creature As ArkSA.Creature = ArkSA.ResolveCreature("", CreaturePath, CreatureClass, ContentPacks, True)
		              
		              Var SetEntry As New ArkSA.MutableSpawnPointSetEntry(Creature)
		              If LevelMembers.LastIndex >= I Then
		                Var LevelValues As Dictionary = LevelMembers(I)
		                Var MinLevels() As Variant = LevelValues.Value("EnemyLevelsMin")
		                Var MaxLevels() As Variant = LevelValues.Value("EnemyLevelsMax")
		                Var Difficulties() As Variant = LevelValues.Value("GameDifficulties")
		                
		                For LevelIdx As Integer = 0 To Min(MinLevels.LastIndex, MaxLevels.LastIndex, Difficulties.LastIndex)
		                  SetEntry.Append(New ArkSA.SpawnPointLevel(MinLevels(LevelIdx), MaxLevels(LevelIdx), Difficulties(LevelIdx)))
		                Next
		              End If
		              If OffsetMembers.LastIndex >= I Then
		                Var OffsetValues As Dictionary = OffsetMembers(I)
		                SetEntry.Offset = New Beacon.Point3D(OffsetValues.Value("X"), OffsetValues.Value("Y"), OffsetValues.Value("Z"))
		              End If
		              If SpawnChanceMembers.LastIndex >= I Then
		                SetEntry.SpawnChance = SpawnChanceMembers(I).DoubleValue
		              End If
		              If MinLevelMultiplierMembers.LastIndex >= I Then
		                SetEntry.MinLevelMultiplier = MinLevelMultiplierMembers(I).DoubleValue
		              End If
		              If MinLevelOffsetMembers.LastIndex >= I Then
		                SetEntry.MinLevelOffset = MinLevelOffsetMembers(I).DoubleValue
		              End If
		              If MaxLevelMultipliersMembers.LastIndex >= I Then
		                SetEntry.MaxLevelMultiplier = MaxLevelMultipliersMembers(I).DoubleValue
		              End If
		              If MaxLevelOffsetMembers.LastIndex >= I Then
		                SetEntry.MaxLevelOffset = MaxLevelOffsetMembers(I).DoubleValue
		              End If
		              If LevelOverrideMembers.LastIndex >= I Then
		                SetEntry.LevelOverride = LevelOverrideMembers(I).DoubleValue
		              End If
		              Set.Append(SetEntry)
		            Next
		            
		            If Entry.HasKey("ManualSpawnPointSpreadRadius") Then
		              Set.SpreadRadius = Entry.Value("ManualSpawnPointSpreadRadius").DoubleValue
		            End If
		            
		            If Entry.HasKey("WaterOnlySpawnMinimumWaterHeight") Then
		              Set.WaterOnlyMinimumHeight = Entry.Value("WaterOnlySpawnMinimumWaterHeight").DoubleValue
		            End If
		            
		            If Entry.HasKey("SpawnMinDistanceFromStructuresMultiplier") Then
		              Set.MinDistanceFromStructuresMultiplier = Entry.Value("SpawnMinDistanceFromStructuresMultiplier").DoubleValue
		            End If
		            
		            If Entry.HasKey("SpawnMinDistanceFromPlayersMultiplier") Then
		              Set.MinDistanceFromPlayersMultiplier = Entry.Value("SpawnMinDistanceFromPlayersMultiplier").DoubleValue
		            End If
		            
		            If Entry.HasKey("SpawnMinDistanceFromTamedDinosMultiplier") Then
		              Set.MinDistanceFromTamedDinosMultiplier = Entry.Value("SpawnMinDistanceFromTamedDinosMultiplier").DoubleValue
		            End If
		            
		            If Entry.HasKey("bAddLevelOffsetBeforeMultiplier") Then
		              Set.LevelOffsetBeforeMultiplier = Entry.Value("bAddLevelOffsetBeforeMultiplier").StringValue = "True"
		            End If
		            
		            If Entry.HasKey("GroupSpawnOffset") Then
		              Var Offset As Beacon.Point3D = Beacon.Point3D.FromSaveData(Entry.Value("GroupSpawnOffset"))
		              If Offset <> Nil Then
		                Set.GroupOffset = Offset
		              Else
		                Break
		              End If
		            End If
		            
		            If Entry.HasKey("NPCRandomSpawnClassWeights") Then
		              Var Replacements() As Variant = Entry.Value("NPCRandomSpawnClassWeights")
		              For Each Replacement As Dictionary In Replacements
		                If Not Replacement.HasAllKeys("FromClass", "ToClasses", "Weights") Then
		                  Continue
		                End If
		                
		                Var FromClass As String = Replacement.Value("FromClass")
		                Var FromPath As String
		                If FromClass.Contains("/") Then
		                  FromPath = ArkSA.CleanupBlueprintPath(FromClass)
		                  FromClass = ""
		                End If
		                Var FromCreature As ArkSA.Creature = ArkSA.ResolveCreature("", FromPath, FromClass, ContentPacks, True)
		                
		                Var ToWeights() As Variant = Replacement.Value("Weights")
		                Var ToClassValues() As Variant = Replacement.Value("ToClasses")
		                For I As Integer = 0 To ToClassValues.LastIndex
		                  Var ToWeight As Double = If(I <= ToWeights.LastIndex, ToWeights(I), 1.0)
		                  Var ToClass As String = ToClassValues(I)
		                  Var ToPath As String
		                  If ToClass.Contains("/") Then
		                    ToPath = ArkSA.CleanupBlueprintPath(ToClass)
		                    ToClass = ""
		                  End If
		                  
		                  Var ToCreature As ArkSA.Creature = ArkSA.ResolveCreature("", ToPath, ToClass, ContentPacks, True)
		                  
		                  Set.CreatureReplacementWeight(FromCreature, ToCreature) = ToWeight
		                Next
		              Next
		            End If
		            
		            If Set.Count > 0 Then
		              Override.Add(Set)
		            End If
		          Catch Err As RuntimeException
		            
		          End Try
		        Next
		      End If
		      
		      If Dict.HasKey("NPCSpawnLimits") Then
		        Var Limits() As Variant = Dict.Value("NPCSpawnLimits")
		        For Each Limit As Dictionary In Limits
		          Var LimitClass As String
		          If Limit.HasKey("NPCClass") Then
		            LimitClass = Limit.Value("NPCClass")
		          ElseIf Limit.HasKey("NPCClassString") Then
		            LimitClass = Limit.Value("NPCClassString")
		          Else
		            Continue
		          End If
		          If Limit.HasKey("MaxPercentageOfDesiredNumToAllow") = False Then
		            Continue
		          End If
		          
		          Var LimitPath As String
		          If LimitClass.Contains("/") Then
		            LimitPath = ArkSA.CleanupBlueprintPath(LimitClass)
		            LimitClass = ""
		          End If
		          
		          Var Creature As ArkSA.Creature = ArkSA.ResolveCreature("", LimitPath, LimitClass, ContentPacks, True)
		          If (Creature Is Nil) = False Then
		            Override.Limit(Creature) = Limit.Value("MaxPercentageOfDesiredNumToAllow")
		          End If
		        Next
		      End If
		      
		      SpawnPoints.Add(Override)
		    Catch Err As RuntimeException
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOverride(SpawnPointRef As ArkSA.BlueprintReference, Mode As Integer) As Boolean
		  If SpawnPointRef Is Nil Then
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPointRef.BlueprintId And Self.mOverrides(Idx).Mode = Mode Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOverride(SpawnPoint As ArkSA.SpawnPoint, Mode As Integer) As Boolean
		  If SpawnPoint Is Nil Then
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPoint.SpawnPointId And Self.mOverrides(Idx).Mode = Mode Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOverride(Override As ArkSA.SpawnPointOverride) As Boolean
		  If Override Is Nil Then
		    Return False
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).UniqueKey = Override.UniqueKey Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameCreatureSpawns
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Overrides() As Variant
		  For Each Override As ArkSA.SpawnPointOverride In Self.mOverrides
		    Overrides.Add(Override.ImmutableVersion)
		  Next
		  Return New Beacon.GenericIterator(Overrides)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var Changed As Boolean
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    Var Mutable As ArkSA.MutableSpawnPointOverride = Self.mOverrides(Idx).MutableVersion
		    Var Migrated As Boolean = Mutable.MigrateBlueprints(Migrator)
		    If Migrated Then
		      Self.mOverrides(Idx) = Mutable.ImmutableVersion
		      Self.Modified = True
		      Changed = True
		    End If
		  Next
		  Return Changed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverrideForSpawnPoint(SpawnPointRef As ArkSA.BlueprintReference, Mode As Integer) As ArkSA.SpawnPointOverride
		  If SpawnPointRef Is Nil Then
		    Return Nil
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPointRef.BlueprintId And Self.mOverrides(Idx).Mode = Mode Then
		      Return Self.mOverrides(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverrideForSpawnPoint(SpawnPoint As ArkSA.SpawnPoint, Mode As Integer) As ArkSA.SpawnPointOverride
		  If SpawnPoint Is Nil Then
		    Return Nil
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPoint.SpawnPointId And Self.mOverrides(Idx).Mode = Mode Then
		      Return Self.mOverrides(Idx)
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overrides(Filter As String = "") As ArkSA.SpawnPointOverride()
		  Filter = Filter.Trim
		  
		  Var Results() As ArkSA.SpawnPointOverride
		  For Each Override As ArkSA.SpawnPointOverride In Self.mOverrides
		    If Filter.IsEmpty = False And Override.SpawnPointReference.Label.IndexOf(Filter) = -1 Then
		      Continue
		    End If
		    
		    Results.Add(Override.ImmutableVersion)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(SpawnPointRef As ArkSA.BlueprintReference, Mode As Integer)
		  If SpawnPointRef Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPointRef.BlueprintId And Self.mOverrides(Idx).Mode = Mode Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(SpawnPoint As ArkSA.SpawnPoint, Mode As Integer)
		  If SpawnPoint Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).SpawnPointId = SpawnPoint.SpawnPointId And Self.mOverrides(Idx).Mode = Mode Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Override As ArkSA.SpawnPointOverride)
		  If Override Is Nil Then
		    Return
		  End If
		  
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    If Self.mOverrides(Idx).UniqueKey = Override.UniqueKey Then
		      Self.mOverrides.RemoveAt(Idx)
		      Self.Modified = True
		      Return
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  Self.mOverrides.ResizeTo(-1)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Note, Name = ConfigAddNPCSpawnEntriesContainer
		ConfigAddNPCSpawnEntriesContainer=(
		    NPCSpawnEntriesContainerClassString=<spawn_class>,
		    NPCSpawnEntries=(
		        (
		            AnEntryName=<spawn_name>,
		            EntryWeight=<factor>,
		            NPCsToSpawnStrings=(<entity_id>)
		        )
		    ),
		    NPCSpawnLimits=(
		        (
		            NPCClassString=<entity_id>,
		            MaxPercentageOfDesiredNumToAllow=<percentage>
		        )
		    )
		)
		
	#tag EndNote

	#tag Note, Name = ConfigOverrideNPCSpawnEntriesContainer
		ConfigOverrideNPCSpawnEntriesContainer=(
		    NPCSpawnEntriesContainerClassString="AB_DinoSpawnEntriesRockDrake_C",
		    NPCSpawnEntries=(
		        (
		            AnEntryName="Rock Drakes (1)",
		            EntryWeight=0.330000,
		            NPCsToSpawnStrings=(
		                "RockDrake_Character_BP_C"
		            ),
		            NPCsSpawnOffsets=(
		                (
		                    X=0.000000,
		                    Y=0.000000,
		                    Z=0.000000
		                )
		            ),
		            NPCsToSpawnPercentageChance=(
		                1.000000
		            ),
		            GroupSpawnOffset=(
		                X=0.000000,
		                Y=0.000000,
		                Z=35.000000
		            ),
		            ManualSpawnPointSpreadRadius=650.000000,
		            WaterOnlySpawnMinimumWaterHeight=24.0
		            NPCDifficultyLevelRanges=(
		                (
		                    EnemyLevelsMin=(
		                        1.000000,
		                        1.000000,
		                        1.000000,
		                        1.000000,
		                        1.000000,
		                        1.000000
		                    ),
		                    EnemyLevelsMax=(
		                        30.999990,
		                        30.999990,
		                        30.999990,
		                        30.999990,
		                        30.999990,
		                        30.999990
		                    ),
		                    GameDifficulties=(
		                        0.000000,
		                        1.000000,
		                        2.000000,
		                        3.000000,
		                        4.000000,
		                        5.000000
		                    )
		                )
		            ),
		            SpawnMinDistanceFromStructuresMultiplier=1.0,
		            SpawnMinDistanceFromPlayersMultiplier=1.0,
		            SpawnMinDistanceFromTamedDinosMultiplier=1.0,
		            NPCRandomSpawnClassWeights=(
		                (
		                    FromClass="Carno_Character_BP_C",
		                    ToClasses=(
		                        "Carno_Character_BP_C",
		                        "MegaCarno_Character_BP_C"
		                    ),
		                    Weights=(
		                        1.0,
		                        0.1
		                    )
		                )
		            )
		        )
		    ),
		    NPCSpawnLimits=(
		        (
		            NPCClassString="RockDrake_Character_BP_C",
		            MaxPercentageOfDesiredNumToAllow=1
		        )
		    ),
		    NPCMinLevelMultiplier=(
		        1.0
		    ),
		    NPCMinLevelOffset=(
		        0.0
		    ),
		    NPCMaxLevelMultiplier=(
		        1.0
		    ),
		    NPCMaxLevelOffset=(
		        0.0
		    ),
		    NPCOverrideLevel=(
		        1.0
		    )
		)
		
		
		
	#tag EndNote

	#tag Note, Name = ConfigSubtractNPCSpawnEntriesContainer
		ConfigSubtractNPCSpawnEntriesContainer=(
		    NPCSpawnEntriesContainerClassString=<spawn_class>,
		    NPCSpawnEntries=(
		        (
		            NPCsToSpawnStrings=(<entity_id>)
		        )
		    ),
		    NPCSpawnLimits=(
		        (
		            NPCClassString=<entity_id>
		        )
		    )
		)
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mOverrides() As ArkSA.SpawnPointOverride
	#tag EndProperty


	#tag Constant, Name = ModeAdd, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModeReplace, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ModeSubstract, Type = Double, Dynamic = False, Default = \"2", Scope = Private
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
End Class
#tag EndClass
