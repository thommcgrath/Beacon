#tag Class
Private Class APIRequest
Inherits Beacon.IntegrationRequest
	#tag Event
		Sub Authorize(Token As BeaconAPI.ProviderToken, Headers As Dictionary)
		  Headers.Value("Authorization") = "Bearer " + Token.AccessToken
		End Sub
	#tag EndEvent


End Class
#tag EndClass
