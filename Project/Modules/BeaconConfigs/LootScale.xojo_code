#tag Class
Protected Class LootScale
Inherits Beacon.ConfigGroup
	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary)
		  If Dict.HasKey("Multiplier") Then
		    Self.mMultiplier = Dict.Value("Multiplier")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary)
		  Dict.Value("Multiplier") = Self.mMultiplier
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As Text
		  Return "LootScale"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Multiplier As Double)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  Self.Multiplier = Multiplier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, DiscoveredData As Xojo.Core.Dictionary, MapCompatibility As UInt64, QualityMultiplier As Double) As BeaconConfigs.LootScale
		  #Pragma Unused DiscoveredData
		  #Pragma Unused MapCompatibility
		  #Pragma Unused QualityMultiplier
		  
		  If ParsedData.HasKey("SupplyCrateLootQualityMultiplier") Then
		    Return New BeaconConfigs.LootScale(ParsedData.Value("SupplyCrateLootQualityMultiplier"))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniValues(SourceDocument As Beacon.Document) As Beacon.ConfigValue()
		  #Pragma Unused SourceDocument
		  
		  Dim Values(0) As Beacon.ConfigValue
		  Values(0) = New Beacon.ConfigValue(Beacon.ShooterGameHeader, "SupplyCrateLootQualityMultiplier", Self.mMultiplier.PrettyText)
		  Return Values
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mMultiplier As Double = 1.0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMultiplier
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mMultiplier <> Value Then
			    Self.mMultiplier = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Multiplier As Double
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
			Name="Multiplier"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
