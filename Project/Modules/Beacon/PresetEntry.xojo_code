#tag Class
Protected Class PresetEntry
Inherits Beacon.SetEntry
	#tag Method, Flags = &h0
		Function Availability() As Integer
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As Integer)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  Self.mAvailability = Beacon.Maps.All.Mask
		  Self.mRespectQualityModifier = True
		  Self.mRespectQuantityMultiplier = True
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
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As Xojo.Core.Dictionary = Super.Export
		  Dict.Value("Availability") = Self.mAvailability
		  Dict.Value("RespectQualityModifier") = Self.mRespectQualityModifier
		  Dict.Value("RespectQuantityMultiplier") = Self.mRespectQuantityMultiplier
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Xojo.Core.Dictionary) As Beacon.PresetEntry
		  Dim SetEntry As Beacon.SetEntry = Beacon.SetEntry.ImportFromBeacon(Dict)
		  If SetEntry = Nil Then
		    Return Nil
		  End If
		  
		  Dim Entry As New Beacon.PresetEntry(SetEntry)
		  Entry.mAvailability = Dict.Lookup("Availability", Entry.mAvailability)
		  Entry.mRespectQualityModifier = Dict.Lookup("RespectQualityModifier", Entry.mRespectQualityModifier)
		  Entry.mRespectQuantityMultiplier = Dict.Lookup("RespectQuantityMultiplier", Entry.mRespectQuantityMultiplier)
		  Return Entry
		End Function
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
		Function ValidForMap(Map As Beacon.Map) As Boolean
		  Return Map = Nil Or Map.Matches(Self.mAvailability)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Map As Beacon.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.mAvailability = Self.mAvailability Or Map.Mask
		  Else
		    Self.mAvailability = Self.mAvailability And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAvailability As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRespectQualityModifier As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRespectQuantityMultiplier As Boolean
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
			Name="MaxQuantity"
			Group="Behavior"
			Type="Integer"
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
			Name="Weight"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
