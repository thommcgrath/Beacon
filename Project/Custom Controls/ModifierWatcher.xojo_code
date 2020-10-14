#tag Class
Protected Class ModifierWatcher
Inherits Timer
	#tag Event
		Sub Action()
		  Self.OptionHeld = Keyboard.AsyncAltKey
		  Self.ShiftHeld = Keyboard.AsyncShiftKey
		  Self.SuperHeld = Keyboard.AsyncOSKey
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function OptionHeld() As Boolean
		  Return Self.mOptionHeld
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub OptionHeld(Assigns Value As Boolean)
		  If Self.mOptionHeld = Value Then
		    Return
		  End If
		  
		  Self.mOptionHeld = Value
		  RaiseEvent OptionChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShiftHeld() As Boolean
		  Return Self.mShiftHeld
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShiftHeld(Assigns Value As Boolean)
		  If Self.mShiftHeld = Value Then
		    Return
		  End If
		  
		  Self.mShiftHeld = Value
		  RaiseEvent ShiftChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SuperHeld() As Boolean
		  Return Self.mSuperHeld
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SuperHeld(Assigns Value As Boolean)
		  If Self.mSuperHeld = Value Then
		    Return
		  End If
		  
		  Self.mSuperHeld = Value
		  RaiseEvent SuperChanged
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event OptionChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShiftChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SuperChanged()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mOptionHeld As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShiftHeld As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSuperHeld As Boolean
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
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
