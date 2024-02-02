#tag Class
Protected Class Difficulty
Inherits ArkSA.ConfigGroup
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub CopyFrom(Other As ArkSA.ConfigGroup)
		  Self.mMaxDinoLevel = ArkSA.Configs.Difficulty(Other).mMaxDinoLevel
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As ArkSA.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As ArkSA.ConfigValue
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "DifficultyOffset=1.0"))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "OverrideOfficialDifficulty=" + Self.OverrideOfficialDifficulty.PrettyText(Self.DecimalPlaces)))
		  Values.Add(New ArkSA.ConfigValue(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "MaxDifficulty=False"))
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As ArkSA.ConfigOption()
		  Var Keys() As ArkSA.ConfigOption
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "DifficultyOffset"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGameUserSettings, ArkSA.HeaderServerSettings, "OverrideOfficialDifficulty"))
		  Keys.Add(New ArkSA.ConfigOption(ArkSA.ConfigFileGame, ArkSA.HeaderShooterGame, "MaxDifficulty"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Function HasContent() As Boolean
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  If SaveData.HasKey("MaxDinoLevel") Then
		    Self.mMaxDinoLevel = SaveData.Value("MaxDinoLevel")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Validate(Location As String, Issues As Beacon.ProjectValidationResults, Project As Beacon.Project)
		  #Pragma Unused Project
		  
		  If Self.mMaxDinoLevel <= 0 Then
		    Issues.Add(New Beacon.Issue(Location + ".MaxDinoLevel", "Difficulty must be greater than zero."))
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  SaveData.Value("MaxDinoLevel") = Self.mMaxDinoLevel
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function BaseArbitraryQuality(DifficultyValue As Double) As Double
		  Var DifficultyOffset As Double = DifficultyOffset(DifficultyValue)
		  Return 0.75 + (DifficultyOffset * 1.75)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DifficultyValue As Double)
		  Self.DifficultyValue = DifficultyValue
		  Self.Modified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function DifficultyOffset(DifficultyValue As Double) As Double
		  Return (DifficultyValue - 0.5) / 4.5
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameDifficulty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Levels() As Integer()
		  Var Results() As Integer
		  For I As Integer = 1 To 30
		    Results.Add(Floor(Self.DifficultyValue * I))
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PerfectLevel(Level As Integer) As Integer
		  Return Level + Floor(Level * 0.5 * 0.999)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.BaseArbitraryQuality(Self.DifficultyValue)
			End Get
		#tag EndGetter
		BaseArbitraryQuality As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.DifficultyOffset(Self.DifficultyValue)
			End Get
		#tag EndGetter
		DifficultyOffset As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Ceiling((Self.mMaxDinoLevel / 30) * 10000) / 10000
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.MaxDinoLevel = Floor(Value * 30)
			End Set
		#tag EndSetter
		DifficultyValue As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.DifficultyValue * 45
			End Get
		#tag EndGetter
		MaxCrystalWyvernLevel As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Max(Self.mMaxDinoLevel, 15)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Min(Value, 2999999970)
			  
			  If Self.mMaxDinoLevel <> Value Then
			    Self.mMaxDinoLevel = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		MaxDinoLevel As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.DifficultyValue * 36
			End Get
		#tag EndGetter
		MaxTekLevel As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.DifficultyValue * 38
			End Get
		#tag EndGetter
		MaxWyvernLevel As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mMaxDinoLevel As Integer = 150
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.DifficultyValue
			End Get
		#tag EndGetter
		OverrideOfficialDifficulty As Double
	#tag EndComputedProperty


	#tag Constant, Name = DecimalPlaces, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
			Name="BaseArbitraryQuality"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DifficultyOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DifficultyValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxCrystalWyvernLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxDinoLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxTekLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxWyvernLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="OverrideOfficialDifficulty"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
