#tag Class
Protected Class BeaconToolbarItem
Implements ObservationKit.Observable,BeaconUI.ColorAnimator, NotificationKit.Receiver
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
		Sub AnimationStep(Identifier As Text, Value As Color)
		  // Part of the BeaconUI.ColorAnimator interface.
		  
		  If Identifier = "ButtonColor" Then
		    Self.mButtonColor = Value
		    Self.NotifyObservers(Self.KeyChanged, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ButtonColor() As Color
		  Return Self.mButtonColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ButtonColor(Animated As Boolean = True, Assigns Value As Color)
		  If Self.mButtonColor = Value Then
		    Return
		  End If
		  
		  If Not Animated Then
		    Self.mButtonColor = Value
		    Self.NotifyObservers(Self.KeyChanged, Value)
		    Return
		  End If
		  
		  If Self.mColorTask <> Nil Then
		    Self.mColorTask.Cancel
		    Self.mColorTask = Nil
		  End If
		  
		  Self.mColorTask = New BeaconUI.ColorTask(Self, "ButtonColor", Self.mButtonColor, Value)
		  Self.mColorTask.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.mColorTask.DurationInSeconds = 0.25
		  Self.mColorTask.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ColorAsDouble(Source As Color) As Double
		  Return (Source.Red * 100000000) + (Source.Green * 100000) + Source.Blue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String)
		  Self.mName = Name
		  Self.mButtonColor = BeaconUI.PrimaryColor()
		  NotificationKit.Watch(Self, "UI Color Changed")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Icon As Picture, Enabled As Boolean = True)
		  Self.Constructor(Name)
		  Self.mIcon = Icon
		  Self.mEnabled = Enabled
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  NotificationKit.Ignore(Self, "UI Color Changed")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DoubleAsColor(Source As Double) As Color
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case "UI Color Changed"
		    Self.ButtonColor = Notification.UserData
		  End Select
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
			  Return Self.mEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabled <> Value Then
			    Self.mEnabled = Value
			    Self.NotifyObservers(Self.KeyChanged, Value)
			  End If
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasMenu
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasMenu <> Value Then
			    Self.mHasMenu = Value
			    Self.NotifyObservers(Self.KeyChanged, Value)
			  End If
			End Set
		#tag EndSetter
		HasMenu As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHelpTag
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mHelpTag = Value
			End Set
		#tag EndSetter
		HelpTag As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIcon <> Value Then
			    Self.mIcon = Value
			    Self.NotifyObservers(Self.KeyChanged, Value)
			  End If
			End Set
		#tag EndSetter
		Icon As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mButtonColor As Color = DefaultColor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mColorTask As BeaconUI.ColorTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasMenu As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHelpTag As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Xojo.Core.Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Rect As REALbasic.Rect
	#tag EndProperty


	#tag Constant, Name = DefaultColor, Type = Color, Dynamic = False, Default = \"&cA64DCF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyChanged, Type = Text, Dynamic = False, Default = \"", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Enabled"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasMenu"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
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
