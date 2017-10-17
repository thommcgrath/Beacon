#tag Class
Protected Class TemporaryDocumentRef
Implements Beacon.DocumentRef
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mDocument = New Beacon.Document
		  Self.mCounter = Self.mCounter + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Document As Beacon.Document)
		  Self.mDocument = Document
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Document() As Beacon.Document
		  Return Self.mDocument
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentID() As Text
		  // Part of the Beacon.DocumentRef interface.
		  
		  Return Self.mDocument.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As Text
		  // Part of the Beacon.DocumentRef interface.
		  
		  If Self.mDocument.Title = "" Then
		    Return "Untitled Document " + Self.mCounter.ToText
		  Else
		    Return Self.mDocument.Title
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared mCounter As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDocument As Beacon.Document
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
			Name="mDocument"
			Group="Behavior"
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
