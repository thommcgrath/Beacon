#tag Class
Protected Class FileWriter
	#tag Method, Flags = &h0
		Sub Constructor(RemotePath As String, LocalFile As FolderItem, OriginalHash As String)
		  Self.mLocalFile = LocalFile
		  Self.mOriginalHash = OriginalHash
		  Self.mRemotePath = RemotePath
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LocalFile() As FolderItem
		  Return Self.mLocalFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OriginalHash() As String
		  Return Self.mOriginalHash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemotePath() As String
		  Return Self.mRemotePath
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLocalFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemotePath As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
