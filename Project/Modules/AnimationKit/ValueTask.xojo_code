#tag Class
Protected Class ValueTask
Inherits AnimationKit.Task
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  If Final Then
		    AnimationKit.ValueAnimator(Self.Item).AnimationStep(Self.Identifier, Self.EndValue)
		    Return
		  End If
		  
		  Dim Elapsed As Double = Self.ElapsedTime(Time)
		  Dim Duration As Double = Self.DurationInSeconds * 1000000
		  Dim Value As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartValue, Self.EndValue)
		  AnimationKit.ValueAnimator(Self.Item).AnimationStep(Self.Identifier, Value)
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
		  Self.Curve = AnimationKit.Curve.CreateFromPreset(AnimationKit.Curve.Presets.Linear)
		  Self.DurationInSeconds = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Target As AnimationKit.ValueAnimator, Identifier As Text, StartValue As Double, EndValue As Double)
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
		EndValue As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		StartValue As Double
	#tag EndProperty


	#tag ViewBehavior
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
			Name="DurationInSeconds"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EndValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Text"
			EditorType="MultiLineEditor"
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
			Name="StartValue"
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
