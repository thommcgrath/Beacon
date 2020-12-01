#tag Class
Protected Class PresetEntry
Inherits Beacon.SetEntry
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  Self.mAvailability = Beacon.Maps.UniversalMask
		  Self.mRespectQualityModifier = True
		  Self.mRespectQuantityMultiplier = True
		  Self.mRespectBlueprintMultiplier = True
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
		  Self.mRespectQualityModifier = Source.mRespectQualityModifier
		  Self.mRespectQuantityMultiplier = Source.mRespectQuantityMultiplier
		  Self.mRespectBlueprintMultiplier = Source.mRespectBlueprintMultiplier
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
		Shared Function FromSaveData(Dict As Dictionary) As Beacon.PresetEntry
		  Var SetEntry As Beacon.SetEntry = Beacon.SetEntry.FromSaveData(Dict)
		  If SetEntry = Nil Then
		    Return Nil
		  End If
		  
		  Var Entry As New Beacon.PresetEntry(SetEntry)
		  Entry.mAvailability = Dict.Lookup("Availability", Entry.mAvailability)
		  Entry.mRespectQualityModifier = Dict.Lookup("RespectQualityModifier", Entry.mRespectQualityModifier)
		  Entry.mRespectQuantityMultiplier = Dict.Lookup("RespectQuantityMultiplier", Entry.mRespectQuantityMultiplier)
		  Entry.mRespectBlueprintMultiplier = Dict.Lookup("RespectBlueprintMultiplier", Entry.mRespectBlueprintMultiplier)
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectBlueprintMultiplier() As Boolean
		  Return Self.mRespectBlueprintMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectBlueprintMultiplier(Assigns Value As Boolean)
		  Self.mRespectBlueprintMultiplier = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectQualityModifier() As Boolean
		  Return Self.mRespectQualityModifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectQualityModifier(Assigns Value As Boolean)
		  Self.mRespectQualityModifier = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RespectQuantityMultiplier() As Boolean
		  Return Self.mRespectQuantityMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RespectQuantityMultiplier(Assigns Value As Boolean)
		  Self.mRespectQuantityMultiplier = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary
		  // Calling the overridden superclass method.
		  Var Dict As Dictionary = Super.SaveData
		  Dict.Value("Availability") = Self.mAvailability
		  Dict.Value("RespectQualityModifier") = Self.mRespectQualityModifier
		  Dict.Value("RespectQuantityMultiplier") = Self.mRespectQuantityMultiplier
		  Dict.Value("RespectBlueprintMultiplier") = Self.mRespectBlueprintMultiplier
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Self.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Map As Beacon.Map, Assigns Value As Boolean)
		  Self.ValidForMask(Map.Mask) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Mask As UInt64) As Boolean
		  Return (Self.mAvailability And Mask) > CType(0, UInt64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMask(Mask As UInt64, Assigns Value As Boolean)
		  If Value Then
		    Self.mAvailability = Self.mAvailability Or Mask
		  Else
		    Self.mAvailability = Self.mAvailability And Not Mask
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRespectBlueprintMultiplier As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRespectQualityModifier As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRespectQuantityMultiplier As Boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="RawWeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ChanceToBeBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ForceBlueprint"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxQuantity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuantity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
