#tag Class
Protected Class MutablePreset
Inherits Beacon.Preset
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.PresetEntry)
		  Self.mContents.Append(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearModifier(Modifier As Beacon.PresetModifier)
		  Self.ClearModifier(Modifier.ModifierID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearModifier(ModifierID As Text)
		  If Self.mModifierValues <> Nil And Self.mModifierValues.HasKey(ModifierID) Then
		    Self.mModifierValues.Remove(ModifierID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Entry(Index As Integer) As Beacon.PresetEntry
		  Return Self.mContents(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entry(Index As Integer, Assigns Item As Beacon.PresetEntry)
		  Self.mContents(Index) = Item
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Grouping(Assigns Value As Text)
		  Self.mGrouping = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.PresetEntry)
		  Self.mContents.Insert(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As Text)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItems(Assigns Value As Integer)
		  Self.mMaxItems = Max(Value, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItems(Assigns Value As Integer)
		  Self.mMinItems = Max(Value, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(NewBound As Integer)
		  Redim Self.mContents(NewBound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.PresetEntry
		  Return Self.mContents(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As Beacon.PresetEntry)
		  Self.mContents(Index) = Item
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QualityModifier(Modifier As Beacon.PresetModifier, Assigns Value As Integer)
		  Self.QualityModifier(Modifier.ModifierID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QualityModifier(ModifierID As Text, Assigns Value As Integer)
		  If Self.mModifierValues = Nil Then
		    Self.mModifierValues = New Xojo.Core.Dictionary
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Self.mModifierValues.Lookup(ModifierID, New Xojo.Core.Dictionary)
		  Dict.Value("Quality") = Value
		  Self.mModifierValues.Value(ModifierID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(Modifier As Beacon.PresetModifier, Assigns Value As Double)
		  Self.QuantityMultiplier(Modifier.ModifierID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(ModifierID As Text, Assigns Value As Double)
		  If Self.mModifierValues = Nil Then
		    Self.mModifierValues = New Xojo.Core.Dictionary
		  End If
		  
		  Dim Dict As Xojo.Core.Dictionary = Self.mModifierValues.Lookup(ModifierID, New Xojo.Core.Dictionary)
		  Dict.Value("Quantity") = Value
		  Self.mModifierValues.Value(ModifierID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mContents.Remove(Index)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
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
			Name="Type"
			Group="Behavior"
			Type="Beacon.Preset.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - BuiltIn"
				"1 - Custom"
				"2 - CustomizedBuiltIn"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
