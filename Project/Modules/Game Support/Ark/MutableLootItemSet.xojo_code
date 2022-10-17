#tag Class
Protected Class MutableLootItemSet
Inherits Ark.LootItemSet
	#tag Method, Flags = &h0
		Sub Add(Entry As Ark.LootItemSetEntry)
		  Self.mEntries.Add(Entry.ImmutableVersion)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddBlueprintEntry(Sources() As Ark.LootItemSetEntry) As Ark.LootItemSetEntry
		  If Sources.Count = 0 Then
		    Return Nil
		  End If
		  
		  Var UUIDs() As String
		  For Idx As Integer = Sources.FirstIndex To Sources.LastIndex
		    UUIDs.Add(Sources(Idx).UUID)
		  Next Idx
		  
		  Var MissingWeight, MinQualitySum, MaxQualitySum As Double
		  Var EntryCount As Double
		  Var References As New Dictionary
		  For Idx As Integer = Self.mEntries.LastIndex DownTo Self.mEntries.FirstIndex
		    If UUIDs.IndexOf(Self.mEntries(Idx).UUID) = -1 Or Self.mEntries(Idx).ChanceToBeBlueprint = 0 Then
		      Continue
		    End If
		    
		    For Each Option As Ark.LootItemSetEntryOption In Self.mEntries(Idx)
		      If References.HasKey(Option.Reference.ObjectID) = False Then
		        References.Value(Option.Reference.ObjectID) = Option
		      End If
		    Next Option
		    
		    Var AdjustedWeight As Double = Self.mEntries(Idx).RawWeight * (1 - Self.mEntries(Idx).ChanceToBeBlueprint)
		    MissingWeight = MissingWeight + (Self.mEntries(Idx).RawWeight - AdjustedWeight)
		    
		    EntryCount = EntryCount + 1
		    MinQualitySum = MinQualitySum + Self.mEntries(Idx).MinQuality.BaseValue
		    MaxQualitySum = MaxQualitySum + Self.mEntries(Idx).MaxQuality.BaseValue
		    
		    If Self.mEntries(Idx).ChanceToBeBlueprint < 1 Then
		      Var MutableEntry As New Ark.MutableLootItemSetEntry(Self.mEntries(Idx))
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
		  
		  Var BlueprintEntry As New Ark.MutableLootItemSetEntry
		  BlueprintEntry.ChanceToBeBlueprint = 1
		  BlueprintEntry.RawWeight = MissingWeight
		  BlueprintEntry.MinQuantity = 1
		  BlueprintEntry.MaxQuantity = 1
		  BlueprintEntry.MinQuality = Ark.Qualities.ForBaseValue(MinQualitySum / EntryCount)
		  BlueprintEntry.MaxQuality = Ark.Qualities.ForBaseValue(MaxQualitySum / EntryCount)
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
		Sub CopyFrom(Source As Ark.LootItemSet)
		  Super.CopyFrom(Source)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootItemSet
		  Return New Ark.LootItemSet(Self)
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
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxNumItems(Assigns Value As Integer)
		  Self.mMaxNumItems = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinNumItems(Assigns Value As Integer)
		  Self.mMinNumItems = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootItemSet
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumItemsPower(Assigns Value As Double)
		  Self.mNumItemsPower = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Entry As Ark.LootItemSetEntry)
		  Self.mEntries(Index) = Entry.ImmutableVersion
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  Self.mSetWeight = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As Ark.LootItemSetEntry)
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
		  Self.mTemplateUUID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UUID(Assigns Value As String)
		  Self.mUUID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod


End Class
#tag EndClass
