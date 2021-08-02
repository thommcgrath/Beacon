#tag Class
Protected Class StatMultipliers
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  #Pragma Unused Profile
		  
		  Var Values() As Beacon.ConfigValue
		  
		  For Each Entry As DictionaryEntry In Self.PlayerStats
		    Var Stat As Beacon.Stat = Beacon.Stats.Named(Entry.Key)
		    If Not (Entry.Value IsA Dictionary) Then
		      Continue
		    End If
		    Var Dict As Dictionary = Entry.Value
		    
		    If Dict.HasKey("Base") And Stat.PlayerBaseCapped = False Then
		      Var Multiplier As Double = Dict.Value("Base")
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PlayerBaseStatMultipliers[" + Stat.Index.ToString(Locale.Raw, "0") + "]=" + Multiplier.PrettyText, Stat.Index))
		    End If
		    If Dict.HasKey("PerLevel") And Stat.PlayerPerLevelEditable = True Then
		      Var Multiplier As Double = Dict.Value("PerLevel")
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_Player[" + Stat.Index.ToString(Locale.Raw, "0") + "]=" + Multiplier.PrettyText, Stat.Index))
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Self.TamedStats
		    Var Stat As Beacon.Stat = Beacon.Stats.Named(Entry.Key)
		    If Not (Entry.Value IsA Dictionary) Then
		      Continue
		    End If
		    Var Dict As Dictionary = Entry.Value
		    
		    If Dict.HasKey("PerLevel") Then
		      Var Multiplier As Double = Dict.Value("PerLevel")
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed[" + Stat.Index.ToString(Locale.Raw, "0") + "]=" + Multiplier.PrettyText, Stat.Index))
		    End If
		    If Dict.HasKey("Add") Then
		      Var Multiplier As Double = Dict.Value("Add")
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed_Add[" + Stat.Index.ToString(Locale.Raw, "0") + "]=" + Multiplier.PrettyText, Stat.Index))
		    End If
		    If Dict.HasKey("Affinity") Then
		      Var Multiplier As Double = Dict.Value("Affinity")
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed_Affinity[" + Stat.Index.ToString(Locale.Raw, "0") + "]=" + Multiplier.PrettyText, Stat.Index))
		    End If
		  Next
		  
		  For Each Entry As DictionaryEntry In Self.WildStats
		    Var Stat As Beacon.Stat = Beacon.Stats.Named(Entry.Key)
		    If Not (Entry.Value IsA Dictionary) Then
		      Continue
		    End If
		    Var Dict As Dictionary = Entry.Value
		    
		    If Dict.HasKey("PerLevel") Then
		      Var Multiplier As Double = Dict.Value("PerLevel")
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoWild[" + Stat.Index.ToString(Locale.Raw, "0") + "]=" + Multiplier.PrettyText, Stat.Index))
		    End If
		  Next
		  
		  For StatIndex As Integer = Self.MutagenTamed.FirstIndex To Self.MutagenTamed.LastIndex
		    If Self.MutagenTamed(StatIndex) <> Self.DefaultMutagenLevelCount(False, StatIndex) Then
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MutagenLevelBoost[" + StatIndex.ToString(Locale.Raw, "0") + "]=" + Self.MutagenTamed(StatIndex).ToString(Locale.Raw, "0"), StatIndex))
		    End If
		  Next StatIndex
		  
		  For StatIndex As Integer = Self.MutagenBred.FirstIndex To Self.MutagenBred.LastIndex
		    If Self.MutagenBred(StatIndex) <> Self.DefaultMutagenLevelCount(True, StatIndex) Then
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MutagenLevelBoostBred[" + StatIndex.ToString(Locale.Raw, "0") + "]=" + Self.MutagenBred(StatIndex).ToString(Locale.Raw, "0"), StatIndex))
		    End If
		  Next StatIndex
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PlayerBaseStatMultipliers"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_Player"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed_Add"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoTamed_Affinity"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "PerLevelStatsMultiplier_DinoWild"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MutagenLevelBoost"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "MutagenLevelBoostBred"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("PlayerStats") And Dict.Value("PlayerStats") IsA Dictionary Then
		    Self.PlayerStats = Dict.Value("PlayerStats")
		  End If
		  If Dict.HasKey("TamedStats") And Dict.Value("TamedStats") IsA Dictionary Then
		    Self.TamedStats = Dict.Value("TamedStats")
		  End If
		  If Dict.HasKey("WildStats") And Dict.Value("WildStats") IsA Dictionary Then
		    Self.WildStats = Dict.Value("WildStats")
		  End If
		  If Dict.HasKey("MutagenTamed") And Dict.Value("MutagenTamed").IsArray Then
		    Var Values() As Integer = Self.IntegerArray(Dict.Value("MutagenTamed"))
		    For StatIndex As Integer = 0 To Min(Values.LastIndex, Self.MutagenTamed.LastIndex)
		      Self.MutagenTamed(StatIndex) = Values(StatIndex)
		    Next StatIndex
		  End If
		  If Dict.HasKey("MutagenBred") And Dict.Value("MutagenBred").IsArray Then
		    Var Values() As Integer = Self.IntegerArray(Dict.Value("MutagenBred"))
		    For StatIndex As Integer = 0 To Min(Values.LastIndex, Self.MutagenBred.LastIndex)
		      Self.MutagenBred(StatIndex) = Values(StatIndex)
		    Next StatIndex
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  If Self.PlayerStats.KeyCount > 0 Then
		    Dict.Value("PlayerStats") = Self.PlayerStats
		  End If
		  If Self.TamedStats.KeyCount > 0 Then
		    Dict.Value("TamedStats") = Self.TamedStats
		  End If
		  If Self.WildStats.KeyCount > 0 Then
		    Dict.Value("WildStats") = Self.WildStats
		  End If
		  If Self.MutagenTamed.Count > 0 Then
		    Dict.Value("MutagenTamed") = Self.MutagenTamed
		  End If
		  If Self.MutagenBred.Count > 0 Then
		    Dict.Value("MutagenBred") = Self.MutagenBred
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameStatMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  Self.PlayerStats = New Dictionary
		  Self.TamedStats = New Dictionary
		  Self.WildStats = New Dictionary
		  
		  Var Stats() As Beacon.Stat = Beacon.Stats.All
		  Self.MutagenTamed.ResizeTo(Stats.LastIndex)
		  Self.MutagenBred.ResizeTo(Stats.LastIndex)
		  For Each Stat As Beacon.Stat In Stats
		    Self.MutagenTamed(Stat.Index) = Self.DefaultMutagenLevelCount(False, Stat.Index)
		    Self.MutagenBred(Stat.Index) = Self.DefaultMutagenLevelCount(True, Stat.Index)
		  Next Stat
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DefaultMutagenLevelCount(Bred As Boolean, StatIndex As Integer) As Integer
		  Select Case StatIndex
		  Case 0, 1, 7, 8
		    Return If(Bred, 1, 5)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.StatMultipliers
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
		  Var Config As New BeaconConfigs.StatMultipliers()
		  Var Stats() As Beacon.Stat = Beacon.Stats.All
		  Var FoundConfig As Boolean
		  
		  For Each Stat As Beacon.Stat In Stats
		    Var PlayerBaseKey As String = "PlayerBaseStatMultipliers[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var PlayerPerLevelKey As String = "PerLevelStatsMultiplier_Player[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var TamedPerLevelKey As String = "PerLevelStatsMultiplier_DinoTamed[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var TamedAddKey As String = "PerLevelStatsMultiplier_DinoTamed_Add[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var TamedAffinityKey As String = "PerLevelStatsMultiplier_DinoTamed_Affinity[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var WildPerLevelKey As String = "PerLevelStatsMultiplier_DinoWild[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var MutagenTamedKey As String = "MutagenLevelBoost[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    Var MutagenBredKey As String = "MutagenLevelBoostBred[" + Stat.Index.ToString(Locale.Raw, "0") + "]"
		    
		    If ParsedData.HasAnyKey(PlayerBaseKey, PlayerPerLevelKey, TamedPerLevelKey, TamedAddKey, TamedAffinityKey, WildPerLevelKey, MutagenTamedKey, MutagenBredKey) = False Then
		      Continue
		    ElseIf FoundConfig = False Then
		      FoundConfig = True
		    End If
		    
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
		    Config.MutagenTamedLevels(Stat) = Round(ParsedData.DoubleValue(MutagenTamedKey, DefaultMutagenLevelCount(False, Stat.Index), True))
		    Config.MutagenBredLevels(Stat) = Round(ParsedData.DoubleValue(MutagenBredKey, DefaultMutagenLevelCount(True, Stat.Index), True))
		  Next
		  
		  If FoundConfig Then
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function IntegerArray(Value As Variant) As Integer()
		  Var Values() As Integer
		  If IsNull(Value) Or Value.IsArray = False Then
		    Return Values
		  End If
		  
		  If Value.ArrayElementType = Variant.TypeInt64 Or Value.ArrayElementType = Variant.TypeInt32 Then
		    Values = Value
		  Else
		    Var Members() As Variant
		    Try
		      Members = Value
		    Catch Err As TypeMismatchException
		    End Try
		    
		    Values.ResizeTo(Members.LastIndex)
		    For Idx As Integer = 0 To Members.LastIndex
		      Try
		        Values(Idx) = Members(Idx)
		      Catch Err As TypeMismatchException
		      End Try
		    Next Idx
		  End If
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutagenBredLevels(Stat As Beacon.Stat) As Integer
		  Return Self.MutagenBred(Stat.Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MutagenBredLevels(Stat As Beacon.Stat, Assigns Value As Integer)
		  If Self.MutagenBred(Stat.Index) <> Value Then
		    Self.MutagenBred(Stat.Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutagenTamedLevels(Stat As Beacon.Stat) As Integer
		  Return Self.MutagenTamed(Stat.Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MutagenTamedLevels(Stat As Beacon.Stat, Assigns Value As Integer)
		  If Self.MutagenTamed(Stat.Index) <> Value Then
		    Self.MutagenTamed(Stat.Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerBaseMultiplier(Stat As Beacon.Stat) As Double
		  If Self.PlayerStats.HasKey(Stat.Key) Then
		    Try
		      Var Dict As Dictionary = Self.PlayerStats.Value(Stat.Key)
		      Return Dict.Lookup("Base", 1.0)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return 1.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerBaseMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.PlayerBaseMultiplier(Stat) Then
		    Return
		  End If
		  
		  Var Dict As Dictionary
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
		  
		  If Dict.KeyCount > 0 Then
		    Self.PlayerStats.Value(Stat.Key) = Dict
		    Self.Modified = True
		  ElseIf Self.PlayerStats.HasKey(Stat.Key) Then
		    Self.PlayerStats.Remove(Stat.Key)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerPerLevelMultiplier(Stat As Beacon.Stat) As Double
		  If Self.PlayerStats.HasKey(Stat.Key) Then
		    Try
		      Var Dict As Dictionary = Self.PlayerStats.Value(Stat.Key)
		      Return Dict.Lookup("PerLevel", 1.0)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return 1.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerPerLevelMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.PlayerPerLevelMultiplier(Stat) Then
		    Return
		  End If
		  
		  Var Dict As Dictionary
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
		  
		  If Dict.KeyCount > 0 Then
		    Self.PlayerStats.Value(Stat.Key) = Dict
		    Self.Modified = True
		  ElseIf Self.PlayerStats.HasKey(Stat.Key) Then
		    Self.PlayerStats.Remove(Stat.Key)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedAddMultiplier(Stat As Beacon.Stat) As Double
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Try
		      Var Dict As Dictionary = Self.TamedStats.Value(Stat.Key)
		      Return Dict.Lookup("Add", Stat.TamedAddDefault)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Stat.TamedAddDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedAddMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.TamedAddMultiplier(Stat) Then
		    Return
		  End If
		  
		  Var Dict As Dictionary
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
		  
		  If Dict.KeyCount > 0 Then
		    Self.TamedStats.Value(Stat.Key) = Dict
		    Self.Modified = True
		  ElseIf Self.TamedStats.HasKey(Stat.Key) Then
		    Self.TamedStats.Remove(Stat.Key)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedAffinityMultiplier(Stat As Beacon.Stat) As Double
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Try
		      Var Dict As Dictionary = Self.TamedStats.Value(Stat.Key)
		      Return Dict.Lookup("Affinity", Stat.TamedAffinityDefault)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Stat.TamedAffinityDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedAffinityMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.TamedAffinityMultiplier(Stat) Then
		    Return
		  End If
		  
		  Var Dict As Dictionary
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
		  
		  If Dict.KeyCount > 0 Then
		    Self.TamedStats.Value(Stat.Key) = Dict
		    Self.Modified = True
		  ElseIf Self.TamedStats.HasKey(Stat.Key) Then
		    Self.TamedStats.Remove(Stat.Key)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedPerLevelMultiplier(Stat As Beacon.Stat) As Double
		  If Self.TamedStats.HasKey(Stat.Key) Then
		    Try
		      Var Dict As Dictionary = Self.TamedStats.Value(Stat.Key)
		      Return Dict.Lookup("PerLevel", Stat.TamedDefault)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Stat.TamedDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TamedPerLevelMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.TamedPerLevelMultiplier(Stat) Then
		    Return
		  End If
		  
		  Var Dict As Dictionary
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
		  
		  If Dict.KeyCount > 0 Then
		    Self.TamedStats.Value(Stat.Key) = Dict
		    Self.Modified = True
		  ElseIf Self.TamedStats.HasKey(Stat.Key) Then
		    Self.TamedStats.Remove(Stat.Key)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WildPerLevelMultiplier(Stat As Beacon.Stat) As Double
		  If Self.WildStats.HasKey(Stat.Key) Then
		    Try
		      Var Dict As Dictionary = Self.WildStats.Value(Stat.Key)
		      Return Dict.Lookup("PerLevel", Stat.WildDefault)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  Return Stat.WildDefault
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WildPerLevelMultiplier(Stat As Beacon.Stat, Assigns Value As Double)
		  If Value = Self.WildPerLevelMultiplier(Stat) Then
		    Return
		  End If
		  
		  Var Dict As Dictionary
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
		  
		  If Dict.KeyCount > 0 Then
		    Self.WildStats.Value(Stat.Key) = Dict
		    Self.Modified = True
		  ElseIf Self.WildStats.HasKey(Stat.Key) Then
		    Self.WildStats.Remove(Stat.Key)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private MutagenBred() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MutagenTamed() As Integer
	#tag EndProperty

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
