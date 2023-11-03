#tag Class
Protected Class ArkSASpawnSimulationThread
Inherits Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  #if false
		    Var Database As ArkSA.DataSource = ArkSA.DataSource.Pool.Get(False)
		    
		    Var DinoCountMultiplier As Double = 1.0
		    Var DinoCountMultiplierKey As ArkSA.ConfigOption = Database.GetConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "DinoCountMultiplier")
		    If (DinoCountMultiplierKey Is Nil) = False Then
		      Var GeneralSettings As ArkSA.ConfigGroup = Self.mProject.CombinedConfig(ArkSA.Configs.NameGeneralSettings, Self.mProfile.ConfigSetStates)
		      If (GeneralSettings Is Nil) = False Then
		        Try
		          DinoCountMultiplier = ArkSA.Configs.OtherSettings(GeneralSettings).Value(DinoCountMultiplierKey).DoubleValue
		        Catch Err As RuntimeException
		          App.Log(Err, CurrentMethodName, "Reading DinoCountMultiplier from General Settings.")
		        End Try
		      Else
		        Var CustomConfig As ArkSA.ConfigGroup = Self.mProject.CombinedConfig(ArkSA.Configs.NameCustomConfig, Self.mProfile.ConfigSetStates)
		        If (CustomConfig Is Nil) = False Then
		          Var Configs() As ArkSA.ConfigValue = CustomConfig.GenerateConfigValues(Self.mProject, App.IdentityManager.CurrentIdentity, Self.mProfile)
		          For Each ConfigValue As ArkSA.ConfigValue In Configs
		            If Self.mCancelled Then
		              Return
		            End If
		            
		            If ConfigValue.Details = DinoCountMultiplierKey Then
		              Try
		                DinoCountMultiplier = Double.FromString(ConfigValue.Value, Locale.Raw)
		              Catch Err As RuntimeException
		                App.Log(Err, CurrentMethodName, "Reading DinoCountMultiplier from Custom Config.")
		              End Try
		              Exit
		            End If
		          Next
		        End If
		      End If
		    End If
		    
		    Var SpawnConfig As ArkSA.ConfigGroup = Self.mProject.CombinedConfig(ArkSA.Configs.NameCreatureSpawns, Self.mProfile.ConfigSetStates)
		    Var SpawnPoints() As ArkSA.SpawnPoint = Database.GetSpawnPoints("", Self.mProject.ContentPacks, "")
		    Var Handled As New Dictionary
		    For Each SpawnPoint As ArkSA.SpawnPoint In SpawnPoints
		      If Self.mCancelled Then
		        Return
		      End If
		      
		      If SpawnPoint.ValidForMask(Self.mProfile.Mask) = False Then
		        Continue
		      End If
		      
		      If Handled.HasKey(SpawnPoint.SpawnPointId) Then
		        Continue
		      End If
		      
		      If SpawnPoint.Mode <> ArkSA.SpawnPointOverride.ModeOverride Then
		        Var Default As ArkSA.SpawnPoint = Database.GetSpawnPoint(SpawnPoint.SpawnPointId)
		        If Default Is Nil Then
		          Continue
		        End If
		        
		        Var Mutable As New ArkSA.MutableSpawnPoint(Default)
		        Database.LoadDefaults(Mutable)
		        
		        Var AppendConfig, RemoveConfig As ArkSA.SpawnPoint
		        If SpawnPoint.Mode = ArkSA.SpawnPointOverride.ModeAppend Then
		          AppendConfig = SpawnPoint
		          RemoveConfig = ArkSA.Configs.SpawnPoints(SpawnConfig).GetSpawnPoint(SpawnPoint.SpawnPointId, ArkSA.SpawnPointOverride.ModeRemove)
		        ElseIf SpawnPoint.Mode = ArkSA.SpawnPointOverride.ModeRemove Then
		          AppendConfig = ArkSA.Configs.SpawnPoints(SpawnConfig).GetSpawnPoint(SpawnPoint.SpawnPointId, ArkSA.SpawnPointOverride.ModeAppend)
		          RemoveConfig = SpawnPoint
		        Else
		          App.Log("Spawn point mode " + SpawnPoint.Mode.ToString(Locale.Raw, "0") + " for " + SpawnPoint.ClassString + " does not make sense.")
		          Continue
		        End If
		        
		        // Remove creatures first
		        If (RemoveConfig Is Nil) = False Then
		          Var Creatures As New Dictionary
		          For Each Set As ArkSA.SpawnPointSet In RemoveConfig
		            If Self.mCancelled Then
		              Return
		            End If
		            
		            For Each Entry As ArkSA.SpawnPointSetEntry In Set
		              If Self.mCancelled Then
		                Return
		              End If
		              
		              Creatures.Value(Entry.Creature.ClassString) = True
		            Next Entry
		          Next Set
		          
		          Var SetBound As Integer = Mutable.LastIndex
		          For SetIdx As Integer = SetBound DownTo 0
		            If Self.mCancelled Then
		              Return
		            End If
		            
		            Var Set As New ArkSA.MutableSpawnPointSet(Mutable.Set(SetIdx))
		            Var EntryBound As Integer = Set.LastIndex
		            For EntryIdx As Integer = EntryBound DownTo 0
		              If Self.mCancelled Then
		                Return
		              End If
		              
		              Var Entry As ArkSA.SpawnPointSetEntry = Set.Entry(EntryIdx)
		              If Creatures.HasKey(Entry.Creature.ClassString) Then
		                Set.Remove(EntryIdx)
		              End If
		            Next
		            
		            If Set.Count = 0 Then
		              Mutable.RemoveSet(Set)
		            End If
		          Next SetIdx
		        End If
		        
		        // Add the new spawn sets
		        If (AppendConfig Is Nil) = False Then
		          For Each Set As ArkSA.SpawnPointSet In AppendConfig
		            If Self.mCancelled Then
		              Return
		            End If
		            
		            Mutable.AddSet(Set)
		          Next Set
		        End If
		        
		        SpawnPoint = Default
		      End If
		      
		      // Start simulating
		      
		      Handled.Value(SpawnPoint.SpawnPointId) = True
		    Next SpawnPoint
		  #endif
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As ArkSA.Project, Profile As ArkSA.ServerProfile)
		  Self.mProject = Project
		  Self.mProfile = Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As ArkSA.Project, MapMask As UInt64, ConfigSetStates() As Beacon.ConfigSetState)
		  Var Profile As New ArkSA.ServerProfile(Local.Identifier, "Spawn Simulation")
		  Profile.Mask = MapMask
		  Profile.ConfigSetStates = ConfigSetStates
		  Self.Constructor(Project, Profile)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCancelled
			End Get
		#tag EndGetter
		Cancelled As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As ArkSA.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As ArkSA.Project
	#tag EndProperty


	#tag ViewBehavior
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
			InitialValue=""
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cancelled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
