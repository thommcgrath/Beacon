#tag Class
Protected Class StatLimits
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.StatLimits = Ark.Configs.StatLimits(Other)
		  For Index As Integer = 0 To Self.mValues.LastIndex
		    Self.mValues(Index) = Source.mValues(Index)
		  Next Index
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  Var EnableClamping As Boolean = False
		  
		  For I As Integer = 0 To Self.mValues.LastIndex
		    If Self.mValues(I) Is Nil Then
		      Continue
		    End If
		    
		    EnableClamping = True
		    
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ItemStatClamps[" + I.ToString + "]=" + Self.mValues(I).DoubleValue.PrettyText, I))
		  Next
		  
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "ClampItemStats=" + If(EnableClamping, "True", "False")))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ItemStatClamps"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ClampItemStats"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, Identity As Beacon.Identity, Project As Ark.Project)
		  #Pragma Unused Identity
		  #Pragma Unused Project
		  
		  If SaveData.HasKey("Armor") Then
		    Self.mValues(Self.StatArmor) = SaveData.Value("Armor").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Generic") Then
		    Self.mValues(Self.StatGenericQuality) = SaveData.Value("Generic").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Hyper") Then
		    Self.mValues(Self.StatHyperthermal) = SaveData.Value("Hyper").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Hypo") Then
		    Self.mValues(Self.StatHypothermal) = SaveData.Value("Hypo").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Durability") Then
		    Self.mValues(Self.StatMaxDurability) = SaveData.Value("Durability").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Ammo") Then
		    Self.mValues(Self.StatWeaponAmmo) = SaveData.Value("Ammo").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Damage") Then
		    Self.mValues(Self.StatWeaponDamage) = SaveData.Value("Damage").DoubleValue
		  End If
		  
		  If SaveData.HasKey("Weight") Then
		    Self.mValues(Self.StatWeight) = SaveData.Value("Weight").DoubleValue
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary)
		  If (Self.mValues(Self.StatArmor) Is Nil) = False Then
		    SaveData.Value("Armor") = Self.mValues(Self.StatArmor).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatGenericQuality) Is Nil) = False Then
		    SaveData.Value("Generic") = Self.mValues(Self.StatGenericQuality).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatHyperthermal) Is Nil) = False Then
		    SaveData.Value("Hyper") = Self.mValues(Self.StatHyperthermal).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatHypothermal) Is Nil) = False Then
		    SaveData.Value("Hypo") = Self.mValues(Self.StatHypothermal).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatMaxDurability) Is Nil) = False Then
		    SaveData.Value("Durability") = Self.mValues(Self.StatMaxDurability).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatWeaponAmmo) Is Nil) = False Then
		    SaveData.Value("Ammo") = Self.mValues(Self.StatWeaponAmmo).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatWeaponDamage) Is Nil) = False Then
		    SaveData.Value("Damage") = Self.mValues(Self.StatWeaponDamage).DoubleValue
		  End If
		  
		  If (Self.mValues(Self.StatWeight) Is Nil) = False Then
		    SaveData.Value("Weight") = Self.mValues(Self.StatWeight).DoubleValue
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ComputeEffectiveLimit(Value As Double, InitialValueConstant As Double, StateModifierScale As Double, RandomRangeMultiplier As Double) As Double
		  Return InitialValueConstant + ((Value * StateModifierScale) * (RandomRangeMultiplier * InitialValueConstant))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, Mods As Beacon.StringList) As Ark.Configs.StatLimits
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  Var Config As New Ark.Configs.StatLimits()
		  
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
		Function InternalName() As String
		  Return Ark.Configs.NameStatLimits
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
	#tag EndViewBehavior
End Class
#tag EndClass
