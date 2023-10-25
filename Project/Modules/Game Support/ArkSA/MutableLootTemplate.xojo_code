#tag Class
Protected Class MutableLootTemplate
Inherits ArkSA.LootTemplate
	#tag Method, Flags = &h0
		Sub Add(Entry As ArkSA.LootTemplateEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.mEntries(Idx) = Entry.ImmutableVersion
		  Else
		    Self.mEntries.Add(Entry.ImmutableVersion)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddBlueprintEntries(Sources() As ArkSA.LootTemplateEntry) As ArkSA.LootTemplateEntry()
		  Var MatchingUUIDs() As String
		  For Idx As Integer = 0 To Sources.LastIndex
		    MatchingUUIDs.Add(Sources(Idx).EntryId)
		  Next Idx
		  
		  Var TotalWeight, MinQualitySum, MaxQualitySum, EntryCount As Double
		  Var References As New Dictionary
		  For Idx As Integer = Self.mEntries.FirstIndex To Self.mEntries.LastIndex
		    If MatchingUUIDs.IndexOf(Self.mEntries(Idx).EntryId) = -1 Or Self.mEntries(Idx).ChanceToBeBlueprint = 0 Then
		      Continue
		    End If
		    
		    For Each Option As ArkSA.LootItemSetEntryOption In Self.mEntries(Idx)
		      If References.HasKey(Option.Reference.BlueprintId) = False Then
		        References.Value(Option.Reference.BlueprintId) = Option.Reference
		      End If
		    Next Option
		    
		    EntryCount = EntryCount + 1
		    MinQualitySum = MinQualitySum + Self.mEntries(Idx).MinQuality.BaseValue
		    MaxQualitySum = MaxQualitySum + Self.mEntries(Idx).MaxQuality.BaseValue
		    TotalWeight = TotalWeight + Self.mEntries(Idx).RawWeight
		    
		    Var Mutable As New ArkSA.MutableLootTemplateEntry(Self.mEntries(Idx))
		    Mutable.ChanceToBeBlueprint = 0
		    Mutable.RespectBlueprintChanceMultipliers = False
		    Self.mEntries(Idx) = New ArkSA.LootTemplateEntry(Mutable)
		  Next Idx
		  
		  Var UniqueMasks() As UInt64
		  For Each Entry As DictionaryEntry In References
		    Var Reference As ArkSA.BlueprintReference = Entry.Value
		    Var Engram As ArkSA.Engram = ArkSA.Engram(Reference.Resolve)
		    Var EngramMask As UInt64 = Engram.Availability
		    If UniqueMasks.IndexOf(EngramMask) = -1 Then
		      UniqueMasks.Add(EngramMask)
		    End If
		  Next Entry
		  
		  Var BlueprintEntries() As ArkSA.LootTemplateEntry
		  For MaskIdx As Integer = UniqueMasks.FirstIndex To UniqueMasks.LastIndex
		    Var EngramMask As UInt64 = UniqueMasks(MaskIdx)
		    Var Blueprint As New ArkSA.MutableLootTemplateEntry
		    Blueprint.ChanceToBeBlueprint = 1
		    Blueprint.RespectBlueprintChanceMultipliers = False
		    Blueprint.RespectQuantityMultipliers = False
		    Blueprint.RespectWeightMultipliers = True
		    Blueprint.Availability = EngramMask
		    Blueprint.ChanceToBeBlueprint = 1
		    Blueprint.RawWeight = TotalWeight / EntryCount
		    Blueprint.MinQuantity = 1
		    Blueprint.MaxQuantity = 1
		    Blueprint.MinQuality = ArkSA.Qualities.ForBaseValue(MinQualitySum / EntryCount)
		    Blueprint.MaxQuality = ArkSA.Qualities.ForBaseValue(MaxQualitySum / EntryCount)
		    Blueprint.SingleItemQuantity = True
		    For Each Entry As DictionaryEntry In References
		      Var Reference As ArkSA.BlueprintReference = Entry.Value
		      Var Engram As ArkSA.Engram = ArkSA.Engram(Reference.Resolve)
		      If (Engram.Availability And EngramMask) > CType(0, UInt64) Then
		        Blueprint.Add(New ArkSA.LootItemSetEntryOption(Engram, 10))
		      End If
		    Next Entry
		    
		    Var Immutable As New ArkSA.LootTemplateEntry(Blueprint)
		    Self.mEntries.Add(Immutable)
		    BlueprintEntries.Add(Immutable)
		  Next MaskIdx
		  
		  Return BlueprintEntries
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintChanceMultiplier(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Double)
		  If TemplateSelector Is Nil Then
		    Return
		  End If
		  
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
		  #Pragma StackOverflowChecking False
		  Self.mGrouping = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.LootTemplate
		  Return New ArkSA.LootTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  #Pragma StackOverflowChecking False
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxEntriesSelected(Assigns Value As Integer)
		  #Pragma StackOverflowChecking False
		  Self.mMaxEntriesSelected = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityOffset(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Integer)
		  If TemplateSelector Is Nil Then
		    Return
		  End If
		  
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
		  #Pragma StackOverflowChecking False
		  Self.mMinEntriesSelected = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityOffset(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Integer)
		  If TemplateSelector Is Nil Then
		    Return
		  End If
		  
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
		Function MutableVersion() As ArkSA.MutableLootTemplate
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Idx As Integer, Assigns Value As ArkSA.LootTemplateEntry)
		  Self.mEntries(Idx) = Value.ImmutableVersion
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Double)
		  If TemplateSelector Is Nil Then
		    Return
		  End If
		  
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
		Sub Remove(Entry As ArkSA.LootTemplateEntry)
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

	#tag Method, Flags = &h0
		Sub WeightMultiplier(TemplateSelector As Beacon.TemplateSelector, Assigns Value As Double)
		  If TemplateSelector Is Nil Then
		    Return
		  End If
		  
		  Self.WeightMultiplier(TemplateSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WeightMultiplier(TemplateSelectorId As String, Assigns Value As Double)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(TemplateSelectorId, New Dictionary)
		  Dict.Value(Self.ModifierWeight) = Value
		  Self.mModifierValues.Value(TemplateSelectorId) = Dict
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
