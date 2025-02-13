#tag Class
Protected Class Creature
Implements Ark.Blueprint,Beacon.DisambiguationCandidate
	#tag Method, Flags = &h0
		Function AllStatValues() As Ark.CreatureStatValue()
		  Var Values() As Ark.CreatureStatValue
		  If Self.mStats Is Nil Then
		    Return Values
		  End If
		  
		  Var Stats() As Ark.Stat = Ark.Stats.All
		  For Each Stat As Ark.Stat In Stats
		    Var Value As Ark.CreatureStatValue = Self.StatValue(Stat)
		    If (Value Is Nil) = False Then
		      Values.Add(Value)
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
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BlueprintId() As String
		  Return Self.mCreatureId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Category() As String
		  Return Ark.CategoryCreatures
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassString() As String
		  Return Self.mClassString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Ark.Creature
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.Creature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  Self.mAvailability = Ark.Maps.UniversalMask
		  Self.mStats = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Ark.Creature)
		  Self.Constructor()
		  
		  Self.mAvailability = Source.mAvailability
		  Self.mClassString = Source.mClassString
		  Self.mIncubationTime = Source.mIncubationTime
		  Self.mLabel = Source.mLabel
		  Self.mMatureTime = Source.mMatureTime
		  Self.mMaxMatingInterval = Source.mMaxMatingInterval
		  Self.mMinMatingInterval = Source.mMinMatingInterval
		  Self.mContentPackId = Source.mContentPackId
		  Self.mModified = Source.mModified
		  Self.mContentPackName = Source.mContentPackName
		  Self.mCreatureId = Source.mCreatureId
		  Self.mPath = Source.mPath
		  Self.mStats = Source.mStats.Clone
		  Self.mStatsMask = Source.mStatsMask
		  Self.mLastUpdate = Source.mLastUpdate
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Source.mTags
		    Self.mTags.Add(Tag)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackName() As String
		  Return Self.mContentPackName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateCustom(BlueprintId As String, Path As String, ClassString As String) As Ark.Creature
		  Var Creature As New Ark.Creature
		  Creature.mContentPackId = Ark.UserContentPackId
		  Creature.mContentPackName = Ark.UserContentPackName
		  
		  If BlueprintId.IsEmpty And Path.IsEmpty And ClassString.IsEmpty Then
		    // Seriously?
		    ClassString = "BeaconNoData_Character_BP_C"
		  End If
		  If Path.IsEmpty Then
		    If ClassString.IsEmpty Then
		      ClassString = BlueprintId + "_Character_BP_C"
		    End If
		    Path = Ark.UnknownBlueprintPath("Creatures", ClassString)
		  ElseIf ClassString.IsEmpty Then
		    ClassString = Ark.ClassStringFromPath(Path)
		  End If
		  If BlueprintId.IsEmpty Then
		    BlueprintId = Beacon.UUID.v5(Creature.mContentPackId.Lowercase + ":" + Path.Lowercase)
		  End If
		  
		  Creature.mClassString = ClassString
		  Creature.mPath = Path
		  Creature.mCreatureId = BlueprintId
		  Creature.mLabel = Ark.LabelFromClassString(ClassString)
		  Return Creature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureId() As String
		  Return Self.mCreatureId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationId() As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mCreatureId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationMask() As UInt64
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Self.mAvailability
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DisambiguationSuffix(Mask As UInt64) As String
		  // Part of the Beacon.DisambiguationCandidate interface.
		  
		  Return Ark.Maps.LabelForMask(Self.Availability And Mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.Creature
		  // Part of the Ark.Blueprint interface.
		  
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
		  If Self.mLabel.IsEmpty Then
		    Self.mLabel = Ark.LabelFromClassString(Self.ClassString)
		  End If
		  
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastUpdate() As Double
		  Return Self.mLastUpdate
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
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableClone() As Ark.MutableCreature
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableCreature
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "CreatureId" )  Function ObjectID() As String
		  Return Self.mCreatureId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Ark.Creature) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mCreatureId = Other.mCreatureId Then
		    Return 0
		  End If
		  
		  Return Self.Label.Compare(Other.Label, ComparisonOptions.CaseInsensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pack(Dict As JSONItem, ForAPI As Boolean)
		  #Pragma Unused ForAPI
		  
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
		    Var Stats() As JSONItem
		    Var Indexes() As Integer
		    
		    For Each Entry As DictionaryEntry In Self.mStats
		      Var StatIndex As Integer = Entry.Key
		      Var StatInfo As Dictionary = Entry.Value
		      
		      Var PackedStats As New JSONItem
		      PackedStats.Value("stat_index") = StatIndex
		      PackedStats.Value("base_value") = StatInfo.Lookup(Self.KeyBase, Self.MissingStatValue).DoubleValue
		      PackedStats.Value("per_level_wild_multiplier") = StatInfo.Lookup(Self.KeyWild, Self.MissingStatValue).DoubleValue
		      PackedStats.Value("per_level_tamed_multiplier") = StatInfo.Lookup(Self.KeyTamed, Self.MissingStatValue).DoubleValue
		      PackedStats.Value("add_multiplier") = StatInfo.Lookup(Self.KeyAdd, Self.MissingStatValue).DoubleValue
		      PackedStats.Value("affinity_multiplier") = StatInfo.Lookup(Self.KeyAffinity, Self.MissingStatValue).DoubleValue
		      
		      Stats.Add(PackedStats)
		      Indexes.Add(StatIndex)
		    Next Entry
		    
		    Indexes.SortWith(Stats)
		    Dict.Child("stats") = CreateJSON(Stats)
		  Else
		    Dict.Child("stats") = Nil
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
		Function StatAddValue(Stat As Ark.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyAdd)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatAffinityValue(Stat As Ark.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyAffinity)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatBaseValue(Stat As Ark.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyBase)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatsMask() As UInt16
		  Return Self.mStatsMask
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatTamedValue(Stat As Ark.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyTamed)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatValue(Stat As Ark.Stat) As Ark.CreatureStatValue
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
		  
		  Return New Ark.CreatureStatValue(Stat, BaseValue, WildMultiplier, TamedMultiplier, AddMultiplier, AffinityMultiplier)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatValue(Stat As Ark.Stat, Key As String) As Double
		  If Self.mStats = Nil Or Self.mStats.HasKey(Stat.Index) = False Then
		    Return Self.MissingStatValue
		  End If
		  
		  Var Dict As Dictionary = Self.mStats.Value(Stat.Index)
		  Return Dict.Lookup(Key, Self.MissingStatValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatWildValue(Stat As Ark.Stat) As Double
		  Return Self.StatValue(Stat, Self.KeyWild)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tags() As String()
		  Var Clone() As String
		  Clone.ResizeTo(Self.mTags.LastIndex)
		  For I As Integer = 0 To Self.mTags.LastIndex
		    Clone(I) = Self.mTags(I)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UsesStats() As Ark.Stat()
		  Return Ark.Stats.ForMask(Self.mStatsMask)
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
		Protected mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mContentPackName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCreatureId As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mIncubationTime As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastUpdate As Double
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

	#tag Property, Flags = &h21
		Private mModified As Boolean
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
