#tag Class
Protected Class GSAIntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Function Discover() As Beacon.DiscoveredData()
		  Var Servers() As Beacon.DiscoveredData
		  If Self.mAccount Is Nil Then
		    Self.mAccount = Self.Document.Accounts.GetByUUID(Self.Profile.ExternalAccountUUID)
		    If Self.mAccount Is Nil Then
		      Self.SetError("Cannot list templates because the required account is no longer available. Check the Accounts editor in your Beacon project.")
		      Return Servers
		    End If
		  End If
		  
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAccount.AccessToken
		  Socket.RequestHeader("GSA-ID") = Beacon.GSAIntegrationEngine.GSAID
		  Var Locked As Boolean = Preferences.SignalConnection()
		  Socket.Send("GET", "https://api.gameserverapp.com/system-api/v1/config-template")
		  If Locked Then
		    Preferences.ReleaseConnection()
		  End If
		  If Socket.LastHTTPStatus <> 200 Or Socket.LastString.IsEmpty Then
		    // Something went wrong
		    If Socket.LastException Is Nil Then
		      Var Reason As String
		      Select Case Socket.LastHTTPStatus
		      Case 200
		        Reason = "GameServerApp.com sent an empty response."
		      Case 401
		        Reason = "GameServerApp.com rejected the API token."
		      Case 404
		        Reason = "GameServerApp.com endpoint not found."
		      Case 429
		        Reason = "GameServerApp.com rate limit exceeded."
		      Case 500
		        Reason = "GameServerApp.com internal server error."
		      Else
		        Reason = "HTTP " + Socket.LastHTTPStatus.ToString(Locale.Raw, "0") + " response"
		      End Select
		      Self.SetError(Reason)
		      Self.Log("Response: " + Socket.LastString)
		    Else
		      Self.SetError(Socket.LastException)
		    End If
		    Return Servers
		  End If
		  
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    Var Templates() As Variant
		    If Parsed.HasKey(Self.ArkAppID) Then
		      Templates = Parsed.Value(Self.ArkAppID)
		    ElseIf Parsed.HasKey(Self.ArkAppID.ToString(Locale.Raw, "0")) Then
		      Templates = Parsed.Value(Self.ArkAppID.ToString(Locale.Raw, "0"))
		    End If
		    
		    For Each Dict As Dictionary In Templates
		      If Dict.Value("can_edit").BooleanValue = False Then
		        Continue
		      End If
		      Var TemplateID As Integer = Dict.Value("id").IntegerValue
		      Var TemplateName As String = Dict.Value("name").StringValue
		      
		      Var Profile As New Beacon.GSAServerProfile(TemplateID, TemplateName)
		      Profile.ExternalAccountUUID = Self.mAccount.UUID
		      Profile.Mask = Beacon.Maps.All.Mask
		      
		      Var Server As New Beacon.GSADiscoveredData(TemplateID, Self.mAccount.AccessToken)
		      Server.Profile = Profile
		      
		      Servers.Add(Server)
		    Next
		  Catch Err As RuntimeException
		    Self.SetError(Err)
		  End Try
		  
		  Return Servers
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Account As Beacon.ExternalAccount)
		  // Simply changing the scope of the constructor
		  Self.mAccount = Account
		  Super.Constructor(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  // Simply changing the scope of the constructor
		  Super.Constructor(Profile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GSAID() As String
		  Static ID As String
		  If ID = "" Then
		    #if DebugBuild
		      Var Chars As String = App.ResourcesFolder.Child("GSAID.txt").Read
		    #else
		      Var Chars As String = GSAIDEncoded
		    #endif
		    ID = DefineEncoding(DecodeBase64(Chars.Middle(3, 1) + Chars.Middle(3, 1) + Chars.Middle(22, 1) + Chars.Middle(10, 1) + Chars.Middle(13, 1) + Chars.Middle(26, 1) + Chars.Middle(5, 1) + Chars.Middle(9, 1) + Chars.Middle(13, 1) + Chars.Middle(18, 1) + Chars.Middle(17, 1) + Chars.Middle(14, 1) + Chars.Middle(20, 1) + Chars.Middle(23, 1) + Chars.Middle(10, 1) + Chars.Middle(18, 1) + Chars.Middle(24, 1) + Chars.Middle(4, 1) + Chars.Middle(1, 1) + Chars.Middle(16, 1) + Chars.Middle(11, 1) + Chars.Middle(5, 1) + Chars.Middle(5, 1) + Chars.Middle(19, 1) + Chars.Middle(24, 1) + Chars.Middle(13, 1) + Chars.Middle(2, 1) + Chars.Middle(9, 1) + Chars.Middle(2, 1) + Chars.Middle(4, 1) + Chars.Middle(11, 1) + Chars.Middle(9, 1) + Chars.Middle(7, 1) + Chars.Middle(4, 1) + Chars.Middle(22, 1) + Chars.Middle(9, 1) + Chars.Middle(0, 1) + Chars.Middle(8, 1) + Chars.Middle(1, 1) + Chars.Middle(8, 1) + Chars.Middle(3, 1) + Chars.Middle(13, 1) + Chars.Middle(6, 1) + Chars.Middle(0, 1) + Chars.Middle(11, 1) + Chars.Middle(22, 1) + Chars.Middle(17, 1) + Chars.Middle(21, 1) + Chars.Middle(12, 1) + Chars.Middle(13, 1) + Chars.Middle(6, 1) + Chars.Middle(24, 1) + Chars.Middle(11, 1) + Chars.Middle(25, 1) + Chars.Middle(15, 1) + Chars.Middle(15, 1)),Encodings.UTF8)
		  End If
		  Return ID
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAccount As Beacon.ExternalAccount
	#tag EndProperty


	#tag Constant, Name = ArkAppID, Type = Double, Dynamic = False, Default = \"376030", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GSAIDEncoded, Type = String, Dynamic = False, Default = \"You didn\'t think it would be that easy did you\?", Scope = Private
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
