#tag Class
Protected Class BeaconSubview
Inherits BeaconContainer
Implements ObservationKit.Observable
	#tag Event
		Sub Close()
		  RaiseEvent Close
		  Self.mClosed = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub ContentsChanged()
		  RaiseEvent ContentsChanged
		  RaiseEvent OwnerModifiedHook
		  
		  If (Self.mLinkedOmniBarItem Is Nil) = False Then
		    Self.mLinkedOmniBarItem.HasUnsavedChanges = Self.Changed
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  // The parent view will call down to the EnableMenuItems method
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  Self.Progress = Self.ProgressNone
		  RaiseEvent Open
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			If Self.IsFrontmost = False Then
			Return False
			End If
			
			If Self.Changed Then
			RaiseEvent ShouldSave(False)
			End If
		End Function
	#tag EndMenuHandler


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
		Function Busy() As Boolean
		  Return Self.mProgress > Self.ProgressNone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanBeClosed() As Boolean
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Closed() As Boolean
		  Return Self.mClosed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfirmClose() As Boolean
		  If Self.HasModifications = False Then
		    Return True
		  End If
		  
		  Self.RequestFrontmost()
		  
		  Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm("Do you want to save the changes made to the " + Self.ViewType(False, True) + " """ + Self.ViewTitle + """?", "Your changes will be lost if you don't save them.", "Save", "Cancel", "Don't Save")
		  Select Case Choice
		  Case BeaconUI.ConfirmResponses.Action
		    RaiseEvent ShouldSave(True)
		    Return False
		  Case BeaconUI.ConfirmResponses.Cancel
		    Return False
		  Case BeaconUI.ConfirmResponses.Alternate
		    Self.DiscardChanges()
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DiscardChanges()
		  RaiseEvent CleanupDiscardedChanges()
		  Self.Changed = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMenuItems()
		  If Self.IsFrontmost = False Then
		    Return
		  End If
		  
		  If Self.HasModifications Then
		    FileSave.Enabled = True
		  End If
		  
		  RaiseEvent EnableMenuItems()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasModifications() As Boolean
		  Return Self.Changed
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

	#tag Method, Flags = &h1
		Protected Sub RequestClose()
		  RaiseEvent WantsClose
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RequestFrontmost()
		  RaiseEvent WantsFrontmost()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchedFrom()
		  Self.mIsFrontmost = False
		  RaiseEvent Hidden
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchedTo(UserData As Variant = Nil)
		  Self.mIsFrontmost = True
		  RaiseEvent Shown(UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewID() As String
		  If Self.mViewID.IsEmpty Then
		    Self.mViewID = New v4UUID
		  End If
		  Return Self.mViewID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ViewID(Assigns Value As String)
		  If Self.mViewID <> Value Then
		    Var OldViewID As String = Self.mViewID
		    Self.mViewID = Value
		    Self.NotifyObservers("ViewID", OldViewID, Value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewType(Plural As Boolean, Lowercase As Boolean) As String
		  If Plural Then
		    Return If(Lowercase, "items", "Items")
		  Else
		    Return If(Lowercase, "item", "Item")
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CleanupDiscardedChanges()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContentsChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Hidden()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OwnerModifiedHook()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldSave(CloseWhenFinished As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WantsClose()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WantsFrontmost()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIsFrontmost
			End Get
		#tag EndGetter
		IsFrontmost As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mLinkedOmniBarItem
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mLinkedOmniBarItem = Value
			  
			  If (Self.mLinkedOmniBarItem Is Nil) = False Then
			    // Update the new OmniBarItem to match
			    Self.Progress = Self.Progress
			    Self.ViewTitle = Self.ViewTitle
			    Self.ViewIcon = Self.ViewIcon
			    Self.mLinkedOmniBarItem.HasUnsavedChanges = Self.Changed
			  End If
			End Set
		#tag EndSetter
		LinkedOmniBarItem As OmniBarItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mClosed As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinimumHeight
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 32)
			  If Self.mMinimumHeight <> Value Then
			    Var OldValue As Integer = Self.mMinimumHeight
			    Self.mMinimumHeight = Value
			    Self.NotifyObservers("MinimumHeight", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		MinimumHeight As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mMinimumWidth
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 32)
			  If Self.mMinimumWidth <> Value Then
			    Var OldValue As Integer = Self.mMinimumWidth
			    Self.mMinimumWidth = Value
			    Self.NotifyObservers("MinimumWidth", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		MinimumWidth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIsFrontmost As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLinkedOmniBarItem As OmniBarItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinimumHeight As Integer = 300
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinimumWidth As Integer = 400
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Double = ProgressNone
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewTitle As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProgress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value < Self.ProgressNone Then
			    Value = Self.ProgressNone
			  ElseIf Value > 1.0 Then
			    Value = Self.ProgressIndeterminate
			  End If
			  
			  If Self.mProgress <> Value Then
			    Var OldValue As Double = Self.mProgress
			    Self.mProgress = Value
			    Self.NotifyObservers("BeaconSubview.Progress", OldValue, Value)
			  End If
			  
			  If (Self.mLinkedOmniBarItem Is Nil) = False Then
			    If Value = Self.ProgressNone Then
			      Self.mLinkedOmniBarItem.HasProgressIndicator = False
			    ElseIf Value = Self.ProgressIndeterminate Then
			      Self.mLinkedOmniBarItem.HasProgressIndicator = True
			      Self.mLinkedOmniBarItem.Progress = OmniBarItem.ProgressIndeterminate
			    Else
			      Self.mLinkedOmniBarItem.HasProgressIndicator = True
			      Self.mLinkedOmniBarItem.Progress = Value
			    End If
			  End If
			End Set
		#tag EndSetter
		Progress As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mViewIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mViewIcon <> Value Then
			    Var OldValue As Picture = Self.mViewIcon
			    Self.mViewIcon = Value
			    Self.NotifyObservers("ViewIcon", OldValue, Value)
			  End If
			  
			  If (Self.mLinkedOmniBarItem Is Nil) = False Then
			    Self.mLinkedOmniBarItem.Icon = Value
			  End If
			End Set
		#tag EndSetter
		ViewIcon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mViewTitle <> "" Then
			    Return Self.mViewTitle
			  ElseIf Self.Title <> "" Then
			    Return Self.Title
			  Else
			    Return "Untitled"
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mViewTitle.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Var OldValue As String = Self.mViewTitle
			    Self.mViewTitle = Value
			    Self.NotifyObservers("ViewTitle", OldValue, Value)
			  End If
			  
			  If (Self.mLinkedOmniBarItem Is Nil) = False Then
			    Self.mLinkedOmniBarItem.Caption = Value
			  End If
			End Set
		#tag EndSetter
		ViewTitle As String
	#tag EndComputedProperty


	#tag Constant, Name = ProgressIndeterminate, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProgressNone, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


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
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="500"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="ViewTitle"
			Visible=true
			Group="Behavior"
			InitialValue="Untitled"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsFrontmost"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
