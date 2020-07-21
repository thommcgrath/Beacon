#tag Class
Protected Class Creature
Implements Beacon.Blueprint
	#tag Method, Flags = &h0
		Function AllStatValues() As Beacon.CreatureStatValue()
		  Var Values() As Beacon.CreatureStatValue
		  If Self.mStats Is Nil Then
		    Return Values
		  End If
		  
		  Var Stats() As Beacon.Stat = Beacon.Stats.All
		  For Each Stat As Beacon.Stat In Stats
		    Var Value As Beacon.CreatureStatValue = Self.StatValue(Stat)
		    If (Value Is Nil) = False Then
		      Values.AddRow(Value)
		    End If
		  Next
		  
		  Return Values
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AlternateLabel() As NullableString
		  Return Self.mAlternateLabel
		End Function
	#tag EndMethod

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
		Function Clone() As Beacon.Creature
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
		  Self.mClassString = Source.mClassString
		  Self.mLabel = Source.mLabel
		  Self.mModID = Source.mModID
		  Self.mModName = Source.mModName
		  Self.mIncubationTime = Source.mIncubationTime
		  Self.mMatureTime = Source.mMatureTime
		  Self.mStats = Source.mStats.Clone
		  Self.mStatsMask = Source.mStatsMask
		  Self.mMinMatingInterval = Source.mMinMatingInterval
		  Self.mMaxMatingInterval = Source.mMaxMatingInterval
		  
		  Self.mTags.ResizeTo(-1)
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
		Shared Function CreateFromObjectID(ObjectID As v4UUID) As Beacon.Creature
		  Var ObjectIDString As String = ObjectID.StringValue
		  Var Creature As Beacon.Creature = CreateFromPath(Beacon.UnknownBlueprintPath("Creatures", ObjectIDString + "_Character_BP_C"))
		  Creature.mLabel = ObjectIDString
		  Creature.mObjectID = ObjectID
		  Return Creature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromPath(Path As String) As Beacon.Creature
		  Var Creature As New Beacon.Creature
		  Creature.mClassString = Beacon.ClassStringFromPath(Path)
		  Creature.mPath = Path
		  Creature.mObjectID = v4UUID.FromHash(Crypto.HashAlgorithms.MD5, Creature.mPath.Lowercase)
		  Creature.mLabel = Beacon.LabelFromClassString(Creature.mClassString)
		  Creature.mModID = LocalData.UserModID
		  Creature.mModName = LocalData.UserModName
		  Return Creature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Beacon.Creature
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IncubationTime() As Double
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
		Function MatureTime() As Double
		  Return Self.mMatureTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxMatingInterval() As Double
		  Return Self.mMaxMatingInterval
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinMatingInterval() As Double
		  Return Self.mMinMatingInterval
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
		Function MutableClone() As Beacon.MutableCreature
		  Return New Beacon.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Beacon.MutableCreature
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
		  
		  Var SelfPath As String = Self.Path
		  Var OtherPath As String = Other.Path
		  Return SelfPath.Compare(OtherPath, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As Dictionary)
		  If Self.mIncubationTime > 0 Then
		    Dict.Value("incubation_time") = Self.mIncubationTime
		  Else
		    Dict.Value("incubation_time") = Nil
		  End If
		  
		  If Self.mMatureTime > 0 Then
		    Dict.Value("mature_time") = Self.mMatureTime
		  Else
		    Dict.Value("mature_time")= Nil
		  End If
		  
		  If (Self.mStats Is Nil) = False And Self.mStats.KeyCount > 0 Then
		    Var Stats() As Dictionary
		    Var Indexes() As Integer
		    
		    For Each Entry As DictionaryEntry In Self.mStats
		      Var StatIndex As Integer = Entry.Key
		      Var StatInfo As Dictionary = Entry.Value
		      
		      Var PackedStats As New Dictionary
		      PackedStats.Value("stat_index") = StatIndex
		      PackedStats.Value("base_value") = StatInfo.Lookup(Self.KeyBase, Self.MissingStatValue)
		      PackedStats.Value("per_level_wild_multiplier") = StatInfo.Lookup(Self.KeyWild, Self.MissingStatValue)
		      PackedStats.Value("per_level_tamed_multiplier") = StatInfo.Lookup(Self.KeyTamed, Self.MissingStatValue)
		      PackedStats.Value("add_multiplier") = StatInfo.Lookup(Self.KeyAdd, Self.MissingStatValue)
		      PackedStats.Value("affinity_multiplier") = StatInfo.Lookup(Self.KeyAffinity, Self.MissingStatValue)
		      
		      Stats.AddRow(PackedStats)
		      Indexes.AddRow(StatIndex)
		    Next
		    
		    Indexes.SortWith(Stats)
		    Dict.Value("stats") = Stats
		  Else
		    Dict.Value("stats") = Nil
		  End If
		  
		  If Self.mStatsMask > 0 Then
		    Dict.Value("used_stats") = Self.mStatsMask
		  Else
		    Dict.Value("used_stats") = Nil
		  End If
		  
		  If Self.mMinMatingInterval > 0 And Self.mMaxMatingInterval > 0 Then
		    Dict.Value("mating_interval_min") = Self.mMinMatingInterval
		    Dict.Value("mating_interval_max") = Self.mMaxMatingInterval
		  Else
		    Dict.Value("mating_interval_min") = Nil
		    Dict.Value("mating_interval_max") = Nil
		  End If
		End Sub
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
		Function StatsMask() As UInt16
		  Return Self.mStatsMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatTamedValue(Stat As Beacon.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyTamed)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatValue(Stat As Beacon.Stat) As Beacon.CreatureStatValue
		  If Stat Is Nil Or Self.mStats Is Nil Or Self.mStats.HasKey(Stat.Index) = False Then
		    Return Nil
		  End If
		  
		  Var Dict As Dictionary = Self.mStats.Value(Stat.Index)
		  Var BaseValue As Double = Dict.Lookup(Self.KeyBase, Self.MissingStatValue).DoubleValue
		  Var WildMultiplier As Double = Dict.Lookup(Self.KeyWild, Self.MissingStatValue).DoubleValue
		  Var TamedMultiplier As Double = Dict.Lookup(Self.KeyTamed, Self.MissingStatValue).DoubleValue
		  Var AddMultiplier As Double = Dict.Lookup(Self.KeyAdd, Self.MissingStatValue).DoubleValue
		  Var AffinityMultiplier As Double = Dict.Lookup(Self.KeyAffinity, Self.MissingStatValue).DoubleValue
		  If BaseValue = Self.MissingStatValue And BaseValue = WildMultiplier And WildMultiplier = TamedMultiplier And TamedMultiplier = AddMultiplier And AddMultiplier = AffinityMultiplier Then
		    Return Nil
		  End If
		  
		  Return New Beacon.CreatureStatValue(Stat, BaseValue, WildMultiplier, TamedMultiplier, AddMultiplier, AffinityMultiplier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatValue(Stat As Beacon.Stat, Key As String) As Double
		  If Self.mStats = Nil Or Self.mStats.HasKey(Stat.Index) = False Then
		    Return Self.MissingStatValue
		  End If
		  
		  Var Dict As Dictionary = Self.mStats.Value(Stat.Index)
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
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastRowIndex)
		  For I As Integer = 0 To Self.mTags.LastRowIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesStats() As Beacon.Stat()
		  Return Beacon.Stats.ForMask(Self.mStatsMask)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mAlternateLabel As NullableString
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mAvailability As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mClassString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIncubationTime As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMatureTime As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMaxMatingInterval As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mMinMatingInterval As Double
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
		Protected mStatsMask As UInt16
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
