#tag Module
Protected Module Nitrado
	#tag Method, Flags = &h1
		Protected Function PortlistsForGroup(AuthToken As String, Group As String) As String()
		  If GameLists Is Nil Then
		    GameLists = New Dictionary
		  End If
		  
		  Var Shortcodes() As String
		  
		  If GameLists.HasKey(AuthToken + ":" + Group) Then
		    Shortcodes = GameLists.Value(AuthToken + ":" + Group)
		    Return Shortcodes
		  End If
		  
		  If GameLists.HasKey(AuthToken) = False Then
		    Var Locked As Boolean = Preferences.SignalConnection()
		    Var Errored As Boolean = True
		    Try
		      Var Socket As New SimpleHTTP.SynchronousHTTPSocket
		      Socket.RequestHeader("Authorization") = "Bearer " + AuthToken
		      Socket.Send("GET", "https://api.nitrado.net/game/list_auth")
		      If Socket.LastHTTPStatus = 200 Then
		        Var Parsed As New JSONItem(Socket.LastContent)
		        GameLists.Value(AuthToken) = Parsed.Child("data").Child("game_list")
		        Errored = False
		      End If
		    Catch Err As RuntimeException
		    End Try
		    If Locked Then
		      Preferences.ReleaseConnection()
		    End If
		    If Errored Then
		      Return Shortcodes
		    End If
		  End If
		  
		  Var GameList As JSONItem = GameLists.Value(AuthToken)
		  Var Bound As Integer = GameList.LastRowIndex
		  For Idx As Integer = 0 To Bound
		    Var Game As JSONItem = GameList.ChildAt(Idx)
		    If Game.Value("group") = Group Then
		      Shortcodes.Add(Game.Value("portlistShort"))
		    End If
		  Next
		  GameLists.Value(AuthToken + ":" + Group) = Shortcodes
		  Return Shortcodes
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private GameLists As Dictionary
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
End Module
#tag EndModule
