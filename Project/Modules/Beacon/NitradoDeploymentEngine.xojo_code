#tag Class
Protected Class NitradoDeploymentEngine
	#tag Method, Flags = &h0
		Sub ListServers(AccessToken As Text)
		  If AccessToken = "" Then
		    Return
		  End If
		  
		  Dim URL As Text = "https://api.nitrado.net/services?access_token=" + Beacon.EncodeURLComponent(AccessToken)
		  SimpleHTTP.Get(URL, AddressOf ListServers_Callback)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListServers_Callback(URL As Text, Status As Integer, Content As Xojo.Core.MemoryBlock)
		  Dim Profiles() As Beacon.NitradoServerProfile
		  
		  If Status <> 200 Then
		    RaiseEvent ServersFound(Profiles)
		    Return
		  End If
		  
		  Try
		    Dim TextContent As Text = Xojo.Core.TextEncoding.UTF8.ConvertDataToText(Content, False)
		    Dim Reply As Xojo.Core.Dictionary = Xojo.Data.ParseJSON(TextContent)
		    If Reply.HasKey("status") = False Or Reply.Value("status") <> "success" Then
		      RaiseEvent ServersFound(Profiles)
		      Return
		    End If
		    
		    Dim Data As Xojo.Core.Dictionary = Reply.Value("data")
		    Dim Services() As Auto = Data.Value("services")
		    For Each Service As Xojo.Core.Dictionary In Services
		      Dim Type As Text = Service.Value("type")
		      If Type <> "gameserver" Then
		        Continue
		      End If
		      
		      Dim Details As Xojo.Core.Dictionary = Service.Value("details")
		      Dim Game As Text = Details.Value("game")
		      If Not Game.BeginsWith("Ark: Survival Evolved") Then
		        Continue
		      End If
		      
		      Dim Profile As New Beacon.NitradoServerProfile
		      Profile.Name = Details.Value("name")
		      Profile.Address = Details.Value("address")
		      Profiles.Append(Profile)
		    Next
		  Catch Err As RuntimeException
		    // Nope
		  End Try
		  
		  RaiseEvent ServersFound(Profiles)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ServersFound(Servers() As Beacon.NitradoServerProfile)
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
