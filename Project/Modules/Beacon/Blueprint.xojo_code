#tag Interface
Protected Interface Blueprint
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.Blueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableBlueprint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As Text()
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
