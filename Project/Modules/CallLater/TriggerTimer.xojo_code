#tag Class
Private Class TriggerTimer
Inherits Timer
	#tag Event
		Sub Action()
		  If Self.Callback <> Nil Then
		    If (GetDelegateTargetMBS(Self.Callback) Is Nil) = False Then
		      Self.Callback.Invoke()
		    Else
		      Self.Callback = Nil
		    End If
		  ElseIf Self.CallbackWithArg <> Nil Then
		    If (GetDelegateTargetMBS(Self.CallbackWithArg) Is Nil) = False Then
		      Self.CallbackWithArg.Invoke(Self.Argument)
		    Else
		      Self.CallbackWithArg = Nil
		    End If
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
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
