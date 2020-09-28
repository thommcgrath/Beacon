#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class StackSizes
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Var Path As String = Entry.Key
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Path)
		    If IsNull(Engram) Then
		      Engram = Beacon.Engram.CreateFromPath(Path)
		    End If
		    
		    If IsNull(Engram) = False And Engram.ValidForDocument(SourceDocument) Then
		      Var StackSize As UInt64 = Min(Entry.Value, Self.MaximumQuantity)
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + StackSize.ToString + ",bIgnoreMultiplier=true))"))
		    End If
		  Next
		  
		  // Inject overrides for things that would go over the limit
		  If Self.mGlobalMultiplier <> 1.0 Then
		    Var AllEngrams() As Beacon.Engram = Beacon.Data.SearchForEngrams("", SourceDocument.Mods)
		    For Each Engram As Beacon.Engram In AllEngrams
		      If Self.mOverrides.HasKey(Engram.Path) Or Engram.StackSize Is Nil Or Engram.StackSize.DoubleValue = 1 Or Engram.StackSize.DoubleValue * Self.mGlobalMultiplier < Self.MaximumQuantity Then
		        Continue
		      End If
		      
		      Values.AddRow(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + Engram.ClassString + """,Quantity=(MaxItemQuantity=" + Self.MaximumQuantity.ToString + ",bIgnoreMultiplier=true))"))
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  If Self.mGlobalMultiplier >= Self.MaximumQuantity Then
		    Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", "1.0"))
		  Else
		    Values.AddRow(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", Self.mGlobalMultiplier.PrettyText))
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
		  
		  If Dict.HasKey("Rates") Then
		    Self.mOverrides = Dict.DictionaryValue("Rates", New Dictionary)
		  Else
		    Self.mOverrides = New Dictionary
		    Var Rates As Dictionary = Dict.DictionaryValue("Overrides", New Dictionary)
		    For Each Entry As DictionaryEntry In Rates
		      Try
		        Var Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(Entry.Key)
		        If IsNull(Engram) Then
		          Engram = Beacon.Engram.CreateFromClass(Entry.Key)
		        End If
		        If IsNull(Engram) = False Then
		          Self.mOverrides.Value(Engram.Path) = Entry.Value.UInt64Value
		        End If
		      Catch Err As RuntimeException
		      End Try
		    Next
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Var LegacyOverrides As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Entry.Key)
		    If IsNull(Engram) Then
		      Engram = Beacon.Engram.CreateFromPath(Entry.Key)
		    End If
		    If IsNull(Engram) = False Then
		      LegacyOverrides.Value(Engram.ClassString) = Entry.Value
		    End If
		  Next
		  
		  Dict.Value("Global") = Self.mGlobalMultiplier
		  Dict.Value("Rates") = Self.mOverrides
		  Dict.Value("Overrides") = LegacyOverrides
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
		Function Count() As Integer
		  Return Self.mOverrides.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Engrams() As Beacon.Engram()
		  Var Results() As Beacon.Engram
		  For Each Entry As DictionaryEntry In Self.mOverrides
		    Var Engram As Beacon.Engram = Beacon.Data.GetEngramByPath(Entry.Key)
		    If IsNull(Engram) Then
		      Engram = Beacon.Engram.CreateFromPath(Entry.Key)
		    End If
		    If IsNull(Engram) = False Then
		      Results.AddRow(Engram)
		    End If
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.StackSizes
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
		      Dicts.AddRow(AutoValue)
		    Case "Object()"
		      Var ArrayValue() As Variant = AutoValue
		      For Each Dict As Dictionary In ArrayValue
		        Dicts.AddRow(Dict)
		      Next
		    End Select
		    
		    For Each Dict As Dictionary In Dicts
		      If Not Dict.HasAllKeys("ItemClassString", "Quantity") Then
		        Continue
		      End If   
		      
		      Var Quantity As Dictionary = Dict.Value("Quantity")
		      Var ClassString As String = Dict.Value("ItemClassString")
		      Var StackSize As UInt64 = Quantity.Lookup("MaxItemQuantity", 0)
		      
		      If ClassString <> "" And ClassString.EndsWith("_C") And StackSize > CType(0, UInt64) Then
		        Var Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		        If IsNull(Engram) Then
		          Engram = Beacon.Engram.CreateFromClass(ClassString)
		        End If
		        Overrides.Value(Engram.Path) = StackSize
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
		    Return Self.mOverrides.Lookup(Engram.Path, Zero)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(Engram As Beacon.Engram, Assigns StackSize As UInt64)
		  Var Zero As UInt64 = 0
		  
		  If IsNull(Engram) Then
		    Return
		  End If
		  
		  If StackSize <= Zero And Self.mOverrides.HasKey(Engram.Path) Then
		    Self.mOverrides.Remove(Engram.Path)
		    Self.Modified = True
		  ElseIf StackSize > Zero And Self.mOverrides.Lookup(Engram.Path, Zero) <> StackSize Then
		    Self.mOverrides.Value(Engram.Path) = StackSize
		    Self.Modified = True
		  End If
		End Sub
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
