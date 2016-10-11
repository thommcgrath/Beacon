#tag Class
Protected Class LootSource
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Sub Append(Item As Beacon.ItemSet)
		  Self.mItems.Append(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinItemSets = 1
		  Self.mMaxItemSets = 3
		  Self.mNumItemSetsPower = 1.0
		  Self.mSetsRandomWithoutReplacement = True
		  Self.mMultipliers = New Beacon.Range(1, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.LootSource)
		  Self.Constructor()
		  
		  Redim Self.mItems(UBound(Source.mItems))
		  
		  Self.mMaxItemSets = Source.mMaxItemSets
		  Self.mMinItemSets = Source.mMinItemSets
		  Self.mNumItemSetsPower = Source.mNumItemSetsPower
		  Self.mSetsRandomWithoutReplacement = Source.mSetsRandomWithoutReplacement
		  Self.mType = Source.mType
		  Self.mLabel = Source.mLabel
		  Self.mMultipliers = New Beacon.Range(Source.mMultipliers.Min, Source.mMultipliers.Max)
		  
		  For I As Integer = 0 To UBound(Source.mItems)
		    Self.mItems(I) = New Beacon.ItemSet(Source.mItems(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Label As Text, Type As Text)
		  Self.Constructor()
		  Self.mType = Type
		  Self.mLabel = Label
		  Self.mMultipliers = Beacon.Data.MultipliersForLootSource(Type)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mItems) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Set As Beacon.ItemSet In Self.mItems
		    Children.Append(Set.Export)
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("ItemSets") = Children
		  Keys.Value("Label") = Self.Label
		  Keys.Value("MaxItemSets") = Self.MaxItemSets
		  Keys.Value("MinItemSets") = Self.MinItemSets
		  Keys.Value("NumItemSetsPower") = Self.NumItemSetsPower
		  Keys.Value("bSetsRandomWithoutReplacement") = Self.SetsRandomWithoutReplacement
		  Keys.Value("SupplyCrateClassString") = Self.Type
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.LootSourceIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Xojo.Core.Dictionary) As Beacon.LootSource
		  // This could be a beacon save or a config line
		  
		  Dim LootSource As New Beacon.LootSource
		  If Dict.HasKey("SupplyCrateClassString") Then
		    LootSource.Type = Dict.Value("SupplyCrateClassString")
		  Else
		    LootSource.Type = Dict.Value("Type")
		  End If
		  
		  If Dict.HasKey("Label") Then
		    LootSource.Label = Dict.Value("Label")
		  End If
		  
		  LootSource.MaxItemSets = Dict.Lookup("MaxItemSets", LootSource.MaxItemSets)
		  LootSource.MinItemSets = Dict.Lookup("MinItemSets", LootSource.MinItemSets)
		  LootSource.NumItemSetsPower = Dict.Lookup("NumItemSetsPower", LootSource.NumItemSetsPower)
		  
		  If Dict.HasKey("bSetsRandomWithoutReplacement") Then
		    LootSource.SetsRandomWithoutReplacement = Dict.Value("bSetsRandomWithoutReplacement")
		  Else
		    LootSource.SetsRandomWithoutReplacement = Dict.Lookup("SetsRandomWithoutReplacement", LootSource.SetsRandomWithoutReplacement)
		  End If
		  
		  Dim Children() As Auto
		  If Dict.HasKey("ItemSets") Then
		    Children = Dict.Value("ItemSets")
		  Else
		    Children = Dict.Value("Items")
		  End If
		  
		  For Each Child As Xojo.Core.Dictionary In Children
		    Dim Set As Beacon.ItemSet = Beacon.ItemSet.Import(Child, LootSource)
		    If Set <> Nil Then
		      LootSource.Append(Set)
		    End If
		  Next
		  
		  Return LootSource
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Beacon.ItemSet) As Integer
		  For I As Integer = 0 To UBound(Self.mItems)
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Beacon.ItemSet)
		  Self.mItems.Insert(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsScorchedEarth() As Boolean
		  Return Self.mType.Right(16) = "_ScorchedEarth_C" Or Self.mType.Right(5) = "_SE_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Kind() As Beacon.LootSource.Kinds
		  If Self.mType.IndexOf("Cave") > -1 Or Self.mType.IndexOf("ArtifactCrate") > -1 Then
		    Return Beacon.LootSource.Kinds.Cave
		  ElseIf Self.mType.IndexOf("Ocean") > -1 Then
		    Return Beacon.LootSource.Kinds.Sea
		  ElseIf Self.mType.IndexOf("_Double_") > -1 Then
		    Return Beacon.LootSource.Kinds.Bonus
		  Else
		    Return Beacon.LootSource.Kinds.Standard
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Multipliers() As Beacon.Range
		  Return Self.mMultipliers
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.LootSource) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Return Self.mType.Compare(Other.mType, Text.CompareCaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mItems(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.ItemSet
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Value As Beacon.ItemSet)
		  Self.mItems(Index) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mItems.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextValue() As Text
		  Dim Values() As Text
		  Values.Append("SupplyCrateClassString=""" + Self.mType + """")
		  Values.Append("MinItemSets=" + Self.mMinItemSets.ToText)
		  Values.Append("MaxItemSets=" + Self.mMaxItemSets.ToText)
		  Values.Append("NumItemSetsPower=" + Self.mNumItemSetsPower.ToText)
		  Values.Append("bSetsRandomWithoutReplacement=" + if(Self.mSetsRandomWithoutReplacement, "true", "false"))
		  Values.Append("ItemSets=(" + Beacon.ItemSet.Join(Self.mItems, ",", Self.Multipliers) + ")")
		  Return "(" + Text.Join(Values, ",") + ")"
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mLabel <> "" Then
			    Return Self.mLabel
			  Else
			    Return Self.mType
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mLabel = Value
			End Set
		#tag EndSetter
		Label As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMaxItemSets
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMaxItemSets = Max(Value, 1)
			End Set
		#tag EndSetter
		MaxItemSets As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinItemSets
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMinItemSets = Max(Value, 1)
			End Set
		#tag EndSetter
		MinItemSets As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItems() As Beacon.ItemSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinItemSets As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultipliers As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumItemSetsPower As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetsRandomWithoutReplacement As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNumItemSetsPower
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mNumItemSetsPower = Max(Value, 0)
			End Set
		#tag EndSetter
		NumItemSetsPower As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSetsRandomWithoutReplacement
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSetsRandomWithoutReplacement = Value
			End Set
		#tag EndSetter
		SetsRandomWithoutReplacement As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mType = Value
			  Self.mMultipliers = Beacon.Data.MultipliersForLootSource(Value)
			End Set
		#tag EndSetter
		Type As Text
	#tag EndComputedProperty


	#tag Enum, Name = Kinds, Type = Integer, Flags = &h0
		Standard
		  Bonus
		  Cave
		Sea
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Label"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxItemSets"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinItemSets"
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
			Name="NumItemSetsPower"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SetsRandomWithoutReplacement"
			Group="Behavior"
			Type="Boolean"
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
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
