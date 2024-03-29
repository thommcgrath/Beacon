#tag Class
Protected Class ShelfItem
Implements ObservationKit.Observable
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
		  
		  Var Amount As Double = Self.PulseAmount
		  If Self.mLastPulseAmount <> Amount Then
		    Var OldAmount As Double = Self.mLastPulseAmount
		    Self.mLastPulseAmount = Amount
		    Self.NotifyObservers("PulseAmount", OldAmount, Amount)
		  End If
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
		Sub NotifyObservers(Key As String, OldValue As Variant, NewValue As Variant)
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
		    Observer.ObservedValueChanged(Self, Key, OldValue, NewValue)
		  Next
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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLoading
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mLoading = Value Then
			    Return
			  End If
			  
			  Self.mLoading = Value
			  Self.mLoadingState = 0
			  Self.mLastLoadingLoopTime = System.Microseconds
			  Self.NotifyObservers("Loading", Not Value, Value)
			End Set
		#tag EndSetter
		Loading As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mLoading = False Then
			    Return 0
			  End If
			  
			  Const Duration = 1500000
			  Var Now As Double = System.Microseconds
			  Var Elapsed As Double = Now - Self.mLastLoadingLoopTime
			  If Elapsed > Duration Then
			    Elapsed = Elapsed - (Floor(Elapsed / Duration) * Duration)
			    Self.mLastLoadingLoopTime = Now - Elapsed
			  End If
			  If Elapsed > Duration / 2 Then
			    Elapsed = Duration - Elapsed
			  End If
			  Return Elapsed / Duration
			End Get
		#tag EndGetter
		LoadingState As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastLoadingLoopTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastPulseAmount As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastPulseTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoadingState As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNotificationColor As ShelfItem.NotificationColors = ShelfItem.NotificationColors.None
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
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
			    Self.mLastPulseTime = System.Microseconds - (Self.PulseTimeout * 1000) // To trigger a pulse immediately
			    If Value = ShelfItem.NotificationColors.None And Self.mPulseTimer <> Nil Then
			      RemoveHandler mPulseTimer.Action, WeakAddressOf mPulseTimer_Action
			      Self.mPulseTimer = Nil
			    ElseIf Value <> ShelfItem.NotificationColors.None And Self.mPulseTimer = Nil Then
			      Self.mPulseTimer = New Timer
			      Self.mPulseTimer.Period = 5
			      Self.mPulseTimer.RunMode = Timer.RunModes.Multiple
			      AddHandler mPulseTimer.Action, WeakAddressOf mPulseTimer_Action
			    End If
			    Self.NotifyObservers("PulseAmount", Self.mLastPulseAmount, 0.0)
			  End If
			End Set
		#tag EndSetter
		NotificationColor As ShelfItem.NotificationColors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If System.Microseconds - Self.mLastPulseTime < Self.PulseTimeout * 1000 Then
			    Return 0
			  End If
			  
			  Var Elapsed As Double = (System.Microseconds - Self.mLastPulseTime) - (Self.PulseTimeout * 1000)
			  Var Amount As Double = Elapsed / (Self.PulseDuration * 1000)
			  If Amount >= 1.0 Then
			    Self.mLastPulseTime = System.Microseconds
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
		#tag ViewProperty
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NotificationColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ShelfItem.NotificationColors"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Blue"
				"2 - Brown"
				"3 - Gray"
				"4 - Green"
				"5 - Orange"
				"6 - Pink"
				"7 - Purple"
				"8 - Red"
				"9 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="PulseAmount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Loading"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LoadingState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
