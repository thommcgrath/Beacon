#tag Interface
Protected Interface DocumentItem
	#tag Method, Flags = &h0
		Sub ConsumeMissingEngrams(Engrams() As Beacon.Engram)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
