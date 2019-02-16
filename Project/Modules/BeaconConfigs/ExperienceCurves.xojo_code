#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class ExperienceCurves
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
		  #Pragma Unused SourceDocument
		  
		  Dim MaxXP As UInt64 = Self.PlayerMaxExperience
		  
		  // Index 0 is level 2!
		  // Index 150 is level 152
		  // Index 178 is level 180
		  // This is because players start at level 1, not level 0. Then the 0-based array needs to be accounted for.
		  Dim Chunks() As Text
		  For Index As Integer = 0 To Self.mPlayerLevels.Ubound
		    Dim XP As UInt64 = Self.mPlayerLevels(Index)
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsPlayer", MaxXP.ToText))
		  
		  Redim Chunks(-1)
		  MaxXP = Self.DinoMaxExperience
		  
		  For Index As Integer = 0 To Self.mDinoLevels.Ubound
		    Dim XP As UInt64 = Self.mDinoLevels(Index)
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsDino", MaxXP.ToText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  If Dict.HasKey("Player Levels") Then
		    Dim List() As Auto = Dict.Value("Player Levels")
		    For Each LevelXP As UInt64 In List
		      Self.mPlayerLevels.Append(LevelXP)
		    Next
		  ElseIf Dict.HasAllKeys("Player Curve", "Player Level Cap", "Player Max Experience") Then
		    Dim Curve As Beacon.Curve = Beacon.Curve.Import(Dict.Value("Player Curve"))
		    Dim MaxLevel As UInt64 = Dict.Value("Player Level Cap")
		    Dim MaxXP As UInt64 = Dict.Value("Player Max Experience")
		    Self.mPlayerLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		  
		  If Dict.HasKey("Dino Levels") Then
		    Dim List() As Auto = Dict.Value("Dino Levels")
		    For Each LevelXP As UInt64 In List
		      Self.mDinoLevels.Append(LevelXP)
		    Next
		  ElseIf Dict.HasAllKeys("Dino Curve", "Dino Level Cap", "Dino Max Experience") Then
		    Dim Curve As Beacon.Curve = Beacon.Curve.Import(Dict.Value("Dino Curve"))
		    Dim MaxLevel As UInt64 = Dict.Value("Dino Level Cap")
		    Dim MaxXP As UInt64 = Dict.Value("Dino Max Experience")
		    Self.mDinoLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dict.Value("Player Levels") = Self.mPlayerLevels
		  Dict.Value("Dino Levels") = Self.mDinoLevels
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendDinoExperience(XP As UInt64)
		  If Self.mDinoLevels.Ubound > -1 And XP < Self.mDinoLevels(Self.mDinoLevels.Ubound) Then
		    Return
		  End If
		  
		  Self.mDinoLevels.Append(XP)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendPlayerExperience(XP As UInt64)
		  If Self.mPlayerLevels.Ubound > -1 And XP < Self.mPlayerLevels(Self.mPlayerLevels.Ubound) Then
		    Return
		  End If
		  
		  Self.mPlayerLevels.Append(XP)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AscensionLevels() As Integer
		  Return Beacon.Data.GetIntegerVariable("Ascension Levels")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "ExperienceCurves"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  
		  Dim List As Text = Beacon.Data.GetTextVariable("Player Levels")
		  If List <> "" Then
		    Dim Values() As Text = List.Split(",")
		    For Each Value As Text In Values
		      Self.mPlayerLevels.Append(UInt64.FromText(Value))
		    Next
		  End If
		  
		  List = Beacon.Data.GetTextVariable("Dino Levels")
		  If List <> "" Then
		    Dim Values() As Text = List.Split(",")
		    For Each Value As Text In Values
		      Self.mDinoLevels.Append(UInt64.FromText(Value))
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
		  Dim PreviousXP, NextXP As UInt64
		  Dim PreviousIndex, NextIndex As Integer
		  PreviousXP = Self.FindLowValue(Self.mDinoLevels, Index, PreviousIndex)
		  NextXP = Self.FindHighValue(Self.mDinoLevels, Index, NextIndex)
		  
		  If Self.mDinoLevels(Index) = XP Or (PreviousXP > -1 And XP < PreviousXP) Or (NextXP > -1 And XP > NextXP) Then
		    Return
		  End If
		  
		  Self.mDinoLevels(Index) = XP
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DinoLevels() As UInt64()
		  Dim Levels() As UInt64
		  Redim Levels(Self.mDinoLevels.Ubound)
		  For I As Integer = 0 To Self.mDinoLevels.Ubound
		    Levels(I) = Self.mDinoLevels(I)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindHighValue(Values() As UInt64, StartingIndex As Integer, ByRef EndingIndex As Integer) As UInt64
		  If StartingIndex >= Values.Ubound Then
		    EndingIndex = -1
		    Return 0
		  End If
		  
		  For I As Integer = StartingIndex + 1 To Values.Ubound
		    If Values(I) > 0 Then
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
		    If Values(I) > 0 Then
		      EndingIndex = I
		      Return Values(I)
		    End If
		  Next
		  
		  EndingIndex = -1
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.ExperienceCurves
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  If Not ParsedData.HasKey("LevelExperienceRampOverrides") Then
		    Return Nil
		  End If
		  
		  Dim PlayerExperience As Boolean = True
		  Dim Values As Auto = ParsedData.Value("LevelExperienceRampOverrides")
		  Dim ValuesInfo As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Values)
		  Dim Overrides() As Auto
		  If ValuesInfo.FullName = "Auto()" Then
		    Overrides = Values
		  ElseIf ValuesInfo.FullName = "Xojo.Core.Dictionary" Then
		    Overrides.Append(Values)
		  Else
		    Return Nil
		  End If
		  
		  Dim Config As New BeaconConfigs.ExperienceCurves
		  Config.mWasPerfectImport = True
		  For Each Dict As Xojo.Core.Dictionary In Overrides
		    Dim Levels() As UInt64
		    For Each Entry As Xojo.Core.DictionaryEntry In Dict
		      Dim Key As Text = Entry.Key
		      If Key.BeginsWith("ExperiencePointsForLevel") Then
		        Dim OpenTagPosition As Integer = Key.IndexOf("[")
		        Dim CloseTagPosition As Integer = Key.IndexOf(OpenTagPosition, "]")
		        If OpenTagPosition = -1 Or CloseTagPosition = -1 Then
		          Continue
		        End If
		        OpenTagPosition = OpenTagPosition + 1
		        Dim IndexTxt As Text = Key.Mid(OpenTagPosition, CloseTagPosition - OpenTagPosition)
		        Dim Index As Integer = Integer.FromText(IndexTxt)
		        If Levels.Ubound < Index Then
		          Redim Levels(Index)
		        End If
		        Levels(Index) = Entry.Value
		      End If
		    Next
		    
		    // Now make sure there are no gaps. If there are, fill in
		    // the gap with the average of the surrounding values
		    For I As Integer = 0 To Levels.Ubound
		      If Levels(I) <> 0 Then
		        Continue
		      End If
		      
		      Dim PreviousXP, NextXP As UInt64
		      Dim LowIndex, HighIndex As Integer
		      PreviousXP = FindLowValue(Levels, I, LowIndex)
		      NextXP = FindHighValue(Levels, I, HighIndex)
		      If LowIndex = -1 Or HighIndex = -1 Then
		        Continue
		      End If
		      
		      Dim Range As Integer = HighIndex - LowIndex
		      Dim Difference As UInt64 = NextXP - PreviousXP
		      Dim XPPerLevel As UInt64 = Round(Difference / Range)
		      For X As Integer = LowIndex + 1 To HighIndex - 1
		        Levels(X) = PreviousXP + (XPPerLevel * (X - LowIndex))
		        Config.mWasPerfectImport = False
		      Next
		    Next
		    
		    If PlayerExperience Then
		      Config.mPlayerLevels = Levels
		      PlayerExperience = False
		    Else
		      Config.mDinoLevels = Levels
		    End If
		  Next
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Issues(Document As Beacon.Document) As Beacon.Issue()
		  #Pragma Unused Document
		  
		  Dim Issues() As Beacon.Issue
		  Dim ConfigName As Text = "ExperienceCurves"
		  Dim Locale As Xojo.Core.Locale = Xojo.Core.Locale.Current
		  
		  If Self.PlayerLevelCap <= Self.AscensionLevels Then
		    Issues.Append(New Beacon.Issue(ConfigName, "Must define at least " + Self.AscensionLevels.ToText(Locale) + " player levels to handle ascension correctly."))
		  End If
		  
		  For I As Integer = 0 To Self.mPlayerLevels.Ubound
		    Dim Level As Integer = I + 2
		    Dim XP As Integer = Self.mPlayerLevels(I)
		    Dim LastXP As UInt64 = If(I > 0, Self.mPlayerLevels(I - 1), 0)
		    If XP < LastXP Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Player level " + Level.ToText(Locale) + " required experience is lower than the previous level.", "Player:" + Level.ToText))
		    End If
		    If XP > Self.MaxSupportedXP Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Player level " + Level.ToText(Locale) + " required experience is greater than Ark's limit of " + Format(Self.MaxSupportedXP, "0,").ToText + ".", "Player:" + Level.ToText))
		    End If
		  Next
		  
		  For I As Integer = 0 To Self.mDinoLevels.Ubound
		    Dim Level As Integer = I + 2
		    Dim XP As Integer = Self.mDinoLevels(I)
		    Dim LastXP As UInt64 = If(I > 0, Self.mDinoLevels(I - 1), 0)
		    If XP < LastXP Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Dino level " + Level.ToText(Locale) + " required experience is lower than the previous level.", "Dino:" + Level.ToText))
		    End If
		    If XP > Self.MaxSupportedXP Then
		      Issues.Append(New Beacon.Issue(ConfigName, "Dino level " + Level.ToText(Locale) + " required experience is greater than Ark's limit of " + Format(Self.MaxSupportedXP, "0,").ToText + ".", "Dino:" + Level.ToText))
		    End If
		  Next
		  
		  Return Issues
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid(Document As Beacon.Document) As Boolean
		  Dim Issues() As Beacon.Issue = Self.Issues(Document)
		  Return Issues.Ubound > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function LegacyCurveImport(Curve As Beacon.Curve, MaxLevel As UInt64, MaxXP As UInt64) As UInt64()
		  Dim Levels() As UInt64
		  For Index As Integer = 0 To MaxLevel - 2
		    Dim Level As Integer = Index + 2
		    Dim XP As UInt64 = Round(Curve.Evaluate((Level - 1) / (MaxLevel - 1), 0, MaxXP))
		    Levels.Append(XP)
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
		  Dim PreviousXP, NextXP As UInt64
		  Dim PreviousIndex, NextIndex As Integer
		  PreviousXP = Self.FindLowValue(Self.mPlayerLevels, Index, PreviousIndex)
		  NextXP = Self.FindHighValue(Self.mPlayerLevels, Index, NextIndex)
		  
		  If Self.mPlayerLevels(Index) = XP Or (PreviousXP > -1 And XP < PreviousXP) Or (NextXP > -1 And XP > NextXP) Then
		    Return
		  End If
		  
		  Self.mPlayerLevels(Index) = XP
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlayerLevels() As UInt64()
		  Dim Levels() As UInt64
		  Redim Levels(Self.mPlayerLevels.Ubound)
		  For I As Integer = 0 To Self.mPlayerLevels.Ubound
		    Levels(I) = Self.mPlayerLevels(I)
		  Next
		  Return Levels
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveDinoExperience(Index As Integer)
		  Self.mDinoLevels.Remove(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemovePlayerExperience(Index As Integer)
		  Self.mPlayerLevels.Remove(Index)
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
			  Return Self.mDinoLevels.Ubound + 2
			End Get
		#tag EndGetter
		DinoLevelCap As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mDinoLevels.Ubound > -1 Then
			    Return Self.mDinoLevels(Self.mDinoLevels.Ubound)
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
			  Return Self.mPlayerLevels.Ubound + 2
			End Get
		#tag EndGetter
		PlayerLevelCap As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mPlayerLevels.Ubound > -1 Then
			    Return Self.mPlayerLevels(Self.mPlayerLevels.Ubound)
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


	#tag Constant, Name = MaxSupportedXP, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Public
	#tag EndConstant


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
		#tag ViewProperty
			Name="DinoLevelCap"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DinoMaxExperience"
			Group="Behavior"
			Type="Int32"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerLevelCap"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerMaxExperience"
			Group="Behavior"
			Type="Int32"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerSoftLevelCap"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
