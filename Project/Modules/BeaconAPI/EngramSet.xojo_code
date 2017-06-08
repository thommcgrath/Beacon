#tag Class
Protected Class EngramSet
	#tag Method, Flags = &h0
		Function ActiveEngrams() As BeaconAPI.Engram()
		  Dim Engrams() As BeaconAPI.Engram
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mNewEngrams
		    Dim Engram As BeaconAPI.Engram = Entry.Value
		    Engrams.Append(New BeaconAPI.Engram(Engram))
		  Next
		  Return Engrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(Engram As BeaconAPI.Engram)
		  If Engram.ClassString = "" Then
		    Return
		  End If
		  
		  If Self.mNewEngrams.HasKey(Engram.ID) Then
		    Dim PreviousEngram As BeaconAPI.Engram = Self.mNewEngrams.Value(Engram.ID)
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
		  Dim Source, Destination As Xojo.Core.Dictionary
		  If Revert Then
		    Source = Self.mOriginalEngrams
		    Destination = Self.mNewEngrams
		  Else
		    Source = Self.mNewEngrams
		    Destination = Self.mOriginalEngrams
		  End If
		  
		  Destination.RemoveAll
		  For Each Entry As Xojo.Core.DictionaryEntry In Source
		    Dim Engram As BeaconAPI.Engram = Entry.Value
		    Destination.Value(Entry.Key) = New BeaconAPI.Engram(Engram)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Sources() As Auto)
		  Self.mOriginalEngrams = New Xojo.Core.Dictionary
		  Self.mNewEngrams = New Xojo.Core.Dictionary
		  
		  For Each Source As Xojo.Core.Dictionary In Sources
		    Dim Engram As New BeaconAPI.Engram(Source)
		    Self.mOriginalEngrams.Value(Engram.ID) = Engram
		    Self.mNewEngrams.Value(Engram.ID) = Engram
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToDelete() As BeaconAPI.Engram()
		  Dim NewClasses() As Text
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mNewEngrams
		    NewClasses.Append(BeaconAPI.Engram(Entry.Value).ClassString)
		  Next
		  
		  Dim DeleteEngrams() As BeaconAPI.Engram
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mOriginalEngrams
		    Dim Engram As BeaconAPI.Engram = Entry.Value
		    If NewClasses.IndexOf(Engram.ClassString) = -1 Then
		      DeleteEngrams.Append(New BeaconAPI.Engram(Engram))
		    End If
		  Next
		  
		  Return DeleteEngrams
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EngramsToSave() As BeaconAPI.Engram()
		  Dim OriginalClasses As New Xojo.Core.Dictionary
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mOriginalEngrams
		    OriginalClasses.Value(BeaconAPI.Engram(Entry.Value).ClassString) = BeaconAPI.Engram(Entry.Value)
		  Next
		  
		  Dim NewEngrams() As BeaconAPI.Engram
		  For Each Entry As Xojo.Core.DictionaryEntry In Self.mNewEngrams
		    Dim Engram As BeaconAPI.Engram = Entry.Value
		    If OriginalClasses.HasKey(Engram.ClassString) Then
		      // Might be changed
		      Dim OriginalEngram As BeaconAPI.Engram = OriginalClasses.Value(Engram.ClassString)
		      If Engram.Hash <> OriginalEngram.Hash Then
		        NewEngrams.Append(New BeaconAPI.Engram(Engram))
		      End If
		    Else
		      // Definitely new
		      NewEngrams.Append(New BeaconAPI.Engram(Engram))
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
		  If Engram.ClassString = "" Then
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
		Private mNewEngrams As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOriginalEngrams As Xojo.Core.Dictionary
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
