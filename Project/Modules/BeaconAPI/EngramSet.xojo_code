#tag Class
Protected Class EngramSet
	#tag Method, Flags = &h0
		Function ActiveEngrams() As BeaconAPI.Engram()
		  Var Engrams() As BeaconAPI.Engram
		  For Each Entry As DictionaryEntry In Self.mNewEngrams
		    Var Engram As BeaconAPI.Engram = Entry.Value
		    Engrams.Add(New BeaconAPI.Engram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Engram As BeaconAPI.Engram)
		  If Engram.Path = "" Then
		    Return
		  End If
		  
		  If Self.mNewEngrams.HasKey(Engram.ID) Then
		    Var PreviousEngram As BeaconAPI.Engram = Self.mNewEngrams.Value(Engram.ID)
		    If Engram.Hash = PreviousEngram.Hash Then
		      Return
		    End If
		  End If
		  
		  Self.mNewEngrams.Value(Engram.ID) = New BeaconAPI.Engram(Engram)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearModifications(Revert As Boolean = True)
		  Var Source, Destination As Dictionary
		  If Revert Then
		    Source = Self.mOriginalEngrams
		    Destination = Self.mNewEngrams
		  Else
		    Source = Self.mNewEngrams
		    Destination = Self.mOriginalEngrams
		  End If
		  
		  Destination.RemoveAll
		  For Each Entry As DictionaryEntry In Source
		    Var Engram As BeaconAPI.Engram = Entry.Value
		    Destination.Value(Entry.Key) = New BeaconAPI.Engram(Engram)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Sources() As Variant)
		  Self.mOriginalEngrams = New Dictionary
		  Self.mNewEngrams = New Dictionary
		  
		  For Each Source As Dictionary In Sources
		    Var Engram As New BeaconAPI.Engram(Source)
		    Self.mOriginalEngrams.Value(Engram.ID) = Engram
		    Self.mNewEngrams.Value(Engram.ID) = Engram
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToDelete() As BeaconAPI.Engram()
		  Var NewClasses() As String
		  For Each Entry As DictionaryEntry In Self.mNewEngrams
		    NewClasses.Add(BeaconAPI.Engram(Entry.Value).Path)
		  Next
		  
		  Var DeleteEngrams() As BeaconAPI.Engram
		  For Each Entry As DictionaryEntry In Self.mOriginalEngrams
		    Var Engram As BeaconAPI.Engram = Entry.Value
		    If NewClasses.IndexOf(Engram.Path) = -1 Then
		      DeleteEngrams.Add(New BeaconAPI.Engram(Engram))
		    End If
		  Next
		  
		  Return DeleteEngrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToSave() As BeaconAPI.Engram()
		  Var OriginalClasses As New Dictionary
		  For Each Entry As DictionaryEntry In Self.mOriginalEngrams
		    OriginalClasses.Value(BeaconAPI.Engram(Entry.Value).Path) = BeaconAPI.Engram(Entry.Value)
		  Next
		  
		  Var NewEngrams() As BeaconAPI.Engram
		  For Each Entry As DictionaryEntry In Self.mNewEngrams
		    Var Engram As BeaconAPI.Engram = Entry.Value
		    If OriginalClasses.HasKey(Engram.Path) Then
		      // Might be changed
		      Var OriginalEngram As BeaconAPI.Engram = OriginalClasses.Value(Engram.Path)
		      If Engram.Hash <> OriginalEngram.Hash Then
		        NewEngrams.Add(New BeaconAPI.Engram(Engram))
		      End If
		    Else
		      // Definitely new
		      NewEngrams.Add(New BeaconAPI.Engram(Engram))
		    End If
		  Next
		  
		  Return NewEngrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Engram As BeaconAPI.Engram)
		  If Engram.Path = "" Then
		    Return
		  End If
		  
		  If Self.mNewEngrams.HasKey(Engram.ID) Then
		    Self.mNewEngrams.Remove(Engram.ID)
		    Self.mModified = True
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNewEngrams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalEngrams As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
