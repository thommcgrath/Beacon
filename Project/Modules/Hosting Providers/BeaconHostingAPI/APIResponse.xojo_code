#tag Class
Private Class APIResponse
Inherits Beacon.IntegrationResponse
	#tag Event
		Sub CustomizeError(Err As Beacon.IntegrationException, Socket As SimpleHTTP.SynchronousHTTPSocket, IsUnknown As Boolean)
		  #Pragma Unused IsUnknown
		  
		  Try
		    Var Parsed As New JSONItem(Socket.LastContent)
		    If Parsed.HasKey("message") Then
		      Err.Message = Parsed.Value("message")
		    End If
		  Catch ParseErr As RuntimeException
		  End Try
		End Sub
	#tag EndEvent


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
