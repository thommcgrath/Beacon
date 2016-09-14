#tag Class
Protected Class Beacon
Implements Ark.Countable
	#tag Method, Flags = &h0
		Sub Append(Item As Ark.ItemSet)
		  Self.mItems.Append(Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinItemSets = 1
		  Self.mMaxItemSets = 3
		  Self.mNumItemSetsPower = 1.0
		  Self.mSetsRandomWithoutReplacement = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.Beacon)
		  Self.Constructor()
		  
		  Redim Self.mItems(UBound(Source.mItems))
		  
		  Self.mMaxItemSets = Source.mMaxItemSets
		  Self.mMinItemSets = Source.mMinItemSets
		  Self.mNumItemSetsPower = Source.mNumItemSetsPower
		  Self.mSetsRandomWithoutReplacement = Source.mSetsRandomWithoutReplacement
		  Self.mType = Source.mType
		  Self.mLabel = Source.mLabel
		  
		  For I As Integer = 0 To UBound(Source.mItems)
		    Self.mItems(I) = New Ark.ItemSet(Source.mItems(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Label As Text, Type As Text)
		  Self.Constructor()
		  Self.mType = Type
		  Self.mLabel = Label
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mItems) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Ark.BeaconIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Import(Dict As Xojo.Core.Dictionary) As Ark.Beacon
		  If Not Dict.HasKey("SupplyCrateClassString") Then
		    Return Nil
		  End If
		  
		  Dim Type As Text = Dict.Value("SupplyCrateClassString")
		  Dim Beacon As New Ark.Beacon("", Type)
		  Beacon.MaxItemSets = Dict.Lookup("MaxItemSets", Beacon.MaxItemSets)
		  Beacon.MinItemSets = Dict.Lookup("MinItemSets", Beacon.MinItemSets)
		  Beacon.NumItemSetsPower = Dict.Lookup("NumItemSetsPower", Beacon.NumItemSetsPower)
		  Beacon.SetsRandomWithoutReplacement = Dict.Lookup("bSetsRandomWithoutReplacement", Beacon.SetsRandomWithoutReplacement)
		  
		  Dim Children() As Auto = Dict.Value("ItemSets")
		  For Each Child As Xojo.Core.Dictionary In Children
		    Dim Set As Ark.ItemSet = Ark.ItemSet.Import(Child)
		    If Set <> Nil Then
		      Beacon.Append(Set)
		    End If
		  Next
		  
		  Return Beacon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As Ark.ItemSet) As Integer
		  For I As Integer = 0 To UBound(Self.mItems)
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As Ark.ItemSet)
		  Self.mItems.Insert(Index, Item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBonus() As Boolean
		  Return InStr(Self.mType, "_Double_") > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsScorchedEarth() As Boolean
		  Return Right(Self.mType, 16) = "_ScorchedEarth_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.Beacon) As Integer
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
		Function Operator_Subscript(Index As Integer) As Ark.ItemSet
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Value As Ark.ItemSet)
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
		  Values.Append("ItemSets=(" + Ark.ItemSet.Join(Self.mItems, ",") + ")")
		  Return "(" + Text.Join(Values, ",") + ")"
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLabel
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
		Private mItems() As Ark.ItemSet
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
			End Set
		#tag EndSetter
		Type As Text
	#tag EndComputedProperty


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
