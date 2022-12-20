#tag Interface
Protected Interface ProgressDisplayer
	#tag Method, Flags = &h0
		Function CancelPressed() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Detail() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Detail(Assigns Value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns Value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Progress() As NullableDouble
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Progress(Assigns Value As NullableDouble)
		  
		End Sub
	#tag EndMethod


End Interface
#tag EndInterface
