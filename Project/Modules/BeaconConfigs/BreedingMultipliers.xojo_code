#tag Class
Protected Class BreedingMultipliers
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Mask As UInt64)
		  #Pragma Unused Mask
		  #Pragma Unused SourceDocument
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "BabyCuddleGracePeriodMultiplier", Self.mBabyCuddleGracePeriodMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "BabyCuddleIntervalMultiplier", Self.mBabyCuddleIntervalMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "BabyCuddleLoseImprintQualitySpeedMultiplier", Self.mBabyCuddleLoseImprintQualitySpeedMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "BabyFoodConsumptionSpeedMultiplier", Self.mBabyFoodConsumptionSpeedMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "BabyImprintingStatScaleMultiplier", Self.mBabyImprintingStatScaleMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "BabyMatureSpeedMultiplier", Self.mBabyMatureSpeedMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "EggHatchSpeedMultiplier", Self.mEggHatchSpeedMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LayEggIntervalMultiplier", Self.mLayEggIntervalMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "MatingIntervalMultiplier", Self.mMatingIntervalMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "MatingSpeedMultiplier", Self.mMatingSpeedMultiplier.PrettyText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Self.mBabyCuddleGracePeriodMultiplier = Dict.Lookup("BabyCuddleGracePeriodMultiplier", 1.0)
		  Self.mBabyCuddleIntervalMultiplier = Dict.Lookup("BabyCuddleIntervalMultiplier", 1.0)
		  Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = Dict.Lookup("BabyCuddleLoseImprintQualitySpeedMultiplier", 1.0)
		  Self.mBabyFoodConsumptionSpeedMultiplier = Dict.Lookup("BabyFoodConsumptionSpeedMultiplier", 1.0)
		  Self.mBabyImprintingStatScaleMultiplier = Dict.Lookup("BabyImprintingStatScaleMultiplier", 1.0)
		  Self.mBabyMatureSpeedMultiplier = Dict.Lookup("BabyMatureSpeedMultiplier", 1.0)
		  Self.mEggHatchSpeedMultiplier = Dict.Lookup("EggHatchSpeedMultiplier", 1.0)
		  Self.mLayEggIntervalMultiplier = Dict.Lookup("LayEggIntervalMultiplier", 1.0)
		  Self.mMatingIntervalMultiplier = Dict.Lookup("MatingIntervalMultiplier", 1.0)
		  Self.mMatingSpeedMultiplier = Dict.Lookup("MatingSpeedMultiplier", 1.0)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dict.Value("BabyCuddleGracePeriodMultiplier") = Self.mBabyCuddleGracePeriodMultiplier
		  Dict.Value("BabyCuddleIntervalMultiplier") = Self.mBabyCuddleIntervalMultiplier
		  Dict.Value("BabyCuddleLoseImprintQualitySpeedMultiplier") = Self.mBabyCuddleLoseImprintQualitySpeedMultiplier
		  Dict.Value("BabyFoodConsumptionSpeedMultiplier") = Self.mBabyFoodConsumptionSpeedMultiplier
		  Dict.Value("BabyImprintingStatScaleMultiplier") = Self.mBabyImprintingStatScaleMultiplier
		  Dict.Value("BabyMatureSpeedMultiplier") = Self.mBabyMatureSpeedMultiplier
		  Dict.Value("EggHatchSpeedMultiplier") = Self.mEggHatchSpeedMultiplier
		  Dict.Value("LayEggIntervalMultiplier") = Self.mLayEggIntervalMultiplier
		  Dict.Value("MatingIntervalMultiplier") = Self.mMatingIntervalMultiplier
		  Dict.Value("MatingSpeedMultiplier") = Self.mMatingSpeedMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "BreedingMultipliers"
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
		  Self.mBabyMatureSpeedMultiplier = 1.0
		  Self.mEggHatchSpeedMultiplier = 1.0
		  Self.mLayEggIntervalMultiplier = 1.0
		  Self.mMatingIntervalMultiplier = 1.0
		  Self.mMatingSpeedMultiplier = 1.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.BreedingMultipliers
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  Dim BabyMatureSpeedMultiplier As Double = ParsedData.DoubleValue("BabyMatureSpeedMultiplier", 1.0, True)
		  Dim EggHatchSpeedMultiplier As Double = ParsedData.DoubleValue("EggHatchSpeedMultiplier", 1.0, True)
		  Dim BabyFoodConsumptionSpeedMultiplier As Double = ParsedData.DoubleValue("BabyFoodConsumptionSpeedMultiplier", 1.0, True)
		  Dim LayEggIntervalMultiplier As Double = ParsedData.DoubleValue("LayEggIntervalMultiplier", 1.0, True)
		  Dim BabyCuddleGracePeriodMultiplier As Double = ParsedData.DoubleValue("BabyCuddleGracePeriodMultiplier", 1.0, True)
		  Dim BabyCuddleIntervalMultiplier As Double = ParsedData.DoubleValue("BabyCuddleIntervalMultiplier", 1.0, True)
		  Dim BabyCuddleLoseImprintQualitySpeedMultiplier As Double = ParsedData.DoubleValue("BabyCuddleLoseImprintQualitySpeedMultiplier", 1.0, True)
		  Dim BabyImprintingStatScaleMultiplier As Double = ParsedData.DoubleValue("BabyImprintingStatScaleMultiplier", 1.0, True)
		  Dim MatingIntervalMultiplier As Double = ParsedData.DoubleValue("MatingIntervalMultiplier", 1.0, True)
		  Dim MatingSpeedMultiplier As Double = ParsedData.DoubleValue("MatingSpeedMultiplier", 1.0, True)
		  
		  If BabyMatureSpeedMultiplier = 1.0 And EggHatchSpeedMultiplier = 1.0 And BabyFoodConsumptionSpeedMultiplier = 1.0 And LayEggIntervalMultiplier = 1.0 And BabyCuddleGracePeriodMultiplier = 1.0 And BabyCuddleIntervalMultiplier = 1.0 And BabyCuddleLoseImprintQualitySpeedMultiplier = 1.0 And BabyImprintingStatScaleMultiplier = 1.0 And MatingIntervalMultiplier = 1.0 And MatingSpeedMultiplier = 1.0 Then
		    Return Nil
		  End If
		  
		  Dim Multipliers As New BeaconConfigs.BreedingMultipliers
		  Multipliers.mBabyCuddleGracePeriodMultiplier = BabyCuddleGracePeriodMultiplier
		  Multipliers.mBabyCuddleIntervalMultiplier = BabyCuddleIntervalMultiplier
		  Multipliers.mBabyCuddleLoseImprintQualitySpeedMultiplier = BabyCuddleLoseImprintQualitySpeedMultiplier
		  Multipliers.mBabyFoodConsumptionSpeedMultiplier = BabyFoodConsumptionSpeedMultiplier
		  Multipliers.mBabyMatureSpeedMultiplier = BabyMatureSpeedMultiplier
		  Multipliers.mEggHatchSpeedMultiplier = EggHatchSpeedMultiplier
		  Multipliers.mLayEggIntervalMultiplier = LayEggIntervalMultiplier
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
			  Return Self.mBabyCuddleIntervalMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsImplicit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyCuddleGracePeriodMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyCuddleIntervalMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyCuddleLoseImprintQualitySpeedMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyFoodConsumptionSpeedMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyImprintingStatScaleMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BabyMatureSpeedMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EggHatchSpeedMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LayEggIntervalMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MatingIntervalMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MatingSpeedMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
