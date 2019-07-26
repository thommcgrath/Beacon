#tag Class
Protected Class LootScale
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  Values.Append(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "SupplyCrateLootQualityMultiplier", Self.mMultiplier.PrettyText))
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Xojo.Core.Dictionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  If Dict.Lookup("App Version", 40) < Self.DiscardBeforeVersion Then
		    App.Log("Discarding loot scale config because saved version " + App.NonReleaseVersion.ToText + " < " + Self.DiscardBeforeVersion.ToText + ".")
		    Self.mMultiplier = 1.0
		    Return
		  End If
		  
		  If Dict.HasKey("Multiplier") Then
		    Self.mMultiplier = Dict.Value("Multiplier")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Xojo.Core.DIctionary, Identity As Beacon.Identity)
		  #Pragma Unused Identity
		  
		  Dict.Value("Multiplier") = Self.mMultiplier
		  Dict.Value("App Version") = App.BuildNumber
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
		Shared Function FromImport(ParsedData As Xojo.Core.Dictionary, CommandLineOptions As Xojo.Core.Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty) As BeaconConfigs.LootScale
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  
		  If ParsedData.HasKey("SupplyCrateLootQualityMultiplier") Then
		    Return New BeaconConfigs.LootScale(ParsedData.DoubleValue("SupplyCrateLootQualityMultiplier"))
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequiresOmni() As Boolean
		  Return False
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


	#tag Constant, Name = DiscardBeforeVersion, Type = Double, Dynamic = False, Default = \"40", Scope = Private
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
			Name="Multiplier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
