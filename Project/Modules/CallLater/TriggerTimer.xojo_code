#tag Class
Private Class TriggerTimer
Inherits Timer
	#tag Event
		Sub Action()
		  If Self.Callback <> Nil Then
		    Self.Callback.Invoke()
		  ElseIf Self.CallbackWithArg <> Nil Then
		    Self.CallbackWithArg.Invoke(Self.Argument)
		  End If
		  
		  If Timers <> Nil And Timers.HasKey(Self.Key) Then
		    Timers.Remove(Self.Key)
		  End If
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		Argument As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Callback As CallLater.CallNoParams
	#tag EndProperty

	#tag Property, Flags = &h0
		CallbackWithArg As CallLater.CallWithArg
	#tag EndProperty

	#tag Property, Flags = &h0
		Key As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="RunMode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="RunModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Key"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
