#tag Class
Protected Class Thread
Inherits Global.Thread
	#tag Event
		Sub Run()
		  Self.mShouldStop = False
		  RaiseEvent Run
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub LockUserData()
		  #if Not TargetiOS
		    If Self.mUserDataLock = Nil Then
		      Self.mUserDataLock = New CriticalSection
		    End If
		    Self.mUserDataLock.Enter
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  Self.mShouldStop = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnlockUserData()
		  #if Not TargetiOS
		    If Self.mUserDataLock <> Nil Then
		      Self.mUserDataLock.Leave
		    End If
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Run()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mShouldStop As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Auto
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mUserDataLock As CriticalSection
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return Self.mShouldStop
			End Get
		#tag EndGetter
		Protected ShouldStop As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUserData
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.LockUserData()
			  Self.mUserData = Value
			  Self.UnlockUserData()
			End Set
		#tag EndSetter
		UserData As Auto
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Priority"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Group="Behavior"
			Type="UInteger"
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
		#tag ViewProperty
			Name="State"
			Group="Behavior"
			Type="Beacon.Thread.States"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Suspended"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
