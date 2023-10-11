#tag Class
Protected Class HostingProvider
Implements Beacon.HostingProvider
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub CreateCheckpoint(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Name As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Discover(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile) As Beacon.DiscoveredData
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DownloadFile(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer, FailureMode As Beacon.Integration.DownloadFailureMode)
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GameSetting(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting) As Variant
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GameSetting(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Setting As Beacon.GameSetting, Assigns Value As Variant)
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetServerStatus(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile) As Beacon.ServerStatus
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Identifier() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListFiles(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, StartingPath As String) As String()
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListServers(Logger As Beacon.LogProducer, Config As Beacon.HostConfig, GameId As String) As Beacon.ServerProfile()
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatchProviderToken(Token As BeaconAPI.ProviderToken) As Boolean
		  #Pragma Unused Token
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SocketStatus() As String
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartServer(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile)
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopServer(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, StopMessage As String)
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsCheckpoints() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsGameSettings() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsRestarting() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStatus() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SupportsStopMessage() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Throttled() As Boolean
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UploadFile(Logger As Beacon.LogProducer, Profile As Beacon.ServerProfile, Transfer As Beacon.IntegrationTransfer)
		  // Part of the Beacon.HostingProvider interface.
		  
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
