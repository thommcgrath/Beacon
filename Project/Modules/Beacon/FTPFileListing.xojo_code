#tag Class
Protected Class FTPFileListing
	#tag Method, Flags = &h0
		Sub Constructor(IsDirectory As Boolean, Filename As String)
		  Self.mIsDirectory = IsDirectory
		  Self.mFilename = Filename
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Filename() As String
		  Return Self.mFilename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDirectory() As Boolean
		  Return Self.mIsDirectory
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsDirectory As Boolean
	#tag EndProperty


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
		#tag ViewProperty
			Name="mIsDirectory"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
