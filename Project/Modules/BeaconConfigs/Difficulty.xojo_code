#tag Class
Protected Class Difficulty
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary)
		  If Dict.HasKey("DinoLevelIncrements") Then
		    Self.DinoLevelIncrements = Dict.Value("DinoLevelIncrements")
		  End If
		  If Dict.HasKey("MaxDinoLevel") Then
		    Self.MaxDinoLevel = Dict.Value("MaxDinoLevel")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary)
		  Dict.Value("MaxDinoLevel") = Self.MaxDinoLevel
		  Dict.Value("DinoLevelIncrements") = Self.DinoLevelIncrements
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CommandLineOptions(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Dim Options(0) As Beacon.ConfigValue
		  Options(0) = New Beacon.ConfigValue("?", "OverrideOfficialDifficulty", Self.DinoLevelIncrements.ToText)
		  Return Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(OverrideOfficialDifficulty As Double, DifficultyOffset As Double)
		  Self.DinoLevelIncrements = Round(OverrideOfficialDifficulty)
		  Self.MaxDinoLevel = Floor(((OverrideOfficialDifficulty * 30) * DifficultyOffset) / Self.DinoLevelIncrements) * Self.DinoLevelIncrements
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Dim DifficultyOffset As Double = Max(((Self.MaxDinoLevel / 30) - 0.5) / (Self.DinoLevelIncrements - 0.5), 0.01)
		  Dim Options(1) As Beacon.ConfigValue
		  Options(0) = New Beacon.ConfigValue(Beacon.SessionSettingsHeader, "DifficultyOffset", DifficultyOffset.PrettyText)
		  Options(1) = New Beacon.ConfigValue(Beacon.SessionSettingsHeader, "OverrideOfficialDifficulty", Self.DinoLevelIncrements.ToText)
		  Return Options
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GroupName() As Text
		  Return "Difficulty"
		End Function
	#tag EndMethod


	#tag Note, Name = Formula
		
		MaxDinoLevel = Max(MaxDinoLevel, 15)
		DinoLevelSteps = Max(DinoLevelSteps, 1)
		DifficultyValue = MaxDinoLevel / 30 
		OverrideOfficialDifficulty = DinoLevelSteps
		DifficultyOffset = Max(((MaxDinoLevel / 30) - 0.5) / (DinoLevelSteps - 0.5), 0.01)
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mDinoLevelIncrements, 1)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDinoLevelIncrements <> Value Then
			    Self.mDinoLevelIncrements = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DinoLevelIncrements As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mMaxDinoLevel, 15)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMaxDinoLevel <> Value Then
			    Self.mMaxDinoLevel = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		MaxDinoLevel As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDinoLevelIncrements As Integer = 5
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxDinoLevel As Integer = 150
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #Pragma Warning "This is suspect"
			  Return Self.MaxDinoLevel / 30
			End Get
		#tag EndGetter
		QualityMultiplier As Double
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
			Name="Modified"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxDinoLevel"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
