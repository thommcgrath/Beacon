#tag Class
Protected Class BeaconSubview
Inherits ContainerControl
Implements ObservationKit.Observable
	#tag Event
		Sub Close()
		  RaiseEvent Close
		  Self.mClosed = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  // The parent view will call down to the EnableMenuItems method
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  RaiseEvent Open
		  RaiseEvent Resize
		  
		  Self.DoubleBuffer = TargetWin32
		  Self.Transparent = Not Self.DoubleBuffer
		  Self.EraseBackground = Not Self.DoubleBuffer
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  RaiseEvent Resize
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  RaiseEvent Resize
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			If Self.ContentsChanged Then
			Call RaiseEvent ShouldSave
			End If
			Return True
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
		Function MinHeight() As UInteger
		  Return 400
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinWidth() As UInteger
		  Return 400
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
		  Return Info.FullName
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
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
		Event Resize()
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

	#tag Property, Flags = &h21
		Private mObservers As Xojo.Core.Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToolbarCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToolbarIcon As Picture
	#tag EndProperty

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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mToolbarIcon <> Nil Then
			    Return Self.mToolbarIcon
			  Else
			    Return IconGenericView
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mToolbarIcon = Value
			  Self.NotifyObservers("ToolbarIcon", Value)
			End Set
		#tag EndSetter
		ToolbarIcon As Picture
	#tag EndComputedProperty


	#tag ViewBehavior
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
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
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
			Name="Enabled"
			Visible=true
			Group="Appearance"
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
			Name="HasBackColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
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
			Name="ToolbarCaption"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToolbarIcon"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
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
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
