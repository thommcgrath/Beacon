#tag Class
Protected Class DelayedSearchField
Inherits UITweaks.ResizedSearchField
	#tag Event
		Sub FocusLost()
		  Self.TriggerAfter(10)
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  If RaiseEvent KeyDown(Key) Then
		    Return True
		  End If
		  
		  Var Code As Integer = Key.Asc
		  Select Case Code
		  Case 10, 13, 3
		    Self.TriggerAfter(10)
		    Return False
		  End Select
		End Function
	#tag EndEvent

	#tag Event
		Sub Pressed()
		  Self.TriggerAfter(10)
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextChanged()
		  Self.TriggerAfter(Self.DelayPeriod)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  
		  Self.mTimer = New Timer
		  Self.mTimer.RunMode = Timer.RunModes.Off
		  Self.mTimer.Period = 250
		  AddHandler Self.mTimer.Action, WeakAddressOf mTimer_Action
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  RemoveHandler Self.mTimer.Action, WeakAddressOf mTimer_Action
		  Self.mTimer.RunMode = Timer.RunModes.Off
		  Self.mTimer.Reset
		  Self.mTimer = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  If Self.mLastEventValue.Compare(Self.Text, ComparisonOptions.CaseSensitive) <> 0 Then
		    Self.mLastEventValue = Self.Text
		    RaiseEvent TextChanged
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerAfter(Delay As Integer)
		  Self.mTimer.Reset
		  Self.mTimer.Period = Delay
		  Self.mTimer.RunMode = Timer.RunModes.Single
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event KeyDown(key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChanged()
	#tag EndHook


	#tag Property, Flags = &h0
		DelayPeriod As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastEventValue As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimer As Timer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="PanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mInitialParent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Active"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabStop"
			Visible=true
			Group="Focus Control"
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
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
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
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
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
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
			Name="AllowRecentItems"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClearMenuItemValue"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumRecentItems"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RecentItemsValue"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DelayPeriod"
			Visible=true
			Group="Behavior"
			InitialValue="250"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hint"
			Visible=true
			Group="Initial State"
			InitialValue="Search"
			Type="String"
			EditorType="String"
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
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
