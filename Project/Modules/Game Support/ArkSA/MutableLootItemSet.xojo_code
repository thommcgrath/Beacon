#tag Class
Protected Class MutableLootItemSet
Inherits ArkSA.LootItemSet
Implements ArkSA.Prunable, Beacon.BlueprintConsumer
	#tag Method, Flags = &h0
		Sub Add(Entry As ArkSA.LootItemSetEntry)
		  Self.mEntries.Add(Entry.ImmutableVersion)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddBlueprintEntry(Sources() As ArkSA.LootItemSetEntry) As ArkSA.LootItemSetEntry
		  If Sources.Count = 0 Then
		    Return Nil
		  End If
		  
		  Var EntryIds() As String
		  For Idx As Integer = Sources.FirstIndex To Sources.LastIndex
		    EntryIds.Add(Sources(Idx).EntryId)
		  Next
		  
		  Var MissingWeight, MinQualitySum, MaxQualitySum As Double
		  Var EntryCount As Double
		  Var References As New Dictionary
		  For Idx As Integer = Self.mEntries.LastIndex DownTo Self.mEntries.FirstIndex
		    If EntryIds.IndexOf(Self.mEntries(Idx).EntryId) = -1 Or Self.mEntries(Idx).ChanceToBeBlueprint = 0 Then
		      Continue
		    End If
		    
		    For Each Option As ArkSA.LootItemSetEntryOption In Self.mEntries(Idx)
		      If References.HasKey(Option.Reference.BlueprintId) = False Then
		        References.Value(Option.Reference.BlueprintId) = Option
		      End If
		    Next Option
		    
		    Var AdjustedWeight As Double = Self.mEntries(Idx).RawWeight * (1 - Self.mEntries(Idx).ChanceToBeBlueprint)
		    MissingWeight = MissingWeight + (Self.mEntries(Idx).RawWeight - AdjustedWeight)
		    
		    EntryCount = EntryCount + 1
		    MinQualitySum = MinQualitySum + Self.mEntries(Idx).MinQuality.BaseValue
		    MaxQualitySum = MaxQualitySum + Self.mEntries(Idx).MaxQuality.BaseValue
		    
		    If Self.mEntries(Idx).ChanceToBeBlueprint < 1 Then
		      Var MutableEntry As New ArkSA.MutableLootItemSetEntry(Self.mEntries(Idx))
		      MutableEntry.ChanceToBeBlueprint = 0
		      MutableEntry.RawWeight = AdjustedWeight
		      Self.mEntries(Idx) = MutableEntry
		    Else
		      Self.mEntries.RemoveAt(Idx)
		    End If
		    Self.Modified = True
		  Next Idx
		  
		  If References.KeyCount = 0 Then
		    Return Nil
		  End If
		  
		  Var BlueprintEntry As New ArkSA.MutableLootItemSetEntry
		  BlueprintEntry.ChanceToBeBlueprint = 1
		  BlueprintEntry.RawWeight = MissingWeight
		  BlueprintEntry.MinQuantity = 1
		  BlueprintEntry.MaxQuantity = 1
		  BlueprintEntry.MinQuality = ArkSA.Qualities.ForBaseValue(MinQualitySum / EntryCount)
		  BlueprintEntry.MaxQuality = ArkSA.Qualities.ForBaseValue(MaxQualitySum / EntryCount)
		  BlueprintEntry.SingleItemQuantity = True
		  For Each ReferenceEntry As DictionaryEntry In References
		    BlueprintEntry.Add(References.Value(ReferenceEntry.Key))
		  Next ReferenceEntry
		  Self.mEntries.Add(BlueprintEntry.ImmutableVersion)
		  Self.Modified = True
		  
		  Return Self.mEntries(Self.mEntries.LastIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Source As ArkSA.LootItemSet)
		  Super.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.LootItemSet
		  Return New ArkSA.LootItemSet(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ItemsRandomWithoutReplacement(Assigns Value As Boolean)
		  Self.mItemsRandomWithoutReplacement = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  If Self.mLabel = Value Then
		    Return
		  End If
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxNumItems(Assigns Value As Integer)
		  Value = Max(Value, 0)
		  If Self.mMaxNumItems = Value Then
		    Return
		  End If
		  
		  Self.mMaxNumItems = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var Changed As Boolean = True
		  For Idx As Integer = 0 To Self.mEntries.LastIndex
		    Var Mutable As ArkSA.MutableLootItemSetEntry = Self.mEntries(Idx).MutableVersion
		    If Mutable.MigrateBlueprints(Migrator) Then
		      Self.mEntries(Idx) = Mutable.ImmutableVersion
		      Self.Modified = True
		      Changed = True
		    End If
		  Next
		  Return Changed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinNumItems(Assigns Value As Integer)
		  Value = Max(Value, 0)
		  If Self.mMinNumItems = Value Then
		    Return
		  End If
		  
		  Self.mMinNumItems = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableLootItemSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumItemsPower(Assigns Value As Double)
		  If Self.mNumItemsPower = Value Then
		    Return
		  End If
		  
		  Self.mNumItemsPower = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Entry As ArkSA.LootItemSetEntry)
		  Self.mEntries(Index) = Entry.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  // Part of the ArkSA.Prunable interface.
		  
		  For Idx As Integer = Self.mEntries.LastIndex DownTo 0
		    Var Mutable As ArkSA.MutableLootItemSetEntry = Self.mEntries(Idx).MutableVersion
		    Mutable.PruneUnknownContent(ContentPackIds)
		    If Mutable.Count = 0 Then
		      Self.mEntries.RemoveAt(Idx)
		      Self.Modified = True
		    ElseIf Mutable.Hash <> Self.mEntries(Idx).Hash Then
		      Self.mEntries(Idx) = Mutable.ImmutableVersion
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  Value = Max(Value, 0)
		  If Self.mSetWeight = Value Then
		    Return
		  End If
		  
		  Self.mSetWeight = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As ArkSA.LootItemSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Index As Integer)
		  Self.mEntries.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mEntries.ResizeTo(Bound)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TemplateUUID(Assigns Value As String)
		  If Self.mTemplateUUID = Value Then
		    Return
		  End If
		  
		  Self.mTemplateUUID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UUID(Assigns Value As String)
		  If Self.mUUID = Value Then
		    Return
		  End If
		  
		  Self.mUUID = Value
		  Self.Modified = True
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
