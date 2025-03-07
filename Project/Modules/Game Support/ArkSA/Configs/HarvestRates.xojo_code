#tag Class
Protected Class HarvestRates
Inherits ArkSA.ConfigGroup
Implements Beacon.BlueprintConsumer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.HarvestRates = ArkSA.Configs.HarvestRates(Other)
		  Self.mClampResourceHarvestDamage = Source.mClampResourceHarvestDamage
		  Self.mDinoHarvestingDamageMultiplier = Source.mDinoHarvestingDamageMultiplier
		  Self.mHarvestAmountMultiplier = Source.mHarvestAmountMultiplier
		  Self.mHarvestHealthMultiplier = Source.mHarvestHealthMultiplier
		  Self.mPlayerHarvestingDamageMultiplier = Source.mPlayerHarvestingDamageMultiplier
		  Self.mUseOptimizedRates = Source.mUseOptimizedRates
		  
		  Var Engrams() As ArkSA.Engram = Source.Engrams
		  For Each Engram As ArkSA.Engram In Engrams
		    Self.mOverrides.Value(Engram, Self.RateAttribute) = Source.mOverrides.Value(Engram, Self.RateAttribute)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As ArkSA.ConfigValue
		  
		  Values.Add(New ArkSA.ConfigValue("CommandLineOption", "?", "UseOptimizedHarvestingHealth=" + If(Self.mUseOptimizedRates, "True", "False")))
		  
		  Var Engrams() As ArkSA.Engram = Self.Engrams
		  For Each Engram As ArkSA.Engram In Engrams
		    If Engram.ValidForProject(Project) Then
		      Var Rate As Double = Self.mOverrides.Value(Engram, Self.RateAttribute)
		      Values.Add(Self.GenerateOverrideConfig(Engram, Rate))
		    End If
		  Next
		  
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PlayerHarvestingDamageMultiplier=" + Self.mPlayerHarvestingDamageMultiplier.PrettyText))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoHarvestingDamageMultiplier=" + Self.mDinoHarvestingDamageMultiplier.PrettyText))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "HarvestAmountMultiplier=" + Self.mHarvestAmountMultiplier.PrettyText))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "HarvestHealthMultiplier=" + Self.mHarvestHealthMultiplier.PrettyText))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "ClampResourceHarvestDamage=" + If(Self.mClampResourceHarvestDamage, "True", "False")))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption("CommandLineOption", "?", "UseOptimizedHarvestingHealth"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "HarvestResourceItemAmountClassMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PlayerHarvestingDamageMultiplier"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoHarvestingDamageMultiplier"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "HarvestAmountMultiplier"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "HarvestHealthMultiplier"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "ClampResourceHarvestDamage"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  Var References() As ArkSA.BlueprintReference = Self.mOverrides.References
		  For Each Reference As ArkSA.BlueprintReference In References
		    Var Blueprint As ArkSA.Blueprint = Reference.Resolve(ContentPackIds, 0)
		    If Blueprint Is Nil Then
		      Self.mOverrides.Remove(Reference.BlueprintId)
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  // There is a slight performance impact here, since DoubleValue will check HasKey too,
		  // but this way is safe.
		  If SaveData.HasKey("Harvest Amount Multiplier") Then
		    Self.mHarvestAmountMultiplier = SaveData.DoubleValue("Harvest Amount Multiplier", 1.0)
		  ElseIf SaveData.HasKey("Global") Then
		    Self.mHarvestAmountMultiplier = SaveData.DoubleValue("Global", 1.0)
		  End If
		  
		  Self.mHarvestHealthMultiplier = SaveData.DoubleValue("Harvest Health Multiplier", 1.0)
		  Self.mUseOptimizedRates = SaveData.BooleanValue("Use Optimized Rates", False)
		  Self.mClampResourceHarvestDamage = SaveData.BooleanValue("Clamp Resource Harvest Damage", False)
		  Self.mPlayerHarvestingDamageMultiplier = SaveData.DoubleValue("Player Harvesting Damage Multiplier", 1.0)
		  Self.mDinoHarvestingDamageMultiplier = SaveData.DoubleValue("Dino Harvesting Damage Multiplier", 1.0)
		  
		  If SaveData.HasKey("Multipliers") Then
		    Var Overrides As ArkSA.BlueprintAttributeManager = ArkSA.BlueprintAttributeManager.FromSaveData(SaveData.Value("Multipliers"))
		    If (Overrides Is Nil) = False Then
		      Self.mOverrides = Overrides
		    End If
		  ElseIf SaveData.HasKey("Rates") Then
		    Var Rates As Dictionary = SaveData.DictionaryValue("Rates", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As ArkSA.Engram = ArkSA.ResolveEngram("", Entry.Key, "", Nil, True)
		        Self.mOverrides.Value(Engram, Self.RateAttribute) = Entry.Value.DoubleValue
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Else
		    Var Rates As Dictionary = SaveData.DictionaryValue("Overrides", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As ArkSA.Engram = ArkSA.ResolveEngram("", "", Entry.Key, Nil, True)
		        Self.mOverrides.Value(Engram, Self.RateAttribute) = Entry.Value.DoubleValue
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  SaveData.Value("Harvest Amount Multiplier") = Self.mHarvestAmountMultiplier
		  SaveData.Value("Harvest Health Multiplier") = Self.mHarvestHealthMultiplier
		  SaveData.Value("Multipliers") = Self.mOverrides.SaveData
		  SaveData.Value("Use Optimized Rates") = Self.mUseOptimizedRates
		  SaveData.Value("Clamp Resource Harvest Damage") = Self.mClampResourceHarvestDamage
		  SaveData.Value("Player Harvesting Damage Multiplier") = Self.mPlayerHarvestingDamageMultiplier
		  SaveData.Value("Dino Harvesting Damage Multiplier") = Self.mDinoHarvestingDamageMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mClampResourceHarvestDamage = False
		  Self.mDinoHarvestingDamageMultiplier = 3.2
		  Self.mHarvestAmountMultiplier = 1.0
		  Self.mHarvestHealthMultiplier = 1.0
		  Self.mPlayerHarvestingDamageMultiplier = 1.0
		  Self.mUseOptimizedRates = False
		  Self.mOverrides = New ArkSA.BlueprintAttributeManager
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return CType(Self.mOverrides.Count, UInteger)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As ArkSA.Engram()
		  Var References() As ArkSA.BlueprintReference = Self.mOverrides.References
		  Var Results() As ArkSA.Engram
		  For Each Reference As ArkSA.BlueprintReference In References
		    If Not Reference.IsEngram Then
		      Continue
		    End If
		    
		    Var Blueprint As ArkSA.Blueprint = Reference.Resolve
		    If (Blueprint Is Nil = False) And Blueprint IsA ArkSA.Engram Then
		      Results.Add(ArkSA.Engram(Blueprint))
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.HarvestRates
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If ParsedData.HasAnyKey("HarvestAmountMultiplier", "HarvestHealthMultiplier", "PlayerHarvestingDamageMultiplier", "DinoHarvestingDamageMultiplier", "ClampResourceHarvestDamage", "HarvestResourceItemAmountClassMultipliers") = False And (CommandLineOptions Is Nil Or CommandLineOptions.HasKey("UseOptimizedHarvestingHealth") = False) Then
		    Return Nil
		  End If
		  
		  Var HarvestAmountMultiplier As Double = ParsedData.DoubleValue("HarvestAmountMultiplier", 1.0, True)
		  Var HarvestHealthMultiplier As Double = ParsedData.DoubleValue("HarvestHealthMultiplier", 1.0, True)
		  Var PlayerHarvestingDamageMultiplier As Double = ParsedData.DoubleValue("PlayerHarvestingDamageMultiplier", 1.0, True)
		  Var DinoHarvestingDamageMultiplier As Double = ParsedData.DoubleValue("DinoHarvestingDamageMultiplier", 1.0, True)
		  Var ClampResourceHarvestDamage As Boolean = ParsedData.BooleanValue("ClampResourceHarvestDamage", False, True)
		  Var UseOptimizedRates As Boolean = False
		  Var Overrides As New ArkSA.BlueprintAttributeManager
		  
		  If (CommandLineOptions Is Nil) = False And CommandLineOptions.HasKey("UseOptimizedHarvestingHealth") Then
		    Try
		      UseOptimizedRates = CommandLineOptions.BooleanValue("UseOptimizedHarvestingHealth", False, False)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ParsedData.HasKey("HarvestResourceItemAmountClassMultipliers") Then
		    Var AutoValue As Variant = ParsedData.Value("HarvestResourceItemAmountClassMultipliers")
		    Var Dicts() As Dictionary
		    Var Info As Introspection.TypeInfo = Introspection.GetType(AutoValue)
		    Select Case Info.FullName
		    Case "Dictionary"
		      Dicts.Add(AutoValue)
		    Case "Object()"
		      Var ArrayValue() As Variant = AutoValue
		      For Each Dict As Dictionary In ArrayValue
		        Dicts.Add(Dict)
		      Next
		    End Select
		    
		    For Each Dict As Dictionary In Dicts
		      If Not Dict.HasAllKeys("ClassName", "Multiplier") Then
		        Continue
		      End If   
		      
		      Var Multiplier As Double = Dict.Value("Multiplier")
		      Var ClassString As String = Dict.Value("ClassName")
		      
		      If ClassString <> "" And ClassString.EndsWith("_C") And Multiplier > 0 Then
		        Var Engram As ArkSA.Engram = ArkSA.ResolveEngram("", "", ClassString, ContentPacks, True)
		        Overrides.Value(Engram, RateAttribute) = Multiplier
		      End If
		    Next
		  End If
		  
		  Var Config As New ArkSA.Configs.HarvestRates
		  Config.HarvestAmountMultiplier = HarvestAmountMultiplier
		  Config.HarvestHealthMultiplier = HarvestHealthMultiplier
		  Config.PlayerHarvestingDamageMultiplier = PlayerHarvestingDamageMultiplier
		  Config.DinoHarvestingDamageMultiplier = DinoHarvestingDamageMultiplier
		  Config.ClampResourceHarvestDamage = ClampResourceHarvestDamage
		  Config.UseOptimizedRates = UseOptimizedRates
		  Config.mOverrides = Overrides
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenerateOverrideConfig(Engram As ArkSA.Engram, Rate As Double) As ArkSA.ConfigValue
		  Return New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "HarvestResourceItemAmountClassMultipliers=(ClassName=""" + Engram.ClassString + """,Multiplier=" + Rate.PrettyText + ")", "HarvestResourceItemAmountClassMultipliers:" + Engram.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameHarvestRates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Return Self.mOverrides.MigrateBlueprints(Migrator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(Engram As ArkSA.Engram) As Double
		  Var Multiplier As Variant = Self.mOverrides.Value(Engram, Self.RateAttribute)
		  If Multiplier.IsNull Then
		    Return 1.0
		  End If
		  Return Multiplier.DoubleValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(Engram As ArkSA.Engram, Assigns Rate As Double)
		  If Engram Is Nil Then
		    Return
		  End If
		  
		  If Rate <= 0 And Self.mOverrides.HasBlueprint(Engram) Then
		    Self.mOverrides.Remove(Engram)
		    Self.Modified = True
		  ElseIf Rate > 0 And (Self.mOverrides.HasAttribute(Engram, Self.RateAttribute) = False Or Self.Override(Engram) <> Rate) Then
		    Self.mOverrides.Value(Engram, Self.RateAttribute) = Rate
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mClampResourceHarvestDamage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mClampResourceHarvestDamage <> Value Then
			    Self.mClampResourceHarvestDamage = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ClampResourceHarvestDamage As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoHarvestingDamageMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDinoHarvestingDamageMultiplier <> Value Then
			    Self.mDinoHarvestingDamageMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DinoHarvestingDamageMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHarvestAmountMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHarvestAmountMultiplier <> Value Then
			    Self.mHarvestAmountMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		HarvestAmountMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHarvestHealthMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHarvestHealthMultiplier <> Value Then
			    Self.mHarvestHealthMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		HarvestHealthMultiplier As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mClampResourceHarvestDamage As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDinoHarvestingDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHarvestAmountMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHarvestHealthMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverrides As ArkSA.BlueprintAttributeManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerHarvestingDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseOptimizedRates As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerHarvestingDamageMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPlayerHarvestingDamageMultiplier <> Value Then
			    Self.mPlayerHarvestingDamageMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PlayerHarvestingDamageMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUseOptimizedRates
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mUseOptimizedRates <> Value Then
			    Self.mUseOptimizedRates = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		UseOptimizedRates As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = RateAttribute, Type = String, Dynamic = False, Default = \"Multiplier", Scope = Private
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
			Name="ClampResourceHarvestDamage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DinoHarvestingDamageMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HarvestAmountMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HarvestHealthMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerHarvestingDamageMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseOptimizedRates"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
