#tag Class
Protected Class DummyProgressDisplayer
Implements Beacon.ProgressDisplayer
	#tag Method, Flags = &h0
		Function CancelPressed() As Boolean
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Detail() As String
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Detail(Assigns Value As String)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns Value As String)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  #Pragma Unused Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As NullableDouble
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Progress(Assigns Value As NullableDouble)
		  // Part of the Beacon.ProgressDisplayer interface.
		  
		  #Pragma Unused Value
		End Sub
	#tag EndMethod


End Class
#tag EndClass
