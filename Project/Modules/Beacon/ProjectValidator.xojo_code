#tag Class
Protected Class ProjectValidator
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mThread = New Thread
		  AddHandler mThread.Run, WeakAddressOf mThread_Run
		  AddHandler mThread.UserInterfaceUpdate, WeakAddressOf mThread_UserInterfaceUpdate
		  Self.mShowUITimer = New Timer
		  Self.mShowUITimer.Period = 1000
		  Self.mShowUITimer.RunMode = Timer.RunModes.Off
		  AddHandler mShowUITimer.Action, WeakAddressOf mShowUITimer_Action
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mShowUITimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  RaiseEvent Validating()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_Run(Sender As Thread)
		  Var Issues As Beacon.ProjectValidationResults = Self.mProject.Validate
		  
		  If Issues.Count = 0 Then
		    // No issues, so report license usage to the api.
		    Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		    If (Identity Is Nil) = False Then
		      Var Flags As Integer = Beacon.FlagsForGameId(Self.mProject.GameId)
		      Var Licenses() As Beacon.OmniLicense = Identity.Licenses(Flags)
		      Var Reported As Boolean = True
		      Var NeedsRefresh As Boolean
		      For Each License As Beacon.OmniLicense In Licenses
		        If License.HasBeenUsed Then
		          Continue
		        End If
		        
		        Try
		          Var Request As New BeaconAPI.Request("/licenses/" + EncodeURLComponent(License.LicenseId), "PUT", "{}", "application/json")
		          Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		          Reported = Reported And Response.Success
		          NeedsRefresh = NeedsRefresh Or Response.Success
		        Catch Err As RuntimeException
		          Reported = False
		        End Try
		      Next
		      If NeedsRefresh Then
		        BeaconAPI.UserController.RefreshUserDetails()
		      End If
		      If Not Reported Then
		        Issues.Add(New Beacon.Issue("", "First time license check has failed."))
		      End If
		    Else
		      Issues.Add(New Beacon.Issue("", "There is no valid identity file."))
		    End If
		  End If
		  
		  Self.mShowUITimer.RunMode = Timer.RunModes.Off
		  Sender.AddUserInterfaceUpdate("Issues" : Issues)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mThread_UserInterfaceUpdate(Sender As Thread, Updates() As Dictionary)
		  #Pragma Unused Sender
		  
		  For Idx As Integer = 0 To Updates.LastIndex
		    Var Dict As Dictionary = Updates(Idx)
		    If Dict.HasKey("Issues") Then
		      Var Issues As Beacon.ProjectValidationResults = Dict.Value("Issues")
		      RaiseEvent ValidationComplete(Issues, Self.mUserData)
		    End If
		  Next Idx
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartValidation(Project As Beacon.Project, UserData As Variant = Nil)
		  Self.mProject = Project
		  Self.mUserData = UserData
		  Self.mShowUITimer.RunMode = Timer.RunModes.Single
		  Self.mThread.Start
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Validating()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValidationComplete(Issues As Beacon.ProjectValidationResults, UserData As Variant)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mProject As Beacon.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShowUITimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThread As Thread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserData As Variant
	#tag EndProperty


	#tag ViewBehavior
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
