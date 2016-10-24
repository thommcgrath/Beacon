#tag Class
Protected Class MutablePreset
Inherits Beacon.Preset
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.PresetEntry)
		  Self.mContents.Append(Item)
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
		Sub QualityModifier(Kind As Beacon.LootSource.Kinds, Assigns Value As Integer)
		  Select Case Kind
		  Case Beacon.LootSource.Kinds.Standard
		    Self.mQualityModifierStandard = Value
		  Case Beacon.LootSource.Kinds.Bonus
		    Self.mQualityModifierBonus = Value
		  Case Beacon.LootSource.Kinds.Cave
		    Self.mQualityModifierCave = Value
		  Case Beacon.LootSource.Kinds.Sea
		    Self.mQualityModifierSea = Value
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(Kind As Beacon.LootSource.Kinds, Assigns Value As Double)
		  Select Case Kind
		  Case Beacon.LootSource.Kinds.Standard
		    Self.mQuantityMultiplierStandard = Value
		  Case Beacon.LootSource.Kinds.Bonus
		    Self.mQuantityMultiplierBonus = Value
		  Case Beacon.LootSource.Kinds.Cave
		    Self.mQuantityMultiplierCave = Value
		  Case Beacon.LootSource.Kinds.Sea
		    Self.mQuantityMultiplierSea = Value
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mContents.Remove(Index)
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Custom"
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
	#tag EndViewBehavior
End Class
#tag EndClass
