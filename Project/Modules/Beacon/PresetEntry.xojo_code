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
		  Self.mAvailability = Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Island) Or Beacon.LootSource.PackageToInteger(Beacon.LootSource.Packages.Scorched)
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
		  Self.mAvailability = Source.mAvailability
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
		  
		  Self.mAvailability = 0
		  For Each Option As Beacon.SetEntryOption In Self
		    Self.mAvailability = Self.mAvailability Or Option.Engram.Availability
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForPackage(Package As Beacon.LootSource.Packages) As Boolean
		  Dim Value As Integer = Beacon.LootSource.PackageToInteger(Package)
		  Return (Self.mAvailability And Value) = Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForPackage(Package As Beacon.LootSource.Packages, Assigns Value As Boolean)
		  If Value Then
		    Self.mAvailability = Self.mAvailability Or Beacon.LootSource.PackageToInteger(Package)
		  Else
		    Self.mAvailability = Self.mAvailability And Not Beacon.LootSource.PackageToInteger(Package)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAvailability As Integer
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
