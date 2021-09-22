#tag Class
Protected Class Difficulty
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Self.mMaxDinoLevel = Ark.Configs.Difficulty(Other).mMaxDinoLevel
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DifficultyOffset=1.0"))
		  Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "OverrideOfficialDifficulty=" + Self.OverrideOfficialDifficulty.PrettyText(Self.DecimalPlaces)))
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "DifficultyOffset"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "OverrideOfficialDifficulty"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  If SaveData.HasKey("MaxDinoLevel") Then
		    Self.mMaxDinoLevel = SaveData.Value("MaxDinoLevel")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
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
		  Return Ark.Configs.NameDifficulty
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
		Function RunWhenBanned() As Boolean
		  Return True
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
