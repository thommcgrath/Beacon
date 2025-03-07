#tag Class
Protected Class MoveTask
Inherits AnimationKit.DeltaTask
	#tag CompatibilityFlags = ( TargetHasGUI )
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  If Final Then
		    Self.ApplyRect(Self.EndBounds)
		    Return
		  End If
		  
		  Var Elapsed As Double = Self.ElapsedTime(Time)
		  Var Duration As Double = Self.DurationInSeconds * 1000000
		  Var RectTop As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartBounds.Top, Self.EndBounds.Top)
		  Var RectLeft As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartBounds.Left, Self.EndBounds.Left)
		  Var RectWidth As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartBounds.Width, Self.EndBounds.Width)
		  Var RectHeight As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartBounds.Height, Self.EndBounds.Height)
		  
		  Self.ApplyRect(New Rect(Floor(RectLeft), Floor(RectTop), Ceiling(RectWidth), Ceiling(RectHeight)))
		End Sub
	#tag EndEvent

	#tag Event
		Sub Started()
		  Self.StartBounds = Self.CurrentRect()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21, CompatibilityFlags = (TargetHasGUI)
		Private Sub ApplyRect(Target As DesktopUIControl, Rect As Rect)
		  If Self.AnimateLeft Then
		    Target.Left = Rect.Left
		  End If
		  If Self.AnimateTop Then
		    Target.Top = Rect.Top
		  End If
		  If Self.AnimateWidth Then
		    Target.Width = Rect.Width
		  End If
		  If Self.AnimateHeight Then
		    Target.Height = Rect.Height
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetHasGUI)
		Private Sub ApplyRect(Target As DesktopWindow, Rect As Rect)
		  If Self.AnimateLeft Then
		    Target.Left = Rect.Left
		  End If
		  If Self.AnimateTop Then
		    Target.Top = Rect.Top
		  End If
		  If Self.AnimateWidth Then
		    Target.Width = Rect.Width
		  End If
		  If Self.AnimateHeight Then
		    Target.Height = Rect.Height
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS)
		Private Sub ApplyRect(Target As iOSControl, Rect As Rect)
		  // This is left in as a stub. iOSControl cannot move, so this entire
		  // task is useless on iOS.
		  
		  If Self.AnimateLeft Then
		    Target.Left = Rect.Left
		  End If
		  If Self.AnimateTop Then
		    Target.Top = Rect.Top
		  End If
		  If Self.AnimateWidth Then
		    Target.Width = Rect.Width
		  End If
		  If Self.AnimateHeight Then
		    Target.Height = Rect.Height
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI) or  (TargetIOS)
		Private Sub ApplyRect(Rect As Rect)
		  Var Item As Object = Self.Item
		  
		  If Item = Nil Then
		    Return
		  End If
		  
		  #if TargetDesktop
		    If Item IsA DesktopWindow Then
		      Self.ApplyRect(DesktopWindow(Item), Rect)
		      Return
		    ElseIf Item IsA DesktopUIControl Then
		      Self.ApplyRect(DesktopUIControl(Item), Rect)
		      Return
		    End If
		  #elseif TargetiOS
		    If Item IsA iOSControl Then
		      Self.ApplyRect(iOSControl(Item), Rect)
		      Return
		    End If
		  #endif
		  
		  Var Err As New UnsupportedOperationException
		  #if TargetDesktop
		    Err.Message = "Item for AnimationKit.MoveTask must be a DesktopWindow or DesktopUIControl."
		  #elseif TargetiOS
		    Err.Message = "Item for AnimationKit.MoveTask must be an iOSControl."
		  #endif
		  Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1021
		Private Sub Constructor()
		  Self.Curve = AnimationKit.Curve.CreateFromPreset(AnimationKit.Curve.Presets.Linear)
		  Self.DurationInSeconds = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000, CompatibilityFlags = (TargetHasGUI)
		Sub Constructor(Target As DesktopUIControl)
		  Self.Constructor()
		  Self.StartBounds = Nil
		  Self.EndBounds = Self.CurrentRect(Target)
		  Self.Item = Target
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000, CompatibilityFlags = (TargetHasGUI)
		Sub Constructor(Target As DesktopWindow)
		  Self.Constructor()
		  Self.StartBounds = Nil
		  Self.EndBounds = Self.CurrentRect(Target)
		  Self.Item = Target
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000, CompatibilityFlags = (TargetIOS)
		Sub Constructor(Target As iOSControl)
		  Self.Constructor()
		  Self.StartBounds = Nil
		  Self.EndBounds = Self.CurrentRect(Target)
		  Self.Item = Target
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI) or  (TargetIOS)
		Private Function CurrentRect() As Xojo.Rect
		  Var Item As Object = Self.Item
		  
		  If Item = Nil Then
		    Return Nil
		  End If
		  
		  #if TargetDesktop
		    If Item IsA DesktopWindow Then
		      Return Self.CurrentRect(DesktopWindow(Item))
		    ElseIf Item IsA DesktopUIControl Then
		      Return Self.CurrentRect(DesktopUIControl(Item))
		    End If
		  #elseif TargetiOS
		    If Item IsA iOSControl Then
		      Return Self.CurrentRect(iOSControl(Item))
		    End If
		  #endif
		  
		  Var Err As New UnsupportedOperationException
		  #if TargetDesktop
		    Err.Message = "Item for AnimationKit.MoveTask must be a DesktopWindow or DesktopUIControl."
		  #elseif TargetiOS
		    Err.Message = "Item for AnimationKit.MoveTask must be an iOSControl."
		  #endif
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetHasGUI)
		Private Function CurrentRect(Target As DesktopUIControl) As Xojo.Rect
		  Return New Xojo.Rect(Target.Left, Target.Top, Target.Width, Target.Height)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetHasGUI)
		Private Function CurrentRect(Target As DesktopWindow) As Xojo.Rect
		  Return New Xojo.Rect(Target.Left, Target.Top, Target.Width, Target.Height)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS)
		Private Function CurrentRect(Target As iOSControl) As Xojo.Rect
		  Return New Xojo.Rect(Target.Left, Target.Top, Target.Width, Target.Height)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisableValues(ParamArray Keys() As UInt64)
		  For Each Key As UInt8 In Keys
		    Self.AnimationKeys = (Self.AnimationKeys And (Not Key))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnableValues(ParamArray Keys() As UInt64)
		  For Each Key As UInt8 In Keys
		    Self.AnimationKeys = (Self.AnimationKeys Or Key)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI) or  (TargetIOS)
		Function OriginalRect() As Rect
		  If (Self.StartBounds Is Nil) = False Then
		    Return CloneRect(Self.StartBounds)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI) or  (TargetIOS)
		Sub SetDestination(Source As Xojo.Rect)
		  Var CurrentBounds As Xojo.Rect = Self.CurrentRect()
		  Self.EndBounds = New Xojo.Rect(Source.Left, Source.Top, Source.Width, Source.Height)
		  Self.AnimationKeys = 0
		  If Self.EndBounds.Left <> CurrentBounds.Left Then
		    Self.EnableValues(Self.KeyLeft)
		  End If
		  If Self.EndBounds.Top <> CurrentBounds.Top Then
		    Self.EnableValues(Self.KeyTop)
		  End If
		  If Self.EndBounds.Width <> CurrentBounds.Width Then
		    Self.EnableValues(Self.KeyWidth)
		  End If
		  If Self.EndBounds.Height <> CurrentBounds.Height Then
		    Self.EnableValues(Self.KeyHeight)
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyHeight, UInt64)) = CType(Self.KeyHeight, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyHeight)
			  Else
			    Self.DisableValues(Self.KeyHeight)
			  End If
			End Set
		#tag EndSetter
		AnimateHeight As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyLeft, UInt64)) = CType(Self.KeyLeft, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyLeft)
			  Else
			    Self.DisableValues(Self.KeyLeft)
			  End If
			End Set
		#tag EndSetter
		AnimateLeft As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyTop, UInt64)) = CType(Self.KeyTop, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyTop)
			  Else
			    Self.DisableValues(Self.KeyTop)
			  End If
			End Set
		#tag EndSetter
		AnimateTop As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyWidth, UInt64)) = CType(Self.KeyWidth, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyWidth)
			  Else
			    Self.DisableValues(Self.KeyWidth)
			  End If
			End Set
		#tag EndSetter
		AnimateWidth As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private AnimationKeys As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EndBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndBounds.Height
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndBounds = New Rect(Self.EndBounds.Left, Self.EndBounds.Top, Self.EndBounds.Width, Value)
			  Self.EnableValues(Self.KeyHeight)
			End Set
		#tag EndSetter
		Height As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndBounds.Left
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndBounds = New Rect(Value, Self.EndBounds.Top, Self.EndBounds.Width, Self.EndBounds.Height)
			  Self.EnableValues(Self.KeyLeft)
			End Set
		#tag EndSetter
		Left As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private StartBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndBounds.Top
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndBounds = New Rect(Self.EndBounds.Left, Value, Self.EndBounds.Width, Self.EndBounds.Height)
			  Self.EnableValues(Self.KeyTop)
			End Set
		#tag EndSetter
		Top As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndBounds.Width
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndBounds = New Rect(Self.EndBounds.Left, Self.EndBounds.Top, Value, Self.EndBounds.Height)
			  Self.EnableValues(Self.KeyWidth)
			End Set
		#tag EndSetter
		Width As Integer
	#tag EndComputedProperty


	#tag Constant, Name = KeyHeight, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyLeft, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyTop, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyWidth, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Threaded"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelayInSeconds"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cancelled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastFrameTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Started"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimateHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimateLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimateTop"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimateWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DurationInSeconds"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="Width"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
