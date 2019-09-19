#tag Class
Protected Class Creature
Implements Beacon.Blueprint
	#tag Method, Flags = &h0
		Function Availability() As UInt64
		  Return mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  Return Beacon.CategoryCreatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  Dim Components() As String = Self.mPath.Split("/")
		  Dim Tail As String = Components(Components.LastRowIndex)
		  Components = Tail.Split(".")
		  Return Components(Components.LastRowIndex) + "_C"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.Blueprint
		  Return New Beacon.Creature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = Beacon.Maps.All.Mask
		  Self.mStats = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.Creature)
		  Self.Constructor()
		  
		  Self.mObjectID = Source.mObjectID
		  Self.mAvailability = Source.mAvailability
		  Self.mPath = Source.mPath
		  Self.mLabel = Source.mLabel
		  Self.mModID = Source.mModID
		  Self.mModName = Source.mModName
		  Self.mIncubationTime = Source.mIncubationTime
		  Self.mMatureTime = Source.mMatureTime
		  Self.mStats = Source.mStats.Clone
		  
		  Redim Self.mTags(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Append(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IncubationTime() As UInt64
		  Return Self.mIncubationTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTagged(Tag As String) As Boolean
		  Return Self.mTags.IndexOf(Beacon.NormalizeTag(Tag)) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatureTime() As UInt64
		  Return Self.mMatureTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModID() As String
		  Return Self.mModID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ModName() As String
		  Return Self.mModName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Beacon.MutableBlueprint
		  Return New Beacon.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As String
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.Creature) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  Dim SelfPath As String = Self.Path
		  Dim OtherPath As String = Other.Path
		  Return SelfPath.Compare(OtherPath, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Return Self.mPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatAddValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, "Add")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatAffinityValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, "Affinity")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatBaseValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, "Base")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatTamedValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, "Tamed")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StatValue(Stat As Beacon.Stat, Key As String) As Double
		  If Self.mStats = Nil Or Self.mStats.HasKey(Stat.Index) = False Then
		    Return 1.0
		  End If
		  
		  Dim Dict As Dictionary = Self.mStats.Value(Stat.Index)
		  Return Dict.Lookup(Key, 1.0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatValues(Stat As Beacon.Stat, ByRef Base As Double, Wild As Double, Tamed As Double, Add As Double, Affinity As Double)
		  Base = 1.0
		  Wild = 1.0
		  Tamed = 1.0
		  Add = 1.0
		  Affinity = 1.0
		  
		  If Self.mStats = Nil Or Self.mStats.HasKey(Stat.Index) = False Then
		    Return
		  End If
		  
		  Dim Dict As Dictionary = Self.mStats.Value(Stat.Index)
		  Base = Dict.Lookup("Base", 1.0)
		  Wild = Dict.Lookup("Wild", 1.0)
		  Tamed = Dict.Lookup("Tamed", 1.0)
		  Add = Dict.Lookup("Add", 1.0)
		  Affinity = Dict.Lookup("Affinity", 1.0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatWildValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, "Wild")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  Dim Clone() As String
		  Redim Clone(Self.mTags.LastRowIndex)
		  For I As Integer = 0 To Self.mTags.LastRowIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIncubationTime As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMatureTime As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStats As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTags() As String
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
