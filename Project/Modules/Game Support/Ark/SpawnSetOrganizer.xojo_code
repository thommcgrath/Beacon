#tag Class
Protected Class SpawnSetOrganizer
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Attach(Point As Ark.MutableSpawnPointOverride, Set As Ark.SpawnPointSet = Nil)
		  If Set <> Nil Then
		    Self.mSets.Value(Point) = Set.MutableVersion
		  Else
		    Self.mSets.Value(Point) = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Ark.MutableSpawnPointSet()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Template As Ark.SpawnPointSet)
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Ark.MutableSpawnPointSet(Template)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueSetLabel(Label As String) As String
		  Var Siblings() As String
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Override As Ark.SpawnPointOverride = Entry.Key
		    For Each Set As Ark.SpawnPointSet In Override
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
		    Var Overrides() As Ark.MutableSpawnPointOverride = Self.Overrides
		    For Each Override As Ark.MutableSpawnPointOverride In Overrides
		      OverrideNames.Add(Override.Label)
		    Next
		    OverrideNames.Sort
		    Self.mSubLabel = Language.EnglishOxfordList(OverrideNames)
		  End If
		  
		  Return Self.Template.Label + EndOfLine + Self.mSubLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Set As Ark.SpawnPointSet) As Boolean
		  If Self.mTemplate.SetId = Set.SetId Or Self.mTemplate.Hash = Set.Hash Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var OtherSet As Ark.SpawnPointSet = Entry.Value
		    If OtherSet.SetId = Set.SetId or OtherSet.Hash = Set.Hash Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Values() As String) As Boolean
		  Var PossibleValues() As String
		  PossibleValues.Add(Self.mTemplate.SetId)
		  PossibleValues.Add(Self.mTemplate.Hash)
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Set As Ark.SpawnPointSet = Entry.Value
		    PossibleValues.Add(Set.SetId)
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
		Function Matches(ParamArray Values() As String) As Boolean
		  Return Self.Matches(Values)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overrides() As Ark.MutableSpawnPointOverride()
		  Var Arr() As Ark.MutableSpawnPointOverride
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
		    Var Override As Ark.MutableSpawnPointOverride = Self.mSets.Key(I)
		    Var Set As Ark.MutableSpawnPointSet = Self.mSets.Value(Override)
		    
		    If (Set Is Nil) = False Then
		      Override.Remove(Set)
		      Set.CopyFrom(Self.mTemplate)
		    Else
		      Set = New Ark.MutableSpawnPointSet
		      Set.CopyFrom(Self.mTemplate)
		      Self.mSets.Value(Override) = Set
		    End If
		    Override.Add(Set)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetForOverride(Override As Ark.MutableSpawnPointOverride) As Ark.SpawnPointSet
		  If Self.mSets.HasKey(Override) Then
		    Return Self.mSets.Value(Override)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLimit(CreatureRef As Ark.BlueprintReference, Limit As NullableDouble, OnlyIfNotSet As Boolean)
		  Var Bound As Integer = Self.mSets.KeyCount - 1
		  For I As Integer = 0 To Bound
		    Var Override As Ark.MutableSpawnPointOverride = Self.mSets.Key(I)
		    If OnlyIfNotSet = False Or Override.Limit(CreatureRef) = 1 Then
		      Override.Limit(CreatureRef) = Limit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Template() As Ark.MutableSpawnPointSet
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
		Private mTemplate As Ark.MutableSpawnPointSet
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
