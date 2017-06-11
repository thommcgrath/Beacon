#tag Class
Protected Class ItemSet
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Sub Append(Entry As Beacon.SetEntry)
		  Self.mEntries.Append(Entry)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mMinNumItems = 1
		  Self.mMaxNumItems = 3
		  Self.mNumItemsPower = 1
		  Self.mSetWeight = 0.5
		  Self.mItemsRandomWithoutReplacement = True
		  Self.mLabel = "Untitled Item Set"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ItemSet)
		  Self.Constructor()
		  
		  Redim Self.mEntries(UBound(Source.mEntries))
		  
		  Self.mItemsRandomWithoutReplacement = Source.mItemsRandomWithoutReplacement
		  Self.mMaxNumItems = Source.mMaxNumItems
		  Self.mMinNumItems = Source.mMinNumItems
		  Self.mNumItemsPower = Source.mNumItemsPower
		  Self.mSetWeight = Source.mSetWeight
		  Self.mLabel = Source.mLabel
		  Self.mSourcePresetID = Source.mSourcePresetID
		  
		  For I As Integer = 0 To UBound(Source.mEntries)
		    Self.mEntries(I) = New Beacon.SetEntry(Source.mEntries(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return UBound(Self.mEntries) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Children() As Xojo.Core.Dictionary
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    Children.Append(Entry.Export)
		  Next
		  
		  Dim Keys As New Xojo.Core.Dictionary
		  Keys.Value("ItemEntries") = Children
		  Keys.Value("bItemsRandomWithoutReplacement") = Self.ItemsRandomWithoutReplacement
		  Keys.Value("Label") = Self.Label // Write "Label" so older versions of Beacon can read it
		  Keys.Value("MaxNumItems") = Self.MaxNumItems
		  Keys.Value("MinNumItems") = Self.MinNumItems
		  Keys.Value("NumItemsPower") = Self.NumItemsPower
		  Keys.Value("SetWeight") = Self.Weight
		  If Self.SourcePresetID <> "" Then
		    Keys.Value("SourcePresetID") = Self.SourcePresetID
		  End If
		  Return Keys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromPreset(Preset As Beacon.Preset, ForLootSource As Beacon.LootSource) As Beacon.ItemSet
		  Dim Set As New Beacon.ItemSet
		  Set.Label = Preset.Label
		  Set.MinNumItems = Preset.MinItems
		  Set.MaxNumItems = Preset.MaxItems
		  // Weight is intentionally skipped, as that is relative to the source, no reason for a preset to alter that.
		  Set.mSourcePresetID = Preset.PresetID
		  
		  Dim QuantityMultiplier As Double = Preset.QuantityMultiplier(ForLootSource.Kind)
		  Dim QualityModifier As Integer = Preset.QualityModifier(ForLootSource.Kind)
		  
		  For Each Entry As Beacon.PresetEntry In Preset
		    If Not Entry.ValidForPackage(ForLootSource.Package) Then
		      Continue
		    End If
		    
		    Dim EntryQuantityMultiplier As Double = If(Entry.RespectQuantityMultiplier, QuantityMultiplier, 1)
		    Dim EntryQualityModifier As Integer = If(Entry.RespectQualityModifier, QualityModifier, 0)
		    
		    Dim MinQuality As Integer = Max(Min(CType(Entry.MinQuality, Integer) + EntryQualityModifier, 8), 0)
		    Dim MaxQuality As Integer = Max(Min(CType(Entry.MaxQuality, Integer) + EntryQualityModifier, 8), 0)
		    
		    Entry.MinQuantity = Round(Entry.MinQuantity * EntryQuantityMultiplier)
		    Entry.MaxQuantity = Round(Entry.MaxQuantity * EntryQuantityMultiplier)
		    Entry.MinQuality = CType(MinQuality, Beacon.Qualities)
		    Entry.MaxQuality = CType(MaxQuality, Beacon.Qualities)
		    
		    Set.Append(New Beacon.SetEntry(Entry))
		  Next
		  
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  Return New Beacon.ItemSetIterator(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hash() As Text
		  Dim Entries() As Text
		  Redim Entries(UBound(Self.mEntries))
		  For I As Integer = 0 To UBound(Entries)
		    Entries(I) = Self.mEntries(I).Hash
		  Next
		  Entries.Sort
		  
		  Dim Locale As Xojo.Core.Locale = Xojo.Core.Locale.Raw
		  Dim Format As Text = "0.000"
		  
		  Dim Parts(5) As Text
		  Parts(0) = Beacon.MD5(Text.Join(Entries, ",")).Lowercase
		  Parts(1) = if(Self.ItemsRandomWithoutReplacement, "1", "0")
		  Parts(2) = Self.MaxNumItems.ToText(Locale, Format)
		  Parts(3) = Self.MinNumItems.ToText(Locale, Format)
		  Parts(4) = Self.NumItemsPower.ToText(Locale, Format)
		  Parts(5) = Self.Weight.ToText(Locale, Format)
		  
		  Return Beacon.MD5(Text.Join(Parts, ",")).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(Dict As Xojo.Core.Dictionary, Source As Beacon.LootSource) As Beacon.ItemSet
		  Dim Set As New Beacon.ItemSet
		  Set.MinNumItems = Dict.Lookup("MinNumItems", Set.MinNumItems)
		  Set.MaxNumItems = Dict.Lookup("MaxNumItems", Set.MaxNumItems)
		  Set.NumItemsPower = Dict.Lookup("NumItemsPower", Set.NumItemsPower)
		  If Dict.HasKey("SetWeight") Then
		    Set.Weight = Dict.Value("SetWeight")
		  Else
		    Set.Weight = Dict.Lookup("Weight", Set.Weight)
		  End If
		  If Dict.HasKey("bItemsRandomWithoutReplacement") Then
		    Set.ItemsRandomWithoutReplacement = Dict.Value("bItemsRandomWithoutReplacement")
		  Else
		    Set.ItemsRandomWithoutReplacement = Dict.Lookup("ItemsRandomWithoutReplacement", Set.ItemsRandomWithoutReplacement)
		  End If
		  If Dict.HasKey("SetName") Then
		    Set.Label = Dict.Value("SetName")
		  ElseIf Dict.HasKey("Label") Then
		    Set.Label = Dict.Value("Label")
		  End If
		  
		  Dim Children() As Auto
		  If Dict.HasKey("ItemEntries") Then
		    Children = Dict.Value("ItemEntries")
		  Else
		    Children = Dict.Value("Items")
		  End If
		  For Each Child As Xojo.Core.Dictionary In Children
		    Dim Entry As Beacon.SetEntry = Beacon.SetEntry.Import(Child, Source.Multipliers)
		    If Entry <> Nil Then
		      Set.Append(Entry)
		    End If
		  Next
		  
		  If Dict.HasKey("SourcePresetID") Then
		    Set.mSourcePresetID = Dict.Value("SourcePresetID")
		  End If
		  
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Beacon.SetEntry) As Integer
		  For I As Integer = 0 To UBound(Self.mEntries)
		    If Self.mEntries(I) = Entry Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Entry As Beacon.SetEntry)
		  Self.mEntries.Insert(Index, Entry)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Join(Sets() As Beacon.ItemSet, Separator As Text, Multipliers As Beacon.Range) As Text
		  Dim Values() As Text
		  For Each Set As Beacon.ItemSet In Sets
		    Values.Append(Set.TextValue(Multipliers))
		  Next
		  Return Text.Join(Values, Separator)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ItemSet) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Dim SelfHash As Text = Self.Hash
		  Dim OtherHash As Text = Other.Hash
		  
		  Return SelfHash.Compare(OtherHash, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(Bound As Integer)
		  Redim Self.mEntries(Bound)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Beacon.SetEntry
		  Return Self.mEntries(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Entry As Beacon.SetEntry)
		  Self.mEntries(Index) = Entry
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReconfigureWithPreset(Preset As Beacon.Preset, ForLootSource As Beacon.LootSource)
		  Dim Clone As Beacon.ItemSet = Beacon.ItemSet.FromPreset(Preset, ForLootSource)
		  Self.mEntries = Clone.mEntries
		  Self.mSourcePresetID = Clone.mSourcePresetID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RelativeWeight(Index As Integer) As Double
		  Return Self.mEntries(Index).Weight / Self.TotalWeight()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mEntries.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SourcePresetID() As Text
		  Return Self.mSourcePresetID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextValue(Multipliers As Beacon.Range) As Text
		  Dim Values() As Text
		  Values.Append("SetName=""" + Self.mLabel + """")
		  Values.Append("MinNumItems=" + Self.mMinNumItems.ToText)
		  Values.Append("MaxNumItems=" + Self.mMaxNumItems.ToText)
		  Values.Append("NumItemsPower=" + Self.mNumItemsPower.ToText)
		  Values.Append("SetWeight=" + Self.mSetWeight.ToText)
		  Values.Append("bItemsRandomWithoutReplacement=" + if(Self.mItemsRandomWithoutReplacement, "true", "false"))
		  Values.Append("ItemEntries=(" + Beacon.SetEntry.Join(Self.mEntries, ",", Multipliers) + ")")
		  Return "(" + Text.Join(Values, ",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeight() As Double
		  Dim Value As Double
		  For Each Entry As Beacon.SetEntry In Self.mEntries
		    Value = Value + Entry.Weight
		  Next
		  Return Value
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mItemsRandomWithoutReplacement
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mItemsRandomWithoutReplacement = Value
			End Set
		#tag EndSetter
		ItemsRandomWithoutReplacement As Boolean
	#tag EndComputedProperty

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
			  Return Self.mMaxNumItems
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMaxNumItems = Max(Value, 1)
			End Set
		#tag EndSetter
		MaxNumItems As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEntries() As Beacon.SetEntry
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinNumItems
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mMinNumItems = Max(Value, 1)
			End Set
		#tag EndSetter
		MinNumItems As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mItemsRandomWithoutReplacement As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxNumItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinNumItems As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNumItemsPower As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSetWeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourcePresetID As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNumItemsPower
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mNumItemsPower = Max(Value, 0)
			End Set
		#tag EndSetter
		NumItemsPower As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSetWeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSetWeight = Min(Max(Value, 0.0), 1.0)
			End Set
		#tag EndSetter
		Weight As Double
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
			Name="ItemsRandomWithoutReplacement"
			Group="Behavior"
			Type="Boolean"
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
			Name="MaxNumItems"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinNumItems"
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
			Name="NumItemsPower"
			Group="Behavior"
			Type="Double"
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
