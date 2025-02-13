#tag Class
Protected Class DinoAdjustments
Inherits ArkSA.ConfigGroup
Implements Beacon.BlueprintConsumer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Var Source As ArkSA.Configs.DinoAdjustments = ArkSA.Configs.DinoAdjustments(Other)
		  Var Behaviors() As ArkSA.CreatureBehavior = Source.Behaviors
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    Self.Add(Behavior)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As ArkSA.ConfigValue
		  
		  Var Behaviors() As ArkSA.CreatureBehavior = Self.Behaviors
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    If Behavior.TargetCreature.ValidForProject(Project) = False Then
		      Continue
		    End If
		    
		    If Behavior.ProhibitSpawning Then
		      Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "NPCReplacements=(FromClassName=""" + Behavior.TargetCreature.ClassString + """,ToClassName="""")", "NPCReplacements:" + Behavior.TargetCreature.ClassString))
		    ElseIf IsNull(Behavior.ReplacementCreature) = False Then
		      Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "NPCReplacements=(FromClassName=""" + Behavior.TargetCreature.ClassString + """,ToClassName=""" + Behavior.ReplacementCreature.ClassString + """)", "NPCReplacements:" + Behavior.TargetCreature.ClassString))
		    Else
		      If Behavior.DamageMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoClassDamageMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.DamageMultiplier.PrettyText + ")", "DinoClassDamageMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.ResistanceMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoClassResistanceMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.ResistanceMultiplier.PrettyText + ")", "DinoClassResistanceMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedDamageMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassDamageMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedDamageMultiplier.PrettyText + ")", "TamedDinoClassDamageMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedResistanceMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassResistanceMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedResistanceMultiplier.PrettyText + ")", "TamedDinoClassResistanceMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.WildSpeedMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoClassSpeedMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.WildSpeedMultiplier.PrettyText + ")", "DinoClassSpeedMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedSpeedMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassSpeedMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedSpeedMultiplier.PrettyText + ")", "TamedDinoClassSpeedMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedStaminaMultiplier <> 1.0 Then
		        Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassStaminaMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedStaminaMultiplier.PrettyText + ")", "TamedDinoClassStaminaMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		    End If
		    If Behavior.ProhibitTaming Then
		      Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PreventDinoTameClassNames=""" + Behavior.TargetCreature.ClassString + """", "PreventDinoTameClassNames:" + Behavior.TargetCreature.ClassString))
		    End If
		    If Behavior.ProhibitTransfer Then
		      Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PreventTransferForClassNames=""" + Behavior.TargetCreature.ClassString + """", "PreventTransferForClassNames:" + Behavior.TargetCreature.ClassString))
		    End If
		  Next
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "NPCReplacements"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoClassDamageMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoClassResistanceMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "DinoClassSpeedMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassDamageMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassResistanceMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassSpeedMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "TamedDinoClassStaminaMultipliers"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PreventDinoTameClassNames"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "PreventTransferForClassNames"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mBehaviors.KeyCount > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  Var Behaviors() As ArkSA.CreatureBehavior = Self.Behaviors
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    Var Reference As ArkSA.BlueprintReference = Behavior.TargetCreatureReference
		    Var Creature As ArkSA.Blueprint = Reference.Resolve(ContentPackIds, 0)
		    If Creature Is Nil Then
		      Self.RemoveBehavior(Reference.BlueprintId)
		      Continue
		    End If
		    
		    Var ReplacementReference As ArkSA.BlueprintReference = Behavior.ReplacementCreatureReference
		    If ReplacementReference Is Nil Then
		      Continue
		    End If
		    
		    Var Replacement As ArkSA.Blueprint = ReplacementReference.Resolve(ContentPackIds, 0)
		    If Replacement Is Nil Then
		      Var Mutable As ArkSA.MutableCreatureBehavior = New ArkSA.MutableCreatureBehavior(Behavior)
		      Mutable.ProhibitSpawning = True
		      Mutable.ReplacementCreature = Nil
		      Self.Add(New ArkSA.CreatureBehavior(Mutable))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As JSONItem, EncryptedData As JSONItem)
		  #Pragma Unused EncryptedData
		  
		  Self.mBehaviors = New Dictionary
		  
		  If Not SaveData.HasKey("Creatures") Then
		    Return
		  End If
		  
		  Var Dicts() As Dictionary = SaveData.Value("Creatures").DictionaryArrayValue
		  For Each CreatureDict As Dictionary In Dicts
		    Var Behavior As ArkSA.CreatureBehavior = ArkSA.CreatureBehavior.FromDictionary(CreatureDict)
		    If Behavior Is Nil Then
		      Return
		    End If
		    
		    Self.mBehaviors.Value(Behavior.CreatureId) = Behavior
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As JSONItem, EncryptedData As JSONItem)
		  #Pragma Unused EncryptedData
		  
		  Var Dicts() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As ArkSA.CreatureBehavior = Entry.Value
		    Dicts.Add(Behavior.ToDictionary)
		  Next
		  
		  SaveData.Value("Creatures") = Dicts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Behavior As ArkSA.CreatureBehavior)
		  Self.Behavior(Behavior.TargetCreature) = Behavior
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behavior(Creature As ArkSA.Creature) As ArkSA.CreatureBehavior
		  If Not Self.mBehaviors.HasKey(Creature.CreatureId) Then
		    Return Nil
		  End If
		  
		  Var Behavior As ArkSA.CreatureBehavior = ArkSA.CreatureBehavior(Self.mBehaviors.Value(Creature.CreatureId))
		  Return New ArkSA.CreatureBehavior(Behavior)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Behavior(Creature As ArkSA.Creature, Assigns Behavior As ArkSA.CreatureBehavior)
		  Self.mBehaviors.Value(Creature.CreatureId) = New ArkSA.CreatureBehavior(Behavior)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behaviors(Filter As String = "") As ArkSA.CreatureBehavior()
		  Filter = Filter.Trim
		  
		  Var Behaviors() As ArkSA.CreatureBehavior
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As ArkSA.CreatureBehavior = Entry.Value
		    If Filter.IsEmpty = False And (Behavior.TargetCreature Is Nil Or Behavior.TargetCreature.Label.IndexOf(Filter) = -1) Then
		      Continue
		    End If
		    
		    Behaviors.Add(New ArkSA.CreatureBehavior(Behavior))
		  Next
		  Return Behaviors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mBehaviors = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As ArkSA.Configs.DinoAdjustments
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var Config As New ArkSA.Configs.DinoAdjustments()
		  
		  Var Replacements() As Variant = ParsedData.AutoArrayValue("NPCReplacements")
		  For Each Entry As Variant In Replacements
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("FromClassName") = False Or Dict.HasKey("ToClassName") = False Then
		        Continue
		      End If
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature(Dict, "", "", "FromClassName", ContentPacks, True))
		      If Dict.Value("ToClassName").StringValue.IsEmpty Then
		        Behavior.ProhibitSpawning = True
		      Else
		        Behavior.ReplacementCreature = ArkSA.ResolveCreature(Dict, "", "", "ToClassName", ContentPacks, True)
		      End If
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var WildDamageMultipliers() As Variant = ParsedData.AutoArrayValue("DinoClassDamageMultipliers")
		  For Each Entry As Variant In WildDamageMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.DamageMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var WildResistanceMultipliers() As Variant = ParsedData.AutoArrayValue("DinoClassResistanceMultipliers")
		  For Each Entry As Variant In WildResistanceMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.ResistanceMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var TamedDamageMultipliers() As Variant = ParsedData.AutoArrayValue("TamedDinoClassDamageMultipliers")
		  For Each Entry As Variant In TamedDamageMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.TamedDamageMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var TamedResistanceMultipliers() As Variant = ParsedData.AutoArrayValue("TamedDinoClassResistanceMultipliers")
		  For Each Entry As Variant In TamedResistanceMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.TamedResistanceMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var PreventTamedDinos() As Variant = ParsedData.AutoArrayValue("PreventDinoTameClassNames")
		  For Each Entry As Variant In PreventTamedDinos
		    Try
		      Var TargetClass As String = Entry
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.ProhibitTaming = True
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var PreventTransferDinos() As Variant = ParsedData.AutoArrayValue("PreventTransferForClassNames")
		  For Each Entry As Variant In PreventTransferDinos
		    Try
		      Var TargetClass As String = Entry
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.ProhibitTransfer = True
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var WildSpeedMultipliers() As Variant = ParsedData.AutoArrayValue("DinoClassSpeedMultipliers")
		  For Each Entry As Variant In WildSpeedMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.WildSpeedMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var TamedSpeedMultipliers() As Variant = ParsedData.AutoArrayValue("TamedDinoClassSpeedMultipliers")
		  For Each Entry As Variant In TamedSpeedMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.TamedSpeedMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var TamedStaminaMultipliers() As Variant = ParsedData.AutoArrayValue("TamedDinoClassStaminaMultipliers")
		  For Each Entry As Variant In TamedStaminaMultipliers
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Var TargetClass As String = Dict.Value("ClassName")
		      Var Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Var Behavior As ArkSA.MutableCreatureBehavior = MutableBehavior(Config, ArkSA.ResolveCreature("", "", TargetClass, ContentPacks, True))
		      Behavior.TamedStaminaMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameCreatureAdjustments
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var Keys() As Variant = Self.mBehaviors.Keys
		  Var Changed As Boolean
		  For Each Key As Variant In Keys
		    Var Behavior As ArkSA.CreatureBehavior = Self.mBehaviors.Value(Key)
		    If Behavior.MigrateBlueprints(Migrator) = False Then
		      Continue
		    End If
		    
		    Self.mBehaviors.Remove(Key)
		    Self.Add(Behavior)
		    Changed = True
		  Next
		  Return Changed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As ArkSA.CreatureBehavior = Entry.Value
		    If Behavior.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Super.Modified = Value
		  
		  If Not Value Then
		    For Each Entry As DictionaryEntry In Self.mBehaviors
		      Var Behavior As ArkSA.CreatureBehavior = Entry.Value
		      Behavior.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function MutableBehavior(Config As ArkSA.Configs.DinoAdjustments, Creature As ArkSA.Creature) As ArkSA.MutableCreatureBehavior
		  Var Behavior As ArkSA.CreatureBehavior = Config.Behavior(Creature)
		  If Behavior <> Nil Then
		    Return New ArkSA.MutableCreatureBehavior(Behavior)
		  Else
		    Return New ArkSA.MutableCreatureBehavior(Creature)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveBehavior(Creature As ArkSA.Creature)
		  If Creature Is Nil Then
		    Return
		  End If
		  
		  Self.RemoveBehavior(Creature.CreatureId)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveBehavior(CreatureId As String)
		  If Self.mBehaviors.HasKey(CreatureId) Then
		    Self.mBehaviors.Remove(CreatureId)
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


	#tag Property, Flags = &h21
		Private mBehaviors As Dictionary
	#tag EndProperty


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
