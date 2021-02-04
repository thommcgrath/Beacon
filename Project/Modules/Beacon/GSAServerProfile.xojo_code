#tag Class
Protected Class GSAServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Provider") = "GameServerApp"
		End Sub
	#tag EndEvent


End Class
#tag EndClass
