#tag Interface
Protected Interface MutableLootSource
Implements Beacon.LootSource
	#tag Method, Flags = &h0
		Sub Availability(Assigns Mask As UInt64)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClassString(Assigns Value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Multipliers(Assigns Value As Beacon.Range)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Notes(Assigns Value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequiredItemSetCount(Assigns Value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortValue(Assigns Value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UIColor(Assigns Value As Color)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
