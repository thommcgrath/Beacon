#tag Class
Protected Class DeltaTask
Inherits AnimationKit.Task
	#tag Event
		Sub Perform(Final As Boolean, Time As Double)
		  If Self.ElapsedTime(Time) < 0 Then
		    Return
		  End If
		  
		  If Not Self.DelayPassed Then
		    RaiseEvent Started()
		    Self.DelayPassed = True
		  End If
		  
		  RaiseEvent Perform(Final, Time)
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

	#tag Method, Flags = &h0
		Function ElapsedTime(Time As Double) As Double
		  Return Super.ElapsedTime(Time) - (Self.DelayInSeconds * 1000000)
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Perform(Final As Boolean, Time As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag Property, Flags = &h0
		Curve As AnimationKit.Curve
	#tag EndProperty

	#tag Property, Flags = &h0
		DelayInSeconds As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DelayPassed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		DurationInSeconds As Double = 1
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="DelayInSeconds"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
