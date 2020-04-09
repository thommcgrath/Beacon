#tag Class
Protected Class ValueTask
Inherits AnimationKit.DeltaTask
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  If Final Then
		    AnimationKit.ValueAnimator(Self.Item).AnimationStep(Self.Identifier, Self.EndValue)
		    Return
		  End If
		  
		  Var Elapsed As Double = Self.ElapsedTime(Time)
		  Var Duration As Double = Self.DurationInSeconds * 1000000
		  Var Value As Double = Self.Curve.Evaluate(Elapsed / Duration, Self.StartValue, Self.EndValue)
		  AnimationKit.ValueAnimator(Self.Item).AnimationStep(Self.Identifier, Value)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Started()
		  //
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1021
		Private Sub Constructor()
		  Self.Curve = AnimationKit.Curve.CreateFromPreset(AnimationKit.Curve.Presets.Linear)
		  Self.DurationInSeconds = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Target As AnimationKit.ValueAnimator, Identifier As String, StartValue As Double, EndValue As Double)
		  Self.Constructor()
		  Self.StartValue = StartValue
		  Self.EndValue = EndValue
		  Self.Item = Target
		  Self.Identifier = Identifier
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		EndValue As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As String
	#tag EndProperty

	#tag Property, Flags = &h0
		StartValue As Double
	#tag EndProperty


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
			Type="String"
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
