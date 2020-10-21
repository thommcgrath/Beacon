#tag Class
Protected Class DayCycle
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  Values.Add(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "DayCycleSpeedScale", "1.0"))
		  Values.Add(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "DayTimeSpeedScale", Self.DaySpeedMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "NightTimeSpeedScale", Self.NightSpeedMultiplier.PrettyText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Document
		  #Pragma Unused Identity
		  
		  If Dict.HasKey("Day") Then
		    Self.mDaySpeedMultiplier = Dict.Value("Day").DoubleValue
		  End If
		  If Dict.HasKey("Night") Then
		    Self.mNightSpeedMultiplier = Dict.Value("Night").DoubleValue
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Day") = Self.mDaySpeedMultiplier
		  Dict.Value("Night") = Self.mNightSpeedMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "DayCycle"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mDaySpeedMultiplier = 1.0
		  Self.mNightSpeedMultiplier = 1.0
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.DayCycle
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  If ParsedData.HasAnyKey("DayCycleSpeedScale", "DayTimeSpeedScale", "NightTimeSpeedScale") = False Then
		    Return Nil
		  End If
		  
		  Var OverallCycleMultiplier As Double = 1.0
		  Var DaySpeedMultiplier As Double = 1.0
		  Var NightSpeedMultiplier As Double = 1.0
		  
		  OverallCycleMultiplier = ParsedData.DoubleValue("DayCycleSpeedScale", OverallCycleMultiplier)
		  DaySpeedMultiplier = ParsedData.DoubleValue("DayTimeSpeedScale", DaySpeedMultiplier)
		  NightSpeedMultiplier = ParsedData.DoubleValue("NightTimeSpeedScale", NightSpeedMultiplier)
		  
		  Var Config As New BeaconConfigs.DayCycle()
		  Config.DaySpeedMultiplier = DaySpeedMultiplier / (1 / OverallCycleMultiplier)
		  Config.NightSpeedMultiplier = NightSpeedMultiplier / (1 / OverallCycleMultiplier)
		  Return Config
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
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
