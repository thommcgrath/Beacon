#tag Module
Protected Module BeaconAPI
	#tag Method, Flags = &h1
		Protected Sub Send(Request As BeaconAPI.Request)
		  // We really want only one socket here so that things queue and stay in order
		  
		  If mSharedSocket Is Nil Then
		    mSharedSocket = New BeaconAPI.Socket
		  End If
		  mSharedSocket.Start(Request)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URL(Path As String = "/", Versioned As Boolean = True) As String
		  #if DebugBuild And App.ForceLiveData = False
		    Var Domain As String = "https://local-api.usebeacon.app"
		  #else
		    Var Domain As String = "https://api.usebeacon.app"
		  #endif
		  If Path.Length = 0 Or Path.Left(1) <> "/" Then
		    Path = "/" + Path
		  End If
		  Return Domain + If(Versioned, "/v" + Version.ToString, "") + Path
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UserController() As BeaconAPI.UserController
		  If mUserController Is Nil Then
		    mUserController = New BeaconAPI.UserController
		  End If
		  Return mUserController
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSharedSocket As BeaconAPI.Socket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserController As BeaconAPI.UserController
	#tag EndProperty


	#tag Constant, Name = PublicKey, Type = String, Dynamic = False, Default = \"30820122300D06092A864886F70D01010105000382010F003082010A02820101009F0CA4882EC50BD8F18DAFA6BB0A83C82BD7AF43872F2DFDF21C932E028EAB699CE4EF229B087565B9DFE48A99101BF5798E8DAD6995489E080813F9EAC88E01F1BD0E250129D9F4837590732A8E11AD6398980246C7DAE9D0C4574239A563EF9C550EB30CED63F7F8D187F7D6CBED463C11EC1FEE4AF8CE87C8B54AB244EFD81CF9F218D8A7674638D7A4F302ED850FD27DB7B1C3B1B8CDCD51FF15D4F8FBD236806CFA2B5E97A6A1504F8CE891CEB786B0B13761B2892A91C78AF9CBFD3CF272613992C71948E6702C0A0AF6345A1BD334A9C6895A5AD7E529217ED6251C3AF78F520642B02FBCD08D1864BCCA584477697326C2FD40BD8FABD7FDB253DE5F0203010001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
