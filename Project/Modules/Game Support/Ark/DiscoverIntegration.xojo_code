#tag Class
Protected Class DiscoverIntegration
Inherits Beacon.DiscoverIntegration
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Function Run() As Beacon.Project
		  Var Provider As Beacon.HostingProvider = Self.Profile.CreateHostingProvider
		  If Provider Is Nil Then
		    Self.SetError("Failed to create hosting provider object")
		    Return Nil
		  End If
		  
		  Var Profile As Ark.ServerProfile = Self.Profile
		  Var Data As New Ark.DiscoveredData
		  Var GameIniPath As String = Profile.GameIniPath
		  If GameIniPath.IsEmpty = False Then
		    Var Transfer As New Beacon.IntegrationTransfer(GameIniPath)
		    Provider.DownloadFile(Self, Profile, Transfer, Beacon.Integration.DownloadFailureMode.Required)
		    If Not Transfer.Success Then
		      Self.SetError("Failed to load Game.ini: " + Transfer.ErrorMessage)
		      Return Nil
		    End If
		    Data.GameIniContent = Transfer.Content
		  End If
		  Var GameUserSettingsIniPath As String = Profile.GameUserSettingsIniPath
		  If GameUserSettingsIniPath.IsEmpty = False Then
		    Var Transfer As New Beacon.IntegrationTransfer(GameUserSettingsIniPath)
		    Provider.DownloadFile(Self, Profile, Transfer, Beacon.Integration.DownloadFailureMode.Required)
		    If Not Transfer.Success Then
		      Self.SetError("Failed to load GameUserSettings.ini: " + Transfer.ErrorMessage)
		      Return Nil
		    End If
		    Data.GameUserSettingsIniContent = Transfer.Content
		  End If
		  
		  If Provider.SupportsGameSettings Then
		    Var Settings() As Ark.ConfigOption = Ark.DataSource.Pool.Get(False).GetConfigOptions("", "", "", False)
		  End If
		  
		  Var Progress As New Beacon.DummyProgressDisplayer
		  Return Ark.ImportThread.RunSynchronous(Data, Self.mDestinationProject, Progress)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Begin(DestinationProject As Ark.Project)
		  Self.mDestinationProject = DestinationProject
		  Super.Begin()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DestinationProject() As Ark.Project
		  Return Self.mDestinationProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Profile() As Ark.ServerProfile
		  Return Ark.ServerProfile(Super.Profile)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDestinationProject As Ark.Project
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
