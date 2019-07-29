#tag Class
Protected Class MutableCreature
Inherits Beacon.Creature
Implements Beacon.MutableBlueprint
	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, ObjectID As String)
		  Super.Constructor()
		  Self.mPath = Path
		  Self.mObjectID = ObjectID
		  Self.mLabel = Beacon.LabelFromClassString(Self.ClassString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncubationTime(Assigns Value As DateInterval)
		  If Value <> Nil Then
		    Self.mIncubationTime = Value.Clone
		  Else
		    Self.mIncubationTime = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  Tag = Beacon.NormalizeTag(Tag)
		  Dim Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 And Value = False Then
		    Self.mTags.Remove(Idx)
		  ElseIf Idx = -1 And Value = True Then
		    Self.mTags.Append(Tag)
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
		Sub MatureTime(Assigns Value As DateInterval)
		  If Value <> Nil Then
		    Self.mMatureTime = Value.Clone
		  Else
		    Self.mMatureTime = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModID(Assigns Value As String)
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  Redim Self.mTags(-1)
		  
		  For Each Tag As String In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.Append(Tag)
		  Next
		  Self.mTags.Sort
		End Sub
	#tag EndMethod


End Class
#tag EndClass
