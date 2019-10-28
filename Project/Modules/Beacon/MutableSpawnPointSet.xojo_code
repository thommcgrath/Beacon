#tag Class
Protected Class MutableSpawnPointSet
Inherits Beacon.SpawnPointSet
	#tag Method, Flags = &h0
		Sub Append(Entry As Beacon.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx = -1 Then
		    Self.mEntries.AddRow(Entry.ImmutableVersion)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Just making it public
		  Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Entries(Assigns NewEntries() As Beacon.SpawnPointSetEntry)
		  Self.mEntries.ResizeTo(NewEntries.LastRowIndex)
		  For I As Integer = 0 To NewEntries.LastRowIndex
		    Self.mEntries(I) = NewEntries(I).ImmutableVersion
		  Next
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GroupOffset(Assigns Offset As Beacon.Point3D)
		  If Self.mGroupOffset <> Offset Then
		    Self.mGroupOffset = New Beacon.Point3D(Offset)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Label(Assigns Value As String)
		  If Self.mLabel.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Current) <> 0 Then
		    Self.mLabel = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OverridesSpreadRadius(Assigns Value As Boolean)
		  If Self.mIncludeSpreadRadius <> Value Then
		    Self.mIncludeSpreadRadius = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OverridesWaterOnlyMinimumHeight(Assigns Value As Boolean)
		  If Self.mIncludeWaterOnlyMinimumHeight <> Value Then
		    Self.mIncludeWaterOnlyMinimumHeight = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Entry As Beacon.SpawnPointSetEntry)
		  Var Idx As Integer = Self.IndexOf(Entry)
		  If Idx > -1 Then
		    Self.mEntries.RemoveRowAt(Idx)
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(AtIndex As Integer)
		  Self.mEntries.RemoveRowAt(AtIndex)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SpreadRadius(Assigns Value As Double)
		  If Self.mSpreadRadius <> Value Or Self.mIncludeSpreadRadius = False Then
		    Self.mSpreadRadius = Value
		    Self.mIncludeSpreadRadius = True
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WaterOnlyMinimumHeight(Assigns Value As Double)
		  If Self.mWaterOnlyMinimumHeight <> Value Or Self.mIncludeWaterOnlyMinimumHeight = False Then
		    Self.mWaterOnlyMinimumHeight = Value
		    Self.mIncludeWaterOnlyMinimumHeight = True
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Weight(Assigns Value As Double)
		  Value = Abs(Value)
		  If Self.mWeight <> Value Then
		    Self.mWeight = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod


End Class
#tag EndClass
