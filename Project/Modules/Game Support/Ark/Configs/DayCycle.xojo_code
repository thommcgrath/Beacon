#tag Class
Protected Class DayCycle
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Self.mDaySpeedMultiplier = Ark.Configs.DayCycle(Other).mDaySpeedMultiplier
		  Self.mNightSpeedMultiplier = Ark.Configs.DayCycle(Other).mNightSpeedMultiplier
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DayCycleSpeedScale=1.0"))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DayTimeSpeedScale=" + Self.DaySpeedMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "NightTimeSpeedScale=" + Self.NightSpeedMultiplier.PrettyText))
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DayCycleSpeedScale"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DayTimeSpeedScale"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "NightTimeSpeedScale"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("Day") Then
		    Self.mDaySpeedMultiplier = SaveData.Value("Day").DoubleValue
		  End If
		  If SaveData.HasKey("Night") Then
		    Self.mNightSpeedMultiplier = SaveData.Value("Night").DoubleValue
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  SaveData.Value("Day") = Self.mDaySpeedMultiplier
		  SaveData.Value("Night") = Self.mNightSpeedMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mDaySpeedMultiplier = 1.0
		  Self.mNightSpeedMultiplier = 1.0
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.DayCycle
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused ContentPacks
		  
		  If ParsedData.HasAnyKey("DayCycleSpeedScale", "DayTimeSpeedScale", "NightTimeSpeedScale") = False Then
		    Return Nil
		  End If
		  
		  Var OverallCycleMultiplier As Double = 1.0
		  Var DaySpeedMultiplier As Double = 1.0
		  Var NightSpeedMultiplier As Double = 1.0
		  
		  OverallCycleMultiplier = ParsedData.DoubleValue("DayCycleSpeedScale", OverallCycleMultiplier)
		  DaySpeedMultiplier = ParsedData.DoubleValue("DayTimeSpeedScale", DaySpeedMultiplier)
		  NightSpeedMultiplier = ParsedData.DoubleValue("NightTimeSpeedScale", NightSpeedMultiplier)
		  
		  Var Config As New Ark.Configs.DayCycle()
		  Config.DaySpeedMultiplier = DaySpeedMultiplier / (1 / OverallCycleMultiplier)
		  Config.NightSpeedMultiplier = NightSpeedMultiplier / (1 / OverallCycleMultiplier)
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameDayCycle
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDaySpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #if AllowZeroMultipliers
			    Value = Max(Value, 0)
			  #else
			    Value = Max(Value, 0.000001)
			  #endif
			  If Self.mDaySpeedMultiplier <> Value Then
			    Self.mDaySpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DaySpeedMultiplier As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDaySpeedMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNightSpeedMultiplier As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNightSpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #if AllowZeroMultipliers
			    Value = Max(Value, 0)
			  #else
			    Value = Max(Value, 0.000001)
			  #endif
			  If Self.mNightSpeedMultiplier <> Value Then
			    Self.mNightSpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		NightSpeedMultiplier As Double
	#tag EndComputedProperty


	#tag Constant, Name = AllowZeroMultipliers, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
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
			Name="DaySpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NightSpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
