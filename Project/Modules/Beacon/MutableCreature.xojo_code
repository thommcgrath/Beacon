#tag Class
Protected Class MutableCreature
Inherits Beacon.Creature
Implements Beacon.MutableBlueprint
	#tag Method, Flags = &h0
		Sub AlternateLabel(Assigns Value As NullableString)
		  Self.mAlternateLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, ObjectID As v4UUID)
		  Super.Constructor()
		  Self.mPath = Path
		  Self.mClassString = Beacon.ClassStringFromPath(Path)
		  Self.mObjectID = ObjectID
		  Self.mLabel = Beacon.LabelFromClassString(Self.ClassString)
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
		  
		  For I As Integer = 0 To Arr.LastRowIndex
		    Try
		      Var Dict As Dictionary = Dictionary(Arr(I))
		      If Not Dict.HasAllKeys("stat_index", "base_value", "per_level_wild_multiplier", "per_level_tamed_multiplier", "add_multiplier", "affinity_multiplier") Then
		        Continue
		      End If
		      
		      Var Index As Integer = Dict.Value("stat_index")
		      Var Stat As Beacon.Stat = Beacon.Stats.WithIndex(Index)
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
		    Catch Err As RuntimeException
		      Continue
		    End Try
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncubationTime(Assigns Value As UInt64)
		  Self.mIncubationTime = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  Tag = Beacon.NormalizeTag(Tag)
		  Var Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.RemoveRowAt(Idx)
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.AddRow(Tag)
		    Self.mTags.Sort()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatureTime(Assigns Value As UInt64)
		  Self.mMatureTime = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxMatingInterval(Assigns Value As UInt64)
		  Self.mMaxMatingInterval = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinMatingInterval(Assigns Value As UInt64)
		  Self.mMinMatingInterval = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModID(Assigns Value As v4UUID)
		  Self.mModID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModName(Assigns Value As String)
		  Self.mModName = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  Self.mPath = Value
		  Self.mClassString = Beacon.ClassStringFromPath(Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatsMask(Assigns Value As UInt16)
		  Self.mStatsMask = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  Self.mTags.ResizeTo(-1)
		  
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.AddRow(Tag)
		  Next
		  Self.mTags.Sort
		End Sub
	#tag EndMethod


End Class
#tag EndClass
