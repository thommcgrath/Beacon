#tag Class
Protected Class LocalDocumentRef
Implements Beacon.DocumentRef
	#tag Method, Flags = &h0
		Sub Constructor(File As Global.FolderItem, Document As Beacon.Document)
		  Self.Constructor(File, Document.Identifier, Document.Title)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As Global.FolderItem, DocumentID As Text, Name As Text)
		  Self.mFile = File
		  Self.mDocumentID = DocumentID
		  Self.mName = Name.Trim
		  If Self.mName = "" Then
		    Self.mName = File.DisplayName.ToText
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentID() As Text
		  // Part of the Beacon.DocumentRef interface.
		  
		  Return Self.mDocumentID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File() As FolderItem
		  Return Self.mFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Import(File As FolderItem) As LocalDocumentRef
		  Dim Document As Beacon.Document = Beacon.Document.Read(File, App.Identity)
		  If Document = Nil Then
		    Return Nil
		  End If
		  
		  Return New LocalDocumentRef(File, Document)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  // Part of the Beacon.DocumentRef interface.
		  
		  Return Self.mName
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDocumentID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As Global.FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As Text
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
