#tag Class
Protected Class Task
	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.PrivateCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Completed(Time As Double) As Boolean
		  #Pragma Unused Time
		  
		  Dim Err As New UnsupportedOperationException
		  Err.Reason = "Subclasses of AnimationKit.Task must override the Completed method."
		  Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ElapsedTime(Time As Double) As Double
		  Return Time - Self.StartTime
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Perform(Time As Double)
		  If Self.Item = Nil Then
		    Return
		  End If
		  
		  If Not Self.Started Then
		    RaiseEvent Started()
		    Self.StartTime = Time
		  End If
		  
		  Self.PrivateLastFrameTime = Time
		  
		  Dim Final As Boolean = Self.Completed(Time)
		  RaiseEvent Perform(Final, Time)
		  If Final Then
		    RaiseEvent Completed
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run()
		  Self.Run(AnimationKit.SharedCoordinator)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run(Coordinator As AnimationKit.Coordinator)
		  Coordinator.AddTask(Self)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Completed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Perform(Final As Boolean, Time As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PrivateCancelled Or Self.Item = Nil
			End Get
		#tag EndGetter
		Cancelled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.ItemRef <> Nil And Self.ItemRef.Value <> Nil Then
			    Return Self.ItemRef.Value
			  Else
			    Return Nil
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Nil Then
			    Self.ItemRef = Nil
			    Return
			  End If
			  
			  Self.ItemRef = Xojo.Core.WeakRef.Create(Value)
			End Set
		#tag EndSetter
		Item As Object
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ItemRef As Xojo.Core.WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PrivateLastFrameTime
			End Get
		#tag EndGetter
		LastFrameTime As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PrivateNextTask
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Nil Then
			    Self.PrivateNextTask = Nil
			    Return
			  End If
			  
			  If Self.PrivateNextTask = Nil Then
			    Self.PrivateNextTask = Value
			  Else
			    Self.PrivateNextTask.NextTask = Value
			  End If
			End Set
		#tag EndSetter
		NextTask As AnimationKit.Task
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private PrivateCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PrivateLastFrameTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PrivateNextTask As AnimationKit.Task
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.PrivateLastFrameTime > 0
			End Get
		#tag EndGetter
		Started As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private StartTime As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Cancelled"
			Group="Behavior"
			Type="Boolean"
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
