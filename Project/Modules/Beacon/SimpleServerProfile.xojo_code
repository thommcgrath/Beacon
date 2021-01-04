#tag Class
Protected Class SimpleServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub WriteToDictionary(Dict As Dictionary)
		  Dict.Value("Provider") = "Simple"
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not all the super constructor
		End Sub
	#tag EndMethod


End Class
#tag EndClass
