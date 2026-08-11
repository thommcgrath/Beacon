#tag Class
Private Class APIRequest
Inherits Beacon.IntegrationRequest
	#tag Event
		Function GetAuthHeader(Token As BeaconAPI.ProviderToken) As String
		  Return "Bearer " + Token.AccessToken
		End Function
	#tag EndEvent


End Class
#tag EndClass
