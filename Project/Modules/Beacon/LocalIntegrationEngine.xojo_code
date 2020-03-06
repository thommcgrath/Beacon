#tag Class
Protected Class LocalIntegrationEngine
Inherits Beacon.IntegrationEngine
	#tag Event
		Function DownloadFile(Filename As String) As String
		  Var File As FolderItem
		  Select Case Filename
		  Case "Game.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameIniFile
		  Case "GameUserSettings.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameUserSettingsIniFile
		  Else
		    Return ""
		  End Select
		  
		  If File <> Nil And File.Exists Then
		    Return File.Read
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub UploadFile(Contents As String, Filename As String)
		  Var File As FolderItem
		  Select Case Filename
		  Case "Game.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameIniFile
		  Case "GameUserSettings.ini"
		    File = Beacon.LocalServerProfile(Self.Profile).GameUserSettingsIniFile
		  Else
		    Return
		  End Select
		  
		  If File <> Nil Then
		    If Not File.Write(Contents) Then
		      Self.SetError("Unable to write to " + File.NativePath)
		      Return
		    End If
		  End If
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
