#tag Class
Protected Class LootItemSetOrganizer
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Attach(Override As Ark.MutableLootDropOverride, Set As Ark.LootItemSet = Nil)
		  If Set <> Nil Then
		    Self.mSets.Value(Override) = Set.MutableVersion
		  Else
		    Self.mSets.Value(Override) = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Ark.MutableLootItemSet()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Template As Ark.LootItemSet)
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Ark.MutableLootItemSet(Template)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueSetLabel(Label As String) As String
		  Var Siblings() As String
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Override As Ark.LootDropOverride = Entry.Key
		    For Each Set As Ark.LootItemSet In Override
		      Siblings.Add(Set.Label)
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
		    Var OverrideNames() As String
		    Var Overrides() As Ark.LootDropOverride = Self.Overrides
		    For Each Override As Ark.LootDropOverride In Overrides
		      OverrideNames.Add(Override.Label)
		    Next
		    OverrideNames.Sort
		    Self.mSubLabel = Language.EnglishOxfordList(OverrideNames)
		  End If
		  
		  Return Self.Template.Label + EndOfLine + Self.mSubLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Set As Ark.LootItemSet) As Boolean
		  If Self.mTemplate.UUID = Set.UUID Or Self.mTemplate.Hash = Set.Hash Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var OtherSet As Ark.LootItemSet = Entry.Value
		    If OtherSet.UUID = Set.UUID or OtherSet.Hash = Set.Hash Then
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
		  PossibleValues.Add(Self.mTemplate.UUID)
		  PossibleValues.Add(Self.mTemplate.Hash)
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Set As Ark.LootItemSet = Entry.Value
		    PossibleValues.Add(Set.UUID)
		    PossibleValues.Add(Set.Hash)
		  Next
		  
		  For Each Value As String In Values
		    If PossibleValues.IndexOf(Value) > -1 Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overrides() As Ark.MutableLootDropOverride()
		  Var Arr() As Ark.MutableLootDropOverride
		  For Each Entry As DictionaryEntry In Self.mSets
		    Arr.Add(Entry.Key)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Replicate()
		  Var Bound As Integer = Self.mSets.KeyCount - 1
		  For I As Integer = 0 To Bound
		    Var Override As Ark.MutableLootDropOverride = Self.mSets.Key(I)
		    Var Set As Ark.MutableLootItemSet = Self.mSets.Value(Override)
		    
		    If (Set Is Nil) = False Then
		      Override.Remove(Set)
		      Set.CopyFrom(Self.mTemplate)
		    Else
		      Set = New Ark.MutableLootItemSet
		      Set.CopyFrom(Self.mTemplate)
		      Self.mSets.Value(Override) = Set
		    End If
		    Override.Add(Set)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetForOverride(Override As Ark.MutableLootDropOverride) As Ark.LootItemSet
		  If Self.mSets.HasKey(Override) Then
		    Return Self.mSets.Value(Override)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Template() As Ark.MutableLootItemSet
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
		Private mTemplate As Ark.MutableLootItemSet
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
