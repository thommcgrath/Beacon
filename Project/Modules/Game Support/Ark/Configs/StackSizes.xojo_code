#tag Class
Protected Class StackSizes
Inherits Ark.ConfigGroup
	#tag Event
		Sub CopyFrom(Other As Ark.ConfigGroup)
		  Var Source As Ark.Configs.StackSizes = Ark.Configs.StackSizes(Other)
		  Self.mGlobalMultiplier = Source.mGlobalMultiplier
		  
		  Var References() As Ark.BlueprintReference = Source.mOverrides.References
		  For Each Reference As Ark.BlueprintReference In References
		    If Reference.IsEngram = False Then
		      Continue
		    End If
		    
		    Self.mOverrides.Value(Reference, "Stack Size") = Source.mOverrides.Value(Reference, "Stack Size")
		  Next Reference
		End Sub
	#tag EndEvent

	#tag Event
		Function GenerateConfigValues(Project As Ark.Project, Profile As Ark.ServerProfile) As Ark.ConfigValue()
		  #Pragma Unused Profile
		  
		  Var Values() As Ark.ConfigValue
		  
		  If Self.mGlobalMultiplier >= Self.MaximumQuantity Then
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ItemStackSizeMultiplier=1.0"))
		  Else
		    Values.Add(New Ark.ConfigValue(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ItemStackSizeMultiplier=" + Self.mGlobalMultiplier.PrettyText))
		  End If
		  
		  Var Engrams() As Ark.Engram = Self.Engrams
		  For Each Engram As Ark.Engram In Engrams
		    If Engram.ValidForProject(Project) Then
		      Var StackSize As UInt64 = Min(Self.mOverrides.Value(Engram, "Stack Size"), Self.MaximumQuantity)
		      Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ConfigOverrideItemMaxQuantity=(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + StackSize.ToString + ",bIgnoreMultiplier=true))", "ConfigOverrideItemMaxQuantity:" + Engram.ClassString))
		    End If
		  Next
		  
		  // Inject overrides for things that would go over the limit
		  If Self.mGlobalMultiplier <> 1.0 Then
		    Var AllEngrams() As Ark.Engram = Ark.DataSource.SharedInstance.GetEngrams("", Project.ContentPacks)
		    For Each Engram As Ark.Engram In AllEngrams
		      If Self.mOverrides.HasBlueprint(Engram) Or (Engram.StackSize Is Nil) Or Engram.StackSize.DoubleValue = 1 Or Engram.StackSize.DoubleValue * Self.mGlobalMultiplier < Self.MaximumQuantity Then
		        Continue
		      End If
		      
		      Values.Add(New Ark.ConfigValue(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ConfigOverrideItemMaxQuantity=(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + Self.MaximumQuantity.ToString + ",bIgnoreMultiplier=true))", "ConfigOverrideItemMaxQuantity:" + Engram.ClassString))
		    Next
		  End If
		  
		  Return Values
		End Function
	#tag EndEvent

	#tag Event
		Function GetManagedKeys() As Ark.ConfigKey()
		  Var Keys() As Ark.ConfigKey
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGameUserSettings, Ark.HeaderServerSettings, "ItemStackSizeMultiplier"))
		  Keys.Add(New Ark.ConfigKey(Ark.ConfigFileGame, Ark.HeaderShooterGame, "ConfigOverrideItemMaxQuantity"))
		  Return Keys
		End Function
	#tag EndEvent

	#tag Event
		Sub ReadSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  Self.mGlobalMultiplier = SaveData.DoubleValue("Global", 1.0)
		  
		  If SaveData.HasKey("Sizes") Then
		    Var Overrides As Ark.BlueprintAttributeManager = Ark.BlueprintAttributeManager.FromSaveData(SaveData.Value("Sizes"))
		    If (Overrides Is Nil) = False Then
		      Self.mOverrides = Overrides
		    End If
		  ElseIf SaveData.HasKey("Rates") Then
		    Var Rates As Dictionary = SaveData.DictionaryValue("Rates", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Ark.Engram = Ark.ResolveEngram("", Entry.Key, "", Nil)
		        Self.mOverrides.Value(Engram, "Stack Size") = Entry.Value.UInt64Value
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Else
		    Var Rates As Dictionary = SaveData.DictionaryValue("Overrides", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Ark.Engram = Ark.ResolveEngram("", "", Entry.Key, Nil)
		        Self.mOverrides.Value(Engram, "Stack Size") = Entry.Value.UInt64Value
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteSaveData(SaveData As Dictionary, EncryptedData As Dictionary)
		  #Pragma Unused EncryptedData
		  
		  SaveData.Value("Global") = Self.mGlobalMultiplier
		  SaveData.Value("Sizes") = Self.mOverrides.SaveData
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mOverrides = New Ark.BlueprintAttributeManager
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return CType(Self.mOverrides.Count, UInteger)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Ark.Engram()
		  Var References() As Ark.BlueprintReference = Self.mOverrides.References
		  Var Results() As Ark.Engram
		  For Each Reference As Ark.BlueprintReference In References
		    If Not Reference.IsEngram Then
		      Continue
		    End If
		    
		    Var Blueprint As Ark.Blueprint = Reference.Resolve
		    If (Blueprint Is Nil = False) And Blueprint IsA Ark.Engram Then
		      Results.Add(Ark.Engram(Blueprint))
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As Double, ContentPacks As Beacon.StringList) As Ark.Configs.StackSizes
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If ParsedData.HasAnyKey("ItemStackSizeMultiplier", "ConfigOverrideItemMaxQuantity") = False Then
		    Return Nil
		  End If
		  
		  Var GlobalMultiplier As Double = ParsedData.DoubleValue("ItemStackSizeMultiplier", 1.0, True)
		  Var Overrides As New Ark.BlueprintAttributeManager
		  
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
		      
		      If ClassString.IsEmpty = False And ClassString.EndsWith("_C") And StackSize > CType(0, UInt64) Then
		        Var Engram As Ark.Engram = Ark.ResolveEngram("", "", ClassString, ContentPacks)
		        Overrides.Value(Engram, "Stack Size") = StackSize
		      End If
		    Next
		  End If
		  
		  Var Config As New Ark.Configs.StackSizes
		  Config.mGlobalMultiplier = GlobalMultiplier
		  Config.mOverrides = Overrides
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GlobalMultiplier() As Double
		  Return Self.mGlobalMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GlobalMultiplier(Assigns Value As Double)
		  If Self.mGlobalMultiplier <> Value Then
		    Self.mGlobalMultiplier = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Ark.Configs.NameStackSizes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As Integer
		  Return Self.mOverrides.Count - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(Engram As Ark.Engram) As UInt64
		  Var StackSize As Variant = Self.mOverrides.Value(Engram, "Stack Size")
		  If StackSize.IsNull Then
		    Return CType(0, UInt64)
		  End If
		  Return StackSize.UInt64Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(Engram As Ark.Engram, Assigns StackSize As UInt64)
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


	#tag Property, Flags = &h21
		Private mGlobalMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverrides As Ark.BlueprintAttributeManager
	#tag EndProperty


	#tag Constant, Name = MaximumQuantity, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Public
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
	#tag EndViewBehavior
End Class
#tag EndClass
