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
		Function AddBlueprintEntries(Sources() As Ark.LootItemSetEntry) As Ark.LootItemSetEntry()
		  #if DebugBuild
		    #Pragma Warning "Does not create blueprint entries"
		  #else
		    #Pragma Error "Does not create blueprint entries"
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(Source As Ark.LootItemSet)
		  Self.mItemsRandomWithoutReplacement = Source.mItemsRandomWithoutReplacement
		  Self.mMaxNumItems = Source.mMaxNumItems
		  Self.mMinNumItems = Source.mMinNumItems
		  Self.mNumItemsPower = Source.mNumItemsPower
		  Self.mSetWeight = Source.mSetWeight
		  Self.mLabel = Source.mLabel
		  Self.mTemplateUUID = Source.mTemplateUUID
		  
		  Self.mEntries.ResizeTo(Source.mEntries.LastIndex)
		  For I As Integer = 0 To Source.mEntries.LastIndex
		    Self.mEntries(I) = New Ark.LootItemSetEntry(Source.mEntries(I))
		  Next
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


End Class
#tag EndClass
