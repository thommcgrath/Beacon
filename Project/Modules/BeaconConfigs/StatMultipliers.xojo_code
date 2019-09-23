#tag Class
Protected Class StatMultipliers
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  For Each Entry As DictionaryEntry In Self.PlayerStats
		    Dim Stat As Beacon.Stat = Beacon.Stats.Named(Entry.Key)
		    Dim Dict As Dictionary = Entry.Value
		    
		    If Dict.HasKey("Base") And Stat.PlayerBaseCapped = False Then
		      Dim Multiplier As Double = Dict.Value("Base")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PlayerBaseStatMultipliers[" + Str(Stat.Index, "0") + "]", Multiplier.PrettyText))
		    End If
		    If Dict.HasKey("PerLevel") And Stat.PlayerPerLevelEditable = True Then
		      Dim Multiplier As Double = Dict.Value("PerLevel")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_Player[" + Str(Stat.Index, "0") + "]", Multiplier.PrettyText))
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Self.TamedStats
		    Dim Stat As Beacon.Stat = Beacon.Stats.Named(Entry.Key)
		    Dim Dict As Dictionary = Entry.Value
		    
		    If Dict.HasKey("PerLevel") Then
		      Dim Multiplier As Double = Dict.Value("PerLevel")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed[" + Str(Stat.Index, "0") + "]", Multiplier.PrettyText))
		    End If
		    If Dict.HasKey("Add") Then
		      Dim Multiplier As Double = Dict.Value("Add")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed_Add[" + Str(Stat.Index, "0") + "]", Multiplier.PrettyText))
		    End If
		    If Dict.HasKey("Affinity") Then
		      Dim Multiplier As Double = Dict.Value("Affinity")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed_Affinity[" + Str(Stat.Index, "0") + "]", Multiplier.PrettyText))
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Self.WildStats
		    Dim Stat As Beacon.Stat = Beacon.Stats.Named(Entry.Key)
		    Dim Dict As Dictionary = Entry.Value
		    
		    If Dict.HasKey("PerLevel") Then
		      Dim Multiplier As Double = Dict.Value("PerLevel")
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoWild[" + Str(Stat.Index, "0") + "]", Multiplier.PrettyText))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("PlayerStats") Then
		    Self.PlayerStats = Dict.Value("PlayerStats")
		  End If
		  If Dict.HasKey("TamedStats") Then
		    Self.TamedStats = Dict.Value("TamedStats")
		  End If
		  If Dict.HasKey("WildStats") Then
		    Self.WildStats = Dict.Value("WildStats")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("PlayerStats") = Self.PlayerStats
		  Dict.Value("TamedStats") = Self.TamedStats
		  Dict.Value("WildStats") = Self.WildStats
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "StatMultipliers"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  Self.PlayerStats = New Dictionary
		  Self.TamedStats = New Dictionary
		  Self.WildStats = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.StatMultipliers
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Dim Config As New BeaconConfigs.StatMultipliers()
		  Dim Stats() As Beacon.Stat = Beacon.Stats.All
		  
		  For Each Stat As Beacon.Stat In Stats
		    Dim PlayerBaseKey As String = "PlayerBaseStatMultipliers[" + Str(Stat.Index, "0") + "]"
		    Dim PlayerPerLevelKey As String = "PerLevelStatsMultiplier_Player[" + Str(Stat.Index, "0") + "]"
		    Dim TamedPerLevelKey As String = "PerLevelStatsMultiplier_DinoTamed[" + Str(Stat.Index, "0") + "]"
		    Dim TamedAddKey As String = "PerLevelStatsMultiplier_DinoTamed_Add[" + Str(Stat.Index, "0") + "]"
		    Dim TamedAffinityKey As String = "PerLevelStatsMultiplier_DinoTamed_Affinity[" + Str(Stat.Index, "0") + "]"
		    Dim WildPerLevelKey As String = "PerLevelStatsMultiplier_DinoWild[" + Str(Stat.Index, "0") + "]"
		    
		    If Stat.PlayerBaseCapped = False Then
		      Config.PlayerBaseMultiplier(Stat) = ParsedData.DoubleValue(PlayerBaseKey, 1.0, True)
		    End If
		    If Stat.PlayerPerLevelEditable Then
		      Config.PlayerPerLevelMultiplier(Stat) = ParsedData.DoubleValue(PlayerPerLevelKey, 1.0, True)
		    End If
		    Config.TamedPerLevelMultiplier(Stat) = ParsedData.DoubleValue(TamedPerLevelKey, Stat.TamedDefault, True)
		    Config.TamedAddMultiplier(Stat) = ParsedData.DoubleValue(TamedAddKey, Stat.TamedAddDefault, True)
		    Config.TamedAffinityMultiplier(Stat) = ParsedData.DoubleValue(TamedAffinityKey, Stat.TamedAffinityDefault, True)
		    Config.WildPerLevelMultiplier(Stat) = ParsedData.DoubleValue(WildPerLevelKey, Stat.WildDefault, True)
		  Next
		  
		  If Config.Modified Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerBaseMultiplier(Stat As Beacon.Stat) As Double
		  If Self.PlayerStats.HasKey(Stat.Key) Then
		    Dim Dict As Dictionary = Self.PlayerStats.Value(Stat.Key)
		    Return Dict.Lookup("Base", 1.0)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerBaseMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.PlayerBaseMultiplier(Stat) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  If Self.PlayerStats.HasKey(Stat.Key) Then
		    Dict = Self.PlayerStats.Value(Stat.Key)
		  Else
		    Dict = New Dictionary
		  End If
		  If Value = 0 Or Value = 1 Then
		    If Dict.HasKey("Base") Then
		      Dict.Remove("Base")
		    End If
		    If Dict.KeyCount = 0 And Self.PlayerStats.HasKey(Stat.Key) Then
		      Self.PlayerStats.Remove(Stat.Key)
		      Self.Modified = True
		      Return
		    End If
		  Else
		    Dict.Value("Base") = Value
		  End If
		  Self.PlayerStats.Value(Stat.Key) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerPerLevelMultiplier(Stat As Beacon.Stat) As Double
		  If Self.PlayerStats.HasKey(Stat.Key) Then
		    Dim Dict As Dictionary = Self.PlayerStats.Value(Stat.Key)
		    Return Dict.Lookup("PerLevel", 1.0)
		  Else
		    Return 1.0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerPerLevelMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.PlayerPerLevelMultiplier(Stat) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  If Self.PlayerStats.HasKey(Stat.Key) Then
		    Dict = Self.PlayerStats.Value(Stat.Key)
		  Else
		    Dict = New Dictionary
		  End If
		  If Value = 0 Or Value = 1 Then
		    If Dict.HasKey("PerLevel") Then
		      Dict.Remove("PerLevel")
		    End If
		    If Dict.KeyCount = 0 And Self.PlayerStats.HasKey(Stat.Key) Then
		      Self.PlayerStats.Remove(Stat.Key)
		      Self.Modified = True
		      Return
		    End If
		  Else
		    Dict.Value("PerLevel") = Value
		  End If
		  Self.PlayerStats.Value(Stat.Key) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedAddMultiplier(Stat As Beacon.Stat) As Double
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Dim Dict As Dictionary = Self.TamedStats.Value(Stat.Key)
		    Return Dict.Lookup("Add", Stat.TamedAddDefault)
		  Else
		    Return Stat.TamedAddDefault
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedAddMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.TamedAddMultiplier(Stat) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Dict = Self.TamedStats.Value(Stat.Key)
		  Else
		    Dict = New Dictionary
		  End If
		  If Value = 0 Or Value = Stat.TamedAddDefault Then
		    If Dict.HasKey("Add") Then
		      Dict.Remove("Add")
		    End If
		    If Dict.KeyCount = 0 And Self.TamedStats.HasKey(Stat.Key) Then
		      Self.TamedStats.Remove(Stat.Key)
		      Self.Modified = True
		      Return
		    End If
		  Else
		    Dict.Value("Add") = Value
		  End If
		  Self.TamedStats.Value(Stat.Key) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedAffinityMultiplier(Stat As Beacon.Stat) As Double
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Dim Dict As Dictionary = Self.TamedStats.Value(Stat.Key)
		    Return Dict.Lookup("Affinity", Stat.TamedAffinityDefault)
		  Else
		    Return Stat.TamedAffinityDefault
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedAffinityMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.TamedAffinityMultiplier(Stat) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Dict = Self.TamedStats.Value(Stat.Key)
		  Else
		    Dict = New Dictionary
		  End If
		  If Value = 0 Or Value = Stat.TamedAffinityDefault Then
		    If Dict.HasKey("Affinity") Then
		      Dict.Remove("Affinity")
		    End If
		    If Dict.KeyCount = 0 And Self.TamedStats.HasKey(Stat.Key) Then
		      Self.TamedStats.Remove(Stat.Key)
		      Self.Modified = True
		      Return
		    End If
		  Else
		    Dict.Value("Affinity") = Value
		  End If
		  Self.TamedStats.Value(Stat.Key) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedPerLevelMultiplier(Stat As Beacon.Stat) As Double
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Dim Dict As Dictionary = Self.TamedStats.Value(Stat.Key)
		    Return Dict.Lookup("PerLevel", Stat.TamedDefault)
		  Else
		    Return Stat.TamedDefault
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedPerLevelMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.TamedPerLevelMultiplier(Stat) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Dict = Self.TamedStats.Value(Stat.Key)
		  Else
		    Dict = New Dictionary
		  End If
		  If Value = 0 Or Value = Stat.TamedDefault Then
		    If Dict.HasKey("PerLevel") Then
		      Dict.Remove("PerLevel")
		    End If
		    If Dict.KeyCount = 0 And Self.TamedStats.HasKey(Stat.Key) Then
		      Self.TamedStats.Remove(Stat.Key)
		      Self.Modified = True
		      Return
		    End If
		  Else
		    Dict.Value("PerLevel") = Value
		  End If
		  Self.TamedStats.Value(Stat.Key) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WildPerLevelMultiplier(Stat As Beacon.Stat) As Double
		  If Self.WildStats.HasKey(Stat.Key) Then
		    Dim Dict As Dictionary = Self.WildStats.Value(Stat.Key)
		    Return Dict.Lookup("PerLevel", Stat.WildDefault)
		  Else
		    Return Stat.WildDefault
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WildPerLevelMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.WildPerLevelMultiplier(Stat) Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary
		  If Self.WildStats.HasKey(Stat.Key) Then
		    Dict = Self.WildStats.Value(Stat.Key)
		  Else
		    Dict = New Dictionary
		  End If
		  If Value = 0 Or Value = Stat.WildDefault Then
		    If Dict.HasKey("PerLevel") Then
		      Dict.Remove("PerLevel")
		    End If
		    If Dict.KeyCount = 0 And Self.WildStats.HasKey(Stat.Key) Then
		      Self.WildStats.Remove(Stat.Key)
		      Self.Modified = True
		      Return
		    End If
		  Else
		    Dict.Value("PerLevel") = Value
		  End If
		  Self.WildStats.Value(Stat.Key) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private PlayerStats As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TamedStats As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WildStats As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
