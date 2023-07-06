#tag Class
Protected Class Archive
	#tag Method, Flags = &h0
		Sub AddFile(Path As String = "", File As FolderItem)
		  If Self.InWriteMode = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot add files in read mode."
		    Raise Err
		  End If
		  
		  If File Is Nil Or File.Exists = False Then
		    Return
		  End If
		  
		  If File.IsFolder Then
		    If Path.IsEmpty = False Then
		      Path = Path + "/"
		    End If
		    For Each Child As FolderItem In File.Children
		      Self.AddFile(Path + File.Name, Child)
		    Next
		    Return
		  End If
		  
		  Const ChunkSize = 256000
		  Var Stream As BinaryStream = BinaryStream.Open(File, False)
		  Var Contents As New MemoryBlock(CType(Stream.Length, Integer))
		  Var Offset As Integer = 0
		  While Stream.EndOfFile = False
		    Var ReadBytes As Integer = Min(ChunkSize, CType(Stream.Length, Integer) - Offset)
		    Contents.StringValue(Offset, ReadBytes) = Stream.Read(ReadBytes, Nil)
		    Offset = Offset + ReadBytes
		  Wend
		  Stream.Close
		  
		  Self.AddFile(Path + "/" + File.Name, Contents)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFile(Path As String, Data As MemoryBlock)
		  If Self.InWriteMode = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot add files in read mode."
		    Raise Err
		  End If
		  
		  If Data Is Nil Or Data.Size = 0 Then
		    Return
		  End If
		  
		  Var Entry As New ArchiveEntryMBS
		  Entry.PathName = Path
		  Entry.Size = CType(Data.Size, UInt64)
		  Entry.Permissions = &o0644
		  Entry.FileType = ArchiveEntryMBS.kFileTypeRegular
		  
		  Self.mWriter.WriteHeader(Entry)
		  Call Self.mWriter.WriteData(Data)
		  If Self.mWriter.LastError <> ArchiveWriterMBS.kArchiveOK Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unable to add " + Path + " to archive: " + Self.LastErrorString
		    Raise Err
		  End If
		  Self.mWriter.FinishEntry
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Reader As ArchiveReaderMBS)
		  Self.Constructor()
		  
		  Self.mReader = Reader
		  Self.mFileContents = New Dictionary
		  Call Self.ListPaths()
		  Self.mReader.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Writer As ArchiveWriterMBS)
		  Self.Constructor()
		  
		  Self.mWriter = Writer
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(File As FolderItem, Password As String = "") As Beacon.Archive
		  Var Writer As ArchiveWriterMBS = CreateWriter(Password)
		  If Not Writer.CreateFile(File) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unable to create archive: " + Writer.ErrorString
		    Raise Err
		  End If
		  Return New Beacon.Archive(Writer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Create(Password As String = "") As Beacon.Archive
		  Var Writer As ArchiveWriterMBS = CreateWriter(Password)
		  If Not Writer.CreateMemoryFile() Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unable to create archive: " + Writer.ErrorString
		    Raise Err
		  End If
		  Return New Beacon.Archive(Writer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateReader(Password As String = "") As ArchiveReaderMBS
		  Var Reader As New ArchiveReaderMBS
		  Reader.SupportFilterAll
		  Reader.SupportFormatAll
		  If Password.IsEmpty = False Then
		    Reader.AddPassphrase(Password)
		  End If
		  //Reader.Yield = True
		  Return Reader
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateWriter(Password As String = "") As ArchiveWriterMBS
		  Var Writer As New ArchiveWriterMBS
		  If Password.IsEmpty Then
		    Writer.AddFilterGZip
		    Writer.SetFormatPaxRestricted
		  Else
		    Writer.SetFormatZip
		    Writer.ZipSetCompressionDeflate
		    Writer.SetOption("zip", "encryption", "aes256")
		    Writer.SetPassphrase(Password)
		  End If
		  // Writer.Yield = True
		  Return Writer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finalize() As MemoryBlock
		  If (Self.mWriter Is Nil) = False Then
		    Self.mWriter.Close
		    Return Self.mWriter.MemoryData
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFile(Path As String) As MemoryBlock
		  If Self.InReadMode = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot read files in write mode."
		    Raise Err
		  End If
		  
		  If Self.mFileContents.HasKey(Path) = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "File " + Path + " not found."
		    Raise Err
		  End If
		  
		  Return Self.mFileContents.Value(Path)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InReadMode() As Boolean
		  Return (Self.mReader Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InWriteMode() As Boolean
		  Return (Self.mWriter Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  If (Self.mWriter Is Nil) = False Then
		    Return Self.mWriter.Lasterror
		  ElseIf (Self.mReader Is Nil) = False Then
		    Return Self.mReader.Lasterror
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastErrorString() As String
		  If (Self.mWriter Is Nil) = False Then
		    Return Self.mWriter.ErrorString
		  ElseIf (Self.mReader Is Nil) = False Then
		    Return Self.mReader.ErrorString
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListPaths() As String()
		  If Self.InReadMode = False Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Cannot list files in write mode."
		    Raise Err
		  End If
		  
		  If Self.mFileContents.KeyCount = 0 Then
		    Do
		      Var Entry As ArchiveEntryMBS = Self.mReader.NextHeader
		      If Entry Is Nil Then
		        Exit
		      End If
		      
		      Var TargetSize As UInt64 = Entry.Size
		      Var Offset As Int64
		      Var FileContents As New MemoryBlock(0)
		      While FileContents.Size <> CType(TargetSize, Integer)
		        FileContents = FileContents +  Self.mReader.ReadDataBlockMemory(Offset)
		      Wend
		      
		      Self.mFileContents.Value(Entry.PathName) = FileContents
		    Loop
		  End If
		  
		  Var Paths() As String
		  For Each Entry As DictionaryEntry In Self.mFileContents
		    Paths.Add(Entry.Key)
		  Next
		  Return Paths
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Open(File As FolderItem, Password As String = "") As Beacon.Archive
		  Var Reader As ArchiveReaderMBS = CreateReader(Password)
		  If Not Reader.OpenFile(File) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unable to open archive: " + Reader.ErrorString
		    Raise Err
		  End If
		  Return New Beacon.Archive(Reader)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Open(Source As MemoryBlock, Password As String = "") As Beacon.Archive
		  Var Reader As ArchiveReaderMBS = CreateReader(Password)
		  If Not Reader.OpenData(Source) Then
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Unable to open archive: " + Reader.ErrorString
		    Raise Err
		  End If
		  Return New Beacon.Archive(Reader)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFileContents As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReader As ArchiveReaderMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWriter As ArchiveWriterMBS
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
