#tag Class
Protected Class DinoAdjustments
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Beacon.ConfigValue
		  
		  Var Behaviors() As Beacon.CreatureBehavior = Self.All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    If Behavior.TargetCreature.ValidForDocument(SourceDocument) = False Then
		      Continue
		    End If
		    
		    If Behavior.ProhibitSpawning Then
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "NPCReplacements=(FromClassName=""" + Behavior.TargetCreature.ClassString + """,ToClassName="""")", "NPCReplacements:" + Behavior.TargetCreature.ClassString))
		    ElseIf IsNull(Behavior.ReplacementCreature) = False Then
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "NPCReplacements=(FromClassName=""" + Behavior.TargetCreature.ClassString + """,ToClassName=""" + Behavior.ReplacementCreature.ClassString + """)", "NPCReplacements:" + Behavior.TargetCreature.ClassString))
		    Else
		      If Behavior.DamageMultiplier <> 1.0 Then
		        Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "DinoClassDamageMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.DamageMultiplier.PrettyText + ")", "DinoClassDamageMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.ResistanceMultiplier <> 1.0 Then
		        Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "DinoClassResistanceMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.ResistanceMultiplier.PrettyText + ")", "DinoClassResistanceMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedDamageMultiplier <> 1.0 Then
		        Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "TamedDinoClassDamageMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedDamageMultiplier.PrettyText + ")", "TamedDinoClassDamageMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.TamedResistanceMultiplier <> 1.0 Then
		        Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "TamedDinoClassResistanceMultipliers=(ClassName=""" + Behavior.TargetCreature.ClassString + """,Multiplier=" + Behavior.TamedResistanceMultiplier.PrettyText + ")", "TamedDinoClassResistanceMultipliers:" + Behavior.TargetCreature.ClassString))
		      End If
		      If Behavior.PreventTaming Then
		        Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PreventDinoTameClassNames=""" + Behavior.TargetCreature.ClassString + """", "PreventDinoTameClassNames:" + Behavior.TargetCreature.ClassString))
		      End If
		    End If
		  Next
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "NPCReplacements"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "DinoClassDamageMultipliers"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "DinoClassResistanceMultipliers"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "TamedDinoClassDamageMultipliers"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "TamedDinoClassResistanceMultipliers"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PreventDinoTameClassNames"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.DinoAdjustments = BeaconConfigs.DinoAdjustments(Other)
		  Var Behaviors() As Beacon.CreatureBehavior = Source.All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    Self.Add(Behavior)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  Self.mBehaviors = New Dictionary
		  
		  If Not Dict.HasKey("Creatures") Then
		    Return
		  End If
		  
		  Var Dicts() As Dictionary = Dict.Value("Creatures").DictionaryArrayValue
		  For Each CreatureDict As Dictionary In Dicts
		    Var Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior.FromDictionary(CreatureDict)
		    If Behavior Is Nil Then
		      Return
		    End If
		    
		    Self.mBehaviors.Value(Behavior.ObjectID) = Behavior
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var Dicts() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Beacon.CreatureBehavior = Entry.Value
		    Dicts.Add(Behavior.ToDictionary)
		  Next
		  
		  Dict.Value("Creatures") = Dicts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Add(Behavior As Beacon.CreatureBehavior)
		  Self.Behavior(Behavior.TargetCreature) = Behavior
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function All() As Beacon.CreatureBehavior()
		  Var Behaviors() As Beacon.CreatureBehavior
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Beacon.CreatureBehavior = Entry.Value
		    Behaviors.Add(New Beacon.CreatureBehavior(Behavior))
		  Next
		  Return Behaviors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behavior(Creature As Beacon.Creature) As Beacon.CreatureBehavior
		  If Not Self.mBehaviors.HasKey(Creature.ObjectID) Then
		    Return Nil
		  End If
		  
		  Var Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior(Self.mBehaviors.Value(Creature.ObjectID))
		  Return New Beacon.CreatureBehavior(Behavior)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Behavior(Creature As Beacon.Creature, Assigns Behavior As Beacon.CreatureBehavior)
		  Self.mBehaviors.Value(Creature.ObjectID) = New Beacon.CreatureBehavior(Behavior)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameDinoAdjustments
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mBehaviors = New Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.DinoAdjustments
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Var Config As New BeaconConfigs.DinoAdjustments()
		  
		  Var Replacements() As Variant = ParsedData.AutoArrayValue("NPCReplacements")
		  For Each Entry As Variant In Replacements
		    Try
		      Var Dict As Dictionary = Entry
		      If Dict.HasKey("FromClassName") = False Or Dict.HasKey("ToClassName") = False Then
		        Continue
		      End If
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, Beacon.ResolveCreature(Dict, "", "", "FromClassName", Mods))
		      If Dict.Value("ToClassName").StringValue.IsEmpty Then
		        Behavior.ProhibitSpawning = True
		      Else
		        Behavior.ReplacementCreature = Beacon.ResolveCreature(Dict, "", "", "ToClassName", Mods)
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
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, Beacon.ResolveCreature("", "", TargetClass, Mods))
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
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, Beacon.ResolveCreature("", "", TargetClass, Mods))
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
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, Beacon.ResolveCreature("", "", TargetClass, Mods))
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
		      
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, Beacon.ResolveCreature("", "", TargetClass, Mods))
		      Behavior.TamedResistanceMultiplier = Multiplier
		      Config.Add(Behavior)
		    Catch Err As RuntimeException
		    End Try
		  Next
		  
		  Var PreventTamedDinos() As Variant = ParsedData.AutoArrayValue("PreventDinoTameClassNames")
		  For Each Entry As Variant In PreventTamedDinos
		    Try
		      Var TargetClass As String = Entry
		      Var Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, Beacon.ResolveCreature("", "", TargetClass, Mods))
		      Behavior.PreventTaming = True
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
		Function Modified() As Boolean
		  If Super.Modified Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mBehaviors
		    Var Behavior As Beacon.CreatureBehavior = Entry.Value
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
		      Var Behavior As Beacon.CreatureBehavior = Entry.Value
		      Behavior.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function MutableBehavior(Config As BeaconConfigs.DinoAdjustments, Creature As Beacon.Creature) As Beacon.MutableCreatureBehavior
		  Var Behavior As Beacon.CreatureBehavior = Config.Behavior(Creature)
		  If Behavior <> Nil Then
		    Return New Beacon.MutableCreatureBehavior(Behavior)
		  Else
		    Return New Beacon.MutableCreatureBehavior(Creature)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveBehavior(Creature As Beacon.Creature)
		  If Self.mBehaviors.HasKey(Creature.ObjectID) Then
		    Self.mBehaviors.Remove(Creature.ObjectID)
		    Self.Modified = True
		  End If
		End Sub
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
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
