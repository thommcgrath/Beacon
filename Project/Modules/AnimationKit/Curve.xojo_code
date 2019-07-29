#tag Class
Protected Class Curve
	#tag CompatibilityFlags = ( not TargetHasGUI and not TargetWeb and not TargetIOS ) or ( TargetWeb ) or ( TargetHasGUI ) or ( TargetIOS )
	#tag Method, Flags = &h1
		Protected Function B0(Time As Double) As Double
		  Return Time * Time * Time
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function B1(Time As Double) As Double
		  Return 3 * Time * Time * (1 - Time)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function B2(Time As Double) As Double
		  Return 3 * Time * (1 - Time) * (1 - Time)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function B3(Time As Double) As Double
		  Return (1 - Time) * (1 - Time) * (1 - Time)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(P1 As Point, P2 As Point)
		  Self.C0 = New Point(0, 0)
		  Self.C1 = New Point(P1.X, P1.Y)
		  Self.C2 = New Point(P2.X, P2.Y)
		  Self.C3 = New Point(1, 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(P1X As Single, P1Y As Single, P2X As Single, P2Y As Single)
		  Self.Constructor(New Point(P1X, P1Y), New Point(P2X, P2Y))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateEaseIn() As AnimationKit.Curve
		  Return CreateFromPreset(Presets.EaseIn)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateEaseInOut() As AnimationKit.Curve
		  Return CreateFromPreset(Presets.EaseInOut)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateEaseOut() As AnimationKit.Curve
		  Return CreateFromPreset(Presets.EaseOut)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFromPreset(Preset As AnimationKit.Curve.Presets) As AnimationKit.Curve
		  Select Case Preset
		  Case AnimationKit.Curve.Presets.Linear
		    Return New AnimationKit.Curve(0.250, 0.250, 0.750, 0.750)
		  Case AnimationKit.Curve.Presets.EaseIn
		    Return New AnimationKit.Curve(0.420, 0.000, 1.000, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInBack
		    Return New AnimationKit.Curve(0.600, -0.280, 0.735, 0.045)
		  Case AnimationKit.Curve.Presets.EaseInCirc
		    Return New AnimationKit.Curve(0.600, 0.040, 0.980, 0.335)
		  Case AnimationKit.Curve.Presets.EaseInCubic
		    Return New AnimationKit.Curve(0.550, 0.055, 0.675, 0.190)
		  Case AnimationKit.Curve.Presets.EaseInExpo
		    Return New AnimationKit.Curve(0.950, 0.050, 0.795, 0.035)
		  Case AnimationKit.Curve.Presets.EaseInQuad
		    Return New AnimationKit.Curve(0.550, 0.085, 0.680, 0.530)
		  Case AnimationKit.Curve.Presets.EaseInQuart
		    Return New AnimationKit.Curve(0.895, 0.030, 0.685, 0.220)
		  Case AnimationKit.Curve.Presets.EaseInQuint
		    Return New AnimationKit.Curve(0.755, 0.050, 0.855, 0.060)
		  Case AnimationKit.Curve.Presets.EaseInSine
		    Return New AnimationKit.Curve(0.470, 0.000, 0.745, 0.715)
		  Case AnimationKit.Curve.Presets.EaseOut
		    Return New AnimationKit.Curve(0.000, 0.000, 0.580, 1.000)
		  Case AnimationKit.Curve.Presets.EaseOutBack
		    Return New AnimationKit.Curve(0.175, 0.885, 0.320, 1.275)
		  Case AnimationKit.Curve.Presets.EaseOutCirc
		    Return New AnimationKit.Curve(0.075, 0.820, 0.165, 1.000)
		  Case AnimationKit.Curve.Presets.EaseOutCubic
		    Return New AnimationKit.Curve(0.215, 0.610, 0.355, 1.000)
		  Case AnimationKit.Curve.Presets.EaseOutExpo
		    Return New AnimationKit.Curve(0.190, 1.000, 0.220, 1.000)
		  Case AnimationKit.Curve.Presets.EaseOutQuad
		    Return New AnimationKit.Curve(0.250, 0.460, 0.450, 0.940)
		  Case AnimationKit.Curve.Presets.EaseOutQuart
		    Return New AnimationKit.Curve(0.165, 0.840, 0.440, 1.000)
		  Case AnimationKit.Curve.Presets.EaseOutQuint
		    Return New AnimationKit.Curve(0.230, 1.000, 0.320, 1.000)
		  Case AnimationKit.Curve.Presets.EaseOutSine
		    Return New AnimationKit.Curve(0.390, 0.575, 0.565, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInOut
		    Return New AnimationKit.Curve(0.420, 0.000, 0.580, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInOutBack
		    Return New AnimationKit.Curve(0.680, -0.550, 0.265, 1.550)
		  Case AnimationKit.Curve.Presets.EaseInOutCirc
		    Return New AnimationKit.Curve(0.785, 0.135, 0.150, 0.860)
		  Case AnimationKit.Curve.Presets.EaseInOutCubic
		    Return New AnimationKit.Curve(0.645, 0.045, 0.355, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInOutExpo
		    Return New AnimationKit.Curve(1.000, 0.000, 0.000, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInOutQuad
		    Return New AnimationKit.Curve(0.455, 0.030, 0.515, 0.955)
		  Case AnimationKit.Curve.Presets.EaseInOutQuart
		    Return New AnimationKit.Curve(0.770, 0.000, 0.175, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInOutQuint
		    Return New AnimationKit.Curve(0.860, 0.000, 0.070, 1.000)
		  Case AnimationKit.Curve.Presets.EaseInOutSine
		    Return New AnimationKit.Curve(0.445, 0.050, 0.550, 0.950)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateLinear() As AnimationKit.Curve
		  Return CreateFromPreset(Presets.Linear)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(Time As Double, StartValue As Double, EndValue As Double) As Double
		  If StartValue = EndValue Then
		    Return StartValue
		  End If
		  
		  Time = 1 - Max(Min(Time, 1), 0)
		  
		  Dim V0 As Double = Self.C0.Y * Self.B0(Time)
		  Dim V1 As Double = Self.C1.Y * Self.B1(Time)
		  Dim V2 As Double = Self.C2.Y * Self.B2(Time)
		  Dim V3 As Double = Self.C3.Y * Self.B3(Time)
		  
		  Dim Y As Double = V0 + V1 + V2 + V3
		  Return StartValue + ((EndValue - StartValue) * Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reverse() As AnimationKit.Curve
		  Return New AnimationKit.Curve(1 - Self.C1.X, 1 - Self.C1.Y, 1 - Self.C2.X, 1 - Self.C2.Y)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private C0 As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C1 As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C2 As Point
	#tag EndProperty

	#tag Property, Flags = &h21
		Private C3 As Point
	#tag EndProperty


	#tag Enum, Name = Presets, Type = Integer, Flags = &h0
		Linear
		  EaseIn
		  EaseInBack
		  EaseInCirc
		  EaseInCubic
		  EaseInExpo
		  EaseInQuad
		  EaseInQuart
		  EaseInQuint
		  EaseInSine
		  EaseOut
		  EaseOutBack
		  EaseOutCirc
		  EaseOutCubic
		  EaseOutExpo
		  EaseOutQuad
		  EaseOutQuart
		  EaseOutQuint
		  EaseOutSine
		  EaseInOut
		  EaseInOutBack
		  EaseInOutCirc
		  EaseInOutCubic
		  EaseInOutExpo
		  EaseInOutQuad
		  EaseInOutQuart
		  EaseInOutQuint
		EaseInOutSine
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
	#tag EndViewBehavior
End Class
#tag EndClass
