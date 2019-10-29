#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class SpawnPoints
Inherits Beacon.ConfigGroup
Implements  Iterable
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  For Each SpawnPoint As Beacon.SpawnPoint In Self.mSpawnPoints
		    Var RenderedEntries() As String
		    Var Limits As Dictionary = SpawnPoint.Limits
		    
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
		        IncludeMinLevelMultiplier = Entry.MinLevelMultiplier <> Nil
		        IncludeMinLevelOffset = Entry.MinLevelOffset <> Nil
		        IncludeMaxLevelMultiplier = Entry.MaxLevelMultiplier <> Nil
		        IncludeMaxLevelOffset = Entry.MaxLevelOffset <> Nil
		        IncludeLevelOverride = Entry.LevelOverride <> Nil
		      Next
		      For Each Entry As Beacon.SpawnPointSetEntry In Entries
		        CreatureClasses.AddRow("""" + Entry.Creature.ClassString + """")
		        
		        If IncludeLevels Then
		          Var Levels() As Beacon.SpawnPointLevel = Entry.Levels
		          Var MinLevels(), MaxLevels(), Difficulties() As String
		          For Each Level As Beacon.SpawnPointLevel In Levels
		            MinLevels.AddRow(Level.MinLevel.PrettyText)
		            MaxLevels.AddRow(Level.MaxLevel.PrettyText)
		            Difficulties.AddRow(Level.Difficulty.PrettyText)
		          Next
		          LevelMembers.AddRow("(EnemyLevelsMin=(" + MinLevels.Join(",") + "),EnemyLevelsMax=(" + MaxLevels.Join(",") + "),GameDifficulties=(" + Difficulties.Join(",") + "))")
		        End If
		        If IncludeOffsets Then
		          Var Offset As Beacon.Point3D = Entry.Offset
		          If Offset <> Nil Then
		            OffsetMembers.AddRow("(X=" + Offset.X.PrettyText + ",Y=" + Offset.Y.PrettyText + ",Z=" + Offset.Z.PrettyText + ")")
		          Else
		            OffsetMembers.AddRow("(X=0.0,Y=0.0,Z=0.0)")
		          End If
		        End If
		        If IncludeSpawnChance Then
		          Var Chance As Double = If(Entry.SpawnChance <> Nil, Entry.SpawnChance.Value, 1.0) / SpawnSum
		          SpawnChanceMembers.AddRow(Chance.PrettyText)
		        End If
		        If IncludeMinLevelMultiplier Then
		          Var Multiplier As Double = If(Entry.MinLevelMultiplier <> Nil, Entry.MinLevelMultiplier.Value, 1.0)
		          MinLevelMultiplierMembers.AddRow(Multiplier.PrettyText)
		        End If
		        If IncludeMinLevelOffset Then
		          Var Offset As Double = If(Entry.MinLevelOffset <> Nil, Entry.MinLevelOffset.Value, 0.0)
		          MinLevelOffsetMembers.AddRow(Offset.PrettyText)
		        End If
		        If IncludeMaxLevelMultiplier Then
		          Var Multiplier As Double = If(Entry.MaxLevelMultiplier <> Nil, Entry.MaxLevelMultiplier.Value, 1.0)
		          MaxLevelMultiplierMembers.AddRow(Multiplier.PrettyText)
		        End If
		        If IncludeMaxLevelOffset Then
		          Var Offset As Double = If(Entry.MaxLevelOffset <> Nil, Entry.MaxLevelOffset.Value, 0.0)
		          MaxLevelOffsetMembers.AddRow(Offset.PrettyText)
		        End If
		        If IncludeLevelOverride Then
		          Var Override As UInt8 = Round(If(Entry.LevelOverride <> Nil, Entry.LevelOverride.Value, 1.0))
		          LevelOverrideMembers.AddRow(Override.ToString)
		        End If
		      Next
		      
		      Var Members(2) As String
		      Members(0) = "AnEntryName=""" + Set.Label + """"
		      Members(1) = "EntryWeight=" + Set.Weight.PrettyText
		      Members(2) = "NPCsToSpawnStrings=(" + CreatureClasses.Join(",") + ")"
		      
		      If IncludeLevels Then
		        Members.AddRow("NPCDifficultyLevelRanges=(" + LevelMembers.Join(",") + ")")
		      End If
		      If IncludeOffsets Then
		        Members.AddRow("NPCsSpawnOffsets=(" + OffsetMembers.Join(",") + ")")
		      End If
		      If IncludeSpawnChance Then
		        Members.AddRow("NPCsToSpawnPercentageChance=(" + SpawnChanceMembers.Join(",") + ")")
		      End If
		      If IncludeMinLevelMultiplier Then
		        Members.AddRow("NPCMinLevelMultiplier=(" + MinLevelMultiplierMembers.Join(",") + ")")
		      End If
		      If IncludeMinLevelOffset Then
		        Members.AddRow("NPCMinLevelOffset=(" + MinLevelOffsetMembers.Join(",") + ")")
		      End If
		      If IncludeMaxLevelMultiplier Then
		        Members.AddRow("NPCMaxLevelMultiplier=(" + MaxLevelMultiplierMembers.Join(",") + ")")
		      End If
		      If IncludeMaxLevelOffset Then
		        Members.AddRow("NPCMaxLevelOffset=(" + MaxLevelOffsetMembers.Join(",") + ")")
		      End If
		      If IncludeLevelOverride Then
		        Members.AddRow("NPCOverrideLevel=(" + LevelOverrideMembers.Join(",") + ")")
		      End If
		      
		      If Set.OverridesSpreadRadius Then
		        Members.AddRow("ManualSpawnPointSpreadRadius=" + Set.SpreadRadius.PrettyText)
		      End If
		      
		      If Set.OverridesWaterOnlyMinimumHeight Then
		        Members.AddRow("WaterOnlySpawnMinimumWaterHeight=" + Set.WaterOnlyMinimumHeight.PrettyText)
		      End If
		      
		      RenderedEntries.AddRow("(" + Members.Join(",") + ")")
		    Next
		    
		    Var Pieces() As String
		    Pieces.AddRow("NPCSpawnEntriesContainerClassString=""" + SpawnPoint.ClassString + """")
		    Pieces.AddRow("NPCSpawnEntries=(" + RenderedEntries.Join(",") + ")")
		    If Limits.KeyCount > 0 Then
		      Var LimitConfigs() As String
		      For Each Entry As DictionaryEntry In Limits
		        LimitConfigs.AddRow("(NPCClassString=""" + Beacon.Creature(Entry.Key).ClassString + """,MaxPercentageOfDesiredNumToAllow=" + Entry.Value.DoubleValue.PrettyText + ")")
		      Next
		      Pieces.AddRow("NPCSpawnLimits=(" + LimitConfigs.Join(",") + ")")
		    End If
		    
		    Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideNPCSpawnEntriesContainer", "ConfigOverrideNPCSpawnEntriesContainer=(" + Pieces.Join(",") + ")"))
		  Next
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
		        Self.mSpawnPoints.AddRow(SpawnPoint)
		      End If
		    Next
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var Points() As Dictionary
		  For Each SpawnPoint As Beacon.SpawnPoint In Self.mSpawnPoints
		    Points.AddRow(SpawnPoint.SaveData)
		  Next
		  Dict.Value("Points") = Points
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Append(SpawnPoint As Beacon.SpawnPoint)
		  If Self.IndexOf(SpawnPoint) = -1 Then
		    Self.mSpawnPoints.AddRow(SpawnPoint)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "SpawnPoints"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.SpawnPoints
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var SpawnPoints As New BeaconConfigs.SpawnPoints
		  HandleConfig(SpawnPoints, ParsedData, "ConfigOverrideNPCSpawnEntriesContainer")
		  HandleConfig(SpawnPoints, ParsedData, "ConfigAddNPCSpawnEntriesContainer")
		  HandleConfig(SpawnPoints, ParsedData, "ConfigSubtractNPCSpawnEntriesContainer")
		  If SpawnPoints.LastRowIndex > -1 Then
		    Return SpawnPoints
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub HandleConfig(SpawnPoints As BeaconConfigs.SpawnPoints, ParsedData As Dictionary, ConfigKey As String)
		  If Not ParsedData.HasKey(ConfigKey) Then
		    Return
		  End If
		  
		  Var Dicts() As Variant
		  Try
		    Dicts = ParsedData.Value(ConfigKey)
		  Catch Err As RuntimeException
		    Dicts.AddRow(ParsedData.Value(ConfigKey))
		  End Try
		  
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
		      Var Idx As Integer = -1
		      For I As Integer = 0 To SpawnPoints.mSpawnPoints.LastRowIndex
		        If SpawnPoints.mSpawnPoints(I) <> Nil And SpawnPoints.mSpawnPoints(I).ClassString = ClassString Then
		          Idx = I
		          Exit For I
		        End If
		      Next
		      
		      Var SpawnPoint As Beacon.SpawnPoint
		      If Idx = -1 Then
		        SpawnPoint = Beacon.Data.GetSpawnPointByClass(ClassString)
		        If SpawnPoint = Nil Then
		          Continue
		        End If
		      Else
		        SpawnPoint = SpawnPoints.mSpawnPoints(Idx)
		      End If
		      
		      Var Clone As New Beacon.MutableSpawnPoint(SpawnPoint)
		      
		      // make changes
		      If ConfigKey.BeginsWith("ConfigOverride") Then
		        Clone.ResizeTo(-1)
		      End If
		      If ConfigKey.BeginsWith("ConfigSubtract") Then
		        
		      Else
		        If Dict.HasKey("NPCSpawnEntries") Then
		          Var Entries() As Variant = Dict.Value("NPCSpawnEntries")
		          For Each Entry As Dictionary In Entries
		            If Not Entry.HasKey("NPCsToSpawnStrings") Then
		              Continue
		            End If
		            
		            Var Classes() As Variant = Entry.Value("NPCsToSpawnStrings")
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
		            
		            For I As Integer = 0 To Classes.LastRowIndex
		              Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByClass(Classes(I))
		              If Creature = Nil Then
		                Continue
		              End If
		              
		              Var SetEntry As New Beacon.MutableSpawnPointSetEntry(Creature)
		              If LevelMembers.LastRowIndex >= I Then
		                Var LevelValues As Dictionary = LevelMembers(I)
		                Var MinLevels() As Variant = LevelValues.Value("EnemyLevelsMin")
		                Var MaxLevels() As Variant = LevelValues.Value("EnemyLevelsMax")
		                Var Difficulties() As Variant = LevelValues.Value("GameDifficulties")
		                
		                For LevelIdx As Integer = 0 To Min(MinLevels.LastRowIndex, MaxLevels.LastRowIndex, Difficulties.LastRowIndex)
		                  SetEntry.Append(New Beacon.SpawnPointLevel(MinLevels(LevelIdx), MaxLevels(LevelIdx), Difficulties(LevelIdx)))
		                Next
		              End If
		              If OffsetMembers.LastRowIndex >= I Then
		                Var OffsetValues As Dictionary = OffsetMembers(I)
		                SetEntry.Offset = New Beacon.Point3D(OffsetValues.Value("X"), OffsetValues.Value("Y"), OffsetValues.Value("Z"))
		              End If
		              If SpawnChanceMembers.LastRowIndex >= I Then
		                SetEntry.SpawnChance = SpawnChanceMembers(I).DoubleValue
		              End If
		              If MinLevelMultiplierMembers.LastRowIndex >= I Then
		                SetEntry.MinLevelMultiplier = MinLevelMultiplierMembers(I).DoubleValue
		              End If
		              If MinLevelOffsetMembers.LastRowIndex >= I Then
		                SetEntry.MinLevelOffset = MinLevelOffsetMembers(I).DoubleValue
		              End If
		              If MaxLevelMultipliersMembers.LastRowIndex >= I Then
		                SetEntry.MaxLevelMultiplier = MaxLevelMultipliersMembers(I).DoubleValue
		              End If
		              If MaxLevelOffsetMembers.LastRowIndex >= I Then
		                SetEntry.MaxLevelOffset = MaxLevelOffsetMembers(I).DoubleValue
		              End If
		              If LevelOverrideMembers.LastRowIndex >= I Then
		                SetEntry.LevelOverride = LevelOverrideMembers(I).DoubleValue
		              End If
		              Set.Append(SetEntry)
		            Next
		            
		            If Entry.HasKey("ManualSpawnPointSpreadRadius") Then
		              Set.OverridesSpreadRadius = True
		              Set.SpreadRadius = Entry.Value("ManualSpawnPointSpreadRadius")
		            End If
		            
		            If Entry.HasKey("WaterOnlySpawnMinimumWaterHeight") Then
		              Set.OverridesWaterOnlyMinimumHeight = True
		              Set.WaterOnlyMinimumHeight = Entry.Value("WaterOnlySpawnMinimumWaterHeight")
		            End If
		            
		            If Set.Count > 0 Then
		              Clone.AddSet(Set)
		            End If
		          Next
		        End If
		        
		        If Dict.HasKey("NPCSpawnLimits") Then
		          Var Limits() As Variant = Dict.Value("NPCSpawnLimits")
		          For Each Limit As Dictionary In Limits
		            If Not Limit.HasAllKeys("NPCClassString", "MaxPercentageOfDesiredNumToAllow") Then
		              Continue
		            End If
		            
		            Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByClass(Limit.Value("NPCClassString"))
		            If Creature <> Nil Then
		              Clone.Limit(Creature) = Limit.Value("MaxPercentageOfDesiredNumToAllow")
		            End If
		          Next
		        End If
		      End If
		      
		      If Idx = -1 Then
		        SpawnPoints.mSpawnPoints.AddRow(New Beacon.SpawnPoint(Clone))
		      Else
		        SpawnPoints.mSpawnPoints(Idx) = New Beacon.SpawnPoint(Clone)
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(SpawnPoint As Beacon.SpawnPoint) As Integer
		  For I As Integer = 0 To Self.mSpawnPoints.LastRowIndex
		    If Self.mSpawnPoints(I).ClassString = SpawnPoint.ClassString Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Points() As Variant
		  For Each SpawnPoint As Beacon.SpawnPoint In Self.mSpawnPoints
		    Points.AddRow(SpawnPoint)
		  Next
		  Return New Beacon.GenericIterator(Points)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mSpawnPoints.LastRowIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Idx As Integer) As Beacon.SpawnPoint
		  Return Self.mSpawnPoints(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Idx As Integer, Assigns SpawnPoint As Beacon.SpawnPoint)
		  Self.mSpawnPoints(Idx) = SpawnPoint
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(SpawnPoint As Beacon.SpawnPoint)
		  Var Idx As Integer = Self.IndexOf(SpawnPoint)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  Self.mSpawnPoints.RemoveRowAt(Idx)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewBound As Integer)
		  Self.mSpawnPoints.ResizeTo(NewBound)
		  Self.Modified = True
		End Sub
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
		Private mSpawnPoints() As Beacon.SpawnPoint
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
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="mSpawnPoints()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
