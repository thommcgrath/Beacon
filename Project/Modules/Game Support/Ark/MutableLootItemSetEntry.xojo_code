#tag Class
Protected Class MutableLootItemSetEntry
Inherits Ark.LootItemSetEntry
	#tag Method, Flags = &h0
		Sub Add(Option As Ark.LootItemSetEntryOption)
		  Self.mOptions.Add(Option)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChanceToBeBlueprint(Assigns Value As Double)
		  Self.mChanceToBeBlueprint = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.LootItemSetEntry
		  Return New Ark.LootItemSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuality(Assigns Value As Ark.Quality)
		  Self.mMaxQuality = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuantity(Assigns Value As Integer)
		  Self.mMaxQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuality(Assigns Value As Ark.Quality)
		  Self.mMinQuality = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuantity(Assigns Value As Integer)
		  Self.mMinQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableLootItemSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As Ark.LootItemSetEntryOption)
		  Self.mOptions(Index) = Item
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  Self.mWeight = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Index As Integer)
		  Self.mOptions.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mOptions.ResizeTo(Bound)
		  Self.Modified = True
		End Sub
	#tag EndMethod


End Class
#tag EndClass
