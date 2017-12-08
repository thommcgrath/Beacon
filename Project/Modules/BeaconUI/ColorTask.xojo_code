#tag Class
Protected Class ColorTask
Inherits AnimationKit.Task
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  If Final Then
		    BeaconUI.ColorAnimator(Self.Item).AnimationStep(Self.Identifier, Self.EndValue)
		    Return
		  End If
		  
		  Dim Elapsed As Double = Self.ElapsedTime(Time)
		  Dim Duration As Double = Self.DurationInSeconds * 1000000
		  Dim Percent As Double = Elapsed / Duration
		  
		  Dim RedValue As Double = Self.Curve.Evaluate(Percent, Self.StartValue.Red, Self.EndValue.Red)
		  Dim GreenValue As Double = Self.Curve.Evaluate(Percent, Self.StartValue.Green, Self.EndValue.Green)
		  Dim BlueValue As Double = Self.Curve.Evaluate(Percent, Self.StartValue.Blue, Self.EndValue.Blue)
		  Dim AlphaValue As Double = Self.Curve.Evaluate(Percent, Self.StartValue.Alpha, Self.EndValue.Alpha)
		  
		  BeaconUI.ColorAnimator(Self.Item).AnimationStep(Self.Identifier, RGB(RedValue, GreenValue, BlueValue, AlphaValue))
		End Sub
	#tag EndEvent

	#tag Event
		Sub Started()
		  //
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Completed(Time As Double) As Boolean
		  Return Self.ElapsedTime(Time) >= (Self.DurationInSeconds * 1000000)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1021
		Private Sub Constructor()
		  Self.Curve = AnimationKit.Curve.CreateEaseOut
		  Self.DurationInSeconds = BeaconUI.ColorChangeDuration
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Target As BeaconUI.ColorAnimator, Identifier As Text, StartValue As Color, EndValue As Color)
		  Self.Constructor()
		  Self.StartValue = StartValue
		  Self.EndValue = EndValue
		  Self.Item = Target
		  Self.Identifier = Identifier
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Curve As AnimationKit.Curve
	#tag EndProperty

	#tag Property, Flags = &h0
		DurationInSeconds As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		EndValue As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		StartValue As Color
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Cancelled"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DurationInSeconds"
			Group="Behavior"
			InitialValue="1"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EndValue"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Group="Behavior"
			Type="Text"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastFrameTime"
			Group="Behavior"
			Type="Double"
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
			Name="Started"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartValue"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
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
