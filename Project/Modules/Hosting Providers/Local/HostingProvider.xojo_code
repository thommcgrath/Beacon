#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider,Ark.HostingProvider,ArkSA.HostingProvider,Palworld.HostingProvider
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function CommandLineOptions(Project As Ark.Project, Profile As Ark.ServerProfile) As Dictionary
		  // Part of the Ark.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Project As Ark.Project, Profile As Ark.ServerProfile, Assigns Options As Dictionary)
		  // Part of the Ark.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Options
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CommandLineOptions(Project As ArkSA.Project, Profile As ArkSA.ServerProfile) As Dictionary
		  // Part of the ArkSA.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CommandLineOptions(Project As ArkSA.Project, Profile As ArkSA.ServerProfile, Assigns Options As Dictionary)
		  // Part of the ArkSA.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Options
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Logger As Beacon.LogProducer = Nil)
		  If Logger Is Nil Then
		    Self.mLogger = New Beacon.DummyLogProducer
		  Else
		    Self.mLogger = Logger
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateBackup(Project As Beacon.Project, Profile As Beacon.ServerProfile, Name As String, ConfigFiles As Boolean, SaveData As Boolean)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused Name
		  #Pragma Unused ConfigFiles
		  #Pragma Unused SaveData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeployPostflight(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeployPreflight(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var File As FolderItem = BookmarkedFolderItem.FromSaveInfo(Transfer.Path)
		  If File Is Nil Or File.Exists = False Then
		    If FailureMode = Beacon.Integration.DownloadFailureMode.Required Then
		      Transfer.Success = False
		      Transfer.ErrorMessage = "File not found"
		    Else
		      Transfer.Success = True
		    End If
		    Return
		  End If
		  
		  Try
		    Transfer.Content = File.Read
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    If FailureMode = Beacon.Integration.DownloadFailureMode.ErrorsAllowed Then
		      Transfer.Success = True
		    Else
		      Transfer.Success = False
		      Transfer.ErrorMessage = Err.Message
		    End If
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FeatureFlags(Project As Beacon.Project, Profile As Beacon.ServerProfile) As UInt64
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return Local.Identifier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Project As Beacon.Project, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused StartingPath
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Config
		  #Pragma Unused GameId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Logger() As Beacon.LogProducer
		  Return Self.mLogger
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchesToken(Token As BeaconAPI.ProviderToken) As Boolean
		  #Pragma Unused Token
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As Ark.Project, Profile As Ark.ServerProfile)
		  // Part of the Ark.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As ArkSA.Project, Profile As ArkSA.ServerProfile)
		  // Part of the ArkSA.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshProfile(Project As Palworld.Project, Profile As Palworld.ServerProfile)
		  // Part of the Palworld.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Project As Beacon.Project, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Project As Beacon.Project, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  #Pragma Unused StopMessage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportedDeployPlans(Project As Beacon.Project, Profile As Beacon.ServerProfile) As Beacon.DeployPlan
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Return Beacon.DeployPlan.UploadOnly
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Project As Beacon.Project, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  // Part of the Beacon.HostingProvider interface.
		  
		  #Pragma Unused Project
		  #Pragma Unused Profile
		  
		  Var File As FolderItem = BookmarkedFolderItem.FromSaveInfo(Transfer.Path)
		  If File Is Nil Then
		    Transfer.SetError("Could not get path to file")
		    Return
		  End If
		  
		  Try
		    File.Write(Transfer.Content)
		    Transfer.Success = True
		  Catch Err As RuntimeException
		    If Err.Message.IsEmpty Then
		      Var Info As Introspection.TypeInfo = Introspection.GetType(Err)
		      Transfer.SetError(Info.FullName + " while trying to write file")
		    Else
		      Transfer.SetError(Err.Message)
		    End If
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLogger As Beacon.LogProducer
	#tag EndProperty


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
