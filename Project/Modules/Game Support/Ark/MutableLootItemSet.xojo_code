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
		Sub Constructor()
		  Super.Constructor
		  
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
		Sub SourcePresetID(Assigns Value As String)
		  Self.mSourcePresetID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod


End Class
#tag EndClass
