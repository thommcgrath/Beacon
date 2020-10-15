#tag Class
Protected Class BeaconToolbarItemArray
Implements ObservationKit.Observable,ObservationKit.Observer,Iterable
	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.Add(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Append(Item As BeaconToolbarItem)
		  Self.mItems.Add(Item)
		  
		  If Item <> Nil Then
		    Item.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.LastIndex + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As BeaconToolbarItem) As Integer
		  For I As Integer = 0 To Self.mItems.LastIndex
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As BeaconToolbarItem)
		  Self.mItems.AddAt(Index, Item)
		  
		  If Item <> Nil Then
		    Item.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  Return New BeaconToolbarItemIterator(Self.mItems)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastRowIndex() As Integer
		  Return Self.mItems.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As String, Value As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As String, Value As Variant)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  
		  Self.NotifyObservers(Key, Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As BeaconToolbarItem
		  Return Self.mItems(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Value As BeaconToolbarItem)
		  If Self.mItems(Index) <> Nil Then
		    Var OldValue As BeaconToolbarItem = Self.mItems(Index)
		    OldValue.RemoveObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.mItems(Index) = Value
		  
		  If Value <> Nil Then
		    Value.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Item As BeaconToolbarItem)
		  Var Idx As Integer = Self.IndexOf(Item)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Var OldValue As BeaconToolbarItem = Self.mItems(Index)
		  If OldValue <> Nil Then
		    OldValue.RemoveObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.mItems.RemoveAt(Index)
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(NewBound As Integer)
		  If NewBound = Self.mItems.LastIndex Then
		    Return
		  End If
		  
		  For I As Integer = Self.mItems.LastIndex DownTo NewBound + 1
		    Var OldValue As BeaconToolbarItem = Self.mItems(I)
		    If OldValue <> Nil Then
		      OldValue.RemoveObserver(Self, BeaconToolbarItem.KeyChanged)
		    End If
		  Next
		  
		  Self.mItems.ResizeTo(NewBound)
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mItems() As BeaconToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
