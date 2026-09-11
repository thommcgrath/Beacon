#tag Class
Protected Class CommonThread
Inherits Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  #if DebugBuild
		    If Self.DebugIdentifier.IsEmpty Then
		      Break
		    End If
		  #endif
		  
		  Self.mLock.Enter
		  Self.mShouldStop = False
		  Self.mLock.Leave
		  
		  Self.YieldToNext // The first iteration always happens on the main thread.
		  RaiseEvent Run
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mLock = New CriticalSection
		  Self.mLock.Type = Thread.Types.Preemptive
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Lock() As Beacon.LockHolder
		  Return New Beacon.LockHolder(Self.mLock)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Release()
		  If (Self.mInstances Is Nil) = False And Self.mInstances.HasKey(Self) Then
		    Self.mInstances.Remove(Self)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Retain()
		  If Self.mInstances Is Nil Then
		    Self.mInstances = New Dictionary
		  End If
		  
		  Self.mInstances.Value(Self) = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldStop() As Boolean
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  Return Self.mShouldStop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Stop()
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  Self.mShouldStop = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData() As Variant
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  Return Self.mUserData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserData(Assigns Value As Variant)
		  Var Holder As New Beacon.LockHolder(Self.mLock)
		  Self.mUserData = Value
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Run()
	#tag EndHook


	#tag Property, Flags = &h21
		Private Shared mInstances As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Private mLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShouldStop As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
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
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=false
			Group="Behavior"
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
	#tag EndViewBehavior
End Class
#tag EndClass
