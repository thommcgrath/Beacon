#tag Interface
Protected Interface DiscoveryEngine
	#tag Method, Flags = &h0
		Sub Begin()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions() As Xojo.Core.DIctionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IniContent() As Text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Map() As UInt64
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
