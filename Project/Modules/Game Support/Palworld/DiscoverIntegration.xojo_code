#tag Class
Protected Class DiscoverIntegration
Inherits Beacon.DiscoverIntegration
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function Run() As Beacon.Project
		  Var Project As Beacon.Project = Self.Project
		  Var Provider As Beacon.HostingProvider = Self.Provider
		  Var GetMapFromLogs As Boolean = True
		  
		  Var Profile As Palworld.ServerProfile = Self.Profile
		  Var Data As New Palworld.DiscoveredData
		  Data.Profile = Profile
		  Select Case Provider
		  Case IsA Nitrado.HostingProvider
		    Self.Log("Checking server status…")
		    Try
		      Profile.BasePath = Provider.GameSetting(Project, Profile, New Beacon.GenericGameSetting(Beacon.GenericGameSetting.TypeString, "/game_specific.path"))
		    Catch Err As RuntimeException
		      Self.SetError("Could not find server base path: " + Err.Message)
		      Return Nil
		    End Try
		  End Select
		  
		  Var SettingsIniPath As String = Profile.SettingsIniPath
		  If SettingsIniPath.IsEmpty = False Then
		    Var DownloadSuccess As Boolean
		    Var IniContent As String = Self.GetFile(SettingsIniPath, Palworld.ConfigFileSettings, Beacon.Integration.DownloadFailureMode.Required, Profile, False, DownloadSuccess)
		    If DownloadSuccess Then
		      Data.SettingsIniContent = IniContent.GuessEncoding("/Script/")
		    Else
		      Return Nil
		    End If
		  End If
		  
		  Self.mImportProgress = New Beacon.DummyProgressDisplayer
		  Var NewProject As Palworld.Project = Palworld.ImportThread.RunSynchronous(Data, Self.mDestinationProject, Self.mImportProgress)
		  Self.mImportProgress = Nil
		  Return NewProject
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin(DestinationProject As Palworld.Project)
		  Self.mDestinationProject = DestinationProject
		  Super.Begin()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DestinationProject() As Palworld.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Palworld.ServerProfile
		  Return Palworld.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusMessage() As String
		  If (Self.mImportProgress Is Nil) = False Then
		    Return Self.mImportProgress.Detail
		  Else
		    Return Super.StatusMessage
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDestinationProject As Palworld.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportProgress As Beacon.DummyProgressDisplayer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ThreadPriority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
