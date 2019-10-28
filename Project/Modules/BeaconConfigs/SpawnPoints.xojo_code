#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class SpawnPoints
Inherits Beacon.ConfigGroup
Implements  Iterable
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  //    ConfigOverrideNPCSpawnEntriesContainer=(
		  //        NPCSpawnEntriesContainerClassString=<spawn_class>,
		  //        NPCSpawnEntries=(
		  //            (
		  //                AnEntryName=<spawn_name>,
		  //                EntryWeight=<factor>,
		  //                NPCsToSpawnStrings=(<entity_id>)
		  //            )
		  //        ),
		  //        NPCSpawnLimits=(
		  //            (
		  //                NPCClassString=<entity_id>,
		  //                MaxPercentageOfDesiredNumToAllow=<percentage>
		  //            )
		  //        )
		  //    )
		  
		  For Each SpawnPoint As Beacon.SpawnPoint In Self.mSpawnPoints
		    Var Entries() As String
		    Var Limits As Dictionary = SpawnPoint.Limits
		    
		    For Each Set As Beacon.SpawnPointSet In SpawnPoint
		      Var CreatureClasses() As String
		      For Each Creature As Beacon.Creature In Set
		        CreatureClasses.AddRow("""" + Creature.ClassString + """")
		      Next
		      
		      Entries.AddRow("(AnEntryName=""" + Set.Label + """,EntryWeight=" + Set.Weight.PrettyText + ",NPCsToSpawnStrings=(" + CreatureClasses.Join(",") + "))")
		    Next
		    
		    Var Pieces() As String
		    Pieces.AddRow("NPCSpawnEntriesContainerClassString=""" + SpawnPoint.ClassString + """")
		    Pieces.AddRow("NPCSpawnEntries=(" + Entries.Join(",") + ")")
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
		        Var Entries() As Variant = Dict.Value("NPCSpawnEntries")
		        For Each Entry As Dictionary In Entries
		          If Not Entry.HasKey("NPCsToSpawnStrings") Then
		            Continue
		          End If
		          
		          Var Classes() As Variant = Entry.Value("NPCsToSpawnStrings")
		          Var Set As New Beacon.MutableSpawnPointSet
		          Set.Label = Entry.Lookup("AnEntryName", "Untitled Creature Set")
		          Set.Weight = Entry.Lookup("EntryWeight", 1.0)
		          For Each CreatureClassString As String In Classes
		            Var Creature As Beacon.Creature = Beacon.Data.GetCreatureByClass(CreatureClassString)
		            If Creature <> Nil Then
		              Set.AddCreature(Creature)
		            End If
		          Next
		          If Set.Count > 0 Then
		            Clone.AddSet(Set)
		          End If
		        Next
		        
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
