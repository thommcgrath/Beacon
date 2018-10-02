#tag Class
Protected Class ShelfItem
Implements ObservationKit.Observable
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

	#tag Method, Flags = &h21
		Private Sub Constructor(Type As Integer)
		  Self.mType = Type
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Icon As Picture, Caption As String, Tag As String)
		  Self.mIcon = Icon
		  Self.mCaption = Caption
		  Self.mTag = Tag
		  Self.mType = TypeNormal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mPulseTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Self.NotifyObservers("PulseAmount", Self.PulseAmount)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function NewFlexibleSpacer() As ShelfItem
		  Return New ShelfItem(TypeFlexibleSpacer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function NewSpacer() As ShelfItem
		  Return New ShelfItem(TypeSpacer)
		End Function
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


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIcon
			End Get
		#tag EndGetter
		Icon As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastPulseTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotificationColor As ShelfItem.NotificationColors = ShelfItem.NotificationColors.None
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPulseTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTag As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mNotificationColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mNotificationColor <> Value Then
			    Self.mNotificationColor = Value
			    Self.mLastPulseTime = Microseconds - (Self.PulseTimeout * 1000) // To trigger a pulse immediately
			    If Value = ShelfItem.NotificationColors.None And Self.mPulseTimer <> Nil Then
			      RemoveHandler mPulseTimer.Action, WeakAddressOf mPulseTimer_Action
			      Self.mPulseTimer = Nil
			    ElseIf Value <> ShelfItem.NotificationColors.None And Self.mPulseTimer = Nil Then
			      Self.mPulseTimer = New Timer
			      Self.mPulseTimer.Period = 5
			      Self.mPulseTimer.Mode = Timer.ModeMultiple
			      AddHandler mPulseTimer.Action, WeakAddressOf mPulseTimer_Action
			    End If
			    Self.NotifyObservers("PulseAmount", 0.0)
			  End If
			End Set
		#tag EndSetter
		NotificationColor As ShelfItem.NotificationColors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Microseconds - Self.mLastPulseTime < Self.PulseTimeout * 1000 Then
			    Return 0
			  End If
			  
			  Dim Elapsed As Double = (Microseconds - Self.mLastPulseTime) - (Self.PulseTimeout * 1000)
			  Dim Amount As Double = Elapsed / (Self.PulseDuration * 1000)
			  If Amount >= 1.0 Then
			    Self.mLastPulseTime = Microseconds
			  End If
			  Return Max(Min(Amount, 1.0), 0.0)
			End Get
		#tag EndGetter
		PulseAmount As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mTag
			End Get
		#tag EndGetter
		Tag As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mType
			End Get
		#tag EndGetter
		Type As Integer
	#tag EndComputedProperty


	#tag Constant, Name = PulseDuration, Type = Double, Dynamic = False, Default = \"1000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PulseTimeout, Type = Double, Dynamic = False, Default = \"3000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeFlexibleSpacer, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeNormal, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TypeSpacer, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


	#tag Enum, Name = NotificationColors, Type = Integer, Flags = &h0
		None
		  Blue
		  Brown
		  Gray
		  Green
		  Orange
		  Pink
		  Purple
		  Red
		Yellow
	#tag EndEnum


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
		#tag ViewProperty
			Name="Caption"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tag"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
