#tag Class
Protected Class APIEngramSet
	#tag Method, Flags = &h0
		Function ActiveEngrams() As APIEngram()
		  Dim Merged As New Xojo.Core.Dictionary
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mOriginalEngrams
		    Merged.Value(Entry.Key) = Entry.Value
		  Next
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mUpdatedEngrams
		    Merged.Value(Entry.Key) = Entry.Value
		  Next
		  
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mRemovedEngrams
		    If Merged.HasKey(Entry.Key) Then
		      Merged.Remove(Entry.Key)
		    End If
		  Next
		  
		  Dim Engrams() As APIEngram
		  For Each Entry As Xojo.Core.DictionaryEntry In Merged
		    Dim Engram As APIEngram = Entry.Value
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Engram As APIEngram)
		  If Engram.ClassString = "" Then
		    Return
		  End If
		  
		  If Self.mRemovedEngrams.HasKey(Engram.ID) Then
		    Self.mRemovedEngrams.Remove(Engram.ID)
		  End If
		  
		  Self.mUpdatedEngrams.Value(Engram.ID) = New APIEngram(Engram)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Sources() As Auto)
		  Self.mOriginalEngrams = New Xojo.Core.Dictionary
		  Self.mUpdatedEngrams = New Xojo.Core.Dictionary
		  Self.mRemovedEngrams = New Xojo.Core.Dictionary
		  
		  For Each Source As Xojo.Core.Dictionary In Sources
		    Dim Engram As New APIEngram(Source)
		    Self.mOriginalEngrams.Value(Engram.ID) = Engram
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToDelete() As APIEngram()
		  Dim Engrams() As APIEngram
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mRemovedEngrams
		    Dim Engram As APIEngram = Entry.Value
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToSave() As APIEngram()
		  Dim Engrams() As APIEngram
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mUpdatedEngrams
		    Dim Engram As APIEngram = Entry.Value
		    Engrams.Append(New APIEngram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mUpdatedEngrams.Count > 0 Or Self.mRemovedEngrams.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As APIEngram)
		  If Engram.ClassString = "" Then
		    Return
		  End If
		  
		  If Self.mUpdatedEngrams.HasKey(Engram.ID) Then
		    Self.mUpdatedEngrams.Remove(Engram.ID)
		  End If
		  
		  If Self.mOriginalEngrams.HasKey(Engram.ID) Then
		    Self.mRemovedEngrams.Value(Engram.ID) = New APIEngram(Engram)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOriginalEngrams As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemovedEngrams As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdatedEngrams As Xojo.Core.Dictionary
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
