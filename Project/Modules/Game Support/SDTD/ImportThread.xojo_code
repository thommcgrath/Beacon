#tag Class
Protected Class ImportThread
Inherits Beacon.Thread
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Sub Run()
		  Self.Status = "Doing nothing…"
		  Self.Sleep(5000)
		  Self.Status = "Done"
		  Self.mFinished = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  Self.mCancelled = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Data As SDTD.DiscoveredData, DestinationProject As SDTD.Project)
		  Self.mUpdateTimer = New Timer
		  Self.mUpdateTimer.RunMode = Timer.RunModes.Off
		  Self.mUpdateTimer.Period = 0
		  #if TargetDesktop
		    AddHandler Self.mUpdateTimer.Action, WeakAddressOf Self.mUpdateTimer_Action
		  #else
		    AddHandler Self.mUpdateTimer.Run, WeakAddressOf Self.mUpdateTimer_Action
		  #endif
		  
		  Self.mData = Data
		  Self.mDestinationProject = DestinationProject
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Invalidate()
		  If Self.mFinished Then
		    Return
		  End If
		  
		  If Self.mUpdateTimer.RunMode = Timer.RunModes.Off Then
		    Self.mUpdateTimer.RunMode = Timer.RunModes.Single
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent UpdateUI
		  
		  If Self.mFinished Then
		    RaiseEvent Finished(Self.mCreatedProject)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  If (Self.mData Is Nil) = False And (Self.mData.Profile Is Nil) = False And Self.mData.Profile.Name.IsEmpty = False Then
		    Return Self.mData.Profile.Name
		  Else
		    Return "Untitled Importer"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As SDTD.Project
		  Return Self.mCreatedProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As String
		  Return Self.mStatusMessage
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Status(Assigns Value As String)
		  If Self.mStatusMessage.Compare(Value, ComparisonOptions.CaseSensitive, Locale.Raw) <> 0 Then
		    Self.mStatusMessage = Value
		    Self.Invalidate
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished(Project As SDTD.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateUI()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mCancelled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCreatedProject As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mData As SDTD.DiscoveredData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDestinationProject As SDTD.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStatusMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateTimer As Timer
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