#tag Class
Protected Class SetEntry
Implements Ark.Countable
	#tag Method, Flags = &h0
		Sub Append(Item As Ark.ItemClass)
		  Self.mItems.Append(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinQuantity = 1
		  Self.mMaxQuantity = 1
		  Self.mMinQuality = 3
		  Self.mMaxQuality = 10
		  Self.mChanceToBeBlueprint = 0.1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.SetEntry)
		  Self.Constructor()
		  
		  Redim Self.mItems(UBound(Source.mItems))
		  
		  Self.mChanceToBeBlueprint = Source.mChanceToBeBlueprint
		  Self.mMaxQuality = Source.mMaxQuality
		  Self.mMaxQuantity = Source.mMaxQuantity
		  Self.mMinQuality = Source.mMinQuality
		  Self.mMinQuantity = Source.mMinQuantity
		  Self.mWeight = Source.mWeight
		  
		  For I As Integer = 0 To UBound(Source.mItems)
		    Self.mItems(I) = New Ark.ItemClass(Source.mItems(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mItems) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Ark.SetEntryIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Import(Dict As Xojo.Core.Dictionary) As Ark.SetEntry
		  // (EntryWeight=1.000000,ItemClassStrings=("PrimalItemStructure_ThatchFloor_C"),ItemsWeights=(1.000000),MinQuantity=1,MaxQuantity=16,MinQuality=1.000000,MaxQuality=1.000000,bForceBlueprint=false,ChanceToBeBlueprintOverride=0.250000)
		  
		  Dim Entry As New Ark.SetEntry
		  Entry.Weight = Dict.Lookup("EntryWeight", Entry.Weight)
		  Entry.MinQuantity = Dict.Lookup("MinQuantity", Entry.MinQuantity)
		  Entry.MaxQuantity = Dict.Lookup("MaxQuantity", Entry.MaxQuantity)
		  Entry.MinQuality = Dict.Lookup("MinQuality", Entry.MinQuality)
		  Entry.MaxQuality = Dict.Lookup("MaxQuality", Entry.MaxQuality)
		  Entry.ChanceToBeBlueprint = Dict.Lookup("ChanceToBeBlueprintOverride", Entry.ChanceToBeBlueprint)
		  
		  Dim ClassStrings() As Auto = Dict.Value("ItemClassStrings")
		  Dim ClassWeights() As Auto = Dict.Value("ItemsWeights")
		  
		  For I As Integer = 0 To UBound(ClassStrings)
		    Entry.Append(New Ark.ItemClass(ClassStrings(I), ClassWeights(I)))
		  Next
		  
		  Return Entry
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Ark.ItemClass) As Integer
		  For I As Integer = 0 To UBound(Self.mItems)
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Ark.ItemClass)
		  Self.mItems.Insert(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Join(Entries() As Ark.SetEntry, Separator As Text) As Text
		  Dim Values() As Text
		  For Each Entry As Ark.SetEntry In Entries
		    Values.Append(Entry.TextValue)
		  Next
		  Return Text.Join(Values, ",")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mItems(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Ark.ItemClass
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As Ark.ItemClass)
		  Self.mItems(Index) = Item
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextValue() As Text
		  Dim Classes(), Weights() As Text
		  Redim Classes(UBound(Self.mItems))
		  Redim Weights(UBound(Self.mItems))
		  For I As Integer = 0 To UBound(Self.mItems)
		    Classes(I) = Self.mItems(I).ClassString
		    Weights(I) = Self.mItems(I).Weight.ToText
		  Next
		  
		  Dim Values() As Text
		  Values.Append("EntryWeight=" + Self.mWeight.ToText)
		  Values.Append("ItemClassStrings=(""" + Text.Join(Classes, """,""") + """)")
		  Values.Append("ItemsWeights=(" + Text.Join(Weights, ",") + ")")
		  Values.Append("MinQuantity=" + Self.mMinQuantity.ToText)
		  Values.Append("MaxQuantity=" + Self.mMaxQuantity.ToText)
		  Values.Append("MinQuality=" + Self.mMinQuality.ToText)
		  Values.Append("MaxQuality=" + Self.mMaxQuality.ToText)
		  Values.Append("bForceBlueprint=" + if(Self.ForceBlueprint, "true", "false"))
		  Values.Append("ChanceToBeBlueprintOverride=" + Self.mChanceToBeBlueprint.ToText)
		  Return "(" + Text.Join(Values, ",") + ")"
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mChanceToBeBlueprint
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mChanceToBeBlueprint = Max(Min(Value, 1), 0)
			End Set
		#tag EndSetter
		ChanceToBeBlueprint As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mChanceToBeBlueprint >= 1.0
			End Get
		#tag EndGetter
		ForceBlueprint As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMaxQuality
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMaxQuality = Max(Value, 1)
			End Set
		#tag EndSetter
		MaxQuality As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMaxQuantity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMaxQuantity = Max(Value, 1)
			End Set
		#tag EndSetter
		MaxQuantity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mChanceToBeBlueprint As Double = 0.1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinQuality
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMinQuality = Max(Value, 1)
			End Set
		#tag EndSetter
		MinQuality As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinQuantity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMinQuantity = Max(Value, 1)
			End Set
		#tag EndSetter
		MinQuantity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItems() As Ark.ItemClass
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxQuality As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinQuality As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinQuantity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeight As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mWeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mWeight = Max(Min(Value, 1), 0)
			End Set
		#tag EndSetter
		Weight As Double
	#tag EndComputedProperty


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
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxQuantity"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinQuality"
			Group="Behavior"
			Type="Double"
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
