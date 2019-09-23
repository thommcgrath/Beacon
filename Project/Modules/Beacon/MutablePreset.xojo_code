#tag Class
Protected Class MutablePreset
Inherits Beacon.Preset
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.PresetEntry)
		  Self.mContents.AddRow(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintMultiplier(Modifier As Beacon.PresetModifier, Assigns Value As Double)
		  Self.BlueprintMultiplier(Modifier.ModifierID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintMultiplier(ModifierID As String, Assigns Value As Double)
		  If Self.mModifierValues = Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  Dict.Value("Blueprint") = Value
		  Self.mModifierValues.Value(ModifierID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearModifier(Modifier As Beacon.PresetModifier)
		  Self.ClearModifier(Modifier.ModifierID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearModifier(ModifierID As String)
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
		Sub Grouping(Assigns Value As String)
		  Self.mGrouping = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.PresetEntry)
		  Self.mContents.AddRowAt(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxItems(Assigns Value As Integer)
		  Self.mMaxItems = Max(Value, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityModifier(Modifier As Beacon.PresetModifier, Assigns Value As Integer)
		  Self.MaxQualityModifier(Modifier.ModifierID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityModifier(ModifierID As String, Assigns Value As Integer)
		  If Self.mModifierValues = Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  Dict.Value("MaxQuality") = Value
		  Self.mModifierValues.Value(ModifierID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinItems(Assigns Value As Integer)
		  Self.mMinItems = Max(Value, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityModifier(Modifier As Beacon.PresetModifier, Assigns Value As Integer)
		  Self.MinQualityModifier(Modifier.ModifierID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityModifier(ModifierID As String, Assigns Value As Integer)
		  If Self.mModifierValues = Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  Dict.Value("MinQuality") = Value
		  Self.mModifierValues.Value(ModifierID) = Dict
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
		Sub QuantityMultiplier(Modifier As Beacon.PresetModifier, Assigns Value As Double)
		  Self.QuantityMultiplier(Modifier.ModifierID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(ModifierID As String, Assigns Value As Double)
		  If Self.mModifierValues = Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Dim Dict As Dictionary = Self.mModifierValues.Lookup(ModifierID, New Dictionary)
		  Dict.Value("Quantity") = Value
		  Self.mModifierValues.Value(ModifierID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mContents.RemoveRowAt(Index)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
