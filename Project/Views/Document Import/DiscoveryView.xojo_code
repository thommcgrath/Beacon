#tag Class
Protected Class DiscoveryView
Inherits DesktopContainer
	#tag CompatibilityFlags = ( TargetDesktop and ( Target32Bit or Target64Bit ) )
	#tag Event
		Sub Closing()
		  RaiseEvent Closing
		  Self.mClosed = True
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  RaiseEvent Resize
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  RaiseEvent Resize
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin()
		  If Self.mClosed Then
		    Return
		  End If
		  
		  RaiseEvent Begin
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cleanup()
		  If Self.mClosed Then
		    Return
		  End If
		  
		  RaiseEvent Cleanup()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DesiredHeight() As Integer
		  Return Self.mDesiredHeight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DesiredHeight(Assigns Value As Integer)
		  If Self.mClosed Then
		    Return
		  End If
		  
		  If Value <> Self.mDesiredHeight Then
		    Self.mDesiredHeight = Value
		  End If  
		  RaiseEvent ShouldResize(Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GameId() As String
		  If Self.mGameId.IsEmpty Then
		    Self.mGameId = RaiseEvent GameId()
		  End If
		  Return Self.mGameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Project() As Beacon.Project
		  Return RaiseEvent GetDestinationProject()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Provider() As Beacon.HostingProvider
		  If Self.mProvider Is Nil Then
		    Self.mProvider = RaiseEvent CreateHostingProvider()
		  End If
		  Return Self.mProvider
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ProviderName() As String
		  If Self.mProviderName.IsEmpty Then
		    Var Provider As Beacon.HostingProvider = Self.Provider
		    If (Provider Is Nil) = False Then
		      Self.mProviderName = Language.ProviderName(Provider.Identifier)
		    End If
		  End If
		  Return Self.mProviderName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PullValuesFromProject(Project As Beacon.Project)
		  If Self.mClosed Then
		    Return
		  End If
		  
		  RaiseEvent GetValuesFromProject(Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldCancel()
		  If Self.mClosed Then
		    Return
		  End If
		  
		  RaiseEvent ShouldCancel()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldFinish(Profiles() As Beacon.ServerProfile)
		  If Self.mClosed Then
		    Return
		  End If
		  
		  RaiseEvent Finished(Profiles)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ShouldFinish(ParamArray Profiles() As Beacon.ServerProfile)
		  Self.ShouldFinish(Profiles)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Begin()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Cleanup()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Closing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CreateHostingProvider() As Beacon.HostingProvider
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Finished(Profiles() As Beacon.ServerProfile)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GameId() As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetDestinationProject() As Beacon.Project
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetValuesFromProject(Project As Beacon.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldCancel()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ShouldResize(NewHeight As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mClosed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDesiredHeight As Integer = 64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProvider As Beacon.HostingProvider
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProviderName As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Composited"
			Visible=true
			Group="Window Behavior"
			InitialValue="False"
			Type="Boolean"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
