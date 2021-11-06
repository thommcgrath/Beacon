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
		  #if DebugBuild
		    #Pragma Warning "Does not create blueprint entries"
		  #else
		    #Pragma Error "Does not create blueprint entries"
		  #endif
		  
		  #if false
		    Var MatchingUUIDs() As String
		    For Idx As Integer = 0 To Sources.LastIndex
		      MatchingUUIDs.Add(Sources(Idx).UUID)
		    Next Idx
		    
		    Var References As New Dictionary
		    For Idx As Integer = 0 To Self.mEntries.LastIndex
		      If MatchingUUIDs.IndexOf(Self.mEntries(Idx).UUID) = -1 Or Self.mEntries(Idx).ChanceToBeBlueprint = 0 Then
		        Continue
		      End If
		      
		      For Each Option As Ark.LootItemSetEntryOption In Self.mEntries(Idx)
		        If References.HasKey(Option.Reference.ObjectID) = False Then
		          References.Value(Option.Reference.ObjectID) = Option.Reference
		        End If
		      Next Option
		      
		      Var Mutable As New Ark.MutableLootTemplateEntry(Self.mEntries(Idx))
		      Mutable.ChanceToBeBlueprint = 0
		      Self.mEntries(Idx) = New Ark.LootTemplateEntry(Mutable)
		    Next Idx
		    
		    Var UniqueMasks() As UInt64
		    For Each Entry As DictionaryEntry In References
		      Var Reference As Ark.BlueprintReference = Entry.Value
		      Var Engram As Ark.Engram = Ark.Engram(Reference.Resolve)
		      Var EngramMask As UInt64 = Mask And Engram.Availability
		      If UniqueMasks.IndexOf(EngramMask) = -1 Then
		        UniqueMasks.Add(EngramMask)
		      End If
		    Next Entry
		    
		    Var BlueprintEntries() As Ark.LootTemplateEntry
		    For MaskIdx As Integer = 0 To UniqueMasks.LastIndex
		      Var EngramMask As UInt64 = UniqueMasks(MaskIdx)
		      Var Blueprint As New Ark.MutableLootTemplateEntry
		      Blueprint.ChanceToBeBlueprint = 1
		      Blueprint.RespectBlueprintChanceMultipliers = False
		      Blueprint.RespectQuantityMultipliers = False
		      Blueprint.Availability = EngramMask
		      For Each Entry As DictionaryEntry In References
		        Var Reference As Ark.BlueprintReference = Entry.Value
		        Var Engram As Ark.Engram = Ark.Engram(Reference.Resolve)
		        If (Engram.Availability And EngramMask) > 0 Then
		          Blueprint.Add(New Ark.LootItemSetEntryOption(Engram, 10))
		        End If
		      Next Entry
		      
		      Var Immutable As New Ark.LootTemplateEntry(Blueprint)
		      Self.mEntries.Add(Immutable)
		      BlueprintEntries.Add(Immutable)
		    Next MaskIdx
		    
		    Return BlueprintEntries
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintChanceMultiplier(LootSelector As Ark.LootContainerSelector, Assigns Value As Double)
		  Self.BlueprintChanceMultiplier(LootSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintChanceMultiplier(LootSelectorUUID As String, Assigns Value As Double)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(LootSelectorUUID, New Dictionary)
		  Dict.Value("Blueprint Chance Multiplier") = Value
		  Self.mModifierValues.Value(LootSelectorUUID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearSelector(ContainerSelector As Ark.LootContainerSelector)
		  Self.ClearSelector(ContainerSelector.UUID)
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
		Sub MaxQualityOffset(LootSelector As Ark.LootContainerSelector, Assigns Value As Integer)
		  Self.MaxQualityOffset(LootSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityOffset(LootSelectorUUID As String, Assigns Value As Integer)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(LootSelectorUUID, New Dictionary)
		  Dict.Value("Max Quality Offset") = Value
		  Self.mModifierValues.Value(LootSelectorUUID) = Dict
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinEntriesSelected(Assigns Value As Integer)
		  Self.mMinEntriesSelected = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityOffset(LootSelector As Ark.LootContainerSelector, Assigns Value As Integer)
		  Self.MinQualityOffset(LootSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityOffset(LootSelectorUUID As String, Assigns Value As Integer)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(LootSelectorUUID, New Dictionary)
		  Dict.Value("Min Quality Offset") = Value
		  Self.mModifierValues.Value(LootSelectorUUID) = Dict
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
		Sub QuantityMultiplier(LootSelector As Ark.LootContainerSelector, Assigns Value As Double)
		  Self.QuantityMultiplier(LootSelector.UUID) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub QuantityMultiplier(LootSelectorUUID As String, Assigns Value As Double)
		  If Self.mModifierValues Is Nil Then
		    Self.mModifierValues = New Dictionary
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Lookup(LootSelectorUUID, New Dictionary)
		  Dict.Value("Quantity Multiplier") = Value
		  Self.mModifierValues.Value(LootSelectorUUID) = Dict
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
