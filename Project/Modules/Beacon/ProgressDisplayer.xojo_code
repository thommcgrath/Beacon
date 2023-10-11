#tag Interface
Protected Interface ProgressDisplayer
	#tag Method, Flags = &h0
		Sub Cancel()
		  
		End Sub
	#tag EndMethod

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

	#tag Method, Flags = &h0
		Function ShowSubProgress() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowSubProgress(Assigns Value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubDetail() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubDetail(Assigns Value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubProgress() As NullableDouble
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubProgress(Assigns Value As NullableDouble)
		  
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
End Interface
#tag EndInterface
