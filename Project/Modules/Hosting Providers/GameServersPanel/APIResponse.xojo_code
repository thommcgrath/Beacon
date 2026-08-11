#tag Class
Private Class APIResponse
Inherits Beacon.IntegrationResponse
	#tag Event
		Sub CustomizeError(Err As Beacon.IntegrationException, Socket As SimpleHTTP.SynchronousHTTPSocket, IsUnknown As Boolean)
		  If IsUnknown = False Then
		    Return
		  End If
		  
		  Try
		    Var JSON As New JSONItem(Self.mContent)
		    If JSON.HasKey("message") Then
		      Err.Message = JSON.Value("message")
		    End If
		  Catch JSONErr As RuntimeException
		  End Try
		End Sub
	#tag EndEvent


End Class
#tag EndClass
