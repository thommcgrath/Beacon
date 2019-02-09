#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class ExperienceCurves
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue)
		  #Pragma Unused SourceDocument
		  
		  Dim MaxLevel As UInteger = Self.PlayerLevelCap
		  Dim MaxXP As UInt64 = Self.PlayerMaxExperience
		  
		  // Index 0 is level 2!
		  // Index 150 is level 152
		  // Index 178 is level 180
		  // This is because players start at level 1, not level 0. Then the 0-based array needs to be accounted for.
		  Dim Chunks() As Text
		  For Index As Integer = 0 To MaxLevel - 2
		    Dim Level As Integer = Index + 2
		    Dim XP As UInteger = Round(Self.PlayerCurve.Evaluate((Level - 1) / (MaxLevel - 1), 0, MaxXP))
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsPlayer", MaxXP.ToText))
		  
		  Redim Chunks(-1)
		  MaxLevel = Self.DinoLevelCap
		  MaxXP = Self.DinoMaxExperience
		  
		  For Index As Integer = 0 To MaxLevel - 2
		    Dim Level As Integer = Index + 2
		    Dim XP As UInteger = Round(Self.DinoCurve.Evaluate((Level - 1) / (MaxLevel - 1), 0, MaxXP))
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Chunks.Join(",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsDino", MaxXP.ToText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dim DinoCurve As Beacon.Curve
		  If Dict.HasKey("Dino Curve") Then
		    DinoCurve = Beacon.Curve.Import(Dict.Value("Dino Curve"))
		  End If
		  If DinoCurve = Nil Then
		    DinoCurve = New Beacon.Curve
		  End If
		  
		  Dim PlayerCurve As Beacon.Curve
		  If Dict.HasKey("Player Curve") Then
		    PlayerCurve = Beacon.Curve.Import(Dict.Value("Player Curve"))
		  End If
		  If PlayerCurve = Nil Then
		    PlayerCurve = New Beacon.Curve
		  End If
		  
		  Self.mDinoLevelCap = Dict.Value("Dino Level Cap")
		  Self.mDinoMaxExperience = Dict.Value("Dino Max Experience")
		  Self.mDinoCurve = DinoCurve
		  
		  Self.mPlayerLevelCap = Dict.Value("Player Level Cap")
		  Self.mPlayerMaxExperience = Dict.Value("Player Max Experience")
		  Self.mPlayerCurve = PlayerCurve
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dict.Value("Dino Level Cap") = Self.mDinoLevelCap
		  Dict.Value("Dino Max Experience") = Self.mDinoMaxExperience
		  Dict.Value("Dino Curve") = Self.mDinoCurve.Export
		  
		  Dict.Value("Player Level Cap") = Self.mPlayerLevelCap
		  Dict.Value("Player Max Experience") = Self.mPlayerMaxExperience
		  Dict.Value("Player Curve") = Self.mPlayerCurve.Export
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
		  
		  Self.DinoCurve = New Beacon.Curve(1, 0, 1, 0)
		  Self.DinoLevelCap = Self.DefaultDinoLevelCap//73
		  Self.DinoMaxExperience = Self.DefaultDinoMaxExperience//3550000
		  
		  Self.PlayerCurve = New Beacon.Curve(1, 0, 1, 0)
		  Self.PlayerLevelCap = Self.DefaultPlayerLevelCap//135
		  Self.PlayerMaxExperience = Self.DefaultPlayerMaxExperience//53373536
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultDinoLevelCap() As Integer
		  Return Beacon.Data.GetIntegerVariable("Dino Level Cap")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultDinoMaxExperience() As UInt64
		  Return Beacon.Data.GetIntegerVariable("Dino Max Experience")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultPlayerLevelCap() As Integer
		  Return Beacon.Data.GetIntegerVariable("Player Level Cap")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultPlayerMaxExperience() As UInt64
		  Return Beacon.Data.GetIntegerVariable("Player Max Experience")
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
		  For Each Dict As Xojo.Core.Dictionary In Overrides
		    Dim MaxLevel As Integer = 0
		    While Dict.HasKey("ExperiencePointsForLevel[" + MaxLevel.ToText + "]")
		      MaxLevel = MaxLevel + 1
		    Wend
		    MaxLevel = MaxLevel - 1
		    
		    Dim MaxXP As Integer = Dict.Value("ExperiencePointsForLevel[" + MaxLevel.ToText + "]")
		    If PlayerExperience Then
		      Config.PlayerLevelCap = MaxLevel + 2
		      Config.PlayerMaxExperience = MaxXP
		      PlayerExperience = False
		    Else
		      Config.DinoLevelCap = MaxLevel + 2
		      Config.DinoMaxExperience = MaxXP
		    End If
		  Next
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WasPerfectImport() As Boolean
		  Return False
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoCurve
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDinoCurve <> Value Then
			    Self.mDinoCurve = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DinoCurve As Beacon.Curve
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoLevelCap
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDinoLevelCap <> Value Then
			    Self.mDinoLevelCap = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DinoLevelCap As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoMaxExperience
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDinoMaxExperience <> Value Then
			    Self.mDinoMaxExperience = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DinoMaxExperience As UInt64
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDinoCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDinoLevelCap As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDinoMaxExperience As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerLevelCap As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerMaxExperience As UInt64
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerCurve
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPlayerCurve <> Value Then
			    Self.mPlayerCurve = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PlayerCurve As Beacon.Curve
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerLevelCap
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPlayerLevelCap <> Value Then
			    Self.mPlayerLevelCap = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PlayerLevelCap As UInteger
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerMaxExperience
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPlayerMaxExperience <> Value Then
			    Self.mPlayerMaxExperience = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
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
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerLevelCap"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerMaxExperience"
			Group="Behavior"
			Type="UInteger"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerSoftLevelCap"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
