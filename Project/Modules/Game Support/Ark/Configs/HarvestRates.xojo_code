#tag Class
Protected Class HarvestRates
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.HarvestRates = Ark.Configs.HarvestRates(Other)
		  Self.mClampResourceHarvestDamage = Source.mClampResourceHarvestDamage
		  Self.mDinoHarvestingDamageMultiplier = Source.mDinoHarvestingDamageMultiplier
		  Self.mHarvestAmountMultiplier = Source.mHarvestAmountMultiplier
		  Self.mHarvestHealthMultiplier = Source.mHarvestHealthMultiplier
		  Self.mPlayerHarvestingDamageMultiplier = Source.mPlayerHarvestingDamageMultiplier
		  Self.mUseOptimizedRates = Source.mUseOptimizedRates
		  
		  Var Engrams() As Ark.Engram = Source.Engrams
		  For Each Engram As Ark.Engram In Engrams
		    Self.mOverrides.Value(Engram, Self.RateAttribute) = Source.mOverrides.Value(Engram, Self.RateAttribute)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  
		  Values.Add(New Ark.ConfigValue("CommandLineOption", "?", "UseOptimizedHarvestingHealth=" + If(Self.mUseOptimizedRates, "True", "False")))
		  
		  Var Engrams() As Ark.Engram = Self.Engrams
		  For Each Engram As Ark.Engram In Engrams
		    If Engram.ValidForProject(Project) Then
		      Var Rate As Double = Self.mOverrides.Value(Engram, Self.RateAttribute)
		      Values.Add(Self.GenerateOverrideConfig(Engram, Rate))
		    End If
		  Next
		  
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PlayerHarvestingDamageMultiplier=" + Self.mPlayerHarvestingDamageMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoHarvestingDamageMultiplier=" + Self.mDinoHarvestingDamageMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "HarvestAmountMultiplier=" + Self.mHarvestAmountMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "HarvestHealthMultiplier=" + Self.mHarvestHealthMultiplier.PrettyText))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ClampResourceHarvestDamage=" + If(Self.mClampResourceHarvestDamage, "True", "False")))
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey("CommandLineOption", "?", "UseOptimizedHarvestingHealth"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "HarvestResourceItemAmountClassMultipliers"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PlayerHarvestingDamageMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoHarvestingDamageMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "HarvestAmountMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "HarvestHealthMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ClampResourceHarvestDamage"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mClampResourceHarvestDamage = True Or Self.mDinoHarvestingDamageMultiplier <> 1.0 Or Self.mHarvestAmountMultiplier <> 1.0 Or Self.mHarvestHealthMultiplier <> 1.0 Or Self.mPlayerHarvestingDamageMultiplier <> 1.0 Or Self.mUseOptimizedRates = True Or ((Self.mOverrides Is Nil) = False And Self.mOverrides.Count > 0)
		End Function
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
		    Var Overrides As Ark.BlueprintAttributeManager = Ark.BlueprintAttributeManager.FromSaveData(SaveData.Value("Multipliers"))
		    If (Overrides Is Nil) = False Then
		      Self.mOverrides = Overrides
		    End If
		  ElseIf SaveData.HasKey("Rates") Then
		    Var Rates As Dictionary = SaveData.DictionaryValue("Rates", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Ark.Engram = Ark.ResolveEngram("", Entry.Key, "", Nil)
		        Self.mOverrides.Value(Engram, Self.RateAttribute) = Entry.Value.DoubleValue
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Else
		    Var Rates As Dictionary = SaveData.DictionaryValue("Overrides", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Ark.Engram = Ark.ResolveEngram("", "", Entry.Key, Nil)
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
		  Self.mOverrides = New Ark.BlueprintAttributeManager
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return CType(Self.mOverrides.Count, UInteger)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Ark.Engram()
		  Var References() As Ark.BlueprintReference = Self.mOverrides.References
		  Var Results() As Ark.Engram
		  For Each Reference As Ark.BlueprintReference In References
		    If Not Reference.IsEngram Then
		      Continue
		    End If
		    
		    Var Blueprint As Ark.Blueprint = Reference.Resolve
		    If (Blueprint Is Nil = False) And Blueprint IsA Ark.Engram Then
		      Results.Add(Ark.Engram(Blueprint))
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.HarvestRates
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
		  Var Overrides As New Ark.BlueprintAttributeManager
		  
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
		        Var Engram As Ark.Engram = Ark.ResolveEngram("", "", ClassString, ContentPacks)
		        Overrides.Value(Engram, RateAttribute) = Multiplier
		      End If
		    Next
		  End If
		  
		  Var Config As New Ark.Configs.HarvestRates
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
		Shared Function GenerateOverrideConfig(Engram As Ark.Engram, Rate As Double) As Ark.ConfigValue
		  Return New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "HarvestResourceItemAmountClassMultipliers=(ClassName=""" + Engram.ClassString + """,Multiplier=" + Rate.PrettyText + ")", "HarvestResourceItemAmountClassMultipliers:" + Engram.ClassString)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameHarvestRates
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(Engram As Ark.Engram) As Double
		  Var Multiplier As Variant = Self.mOverrides.Value(Engram, Self.RateAttribute)
		  If Multiplier.IsNull Then
		    Return 1.0
		  End If
		  Return Multiplier.DoubleValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(Engram As Ark.Engram, Assigns Rate As Double)
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
		Private mOverrides As Ark.BlueprintAttributeManager
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
