#tag Class
Protected Class ExperienceCurves
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary)
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
		  Self.mPlayerLevelCapIsAscended = Dict.Value("Player Level Cap Is Ascended")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary)
		  Dict.Value("Dino Level Cap") = Self.mDinoLevelCap
		  Dict.Value("Dino Max Experience") = Self.mDinoMaxExperience
		  Dict.Value("Dino Curve") = Self.mDinoCurve.Export
		  
		  Dict.Value("Player Level Cap") = Self.mPlayerLevelCap
		  Dict.Value("Player Max Experience") = Self.mPlayerMaxExperience
		  Dict.Value("Player Curve") = Self.mPlayerCurve.Export
		  Dict.Value("Player Level Cap Is Ascended") = Self.mPlayerLevelCapIsAscended
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "ExperienceCurves"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  
		  Self.DinoCurve = New Beacon.Curve(0.9999, 0.0001, 0.9999, 0.0001)
		  Self.DinoLevelCap = 73
		  Self.DinoMaxExperience = 3550000
		  
		  Self.PlayerCurve = New Beacon.Curve(0.9999, 0.0001, 0.9999, 0.0001)
		  Self.PlayerLevelCap = 105
		  Self.PlayerLevelCapIsAscended = False
		  Self.PlayerMaxExperience = 4098538
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  Const AscensionLevels = 30
		  
		  Dim MaxLevel As UInteger
		  If Self.PlayerLevelCapIsAscended Then
		    MaxLevel = Self.PlayerLevelCap
		  Else
		    MaxLevel = Self.PlayerLevelCap + AscensionLevels
		  End If
		  
		  Dim EndLevel As UInteger = Self.PlayerLevelCap
		  Dim MaxXP As UInteger = Self.PlayerMaxExperience
		  Dim TrueMaxXP As UInteger = Round(Self.PlayerCurve.Evaluate(MaxLevel / EndLevel, 0, MaxXP))
		  
		  // Index 0 is level 2!
		  // Index 150 is level 152
		  // Index 178 is level 180
		  // This is because players start at level 1, not level 0. Then the 0-based array needs to be accounted for.
		  Dim Chunks() As Text
		  For Index As Integer = 0 To MaxLevel - 2
		    Dim Level As Integer = Index + 2
		    Dim XP As UInteger = Round(Self.PlayerCurve.Evaluate((Level - 1) / (EndLevel - 1), 0, MaxXP))
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Dim Values() As Beacon.ConfigValue
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Text.Join(Chunks, ",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsPlayer", TrueMaxXP.ToText))
		  
		  Redim Chunks(-1)
		  MaxLevel = Self.DinoLevelCap
		  EndLevel = MaxLevel
		  MaxXP = Self.DinoMaxExperience
		  TrueMaxXP = MaxXP
		  
		  For Index As Integer = 0 To MaxLevel - 2
		    Dim Level As Integer = Index + 2
		    Dim XP As UInteger = Round(Self.DinoCurve.Evaluate((Level - 1) / (EndLevel - 1), 0, MaxXP))
		    Chunks.Append("ExperiencePointsForLevel[" + Index.ToText + "]=" + XP.ToText)
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "LevelExperienceRampOverrides", "(" + Text.Join(Chunks, ",") + ")"))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "OverrideMaxExperiencePointsDino", Self.DinoMaxExperience.ToText))
		  
		  Return Values
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
		DinoMaxExperience As UInteger
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDinoCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDinoLevelCap As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDinoMaxExperience As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerCurve As Beacon.Curve
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerLevelCap As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerLevelCapIsAscended As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerMaxExperience As UInteger
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
			  Return Self.mPlayerLevelCapIsAscended
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPlayerLevelCapIsAscended <> Value Then
			    Self.mPlayerLevelCapIsAscended = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PlayerLevelCapIsAscended As Boolean
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
		PlayerMaxExperience As UInteger
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
	#tag EndViewBehavior
End Class
#tag EndClass
