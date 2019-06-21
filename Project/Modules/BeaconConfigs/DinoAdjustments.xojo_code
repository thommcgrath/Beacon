#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class DinoAdjustments
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Mask As UInt64)
		  Dim Behaviors() As Beacon.CreatureBehavior = Self.All
		  For Each Behavior As Beacon.CreatureBehavior In Behaviors
		    If Behavior.ProhibitSpawning Then
		      Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "NPCReplacements", "(FromClassName=""" + Behavior.TargetClass + """,ToClassName="""")"))
		    ElseIf Behavior.ReplacementClass <> "" Then
		      Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "NPCReplacements", "(FromClassName=""" + Behavior.TargetClass + """,ToClassName=""" + Behavior.ReplacementClass + """)"))
		    Else
		      If Behavior.DamageMultiplier <> 1.0 Then
		        Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "DinoClassDamageMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.DamageMultiplier.PrettyText + ")"))
		      End If
		      If Behavior.ResistanceMultiplier <> 1.0 Then
		        Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "DinoClassResistanceMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.ResistanceMultiplier.PrettyText + ")"))
		      End If
		      If Behavior.TamedDamageMultiplier <> 1.0 Then
		        Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "TamedDinoClassDamageMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.TamedDamageMultiplier.PrettyText + ")"))
		      End If
		      If Behavior.TamedResistanceMultiplier <> 1.0 Then
		        Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "TamedDinoClassResistanceMultipliers", "(ClassName=""" + Behavior.TargetClass + """,Multiplier=" + Behavior.TamedResistanceMultiplier.PrettyText + ")"))
		      End If
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Self.mBehaviors = New Xojo.Core.Dictionary
		  
		  If Not Dict.HasKey("Creatures") Then
		    Return
		  End If
		  
		  Dim Dicts() As Auto = Dict.Value("Creatures")
		  For Each CreatureDict As Xojo.Core.Dictionary In Dicts
		    Dim Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior.FromDictionary(CreatureDict)
		    If Behavior = Nil Then
		      Return
		    End If
		    
		    Self.mBehaviors.Value(Behavior.TargetClass) = Behavior
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dim Dicts() As Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mBehaviors
		    Dim Behavior As Beacon.CreatureBehavior = Entry.Value
		    Dicts.Append(Behavior.ToDictionary)
		  Next
		  
		  Dict.Value("Creatures") = Dicts
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function All() As Beacon.CreatureBehavior()
		  Dim Behaviors() As Beacon.CreatureBehavior
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mBehaviors
		    Dim Behavior As Beacon.CreatureBehavior = Entry.Value
		    Behaviors.Append(New Beacon.CreatureBehavior(Behavior))
		  Next
		  Return Behaviors
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Behavior(TargetClass As Text) As Beacon.CreatureBehavior
		  If Not Self.mBehaviors.HasKey(TargetClass) Then
		    Return Nil
		  End If
		  
		  Dim Behavior As Beacon.CreatureBehavior = Beacon.CreatureBehavior(Self.mBehaviors.Value(TargetClass))
		  Return New Beacon.CreatureBehavior(Behavior)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Behavior(TargetClass As Text, Assigns Behavior As Beacon.CreatureBehavior)
		  Self.mBehaviors.Value(TargetClass) = New Beacon.CreatureBehavior(Behavior)
		  Self.Modified = Self.Modified Or Behavior.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "DinoAdjustments"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mBehaviors = New Xojo.Core.Dictionary
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.DinoAdjustments
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  Dim Config As New BeaconConfigs.DinoAdjustments()
		  
		  Dim Replacements() As Auto = ParsedData.AutoArrayValue("NPCReplacements")
		  For Each Entry As Auto In Replacements
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Entry
		      If Dict.HasKey("FromClassName") = False Or Dict.HasKey("ToClassName") = False Then
		        Continue
		      End If
		      
		      Dim TargetClass As Text = Dict.Value("FromClassName")
		      Dim ReplacementClass As Text = Dict.Value("ToClassName")
		      
		      Dim Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      If ReplacementClass = "" Then
		        Behavior.ProhibitSpawning = True
		      Else
		        Behavior.ReplacementClass = ReplacementClass
		      End If
		      Config.Behavior(TargetClass) = Behavior
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Dim WildDamageMultipliers() As Auto = ParsedData.AutoArrayValue("DinoClassDamageMultipliers")
		  For Each Entry As Auto In WildDamageMultipliers
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Dim TargetClass As Text = Dict.Value("ClassName")
		      Dim Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Dim Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.DamageMultiplier = Multiplier
		      Config.Behavior(TargetClass) = Behavior
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Dim WildResistanceMultipliers() As Auto = ParsedData.AutoArrayValue("DinoClassResistanceMultipliers")
		  For Each Entry As Auto In WildResistanceMultipliers
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Dim TargetClass As Text = Dict.Value("ClassName")
		      Dim Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Dim Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.ResistanceMultiplier = Multiplier
		      Config.Behavior(TargetClass) = Behavior
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Dim TamedDamageMultipliers() As Auto = ParsedData.AutoArrayValue("TamedDinoClassDamageMultipliers")
		  For Each Entry As Auto In TamedDamageMultipliers
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Dim TargetClass As Text = Dict.Value("ClassName")
		      Dim Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Dim Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.TamedDamageMultiplier = Multiplier
		      Config.Behavior(TargetClass) = Behavior
		    Catch Err As TypeMismatchException
		    End Try
		  Next
		  
		  Dim TamedResistanceMultipliers() As Auto = ParsedData.AutoArrayValue("TamedDinoClassResistanceMultipliers")
		  For Each Entry As Auto In TamedResistanceMultipliers
		    Try
		      Dim Dict As Xojo.Core.Dictionary = Entry
		      If Dict.HasKey("ClassName") = False Or Dict.HasKey("Multiplier") = False Then
		        Continue
		      End If
		      
		      Dim TargetClass As Text = Dict.Value("ClassName")
		      Dim Multiplier As Double = Dict.DoubleValue("Multiplier", 1.0, True)
		      
		      Dim Behavior As Beacon.MutableCreatureBehavior = MutableBehavior(Config, TargetClass)
		      Behavior.TamedResistanceMultiplier = Multiplier
		      Config.Behavior(TargetClass) = Behavior
		    Catch Err As TypeMismatchException
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
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mBehaviors
		    Dim Behavior As Beacon.CreatureBehavior = Entry.Value
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
		    For Each Entry As Xojo.Core.DictionaryEntry In Self.mBehaviors
		      Dim Behavior As Beacon.CreatureBehavior = Entry.Value
		      Behavior.Modified = False
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function MutableBehavior(Config As BeaconConfigs.DinoAdjustments, ClassString As Text) As Beacon.MutableCreatureBehavior
		  Dim Behavior As Beacon.CreatureBehavior = Config.Behavior(ClassString)
		  If Behavior <> Nil Then
		    Return New Beacon.MutableCreatureBehavior(Behavior)
		  Else
		    Return New Beacon.MutableCreatureBehavior(ClassString)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveBehavior(TargetClass As Text)
		  If Self.mBehaviors.HasKey(TargetClass) Then
		    Self.mBehaviors.Remove(TargetClass)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBehaviors As Xojo.Core.Dictionary
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
	#tag EndViewBehavior
End Class
#tag EndClass
