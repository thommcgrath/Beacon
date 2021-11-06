#tag Class
Protected Class ProjectValidationResults
Implements Iterable
	#tag Method, Flags = &h0
		Sub Add(Issue As Beacon.Issue)
		  If Self.HasIssue(Issue) Then
		    Return
		  End If
		  
		  Self.mIssues.Value(Issue.Description) = Issue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mIssues = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mIssues.KeyCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasIssue(Issue As Beacon.Issue) As Boolean
		  Return Self.HasIssue(Issue.Description)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasIssue(Description As String) As Boolean
		  Return Self.mIssues.HasKey(Description)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Items() As Variant
		  For Each Entry As DictionaryEntry In Self.mIssues
		    Items.Add(Entry.Value)
		  Next Entry
		  
		  Return New Beacon.GenericIterator(Items)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mIssues As Dictionary
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
			Name="mIssues"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
