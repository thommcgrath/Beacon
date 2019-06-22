#tag Interface
Protected Interface MutableBlueprint
Implements Beacon.Blueprint
	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As Text)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModID(Assigns Value As Text)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModName(Assigns Value As Text)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As Text)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As Text)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
