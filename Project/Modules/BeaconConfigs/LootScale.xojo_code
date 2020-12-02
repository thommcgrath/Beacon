#tag Class
Protected Class LootScale
Inherits Beacon.ConfigGroup
	#tag Event
		Sub GameIniValues(SourceDocument As Beacon.Document, Values() As Beacon.ConfigValue, Profile As Beacon.ServerProfile)
		  #Pragma Unused Profile
		  #Pragma Unused SourceDocument
		  
		  If App.IdentityManager.CurrentIdentity.IsBanned Then
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "SupplyCrateLootQualityMultiplier", "0.001"))
		  Else
		    Values.Add(New Beacon.ConfigValue(Beacon.ShooterGameHeader, "SupplyCrateLootQualityMultiplier", Self.mMultiplier.PrettyText))
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReadDictionary(Dict As Dictionary, Identity As Beacon.Identity, Document As Beacon.Document)
		  #Pragma Unused Identity
		  #Pragma Unused Document
		  
		  If Dict.HasKey("Multiplier") Then
		    Self.mMultiplier = Dict.Value("Multiplier")
		  End If
		  
		  If Self.mMultiplier <> 1.0 And Dict.Lookup("App Version", 40) < Self.DiscardBeforeVersion Then
		    App.Log("Discarding loot scale config because saved version " + App.NonReleaseVersion.ToString + " < " + Self.DiscardBeforeVersion.ToString + ".")
		    
		    #if TargetDesktop
		      // This has been made thread safe
		      BeaconUI.ShowAlert("Loot Quality Scale of " + Self.mMultiplier.ToString(Locale.Current, ",##0%") + " has been reset to default.", "Since the last time you used this file, Beacon's quality formulas have changed. To prevent unintended quality changes, Beacon has reset your Loot Quality Scale. You are welcome to set it back to " + Self.mMultiplier.ToString(Locale.Current, ",##0%") + " if you like, but you may find that value to be too high or low for the new quality values.")
		    #endif
		    
		    Self.mMultiplier = 1.0
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteDictionary(Dict As Dictionary, Document As Beacon.Document)
		  #Pragma Unused Document
		  
		  Dict.Value("Multiplier") = Self.mMultiplier
		  Dict.Value("App Version") = App.BuildNumber
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function ConfigName() As String
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
		Shared Function FromImport(ParsedData As Dictionary, CommandLineOptions As Dictionary, MapCompatibility As UInt64, Difficulty As BeaconConfigs.Difficulty, Mods As Beacon.StringList) As BeaconConfigs.LootScale
		  #Pragma Unused CommandLineOptions
		  #Pragma Unused MapCompatibility
		  #Pragma Unused Difficulty
		  #Pragma Unused Mods
		  
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


	#tag Constant, Name = DiscardBeforeVersion, Type = Double, Dynamic = False, Default = \"10209300", Scope = Private
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
