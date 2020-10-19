#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class SpawnPoints
Inherits Beacon.ConfigGroup
Implements Iterable
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  
		  For Each Entry As DictionaryEntry In Self.mSpawnPoints
		    Var SpawnPoint As Beacon.SpawnPoint = Entry.Value
		    
		    If Not SpawnPoint.ValidForMask(Profile.Mask) Then
		      Continue
		    End If
		    
		    Var Value As Beacon.ConfigValue = Self.ConfigValueForSpawnPoint(SpawnPoint)
		    If Value <> Nil Then
		      Values.Add(Value)
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.SpawnPoints = BeaconConfigs.SpawnPoints(Other)
		  
		  For Each Entry As DictionaryEntry In Source.mSpawnPoints
		    Var SpawnPoint As Beacon.SpawnPoint = Entry.Value
		    Self.Add(New Beacon.SpawnPoint(SpawnPoint))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub NonGeneratedKeys(Keys() As Beacon.ConfigKey)
		  Keys.Add(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "ConfigOverrideNPCSpawnEntriesContainer"))
		  Keys.Add(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "ConfigAddNPCSpawnEntriesContainer"))
		  Keys.Add(New Beacon.ConfigKey("Game.ini", Beacon.ShooterGameHeader, "ConfigSubtractNPCSpawnEntriesContainer"))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Not Dict.HasKey("Points") Then
		    Return
		  End If
		  
		  Var Points() As Variant
		  Try
		    Points = Dict.Value("Points")
		    For Each PointData As Dictionary In Points
		      Var SpawnPoint As Beacon.SpawnPoint = Beacon.SpawnPoint.FromSaveData(PointData)
		      If SpawnPoint <> Nil Then
		        Self.mSpawnPoints.Value(Self.DictionaryKey(SpawnPoint)) = SpawnPoint
		      End If
		    Next
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document, BlueprintsMap As Dictionary)
		  #Pragma Unused Document
		  
		  Var Points() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mSpawnPoints
		    Points.Add(Beacon.SpawnPoint(Entry.Value).SaveData)
		  Next
		  Dict.Value("Points") = Points
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(SpawnPoint As Beacon.SpawnPoint)
		  Self.mSpawnPoints.Value(Self.DictionaryKey(SpawnPoint)) = SpawnPoint.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function All() As Beacon.SpawnPoint()
		  Var Arr() As Beacon.SpawnPoint
		  For Each Entry As DictionaryEntry In Self.mSpawnPoints
		    Arr.Add(Beacon.SpawnPoint(Entry.Value).ImmutableVersion)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return ConfigKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigValueForSpawnPoint(SpawnPoint As Beacon.SpawnPoint) As Beacon.ConfigValue
		  Var RenderedEntries() As String
		  Var Limits As Dictionary = SpawnPoint.Limits
		  
		  Var Config As String
		  Select Case SpawnPoint.Mode
		  Case Beacon.SpawnPoint.ModeOverride
		    Config = "ConfigOverrideNPCSpawnEntriesContainer"
		  Case Beacon.SpawnPoint.ModeAppend
		    Config = "ConfigAddNPCSpawnEntriesContainer"
		  Case Beacon.SpawnPoint.ModeRemove
		    Config = "ConfigSubtractNPCSpawnEntriesContainer"
		  Else
		    Return Nil
		  End Select
		  
		  For Each Set As Beacon.SpawnPointSet In SpawnPoint
		    Var CreatureClasses(), LevelMembers(), OffsetMembers(), SpawnChanceMembers(), MinLevelMultiplierMembers(), MinLevelOffsetMembers(), MaxLevelMultiplierMembers(), MaxLevelOffsetMembers(), LevelOverrideMembers() As String
		    Var IncludeLevels, IncludeOffsets, IncludeSpawnChance, IncludeMinLevelMultiplier, IncludeMaxLevelMultiplier, IncludeMinLevelOffset, IncludeMaxLevelOffset, IncludeLevelOverride As Boolean
		    Var Entries() As Beacon.SpawnPointSetEntry = Set.Entries
		    Var SpawnSum As Double
		    
		    For Each Entry As Beacon.SpawnPointSetEntry In Entries
		      IncludeLevels = IncludeLevels Or Entry.LevelCount > 0
		      IncludeOffsets = IncludeOffsets Or Entry.Offset <> Nil
		      If Entry.SpawnChance <> Nil Then
		        SpawnSum = SpawnSum + Entry.SpawnChance
		        IncludeSpawnChance = True
		      Else
		        SpawnSum = SpawnSum + 1.0
		      End If
		      IncludeMinLevelMultiplier = IncludeMinLevelMultiplier Or Entry.MinLevelMultiplier <> Nil
		      IncludeMinLevelOffset = IncludeMinLevelOffset Or Entry.MinLevelOffset <> Nil
		      IncludeMaxLevelMultiplier = IncludeMaxLevelMultiplier Or Entry.MaxLevelMultiplier <> Nil
		      IncludeMaxLevelOffset = IncludeMaxLevelOffset Or Entry.MaxLevelOffset <> Nil
		      IncludeLevelOverride = IncludeLevelOverride Or Entry.LevelOverride <> Nil
		    Next
		    For Each Entry As Beacon.SpawnPointSetEntry In Entries
		      CreatureClasses.Add("""" + Entry.Creature.ClassString + """")
		      
		      If IncludeLevels Then
		        Var Levels() As Beacon.SpawnPointLevel = Entry.Levels
		        Var MinLevels(), MaxLevels(), Difficulties() As String
		        For Each Level As Beacon.SpawnPointLevel In Levels
		          MinLevels.Add(Level.MinLevel.PrettyText)
		          MaxLevels.Add(Level.MaxLevel.PrettyText)
		          Difficulties.Add(Level.Difficulty.PrettyText)
		        Next
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
		        Var Chance As Double = If(Entry.SpawnChance <> Nil, Entry.SpawnChance.DoubleValue, 1.0) / SpawnSum
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
		        Var Override As UInt8 = Round(If(Entry.LevelOverride <> Nil, Entry.LevelOverride.DoubleValue, 1.0))
		        LevelOverrideMembers.Add(Override.ToString)
		      End If
		    Next
		    
		    Var Members(2) As String
		    Members(0) = "AnEntryName=""" + Set.Label + """"
		    Members(1) = "EntryWeight=" + Set.Weight.PrettyText
		    Members(2) = "NPCsToSpawnStrings=(" + CreatureClasses.Join(",") + ")"
		    
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
		      Var ReplacedCreatures() As Beacon.Creature = Set.ReplacedCreatures()
		      Var Replacements() As String
		      For Each FromCreature As Beacon.Creature In ReplacedCreatures
		        Var ReplacementCreatures() As Beacon.Creature = Set.ReplacementCreatures(FromCreature)
		        Var ReplacementClasses(), ReplacementWeights() As String
		        
		        For Each ToCreature As Beacon.Creature In ReplacementCreatures
		          Var Weight As Double = Set.CreatureReplacementWeight(FromCreature, ToCreature)
		          ReplacementClasses.Add("""" + ToCreature.ClassString + """")
		          ReplacementWeights.Add(Weight.PrettyText)
		        Next
		        
		        Replacements.Add("(FromClass=""" + FromCreature.ClassString + """,ToClasses=(" + ReplacementClasses.Join(",") + "),Weights=(" + ReplacementWeights.Join(",") + "))")
		      Next
		      Members.Add("NPCRandomSpawnClassWeights=(" + Replacements.Join(",") + ")")
		    End If
		    
		    If IncludeMinLevelMultiplier Or IncludeMaxLevelMultiplier Or IncludeMinLevelOffset Or IncludeMaxLevelOffset Or IncludeLevelOverride Then
		      Members.Add("bAddLevelOffsetBeforeMultiplier=" + If(Set.LevelOffsetBeforeMultiplier, "true", "false"))
		    End If
		    
		    RenderedEntries.Add("(" + Members.Join(",") + ")")
		  Next
		  
		  Var Pieces() As String
		  Pieces.Add("NPCSpawnEntriesContainerClassString=""" + SpawnPoint.ClassString + """")
		  Pieces.Add("NPCSpawnEntries=(" + RenderedEntries.Join(",") + ")")
		  If Limits.KeyCount > 0 Then
		    Var LimitConfigs() As String
		    For Each Entry As DictionaryEntry In Limits
		      If Entry.Value.DoubleValue < 1.0 Then
		        LimitConfigs.Add("(NPCClassString=""" + Beacon.Creature(Entry.Key).ClassString + """,MaxPercentageOfDesiredNumToAllow=" + Entry.Value.DoubleValue.PrettyText + ")")
		      End If
		    Next
		    If LimitConfigs.LastIndex > -1 Then
		      Pieces.Add("NPCSpawnLimits=(" + LimitConfigs.Join(",") + ")")
		    End If
		  End If
		  
		  Return New Beacon.ConfigValue(Beacon.ShooterGameHeader, Config, "(" + Pieces.Join(",") + ")")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSpawnPoints = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mSpawnPoints.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DictionaryKey(Point As Beacon.SpawnPoint) As String
		  If Point = Nil Then
		    Return ""
		  End If
		  
		  Return Point.UniqueKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.SpawnPoints
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var SpawnPoints As New BeaconConfigs.SpawnPoints
		  HandleConfig(SpawnPoints, ParsedData, "ConfigOverrideNPCSpawnEntriesContainer", Mods)
		  HandleConfig(SpawnPoints, ParsedData, "ConfigAddNPCSpawnEntriesContainer", Mods)
		  HandleConfig(SpawnPoints, ParsedData, "ConfigSubtractNPCSpawnEntriesContainer", Mods)
		  If SpawnPoints.Count > 0 Then
		    Return SpawnPoints
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPoint(Path As String, Mode As Integer) As Beacon.SpawnPoint
		  Var Key As String = Path
		  Select Case Mode
		  Case Beacon.SpawnPoint.ModeOverride
		    Key = Key + ":Override"
		  Case Beacon.SpawnPoint.ModeAppend
		    Key = Key + ":Append"
		  Case Beacon.SpawnPoint.ModeRemove
		    Key = Key + ":Remove"
		  End Select
		  If Self.mSpawnPoints.HasKey(Key) Then
		    Return Beacon.SpawnPoint(Self.mSpawnPoints.Value(Key)).ImmutableVersion
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub HandleConfig(SpawnPoints As BeaconConfigs.SpawnPoints, ParsedData As Dictionary, ConfigKey As String, Mods As Beacon.StringList)
		  If Not ParsedData.HasKey(ConfigKey) Then
		    Return
		  End If
		  
		  Var Dicts() As Variant
		  #Pragma BreakOnExceptions False
		  Try
		    Dicts = ParsedData.Value(ConfigKey)
		  Catch Err As RuntimeException
		    Dicts.Add(ParsedData.Value(ConfigKey))
		  End Try
		  #Pragma BreakOnExceptions Default
		  
		  Var Mode As Integer
		  If ConfigKey.BeginsWith("ConfigAdd") Then
		    Mode = Beacon.SpawnPoint.ModeAppend
		  ElseIf ConfigKey.BeginsWith("ConfigSubtract") Then
		    Mode = Beacon.SpawnPoint.ModeRemove
		  Else
		    Mode = Beacon.SpawnPoint.ModeOverride
		  End If
		  
		  Var SpawnClasses As New Dictionary
		  For Each Obj As Variant In Dicts
		    If IsNull(Obj) Or Obj.Type <> Variant.TypeObject Or (Obj IsA Dictionary) = False Then
		      Continue
		    End If
		    
		    Try
		      Var Dict As Dictionary = Obj
		      
		      If Not Dict.HasKey("NPCSpawnEntriesContainerClassString") Then
		        Continue
		      End If
		      
		      Var SpawnPoint As Beacon.SpawnPoint
		      Var ClassString As String = Dict.Value("NPCSpawnEntriesContainerClassString")
		      If SpawnClasses.HasKey(ClassString) Then
		        SpawnPoint = SpawnPoints.mSpawnPoints.Value(SpawnClasses.Value(ClassString))
		      Else
		        SpawnPoint = Beacon.ResolveSpawnPoint("", "", ClassString, Mods)
		        
		        Var Mutable As Beacon.MutableSpawnPoint = SpawnPoint.MutableVersion
		        Mutable.Mode = Mode
		        SpawnPoint = Mutable
		        SpawnClasses.Value(ClassString) = DictionaryKey(SpawnPoint)
		      End If
		      
		      Var Clone As Beacon.MutableSpawnPoint = SpawnPoint.MutableVersion
		      Clone.ResizeTo(-1)
		      Clone.LimitsString = "{}"
		      
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
		            
		            Var Set As New Beacon.MutableSpawnPointSet
		            Set.Label = Entry.Lookup("AnEntryName", "Untitled Spawn Set")
		            Set.Weight = Entry.Lookup("EntryWeight", 1.0)
		            
		            For I As Integer = 0 To Classes.LastIndex
		              Var Creature As Beacon.Creature = Beacon.ResolveCreature("", "", Classes(I), Mods)
		              
		              Var SetEntry As New Beacon.MutableSpawnPointSetEntry(Creature)
		              If LevelMembers.LastIndex >= I Then
		                Var LevelValues As Dictionary = LevelMembers(I)
		                Var MinLevels() As Variant = LevelValues.Value("EnemyLevelsMin")
		                Var MaxLevels() As Variant = LevelValues.Value("EnemyLevelsMax")
		                Var Difficulties() As Variant = LevelValues.Value("GameDifficulties")
		                
		                For LevelIdx As Integer = 0 To Min(MinLevels.LastIndex, MaxLevels.LastIndex, Difficulties.LastIndex)
		                  SetEntry.Append(New Beacon.SpawnPointLevel(MinLevels(LevelIdx), MaxLevels(LevelIdx), Difficulties(LevelIdx)))
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
		              Set.LevelOffsetBeforeMultiplier = Entry.Value("bAddLevelOffsetBeforeMultiplier").StringValue = "true"
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
		                
		                Var FromClassValue As String = Replacement.Value("FromClass")
		                Var FromCreature As Beacon.Creature = Beacon.ResolveCreature("", "", FromClassValue, Mods)
		                
		                Var ToWeights() As Variant = Replacement.Value("Weights")
		                Var ToClassValues() As Variant = Replacement.Value("ToClasses")
		                For I As Integer = 0 To ToClassValues.LastIndex
		                  Var ToWeight As Double = If(I <= ToWeights.LastIndex, ToWeights(I), 1.0)
		                  Var ToCreature As Beacon.Creature = Beacon.ResolveCreature("", "", ToClassValues(I), Mods)
		                  
		                  Set.CreatureReplacementWeight(FromCreature, ToCreature) = ToWeight
		                Next
		              Next
		            End If
		            
		            If Set.Count > 0 Then
		              Clone.AddSet(Set)
		            End If
		          Catch Err As RuntimeException
		            
		          End Try
		        Next
		      End If
		      
		      If Dict.HasKey("NPCSpawnLimits") Then
		        Var Limits() As Variant = Dict.Value("NPCSpawnLimits")
		        For Each Limit As Dictionary In Limits
		          If Not Limit.HasAllKeys("NPCClassString", "MaxPercentageOfDesiredNumToAllow") Then
		            Continue
		          End If
		          
		          Var Creature As Beacon.Creature = Beacon.ResolveCreature(Limit, "", "", "NPCClassString", Mods)
		          If (Creature Is Nil) = False Then
		            Clone.Limit(Creature) = Limit.Value("MaxPercentageOfDesiredNumToAllow")
		          End If
		        Next
		      End If
		      
		      SpawnPoints.mSpawnPoints.Value(DictionaryKey(Clone)) = Clone.ImmutableVersion
		    Catch Err As RuntimeException
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasSpawnPoint(SpawnPoint As Beacon.SpawnPoint) As Boolean
		  If SpawnPoint = Nil Then
		    Return False
		  End If
		  
		  Return Self.mSpawnPoints.HasKey(Self.DictionaryKey(SpawnPoint))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Points() As Variant
		  For Each Entry As DictionaryEntry In Self.mSpawnPoints
		    Points.Add(Beacon.SpawnPoint(Entry.Value).ImmutableVersion)
		  Next
		  Return New Beacon.GenericIterator(Points)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(SpawnPoint As Beacon.SpawnPoint)
		  If Self.HasSpawnPoint(SpawnPoint) Then
		    Self.mSpawnPoints.Remove(Self.DictionaryKey(SpawnPoint))
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  Self.mSpawnPoints = New Dictionary
		  Self.Modified = True
		End Sub
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
		Private mSpawnPoints As Dictionary
	#tag EndProperty


	#tag Constant, Name = ConfigKey, Type = String, Dynamic = False, Default = \"SpawnPoints", Scope = Private
	#tag EndConstant

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
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
