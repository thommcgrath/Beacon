#tag Interface
Protected Interface DataSource
	#tag Method, Flags = &h0
		Sub AddPresetModifier(Modifier As Beacon.PresetModifier)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllPresetModifiers() As Beacon.PresetModifier()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleSafeMods() As String()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeletePreset(Preset As Beacon.Preset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBlueprintByObjectID(ObjectID As v4UUID) As Beacon.Blueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBooleanVariable(Key As String, Default As Boolean = False) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByClass(ClassString As String) As Beacon.Creature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByID(CreatureID As v4UUID) As Beacon.Creature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCreatureByPath(Path As String) As Beacon.Creature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As String, Default As Double = 0.0) As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByClass(ClassString As String) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByEntryString(EntryString As String) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByID(EngramID As v4UUID) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByPath(Path As String) As Beacon.Engram
		  
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
		Function GetPreset(PresetID As String) As Beacon.Preset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifier(ModifierID As String) As Beacon.PresetModifier
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByClass(ClassString As String) As Beacon.SpawnPoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByID(SpawnPointID As v4UUID) As Beacon.SpawnPoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSpawnPointByPath(Path As String) As Beacon.SpawnPoint
		  
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
		Sub LoadPresets()
		  
		End Sub
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
		Sub SaveNotification(Notification As Beacon.UserNotification)
		  
		End Sub
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
		Function SearchForEngramEntries(SearchText As String, Mods As Beacon.StringList, Tags As String) As Beacon.Engram()
		  
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
