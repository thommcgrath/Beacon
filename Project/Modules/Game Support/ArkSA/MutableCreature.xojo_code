#tag Class
Protected Class MutableCreature
Inherits ArkSA.Creature
Implements ArkSA.MutableBlueprint
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddStatValue(Values As ArkSA.CreatureStatValue)
		  If Values Is Nil Then
		    If (Self.mStats Is Nil) = False And Self.mStats.HasKey(Values.Stat.Index) Then
		      Self.mStats.Remove(Values.Stat.Index)
		    End If
		    Return
		  End If
		  
		  Var Dict As New Dictionary
		  Dict.Value(Self.KeyBase) = Values.BaseValue
		  Dict.Value(Self.KeyWild) = Values.WildMultiplier
		  Dict.Value(Self.KeyTamed) = Values.TamedMultiplier
		  Dict.Value(Self.KeyAdd) = Values.AddMultiplier
		  Dict.Value(Self.KeyAffinity) = Values.AffinityMultiplier
		  Self.mStats.Value(Values.Stat.Index) = Dict
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  If Self.mAlternateLabel = Value Then
		    Return
		  End If
		  
		  Self.mAlternateLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  If Self.mAvailability = Value Then
		    Return
		  End If
		  
		  Self.mAvailability = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BlueprintId(Assigns Value As String)
		  If Self.mCreatureId = Value Then
		    Return
		  End If
		  
		  Self.mCreatureId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearStats()
		  Self.mStats = New Dictionary
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As ArkSA.MutableCreature
		  Return New ArkSA.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Making it public
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, CreatureId As String)
		  Super.Constructor()
		  
		  Self.mCreatureId = CreatureId
		  Self.mPath = Path
		  Self.mClassString = ArkSA.ClassStringFromPath(Path)
		  Self.mAvailability = ArkSA.Maps.UniversalMask
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsumeStats(Source As String)
		  Var Arr() As Object
		  Try
		    Arr = Beacon.ParseJSON(Source)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  For I As Integer = 0 To Arr.LastIndex
		    Try
		      Var Dict As Dictionary = Dictionary(Arr(I))
		      If Not Dict.HasAllKeys("stat_index", "base_value", "per_level_wild_multiplier", "per_level_tamed_multiplier", "add_multiplier", "affinity_multiplier") Then
		        Continue
		      End If
		      
		      Var Index As Integer = Dict.Value("stat_index")
		      Var Stat As ArkSA.Stat = ArkSA.Stats.WithIndex(Index)
		      If Stat = Nil Then
		        Continue
		      End If
		      
		      Var Store As New Dictionary
		      Store.Value("Base") = Dict.Value("base_value").DoubleValue
		      Store.Value("Wild") = Dict.Value("per_level_wild_multiplier").DoubleValue
		      Store.Value("Tamed") = Dict.Value("per_level_tamed_multiplier").DoubleValue
		      Store.Value("Add") = Dict.Value("add_multiplier").DoubleValue
		      Store.Value("Affinity") = Dict.Value("affinity_multiplier").DoubleValue
		      Self.mStats.Value(Index) = Store
		      Self.Modified = True
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackId(Assigns Value As String)
		  If Self.mContentPackId = Value Then
		    Return
		  End If
		  
		  Self.mContentPackId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackName(Assigns Value As String)
		  If Self.mContentPackName = Value Then
		    Return
		  End If
		  
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreatureId(Assigns Value As String)
		  If Self.mCreatureId = Value Then
		    Return
		  End If
		  
		  Self.mCreatureId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.Creature
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return New ArkSA.Creature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncubationTime(Assigns Value As Double)
		  Self.mIncubationTime = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Tag = Beacon.NormalizeTag(Tag)
		  Var Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.RemoveAt(Idx)
		    Self.Modified = True
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.Add(Tag)
		    Self.mTags.Sort()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  If Self.mLabel = Value Then
		    Return
		  End If
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LastUpdate(Assigns Value As Double)
		  If Self.mLastUpdate = Value Then
		    Return
		  End If
		  
		  Self.mLastUpdate = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatureTime(Assigns Value As Double)
		  If Self.mMatureTime = Value Then
		    Return
		  End If
		  
		  Self.mMatureTime = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxMatingInterval(Assigns Value As Double)
		  If Self.mMaxMatingInterval = Value Then
		    Return
		  End If
		  
		  Self.mMaxMatingInterval = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinMatingInterval(Assigns Value As Double)
		  If Self.mMinMatingInterval = Value Then
		    Return
		  End If
		  
		  Self.mMinMatingInterval = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableCreature
		  // Part of the ArkSA.Blueprint interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NameTag(Assigns Value As NullableString)
		  If Self.mNameTag = Value Then
		    Return
		  End If
		  
		  Self.mNameTag = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  If Self.mPath = Value Then
		    Return
		  End If
		  
		  Self.mPath = Value
		  Self.mClassString = ArkSA.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatsMask(Assigns Value As UInt16)
		  If Self.mStatsMask = Value Then
		    Return
		  End If
		  
		  Self.mStatsMask = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the ArkSA.MutableBlueprint interface.
		  
		  Self.mTags.ResizeTo(-1)
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.Add(Tag)
		  Next
		  Self.mTags.Sort
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Unpack(Dict As JSONItem)
		  Self.mIncubationTime = Dict.FirstValue(0, "incubationTime", "incubation_time")
		  Self.mMatureTime = Dict.FirstValue(0, "matureTime", "mature_time")
		  Self.mStatsMask = Dict.FirstValue(0, "usedStats", "used_stats")
		  
		  If Dict.HasChild("stats") Then
		    Var Stats As JSONItem = Dict.Child("stats")
		    
		    Self.mStats = New Dictionary
		    For Each StatEntry As JSONEntry In Stats.Iterator
		      Var StatInfo As JSONItem = StatEntry.Value
		      Var StatIndex As Integer
		      Var Base, PerLevelWild, PerLevelTamed, Add, Affinity As Double
		      
		      If StatInfo.HasAllKeys("statIndex", "baseValue", "perLevelWildMultiplier", "perLevelTamedMultiplier", "addMultiplier", "affinityMultiplier") Then
		        StatIndex = StatInfo.Value("statIndex")
		        Base = StatInfo.Value("baseValue")
		        PerLevelWild = StatInfo.Value("perLevelWildMultiplier")
		        PerLevelTamed = StatInfo.Value("perLevelTamedMultiplier")
		        Add = StatInfo.Value("addMultiplier")
		        Affinity = StatInfo.Value("affinityMultiplier")
		      ElseIf StatInfo.HasAllKeys("stat_index", "base_value", "per_level_wild_multiplier", "per_level_tamed_multiplier", "add_multiplier", "affinity_multiplier") Then
		        StatIndex = StatInfo.Value("stat_index")
		        Base = StatInfo.Value("base_value")
		        PerLevelWild = StatInfo.Value("per_level_wild_multiplier")
		        PerLevelTamed = StatInfo.Value("per_level_tamed_multiplier")
		        Add = StatInfo.Value("add_multiplier")
		        Affinity = StatInfo.Value("affinity_multiplier")
		      Else
		        Continue
		      End If
		      
		      If StatIndex = Self.MissingStatValue Or Base = Self.MissingStatValue Or PerLevelWild = Self.MissingStatValue Or PerLevelTamed = Self.MissingStatValue Or Add = Self.MissingStatValue Or Affinity = Self.MissingStatValue Then
		        Continue
		      End If
		      
		      Var Stat As New Dictionary
		      Stat.Value(Self.KeyBase) = Base
		      Stat.Value(Self.KeyWild) = PerLevelWild
		      Stat.Value(Self.KeyTamed) = PerLevelTamed
		      Stat.Value(Self.KeyAdd) = Add
		      Stat.Value(Self.KeyAffinity) = Affinity
		      Self.mStats.Value(StatIndex) = Stat
		    Next
		  Else
		    Self.mStats = New Dictionary
		  End If
		  
		  If Dict.HasAllKeys("minMatingInterval", "maxMatingInterval") And IsNull(Dict.Value("minMatingInterval")) = False And IsNull(Dict.Value("maxMatingInterval")) = False Then
		    Self.mMinMatingInterval = Dict.Value("minMatingInterval").UInt64Value
		    Self.mMaxMatingInterval = Dict.Value("maxMatingInterval").UInt64Value
		  ElseIf Dict.HasAllKeys("mating_interval_min", "mating_interval_max") And IsNull(Dict.Value("mating_interval_min")) = False And IsNull(Dict.Value("mating_interval_max")) = False Then
		    Self.mMinMatingInterval = Dict.Value("mating_interval_min").UInt64Value
		    Self.mMaxMatingInterval = Dict.Value("mating_interval_max").UInt64Value
		  Else
		    Self.mMinMatingInterval = 0
		    Self.mMaxMatingInterval = 0
		  End If
		  
		  If Dict.HasKey("dinoNameTag") Then
		    Self.mNameTag = NullableString.FromVariant(Dict.Value("dinoNameTag"))
		  End If
		End Sub
	#tag EndMethod


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
