#tag Class
Protected Class ProfileTask
Inherits AnimationKit.Task
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  Dim Animator As BeaconUI.ProfileAnimator = BeaconUI.ProfileAnimator(Self.Item)
		  
		  If Final Then
		    Animator.AnimationStep(Self.Identifier, Self.EndProfile)
		    Return
		  End If
		  
		  Dim Elapsed As Double = Self.ElapsedTime(Time)
		  Dim Duration As Double = Self.DurationInSeconds * 1000000
		  Dim Percent As Double = Elapsed / Duration
		  
		  Dim BlendPercent As Double = Self.Curve.Evaluate(Percent, 0.0, 1.0)
		  Dim Profile As BeaconUI.ColorProfile = Self.StartProfile.BlendWithProfile(Self.EndProfile, BlendPercent)
		  
		  Animator.AnimationStep(Self.Identifier, Profile)
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
		  Self.DurationInSeconds = 1.15
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Target As BeaconUI.ProfileAnimator, Identifier As Text, StartProfile As BeaconUI.ColorProfile, EndProfile As BeaconUI.ColorProfile)
		  Self.Constructor()
		  Self.StartProfile = StartProfile
		  Self.EndProfile = EndProfile
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
		EndProfile As BeaconUI.ColorProfile
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As Text
	#tag EndProperty

	#tag Property, Flags = &h0
		StartProfile As BeaconUI.ColorProfile
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
			Name="DurationInSeconds"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Text"
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
			Name="LastFrameTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="Started"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
