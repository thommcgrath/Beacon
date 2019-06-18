#tag Class
Protected Class MutableCreature
Inherits Beacon.Creature
	#tag Method, Flags = &h0
		Sub AddTag(Tag As Text)
		  Tag = Beacon.NormalizeTag(Tag)
		  If Self.mTags.IndexOf(Tag) = -1 Then
		    Self.mTags.Append(Tag)
		    Self.mTags.Sort
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text)
		  Super.Constructor()
		  Self.mPath = Path
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IncubationTime(Assigns Value As Xojo.Core.DateInterval)
		  If Value <> Nil Then
		    Self.mIncubationTime = Value.Clone
		  Else
		    Self.mIncubationTime = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As Text)
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatureTime(Assigns Value As Xojo.Core.DateInterval)
		  If Value <> Nil Then
		    Self.mMatureTime = Value.Clone
		  Else
		    Self.mMatureTime = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModID(Assigns Value As Text)
		  Self.mModID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModName(Assigns Value As Text)
		  Self.mModName = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As Text)
		  Self.mPath = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTag(Tag As Text)
		  Tag = Beacon.NormalizeTag(Tag)
		  Dim Idx As Integer = Self.mTags.IndexOf(Tag)
		  If Idx > -1 Then
		    Self.mTags.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As Text)
		  Redim Self.mTags(-1)
		  
		  For Each Tag As Text In Tags
		    Tag = Beacon.NormalizeTag(Tag)
		    Self.mTags.Append(Tag)
		  Next
		  Self.mTags.Sort
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TagString(Assigns Value As Text)
		  Dim Tags() As Text = Value.Split(",")
		  Self.Tags = Tags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValidForMap(Map As Beacon.Map, Assigns Value As Boolean)
		  If Value Then
		    Self.mAvailability = Self.mAvailability Or Map.Mask
		  Else
		    Self.mAvailability = Self.mAvailability And Not Map.Mask
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
