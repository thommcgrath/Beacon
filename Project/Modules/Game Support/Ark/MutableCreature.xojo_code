#tag Class
Protected Class MutableCreature
Inherits Ark.Creature
Implements Ark.MutableBlueprint
	#tag Method, Flags = &h0
		Sub AddStatValue(Values As Ark.CreatureStatValue)
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
		  Self.mAlternateLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
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
		Function Clone() As Ark.MutableCreature
		  Return New Ark.MutableCreature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, ObjectID As String)
		  Super.Constructor()
		  
		  Self.mObjectID = ObjectID
		  Self.mPath = Path
		  Self.mClassString = Beacon.ClassStringFromPath(Path)
		  Self.mAvailability = Ark.Maps.UniversalMask
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
		      Var Stat As Ark.Stat = Ark.Stats.WithIndex(Index)
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
		Sub ContentPackName(Assigns Value As String)
		  Self.mContentPackName = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContentPackUUID(Assigns Value As String)
		  Self.mContentPackUUID = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As Ark.Creature
		  // Part of the Ark.Blueprint interface.
		  
		  Return New Ark.Creature(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncubationTime(Assigns Value As Double)
		  Self.mIncubationTime = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		  // Part of the Ark.MutableBlueprint interface.
		  
		  Self.mLabel = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatureTime(Assigns Value As Double)
		  Self.mMatureTime = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxMatingInterval(Assigns Value As Double)
		  Self.mMaxMatingInterval = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinMatingInterval(Assigns Value As Double)
		  Self.mMinMatingInterval = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As Ark.MutableCreature
		  // Part of the Ark.Blueprint interface.
		  
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  Self.mPath = Value
		  Self.mClassString = Beacon.ClassStringFromPath(Value)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatsMask(Assigns Value As UInt16)
		  Self.mStatsMask = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the Ark.MutableBlueprint interface.
		  
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
		Sub Unpack(Dict As Dictionary)
		  If Dict.HasKey("incubation_time") And IsNull(Dict.Value("incubation_time")) = False Then
		    Self.mIncubationTime = Dict.Value("incubation_time").UInt64Value
		  Else
		    Self.mIncubationTime = 0
		  End If
		  
		  If Dict.HasKey("mature_time") ANd IsNull(Dict.Value("mature_time")) = False Then
		    Self.mMatureTime = Dict.Value("mature_time").UInt64Value
		  Else
		    Self.mMatureTime = 0
		  End If
		  
		  If Dict.HasKey("stats") And IsNull(Dict.Value("stats")) = False Then
		    Var Dicts() As Dictionary
		    Var Info As Introspection.TypeInfo = Introspection.GetType(Dict.Value("stats"))
		    Select Case Info.FullName
		    Case "Dictionary()"
		      Dicts = Dict.Value("stats")
		    Case "Object()"
		      Var Temp() As Object = Dict.Value("stats")
		      For Each Obj As Object In Temp
		        If (Obj Is Nil) = False And Obj IsA Dictionary Then
		          Dicts.Add(Dictionary(Obj))
		        End If
		      Next
		    End Select
		    
		    Self.mStats = New Dictionary
		    For Each StatInfo As Dictionary In Dicts
		      If Not StatInfo.HasAllKeys("stat_index", "base_value", "per_level_wild_multiplier", "per_level_tamed_multiplier", "add_multiplier", "affinity_multiplier") Then
		        Continue
		      End If
		      
		      Var StatIndex As Integer = StatInfo.Value("stat_index")
		      Var Base As Double = StatInfo.Value("base_value")
		      Var PerLevelWild As Double = StatInfo.Value("per_level_wild_multiplier")
		      Var PerLevelTamed As Double = StatInfo.Value("per_level_tamed_multiplier")
		      Var Add As Double = StatInfo.Value("add_multiplier")
		      Var Affinity As Double = StatInfo.Value("affinity_multiplier")
		      
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
		  
		  If Dict.HasKey("used_stats") And IsNull(Dict.Value("used_stats")) = False Then
		    Self.mStatsMask = Dict.Value("used_stats").UInt32Value
		  Else
		    Self.mStatsMask = 0
		  End If
		  
		  If Dict.HasAllKeys("mating_interval_min", "mating_interval_max") And IsNull(Dict.Value("mating_interval_min")) = False And IsNull(Dict.Value("mating_interval_max")) = False Then
		    Self.mMinMatingInterval = Dict.Value("mating_interval_min").UInt64Value
		    Self.mMaxMatingInterval = Dict.Value("mating_interval_max").UInt64Value
		  Else
		    Self.mMinMatingInterval = 0
		    Self.mMaxMatingInterval = 0
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
