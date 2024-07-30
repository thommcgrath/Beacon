#tag Module
Protected Module CurseForge
	#tag Method, Flags = &h1
		Protected Function LookupMod(ModId As String) As CurseForge.ModInfo
		  // This should be used inside a thread
		  
		  Var LookupSocket As New SimpleHTTP.SynchronousHTTPSocket
		  LookupSocket.RequestHeader("User-Agent") = App.UserAgent
		  LookupSocket.RequestHeader("x-api-key") = Beacon.CurseForgeApiKey
		  LookupSocket.Send("GET", "https://api.curseforge.com/v1/mods/" + ModId)
		  If LookupSocket.LastHTTPStatus <> 200 Then
		    App.Log("Could not find mod " + ModId + ": HTTP #" + LookupSocket.LastHTTPStatus.ToString(Locale.Raw, "0"))
		    Return Nil
		  End If
		  
		  Var ResponseJson As New JSONItem(LookupSocket.LastContent)
		  Return New CurseForge.ModInfo(ResponseJson.Child("data"))
		End Function
	#tag EndMethod


End Module
#tag EndModule
