#tag Class
Protected Class ScrollTask
Inherits AnimationKit.DeltaTask
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  Var Item As Object = Self.Item
		  If Item = Nil Then
		    Return
		  End If
		  
		  If Not (Item IsA AnimationKit.Scrollable) Then
		    Return
		  End If
		  
		  Var Target As AnimationKit.Scrollable = AnimationKit.Scrollable(Item)
		  
		  If Final Then
		    Self.Apply(Target, Self.Minimum, Self.Maximum, Self.Position)
		    Return
		  End If
		  
		  Var Elapsed As Double = Self.ElapsedTime(Time)
		  Var Duration As Double = Self.DurationInSeconds * 1000000
		  Var Minimum As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartMinimum, Self.Minimum)
		  Var Maximum As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartMaximum, Self.Maximum)
		  Var Position As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartPosition, Self.Position)
		  Self.Apply(Target, Minimum, Maximum, Position)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Started()
		  Var Item As Object = Self.Item
		  If Item = Nil Then
		    Return
		  End If
		  
		  If Not (Item IsA AnimationKit.Scrollable) Then
		    Return
		  End If
		  
		  Var Target As AnimationKit.Scrollable = AnimationKit.Scrollable(Item)
		  Self.StartMinimum = Target.ScrollMinimum
		  Self.StartMaximum = Target.ScrollMaximum
		  Self.StartPosition = Target.ScrollPosition
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub Apply(Target As AnimationKit.Scrollable, Minimum As Double, Maximum As Double, Position As Double)
		  If Self.AnimateMaximum Then
		    Target.ScrollMaximum = Maximum
		  End If
		  If Self.AnimateMinimum Then
		    Target.ScrollMinimum = Minimum
		  End If
		  If Self.AnimatePosition Then
		    Target.ScrollPosition = Position
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  Self.Curve = AnimationKit.Curve.CreateFromPreset(AnimationKit.Curve.Presets.Linear)
		  Self.DurationInSeconds = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Target As AnimationKit.Scrollable)
		  Self.Constructor()
		  Self.Item = Target
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI)
		Sub Constructor(Target As Listbox)
		  Self.Retainer = New ListboxScrollDelegate(Target)
		  Self.Constructor(Self.Retainer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI)
		Sub Constructor(Target As ScrollBar)
		  Self.Retainer = New ScrollBarScrollDelegate(Target)
		  Self.Constructor(Self.Retainer)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetHasGUI)
		Sub Constructor(Target As TextArea)
		  Self.Retainer = New TextAreaScrollDelegate(Target)
		  Self.Constructor(Self.Retainer)
		End Sub
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


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyMaximum, UInt64)) = CType(Self.KeyMaximum, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyMaximum)
			  Else
			    Self.DisableValues(Self.KeyMaximum)
			  End If
			End Set
		#tag EndSetter
		AnimateMaximum As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyMinimum, UInt64)) = CType(Self.KeyMinimum, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyMinimum)
			  Else
			    Self.DisableValues(Self.KeyMinimum)
			  End If
			End Set
		#tag EndSetter
		AnimateMinimum As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return (Self.AnimationKeys And CType(Self.KeyPosition, UInt64)) = CType(Self.KeyPosition, UInt64)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value Then
			    Self.EnableValues(Self.KeyPosition)
			  Else
			    Self.DisableValues(Self.KeyPosition)
			  End If
			End Set
		#tag EndSetter
		AnimatePosition As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private AnimationKeys As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EndMaximum As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EndMinimum As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EndPosition As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndMaximum
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndMaximum = Value
			  Self.EnableValues(Self.KeyMaximum)
			End Set
		#tag EndSetter
		Maximum As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndMinimum
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndMinimum = Value
			  Self.EnableValues(Self.KeyMinimum)
			End Set
		#tag EndSetter
		Minimum As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.EndPosition
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.EndPosition = Value
			  Self.EnableValues(Self.KeyPosition)
			End Set
		#tag EndSetter
		Position As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Retainer As AnimationKit.Scrollable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartMaximum As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartMinimum As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartPosition As Double
	#tag EndProperty


	#tag Constant, Name = KeyMaximum, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyMinimum, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KeyPosition, Type = Double, Dynamic = False, Default = \"4", Scope = Public
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
			Name="AnimateMaximum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimateMinimum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimatePosition"
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
			InitialValue=""
			Type="Double"
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
			Name="Maximum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Minimum"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="Position"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
