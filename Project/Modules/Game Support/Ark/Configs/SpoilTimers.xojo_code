#tag Class
Protected Class SpoilTimers
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.SpoilTimers = Ark.Configs.SpoilTimers(Other)
		  Self.mAutoDestroyDecayedDinos = Source.mAutoDestroyDecayedDinos
		  Self.mAutoDestroyOldStructuresMultiplier = Source.mAutoDestroyOldStructuresMultiplier
		  Self.mAutoDestroyStructures = Source.mAutoDestroyStructures
		  Self.mClampItemSpoilingTimes = Source.mClampItemSpoilingTimes
		  Self.mCropDecaySpeedMultiplier = Source.mCropDecaySpeedMultiplier
		  Self.mDisableDinoDecayPvE = Source.mDisableDinoDecayPvE
		  Self.mDisableStructureDecayPvE = Source.mDisableStructureDecayPvE
		  Self.mFastDecayInterval = Source.mFastDecayInterval
		  Self.mFastDecayUnsnappedCoreStructures = Source.mFastDecayUnsnappedCoreStructures
		  Self.mGlobalCorpseDecompositionTimeMultiplier = Source.mGlobalCorpseDecompositionTimeMultiplier
		  Self.mGlobalItemDecompositionTimeMultiplier = Source.mGlobalItemDecompositionTimeMultiplier
		  Self.mGlobalSpoilingTimeMultiplier = Source.mGlobalSpoilingTimeMultiplier
		  Self.mOnlyAutoDestroyCoreStructures = Source.mOnlyAutoDestroyCoreStructures
		  Self.mPvEDinoDecayPeriodMultiplier = Source.mPvEDinoDecayPeriodMultiplier
		  Self.mPvEStructureDecayDestructionPeriod = Source.mPvEStructureDecayDestructionPeriod
		  Self.mPvEStructureDecayPeriodMultiplier = Source.mPvEStructureDecayPeriodMultiplier
		  Self.mPvPDinoDecay = Source.mPvPDinoDecay
		  Self.mPvPStructureDecay = Source.mPvPStructureDecay
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  
		  Values.Add(New Ark.ConfigValue("CommandLineFlag", "-", "AutoDestroyStructures=" + If(Self.mAutoDestroyStructures, "True", "False")))
		  
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "AutoDestroyDecayedDinos=" + If(Self.mAutoDestroyDecayedDinos, "True", "False")))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "AutoDestroyOldStructuresMultiplier=" + Self.mAutoDestroyOldStructuresMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "ClampItemSpoilingTimes=" + If(Self.mClampItemSpoilingTimes, "True", "False")))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "FastDecayUnsnappedCoreStructures=" + If(Self.mFastDecayUnsnappedCoreStructures, "True", "False")))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "OnlyAutoDestroyCoreStructures=" + If(Self.mOnlyAutoDestroyCoreStructures, "True", "False")))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "OnlyDecayUnsnappedCoreStructures=" + If(Self.mOnlyDecayUnsnappedCoreStructures, "True", "False")))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "PvEDinoDecayPeriodMultiplier=" + Self.mPvEDinoDecayPeriodMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "PvPDinoDecay=" + If(Self.mPvPDinoDecay, "True", "False")))
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "PvPStructureDecay=" + If(Self.mPvPStructureDecay, "True", "False")))
		  
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "CropDecaySpeedMultiplier=" + Self.mCropDecaySpeedMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "FastDecayInterval=" + Self.mFastDecayInterval.ToString(Locale.Raw, "0")))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "GlobalSpoilingTimeMultiplier=" + Self.mGlobalSpoilingTimeMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "GlobalCorpseDecompositionTimeMultiplier=" + Self.mGlobalCorpseDecompositionTimeMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "GlobalItemDecompositionTimeMultiplier=" + Self.mGlobalItemDecompositionTimeMultiplier.PrettyText))
		  
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DisableDinoDecayPvE=" + If(Self.mDisableDinoDecayPvE, "True", "False")))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DisableStructureDecayPvE=" + If(Self.mDisableStructureDecayPvE, "True", "False")))
		  If Self.mPvEStructureDecayDestructionPeriod <> 0 Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "PvEStructureDecayDestructionPeriod=" + Self.mPvEStructureDecayDestructionPeriod.ToString(Locale.Raw, "0")))
		  End If
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "PvEStructureDecayPeriodMultiplier=" + Self.mPvEStructureDecayPeriodMultiplier.PrettyText))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  
		  Keys.Add(New Ark.ConfigKey("CommandLineFlag", "-", "AutoDestroyStructures"))
		  
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "AutoDestroyDecayedDinos"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "AutoDestroyOldStructuresMultiplier"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "ClampItemSpoilingTimes"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "FastDecayUnsnappedCoreStructures"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "OnlyAutoDestroyCoreStructures"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "OnlyDecayUnsnappedCoreStructures"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "PvEDinoDecayPeriodMultiplier"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "PvPDinoDecay"))
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "PvPStructureDecay"))
		  
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "CropDecaySpeedMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "FastDecayInterval"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "GlobalSpoilingTimeMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "GlobalItemDecompositionTimeMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "GlobalCorpseDecompositionTimeMultiplier"))
		  
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DisableDinoDecayPvE"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DisableStructureDecayPvE"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "PvEStructureDecayDestructionPeriod"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "PvEStructureDecayPeriodMultiplier"))
		  
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, Identity As Beacon.Identity, Project As Ark.Project)
		  #Pragma Unused Identity
		  #Pragma Unused Project
		  
		  Self.mAutoDestroyDecayedDinos = SaveData.Value("AutoDestroyDecayedDinos")
		  Self.mAutoDestroyOldStructuresMultiplier = SaveData.Value("AutoDestroyOldStructuresMultiplier")
		  Self.mAutoDestroyStructures = SaveData.Value("AutoDestroyStructures")
		  Self.mClampItemSpoilingTimes = SaveData.Value("ClampItemSpoilingTimes")
		  Self.mCropDecaySpeedMultiplier = SaveData.Value("CropDecaySpeedMultiplier")
		  Self.mDisableDinoDecayPvE = SaveData.Value("DisableDinoDecayPvE")
		  Self.mDisableStructureDecayPvE = SaveData.Value("DisableStructureDecayPvE")
		  Self.mFastDecayInterval = SaveData.Value("FastDecayInterval")
		  Self.mFastDecayUnsnappedCoreStructures = SaveData.Value("FastDecayUnsnappedCoreStructures")
		  Self.mGlobalCorpseDecompositionTimeMultiplier = SaveData.Value("GlobalCorpseDecompositionTimeMultiplier")
		  Self.mGlobalItemDecompositionTimeMultiplier = SaveData.Value("GlobalItemDecompositionTimeMultiplier")
		  Self.mGlobalSpoilingTimeMultiplier = SaveData.Value("GlobalSpoilingTimeMultiplier")
		  Self.mOnlyAutoDestroyCoreStructures = SaveData.Value("OnlyAutoDestroyCoreStructures")
		  Self.mOnlyDecayUnsnappedCoreStructures = SaveData.Value("OnlyDecayUnsnappedCoreStructures")
		  Self.mPvEDinoDecayPeriodMultiplier = SaveData.Value("PvEDinoDecayPeriodMultiplier")
		  Self.mPvEStructureDecayDestructionPeriod = SaveData.Value("PvEStructureDecayDestructionPeriod")
		  Self.mPvEStructureDecayPeriodMultiplier = SaveData.Value("PvEStructureDecayPeriodMultiplier")
		  Self.mPvPDinoDecay = SaveData.Value("PvPDinoDecay")
		  Self.mPvPStructureDecay = SaveData.Value("PvPStructureDecay")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary)
		  SaveData.Value("AutoDestroyDecayedDinos") = Self.mAutoDestroyDecayedDinos
		  SaveData.Value("AutoDestroyOldStructuresMultiplier") = Self.mAutoDestroyOldStructuresMultiplier
		  SaveData.Value("AutoDestroyStructures") = Self.mAutoDestroyStructures
		  SaveData.Value("ClampItemSpoilingTimes") = Self.mClampItemSpoilingTimes
		  SaveData.Value("CropDecaySpeedMultiplier") = Self.mCropDecaySpeedMultiplier
		  SaveData.Value("DisableDinoDecayPvE") = Self.mDisableDinoDecayPvE
		  SaveData.Value("DisableStructureDecayPvE") = Self.mDisableStructureDecayPvE
		  SaveData.Value("FastDecayInterval") = Self.mFastDecayInterval
		  SaveData.Value("FastDecayUnsnappedCoreStructures") = Self.mFastDecayUnsnappedCoreStructures
		  SaveData.Value("GlobalCorpseDecompositionTimeMultiplier") = Self.mGlobalCorpseDecompositionTimeMultiplier
		  SaveData.Value("GlobalItemDecompositionTimeMultiplier") = Self.mGlobalItemDecompositionTimeMultiplier
		  SaveData.Value("GlobalSpoilingTimeMultiplier") = Self.mGlobalSpoilingTimeMultiplier
		  SaveData.Value("OnlyAutoDestroyCoreStructures") = Self.mOnlyAutoDestroyCoreStructures
		  SaveData.Value("OnlyDecayUnsnappedCoreStructures") = Self.mOnlyDecayUnsnappedCoreStructures
		  SaveData.Value("PvEDinoDecayPeriodMultiplier") = Self.mPvEDinoDecayPeriodMultiplier
		  SaveData.Value("PvEStructureDecayDestructionPeriod") = Self.mPvEStructureDecayDestructionPeriod
		  SaveData.Value("PvEStructureDecayPeriodMultiplier") = Self.mPvEStructureDecayPeriodMultiplier
		  SaveData.Value("PvPDinoDecay") = Self.mPvPDinoDecay
		  SaveData.Value("PvPStructureDecay") = Self.mPvPStructureDecay
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.SpoilTimers
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused ContentPacks
		  
		  Var Spoil As New Ark.Configs.SpoilTimers
		  
		  // Flags
		  If CommandLineOptions.HasKey("AutoDestroyStructures") Then
		    Spoil.AutoDestroyStructures = CommandLineOptions.BooleanValue("AutoDestroyStructures", Spoil.AutoDestroyStructures)
		  ElseIf ParsedData.HasKey("AutoDestroyStructures") Then
		    Spoil.AutoDestroyStructures = ParsedData.BooleanValue("AutoDestroyStructures", Spoil.AutoDestroyStructures)
		  End If
		  
		  // Options
		  If CommandLineOptions.HasKey("AutoDestroyDecayedDinos") Then
		    Spoil.AutoDestroyDecayedDinos = CommandLineOptions.BooleanValue("AutoDestroyDecayedDinos", Spoil.AutoDestroyDecayedDinos)
		  ElseIf ParsedData.HasKey("AutoDestroyDecayedDinos") Then
		    Spoil.AutoDestroyDecayedDinos = ParsedData.BooleanValue("AutoDestroyDecayedDinos", Spoil.AutoDestroyDecayedDinos)
		  End If
		  If CommandLineOptions.HasKey("AutoDestroyOldStructuresMultiplier") Then
		    Spoil.AutoDestroyOldStructuresMultiplier = CommandLineOptions.DoubleValue("AutoDestroyOldStructuresMultiplier", Spoil.AutoDestroyOldStructuresMultiplier)
		  ElseIf ParsedData.HasKey("AutoDestroyOldStructuresMultiplier") Then
		    Spoil.AutoDestroyOldStructuresMultiplier = ParsedData.DoubleValue("AutoDestroyOldStructuresMultiplier", Spoil.AutoDestroyOldStructuresMultiplier)
		  End If
		  If CommandLineOptions.HasKey("ClampItemSpoilingTimes") Then
		    Spoil.ClampItemSpoilingTimes = CommandLineOptions.BooleanValue("ClampItemSpoilingTimes", Spoil.ClampItemSpoilingTimes)
		  ElseIf ParsedData.HasKey("ClampItemSpoilingTimes") Then
		    Spoil.ClampItemSpoilingTimes = ParsedData.BooleanValue("ClampItemSpoilingTimes", Spoil.ClampItemSpoilingTimes)
		  End If
		  If CommandLineOptions.HasKey("FastDecayUnsnappedCoreStructures") Then
		    Spoil.FastDecayUnsnappedCoreStructures = CommandLineOptions.BooleanValue("FastDecayUnsnappedCoreStructures", Spoil.FastDecayUnsnappedCoreStructures)
		  ElseIf ParsedData.HasKey("FastDecayUnsnappedCoreStructures") Then
		    Spoil.FastDecayUnsnappedCoreStructures = ParsedData.BooleanValue("FastDecayUnsnappedCoreStructures", Spoil.FastDecayUnsnappedCoreStructures)
		  End If
		  If CommandLineOptions.HasKey("OnlyAutoDestroyCoreStructures") Then
		    Spoil.OnlyAutoDestroyCoreStructures = CommandLineOptions.BooleanValue("OnlyAutoDestroyCoreStructures", Spoil.OnlyAutoDestroyCoreStructures)
		  ElseIf ParsedData.HasKey("OnlyAutoDestroyCoreStructures") Then
		    Spoil.OnlyAutoDestroyCoreStructures = ParsedData.BooleanValue("OnlyAutoDestroyCoreStructures", Spoil.OnlyAutoDestroyCoreStructures)
		  End If
		  If CommandLineOptions.HasKey("OnlyDecayUnsnappedCoreStructures") Then
		    Spoil.OnlyDecayUnsnappedCoreStructures = CommandLineOptions.BooleanValue("OnlyDecayUnsnappedCoreStructures", Spoil.OnlyDecayUnsnappedCoreStructures)
		  ElseIf ParsedData.HasKey("OnlyDecayUnsnappedCoreStructures") Then
		    Spoil.OnlyDecayUnsnappedCoreStructures = ParsedData.BooleanValue("OnlyDecayUnsnappedCoreStructures", Spoil.OnlyDecayUnsnappedCoreStructures)
		  End If
		  If CommandLineOptions.HasKey("PvEDinoDecayPeriodMultiplier") Then
		    Spoil.PvEDinoDecayPeriodMultiplier = CommandLineOptions.DoubleValue("PvEDinoDecayPeriodMultiplier", Spoil.PvEDinoDecayPeriodMultiplier)
		  ElseIf ParsedData.HasKey("PvEDinoDecayPeriodMultiplier") Then
		    Spoil.PvEDinoDecayPeriodMultiplier = ParsedData.DoubleValue("PvEDinoDecayPeriodMultiplier", Spoil.PvEDinoDecayPeriodMultiplier)
		  End If
		  If CommandLineOptions.HasKey("PvPDinoDecay") Then
		    Spoil.PvPDinoDecay = CommandLineOptions.BooleanValue("PvPDinoDecay", Spoil.PvPDinoDecay)
		  ElseIf ParsedData.HasKey("PvPDinoDecay") Then
		    Spoil.PvPDinoDecay = ParsedData.BooleanValue("PvPDinoDecay", Spoil.PvPDinoDecay)
		  End If
		  If CommandLineOptions.HasKey("PvPStructureDecay") Then
		    Spoil.PvPStructureDecay = CommandLineOptions.BooleanValue("PvPStructureDecay", Spoil.PvPStructureDecay)
		  ElseIf ParsedData.HasKey("PvPStructureDecay") Then
		    Spoil.PvPStructureDecay = ParsedData.BooleanValue("PvPStructureDecay", Spoil.PvPStructureDecay)
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

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameSpoilTimers
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
		Private mAutoDestroyDecayedDinos As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDestroyOldStructuresMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDestroyStructures As Boolean = False
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
		Private mFastDecayUnsnappedCoreStructures As Boolean = False
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
		Private mOnlyAutoDestroyCoreStructures As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOnlyDecayUnsnappedCoreStructures As Boolean = False
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
	#tag EndViewBehavior
End Class
#tag EndClass
