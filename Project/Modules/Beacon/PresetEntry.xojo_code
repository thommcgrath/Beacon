#tag Class
Protected Class PresetEntry
Inherits Beacon.SetEntry
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From SetEntry
		  // Constructor(Source As Beacon.SetEntry) -- From SetEntry
		  Super.Constructor
		  Self.ValidForIsland = True
		  Self.ValidForScorched = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.PresetEntry)
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From SetEntry
		  // Constructor(Source As Beacon.SetEntry) -- From SetEntry
		  Super.Constructor(Source)
		  Self.ValidForIsland = Source.ValidForIsland
		  Self.ValidForScorched = Source.ValidForScorched
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.SetEntry)
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From SetEntry
		  // Constructor(Source As Beacon.SetEntry) -- From SetEntry
		  Super.Constructor(Source)
		  
		  Self.ValidForIsland = False
		  Self.ValidForScorched = False
		  
		  For Each Option As Beacon.SetEntryOption In Self
		    Self.ValidForIsland = Self.ValidForIsland Or Option.Engram.AvailableTo(Beacon.LootSource.Packages.Island)
		    Self.ValidForScorched = Self.ValidForScorched Or Option.Engram.AvailableTo(Beacon.LootSource.Packages.Scorched)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		ValidForIsland As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ValidForScorched As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ChanceToBeBlueprint"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ForceBlueprint"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxQuality"
			Group="Behavior"
			Type="Beacon.Qualities"
			EditorType="Enum"
			#tag EnumValues
				"0 - Primitive"
				"1 - Ramshackle"
				"2 - Apprentice"
				"3 - Journeyman"
				"4 - Mastercraft"
				"5 - Ascendant"
				"6 - AscendantPlus"
				"7 - AscendantPlusPlus"
				"8 - AscendantPlusPlusPlus"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxQuantity"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuality"
			Group="Behavior"
			Type="Beacon.Qualities"
			EditorType="Enum"
			#tag EnumValues
				"0 - Primitive"
				"1 - Ramshackle"
				"2 - Apprentice"
				"3 - Journeyman"
				"4 - Mastercraft"
				"5 - Ascendant"
				"6 - AscendantPlus"
				"7 - AscendantPlusPlus"
				"8 - AscendantPlusPlusPlus"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuantity"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidForIsland"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidForScorched"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Weight"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
