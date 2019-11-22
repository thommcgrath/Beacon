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
		  Return Self.mClassString
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
		    Self.mTags.AddRow(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromClass(ClassString As String) As Beacon.Creature
		  Return Creature.CreateFromPath(Beacon.UnknownBlueprintPath("Creatures", ClassString))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromPath(Path As String) As Beacon.Creature
		  Var Creature As New Beacon.Creature
		  Creature.mClassString = Beacon.ClassStringFromPath(Path)
		  Creature.mPath = Path
		  Creature.mObjectID = v4UUID.FromHash(Crypto.Algorithm.MD5, Creature.mPath.Lowercase)
		  Creature.mLabel = Beacon.LabelFromClassString(Creature.mClassString)
		  Creature.mModID = LocalData.UserModID
		  Creature.mModName = LocalData.UserModName
		  Return Creature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As Beacon.Creature
		  If Dict.HasKey("Category") = False Or Dict.Value("Category") <> Beacon.CategoryCreatures Then
		    Return Nil
		  End If
		  
		  If Not Dict.HasAllKeys("UUID", "Label", "Path", "Availability", "Tags", "ModID", "ModName", "IncubationTime", "MatureTime", "Stats") Then
		    Return Nil
		  End If
		  
		  Var Creature As New Beacon.MutableCreature(Dict.Value("Path").StringValue, Dict.Value("UUID").StringValue)
		  Creature.Label = Dict.Value("Label").StringValue
		  Creature.Availability = Dict.Value("Availability").UInt64Value
		  Creature.Tags = Dict.Value("Tags")
		  Creature.ModID = Dict.Value("ModID").StringValue
		  Creature.ModName = Dict.Value("ModName").StringValue
		  Creature.IncubationTime = Dict.Value("IncubationTime").UInt64Value
		  Creature.MatureTime = Dict.Value("MatureTime").UInt64Value
		  
		  Var Immutable As New Beacon.Creature(Creature)
		  Var StatData As Dictionary = Dict.Value("Stats")
		  Var Stats() As Beacon.Stat = Beacon.Stats.All
		  For Each Stat As Beacon.Stat In Stats
		    If StatData.HasKey(Stat.Key) Then
		      Immutable.mStats.Value(Stat.Index) = StatData.Value(Stat.Key)
		    End If
		  Next
		  Return Immutable
		End Function
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
		Function ModID() As v4UUID
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
		Function ObjectID() As v4UUID
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
		  Return Self.StatValue(Stat, Self.KeyAdd)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatAffinityValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyAffinity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatBaseValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyBase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatTamedValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyTamed)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatValue(Stat As Beacon.Stat, Key As String) As Double
		  If Self.mStats = Nil Or Self.mStats.HasKey(Stat.Index) = False Then
		    Return Self.MissingStatValue
		  End If
		  
		  Dim Dict As Dictionary = Self.mStats.Value(Stat.Index)
		  Return Dict.Lookup(Key, Self.MissingStatValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatWildValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyWild)
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

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var StatData As New Dictionary
		  Var Stats() As Beacon.Stat = Beacon.Stats.All
		  For Each Stat As Beacon.Stat In Stats
		    If Self.mStats.HasKey(Stat.Index) Then
		      StatData.Value(Stat.Key) = Self.mStats.Value(Stat.Index)
		    End If
		  Next
		  
		  Var Dict As New Dictionary
		  Dict.Value("Category") = Self.Category
		  Dict.Value("UUID") = Self.ObjectID.StringValue
		  Dict.Value("Label") = Self.Label
		  Dict.Value("Path") = Self.Path
		  Dict.Value("Availability") = Self.Availability
		  Dict.Value("Tags") = Self.Tags
		  Dict.Value("ModID") = Self.ModID.StringValue
		  Dict.Value("ModName") = Self.ModName
		  Dict.Value("IncubationTime") = Self.IncubationTime
		  Dict.Value("MatureTime") = Self.MatureTime
		  Dict.Value("Stats") = StatData
		  Return Dict
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
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
		Protected mModID As v4UUID
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mObjectID As v4UUID
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


	#tag Constant, Name = KeyAdd, Type = String, Dynamic = False, Default = \"Add", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyAffinity, Type = String, Dynamic = False, Default = \"Affinity", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyBase, Type = String, Dynamic = False, Default = \"Base", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyTamed, Type = String, Dynamic = False, Default = \"Tamed", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyWild, Type = String, Dynamic = False, Default = \"Wild", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MissingStatValue, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


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
