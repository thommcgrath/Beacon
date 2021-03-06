#tag Class
Protected Class Difficulty
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  Var Values() As Beacon.ConfigValue
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "DifficultyOffset=1.0"))
		  Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "OverrideOfficialDifficulty=" + Self.OverrideOfficialDifficulty.PrettyText(Self.DecimalPlaces)))
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "DifficultyOffset"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "OverrideOfficialDifficulty"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("MaxDinoLevel") Then
		    Self.MaxDinoLevel = Dict.Value("MaxDinoLevel")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("MaxDinoLevel") = Self.MaxDinoLevel
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function ConfigName() As String
		  Return BeaconConfigs.NameDifficulty
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DifficultyValue As Double)
		  Self.DifficultyValue = DifficultyValue
		  Self.Modified = False
		End Sub
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
		Function RequiresOmni() As Boolean
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunWhenBanned() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag Note, Name = Source
		https://forums.unrealengine.com/development-discussion/modding/ark-survival-evolved/93237-tutorial-understanding-arbitrary-item-quality
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return 0.75 + (Self.DifficultyOffset * 1.75)
			End Get
		#tag EndGetter
		BaseArbitraryQuality As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.DifficultyValue - 0.5) / 4.5
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
		#tag ViewProperty
			Name="MaxDinoLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="BaseArbitraryQuality"
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
			Name="OverrideOfficialDifficulty"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="MaxCrystalWyvernLevel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
