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
		Function GetBooleanVariable(Key As Text) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDoubleVariable(Key As Text) As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByClass(ClassString As Text) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEngramByPath(Path As Text) As Beacon.Engram
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIntegerVariable(Key As Text) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLootSource(ClassString As Text) As Beacon.LootSource
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPreset(PresetID As Text) As Beacon.Preset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPresetModifier(ModifierID As Text) As Beacon.PresetModifier
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTextVariable(Key As Text) As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPresetCustom(Preset As Beacon.Preset) As Boolean
		  
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
		Sub RemovePreset(Preset As Beacon.Preset)
		  
		End Sub
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
		Function SearchForEngrams(SearchText As Text, ConsoleSafe As Boolean, Filter As Beacon.EngramSearchFilter = Nil) As Beacon.Engram()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchForLootSources(SearchText As Text, ConsoleSafe As Boolean, IncludeExperimental As Boolean) As Beacon.LootSource()
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Interface
#tag EndInterface
