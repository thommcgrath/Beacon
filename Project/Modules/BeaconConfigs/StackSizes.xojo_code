#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class StackSizes
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Var UUID As String = Entry.Key
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByID(UUID)
		    
		    If Engram.ValidForDocument(SourceDocument) Then
		      Var StackSize As UInt64 = Min(Entry.Value, Self.MaximumQuantity)
		      Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + StackSize.ToString + ",bIgnoreMultiplier=true))"))
		    End If
		  Next
		  
		  // Inject overrides for things that would go over the limit
		  If Self.mGlobalMultiplier <> 1.0 Then
		    Var AllEngrams() As Beacon.Engram = Beacon.Data.SearchForEngrams("", SourceDocument.Mods)
		    For Each Engram As Beacon.Engram In AllEngrams
		      If Self.mOverrides.HasKey(Engram.ObjectID) Or Engram.StackSize Is Nil Or Engram.StackSize.DoubleValue = 1 Or Engram.StackSize.DoubleValue * Self.mGlobalMultiplier < Self.MaximumQuantity Then
		        Continue
		      End If
		      
		      Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + Self.MaximumQuantity.ToString + ",bIgnoreMultiplier=true))"))
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  If Self.mGlobalMultiplier >= Self.MaximumQuantity Then
		    Values.Add(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", "1.0"))
		  Else
		    Values.Add(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", Self.mGlobalMultiplier.PrettyText))
		  End If
		End Sub
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
		  Self.mOverrides = New Dictionary
		  
		  If Dict.HasKey("Values") Then
		    Var Values() As Variant
		    Try
		      Values = Dict.Value("Values")
		    Catch Err As RuntimeException
		    End Try
		    For Idx As Integer = 0 To Values.LastIndex
		      If (Values(Idx) IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var ValueDict As Dictionary = Values(Idx)
		      Var UUID As String = ValueDict.Value("UUID").StringValue
		      Var Rate As UInt64 = ValueDict.Value("Rate").UInt64Value
		      Self.mOverrides.Value(UUID) = Rate
		    Next
		  ElseIf Dict.HasKey("Rates") Then
		    Var Rates As Dictionary = Dict.DictionaryValue("Rates", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Beacon.Engram = Beacon.ResolveEngram("", Entry.Key, "", Nil)
		        Self.mOverrides.Value(Engram.ObjectID) = Entry.Value.UInt64Value
		      Catch Err As RuntimeException
		      End Try
		    Next
		  Else
		    Var Rates As Dictionary = Dict.DictionaryValue("Overrides", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Beacon.Engram = Beacon.ResolveEngram("", "", Entry.Key, Nil)
		        Self.mOverrides.Value(Engram.ObjectID) = Entry.Value.UInt64Value
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document, BlueprintsMap As Dictionary)
		  #Pragma Unused Document
		  
		  Var Values() As Dictionary
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Var UUID As String = Entry.Key
		    Var Rate As UInt64 = Entry.Value
		    
		    Var ValueDict As New Dictionary
		    ValueDict.Value("UUID") = UUID
		    ValueDict.Value("Rate") = Rate
		    Values.Add(ValueDict)
		    
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByID(UUID)
		    If (Engram Is Nil) = False Then
		      BlueprintsMap.Value(Engram.ObjectID) = Engram
		    End If
		  Next
		  
		  Dict.Value("Global") = Self.mGlobalMultiplier
		  Dict.Value("Values") = Values
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
		  Self.mOverrides = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return CType(Self.mOverrides.KeyCount, UInteger)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Beacon.Engram()
		  Var Results() As Beacon.Engram
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByID(Entry.Key.StringValue)
		    If (Engram Is Nil) = False Then
		      Results.Add(Engram)
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
		  Var Overrides As New Dictionary
		  
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
		        Overrides.Value(Engram.ObjectID) = StackSize
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
		  Return Self.mOverrides.KeyCount - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(Engram As Beacon.Engram) As UInt64
		  Var Zero As UInt64 = 0
		  
		  If Engram <> Nil Then
		    Return Self.mOverrides.Lookup(Engram.ObjectID, Zero)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(Engram As Beacon.Engram, Assigns StackSize As UInt64)
		  Var Zero As UInt64 = 0
		  
		  If IsNull(Engram) Then
		    Return
		  End If
		  
		  If StackSize <= Zero And Self.mOverrides.HasKey(Engram.ObjectID) Then
		    Self.mOverrides.Remove(Engram.ObjectID)
		    Self.Modified = True
		  ElseIf StackSize > Zero And Self.mOverrides.Lookup(Engram.ObjectID, Zero) <> StackSize Then
		    Self.mOverrides.Value(Engram.ObjectID) = StackSize
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
		Private mOverrides As Dictionary
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
