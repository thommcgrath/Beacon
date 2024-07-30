#tag Class
Protected Class ModDownload
	#tag Method, Flags = &h0
		Sub CloseArchive()
		  If (Self.mArchive Is Nil) = False Then
		    Self.mArchive.Close
		    Self.mArchive = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Archive As ArchiveReaderMBS, Filename As String)
		  Self.mArchive = Archive
		  Self.mFilename = Filename
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Self.CloseArchive()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Filename() As String
		  Return Self.mFilename
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextHeader() As ArchiveEntryMBS
		  Return Self.mArchive.NextHeader
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadDataBlockMemory() As MemoryBlock
		  Var Offset As Int64
		  Return Self.mArchive.ReadDataBlockMemory(Offset)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mArchive As ArchiveReaderMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFilename As String
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
