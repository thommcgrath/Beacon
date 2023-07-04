#tag Class
Protected Class UserController
	#tag Method, Flags = &h21
		Private Sub Callback_RefreshUserDetails(Request As BeaconAPI.Request, Response As BeaconAPI.Response)
		  #Pragma Unused Request
		  
		  Var Parsed As Dictionary
		  Try
		    Parsed = Beacon.ParseJSON(Response.Content)
		  Catch Err as RuntimeException
		    Return
		  End Try
		  
		  Var Identity As Beacon.Identity = App.IdentityManager.Import(Parsed)
		  If (Identity Is Nil) = False And Identity.IsValid Then
		    App.IdentityManager.CurrentIdentity = Identity
		  Else
		    Break
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshUserDetails()
		  Var Request As New BeaconAPI.Request("/user?deviceId=" + Beacon.HardwareID, "GET", AddressOf Callback_RefreshUserDetails)
		  If Thread.Current Is Nil Then
		    BeaconAPI.Send(Request)
		  Else
		    Var Response As BeaconAPI.Response = BeaconAPI.SendSync(Request)
		    Self.Callback_RefreshUserDetails(Request, Response)
		  End If
		End Sub
	#tag EndMethod


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
