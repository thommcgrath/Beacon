#tag Class
Protected Class LootTemplate
Inherits Beacon.Template
Implements Beacon.Countable, Iterable
	#tag Method, Flags = &h0
		Function ActiveSelectorIDs() As String()
		  Var IDs() As String
		  For Each Entry As DictionaryEntry In Self.mModifierValues
		    IDs.Add(Entry.Key)
		  Next
		  Return IDs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintChanceMultiplier(LootSelector As Ark.LootContainerSelector) As Double
		  Return Self.BlueprintChanceMultiplier(LootSelector.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintChanceMultiplier(LootSelectorUUID As String) As Double
		  If Self.mModifierValues Is Nil Or Self.mModifierValues.HasKey(LootSelectorUUID) = False Then
		    Return 1.0
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Value(LootSelectorUUID)
		  Return Dict.Lookup("Blueprint Chance Multiplier", 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLabel = "Untitled Template"
		  Self.mGrouping = "Miscellaneous"
		  Self.mMinEntriesSelected = 1
		  Self.mMaxEntriesSelected = 3
		  Self.mUUID = New v4UUID
		  Self.mModifierValues = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.LootTemplate)
		  Self.mLabel = Source.mLabel
		  Self.mGrouping = Source.mGrouping
		  Self.mMinEntriesSelected = Source.mMinEntriesSelected
		  Self.mMaxEntriesSelected = Source.mMaxEntriesSelected
		  Self.mUUID = Source.mUUID
		  
		  Self.mModifierValues = New Dictionary
		  For Each Entry As DictionaryEntry In Source.mModifierValues
		    Var Dict As Dictionary = Entry.Value
		    Self.mModifierValues.Value(Entry.Key) = Dict.Clone
		  Next
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastIndex)
		  For I As Integer = 0 To Self.mEntries.LastIndex
		    Self.mEntries(I) = New Ark.LootTemplateEntry(Source.mEntries(I))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mEntries.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Grouping() As String
		  Return Self.mGrouping
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableClone() As Ark.LootTemplate
		  Return New Ark.LootTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootTemplate
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Entry As Ark.LootTemplateEntry) As Integer
		  For Idx As Integer = 0 To Self.mEntries.LastIndex
		    If Self.mEntries(Idx) = Entry Then
		      Return Idx
		    End If
		  Next Idx
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Entries() As Variant
		  Entries.ResizeTo(Self.mEntries.LastIndex)
		  For Idx As Integer = 0 To Entries.LastIndex
		    Entries(Idx) = Self.mEntries(Idx)
		  Next Idx
		  Return New Beacon.GenericIterator(Entries)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxEntriesSelected() As Integer
		  Return Self.mMaxEntriesSelected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQualityOffset(LootSelector As Ark.LootContainerSelector) As Integer
		  Return Self.MaxQualityOffset(LootSelector.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxQualityOffset(LootSelectorUUID As String) As Integer
		  If Self.mModifierValues Is Nil Or Self.mModifierValues.HasKey(LootSelectorUUID) = False Then
		    Return 0
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Value(LootSelectorUUID)
		  Return Dict.Lookup("Max Quality Offset", 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinEntriesSelected() As Integer
		  Return Self.mMinEntriesSelected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQualityOffset(LootSelector As Ark.LootContainerSelector) As Integer
		  Return Self.MinQualityOffset(LootSelector.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinQualityOffset(LootSelectorUUID As String) As Integer
		  If Self.mModifierValues Is Nil Or Self.mModifierValues.HasKey(LootSelectorUUID) = False Then
		    Return 0
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Value(LootSelectorUUID)
		  Return Dict.Lookup("Min Quality Offset", 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableLootTemplate
		  Return New Ark.MutableLootTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootTemplate
		  Return New Ark.MutableLootTemplate(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.LootTemplate) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mUUID = Other.mUUID Then
		    Return 0
		  End If
		  
		  Var SelfValue As String = Self.mLabel + ":" + Self.mUUID
		  Var OtherValue As String = Other.mLabel + ":" + Other.mUUID
		  Return SelfValue.Compare(OtherValue, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Idx As Integer) As Ark.LootTemplateEntry
		  Return Self.mEntries(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(LootSelector As Ark.LootContainerSelector) As Double
		  Return Self.QuantityMultiplier(LootSelector.UUID)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QuantityMultiplier(LootSelectorUUID As String) As Double
		  If Self.mModifierValues Is Nil Or Self.mModifierValues.HasKey(LootSelectorUUID) = False Then
		    Return 1.0
		  End If
		  
		  Var Dict As Dictionary = Self.mModifierValues.Value(LootSelectorUUID)
		  Return Dict.Lookup("Quantity Multiplier", 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUID() As String
		  Return Self.mUUID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMap(Map As Ark.Map) As Boolean
		  Return Self.ValidForMask(Map.Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValidForMask(Mask As UInt64) As Boolean
		  If Mask = CType(0, UInt64) Then
		    Return True
		  End If
		  
		  For Each Entry As Ark.LootTemplateEntry In Self.mEntries
		    If Entry.ValidForMask(Mask) Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mEntries() As Ark.LootTemplateEntry
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mGrouping As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxEntriesSelected As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinEntriesSelected As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModifierValues As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUUID As String
	#tag EndProperty


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
		#tag ViewProperty
			Name="mEntries()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
