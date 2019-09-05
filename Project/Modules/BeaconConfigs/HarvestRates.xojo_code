#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class HarvestRates
Inherits Beacon.ConfigGroup
	#tag Event
		Sub CommandLineOptions(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  Values.Append(New Beacon.ConfigValue("?", "UseOptimizedHarvestingHealth", If(Self.mUseOptimizedRates, "true", "false")))
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Dim ClassString As String = Entry.Key
		    Dim Rate As Double = Entry.Value
		    Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "HarvestResourceItemAmountClassMultipliers", "(ClassName=""" + ClassString + """,Multiplier=" + Rate.PrettyText + ")"))
		  Next
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "PlayerHarvestingDamageMultiplier", Self.mPlayerHarvestingDamageMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "DinoHarvestingDamageMultiplier", Self.mDinoHarvestingDamageMultiplier.PrettyText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "HarvestAmountMultiplier", Self.mHarvestAmountMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "HarvestHealthMultiplier", Self.mHarvestHealthMultiplier.PrettyText))
		  Values.Append(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ClampResourceHarvestDamage", If(Self.mClampResourceHarvestDamage, "True", "False")))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  // There is a slight performance impact here, since DoubleValue will check HasKey too,
		  // but this way is safe.
		  If Dict.HasKey("Harvest Amount Multiplier") Then
		    Self.mHarvestAmountMultiplier = Dict.DoubleValue("Harvest Amount Multiplier", 1.0)
		  ElseIf Dict.HasKey("Global") Then
		    Self.mHarvestAmountMultiplier = Dict.DoubleValue("Global", 1.0)
		  End If
		  
		  Self.mHarvestHealthMultiplier = Dict.DoubleValue("Harvest Health Multiplier", 1.0)
		  Self.mUseOptimizedRates = Dict.BooleanValue("Use Optimized Rates", False)
		  Self.mClampResourceHarvestDamage = Dict.BooleanValue("Clamp Resource Harvest Damage", False)
		  Self.mPlayerHarvestingDamageMultiplier = Dict.DoubleValue("Player Harvesting Damage Multiplier", 1.0)
		  Self.mDinoHarvestingDamageMultiplier = Dict.DoubleValue("Dino Harvesting Damage Multiplier", 1.0)
		  
		  Self.mOverrides = Dict.DictionaryValue("Overrides", New Dictionary)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Harvest Amount Multiplier") = Self.mHarvestAmountMultiplier
		  Dict.Value("Harvest Health Multiplier") = Self.mHarvestHealthMultiplier
		  Dict.Value("Overrides") = Self.mOverrides
		  Dict.Value("Use Optimized Rates") = Self.mUseOptimizedRates
		  Dict.Value("Clamp Resource Harvest Damage") = Self.mClampResourceHarvestDamage
		  Dict.Value("Player Harvesting Damage Multiplier") = Self.mPlayerHarvestingDamageMultiplier
		  Dict.Value("Dino Harvesting Damage Multiplier") = Self.mDinoHarvestingDamageMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Classes() As String()
		  Dim Results() As String
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Results.Append(Entry.Key)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "HarvestRates"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  Self.mClampResourceHarvestDamage = False
		  Self.mDinoHarvestingDamageMultiplier = 1.0
		  Self.mHarvestAmountMultiplier = 1.0
		  Self.mHarvestHealthMultiplier = 1.0
		  Self.mPlayerHarvestingDamageMultiplier = 1.0
		  Self.mUseOptimizedRates = False
		  Self.mOverrides = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mOverrides.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.HarvestRates
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  Dim HarvestAmountMultiplier As Double = ParsedData.DoubleValue("HarvestAmountMultiplier", 1.0, True)
		  Dim HarvestHealthMultiplier As Double = ParsedData.DoubleValue("HarvestHealthMultiplier", 1.0, True)
		  Dim PlayerHarvestingDamageMultiplier As Double = ParsedData.DoubleValue("PlayerHarvestingDamageMultiplier", 1.0, True)
		  Dim DinoHarvestingDamageMultiplier As Double = ParsedData.DoubleValue("DinoHarvestingDamageMultiplier", 1.0, True)
		  Dim ClampResourceHarvestDamage As Boolean = ParsedData.BooleanValue("ClampResourceHarvestDamage", False, True)
		  Dim UseOptimizedRates As Boolean = False
		  Dim Overrides As New Dictionary
		  
		  If CommandLineOptions <> Nil And CommandLineOptions.HasKey("UseOptimizedHarvestingHealth") Then
		    Try
		      UseOptimizedRates = CommandLineOptions.BooleanValue("UseOptimizedHarvestingHealth", False, False)
		    Catch Err As RuntimeException
		    End Try
		  End If
		  
		  If ParsedData.HasKey("HarvestResourceItemAmountClassMultipliers") Then
		    Dim AutoValue As Variant = ParsedData.Value("HarvestResourceItemAmountClassMultipliers")
		    Dim Dicts() As Dictionary
		    Dim Info As Introspection.TypeInfo = Introspection.GetType(AutoValue)
		    Select Case Info.FullName
		    Case "Dictionary"
		      Dicts.Append(AutoValue)
		    Case "Auto()"
		      Dim ArrayValue() As Variant = AutoValue
		      For Each Dict As Dictionary In ArrayValue
		        Dicts.Append(Dict)
		      Next
		    End Select
		    
		    For Each Dict As Dictionary In Dicts
		      If Not Dict.HasAllKeys("ClassName", "Multiplier") Then
		        Continue
		      End If   
		      
		      Dim Multiplier As Double = Dict.Value("Multiplier")
		      Dim ClassString As String = Dict.Value("ClassName")
		      
		      If ClassString <> "" And ClassString.EndsWith("_C") And Multiplier > 0 Then
		        Overrides.Value(ClassString) = Multiplier
		      End If
		    Next
		  End If
		  
		  // Use the public properties here to toggle modified ...
		  Dim Config As New BeaconConfigs.HarvestRates
		  Config.HarvestAmountMultiplier = HarvestAmountMultiplier
		  Config.HarvestHealthMultiplier = HarvestHealthMultiplier
		  Config.PlayerHarvestingDamageMultiplier = PlayerHarvestingDamageMultiplier
		  Config.DinoHarvestingDamageMultiplier = DinoHarvestingDamageMultiplier
		  Config.ClampResourceHarvestDamage = ClampResourceHarvestDamage
		  Config.UseOptimizedRates = UseOptimizedRates
		  Config.mOverrides = Overrides
		  
		  // ... so it can be checked here to determine if any of the values are non-default
		  If Config.Modified Or Config.mOverrides.KeyCount > 0 Then
		    Config.Modified = False
		    Return Config
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mOverrides.KeyCount - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(ClassString As String) As Double
		  Return Self.mOverrides.Lookup(ClassString, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(ClassString As String, Assigns Rate As Double)
		  If Rate <= 0 And Self.mOverrides.HasKey(ClassString) Then
		    Self.mOverrides.Remove(ClassString)
		    Self.Modified = True
		  ElseIf Rate > 0 And Self.mOverrides.Lookup(ClassString, 0) <> Rate Then
		    Self.mOverrides.Value(ClassString) = Rate
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mClampResourceHarvestDamage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mClampResourceHarvestDamage <> Value Then
			    Self.mClampResourceHarvestDamage = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		ClampResourceHarvestDamage As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mDinoHarvestingDamageMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mDinoHarvestingDamageMultiplier <> Value Then
			    Self.mDinoHarvestingDamageMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		DinoHarvestingDamageMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHarvestAmountMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHarvestAmountMultiplier <> Value Then
			    Self.mHarvestAmountMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		HarvestAmountMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHarvestHealthMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHarvestHealthMultiplier <> Value Then
			    Self.mHarvestHealthMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		HarvestHealthMultiplier As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mClampResourceHarvestDamage As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDinoHarvestingDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHarvestAmountMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHarvestHealthMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverrides As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlayerHarvestingDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseOptimizedRates As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPlayerHarvestingDamageMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPlayerHarvestingDamageMultiplier <> Value Then
			    Self.mPlayerHarvestingDamageMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		PlayerHarvestingDamageMultiplier As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUseOptimizedRates
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mUseOptimizedRates <> Value Then
			    Self.mUseOptimizedRates = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		UseOptimizedRates As Boolean
	#tag EndComputedProperty


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
			Name="HarvestAmountMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClampResourceHarvestDamage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DinoHarvestingDamageMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HarvestHealthMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PlayerHarvestingDamageMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseOptimizedRates"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
