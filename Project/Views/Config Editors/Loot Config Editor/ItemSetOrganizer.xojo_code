#tag Class
Protected Class ItemSetOrganizer
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Attach(Source As Beacon.LootSource, Set As Beacon.ItemSet = Nil)
		  If Set <> Nil Then
		    Self.mSets.Value(Source) = Set
		  Else
		    Self.mSets.Value(Source) = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Beacon.ItemSet()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Template As Beacon.ItemSet)
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Beacon.ItemSet(Template)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueSetLabel(Label As String) As String
		  Var Siblings() As String
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var LootSource As Beacon.LootSource = Entry.Key
		    For Each Set As Beacon.ItemSet In LootSource
		      Siblings.AddRow(Set.Label)
		    Next
		  Next
		  
		  Return Beacon.FindUniqueLabel(Label, Siblings)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  // Part of the Beacon.NamedItem interface.
		  
		  Return Self.Label(False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label(Extended As Boolean) As String
		  If Not Extended Then
		    Return Self.Template.Label
		  End If
		  
		  If Self.mSubLabel = "" Then
		    Var SourceNames() As String
		    Var Sources() As Beacon.LootSource = Self.Sources
		    For Each Source As Beacon.LootSource In Sources
		      SourceNames.AddRow(Source.Label)
		    Next
		    SourceNames.Sort
		    Self.mSubLabel = Language.EnglishOxfordList(SourceNames)
		  End If
		  
		  Return Self.Template.Label + EndOfLine + Self.mSubLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Set As Beacon.ItemSet) As Boolean
		  If Self.mTemplate.ID = Set.ID Or Self.mTemplate.Hash = Set.Hash Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var OtherSet As Beacon.ItemSet = Entry.Value
		    If OtherSet.ID = Set.ID or OtherSet.Hash = Set.Hash Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(ParamArray Values() As String) As Boolean
		  Return Self.Matches(Values)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Values() As String) As Boolean
		  Var PossibleValues() As String
		  PossibleValues.AddRow(Self.mTemplate.ID)
		  PossibleValues.AddRow(Self.mTemplate.Hash)
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Set As Beacon.ItemSet = Entry.Value
		    PossibleValues.AddRow(Set.ID)
		    PossibleValues.AddRow(Set.Hash)
		  Next
		  
		  For Each Value As String In Values
		    If PossibleValues.IndexOf(Value) > -1 Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Replicate()
		  Var Bound As Integer = Self.mSets.KeyCount - 1
		  For I As Integer = 0 To Bound
		    Var Source As Beacon.LootSource = Self.mSets.Key(I)
		    Var Set As Beacon.ItemSet = Self.mSets.Value(Source)
		    
		    If Set = Nil Then
		      Set = Source.AddSet(New Beacon.ItemSet(Self.mTemplate), True)
		      Self.mSets.Value(Source) = Set
		    End If
		    
		    Set.CopyFrom(Self.mTemplate)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetForSource(Source As Beacon.LootSource) As Beacon.ItemSet
		  If Self.mSets.HasKey(Source) Then
		    Return Self.mSets.Value(Source)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sources() As Beacon.LootSource()
		  Var Arr() As Beacon.LootSource
		  For Each Entry As DictionaryEntry In Self.mSets
		    Arr.AddRow(Entry.Key)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Template() As Beacon.ItemSet
		  Return Self.mTemplate
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSets As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSubLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemplate As Beacon.ItemSet
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
