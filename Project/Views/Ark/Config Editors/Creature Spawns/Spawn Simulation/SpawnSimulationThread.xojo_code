#tag Class
Protected Class SpawnSimulationThread
Inherits Thread
	#tag Event
		Sub Run()
		  If Self.mCancelled Then
		    Return
		  End If
		  
		  Var Database As Ark.DataSource = Ark.DataSource.Pool.Get(False)
		  
		  Var DinoCountMultiplier As Double = 1.0
		  Var DinoCountMultiplierKey As Ark.ConfigKey = Database.GetConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DinoCountMultiplier")
		  If (DinoCountMultiplierKey Is Nil) = False Then
		    Var GeneralSettings As Ark.ConfigGroup = Self.mProject.CombinedConfig(Ark.Configs.NameOtherSettings, Self.mProfile.ConfigSetStates)
		    If (GeneralSettings Is Nil) = False Then
		      Try
		        DinoCountMultiplier = Ark.Configs.OtherSettings(GeneralSettings).Value(DinoCountMultiplierKey).DoubleValue
		      Catch Err As RuntimeException
		        App.Log(Err, CurrentMethodName, "Reading DinoCountMultiplier from General Settings.")
		      End Try
		    Else
		      Var CustomConfig As Ark.ConfigGroup = Self.mProject.CombinedConfig(Ark.Configs.NameCustomContent, Self.mProfile.ConfigSetStates)
		      If (CustomConfig Is Nil) = False Then
		        Var Configs() As Ark.ConfigValue = CustomConfig.GenerateConfigValues(Self.mProject, App.IdentityManager.CurrentIdentity, Self.mProfile)
		        For Each ConfigValue As Ark.ConfigValue In Configs
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
		  
		  Var SpawnConfig As Ark.ConfigGroup = Self.mProject.CombinedConfig(Ark.Configs.NameSpawnPoints, Self.mProfile.ConfigSetStates)
		  Var SpawnPoints() As Ark.SpawnPoint = Database.GetSpawnPoints("", Self.mProject.ContentPacks, "")
		  Var Handled As New Dictionary
		  For Each SpawnPoint As Ark.SpawnPoint In SpawnPoints
		    If Self.mCancelled Then
		      Return
		    End If
		    
		    If SpawnPoint.ValidForMask(Self.mProfile.Mask) = False Then
		      Continue
		    End If
		    
		    If Handled.HasKey(SpawnPoint.ObjectID) Then
		      Continue
		    End If
		    
		    If SpawnPoint.Mode <> Ark.SpawnPoint.ModeOverride Then
		      Var Default As Ark.SpawnPoint = Database.GetSpawnPointByUUID(SpawnPoint.ObjectID)
		      If Default Is Nil Then
		        Continue
		      End If
		      
		      Var Mutable As New Ark.MutableSpawnPoint(Default)
		      Database.LoadDefaults(Mutable)
		      
		      Var AppendConfig, RemoveConfig As Ark.SpawnPoint
		      If SpawnPoint.Mode = Ark.SpawnPoint.ModeAppend Then
		        AppendConfig = SpawnPoint
		        RemoveConfig = Ark.Configs.SpawnPoints(SpawnConfig).GetSpawnPoint(SpawnPoint.ObjectID, Ark.SpawnPoint.ModeRemove)
		      ElseIf SpawnPoint.Mode = Ark.SpawnPoint.ModeRemove Then
		        AppendConfig = Ark.Configs.SpawnPoints(SpawnConfig).GetSpawnPoint(SpawnPoint.ObjectID, Ark.SpawnPoint.ModeAppend)
		        RemoveConfig = SpawnPoint
		      Else
		        App.Log("Spawn point mode " + SpawnPoint.Mode.ToString(Locale.Raw, "0") + " for " + SpawnPoint.ClassString + " does not make sense.")
		        Continue
		      End If
		      
		      // Remove creatures first
		      If (RemoveConfig Is Nil) = False Then
		        Var Creatures As New Dictionary
		        For Each Set As Ark.SpawnPointSet In RemoveConfig
		          If Self.mCancelled Then
		            Return
		          End If
		          
		          For Each Entry As Ark.SpawnPointSetEntry In Set
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
		          
		          Var Set As New Ark.MutableSpawnPointSet(Mutable.Set(SetIdx))
		          Var EntryBound As Integer = Set.LastIndex
		          For EntryIdx As Integer = EntryBound DownTo 0
		            If Self.mCancelled Then
		              Return
		            End If
		            
		            Var Entry As Ark.SpawnPointSetEntry = Set.Entry(EntryIdx)
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
		        For Each Set As Ark.SpawnPointSet In AppendConfig
		          If Self.mCancelled Then
		            Return
		          End If
		          
		          Mutable.AddSet(Set)
		        Next Set
		      End If
		      
		      SpawnPoint = Default
		    End If
		    
		    // Start simulating
		    
		    Handled.Value(SpawnPoint.ObjectID) = True
		  Next SpawnPoint
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project, Profile As Ark.ServerProfile)
		  Self.mProject = Project
		  Self.mProfile = Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Ark.Project, MapMask As UInt64, ConfigSetStates() As Beacon.ConfigSetState)
		  Var Profile As New Ark.GenericServerProfile("Spawn Simulation", MapMask)
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
		Private mProfile As Ark.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Ark.Project
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
