#tag Class
Protected Class LocalIntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Sub DownloadFile(Transfer As Beacon.IntegrationTransfer, FailureMode As DownloadFailureMode, Profile As Beacon.ServerProfile)
		  Var File As FolderItem
		  Select Case Transfer.Filename
		  Case "Game.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameIniFile
		  Case "GameUserSettings.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameUserSettingsIniFile
		  Else
		    Transfer.SetError("Unknown file " + Transfer.Filename)
		    Return
		  End Select
		  
		  If File <> Nil And File.Exists Then
		    Try
		      Transfer.Content = File.Read
		      Transfer.Success = True
		    Catch Err As RuntimeException
		      Transfer.SetError(Err.Message)
		    End Try
		  Else
		    Transfer.SetError("File " + Transfer.Filename + " does not exist.")
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub UploadFile(Transfer As Beacon.IntegrationTransfer)
		  Var File As FolderItem
		  Select Case Transfer.Filename
		  Case "Game.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameIniFile
		  Case "GameUserSettings.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameUserSettingsIniFile
		  Else
		    Transfer.SetError("Unknown file " + Transfer.Filename)
		    Return
		  End Select
		  
		  If File Is Nil Then
		    Transfer.SetError("Destination is invalid")
		    Return
		  End If
		  
		  Try
		    If File.Write(Transfer.Content) = False Then
		      Transfer.SetError("Could not write to " + File.NativePath)
		      Return
		    End If
		    
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    Transfer.SetError(Err.Message)
		  End Try
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Profile As Beacon.ServerProfile)
		  // Simply changing the scope of the constructor
		  Super.Constructor(Profile)
		End Sub
	#tag EndMethod


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
