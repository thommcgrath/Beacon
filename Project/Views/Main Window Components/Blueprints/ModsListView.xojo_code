#tag Class
Protected Class ModsListView
Inherits BeaconSubview
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) )
	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  Self.HasBeenShown = True
		  Self.RefreshMods()
		  RaiseEvent Shown(UserData)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function CloseModView(ModId As String) As Boolean
		  Return RaiseEvent CloseModView(ModId)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mUpdateTimer = New Timer
		  Self.mUpdateTimer.RunMode = Timer.RunModes.Off
		  Self.mUpdateTimer.Period = 10
		  AddHandler mUpdateTimer.Action, WeakAddressOf mUpdateTimer_Action
		  
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub FinishJob()
		  Self.mJobCount = Self.mJobCount - 1
		  
		  If Self.mJobCount > 0 Then
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Else
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  If Self.mJobCount = 0 Then
		    RaiseEvent JobsFinished()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasBeenShown() As Boolean
		  Return Self.mHasBeenShown
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HasBeenShown(Assigns Value As Boolean)
		  If Self.mHasBeenShown = Value Then
		    Return
		  End If
		  
		  Self.mHasBeenShown = Value
		  Self.UpdateUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function JobCount() As Integer
		  Return Self.mJobCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mUpdateTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent UpdateUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshMods()
		  RaiseEvent RefreshMods()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShowMod(ModInfo As BeaconAPI.ContentPack)
		  RaiseEvent ShowMod(ModInfo)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StartJob()
		  Self.mJobCount = Self.mJobCount + 1
		  
		  If Self.mJobCount > 0 Then
		    Self.Progress = BeaconSubview.ProgressIndeterminate
		  Else
		    Self.Progress = BeaconSubview.ProgressNone
		  End If
		  
		  If Self.mJobCount = 1 Then
		    RaiseEvent JobsStarted()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalPages() As Integer
		  Return Self.mTotalPages
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TotalPages(Assigns Value As Integer)
		  If Self.mTotalPages = Value Then
		    Return
		  End If
		  
		  Self.mTotalPages = Value
		  Self.UpdateUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalResults() As Integer
		  Return Self.mTotalResults
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TotalResults(Assigns Value As Integer)
		  If Self.mTotalResults = Value Then
		    Return
		  End If
		  
		  Self.mTotalResults = Value
		  Self.UpdateUI()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateUI()
		  Self.mUpdateTimer.RunMode = Timer.RunModes.Single
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Working() As Boolean
		  Return Self.mJobCount > 0
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CloseModView(ModId As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event JobsFinished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event JobsStarted()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RefreshMods()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShowMod(ModInfo As BeaconAPI.ContentPack)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Shown(UserData As Variant = Nil)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UpdateUI()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mHasBeenShown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJobCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalPages As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalResults As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdateTimer As Timer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Modified"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Composited"
			Visible=true
			Group="Window Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Size"
			InitialValue="500"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Size"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="&hFFFFFF"
			Type="ColorGroup"
			EditorType="ColorGroup"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackgroundColor"
			Visible=true
			Group="Background"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Background"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Progress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewTitle"
			Visible=true
			Group="Behavior"
			InitialValue="Untitled"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ViewIcon"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsFrontmost"
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
	#tag EndViewBehavior
End Class
#tag EndClass
