#tag Class
Protected Class DinoAdjustments
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.DinoAdjustments = Ark.Configs.DinoAdjustments(Other)
		  Var Behaviors() As Ark.CreatureBehavior = Source.Behaviors
		  For Each Behavior As Ark.CreatureBehavior In Behaviors
		    Self.Add(Behavior)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  
		  Var Behaviors() As Ark.CreatureBehavior = Self.Behaviors
		  For Each Behavior As Ark.CreatureBehavior In Behaviors
		    If Behavior.TargetCreature.ValidForProject(Project) = False Then
		      Continue
		    End If
		    
		    If Behavior.ProhibitSpawning Then
		      Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "NPCReplacements=(FromClassName=""" + Behavior.TargetCreature.ClassString + """,ToClassName="""")", "NPCReplacements:" + Behavior.TargetCreature.ClassString))
		    ElseIf IsNull(Behavior.ReplacementCreature) = False Then
		      Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "NPCReplacements=(FromClassName=""" + Behavior.TargetCreature.ClassString + """,ToClassName=""" + Behavior.ReplacementCreature.ClassString + """)", "NPCReplacements:" + Behavior.TargetCreature.ClassString))
		    Else
		      If Behavior.DamageMultiplier <> 1.0 Then
		        Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoClassDamageMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.DamageMultiplier.PrettyText + ")", "DinoClassDamageMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.ResistanceMultiplier <> 1.0 Then
		        Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoClassResistanceMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.ResistanceMultiplier.PrettyText + ")", "DinoClassResistanceMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedDamageMultiplier <> 1.0 Then
		        Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "TamedDinoClassDamageMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedDamageMultiplier.PrettyText + ")", "TamedDinoClassDamageMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedResistanceMultiplier <> 1.0 Then
		        Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "TamedDinoClassResistanceMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedResistanceMultiplier.PrettyText + ")", "TamedDinoClassResistanceMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.ProhibitTaming Then
		        Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PreventDinoTameClassNames=""" + Behavior.TargetCreature.ClassString + """", "PreventDinoTameClassNames:" + Behavior.TargetCreature.ClassString))
		      End If
		      
		      #if EnableSpawnWeights
		        If Behavior.SpawnWeightMultiplier <> 1.0 Or (Behavior.SpawnLimitPercent Is Nil) = False Then
		          Var Elements() As String = Array("DinoNameTag=""" + Behavior.TargetCreature.ClassString + """")
		          If Behavior.SpawnWeightMultiplier <> 1.0 Then
		            Elements.Add("SpawnWeightMultiplier=" + Behavior.SpawnWeightMultiplier.PrettyText)
		          End If
		          If (Behavior.SpawnLimitPercent Is Nil) = False Then
		            Elements.Add("OverrideSpawnLimitPercentage=True")
		            Elements.Add("SpawnLimitPercentage=" + Behavior.SpawnLimitPercent.DoubleValue.PrettyText)
		          End If
		          Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoSpawnWeightMultipliers=" + Elements.Join(","), "DinoSpawnWeightMultipliers:" + Behavior.TargetCreature.ClassString))
		        End If
		      #endif
		    End If
		    If Behavior.ProhibitTransfer Then
		      Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PreventTransferForClassNames=""" + Behavior.TargetCreature.ClassString + """", "PreventTransferForClassNames:" + Behavior.TargetCreature.ClassString))
		    End If
		  Next
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "NPCReplacements"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoClassDamageMultipliers"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoClassResistanceMultipliers"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "TamedDinoClassDamageMultipliers"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "TamedDinoClassResistanceMultipliers"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PreventDinoTameClassNames"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "PreventTransferForClassNames"))
		  #if EnableSpawnWeights
		    Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "DinoSpawnWeightMultipliers"))
		  #endif
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return Self.mBehaviors.KeyCount > 0
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Self.mBehaviors = New Dictionary
		  
		  If Not SaveData.HasKey("Creatures") Then
		    Return
		  End If
		  
		  Var Dicts() As Dictionary = SaveData.Value("Creatures").DictionaryArrayValue
		  For Each CreatureDict As Dictionary In Dicts
		    Var Behavior As Ark.CreatureBehavior = Ark.CreatureBehavior.FromDictionary(CreatureDict)
		    If Behavior Is Nil Then
		      Return
		    End If
		    
		    Self.mBehaviors.Value(Behavior.ObjectID) = Behavior
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Var Dicts() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Ark.CreatureBehavior = Entry.Value
		    Dicts.Add(Behavior.ToDictionary)
		  Next
		  
		  SaveData.Value("Creatures") = Dicts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Behavior As Ark.CreatureBehavior)
		  Self.Behavior(Behavior.TargetCreature) = Behavior
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behavior(Creature As Ark.Creature) As Ark.CreatureBehavior
		  If Not Self.mBehaviors.HasKey(Creature.ObjectID) Then
		    Return Nil
		  End If
		  
		  Var Behavior As Ark.CreatureBehavior = Ark.CreatureBehavior(Self.mBehaviors.Value(Creature.ObjectID))
		  Return New Ark.CreatureBehavior(Behavior)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Behavior(Creature As Ark.Creature, Assigns Behavior As Ark.CreatureBehavior)
		  Self.mBehaviors.Value(Creature.ObjectID) = New Ark.CreatureBehavior(Behavior)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behaviors(Filter As String = "") As Ark.CreatureBehavior()
		  Filter = Filter.Trim
		  
		  Var Behaviors() As Ark.CreatureBehavior
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Ark.CreatureBehavior = Entry.Value
		    If Filter.IsEmpty = False And (Behavior.TargetCreature Is Nil Or Behavior.TargetCreature.Label.IndexOf(Filter) = -1) Then
		      Continue
		    End If
		    
		    Behaviors.Add(New Ark.CreatureBehavior(Behavior))
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
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.DinoAdjustments
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var Config As New Ark.Configs.DinoAdjustments()
		  
		  Var Replacements() As Variant = ParsedData.AutoArrayValue("NPCReplacements")
		  For Each Entry As Variant In Replacements
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("FromClassName") = False Or Dict.HasKey("ToClassName") = False Then
		        Continue
		      End If
		      
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature(Dict, "", "", "FromClassName", ContentPacks))
		      If Dict.Value("ToClassName").StringValue.IsEmpty Then
		        Behavior.ProhibitSpawning = True
		      Else
		        Behavior.ReplacementCreature = Ark.ResolveCreature(Dict, "", "", "ToClassName", ContentPacks)
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
		      
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature("", "", TargetClass, ContentPacks))
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
		      
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature("", "", TargetClass, ContentPacks))
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
		      
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature("", "", TargetClass, ContentPacks))
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
		      
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature("", "", TargetClass, ContentPacks))
		      Behavior.TamedResistanceMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var PreventTamedDinos() As Variant = ParsedData.AutoArrayValue("PreventDinoTameClassNames")
		  For Each Entry As Variant In PreventTamedDinos
		    Try
		      Var TargetClass As String = Entry
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature("", "", TargetClass, ContentPacks))
		      Behavior.ProhibitTaming = True
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var PreventTransferDinos() As Variant = ParsedData.AutoArrayValue("PreventTransferForClassNames")
		  For Each Entry As Variant In PreventTransferDinos
		    Try
		      Var TargetClass As String = Entry
		      Var Behavior As Ark.MutableCreatureBehavior = MutableBehavior(Config, Ark.ResolveCreature("", "", TargetClass, ContentPacks))
		      Behavior.ProhibitTransfer = True
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  #if EnableSpawnWeights
		    Var SpawnWeights() As Variant = ParsedData.AutoArrayValue("DinoSpawnWeightMultipliers")
		    For Each Entry As Variant In SpawnWeights
		      Try
		        Var Dict As Dictionary = Entry
		        Var TargetClass As String = Dict.Value("
		        If Dict.HasKey("SpawnWeightMultiplier") Then
		          
		        End If
		        If Dict.HasKey("SpawnLimitPercentage") Then
		          
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  #endif
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameDinoAdjustments
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Ark.CreatureBehavior = Entry.Value
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
		      Var Behavior As Ark.CreatureBehavior = Entry.Value
		      Behavior.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function MutableBehavior(Config As Ark.Configs.DinoAdjustments, Creature As Ark.Creature) As Ark.MutableCreatureBehavior
		  Var Behavior As Ark.CreatureBehavior = Config.Behavior(Creature)
		  If Behavior <> Nil Then
		    Return New Ark.MutableCreatureBehavior(Behavior)
		  Else
		    Return New Ark.MutableCreatureBehavior(Creature)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveBehavior(Creature As Ark.Creature)
		  If Self.mBehaviors.HasKey(Creature.ObjectID) Then
		    Self.mBehaviors.Remove(Creature.ObjectID)
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


	#tag Constant, Name = EnableSpawnWeights, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public
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
