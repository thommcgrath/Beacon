#tag Class
Protected Class UserController
	#tag Method, Flags = &h21
		Private Function Callback_RefreshUserDetails_Common(Request As BeaconAPI.Request, Response As BeaconAPI.Response) As IdentityResponse
		  // True = Show login window
		  
		  #Pragma Unused Request
		  
		  Try
		    Var Parsed As New JSONItem(Response.Content)
		    Select Case Response.HTTPStatus
		    Case 200
		      Var Result As IdentityImportResponse = App.IdentityManager.Import(Parsed, "")
		      If Result.Success Then
		        App.IdentityManager.CurrentIdentity = Result.Identity
		        Return IdentityResponse.Success(Result.Identity)
		      ElseIf Result.Status = IdentityImportResponse.Statuses.SecretNeeded Then
		        Return IdentityResponse.SecretNeeded(Parsed)
		      Else
		        Var Err As New UnsupportedOperationException
		        Err.Message = "Could not load user profile."
		        Raise Err
		      End If
		    Case 401, 403
		      App.Log("Login window will be presented because user details returned an unauthorized or forbidden response.")
		      Return IdentityResponse.Failed()
		    End Select
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName, "Importing identity")
		    Raise Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Callback_RefreshUserDetails_WithUI(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  Var Verbosity As Integer = Request.Tag
		  Var NextStep As IdentityResponse
		  Try
		    NextStep = Self.Callback_RefreshUserDetails_Common(Request, Response)
		  Catch Err As RuntimeException
		    If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		      Self.ShowRefreshResponse(Err)
		    End If
		    Return
		  End Try
		  
		  Select Case NextStep.Mode
		  Case BeaconAPI.IdentityResponse.Modes.Success
		    If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		      Self.ShowRefreshResponse(Response)
		    End If
		  Case BeaconAPI.IdentityResponse.Modes.SecretNeeded
		    If Verbosity <> BeaconAPI.UserController.VerbositySilent Then
		      Var Params As New Dictionary
		      Params.Value("nextStep") = NextStep
		      Params.Value("verbosity") = Verbosity
		      Params.Value("apiResponse") = Response
		      Self.ShowSecretWindow(Params)
		    End If
		  Case BeaconAPI.IdentityResponse.Modes.LoginNeeded
		    If Verbosity <> BeaconAPI.UserController.VerbositySilent Then
		      Self.ShowLoginWindow()
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshUserDetails(Verbosity As Integer)
		  Var Url As String = "/user?deviceId=" + Beacon.HardwareId
		  If (Thread.Current Is Nil) = False Then
		    Var Request As New BeaconAPI.Request(Url, "GET")
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    Var NextStep As BeaconAPI.IdentityResponse
		    Try
		      NextStep = Self.Callback_RefreshUserDetails_Common(Request, Response)
		    Catch Err As RuntimeException
		      If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		        Call CallLater.Schedule(1, AddressOf ShowRefreshResponse, Err)
		      End If
		      Return
		    End Try
		    
		    Select Case NextStep.Mode
		    Case BeaconAPI.IdentityResponse.Modes.Success
		      If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		        Call CallLater.Schedule(1, AddressOf ShowRefreshResponse, Response)
		      End If
		    Case BeaconAPI.IdentityResponse.Modes.SecretNeeded
		      If Verbosity <> BeaconAPI.UserController.VerbositySilent Then
		        Var Params As New Dictionary
		        Params.Value("nextStep") = NextStep
		        Params.Value("verbosity") = Verbosity
		        Params.Value("apiResponse") = Response
		        Call CallLater.Schedule(1, AddressOf ShowSecretWindow, Params)
		      End If
		    Case BeaconAPI.IdentityResponse.Modes.LoginNeeded
		      If Verbosity <> BeaconAPI.UserController.VerbositySilent Then
		        Call CallLater.Schedule(1, AddressOf ShowLoginWindow)
		      End If
		    End Select
		    
		    Return
		  End If
		  
		  Var Request As New BeaconAPI.Request(Url, "GET", Addressof Callback_RefreshUserDetails_WithUI)
		  Request.Tag = Verbosity
		  BeaconAPI.Send(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowLoginWindow()
		  UserWelcomeWindow.Present(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowRefreshResponse(Param As Variant)
		  If Param IsA RuntimeException Then
		    BeaconUI.ShowAlert("There was an error updating your profile and purchases.", "The profile data failed to decode and decrypt. Try signing into your account again.")
		    Return
		  End If
		  
		  Var Response As BeaconAPI.Response = Param
		  Select Case Response.HTTPStatus
		  Case 200
		    BeaconUI.ShowAlert("User information has been refreshed", "Beacon has downloaded profile and purchase information for " + App.IdentityManager.CurrentIdentity.Username(True) + ".")
		  Case 500
		    BeaconUI.ShowAlert("There was an error updating your profile and purchases.", "Beacon's server experienced an error while loading your profile and purchase information. Hopefully this is temporary, so please try again in a few minutes.")
		  Else
		    BeaconUI.ShowAlert("There was an error updating your profile and purchases.", "Beacon's server replied with a " + Response.HTTPStatus.ToString(Locale.Raw, "0") + " response, which Beacon isn't expecting. You might have luck signing into your account again.")
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowSecretWindow(Param As Variant)
		  Var Params As Dictionary = Param
		  Var NextStep As IdentityResponse = Params.Value("nextStep")
		  Var Verbosity As Integer = Params.Value("verbosity")
		  Var Response As BeaconAPI.Response = Params.Value("apiResponse")
		  
		  Var Secret As String = UserSecretWindow.Present(Nil)
		  If Secret.IsEmpty Then
		    Return
		  End If
		  
		  Var Result As IdentityImportResponse = App.IdentityManager.Import(NextStep.PendingIdentity, Secret)
		  If Result.Success Then
		    App.IdentityManager.CurrentIdentity = Result.Identity
		    If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		      Call CallLater.Schedule(1, AddressOf ShowRefreshResponse, Response)
		    End If
		  ElseIf Result.Status = IdentityImportResponse.Statuses.SecretNeeded Then
		    Var NextParams As New Dictionary
		    NextParams.Value("nextStep") = IdentityResponse.SecretNeeded(NextStep.PendingIdentity)
		    NextParams.Value("verbosity") = Verbosity
		    NextParams.Value("apiResponse") = Response
		    Self.ShowSecretWindow(NextParams)
		  Else
		    Var Err As New UnsupportedOperationException
		    Err.Message = "Could not load user profile."
		    Raise Err
		  End If
		End Sub
	#tag EndMethod


	#tag Constant, Name = VerbosityFull, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VerbosityLoginOnly, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VerbositySilent, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant


	#tag Enum, Name = RefreshResults, Type = Integer, Flags = &h21
		Silent
		  ShowLoginWindow
		ShowSecretWindow
	#tag EndEnum


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
