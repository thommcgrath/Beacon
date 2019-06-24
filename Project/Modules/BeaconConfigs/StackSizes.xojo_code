#tag Class
 Attributes ( OmniVersion = 1 ) Protected Class StackSizes
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Mask As UInt64)
		  #Pragma Unused Mask
		  #Pragma Unused SourceDocument
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mOverrides
		    Dim ClassString As Text = Entry.Key
		    Dim StackSize As Integer = Entry.Value
		    Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "ConfigOverrideItemMaxQuantity", "(ItemClassString=""" + ClassString + """,Quantity=(MaxItemQuantity=" + StackSize.ToText + ",bIgnoreMultiplier=true))"))
		  Next
		End Sub
	#tag EndEvent

	#tag Event
		Sub GameUserSettingsIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Mask As UInt64)
		  #Pragma Unused Mask
		  #Pragma Unused SourceDocument
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ServerSettingsHeader, "ItemStackSizeMultiplier", Self.mGlobalMultiplier.PrettyText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Self.mOverrides = Dict.DictionaryValue("Overrides", New Xojo.Core.Dictionary)
		  Self.mGlobalMultiplier = Dict.DoubleValue("Global", 1.0)
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dict.Value("Global") = Self.mGlobalMultiplier
		  Dict.Value("Overrides") = Self.mOverrides
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Classes() As Text()
		  Dim Results() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mOverrides
		    Results.Append(Entry.Key)
		  Next
		  Return Results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "StackSizes"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor()
		  Self.mOverrides = New Xojo.Core.Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As UInteger
		  Return Self.mOverrides.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.StackSizes
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  Dim GlobalMultiplier As Double = ParsedData.DoubleValue("ItemStackSizeMultiplier", 1.0, True)
		  Dim Overrides As New Xojo.Core.Dictionary
		  
		  If ParsedData.HasKey("ConfigOverrideItemMaxQuantity") Then
		    Dim AutoValue As Auto = ParsedData.Value("ConfigOverrideItemMaxQuantity")
		    Dim Dicts() As Xojo.Core.Dictionary  
		    Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(AutoValue)
		    Select Case Info.FullName
		    Case "Xojo.Core.Dictionary"
		      Dicts.Append(AutoValue)
		    Case "Auto()"
		      Dim ArrayValue() As Auto = AutoValue
		      For Each Dict As Xojo.Core.Dictionary In ArrayValue
		        Dicts.Append(Dict)
		      Next
		    End Select
		    
		    For Each Dict As Xojo.Core.Dictionary In Dicts
		      If Not Dict.HasAllKeys("ItemClassString", "Quantity") Then
		        Continue
		      End If   
		      
		      Dim Quantity As Xojo.Core.Dictionary = Dict.Value("Quantity")
		      Dim ClassString As Text = Dict.Value("ItemClassString")
		      Dim StackSize As Integer = Quantity.Lookup("MaxItemQuantity", 0)
		      
		      If ClassString <> "" And ClassString.EndsWith("_C") And StackSize > 0 Then
		        Overrides.Value(ClassString) = StackSize
		      End If
		    Next
		  End If
		  
		  If GlobalMultiplier = 1.0 And Overrides.Count = 0 Then
		    Return Nil
		  End If
		  
		  Dim Config As New BeaconConfigs.StackSizes
		  Config.mGlobalMultiplier = GlobalMultiplier
		  Config.mOverrides = Overrides
		  Return Config
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Override(ClassString As Text) As Integer
		  Return Self.mOverrides.Lookup(ClassString, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Override(ClassString As Text, Assigns StackSize As Integer)
		  If StackSize <= 0 And Self.mOverrides.HasKey(ClassString) Then
		    Self.mOverrides.Remove(ClassString)
		    Self.Modified = True
		  ElseIf StackSize > 0 And Self.mOverrides.Lookup(ClassString, 0) <> StackSize Then
		    Self.mOverrides.Value(ClassString) = StackSize
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Self.mOverrides.Count - 1
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
		Private mOverrides As Xojo.Core.Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="IsImplicit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
			Name="GlobalMultiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
