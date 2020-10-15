#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class ExperienceCurves
Inherits Beacon.ConfigGroup
	#tag Event
		Sub DetectIssues(Document As Beacon.Document, Issues() As Beacon.Issue)
		  #Pragma Unused Document
		  
		  Var ConfigName As String = ConfigKey
		  Var Locale As Locale = Locale.Current
		  
		  If Self.mPlayerLevels.LastRowIndex > -1 And Self.PlayerLevelCap <= Self.AscensionLevels Then
		    Issues.Add(New Beacon.Issue(ConfigName, "Must define at least " + Self.AscensionLevels.ToString(Locale) + " player levels to handle ascension correctly."))
		  End If
		  
		  For I As Integer = 0 To Self.mPlayerLevels.LastRowIndex
		    Var Level As Integer = I + 2
		    Var XP As UInt64 = Self.mPlayerLevels(I)
		    Var LastXP As UInt64 = If(I > 0, Self.mPlayerLevels(I - 1), CType(0, UInt64))
		    If XP < LastXP Then
		      Issues.Add(New Beacon.Issue(ConfigName, "Player level " + Level.ToString(Locale) + " required experience is lower than the previous level.", "Player:" + Level.ToString))
		    End If
		    If XP > CType(Self.MaxSupportedXP, UInt64) Then
		      Issues.Add(New Beacon.Issue(ConfigName, "Player level " + Level.ToString(Locale) + " required experience is greater than Ark's limit of " + Format(Self.MaxSupportedXP, "0,") + ".", "Player:" + Level.ToString))
		    End If
		  Next
		  
		  For I As Integer = 0 To Self.mDinoLevels.LastRowIndex
		    Var Level As Integer = I + 2
		    Var XP As UInt64 = Self.mDinoLevels(I)
		    Var LastXP As UInt64 = If(I > 0, Self.mDinoLevels(I - 1), CType(0, UInt64))
		    If XP < LastXP Then
		      Issues.Add(New Beacon.Issue(ConfigName, "Dino level " + Level.ToString(Locale) + " required experience is lower than the previous level.", "Dino:" + Level.ToString))
		    End If
		    If XP > CType(Self.MaxSupportedXP, UInt64) Then
		      Issues.Add(New Beacon.Issue(ConfigName, "Dino level " + Level.ToString(Locale) + " required experience is greater than Ark's limit of " + Format(Self.MaxSupportedXP, "0,") + ".", "Dino:" + Level.ToString))
		    End If
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  Const CompactMode = False
		  
		  If Self.mPlayerLevels.LastRowIndex > -1 Then
		    Var MaxXP As UInt64 = Self.PlayerMaxExperience
		    
		    // Index 0 is level 2!
		    // Index 150 is level 152
		    // Index 178 is level 180
		    // This is because players start at level 1, not level 0. Then the 0-based array needs to be accounted for.
		    Var Chunks() As String
		    Var LastXP As UInt64
		    For Index As Integer = 0 To Self.mPlayerLevels.LastRowIndex
		      Var XP As UInt64 = Self.mPlayerLevels(Index)
		      If CompactMode And XP = LastXP And Chunks.LastRowIndex > -1 Then
		        Chunks.RemoveRowAt(Chunks.LastRowIndex)
		      End If
		      Chunks.Add("ExperiencePointsForLevel[" + Index.ToString + "]=" + XP.ToString)
		      LastXP = XP
		    Next
		    
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsPlayer", MaxXP.ToString))
		  ElseIf Self.mPlayerLevels.LastRowIndex = -1 And Self.mDinoLevels.LastRowIndex > -1 Then
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", ""))
		  Else
		    Return
		  End If
		  
		  If Self.mDinoLevels.LastRowIndex > -1 Then
		    Var Chunks() As String
		    Var MaxXP As UInt64 = Self.DinoMaxExperience
		    
		    Var LastXP As UInt64
		    For Index As Integer = 0 To Self.mDinoLevels.LastRowIndex
		      Var XP As UInt64 = Self.mDinoLevels(Index)
		      If CompactMode And XP = LastXP And Chunks.LastRowIndex > -1 Then
		        Chunks.RemoveRowAt(Chunks.LastRowIndex)
		      End If
		      Chunks.Add("ExperiencePointsForLevel[" + Index.ToString + "]=" + XP.ToString)
		      LastXP = XP
		    Next
		    
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsDino", MaxXP.ToString))
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Player Levels") Then
		    Var List() As Variant = Dict.Value("Player Levels")
		    For Each LevelXP As UInt64 In List
		      Self.mPlayerLevels.Add(LevelXP)
		    Next
		  ElseIf Dict.HasAllKeys("Player Curve", "Player Level Cap", "Player Max Experience") Then
		    Var Curve As Beacon.Curve = Beacon.Curve.Import(Dict.Value("Player Curve"))
		    Var MaxLevel As Integer = Dict.Value("Player Level Cap")
		    Var MaxXP As UInt64 = Dict.Value("Player Max Experience")
		    Self.mPlayerLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		  
		  If Dict.HasKey("Dino Levels") Then
		    Var List() As Variant = Dict.Value("Dino Levels")
		    For Each LevelXP As UInt64 In List
		      Self.mDinoLevels.Add(LevelXP)
		    Next
		  ElseIf Dict.HasAllKeys("Dino Curve", "Dino Level Cap", "Dino Max Experience") Then
		    Var Curve As Beacon.Curve = Beacon.Curve.Import(Dict.Value("Dino Curve"))
		    Var MaxLevel As Integer = Dict.Value("Dino Level Cap")
		    Var MaxXP As UInt64 = Dict.Value("Dino Max Experience")
		    Self.mDinoLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Player Levels") = Self.mPlayerLevels
		  Dict.Value("Dino Levels") = Self.mDinoLevels
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendDinoExperience(XP As UInt64)
		  If Self.mDinoLevels.LastRowIndex > -1 And XP < Self.mDinoLevels(Self.mDinoLevels.LastRowIndex) Then
		    Return
		  End If
		  
		  Self.mDinoLevels.Add(XP)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendPlayerExperience(XP As UInt64)
		  If Self.mPlayerLevels.LastRowIndex > -1 And XP < Self.mPlayerLevels(Self.mPlayerLevels.LastRowIndex) Then
		    Return
		  End If
		  
		  Self.mPlayerLevels.Add(XP)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AscensionLevels() As Integer
		  Return Beacon.Data.GetIntegerVariable("Ascension Levels")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return ConfigKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  
		  Var List As String = Beacon.Data.GetStringVariable("Player Levels")
		  If List <> "" Then
		    Var Values() As String = List.Split(",")
		    For Each Value As String In Values
		      Self.mPlayerLevels.Add(UInt64.FromString(Value))
		    Next
		  End If
		  
		  List = Beacon.Data.GetStringVariable("Dino Levels")
		  If List <> "" Then
		    Var Values() As String = List.Split(",")
		    For Each Value As String In Values
		      Self.mDinoLevels.Add(UInt64.FromString(Value))
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DinoExperience(Index As Integer) As UInt64
		  Return Self.mDinoLevels(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DinoExperience(Index As Integer, Assigns XP As UInt64)
		  Var PreviousXP, NextXP As UInt64
		  Var PreviousIndex, NextIndex As Integer
		  PreviousXP = Self.FindLowValue(Self.mDinoLevels, Index, PreviousIndex)
		  NextXP = Self.FindHighValue(Self.mDinoLevels, Index, NextIndex)
		  
		  If Self.mDinoLevels(Index) = XP Or (PreviousIndex > -1 And XP < PreviousXP) Or (NextIndex > -1 And XP > NextXP) Then
		    Return
		  End If
		  
		  Self.mDinoLevels(Index) = XP
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DinoLevels() As UInt64()
		  Var Levels() As UInt64
		  Levels.ResizeTo(Self.mDinoLevels.LastRowIndex)
		  For I As Integer = 0 To Self.mDinoLevels.LastRowIndex
		    Levels(I) = Self.mDinoLevels(I)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindHighValue(Values() As UInt64, StartingIndex As Integer, ByRef EndingIndex As Integer) As UInt64
		  If StartingIndex >= Values.LastRowIndex Then
		    EndingIndex = -1
		    Return 0
		  End If
		  
		  For I As Integer = StartingIndex + 1 To Values.LastRowIndex
		    If Values(I) > CType(0, UInt64) Then
		      EndingIndex = I
		      Return Values(I)
		    End If
		  Next
		  
		  EndingIndex = -1
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindLowValue(Values() As UInt64, StartingIndex As Integer, ByRef EndingIndex As Integer) As UInt64
		  If StartingIndex <= 0 Then
		    EndingIndex = -1
		    Return 0
		  End If
		  
		  For I As Integer = StartingIndex - 1 DownTo 0
		    If Values(I) > CType(0, UInt64) Then
		      EndingIndex = I
		      Return Values(I)
		    End If
		  Next
		  
		  EndingIndex = -1
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.ExperienceCurves
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If Not ParsedData.HasKey("LevelExperienceRampOverrides") Then
		    Return Nil
		  End If
		  
		  Var Values As Variant = ParsedData.Value("LevelExperienceRampOverrides")
		  Var ValuesInfo As Introspection.TypeInfo = Introspection.GetType(Values)
		  Var Overrides() As Variant
		  If ValuesInfo.FullName = "Object()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Dictionary" Then
		    Overrides.Add(Values)
		  Else
		    Return Nil
		  End If
		  
		  Const IdxPlayerData = 0
		  Const IdxTameData = 1
		  
		  Var Config As New BeaconConfigs.ExperienceCurves
		  Config.mWasPerfectImport = True
		  
		  Var Bound As Integer = Min(Overrides.LastRowIndex, 1)
		  For Idx As Integer = 0 To Bound
		    Try
		      Var Dict As Dictionary = Overrides(Idx)
		      Var Levels() As UInt64
		      For Each Entry As DictionaryEntry In Dict
		        Var Key As String = Entry.Key
		        If Key.BeginsWith("ExperiencePointsForLevel") Then
		          Var OpenTagPosition As Integer = Key.IndexOf("[")
		          Var CloseTagPosition As Integer = Key.IndexOf(OpenTagPosition, "]")
		          If OpenTagPosition = -1 Or CloseTagPosition = -1 Then
		            Continue
		          End If
		          OpenTagPosition = OpenTagPosition + 1
		          Var IndexTxt As String = Key.Middle(OpenTagPosition, CloseTagPosition - OpenTagPosition)
		          Var Index As Integer = Integer.FromString(IndexTxt)
		          If Levels.LastRowIndex < Index Then
		            Levels.ResizeTo(Index)
		          End If
		          Levels(Index) = Entry.Value
		        End If
		      Next
		      
		      // Now make sure there are no gaps. If there are, fill in
		      // the gap with the average of the surrounding values
		      For I As Integer = 0 To Levels.LastRowIndex
		        If Levels(I) <> CType(0, UInt64) Then
		          Continue
		        End If
		        
		        Var PreviousXP, NextXP As UInt64
		        Var LowIndex, HighIndex As Integer
		        PreviousXP = FindLowValue(Levels, I, LowIndex)
		        NextXP = FindHighValue(Levels, I, HighIndex)
		        If LowIndex = -1 Or HighIndex = -1 Then
		          Continue
		        End If
		        
		        Var Range As Integer = HighIndex - LowIndex
		        Var Difference As UInt64 = NextXP - PreviousXP
		        Var XPPerLevel As UInt64 = Round(Difference / Range)
		        For X As Integer = LowIndex + 1 To HighIndex - 1
		          Levels(X) = PreviousXP + (XPPerLevel * CType(X - LowIndex, UInt64))
		          Config.mWasPerfectImport = False
		        Next
		      Next
		      
		      If Idx = IdxPlayerData Then
		        Config.mPlayerLevels = Levels
		      ElseIf Idx = IdxTameData Then
		        Config.mDinoLevels = Levels
		      End If
		    Catch Err As RuntimeException
		    End Try
		  Next
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LegacyCurveImport(Curve As Beacon.Curve, MaxLevel As Integer, MaxXP As UInt64) As UInt64()
		  Var Levels() As UInt64
		  For Index As Integer = 0 To MaxLevel - 2
		    Var Level As Integer = Index + 2
		    Var XP As UInt64 = Round(Curve.Evaluate((Level - 1) / (MaxLevel - 1), 0, MaxXP))
		    Levels.Add(XP)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerExperience(Index As Integer) As UInt64
		  Return Self.mPlayerLevels(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayerExperience(Index As Integer, Assigns XP As UInt64)
		  Var PreviousXP, NextXP As UInt64
		  Var PreviousIndex, NextIndex As Integer
		  PreviousXP = Self.FindLowValue(Self.mPlayerLevels, Index, PreviousIndex)
		  NextXP = Self.FindHighValue(Self.mPlayerLevels, Index, NextIndex)
		  
		  If Self.mPlayerLevels(Index) = XP Or (PreviousIndex > -1 And XP < PreviousXP) Or (NextIndex > -1 And XP > NextXP) Then
		    Return
		  End If
		  
		  Self.mPlayerLevels(Index) = XP
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerLevels() As UInt64()
		  Var Levels() As UInt64
		  Levels.ResizeTo(Self.mPlayerLevels.LastRowIndex)
		  For I As Integer = 0 To Self.mPlayerLevels.LastRowIndex
		    Levels(I) = Self.mPlayerLevels(I)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveDinoExperience(Index As Integer)
		  Self.mDinoLevels.RemoveRowAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePlayerExperience(Index As Integer)
		  Self.mPlayerLevels.RemoveRowAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WasPerfectImport() As Boolean
		  Return Self.mWasPerfectImport
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoLevels.LastRowIndex + 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.DinoLevelCap = Value Then
			    Return
			  End If
			  
			  Self.mDinoLevels.ResizeTo(Value - 1)
			  Self.Modified = True
			End Set
		#tag EndSetter
		DinoLevelCap As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mDinoLevels.LastRowIndex > -1 Then
			    Return Self.mDinoLevels(Self.mDinoLevels.LastRowIndex)
			  End If
			End Get
		#tag EndGetter
		DinoMaxExperience As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDinoLevels() As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerLevels() As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWasPerfectImport As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerLevels.LastRowIndex + 2
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.PlayerLevelCap = Value Then
			    Return
			  End If
			  
			  Self.mPlayerLevels.ResizeTo(Value - 2)
			  Self.Modified = True
			End Set
		#tag EndSetter
		PlayerLevelCap As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mPlayerLevels.LastRowIndex > -1 Then
			    Return Self.mPlayerLevels(Self.mPlayerLevels.LastRowIndex)
			  End If
			End Get
		#tag EndGetter
		PlayerMaxExperience As UInt64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PlayerLevelCap - Self.AscensionLevels
			End Get
		#tag EndGetter
		PlayerSoftLevelCap As Integer
	#tag EndComputedProperty


	#tag Constant, Name = ConfigKey, Type = Text, Dynamic = False, Default = \"ExperienceCurves", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MaxSupportedXP, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Public
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
			Name="IsImplicit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DinoLevelCap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DinoMaxExperience"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerLevelCap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerMaxExperience"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt64"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerSoftLevelCap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
