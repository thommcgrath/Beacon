#tag Module
Protected Module Nitrado
	#tag Method, Flags = &h1
		Protected Function PortlistsForProducts(Token As BeaconAPI.ProviderToken, ParamArray Products() As String) As String()
		  If mGameLists Is Nil Then
		    mGameLists = New Dictionary
		  End If
		  
		  Products.Sort
		  Var CacheKeyShort As String = EncodeHex(Crypto.SHA2_256(Token.AccessToken)).Lowercase
		  Var CacheKeyFull As String = EncodeHex(Crypto.SHA2_256(Token.AccessToken + ":" + String.FromArray(Products, ","))).Lowercase
		  
		  Var Shortcodes() As String
		  If mGameLists.HasKey(CacheKeyFull) Then
		    Shortcodes = mGameLists.Value(CacheKeyFull)
		    Return Shortcodes
		  End If
		  
		  If mGameLists.HasKey(CacheKeyShort) = False Then
		    Try
		      Var Response As Nitrado.APIResponse = Nitrado.APIRequest.Get("https://api.nitrado.net/game/list_auth", Token)
		      If Response.Success = False Then
		        Return Shortcodes
		      End If
		      
		      Var Parsed As New JSONItem(Response.Content)
		      mGameLists.Value(CacheKeyShort) = Parsed.Child("data").Child("game_list")
		    Catch Err As RuntimeException
		      Return Shortcodes
		    End Try
		  End If
		  
		  Var GameList As JSONItem = mGameLists.Value(CacheKeyShort)
		  Var Bound As Integer = GameList.LastRowIndex
		  For Idx As Integer = 0 To Bound
		    Var Game As JSONItem = GameList.ChildAt(Idx)
		    If Products.IndexOf(Game.Value("product").StringValue) > -1 Then
		      Shortcodes.Add(Game.Value("portlistShort").StringValue)
		    End If
		  Next
		  mGameLists.Value(CacheKeyFull) = Shortcodes
		  Return Shortcodes
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mGameLists As Dictionary
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
