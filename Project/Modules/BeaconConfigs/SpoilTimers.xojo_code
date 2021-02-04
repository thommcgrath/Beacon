#tag Class
Protected Class SpoilTimers
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  Var Values() As Beacon.ConfigValue
		  
		  Values.Add(New Beacon.ConfigValue("CommandLineFlag", "-", "AutoDestroyStructures"))
		  
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "AutoDestroyDecayedDinos=" + If(Self.mAutoDestroyDecayedDinos, "True", "False")))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "AutoDestroyOldStructuresMultiplier=" + Self.mAutoDestroyOldStructuresMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "ClampItemSpoilingTimes=" + If(Self.mClampItemSpoilingTimes, "True", "False")))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "FastDecayUnsnappedCoreStructures=" + If(Self.mFastDecayUnsnappedCoreStructures, "True", "False")))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "OnlyAutoDestroyCoreStructures=" + If(Self.mOnlyAutoDestroyCoreStructures, "True", "False")))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "OnlyDecayUnsnappedCoreStructures=" + If(Self.mOnlyDecayUnsnappedCoreStructures, "True", "False")))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "PvEDinoDecayPeriodMultiplier=" + Self.mPvEDinoDecayPeriodMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "PvPDinoDecay=" + If(Self.mPvPDinoDecay, "True", "False")))
		  Values.Add(New Beacon.ConfigValue("CommandLineOption", "?", "PvPStructureDecay=" + If(Self.mPvPStructureDecay, "True", "False")))
		  
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "CropDecaySpeedMultiplier=" + Self.mCropDecaySpeedMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "FastDecayInterval=" + Self.mFastDecayInterval.ToString(Locale.Raw, "0")))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "GlobalSpoilingTimeMultiplier=" + Self.mGlobalSpoilingTimeMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "GlobalCorpseDecompositionTimeMultiplier=" + Self.mGlobalCorpseDecompositionTimeMultiplier.PrettyText))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "GlobalItemDecompositionTimeMultiplier=" + Self.mGlobalItemDecompositionTimeMultiplier.PrettyText))
		  
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "DisableDinoDecayPvE=" + If(Self.mDisableDinoDecayPvE, "True", "False")))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "DisableStructureDecayPvE=" + If(Self.mDisableStructureDecayPvE, "True", "False")))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "PvEStructureDecayDestructionPeriod=" + Self.mPvEStructureDecayDestructionPeriod.ToString(Locale.Raw, "0")))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "PvEStructureDecayPeriodMultiplier=" + Self.mPvEStructureDecayPeriodMultiplier.PrettyText))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  
		  Keys.Add(New Beacon.ConfigKey("CommandLineFlag", "-", "AutoDestroyStructures"))
		  
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "AutoDestroyDecayedDinos"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "AutoDestroyOldStructuresMultiplier"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "ClampItemSpoilingTimes"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "FastDecayUnsnappedCoreStructures"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "OnlyDecayUnsnappedCoreStructures"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "OnlyDecayUnsnappedCoreStructures"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "PvEDinoDecayPeriodMultiplier"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "PvPDinoDecay"))
		  Keys.Add(New Beacon.ConfigKey("CommandLineOption", "?", "PvPStructureDecay"))
		  
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "CropDecaySpeedMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "FastDecayInterval"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "GlobalSpoilingTimeMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "GlobalItemDecompositionTimeMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "GlobalCorpseDecompositionTimeMultiplier"))
		  
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "DisableDinoDecayPvE"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "DisableStructureDecayPvE"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "PvEStructureDecayDestructionPeriod"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "PvEStructureDecayPeriodMultiplier"))
		  
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  Self.mAutoDestroyDecayedDinos = Dict.Value("AutoDestroyDecayedDinos")
		  Self.mAutoDestroyOldStructuresMultiplier = Dict.Value("AutoDestroyOldStructuresMultiplier")
		  Self.mAutoDestroyStructures = Dict.Value("AutoDestroyStructures")
		  Self.mClampItemSpoilingTimes = Dict.Value("ClampItemSpoilingTimes")
		  Self.mCropDecaySpeedMultiplier = Dict.Value("CropDecaySpeedMultiplier")
		  Self.mDisableDinoDecayPvE = Dict.Value("DisableDinoDecayPvE")
		  Self.mDisableStructureDecayPvE = Dict.Value("DisableStructureDecayPvE")
		  Self.mFastDecayInterval = Dict.Value("FastDecayInterval")
		  Self.mFastDecayUnsnappedCoreStructures = Dict.Value("FastDecayUnsnappedCoreStructures")
		  Self.mGlobalCorpseDecompositionTimeMultiplier = Dict.Value("GlobalCorpseDecompositionTimeMultiplier")
		  Self.mGlobalItemDecompositionTimeMultiplier = Dict.Value("GlobalItemDecompositionTimeMultiplier")
		  Self.mGlobalSpoilingTimeMultiplier = Dict.Value("GlobalSpoilingTimeMultiplier")
		  Self.mOnlyAutoDestroyCoreStructures = Dict.Value("OnlyAutoDestroyCoreStructures")
		  Self.mOnlyDecayUnsnappedCoreStructures = Dict.Value("OnlyDecayUnsnappedCoreStructures")
		  Self.mPvEDinoDecayPeriodMultiplier = Dict.Value("PvEDinoDecayPeriodMultiplier")
		  Self.mPvEStructureDecayDestructionPeriod = Dict.Value("PvEStructureDecayDestructionPeriod")
		  Self.mPvEStructureDecayPeriodMultiplier = Dict.Value("PvEStructureDecayPeriodMultiplier")
		  Self.mPvPDinoDecay = Dict.Value("PvPDinoDecay")
		  Self.mPvPStructureDecay = Dict.Value("PvPStructureDecay")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("AutoDestroyDecayedDinos") = Self.mAutoDestroyDecayedDinos
		  Dict.Value("AutoDestroyOldStructuresMultiplier") = Self.mAutoDestroyOldStructuresMultiplier
		  Dict.Value("AutoDestroyStructures") = Self.mAutoDestroyStructures
		  Dict.Value("ClampItemSpoilingTimes") = Self.mClampItemSpoilingTimes
		  Dict.Value("CropDecaySpeedMultiplier") = Self.mCropDecaySpeedMultiplier
		  Dict.Value("DisableDinoDecayPvE") = Self.mDisableDinoDecayPvE
		  Dict.Value("DisableStructureDecayPvE") = Self.mDisableStructureDecayPvE
		  Dict.Value("FastDecayInterval") = Self.mFastDecayInterval
		  Dict.Value("FastDecayUnsnappedCoreStructures") = Self.mFastDecayUnsnappedCoreStructures
		  Dict.Value("GlobalCorpseDecompositionTimeMultiplier") = Self.mGlobalCorpseDecompositionTimeMultiplier
		  Dict.Value("GlobalItemDecompositionTimeMultiplier") = Self.mGlobalItemDecompositionTimeMultiplier
		  Dict.Value("GlobalSpoilingTimeMultiplier") = Self.mGlobalSpoilingTimeMultiplier
		  Dict.Value("OnlyAutoDestroyCoreStructures") = Self.mOnlyAutoDestroyCoreStructures
		  Dict.Value("OnlyDecayUnsnappedCoreStructures") = Self.mOnlyDecayUnsnappedCoreStructures
		  Dict.Value("PvEDinoDecayPeriodMultiplier") = Self.mPvEDinoDecayPeriodMultiplier
		  Dict.Value("PvEStructureDecayDestructionPeriod") = Self.mPvEStructureDecayDestructionPeriod
		  Dict.Value("PvEStructureDecayPeriodMultiplier") = Self.mPvEStructureDecayPeriodMultiplier
		  Dict.Value("PvPDinoDecay") = Self.mPvPDinoDecay
		  Dict.Value("PvPStructureDecay") = Self.mPvPStructureDecay
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameSpoilTimers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.SpoilTimers
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  Var Spoil As New BeaconConfigs.SpoilTimers
		  
		  // Flags
		  If CommandLineOptions.HasKey("AutoDestroyStructures") Then
		    Spoil.AutoDestroyStructures = CommandLineOptions.BooleanValue("AutoDestroyStructures", Spoil.AutoDestroyStructures)
		  End If
		  
		  // Options
		  If CommandLineOptions.HasKey("AutoDestroyDecayedDinos") Then
		    Spoil.AutoDestroyDecayedDinos = CommandLineOptions.BooleanValue("AutoDestroyDecayedDinos", Spoil.AutoDestroyDecayedDinos)
		  End If
		  If CommandLineOptions.HasKey("AutoDestroyOldStructuresMultiplier") Then
		    Spoil.AutoDestroyOldStructuresMultiplier = CommandLineOptions.DoubleValue("AutoDestroyOldStructuresMultiplier", Spoil.AutoDestroyOldStructuresMultiplier)
		  End If
		  If CommandLineOptions.HasKey("ClampItemSpoilingTimes") Then
		    Spoil.ClampItemSpoilingTimes = CommandLineOptions.BooleanValue("ClampItemSpoilingTimes", Spoil.ClampItemSpoilingTimes)
		  End If
		  If CommandLineOptions.HasKey("FastDecayUnsnappedCoreStructures") Then
		    Spoil.FastDecayUnsnappedCoreStructures = CommandLineOptions.BooleanValue("FastDecayUnsnappedCoreStructures", Spoil.FastDecayUnsnappedCoreStructures)
		  End If
		  If CommandLineOptions.HasKey("OnlyAutoDestroyCoreStructures") Then
		    Spoil.OnlyAutoDestroyCoreStructures = CommandLineOptions.BooleanValue("OnlyAutoDestroyCoreStructures", Spoil.OnlyAutoDestroyCoreStructures)
		  End If
		  If CommandLineOptions.HasKey("OnlyDecayUnsnappedCoreStructures") Then
		    Spoil.OnlyDecayUnsnappedCoreStructures = CommandLineOptions.BooleanValue("OnlyDecayUnsnappedCoreStructures", Spoil.OnlyDecayUnsnappedCoreStructures)
		  End If
		  If CommandLineOptions.HasKey("PvEDinoDecayPeriodMultiplier") Then
		    Spoil.PvEDinoDecayPeriodMultiplier = CommandLineOptions.DoubleValue("PvEDinoDecayPeriodMultiplier", Spoil.PvEDinoDecayPeriodMultiplier)
		  End If
		  If CommandLineOptions.HasKey("PvPDinoDecay") Then
		    Spoil.PvPDinoDecay = CommandLineOptions.BooleanValue("PvPDinoDecay", Spoil.PvPDinoDecay)
		  End If
		  If CommandLineOptions.HasKey("PvPStructureDecay") Then
		    Spoil.PvPStructureDecay = CommandLineOptions.BooleanValue("PvPStructureDecay", Spoil.PvPStructureDecay)
		  End If
		  
		  // Game.ini
		  If ParsedData.HasKey("CropDecaySpeedMultiplier") Then
		    Spoil.CropDecaySpeedMultiplier = ParsedData.DoubleValue("CropDecaySpeedMultiplier", Spoil.CropDecaySpeedMultiplier)
		  End If
		  If ParsedData.HasKey("FastDecayInterval") Then
		    Spoil.FastDecayInterval = ParsedData.DoubleValue("FastDecayInterval", Spoil.FastDecayInterval)
		  End If
		  If ParsedData.HasKey("GlobalSpoilingTimeMultiplier") Then
		    Spoil.GlobalSpoilingTimeMultiplier = ParsedData.DoubleValue("GlobalSpoilingTimeMultiplier", Spoil.GlobalSpoilingTimeMultiplier)
		  End If
		  If ParsedData.HasKey("GlobalCorpseDecompositionTimeMultiplier") Then
		    Spoil.GlobalCorpseDecompositionTimeMultiplier = ParsedData.DoubleValue("GlobalCorpseDecompositionTimeMultiplier", Spoil.GlobalCorpseDecompositionTimeMultiplier)
		  End If
		  If ParsedData.HasKey("GlobalItemDecompositionTimeMultiplier") Then
		    Spoil.GlobalItemDecompositionTimeMultiplier = ParsedData.DoubleValue("GlobalItemDecompositionTimeMultiplier", Spoil.GlobalItemDecompositionTimeMultiplier)
		  End If
		  
		  // GameUserSettings.ini
		  If ParsedData.HasKey("DisableDinoDecayPvE") Then
		    Spoil.DisableDinoDecayPvE = ParsedData.BooleanValue("DisableDinoDecayPvE", Spoil.DisableDinoDecayPvE)
		  End If
		  If ParsedData.HasKey("DisableStructureDecayPvE") Then
		    Spoil.DisableStructureDecayPvE = ParsedData.BooleanValue("DisableStructureDecayPvE", Spoil.DisableStructureDecayPvE)
		  End If
		  If ParsedData.HasKey("PvEStructureDecayDestructionPeriod") Then
		    Spoil.PvEStructureDecayDestructionPeriod = ParsedData.DoubleValue("PvEStructureDecayDestructionPeriod", Spoil.PvEStructureDecayDestructionPeriod)
		  End If
		  If ParsedData.HasKey("PvEStructureDecayPeriodMultiplier") Then
		    Spoil.PvEStructureDecayPeriodMultiplier = ParsedData.DoubleValue("PvEStructureDecayPeriodMultiplier", Spoil.PvEStructureDecayPeriodMultiplier)
		  End If
		  
		  If Spoil.Modified Then
		    Return Spoil
		  End If
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAutoDestroyDecayedDinos
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAutoDestroyDecayedDinos <> Value Then
			    Self.mAutoDestroyDecayedDinos = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AutoDestroyDecayedDinos As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAutoDestroyOldStructuresMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAutoDestroyOldStructuresMultiplier <> Value Then
			    Self.mAutoDestroyOldStructuresMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AutoDestroyOldStructuresMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAutoDestroyStructures
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAutoDestroyStructures <> Value Then
			    Self.mAutoDestroyStructures = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		AutoDestroyStructures As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mClampItemSpoilingTimes
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mClampItemSpoilingTimes <> Value Then
			    Self.mClampItemSpoilingTimes = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ClampItemSpoilingTimes As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCropDecaySpeedMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCropDecaySpeedMultiplier <> Value Then
			    Self.mCropDecaySpeedMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		CropDecaySpeedMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDisableDinoDecayPvE
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDisableDinoDecayPvE <> Value Then
			    Self.mDisableDinoDecayPvE = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DisableDinoDecayPvE As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDisableStructureDecayPvE
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDisableStructureDecayPvE <> Value Then
			    Self.mDisableStructureDecayPvE = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DisableStructureDecayPvE As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFastDecayInterval
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mFastDecayInterval <> Value Then
			    Self.mFastDecayInterval = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		FastDecayInterval As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFastDecayUnsnappedCoreStructures
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mFastDecayUnsnappedCoreStructures <> Value Then
			    Self.mFastDecayUnsnappedCoreStructures = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		FastDecayUnsnappedCoreStructures As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGlobalCorpseDecompositionTimeMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGlobalCorpseDecompositionTimeMultiplier <> Value Then
			    Self.mGlobalCorpseDecompositionTimeMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GlobalCorpseDecompositionTimeMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGlobalItemDecompositionTimeMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGlobalItemDecompositionTimeMultiplier <> Value Then
			    Self.mGlobalItemDecompositionTimeMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GlobalItemDecompositionTimeMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGlobalSpoilingTimeMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGlobalSpoilingTimeMultiplier <> Value Then
			    Self.mGlobalSpoilingTimeMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GlobalSpoilingTimeMultiplier As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAutoDestroyDecayedDinos As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDestroyOldStructuresMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDestroyStructures As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mClampItemSpoilingTimes As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCropDecaySpeedMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisableDinoDecayPvE As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisableStructureDecayPvE As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFastDecayInterval As Integer = 43200
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFastDecayUnsnappedCoreStructures As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGlobalCorpseDecompositionTimeMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGlobalItemDecompositionTimeMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGlobalSpoilingTimeMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOnlyAutoDestroyCoreStructures As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOnlyDecayUnsnappedCoreStructures As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPvEDinoDecayPeriodMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPvEStructureDecayDestructionPeriod As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPvEStructureDecayPeriodMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPvPDinoDecay As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPvPStructureDecay As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOnlyAutoDestroyCoreStructures
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOnlyAutoDestroyCoreStructures <> Value Then
			    Self.mOnlyAutoDestroyCoreStructures = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		OnlyAutoDestroyCoreStructures As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mOnlyDecayUnsnappedCoreStructures
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mOnlyDecayUnsnappedCoreStructures <> Value Then
			    Self.mOnlyDecayUnsnappedCoreStructures = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		OnlyDecayUnsnappedCoreStructures As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPvEDinoDecayPeriodMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPvEDinoDecayPeriodMultiplier <> Value Then
			    Self.mPvEDinoDecayPeriodMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PvEDinoDecayPeriodMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPvEStructureDecayDestructionPeriod
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPvEStructureDecayDestructionPeriod <> Value Then
			    Self.mPvEStructureDecayDestructionPeriod = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PvEStructureDecayDestructionPeriod As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPvEStructureDecayPeriodMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPvEStructureDecayPeriodMultiplier <> Value Then
			    Self.mPvEStructureDecayPeriodMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PvEStructureDecayPeriodMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPvPDinoDecay
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPvPDinoDecay <> Value Then
			    Self.mPvPDinoDecay = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PvPDinoDecay As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPvPStructureDecay
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPvPStructureDecay <> Value Then
			    Self.mPvPStructureDecay = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PvPStructureDecay As Boolean
	#tag EndComputedProperty


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
			Name="AutoDestroyDecayedDinos"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClampItemSpoilingTimes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CropDecaySpeedMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisableDinoDecayPvE"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisableStructureDecayPvE"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FastDecayInterval"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FastDecayUnsnappedCoreStructures"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GlobalSpoilingTimeMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OnlyDecayUnsnappedCoreStructures"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PvEDinoDecayPeriodMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PvEStructureDecayDestructionPeriod"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PvEStructureDecayPeriodMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PvPDinoDecay"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PvPStructureDecay"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDestroyOldStructuresMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDestroyStructures"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OnlyAutoDestroyCoreStructures"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GlobalCorpseDecompositionTimeMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GlobalItemDecompositionTimeMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
