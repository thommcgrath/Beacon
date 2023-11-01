#tag Class
Protected Class UserController
	#tag Method, Flags = &h21
		Private Function Callback_RefreshUserDetails_Common(Request As BeaconAPI.Request, Response As BeaconAPI.Response) As Boolean
		  // True = Show login window
		  
		  #Pragma Unused Request
		  
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Response.Content)
		    Select Case Response.HTTPStatus
		    Case 200
		      Var Identity As Beacon.Identity = App.IdentityManager.Import(Parsed)
		      If (Identity Is Nil) = False And Identity.IsValid Then
		        App.IdentityManager.CurrentIdentity = Identity
		      Else
		        Var Err As New UnsupportedOperationException
		        Err.Message = "Could not load user profile."
		        Raise Err
		      End If
		    Case 401, 403
		      Return True
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
		  Var ShowLoginWindow As Boolean
		  Try
		    ShowLoginWindow = Self.Callback_RefreshUserDetails_Common(Request, Response)
		  Catch Err As RuntimeException
		    If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		      Self.ShowRefreshResponse(Err)
		    End If
		    Return
		  End Try
		  
		  Select Case Verbosity
		  Case BeaconAPI.UserController.VerbosityLoginOnly
		    If ShowLoginWindow Then
		      Self.ShowLoginWindow()
		    End If
		  Case BeaconAPI.UserController.VerbosityFull
		    If ShowLoginWindow Then
		      Self.ShowLoginWindow()
		    Else
		      Self.ShowRefreshResponse(Response)
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
		    Var ShowLoginWindow As Boolean
		    Try
		      ShowLoginWindow = Self.Callback_RefreshUserDetails_Common(Request, Response)
		    Catch Err As RuntimeException
		      If Verbosity = BeaconAPI.UserController.VerbosityFull Then
		        Call CallLater.Schedule(1, AddressOf ShowRefreshResponse, Err)
		      End If
		      Return
		    End Try
		    
		    Select Case Verbosity
		    Case BeaconAPI.UserController.VerbosityLoginOnly
		      If ShowLoginWindow Then
		        Call CallLater.Schedule(1, AddressOf ShowLoginWindow)
		      End If
		    Case BeaconAPI.UserController.VerbosityFull
		      If ShowLoginWindow Then
		        Call CallLater.Schedule(1, AddressOf ShowLoginWindow)
		      Else
		        Call CallLater.Schedule(1, AddressOf ShowRefreshResponse, Response)
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


	#tag Constant, Name = VerbosityFull, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VerbosityLoginOnly, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VerbositySilent, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant


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
