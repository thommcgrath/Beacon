#tag Class
Protected Class FrameTask
Inherits AnimationKit.Task
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  If Final Then
		    Self.CurrentFrame = UBound(Self.Frames)
		    AnimationKit.FrameTarget(Self.Item).AnimationStep(Self.Identifier, Self.Frames.LastFrame)
		    Return
		  End If
		  
		  Dim Duration As Double = Self.DurationInSeconds * 1000000
		  Dim LoopElapsed As Double = Self.ElapsedTime(Time) Mod Duration
		  Dim PercentComplete As Double = LoopElapsed / Duration
		  Dim Frame As Integer = Round(Self.Frames.LastRowIndex * PercentComplete)
		  
		  If Frame <> Self.CurrentFrame Then
		    Self.CurrentFrame = Frame
		    AnimationKit.FrameTarget(Self.Item).AnimationStep(Self.Identifier, Self.Frames(Frame))
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Started()
		  //
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Completed(Time As Double) As Boolean
		  If Self.Looping Then
		    Return False
		  Else
		    Return Self.ElapsedTime(Time) >= (Self.DurationInSeconds * 1000000)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1021
		Private Sub Constructor()
		  Self.Looping = True
		  Self.Frames = New AnimationKit.FrameSet()
		  Self.DurationInSeconds = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Target As AnimationKit.FrameTarget, Frames As AnimationKit.FrameSet)
		  Self.Constructor()
		  Self.Item = Target
		  Self.Frames = Frames
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private CurrentFrame As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DurationInSeconds As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		Frames As AnimationKit.FrameSet
	#tag EndProperty

	#tag Property, Flags = &h0
		Identifier As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Looping As Boolean
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
			Name="Looping"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
