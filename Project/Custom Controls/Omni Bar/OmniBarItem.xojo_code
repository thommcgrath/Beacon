#tag Class
Protected Class OmniBarItem
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
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.AddRow(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Name As String, Caption As String, Icon As Picture = Nil)
		  Self.mActiveColor = OmniBarItem.ActiveColors.Accent
		  Self.mAlwaysUseActiveColor = False
		  Self.mCanBeClosed = False
		  Self.mCaption = Caption
		  Self.mEnabled = True
		  Self.mHasProgressIndicator = False
		  Self.mHasUnsavedChanges = False
		  Self.mHelpTag = ""
		  Self.mIcon = Icon
		  Self.mName = Name
		  Self.mProgress = OmniBarItem.ProgressIndeterminate
		End Sub
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
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, Value)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As OmniBarItem) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Return Self.mName.Compare(Other.mName, ComparisonOptions.CaseSensitive)
		End Function
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
		  
		  For I As Integer = Refs.LastRowIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveRowAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mActiveColor <> Value Then
			    Self.mActiveColor = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		ActiveColor As OmniBarItem.ActiveColors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAlwaysUseActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAlwaysUseActiveColor <> Value Then
			    Self.mAlwaysUseActiveColor = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		AlwaysUseActiveColor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCanBeClosed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCanBeClosed <> Value Then
			    Self.mCanBeClosed = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		CanBeClosed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCaption.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mCaption = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

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
			    Self.NotifyObservers("Changed", Value)
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
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		HasMenu As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasProgressIndicator
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasProgressIndicator <> Value Then
			    Self.mHasProgressIndicator = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		HasProgressIndicator As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasUnsavedChanges
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasUnsavedChanges <> Value Then
			    Self.mHasUnsavedChanges = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		HasUnsavedChanges As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHelpTag
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHelpTag.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mHelpTag = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
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
			  Self.mIcon = Value
			  Self.NotifyObservers("Changed", Value)
			End Set
		#tag EndSetter
		Icon As Picture
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActiveColor As OmniBarItem.ActiveColors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAlwaysUseActiveColor As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCanBeClosed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasMenu As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasProgressIndicator As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasUnsavedChanges As Boolean
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
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToggled As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProgress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProgress <> Value Then
			    Self.mProgress = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		Progress As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mToggled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mToggled <> Value Then
			    Self.mToggled = Value
			    Self.NotifyObservers("Changed", Value)
			  End If
			End Set
		#tag EndSetter
		Toggled As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = ProgressIndeterminate, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ActiveColors, Type = Integer, Flags = &h0
		Accent
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
		#tag ViewProperty
			Name="ActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBarItem.ActiveColors"
			EditorType="Enum"
			#tag EnumValues
				"0 - Accent"
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
			Name="AlwaysUseActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanBeClosed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasProgressIndicator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasUnsavedChanges"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
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
			Name="Progress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasMenu"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Toggled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
