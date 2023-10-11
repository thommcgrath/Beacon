#tag Class
Protected Class DiscoverIntegration
Inherits Beacon.Integration
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Var Project As Beacon.Project
		  Try
		    Project = RaiseEvent Run()
		    If Project Is Nil Then
		      If Self.Errored = False Then
		        Self.SetError("No server discovered")
		      End If
		      Return
		    End If
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		    Return
		  End Try
		  
		  Var Dict As New Dictionary
		  Dict.Value("Event") = "Discovered"
		  Dict.Value("Project") = Project
		  Self.Thread.AddUserInterfaceUpdate(Dict)
		  Self.mProject = Project
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin()
		  // Scope change
		  Super.Begin()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FireEvent(EventName As String, UpdateData As Dictionary)
		  Select Case EventName
		  Case "Discovered"
		    Var Project As Beacon.Project = UpdateData.Value("Project")
		    RaiseEvent Discovered(Project)
		  Else
		    Super.FireEvent(EventName, UpdateData)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Project() As Beacon.Project
		  Return Self.mProject
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Discovered(Project As Beacon.Project)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Run() As Beacon.Project
	#tag EndHook


	#tag Property, Flags = &h21
		Private mProject As Beacon.Project
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ThreadPriority"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
