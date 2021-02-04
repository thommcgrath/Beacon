#tag Class
Protected Class StatLimits
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  Var Values() As Beacon.ConfigValue
		  Var EnableClamping As Boolean = False
		  
		  For I As Integer = 0 To Self.mValues.LastIndex
		    If Self.mValues(I) = Nil Then
		      Continue
		    End If
		    
		    EnableClamping = True
		    
		    Var Value As Double = Self.mValues(I)
		    Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ItemStatClamps[" + I.ToString + "]=" + Value.PrettyText, I))
		  Next
		  
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "ClampItemStats=" + If(EnableClamping, "True", "False")))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ItemStatClamps"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "ClampItemStats"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Armor") Then
		    Self.mValues(Self.StatArmor) = Dict.Value("Armor").DoubleValue
		  End If
		  
		  If Dict.HasKey("Generic") Then
		    Self.mValues(Self.StatGenericQuality) = Dict.Value("Generic").DoubleValue
		  End If
		  
		  If Dict.HasKey("Hyper") Then
		    Self.mValues(Self.StatHyperthermal) = Dict.Value("Hyper").DoubleValue
		  End If
		  
		  If Dict.HasKey("Hypo") Then
		    Self.mValues(Self.StatHypothermal) = Dict.Value("Hypo").DoubleValue
		  End If
		  
		  If Dict.HasKey("Durability") Then
		    Self.mValues(Self.StatMaxDurability) = Dict.Value("Durability").DoubleValue
		  End If
		  
		  If Dict.HasKey("Ammo") Then
		    Self.mValues(Self.StatWeaponAmmo) = Dict.Value("Ammo").DoubleValue
		  End If
		  
		  If Dict.HasKey("Damage") Then
		    Self.mValues(Self.StatWeaponDamage) = Dict.Value("Damage").DoubleValue
		  End If
		  
		  If Dict.HasKey("Weight") Then
		    Self.mValues(Self.StatWeight) = Dict.Value("Weight").DoubleValue
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  If Self.mValues(Self.StatArmor) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatArmor)
		    Dict.Value("Armor") = Value
		  End If
		  
		  If Self.mValues(Self.StatGenericQuality) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatGenericQuality)
		    Dict.Value("Generic") = Value
		  End If
		  
		  If Self.mValues(Self.StatHyperthermal) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatHyperthermal)
		    Dict.Value("Hyper") = Value
		  End If
		  
		  If Self.mValues(Self.StatHypothermal) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatHypothermal)
		    Dict.Value("Hypo") = Value
		  End If
		  
		  If Self.mValues(Self.StatMaxDurability) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatMaxDurability)
		    Dict.Value("Durability") = Value
		  End If
		  
		  If Self.mValues(Self.StatWeaponAmmo) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatWeaponAmmo)
		    Dict.Value("Ammo") = Value
		  End If
		  
		  If Self.mValues(Self.StatWeaponDamage) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatWeaponDamage)
		    Dict.Value("Damage") = Value
		  End If
		  
		  If Self.mValues(Self.StatWeight) <> Nil Then
		    Var Value As Double = Self.mValues(Self.StatWeight)
		    Dict.Value("Weight") = Value
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ComputeEffectiveLimit(Value As Double, InitialValueConstant As Double, StateModifierScale As Double, RandomRangeMultiplier As Double) As Double
		  Return InitialValueConstant + ((Value * StateModifierScale) * (RandomRangeMultiplier * InitialValueConstant))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameStatLimits
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.StatLimits
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  Var Config As New BeaconConfigs.StatLimits()
		  
		  For Index As Integer = 0 To Config.mValues.LastIndex
		    Var ValueTestOne As Double = ParsedData.DoubleValue("ItemStatClamps[" + Index.ToString + "]", 100.0, True)
		    Var ValueTestTwo As Double = ParsedData.DoubleValue("ItemStatClamps[" + Index.ToString + "]", 200.0, True)
		    
		    If ValueTestOne <> ValueTestTwo Then
		      // Default
		      Config.Value(Index) = Nil
		    Else
		      Config.Value(Index) = ValueTestOne
		    End If
		  Next
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SolveForDesiredLimit(Limit As Double, InitialValueConstant As Double, StateModifierScale As Double, RandomRangeMultiplier As Double) As Double
		  Return (Limit - InitialValueConstant) / (StateModifierScale * RandomRangeMultiplier * InitialValueConstant)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Stat As Integer) As NullableDouble
		  Return Self.mValues(Stat)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Stat As Integer, Assigns Value As NullableDouble)
		  If Self.mValues(Stat) = Value Then
		    Return
		  End If
		  
		  Self.mValues(Stat) = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mValues(7) As NullableDouble
	#tag EndProperty


	#tag Constant, Name = StatArmor, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatGenericQuality, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatHyperthermal, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatHypothermal, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatMaxDurability, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatWeaponAmmo, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatWeaponDamage, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StatWeight, Type = Double, Dynamic = False, Default = \"6", Scope = Public
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
