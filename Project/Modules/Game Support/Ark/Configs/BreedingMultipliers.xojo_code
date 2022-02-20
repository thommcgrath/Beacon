#tag Class
Protected Class BreedingMultipliers
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.BreedingMultipliers = Ark.Configs.BreedingMultipliers(Other)
		  
		  Self.mAllowAnyoneBabyImprintCuddle = Source.mAllowAnyoneBabyImprintCuddle
		  Self.mBabyCuddleGracePeriodMultiplier = Source.mBabyCuddleGracePeriodMultiplier
		  Self.mBabyCuddleIntervalMultiplier = Source.mBabyCuddleIntervalMultiplier
		  Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = Source.mBabyCuddleLoseImprintQualitySpeedMultiplier
		  Self.mBabyFoodConsumptionSpeedMultiplier = Source.mBabyFoodConsumptionSpeedMultiplier
		  Self.mBabyImprintAmountMultiplier = Source.mBabyImprintAmountMultiplier
		  Self.mBabyImprintingStatScaleMultiplier = Source.mBabyImprintingStatScaleMultiplier
		  Self.mBabyMatureSpeedMultiplier = Source.mBabyMatureSpeedMultiplier
		  Self.mDisableImprintDinoBuff = Source.mDisableImprintDinoBuff
		  Self.mEggHatchSpeedMultiplier = Source.mEggHatchSpeedMultiplier
		  Self.mLayEggIntervalMultiplier = Source.mLayEggIntervalMultiplier
		  Self.mMatingIntervalMultiplier = Source.mMatingIntervalMultiplier
		  Self.mMatingSpeedMultiplier = Source.mMatingSpeedMultiplier
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyCuddleGracePeriodMultiplier=" + Self.BabyCuddleGracePeriodMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyCuddleIntervalMultiplier=" + Self.BabyCuddleIntervalMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyCuddleLoseImprintQualitySpeedMultiplier=" + Self.BabyCuddleLoseImprintQualitySpeedMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyFoodConsumptionSpeedMultiplier=" + Self.BabyFoodConsumptionSpeedMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyImprintAmountMultiplier=" + Self.BabyImprintAmountMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyImprintingStatScaleMultiplier=" + Self.BabyImprintingStatScaleMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyMatureSpeedMultiplier=" + Self.BabyMatureSpeedMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "EggHatchSpeedMultiplier=" + Self.EggHatchSpeedMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "LayEggIntervalMultiplier=" + Self.LayEggIntervalMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "MatingIntervalMultiplier=" + Self.MatingIntervalMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "MatingSpeedMultiplier=" + Self.MatingSpeedMultiplier.PrettyText))
		  If (Self.mAllowAnyoneBabyImprintCuddle Is Nil) = False Then
		    Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "AllowAnyoneBabyImprintCuddle=" + If(Self.AllowAnyoneBabyImprintCuddle, "True", "False")))
		  End If
		  If (Self.mDisableImprintDinoBuff Is Nil) = False Then
		    Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "DisableImprintDinoBuff=" + If(Self.DisableImprintDinoBuff, "True", "False")))
		  End If
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyCuddleGracePeriodMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyCuddleIntervalMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyCuddleLoseImprintQualitySpeedMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyFoodConsumptionSpeedMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyImprintAmountMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyImprintingStatScaleMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "BabyMatureSpeedMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "EggHatchSpeedMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "LayEggIntervalMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "MatingIntervalMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "MatingSpeedMultiplier"))
		  If (Self.mAllowAnyoneBabyImprintCuddle Is Nil) = False Then
		    Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "AllowAnyoneBabyImprintCuddle"))
		  End If
		  If (Self.mDisableImprintDinoBuff Is Nil) = False Then
		    Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "DisableImprintDinoBuff"))
		  End If
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Self.mBabyCuddleGracePeriodMultiplier = SaveData.Lookup("BabyCuddleGracePeriodMultiplier", 1.0)
		  Self.mBabyCuddleIntervalMultiplier = SaveData.Lookup("BabyCuddleIntervalMultiplier", 1.0)
		  Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = SaveData.Lookup("BabyCuddleLoseImprintQualitySpeedMultiplier", 1.0)
		  Self.mBabyFoodConsumptionSpeedMultiplier = SaveData.Lookup("BabyFoodConsumptionSpeedMultiplier", 1.0)
		  Self.mBabyImprintAmountMultiplier = SaveData.Lookup("BabyImprintAmountMultiplier", 1.0)
		  Self.mBabyImprintingStatScaleMultiplier = SaveData.Lookup("BabyImprintingStatScaleMultiplier", 1.0)
		  Self.mBabyMatureSpeedMultiplier = SaveData.Lookup("BabyMatureSpeedMultiplier", 1.0)
		  Self.mEggHatchSpeedMultiplier = SaveData.Lookup("EggHatchSpeedMultiplier", 1.0)
		  Self.mLayEggIntervalMultiplier = SaveData.Lookup("LayEggIntervalMultiplier", 1.0)
		  Self.mMatingIntervalMultiplier = SaveData.Lookup("MatingIntervalMultiplier", 1.0)
		  Self.mMatingSpeedMultiplier = SaveData.Lookup("MatingSpeedMultiplier", 1.0)
		  
		  If SaveData.HasKey("AllowAnyoneBabyImprintCuddle") Then
		    Self.mAllowAnyoneBabyImprintCuddle = SaveData.BooleanValue("AllowAnyoneBabyImprintCuddle", False)
		  Else
		    Self.mAllowAnyoneBabyImprintCuddle = Nil
		  End If
		  If SaveData.HasKey("DisableImprintDinoBuff") Then
		    Self.mDisableImprintDinoBuff = SaveData.BooleanValue("DisableImprintDinoBuff", False)
		  Else
		    Self.mDisableImprintDinoBuff = Nil
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  SaveData.Value("BabyCuddleGracePeriodMultiplier") = Self.mBabyCuddleGracePeriodMultiplier
		  SaveData.Value("BabyCuddleIntervalMultiplier") = Self.mBabyCuddleIntervalMultiplier
		  SaveData.Value("BabyCuddleLoseImprintQualitySpeedMultiplier") = Self.mBabyCuddleLoseImprintQualitySpeedMultiplier
		  SaveData.Value("BabyFoodConsumptionSpeedMultiplier") = Self.mBabyFoodConsumptionSpeedMultiplier
		  SaveData.Value("BabyImprintAmountMultiplier") = Self.mBabyImprintAmountMultiplier
		  SaveData.Value("BabyImprintingStatScaleMultiplier") = Self.mBabyImprintingStatScaleMultiplier
		  SaveData.Value("BabyMatureSpeedMultiplier") = Self.mBabyMatureSpeedMultiplier
		  SaveData.Value("EggHatchSpeedMultiplier") = Self.mEggHatchSpeedMultiplier
		  SaveData.Value("LayEggIntervalMultiplier") = Self.mLayEggIntervalMultiplier
		  SaveData.Value("MatingIntervalMultiplier") = Self.mMatingIntervalMultiplier
		  SaveData.Value("MatingSpeedMultiplier") = Self.mMatingSpeedMultiplier
		  If (Self.mAllowAnyoneBabyImprintCuddle Is Nil) = False Then
		    SaveData.Value("AllowAnyoneBabyImprintCuddle") = Self.mAllowAnyoneBabyImprintCuddle.BooleanValue
		  End If
		  If (Self.mDisableImprintDinoBuff Is Nil) = False Then
		    SaveData.Value("DisableImprintDinoBuff") = Self.mDisableImprintDinoBuff.BooleanValue
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  Self.mAllowAnyoneBabyImprintCuddle = False
		  Self.mBabyCuddleGracePeriodMultiplier = 1.0
		  Self.mBabyCuddleIntervalMultiplier = 1.0
		  Self.mBabyCuddleLoseImprintQualitySpeedMultiplier = 1.0
		  Self.mBabyFoodConsumptionSpeedMultiplier = 1.0
		  Self.mBabyImprintAmountMultiplier = 1.0
		  Self.mBabyImprintingStatScaleMultiplier = 1.0
		  Self.mBabyMatureSpeedMultiplier = 1.0
		  Self.mDisableImprintDinoBuff = False
		  Self.mEggHatchSpeedMultiplier = 1.0
		  Self.mLayEggIntervalMultiplier = 1.0
		  Self.mMatingIntervalMultiplier = 1.0
		  Self.mMatingSpeedMultiplier = 1.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.BreedingMultipliers
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused ContentPacks
		  
		  If CommandLineOptions.HasAnyKey("AllowAnyoneBabyImprintCuddle", "DisableImprintDinoBuff") = False And ParsedData.HasAnyKey("AllowAnyoneBabyImprintCuddle", "BabyCuddleGracePeriodMultiplier", "BabyCuddleIntervalMultiplier", "BabyCuddleLoseImprintQualitySpeedMultiplier", "BabyFoodConsumptionSpeedMultiplier", "BabyImprintAmountMultiplier", "BabyImprintingStatScaleMultiplier", "BabyMatureSpeedMultiplier", "DisableImprintDinoBuff", "EggHatchSpeedMultiplier", "LayEggIntervalMultiplier", "MatingIntervalMultiplier", "MatingSpeedMultiplier") = False Then
		    Return Nil
		  End If
		  
		  Var BabyCuddleGracePeriodMultiplier As Double = ParsedData.DoubleValue("BabyCuddleGracePeriodMultiplier", 1.0, True)
		  Var BabyCuddleIntervalMultiplier As Double = ParsedData.DoubleValue("BabyCuddleIntervalMultiplier", 1.0, True)
		  Var BabyCuddleLoseImprintQualitySpeedMultiplier As Double = ParsedData.DoubleValue("BabyCuddleLoseImprintQualitySpeedMultiplier", 1.0, True)
		  Var BabyFoodConsumptionSpeedMultiplier As Double = ParsedData.DoubleValue("BabyFoodConsumptionSpeedMultiplier", 1.0, True)
		  Var BabyImprintAmountMultiplier As Double = ParsedData.DoubleValue("BabyImprintAmountMultiplier", 1.0, True)
		  Var BabyImprintingStatScaleMultiplier As Double = ParsedData.DoubleValue("BabyImprintingStatScaleMultiplier", 1.0, True)
		  Var BabyMatureSpeedMultiplier As Double = ParsedData.DoubleValue("BabyMatureSpeedMultiplier", 1.0, True)
		  Var EggHatchSpeedMultiplier As Double = ParsedData.DoubleValue("EggHatchSpeedMultiplier", 1.0, True)
		  Var LayEggIntervalMultiplier As Double = ParsedData.DoubleValue("LayEggIntervalMultiplier", 1.0, True)
		  Var MatingIntervalMultiplier As Double = ParsedData.DoubleValue("MatingIntervalMultiplier", 1.0, True)
		  Var MatingSpeedMultiplier As Double = ParsedData.DoubleValue("MatingSpeedMultiplier", 1.0, True)
		  
		  Var Multipliers As New Ark.Configs.BreedingMultipliers
		  Multipliers.mBabyCuddleGracePeriodMultiplier = BabyCuddleGracePeriodMultiplier
		  Multipliers.mBabyCuddleIntervalMultiplier = BabyCuddleIntervalMultiplier
		  Multipliers.mBabyCuddleLoseImprintQualitySpeedMultiplier = BabyCuddleLoseImprintQualitySpeedMultiplier
		  Multipliers.mBabyFoodConsumptionSpeedMultiplier = BabyFoodConsumptionSpeedMultiplier
		  Multipliers.mBabyImprintAmountMultiplier = BabyImprintAmountMultiplier
		  Multipliers.mBabyImprintingStatScaleMultiplier = BabyImprintingStatScaleMultiplier
		  Multipliers.mBabyMatureSpeedMultiplier = BabyMatureSpeedMultiplier
		  Multipliers.mEggHatchSpeedMultiplier = EggHatchSpeedMultiplier
		  Multipliers.mLayEggIntervalMultiplier = LayEggIntervalMultiplier
		  Multipliers.mMatingIntervalMultiplier = MatingIntervalMultiplier
		  Multipliers.mMatingSpeedMultiplier = MatingSpeedMultiplier
		  
		  If CommandLineOptions.HasKey("AllowAnyoneBabyImprintCuddle") Then
		    Multipliers.mAllowAnyoneBabyImprintCuddle = CommandLineOptions.BooleanValue("AllowAnyoneBabyImprintCuddle", False)
		  ElseIf ParsedData.HasKey("AllowAnyoneBabyImprintCuddle") Then
		    Multipliers.mAllowAnyoneBabyImprintCuddle = ParsedData.BooleanValue("AllowAnyoneBabyImprintCuddle", False)
		  End If
		  
		  If CommandLineOptions.HasKey("DisableImprintDinoBuff") Then
		    Multipliers.mDisableImprintDinoBuff = CommandLineOptions.BooleanValue("DisableImprintDinoBuff", False)
		  ElseIf ParsedData.HasKey("DisableImprintDinoBuff") Then
		    Multipliers.mDisableImprintDinoBuff = ParsedData.BooleanValue("DisableImprintDinoBuff", False)
		  End If
		  
		  Return Multipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameBreedingMultipliers
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAllowAnyoneBabyImprintCuddle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAllowAnyoneBabyImprintCuddle <> Value Then
			    Self.mAllowAnyoneBabyImprintCuddle = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AllowAnyoneBabyImprintCuddle As NullableBoolean
	#tag EndComputedProperty

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
			  Return Self.mDisableImprintDinoBuff
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDisableImprintDinoBuff <> Value Then
			    Self.mDisableImprintDinoBuff = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DisableImprintDinoBuff As NullableBoolean
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

	#tag Property, Flags = &h21
		Private mAllowAnyoneBabyImprintCuddle As NullableBoolean
	#tag EndProperty

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
		Private mDisableImprintDinoBuff As NullableBoolean
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
			Name="BabyImprintAmountMultiplier"
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
	#tag EndViewBehavior
End Class
#tag EndClass
