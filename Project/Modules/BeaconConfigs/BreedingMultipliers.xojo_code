#tag Class
Protected Class BreedingMultipliers
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  Var Values() As Beacon.ConfigValue
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyCuddleGracePeriodMultiplier=" + Self.BabyCuddleGracePeriodMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyCuddleIntervalMultiplier=" + Self.BabyCuddleIntervalMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyCuddleLoseImprintQualitySpeedMultiplier=" + Self.BabyCuddleLoseImprintQualitySpeedMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyFoodConsumptionSpeedMultiplier=" + Self.BabyFoodConsumptionSpeedMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyImprintingStatScaleMultiplier=" + Self.BabyImprintingStatScaleMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyImprintAmountMultiplier=" + Self.BabyImprintAmountMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyMatureSpeedMultiplier=" + Self.BabyMatureSpeedMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "EggHatchSpeedMultiplier=" + Self.EggHatchSpeedMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "LayEggIntervalMultiplier=" + Self.LayEggIntervalMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MatingIntervalMultiplier=" + Self.MatingIntervalMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MatingSpeedMultiplier=" + Self.MatingSpeedMultiplier.PrettyText))
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyCuddleGracePeriodMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyCuddleIntervalMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyCuddleLoseImprintQualitySpeedMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyFoodConsumptionSpeedMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyImprintingStatScaleMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyImprintAmountMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "BabyMatureSpeedMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "EggHatchSpeedMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "LayEggIntervalMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MatingIntervalMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MatingSpeedMultiplier"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  Self.mBabyCuddleGracePeriodMultiplier = Dict.Lookup("BabyCuddleGracePeriodMultiplier", 1.0)
		  Self.mBabyCuddleIntervalMultiplier = Dict.Lookup("BabyCuddleIntervalMultiplier", 1.0)
		  Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = Dict.Lookup("BabyCuddleLoseImprintQualitySpeedMultiplier", 1.0)
		  Self.mBabyFoodConsumptionSpeedMultiplier = Dict.Lookup("BabyFoodConsumptionSpeedMultiplier", 1.0)
		  Self.mBabyImprintingStatScaleMultiplier = Dict.Lookup("BabyImprintingStatScaleMultiplier", 1.0)
		  Self.mBabyImprintAmountMultiplier = Dict.Lookup("BabyImprintAmountMultiplier", 1.0)
		  Self.mBabyMatureSpeedMultiplier = Dict.Lookup("BabyMatureSpeedMultiplier", 1.0)
		  Self.mEggHatchSpeedMultiplier = Dict.Lookup("EggHatchSpeedMultiplier", 1.0)
		  Self.mLayEggIntervalMultiplier = Dict.Lookup("LayEggIntervalMultiplier", 1.0)
		  Self.mMatingIntervalMultiplier = Dict.Lookup("MatingIntervalMultiplier", 1.0)
		  Self.mMatingSpeedMultiplier = Dict.Lookup("MatingSpeedMultiplier", 1.0)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("BabyCuddleGracePeriodMultiplier") = Self.mBabyCuddleGracePeriodMultiplier
		  Dict.Value("BabyCuddleIntervalMultiplier") = Self.mBabyCuddleIntervalMultiplier
		  Dict.Value("BabyCuddleLoseImprintQualitySpeedMultiplier") = Self.mBabyCuddleLoseImprintQualitySpeedMultiplier
		  Dict.Value("BabyFoodConsumptionSpeedMultiplier") = Self.mBabyFoodConsumptionSpeedMultiplier
		  Dict.Value("BabyImprintingStatScaleMultiplier") = Self.mBabyImprintingStatScaleMultiplier
		  Dict.Value("BabyImprintAmountMultiplier") = Self.mBabyImprintAmountMultiplier
		  Dict.Value("BabyMatureSpeedMultiplier") = Self.mBabyMatureSpeedMultiplier
		  Dict.Value("EggHatchSpeedMultiplier") = Self.mEggHatchSpeedMultiplier
		  Dict.Value("LayEggIntervalMultiplier") = Self.mLayEggIntervalMultiplier
		  Dict.Value("MatingIntervalMultiplier") = Self.mMatingIntervalMultiplier
		  Dict.Value("MatingSpeedMultiplier") = Self.mMatingSpeedMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameBreedingMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  Self.mBabyCuddleGracePeriodMultiplier = 1.0
		  Self.mBabyCuddleIntervalMultiplier = 1.0
		  Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = 1.0
		  Self.mBabyFoodConsumptionSpeedMultiplier = 1.0
		  Self.mBabyImprintingStatScaleMultiplier = 1.0
		  Self.mBabyImprintAmountMultiplier = 1.0
		  Self.mBabyMatureSpeedMultiplier = 1.0
		  Self.mEggHatchSpeedMultiplier = 1.0
		  Self.mLayEggIntervalMultiplier = 1.0
		  Self.mMatingIntervalMultiplier = 1.0
		  Self.mMatingSpeedMultiplier = 1.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.BreedingMultipliers
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  If ParsedData.HasAnyKey("BabyMatureSpeedMultiplier", "EggHatchSpeedMultiplier", "BabyFoodConsumptionSpeedMultiplier", "LayEggIntervalMultiplier", "BabyCuddleGracePeriodMultiplier", "BabyCuddleIntervalMultiplier", "BabyCuddleLoseImprintQualitySpeedMultiplier", "BabyImprintingStatScaleMultiplier", "MatingIntervalMultiplier", "MatingSpeedMultiplier") = False Then
		    Return Nil
		  End If
		  
		  Var BabyMatureSpeedMultiplier As Double = ParsedData.DoubleValue("BabyMatureSpeedMultiplier", 1.0, True)
		  Var EggHatchSpeedMultiplier As Double = ParsedData.DoubleValue("EggHatchSpeedMultiplier", 1.0, True)
		  Var BabyFoodConsumptionSpeedMultiplier As Double = ParsedData.DoubleValue("BabyFoodConsumptionSpeedMultiplier", 1.0, True)
		  Var LayEggIntervalMultiplier As Double = ParsedData.DoubleValue("LayEggIntervalMultiplier", 1.0, True)
		  Var BabyCuddleGracePeriodMultiplier As Double = ParsedData.DoubleValue("BabyCuddleGracePeriodMultiplier", 1.0, True)
		  Var BabyCuddleIntervalMultiplier As Double = ParsedData.DoubleValue("BabyCuddleIntervalMultiplier", 1.0, True)
		  Var BabyCuddleLoseImprintQualitySpeedMultiplier As Double = ParsedData.DoubleValue("BabyCuddleLoseImprintQualitySpeedMultiplier", 1.0, True)
		  Var BabyImprintingStatScaleMultiplier As Double = ParsedData.DoubleValue("BabyImprintingStatScaleMultiplier", 1.0, True)
		  Var BabyImprintAmountMultiplier As Double = ParsedData.DoubleValue("BabyImprintAmountMultiplier", 1.0, True)
		  Var MatingIntervalMultiplier As Double = ParsedData.DoubleValue("MatingIntervalMultiplier", 1.0, True)
		  Var MatingSpeedMultiplier As Double = ParsedData.DoubleValue("MatingSpeedMultiplier", 1.0, True)
		  
		  Var Multipliers As New BeaconConfigs.BreedingMultipliers
		  Multipliers.mBabyCuddleGracePeriodMultiplier = BabyCuddleGracePeriodMultiplier
		  Multipliers.mBabyCuddleIntervalMultiplier = BabyCuddleIntervalMultiplier
		  Multipliers.mBabyCuddleLoseImprintQualitySpeedMultiplier = BabyCuddleLoseImprintQualitySpeedMultiplier
		  Multipliers.mBabyFoodConsumptionSpeedMultiplier = BabyFoodConsumptionSpeedMultiplier
		  Multipliers.mBabyMatureSpeedMultiplier = BabyMatureSpeedMultiplier
		  Multipliers.mEggHatchSpeedMultiplier = EggHatchSpeedMultiplier
		  Multipliers.mLayEggIntervalMultiplier = LayEggIntervalMultiplier
		  Multipliers.mBabyImprintingStatScaleMultiplier = BabyImprintingStatScaleMultiplier
		  Multipliers.mBabyImprintAmountMultiplier = BabyImprintAmountMultiplier
		  Multipliers.mMatingIntervalMultiplier = MatingIntervalMultiplier
		  Multipliers.mMatingSpeedMultiplier = MatingSpeedMultiplier
		  Return Multipliers
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBabyCuddleGracePeriodMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBabyCuddleGracePeriodMultiplier <> Value Then
			    Self.mBabyCuddleGracePeriodMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyCuddleGracePeriodMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mBabyCuddleIntervalMultiplier, Self.MinImprintIntervalMultiplier)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, Self.MinImprintIntervalMultiplier)
			  
			  If Self.mBabyCuddleIntervalMultiplier <> Value Then
			    Self.mBabyCuddleIntervalMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyCuddleIntervalMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBabyCuddleLoseImprintQualitySpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBabyCuddleLoseImprintQualitySpeedMultiplier <> Value Then
			    Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyCuddleLoseImprintQualitySpeedMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBabyFoodConsumptionSpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBabyFoodConsumptionSpeedMultiplier <> Value Then
			    Self.mBabyFoodConsumptionSpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyFoodConsumptionSpeedMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBabyImprintAmountMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBabyImprintAmountMultiplier <> Value Then
			    Self.mBabyImprintAmountMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyImprintAmountMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBabyImprintingStatScaleMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBabyImprintingStatScaleMultiplier <> Value Then
			    Self.mBabyImprintingStatScaleMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyImprintingStatScaleMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mBabyMatureSpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mBabyMatureSpeedMultiplier <> Value Then
			    Self.mBabyMatureSpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		BabyMatureSpeedMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEggHatchSpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEggHatchSpeedMultiplier <> Value Then
			    Self.mEggHatchSpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		EggHatchSpeedMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLayEggIntervalMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mLayEggIntervalMultiplier <> Value Then
			    Self.mLayEggIntervalMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		LayEggIntervalMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMatingIntervalMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMatingIntervalMultiplier <> Value Then
			    Self.mMatingIntervalMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		MatingIntervalMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMatingSpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMatingSpeedMultiplier <> Value Then
			    Self.mMatingSpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		MatingSpeedMultiplier As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBabyCuddleGracePeriodMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBabyCuddleIntervalMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBabyCuddleLoseImprintQualitySpeedMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBabyFoodConsumptionSpeedMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBabyImprintAmountMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBabyImprintingStatScaleMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBabyMatureSpeedMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEggHatchSpeedMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLayEggIntervalMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMatingIntervalMultiplier As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMatingSpeedMultiplier As Double
	#tag EndProperty


	#tag Constant, Name = MinImprintIntervalMultiplier, Type = Double, Dynamic = False, Default = \"0.0001", Scope = Public
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
			Name="BabyCuddleGracePeriodMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyCuddleIntervalMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyCuddleLoseImprintQualitySpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyFoodConsumptionSpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyImprintingStatScaleMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyMatureSpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EggHatchSpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LayEggIntervalMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MatingIntervalMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MatingSpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyImprintAmountMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
