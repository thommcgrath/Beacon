#tag Class
Protected Class SpawnSetOrganizer
Implements Beacon.NamedItem
	#tag Method, Flags = &h0
		Sub Attach(Point As Beacon.MutableSpawnPoint, Set As Beacon.SpawnPointSet = Nil)
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
		  Self.mTemplate = New Beacon.MutableSpawnPointSet()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Template As Beacon.SpawnPointSet)
		  Self.mSets = New Dictionary
		  Self.mTemplate = New Beacon.MutableSpawnPointSet(Template)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindUniqueSetLabel(Label As String) As String
		  Var Siblings() As String
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Point As Beacon.SpawnPoint = Entry.Key
		    For Each Set As Beacon.SpawnPointSet In Point
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
		    Var PointNames() As String
		    Var Points() As Beacon.MutableSpawnPoint = Self.Points
		    For Each Point As Beacon.MutableSpawnPoint In Points
		      PointNames.AddRow(Point.Label)
		    Next
		    PointNames.Sort
		    Self.mSubLabel = Language.EnglishOxfordList(PointNames)
		  End If
		  
		  Return Self.Template.Label + EndOfLine + Self.mSubLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Set As Beacon.SpawnPointSet) As Boolean
		  If Self.mTemplate.ID = Set.ID Or Self.mTemplate.Hash = Set.Hash Then
		    Return True
		  End If
		  
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var OtherSet As Beacon.SpawnPointSet = Entry.Value
		    If OtherSet.ID = Set.ID or OtherSet.Hash = Set.Hash Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(Values() As String) As Boolean
		  Var PossibleValues() As String
		  PossibleValues.AddRow(Self.mTemplate.ID)
		  PossibleValues.AddRow(Self.mTemplate.Hash)
		  For Each Entry As DictionaryEntry In Self.mSets
		    Var Set As Beacon.SpawnPointSet = Entry.Value
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
		Function Matches(ParamArray Values() As String) As Boolean
		  Return Self.Matches(Values)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Points() As Beacon.MutableSpawnPoint()
		  Var Arr() As Beacon.MutableSpawnPoint
		  For Each Entry As DictionaryEntry In Self.mSets
		    Arr.AddRow(Entry.Key)
		  Next
		  Return Arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Replicate()
		  Var Bound As Integer = Self.mSets.KeyCount - 1
		  For I As Integer = 0 To Bound
		    Var Point As Beacon.MutableSpawnPoint = Self.mSets.Key(I)
		    Var Set As Beacon.MutableSpawnPointSet = Self.mSets.Value(Point)
		    
		    If Set <> Nil Then
		      Point.RemoveSet(Set)
		      Set.CopyFrom(Self.mTemplate)
		    Else
		      Set = New Beacon.MutableSpawnPointSet(Self.mTemplate)
		      Self.mSets.Value(Point) = Set
		    End If
		    Point.AddSet(Set, True)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetForPoint(Point As Beacon.MutableSpawnPoint) As Beacon.SpawnPointSet
		  If Self.mSets.HasKey(Point) Then
		    Return Self.mSets.Value(Point)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLimit(Creature As Beacon.Creature, Limit As NullableDouble, OnlyIfNotSet As Boolean)
		  Var Bound As Integer = Self.mSets.KeyCount - 1
		  For I As Integer = 0 To Bound
		    Var Point As Beacon.MutableSpawnPoint = Self.mSets.Key(I)
		    If OnlyIfNotSet = False Or Point.Limit(Creature) = 1 Then
		      Point.Limit(Creature) = Limit
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Template() As Beacon.MutableSpawnPointSet
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
		Private mTemplate As Beacon.MutableSpawnPointSet
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
