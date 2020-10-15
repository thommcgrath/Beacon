#tag Class
Protected Class ItemSetCollection
Implements Beacon.Countable
	#tag Method, Flags = &h0
		Function Append(Set As Beacon.ItemSet, Replace As Boolean = False) As Beacon.ItemSet
		  // If the set is already in this collection, create a new one
		  Var Idx As Integer = Self.IndexOf(Set)
		  If Idx > -1 Then
		    If Replace Then
		      // Remove the set so it is not counted when finding a unique label
		      Self.mItemSets.RemoveAt(Idx)
		    Else
		      // Create a new item set. Use CopyFrom so the identifier is not copied
		      Var Clone As New Beacon.ItemSet
		      Clone.CopyFrom(Set)
		      Set = Clone
		    End If
		  End If
		  
		  Var Labels() As String
		  Labels.ResizeTo(Self.mItemSets.LastRowIndex)
		  For I As Integer = 0 To Labels.LastRowIndex
		    Labels(I) = Self.mItemSets(I).Label
		  Next
		  
		  Set.Label = Beacon.FindUniqueLabel(Set.Label, Labels)
		  
		  Self.mItemSets.Add(Set)
		  Self.mModified = True
		  
		  Return Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AtIndex(Idx As Integer) As Beacon.ItemSet
		  Return Self.mItemSets(Idx)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AtIndex(Idx As Integer, Assigns Set As Beacon.ItemSet)
		  Self.mItemSets(Idx) = Set
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  If Self.mItemSets.LastRowIndex = -1 Then
		    Return
		  End If
		  
		  Self.mItemSets.ResizeTo(-1)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As Beacon.ItemSetCollection
		  Return New Beacon.ItemSetCollection(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mModified = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.ItemSetCollection)
		  Self.Constructor()
		  
		  If Source Is Nil Then
		    Return
		  End If
		  
		  Self.mModified = Source.mModified
		  Self.mItemSets.ResizeTo(Source.mItemSets.LastRowIndex)
		  For Idx As Integer = 0 To Source.mItemSets.LastRowIndex
		    Self.mItemSets(Idx) = New Beacon.ItemSet(Source.mItemSets(Idx))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Part of the Beacon.Countable interface.
		  
		  Return Self.mItemSets.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromSaveData(SaveData As Variant) As Beacon.ItemSetCollection
		  Var Sets As New Beacon.ItemSetCollection
		  
		  If IsNull(SaveData) Or SaveData.IsArray = False Or SaveData.ArrayElementType <> Variant.TypeObject Then
		    Return Sets
		  End If
		  
		  Var Dicts() As Variant
		  Try
		    Dicts = SaveData
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Casting SaveData to array")
		    Return Sets
		  End Try
		  
		  For Idx As Integer = 0 To Dicts.LastRowIndex
		    Try
		      Var Dict As Variant = Dicts(Idx)
		      If IsNull(Dict) Or Dict.IsArray = True Or Dict.Type <> Variant.TypeObject Or (Dict.ObjectValue IsA Dictionary) = False Then
		        Continue
		      End If
		      
		      Var Set As Beacon.ItemSet = Beacon.ItemSet.ImportFromBeacon(Dictionary(Dict))
		      Call Sets.Append(Set)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Reading item set dictionary #" + Str(Idx, "-0"))
		    End Try
		  Next
		  
		  Sets.Modified = False
		  Return Sets
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Set As Beacon.ItemSet) As Integer
		  For Idx As Integer = 0 To Self.mItemSets.LastRowIndex
		    If Self.mItemSets(Idx) = Set Then
		      Return Idx
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Var Sets() As Variant
		  For Each Set As Beacon.ItemSet In Self.mItemSets
		    Sets.Add(Set)
		  Next
		  Return New Beacon.GenericIterator(Sets)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mModified = True Then
		    Return True
		  End If
		  
		  For Each Set As Beacon.ItemSet In Self.mItemSets
		    If Set.Modified Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		  
		  If Self.mModified = True Then
		    Return
		  End If
		  
		  For Each Set As Beacon.ItemSet In Self.mItemSets
		    Set.Modified = False
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Set As Beacon.ItemSet)
		  Var Idx As Integer = Self.IndexOf(Set)
		  Self.Remove(Idx)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Idx As Integer)
		  Self.mItemSets.RemoveAt(Idx)
		  Self.mModified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SaveData() As Dictionary()
		  Var Sets() As Dictionary
		  For Each Set As Beacon.ItemSet In Self.mItemSets
		    Var Dict As Dictionary = Set.Export
		    If Dict Is Nil Then
		      Continue
		    End If
		    Sets.Add(Dict)
		  Next
		  Return Sets
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mItemSets() As Beacon.ItemSet
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModified As Boolean
	#tag EndProperty


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
