#tag Class
Protected Class GSADiscoveredData
Inherits Beacon.DiscoveredData
	#tag Method, Flags = &h0
		Function CommandLineOptions() As Dictionary
		  If Self.mLoaded = False Then
		    Self.DownloadTemplate()
		  End If
		  Return Super.CommandLineOptions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // To prevent calling without parameters
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(TemplateID As Integer, AuthToken As String)
		  Self.mTemplateID = TemplateID
		  Self.mAuthToken = AuthToken
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DownloadTemplate()
		  Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		  Socket.RequestHeader("Authorization") = "Bearer " + Self.mAuthToken
		  Socket.RequestHeader("GSA-ID") = GSAIntegrationEngine.GSAID
		  
		  Var Locked As Boolean = Preferences.SignalConnection
		  Socket.Send("GET", "https://api.gameserverapp.com/system-api/v1/config-template/" + Self.mTemplateID.ToString(Locale.Raw, "0"))
		  If Locked Then
		    Preferences.ReleaseConnection
		  End If
		  
		  If (Socket.LastException Is Nil) = False Then
		    App.Log(Socket.LastException, CurrentMethodName)
		    Return
		  ElseIf Socket.LastHTTPStatus <> 200 Or Socket.LastString.IsEmpty Then
		    App.Log("Could not download template " + Self.mTemplateID.ToString(Locale.Raw, "0") + ": HTTP " + Socket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		    App.Log(Socket.LastString)
		    Return
		  End If
		  
		  Try
		    Var Parsed As Dictionary = Beacon.ParseJSON(Socket.LastString)
		    
		    Var Configs() As Variant = Parsed.Value("configs")
		    For Each Dict As Dictionary In Configs
		      Var Content As String = Dict.Value("content")
		      Select Case Dict.Value("location")
		      Case "Game.ini"
		        Super.GameIniContent = Content
		      Case "GameUserSettings.ini"
		        Super.GameUserSettingsIniContent = Content
		      End Select
		    Next
		    
		    Var Parameters() As Variant = Parsed.Value("parameters")
		    Var Chain, Tail As String
		    For Each Dict As Dictionary In Parameters
		      Var Content As String = Dict.Value("content")
		      Select Case Dict.Value("location")
		      Case "chain"
		        Chain = Content
		      Case "end"
		        Tail = Content
		      End Select
		    Next
		    
		    Var Launch As String = "TheIsland?listen" + Chain + " " + Tail
		    Super.CommandLineOptions = Beacon.ParseCommandLine(Launch)
		  Catch Err As RuntimeException
		    App.Log(Err, CurrentMethodName)
		  End Try
		  
		  Self.mLoaded = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameIniContent() As String
		  If Self.mLoaded = False Then
		    Self.DownloadTemplate()
		  End If
		  Return Super.GameIniContent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameUserSettingsIniContent() As String
		  If Self.mLoaded = False Then
		    Self.DownloadTemplate()
		  End If
		  Return Super.GameUserSettingsIniContent
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAuthToken As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLoaded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemplateID As Integer
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
