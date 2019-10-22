#tag Class
Protected Class MutableSpawnPoint
Inherits Beacon.SpawnPoint
Implements Beacon.MutableBlueprint
	#tag Method, Flags = &h0
		Sub Availability(Assigns Value As UInt64)
		  // Part of the Beacon.MutableBlueprint interface.
		  
		  Self.mAvailability = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Path As String, ObjectID As String)
		  Super.Constructor()
		  Self.mObjectID = ObjectID
		  Self.Path = Path
		  Self.Label = Beacon.LabelFromClassString(Self.ClassString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTagged(Tag As String, Assigns Value As Boolean)
		  // Part of the Beacon.MutableBlueprint interface.
		  
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
		  // Part of the Beacon.MutableBlueprint interface.
		  
		  Self.mLabel = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModID(Assigns Value As String)
		  // Part of the Beacon.MutableBlueprint interface.
		  
		  Self.mModID = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModName(Assigns Value As String)
		  // Part of the Beacon.MutableBlueprint interface.
		  
		  Self.mModName = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns Value As String)
		  // Part of the Beacon.MutableBlueprint interface.
		  
		  Self.mPath = Value
		  
		  Var Components() As String = Value.Split("/")
		  Var Tail As String = Components(Components.LastRowIndex)
		  Components = Tail.Split(".")
		  Self.mClassString = Components(Components.LastRowIndex) + "_C"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetsAsJSON(Assigns Value As String)
		  Var Parsed As Variant
		  Try
		    Parsed = Beacon.ParseJSON(Value)
		  Catch Err As RuntimeException
		    Return
		  End Try
		  
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tags(Assigns Tags() As String)
		  // Part of the Beacon.MutableBlueprint interface.
		  
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
