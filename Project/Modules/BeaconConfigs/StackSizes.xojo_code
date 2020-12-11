#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class StackSizes
Inherits Beacon.ConfigGroup
	#tag Event
		Function GenerateConfigValues(SourceDocument As Beacon.Document, Profile As Beacon.ServerProfile) As Beacon.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Beacon.ConfigValue
		  
		  If Self.mGlobalMultiplier >= Self.MaximumQuantity Then
		    Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", "1.0"))
		  Else
		    Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", Self.mGlobalMultiplier.PrettyText))
		  End If
		  
		  Var Engrams() As Beacon.Engram = Self.Engrams
		  For Each Engram As Beacon.Engram In Engrams
		    If Engram.ValidForDocument(SourceDocument) Then
		      Var StackSize As UInt64 = Min(Self.mOverrides.Value(Engram, "Stack Size"), Self.MaximumQuantity)
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + StackSize.ToString + ",bIgnoreMultiplier=true))"))
		    End If
		  Next
		  
		  // Inject overrides for things that would go over the limit
		  If Self.mGlobalMultiplier <> 1.0 Then
		    Var AllEngrams() As Beacon.Engram = Beacon.Data.SearchForEngrams("", SourceDocument.Mods)
		    For Each Engram As Beacon.Engram In AllEngrams
		      If Self.mOverrides.HasBlueprint(Engram) Or (Engram.StackSize Is Nil) Or Engram.StackSize.DoubleValue = 1 Or Engram.StackSize.DoubleValue * Self.mGlobalMultiplier < Self.MaximumQuantity Then
		        Continue
		      End If
		      
		      Values.Add(New Beacon.ConfigValue(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + Self.MaximumQuantity.ToString + ",bIgnoreMultiplier=true))"))
		    Next
		  End If
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Beacon.ConfigKey()
		  Var Keys() As Beacon.ConfigKey
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGameUserSettings, Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier"))
		  Keys.Add(New Beacon.ConfigKey(Beacon.ConfigFileGame, Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub MergeFrom(Other As Beacon.ConfigGroup)
		  Var Source As BeaconConfigs.StackSizes = BeaconConfigs.StackSizes(Other)
		  Var Engrams() As Beacon.Engram = Source.Engrams
		  For Each Engram As Beacon.Engram In Engrams
		    Self.Override(Engram) = Source.Override(Engram)
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  Self.mGlobalMultiplier = Dict.DoubleValue("Global", 1.0)
		  
		  If Dict.HasKey("Sizes") Then
		    Var Overrides As Beacon.BlueprintAttributeManager = Beacon.BlueprintAttributeManager.FromSaveData(Dict.Value("Sizes"))
		    If (Overrides Is Nil) = False Then
		      Self.mOverrides = Overrides
		    End If
		  ElseIf Dict.HasKey("Rates") Then
		    Var Rates As Dictionary = Dict.DictionaryValue("Rates", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Beacon.Engram = Beacon.ResolveEngram("", Entry.Key, "", Nil)
		        Self.mOverrides.Value(Engram, "Stack Size") = Entry.Value.UInt64Value
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Else
		    Var Rates As Dictionary = Dict.DictionaryValue("Overrides", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Beacon.Engram = Beacon.ResolveEngram("", "", Entry.Key, Nil)
		        Self.mOverrides.Value(Engram, "Stack Size") = Entry.Value.UInt64Value
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Global") = Self.mGlobalMultiplier
		  Dict.Value("Sizes") = Self.mOverrides.SaveData
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
		  Return "StackSizes"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  Self.mOverrides = New Beacon.BlueprintAttributeManager
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return CType(Self.mOverrides.Count, UInteger)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Beacon.Engram()
		  Var References() As Beacon.BlueprintReference = Self.mOverrides.References
		  Var Results() As Beacon.Engram
		  For Each Reference As Beacon.BlueprintReference In References
		    If Not Reference.IsEngram Then
		      Continue
		    End If
		    
		    Var Blueprint As Beacon.Blueprint = Reference.Resolve
		    If (Blueprint Is Nil = False) And Blueprint IsA Beacon.Engram Then
		      Results.Add(Beacon.Engram(Blueprint))
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.StackSizes
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If ParsedData.HasAnyKey("ItemStackSizeMultiplier", "ConfigOverrideItemMaxQuantity") = False Then
		    Return Nil
		  End If
		  
		  Var GlobalMultiplier As Double = ParsedData.DoubleValue("ItemStackSizeMultiplier", 1.0, True)
		  Var Overrides As New Beacon.BlueprintAttributeManager
		  
		  If ParsedData.HasKey("ConfigOverrideItemMaxQuantity") Then
		    Var AutoValue As Variant = ParsedData.Value("ConfigOverrideItemMaxQuantity")
		    Var Dicts() As Dictionary  
		    Var Info As Introspection.TypeInfo = Introspection.GetType(AutoValue)
		    Select Case Info.FullName
		    Case "Dictionary"
		      Dicts.Add(AutoValue)
		    Case "Object()"
		      Var ArrayValue() As Variant = AutoValue
		      For Each Dict As Dictionary In ArrayValue
		        Dicts.Add(Dict)
		      Next
		    End Select
		    
		    For Each Dict As Dictionary In Dicts
		      If Not Dict.HasAllKeys("ItemClassString", "Quantity") Then
		        Continue
		      End If   
		      
		      Var Quantity As Dictionary = Dict.Value("Quantity")
		      Var ClassString As String = Dict.Value("ItemClassString")
		      Var StackSize As UInt64 = Quantity.Lookup("MaxItemQuantity", CType(0, UInt64))
		      
		      If ClassString <> "" And ClassString.EndsWith("_C") And StackSize > CType(0, UInt64) Then
		        Var Engram As Beacon.Engram = Beacon.ResolveEngram("", "", ClassString, Mods)
		        Overrides.Value(Engram, "Stack Size") = StackSize
		      End If
		    Next
		  End If
		  
		  Var Config As New BeaconConfigs.StackSizes
		  Config.mGlobalMultiplier = GlobalMultiplier
		  Config.mOverrides = Overrides
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mOverrides.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(Engram As Beacon.Engram) As UInt64
		  Var StackSize As Variant = Self.mOverrides.Value(Engram, "Stack Size")
		  If StackSize.IsNull Then
		    Return CType(0, UInt64)
		  End If
		  Return StackSize.UInt64Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(Engram As Beacon.Engram, Assigns StackSize As UInt64)
		  If Engram Is Nil Then
		    Return
		  End If
		  
		  If StackSize <= CType(0, UInt64) And Self.mOverrides.HasBlueprint(Engram) Then
		    Self.mOverrides.Remove(Engram)
		    Self.Modified = True
		  ElseIf StackSize > CType(0, UInt64) And Self.Override(Engram) <> StackSize Then
		    Self.mOverrides.Value(Engram, "Stack Size") = StackSize
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsMerging() As Boolean
		  Return True
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGlobalMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGlobalMultiplier <> Value Then
			    Self.mGlobalMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GlobalMultiplier As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGlobalMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverrides As Beacon.BlueprintAttributeManager
	#tag EndProperty


	#tag Constant, Name = MaximumQuantity, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Public
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
			Name="GlobalMultiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
