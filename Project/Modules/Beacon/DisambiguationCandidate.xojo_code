#tag Interface
Protected Interface DisambiguationCandidate
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Function DisambiguationId() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationSuffix(Mask As UInt64) As String
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
