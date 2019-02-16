#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class ExperienceCurves
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
		  #Pragma Unused SourceDocument
		  
		  Dim MaxXP As Int32 = Self.PlayerMaxExperience
		  
		  // Index 0 is level 2!
		  // Index 150 is level 152
		  // Index 178 is level 180
		  // This is because players start at level 1, not level 0. Then the 0-based array needs to be accounted for.
		  Dim Chunks() As Text
		  For Index As Int32 = 0 To Self.mPlayerLevels.Ubound
		    Dim XP As Int32 = Self.mPlayerLevels(Index)
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsPlayer", MaxXP.ToText))
		  
		  Redim Chunks(-1)
		  MaxXP = Self.DinoMaxExperience
		  
		  For Index As Int32 = 0 To Self.mDinoLevels.Ubound
		    Dim XP As Int32 = Self.mDinoLevels(Index)
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
		    For Each LevelXP As Int32 In List
		      Self.mPlayerLevels.Append(LevelXP)
		    Next
		  ElseIf Dict.HasAllKeys("Player Curve", "Player Level Cap", "Player Max Experience") Then
		    Dim Curve As Beacon.Curve = Beacon.Curve.Import(Dict.Value("Player Curve"))
		    Dim MaxLevel As Int32 = Dict.Value("Player Level Cap")
		    Dim MaxXP As Int32 = Dict.Value("Player Max Experience")
		    Self.mPlayerLevels = Self.LegacyCurveImport(Curve, MaxLevel, MaxXP)
		  End If
		  
		  If Dict.HasKey("Dino Levels") Then
		    Dim List() As Auto = Dict.Value("Dino Levels")
		    For Each LevelXP As Int32 In List
		      Self.mDinoLevels.Append(LevelXP)
		    Next
		  ElseIf Dict.HasAllKeys("Dino Curve", "Dino Level Cap", "Dino Max Experience") Then
		    Dim Curve As Beacon.Curve = Beacon.Curve.Import(Dict.Value("Dino Curve"))
		    Dim MaxLevel As Int32 = Dict.Value("Dino Level Cap")
		    Dim MaxXP As Int32 = Dict.Value("Dino Max Experience")
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
		      Self.mPlayerLevels.Append(Int32.FromText(Value))
		    Next
		  End If
		  
		  List = Beacon.Data.GetTextVariable("Dino Levels")
		  If List <> "" Then
		    Dim Values() As Text = List.Split(",")
		    For Each Value As Text In Values
		      Self.mDinoLevels.Append(Int32.FromText(Value))
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FindHighValue(Values() As Int32, StartingIndex As Integer, ByRef EndingIndex As Integer) As Int32
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
		Private Shared Function FindLowValue(Values() As Int32, StartingIndex As Integer, ByRef EndingIndex As Integer) As Int32
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
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As Int32, QualityMultiplier As Double) As BeaconConfigs.ExperienceCurves
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
		    Dim Levels() As Int32
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
		        Dim Index As UInt32 = UInt32.FromText(IndexTxt)
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
		      
		      Dim PreviousXP, NextXP As Int32
		      Dim LowIndex, HighIndex As Integer
		      PreviousXP = FindLowValue(Levels, I, LowIndex)
		      NextXP = FindHighValue(Levels, I, HighIndex)
		      If LowIndex = -1 Or HighIndex = -1 Then
		        Continue
		      End If
		      
		      Dim Range As Integer = HighIndex - LowIndex
		      Dim Difference As Int32 = NextXP - PreviousXP
		      Dim XPPerLevel As Int32 = Round(Difference / Range)
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

	#tag Method, Flags = &h21
		Private Shared Function LegacyCurveImport(Curve As Beacon.Curve, MaxLevel As Int32, MaxXP As Int32) As Int32()
		  Dim Levels() As Int32
		  For Index As Integer = 0 To MaxLevel - 2
		    Dim Level As Integer = Index + 2
		    Dim XP As Int32 = Round(Curve.Evaluate((Level - 1) / (MaxLevel - 1), 0, MaxXP))
		    Levels.Append(XP)
		  Next
		  Return Levels
		End Function
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
		DinoMaxExperience As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDinoLevels() As Int32
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerLevels() As Int32
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
		PlayerMaxExperience As Int32
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
			Type="UInt64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerLevelCap"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerMaxExperience"
			Group="Behavior"
			Type="UInt64"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerSoftLevelCap"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
