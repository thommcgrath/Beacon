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
			If Self.ContentsChanged Then
			Return RaiseEvent ShouldSave
			End If
		End Function
	#tag EndMenuHandler


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
		  If Not Self.ContentsChanged Then
		    Return True
		  End If
		  
		  Dim Dialog As New MessageDialog
		  Dialog.Title = ""
		  Dialog.Message = "Do you want to save the changes made to the document """ + Self.Title + """?"
		  Dialog.Explanation = "Your changes will be lost if you don't save them."
		  Dialog.ActionButton.Caption = "Save…"
		  Dialog.CancelButton.Visible = True
		  Dialog.AlternateActionButton.Caption = "Don't Save"
		  Dialog.AlternateActionButton.Visible = True
		  
		  Dim Choice As MessageDialogButton = Dialog.ShowModalWithin(Self.TrueWindow)
		  Select Case Choice
		  Case Dialog.ActionButton
		    Return RaiseEvent ShouldSave()
		  Case Dialog.CancelButton
		    Return False
		  Case Dialog.AlternateActionButton
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableMenuItems()
		  If Self.ContentsChanged Then
		    FileSave.Enable
		  End If
		  
		  RaiseEvent EnableMenuItems()
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

	#tag Method, Flags = &h0
		Sub SwitchedFrom()
		  RaiseEvent Hidden
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchedTo(UserData As Auto = Nil)
		  RaiseEvent Shown(UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewID() As Text
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Self)
		  Return Info.Name
		End Function
	#tag EndMethod


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
		Event ShouldSave() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Auto = Nil)
	#tag EndHook


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
			    Self.mMinimumHeight = Value
			    Self.NotifyObservers("MinimumHeight", Value)
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
			    Self.mMinimumWidth = Value
			    Self.NotifyObservers("MinimumWidth", Value)
			  End If
			End Set
		#tag EndSetter
		MinimumWidth As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mMinimumHeight As Integer = 300
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinimumWidth As Integer = 400
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Double = ProgressNone
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToolbarCaption As String
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
			    Self.mProgress = Value
			    Self.NotifyObservers("BeaconSubview.Progress", Value)
			  End If
			End Set
		#tag EndSetter
		Progress As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mToolbarCaption <> "" Then
			    Return Self.mToolbarCaption
			  ElseIf Self.Title <> "" Then
			    Return Self.Title
			  Else
			    Return "Untitled"
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If StrComp(Self.mToolbarCaption, Value, 0) <> 0 Then
			    Self.mToolbarCaption = Value
			    Self.NotifyObservers("ToolbarCaption", Value)
			  End If
			End Set
		#tag EndSetter
		ToolbarCaption As String
	#tag EndComputedProperty


	#tag Constant, Name = ProgressIndeterminate, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProgressNone, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="500"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Background"
			Type="Picture"
			EditorType="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToolbarCaption"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumWidth"
			Visible=true
			Group="Behavior"
			InitialValue="400"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=true
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Progress"
			Group="Behavior"
			InitialValue="ProgressNone"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Windows Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
