#tag Class
Protected Class MutableEngram
Inherits Beacon.Engram
	#tag Method, Flags = &h0
		Sub AddTag(Tag As Text)
		  Tag = Self.NormalizeTag(Tag)
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
		Attributes( Deprecated = "IsTagged(""blueprintable"")" )  Sub CanBeBlueprint(Assigns Value As Boolean)
		  If Value Then
		    Self.AddTag("blueprintable")
		  Else
		    Self.RemoveTag("blueprintable")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ConsoleSafe(Assigns Value As Boolean)
		  Self.mConsoleSafe = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As Text)
		  Super.Constructor()
		  
		  Self.mPath = Path
		  Self.mIsValid = Self.mPath.Length > 6 And Self.mPath.Left(6) = "/Game/"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As Text)
		  Self.mLabel = Value
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
		  Self.mIsValid = Self.mPath.Length > 6 And Self.mPath.Left(6) = "/Game/"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTag(Tag As Text)
		  Tag = Self.NormalizeTag(Tag)
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
		    Tag = Self.NormalizeTag(Tag)
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
