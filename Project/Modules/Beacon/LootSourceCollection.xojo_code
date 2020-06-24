#tag Class
Protected Class LootSourceCollection
Inherits Beacon.Collection
	#tag Method, Flags = &h0
		Function Operator_Convert() As Beacon.LootSource()
		  Var Sources() As Beacon.LootSource
		  For Each Item As Beacon.LootSource In Self.mItems
		    Sources.AddRow(Item)
		  Next
		  Return Sources
		End Function
	#tag EndMethod


End Class
#tag EndClass
