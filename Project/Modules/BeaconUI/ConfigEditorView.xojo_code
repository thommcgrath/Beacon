#tag Interface
Protected Interface ConfigEditorView
	#tag Method, Flags = &h0
		Function ConfigLabel() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GoToIssue(Issue As Beacon.Issue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImportFinished()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Beacon.Project
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunTool(ToolId As String) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupUI()
		  
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
