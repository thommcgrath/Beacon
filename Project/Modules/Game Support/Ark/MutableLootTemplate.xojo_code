#tag Class
Protected Class MutableLootTemplate
Inherits Ark.LootTemplate
	#tag Method, Flags = &h0
		Sub Add(Entry As Ark.LootTemplateEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.mEntries(Idx) = Entry.ImmutableVersion
		  Else
		    Self.mEntries.Add(Entry.ImmutableVersion)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddBlueprintEntries(Sources() As Ark.LootTemplateEntry) As Ark.LootTemplateEntry()
		  Var MatchingUUIDs() As String
		  For Idx As Integer = 0 To Sources.LastIndex
		    MatchingUUIDs.Add(Sources(Idx).UUID)
		  Next Idx
		  
		  Var MissingWeight, MinQualitySum, MaxQualitySum As Double
		  Var EntryCount As Double
		  Var References As New Dictionary
		  For Idx As Integer = Self.mEntries.FirstIndex To Self.mEntries.LastIndex
		    If MatchingUUIDs.IndexOf(Self.mEntries(Idx).UUID) = -1 Or Self.mEntries(Idx).ChanceToBeBlueprint = 0 Then
		      Continue
		    End If
		    
		    For Each Option As Ark.LootItemSetEntryOption In Self.mEntries(Idx)
		      If References.HasKey(Option.Reference.ObjectID) = False Then
		        References.Value(Option.Reference.ObjectID) = Option.Reference
		      End If
		    Next Option
		    
		    Var AdjustedWeight As Double = Self.mEntries(Idx).RawWeight * (1 - Self.mEntries(Idx).ChanceToBeBlueprint)
		    MissingWeight = MissingWeight + (Self.mEntries(Idx).RawWeight - AdjustedWeight)
		    
		    EntryCount = EntryCount + 1
		    MinQualitySum = MinQualitySum + Self.mEntries(Idx).MinQuality.BaseValue
		    MaxQualitySum = MaxQualitySum + Self.mEntries(Idx).MaxQuality.BaseValue
		    
		    Var Mutable As New Ark.MutableLootTemplateEntry(Self.mEntries(Idx))
		    Mutable.ChanceToBeBlueprint = 0
		    Mutable.RawWeight = AdjustedWeight
		    Mutable.RespectBlueprintChanceMultipliers = False
		    Self.mEntries(Idx) = New Ark.LootTemplateEntry(Mutable)
		  Next Idx
		  
		  Var UniqueMasks() As UInt64
		  For Each Entry As DictionaryEntry In References
		    Var Reference As Ark.BlueprintReference = Entry.Value
		    Var Engram As Ark.Engram = Ark.Engram(Reference.Resolve)
		    Var EngramMask As UInt64 = Engram.Availability
		    If UniqueMasks.IndexOf(EngramMask) = -1 Then
		      UniqueMasks.Add(EngramMask)
		    End If
		  Next Entry
		  
		  Var BlueprintEntries() As Ark.LootTemplateEntry
		  For MaskIdx As Integer = UniqueMasks.FirstIndex To UniqueMasks.LastIndex
		    Var EngramMask As UInt64 = UniqueMasks(MaskIdx)
		    Var Blueprint As New Ark.MutableLootTemplateEntry
		    Blueprint.ChanceToBeBlueprint = 1
		    Blueprint.RespectBlueprintChanceMultipliers = False
		    Blueprint.RespectQuantityMultipliers = False
		    Blueprint.Availability = EngramMask
		    Blueprint.ChanceToBeBlueprint = 1
		    Blueprint.RawWeight = MissingWeight
		    Blueprint.MinQuantity = 1
		    Blueprint.MaxQuantity = 1
		    Blueprint.MinQuality = Ark.Qualities.ForBaseValue(MinQualitySum / EntryCount)
		    Blueprint.MaxQuality = Ark.Qualities.ForBaseValue(MaxQualitySum / EntryCount)
		    Blueprint.SingleItemQuantity = True
		    For Each Entry As DictionaryEntry In References
		      Var Reference As Ark.BlueprintReference = Entry.Value
		      Var Engram As Ark.Engram = Ark.Engram(Reference.Resolve)
		      If (Engram.Availability And EngramMask) > CType(0, UInt64) Then
		        Blueprint.Add(New Ark.LootItemSetEntryOption(Engram, 10))
		      End If
		    Next Entry
		    
		    Var Immutable As New Ark.LootTemplateEntry(Blueprint)
		    Self.mEntries.Add(Immutable)
		    BlueprintEntries.Add(Immutable)
		  Next MaskIdx
		  
		  Return BlueprintEntries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintChanceMultiplier(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Double)
		  Self.BlueprintChanceMultiplier(TemplateSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintChanceMultiplier(TemplateSelectorUUID As String, Assigns Value As Double)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(TemplateSelectorUUID, New Dictionary)
		  Dict.Value(Self.ModifierBlueprintChance) = Value
		  Self.mModifierValues.Value(TemplateSelectorUUID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearSelector(TemplateSelector As Beacon.TemplateSelector)
		  Self.ClearSelector(TemplateSelector.UUID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearSelector(SelectorUUID As String)
		  If (Self.mModifierValues Is Nil) = False And Self.mModifierValues.HasKey(SelectorUUID) Then
		    Self.mModifierValues.Remove(SelectorUUID)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Grouping(Assigns Value As String)
		  Self.mGrouping = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootTemplate
		  Return New Ark.LootTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxEntriesSelected(Assigns Value As Integer)
		  Self.mMaxEntriesSelected = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityOffset(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Integer)
		  Self.MaxQualityOffset(TemplateSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityOffset(TemplateSelectorUUID As String, Assigns Value As Integer)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(TemplateSelectorUUID, New Dictionary)
		  Dict.Value(Self.ModifierMaxQuality) = Value
		  Self.mModifierValues.Value(TemplateSelectorUUID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinEntriesSelected(Assigns Value As Integer)
		  Self.mMinEntriesSelected = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityOffset(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Integer)
		  Self.MinQualityOffset(TemplateSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityOffset(TemplateSelectorUUID As String, Assigns Value As Integer)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(TemplateSelectorUUID, New Dictionary)
		  Dict.Value(Self.ModifierMinQuality) = Value
		  Self.mModifierValues.Value(TemplateSelectorUUID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootTemplate
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Idx As Integer, Assigns Value As Ark.LootTemplateEntry)
		  Self.mEntries(Idx) = Value.ImmutableVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Double)
		  Self.QuantityMultiplier(TemplateSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(TemplateSelectorUUID As String, Assigns Value As Double)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(TemplateSelectorUUID, New Dictionary)
		  Dict.Value(Self.ModifierQuantity) = Value
		  Self.mModifierValues.Value(TemplateSelectorUUID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As Ark.LootTemplateEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Idx As Integer)
		  Self.mEntries.RemoveAt(Idx)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(UpperBound As Integer)
		  Self.mEntries.ResizeTo(UpperBound)
		End Sub
	#tag EndMethod


End Class
#tag EndClass
