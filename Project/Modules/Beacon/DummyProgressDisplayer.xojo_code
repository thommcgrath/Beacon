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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
