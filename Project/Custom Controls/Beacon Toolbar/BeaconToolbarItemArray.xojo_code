#tag Class
Protected Class BeaconToolbarItemArray
Implements Xojo.Core.Iterable,ObservationKit.Observable,ObservationKit.Observer
	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As Text)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Xojo.Core.Dictionary
		  End If
		  
		  Dim Refs() As Xojo.Core.WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = UBound(Refs) DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.Remove(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.Append(Xojo.Core.WeakRef.Create(Observer))
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Append(Item As BeaconToolbarItem)
		  Self.mItems.Append(Item)
		  
		  If Item <> Nil Then
		    Item.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Self.mItems.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  Return New BeaconToolbarItemIterator(Self.mItems)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Item As BeaconToolbarItem) As Integer
		  For I As Integer = 0 To Self.mItems.Ubound
		    If Self.mItems(I) = Item Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Item As BeaconToolbarItem)
		  Self.mItems.Insert(Index, Item)
		  
		  If Item <> Nil Then
		    Item.AddObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As Text, Value As Auto)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Xojo.Core.Dictionary
		  End If
		  
		  Dim Refs() As Xojo.Core.WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = UBound(Refs) DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.Remove(I)
		      Continue
		    End If
		    
		    Dim Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ObservedValueChanged(Source As ObservationKit.Observable, Key As Text, Value As Auto)
		  // Part of the ObservationKit.Observer interface.
		  
		  #Pragma Unused Source
		  
		  Self.NotifyObservers(Key, Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Redim(NewBound As Integer)
		  If NewBound = Self.mItems.Ubound Then
		    Return
		  End If
		  
		  For I As Integer = Self.mItems.Ubound DownTo NewBound + 1
		    Dim OldValue As BeaconToolbarItem = Self.mItems(I)
		    If OldValue <> Nil Then
		      OldValue.RemoveObserver(Self, BeaconToolbarItem.KeyChanged)
		    End If
		  Next
		  
		  Redim Self.mItems(NewBound)
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
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
		    Dim OldValue As BeaconToolbarItem = Self.mItems(Index)
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
		Sub Remove(Index As Integer)
		  Dim OldValue As BeaconToolbarItem = Self.mItems(Index)
		  If OldValue <> Nil Then
		    OldValue.RemoveObserver(Self, BeaconToolbarItem.KeyChanged)
		  End If
		  
		  Self.mItems.Remove(Index)
		  
		  Self.NotifyObservers(BeaconToolbarItem.KeyChanged, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As Text)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Xojo.Core.Dictionary
		  End If
		  
		  Dim Refs() As Xojo.Core.WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = UBound(Refs) DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.Remove(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UBound() As Integer
		  Return Self.mItems.Ubound
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mItems() As BeaconToolbarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Xojo.Core.Dictionary
	#tag EndProperty


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
